Return-Path: <stable+bounces-187920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B7CBEF534
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 06:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA58C1892F6E
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 04:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C9D2C2363;
	Mon, 20 Oct 2025 04:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Agze4Khb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C0C2C0F6D;
	Mon, 20 Oct 2025 04:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760936197; cv=none; b=dqs+7ITfRvVglawkV9SXw7OTh4YTJSsXtU1Fo8lX5/9IT90QsPzI5BZ5FNZP/9hSHhbeVjcmYmAtJsdVVSaxeqifotFyGBCKAxnJdF5QPiifExOXxFdxcjAgtaNLKVopaKfij53bcmpYV+rlv/pu5DzbF1NR7guMgHvRTA9zAts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760936197; c=relaxed/simple;
	bh=Vs3JXMHA2JEN80dOAChSfBFVZoS2PQMeJrgOF/SbKA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aj38BqlOvEx9IuQR6AC/OEgiixw1WM8nK+ocZ9a1Rp6mclLgOoUg9swAZYRKzvtlqh6DPg/bpX7gcPzogddV5ItC3zk1wx1bj9yHrkqXLxghyjF9afpFJrjbrUMIhRniitnrqtiOy9tXC6svMxpTm1v5h1uXh0nBseEyu17Sh/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Agze4Khb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7769BC19424;
	Mon, 20 Oct 2025 04:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760936197;
	bh=Vs3JXMHA2JEN80dOAChSfBFVZoS2PQMeJrgOF/SbKA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Agze4Khb9TZRD9HcFWiVIswGbHx6PwWVM6QOeLZdAUlH7K4HF4Ib94GrJfb4sLKfP
	 zPThsumbAEkrSo0h8V6Wi0XyC8qqjhZr5L+l9WfI28pwTBXlVo11MkpKM2vtsqWpLf
	 07X2eAT6Rvtv1WwqiZc+SCbv1vLsCFo92oA2FV0yiGN2TJXWU2jeSGm2VGsqlaoftr
	 Pu02do99WfoGfsx5iPPTukJM9kyfFjA/k91btFRBpDvve3pyczRWkBGG6Zohi1S4Lq
	 IAVr636PgNp5YiNx0pM89GH1DPOPD48LtvfrExvE3mhewla+IExLDb3qeYyjJH5dFl
	 /8rZJUXGW22Cw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vAhwn-0000000083J-22AS;
	Mon, 20 Oct 2025 06:56:41 +0200
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
	stable@vger.kernel.org,
	Honghui Zhang <honghui.zhang@mediatek.com>
Subject: [PATCH v3 08/14] iommu/mediatek-v1: fix device leak on probe_device()
Date: Mon, 20 Oct 2025 06:53:12 +0200
Message-ID: <20251020045318.30690-9-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251020045318.30690-1-johan@kernel.org>
References: <20251020045318.30690-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken to the iommu platform device when
looking up its driver data during probe_device().

Fixes: b17336c55d89 ("iommu/mediatek: add support for mtk iommu generation one HW")
Cc: stable@vger.kernel.org	# 4.8
Cc: Honghui Zhang <honghui.zhang@mediatek.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Yong Wu <yong.wu@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/iommu/mtk_iommu_v1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 10cc0b1197e8..de9153c0a82f 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -435,6 +435,8 @@ static int mtk_iommu_v1_create_mapping(struct device *dev,
 			return -EINVAL;
 
 		dev_iommu_priv_set(dev, platform_get_drvdata(m4updev));
+
+		put_device(&m4updev->dev);
 	}
 
 	ret = iommu_fwspec_add_ids(dev, args->args, 1);
-- 
2.49.1


