Return-Path: <stable+bounces-105088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AD09F5BEC
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 01:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B37188F6E6
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 00:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210E71E529;
	Wed, 18 Dec 2024 00:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaishome.de header.i=@kaishome.de header.b="XQ4dsQar"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3213C2572
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 00:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734483438; cv=none; b=be0Ck4uIaMADUbIJLk6awOuZV7p8tY68UxSHX+pZaiEPrUGjCwfi2Wcv3FfIZkJNKjKIzUnQfoj2i2r0KNIWubRzrAA6RK5BnQkyeDFruea9iEoTHqK55vkUaoPo9PiserkVRRQMfx3iix9Co9WskKscO551dkbe0EFE61P9VkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734483438; c=relaxed/simple;
	bh=Qiw2AsTVSSSt+ofkrMEHt/5yEkKYRy8sOO5QkWfqE+o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UlGUEG8a3LSaEdivDrGW212P+Xmd4RlRwXUluerVYrakqSatAr0FZxPkReToYaQrGS3MS5tcUmFeETUE7csLEt3Ehttk8Mc7cDESFdI70stzP0xVkzMfgGiHfBj50DAb5SjRmnNCtyFkGC9VWf3E0QJD6riVsMCuhhn8V/6EamY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaishome.de; spf=pass smtp.mailfrom=kaishome.de; dkim=pass (1024-bit key) header.d=kaishome.de header.i=@kaishome.de header.b=XQ4dsQar; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaishome.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaishome.de
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361d5dcf5bso64119835e9.3
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 16:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaishome.de; s=google; t=1734483434; x=1735088234; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YhcpKPuzHEuLVyXvF+Zv2qB9dmvlbj36pcV+LKoRkwc=;
        b=XQ4dsQarZPKZhjeV8oc3xUChbcQQQOSRGeWg56obQav0PpGa6+RCapaAjMCucSOigh
         A7pXfSwnWwMp+FOM6tGFZo8YOxWdPArPmcLY9o5eXHJ1ra/f8PkB8tiWl1IoHR5To7+0
         Lsubk4iSdqumrK5kCu7aVgss98NHsbTT9MQy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734483434; x=1735088234;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YhcpKPuzHEuLVyXvF+Zv2qB9dmvlbj36pcV+LKoRkwc=;
        b=qgaQE1/Z+IMoFjCV+ovI+zPclIQAkqdgfW5jS8FLMqIPnGPYf9zD5oYnEY0jpDTDkx
         2LIPXpSD7X2gGT4nRISZi+FgeKyxtnklbzK6jaqBQ/z246mtN2SaRtREc662QJI9eWWe
         03Umi/e2v12bp2zEdMtYdCrS26qFtCDdsv4HwP2kPgnGSbc+bgDod8E59jxLu7SK4Uwo
         RZvnj85C0icf+qE/+7hjAjXl2CV3f9x5EF6NYnDjas1q5nDewc54E0QubK4E3VumvdPQ
         GjARI0mwIZlLV9jzZdY2PKdA8DJ2IGqPlyZ2Q91hzWQ9YRNc14dV134zuMp3sIuWLMBu
         iyxQ==
X-Gm-Message-State: AOJu0YyRF4Kaeo5j8ymIn/CrTQCGIAZauxnTByarrX4q9R12tKQm9dL1
	a0fudNHS+YH5iwLNwWvVz2ouY8Y0XHIoL9urDUmZxyWF99Dr62IH0DFPkyuTtFAUeRs/HbUfOZv
	g1/TYTyGPUkFDgL2ESP7tiYNwB2E/vBsLSNlj0+Voym2YbYdD5fM=
X-Gm-Gg: ASbGncut3yym+IoOkNbVW2c8zX46+W4kTsYxE5tdoXZl2jLhExxFcxTwcHwMLke+89Z
	RIdVTlDcR82BH4QV6JRaJtGYc6s/Q1DYh0CZjBxoBgR8eK40YuCz+PpEGrQAkz7JJQ+1A6IQ=
