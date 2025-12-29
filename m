Return-Path: <stable+bounces-203556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61818CE6D24
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92156301F249
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 13:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EF71E9915;
	Mon, 29 Dec 2025 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gBDJkYjt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BA31DE8BF
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767013443; cv=none; b=Ax8myNRvbrRQIcCPAezcIQ8vWMqXzWoqzJEEMXPN1IcjtQ7bqR5t4/RjeOWtDsHpU0c5vJ/zVguesK93e594jXagS69BE3qPH+1cbCOnBPxWbXvIOVNBPPo5MlgWkCcCJAwnxI3ruMF+kfjEn23BN438FAAahrPsjv/+M+fD6rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767013443; c=relaxed/simple;
	bh=hvV9pWiWIxfroy0dR5AN1jvTbPO8VareSaOdV7zfNhI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=docV7tqA49JCFmuReSAjgyV19+Oyz8setivm+W8CyktdpEy2C01ylg+yp9JF+yAguhaXPzTlMzeyHsp0bzHgEM/S1gmIAev+KfFbsmsqDtSmjbg/4y/MzQUgZ4fIo++Iddlv6+0PIT2WAIX3Kv55IgeE58s0WnXNECid+J+w9Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gBDJkYjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41BBC4CEF7;
	Mon, 29 Dec 2025 13:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767013443;
	bh=hvV9pWiWIxfroy0dR5AN1jvTbPO8VareSaOdV7zfNhI=;
	h=Subject:To:Cc:From:Date:From;
	b=gBDJkYjto65W6+/hQ7puwn21lJyEH3VRAiXbcXCxXSq0EP6pJNTqU7siGAc46XBKt
	 Bx/WAdgrFukpPZ8pgyQI8WxBfc/gBMjatbV4XMd2TSxHQEA5vIaMmYeAzknBxMcXhB
	 +IQQLHi5gUm2oGwAEICpQ4x/Wae9gP2FOVayfICw=
Subject: FAILED: patch "[PATCH] mptcp: schedule rtx timer only after pushing data" failed to apply to 5.15-stable tree
To: pabeni@redhat.com,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 14:03:52 +0100
Message-ID: <2025122952-supervise-regulate-a26b@gregkh>
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
git cherry-pick -x 2ea6190f42d0416a4310e60a7fcb0b49fcbbd4fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122952-supervise-regulate-a26b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2ea6190f42d0416a4310e60a7fcb0b49fcbbd4fb Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Fri, 5 Dec 2025 19:55:16 +0100
Subject: [PATCH] mptcp: schedule rtx timer only after pushing data

The MPTCP protocol usually schedule the retransmission timer only
when there is some chances for such retransmissions to happen.

With a notable exception: __mptcp_push_pending() currently schedule
such timer unconditionally, potentially leading to unnecessary rtx
timer expiration.

The issue is present since the blamed commit below but become easily
reproducible after commit 27b0e701d387 ("mptcp: drop bogus optimization
in __mptcp_check_push()")

Fixes: 33d41c9cd74c ("mptcp: more accurate timeout")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251205-net-mptcp-misc-fixes-6-19-rc1-v1-3-9e4781a6c1b8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e212c1374bd0..d8a7f7029164 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1623,7 +1623,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	struct mptcp_sendmsg_info info = {
 				.flags = flags,
 	};
-	bool do_check_data_fin = false;
+	bool copied = false;
 	int push_count = 1;
 
 	while (mptcp_send_head(sk) && (push_count > 0)) {
@@ -1665,7 +1665,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 						push_count--;
 					continue;
 				}
-				do_check_data_fin = true;
+				copied = true;
 			}
 		}
 	}
@@ -1674,11 +1674,14 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	if (ssk)
 		mptcp_push_release(ssk, &info);
 
-	/* ensure the rtx timer is running */
-	if (!mptcp_rtx_timer_pending(sk))
-		mptcp_reset_rtx_timer(sk);
-	if (do_check_data_fin)
+	/* Avoid scheduling the rtx timer if no data has been pushed; the timer
+	 * will be updated on positive acks by __mptcp_cleanup_una().
+	 */
+	if (copied) {
+		if (!mptcp_rtx_timer_pending(sk))
+			mptcp_reset_rtx_timer(sk);
 		mptcp_check_send_data_fin(sk);
+	}
 }
 
 static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)


