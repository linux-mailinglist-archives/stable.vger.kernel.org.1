Return-Path: <stable+bounces-268083-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hUdpJr+DO2pYZAgAu9opvQ
	(envelope-from <stable+bounces-268083-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 09:14:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E416BC114
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 09:14:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268083-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268083-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C04C1302D5F7
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 07:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C24438C401;
	Wed, 24 Jun 2026 07:13:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6081385D75
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 07:13:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782285198; cv=none; b=PA4EUSIaCzl1JV2SDz/Om2LVzVyXmoqVX7DEfm9jurLGw4L/YIi9YuYoK7TDDLAzVxyFoTzlQlqqzhqEGs7ubaD5bCFXmWlFCXidGTrQX1jfPKRJ0Fb6CtxgtXd+vvZN+v0Wi2vy5u+qDtaeBUJK22ZKBmIPf6juPS+/kfFk09E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782285198; c=relaxed/simple;
	bh=D5x3bMnC7ssQUxkomi6+PpKQQaU7Xoq+nvNPzzgbtlE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=B93OdfCqKg/XujLmlo0g4KkWUr2o6qOjeMV+DpXY/4ej9jgZVqM+4bda3o0lVaxUgXfI8ckXz9AIlVGB8rDsq2njiN/AUfxhERxoWN/eSK/8exxGPAGuSor9bI17HyXJt9kvdQc/DW7eTbLB3XTJvUeSz2zzd3QUEeDGw1aM9Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-48952d1c293so1202280b6e.3
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 00:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782285196; x=1782889996;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBoFAIV4uqiLRHVMXBdmCTKrSw3E3vg+XbDQ1EwUBeo=;
        b=F+s8Nf4V+bgBJBFHCHxrvqmajDGfNecRqh992bs20XmeCD9LHH3LnqJqBeVEQ980+Z
         2V3vr+59/DSD12/6RD72vrcUShL90P9LwEC7rQpK+Dr9JEBRFRA6m4lU1/QKu9mQ0RvV
         PV6E6fJlxzf3lzabWZ6Licebk5ecLGWHwmx92avOTh9iM5q1vX/OHYls6d4PIpIJt+2R
         myFDVh1/GMKaZaLfWCFJx/ub3N2UHJbuXSNB8ekYzcZOqTu+262Rf0THCifrX/igmczI
         wvvlMscnqqOrhVRec3QgvYHi9uHS6235C68SfZk4MskyXhzBY/cuL85JwBHz+21Sqoix
         tYbA==
X-Forwarded-Encrypted: i=1; AFNElJ/1S5MFjmANqbyBNM8CpWOlHXvf4V492yNc3Z5VX0wO5U4+nnaPys9CRvA26pzBOH0qCwq/kKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ956qKYRhPW6CSjLevZejltgUrmhqCRBShlxZ/CIYkjk/RbZ8
	mWXhJmEb8owoTaZNh00F2F/XPtVQcyn62aMtf12+WN2ck+EEncfsqTr0idpHSLoovxrasa51xjR
	HkLKJYraE3vLQSO38I4mZxos+9JDwgjoQ2RyStQ/WeQOzg0IMkAeUbjXqOgc=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1496:b0:48c:3b4:2b95 with SMTP id
 5614622812f47-48c03b4480emr14653928b6e.29.1782285195953; Wed, 24 Jun 2026
 00:13:15 -0700 (PDT)
Date: Wed, 24 Jun 2026 00:13:15 -0700
In-Reply-To: <20260623222402.175798-1-sam@bynar.io>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a3b838b.c358b6d0.89040.0007.GAE@google.com>
Subject: [syzbot ci] Re: nfc: nci: fix uninit-value in nci_core_init_rsp_packet()
From: syzbot ci <syzbot+cie92d4e0088e1c4d0@syzkaller.appspotmail.com>
To: davem@davemloft.net, david@ixit.cz, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	oe-linux-nfc@lists.linux.dev, pabeni@redhat.com, sam@bynar.io, 
	stable@vger.kernel.org
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:david@ixit.cz,m:edumazet@google.com,m:horms@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:oe-linux-nfc@lists.linux.dev,m:pabeni@redhat.com,m:sam@bynar.io,m:stable@vger.kernel.org,m:syzbot@lists.linux.dev,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268083-lists,stable=lfdr.de,cie92d4e0088e1c4d0];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,syzbot.org:url,appspotmail.com:email,googlegroups.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E5E416BC114

syzbot ci has tested the following series

[v1] nfc: nci: fix uninit-value in nci_core_init_rsp_packet()
https://lore.kernel.org/all/20260623222402.175798-1-sam@bynar.io
* [PATCH net] nfc: nci: fix uninit-value in nci_core_init_rsp_packet()

and found the following issue:
UBSAN: array-index-out-of-bounds in nci_init_complete_req

Full report is available here:
https://ci.syzbot.org/series/2a9a8657-37a3-4dce-8cb5-2035027791dd

***

UBSAN: array-index-out-of-bounds in nci_init_complete_req

tree:      linux-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next
base:      a986fde914d88af47eb78fd29c5d1af7952c3500
arch:      amd64
compiler:  Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6
config:    https://ci.syzbot.org/builds/80f835c3-e998-47ff-aaa5-24c578af3b4e/config
syz repro: https://ci.syzbot.org/findings/65008893-2498-4786-b913-f2c474a7b34a/syz_repro

------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in net/nfc/nci/core.c:192:7
index 4 is out of range for type '__u8[4]' (aka 'unsigned char[4]')
CPU: 0 UID: 0 PID: 5905 Comm: syz.1.33 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
 __ubsan_handle_out_of_bounds+0xe8/0xf0 lib/ubsan.c:455
 nci_init_complete_req+0x255/0x460 net/nfc/nci/core.c:192
 __nci_request+0x7d/0x300 net/nfc/nci/core.c:108
 nci_open_device net/nfc/nci/core.c:529 [inline]
 nci_dev_up+0x8c3/0xdc0 net/nfc/nci/core.c:643
 nfc_dev_up+0x165/0x350 net/nfc/core.c:118
 nfc_genl_dev_up+0x89/0xe0 net/nfc/netlink.c:775
 genl_family_rcv_msg_doit+0x233/0x340 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0x614/0x7a0 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x7bb/0x940 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec net/socket.c:775 [inline]
 __sock_sendmsg net/socket.c:790 [inline]
 ____sys_sendmsg+0x9b9/0xa20 net/socket.c:2684
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2738
 __sys_sendmsg net/socket.c:2770 [inline]
 __do_sys_sendmsg net/socket.c:2775 [inline]
 __se_sys_sendmsg net/socket.c:2773 [inline]
 __x64_sys_sendmsg+0x1b1/0x290 net/socket.c:2773
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f55ead9ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f55ebcb9028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f55eb015fa0 RCX: 00007f55ead9ce59
RDX: 0000000004008054 RSI: 0000200000000200 RDI: 0000000000000005
RBP: 00007f55eae32e6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f55eb016038 R14: 00007f55eb015fa0 R15: 00007ffcba11c798
 </TASK>
---[ end trace ]---


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a patch for this bug, please reply with `#syz test`
(should be on a separate line).

The patch should be attached to the email.
Note: arguments like custom git repos and branches are not supported.