X-Google-Smtp-Source: AGHT+IGCZTaMRRzAVU0Jac2I68kHHE7eR2kI0sXS9PgYpLOMGHqx2dALEz1saX79agnyAXDqrJwsiOV0GLXnvkOCs6A=
X-Received: by 2002:a05:600c:468d:b0:434:a5d1:9905 with SMTP id
 5b1f17b1804b1-436553f4e3amr4480785e9.26.1734483433611; Tue, 17 Dec 2024
 16:57:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kai Krakow <kai@kaishome.de>
Date: Wed, 18 Dec 2024 01:57:03 +0100
Message-ID: <CAC2ZOYt1iqpZk_mDgLux+PNhQC=OS1FDyhbeFQYe6cqJqGZ+aw@mail.gmail.com>
Subject: 
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello!

Running 6.12.4 on Gentoo, using zswap with zsmalloc.

Since 6.12, I often experience the following error while
installing/compiling packages:

Dez 16 03:11:58 jupiter kernel: Huh VM_FAULT_OOM leaked out to the #PF
handler. Retrying PF
Dez 16 03:11:58 jupiter kernel: Huh VM_FAULT_OOM leaked out to the #PF
handler. Retrying PF
Dez 16 03:11:58 jupiter kernel: Huh VM_FAULT_OOM leaked out to the #PF
handler. Retrying PF
Dez 16 03:11:58 jupiter kernel: Huh VM_FAULT_OOM leaked out to the #PF
handler. Retrying PF
Dez 16 03:11:58 jupiter kernel: Huh VM_FAULT_OOM leaked out to the #PF
handler. Retrying PF
Dez 16 03:11:58 jupiter kernel: Huh VM_FAULT_OOM leaked out to the #PF
handler. Retrying PF
Dez 16 03:11:58 jupiter kernel: Huh VM_FAULT_OOM leaked out to the #PF
handler. Retrying PF
Dez 16 03:11:58 jupiter kernel: Huh VM_FAULT_OOM leaked out to the #PF
handler. Retrying PF
Dez 16 03:11:58 jupiter kernel: Huh VM_FAULT_OOM leaked out to the #PF
handler. Retrying PF
Dez 16 03:11:58 jupiter kernel: Huh VM_FAULT_OOM leaked out to the #PF
handler. Retrying PF
Dez 16 03:12:03 jupiter kernel: pagefault_out_of_memory: 8645812
callbacks suppressed

Programs then slowly start to stop responding and the system won't
shut down cleanly.

I'm starting to get backtraces after a while:

