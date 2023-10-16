Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146F77CA32F
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 11:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjJPJCR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 05:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjJPJB7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 05:01:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BB2F0
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 02:01:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894D0C433C7;
        Mon, 16 Oct 2023 09:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446909;
        bh=OgrzTWM0ZMoIuX6AkLrR/gfrPF2mRx+8tQZuKpgAqMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QiK1/PgGz0kKa15HlAIDkhKsKMMbgvHjnXZBVkgXJSzAaOJH3NGd1JN7sH02LuVX3
         1UK1BC2m2RMRwNyDjKsT63R3SgA7SLZRWeigrMsMb85Elrp99NVE4YUE/cVtqtm10q
         XOFe1Z0MuOKeZOeWXaeogcMJ08N9EM/Rljw+FtBI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mike Freemon <mfreemon@cloudflare.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 067/131] tcp: enforce receive buffer memory limits by allowing the tcp window to shrink
Date:   Mon, 16 Oct 2023 10:40:50 +0200
Message-ID: <20231016084001.732118317@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: mfreemon@cloudflare.com <mfreemon@cloudflare.com>

[ Upstream commit b650d953cd391595e536153ce30b4aab385643ac ]

Under certain circumstances, the tcp receive buffer memory limit
set by autotuning (sk_rcvbuf) is increased due to incoming data
packets as a result of the window not closing when it should be.
This can result in the receive buffer growing all the way up to
tcp_rmem[2], even for tcp sessions with a low BDP.

To reproduce:  Connect a TCP session with the receiver doing
nothing and the sender sending small packets (an infinite loop
of socket send() with 4 bytes of payload with a sleep of 1 ms
in between each send()).  This will cause the tcp receive buffer
to grow all the way up to tcp_rmem[2].

As a result, a host can have individual tcp sessions with receive
buffers of size tcp_rmem[2], and the host itself can reach tcp_mem
limits, causing the host to go into tcp memory pressure mode.

The fundamental issue is the relationship between the granularity
of the window scaling factor and the number of byte ACKed back
to the sender.  This problem has previously been identified in
RFC 7323, appendix F [1].

The Linux kernel currently adheres to never shrinking the window.

In addition to the overallocation of memory mentioned above, the
current behavior is functionally incorrect, because once tcp_rmem[2]
is reached when no remediations remain (i.e. tcp collapse fails to
free up any more memory and there are no packets to prune from the
out-of-order queue), the receiver will drop in-window packets
resulting in retransmissions and an eventual timeout of the tcp
session.  A receive buffer full condition should instead result
in a zero window and an indefinite wait.

In practice, this problem is largely hidden for most flows.  It
is not applicable to mice flows.  Elephant flows can send data
fast enough to "overrun" the sk_rcvbuf limit (in a single ACK),
triggering a zero window.

But this problem does show up for other types of flows.  Examples
are websockets and other type of flows that send small amounts of
data spaced apart slightly in time.  In these cases, we directly
encounter the problem described in [1].

RFC 7323, section 2.4 [2], says there are instances when a retracted
window can be offered, and that TCP implementations MUST ensure
that they handle a shrinking window, as specified in RFC 1122,
section 4.2.2.16 [3].  All prior RFCs on the topic of tcp window
management have made clear that sender must accept a shrunk window
from the receiver, including RFC 793 [4] and RFC 1323 [5].

This patch implements the functionality to shrink the tcp window
when necessary to keep the right edge within the memory limit by
autotuning (sk_rcvbuf).  This new functionality is enabled with
the new sysctl: net.ipv4.tcp_shrink_window

Additional information can be found at:
https://blog.cloudflare.com/unbounded-memory-usage-by-tcp-for-receive-buffers-and-how-we-fixed-it/

