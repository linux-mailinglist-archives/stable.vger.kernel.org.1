Return-Path: <stable+bounces-77222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B22985A98
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81F211C23A91
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8579F1B81DF;
	Wed, 25 Sep 2024 11:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIUA9q0C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6701B81D7;
	Wed, 25 Sep 2024 11:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264559; cv=none; b=dVX4oT4jUcBtZabVx9hx3egWWgyKchJxXV5aC5fSwzx6t9O/8f3ufisEcs2180JXnRCFQtt/bG9mQzAoM4muy003047/myS6xl0bYnIBCQztBhxp3EB36yk7bfO3LIZNG/eGxx0XXDEMGSVw9zs7KFa+DDxypa/jxsjIdJDgFdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264559; c=relaxed/simple;
	bh=0KQd0k1y4+JdAS4TDaDIygSxEqnD7snMQNXNK2SjcLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0bHx4uU9MW19ZkWAYrAOAkCA0NX9n6qx17tEgrkHnX6v/7Q/Kmut2tlZM42fm7kG777Fj1USkWxZBnxWoPMN57MEEpYeKPj7d4cO+xm4OGD7D+lUMjw5ftB9zLBGGR0d0CW7Zo7KtPmxio8q3fGh71LDGH28zPyRXErxKmmj5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIUA9q0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480ECC4CECF;
	Wed, 25 Sep 2024 11:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264559;
	bh=0KQd0k1y4+JdAS4TDaDIygSxEqnD7snMQNXNK2SjcLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cIUA9q0CChMW1ukPwlHrRMgKOfT5RIPDLoARPmubMBejEyTLXJFEEByztSRb4Jssv
	 xXBIGI0tiOeUDdx5WcHBxSdMChyDS1m50RUdbsVoAy9cZ6E405lX6nPHtlQuaWo2x3
	 hxjWxnM0yoYDoP+LF2uAlAoOKmM/01exs9lxSfvCpNPRxqrkG31yJmk3aIIFaR9h79
	 d3bqYVLC2f/fY4GNpPxXd0CgvjdGCIIT858IppOyF2s9GYZ9wS96E8KbUI8SskhRUJ
	 WkdGuHgvebMbedYXO/kgNkmp/RbJox0nwCL/kgE00xPU6kjrlnV16lj1WEloWaVAR6
	 r33u9iIdGTKlw==
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
Subject: [PATCH AUTOSEL 6.11 124/244] iommu/vt-d: Always reserve a domain ID for identity setup
Date: Wed, 25 Sep 2024 07:25:45 -0400
Message-ID: <20240925113641.1297102-124-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
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
index 4aa070cf56e70..e3e513cabc86a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1447,10 +1447,10 @@ static int iommu_init_domains(struct intel_iommu *iommu)
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


