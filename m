Return-Path: <stable+bounces-221070-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JGFMFRdo2lxBQUAu9opvQ
	(envelope-from <stable+bounces-221070-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:25:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 700681C909A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A7963542E43
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4AA301EE9;
	Sat, 28 Feb 2026 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPTTkNse"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F790301EFD;
	Sat, 28 Feb 2026 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301415; cv=none; b=U9L3Zj6drZLMteIhr0efeUkXRna3gn7GUEn1hPR7tF6Btq6HZ52U+/o5N3q/TfqChMTCsui/5a6LmBJAzzoAj4gT/ZRHAHmaczZXIsMtaYBzs0ldq7FiUuqmTtBMw2fKQ+iohqo4SOv6ZAgM4Pi7KiOMLN2wCO7mDjoDLnHpb1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301415; c=relaxed/simple;
	bh=o2WKnLJuHPX8Zsj5IZCBvBLuKmZnG+xkrYlmdLsUuz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvZ62JdTSm2nXOP7ZFJm9KKJK6uwacIBrFaIjR3gcX2H/E2gKkHYb8TT9/GK80G664f99Y3dtzcUhcjXV4YCaQTY3AOwXzKEVy3Efwgv3zizvwQBWQUfOTrXoYgUn4J3u7yyCWltZt+oCzClZx0DPzos1L2hezsG3OPlJt91a7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPTTkNse; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9106FC19424;
	Sat, 28 Feb 2026 17:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301415;
	bh=o2WKnLJuHPX8Zsj5IZCBvBLuKmZnG+xkrYlmdLsUuz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kPTTkNseJ5nf7nG9RUfNStH1zuLehMtZod22I4P6sABz0xfPoMa1ro2vpWQcQXDf5
	 lFiuE7sgzwIZyOSuscclOGhFbedKUfBKWOapKNBEjBBvL60iUaiwKVkWlVq4NvmvCo
	 WVl/PCN5E7li8ZlrECjg8oxzaHpUinJXTT7rVGL5vz3XDTe1NEDta6EYWrUmJ4nvYW
	 SHC7/4zoqE0p2uJ1TqSZxJzEsm6syH4cibtSLp7f6q80xMgNiDRbzEcz6l2A0fIz9q
	 Fd8iU/WFevP04JomiOGW7p/heMuU6oOfE7sAIW8izmAADTzIgPrg/ZLCiMV5806iVo
	 tyFmtBMLYImrg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	stable@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 604/752] iommu/arm-smmu-v3: Do not set disable_ats unless vSTE is Translate
Date: Sat, 28 Feb 2026 12:45:15 -0500
Message-ID: <20260228174750.1542406-604-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221070-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 700681C909A
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
index 8cd8929bbfdf8..9ec5591565083 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -165,7 +165,9 @@ static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
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


