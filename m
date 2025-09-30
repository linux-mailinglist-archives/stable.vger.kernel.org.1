Return-Path: <stable+bounces-182062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0638DBAC922
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 12:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4261923FC4
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 10:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E74D2F7475;
	Tue, 30 Sep 2025 10:56:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471341AAE13
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 10:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759229816; cv=none; b=rXe+6XMqpJSgxQYJVradQ39M+9gS1mh8rcdg1IZE/8cvWwqGRIMqRB9Q6qzhfDhuZTo0ubV1g0u0sCsU07RhdmabccQG6aRVt3vTopRuSYWpbJ6K/2VcfsUsWTt63qLoSo5kGYX2hC4M2psScwY3cUrbfdOXi9wtewD7SqfK4yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759229816; c=relaxed/simple;
	bh=P0bulvBSgw0/2qG+kHXMW1VRv65+K/7NX/DitiBMI/k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Kiwa9BCTD8X2A/tXTGClT9kJ04172XPt8wQIpV3F7fHvAKCuGY9aIzu7yyW5nPldP6d+lx4J0sNDQtWnOBvZCfLVPzfW1wBcfgYYHQRh1YxoCl/oOT4+owr4ApxHLOYgP5iDyhUNp7FzuXyS3aVMBvaYwHCae6EDRW/e6owJQkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42721b7023eso48798605ab.2
        for <stable@vger.kernel.org>; Tue, 30 Sep 2025 03:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759229814; x=1759834614;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A9s5lKvKDABnlyPv5FHzfoj0kZjQ9BrH1NHlxob5owg=;
        b=DeiYRDH8pfdybewljzkiK7UmGfj0w2ccvFt9dSg3Zc+zRYlitPvqv3fgqDcjYW9a3u
         cRQ5VAcvEXDogx4Lfcspio96hRGHK1/huBlPFwME0qYa19fWGhegDqBIzuU5yrNLYNpE
         QF9oXR8oGowgphgjW9Ua2DgxRxb8bex4Mn3LXzOfkblwmMjF1o7AObAZv6t9bMRfwJQm
         wdof/X+kJjbKiYqRY2Pc/7WPDBiOfFNUctEPb2fEnqp+wCa6c5h5v9Lq8o7MyCaiDzkd
         OUcxurGqd5v0YJwuQKtwAPOKxNVorZ4tdNT3INcZ5SJEcT5NoIQ70ArK5eefo0AiL4D+
         ZR2w==
X-Forwarded-Encrypted: i=1; AJvYcCWRE5CaT3n09O8XXau632u+Vw7jku+VcUZiAvex+QoYvj2WiHmGz3rVjwVtL3QdBnWgSM47se8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrup1yWBxUx8t6V90sMOabv/h3+5zIzjpiRyD6rCPYMSRQXgz5
	yrpIuhX0c/P/LBRDnPtN9kGRc5W8mtl/VtY1PKu6Rmj4jK2lNI8TXGWViwRth2PJxbrYd2WJUAI
	eLriopg7WGynWk+pDClgKv6HQC3ZELOpnJPKgBWgF9kSS0cfhecFXWl53u24=
X-Google-Smtp-Source: AGHT+IG6+NqI73w0Zf2L+W4izG5fN2n5MZDwq2eoASlJ8ucEBVdNMpT8OCeevvkXqn2u90OpDt97HulPwwihv4CG2Zc/ccRnQoLa
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26c:0:b0:425:7466:624d with SMTP id
 e9e14a558f8ab-42595654e5cmr282606945ab.26.1759229814315; Tue, 30 Sep 2025
 03:56:54 -0700 (PDT)
Date: Tue, 30 Sep 2025 03:56:54 -0700
In-Reply-To: <20250930060557.85133-1-lance.yang@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dbb776.a00a0220.102ee.0046.GAE@google.com>
Subject: [syzbot ci] Re: mm/rmap: fix soft-dirty and uffd-wp bit loss when
 remapping zero-filled mTHP subpage to shared zeropage
From: syzbot ci <syzbot+ci80449aea3ab57787@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, byungchul@sk.com, david@redhat.com, 
	dev.jain@arm.com, gourry@gourry.net, harry.yoo@oracle.com, 
	ioworker0@gmail.com, jannh@google.com, joshua.hahnjy@gmail.com, 
	lance.yang@linux.dev, liam.howlett@oracle.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, matthew.brost@intel.com, 
	npache@redhat.com, peterx@redhat.com, rakie.kim@sk.com, riel@surriel.com, 
	ryan.roberts@arm.com, stable@vger.kernel.org, usamaarif642@gmail.com, 
	vbabka@suse.cz, ying.huang@linux.alibaba.com, yuzhao@google.com, 
	ziy@nvidia.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v3] mm/rmap: fix soft-dirty and uffd-wp bit loss when remapping zero-filled mTHP subpage to shared zeropage
https://lore.kernel.org/all/20250930060557.85133-1-lance.yang@linux.dev
* [PATCH v3 1/1] mm/rmap: fix soft-dirty and uffd-wp bit loss when remapping zero-filled mTHP subpage to shared zeropage

