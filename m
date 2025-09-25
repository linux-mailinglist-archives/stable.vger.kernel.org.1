Return-Path: <stable+bounces-181712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0602EB9F3D1
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 14:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2177D7A6D81
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 12:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18A2302756;
	Thu, 25 Sep 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnU66YD2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875832FFFB7;
	Thu, 25 Sep 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803350; cv=none; b=siS02oqkte1+C7ifXjxbAO1BR93ZtWH1dI+eOi222rE9p31skwZrQyST3o6e8pv76FaWqS5LPLRVGKTibvPywll3u0hnubeX6qLSLEsOdFd01h315c5qS9MoyBXvKkJr2c4yoQVofgVFwbgXMnf2f+fq0JtyprAHlZb44hAXZjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803350; c=relaxed/simple;
	bh=mdosckf0l+HgxKirE+dl118jDU4w52EV+AHS+DL8NSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXtTXuBubnUyvc3Po76AHVs2MSF5XPNQpW+dT7W2lieEKKSC+XhBZKVainNUw1NXODq8He34ajmm7jxNtbSNOIT3GVxgCX1AiLXQ0LT+lP9UzHIzrqlwb9dQTKFt5BEr5qMU8bgpphNhZG3UCDoyGaAaXZjhzPDfI2gart6PRRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnU66YD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1710CC2BC86;
	Thu, 25 Sep 2025 12:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758803350;
	bh=mdosckf0l+HgxKirE+dl118jDU4w52EV+AHS+DL8NSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DnU66YD29txcemyS+NUCwra1MvI2Sot3XYzan+5y/yi9m9pk75j8eDjYcc4rwdqQf
	 z8VAvz1P1V708y+itzCEAx0kxV3dhmf0WQl2FF1/OmHhPhvh7VZLYopkmNQn9sAOBL
	 x7xrVJWtnQyzqVK3q1DKxLxw1O1YbutHMnx5ldo3wIat4nemhqWx7lGA+bWXWLlBRX
	 fx6541S0PT2MvYCHczVAVcCqbwkZAYXxDqaEG9Vdm506AfwUKhIq5lARFwcKWng7zA
	 5flb7itK1ffMHOOl7C8PmJzTmD+6/RltwLHCMASjbsGd+mm7OiaF3W0lCcaEnJDgO7
	 gDYMOJhkNQ3dw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v1l5q-000000002rY-2AEB;
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
	stable@vger.kernel.org,
	Magnus Damm <damm+renesas@opensource.se>
Subject: [PATCH 04/14] iommu/ipmmu-vmsa: fix device leak on of_xlate()
Date: Thu, 25 Sep 2025 14:27:46 +0200
Message-ID: <20250925122756.10910-5-johan@kernel.org>
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

Fixes: 7b2d59611fef ("iommu/ipmmu-vmsa: Replace local utlb code with fwspec ids")
Cc: stable@vger.kernel.org	# 4.14
Cc: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/iommu/ipmmu-vmsa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index ffa892f65714..02a2a55ffa0a 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -720,6 +720,8 @@ static int ipmmu_init_platform_device(struct device *dev,
 
 	dev_iommu_priv_set(dev, platform_get_drvdata(ipmmu_pdev));
 
+	put_device(&ipmmu_pdev->dev);
+
 	return 0;
 }
 
-- 
2.49.1


