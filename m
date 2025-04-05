Return-Path: <stable+bounces-128363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69472A7C77B
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 05:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D922163ADB
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 03:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF8A42070;
	Sat,  5 Apr 2025 03:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b="iAFiv0oy"
X-Original-To: stable@vger.kernel.org
Received: from s1.g1.infrastructure.qtmlabs.xyz (s1.g1.infrastructure.qtmlabs.xyz [107.172.1.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC027101EE;
	Sat,  5 Apr 2025 03:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.172.1.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743822582; cv=none; b=X49zDEioXbVWYowQ8HMvRfsJqg2F7drh/a6AonAiRrMg32ZP7OrQCHr+w6A+QuiWyvIlIJPh5smsP/o/Md18xcLlZF+/+zBiadeDOGxWSEf/PP3C3LCYmbI0I204G//98jGFwfBMv4TiX2+sGi3xVX+OuQmxQ8pvSYLJTXcSDv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743822582; c=relaxed/simple;
	bh=hujQm0HClXP7xjO2znk9QgTnRzmTHqA4LUOAnZTczgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KrOZeexpJiY/nVLbacCNmIhShcj6/q+g85aeIgU0fbIQfqEPf3d4Fq6hX0CoH+JBXg+Rz4AP6TCyZBftbB5KF8jt6E+1CFlV0httAX2s52q53gvXBMQkcdxZJqI7CUPZwGFzQfya0mj8JPDzz9hxj21qXc6I9feLNcO5B+vfbCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz; spf=pass smtp.mailfrom=qtmlabs.xyz; dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b=iAFiv0oy; arc=none smtp.client-ip=107.172.1.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtmlabs.xyz
From: msizanoen <msizanoen@qtmlabs.xyz>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtmlabs.xyz; s=dkim;
	t=1743822571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rTf9akzD0dNQb/RAitsDp1AU3nLBLkrnu2RP1/sYscY=;
	b=iAFiv0oyfxQUliXn0AizR88bACAQCDhmG0mq5j4RGh4Tt+E2JogHQNidoQ74gMce+nJ+g1
	As/M8IyoByEO4TwTws9COQO9oKQ6uf0PNRI/ECmuK6jEJfoS6G9zNjALImaSsvLLclbRsx
	/GUHxxQB0OhC2A23zGURT0gTwYg2F6mQvik/++4khVDYW4UhAq3rOGefHANyxtdT8FqYJ5
	c9/LHU0h7wbuth7EfQc6Oe37ixp9MqkJQ2NSSe82yjZeGbvJblemqzMKZDequUy4kxVmPz
	eCx39SoxYHTh/j3+EfjN0gbGi3XoU6Lqq5+SmopUbGKWb2H7TjYlAzRwYtefcQ==
Authentication-Results: s1.g1.infrastructure.qtmlabs.xyz;
	auth=pass smtp.mailfrom=msizanoen@qtmlabs.xyz
Date: Sat, 05 Apr 2025 10:09:24 +0700
Subject: [PATCH] x86/e820: Fix handling of subpage regions when calculating
 nosave ranges
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250405-fix-e820-nosave-v1-1-162633199548@qtmlabs.xyz>
X-B4-Tracking: v=1; b=H4sIAOOe8GcC/x2MywqAIBAAfyX23IL5QOtXooPZVnuxUIhA/Pek4
 8DMFMiUmDJMXYFED2e+YoOh7yCcPh6EvDUGKaQRWhjc+UVyUmC8sn8Ig1bWjsYpvxK06k7UlP8
 4L7V+3SveKGEAAAA=
X-Change-ID: 20250405-fix-e820-nosave-c43779583abe
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
 Roberto Ricci <io@r-ricci.it>, msizanoen <msizanoen@qtmlabs.xyz>, 
 stable@vger.kernel.org
X-Spamd-Bar: /

Handle better cases where there might be non-page-aligned RAM e820
regions so we don't end up marking kernel memory as nosave.

This also simplifies the calculation of nosave ranges by treating
non-RAM regions as holes.

Fixes: e5540f875404 ("x86/boot/e820: Consolidate 'struct e820_entry *entry' local variable names")
Tested-by: Roberto Ricci <io@r-ricci.it>
Reported-by: Roberto Ricci <io@r-ricci.it>
Closes: https://lore.kernel.org/all/Z4WFjBVHpndct7br@desktop0a/
Signed-off-by: msizanoen <msizanoen@qtmlabs.xyz>
Cc: stable@vger.kernel.org
---
The issue of the kernel failing to resume from hibernation after
kexec_load() is used is likely due to kexec-tools passing in a different
e820 memory map from the one provided by system firmware, causing the
e820 consistency check to fail. That issue is not addressed in this
patch and will need to be fixed in kexec-tools instead.
---
 arch/x86/kernel/e820.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 57120f0749cc3c23844eeb36820705687e08bbf7..656ed7abd28de180b842a8d7993e9708f9f17026 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -753,22 +753,21 @@ void __init e820__memory_setup_extended(u64 phys_addr, u32 data_len)
 void __init e820__register_nosave_regions(unsigned long limit_pfn)
 {
 	int i;
-	unsigned long pfn = 0;
+	u64 last_addr = 0;
 
 	for (i = 0; i < e820_table->nr_entries; i++) {
 		struct e820_entry *entry = &e820_table->entries[i];
 
-		if (pfn < PFN_UP(entry->addr))
-			register_nosave_region(pfn, PFN_UP(entry->addr));
-
-		pfn = PFN_DOWN(entry->addr + entry->size);
-
 		if (entry->type != E820_TYPE_RAM)
-			register_nosave_region(PFN_UP(entry->addr), pfn);
+			continue;
 
-		if (pfn >= limit_pfn)
-			break;
+		if (last_addr < entry->addr)
+			register_nosave_region(PFN_UP(last_addr), PFN_DOWN(entry->addr));
+
+		last_addr = entry->addr + entry->size;
 	}
+
+	register_nosave_region(PFN_UP(last_addr), limit_pfn);
 }
 
 #ifdef CONFIG_ACPI

---
base-commit: e48e99b6edf41c69c5528aa7ffb2daf3c59ee105
change-id: 20250405-fix-e820-nosave-c43779583abe

Best regards,
-- 
msizanoen <msizanoen@qtmlabs.xyz>


