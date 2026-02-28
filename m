Return-Path: <stable+bounces-220756-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGHNOAtDo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220756-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:33:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D95B1C71CA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 563A030FA049
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B93D40508E;
	Sat, 28 Feb 2026 17:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ooi325s9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB79405085;
	Sat, 28 Feb 2026 17:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300637; cv=none; b=HwEbV0GTWK9ebL6jcx1uyIUQRod3eBtsY2uYBJIxopYPdmg9U3sx39rPPsaE21cvlCrAWY6mbA2zEiSXesUJjwdi+O50ps9ruuJhA5GgiVt1giFUMU079/M4giyZcjI09iUP3z1W4kbVlQj3kQCwUDB27x0SG9qEZptA7KzRfLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300637; c=relaxed/simple;
	bh=oQC+znb4ZNigAItQE36WMOtjblJ8pgVxq3Mmq24po3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSVUi6naWMXoSDYGh8D2G422x3kv4vM3eZfhYIPujTsRnvgg/9dIEwvGUlrktuKa+UYKuq9u6IggkC4vKcm4wHg4lhWAzagxFzKw+Z4/3M9VYVOQQ4SpYsX5K99awjuAF7uX5zwnGeUMRc89h4SLNzqrRdJLmJWvAGbcKZyEWtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ooi325s9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3DBC116D0;
	Sat, 28 Feb 2026 17:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300636;
	bh=oQC+znb4ZNigAItQE36WMOtjblJ8pgVxq3Mmq24po3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ooi325s9oPtq+w452kkhJoImf2DJoIZ6xNhAlmKieaTBF8vBW28oql14MMHxF90RX
	 +zMBDAVwC+nxmj+Xp8cSsp+oRcyFYF1qJQMjjblg3zQpaW8u0wDDuzC+0qwLWSyMSK
	 iVHiJXJ/6e94X0lTzDFjjlQV3Cv1x3or+Ll/jMzSG6KGjM+02s7Ajfp9IHrQ0sxtUt
	 wGFnUxyFRV2AirhK8w8FsRHokGF8LjGS80Yw7/5UVsM53rwdgvxq5uXc8eqlumjb30
	 FSOtRhoPiqZn7LCjUTuLtao2Bso5JDkJCg3slwuM4fhE/0oMVWLQ0XDxkrSDnUwXQ3
	 orwHj6rJcUw+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 677/844] iommu/arm-smmu-v3: Do not set disable_ats unless vSTE is Translate
Date: Sat, 28 Feb 2026 12:29:50 -0500
Message-ID: <20260228173244.1509663-678-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220756-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 8D95B1C71CA
X-Rspamd-Action: no action

From: Nicolin Chen <nicolinc@nvidia.com>

[ Upstream commit a45dd34663025c75652b27e384e91c9c05ba1d80 ]

A vSTE may have three configuration types: Abort, Bypass, and Translate.

An Abort vSTE wouldn't enable ATS, but the other two might.

It makes sense for a Transalte vSTE to rely on the guest vSTE.EATS field.

For a Bypass vSTE, it would end up with an S2-only physical STE, similar
to an attachment to a regular S2 domain. However, the nested case always
disables ATS following the Bypass vSTE, while the regular S2 case always
enables ATS so long as arm_smmu_ats_supported(master) == true.

Note that ATS is needed for certain VM centric workloads and historically
non-vSMMU cases have relied on this automatic enablement. So, having the
nested case behave differently causes problems.

To fix that, add a condition to disable_ats, so that it might enable ATS
for a Bypass vSTE, aligning with the regular S2 case.

Fixes: f27298a82ba0 ("iommu/arm-smmu-v3: Allow ATS for IOMMU_DOMAIN_NESTED")
Cc: stable@vger.kernel.org
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 93fdadd07431a..823461a26659f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -177,7 +177,9 @@ static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
 	 * config bit here base this off the EATS value in the STE. If the EATS
 	 * is set then the VM must generate ATC flushes.
 	 */
-	state.disable_ats = !nested_domain->enable_ats;
+	if (FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(nested_domain->ste[0])) ==
+	    STRTAB_STE_0_CFG_S1_TRANS)
+		state.disable_ats = !nested_domain->enable_ats;
 	ret = arm_smmu_attach_prepare(&state, domain);
 	if (ret) {
 		mutex_unlock(&arm_smmu_asid_lock);
-- 
2.51.0


