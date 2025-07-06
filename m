Return-Path: <stable+bounces-159603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7945AF7973
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B2116B44B
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 14:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE852EAD1B;
	Thu,  3 Jul 2025 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DPEG8Z5b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1B32E7F1A;
	Thu,  3 Jul 2025 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554752; cv=none; b=gpyCj5vGHaeEIFUOrQAVyCZ227ZOf3d2Q4UnmU1XrQ0cZNcfg6lQrawb83a5kjYaZivXyl0z3WMn7K0G/YeHAuWZC/UvdJFJTW3QopAZUr94NaopU9KADaHLPs44IsLZJ39UR/cNR/oerHedRWEHgvk/j9s/OyTYClr4fkFMAoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554752; c=relaxed/simple;
	bh=FWaNcpqiRAS/frJwJ69LzVkfmq3n55dsqWy0IAAnQHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/47UMk43czLJb/0ZcF2MpeR0jzN4GC93VjYUkv8AO+kuSloxOXy5y99hydvc6r7dN71qi3vD4vWxyoIFKupYHdhAqFsfy0l2395Muy4M59jg7QLiPWq7edAe5D5qhtKEWZnpuYtEVoJQ/8ugidZlpE1fW0Pivxwsv3HvzATsyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DPEG8Z5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C6EC4CEEE;
	Thu,  3 Jul 2025 14:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751554752;
	bh=FWaNcpqiRAS/frJwJ69LzVkfmq3n55dsqWy0IAAnQHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DPEG8Z5bOZP3182srHMvT9tTrMYNBd4iUs4uUvyjSIruwzFmG0jCqyr+zGITMEofp
	 hmxEsr6ii66RniOh3NcsrBn2VY2BBnOnzSLuMrz6NbtIVdr3YrrPhij+EDMqTQR3Xu
	 wPlPCYf6XMhoK4DuB8amhkyAFHV2ErVdiEbWDU8s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 068/263] s390/mm: Fix in_atomic() handling in do_secure_storage_access()
Date: Thu,  3 Jul 2025 16:39:48 +0200
Message-ID: <20250703144007.040829939@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703144004.276210867@linuxfoundation.org>
References: <20250703144004.276210867@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit 11709abccf93b08adde95ef313c300b0d4bc28f1 ]

Kernel user spaces accesses to not exported pages in atomic context
incorrectly try to resolve the page fault.
With debug options enabled call traces like this can be seen:

BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1523
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 419074, name: qemu-system-s39
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
Preemption disabled at:
[<00000383ea47cfa2>] copy_page_from_iter_atomic+0xa2/0x8a0
CPU: 12 UID: 0 PID: 419074 Comm: qemu-system-s39
Tainted: G        W           6.16.0-20250531.rc0.git0.69b3a602feac.63.fc42.s390x+debug #1 PREEMPT
Tainted: [W]=WARN
Hardware name: IBM 3931 A01 703 (LPAR)
Call Trace:
 [<00000383e990d282>] dump_stack_lvl+0xa2/0xe8
 [<00000383e99bf152>] __might_resched+0x292/0x2d0
 [<00000383eaa7c374>] down_read+0x34/0x2d0
 [<00000383e99432f8>] do_secure_storage_access+0x108/0x360
 [<00000383eaa724b0>] __do_pgm_check+0x130/0x220
 [<00000383eaa842e4>] pgm_check_handler+0x114/0x160
 [<00000383ea47d028>] copy_page_from_iter_atomic+0x128/0x8a0
([<00000383ea47d016>] copy_page_from_iter_atomic+0x116/0x8a0)
 [<00000383e9c45eae>] generic_perform_write+0x16e/0x310
 [<00000383e9eb87f4>] ext4_buffered_write_iter+0x84/0x160
 [<00000383e9da0de4>] vfs_write+0x1c4/0x460
 [<00000383e9da123c>] ksys_write+0x7c/0x100
 [<00000383eaa7284e>] __do_syscall+0x15e/0x280
 [<00000383eaa8417e>] system_call+0x6e/0x90
INFO: lockdep is turned off.

It is not allowed to take the mmap_lock while in atomic context. Therefore
handle such a secure storage access fault as if the accessed page is not
mapped: the uaccess function will return -EFAULT, and the caller has to
deal with this. Usually this means that the access is retried in process
context, which allows to resolve the page fault (or in this case export the
page).

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Link: https://lore.kernel.org/r/20250603134936.1314139-1-hca@linux.ibm.com
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/mm/fault.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index da84ff6770dec..8b3f6dd00eab2 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -442,6 +442,8 @@ void do_secure_storage_access(struct pt_regs *regs)
 		if (rc)
 			BUG();
 	} else {
+		if (faulthandler_disabled())
+			return handle_fault_error_nolock(regs, 0);
 		mm = current->mm;
 		mmap_read_lock(mm);
 		vma = find_vma(mm, addr);
-- 
2.39.5




