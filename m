Return-Path: <stable+bounces-221068-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDCFGXdXo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221068-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:00:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA771C8B0B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1B58D315996F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1B1301F06;
	Sat, 28 Feb 2026 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGQ7uQLC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F706301EE9;
	Sat, 28 Feb 2026 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301413; cv=none; b=IeH4PtSej8j+K6ir79493rtc7TYFiwkGOt+kSCpCGLDD1N71Re2UYx9zcAubmGrih9IM4WxMwlmuD/BWuYhO0LN0on7vlpLHQS1sw8fQzKrYt+r/s4ua2fgkljpKyjQhyWrOUVx+AbVgJNw4qo1508OTH5NFzlv7+p/obju8X9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301413; c=relaxed/simple;
	bh=LFso4gGWa0HLTFJsEh6cRF2qUDdp2Q2CBEykfE4/CpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NP7pYKEFjlq8TaJceK586m+PRW5O+ZvWSESKBzXFIdwYMLZbC/4FCytH6eP+hNLtng/SbALjQEqNiZAJlSggUyaBWezhDeEhmqMBOkGsWGFunKLcxHRpvZuhhJd9LXWgSQJS+L2587/F0bxEqAaqVGt15lZy6BhubhMiUWoIvX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGQ7uQLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA19C19423;
	Sat, 28 Feb 2026 17:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301413;
	bh=LFso4gGWa0HLTFJsEh6cRF2qUDdp2Q2CBEykfE4/CpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OGQ7uQLCIl3iOo1ygop+23MMx2GSGnYU9jsALwRTFT93TxCkRjBl2tai+iVrZXZ3C
	 Sc4DghYtTdrDt+OgPIsOettC+sUDGmGb/orQZ/J3pQ+NDUhUcco3vFzmrpTziPf6mk
	 Na7JFe2rRM61DVFQF33/1lFLdbrcDasKABdHBEqiNyrOY3p9LrCeat5W0D9NQIm9xS
	 w4QzOmp7GvimWlGvnKfxWFweUwvtI+pH1+bAP/4mHBJnl4stFYz1seV8BoeVIpyOSD
	 z52X+K3TvC3SAj7SW7Agc//gfiubm4AIbEAWM8FqIbYSkEMPzHed2oQKiy2iUpV8AG
	 wLCXLXM42hpDw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	stable@vger.kernel.org,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Mostafa Saleh <smostafa@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 602/752] iommu/arm-smmu-v3: Mark STE MEV safe when computing the update sequence
Date: Sat, 28 Feb 2026 12:45:13 -0500
Message-ID: <20260228174750.1542406-602-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221068-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 3BA771C8B0B
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
index e7d62acb4b779..bb755c7ef9a79 100644
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


