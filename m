Return-Path: <stable+bounces-65566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0484194A9B3
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 16:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27DB91C2136C
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 14:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747D279B9D;
	Wed,  7 Aug 2024 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EO86/Sup"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3424D61674
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040082; cv=none; b=XHTe5ZfB5XSM687IGeQBAxDuM4zqiiD3soehVwBJ9iSSlIutoP8Z//Wm3xAUccN7Tqm8WBDgWX3AXjRxrBnne7x2A+H/warHj/BmCbtRAJkQsFHfCwJbg4noV6E0ntr6iQAtrtsFk86I0rY2uouBQ4Jn+GouzN8g/MpAjAIMfdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040082; c=relaxed/simple;
	bh=ve3H0tlDgJC+vtuMps2zu53r8mD2rSRrUlIhv8gwago=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=anir/wUY0qEJMTvuPWQXS7nsxeVqPEfzwTCouZ/mv/EFScBZRkDPpthYe9sVr22cZAb0jlpQr1AeGhWFYzAldCZe68ttLsyiZ1Pld8TxUaXsJ6mx12KvjtpGWYMMRdm7WomEa/wMI1it38Z6in5i2xbB204grUyty8OGAaXaMzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EO86/Sup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B65C32781;
	Wed,  7 Aug 2024 14:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723040082;
	bh=ve3H0tlDgJC+vtuMps2zu53r8mD2rSRrUlIhv8gwago=;
	h=Subject:To:Cc:From:Date:From;
	b=EO86/SupvNlLlfziQTjBoiFnl2HfN+aNJg0Rj1nYqbMFz4EAdASXilR1ngIT0e1Wm
	 Mq/0Fg3Tjh3rFKoOG68JnNAaxQHDT6T8BTwkYkzdRr3OpqZ/9fcXWwRYnacql2gNKh
	 n2HWBMI2nLWezcIGBkNmNfmzxPhuZzhaIdtQNVU8=
Subject: FAILED: patch "[PATCH] mptcp: fix bad RCVPRUNED mib accounting" failed to apply to 5.15-stable tree
To: pabeni@redhat.com,martineau@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 07 Aug 2024 16:14:38 +0200
Message-ID: <2024080738-providing-expiring-91d1@gregkh>
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
git cherry-pick -x 0a567c2a10033bf04ed618368d179bce6977984b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024080738-providing-expiring-91d1@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

0a567c2a1003 ("mptcp: fix bad RCVPRUNED mib accounting")
6511882cdd82 ("mptcp: allocate fwd memory separately on the rx and tx path")
765ff425528f ("mptcp: use lockdep_assert_held_once() instead of open-coding it")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0a567c2a10033bf04ed618368d179bce6977984b Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Wed, 31 Jul 2024 12:10:14 +0200
Subject: [PATCH] mptcp: fix bad RCVPRUNED mib accounting

Since its introduction, the mentioned MIB accounted for the wrong
event: wake-up being skipped as not-needed on some edge condition
instead of incoming skb being dropped after landing in the (subflow)
receive queue.

Move the increment in the correct location.

Fixes: ce599c516386 ("mptcp: properly account bulk freed memory")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a2fc54ed68c0..0d536b183a6c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -350,8 +350,10 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 	skb_orphan(skb);
 
 	/* try to fetch required memory from subflow */
-	if (!mptcp_rmem_schedule(sk, ssk, skb->truesize))
+	if (!mptcp_rmem_schedule(sk, ssk, skb->truesize)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
 		goto drop;
+	}
 
 	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 
@@ -844,10 +846,8 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 		sk_rbuf = ssk_rbuf;
 
 	/* over limit? can't append more skbs to msk, Also, no need to wake-up*/
-	if (__mptcp_rmem(sk) > sk_rbuf) {
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
+	if (__mptcp_rmem(sk) > sk_rbuf)
 		return;
-	}
 
 	/* Wake-up the reader only for in-sequence data */
 	mptcp_data_lock(sk);


