Return-Path: <stable+bounces-220755-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aICCNf9Co2li+wQAu9opvQ
	(envelope-from <stable+bounces-220755-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:33:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6421C71BC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E2CD33063FE1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A4540471F;
	Sat, 28 Feb 2026 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMX5PLGH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4AF404718;
	Sat, 28 Feb 2026 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300636; cv=none; b=GMBI8f6au4gZ4EkNgW6+EmPpWb7diLux1NDKe6PR41J7gH7rNgdOC91b2PtYUJRNxMc1RfTzDDQLIFP3D3Kyd/49NkezueXP2Aab4WFa1iqxF6tVFJ4TEBecOAs9jjn85VoocP0HLYukLVJbqTNsPvbrWOWv+xieJPW1uPGtOn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300636; c=relaxed/simple;
	bh=m656M2eFCFwUxJZh0qPMW5TWZ7MJ1/UrBFM30tb22pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNQ84qnj6cHTqiP5h9FzJL5kVS1va247S6b69lMYpifO68dkgeJzlCwT9l5OWHwYlHjS01XseyMLJrW1KzbwBaqKoQ/tWB3UbxeJ7v1d3kf96bE25xyj+6BKPvR1EPHjl0obVWYkTTCR2fIIVb9hLcvV5URI1mWxm0zxlbVgxyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMX5PLGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B45C19423;
	Sat, 28 Feb 2026 17:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300635;
	bh=m656M2eFCFwUxJZh0qPMW5TWZ7MJ1/UrBFM30tb22pA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TMX5PLGHEl4pBi25LvK+H/9EstifGya51r0fC9ekmRFFwAxKcbJUImsJEM1OB8xek
	 s89mDqtFQGP2jP+15e8P0BWo2cd7CM/Ls/ebaG9El4Fwf1fz2aK8I3t1krptlqQO7P
	 lHVxKjgCUOw+KbC2aQcdn7XQ5RcGI/mnK85kLUO/gmEkE69KhHUf0Dfeq+nH5lIqyS
	 P0ff+LA+D0aUxJDrqGb5yASyYOljoUwhAbRqLsnYNdFXUX6KVVKqpFKivCeGTAORN4
	 51BHuUzsD/Hbvv57O1yw3bOdxvaeTttQLiA9Goqd/5NeriklXRYN6rhbe7+irEJncf
	 E3FuD4wet2+Pw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 676/844] iommu/arm-smmu-v3: Mark EATS_TRANS safe when computing the update sequence
Date: Sat, 28 Feb 2026 12:29:49 -0500
Message-ID: <20260228173244.1509663-677-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220755-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: 7C6421C71BC
X-Rspamd-Action: no action

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit 7cad800485956a263318930613f8f4a084af8c70 ]

If VM wants to toggle EATS_TRANS off at the same time as changing the CFG,
hypervisor will see EATS change to 0 and insert a V=0 breaking update into
the STE even though the VM did not ask for that.

In bare metal, EATS_TRANS is ignored by CFG=ABORT/BYPASS, which is why this
does not cause a problem until we have the nested case where CFG is always
a variation of S2 trans that does use EATS_TRANS.

Relax the rules for EATS_TRANS sequencing, we don't need it to be exact as
the enclosing code will always disable ATS at the PCI device when changing
EATS_TRANS. This ensures there are no ATS transactions that can race with
an EATS_TRANS change so we don't need to carefully sequence these bits.

Fixes: 1e8be08d1c91 ("iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 26 +++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 65c0119f45eae..d55b8e39b8e3c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1097,6 +1097,32 @@ VISIBLE_IF_KUNIT
 void arm_smmu_get_ste_update_safe(const __le64 *cur, const __le64 *target,
 				  __le64 *safe_bits)
 {
+	const __le64 eats_s1chk =
+		FIELD_PREP(STRTAB_STE_1_EATS, STRTAB_STE_1_EATS_S1CHK);
+	const __le64 eats_trans =
+		FIELD_PREP(STRTAB_STE_1_EATS, STRTAB_STE_1_EATS_TRANS);
+
+	/*
+	 * When an STE changes EATS_TRANS, the sequencing code in the attach
+	 * logic already will have the PCI cap for ATS disabled. Thus at this
+	 * moment we can expect that the device will not generate ATS queries
+	 * and so we don't care about the sequencing of EATS. The purpose of
+	 * EATS_TRANS is to protect the system from hostile untrusted devices
+	 * that issue ATS when the PCI config space is disabled. However, if
+	 * EATS_TRANS is being changed, then we must have already trusted the
+	 * device as the EATS_TRANS security block is being disabled.
+	 *
+	 *  Note: now the EATS_TRANS update is moved to the first entry_set().
+	 *  Changing S2S and EATS might transiently result in S2S=1 and EATS=1
+	 *  which is a bad STE (see "5.2 Stream Table Entry"). In such a case,
+	 *  we can't do a hitless update. Also, it should not be added to the
+	 *  safe bits with STRTAB_STE_1_EATS_S1CHK, because EATS=0b11 would be
+	 *  effectively an errant 0b00 configuration.
+	 */
+	if (!((cur[1] | target[1]) & cpu_to_le64(eats_s1chk)) &&
+	    !((cur[2] | target[2]) & cpu_to_le64(STRTAB_STE_2_S2S)))
+		safe_bits[1] |= cpu_to_le64(eats_trans);
+
 	/*
 	 * MEV does not meaningfully impact the operation of the HW, it only
 	 * changes how many fault events are generated, thus we can relax it
-- 
2.51.0


