Return-Path: <stable+bounces-66200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1818594CE70
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3FA282846
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C159191F65;
	Fri,  9 Aug 2024 10:17:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C756D18C926
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723198669; cv=none; b=GDMGXvtUylvZb3q3z3X5aOhtd6dgqgxmj8RP5fhE3LRHI1hJaJ8KHXS5o09cdp6m7FKET5IxV0/OoP/jcnH17N3oggPhC/8wtabT9BlyYYffJ7KdzJBU6Z92+AOyi9cybIB4BN0UAX0kE8ZgG7R+GaFiskwjL7lO6ia/hJ+k/84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723198669; c=relaxed/simple;
	bh=QFc0WLGEnFlxQnGemNxYiHA2rgzOWYtoU6Ui4Dv8RNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ikMR/52LjWP8TfQm+N3H53c0pzM1xmAdBhAIzxvfuh6orBGKsgnEdrYUwSQQZsP5xv2AbbtenHoXB1do1B8PFbRtWKZ+ytcsMW0p4AWUZ7MpfCIee/VO9Odw02G05hySc8/3j9eelecaUzoV81UxAje8DwNhNNXtwZyQ1Zbe+zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6DF91691;
	Fri,  9 Aug 2024 03:18:12 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EBA2F3F766;
	Fri,  9 Aug 2024 03:17:45 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	bwicaksono@nvidia.com,
	catalin.marinas@arm.com,
	james.clark@arm.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	suzuki.poulose@arm.com,
	will@kernel.org
Subject: [PATCH 5.10.y 01/13] arm64: cpufeature: Force HWCAP to be based on the sysreg visible to user-space
Date: Fri,  9 Aug 2024 11:17:27 +0100
Message-Id: <20240809101739.3477931-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240809101739.3477931-1-mark.rutland@arm.com>
References: <20240809101739.3477931-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Morse <james.morse@arm.com>

[ Upstream commit 237405ebef580a7352a52129b2465c117145eafa ]

arm64 advertises hardware features to user-space via HWCAPs, and by
emulating access to the CPUs id registers. The cpufeature code has a
sanitised system-wide view of an id register, and a sanitised user-space
view of an id register, where some features use their 'safe' value
instead of the hardware value.

It is currently possible for a HWCAP to be advertised where the user-space
view of the id register does not show the feature as supported.
Erratum workaround need to remove both the HWCAP, and the feature from
the user-space view of the id register. This involves duplicating the
code, and spreading it over cpufeature.c and cpu_errata.c.

Make the HWCAP code use the user-space view of id registers. This ensures
the values never diverge, and allows erratum workaround to remove HWCAP
by modifying the user-space view of the id register.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20220909165938.3931307-2-james.morse@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[ Mark: fixup lack of 'width' parameter ]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 36 +++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 1f0a2deafd643..11a42fcf94bfc 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1196,17 +1196,39 @@ feature_matches(u64 reg, const struct arm64_cpu_capabilities *entry)
 	return val >= entry->min_field_value;
 }
 
-static bool
-has_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
+static u64
+read_scoped_sysreg(const struct arm64_cpu_capabilities *entry, int scope)
 {
-	u64 val;
-
 	WARN_ON(scope == SCOPE_LOCAL_CPU && preemptible());
 	if (scope == SCOPE_SYSTEM)
-		val = read_sanitised_ftr_reg(entry->sys_reg);
+		return read_sanitised_ftr_reg(entry->sys_reg);
 	else
-		val = __read_sysreg_by_encoding(entry->sys_reg);
+		return __read_sysreg_by_encoding(entry->sys_reg);
+}
+
+static bool
+has_user_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	int mask;
+	struct arm64_ftr_reg *regp;
+	u64 val = read_scoped_sysreg(entry, scope);
+
+	regp = get_arm64_ftr_reg(entry->sys_reg);
+	if (!regp)
+		return false;
+
+	mask = cpuid_feature_extract_unsigned_field(regp->user_mask,
+						    entry->field_pos);
+	if (!mask)
+		return false;
+
+	return feature_matches(val, entry);
+}
 
+static bool
+has_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	u64 val = read_scoped_sysreg(entry, scope);
 	return feature_matches(val, entry);
 }
 
@@ -2172,7 +2194,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 };
 
 #define HWCAP_CPUID_MATCH(reg, field, s, min_value)				\
-		.matches = has_cpuid_feature,					\
+		.matches = has_user_cpuid_feature,				\
 		.sys_reg = reg,							\
 		.field_pos = field,						\
 		.sign = s,							\
-- 
2.30.2


