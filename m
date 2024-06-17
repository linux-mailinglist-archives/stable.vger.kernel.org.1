Return-Path: <stable+bounces-52379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D777590ADCA
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 14:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091331C2321B
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 12:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7C416C6AF;
	Mon, 17 Jun 2024 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fAz+GrB5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCCD2F32
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 12:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718626622; cv=none; b=XH/HtwKxItapK6Hjz3eUEIr9u2/OneqscuDnI/zmxBrBdY3RenLkuiTQw6LWGaXR7UWtCIHYDe/urJYpgS43xjfEr+ckeoyvH97FH9ipooqXC/Puslob31kZG+Q+1k/3cB/a3+mahgQD/8zbnQ2rbQJCwLxLAq/cSIT+Igr6+X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718626622; c=relaxed/simple;
	bh=ividLKsklRzV3hwXaWu4BxFuMTfHRDtQL1zB84sfJug=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ONJV3gd46mfBfn+Pb8C8QdNGU/2Fcp2Cfj7f+Oj634BrSPlqP6OIwcHiOlrwhJfO/wjG7vz3IBSYh28IOwt/q0auceKFQnZaBTZMhxjRQ/hUdK1exk0fPPwzRVnbwWhXbmYbZczPW3d28C+Zq3xSmU8j5t48n4b0RloBRIljAZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fAz+GrB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF62C2BD10;
	Mon, 17 Jun 2024 12:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718626622;
	bh=ividLKsklRzV3hwXaWu4BxFuMTfHRDtQL1zB84sfJug=;
	h=Subject:To:Cc:From:Date:From;
	b=fAz+GrB5/7k1n9tjlXKcfHjxE3tmxndUEhpmHnHBC47DsTMDNulNi4QRtxS0Y2h4y
	 LiiCTi/kUYiXfMOVSxl9qSN0HIBi3n+kOIPorw+DkMA7PxaTdeIheZdPaJgcY4c0lg
	 86+O0bQZ1NEEdruP2/6QYDR/JCxiJ6zK12WZk0EQ=
Subject: FAILED: patch "[PATCH] gve: Clear napi->skb before dev_kfree_skb_any()" failed to apply to 5.15-stable tree
To: ziweixiao@google.com,hramamurthy@google.com,kuba@kernel.org,pkaligineedi@google.com,shailend@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Jun 2024 14:16:59 +0200
Message-ID: <2024061759-decoy-condiment-7d57@gregkh>
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
git cherry-pick -x 6f4d93b78ade0a4c2cafd587f7b429ce95abb02e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061759-decoy-condiment-7d57@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

6f4d93b78ade ("gve: Clear napi->skb before dev_kfree_skb_any()")
1344e751e910 ("gve: Add RX context.")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6f4d93b78ade0a4c2cafd587f7b429ce95abb02e Mon Sep 17 00:00:00 2001
From: Ziwei Xiao <ziweixiao@google.com>
Date: Wed, 12 Jun 2024 00:16:54 +0000
Subject: [PATCH] gve: Clear napi->skb before dev_kfree_skb_any()

gve_rx_free_skb incorrectly leaves napi->skb referencing an skb after it
is freed with dev_kfree_skb_any(). This can result in a subsequent call
to napi_get_frags returning a dangling pointer.

Fix this by clearing napi->skb before the skb is freed.

Fixes: 9b8dd5e5ea48 ("gve: DQO: Add RX path")
Cc: stable@vger.kernel.org
Reported-by: Shailend Chand <shailend@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Shailend Chand <shailend@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Link: https://lore.kernel.org/r/20240612001654.923887-1-ziweixiao@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index c1c912de59c7..1154c1d8f66f 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -647,11 +647,13 @@ static void gve_rx_skb_hash(struct sk_buff *skb,
 	skb_set_hash(skb, le32_to_cpu(compl_desc->hash), hash_type);
 }
 
-static void gve_rx_free_skb(struct gve_rx_ring *rx)
+static void gve_rx_free_skb(struct napi_struct *napi, struct gve_rx_ring *rx)
 {
 	if (!rx->ctx.skb_head)
 		return;
 
+	if (rx->ctx.skb_head == napi->skb)
+		napi->skb = NULL;
 	dev_kfree_skb_any(rx->ctx.skb_head);
 	rx->ctx.skb_head = NULL;
 	rx->ctx.skb_tail = NULL;
@@ -950,7 +952,7 @@ int gve_rx_poll_dqo(struct gve_notify_block *block, int budget)
 
 		err = gve_rx_dqo(napi, rx, compl_desc, complq->head, rx->q_num);
 		if (err < 0) {
-			gve_rx_free_skb(rx);
+			gve_rx_free_skb(napi, rx);
 			u64_stats_update_begin(&rx->statss);
 			if (err == -ENOMEM)
 				rx->rx_skb_alloc_fail++;
@@ -993,7 +995,7 @@ int gve_rx_poll_dqo(struct gve_notify_block *block, int budget)
 
 		/* gve_rx_complete_skb() will consume skb if successful */
 		if (gve_rx_complete_skb(rx, napi, compl_desc, feat) != 0) {
-			gve_rx_free_skb(rx);
+			gve_rx_free_skb(napi, rx);
 			u64_stats_update_begin(&rx->statss);
 			rx->rx_desc_err_dropped_pkt++;
 			u64_stats_update_end(&rx->statss);


