Return-Path: <stable+bounces-144891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D21ABC6E5
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 20:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C93344A1A7A
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 18:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769711EE032;
	Mon, 19 May 2025 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g5PG1DKN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C5E284B40
	for <stable@vger.kernel.org>; Mon, 19 May 2025 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747678102; cv=none; b=HgMJ9YSVDM3iHIzL8qzt8dvx7Ql7HH9aknrDLDEOSBnuJqd8AwB5uDT7qQ+LZzuGhBadGuAWmgp1+xp8tsg9x0A/sQB6nVl5/LuNF3FhaIORxlixIxvvIEB004pWgIOTAYMojQuvtdC2VfqNbqu5COB69p209T0skBHfm5qDmfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747678102; c=relaxed/simple;
	bh=h25b1ZQHWUy7GA1BKwsRv4lBzQgq/l+ecx3lVX8QMB0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YRWUblwRWd5yPMQ95oJU+PMCTdPH+S+9ouc/QXYMbAc0JFQGuWr/n/z9kdUP1BFRI+028fhr5NcLxaHaRrpmUsi0NDRtU3VaVlmCP4t/CuPUYTOjHOK/FAmxotsipY6AMlHVzxMyd2X03arn8po7UT+txcJppcM3eW8runbYq0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g5PG1DKN; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a376da334dso439858f8f.0
        for <stable@vger.kernel.org>; Mon, 19 May 2025 11:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747678099; x=1748282899; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yVFuYQ5+RK+jobpgYs8UNNrUAZW+AMGmHxrUYMucspg=;
        b=g5PG1DKNb4CHYkH7t1pqtI6HOny2iDoBxERSBVb4ijfqE1/uz0W7LlUl9llFBL/+Xf
         FWs2f6F0KbDg3f0f4/XsotZ9Wo2aznXrMPetUc76MVfLMfW2I9mF0ribIByxyss04H7t
         tC0N3yDfkE5iRk4aeOim57eccNfqPU760v+8MIrPl9c9WqjqDohKGFoNTosrgAH00mcy
         R1rrMC0xAMrNUa5Ksytdrao0g5qUb9CEzWmPWzvahLvOsDTAAtWeIS7RBvgTK3TWZGGK
         sKx9aOl0msLsFWMlVc/FxbXfTmIH6GXydK6CrFySAYl/nxGYZh5Y7VofERet1BBhGaHM
         3VeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747678099; x=1748282899;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yVFuYQ5+RK+jobpgYs8UNNrUAZW+AMGmHxrUYMucspg=;
        b=FDdla8XxYlkNeVVI/VAzLDncUekyM/7fav+PTUOQml1Aq3kZ/2baimO12f79viVB8d
         tyZuvNUu8bVwXCRDv4w8sz6AGWRUtEcqhLAafRitz60GMkZQOAgWZQ3i/QkrFYUaSFDq
         +glP6OkGoIpbHBOPB12cUXYl35Z9ciDOH2Da40ZQuBcmQvYgblMZnyf+wjcuvBi3Jjnl
         PQjFDdqlA0T2Onrrim7jL7poykklEkvCpw1SREPylmI7+Al50e3M6dmH9dSkMNOCKAdt
         Z/AwzyIHdKQJIm+BdW5rcW0DFhF7CsGXDQPyus56pGDfq3qf2Nl81ryWsWkvWc906nHb
         MMgg==
X-Forwarded-Encrypted: i=1; AJvYcCUeDfpD81zuX42/AIcc73Yvi1E1O1bzlxDGm3Z6IVluxA6UAjjgXOpQvCGKrL0KD/nmtbL169o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDxB/QzZjFs608b3KjkkHgn5JLZ1Ot4WsoACiqg8vyvBZVluUm
	LfCO7towCIV7hppQe5txDVtGvS9GU5ovU+Om8j8aXLkEhlHXCbVSi3WPVYI4FEFQsoKkoA1vTIX
	NR+PxKX+bEMUo9gkL3A==
