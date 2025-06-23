Return-Path: <stable+bounces-156254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0B0AE4ECF
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C74C33BE697
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8D01F582A;
	Mon, 23 Jun 2025 21:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jdSeAlQt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D0D70838;
	Mon, 23 Jun 2025 21:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750712960; cv=none; b=mu3gO2RIUXqqo3EYHN9UMQvfc0waQ7MZwl2af6OU7PYg0L/cnH7E5iVFufH7TOWGCqk70Fx0yrL/OzYieXIQLblTkja/mAkOQApz7uU0P/6LT9Drgchj3iWyGyzZcOZWcAVs5F5WeooeW6KiNtWdP7qFKznXRt4FGa6IMeXlAKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750712960; c=relaxed/simple;
	bh=L7uCX9aYjUFzHUMWv5p+umC+EpVzWLKJnPE2zpmQcn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ul3Yifh5I4kLXtfWnbZFl3vt1HR2foXX5jqpMnUhugGp1zHcVW5uIhW3oCTCBVEr9+LHKJxdqoxUtg1DTJsTP/63oT0g/07LbqoOOv0b1oSDyw8CRoIvziVt7MEqkHYfooz9yh85vSW+eGhx9v8rAkbcPTH3e23iO2MuaNDjnNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jdSeAlQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367DFC4CEEA;
	Mon, 23 Jun 2025 21:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750712960;
	bh=L7uCX9aYjUFzHUMWv5p+umC+EpVzWLKJnPE2zpmQcn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jdSeAlQtqdKig+hloJVhiMCtVPwLrPxnwnHUFmDXtjKYH/36+bucnwkgO3qXG4Pnb
	 a8UMXDScE4JNSXZrjLXIGUVM79Ibmzho4Ljrh3m8XrC/3U7k5jp0/wXljj/vESPnXZ
	 o9dYu0l1EY7zeSAITZWdegJsE0f8aaLLcqlkOc/o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+0d33ab192bd50b6c91e6@syzkaller.appspotmail.com,
	Edward Adam Davis <eadavis@qq.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.6 040/290] media: vidtv: Terminating the subsequent process of initialization failure
Date: Mon, 23 Jun 2025 15:05:01 +0200
Message-ID: <20250623130628.212186404@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.910356556@linuxfoundation.org>
References: <20250623130626.910356556@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Edward Adam Davis <eadavis@qq.com>

commit 1d5f88f053480326873115092bc116b7d14916ba upstream.

syzbot reported a slab-use-after-free Read in vidtv_mux_init. [1]

After PSI initialization fails, the si member is accessed again, resulting
in this uaf.

After si initialization fails, the subsequent process needs to be exited.

[1]
BUG: KASAN: slab-use-after-free in vidtv_mux_pid_ctx_init drivers/media/test-drivers/vidtv/vidtv_mux.c:78 [inline]
BUG: KASAN: slab-use-after-free in vidtv_mux_init+0xac2/0xbe0 drivers/media/test-drivers/vidtv/vidtv_mux.c:524
Read of size 8 at addr ffff88802fa42acc by task syz.2.37/6059

CPU: 0 UID: 0 PID: 6059 Comm: syz.2.37 Not tainted 6.14.0-rc5-syzkaller #0
Hardware name: Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:94 [inline]
dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
print_address_description mm/kasan/report.c:408 [inline]
print_report+0xc3/0x670 mm/kasan/report.c:521
kasan_report+0xd9/0x110 mm/kasan/report.c:634
vidtv_mux_pid_ctx_init drivers/media/test-drivers/vidtv/vidtv_mux.c:78
vidtv_mux_init+0xac2/0xbe0 drivers/media/test-drivers/vidtv/vidtv_mux.c:524
vidtv_start_streaming drivers/media/test-drivers/vidtv/vidtv_bridge.c:194
vidtv_start_feed drivers/media/test-drivers/vidtv/vidtv_bridge.c:239
dmx_section_feed_start_filtering drivers/media/dvb-core/dvb_demux.c:973
dvb_dmxdev_feed_start drivers/media/dvb-core/dmxdev.c:508 [inline]
dvb_dmxdev_feed_restart.isra.0 drivers/media/dvb-core/dmxdev.c:537
dvb_dmxdev_filter_stop+0x2b4/0x3a0 drivers/media/dvb-core/dmxdev.c:564
dvb_dmxdev_filter_free drivers/media/dvb-core/dmxdev.c:840 [inline]
dvb_demux_release+0x92/0x550 drivers/media/dvb-core/dmxdev.c:1246
__fput+0x3ff/0xb70 fs/file_table.c:464
task_work_run+0x14e/0x250 kernel/task_work.c:227
exit_task_work include/linux/task_work.h:40 [inline]
do_exit+0xad8/0x2d70 kernel/exit.c:938
do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
__do_sys_exit_group kernel/exit.c:1098 [inline]
__se_sys_exit_group kernel/exit.c:1096 [inline]
__x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1096
x64_sys_call+0x151f/0x1720 arch/x86/include/generated/asm/syscalls_64.h:232
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f871d58d169
Code: Unable to access opcode bytes at 0x7f871d58d13f.
RSP: 002b:00007fff4b19a788 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f871d58d169
RDX: 0000000000000064 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fff4b19a7ec R08: 0000000b4b19a87f R09: 00000000000927c0
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000003
R13: 00000000000927c0 R14: 000000000001d553 R15: 00007fff4b19a840
 </TASK>

