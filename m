Return-Path: <stable+bounces-1677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61297F80D8
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B371C2162E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C96B14F7B;
	Fri, 24 Nov 2023 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WPdL7zVj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2D5339BE;
	Fri, 24 Nov 2023 18:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E766C433C7;
	Fri, 24 Nov 2023 18:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851999;
	bh=TiIk50v+mS/pcqel6PKosJ58uxOgz/vIYBFEymVvN+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WPdL7zVj8aGzyMtf6qeUkgWI58m9S0Q50yaGZ1kVq0zAYUcILr4o0zkEHYruizyc5
	 Z+CSMND2Rth5rNnZCu21VlG92zzppk4RlA6FYaMfNXHjZO4TsRYcD17JXzFJag9lWd
	 +lQrxEeB64U3iAEVktpa33yM42EDfceYTfF/ip40=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	jirislaby@kernel.org,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [PATCH 6.1 180/372] tty/sysrq: replace smp_processor_id() with get_cpu()
Date: Fri, 24 Nov 2023 17:49:27 +0000
Message-ID: <20231124172016.465392872@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

From: Muhammad Usama Anjum <usama.anjum@collabora.com>

commit dd976a97d15b47656991e185a94ef42a0fa5cfd4 upstream.

The smp_processor_id() shouldn't be called from preemptible code.
Instead use get_cpu() and put_cpu() which disables preemption in
addition to getting the processor id. Enable preemption back after
calling schedule_work() to make sure that the work gets scheduled on all
cores other than the current core. We want to avoid a scenario where
current core's stack trace is printed multiple times and one core's
stack trace isn't printed because of scheduling of current task.

This fixes the following bug:

[  119.143590] sysrq: Show backtrace of all active CPUs
[  119.143902] BUG: using smp_processor_id() in preemptible [00000000] code: bash/873
[  119.144586] caller is debug_smp_processor_id+0x20/0x30
[  119.144827] CPU: 6 PID: 873 Comm: bash Not tainted 5.10.124-dirty #3
[  119.144861] Hardware name: QEMU QEMU Virtual Machine, BIOS 2023.05-1 07/22/2023
[  119.145053] Call trace:
[  119.145093]  dump_backtrace+0x0/0x1a0
[  119.145122]  show_stack+0x18/0x70
[  119.145141]  dump_stack+0xc4/0x11c
[  119.145159]  check_preemption_disabled+0x100/0x110
[  119.145175]  debug_smp_processor_id+0x20/0x30
[  119.145195]  sysrq_handle_showallcpus+0x20/0xc0
[  119.145211]  __handle_sysrq+0x8c/0x1a0
[  119.145227]  write_sysrq_trigger+0x94/0x12c
[  119.145247]  proc_reg_write+0xa8/0xe4
[  119.145266]  vfs_write+0xec/0x280
[  119.145282]  ksys_write+0x6c/0x100
[  119.145298]  __arm64_sys_write+0x20/0x30
[  119.145315]  el0_svc_common.constprop.0+0x78/0x1e4
[  119.145332]  do_el0_svc+0x24/0x8c
[  119.145348]  el0_svc+0x10/0x20
[  119.145364]  el0_sync_handler+0x134/0x140
[  119.145381]  el0_sync+0x180/0x1c0

Cc: jirislaby@kernel.org
Cc: stable@vger.kernel.org
Fixes: 47cab6a722d4 ("debug lockups: Improve lockup detection, fix generic arch fallback")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Link: https://lore.kernel.org/r/20231009162021.3607632-1-usama.anjum@collabora.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/sysrq.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -263,13 +263,14 @@ static void sysrq_handle_showallcpus(int
 		if (in_hardirq())
 			regs = get_irq_regs();
 
-		pr_info("CPU%d:\n", smp_processor_id());
+		pr_info("CPU%d:\n", get_cpu());
 		if (regs)
 			show_regs(regs);
 		else
 			show_stack(NULL, NULL, KERN_INFO);
 
 		schedule_work(&sysrq_showallcpus);
+		put_cpu();
 	}
 }
 



