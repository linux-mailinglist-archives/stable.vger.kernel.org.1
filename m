Return-Path: <stable+bounces-151853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9E4AD0E25
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 17:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985A4188FA5A
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 15:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52731E231D;
	Sat,  7 Jun 2025 15:33:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139121DEFF3
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749310390; cv=none; b=IpfpzWQohZqvX/SRJ7R1LLN1/JVRFhlPq0KbkrQPs7vyHLcu8137gSCm2H/8L71IkwWpp3opE9BnTVtdR5qZhC4bxAWZNgoAnx+OVQdIZqTxkcQBMcSZqF83LtBMaYSd2Iww7Cra5FNRJjIFagubfqoE1ZGDDVBzgtH93bfiDJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749310390; c=relaxed/simple;
	bh=jaaTC6xa4EFcY7wyZvoflsyeg6Ag8fesamd4ZEayTFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D3P5wpbnqmkuYr9/alsVEnU7y8KF8bgDdC60PjbJ+ILZwxCxP5XmI2rc1WKEwBan6Lm96Xtcnjl3yppwP7SLi4c7hwRZDSfOqlRxJeOTllUR+NDjIUww2JKH/XRKIokWJsFldM9Ez5+jH3BedJr915nU0MCfPyFqqtGKSxpf/+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bF2JM2BMFzYQvc1
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 23:33:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 541AC1A0E24
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 23:33:06 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgBH5sCwW0Rod05JOg--.5386S8;
	Sat, 07 Jun 2025 23:33:06 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: stable@vger.kernel.org
Cc: james.morse@arm.com,
	catalin.marinas@arm.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	xukuohai@huawei.com,
	pulehui@huawei.com
Subject: [PATCH 5.15 6/9] arm64: spectre: increase parameters that can be used to turn off bhb mitigation individually
Date: Sat,  7 Jun 2025 15:35:32 +0000
Message-Id: <20250607153535.3613861-7-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250607153535.3613861-1-pulehui@huaweicloud.com>
References: <20250607153535.3613861-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBH5sCwW0Rod05JOg--.5386S8
X-Coremail-Antispam: 1UD129KBjvJXoWxur45Kw47JrW5Kry8Xr43Jrb_yoW5CrWkpa
	1kGr1Sq34DWF15XrW7Jrs7t345C3s7Xay3G3yqkw1rtFnIy3sYgrnagwnagF1v9rWrXayU
	ZFsIqr4Fk3W8A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUrfOzUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Liu Song <liusong@linux.alibaba.com>

[ Upstream commit 877ace9eab7de032f954533afd5d1ecd0cf62eaf ]

In our environment, it was found that the mitigation BHB has a great
impact on the benchmark performance. For example, in the lmbench test,
the "process fork && exit" test performance drops by 20%.
So it is necessary to have the ability to turn off the mitigation
individually through cmdline, thus avoiding having to compile the
kernel by adjusting the config.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/1661514050-22263-1-git-send-email-liusong@linux.alibaba.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 arch/arm64/kernel/proton-pack.c                 | 10 +++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e0670357d23f..d40b57f3d1e1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3105,6 +3105,7 @@
 					       spectre_bhi=off [X86]
 					       spectre_v2_user=off [X86]
 					       ssbd=force-off [ARM64]
+					       nospectre_bhb [ARM64]
 					       tsx_async_abort=off [X86]
 
 				Exceptions:
@@ -3526,6 +3527,10 @@
 			vulnerability. System may allow data leaks with this
 			option.
 
+	nospectre_bhb	[ARM64] Disable all mitigations for Spectre-BHB (branch
+			history injection) vulnerability. System may allow data leaks
+			with this option.
+
 	nospec_store_bypass_disable
 			[HW] Disable all mitigations for the Speculative Store Bypass vulnerability
 
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 71a6d3dd393a..9cc14f6de63e 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -1023,6 +1023,14 @@ static void this_cpu_set_vectors(enum arm64_bp_harden_el1_vectors slot)
 	isb();
 }
 
+static bool __read_mostly __nospectre_bhb;
+static int __init parse_spectre_bhb_param(char *str)
+{
+	__nospectre_bhb = true;
+	return 0;
+}
+early_param("nospectre_bhb", parse_spectre_bhb_param);
+
 void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 {
 	bp_hardening_cb_t cpu_cb;
@@ -1036,7 +1044,7 @@ void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 		/* No point mitigating Spectre-BHB alone. */
 	} else if (!IS_ENABLED(CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY)) {
 		pr_info_once("spectre-bhb mitigation disabled by compile time option\n");
-	} else if (cpu_mitigations_off()) {
+	} else if (cpu_mitigations_off() || __nospectre_bhb) {
 		pr_info_once("spectre-bhb mitigation disabled by command line option\n");
 	} else if (supports_ecbhb(SCOPE_LOCAL_CPU)) {
 		state = SPECTRE_MITIGATED;
-- 
2.34.1


