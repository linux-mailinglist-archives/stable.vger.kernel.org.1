Return-Path: <stable+bounces-16434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0DD840C6B
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A5828819B
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 16:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD3515698D;
	Mon, 29 Jan 2024 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZMAOj0g8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9DD157028
	for <stable@vger.kernel.org>; Mon, 29 Jan 2024 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547192; cv=none; b=K6lV2x6btt4NDY0N1SRYt4qoNg5X20ynaH6yopRHGMIH35sgBRodEEu1j4Bb7Ry4tpWom3py3bP2xv6S8+SoAR2QYhTn52a4wyuyAy5D2dp//ibitwKXXGmq0pG6cHbI9MWgEX+HThC+G1xyPGDNTFEOa1dEBiPtlODK+pK4Sfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547192; c=relaxed/simple;
	bh=pFfPXjtHf0RMuyeHclhDdMWCbGWTFSgUxCCzMNYAQfg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=j39rI+wHYq9yehOCwjeK7+sN5XQj/hWy2j9/rZk2yON0NorlyqL/0X2JdtZTz7kw7E+6wqPXE7fL0CtdjnPqMCybhpb7xEA6itFgxipBY4mh8D6gICSfEP+5C9V+eTtBUWs9sdewpMXmb8yEFK1EqMxJxVT0gX+8uTiJWtvzrLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZMAOj0g8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F56C433C7;
	Mon, 29 Jan 2024 16:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706547192;
	bh=pFfPXjtHf0RMuyeHclhDdMWCbGWTFSgUxCCzMNYAQfg=;
	h=Subject:To:Cc:From:Date:From;
	b=ZMAOj0g8d3FMxxTKXfbRiwqcbTWxukiPlx8EIfcxRL3sgBpFsp7C+R2du/m/F6gZM
	 4rw+9nFJZvNXb0G4T8f5HBj7EGHyU4iRDyRJJ2HUAUbRTLk7An3i7pEcPZgPnZATH/
	 NOvv9KRt/V9/8iPujKFujuMaN0w28xJHeJL1O1N4=
Subject: FAILED: patch "[PATCH] LoongArch/smp: Call rcutree_report_cpu_starting() at" failed to apply to 6.1-stable tree
To: chenhuacai@kernel.org,chenhuacai@loongson.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jan 2024 08:53:11 -0800
Message-ID: <2024012911-outright-violin-e677@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5056c596c3d1848021a4eaa76ee42f4c05c50346
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012911-outright-violin-e677@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