Allocated by task 6059:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 vidtv_psi_pat_table_init drivers/media/test-drivers/vidtv/vidtv_psi.c:970
 vidtv_channel_si_init drivers/media/test-drivers/vidtv/vidtv_channel.c:423
 vidtv_mux_init drivers/media/test-drivers/vidtv/vidtv_mux.c:519
 vidtv_start_streaming drivers/media/test-drivers/vidtv/vidtv_bridge.c:194
 vidtv_start_feed drivers/media/test-drivers/vidtv/vidtv_bridge.c:239
 dmx_section_feed_start_filtering drivers/media/dvb-core/dvb_demux.c:973
 dvb_dmxdev_feed_start drivers/media/dvb-core/dmxdev.c:508 [inline]
 dvb_dmxdev_feed_restart.isra.0 drivers/media/dvb-core/dmxdev.c:537
 dvb_dmxdev_filter_stop+0x2b4/0x3a0 drivers/media/dvb-core/dmxdev.c:564
 dvb_dmxdev_filter_free drivers/media/dvb-core/dmxdev.c:840 [inline]
 dvb_demux_release+0x92/0x550 drivers/media/dvb-core/dmxdev.c:1246
 __fput+0x3ff/0xb70 fs/file_table.c:464
 task_work_run+0x14e/0x250 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xad8/0x2d70 kernel/exit.c:938
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
 __do_sys_exit_group kernel/exit.c:1098 [inline]
 __se_sys_exit_group kernel/exit.c:1096 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1096
 x64_sys_call arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6059:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4609 [inline]
 kfree+0x2c4/0x4d0 mm/slub.c:4757
 vidtv_channel_si_init drivers/media/test-drivers/vidtv/vidtv_channel.c:499
 vidtv_mux_init drivers/media/test-drivers/vidtv/vidtv_mux.c:519
 vidtv_start_streaming drivers/media/test-drivers/vidtv/vidtv_bridge.c:194
 vidtv_start_feed drivers/media/test-drivers/vidtv/vidtv_bridge.c:239
 dmx_section_feed_start_filtering drivers/media/dvb-core/dvb_demux.c:973
 dvb_dmxdev_feed_start drivers/media/dvb-core/dmxdev.c:508 [inline]
 dvb_dmxdev_feed_restart.isra.0 drivers/media/dvb-core/dmxdev.c:537
 dvb_dmxdev_filter_stop+0x2b4/0x3a0 drivers/media/dvb-core/dmxdev.c:564
 dvb_dmxdev_filter_free drivers/media/dvb-core/dmxdev.c:840 [inline]
 dvb_demux_release+0x92/0x550 drivers/media/dvb-core/dmxdev.c:1246
 __fput+0x3ff/0xb70 fs/file_table.c:464
 task_work_run+0x14e/0x250 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xad8/0x2d70 kernel/exit.c:938
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
 __do_sys_exit_group kernel/exit.c:1098 [inline]
 __se_sys_exit_group kernel/exit.c:1096 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1096
 x64_sys_call arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 3be8037960bc ("media: vidtv: add error checks")
Cc: stable@vger.kernel.org
Reported-by: syzbot+0d33ab192bd50b6c91e6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0d33ab192bd50b6c91e6
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/test-drivers/vidtv/vidtv_channel.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/test-drivers/vidtv/vidtv_channel.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_channel.c
@@ -497,7 +497,7 @@ free_sdt:
 	vidtv_psi_sdt_table_destroy(m->si.sdt);
 free_pat:
 	vidtv_psi_pat_table_destroy(m->si.pat);
-	return 0;
+	return -EINVAL;
 }
 
 void vidtv_channel_si_destroy(struct vidtv_mux *m)



