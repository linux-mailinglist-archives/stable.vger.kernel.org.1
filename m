Return-Path: <stable+bounces-151850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A28AD0E22
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 17:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20C916DA62
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 15:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574F01362;
	Sat,  7 Jun 2025 15:33:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF8F1D7984
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749310390; cv=none; b=P+P2slcoGKfTa6ieCAv3ounf8O8Lrb+qhX+ykz8oSFHBJM5rlGlXlXETpQKa1qnfQUDwr5sKEKSltdowEFSorw83LsDIxASLKrIGfHRP3bZ29cOGfDqyhKIc1rm3VJO488NwsJXtIQXeybXa0WQDRU8jxOYljKUjIBZJ0yhnMyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749310390; c=relaxed/simple;
	bh=lLHV02PS/kz4paTtw0INZZnf+BTKOwly7m3HmJ/qBOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q37o6ZlJvjzRtN7sVjKi13ixh/UG28ALhWWFP0zteD9mEhgkaqaXn5+61AgXj59cWNmo5krmVe00w/dfGCav1wvP19ZATFHfA1MVINPoJm+3oTvBCEIACCucbxUyauVL1co0JfYZfZNP55JRPQkeNSl8TXWWgEQqa4gqeBA3XVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bF2JM1BZYzYQvc1
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 23:33:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 3330C1A0DC2
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 23:33:06 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgBH5sCwW0Rod05JOg--.5386S6;
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
Subject: [PATCH 5.15 4/9] arm64: proton-pack: Expose whether the platform is mitigated by firmware
Date: Sat,  7 Jun 2025 15:35:30 +0000
Message-Id: <20250607153535.3613861-5-pulehui@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgBH5sCwW0Rod05JOg--.5386S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1DXF4rGF17GFWkWryDJrb_yoW5JF4Upa
	yDCFn7WrWkWFyxXry7Jw4Iyry5C395W3y3GrWUC34YvF1qvryrWrnYg3yvka1vyr4rXayf
	uF12qryFq3WDC37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	x0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUrfOzUUUUU
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
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/arm64/include/asm/spectre.h | 1 +
 arch/arm64/kernel/proton-pack.c  | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/spectre.h b/arch/arm64/include/asm/spectre.h
index 6d7f03adece8..af06d2a4c49c 100644
--- a/arch/arm64/include/asm/spectre.h
+++ b/arch/arm64/include/asm/spectre.h
@@ -97,6 +97,7 @@ enum mitigation_state arm64_get_meltdown_state(void);
 
 enum mitigation_state arm64_get_spectre_bhb_state(void);
 bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry, int scope);
+bool is_spectre_bhb_fw_mitigated(void);
 void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *__unused);
 bool try_emulate_el1_ssbs(struct pt_regs *regs, u32 instr);
 #endif	/* __ASSEMBLY__ */
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index df8188193c17..e79ca2c4841d 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -1088,6 +1088,11 @@ void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 	update_mitigation_state(&spectre_bhb_state, state);
 }
 
+bool is_spectre_bhb_fw_mitigated(void)
+{
+	return test_bit(BHB_FW, &system_bhb_mitigations);
+}
+
 /* Patched to NOP when enabled */
 void noinstr spectre_bhb_patch_loop_mitigation_enable(struct alt_instr *alt,
 						     __le32 *origptr,
-- 
2.34.1


