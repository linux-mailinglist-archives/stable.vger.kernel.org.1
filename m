Return-Path: <stable+bounces-145920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E355BABFBD1
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 18:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031031BC67F5
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 17:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71C4261588;
	Wed, 21 May 2025 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="qemtN66r"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9C925B1DA;
	Wed, 21 May 2025 16:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747846771; cv=none; b=dLLgis0PofZI6zW+Il/cgDoTYO0ZDVOfBKX3Z12YMQTsDgRe5IEgceAV6Fl6wJ3ordMSihvmj9n9S1EqUbE83dkULbkx0+0egwHeW0vl2k0+rPCX9d6t7pC7gUwRfT8PQkyrKJtouZCV5omImtv74xinwzVdGfZdFNhPQy3xr/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747846771; c=relaxed/simple;
	bh=7Of1OA5Yxg182QnsgLL7TbVWRBf475bH06Jde+Nb2M8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jBRkkFW/FC03DwadJKeGExF/p9wTC80OH4gUgWZ/5c7MolciPxCS7g0iWDEtMT3ueKXAHaWZ02E88S/xuzeo3nyT15RCOF6X9zUuSgorBe+USp2dZ8xjlFGvMFCSCs5e4P2JHlN4WeFUA34IIA0S3heInp8lv6uw+X3VPfjOlYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=qemtN66r; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.10])
	by mail.ispras.ru (Postfix) with ESMTPSA id 5A9D2552F546;
	Wed, 21 May 2025 16:59:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 5A9D2552F546
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1747846759;
	bh=HLmlo26sE/2rMaJzaKatd95yXazpO/4KJbkvVO+Dkks=;
	h=From:To:Cc:Subject:Date:From;
	b=qemtN66rg0n1LI5VCSYeOkDkVEOVabDx5Va1tkujpytq9DCvdo5viIUzzXvwHWnAN
	 AV9MOHJf0DXH8oYVAVNL3MaZW0DKTuSyfle3qa6KKME3ArkOVSfAOp4tmxsHgudyw+
	 acmhYVLY9utOmtg5phLsA8HBckC0BYsYLWw3IphE=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1 0/1] Oopses on module unload seen on 6.1.y
Date: Wed, 21 May 2025 19:59:07 +0300
Message-ID: <20250521165909.834545-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

commit 959cadf09dbae7b304f03e039b8d8e13c529e2dd
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Mon Oct 14 10:05:48 2024 -0700

    x86/its: Use dynamic thunks for indirect branches
    
    commit 872df34d7c51a79523820ea6a14860398c639b87 upstream.

was ported at v6.1.139 and leads to kernel crashes there after module
unload operations.

Example trace:
 BUG: unable to handle page fault for address: ffff8fcb47dd4000
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0003) - permissions violation
 PGD 34801067 P4D 34801067 PUD 100148063 PMD 107dd5063 PTE 8000000107dd4161
 Oops: 0003 [#1] PREEMPT SMP NOPTI
 CPU: 3 PID: 378 Comm: modprobe Not tainted 6.1.139-01446-g753bd4a5f9a9 #1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
 RIP: 0010:__change_page_attr_set_clr+0x49d/0x1280
 Call Trace:
  <TASK>
  ? free_unref_page_prepare+0x80/0x4b0
  set_direct_map_invalid_noflush+0x6e/0xa0
  __vunmap+0x18c/0x3e0
  __vfree+0x21/0xb0
  vfree+0x2b/0x90
  module_memfree+0x1b/0x50
  free_module+0x17c/0x250
  __do_sys_delete_module+0x337/0x4b0
  __x64_sys_delete_module+0x15/0x30
  x64_sys_call+0x3f9a/0x43a0
  do_syscall_64+0x33/0x80
  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
 RIP: 0033:0x7f70755c0807
  </TASK>
 Modules linked in: dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua [last unloaded: scsi_debug]


As mentioned in the blamed patch comment describing the backport
adaptations:

[ pawan: CONFIG_EXECMEM and CONFIG_EXECMEM_ROX are not supported on
        backport kernel, made changes to use module_alloc() and
        set_memory_*() for dynamic thunks. ]

module_alloc/module_memfree in conjunction with memory protection routines
were used. The allocated memory is vmalloc-based, and it ends up being ROX
upon release inside its_free_mod().

Freeing of special permissioned memory in vmalloc requires its own
handling. VM_FLUSH_RESET_PERMS flag was introduced for these purposes.

In-kernel users dealing with the stuff had to care about this explicitly
before commit 4c4eb3ecc91f ("x86/modules: Set VM_FLUSH_RESET_PERMS in
module_alloc()").

More recent kernels starting from 6.2 have the commit and are not affected.

So port it as a followup for ITS mitigation 6.1-series to fix the
aforementioned failures.

The problem concerns 5.15-series (currently in stable-queue) as well. It
needs its own patch to apply cleanly. Will send it shortly, too.

Found by Linux Verification Center (linuxtesting.org).


Thomas Gleixner (1):
  x86/modules: Set VM_FLUSH_RESET_PERMS in module_alloc()

 arch/x86/kernel/ftrace.c       | 2 --
 arch/x86/kernel/kprobes/core.c | 1 -
 arch/x86/kernel/module.c       | 9 +++++----
 3 files changed, 5 insertions(+), 7 deletions(-)

-- 
2.49.0


