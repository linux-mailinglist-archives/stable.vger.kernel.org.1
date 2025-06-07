Return-Path: <stable+bounces-151861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B50DAD0E35
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 17:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3FBF16DF7F
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 15:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE441E412A;
	Sat,  7 Jun 2025 15:41:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5C91DE8BF
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749310892; cv=none; b=L0jB7WExw4gfWCKfwNDXo9BYQq2lZQHEO8Pjdm3ze2+wyhytsS/7eQj/3KFcYBK3u6aU2QQL0HTcA07J7fnJGzBcydqWVIrehquE7HESQ09uGrPrccgFg0ts1Zr1bqDZ8vNFX7pug3vSbybDmPQ4i45eCwUAlnUhXQlt/nMwIBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749310892; c=relaxed/simple;
	bh=i5XY+aKamswByk664QjoZXGYW0LxfNpl77CCyHMhuGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KPHrno6NoinafN7GE/IaSdmRgEh7oMaHOUCHKelVn+vIFcV90UXX86qQvD22+ASmw4xx3R/1mOxN3ZC+7qRBa7RxRrVcT1sMJWa2mc63UizCp6PoaJYHcr2o/KTw/POc5WteJfiWRODhdzeRNoWtPQWoZHEDpbxIT4O4JvS6w8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bF24g5TD5zKHNRx
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 23:22:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 21D581A12A4
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 23:22:58 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgB3ycNKWURof5hIOg--.36463S13;
	Sat, 07 Jun 2025 23:22:58 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: stable@vger.kernel.org
Cc: james.morse@arm.com,
	catalin.marinas@arm.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	xukuohai@huawei.com,
	pulehui@huawei.com
Subject: [PATCH 5.10 11/14] arm64: spectre: increase parameters that can be used to turn off bhb mitigation individually
Date: Sat,  7 Jun 2025 15:25:18 +0000
Message-Id: <20250607152521.2828291-12-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250607152521.2828291-1-pulehui@huaweicloud.com>
References: <20250607152521.2828291-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB3ycNKWURof5hIOg--.36463S13
X-Coremail-Antispam: 1UD129KBjvJXoWxur45Kw47JrW5Kr15Xw45Awb_yoW5CFyfpa
	1kCr1Iq34DWF1rXrW7JFn7try5Ca4vvay3J3yqkw18tFnay34Fgrsagwna93Wv9FWrWayr
	WFsIqr4Fk3W8C37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1l_M7UUUUU==
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
 Documentation/admin-guide/kernel-parameters.txt | 5 +++++
 arch/arm64/kernel/proton-pack.c                 | 9 ++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 12af5b0ecc8e..0253b80b06ee 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2954,6 +2954,7 @@
 					       spec_store_bypass_disable=off [X86,PPC]
 					       spectre_v2_user=off [X86]
 					       ssbd=force-off [ARM64]
+					       nospectre_bhb [ARM64]
 					       tsx_async_abort=off [X86]
 
 				Exceptions:
@@ -3367,6 +3368,10 @@
 			vulnerability. System may allow data leaks with this
 			option.
 
+	nospectre_bhb   [ARM64] Disable all mitigations for Spectre-BHB (branch
+			history injection) vulnerability. System may allow data leaks
+			with this option.
+
 	nospec_store_bypass_disable
 			[HW] Disable all mitigations for the Speculative Store Bypass vulnerability
 
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 223527066a4f..7728026d98f7 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -1088,6 +1088,13 @@ static void kvm_setup_bhb_slot(const char *hyp_vecs_start) { }
 #endif /* CONFIG_KVM */
 
 static bool spectre_bhb_fw_mitigated;
+static bool __read_mostly __nospectre_bhb;
+static int __init parse_spectre_bhb_param(char *str)
+{
+	__nospectre_bhb = true;
+	return 0;
+}
+early_param("nospectre_bhb", parse_spectre_bhb_param);
 
 void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 {
@@ -1100,7 +1107,7 @@ void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
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


