Return-Path: <stable+bounces-9010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5968205D0
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A1C1C21192
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D7079EE;
	Sat, 30 Dec 2023 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FEEMJdwj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8C579C2;
	Sat, 30 Dec 2023 12:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA31DC433C8;
	Sat, 30 Dec 2023 12:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703938339;
	bh=zKKQES8Fi1M/Bb8+O4FjGp+zxf10ZLbHvhvDvv+aWVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FEEMJdwjqizbVpvTshsj/nxA+fj0Sg8vMw6r+JgotDh/4S/o5yZgzXcekmmXNqyfS
	 F1PY9GTBgfdjtas+/5SRLhv7I/CrXGFVzYVwMChJXIqsor+qW4rxVR8TPz7A2JC5Sg
	 a0mTgtubb0PI6gN+G1DNKhgW6bFZXMoozSjalOOg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	stable@kernel.org
Subject: [PATCH 6.1 108/112] x86/alternatives: Sync core before enabling interrupts
Date: Sat, 30 Dec 2023 12:00:21 +0000
Message-ID: <20231230115810.222842736@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115806.714618407@linuxfoundation.org>
References: <20231230115806.714618407@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 3ea1704a92967834bf0e64ca1205db4680d04048 upstream.

text_poke_early() does:

   local_irq_save(flags);
   memcpy(addr, opcode, len);
   local_irq_restore(flags);
   sync_core();

That's not really correct because the synchronization should happen before
interrupts are re-enabled to ensure that a pending interrupt observes the
complete update of the opcodes.

It's not entirely clear whether the interrupt entry provides enough
serialization already, but moving the sync_core() invocation into interrupt
disabled region does no harm and is obviously correct.

Fixes: 6fffacb30349 ("x86/alternatives, jumplabel: Use text_poke_early() before mm_init()")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/ZT6narvE%2BLxX%2B7Be@windriver.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/alternative.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1015,8 +1015,8 @@ void __init_or_module text_poke_early(vo
 	} else {
 		local_irq_save(flags);
 		memcpy(addr, opcode, len);
-		local_irq_restore(flags);
 		sync_core();
+		local_irq_restore(flags);
 
 		/*
 		 * Could also do a CLFLUSH here to speed up CPU recovery; but



