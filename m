Return-Path: <stable+bounces-181708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C86DB9F3C8
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 14:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B1C317448A
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 12:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6053009FF;
	Thu, 25 Sep 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D342v1P5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FEE2FE572;
	Thu, 25 Sep 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803350; cv=none; b=qVwtAMVSATWxS6PyiwB1Wrj8zIE5cGTEDuVIhaK9A5NBcxCPurNnlnVJxQJjMuHymSTXcAibVa6qHxfxxOQxS88Qtcy0JCxw+9openzQqDFGTeHq/9nsXW5mSh6o7S5nTA2DBx6dSqsmMBz/kCPxIoPxgwO3MohFEC9dJJMrVkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803350; c=relaxed/simple;
	bh=Bg4I8IWbebGYccvxfcM2gwSUppOl4t3rWxBdtp5EX2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9ooK8d6tgJbSinaXC4bm6bg3tpU7Yj5IbwhroDOY0Ue4xujlDNziyKCQAKVneGO2JchO1AoQYFZQwo4mTqzSkM6VY2WhspQBUjDLVRIt6fTLaX72KEZMWOS3dy7g9YZc0YBok3Q4kPySKm32x2DUyfWhCCekhKbGZW5ji6p/ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D342v1P5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36F5C4CEF5;
	Thu, 25 Sep 2025 12:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758803349;
	bh=Bg4I8IWbebGYccvxfcM2gwSUppOl4t3rWxBdtp5EX2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D342v1P5WEDp7o+QbJv112IaBx4ucrl/SzkxPhJN8FgrMeJxwsj9R5koHOleYHa3G
	 67qJZvZB0qZPStMXFvMGzek8xmu6MOD/FE57TF9XRGe92y8Dcr3GThvrBhxpN4klsC
	 7Eo+Swa+DsVz1EGvWpBGCDsFgQUfoObDZvSILzm6JDJT7bZlEcrmUdIbArIVOCmFgH
	 DWBkOt1S1NuorQT/6LkIVU4O5tSUtWI5Udux6k81A4KVMQ5jQtSo7ujJXnUHrAPygp
	 vKrFyHdv2i6P+pIBhRgW3MRX77nzFW2ArPgTBvHBvLYG+bw26g/fIOP/vHIOyv0unU
	 sDPe2liF+Jn5A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v1l5q-000000002rS-1Atb;
	Thu, 25 Sep 2025 14:29:02 +0200
From: Johan Hovold <johan@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 01/14] iommu/apple-dart: fix device leak on of_xlate()
Date: Thu, 25 Sep 2025 14:27:43 +0200
Message-ID: <20250925122756.10910-2-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250925122756.10910-1-johan@kernel.org>
References: <20250925122756.10910-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken to the iommu platform device when
looking up its driver data during of_xlate().

Fixes: 46d1fb072e76 ("iommu/dart: Add DART iommu driver")
Cc: stable@vger.kernel.org	# 5.15
Cc: Sven Peter <sven@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/iommu/apple-dart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 190f28d76615..1aa7c10262a8 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -790,6 +790,8 @@ static int apple_dart_of_xlate(struct device *dev,
 	struct apple_dart *cfg_dart;
 	int i, sid;
 
+	put_device(&iommu_pdev->dev);
+
 	if (args->args_count != 1)
 		return -EINVAL;
 	sid = args->args[0];
-- 
2.49.1


