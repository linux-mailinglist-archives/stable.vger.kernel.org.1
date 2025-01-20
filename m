Return-Path: <stable+bounces-109521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2C0A16D84
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 14:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647EC3A170C
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 13:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D78D1E1A1F;
	Mon, 20 Jan 2025 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CE3sWwxN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0881FC8
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737380321; cv=none; b=f8/d7Md8q+wNk0MXYq00+GqVW4zlR3hhet1ee2U3OjXZNlwRMqYItVl2+fUW5uOcPfLuMvJLTC2sKpMt8vz9QJ09uAm8G25Tjui4L7IOMHh7TPeA/vKudRkMJ388pbY5LQ0PvBJJQgA9gU/w+8Ut37jY1NUvgf+5dgrOPNgrFGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737380321; c=relaxed/simple;
	bh=YPF/vT48T5qXB2KdoYhW8W1C7UD2wKomS6nRwQthM00=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ppPmGusR+WTJezDYBMQ1CrVjdrhzIfXtQa2nS7mtw0/LjfrbXUlM/u8QDdyqp+BtsOT3b4O9kPUq7RlyA0p+2Ov9FvR32FPZ1hofiuEm4M3vF563zb1QkWIaTQ+dAxs47bfzaVBr6w1k2t23Rq3RA0MsDWjfb0ttmbioM/zaUAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CE3sWwxN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E48C4CEDD;
	Mon, 20 Jan 2025 13:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737380320;
	bh=YPF/vT48T5qXB2KdoYhW8W1C7UD2wKomS6nRwQthM00=;
	h=Subject:To:Cc:From:Date:From;
	b=CE3sWwxNJZBA7bHw8gVE+e620UGtdljIt1HZWh60WzZ/C8bbQAQ5rt3ECrBwbvqQn
	 +wStsCLlfbBxsNKqZtHHkrSqf07MHhYLNQcJ9L6dg9FimXKWP+kO0u3TlNruoGVZH8
	 mQg1APMGdfMeoXzfzt/JT8k9J5FvdCTraKoToQo0=
Subject: FAILED: patch "[PATCH] mptcp: be sure to send ack when mptcp-level window re-opens" failed to apply to 5.15-stable tree
To: pabeni@redhat.com,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jan 2025 14:38:37 +0100
Message-ID: <2025012037-siesta-sulfite-8b05@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 2ca06a2f65310aeef30bb69b7405437a14766e4d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025012037-siesta-sulfite-8b05@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2ca06a2f65310aeef30bb69b7405437a14766e4d Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Mon, 13 Jan 2025 16:44:56 +0100
Subject: [PATCH] mptcp: be sure to send ack when mptcp-level window re-opens

mptcp_cleanup_rbuf() is responsible to send acks when the user-space
reads enough data to update the receive windows significantly.

It tries hard to avoid acquiring the subflow sockets locks by checking
conditions similar to the ones implemented at the TCP level.

To avoid too much code duplication - the MPTCP protocol can't reuse the
TCP helpers as part of the relevant status is maintained into the msk
socket - and multiple costly window size computation, mptcp_cleanup_rbuf
uses a rough estimate for the most recently advertised window size:
the MPTCP receive free space, as recorded as at last-ack time.

Unfortunately the above does not allow mptcp_cleanup_rbuf() to detect
a zero to non-zero win change in some corner cases, skipping the
tcp_cleanup_rbuf call and leaving the peer stuck.

After commit ea66758c1795 ("tcp: allow MPTCP to update the announced
window"), MPTCP has actually cheap access to the announced window value.
Use it in mptcp_cleanup_rbuf() for a more accurate ack generation.

Fixes: e3859603ba13 ("mptcp: better msk receive window updates")
Cc: stable@vger.kernel.org
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/20250107131845.5e5de3c5@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250113-net-mptcp-connect-st-flakes-v1-1-0d986ee7b1b6@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index a62bc874bf1e..123f3f297284 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -607,7 +607,6 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 	}
 	opts->ext_copy.use_ack = 1;
 	opts->suboptions = OPTION_MPTCP_DSS;
-	WRITE_ONCE(msk->old_wspace, __mptcp_space((struct sock *)msk));
 
 	/* Add kind/length/subtype/flag overhead if mapping is not populated */
 	if (dss_size == 0)
@@ -1288,7 +1287,7 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 			}
 			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_RCVWNDCONFLICT);
 		}
-		return;
+		goto update_wspace;
 	}
 
 	if (rcv_wnd_new != rcv_wnd_old) {
@@ -1313,6 +1312,9 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 		th->window = htons(new_win);
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_RCVWNDSHARED);
 	}
+
+update_wspace:
+	WRITE_ONCE(msk->old_wspace, tp->rcv_wnd);
 }
 
 __sum16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)


