Return-Path: <stable+bounces-187917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2E4BEF528
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 06:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20ABF1890676
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 04:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5182C11F4;
	Mon, 20 Oct 2025 04:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbNsoq84"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7203F2C0266;
	Mon, 20 Oct 2025 04:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760936197; cv=none; b=iiD5NyXzpP//fvT0r49l7QA6x+JuwWdKzL2d3m9/npnPlSAs88M+AHpPHPPUdRBINZ5RV03HCCLQCZ35hK/HuKOO8GH7za01EG71wqoUTCVd14NcrslhtNoTkOf+SzIHrXT3kfzzILdsbYOutlHJ/X7Gyooh4UghX6Dru0lOyJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760936197; c=relaxed/simple;
	bh=FyWhY5bdBhnBjSs0edv55LlddyoKr6zkeQMAkUftQ70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+JmbbjSI+ZydRnYD/EvXKxRO+aLFm+JIShc410TB8n56IzHWnU+qJ5NGexS2xCIu7s4Cqkaayw1VjX8GImFBLRSV50G8hjyJRxIrJudbou46hFD4ajibfeoHPLVwD9mKnMPxSNunQed4yAowyMUfKimE04Kgrx0vduMn0v6u+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbNsoq84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359C5C19421;
	Mon, 20 Oct 2025 04:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760936197;
	bh=FyWhY5bdBhnBjSs0edv55LlddyoKr6zkeQMAkUftQ70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NbNsoq84dyjFRgMtcA96mVS3b2XBf/pIlooEgaFs7+3i3Js3NvAioIrM2QRxCIlP1
	 /DOGUZbzxwJ4KKeBhXqDDv4JiyyEjq0GB2z7WpCYzWXXz9Rf1H0NvQD5PFEHPiYQyD
	 imxXO+6wv/dj6NmQv0NGW9LGXYGFGtzX91pvNr3c05Uy/onWLbKggp6mymu+e8OROV
	 VT6RlQiMHAItRzYMwbcqZBc9vNeMdGnTJynywE2hPYur8MMwPNkeXm4hxe3+42Fvu5
	 hc9U1b4dykspZiNE1Ca0cI2qIn9gHGir7D/03Ln7dzDP6PSuOd6LSN6dUCTugJ+1IK
	 U9bBDOJbtYpcA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vAhwn-0000000083B-0zoc;
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
	stable@vger.kernel.org
Subject: [PATCH v3 05/14] iommu/mediatek: fix device leak on of_xlate()
Date: Mon, 20 Oct 2025 06:53:09 +0200
Message-ID: <20251020045318.30690-6-johan@kernel.org>
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
looking up its driver data during of_xlate().

Fixes: 0df4fabe208d ("iommu/mediatek: Add mt8173 IOMMU driver")
Cc: stable@vger.kernel.org	# 4.6
Acked-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Yong Wu <yong.wu@mediatek.com>
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


