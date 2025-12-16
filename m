Return-Path: <stable+bounces-202494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3485ECC32DF
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 14:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E76B03044137
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50340376BED;
	Tue, 16 Dec 2025 12:28:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F91C376BE9
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765888085; cv=none; b=PE4xcd97H8uLbY+Nhj4OUFHtXvr7DB4PaNFM1n+ckWtxENmoJXJ3aeb0VAQ0JCI/z+u4OaEsjHnf+iwx6XXny7ru1hxhPGvZKGYe5g7y42ryQPTHnNdZ2Oli8TQqSukIYEKJnYa1ZnC8rJXtlSDxQryianjXR4jsIRlLCcRz6uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765888085; c=relaxed/simple;
	bh=7/SaTSWYp5yg+KSn7Qcx6RZNdrsteUYQJm9n61ul4RM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bieHh5pzem3dbNO0m7pPiqma2IECWhAxbbngKFEXn2azudBtI7G/9eUpM9Jn5nenX3xnNbZVhHnKNKEtX0jBPqg3sZ8N/+51iASnNSnqs+w41OV3RRWseyIusqh9uyQ/qchnX5LZXZJ3AGm/Us2WO+ixiwGJ6wTADC9M2vgn1EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-65b37e173faso6429264eaf.0
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 04:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765888082; x=1766492882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GqzSrTvkfjAQEGBMiElqZ89AGID7wD0Gp4+63xQ2pGo=;
        b=SdATXOk+QuXQEYVybi0gfoN4luBYpVeMQkN5plJeOE5GYp6SRG5KU95qabB5A8u85T
         cMomLtizKhUnZ3QLtpnfBc+DMOOCmrnHOVMpDvH37aHK5zZyjuJg5SrARfCzwg1mlhec
         7gR53qn/7P2tgWCPAA2eivtMa3Uce3bR3uUG6IoHhMSjc6bqoJ9s9AhVozsg5s5ApTfo
         rch2tvXyok02Bm2PsoEoDWteMyntmIBNKCzKO57LlPZwe/mIddJyrqMX28uQcT7XV+WN
         sz53F01OulpbvGsbjBZNiMxYoRWmREZhyJ0Q8gFFWmQqDy9YMh2ZdQc8f5upBNioell3
         zywA==
X-Forwarded-Encrypted: i=1; AJvYcCWtw1SQcbV8OWuyUQpiUy7CKUM7zK0ESLaBkTseWiTHP4EowxSzpGdCIRsxIvAKyohmFs58qJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEEgjgy6opP4zRP7y88HTuH+gkq13mFZK/93Vc9/X9M5G6mjrK
	JdzY9zKcApCH3gm6wl0DKJh8jjF6JRjOaVNp0YrOU9FJFhSC5DSPETrDFGLMv+B+fhykRFa3lCF
	3H8CtC6R+GwMWSbZEp9whV2d23jjUp88J7TiLsLgunhza8EV0mPy4K8vCkKE=
X-Google-Smtp-Source: AGHT+IGQFRVkWkjxTQOTQPBe77HYPZQr/nIzYDVLDCLQU7+B8QRGxO4U72ApY8cObLWtEOpRuS8JtyDkcqSkAQPUO6up/6GpxyUr
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1885:b0:659:9a49:8f7e with SMTP id
 006d021491bc7-65b45736579mr6905941eaf.67.1765888082301; Tue, 16 Dec 2025
 04:28:02 -0800 (PST)
