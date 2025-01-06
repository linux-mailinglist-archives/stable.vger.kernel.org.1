Return-Path: <stable+bounces-106815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9979CA02398
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 11:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88801161F6F
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 10:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43D51DC989;
	Mon,  6 Jan 2025 10:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VgwX4Mk+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834541DC980
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 10:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736161005; cv=none; b=UgBWcvbTKPigxz17FTvFEhRpvdsD2BWHBusrfJicXEjzy8dXl8w5af4RWrCV/nPaPfYnXMPbng+kVqvWJLi7cm4O9NcIQIvKnzkx3g2Vun8G6lY4SmmIV2ACuieCG6GqofSp3EYWL9xMSERCWUxGLoZ7+xSE3MtWSCSj1TrP14g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736161005; c=relaxed/simple;
	bh=d+Qkrz1gLnOmsoupzL8OS21ucUlZqy5hMrs7w5nBk+Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eMXHcbJVtWvFSWUKjKK5zDdLXjvXTaNmgkP7Y8KUDitEsqIuKEOaZBSAu5JX+BCxSvTbTnvfZUGLGg7aiWyBl+gFZi9WsjKjGTN0L6qfY4KeX2nYCBqQDQvUE9azGGKsCmRy6vzuFBjaMYDebz168NAqTl/t0zZ1hjZi7KfQhwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VgwX4Mk+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFBCC4CED2;
	Mon,  6 Jan 2025 10:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736161005;
	bh=d+Qkrz1gLnOmsoupzL8OS21ucUlZqy5hMrs7w5nBk+Y=;
	h=Subject:To:Cc:From:Date:From;
	b=VgwX4Mk+eoaEyzM34q8ByWu+bvIqjtfjQTmVJ9DezHmPdFX0wILntLcmZWk+IrKmG
	 pusXZNoauBaHFaKAMNxW09TnIJHCHMgKz2uGnWXJYjZG+NXpMXRKQP3C4CzZfb4A9R
	 +uumRQKVLybbsoRY4NuDzHDYI65Es/lkctGTJtHs=
Subject: FAILED: patch "[PATCH] gve: clean XDP queues in gve_tx_stop_ring_gqi" failed to apply to 6.6-stable tree
To: joshwash@google.com,davem@davemloft.net,pkaligineedi@google.com,willemb@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 06 Jan 2025 11:56:42 +0100
Message-ID: <2025010642-annually-shirt-b4e1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6321f5fb70d502d95de8a212a7b484c297ec9644
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025010642-annually-shirt-b4e1@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6321f5fb70d502d95de8a212a7b484c297ec9644 Mon Sep 17 00:00:00 2001
From: Joshua Washington <joshwash@google.com>
Date: Wed, 18 Dec 2024 05:34:11 -0800
Subject: [PATCH] gve: clean XDP queues in gve_tx_stop_ring_gqi

When stopping XDP TX rings, the XDP clean function needs to be called to
clean out the entire queue, similar to what happens in the normal TX
queue case. Otherwise, the FIFO won't be cleared correctly, and
xsk_tx_completed won't be reported.

Fixes: 75eaae158b1b ("gve: Add XDP DROP and TX support for GQI-QPL format")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/net/ethernet/google/gve/gve_tx.c b/drivers/net/ethernet/google/gve/gve_tx.c
index e7fb7d6d283d..83ad278ec91f 100644
--- a/drivers/net/ethernet/google/gve/gve_tx.c
+++ b/drivers/net/ethernet/google/gve/gve_tx.c
@@ -206,7 +206,10 @@ void gve_tx_stop_ring_gqi(struct gve_priv *priv, int idx)
 		return;
 
 	gve_remove_napi(priv, ntfy_idx);
-	gve_clean_tx_done(priv, tx, priv->tx_desc_cnt, false);
+	if (tx->q_num < priv->tx_cfg.num_queues)
+		gve_clean_tx_done(priv, tx, priv->tx_desc_cnt, false);
+	else
+		gve_clean_xdp_done(priv, tx, priv->tx_desc_cnt);
 	netdev_tx_reset_queue(tx->netdev_txq);
 	gve_tx_remove_from_block(priv, idx);
 }


