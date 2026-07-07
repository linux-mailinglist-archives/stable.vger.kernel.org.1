Return-Path: <stable+bounces-272352-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SQilKa+dTGp6nAEAu9opvQ
	(envelope-from <stable+bounces-272352-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 08:33:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 956F371800B
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 08:33:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272352-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272352-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 53E85300A24D
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 06:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC733A872A;
	Tue,  7 Jul 2026 06:32:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3363839FCD8
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 06:32:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783405976; cv=none; b=MudGvY7yRNUoVzuj9BvER1FfI8sI+4DnJW2Sc5kAdKDKXvqFSozdedqpAajTm7bQnIN8GLfBMPhUWWbORDBiX8K2AawXifTkx3xN7h2yKQdVMceY2NTXqqhI/yW3OVomxEi9Vx2enNR04FBRCxB+Zq/lD6TK6id+BYlbn04o8gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783405976; c=relaxed/simple;
	bh=PCP9wyKT5koTLIkjIeei/P1WraBTk0KhHeG6UVa4P5c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=FCnbXuU3ndFKgHbORdwObIeQ9HXt0UdmeCxkXxKibFgYM4zS1b/zNYEbyWV3zvASES1G0yDgMAhnbkVMnihrkGjZwWUZxuTpy9MoQjWkVCOJqQbQU2ezK7yFIwfpapR0ZACDyFHNDLelLzXG6HyEWntRPq8OclDDyolESwaTS/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-49226201eb8so2585849b6e.1
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 23:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783405974; x=1784010774;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=T6Li1k9zIvCaaJ+CIFvo/B8eY2h2BuLADS5o2OvokTo=;
        b=ADYU9zmF9D5LoBx955mXgDVyXJS2Jw3lBWaVk52Yosp+4kRvBnD2CMLm1an5HGo0a4
         2O0UOBvDzfyZDyFfQjkMGiaxUZc+z+tB/RIe00IEBgFrQnQl5geRXP8QaDFMdDcpU2AV
         4BuRQiP59QUXHfY6EAMlc9LSbBL0SJa4lMuchH6kUMzqJqEWPwOMwLPVh1U5Ye8Tz8ci
         /7O3JB23mAI9gpuwYUu7oqCSTasCWKHAbuuRCZTvlBA6U2EtPuZS2/Y2ecaLDBRvQSZ6
         MDeV6oCHyud4Km06ENuGCr+w83JRjVdPkLwsktLM/J0mP3A78u85bEJKM6aPV9WvPY+U
         wBfQ==
X-Forwarded-Encrypted: i=1; AFNElJ/HZgFiZkEP1HgxPF1td+rvYAI6W6kbEjMqvhQrsu+jacPPQsaaEsa8iTbxrKVXEx2uGHaSGLo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8gqrcDCA6iY+8QejZjGM1H3Unpr6oEz3XB1H2dRtgEhfsLqmq
	vxF+xp4/ljoHPhYXHJ22SIVRGRQkLvV2pWj/oIPHMwN2g+TfTxDQajYxipujxSTLtQX5ZyfBbKg
	WulFB7ryPcGFOCEOtO5JfjouoUuWhjaGHFZ3AHzt3R1netXDAcfaysyfTzSA=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:8c7:b0:6a1:98cd:7484 with SMTP id
 006d021491bc7-6a3554fb157mr2880812eaf.61.1783405974169; Mon, 06 Jul 2026
 23:32:54 -0700 (PDT)
Date: Mon, 06 Jul 2026 23:32:54 -0700
In-Reply-To: <20260706180025.2735341-3-bestswngs@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a4c9d96.a1ad617e.25832.0008.GAE@google.com>
Subject: [syzbot ci] Re: KVM: x86: Destroy the PIC and IOAPIC before
 destroying vCPUs
From: syzbot ci <syzbot+cib53d48a96bc1aea0@syzkaller.appspotmail.com>
To: bestswngs@gmail.com, jasowang@redhat.com, kai.huang@intel.com, 
	kvm@vger.kernel.org, pbonzini@redhat.com, seanjc@google.com, 
	shixuanqing.11@bytedance.com, stable@vger.kernel.org, 
	wangzhong.c0ss4ck@bytedance.com, zhanghy@sangfor.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bestswngs@gmail.com,m:jasowang@redhat.com,m:kai.huang@intel.com,m:kvm@vger.kernel.org,m:pbonzini@redhat.com,m:seanjc@google.com,m:shixuanqing.11@bytedance.com,m:stable@vger.kernel.org,m:wangzhong.c0ss4ck@bytedance.com,m:zhanghy@sangfor.com,m:syzbot@lists.linux.dev,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,intel.com,vger.kernel.org,google.com,bytedance.com,sangfor.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272352-lists,stable=lfdr.de,cib53d48a96bc1aea0];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,googlegroups.com:email,appspotmail.com:email,syzkaller.appspotmail.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 956F371800B

syzbot ci has tested the following series

[v2] KVM: x86: Destroy the PIC and IOAPIC before destroying vCPUs
https://lore.kernel.org/all/20260706180025.2735341-3-bestswngs@gmail.com
* [PATCH v2] KVM: x86: Destroy the PIC and IOAPIC before destroying vCPUs

