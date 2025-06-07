Return-Path: <stable+bounces-151842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A21AD0E0F
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 17:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD5E188D43B
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 15:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0C11DF244;
	Sat,  7 Jun 2025 15:23:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F181DC997
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 15:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749309788; cv=none; b=EPpDnkjhoWZFXo3On0RJcNnO3wS7qOpzLphtjDidwf2Xfo1Nrlp/Z1WVX158w2L8y6zjLtfxf5BZE/59Th3HOdHH06JwsrpdTo9IRZfTHKuO+vAsQHaNVZfRdflJfdid+XNHqNVDnw0YJNJGsE7qReFB1UPmDleaMTD8MQb5JZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749309788; c=relaxed/simple;
	bh=Ifji5DrtqPTaqZ+bYSU9QHnPNq06BHrUNPEzRuN/giI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=toh3QgaLuCqXAsQBVg4PqP/FeHONROqi9RAi2xRQ6qKyImEYcdRWrq9eIWVZ0pYBxq0haP5JZDHMden1vuWKsSV7dI7XkIu+Zky/GTk3JCIbSfNwRpTETqvWTbMI+nedpyMo0WdkLeiKk7i6RqFDKv9EbuSTDH2ogYbFry2rlcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bF24c5SbDzYQvPT
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 23:22:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C5BDE1A0AD6
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 23:22:55 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgB3ycNKWURof5hIOg--.36463S7;
	Sat, 07 Jun 2025 23:22:55 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: stable@vger.kernel.org
Cc: james.morse@arm.com,
	catalin.marinas@arm.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	xukuohai@huawei.com,
	pulehui@huawei.com
Subject: [PATCH 5.10 05/14] arm64: proton-pack: Expose whether the platform is mitigated by firmware
Date: Sat,  7 Jun 2025 15:25:12 +0000
Message-Id: <20250607152521.2828291-6-pulehui@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgB3ycNKWURof5hIOg--.36463S7
X-Coremail-Antispam: 1UD129KBjvJXoWxGryftF1rXryfZF1UWw4kWFg_yoW5Cw1xpa
	yDCFn7WrWkWFyxZry7Jwn2yry5C3ykW3y3JrWUCw1YvF1qkryrWrn8K34vka1vvr4rWayf
	uF12vryFqa1DA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwuWlUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: James Morse <james.morse@arm.com>

[ Upstream commit e7956c92f396a44eeeb6eaf7a5b5e1ad24db6748 ]

is_spectre_bhb_fw_affected() allows the caller to determine if the CPU
is known to need a firmware mitigation. CPUs are either on the list
of CPUs we know about, or firmware has been queried and reported that
the platform is affected - and mitigated by firmware.

This helper is not useful to determine if the platform is mitigated
by firmware. A CPU could be on the know list, but the firmware may
not be implemented. Its affected but not mitigated.

spectre_bhb_enable_mitigation() handles this distinction by checking
the firmware state before enabling the mitigation.

Add a helper to expose this state. This will be used by the BPF JIT
to determine if calling firmware for a mitigation is necessary and
supported.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Conflicts:
	arch/arm64/kernel/proton-pack.c
[The conflicts were due to not include bitmap of mitigations]
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/arm64/include/asm/spectre.h | 1 +
 arch/arm64/kernel/proton-pack.c  | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm64/include/asm/spectre.h b/arch/arm64/include/asm/spectre.h
index e48afcb69392..9c8ed2c4629d 100644
--- a/arch/arm64/include/asm/spectre.h
+++ b/arch/arm64/include/asm/spectre.h
@@ -32,6 +32,7 @@ void spectre_v4_enable_task_mitigation(struct task_struct *tsk);
 
 enum mitigation_state arm64_get_spectre_bhb_state(void);
 bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry, int scope);
+bool is_spectre_bhb_fw_mitigated(void);
 u8 spectre_bhb_loop_affected(int scope);
 void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *__unused);
 bool try_emulate_el1_ssbs(struct pt_regs *regs, u32 instr);
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 45fdfe70b69f..95b8d76670c8 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -1059,6 +1059,8 @@ static void kvm_setup_bhb_slot(const char *hyp_vecs_start)
 static void kvm_setup_bhb_slot(const char *hyp_vecs_start) { }
 #endif /* CONFIG_KVM */
 
+static bool spectre_bhb_fw_mitigated;
+
 void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 {
 	enum mitigation_state fw_state, state = SPECTRE_VULNERABLE;
@@ -1103,12 +1105,18 @@ void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 			this_cpu_set_vectors(EL1_VECTOR_BHB_FW);
 
 			state = SPECTRE_MITIGATED;
+			spectre_bhb_fw_mitigated = true;
 		}
 	}
 
 	update_mitigation_state(&spectre_bhb_state, state);
 }
 
+bool is_spectre_bhb_fw_mitigated(void)
+{
+	return spectre_bhb_fw_mitigated;
+}
+
 /* Patched to correct the immediate */
 void noinstr spectre_bhb_patch_loop_iter(struct alt_instr *alt,
 				   __le32 *origptr, __le32 *updptr, int nr_inst)
-- 
2.34.1