[1] https://www.rfc-editor.org/rfc/rfc7323#appendix-F
[2] https://www.rfc-editor.org/rfc/rfc7323#section-2.4
[3] https://www.rfc-editor.org/rfc/rfc1122#page-91
[4] https://www.rfc-editor.org/rfc/rfc793
[5] https://www.rfc-editor.org/rfc/rfc1323

Signed-off-by: Mike Freemon <mfreemon@cloudflare.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/networking/ip-sysctl.rst | 15 +++++++
 include/net/netns/ipv4.h               |  1 +
 net/ipv4/sysctl_net_ipv4.c             |  9 ++++
 net/ipv4/tcp_ipv4.c                    |  2 +
 net/ipv4/tcp_output.c                  | 60 ++++++++++++++++++++++----
 5 files changed, 78 insertions(+), 9 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index f5f7a464605f9..b47b3d0ce5596 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -967,6 +967,21 @@ tcp_tw_reuse - INTEGER
 tcp_window_scaling - BOOLEAN
 	Enable window scaling as defined in RFC1323.
 
+tcp_shrink_window - BOOLEAN
+	This changes how the TCP receive window is calculated.
+
+	RFC 7323, section 2.4, says there are instances when a retracted
+	window can be offered, and that TCP implementations MUST ensure
+	that they handle a shrinking window, as specified in RFC 1122.
+
+	- 0 - Disabled.	The window is never shrunk.
+	- 1 - Enabled.	The window is shrunk when necessary to remain within
+			the memory limit set by autotuning (sk_rcvbuf).
+			This only occurs if a non-zero receive window
+			scaling factor is also in effect.
+
+	Default: 0
+
 tcp_wmem - vector of 3 INTEGERs: min, default, max
 	min: Amount of memory reserved for send buffers for TCP sockets.
 	Each TCP socket has rights to use it due to fact of its birth.
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 1b80046794451..ede2ff1da53a3 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -64,6 +64,7 @@ struct netns_ipv4 {
 #endif
 	bool			fib_has_custom_local_routes;
 	bool			fib_offload_disabled;
+	u8			sysctl_tcp_shrink_window;
 #ifdef CONFIG_IP_ROUTE_CLASSID
 	atomic_t		fib_num_tclassid_users;
 #endif
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index f68762ce4d8a3..73e5821584c18 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -1387,6 +1387,15 @@ static struct ctl_table ipv4_net_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
 	},
+	{
+		.procname	= "tcp_shrink_window",
+		.data		= &init_net.ipv4.sysctl_tcp_shrink_window,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 	{ }
 };
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index f9b8a4a1d2edc..5df19f93f86ab 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3221,6 +3221,8 @@ static int __net_init tcp_sk_init(struct net *net)
 	else
 		net->ipv4.tcp_congestion_control = &tcp_reno;
 
+	net->ipv4.sysctl_tcp_shrink_window = 0;
+
 	return 0;
 }
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 5921b0f6f9f41..443b1cab25299 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -259,8 +259,8 @@ static u16 tcp_select_window(struct sock *sk)
 	u32 old_win = tp->rcv_wnd;
 	u32 cur_win = tcp_receive_window(tp);
 	u32 new_win = __tcp_select_window(sk);
+	struct net *net = sock_net(sk);
 
-	/* Never shrink the offered window */
 	if (new_win < cur_win) {
 		/* Danger Will Robinson!
 		 * Don't update rcv_wup/rcv_wnd here or else
@@ -269,11 +269,14 @@ static u16 tcp_select_window(struct sock *sk)
 		 *
 		 * Relax Will Robinson.
 		 */
-		if (new_win == 0)
-			NET_INC_STATS(sock_net(sk),
-				      LINUX_MIB_TCPWANTZEROWINDOWADV);
-		new_win = ALIGN(cur_win, 1 << tp->rx_opt.rcv_wscale);
+		if (!READ_ONCE(net->ipv4.sysctl_tcp_shrink_window) || !tp->rx_opt.rcv_wscale) {
+			/* Never shrink the offered window */
+			if (new_win == 0)
+				NET_INC_STATS(net, LINUX_MIB_TCPWANTZEROWINDOWADV);
+			new_win = ALIGN(cur_win, 1 << tp->rx_opt.rcv_wscale);
+		}
 	}
