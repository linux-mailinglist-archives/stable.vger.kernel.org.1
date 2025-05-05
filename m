Return-Path: <stable+bounces-139926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB99AAA256
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54F5E7B04CE
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30072DA827;
	Mon,  5 May 2025 22:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XX1xYNlx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCCC2DA116;
	Mon,  5 May 2025 22:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483685; cv=none; b=Qa8/71Aomm5wY3FVTEGwIY6JnqeBk5VWVUrI724gcsfROldMOaU+Ops0veJ6VDHkG0IO0YRFYJCoTCrhPh0u0EfhaKGLKZbizaZqzjQrTpS1jfpx92tdxhLS3w+4ozJ1sEyLxaVnSU3rXQKTcaLseip7if5uK+w2IU62bPH+bsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483685; c=relaxed/simple;
	bh=eo4Fa6CgI/HpElnDm5vdUR99d7waC0pJUIEn/hDqvp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fTgK1Xf7gF8mpzmaGIhnKSqQca+6E/ddibcqWSmesXxlb6/otjiYSXA7/a0REcfLhpTdBxXU+FuLvtzy5F/a7kFpE80Eta43TsUOeJWEzOii3qga9pM0nfa5qZmR/yswU0bovk7WSrJqWTARPMxJ5+4nJbNgWwKRnc1qAuFImcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XX1xYNlx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01950C4CEEE;
	Mon,  5 May 2025 22:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483685;
	bh=eo4Fa6CgI/HpElnDm5vdUR99d7waC0pJUIEn/hDqvp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XX1xYNlxJ4bgr7sSCBsdVAw96QV1HdvMauep/+aU6rtlNWbH+3S1+G1tsG2X8c1Pk
	 k8bhm9w7l+pfWZHDN3CFcQiTg4kQd0EzRD7A4xeADJO779L/Cotp52pKmI1FlPjxBu
	 plu0wcy9FK+rAls21pF0Q1cUir2PFHHopKzLcGHgktM4zwM4mNagcKlGlGkISZcOWx
	 8eBUqoNmNRIZfEWYyG5yP68Y5MhMkV04DntAOXm9k/2X5+ofigfFvdUrD3yL9P6LXY
	 u/fyaebKfpmCsnMUhfPpBlcO9YBtJw87HNVoUbS5Kto6J3+A5XDOqlq7c8WDICHrrM
	 9KkCIrTT2XLeA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.14 179/642] iommu: Keep dev->iommu state consistent
Date: Mon,  5 May 2025 18:06:35 -0400
Message-Id: <20250505221419.2672473-179-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit 3832862eb9c4dfa0e80b2522bfaedbc8a43de97d ]

At the moment, if of_iommu_configure() allocates dev->iommu itself via
iommu_fwspec_init(), then suffers a DT parsing failure, it cleans up the
fwspec but leaves the empty dev_iommu hanging around. So far this is
benign (if a tiny bit wasteful), but we'd like to be able to reason
about dev->iommu having a consistent and unambiguous lifecycle. Thus
make sure that the of_iommu cleanup undoes precisely whatever it did.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/d219663a3f23001f23d520a883ac622d70b4e642.1740753261.git.robin.murphy@arm.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommu-priv.h | 2 ++
 drivers/iommu/iommu.c      | 2 +-
 drivers/iommu/of_iommu.c   | 6 +++++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index de5b54eaa8bf1..a5913c0b02a0a 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -17,6 +17,8 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 	return dev->iommu->iommu_dev->ops;
 }
 
+void dev_iommu_free(struct device *dev);
+
 const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode);
 
 static inline const struct iommu_ops *iommu_fwspec_ops(struct iommu_fwspec *fwspec)
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1efe7cddb4fe3..3a2804a98203b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -352,7 +352,7 @@ static struct dev_iommu *dev_iommu_get(struct device *dev)
 	return param;
 }
 
-static void dev_iommu_free(struct device *dev)
+void dev_iommu_free(struct device *dev)
 {
 	struct dev_iommu *param = dev->iommu;
 
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 97987cd78da93..e10a68b5ffde1 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -116,6 +116,7 @@ static void of_pci_check_device_ats(struct device *dev, struct device_node *np)
 int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		       const u32 *id)
 {
+	bool dev_iommu_present;
 	int err;
 
 	if (!master_np)
@@ -127,6 +128,7 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		mutex_unlock(&iommu_probe_device_lock);
 		return 0;
 	}
+	dev_iommu_present = dev->iommu;
 
 	/*
 	 * We don't currently walk up the tree looking for a parent IOMMU.
@@ -147,8 +149,10 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		err = of_iommu_configure_device(master_np, dev, id);
 	}
 
-	if (err)
+	if (err && dev_iommu_present)
 		iommu_fwspec_free(dev);
+	else if (err && dev->iommu)
+		dev_iommu_free(dev);
 	mutex_unlock(&iommu_probe_device_lock);
 
 	if (!err && dev->bus)
-- 
2.39.5


