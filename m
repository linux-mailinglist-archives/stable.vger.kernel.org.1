Return-Path: <stable+bounces-183514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AB5BC0E31
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 11:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B013AB30E
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 09:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D292D7DF7;
	Tue,  7 Oct 2025 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJcDcXAK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CF22D3EDF;
	Tue,  7 Oct 2025 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830295; cv=none; b=F1vKN/yd1/0XUKJDTQks+TuwV3LSAzAtA/YYTtGK6Gyme74qo69iKEPxoIF2OmwY0TaN2aF036Sx/ORIl1J2DScDV/9DCXHSwCIwLp+B9E1KGh8UPdNf9VPQQII0vIB4RA45mlyKnjpoEfrTo5J1rrDB6fFQTjjpPcO5FJDm4y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830295; c=relaxed/simple;
	bh=24lxMVd6ezJDeP+VC+ACkuc82KgwoZ9Q4vT6cNRNrWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RoLc6nJ6OnzEwDN0n0sG6jZ7ppwlXG7W+AuHP00rH5p4hednSVCVjGDF1XD2GJIbzrupxTRSsDOkp5dYTpgWqrnXG/rYO/RkNYZv4rdbu6FQiwLYrDmbyCpL0bfErs0Zrn34f9qB3zKds9nnP2WKwAchkc3o+vqUHx/pyVCCQqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJcDcXAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA006C4CEF9;
	Tue,  7 Oct 2025 09:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759830294;
	bh=24lxMVd6ezJDeP+VC+ACkuc82KgwoZ9Q4vT6cNRNrWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LJcDcXAKWu2jTe3Xb44iXIun7VW4wdME/I1WEC5X07Seq4WeR2ABkUmD4SqduLyF8
	 0wXOpmuMSbGK/MG5r0GCh+7bAJ8o+2wCw6dJYI1ySe5MARM7a8O/gdl+VDKbwqkPYH
	 ILyOBOQOwDIVGyxLzXuCIiAB+pyZGVspU1lYPCKDG2mK11LoKaL4GSklpnURSjnYxq
	 XkY58/YJw/2vMG3BjfNeFgqT5xmrVZm2nbTh//IXmTgBLJrVv+2vXO+JmUol5k2jWg
	 HeMkmk1E3fh2rH8dQnWSyLYQ7w7A05btNgpxAXntt58SLZC0/QJmGSQn+o5i6BW8iL
	 kxGPQY4syfhcw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v64FY-0000000035Z-3O0C;
	Tue, 07 Oct 2025 11:44:52 +0200
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
Subject: [PATCH v2 01/14] iommu/apple-dart: fix device leak on of_xlate()
Date: Tue,  7 Oct 2025 11:43:14 +0200
Message-ID: <20251007094327.11734-2-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251007094327.11734-1-johan@kernel.org>
References: <20251007094327.11734-1-johan@kernel.org>
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
Acked-by: Robin Murphy <robin.murphy@arm.com>
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


