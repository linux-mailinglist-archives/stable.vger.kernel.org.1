Return-Path: <stable+bounces-92043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA0B9C31E6
	for <lists+stable@lfdr.de>; Sun, 10 Nov 2024 13:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50EAAB20EFF
	for <lists+stable@lfdr.de>; Sun, 10 Nov 2024 12:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD9415443F;
	Sun, 10 Nov 2024 12:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="da4XQwh/"
X-Original-To: stable@vger.kernel.org
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CBD1494DC;
	Sun, 10 Nov 2024 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731240944; cv=none; b=LZi5UI7JmTMNzOkHPkqSAHw0sX84A0btpoCxy6i1wP1bMybH9fmQaEWGmkteClKVk+1yJ+DbkahmLuichalifaDGjo9tTLfk02gvJQktTmCPU1g1pKTowCvCYJiSMsyWcEISvyqayWqrIzqllbNoUETKKfyNdbiEtVatFXQlfbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731240944; c=relaxed/simple;
	bh=v0HN/FED+TT7/gvTHHTC20H9BDfo2Jlpr2rIPHK6WFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NAWuKcLcvQ1mGpuNIP2ZMdt+Ptm1elLQ1qZqn/hT3E6eScGbqN/bWKPWC7BLgf3VUljNI++QYxWsOiYN8sP3HKBjnNb2A6ClYJwVsn5MBpKfJlBPLpmUjHVAQ7NypzAby4U7XPe7HWXK5f9TdNOJcnw973vE8TCl+kVp2tfufwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=da4XQwh/; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Content-Type:From:Reply-To:Subject:Content-ID:
	Content-Description:In-Reply-To:References:X-Debbugs-Cc;
	bh=qvK83CYVvOTn6ti8fkhXE4YiU4NnTKoBN9s7aChfpTU=; b=da4XQwh/NWeANyMxlEa8KPZF7h
	vqRo/ljnFVJSr4rIBLZs+ZVnU7N5tYN7DGxtAFvaNWdO2vMmdkZf4lMKqEHZoTNfmX0HqHJ97Ot5d
	B3xlCsBuBnrEWUqVIiONDO7FgWrR9SKHtkkyF1mkRYbMEv9lj1/s5HDl77pIK9+MGTjePpKL5iRu0
	LVet9FiK1V8+WxmHXLErbC7wKqmmTSAnD//oX3afbU0QHIDsuVVxsLDbGmWG1V1HTKOEYpGDQTRaa
	Iab8mA5P8P6HpEsqScbOttA3k7vfbR0td0b+wnJw4E4/9QTyZo0MwzP7fJPDQKTeo+0h+QHAPpydZ
	+9fkQCKw==;
Received: from ohm.aurel32.net ([2001:bc8:30d7:111::2] helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1tA6Pm-005bzm-05;
	Sun, 10 Nov 2024 12:47:34 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: linux-kernel@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	linux-mmc@vger.kernel.org (open list:SYNOPSYS DESIGNWARE MMC/SD/SDIO DRIVER)
Cc: Ron Economos <re@w6rz.net>,
	Adam Green <greena88@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	stable@vger.kernel.org
Subject: [PATCH] Revert "mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K"
Date: Sun, 10 Nov 2024 12:46:36 +0100
Message-ID: <20241110114700.622372-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 8396c793ffdf ("mmc: dw_mmc: Fix IDMAC operation with pages
bigger than 4K") increased the max_req_size, even for 4K pages, causing
various issues:
- Panic booting the kernel/rootfs from an SD card on Rockchip RK3566
- Panic booting the kernel/rootfs from an SD card on StarFive JH7100
- "swiotlb buffer is full" and data corruption on StarFive JH7110

At this stage no fix have been found, so it's probably better to just
revert the change.

This reverts commit 8396c793ffdf28bb8aee7cfe0891080f8cab7890.

Cc: stable@vger.kernel.org
Cc: Sam Protsenko <semen.protsenko@linaro.org>
Fixes: 8396c793ffdf ("mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K")
Closes: https://lore.kernel.org/linux-mmc/614692b4-1dbe-31b8-a34d-cb6db1909bb7@w6rz.net/
Closes: https://lore.kernel.org/linux-mmc/CAC8uq=Ppnmv98mpa1CrWLawWoPnu5abtU69v-=G-P7ysATQ2Pw@mail.gmail.com/
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 drivers/mmc/host/dw_mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

I have posted a patch to fix the issue, but unfortunately it only fixes
the JH7110 case:
https://lore.kernel.org/linux-mmc/20241020142931.138277-1-aurelien@aurel32.net/

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 41e451235f637..e9f6e4e622901 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2957,8 +2957,8 @@ static int dw_mci_init_slot(struct dw_mci *host)
 	if (host->use_dma == TRANS_MODE_IDMAC) {
 		mmc->max_segs = host->ring_size;
 		mmc->max_blk_size = 65535;
-		mmc->max_req_size = DW_MCI_DESC_DATA_LENGTH * host->ring_size;
-		mmc->max_seg_size = mmc->max_req_size;
+		mmc->max_seg_size = 0x1000;
+		mmc->max_req_size = mmc->max_seg_size * host->ring_size;
 		mmc->max_blk_count = mmc->max_req_size / 512;
 	} else if (host->use_dma == TRANS_MODE_EDMAC) {
 		mmc->max_segs = 64;
-- 
2.45.2


