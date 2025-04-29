Return-Path: <stable+bounces-138980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD381AA3D4D
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 01:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F5027ADC02
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 23:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596F02609C6;
	Tue, 29 Apr 2025 23:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFw7xcsa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1231A2609EF;
	Tue, 29 Apr 2025 23:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970653; cv=none; b=mbykqxNqvhXebCJBVENb37rG9ZY1wuDIBRGfnrIRcYcvXWgpfHPOi/lDIB/j7y0LHMxAUc0XwpnrZn/8YbT6Q73+EDmXyZM2m4/r0THYAXIAjIm4c02iVX/7rHKlqJBiw64SPbHWTpmfu4YC+xRzVLuVcki7sU7IdlG3rRBe6CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970653; c=relaxed/simple;
	bh=BKoPq7hKYiVRd3qb/NWCXj789wDEgmQZqkzbTJa/eJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HiHTFWrQJcebWzD5yHrSxw20oUhTmBjGb2UsDpWinhdA/UAc9zZ4G6nd4M4uc3QeQl5v+O+byq3MTsUilIeLDz3zshGKGlbOCY28vJGKznH4+ZvYHo3xmfST8XRWvQI9ZUuGRtr+IYVm29abNFUMTVNz18WsD0pUToNPr8r4uHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFw7xcsa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962DDC4CEEF;
	Tue, 29 Apr 2025 23:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970652;
	bh=BKoPq7hKYiVRd3qb/NWCXj789wDEgmQZqkzbTJa/eJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GFw7xcsadEzAR53xLWaSqT8i/FUK7veO54C40KiLXPwYCpQBlndla7+m4jNecYKYH
	 N2gt+hCY+f32AsxtcWeviK8jsDnSAMxpFFXZmZ++ZBU8lzPlJzwxqoG3NpPrzt4nAe
	 a0PlUmsiT2El9aSM1BiTi4fXEmvOriyuE9SFTH08tYucQS9WtBWv8KZLXNtiurDgD4
	 flejFyE45Rz9sPavlMHXNYiYcdbuU7jfb2KtWb+LEbFwu5POiMLgn9+HbCLpoRUc7s
	 fWkyOJY2qA8r5wcnQmct2osy087hF0F3ermFZFFX1SL7XGfKrwMrxKIk1PAN88VNJt
	 7b0e6Uf/es04w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Balbir Singh <balbirs@nvidia.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	kernel test robot <lkp@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.14 24/39] dma-mapping: Fix warning reported for missing prototype
Date: Tue, 29 Apr 2025 19:49:51 -0400
Message-Id: <20250429235006.536648-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235006.536648-1-sashal@kernel.org>
References: <20250429235006.536648-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.4
Content-Transfer-Encoding: 8bit

From: Balbir Singh <balbirs@nvidia.com>

[ Upstream commit cae5572ec9261f752af834cdaaf5a0ba0afcf256 ]

lkp reported a warning about missing prototype for a recent patch.

The kernel-doc style comments are out of sync, move them to the right
function.

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202504190615.g9fANxHw-lkp@intel.com/

Signed-off-by: Balbir Singh <balbirs@nvidia.com>
[mszyprow: reformatted subject]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/20250422114034.3535515-1-balbirs@nvidia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/mapping.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 67da08fa67237..051a32988040f 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -910,14 +910,6 @@ int dma_set_coherent_mask(struct device *dev, u64 mask)
 }
 EXPORT_SYMBOL(dma_set_coherent_mask);
 
-/**
- * dma_addressing_limited - return if the device is addressing limited
- * @dev:	device to check
- *
- * Return %true if the devices DMA mask is too small to address all memory in
- * the system, else %false.  Lack of addressing bits is the prime reason for
- * bounce buffering, but might not be the only one.
- */
 static bool __dma_addressing_limited(struct device *dev)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
@@ -931,6 +923,14 @@ static bool __dma_addressing_limited(struct device *dev)
 	return !dma_direct_all_ram_mapped(dev);
 }
 
+/**
+ * dma_addressing_limited - return if the device is addressing limited
+ * @dev:	device to check
+ *
+ * Return %true if the devices DMA mask is too small to address all memory in
+ * the system, else %false.  Lack of addressing bits is the prime reason for
+ * bounce buffering, but might not be the only one.
+ */
 bool dma_addressing_limited(struct device *dev)
 {
 	if (!__dma_addressing_limited(dev))
-- 
2.39.5


