Return-Path: <stable+bounces-183513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A8CBC0E3A
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 11:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82763BF78D
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 09:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981842D7DE6;
	Tue,  7 Oct 2025 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5m4il7b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C8025A324;
	Tue,  7 Oct 2025 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830295; cv=none; b=aNegn6uwTa5/n7u3IPOfLFKJGx+5Vv5482p0RAa5yO1HyrLYjJNQJBzJHYqJeBuDeAxC0QB17FJ+/DAWOAVG/4T2p4F3Vb+XxsOPWVray4Zy/F+uSZHFPgWnLakdWqNNVEnemz1yki4ND0j/pGYqcS/gw3V8/s3DBe/EqPKyx5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830295; c=relaxed/simple;
	bh=VGVPMHZfJFWJ065a5fqtHiZF8kLqRFAbyAg8TzOuAcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFfRhQhy0klATMG96YAlYzzBy34cYvhy6v6RHdA6OANr+hr4GsfrrYkIf91ty/3nPSNVNggJ011CDAePzCuUJab/rhd2Mj3uq4dDHBK9od4JK8Tako2VU991K+UkFaZMcF5F8pyeBcBsAnAPGAnkAhKUBqcR3ntaLXoMUQ7A800=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5m4il7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBCFC116D0;
	Tue,  7 Oct 2025 09:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759830294;
	bh=VGVPMHZfJFWJ065a5fqtHiZF8kLqRFAbyAg8TzOuAcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f5m4il7bogse4bk0D9jOCOcDlKkY34svP9eZdZEjow6BRd12AHNkhgt9Ie/PRBVKB
	 63nfTkVz3brZTZ8zihJ4blaGhOE6vH9lRgr7LvBI8y2UrH5/AFCsXp1T0x55Y5wpQR
	 K+JVoO6ZgTT/EWmXZZYoDBgRv3xGovAs03AqKTMAfd4C09La8fwlMC176jVJu8fT66
	 5FNUZOqy8OkZUdsE0Ksxlab+/II6AvFXGjg9zsi1gyJK0Bf31tZoXkIiJZo+3zdLsa
	 2P2C6yTTRT8gAwDgpaV7Bbm7Kro+uABu6w6DcHCGxEoH7AEDm1/5tqjV9ApkgkmYYw
	 AnnWaoEKo1yYg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v64FZ-0000000035h-0Jx1;
	Tue, 07 Oct 2025 11:44:53 +0200
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
Subject: [PATCH v2 04/14] iommu/ipmmu-vmsa: fix device leak on of_xlate()
Date: Tue,  7 Oct 2025 11:43:17 +0200
Message-ID: <20251007094327.11734-5-johan@kernel.org>
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

Fixes: 7b2d59611fef ("iommu/ipmmu-vmsa: Replace local utlb code with fwspec ids")
Cc: stable@vger.kernel.org	# 4.14
Cc: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Robin Murphy <robin.murphy@arm.com>
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


