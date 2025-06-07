Return-Path: <stable+bounces-151852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3494AD0E24
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 17:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566DE16DB85
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 15:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFCB1E8335;
	Sat,  7 Jun 2025 15:33:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9798E1DF97D
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749310390; cv=none; b=d/JgQtbzcaoWUyE+C5nnQEdvsM9w3eo9fZJHDYpizQBb1fv0Cv2ntz9Q7toQ5GqRK7zbSO8O+KbvNpManuHsV/1tANmAv1lB5g93Z4tMHEXycfvhwgzz4NCy+gdH5RsoUOb8ZteJvHX6eGLbgqFqVRBAj2oQTHantJJGt/ydH/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749310390; c=relaxed/simple;
	bh=2ZKIR4yNrsuH3QDOfK86hX9Txy9XO+u5brU4Rv7MCFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N2xCBE9XxRInb58w0WzaHJI1Ut6caKmNfnYeMBSwycrSXXCHJI8h6zb+wSCV1hycsx0v2eo+DZ2HRHYHIE0dYNfcOnItbxsXzfggjQ+ngwkhcrpa7SDdXKgWl1jNcgq3lQg1vBgKka4OGGsSjdstPhq4L9zvnsFOk+FRhgQC4Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bF2JN0WjdzKHN5K
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 23:33:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 6DACE1A117F
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 23:33:06 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgBH5sCwW0Rod05JOg--.5386S10;
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
Subject: [PATCH 5.15 8/9] arm64: bpf: Only mitigate cBPF programs loaded by unprivileged users
Date: Sat,  7 Jun 2025 15:35:34 +0000
Message-Id: <20250607153535.3613861-9-pulehui@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgBH5sCwW0Rod05JOg--.5386S10
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1fZw45Aw1rWr4fArW5Wrg_yoW8JF4kpw
	1UCwn3C3yDWF1kCF4UX3ySvr4Y9w4ktr4xury093yFvF4qqryfuryfKw4Yka95ArWrXF1r
	ZFZ0kr1S93WkX3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUoo7KUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: James Morse <james.morse@arm.com>

[ Upstream commit f300769ead032513a68e4a02e806393402e626f8 ]

Support for eBPF programs loaded by unprivileged users is typically
disabled. This means only cBPF programs need to be mitigated for BHB.

In addition, only mitigate cBPF programs that were loaded by an
unprivileged user. Privileged users can also load the same program
via eBPF, making the mitigation pointless.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/arm64/net/bpf_jit_comp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 2691e53007eb..654e7ed2d1a6 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -341,6 +341,9 @@ static void __maybe_unused build_bhb_mitigation(struct jit_ctx *ctx)
 	    arm64_get_spectre_v2_state() == SPECTRE_VULNERABLE)
 		return;
 
+	if (capable(CAP_SYS_ADMIN))
+		return;
+
 	if (supports_clearbhb(SCOPE_SYSTEM)) {
 		emit(aarch64_insn_gen_hint(AARCH64_INSN_HINT_CLEARBHB), ctx);
 		return;
-- 
2.34.1


