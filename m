Return-Path: <stable+bounces-181713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5CEB9F3DD
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 14:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF2717A5AC
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 12:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EBB303CBB;
	Thu, 25 Sep 2025 12:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csWs0Buy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8761D2FFFBC;
	Thu, 25 Sep 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803350; cv=none; b=YH/BPUMTXZyAxjxwt28jMKB/+bke/jIPKV2YxRSMNgfF3oi8zCoGYsOjKEq2eQLHSCg9IugeyyogRTINZRyu5JoT3IjRIfgRa2ylkncKwQ0e4a9cVJBLp6XUEUHv8rUr79SJnqdCSNPnkssaYpbR5dTg4WE/WDN0UuFJRIPhCLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803350; c=relaxed/simple;
	bh=I2uuCriRflVqgvU8CtAnGXErcoFYIBf/4993czMBu4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEmrsrVpnX+Wj64GHZy0RV84hIypKFUfgpD2Fd4KIphF4v8r5nGFKdy0Kt5MVHRpiY0jeAF4RtWgKJSTg0g4DQYSfoMx+PzelcEmL0WCv5wgJFB8U2puqTtzE3fsi5xI3q7lNl+uiE/k3OZR6sTl6IqSqegtl8vJMUS2DfWJYVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csWs0Buy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F81C19423;
	Thu, 25 Sep 2025 12:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758803350;
	bh=I2uuCriRflVqgvU8CtAnGXErcoFYIBf/4993czMBu4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=csWs0BuyxNNhkbWIrSqp2//obeC2K8qMFRJN2Lw/QXKsl5DEF0ueDq3Xv1BfpR/GV
	 hIv36MU7b9j+Cv7FnEQQZ7Jf4GmUqy2Jxamw0lE5OGpaFpfwlZAGFTG25ekancdaqo
	 DyhjkZ/IGuEg+yoWj4kbfYsebADvpROuCFZxYwfZkmkldioLQIToGtEOqo1uAq7+h1
	 I7b1o4JnQGKARIpxaUZKIwAbgLtum1e2PBMZXdy5wGKvH/HKsSBClWjVbkV4JsyJ4b
	 gjs+Ix34C0eYkJozzyZbK0lxV01xZHpWU6+YTw5trmxEbgzaIa0IcZD8QJAOZwCjIm
	 NzYlZ8xut3viw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v1l5q-000000002rb-2a5G;
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
Subject: [PATCH 05/14] iommu/mediatek: fix device leak on of_xlate()
Date: Thu, 25 Sep 2025 14:27:47 +0200
Message-ID: <20250925122756.10910-6-johan@kernel.org>
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

Fixes: 0df4fabe208d ("iommu/mediatek: Add mt8173 IOMMU driver")
Cc: stable@vger.kernel.org	# 4.6
Cc: Yong Wu <yong.wu@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/iommu/mtk_iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 0e0285348d2b..8d8e85186188 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -974,6 +974,8 @@ static int mtk_iommu_of_xlate(struct device *dev,
 			return -EINVAL;
 
 		dev_iommu_priv_set(dev, platform_get_drvdata(m4updev));
+
+		put_device(&m4updev->dev);
 	}
 
 	return iommu_fwspec_add_ids(dev, args->args, 1);
-- 
2.49.1