Dez 16 03:58:17 jupiter kernel: ------------[ cut here ]------------
Dez 16 03:58:17 jupiter kernel: WARNING: CPU: 5 PID: 5149 at
mm/swapfile.c:1566 free_swap_and_cache_nr+0xab/0x540
Dez 16 03:58:17 jupiter kernel: Modules linked in: nfnetlink_queue
nf_conntrack_netlink ip6t_REJECT nf_reject_ipv6 ip6table_nat
ip6table_filter xt_nat ipt_REJECT nf_reject_ipv4 xt_NFQUEUE xt_mark
xt_connmark iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 iptable_filter ip6table_mangle ip6_tables
iptable_mangle xt_DSCP xt_tcpudp ip_tables x_tables rfcomm
snd_hrtimer>
Dez 16 03:58:17 jupiter kernel:  gpu_sched drm_gpuvm drm_exec i915
drm_buddy drm_display_helper ttm nvidia_uvm(PO) nvidia_modeset(PO)
nvidia(PO) lm92 efivarfs
Dez 16 03:58:17 jupiter kernel: CPU: 5 UID: 1000 PID: 5149 Comm:
QXcbEventQueue Tainted: P           O       6.12.4-gentoo-r1 #1
Dez 16 03:58:17 jupiter kernel: Tainted: [P]=PROPRIETARY_MODULE, [O]=OOT_MODULE
Dez 16 03:58:17 jupiter kernel: Hardware name: ASRock Z690 Pro RS/Z690
Pro RS, BIOS 18.02 01/04/2024
Dez 16 03:58:17 jupiter kernel: RIP: 0010:free_swap_and_cache_nr+0xab/0x540
Dez 16 03:58:17 jupiter kernel: Code: 31 ed 4c 89 7c 24 10 49 89 dc 48
ba 00 00 00 00 00 00 00 fc 48 89 5c 24 18 45 89 ef 48 21 d1 44 88 4c
24 26 48 89 0c 24 eb 1c <0f> 0b 41 83 c7 01 49 83 c4 01 45 39 fe 0f 8e
dd 00 00 00 48 8b 45
Dez 16 03:58:17 jupiter kernel: RSP: 0018:ffffb2bcc984bac8 EFLAGS: 00010246
Dez 16 03:58:17 jupiter kernel: RAX: 0000000000000000 RBX:
00000000002c1603 RCX: 0000000000000000
Dez 16 03:58:17 jupiter kernel: RDX: fc00000000000000 RSI:
0000000000000001 RDI: ffff8e093c170f00
Dez 16 03:58:17 jupiter kernel: RBP: ffff8e084a8bec00 R08:
0000000000000008 R09: 0000000000000000
Dez 16 03:58:17 jupiter kernel: R10: ffffd68059365ec0 R11:
0000000000000000 R12: 00000000002c1603
Dez 16 03:58:17 jupiter kernel: R13: 0000000000000000 R14:
0000000000000001 R15: 0000000000000000
Dez 16 03:58:17 jupiter kernel: FS:  0000000000000000(0000)
GS:ffff8e0f6f340000(0000) knlGS:0000000000000000
Dez 16 03:58:17 jupiter kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Dez 16 03:58:17 jupiter kernel: CR2: 0000188c00a50000 CR3:
00000007db42b000 CR4: 0000000000f52ef0
Dez 16 03:58:17 jupiter kernel: PKRU: 55555554
Dez 16 03:58:17 jupiter kernel: Call Trace:
Dez 16 03:58:17 jupiter kernel:  <TASK>
Dez 16 03:58:17 jupiter kernel:  ? __warn.cold+0x90/0x9e
Dez 16 03:58:17 jupiter kernel:  ? free_swap_and_cache_nr+0xab/0x540
Dez 16 03:58:17 jupiter kernel:  ? report_bug+0xf6/0x140
Dez 16 03:58:17 jupiter kernel:  ? handle_bug+0x4f/0x90
Dez 16 03:58:17 jupiter kernel:  ? exc_invalid_op+0x17/0x60
Dez 16 03:58:17 jupiter kernel:  ? asm_exc_invalid_op+0x1a/0x20
Dez 16 03:58:17 jupiter kernel:  ? free_swap_and_cache_nr+0xab/0x540
Dez 16 03:58:17 jupiter kernel:  ? free_swap_and_cache_nr+0x2c/0x540
Dez 16 03:58:17 jupiter kernel:  ? swap_pte_batch+0xdc/0x1f0
Dez 16 03:58:17 jupiter kernel:  unmap_page_range+0xa18/0x16b0
Dez 16 03:58:17 jupiter kernel:  unmap_vmas+0xb7/0x170
Dez 16 03:58:17 jupiter kernel:  exit_mmap+0xfb/0x280
Dez 16 03:58:17 jupiter kernel:  __mmput+0x35/0x120
Dez 16 03:58:17 jupiter kernel:  do_exit+0x255/0x930
Dez 16 03:58:17 jupiter kernel:  do_group_exit+0x2b/0x80
Dez 16 03:58:17 jupiter kernel:  get_signal+0x774/0x7b0
Dez 16 03:58:17 jupiter kernel:  arch_do_signal_or_restart+0x29/0x230
Dez 16 03:58:17 jupiter kernel:  syscall_exit_to_user_mode+0x7b/0xf0
Dez 16 03:58:17 jupiter kernel:  do_syscall_64+0x57/0x100
Dez 16 03:58:17 jupiter kernel:  entry_SYSCALL_64_after_hwframe+0x4b/0x53
Dez 16 03:58:17 jupiter kernel: RIP: 0033:0x564111720e3f
Dez 16 03:58:17 jupiter kernel: Code: Unable to access opcode bytes at
0x564111720e15.
Dez 16 03:58:17 jupiter kernel: RSP: 002b:000056410b1fda00 EFLAGS:
00000293 ORIG_RAX: 0000000000000007
Dez 16 03:58:17 jupiter kernel: RAX: fffffffffffffdfc RBX:
0000564131839600 RCX: 0000564111720e3f
Dez 16 03:58:17 jupiter kernel: RDX: 00000000ffffffff RSI:
0000000000000001 RDI: 000056410b1fda48
Dez 16 03:58:17 jupiter kernel: RBP: 000056410b1fdb20 R08:
0000000000000000 R09: 0000000000000081
Dez 16 03:58:17 jupiter kernel: R10: 0000000000000000 R11:
0000000000000293 R12: 000056410b1fda48
Dez 16 03:58:17 jupiter kernel: R13: 0000000000000000 R14:
0000000000000000 R15: 0000564131839618
Dez 16 03:58:17 jupiter kernel:  </TASK>
Dez 16 03:58:17 jupiter kernel: ---[ end trace 0000000000000000 ]---
Dez 16 03:58:17 jupiter kernel: BUG: Bad rss-counter state
mm:00000000bf899335 type:MM_ANONPAGES val:1
Dez 16 03:58:17 jupiter kernel: BUG: Bad rss-counter state
mm:00000000bf899335 type:MM_SHMEMPAGES val:-1
Dez 16 03:58:17 jupiter kernel: BUG: Bad page cache in process
QXcbEventQueue  pfn:81fdec
Dez 16 03:58:17 jupiter kernel: page: refcount:3 mapcount:1
mapping:00000000e6a99870 index:0x10 pfn:0x81fdec
Dez 16 03:58:17 jupiter kernel: memcg:ffff8e09819f9000
Dez 16 03:58:17 jupiter kernel: aops:0xffffffffbb027a60 ino:20c5
Dez 16 03:58:17 jupiter kernel: flags:
0xa00000000002002d(locked|referenced|uptodate|lru|swapbacked|zone=2)
Dez 16 03:58:17 jupiter kernel: raw: a00000000002002d ffffd680607facc8
ffffd6806075c308 ffff8e0805f5e0b8
Dez 16 03:58:17 jupiter kernel: raw: 0000000000000010 0000000000000000
0000000300000000 ffff8e09819f9000
Dez 16 03:58:17 jupiter kernel: page dumped because: still mapped when deleted