and found the following issue:
general protection fault in remove_migration_pte

Full report is available here:
https://ci.syzbot.org/series/a2021abd-c238-431c-a92e-cc29beb53cbf

***

general protection fault in remove_migration_pte

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      1896ce8eb6c61824f6c1125d69d8fda1f44a22f8
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/84a2085e-d609-43ea-8b19-f9af8ea3d54a/config
C repro:   https://ci.syzbot.org/findings/3e211477-5a8d-4d4d-935b-15076499b001/c_repro
syz repro: https://ci.syzbot.org/findings/3e211477-5a8d-4d4d-935b-15076499b001/syz_repro

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 5985 Comm: syz.0.27 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:ptep_get include/linux/pgtable.h:340 [inline]
RIP: 0010:remove_migration_pte+0x37f/0x2340 mm/migrate.c:361
Code: 43 20 48 89 84 24 08 01 00 00 49 8d 47 40 48 89 84 24 00 01 00 00 4c 89 64 24 50 4c 8b b4 24 70 01 00 00 4c 89 f0 48 c1 e8 03 <42> 80 3c 28 00 74 08 4c 89 f7 e8 22 3e ff ff 49 8b 06 48 89 44 24
RSP: 0018:ffffc90002c2f3c0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888027799080 RCX: 1ffffd40008d1006
RDX: 0000000000000000 RSI: 00000000000387ff RDI: 0000000000038600
RBP: ffffc90002c2f5d0 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52000585e30 R12: ffffea0004688008
R13: dffffc0000000000 R14: 0000000000000000 R15: ffffea0004688000
FS:  0000555589124500(0000) GS:ffff8880b8d7e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000300 CR3: 0000000026118000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 rmap_walk_anon+0x553/0x730 mm/rmap.c:2842
 remove_migration_ptes mm/migrate.c:478 [inline]
 migrate_folio_move mm/migrate.c:1394 [inline]
 migrate_folios_move mm/migrate.c:1725 [inline]
 migrate_pages_batch+0x200a/0x35c0 mm/migrate.c:1972
 migrate_pages_sync mm/migrate.c:2002 [inline]
 migrate_pages+0x1bcc/0x2930 mm/migrate.c:2111
 migrate_to_node mm/mempolicy.c:1244 [inline]
 do_migrate_pages+0x5ee/0x800 mm/mempolicy.c:1343
 kernel_migrate_pages mm/mempolicy.c:1858 [inline]
 __do_sys_migrate_pages mm/mempolicy.c:1876 [inline]
 __se_sys_migrate_pages+0x544/0x650 mm/mempolicy.c:1872
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f922b98ec29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffccaf966f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000100
RAX: ffffffffffffffda RBX: 00007f922bbd5fa0 RCX: 00007f922b98ec29
RDX: 0000200000000300 RSI: 0000000000000003 RDI: 0000000000000000
RBP: 00007f922ba11e41 R08: 0000000000000000 R09: 0000000000000000
R10: 0000200000000040 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f922bbd5fa0 R14: 00007f922bbd5fa0 R15: 0000000000000004
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ptep_get include/linux/pgtable.h:340 [inline]
RIP: 0010:remove_migration_pte+0x37f/0x2340 mm/migrate.c:361
Code: 43 20 48 89 84 24 08 01 00 00 49 8d 47 40 48 89 84 24 00 01 00 00 4c 89 64 24 50 4c 8b b4 24 70 01 00 00 4c 89 f0 48 c1 e8 03 <42> 80 3c 28 00 74 08 4c 89 f7 e8 22 3e ff ff 49 8b 06 48 89 44 24
RSP: 0018:ffffc90002c2f3c0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888027799080 RCX: 1ffffd40008d1006
RDX: 0000000000000000 RSI: 00000000000387ff RDI: 0000000000038600
RBP: ffffc90002c2f5d0 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52000585e30 R12: ffffea0004688008
R13: dffffc0000000000 R14: 0000000000000000 R15: ffffea0004688000
FS:  0000555589124500(0000) GS:ffff8880b8d7e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000300 CR3: 0000000026118000 CR4: 00000000000006f0
----------------
Code disassembly (best guess):
   0:	43 20 48 89          	rex.XB and %cl,-0x77(%r8)
   4:	84 24 08             	test   %ah,(%rax,%rcx,1)
   7:	01 00                	add    %eax,(%rax)
   9:	00 49 8d             	add    %cl,-0x73(%rcx)
   c:	47                   	rex.RXB
   d:	40                   	rex
   e:	48 89 84 24 00 01 00 	mov    %rax,0x100(%rsp)
  15:	00
  16:	4c 89 64 24 50       	mov    %r12,0x50(%rsp)
  1b:	4c 8b b4 24 70 01 00 	mov    0x170(%rsp),%r14
  22:	00
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 f7             	mov    %r14,%rdi
  34:	e8 22 3e ff ff       	call   0xffff3e5b
  39:	49 8b 06             	mov    (%r14),%rax
  3c:	48                   	rex.W
  3d:	89                   	.byte 0x89
  3e:	44                   	rex.R
  3f:	24                   	.byte 0x24


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

