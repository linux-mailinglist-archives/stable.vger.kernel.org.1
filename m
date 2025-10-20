Return-Path: <stable+bounces-187921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5042BEF538
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 06:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D8F3BF087
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 04:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F8C2C3263;
	Mon, 20 Oct 2025 04:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzj7gL0p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3E62C0F7D;
	Mon, 20 Oct 2025 04:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760936197; cv=none; b=k5xVFzzeHS896EsjD0XIH5ZW0j8jbfdyGjDbOX9KPLO0dbOqezvEh9rX6ZOtzHxfiXMM99Yu7+sQrrvsYac0Iz6OstngWXq71Zx2rBYEcbziY4vjHGK71Upps1Blqk1H49vMvqsWByF710Vy0lpdzGMeV8r6JBM77DLKYekxqZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760936197; c=relaxed/simple;
	bh=VGVPMHZfJFWJ065a5fqtHiZF8kLqRFAbyAg8TzOuAcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2zfzF0GE8VzPdEdM6HSSE5YXESac/9xrHzXNFgX35YSV6KFvoWzFCq7VrnCZNOHFKSyuJ7dIKw8k+GxETwFjGf5lb20ReukkbdMRBhnMEmta6tqYR5wIKDHKsgBpVrHZztZV+nF3WF+cjPgrW5P8NLXgq+Hl6XJQ00lBYIcUtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzj7gL0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C83FC19422;
	Mon, 20 Oct 2025 04:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760936197;
	bh=VGVPMHZfJFWJ065a5fqtHiZF8kLqRFAbyAg8TzOuAcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mzj7gL0pivU/EfTA7H3gg6z7TV+Je+RM6IUzJNqfokHkifgWMT0Nh5U89DaLg5VUS
	 3x5yU/uM1PYFUf23YtkrhKBWtDfNiXZxOrAjqzxxPK7zHl3YSYpidchv4gH0eZF91G
	 TMRUB2TdeQLEGMmOQBQggW7tvgyqoWXcAFnHQQ23M/DVCr54dm8SoAD+Txv5eQqoKV
	 lAdBq5PDA8XY3jtOSSiG4txlzGdUiaVXE/5xjErpXCjGq6P99OazHFuoKSv2mmdnMq
	 sNot9LOm3x9Jm1r9ynD/wKjMmVVwjKykdhXE2+qBUZSmlZhqAd8Va1WvkTNmzozeTK
	 iVA34TYuYVEOw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vAhwn-00000000837-0X2N;
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
	Magnus Damm <damm+renesas@opensource.se>
Subject: [PATCH v3 04/14] iommu/ipmmu-vmsa: fix device leak on of_xlate()
Date: Mon, 20 Oct 2025 06:53:08 +0200
Message-ID: <20251020045318.30690-5-johan@kernel.org>
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


