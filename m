Return-Path: <stable+bounces-182977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 625CCBB145C
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 18:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD512A0415
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 16:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565AF287268;
	Wed,  1 Oct 2025 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="et4f6tyq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCBB2773F3;
	Wed,  1 Oct 2025 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759337005; cv=none; b=MQHhWZL7YkuX6F7L5V4GSrZ1jN7MTflMezIA7/vMb1wg5/RjkYtBpVpJCo+K6bYlqTjWMTL/CjfXCPQTbsAKh2w2tgcWh4e+Ze0vdnRaLUQTAD2WA/ZHGTSq/4F81avFS4weHOiXxkvqiEzbXQXppafX8H9dhqS2f0bNEcRrjC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759337005; c=relaxed/simple;
	bh=QNWLZ4djmIVjwAAxkUZ+XJhGSD3E4wAU7zU18m3QAOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JuCG9d+jvA8/Vy7eCw8LDtNXIWgoKk5Oyw/4mMFW4IB44dmL74NOK+qGNH9YtcRuEn5jEywsnDSoIdPSRImGE/sHBX+w17qo3R30/mJnIE57XzX2xQWA3OEy+m2+pTZurnIhcXkV0XWyEKaF3ss/TVyOt+2+SGcH5ZVU8V1NDas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=et4f6tyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B905C4CEF1;
	Wed,  1 Oct 2025 16:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759337004;
	bh=QNWLZ4djmIVjwAAxkUZ+XJhGSD3E4wAU7zU18m3QAOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=et4f6tyqrgBs7WZdlRex+OjwqnGS/x5v8MW5qcn+FID5dPPlJ6MdrhJ69h5DiRGOU
	 JMdkEsTcrsZICAHv2OlH3sRAZBik9sU0UHIc7UUI0CCMSawT2yT8B82DtPj+LhGlTt
	 yUBy3bUol0m3/CncqRBf25h3T+RjMO/mqJvolAZ/43Ei8ths7hTOrn1i0qlaS980vB
	 kI17kNzpPN97y09flJ7eGoKXitPjRvc2brrw14m4Lv4hDWOpkQC953BAQykS23lhMp
	 73lmIDC0Nn0bZp4CpXnwKzHJmlAvUB6yXZ0M2bDTY//9tiAGJP3K/J5VM8LDPCs5qY
	 HbIogzzOYCGTg==
From: SeongJae Park <sj@kernel.org>
To: Jakub Acs <acsjakub@amazon.de>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	peterx@redhat.com,
	axelrasmussen@google.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm/ksm: fix flag-dropping behavior in ksm_madvise
Date: Wed,  1 Oct 2025 09:43:22 -0700
Message-Id: <20251001164322.54119-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251001090353.57523-2-acsjakub@amazon.de>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 1 Oct 2025 09:03:52 +0000 Jakub Acs <acsjakub@amazon.de> wrote:

> syzkaller discovered the following crash: (kernel BUG)
> 
> [   44.607039] ------------[ cut here ]------------
> [   44.607422] kernel BUG at mm/userfaultfd.c:2067!
> [   44.608148] Oops: invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
> [   44.608814] CPU: 1 UID: 0 PID: 2475 Comm: reproducer Not tainted 6.16.0-rc6 #1 PREEMPT(none)
> [   44.609635] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   44.610695] RIP: 0010:userfaultfd_release_all+0x3a8/0x460
> 
> <snip other registers, drop unreliable trace>
> 
> [   44.617726] Call Trace:
> [   44.617926]  <TASK>
> [   44.619284]  userfaultfd_release+0xef/0x1b0
> [   44.620976]  __fput+0x3f9/0xb60
> [   44.621240]  fput_close_sync+0x110/0x210
> [   44.622222]  __x64_sys_close+0x8f/0x120
> [   44.622530]  do_syscall_64+0x5b/0x2f0
> [   44.622840]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   44.623244] RIP: 0033:0x7f365bb3f227
> 
> Kernel panics because it detects UFFD inconsistency during
> userfaultfd_release_all(). Specifically, a VMA which has a valid pointer
> to vma->vm_userfaultfd_ctx, but no UFFD flags in vma->vm_flags.
> 
> The inconsistency is caused in ksm_madvise(): when user calls madvise()
> with MADV_UNMEARGEABLE on a VMA that is registered for UFFD in MINOR
> mode, it accidentally clears all flags stored in the upper 32 bits of
> vma->vm_flags.
> 
> Assuming x86_64 kernel build, unsigned long is 64-bit and unsigned int
> and int are 32-bit wide. This setup causes the following mishap during
> the &= ~VM_MERGEABLE assignment.
> 
> VM_MERGEABLE is a 32-bit constant of type unsigned int, 0x8000'0000.
> After ~ is applied, it becomes 0x7fff'ffff unsigned int, which is then
> promoted to unsigned long before the & operation. This promotion fills
> upper 32 bits with leading 0s, as we're doing unsigned conversion (and
> even for a signed conversion, this wouldn't help as the leading bit is
> 0). & operation thus ends up AND-ing vm_flags with 0x0000'0000'7fff'ffff
> instead of intended 0xffff'ffff'7fff'ffff and hence accidentally clears
> the upper 32-bits of its value.
> 
> Fix it by changing `VM_MERGEABLE` constant to unsigned long, using the
> BIT() macro.

Nice!

> 
> Note: other VM_* flags are not affected:
> This only happens to the VM_MERGEABLE flag, as the other VM_* flags are
> all constants of type int and after ~ operation, they end up with
> leading 1 and are thus converted to unsigned long with leading 1s.
> 
> Note 2:
> After commit 31defc3b01d9 ("userfaultfd: remove (VM_)BUG_ON()s"), this is
> no longer a kernel BUG, but a WARNING at the same place:
> 
> [   45.595973] WARNING: CPU: 1 PID: 2474 at mm/userfaultfd.c:2067
> 
> but the root-cause (flag-drop) remains the same.
> 
> Fixes: 7677f7fd8be76 ("userfaultfd: add minor fault registration mode")

Nit.  It is recommended [1] to use 12 characters of the SHA-1 ID, but you are
using 13 characters.

> Signed-off-by: Jakub Acs <acsjakub@amazon.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Xu Xin <xu.xin16@zte.com.cn>
> Cc: Chengming Zhou <chengming.zhou@linux.dev>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org

Nit.  This would be nice to be placed just after the 'Fixes:' tag.

Acked-by: SeongJae Park <sj@kernel.org>

[1] https://docs.kernel.org/process/submitting-patches.html#describe-your-changes


Thanks,
SJ

[...]

