Return-Path: <stable+bounces-107736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4B1A02E17
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 17:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70BA018821DA
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CF31E0080;
	Mon,  6 Jan 2025 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItO3rogY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66501DFE10;
	Mon,  6 Jan 2025 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181738; cv=none; b=s6819dx8kfykbtGUFvKuUxuGPTZZscNXk4AeXFASeEnvTxEILqqVB/Cr7SAr/jLEvVgrVwDvTrQnAQVPEw1nVDJAIMTKBsW0LW1DqCsPf1xpx80wzLW6j56+KxX9YAHMsN2ONy0Rb8UF+0/Z8l1m2Yif9OtQTAhD/2YRO619SrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181738; c=relaxed/simple;
	bh=NZjaipx7SOL5Wkr2z0JjaWDaYrgGFoWE9FvBd4OLYBs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BCmn8tDA0C3rjR0jM1OaHOPkFb7ci9lT/dH4Z5k3fhjkTkg9FzVNb3PVZ5NgkjzsiaHpwm20QrwpPIg1/gkNdQa9GmO8DSBl0ZWB1/qZE6XG7oaI/BkzD0ncJzs+M3lQnZL4KGmF90hOGoPh5eth+ihkY7ckmGD9DORs2VaFt/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItO3rogY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9245EC4CED2;
	Mon,  6 Jan 2025 16:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736181738;
	bh=NZjaipx7SOL5Wkr2z0JjaWDaYrgGFoWE9FvBd4OLYBs=;
	h=From:To:Cc:Subject:Date:From;
	b=ItO3rogYaVrwBDxuvqD1Lpxm6bv2X9Mbb18jHSH77WRlLNcwCFlmazF296kIlVnBE
	 MD3T58x1aj5evbVGXl0TB9cUiE2+zv+kyIkWJAMNf3kIFpIAZI8GrevCQPV1wBZGbZ
	 lmFxaiwhjgVCIb9yUmceFZ6w3jYSyX1QL6RMfrPZabI6ZQH+GC0Y71hHMZ9+o/LkQU
	 fWk5j3ojU+r1ulG3VXL2+R4IqcNi+V3BYTxQeMhEoqMs6dQlHfeLRDu09MZjFuGK1U
	 xHuHi5mn0nO/abqkwKNU7TH41fdsAok4tvXlwOyGMDPbrV2NZLYkp/IqGsTvm/zYCB
	 OLteGizzCI26Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10] nvmet: propagate npwg topology
Date: Mon,  6 Jan 2025 11:42:16 -0500
Message-Id: <20250106164216.1122400-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.232
Content-Transfer-Encoding: 8bit

From: Luis Chamberlain <mcgrof@kernel.org>

[ Upstream commit b579d6fdc3a9149bb4d2b3133cc0767130ed13e6 ]

Ensure we propagate npwg to the target as well instead
of assuming its the same logical blocks per physical block.

This ensures devices with large IUs information properly
propagated on the target.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/io-cmd-bdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 6a9626ff0713..58dd91d2d71c 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -36,7 +36,7 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	 */
 	id->nsfeat |= 1 << 4;
 	/* NPWG = Namespace Preferred Write Granularity. 0's based */
-	id->npwg = lpp0b;
+	id->npwg = to0based(bdev_io_min(bdev) / bdev_logical_block_size(bdev));
 	/* NPWA = Namespace Preferred Write Alignment. 0's based */
 	id->npwa = id->npwg;
 	/* NPDG = Namespace Preferred Deallocate Granularity. 0's based */
-- 
2.39.5


