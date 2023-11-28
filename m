Return-Path: <stable+bounces-2888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 881E37FB9C4
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 12:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98241C2142D
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 11:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F3D4F8A5;
	Tue, 28 Nov 2023 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783D395
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 03:57:39 -0800 (PST)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Sfgnp6tbRzLnd8;
	Tue, 28 Nov 2023 19:53:18 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.179) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 Nov 2023 19:57:36 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<sashal@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<andrew.murray@arm.com>, <mark.rutland@arm.com>, <suzuki.poulose@arm.com>,
	<wanghaibin.wang@huawei.com>, <will@kernel.org>, Zenghui Yu
	<yuzenghui@huawei.com>
Subject: [for-5.4 1/2] arm64: cpufeature: Extract capped perfmon fields
Date: Tue, 28 Nov 2023 19:57:24 +0800
Message-ID: <20231128115725.964-2-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20231128115725.964-1-yuzenghui@huawei.com>
References: <20231128115725.964-1-yuzenghui@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected

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
---
 arch/arm64/include/asm/cpufeature.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index f63438474dd5..587b8a804fc7 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -449,6 +449,29 @@ cpuid_feature_extract_unsigned_field(u64 features, int field)
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
-- 
2.33.0