and found the following issue:
general protection fault in kvm_cpu_has_extint

Full report is available here:
https://ci.syzbot.org/series/43a61d29-79d6-47db-ac80-4e948bd10c1a

***

general protection fault in kvm_cpu_has_extint

tree:      kvm-next
URL:       https://kernel.googlesource.com/pub/scm/virt/kvm/kvm/
base:      fb402386af4cdce108ff991a796386de55439735
arch:      amd64
compiler:  Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6
config:    https://ci.syzbot.org/builds/7f3721c2-14ce-4beb-aa97-08232f57e71a/config
syz repro: https://ci.syzbot.org/findings/0522c527-432c-4524-9835-64ab75b899af/syz_repro

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000012: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000090-0x0000000000000097]
CPU: 1 UID: 0 PID: 5786 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:kvm_cpu_has_extint+0xdb/0x340 arch/x86/kvm/irq.c:83
Code: c6 e8 0d 00 00 4c 89 f0 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 f7 e8 44 54 e0 00 bb 90 00 00 00 49 03 1e 48 89 d8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 aa 00 00 00 8b 2b eb 6d e8 df 08 76 00
RSP: 0018:ffffc900032f7740 EFLAGS: 00010206
RAX: 0000000000000012 RBX: 0000000000000090 RCX: ffff88816b748000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffff88816b748000 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000000 R12: 1ffff1102e032000
R13: dffffc0000000000 R14: ffff88811e33cde8 R15: dffffc0000000000
FS:  00007f57357e76c0(0000) GS:ffff8882a9714000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fae800f0378 CR3: 0000000109ffc000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 kvm_cpu_has_injectable_intr+0x1c/0x170 arch/x86/kvm/irq.c:98
 __nested_vmx_vmexit+0x1911/0x2b40 arch/x86/kvm/vmx/nested.c:5181
 nested_vmx_vmexit arch/x86/kvm/vmx/nested.h:46 [inline]
 vmx_leave_nested arch/x86/kvm/vmx/nested.c:6854 [inline]
 nested_vmx_free_vcpu+0x8e/0xd0 arch/x86/kvm/vmx/nested.c:381
 vmx_vcpu_free+0x109/0x2c0 arch/x86/kvm/vmx/vmx.c:7765
 kvm_arch_vcpu_destroy+0x154/0x380 arch/x86/kvm/x86.c:12859
 kvm_vcpu_destroy virt/kvm/kvm_main.c:469 [inline]
 kvm_destroy_vcpus+0x123/0x380 virt/kvm/kvm_main.c:489
 kvm_arch_destroy_vm+0xf9/0x2c0 arch/x86/kvm/x86.c:13405
 kvm_destroy_vm virt/kvm/kvm_main.c:1301 [inline]
 kvm_put_kvm+0x772/0xb10 virt/kvm/kvm_main.c:1338
 kvm_vcpu_release+0x54/0x60 virt/kvm/kvm_main.c:4101
 __fput+0x41f/0xa40 fs/file_table.c:469
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 get_signal+0x1181/0x12c0 kernel/signal.c:2807
 arch_do_signal_or_restart+0xbb/0x810 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
 exit_to_user_mode_loop+0xa3/0x5e0 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x357/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f573499ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f57357e7028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: fffffffffffffffc RBX: 00007f5734c15fa0 RCX: 00007f573499ce59
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000006
RBP: 00007f5734a32e6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5734c16038 R14: 00007f5734c15fa0 R15: 00007fffda4d80f8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:kvm_cpu_has_extint+0xdb/0x340 arch/x86/kvm/irq.c:83
Code: c6 e8 0d 00 00 4c 89 f0 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 f7 e8 44 54 e0 00 bb 90 00 00 00 49 03 1e 48 89 d8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 aa 00 00 00 8b 2b eb 6d e8 df 08 76 00
RSP: 0018:ffffc900032f7740 EFLAGS: 00010206
RAX: 0000000000000012 RBX: 0000000000000090 RCX: ffff88816b748000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffff88816b748000 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000000 R12: 1ffff1102e032000
R13: dffffc0000000000 R14: ffff88811e33cde8 R15: dffffc0000000000
FS:  00007f57357e76c0(0000) GS:ffff8882a9714000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056532c5e2950 CR3: 0000000109ffc000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	e8 0d 00 00 4c       	call   0x4c000012
   5:	89 f0                	mov    %esi,%eax
   7:	48 c1 e8 03          	shr    $0x3,%rax
   b:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
  10:	74 08                	je     0x1a
  12:	4c 89 f7             	mov    %r14,%rdi
  15:	e8 44 54 e0 00       	call   0xe0545e
  1a:	bb 90 00 00 00       	mov    $0x90,%ebx
  1f:	49 03 1e             	add    (%r14),%rbx
  22:	48 89 d8             	mov    %rbx,%rax
  25:	48 c1 e8 03          	shr    $0x3,%rax
* 29:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 aa 00 00 00    	jne    0xe0
  36:	8b 2b                	mov    (%rbx),%ebp
  38:	eb 6d                	jmp    0xa7
  3a:	e8 df 08 76 00       	call   0x76091e


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

