Return-Path: <stable+bounces-8889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E767820550
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055361F21B26
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0B579EE;
	Sat, 30 Dec 2023 12:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g9gzwnyw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F2E79DC;
	Sat, 30 Dec 2023 12:07:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D0CC433C7;
	Sat, 30 Dec 2023 12:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703938025;
	bh=JXp5RWvbSYztXNzk06hmzhbN5pm0+SHO1kL2SePL8Mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g9gzwnywqnUVnDBqaE4CwApIloRdeZZoBYt5mLcYFGEu2EEy8vCTGipdaLdF82Sxz
	 RyeuBMiPVfWaqBYQFe8QkCNISrjTYc61n9rRDizTHTH+scRf8sXixnDySAig6waPg2
	 P16hI8JgwBNPVoQ7Ae/iQ3BkBc1xoebU4SXiS5ho=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 6.6 154/156] x86/alternatives: Disable interrupts and sync when optimizing NOPs in place
Date: Sat, 30 Dec 2023 12:00:08 +0000
Message-ID: <20231230115817.328974221@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115812.333117904@linuxfoundation.org>
References: <20231230115812.333117904@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 2dc4196138055eb0340231aecac4d78c2ec2bea5 upstream.

apply_alternatives() treats alternatives with the ALT_FLAG_NOT flag set
special as it optimizes the existing NOPs in place.

Unfortunately, this happens with interrupts enabled and does not provide any
form of core synchronization.

So an interrupt hitting in the middle of the update and using the affected code
path will observe a half updated NOP and crash and burn. The following
3 NOP sequence was observed to expose this crash halfway reliably under QEMU
  32bit:

   0x90 0x90 0x90

which is replaced by the optimized 3 byte NOP:

   0x8d 0x76 0x00

So an interrupt can observe:

   1) 0x90 0x90 0x90		nop nop nop
   2) 0x8d 0x90 0x90		undefined
   3) 0x8d 0x76 0x90		lea    -0x70(%esi),%esi
   4) 0x8d 0x76 0x00		lea     0x0(%esi),%esi

Where only #1 and #4 are true NOPs. The same problem exists for 64bit obviously.

Disable interrupts around this NOP optimization and invoke sync_core()
before re-enabling them.

Fixes: 270a69c4485d ("x86/alternative: Support relocations in alternatives")
Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/ZT6narvE%2BLxX%2B7Be@windriver.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/alternative.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index fd44739828f7..aae7456ece07 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -255,6 +255,16 @@ static void __init_or_module noinline optimize_nops(u8 *instr, size_t len)
 	}
 }
 
+static void __init_or_module noinline optimize_nops_inplace(u8 *instr, size_t len)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	optimize_nops(instr, len);
+	sync_core();
+	local_irq_restore(flags);
+}
+
 /*
  * In this context, "source" is where the instructions are placed in the
  * section .altinstr_replacement, for example during kernel build by the
@@ -438,7 +448,7 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		 *   patch if feature is *NOT* present.
 		 */
 		if (!boot_cpu_has(a->cpuid) == !(a->flags & ALT_FLAG_NOT)) {
-			optimize_nops(instr, a->instrlen);
+			optimize_nops_inplace(instr, a->instrlen);
 			continue;
 		}
 
-- 
2.43.0




