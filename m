Return-Path: <stable+bounces-230493-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBXWIHRbxWkk9gQAu9opvQ
	(envelope-from <stable+bounces-230493-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 17:14:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31726338342
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 17:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40AFD3056704
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 16:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5244035D0;
	Thu, 26 Mar 2026 16:09:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130002FD1B6
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774541345; cv=none; b=JXdRWzr1EqjLJ5cxU8OmZzre+NyoQkStyMi84t0/GWjj6h2l27g7YQ2i0pWUaBfBWMMYAiv1VQV+9+fpf/6MD8/nmUGd37iyLCjJJvnodbeLR0iSjjgSWp/b0SlSXd1FjxBkemug0wQKgVIUXD57A0EqYcV1x2s+Bqow9BlzGwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774541345; c=relaxed/simple;
	bh=MGyeeJ1a0lMJ829hfcGJqK1aUVuI8uarAoKT5MIItks=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O4oPfvpWFvyeYQsXD1VBhFvDqIREPQxIC00+E10ijxUxH2MCtMu1XGj2Pf9mZgkfRZYbd9xuxNNlAuRObDKIAACXUVhvB+HhLr5l9+Kr89ltj34YdUkGkrbkyBJV+sEMpvk8UiZLHjaFOh5bdYMHzijbYN+BQ8rCujBeZpUS+w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-67df63d61e0so3110234eaf.2
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 09:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774541343; x=1775146143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8junP6WMSdW3XnEnRVAvBA3AlZhw0juim/cfYtbyDa0=;
        b=gmJVmEFeohypweyo7RPaRqvLJJEIuvV7eS3ALM+JqL4bhGF+oaHWdSrtbTXn5iLtil
         DxVVnQSIE0j71PiZ8lw5//+gXFJpdqlCFHGTkHQsCgjQcRi6Pb4AWLBW/aLTe/pqTRLk
         VfGMakpIOrN8I+8expdk5/idEoJCI6qHq01Q1OS45qjtrdErvfAseG5lZ0SrwaabKe7J
         zerugWTYQKoEWoItwD6+zFqt9ebCQJsJbNSYFu3QYybVXcwAF0q/Ew7cwXEv0V9AY97g
         P+jIbPPHHZIDJdOYNElyPupjmKjIRRHegtxhe7Vhj4keiI2eiarzpjHUvaEqwRIgy1nQ
         6uGw==
X-Forwarded-Encrypted: i=1; AJvYcCUpPORweVaUtMHyQIz3aRW+6HDkBNwZj8nljp4k6Pw3tN4LwgLYfxC7Zx3/0LTLdhR0K0FbpcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeGBTfwcMHNXNLp15c986C0xQIt3fwx++OFHiOnQIT3R5ioop9
	Q2UUBsCTE9mQilbnBwrVWPAf2DmPnVCAgMJesKZuTFWQSw+3npziD0NZEY5bbfFhO/49IcBzVBk
	N1h10hELZ6UVi4VO4tpZCR5TTo04DL7R15rqnpEshnQxMn01wxhZocUHyiKI=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:8c1:b0:67c:305f:ac67 with SMTP id
 006d021491bc7-67dff3cfa80mr3777055eaf.11.1774541343046; Thu, 26 Mar 2026
 09:09:03 -0700 (PDT)
Date: Thu, 26 Mar 2026 09:09:03 -0700
In-Reply-To: <tencent_983857212537723BA67CEF4462DAD5A9120A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c55a1f.a70a0220.3d5e5.0007.GAE@google.com>
Subject: Re: [v6.1] WARNING in ext4_dirty_folio
From: syzbot <syzbot+6d41dcf689b8618244d6@syzkaller.appspotmail.com>
To: driz2t@qq.com, stable@vger.kernel.org, syzkaller-lts-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=e608db5e3125a45d];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[qq.com,vger.kernel.org,googlegroups.com];
	TAGGED_FROM(0.00)[bounces-230493-lists,stable=lfdr.de,6d41dcf689b8618244d6];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c09:e001:a7::12fc:5321:query timed out];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31726338342
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in ext4_dirty_folio

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5107 at fs/ext4/inode.c:3659 ext4_dirty_folio+0x155/0x310 fs/ext4/inode.c:3659
Modules linked in:
CPU: 0 PID: 5107 Comm: syz.0.17 Not tainted syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:ext4_dirty_folio+0x155/0x310 fs/ext4/inode.c:3659
Code: 49 83 3f 00 74 1f e8 ba 10 5b ff 48 8b 3c 24 48 89 de 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d e9 50 8f c9 ff e8 9b 10 5b ff <0f> 0b eb dd e8 92 10 5b ff 0f 0b eb af e8 89 10 5b ff 48 89 df 48
RSP: 0018:ffffc900032b7a50 EFLAGS: 00010293
RAX: ffffffff82275215 RBX: ffffea0001b438c0 RCX: ffff88807dc50000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 1ffffd4000368718 R08: ffffea0001b438c7 R09: 1ffffd4000368718
R10: dffffc0000000000 R11: fffff94000368719 R12: dffffc0000000000
R13: 1ffffd4000368719 R14: 0000000000000001 R15: ffffea0001b438e8
FS:  00007fd4acea26c0(0000) GS:ffff8880b8e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd4acea1ff8 CR3: 000000002ddcc000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 set_page_dirty_lock+0x1a/0x30 mm/page-writeback.c:2793
 fuse_copy_finish+0x104/0x200 fs/fuse/dev.c:678
 fuse_dev_do_read+0xc7d/0x11d0 fs/fuse/dev.c:1301
 fuse_dev_read+0xda/0x140 fs/fuse/dev.c:1366
 call_read_iter include/linux/fs.h:2259 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x4a7/0xa00 fs/read_write.c:470
 ksys_read+0x14c/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:46 [inline]
 do_syscall_64+0x4c/0xa0 arch/x86/entry/common.c:76
 entry_SYSCALL_64_after_hwframe+0x68/0xd2
RIP: 0033:0x7fd4abf9aef9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd4acea2028 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007fd4ac206090 RCX: 00007fd4abf9aef9
RDX: 0000000000002020 RSI: 0000200000000940 RDI: 0000000000000005
RBP: 00007fd4ac02fee0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd4ac206128 R14: 00007fd4ac206090 R15: 00007ffcf7380148
 </TASK>


Tested on:

commit:         f2ddafa9 Linux 6.1.166
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=164c61d6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e608db5e3125a45d
dashboard link: https://syzkaller.appspot.com/bug?extid=6d41dcf689b8618244d6
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11ba8102580000


