Return-Path: <stable+bounces-185405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25133BD54AF
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 18:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC32423D63
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 16:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D4A3090DF;
	Mon, 13 Oct 2025 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ndxW040R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47D9284B4F;
	Mon, 13 Oct 2025 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370199; cv=none; b=TREBeHHnvc12zWTD6v2f85yUtbDI3jgK5scU9QkaBAHPJi6n5Jliw2DUOcrhDw57Dseqjs7KTFePUiasUXY+Vg3weQVqyGWhvKeLyabBngHNFo9Drabm7cQ/lzd9NBttJq3QgzoAvm4um7nKc6hTUF1BY87BfrUKXh71HvPm4gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370199; c=relaxed/simple;
	bh=Ka/3Rhaecf19LcwJRLZ5o6ZRlY9mzou/tbReuiLptFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GriGWaOV2O42J/vGgxWM76Bi6xDDhMrOzeQ8EWPRqL2pD899YSd+JxH7D7UC7gg1buIYff5I0BaFp+RBQbMuKxtYl/GFQyJzZRgDpWT4kJ7rqciu3Kb6ZVPOm1QsMxNFMvy6aHI/VRzY5KMlCiwGoNKr4TV1bJuc395xKlyBcv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ndxW040R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEDBC4CEE7;
	Mon, 13 Oct 2025 15:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760370199;
	bh=Ka/3Rhaecf19LcwJRLZ5o6ZRlY9mzou/tbReuiLptFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ndxW040R2DO1SmKFYw1QTxTG/XQhNn1X3Jo2/vrFdbkcZrSQJfio620rlKC37C2nu
	 G+P9xSyu5JcfgX7Tlw/ww1Us+pYZiekoZdt6KsHOOsaOkPHw3bLqxZnnFiZbUF9S0l
	 UJ1ycAyb7HjSNnZA0KLth66ImsKZYT65Xyo8DWWg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bo Sun <bo@mboxify.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 486/563] octeontx2-pf: fix bitmap leak
Date: Mon, 13 Oct 2025 16:45:47 +0200
Message-ID: <20251013144428.899244381@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
References: <20251013144411.274874080@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bo Sun <bo@mboxify.com>

[ Upstream commit 92e9f4faffca70c82126e59552f6e8ff8f95cc65 ]

The bitmap allocated with bitmap_zalloc() in otx2_probe() was not
released in otx2_remove(). Unbinding and rebinding the driver therefore
triggers a kmemleak warning:

    unreferenced object (size 8):
      backtrace:
        bitmap_zalloc
        otx2_probe

Call bitmap_free() in the remove path to fix the leak.

Fixes: efabce290151 ("octeontx2-pf: AF_XDP zero copy receive support")
Signed-off-by: Bo Sun <bo@mboxify.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 5027fae0aa77a..e808995703cfd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -3542,6 +3542,7 @@ static void otx2_remove(struct pci_dev *pdev)
 	otx2_disable_mbox_intr(pf);
 	otx2_pfaf_mbox_destroy(pf);
 	pci_free_irq_vectors(pf->pdev);
+	bitmap_free(pf->af_xdp_zc_qidx);
 	pci_set_drvdata(pdev, NULL);
 	free_netdev(netdev);
 }
-- 
2.51.0




