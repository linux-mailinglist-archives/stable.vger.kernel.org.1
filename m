Return-Path: <stable+bounces-238121-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOPlDk2H32nSUgAAu9opvQ
	(envelope-from <stable+bounces-238121-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 14:40:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 235054045B4
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 14:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63A5C300460D
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 12:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34F92DEA95;
	Wed, 15 Apr 2026 12:39:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2752C15AA
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776256796; cv=none; b=JkHqE1B3rNWAEnuq3/a3GHgGDRUltWwXmUAieqqcXClbi7fHr9mvgYJyqvHiyr5q8oPJvGIJcggM10KgpENsgFbOuvOTFrbsWQoEu9QaiV47zXalm0BWj+VaizcHUPH5K2sd5J8jt+n1QMWXm6yPs+g2GjkVywQH+gT7xp6qQdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776256796; c=relaxed/simple;
	bh=2TNqqtfZzwk4Q3+MGNL4tZZFPOezZtPOfc8fLHTjesI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=hW6yIK9BtTic5Wso3cPJhUet8c0ROmO2wmmzLGBDMngz7LgAkraTp9Vmw/8INOOS6tIHaOgaoX2RZpXf4aHwlsSY1zIl3VOweIwwIRXp1jnMTDtF7Splv+kDat/tdGEpPYoiE7tBaoZR5lqxNrA37SaJwfFRBXn4Zj63rADq2UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7dbb6b95836so16622464a34.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 05:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776256794; x=1776861594;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i8Te8xad6g0TwUkLXSSTn+m9+c6JyVc1hrfw+QrXB3E=;
        b=mhxBgBzcSvF0zfJNCf63xE68QIOWORIJdSRar2ctddevcNBE164+jy7Qaf+1NJF07Z
         LX8imyHyVmq/6tUkQPNMD3WULf/qZ3UIRQoA9CANMHNlxvAyqSL4pSs2e5i6VPsSUQff
         3dn2CItIeahjq+w/aGA93WgEyRglCLnxhfYt3eoItW8ilKdkJq7j5kGV9PPVXvTkZI21
         Z6/y2Mu3nMc/HCm7t5KOiNEz7jG4S7hq9nc+AGeBdfnbPN3Ttcz2qcwj7ZyT2b4bwNvt
         36xKXLch/pDEdt1fFR+y1yKsG4UKXpFyOrCZTPl+jS5rhg79Qt431KAe/GHu33Slwbfw
         yWfg==
X-Forwarded-Encrypted: i=1; AFNElJ+bqlzw8ZV8fOwcDkqnPYgTG4pKjbcyvy53RtzsHIXQr6Tix4SEhB8H3qQVNSV9Ul3RvCouK8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkZGCPx4DNX6oUFMnAsPcn4L2ZxofnY00tRz7yF4+szEhP6LlH
	oUkXXyNF0gktRLgucapSFkarD/dR0GPyV88ApEOeVLq2ytxliLIKW/pBuQ3705VN22zamTPtFq1
	ilw7eKvZ9MBCJIAS7LfXizZPh24CT5rph4vS7G5gTApIqKp3ESnxmSM0bbPA=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:780f:b0:688:6d55:17b with SMTP id
 006d021491bc7-68be89e55bemr7059638eaf.51.1776256794253; Wed, 15 Apr 2026
 05:39:54 -0700 (PDT)
Date: Wed, 15 Apr 2026 05:39:54 -0700
In-Reply-To: <20260415061211.45530-1-95986478+SnailSploit@users.noreply.github.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69df871a.a70a0220.259bc5.000b.GAE@google.com>
Subject: [syzbot ci] Re: [PATCH net] tipc: fix UAF race in tipc_mon_peer_up/down/remove_peer
 vs bearer teardown
From: syzbot ci <syzbot+ci2d44e407aec2bd60@syzkaller.appspotmail.com>
To: jmaloy@redhat.com, kai.aizen.dev@gmail.com, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,kernel.org,vger.kernel.org,lists.sourceforge.net,windriver.com];
	TAGGED_FROM(0.00)[bounces-238121-lists,stable=lfdr.de,ci2d44e407aec2bd60];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,appspotmail.com:email,syzbot.org:url,googlesource.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 235054045B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzbot ci has tested the following series

[v1] [PATCH net] tipc: fix UAF race in tipc_mon_peer_up/down/remove_peer vs bearer teardown
https://lore.kernel.org/all/20260415061211.45530-1-95986478+SnailSploit@users.noreply.github.com
* [PATCH] [PATCH net] tipc: fix UAF race in tipc_mon_peer_up/down/remove_peer vs bearer teardown

and found the following issue:
WARNING: suspicious RCU usage in tipc_mon_delete

Full report is available here:
https://ci.syzbot.org/series/6267bc07-4172-4821-b3e5-dac381479d9d

***

WARNING: suspicious RCU usage in tipc_mon_delete

tree:      net-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net-next.git
base:      35c2c39832e569449b9192fa1afbbc4c66227af7
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/a29dabe7-96d8-4072-bc2c-d798a349301e/config
syz repro: https://ci.syzbot.org/findings/f144d75a-7c29-41a1-988e-09892a89baa1/syz_repro

tipc: Disabling bearer <eth:syzkaller0>
=============================
WARNING: suspicious RCU usage
syzkaller #0 Not tainted
-----------------------------
net/tipc/monitor.c:108 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz.2.19/5962:
 #0: ffffffff8fbcba48 (rtnl_mutex){+.+.}-{4:4}, at: tun_detach drivers/net/tun.c:634 [inline]
 #0: ffffffff8fbcba48 (rtnl_mutex){+.+.}-{4:4}, at: tun_chr_close+0x3e/0x1c0 drivers/net/tun.c:3438

stack backtrace:
CPU: 1 UID: 0 PID: 5962 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x13f/0x1d0 kernel/locking/lockdep.c:6876
 tipc_monitor_rcu_bh+0xf5/0x110 net/tipc/monitor.c:108
 get_self net/tipc/monitor.c:209 [inline]
 tipc_mon_delete+0x10b/0x4d0 net/tipc/monitor.c:704
 tipc_l2_device_event+0x370/0x680 net/tipc/bearer.c:-1
 notifier_call_chain+0x1be/0x400 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2287 [inline]
 call_netdevice_notifiers net/core/dev.c:2301 [inline]
 unregister_netdevice_many_notify+0x17a5/0x22c0 net/core/dev.c:12464
 unregister_netdevice_many net/core/dev.c:12527 [inline]
 unregister_netdevice_queue+0x31f/0x360 net/core/dev.c:12337
 unregister_netdevice include/linux/netdevice.h:3427 [inline]
 __tun_detach+0x6d9/0x15d0 drivers/net/tun.c:621
 tun_detach drivers/net/tun.c:637 [inline]
 tun_chr_close+0x10a/0x1c0 drivers/net/tun.c:3438
 __fput+0x44f/0xa70 fs/file_table.c:469
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0xed/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7b26d9c819
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffec30cee78 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007ffec30cef60 RCX: 00007f7b26d9c819
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 0000000000011900 R08: 0000000000000001 R09: 0000000000000000
R10: 0000001b2e520000 R11: 0000000000000246 R12: 00007ffec30cefa0
R13: 00007f7b27015fac R14: 000000000001193b R15: 00007f7b27015fa0
 </TASK>


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

