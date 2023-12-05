Return-Path: <stable+bounces-4558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4C28047FE
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103441F21D68
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E488C05;
	Tue,  5 Dec 2023 03:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UNKBRBy9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243796FB0;
	Tue,  5 Dec 2023 03:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96903C433C7;
	Tue,  5 Dec 2023 03:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747879;
	bh=qxXU+0rEJr3ZPjMxJxrmzJRoojAVEUbXoiI3SkVMs1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UNKBRBy9BB7nwh5FRMuLRw1yeHEyqvRWwA3VijZ+kNWlDRE7AWI/c2U54Ti7j8xSK
	 jZzxicyCWhDn29UsLcOS/TgSKSIwaAtcpPBOAozf7pVhIBElrRsfMMcPznzM1j8iTx
	 /BILx7hwxkZndLDDTZN+Gp61c5nK4sEh31QJH+Qs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Murray <andrew.murray@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH 5.4 32/94] arm64: cpufeature: Extract capped perfmon fields
Date: Tue,  5 Dec 2023 12:17:00 +0900
Message-ID: <20231205031524.700657475@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031522.815119918@linuxfoundation.org>
References: <20231205031522.815119918@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Murray <andrew.murray@arm.com>

commit 8e35aa642ee4dab01b16cc4b2df59d1936f3b3c2 upstream.

When emulating ID registers there is often a need to cap the version
bits of a feature such that the guest will not use features that the
host is not aware of. For example, when KVM mediates access to the PMU
by emulating register accesses.

Let's add a helper that extracts a performance monitors ID field and
caps the version to a given value.

Fields that identify the version of the Performance Monitors Extension
do not follow the standard ID scheme, and instead follow the scheme
described in ARM DDI 0487E.a page D13-2825 "Alternative ID scheme used
for the Performance Monitors Extension version". The value 0xF means an
IMPLEMENTATION DEFINED PMU is present, and values 0x0-OxE can be treated
the same as an unsigned field with 0x0 meaning no PMU is present.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
[Mark: rework to handle perfmon fields]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/cpufeature.h |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -449,6 +449,29 @@ cpuid_feature_extract_unsigned_field(u64
 	return cpuid_feature_extract_unsigned_field_width(features, field, 4);
 }
 
+/*
+ * Fields that identify the version of the Performance Monitors Extension do
+ * not follow the standard ID scheme. See ARM DDI 0487E.a page D13-2825,
+ * "Alternative ID scheme used for the Performance Monitors Extension version".
+ */
+static inline u64 __attribute_const__
+cpuid_feature_cap_perfmon_field(u64 features, int field, u64 cap)
+{
+	u64 val = cpuid_feature_extract_unsigned_field(features, field);
+	u64 mask = GENMASK_ULL(field + 3, field);
+
+	/* Treat IMPLEMENTATION DEFINED functionality as unimplemented */
+	if (val == 0xf)
+		val = 0;
+
+	if (val > cap) {
+		features &= ~mask;
+		features |= (cap << field) & mask;
+	}
+
+	return features;
+}
+
 static inline u64 arm64_ftr_mask(const struct arm64_ftr_bits *ftrp)
 {
 	return (u64)GENMASK(ftrp->shift + ftrp->width - 1, ftrp->shift);



