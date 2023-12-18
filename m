Return-Path: <stable+bounces-7204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E9B817166
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9431C23F88
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521D2129EF7;
	Mon, 18 Dec 2023 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ge9c8wci"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A567129EC8;
	Mon, 18 Dec 2023 13:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6E8C433C8;
	Mon, 18 Dec 2023 13:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907842;
	bh=KB3TEh+xP/If4h/ej6qsEpnAupc5f7B9LZloRlaydZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ge9c8wciORPnlK/dtntM5twxVkQgxtuY/CPOX6cwkoEuL7iu8Y6KRKVXYxeX6IHD6
	 zj+xBh5H/GaKPFb73sZcFrwChSz5K9Ge32RYHbG6I23Jnat18ar/QDux57tPvEhB6N
	 J0GHRAHCk9WZ5evQXKxCOz8Az7OyOE2n271W2itg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 038/106] dpaa2-switch: fix size of the dma_unmap
Date: Mon, 18 Dec 2023 14:50:52 +0100
Message-ID: <20231218135056.669961997@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135055.005497074@linuxfoundation.org>
References: <20231218135055.005497074@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ioana Ciornei <ioana.ciornei@nxp.com>

[ Upstream commit 2aad7d4189a923b24efa8ea6ad09059882b1bfe4 ]

The size of the DMA unmap was wrongly put as a sizeof of a pointer.
Change the value of the DMA unmap to be the actual macro used for the
allocation and the DMA map.

Fixes: 1110318d83e8 ("dpaa2-switch: add tc flower hardware offload on ingress traffic")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Link: https://lore.kernel.org/r/20231212164326.2753457-2-ioana.ciornei@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c
index c39b866e2582d..16d3c3610720b 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c
@@ -139,7 +139,8 @@ int dpaa2_switch_acl_entry_add(struct dpaa2_switch_filter_block *filter_block,
 	err = dpsw_acl_add_entry(ethsw->mc_io, 0, ethsw->dpsw_handle,
 				 filter_block->acl_id, acl_entry_cfg);
 
-	dma_unmap_single(dev, acl_entry_cfg->key_iova, sizeof(cmd_buff),
+	dma_unmap_single(dev, acl_entry_cfg->key_iova,
+			 DPAA2_ETHSW_PORT_ACL_CMD_BUF_SIZE,
 			 DMA_TO_DEVICE);
 	if (err) {
 		dev_err(dev, "dpsw_acl_add_entry() failed %d\n", err);
@@ -181,8 +182,8 @@ dpaa2_switch_acl_entry_remove(struct dpaa2_switch_filter_block *block,
 	err = dpsw_acl_remove_entry(ethsw->mc_io, 0, ethsw->dpsw_handle,
 				    block->acl_id, acl_entry_cfg);
 
-	dma_unmap_single(dev, acl_entry_cfg->key_iova, sizeof(cmd_buff),
-			 DMA_TO_DEVICE);
+	dma_unmap_single(dev, acl_entry_cfg->key_iova,
+			 DPAA2_ETHSW_PORT_ACL_CMD_BUF_SIZE, DMA_TO_DEVICE);
 	if (err) {
 		dev_err(dev, "dpsw_acl_remove_entry() failed %d\n", err);
 		kfree(cmd_buff);
-- 
2.43.0




