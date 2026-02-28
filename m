Return-Path: <stable+bounces-220754-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJKKGtxAo2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220754-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:24:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 261371C6EF4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FA9B30D21C8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48159404708;
	Sat, 28 Feb 2026 17:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toFpVqd7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07220404701;
	Sat, 28 Feb 2026 17:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300635; cv=none; b=gQHXCNUe5BLhjelsKFMzgMQL5cU0UFg7NX1VrVT4juyQgC2+pt8fIys73Povmp0nfNSMOT/rXxNrx3v5/vnKriyMHdT58kZgvNEUiHpgYd0rTXkFXoCnawQrIbVmtZ85lG+KwXlSrvlcjk2DNLL1wjZutEnieUnVBeM11CvTYZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300635; c=relaxed/simple;
	bh=i0hec5elO3Uy2H1s2O7ojzDBcoo/YFdHOGcSU5X+kjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YB6bgHmgagASVuSHT0rAr/ZiUFJ2pUbKo1ukdPaVgT4jUMd5cScIar21PxiGjjGOCFkRLzg1ikaEk1Ty48IHN+LmW2peZGCw3gkrj5YZwismEMABPOUt/vnCceOyiv5rEaBTulNQ/5Qkl8E2ik3LkmLnnn2Pd41z7kSKrxw0UWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toFpVqd7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9921C2BC87;
	Sat, 28 Feb 2026 17:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300634;
	bh=i0hec5elO3Uy2H1s2O7ojzDBcoo/YFdHOGcSU5X+kjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=toFpVqd7B+T3Li5JVAQRsk4gYhWIUrWw+/giuxEscmBhQ9Pf0otrVhV8HORLyBczR
	 /I3QS4lRAKtVJOEWxV9cP2Gm3fB3x6suQuBkOoOcsS6iYsjwLc8Shd30U90OPuNom5
	 aUPH4NFQm9QrQTlrwsOYLKJ2E/YpeJ5HVEmCBrjI7Htt7TcPpVuU1esBRJze+WIIGX
	 7BCKADoqrxCdx+GT9vuVwnL2GIMHN3X3/i4JNAV3UngERMbbUyf/MvDIFg32gdZWFD
	 AdgDQVHDT/HLq5pcsXLTT4PvE+dtVP0M+Jd0Fgvc10vPL0ZlNWpA0kaLMHuFwijzQ5
	 S0hCipnuQmuaQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Mostafa Saleh <smostafa@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 675/844] iommu/arm-smmu-v3: Mark STE MEV safe when computing the update sequence
Date: Sat, 28 Feb 2026 12:29:48 -0500
Message-ID: <20260228173244.1509663-676-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220754-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 261371C6EF4
X-Rspamd-Action: no action

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit f3c1d372dbb8e5a86923f20db66deabef42bfc9d ]

Nested CD tables set the MEV bit to try to reduce multi-fault spamming on
the hypervisor. Since MEV is in STE word 1 this causes a breaking update
sequence that is not required and impacts real workloads.

For the purposes of STE updates the value of MEV doesn't matter, if it is
set/cleared early or late it just results in a change to the fault reports
that must be supported by the kernel anyhow. The spec says:

 Note: Software must expect, and be able to deal with, coalesced fault
 records even when MEV == 0.

So mark STE MEV safe when computing the update sequence, to avoid creating
a breaking update.

Fixes: da0c56520e88 ("iommu/arm-smmu-v3: Set MEV bit in nested STE for DoS mitigations")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 56420104e154e..65c0119f45eae 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1097,6 +1097,16 @@ VISIBLE_IF_KUNIT
 void arm_smmu_get_ste_update_safe(const __le64 *cur, const __le64 *target,
 				  __le64 *safe_bits)
 {
+	/*
+	 * MEV does not meaningfully impact the operation of the HW, it only
+	 * changes how many fault events are generated, thus we can relax it
+	 * when computing the ordering. The spec notes the device can act like
+	 * MEV=1 anyhow:
+	 *
+	 *  Note: Software must expect, and be able to deal with, coalesced
+	 *  fault records even when MEV == 0.
+	 */
+	safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
 }
 EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_update_safe);
 
-- 
2.51.0


