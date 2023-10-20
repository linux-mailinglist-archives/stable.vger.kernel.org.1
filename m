Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2511B7D16EB
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 22:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjJTUZX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 16:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJTUZX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 16:25:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBFA1A4
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 13:25:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBA0C433C8;
        Fri, 20 Oct 2023 20:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697833520;
        bh=1sTFG4rlmBhZQ7V0J9YCnLLtBk+OpnGqQFWlsFt/VyQ=;
        h=Subject:To:Cc:From:Date:From;
        b=iU1IHUpSdB5aEjUfIyVDcKjxxHjKGuWoaO4tUQo+Djdd5zCvbw4YK8922+/TMY/te
         HVh1Uq9tWII4gt9TbQv+PX8clUc8XSQbvckzfnjVZ4v4Rm5dtYc3vqubnlI6gaszY4
         xPGAEUQjMvFOwQuSmUeoeidVBHQKbK05ZhEeYS6Y=
Subject: FAILED: patch "[PATCH] tcp: fix excessive TLP and RACK timeouts from HZ rounding" failed to apply to 4.14-stable tree
To:     ncardwell@google.com, edumazet@google.com, kuba@kernel.org,
        ycheng@google.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 20 Oct 2023 22:25:17 +0200
Message-ID: <2023102017-pedometer-skier-c67d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 1c2709cfff1dedbb9591e989e2f001484208d914
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102017-pedometer-skier-c67d@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1c2709cfff1dedbb9591e989e2f001484208d914 Mon Sep 17 00:00:00 2001
From: Neal Cardwell <ncardwell@google.com>
Date: Sun, 15 Oct 2023 13:47:00 -0400
Subject: [PATCH] tcp: fix excessive TLP and RACK timeouts from HZ rounding

We discovered from packet traces of slow loss recovery on kernels with
the default HZ=250 setting (and min_rtt < 1ms) that after reordering,
when receiving a SACKed sequence range, the RACK reordering timer was
firing after about 16ms rather than the desired value of roughly
min_rtt/4 + 2ms. The problem is largely due to the RACK reorder timer
calculation adding in TCP_TIMEOUT_MIN, which is 2 jiffies. On kernels
with HZ=250, this is 2*4ms = 8ms. The TLP timer calculation has the
exact same issue.

This commit fixes the TLP transmit timer and RACK reordering timer
floor calculation to more closely match the intended 2ms floor even on
kernels with HZ=250. It does this by adding in a new
TCP_TIMEOUT_MIN_US floor of 2000 us and then converting to jiffies,
instead of the current approach of converting to jiffies and then
adding th TCP_TIMEOUT_MIN value of 2 jiffies.

Our testing has verified that on kernels with HZ=1000, as expected,
this does not produce significant changes in behavior, but on kernels
with the default HZ=250 the latency improvement can be large. For
example, our tests show that for HZ=250 kernels at low RTTs this fix
roughly halves the latency for the RACK reorder timer: instead of
mostly firing at 16ms it mostly fires at 8ms.

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Fixes: bb4d991a28cc ("tcp: adjust tail loss probe timeout")
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20231015174700.2206872-1-ncardwell.sw@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 7b1a720691ae..4b03ca7cb8a5 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -141,6 +141,9 @@ void tcp_time_wait(struct sock *sk, int state, int timeo);
 #define TCP_RTO_MAX	((unsigned)(120*HZ))
 #define TCP_RTO_MIN	((unsigned)(HZ/5))
 #define TCP_TIMEOUT_MIN	(2U) /* Min timeout for TCP timers in jiffies */
+
+#define TCP_TIMEOUT_MIN_US (2*USEC_PER_MSEC) /* Min TCP timeout in microsecs */
+
 #define TCP_TIMEOUT_INIT ((unsigned)(1*HZ))	/* RFC6298 2.1 initial RTO value	*/
 #define TCP_TIMEOUT_FALLBACK ((unsigned)(3*HZ))	/* RFC 1122 initial RTO value, now
 						 * used as a fallback RTO for the
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 9c8c42c280b7..bbd85672fda7 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2788,7 +2788,7 @@ bool tcp_schedule_loss_probe(struct sock *sk, bool advancing_rto)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
-	u32 timeout, rto_delta_us;
+	u32 timeout, timeout_us, rto_delta_us;
 	int early_retrans;
 
 	/* Don't do any loss probe on a Fast Open connection before 3WHS
@@ -2812,11 +2812,12 @@ bool tcp_schedule_loss_probe(struct sock *sk, bool advancing_rto)
 	 * sample is available then probe after TCP_TIMEOUT_INIT.
 	 */
 	if (tp->srtt_us) {
-		timeout = usecs_to_jiffies(tp->srtt_us >> 2);
+		timeout_us = tp->srtt_us >> 2;
 		if (tp->packets_out == 1)
-			timeout += TCP_RTO_MIN;
+			timeout_us += tcp_rto_min_us(sk);
 		else
-			timeout += TCP_TIMEOUT_MIN;
+			timeout_us += TCP_TIMEOUT_MIN_US;
+		timeout = usecs_to_jiffies(timeout_us);
 	} else {
 		timeout = TCP_TIMEOUT_INIT;
 	}
diff --git a/net/ipv4/tcp_recovery.c b/net/ipv4/tcp_recovery.c
index acf4869c5d3b..bba10110fbbc 100644
--- a/net/ipv4/tcp_recovery.c
+++ b/net/ipv4/tcp_recovery.c
@@ -104,7 +104,7 @@ bool tcp_rack_mark_lost(struct sock *sk)
 	tp->rack.advanced = 0;
 	tcp_rack_detect_loss(sk, &timeout);
 	if (timeout) {
-		timeout = usecs_to_jiffies(timeout) + TCP_TIMEOUT_MIN;
+		timeout = usecs_to_jiffies(timeout + TCP_TIMEOUT_MIN_US);
 		inet_csk_reset_xmit_timer(sk, ICSK_TIME_REO_TIMEOUT,
 					  timeout, inet_csk(sk)->icsk_rto);
 	}

