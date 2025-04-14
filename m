Return-Path: <stable+bounces-132552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F03CEA8833B
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A0016069A
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038AA252288;
	Mon, 14 Apr 2025 13:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htupVhMD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31A72BCF7F;
	Mon, 14 Apr 2025 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637394; cv=none; b=WXDFje20uU3lBTaGzuy9ahUHZ9u/vIx4bpkojS8zs5x3OQuZ5hDOaSKJB2yUjb6suWBQX76yMBb6ZsuC1rJBFCiS6hJ+vcj2MtK0zuTaq6zCF7ZvI1RHQt9dl52CeYXcsHGRgID7P6PavmvwLu5itQEQfjCFLHNqA4/BmpMKTMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637394; c=relaxed/simple;
	bh=2hHOj7k57fAN+9OJ5YmLV2yc/C4P2zyyX6dovmoRBFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nV1oLR295+FzhObql15fx/Ze0f2BABtyDQGPaVn/T0N1+QaZQTyPJfYHQtgRhtzHLtnCvuEFZSzYGk8ASQQrkpENIRQRYePlC+crdp9u+HVgDUDnTl5w6zfcqKoFjf7wxdekxsLdxvxxZd39F83IDb3OupMpHDZyXdrEz8E00pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htupVhMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A18C4CEE9;
	Mon, 14 Apr 2025 13:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637394;
	bh=2hHOj7k57fAN+9OJ5YmLV2yc/C4P2zyyX6dovmoRBFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=htupVhMDLkstsvRTf3SSTCHKMd/Z1kVBb6VHs/UrMZ3WwlWG4u/d5U3VcMQnH4f/J
	 xr1FnKrz38gNRTB/O8yz4qJAeuo5N7MNaFhu5RFgLPxxBTkHZ9pKboXrUWV7h/PITc
	 EOh3fpnlE7gqHyj2j9mQArg7RmlOJiPitK6FM/e0qo++E4qYtnmVaWoO+RkObKHRcM
	 SVpkkr8QbvZg/CNUXYDxbNRjGTxTIVf+n1lJK7F0CaMs17ely73nkmAqWnxjjReP+G
	 mj8nuLv27SWwdaf/GYzH/iYwRbRx7+amzG5aLh97JZzG9oc/QSPEM7spiMZVZ1hofo
	 TqvEkQlcj94CA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 29/30] iommu: Clear iommu-dma ops on cleanup
Date: Mon, 14 Apr 2025 09:28:46 -0400
Message-Id: <20250414132848.679855-29-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132848.679855-1-sashal@kernel.org>
References: <20250414132848.679855-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.23
Content-Transfer-Encoding: 8bit

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit 280e5a30100578106a4305ce0118e0aa9b866f12 ]

If iommu_device_register() encounters an error, it can end up tearing
down already-configured groups and default domains, however this
currently still leaves devices hooked up to iommu-dma (and even
historically the behaviour in this area was at best inconsistent across
architectures/drivers...) Although in the case that an IOMMU is present
whose driver has failed to probe, users cannot necessarily expect DMA to
work anyway, it's still arguable that we should do our best to put
things back as if the IOMMU driver was never there at all, and certainly
the potential for crashing in iommu-dma itself is undesirable. Make sure
we clean up the dev->dma_iommu flag along with everything else.

Reported-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Closes: https://lore.kernel.org/all/CAGXv+5HJpTYmQ2h-GD7GjyeYT7bL9EBCvu0mz5LgpzJZtzfW0w@mail.gmail.com/
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/e788aa927f6d827dd4ea1ed608fada79f2bab030.1744284228.git.robin.murphy@arm.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 83c8e617a2c58..13c2a00f8aac1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -503,6 +503,9 @@ static void iommu_deinit_device(struct device *dev)
 	dev->iommu_group = NULL;
 	module_put(ops->owner);
 	dev_iommu_free(dev);
+#ifdef CONFIG_IOMMU_DMA
+	dev->dma_iommu = false;
+#endif
 }
 
 DEFINE_MUTEX(iommu_probe_device_lock);
-- 
2.39.5


