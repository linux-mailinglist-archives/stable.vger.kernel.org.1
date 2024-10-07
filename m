Return-Path: <stable+bounces-81211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D735A9923E0
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 07:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911222825D0
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 05:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0A973501;
	Mon,  7 Oct 2024 05:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EkcWkra3"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39F94C91;
	Mon,  7 Oct 2024 05:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728278732; cv=none; b=fRvSkgQgr6eK1I+gmbvIy2eUiEWU0RVS3rL8whZ7jFa2yZZCzF9A5qXVi+KuMQHoB5vqwLvSQuKQV5b7PuDvogqvzQ/erWAaqNL6KF0gHQpKdNPGAO98KMKZMA9BYE0Ai6SRM5BZLf67en51sKVYa2pxe1vap85Miki+cVhhOr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728278732; c=relaxed/simple;
	bh=HGWJxwIRNXsyN17Qpv93j15/elFdg1kKrAGTqGqbi0c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=br00+Vis7e0vYjUyIYPRT5UZzQrzUvRfLBazkNd8mMb2PqwsWjZF8iTLuM/EYzyzeHDlxHHZ3UTzGBlWg0TFPjWZJIrrzdmcUUBXWlNCEDAPohBYq7J2y9X3ke+n7hOvRslndZ5Ll9zZLryzckAHMOFyWcdbk0klz0QOSkefofM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EkcWkra3; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=324PJEeBYpJfWCK8xWbXB9A56qDSOD1jxIROj5ssz1g=;
	b=EkcWkra3uZT2kbTGpHZYgb7udCwytAwrTEGLutzPRkZseEfRYKfbZQLg8ZU1tk
	MeDPNHt1Hd8wjLQgHtEI22zJHaTWChvSByJ8W2l2+M2zC2ND/C440wemjEhFjjHU
	FRI3qkCyHan9TCOK8lH3pge4yGy38GAC1Bb2uKNkDMU0c=
Received: from localhost (unknown [39.144.4.86])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBnN4NccANnI_KQBQ--.20392S3;
	Mon, 07 Oct 2024 13:23:41 +0800 (CST)
Date: Mon, 7 Oct 2024 13:23:40 +0800
From: Melon Liu <melon1335@163.com>
To: linux@armlinux.org.uk, lecopzer.chen@mediatek.com,
	linus.walleij@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] ARM/mm: Fix stack recursion caused by KASAN
Message-ID: <ZwNwXF2MqPpHvzqW@liu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-CM-TRANSID:_____wBnN4NccANnI_KQBQ--.20392S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw4xWFy5XFWDGr1xGF18uFg_yoW8uF1xpF
	43Ca4rArsxXr1akrW3Xa18uF95t3WkK3WUt392gayrWrWUKr1UJF40qFWfu34UWrW8AFWa
	yFWSya45urn7t3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joHq7UUUUU=
X-CM-SenderInfo: ppho00irttkqqrwthudrp/xtbBhQlxIWcDZn9sZQAAso

When accessing the KASAN shadow area corresponding to the task stack
which is in vmalloc space, the stack recursion would occur if the area`s
page tables are unpopulated.

Calltrace:
 ...
 __dabt_svc+0x4c/0x80
 __asan_load4+0x30/0x88
 do_translation_fault+0x2c/0x110
 do_DataAbort+0x4c/0xec
 __dabt_svc+0x4c/0x80
 __asan_load4+0x30/0x88
 do_translation_fault+0x2c/0x110
 do_DataAbort+0x4c/0xec
 __dabt_svc+0x4c/0x80
 sched_setscheduler_nocheck+0x60/0x158
 kthread+0xec/0x198
 ret_from_fork+0x14/0x28

Fixes: 565cbaad83d ("ARM: 9202/1: kasan: support CONFIG_KASAN_VMALLOC")
Cc: <stable@vger.kernel.org>
Signed-off-by: Melon Liu <melon1335@163.org>
---
 arch/arm/mm/ioremap.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 794cfea9f..f952b0b0f 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -115,16 +115,31 @@ int ioremap_page(unsigned long virt, unsigned long phys,
 }
 EXPORT_SYMBOL(ioremap_page);
 
+static inline void sync_pgds(struct mm_struct *mm, unsigned long start,
+			     unsigned long end)
+{
+	end = ALIGN(end, PGDIR_SIZE);
+	memcpy(pgd_offset(mm, start), pgd_offset_k(start),
+	       sizeof(pgd_t) * (pgd_index(end) - pgd_index(start)));
+}
+
+static inline void sync_vmalloc_pgds(struct mm_struct *mm)
+{
+	sync_pgds(mm, VMALLOC_START, VMALLOC_END);
+	if (IS_ENABLED(CONFIG_KASAN_VMALLOC))
+		sync_pgds(mm, (unsigned long)kasan_mem_to_shadow(
+					(void *)VMALLOC_START),
+			      (unsigned long)kasan_mem_to_shadow(
+					(void *)VMALLOC_END));
+}
+
 void __check_vmalloc_seq(struct mm_struct *mm)
 {
 	int seq;
 
 	do {
 		seq = atomic_read(&init_mm.context.vmalloc_seq);
-		memcpy(pgd_offset(mm, VMALLOC_START),
-		       pgd_offset_k(VMALLOC_START),
-		       sizeof(pgd_t) * (pgd_index(VMALLOC_END) -
-					pgd_index(VMALLOC_START)));
+		sync_vmalloc_pgds(mm);
 		/*
 		 * Use a store-release so that other CPUs that observe the
 		 * counter's new value are guaranteed to see the results of the
-- 
2.43.0