Date: Tue, 16 Dec 2025 04:28:02 -0800
In-Reply-To: <aUFLJriRifOpmubw@ndev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69415052.a70a0220.33cd7b.013c.GAE@google.com>
Subject: Re: [syzbot] [fs?] [mm?] kernel BUG in __filemap_add_folio
From: syzbot <syzbot+4d3cc33ef7a77041efa6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, wangjinchao600@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in __filemap_add_folio

 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0x7df/0x1170 mm/page_alloc.c:2943
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0x79c/0x15f0 kernel/rcu/tree.c:2857
 handle_softirqs+0x219/0x950 kernel/softirq.c:622
 run_ksoftirqd kernel/softirq.c:1063 [inline]
 run_ksoftirqd+0x3a/0x60 kernel/softirq.c:1055
 smpboot_thread_fn+0x3f7/0xae0 kernel/smpboot.c:160
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
------------[ cut here ]------------
kernel BUG at mm/filemap.c:858!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 6821 Comm: syz.1.76 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:__filemap_add_folio+0xf29/0x11b0 mm/filemap.c:858
Code: 9b c6 ff 48 c7 c6 c0 e9 99 8b 4c 89 ef e8 0f 74 11 00 90 0f 0b e8 47 9b c6 ff 48 c7 c6 20 ea 99 8b 4c 89 ef e8 f8 73 11 00 90 <0f> 0b e8 30 9b c6 ff 90 0f 0b 90 e9 1c fc ff ff e8 22 9b c6 ff 48
RSP: 0018:ffffc900033af840 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8880737fc980 RSI: ffffffff81f7ebf8 RDI: ffff8880737fce04
RBP: 0000000000112cc0 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff908689d7 R11: 0000000000000000 R12: 0000000000000002
R13: ffffea0001ce4980 R14: 0000000000000000 R15: 0000000000000000
FS:  000055557770b500(0000) GS:ffff888124a48000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9aef15c000 CR3: 000000002ee4c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 filemap_add_folio+0x19a/0x610 mm/filemap.c:966
 ra_alloc_folio mm/readahead.c:453 [inline]
 page_cache_ra_order+0x637/0xed0 mm/readahead.c:512
 do_sync_mmap_readahead mm/filemap.c:3400 [inline]
 filemap_fault+0x16ac/0x29d0 mm/filemap.c:3549
 __do_fault+0x10d/0x490 mm/memory.c:5320
 do_shared_fault mm/memory.c:5819 [inline]
 do_fault+0x302/0x1ad0 mm/memory.c:5893
 do_pte_missing mm/memory.c:4401 [inline]
 handle_pte_fault mm/memory.c:6273 [inline]
 __handle_mm_fault+0x1919/0x2bb0 mm/memory.c:6411
 handle_mm_fault+0x3fe/0xad0 mm/memory.c:6580
 do_user_addr_fault+0x60c/0x1370 arch/x86/mm/fault.c:1336
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x64/0xc0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
RIP: 0033:0x7f8af1a55171
Code: 48 8b 54 24 08 48 85 d2 74 17 8b 44 24 18 0f c8 89 c0 48 89 44 24 18 48 83 fa 01 0f 85 b3 01 00 00 48 8b 44 24 10 8b 54 24 18 <89> 10 e9 15 fd ff ff 48 8b 44 24 10 8b 10 48 8b 44 24 08 48 85 c0
RSP: 002b:00007ffc7d678bf0 EFLAGS: 00010246
RAX: 0000200000000980 RBX: 0000000000000004 RCX: 0000000000000000
RDX: 0000000000004000 RSI: 0000000000000000 RDI: 000055557770b3c8
RBP: 00007ffc7d678cf8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000002 R12: 00007f8af1dd5fac
R13: 00007f8af1dd5fa0 R14: fffffffffffffffe R15: 00007ffc7d678d40
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__filemap_add_folio+0xf29/0x11b0 mm/filemap.c:858
Code: 9b c6 ff 48 c7 c6 c0 e9 99 8b 4c 89 ef e8 0f 74 11 00 90 0f 0b e8 47 9b c6 ff 48 c7 c6 20 ea 99 8b 4c 89 ef e8 f8 73 11 00 90 <0f> 0b e8 30 9b c6 ff 90 0f 0b 90 e9 1c fc ff ff e8 22 9b c6 ff 48
RSP: 0018:ffffc900033af840 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8880737fc980 RSI: ffffffff81f7ebf8 RDI: ffff8880737fce04
RBP: 0000000000112cc0 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff908689d7 R11: 0000000000000000 R12: 0000000000000002
R13: ffffea0001ce4980 R14: 0000000000000000 R15: 0000000000000000
FS:  000055557770b500(0000) GS:ffff888124a48000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f772b5d7dac CR3: 000000002ee4c000 CR4: 00000000003526f0


Tested on:

commit:         40fbbd64 Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10715dc2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=495547a782e37c4f
dashboard link: https://syzkaller.appspot.com/bug?extid=4d3cc33ef7a77041efa6
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

