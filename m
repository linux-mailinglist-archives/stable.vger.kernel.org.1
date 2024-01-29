Return-Path: <stable+bounces-16435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4881840C6E
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EFFA2886CC
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 16:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8F215703C;
	Mon, 29 Jan 2024 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="icvkgXls"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C946B157036
	for <stable@vger.kernel.org>; Mon, 29 Jan 2024 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547193; cv=none; b=UA2Lu2ZR7isnrS1BwOYs7Cm3voTdEUpKvzZSMkRPIfL7bGeYaeYxXhz7P3kJLU2rUp7Gey9ozhYW31wuTWPgxWao0dfnpPzNmt3NP8aWvBo6Ngv/MjHKKoiZSQ6ftejINfCZskiwPaFunvnxPs6e6CRz5WbDxDU5GFxxxatlrqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547193; c=relaxed/simple;
	bh=9yQcuc3nPLx99G52diMC7k8lLfduJbaGVOWnrjJuc7M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oYddZS7z9dWRzbXPqvngTSVhxP/J1XBzs996/jxNVTekd2CkXCvdmxWqg1eA61HU/XKCjEyEkvE/AbRScUV95G97X71C5xwjvpk/+3ILVqxNdFsI5ijHdjNssf4NB287NGGvoL4blVm5xXbChp/8EPYqBJ06313rbJ0FabXDLyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=icvkgXls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42545C43394;
	Mon, 29 Jan 2024 16:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706547193;
	bh=9yQcuc3nPLx99G52diMC7k8lLfduJbaGVOWnrjJuc7M=;
	h=Subject:To:Cc:From:Date:From;
	b=icvkgXlsK+8UG7DzOgJM1ajORfXXJOSva6GhOJfILVstp4m+qFD5IEkQoVbiKB9Ju
	 fZkw1DUs3durxajELB27Du95k9DscBMWHkjW6dgPvOpot54WuLFx0uSYoTIVWiWxE9
	 jnQla9+4s6D8onq08Q81dHg4/LISAx8FBjBLnBAo=
Subject: FAILED: patch "[PATCH] LoongArch/smp: Call rcutree_report_cpu_starting() at" failed to apply to 6.6-stable tree
To: chenhuacai@kernel.org,chenhuacai@loongson.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jan 2024 08:53:12 -0800
Message-ID: <2024012912-yahoo-patchwork-d338@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 5056c596c3d1848021a4eaa76ee42f4c05c50346
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012912-yahoo-patchwork-d338@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

5056c596c3d1 ("LoongArch/smp: Call rcutree_report_cpu_starting() at tlb_init()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5056c596c3d1848021a4eaa76ee42f4c05c50346 Mon Sep 17 00:00:00 2001
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 26 Jan 2024 16:22:07 +0800
Subject: [PATCH] LoongArch/smp: Call rcutree_report_cpu_starting() at
 tlb_init()

Machines which have more than 8 nodes fail to boot SMP after commit
a2ccf46333d7b2cf96 ("LoongArch/smp: Call rcutree_report_cpu_starting()
earlier"). Because such machines use tlb-based per-cpu base address
rather than dmw-based per-cpu base address, resulting per-cpu variables
can only be accessed after tlb_init(). But rcutree_report_cpu_starting()
is now called before tlb_init() and accesses per-cpu variables indeed.

Since the original patch want to avoid the lockdep warning caused by
page allocation in tlb_init(), we can move rcutree_report_cpu_starting()
to tlb_init() where after tlb exception configuration but before page
allocation.

Fixes: a2ccf46333d7b2cf96 ("LoongArch/smp: Call rcutree_report_cpu_starting() earlier")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index a16e3dbe9f09..2b49d30eb7c0 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -509,7 +509,6 @@ asmlinkage void start_secondary(void)
 	sync_counter();
 	cpu = raw_smp_processor_id();
 	set_my_cpu_offset(per_cpu_offset(cpu));
-	rcutree_report_cpu_starting(cpu);
 
 	cpu_probe();
 	constant_clockevent_init();
diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
index 2c0a411f23aa..0b95d32b30c9 100644
--- a/arch/loongarch/mm/tlb.c
+++ b/arch/loongarch/mm/tlb.c
@@ -284,12 +284,16 @@ static void setup_tlb_handler(int cpu)
 		set_handler(EXCCODE_TLBNR * VECSIZE, handle_tlb_protect, VECSIZE);
 		set_handler(EXCCODE_TLBNX * VECSIZE, handle_tlb_protect, VECSIZE);
 		set_handler(EXCCODE_TLBPE * VECSIZE, handle_tlb_protect, VECSIZE);
-	}
+	} else {
+		int vec_sz __maybe_unused;
+		void *addr __maybe_unused;
+		struct page *page __maybe_unused;
+
+		/* Avoid lockdep warning */
+		rcutree_report_cpu_starting(cpu);
+
 #ifdef CONFIG_NUMA
-	else {
-		void *addr;
-		struct page *page;
-		const int vec_sz = sizeof(exception_handlers);
+		vec_sz = sizeof(exception_handlers);
 
 		if (pcpu_handlers[cpu])
 			return;
@@ -305,8 +309,8 @@ static void setup_tlb_handler(int cpu)
 		csr_write64(pcpu_handlers[cpu], LOONGARCH_CSR_EENTRY);
 		csr_write64(pcpu_handlers[cpu], LOONGARCH_CSR_MERRENTRY);
 		csr_write64(pcpu_handlers[cpu] + 80*VECSIZE, LOONGARCH_CSR_TLBRENTRY);
-	}
 #endif
+	}
 }
 
 void tlb_init(int cpu)