When trying to kill processes with sysrq or via kill command, those
processes usually get stuck in state D and I get the following errors
in dmesg:

Dez 16 20:40:12 jupiter kernel: _swap_info_get: Unused swap offset
entry 002c16ee
Dez 16 20:40:12 jupiter kernel: _swap_info_get: Unused swap offset
entry 002c16c0
Dez 16 20:40:12 jupiter kernel: _swap_info_get: Unused swap offset
entry 002c16c1
Dez 16 20:40:12 jupiter kernel: _swap_info_get: Unused swap offset
entry 002c1760
Dez 16 20:40:12 jupiter kernel: _swap_info_get: Unused swap offset
entry 40000000004ce36
Dez 16 20:40:12 jupiter kernel: _swap_info_get: Unused swap offset
entry 40000000004ce1d
Dez 16 20:40:12 jupiter kernel: _swap_info_get: Unused swap offset
entry 40000000004ce52
Dez 16 20:40:12 jupiter kernel: _swap_info_get: Unused swap offset
entry 40000000004ced8
Dez 16 20:40:12 jupiter kernel: _swap_info_get: Unused swap offset
entry 40000000004ced9
Dez 16 20:40:12 jupiter kernel: _swap_info_get: Unused swap offset
entry 40000000004cec4
Dez 16 20:40:12 jupiter kernel: _swap_info_get: Unused swap offset
entry 40000000004cec3

The system can then only be rebooted with alt+sysrq+b.

Regards,
Kai

