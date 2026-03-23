Return-Path: <stable+bounces-227873-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIPDBBuOwGnkIgQAu9opvQ
	(envelope-from <stable+bounces-227873-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 01:49:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C462EB4C7
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 01:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E07C93003367
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 00:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE48B286A4;
	Mon, 23 Mar 2026 00:49:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF75145A1F
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 00:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774226966; cv=none; b=GdMALVuey62UEzxANtyHnj4d62YAFNxOPB+7KUqVT7N+evZ1Le31nFHUGG9BjkaVBLVUM/8lxmPApXTZHFEf/vUcjrukiXtVGTPx/hRqgF+q4Z0rO4Yv2MJhIhUvpcb25qgZB2fO9HY7fzgTz0IpmluYgvlnMOJa2yOBoiauCWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774226966; c=relaxed/simple;
	bh=7LaKKr4yZyg0ZvE9VEGYMOfjx057iDIEwnbzmhIy93A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ibgvZaL7W0Buzk6eZD6KmawmaDQm0ICdVPgPsfuFfY8wKW6esLSaAhFimV1SOeSpJJSzTfM8YA1Up1JOoTa2nWkUGVLe/SU/cpMaedN3j/8v4mM2MTLDj1E/cPDiOICF+ixxJoiBVvjua1nB10kqBQZr6z2KbD4r0SgcEMOe3n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-67c258734aeso48710157eaf.1
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 17:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774226964; x=1774831764;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lCR822/uZHf0Q8Jfza0L6H0l12rk2oqJxUhoblYiW7c=;
        b=nXYPyy1HBEul674obZ3kd3JskcP0d74TklwN8q56QyEAVWW/snL+6ZAgk7h4rd/W2Z
         yDtw5U5H8ivxBwiSbw4js1rt3klWGSbtXbdHSgDNW9bK8shkLW+t6Fbrz+fK1sLLz0QA
         UVP6qNyRUufZnF5ud+umj7xNVz0aXXv059f36spo3Qehlxz943L80/HMb/8dKIQuxEeO
         4SKZ4yIjAPyTE5o0YHCxFHA5ugVHI8rWbmKK6xGKxgPkFNciTwVR8hc/jLsDntT09IAy
         3BAFN2jdm6Kfm6eZq4yIqkqoHA1T/WNY+L3y1NHBZ9FgU7ZN2dai9a6rKBPFQSp1pOCj
         Hjeg==
X-Forwarded-Encrypted: i=1; AJvYcCUHiMY34Cw/1bA5ei49JdgbogHuMFrs5AYKx5G5x1hJsp+DHBn3T7hm1H2LSdXhOGcVcVUs9Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvwJn02CGuaRqKXJwT5TcJT5WHJ+nuCSuftr5s040C9HUXclQq
	ExQga0/AGKCa5SUii6Esras1stEtPgWZcq5OQKbNGOrBu1xiIhv9edJTj7zZap/zqY0pgAStFm1
	uCzCsvr0SHCZmQZk3dhN1ROispDfd+caQHaoi/miu1Nh3V5M/jELXNs43wwc=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:a29a:10b0:67c:2734:6aa3 with SMTP id
 006d021491bc7-67c27346d80mr4722941eaf.42.1774226964307; Sun, 22 Mar 2026
 17:49:24 -0700 (PDT)
Date: Sun, 22 Mar 2026 17:49:24 -0700
In-Reply-To: <69b8c9a9.a00a0220.3b25d1.002a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c08e14.050a0220.3bf4de.008f.GAE@google.com>
Subject: Re: [syzbot] [nilfs?] WARNING in nilfs_ioctl_prepare_clean_segments
From: syzbot <syzbot+466a45fcfb0562f5b9a0@syzkaller.appspotmail.com>
To: junjie.cao@linux.dev, konishi.ryusuke@gmail.com, 
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org, slava@dubeyko.com, 
	stable@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=c584910d0d74158d];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[linux.dev,gmail.com,vger.kernel.org,dubeyko.com,googlegroups.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-227873-lists,stable=lfdr.de,466a45fcfb0562f5b9a0];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,appspotmail.com:email,syzkaller.appspot.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 97C462EB4C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzbot has found a reproducer for the following issue on:

HEAD commit:    785f0eb2f85d Add linux-next specific files for 20260320
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10d95e02580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c584910d0d74158d
dashboard link: https://syzkaller.appspot.com/bug?extid=466a45fcfb0562f5b9a0
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a941d6580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d95e02580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a1f7fd9c1a63/disk-785f0eb2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6c138da87c25/vmlinux-785f0eb2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4d1be64e56db/bzImage-785f0eb2.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/35af4078ce5c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+466a45fcfb0562f5b9a0@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
------------[ cut here ]------------
ret == -ENOENT
WARNING: fs/nilfs2/ioctl.c:757 at nilfs_ioctl_mark_blocks_dirty fs/nilfs2/ioctl.c:757 [inline], CPU#1: syz.0.17/6067
WARNING: fs/nilfs2/ioctl.c:757 at nilfs_ioctl_prepare_clean_segments+0x7e7/0x800 fs/nilfs2/ioctl.c:799, CPU#1: syz.0.17/6067
Modules linked in:
CPU: 1 UID: 0 PID: 6067 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:nilfs_ioctl_mark_blocks_dirty fs/nilfs2/ioctl.c:757 [inline]
RIP: 0010:nilfs_ioctl_prepare_clean_segments+0x7e7/0x800 fs/nilfs2/ioctl.c:799
Code: fe e9 3e fa ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c d4 fa ff ff 4c 89 ef e8 34 a7 7e fe e9 c7 fa ff ff e8 fa 40 15 fe 90 <0f> 0b 90 41 bf fe ff ff ff e9 e3 fe ff ff 66 66 2e 0f 1f 84 00 00
RSP: 0018:ffffc90002f17640 EFLAGS: 00010293
RAX: ffffffff83b11086 RBX: 00000000fffffffe RCX: ffff888029a05b80
RDX: 0000000000000000 RSI: ffffffff8ecbc490 RDI: 00000000fffffffe
RBP: ffffc90002f17730 R08: ffff888029a05b80 R09: 0000000000000002
R10: 00000000fffffffe R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000020 R14: ffff88805c254560 R15: ffff88807ade9180
FS:  0000555588d41500(0000) GS:ffff888125548000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31063fff CR3: 0000000078882000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 nilfs_clean_segments+0x18c/0xa50 fs/nilfs2/segment.c:2525
 nilfs_ioctl_clean_segments fs/nilfs2/ioctl.c:916 [inline]
 nilfs_ioctl+0x261f/0x2780 fs/nilfs2/ioctl.c:1346
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2426b9c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcedafafd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f2426e15fa0 RCX: 00007f2426b9c799
RDX: 0000200000000000 RSI: 0000000040786e88 RDI: 0000000000000004
RBP: 00007f2426c32c99 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2426e15fac R14: 00007f2426e15fa0 R15: 00007f2426e15fa0
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