X-Google-Smtp-Source: AGHT+IGbmbkLxQ6+c+1jvf284DkuCMXNCx0iTcuUM30vDlHFtVeT2ykVdEf82/2w+mxDQEcmu8s27itQ8/1huBM=
X-Received: from wrbft8.prod.google.com ([2002:a05:6000:2b08:b0:3a1:f532:5b8f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:144c:b0:3a3:6843:497a with SMTP id ffacd0b85a97d-3a368434aefmr6924653f8f.27.1747678098818;
 Mon, 19 May 2025 11:08:18 -0700 (PDT)
Date: Mon, 19 May 2025 18:08:16 +0000
In-Reply-To: <20250517170957.1317876-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250517170957.1317876-1-cmllamas@google.com>
Message-ID: <aCtzkI2HGqIStHg-@google.com>
Subject: Re: [PATCH v2] binder: fix use-after-free in binderfs_evict_inode()
From: Alice Ryhl <aliceryhl@google.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, kernel-team@android.com, 
	Dmitry Antipov <dmantipov@yandex.ru>, stable@vger.kernel.org, 
	syzbot+353d7b75658a95aa955a@syzkaller.appspotmail.com, 
	"open list:ANDROID DRIVERS" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"

On Sat, May 17, 2025 at 05:09:56PM +0000, Carlos Llamas wrote:
> From: Dmitry Antipov <dmantipov@yandex.ru>
> 
> Running 'stress-ng --binderfs 16 --timeout 300' under KASAN-enabled
> kernel, I've noticed the following:
> 
> BUG: KASAN: slab-use-after-free in binderfs_evict_inode+0x1de/0x2d0
> Write of size 8 at addr ffff88807379bc08 by task stress-ng-binde/1699
> 
> CPU: 0 UID: 0 PID: 1699 Comm: stress-ng-binde Not tainted 6.14.0-rc7-g586de92313fc-dirty #13
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x1c2/0x2a0
>  ? __pfx_dump_stack_lvl+0x10/0x10
>  ? __pfx__printk+0x10/0x10
>  ? __pfx_lock_release+0x10/0x10
>  ? __virt_addr_valid+0x18c/0x540
>  ? __virt_addr_valid+0x469/0x540
>  print_report+0x155/0x840
>  ? __virt_addr_valid+0x18c/0x540
>  ? __virt_addr_valid+0x469/0x540
>  ? __phys_addr+0xba/0x170
>  ? binderfs_evict_inode+0x1de/0x2d0
>  kasan_report+0x147/0x180
>  ? binderfs_evict_inode+0x1de/0x2d0
>  binderfs_evict_inode+0x1de/0x2d0
>  ? __pfx_binderfs_evict_inode+0x10/0x10
>  evict+0x524/0x9f0
>  ? __pfx_lock_release+0x10/0x10
>  ? __pfx_evict+0x10/0x10
>  ? do_raw_spin_unlock+0x4d/0x210
>  ? _raw_spin_unlock+0x28/0x50
>  ? iput+0x697/0x9b0
>  __dentry_kill+0x209/0x660
>  ? shrink_kill+0x8d/0x2c0
>  shrink_kill+0xa9/0x2c0
>  shrink_dentry_list+0x2e0/0x5e0
>  shrink_dcache_parent+0xa2/0x2c0
>  ? __pfx_shrink_dcache_parent+0x10/0x10
>  ? __pfx_lock_release+0x10/0x10
>  ? __pfx_do_raw_spin_lock+0x10/0x10
>  do_one_tree+0x23/0xe0
>  shrink_dcache_for_umount+0xa0/0x170
>  generic_shutdown_super+0x67/0x390
>  kill_litter_super+0x76/0xb0
>  binderfs_kill_super+0x44/0x90
>  deactivate_locked_super+0xb9/0x130
>  cleanup_mnt+0x422/0x4c0
>  ? lockdep_hardirqs_on+0x9d/0x150
>  task_work_run+0x1d2/0x260
>  ? __pfx_task_work_run+0x10/0x10
>  resume_user_mode_work+0x52/0x60
>  syscall_exit_to_user_mode+0x9a/0x120
>  do_syscall_64+0x103/0x210
>  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0xcac57b
> Code: c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8
> RSP: 002b:00007ffecf4226a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> RAX: 0000000000000000 RBX: 00007ffecf422720 RCX: 0000000000cac57b
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ffecf422850
> RBP: 00007ffecf422850 R08: 0000000028d06ab1 R09: 7fffffffffffffff
> R10: 3fffffffffffffff R11: 0000000000000246 R12: 00007ffecf422718
> R13: 00007ffecf422710 R14: 00007f478f87b658 R15: 00007ffecf422830
>  </TASK>
> 
> Allocated by task 1705:
>  kasan_save_track+0x3e/0x80
>  __kasan_kmalloc+0x8f/0xa0
>  __kmalloc_cache_noprof+0x213/0x3e0
>  binderfs_binder_device_create+0x183/0xa80
>  binder_ctl_ioctl+0x138/0x190
>  __x64_sys_ioctl+0x120/0x1b0
>  do_syscall_64+0xf6/0x210
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Freed by task 1705:
>  kasan_save_track+0x3e/0x80
>  kasan_save_free_info+0x46/0x50
>  __kasan_slab_free+0x62/0x70
>  kfree+0x194/0x440
>  evict+0x524/0x9f0
>  do_unlinkat+0x390/0x5b0
>  __x64_sys_unlink+0x47/0x50
>  do_syscall_64+0xf6/0x210
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> This 'stress-ng' workload causes the concurrent deletions from
> 'binder_devices' and so requires full-featured synchronization
> to prevent list corruption.
> 
> I've found this issue independently but pretty sure that syzbot did
> the same, so Reported-by: and Closes: should be applicable here as well.
> 
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+353d7b75658a95aa955a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=353d7b75658a95aa955a
> Fixes: e77aff5528a18 ("binderfs: fix use-after-free in binder_devices")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Carlos Llamas <cmllamas@google.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

