Return-Path: <stable+bounces-121143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 057F1A54169
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 04:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7E93ABEBC
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 03:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52501991B2;
	Thu,  6 Mar 2025 03:53:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395BF194147;
	Thu,  6 Mar 2025 03:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741233207; cv=none; b=PNK17TnHXgvrmn2ge+zfujysAB0Hkvd+i+BrEXk67lk5wBSRsd6nGH8v3hokthib+9knU/lPkhFdlD+lm1jdYoxfE5cwRj/6qD0qK6P/+u2OTV4C3meRHkUMIVNq1nxC/f/rEbn1q6g5mx7J+e6bysT2KJ485VowiQ1s42qh5e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741233207; c=relaxed/simple;
	bh=7cn86iQZzeSzLx4TZ+B2VFpB0fRGSWzetk4yGmo+dMM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sD+XXemd7mPgsY7iLRnnZ3k97PeDpWy1FKVtpVj/dXpAOXwb9u7Qbpse5ov/bDAxRiVqYV8f+qSM5J8S/TSIRfsZOB1WTwvcOaozlI2c3dKWkKBAKVwks1rwKd3VI5gO2S+YcH0mJABYi6X5uHyG0FqeEWFZs7rKMRujntks7Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxOGoxHMlntd2LAA--.43319S3;
	Thu, 06 Mar 2025 11:53:21 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMDxH+UwHMln48U4AA--.15034S2;
	Thu, 06 Mar 2025 11:53:20 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] LoongArch: mm: Set max_pfn with the PFN of the last page
Date: Thu,  6 Mar 2025 11:53:14 +0800
Message-Id: <20250306035314.2131976-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxH+UwHMln48U4AA--.15034S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

The current max_pfn equals to zero. In this case, it caused users cannot
get some page information through /proc such as kpagecount. The following
message is displayed by stress-ng test suite with the command
"stress-ng --verbose --physpage 1 -t 1".

 # stress-ng --verbose --physpage 1 -t 1
 stress-ng: error: [1691] physpage: cannot read page count for address 0x134ac000 in /proc/kpagecount, errno=22 (Invalid argument)
 stress-ng: error: [1691] physpage: cannot read page count for address 0x7ffff207c3a8 in /proc/kpagecount, errno=22 (Invalid argument)
 stress-ng: error: [1691] physpage: cannot read page count for address 0x134b0000 in /proc/kpagecount, errno=22 (Invalid argument)
 ...

After applying this patch, the kernel can pass the test.
 # stress-ng --verbose --physpage 1 -t 1
 stress-ng: debug: [1701] physpage: [1701] started (instance 0 on CPU 3)
 stress-ng: debug: [1701] physpage: [1701] exited (instance 0 on CPU 3)
 stress-ng: debug: [1700] physpage: [1701] terminated (success)

Cc: stable@vger.kernel.org
Fixes: ff6c3d81f2e8 ("NUMA: optimize detection of memory with no node id assigned by firmware")

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kernel/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index edcfdfcad7d2..a9c1184ab893 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -390,6 +390,7 @@ static void __init arch_mem_init(char **cmdline_p)
 	if (usermem)
 		pr_info("User-defined physical RAM map overwrite\n");
 
+	max_low_pfn = max_pfn = PHYS_PFN(memblock_end_of_DRAM());
 	check_kernel_sections_mem();
 
 	/*

base-commit: 848e076317446f9c663771ddec142d7c2eb4cb43
-- 
2.39.3


