Return-Path: <stable+bounces-151846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC981AD0E13
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 17:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E133AF696
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 15:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A13F1CEACB;
	Sat,  7 Jun 2025 15:23:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5335E1DED4C
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 15:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749309790; cv=none; b=T0ZV7xo47rt9vPuA00nqvLxSLcyRZiw6VQotfc2b+t/2OR3Q5e4pAY7xZcWeTn3WfbZFOlgyJlA+feGE+hfgZ1U/CUQMBaeZkgHZxVIUSolRAwc2Ap/DBDlQjW5GRzNjDOEK5OzblzyYJ+JP3wTLmflUdkpYAhqAQ7qbvL7I6u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749309790; c=relaxed/simple;
	bh=QO2pQxkxIBQhSyS0tjBI/OKdpY8v+IEK37lK7p4bdq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGleGkNsgXZFy07Vfp8PWrp9/xzFSPOC9kOjCYBRvz4IpTfZNZSaN15eHtboHj2BVHpKZlb25/dziijsKUvcYwWUxvnC4jqsqqBx2pQ82vWKk3KewqlbjtMwdRFknOO2kb3KuTe3gltnOq6nPo0at7x2imtCbs+w7XGKQvJ5jMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bF24f73J9zYQvTh
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 23:22:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 077181A0ECC
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 23:22:58 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgB3ycNKWURof5hIOg--.36463S11;
	Sat, 07 Jun 2025 23:22:57 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: stable@vger.kernel.org
Cc: james.morse@arm.com,
	catalin.marinas@arm.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	xukuohai@huawei.com,
	pulehui@huawei.com
Subject: [PATCH 5.10 09/14] arm64: errata: Add missing sentinels to Spectre-BHB MIDR arrays
Date: Sat,  7 Jun 2025 15:25:16 +0000
Message-Id: <20250607152521.2828291-10-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250607152521.2828291-1-pulehui@huaweicloud.com>
References: <20250607152521.2828291-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB3ycNKWURof5hIOg--.36463S11
X-Coremail-Antispam: 1UD129KBjvJXoWxury5tr18XF13Ary5AF4ruFg_yoW5Cr4DpF
	45GrnFkr48WF17A3yDJF1q9Fyrua98XF4fCrWDCwnI9r90qFyrtr4qq3yv9rsFgryrW340
	kF4qgr18t3WkA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1l_M7UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Will Deacon <will@kernel.org>

[ Upstream commit fee4d171451c1ad9e8aaf65fc0ab7d143a33bd72 ]

Commit a5951389e58d ("arm64: errata: Add newer ARM cores to the
spectre_bhb_loop_affected() lists") added some additional CPUs to the
Spectre-BHB workaround, including some new arrays for designs that
require new 'k' values for the workaround to be effective.

Unfortunately, the new arrays omitted the sentinel entry and so
is_midr_in_range_list() will walk off the end when it doesn't find a
match. With UBSAN enabled, this leads to a crash during boot when
is_midr_in_range_list() is inlined (which was more common prior to
c8c2647e69be ("arm64: Make  _midr_in_range_list() an exported
function")):

 |  Internal error: aarch64 BRK: 00000000f2000001 [#1] PREEMPT SMP
 |  pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 |  pc : spectre_bhb_loop_affected+0x28/0x30
 |  lr : is_spectre_bhb_affected+0x170/0x190
 | [...]
 |  Call trace:
 |   spectre_bhb_loop_affected+0x28/0x30
 |   update_cpu_capabilities+0xc0/0x184
 |   init_cpu_features+0x188/0x1a4
 |   cpuinfo_store_boot_cpu+0x4c/0x60
 |   smp_prepare_boot_cpu+0x38/0x54
 |   start_kernel+0x8c/0x478
 |   __primary_switched+0xc8/0xd4
 |  Code: 6b09011f 54000061 52801080 d65f03c0 (d4200020)
 |  ---[ end trace 0000000000000000 ]---
 |  Kernel panic - not syncing: aarch64 BRK: Fatal exception

Add the missing sentinel entries.

Cc: Lee Jones <lee@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: <stable@vger.kernel.org>
Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Fixes: a5951389e58d ("arm64: errata: Add newer ARM cores to the spectre_bhb_loop_affected() lists")
Signed-off-by: Will Deacon <will@kernel.org>
Reviewed-by: Lee Jones <lee@kernel.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20250501104747.28431-1-will@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/arm64/kernel/proton-pack.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 68a75afba0c4..1e1615442bb2 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -887,10 +887,12 @@ static u8 spectre_bhb_loop_affected(void)
 	static const struct midr_range spectre_bhb_k132_list[] = {
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_X3),
 		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
+		{},
 	};
 	static const struct midr_range spectre_bhb_k38_list[] = {
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A715),
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A720),
+		{},
 	};
 	static const struct midr_range spectre_bhb_k32_list[] = {
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A78),
-- 
2.34.1


