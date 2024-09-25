Return-Path: <stable+bounces-77452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A077A985D6E
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476EE1F20EDE
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C73E1E2003;
	Wed, 25 Sep 2024 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s083TyZ1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6FA1E1A3B;
	Wed, 25 Sep 2024 12:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265816; cv=none; b=DlDqjiW/s7gji0HOeJwRxiZIHxMY1Yv5gyp2WB8mYCrCJ4989GPWt4Y9JrFdjIEM4q+X4x60pEmokvu8xNO5djZVYaXZTAogLuaGx4tal+4Fd4479pf7nq9Gw78eynixqHx4FM1IQJfohEIx5DuZt+aKsgAi0zP8IoNzHU9jRVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265816; c=relaxed/simple;
	bh=sG+YR21KKAj/tfJpOX/8rEsopszcBLwNQ0dcCogdoT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HejboHzpn2lBHdp1JY37IskAHoR7Xwizw+KH9eJ9TFIZrHFSOtKBUST9A89BDuXmY8FwlWg4pA6gvvhX4T9Bh0ekJpiQ+g1fHXhq8j5Qoh5ZFlZFrVDZAGFwlw/DD8BLLl2LbwWbq2YydVnQSdACoWTKUG8YkIijd/yP1V6HZmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s083TyZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27337C4CECD;
	Wed, 25 Sep 2024 12:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265816;
	bh=sG+YR21KKAj/tfJpOX/8rEsopszcBLwNQ0dcCogdoT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s083TyZ1N0xJQAi1YNPXLyz1Urz+PpMn199S4ZwAsB7/ejb06pRwxmakcYiglM/Oo
	 X5q+bmo5sRN1+Yx1dtgIJ1NJNTw6KAlqBy5AeHxEy+A3k27xH6ssqa8kMA/ayXkAet
	 gHKBN89IQmpg15heheum1Lg4ad2Mo4NeoTCqPo/8msIWcqk2+N9J/u78cXwWGCy3EO
	 +4vTngj8ZMkNunDeN+2G2owEJtQI7GZ6d0wQUkje4FgOEmZ5S59SqSfcxcTDihB8uZ
	 y1yKlJAOeKjZME00yHcLpS7/ZAdYbqiNz0VcVqYRNFxRfoWq7mVV1gzcstWIqk9lu6
	 ilwwXt+T589Gg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	dwmw2@infradead.org,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.10 107/197] iommu/vt-d: Always reserve a domain ID for identity setup
Date: Wed, 25 Sep 2024 07:52:06 -0400
Message-ID: <20240925115823.1303019-107-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

[ Upstream commit 2c13012e09190174614fd6901857a1b8c199e17d ]

We will use a global static identity domain. Reserve a static domain ID
for it.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Link: https://lore.kernel.org/r/20240809055431.36513-4-baolu.lu@linux.intel.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e9bea0305c268..eed67326976d3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1462,10 +1462,10 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 	 * entry for first-level or pass-through translation modes should
 	 * be programmed with a domain id different from those used for
 	 * second-level or nested translation. We reserve a domain id for
-	 * this purpose.
+	 * this purpose. This domain id is also used for identity domain
+	 * in legacy mode.
 	 */
-	if (sm_supported(iommu))
-		set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
+	set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
 
 	return 0;
 }
-- 
2.43.0


