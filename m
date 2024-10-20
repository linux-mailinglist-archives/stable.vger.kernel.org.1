Return-Path: <stable+bounces-86975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E147D9A5480
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 16:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53FBC282182
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 14:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F52F192B88;
	Sun, 20 Oct 2024 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="dAyw6bpQ"
X-Original-To: stable@vger.kernel.org
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F57219259F;
	Sun, 20 Oct 2024 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729434630; cv=none; b=mmNPkR0ch+hp7C7myWFGpZiZTt0x8yy+yonPkzDqfLEYSWK4qrarIzA7VOjnvpryTfdYPHtM5WXs2TwPcIumoAfCOIl5oBq4v3AHTcuKFncGlwWPVgq2/ivZ+KBLYCa5G5x8rQ8ouyX25V/NJvQbQX+PZnvpw7hwmXaIWSZKVP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729434630; c=relaxed/simple;
	bh=sjC3FAXtWg6O06Pv1zwqwzO4mh/+6hnyFfe6tqV1uzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k2a9XL//WkAqUmQRwIOxfvmGV5R8gl2f5PL0fno0/Z9p/mFG6cQOJNw3qrxOCqg6I9NyrnJQPXKu2+uA26KTNGVYpJmjZsLxewtQb8O+W+wWT2ermrJtdTHl6WZWFUTcWT7jRZTabVjS+Wf/WxOGOawCJtz1uCffDuBJRNGx5po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=dAyw6bpQ; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Content-Type:From:Reply-To:Subject:Content-ID:
	Content-Description:In-Reply-To:References:X-Debbugs-Cc;
	bh=c8OwalKN/einu7unYL2zrwmG3433Cw/yB0G2xU4t9rQ=; b=dAyw6bpQ+Wz1leHkH9cvdO39Nm
	fngPmqnv1U4CWTTIkFui4x2R+PFoROQhuVLhj659h1deKyEfSjcIv/2Wc5Y3GJeXKXWKE/X2WuSRY
	vmkvBvC6Ef9hWP3IEdXH5iMpogNeruNwuvX5DmqQEnLg1G50gKANYOaEpBXnE+SUQEeVgGIbSVdu2
	Q9bD3ubEO+YER73zUeya0qIq9jBCSRQXYu5PxcXIWkiEuP5aIBW99Vr1ywMWI5hTxtufH+gaj1taP
	0NIa9BE+GvYhy/y12MMtbXQ9eskley/iKQUldCt36i6cqR+DpF40tgarIFCQ49hFe5dz9IOCNz40D
	xYGicPbA==;
Received: from ohm.aurel32.net ([2001:bc8:30d7:111::2] helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1t2WwJ-00BfVt-0V;
	Sun, 20 Oct 2024 16:29:51 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: William Qiu <william.qiu@starfivetech.com>,
	linux-riscv@lists.infradead.org (open list:RISC-V MISC SOC SUPPORT),
	Jaehoon Chung <jh80.chung@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	linux-mmc@vger.kernel.org (open list:SYNOPSYS DESIGNWARE MMC/SD/SDIO DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Aurelien Jarno <aurelien@aurel32.net>,
	Ron Economos <re@w6rz.net>,
	Jing Luo <jing@jing.rocks>,
	stable@vger.kernel.org
Subject: [PATCH] mmc: dw_mmc: take SWIOTLB memory size limitation into account
Date: Sun, 20 Oct 2024 16:29:31 +0200
Message-ID: <20241020142931.138277-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Synopsys DesignWare mmc controller on the JH7110 SoC
(dw_mmc-starfive.c driver) is using a 32-bit IDMAC address bus width,
and thus requires the use of SWIOTLB.

The commit 8396c793ffdf ("mmc: dw_mmc: Fix IDMAC operation with pages
bigger than 4K") increased the max_seq_size, even for 4K pages, causing
"swiotlb buffer is full" to happen because swiotlb can only handle a
memory size up to 256kB only.

Fix the issue, by making sure the dw_mmc driver doesn't use segments
bigger than what SWIOTLB can handle.

Reported-by: Ron Economos <re@w6rz.net>
Reported-by: Jing Luo <jing@jing.rocks>
Fixes: 8396c793ffdf ("mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K")
Cc: stable@vger.kernel.org
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 drivers/mmc/host/dw_mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 41e451235f637..dc0d6201f7b73 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2958,7 +2958,8 @@ static int dw_mci_init_slot(struct dw_mci *host)
 		mmc->max_segs = host->ring_size;
 		mmc->max_blk_size = 65535;
 		mmc->max_req_size = DW_MCI_DESC_DATA_LENGTH * host->ring_size;
-		mmc->max_seg_size = mmc->max_req_size;
+		mmc->max_seg_size =
+		    min_t(size_t, mmc->max_req_size, dma_max_mapping_size(host->dev));
 		mmc->max_blk_count = mmc->max_req_size / 512;
 	} else if (host->use_dma == TRANS_MODE_EDMAC) {
 		mmc->max_segs = 64;
-- 
2.45.2