+
 	tp->rcv_wnd = new_win;
 	tp->rcv_wup = tp->rcv_nxt;
 
@@ -281,7 +284,7 @@ static u16 tcp_select_window(struct sock *sk)
 	 * scaled window.
 	 */
 	if (!tp->rx_opt.rcv_wscale &&
-	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_workaround_signed_windows))
+	    READ_ONCE(net->ipv4.sysctl_tcp_workaround_signed_windows))
 		new_win = min(new_win, MAX_TCP_WINDOW);
 	else
 		new_win = min(new_win, (65535U << tp->rx_opt.rcv_wscale));
@@ -293,10 +296,9 @@ static u16 tcp_select_window(struct sock *sk)
 	if (new_win == 0) {
 		tp->pred_flags = 0;
 		if (old_win)
-			NET_INC_STATS(sock_net(sk),
-				      LINUX_MIB_TCPTOZEROWINDOWADV);
+			NET_INC_STATS(net, LINUX_MIB_TCPTOZEROWINDOWADV);
 	} else if (old_win == 0) {
-		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPFROMZEROWINDOWADV);
+		NET_INC_STATS(net, LINUX_MIB_TCPFROMZEROWINDOWADV);
 	}
 
 	return new_win;
@@ -2949,6 +2951,7 @@ u32 __tcp_select_window(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
+	struct net *net = sock_net(sk);
 	/* MSS for the peer's data.  Previous versions used mss_clamp
 	 * here.  I don't know if the value based on our guesses
 	 * of peer's MSS is better for the performance.  It's more correct
@@ -2970,6 +2973,15 @@ u32 __tcp_select_window(struct sock *sk)
 		if (mss <= 0)
 			return 0;
 	}
+
+	/* Only allow window shrink if the sysctl is enabled and we have
+	 * a non-zero scaling factor in effect.
+	 */
+	if (READ_ONCE(net->ipv4.sysctl_tcp_shrink_window) && tp->rx_opt.rcv_wscale)
+		goto shrink_window_allowed;
+
+	/* do not allow window to shrink */
+
 	if (free_space < (full_space >> 1)) {
 		icsk->icsk_ack.quick = 0;
 
@@ -3024,6 +3036,36 @@ u32 __tcp_select_window(struct sock *sk)
 	}
 
 	return window;
+
+shrink_window_allowed:
+	/* new window should always be an exact multiple of scaling factor */
+	free_space = round_down(free_space, 1 << tp->rx_opt.rcv_wscale);
+
+	if (free_space < (full_space >> 1)) {
+		icsk->icsk_ack.quick = 0;
+
+		if (tcp_under_memory_pressure(sk))
+			tcp_adjust_rcv_ssthresh(sk);
+
+		/* if free space is too low, return a zero window */
+		if (free_space < (allowed_space >> 4) || free_space < mss ||
+			free_space < (1 << tp->rx_opt.rcv_wscale))
+			return 0;
+	}
+
+	if (free_space > tp->rcv_ssthresh) {
+		free_space = tp->rcv_ssthresh;
+		/* new window should always be an exact multiple of scaling factor
+		 *
+		 * For this case, we ALIGN "up" (increase free_space) because
+		 * we know free_space is not zero here, it has been reduced from
+		 * the memory-based limit, and rcv_ssthresh is not a hard limit
+		 * (unlike sk_rcvbuf).
+		 */
+		free_space = ALIGN(free_space, (1 << tp->rx_opt.rcv_wscale));
+	}
+
+	return free_space;
 }
 
 void tcp_skb_collapse_tstamp(struct sk_buff *skb,
-- 
2.40.1



