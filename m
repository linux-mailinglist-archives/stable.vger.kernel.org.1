Return-Path: <stable+bounces-151491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C8EACEAA7
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 09:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04AAB3A90D1
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 07:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935FA1E5B72;
	Thu,  5 Jun 2025 07:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DFj6hHI6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AB21C84D9
	for <stable@vger.kernel.org>; Thu,  5 Jun 2025 07:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749107385; cv=none; b=UiDdRQJfl/0jBr4qLDpp7u2XUIJ8rvKpyaP3NoXRiOgyXYJxSJUUiMcgYo+66ICX52kifdYEzgGciVDBG2FC3OQCQqdCfko6W3JuVeG6B9JvSNmmpmYNuHeC2qS+x3N5f/CsIxOfW8PZxcYd7zvTs4+rA374kiLc65ii6tHHKF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749107385; c=relaxed/simple;
	bh=Y7PVPg7JaNWxolT8BSBUG2tpknsL/I7qOgGvmU2EWx4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oeDmStf0/iTzNlloM5mKGqjUDxZSd8Nx5R4MjzsbFcqg39MzxG6PS3nCalQqg+JRcyHJZjCNebxTWcO7foiR01kuCjCgSshjcFjuA+n6zADoPhZo/dbcgUgXRY7lUZO7svO00acthloHTY+mYCqC5PXRXjSvfiiMRyGvgeIzECk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DFj6hHI6; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso791479b3a.2
        for <stable@vger.kernel.org>; Thu, 05 Jun 2025 00:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1749107378; x=1749712178; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QFv99mSNVKcGEkg50zQ3zPhFPrIxJ7eqThSOZ53PFpk=;
        b=DFj6hHI6MVgQr72cQFwgA+ayHnWccH2Wuyx1Oh9fE9wGZPSLKLWmGkoLENcYoemxAn
         Z6pSVX6oHZugdQePFjaiauaxp0NO2U3qRp4zP/7sxbv7lcJML9Ro2+H5vdgbfbtmGQtU
         eqKht+RkDN/6gQ+ienNALO773PocSE+JmWYgx5ZviNgMoPIrc6tzYqmBVKSTHmeEfGKT
         i6LJ0PwIR1Ddo9KkKtmWbYlpUqsxi3MO19i6OySZYfS+D8zSJQuXCa8LK0VXWE6ztR6C
         DkruV3k/NYtsA5AuePjd/rbtlRGZre8mhSh1ilkH0vp4hovmo3jah2rSW8SV9bViVDSB
         WjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749107378; x=1749712178;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFv99mSNVKcGEkg50zQ3zPhFPrIxJ7eqThSOZ53PFpk=;
        b=XXunc0p7brBfW7BosMdOcM1a89zUyO1gzRUDdg8Xpq7mpiAM/c93DXhSVHPgX0yUs/
         TujsL4ybelRvVZkkzAYTf24A7ZviMUfMDL6N9vjrhrV1hVCKhMwC2C/yFDJMx1AP6uFQ
         d9kHmKFO9CS99kihWxm+kW4g22uZ5e1xQQ2DUuJbGDV/IH4UJxCymtcvGEhDoKpakynX
         ZfIDbna/wlJOQ+8P5FzeB+hcGOFo2xfmmGd2F30nqQPU4J8Kph5DKRtiQZtrxT+hqqrv
         Yr1ZKhCIAO589e46wIAAqsWLf2ZScJvAjBA5EiRkPZPGEy+1u/SWaoXMB3x0LGi/7gsB
         5Ddw==
X-Gm-Message-State: AOJu0Yy+wxIg81UY2ebxVTm7OGrcjmCubT6ov1DEoU5ntv4i0dAJ/ZIE
	1DA+ucG3JSEB6WO+55GqM5gruciUNHSqmAglOWnsePgOUEPU2LsgFwnWSCRd0cDK3HGQJ831UHl
	qc5M=
X-Gm-Gg: ASbGncuJi+DYVysX3aHoCijxphdPCb9Q0eleG8Nn9/XD62AgeAcPFz8GV6o1QK4+6+v
	pIerJG6VLdKd8WSqUNpndZHt6nCFOf5LmvndWsyG2Q57qBekLTEeuXzJ/ugc1tTVy6kq9qaZVsW
	J3Xf5vdCJ7ExbMRjsMV2DIcDraYxu+mzG5Ov+cKTB6mVKJ8yRsQcBdMA9k813QTFKm0cEdyvKkK
	6ls+sIPh8d1BtDsdlBlpckaunaCYS356zpt0nyf2UlOMQN9xYkmHOk0SSXON9hD+ugxqHvLLeRH
	BlM/nIaMaT400UtCJyP/Y2x1I2dwB847HxS6K5KQE2Y1C/iw7xH3GjkqsNH4x0s6SaN9ZPdVl38
	VvOd3s4I=
X-Google-Smtp-Source: AGHT+IGomQ14NQP3Fat8qljJO/X7TSD+m/Qcel4gb5VSfkluN/GwC9Wq5d/T3qKRd1uMt41eP3gkZA==
X-Received: by 2002:a05:6a00:3d13:b0:742:362c:d2e4 with SMTP id d2e1a72fcca58-7480b226180mr7426610b3a.5.1749107377855;
        Thu, 05 Jun 2025 00:09:37 -0700 (PDT)
Received: from bytedance ([61.213.176.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affd41e2sm12669599b3a.145.2025.06.05.00.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 00:09:36 -0700 (PDT)
Date: Thu, 5 Jun 2025 15:09:21 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Pu Lehui <pulehui@huawei.com>,
	Luiz Capitulino <luizcap@amazon.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wei Wei <weiwei.danny@bytedance.com>,
	Yuchen Zhang <zhangyuchen.lcr@bytedance.com>
Subject: Host panic in bpf verifier when loading bpf prog in 5.10 stable
 kernel
Message-ID: <20250605070921.GA3795@bytedance>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="W74xIKzLWQUpHayz"
Content-Disposition: inline


--W74xIKzLWQUpHayz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Wei reported when loading his bpf prog in 5.10.200 kernel, host would
panic, this didn't happen in 5.10.135 kernel. Test on latest v5.10.238
still has this panic.

[   26.531718] BUG: kernel NULL pointer dereference, address: 0000000000000168
[   26.538093] #PF: supervisor read access in kernel mode
[   26.542727] #PF: error_code(0x0000) - not-present page
[   26.548093] PGD 10f3e9067 P4D 10f332067 PUD 10f0c5067 PMD 0
[   26.553211] Oops: 0000 [#1] SMP NOPTI
[   26.556531] CPU: 2 PID: 541 Comm: main Not tainted 5.10.238-00267-g01e7e36b8606 #63
[   26.563816] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   26.572357] RIP: 0010:__mark_chain_precision+0x24b/0x4d0
[   26.576572] Code: 51 01 be 20 00 00 00 4c 89 ef 48 63 d2 e8 bd df 31 00 89 c1 83 f8 1f 7f 29 48 63 d1 48 89 d0 48 c1 e0 04 48 29 d0 48 8d 04 c3 <83> 38 01 75 c3 0f b6 74 24 06 80 78 74 00 c6 40 74 01 44 0f 44 f6
[   26.589100] RSP: 0018:ffa0000000ff7b60 EFLAGS: 00010216
[   26.592612] RAX: 0000000000000168 RBX: 0000000000000000 RCX: 0000000000000003
[   26.597416] RDX: 0000000000000003 RSI: 0000000000000020 RDI: ffa0000000ff7b78
[   26.601362] RBP: 0000000000000003 R08: ffa0000000ff7b70 R09: 0000000000000004
[   26.604261] R10: 0000000000000007 R11: ffa0000000425000 R12: ff11000102ee2000
[   26.607202] R13: ffa0000000ff7b78 R14: 0000000000000000 R15: ff1100010ee37140
[   26.610327] FS:  00000000007a0630(0000) GS:ff1100081c400000(0000) knlGS:0000000000000000
[   26.613678] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   26.616105] CR2: 0000000000000168 CR3: 0000000115e72002 CR4: 0000000000371ee0
[   26.619059] Call Trace:
[   26.620118]  adjust_reg_min_max_vals+0x133/0x340
[   26.622048]  ? krealloc+0x63/0xe0
[   26.623435]  do_check+0x38c/0xa80
[   26.624859]  do_check_common+0x15b/0x280
[   26.626496]  bpf_check+0xbe1/0xd30
[   26.627939]  ? srso_alias_return_thunk+0x5/0x7f
[   26.629796]  ? trace_hardirqs_on+0x1a/0xd0
[   26.631503]  ? srso_alias_return_thunk+0x5/0x7f
[   26.633402]  bpf_prog_load+0x422/0x8a0
[   26.634987]  ? srso_alias_return_thunk+0x5/0x7f
[   26.636864]  ? __handle_mm_fault+0x3cb/0x6d0
[   26.638658]  ? srso_alias_return_thunk+0x5/0x7f
[   26.640543]  ? lock_release+0xe3/0x110
[   26.642114]  __do_sys_bpf+0x485/0xdf0
[   26.643624]  do_syscall_64+0x33/0x40
[   26.645110]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
[   26.647190] RIP: 0033:0x409a6e
[   26.648470] Code: 24 28 44 8b 44 24 2c e9 70 ff ff ff cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 49 89 f2 48 89 fa 48 89 ce 48 89 df 0f 05 <48> 3d 01 f0 ff ff 76 15 48 f7 d8 48 89 c1 48 c7 c0 ff ff ff ff 48
[   26.656154] RSP: 002b:000000c00199edc0 EFLAGS: 00000212 ORIG_RAX: 0000000000000141
[   26.659451] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000409a6e
[   26.662375] RDX: 0000000000000098 RSI: 000000c00199f290 RDI: 0000000000000005
[   26.665267] RBP: 000000c00199ee00 R08: 0000000000000000 R09: 0000000000000000
[   26.668204] R10: 0000000000000000 R11: 0000000000000212 R12: 0000000000000000
[   26.671125] R13: 0000000000000080 R14: 000000c000002380 R15: 8080808080808080
[   26.674085] Modules linked in:
[   26.675363] CR2: 0000000000000168
[   26.676772] ---[ end trace 3fc192ee4dabbf12 ]---
[   26.678667] RIP: 0010:__mark_chain_precision+0x24b/0x4d0
[   26.680926] Code: 51 01 be 20 00 00 00 4c 89 ef 48 63 d2 e8 bd df 31 00 89 c1 83 f8 1f 7f 29 48 63 d1 48 89 d0 48 c1 e0 04 48 29 d0 48 8d 04 c3 <83> 38 01 75 c3 0f b6 74 24 06 80 78 74 00 c6 40 74 01 44 0f 44 f6
[   26.688665] RSP: 0018:ffa0000000ff7b60 EFLAGS: 00010216
[   26.690828] RAX: 0000000000000168 RBX: 0000000000000000 RCX: 0000000000000003
[   26.693777] RDX: 0000000000000003 RSI: 0000000000000020 RDI: ffa0000000ff7b78
[   26.696680] RBP: 0000000000000003 R08: ffa0000000ff7b70 R09: 0000000000000004
[   26.699651] R10: 0000000000000007 R11: ffa0000000425000 R12: ff11000102ee2000
[   26.702561] R13: ffa0000000ff7b78 R14: 0000000000000000 R15: ff1100010ee37140
[   26.705522] FS:  00000000007a0630(0000) GS:ff1100081c400000(0000) knlGS:0000000000000000
[   26.708806] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   26.711179] CR2: 0000000000000168 CR3: 0000000115e72002 CR4: 0000000000371ee0
[   26.714143] Kernel panic - not syncing: Fatal exception
[   26.716893] Kernel Offset: disabled
[   26.718911] Rebooting in 5 seconds..

I did a bisect in linux-5.10.y branch and found the fbc is commit
2474ec58b96d("bpf: allow precision tracking for programs with subprogs").

I noticed there is a commit in Linus master branch that has a fix tag for
this bisected commit: commit 81335f90e8a8("bpf: unconditionally reset
backtrack_state masks on global func exit"), I tried to apply it in this
5.10.y branch but since the bases are quite different, clean apply is
not possible, I end up with the following diff:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 40ac67a04ab75..71da33fb96552 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2118,11 +2118,9 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 				bitmap_from_u64(mask, reg_mask);
 				for_each_set_bit(i, mask, 32) {
 					reg = &st->frame[0]->regs[i];
-					if (reg->type != SCALAR_VALUE) {
-						reg_mask &= ~(1u << i);
-						continue;
-					}
-					reg->precise = true;
+					reg_mask &= ~(1u << i);
+					if (reg->type == SCALAR_VALUE)
+						reg->precise = true;
 				}
 				return 0;
 			}

But it didn't make any difference.

Here are the reproduce steps:
1 clone this repo https://github.com/bytedance/vArmor-ebpf and switch to
  panic-analysis branch;
2 make build
A binary named main should be built.
I used golang compiler downloaded here:
https://go.dev/dl/go1.24.3.linux-amd64.tar.gz but other golang compiler
may also work.

Run main as root and it will panic the host(kernel needs CONFIG_BPF_LSM).

Full dmesg and config are attached, feel free to let me know if you need
any additional info, thanks.

P.S. linux-5.15.y has the same situation.

--W74xIKzLWQUpHayz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-5.10.238"

[    0.000000] Linux version 5.10.238-00267-g01e7e36b8606 (ziqianlu@n232-168-196) (gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #63 SMP Thu Jun 5 14:14:46 CST 2025
[    0.000000] Command line: root=/dev/vda2 selinux=0 console=ttyS0 sched_verbose
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bffd6fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bffd7000-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000083fffffff] usable
[    0.000000] BIOS-e820: [mem 0x000000fd00000000-0x000000ffffffffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: cpu 0, msr 69e7001, primary cpu clock
[    0.000000] kvm-clock: using sched offset of 410636803 cycles
[    0.000004] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000010] tsc: Detected 2596.100 MHz processor
[    0.000904] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000909] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000915] last_pfn = 0x840000 max_arch_pfn = 0x10000000000
[    0.000981] MTRR default type: write-back
[    0.000983] MTRR fixed ranges enabled:
[    0.000984]   00000-9FFFF write-back
[    0.000985]   A0000-BFFFF uncachable
[    0.000987]   C0000-FFFFF write-protect
[    0.000988] MTRR variable ranges enabled:
[    0.000989]   0 base 00000C0000000 mask FFFFFC0000000 uncachable
[    0.000990]   1 disabled
[    0.000992]   2 disabled
[    0.000993]   3 disabled
[    0.000993]   4 disabled
[    0.000994]   5 disabled
[    0.000995]   6 disabled
[    0.000996]   7 disabled
[    0.001018] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.001035] last_pfn = 0xbffd7 max_arch_pfn = 0x10000000000
[    0.001089] Using GB pages for direct mapping
[    0.001516] ACPI: Early table checksum verification disabled
[    0.001522] ACPI: RSDP 0x00000000000F5960 000014 (v00 BOCHS )
[    0.001762] ACPI: RSDT 0x00000000BFFE202A 000034 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.001769] ACPI: FACP 0x00000000BFFE1E66 000074 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.001775] ACPI: DSDT 0x00000000BFFE0040 001E26 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.001780] ACPI: FACS 0x00000000BFFE0000 000040
[    0.001784] ACPI: APIC 0x00000000BFFE1EDA 0000F0 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.001789] ACPI: HPET 0x00000000BFFE1FCA 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.001793] ACPI: WAET 0x00000000BFFE2002 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.001798] ACPI: Reserving FACP table memory at [mem 0xbffe1e66-0xbffe1ed9]
[    0.001800] ACPI: Reserving DSDT table memory at [mem 0xbffe0040-0xbffe1e65]
[    0.001802] ACPI: Reserving FACS table memory at [mem 0xbffe0000-0xbffe003f]
[    0.001804] ACPI: Reserving APIC table memory at [mem 0xbffe1eda-0xbffe1fc9]
[    0.001806] ACPI: Reserving HPET table memory at [mem 0xbffe1fca-0xbffe2001]
[    0.001808] ACPI: Reserving WAET table memory at [mem 0xbffe2002-0xbffe2029]
[    0.001828] ACPI: Local APIC address 0xfee00000
[    0.001850] No NUMA configuration found
[    0.001852] Faking a node at [mem 0x0000000000000000-0x000000083fffffff]
[    0.001860] NODE_DATA(0) allocated [mem 0x83ffdb000-0x83fffdfff]
[    0.073641] Zone ranges:
[    0.073647]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.073651]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.073654]   Normal   [mem 0x0000000100000000-0x000000083fffffff]
[    0.073658] Movable zone start for each node
[    0.073660] Early memory node ranges
[    0.073662]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.073665]   node   0: [mem 0x0000000000100000-0x00000000bffd6fff]
[    0.073667]   node   0: [mem 0x0000000100000000-0x000000083fffffff]
[    0.073672] Initmem setup node 0 [mem 0x0000000000001000-0x000000083fffffff]
[    0.073675] On node 0 totalpages: 8388469
[    0.073677]   DMA zone: 64 pages used for memmap
[    0.073678]   DMA zone: 21 pages reserved
[    0.073679]   DMA zone: 3998 pages, LIFO batch:0
[    0.073681]   DMA32 zone: 12224 pages used for memmap
[    0.073682]   DMA32 zone: 782295 pages, LIFO batch:63
[    0.073683]   Normal zone: 118784 pages used for memmap
[    0.073685]   Normal zone: 7602176 pages, LIFO batch:63
[    0.073690] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.073717] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.105404] On node 0, zone Normal: 41 pages in unavailable ranges
[    0.106030] ACPI: PM-Timer IO Port: 0x608
[    0.106035] ACPI: Local APIC address 0xfee00000
[    0.106041] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.106100] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.106106] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.106109] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.106111] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.106114] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.106116] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.106119] ACPI: IRQ0 used by override.
[    0.106120] ACPI: IRQ5 used by override.
[    0.106121] ACPI: IRQ9 used by override.
[    0.106123] ACPI: IRQ10 used by override.
[    0.106124] ACPI: IRQ11 used by override.
[    0.106126] Using ACPI (MADT) for SMP configuration information
[    0.106129] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.106132] TSC deadline timer available
[    0.106138] smpboot: Allowing 16 CPUs, 0 hotplug CPUs
[    0.106155] kvm-guest: KVM setup pv remote TLB flush
[    0.106170] kvm-guest: setup PV sched yield
[    0.106185] [mem 0xc0000000-0xfeffbfff] available for PCI devices
[    0.106188] Booting paravirtualized kernel on KVM
[    0.106191] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.109049] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
[    0.119045] percpu: Embedded 522 pages/cpu s2099416 r8192 d30504 u4194304
[    0.119054] pcpu-alloc: s2099416 r8192 d30504 u4194304 alloc=2*2097152
[    0.119057] pcpu-alloc: [0] 00 [0] 01 [0] 02 [0] 03 [0] 04 [0] 05 [0] 06 [0] 07
[    0.119075] pcpu-alloc: [0] 08 [0] 09 [0] 10 [0] 11 [0] 12 [0] 13 [0] 14 [0] 15
[    0.119137] kvm-guest: KVM setup async PF for cpu 0
[    0.119146] kvm-guest: stealtime: cpu 0, msr 81bc1ba40
[    0.119152] kvm-guest: PV spinlocks enabled
[    0.119156] PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, linear)
[    0.119174] Built 1 zonelists, mobility grouping on.  Total pages: 8257376
[    0.119176] Policy zone: Normal
[    0.119179] Kernel command line: root=/dev/vda2 selinux=0 console=ttyS0 sched_verbose
[    0.123312] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.125346] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.125397] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.186713] Memory: 32749508K/33553876K available (12296K kernel code, 59677K rwdata, 9824K rodata, 4056K init, 37268K bss, 804168K reserved, 0K cma-reserved)
[    0.186786] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.186832] ftrace: allocating 31055 entries in 122 pages
[    0.198422] ftrace: allocated 122 pages with 5 groups
[    0.198860] Running RCU self tests
[    0.198868] rcu: Hierarchical RCU implementation.
[    0.198870] rcu:     RCU lockdep checking is enabled.
[    0.198872] rcu:     RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=16.
[    0.198874]  Rude variant of Tasks RCU enabled.
[    0.198876]  Tracing variant of Tasks RCU enabled.
[    0.198878] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.198881] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
[    0.199197] NR_IRQS: 524544, nr_irqs: 552, preallocated irqs: 16
[    0.199437] random: crng init done
[    0.217787] Console: colour VGA+ 80x25
[    0.445268] printk: console [ttyS0] enabled
[    0.446796] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.449728] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.451204] ... MAX_LOCK_DEPTH:          48
[    0.452720] ... MAX_LOCKDEP_KEYS:        8192
[    0.454286] ... CLASSHASH_SIZE:          4096
[    0.455869] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.457470] ... MAX_LOCKDEP_CHAINS:      65536
[    0.459083] ... CHAINHASH_SIZE:          32768
[    0.460715]  memory used by lock dependency info: 6877 kB
[    0.462664]  memory used for stack traces: 4224 kB
[    0.464376]  per task-struct memory footprint: 2688 bytes
[    0.466568] ACPI: Core revision 20200925
[    0.468215] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.471906] APIC: Switch to symmetric I/O mode setup
[    0.474045] Switched APIC routing to physical flat.
[    0.475998] kvm-guest: setup PV IPIs
[    0.480195] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.482733] tsc: Marking TSC unstable due to TSCs unsynchronized
[    0.485100] Calibrating delay loop (skipped) preset value.. 5192.20 BogoMIPS (lpj=25961000)
[    0.488527] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.491248] Last level iTLB entries: 4KB 512, 2MB 255, 4MB 127
[    0.495110] Last level dTLB entries: 4KB 512, 2MB 255, 4MB 127, 1GB 0
[    0.497637] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.501023] Spectre V2 : Mitigation: Retpolines
[    0.502835] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.505092] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    0.507762] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.510616] Spectre V2 : User space: Vulnerable
[    0.515092] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.518463] Speculative Return Stack Overflow: Mitigation: safe RET
[    0.520951] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.523920] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.525092] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.527588] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.530133] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.532556] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.535092] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.538216] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.540842] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
[    0.545091] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
[    0.547581] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
[    0.549932] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
[    0.552367] x86/fpu: Enabled xstate features 0x2e7, context size is 2440 bytes, using 'compacted' format.
[    0.568021] Freeing SMP alternatives memory: 28K
[    0.570176] pid_max: default: 32768 minimum: 301
[    0.572326] LSM: Security Framework initializing
[    0.574162] LSM support for eBPF active
[    0.575396] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.578399] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.582814] smpboot: CPU0: AMD EPYC 9Y24 96-Core Processor (family: 0x19, model: 0x11, stepping: 0x1)
[    0.585089] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
[    0.585089] ... version:                0
[    0.585089] ... bit width:              48
[    0.585100] ... generic registers:      6
[    0.586657] ... value mask:             0000ffffffffffff
[    0.588724] ... max period:             00007fffffffffff
[    0.590813] ... fixed-purpose events:   0
[    0.592433] ... event mask:             000000000000003f
[    0.594907] rcu: Hierarchical SRCU implementation.
[    0.596441] smp: Bringing up secondary CPUs ...
[    0.598800] x86: Booting SMP configuration:
[    0.600474] .... node  #0, CPUs:        #1
[    0.285676] kvm-clock: cpu 1, msr 69e7041, secondary cpu clock
[    0.606252] kvm-guest: KVM setup async PF for cpu 1
[    0.614954] kvm-guest: stealtime: cpu 1, msr 81c01ba40
[    0.621289]   #2
[    0.285676] kvm-clock: cpu 2, msr 69e7081, secondary cpu clock
[    0.625829] kvm-guest: KVM setup async PF for cpu 2
[    0.634819] kvm-guest: stealtime: cpu 2, msr 81c41ba40
[    0.640536]   #3
[    0.285676] kvm-clock: cpu 3, msr 69e70c1, secondary cpu clock
[    0.645098] kvm-guest: KVM setup async PF for cpu 3
[    0.645098] kvm-guest: stealtime: cpu 3, msr 81c81ba40
[    0.660063]   #4
[    0.285676] kvm-clock: cpu 4, msr 69e7101, secondary cpu clock
[    0.660063] kvm-guest: KVM setup async PF for cpu 4
[    0.664846] kvm-guest: stealtime: cpu 4, msr 81cc1ba40
[    0.679176]   #5
[    0.285676] kvm-clock: cpu 5, msr 69e7141, secondary cpu clock
[    0.679920] kvm-guest: KVM setup async PF for cpu 5
[    0.684856] kvm-guest: stealtime: cpu 5, msr 81d01ba40
[    0.698785]   #6
[    0.285676] kvm-clock: cpu 6, msr 69e7181, secondary cpu clock
[    0.700256] kvm-guest: KVM setup async PF for cpu 6
[    0.705089] kvm-guest: stealtime: cpu 6, msr 81d41ba40
[    0.719064]   #7
[    0.285676] kvm-clock: cpu 7, msr 69e71c1, secondary cpu clock
[    0.720093] kvm-guest: KVM setup async PF for cpu 7
[    0.725089] kvm-guest: stealtime: cpu 7, msr 81d81ba40
[    0.739590]   #8
[    0.285676] kvm-clock: cpu 8, msr 69e7201, secondary cpu clock
[    0.740154] kvm-guest: KVM setup async PF for cpu 8
[    0.744955] kvm-guest: stealtime: cpu 8, msr 81dc1ba40
[    0.759859]   #9
[    0.285676] kvm-clock: cpu 9, msr 69e7241, secondary cpu clock
[    0.765174] kvm-guest: KVM setup async PF for cpu 9
[    0.765174] kvm-guest: stealtime: cpu 9, msr 81e01ba40
[    0.780147]  #10
[    0.285676] kvm-clock: cpu 10, msr 69e7281, secondary cpu clock
[    0.785386] kvm-guest: KVM setup async PF for cpu 10
[    0.795073] kvm-guest: stealtime: cpu 10, msr 81e41ba40
[    0.800572]  #11
[    0.285676] kvm-clock: cpu 11, msr 69e72c1, secondary cpu clock
[    0.805941] kvm-guest: KVM setup async PF for cpu 11
[    0.815089] kvm-guest: stealtime: cpu 11, msr 81e81ba40
[    0.821227]  #12
[    0.285676] kvm-clock: cpu 12, msr 69e7301, secondary cpu clock
[    0.826496] kvm-guest: KVM setup async PF for cpu 12
[    0.835089] kvm-guest: stealtime: cpu 12, msr 81ec1ba40
[    0.845513]  #13
[    0.285676] kvm-clock: cpu 13, msr 69e7341, secondary cpu clock
[    0.849710] kvm-guest: KVM setup async PF for cpu 13
[    0.855089] kvm-guest: stealtime: cpu 13, msr 81f01ba40
[    0.867761]  #14
[    0.285676] kvm-clock: cpu 14, msr 69e7381, secondary cpu clock
[    0.870135] kvm-guest: KVM setup async PF for cpu 14
[    0.875069] kvm-guest: stealtime: cpu 14, msr 81f41ba40
[    0.887837]  #15
[    0.285676] kvm-clock: cpu 15, msr 69e73c1, secondary cpu clock
[    0.890262] kvm-guest: KVM setup async PF for cpu 15
[    0.895089] kvm-guest: stealtime: cpu 15, msr 81f81ba40
[    0.908194] smp: Brought up 1 node, 16 CPUs
[    0.909641] smpboot: Max logical packages: 1
[    0.915136] smpboot: Total of 16 processors activated (83075.20 BogoMIPS)
[    0.957507] devtmpfs: initialized
[    0.958700] x86/mm: Memory block size: 128MB
[    0.991512] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.995133] futex hash table entries: 4096 (order: 7, 524288 bytes, linear)
[    1.001799] NET: Registered protocol family 16
[    1.006110] audit: initializing netlink subsys (disabled)
[    1.010639] audit: type=2000 audit(1749104607.523:1): state=initialized audit_enabled=0 res=1
[    1.010639] thermal_sys: Registered thermal governor 'step_wise'
[    1.015118] thermal_sys: Registered thermal governor 'user_space'
[    1.019603] cpuidle: using governor menu
[    1.028968] ACPI: bus type PCI registered
[    1.029365] PCI: Using configuration type 1 for base access
[    1.035116] PCI: Using configuration type 1 for extended access
[    1.055795] Kprobes globally optimized
[    1.058437] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    1.058437] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    1.079278] ACPI: Added _OSI(Module Device)
[    1.079781] ACPI: Added _OSI(Processor Device)
[    1.085124] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.089303] ACPI: Added _OSI(Processor Aggregator Device)
[    1.094108] ACPI: Added _OSI(Linux-Dell-Video)
[    1.095122] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    1.099844] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    1.114423] ACPI: 1 ACPI AML tables successfully acquired and loaded

[    1.136581] =============================
[    1.140414] [ BUG: Invalid wait context ]
[    1.143995] 5.10.238-00267-g01e7e36b8606 #63 Not tainted
[    1.145089] -----------------------------
[    1.145089] swapper/3/0 is trying to lock:
[    1.145089] ff11000100033498 (&n->list_lock){....}-{3:3}, at: deactivate_slab+0x2fc/0x680
[    1.145089] other info that might help us debug this:
[    1.145089] context-{2:2}
[    1.145089] no locks held by swapper/3/0.
[    1.145089] stack backtrace:
[    1.145089] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.10.238-00267-g01e7e36b8606 #63
[    1.145089] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    1.145089] Call Trace:
[    1.145089]  <IRQ>
[    1.145089]  dump_stack+0x77/0x9b
[    1.145089]  __lock_acquire.cold+0x156/0x17a
[    1.145089]  ? srso_alias_return_thunk+0x5/0x7f
[    1.145089]  ? srso_alias_return_thunk+0x5/0x7f
[    1.145089]  ? validate_chain+0x2aa/0x930
[    1.145089]  lock_acquire+0xc3/0x270
[    1.145089]  ? deactivate_slab+0x2fc/0x680
[    1.145089]  ? srso_alias_return_thunk+0x5/0x7f
[    1.145089]  ? __lock_acquire+0x6f0/0xa70
[    1.145089]  _raw_spin_lock+0x30/0x70
[    1.145089]  ? deactivate_slab+0x2fc/0x680
[    1.145089]  deactivate_slab+0x2fc/0x680
[    1.145089]  ? srso_alias_return_thunk+0x5/0x7f
[    1.145089]  ? clockevents_program_event+0x4e/0xf0
[    1.145089]  ? srso_alias_return_thunk+0x5/0x7f
[    1.145089]  ? srso_alias_return_thunk+0x5/0x7f
[    1.145089]  flush_cpu_slab+0x32/0x40
[    1.145089]  flush_smp_call_function_queue+0x137/0x1a0
[    1.145089]  __sysvec_call_function+0x43/0x110
[    1.145089]  asm_call_irq_on_stack+0x12/0x20
[    1.145089]  </IRQ>
[    1.145089]  sysvec_call_function+0x7b/0xa0
[    1.145089]  asm_sysvec_call_function+0x12/0x20
[    1.145089] RIP: 0010:default_idle+0x13/0x20
[    1.145089] Code: 00 0f ae f0 0f ae 38 0f ae f0 eb b2 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 e9 07 00 00 00 0f 00 2d 59 19 5a 00 fb f4 <e9> 48 df 39 00 cc cc cc cc cc cc cc cc 0f 1f 44 00 00 65 8b 15 a4
[    1.145089] RSP: 0018:ffa0000000097ee8 EFLAGS: 00000212
[    1.145089] RAX: ffffffff818640a0 RBX: 0000000000000000 RCX: 0000000000000000
[    1.145089] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff81864278
[    1.145089] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
[    1.145089] R10: 0000000000000001 R11: 00000000ffffffff R12: ff11000100358000
[    1.145089] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    1.145089]  ? mwait_idle+0x80/0x80
[    1.145089]  ? default_idle_call+0x48/0x170
[    1.145089]  ? mwait_idle+0x80/0x80
[    1.145089]  default_idle_call+0x6f/0x170
[    1.145089]  cpuidle_idle_call+0x14f/0x190
[    1.145089]  ? srso_alias_return_thunk+0x5/0x7f
[    1.145089]  do_idle+0x84/0xd0
[    1.145089]  cpu_startup_entry+0x19/0x20
[    1.145089]  secondary_startup_64_no_verify+0xbe/0xcb
[    1.332154] ACPI: Interpreter enabled
[    1.333721] ACPI: (supports S0 S5)
[    1.335130] ACPI: Using IOAPIC for interrupt routing
[    1.337402] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.341375] ACPI: Enabled 2 GPEs in block 00 to 0F
[    1.349124] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    1.351816] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    1.355153] PCI host bridge to bus 0000:00
[    1.356864] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    1.359556] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    1.362437] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    1.365099] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
[    1.368217] pci_bus 0000:00: root bus resource [mem 0x840000000-0x8bfffffff window]
[    1.371340] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.373845] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    1.375854] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    1.379461] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    1.391576] pci 0000:00:01.1: reg 0x20: [io  0xc1c0-0xc1cf]
[    1.395132] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    1.398161] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    1.400903] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    1.404224] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    1.405417] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    1.408770] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    1.411814] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    1.415417] pci 0000:00:02.0: [1af4:1000] type 00 class 0x020000
[    1.419241] pci 0000:00:02.0: reg 0x10: [io  0xc180-0xc19f]
[    1.422801] pci 0000:00:02.0: reg 0x14: [mem 0xfc052000-0xfc052fff]
[    1.439343] pci 0000:00:02.0: reg 0x20: [mem 0xfebf0000-0xfebf3fff 64bit pref]
[    1.443859] pci 0000:00:02.0: reg 0x30: [mem 0xfc000000-0xfc03ffff pref]
[    1.446059] pci 0000:00:03.0: [1b36:0100] type 00 class 0x030000
[    1.456854] pci 0000:00:03.0: reg 0x10: [mem 0xf0000000-0xf7ffffff]
[    1.476971] pci 0000:00:03.0: reg 0x14: [mem 0xf8000000-0xfbffffff]
[    1.486852] pci 0000:00:03.0: reg 0x18: [mem 0xfc050000-0xfc051fff]
[    1.496981] pci 0000:00:03.0: reg 0x1c: [io  0xc1a0-0xc1bf]
[    1.517343] pci 0000:00:03.0: reg 0x30: [mem 0xfc040000-0xfc04ffff pref]
[    1.520730] pci 0000:00:04.0: [1af4:1001] type 00 class 0x010000
[    1.538703] pci 0000:00:04.0: reg 0x10: [io  0xc000-0xc07f]
[    1.545102] pci 0000:00:04.0: reg 0x14: [mem 0xfc053000-0xfc053fff]
[    1.565099] pci 0000:00:04.0: reg 0x20: [mem 0xfebf4000-0xfebf7fff 64bit pref]
[    1.576568] pci 0000:00:05.0: [1af4:1001] type 00 class 0x010000
[    1.585100] pci 0000:00:05.0: reg 0x10: [io  0xc080-0xc0ff]
[    1.596868] pci 0000:00:05.0: reg 0x14: [mem 0xfc054000-0xfc054fff]
[    1.622083] pci 0000:00:05.0: reg 0x20: [mem 0xfebf8000-0xfebfbfff 64bit pref]
[    1.633211] pci 0000:00:06.0: [1af4:1001] type 00 class 0x010000
[    1.641496] pci 0000:00:06.0: reg 0x10: [io  0xc100-0xc17f]
[    1.648421] pci 0000:00:06.0: reg 0x14: [mem 0xfc055000-0xfc055fff]
[    1.675155] pci 0000:00:06.0: reg 0x20: [mem 0xfebfc000-0xfebfffff 64bit pref]
[    1.688363] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    1.693985] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    1.695649] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    1.701184] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    1.705450] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
[    1.715177] pci 0000:00:03.0: vgaarb: setting as boot VGA device
[    1.720594] pci 0000:00:03.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    1.725114] pci 0000:00:03.0: vgaarb: bridge control possible
[    1.730486] vgaarb: loaded
[    1.733503] PCI: Using ACPI for IRQ routing
[    1.735109] PCI: pci_cache_line_size set to 64 bytes
[    1.740390] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    1.745108] e820: reserve RAM buffer [mem 0xbffd7000-0xbfffffff]
[    1.750560] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    1.754940] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    1.770142] clocksource: Switched to clocksource kvm-clock
[    1.799877] pnp: PnP ACPI init
[    1.802272] pnp 00:00: Plug and Play ACPI device, IDs PNP0303 (active)
[    1.807041] pnp 00:01: Plug and Play ACPI device, IDs PNP0f13 (active)
[    1.811761] pnp 00:02: [dma 2]
[    1.813999] pnp 00:02: Plug and Play ACPI device, IDs PNP0700 (active)
[    1.816903] pnp 00:03: Plug and Play ACPI device, IDs PNP0400 (active)
[    1.819656] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    1.822605] pnp 00:05: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.825794] pnp: PnP ACPI: found 6 devices
[    1.836991] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    1.840633] NET: Registered protocol family 2
[    1.842779] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    1.846793] tcp_listen_portaddr_hash hash table entries: 16384 (order: 8, 1441792 bytes, linear)
[    1.851096] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    1.855669] TCP bind hash table entries: 65536 (order: 10, 5242880 bytes, vmalloc)
[    1.860823] TCP: Hash tables configured (established 262144 bind 65536)
[    1.863652] UDP hash table entries: 16384 (order: 9, 3145728 bytes, linear)
[    1.868002] UDP-Lite hash table entries: 16384 (order: 9, 3145728 bytes, linear)
[    1.872465] NET: Registered protocol family 1
[    1.874272] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    1.876832] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    1.879430] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    1.882297] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff window]
[    1.885222] pci_bus 0000:00: resource 8 [mem 0x840000000-0x8bfffffff window]
[    1.888350] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    1.890710] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    1.893159] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    1.895802] pci 0000:00:03.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    1.899222] PCI: CLS 0 bytes, default 64
[    1.900930] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.903566] software IO TLB: mapped [mem 0x00000000bbfd7000-0x00000000bffd7000] (64MB)
[    1.923202] workingset: timestamp_bits=36 max_order=23 bucket_order=0
[    1.929473] fuse: init (API version 7.32)
[    1.931564] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    1.934601] io scheduler mq-deadline registered
[    1.936448] io scheduler kyber registered
[    2.013490] PCI Interrupt Link [LNKB] enabled at IRQ 10
[    2.089919] PCI Interrupt Link [LNKD] enabled at IRQ 11
[    2.168560] PCI Interrupt Link [LNKA] enabled at IRQ 10
[    2.252429] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    2.255227] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    2.259450] Non-volatile memory driver v1.3
[    2.261370] ACPI: bus type drm_connector registered
[    2.334704] PCI Interrupt Link [LNKC] enabled at IRQ 11
[    2.337129] qxl 0000:00:03.0: vgaarb: deactivate vga console
[    2.364650] Console: switching to colour dummy device 80x25
[    2.367140] [drm] Device Version 0.0
[    2.368596] [drm] Compression level 0 log level 0
[    2.370556] [drm] 16382 io pages at offset 0x4000000
[    2.372554] [drm] 67108864 byte draw area at offset 0x0
[    2.374724] [drm] RAM header offset: 0x7ffe000
[    2.377220] [TTM] Zone  kernel: Available graphics memory: 16374868 KiB
[    2.379983] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
[    2.382680] [TTM] Initializing pool allocator
[    2.384462] [TTM] Initializing DMA pool allocator
[    2.386687] [drm] qxl: 64M of VRAM memory size
[    2.388510] [drm] qxl: 127M of IO pages memory ready (VRAM domain)
[    2.391090] [drm] qxl: 64M of Surface memory size
[    2.394531] [drm] slot 0 (main): base 0xf0000000, size 0x07ffe000
[    2.397675] [drm] slot 1 (surfaces): base 0xf8000000, size 0x04000000
[    2.400918] [drm] Initialized qxl 0.1.0 20120117 for 0000:00:03.0 on minor 0
[    2.404894] fbcon: qxldrmfb (fb0) is primary device
[    2.613231] Console: switching to colour frame buffer device 128x48
[    2.882856] qxl 0000:00:03.0: [drm] fb0: qxldrmfb frame buffer device
[    3.022781] brd: module loaded
[    3.036728] loop: module loaded
[    3.062871] virtio_blk virtio1: [vda] 41943040 512-byte logical blocks (21.5 GB/20.0 GiB)
[    3.070096] vda: detected capacity change from 0 to 21474836480
[    3.095279]  vda: vda1 vda2
[    3.116093] virtio_blk virtio2: [vdb] 83886080 512-byte logical blocks (42.9 GB/40.0 GiB)
[    3.121718] vdb: detected capacity change from 0 to 42949672960
[    3.154104] virtio_blk virtio3: [vdc] 104857600 512-byte logical blocks (53.7 GB/50.0 GiB)
[    3.157409] vdc: detected capacity change from 0 to 53687091200
[    3.174554] zram: Added device: zram0
[    3.176131] tun: Universal TUN/TAP device driver, 1.6
[    3.181282] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    3.185961] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.187991] serio: i8042 AUX port at 0x60,0x64 irq 12
[    3.190400] mousedev: PS/2 mouse device common for all mice
[    3.192765] rtc_cmos 00:05: RTC can wake from S4
[    3.196385] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    3.199996] rtc_cmos 00:05: registered as rtc0
[    3.202262] rtc_cmos 00:05: setting system clock to 2025-06-05T06:23:29 UTC (1749104609)
[    3.206031] rtc_cmos 00:05: alarms up to one day, y3k, 242 bytes nvram, hpet irqs
[    3.209552] NET: Registered protocol family 17
[    3.218707] IPI shorthand broadcast: enabled
[    3.223015] sched_clock: Marking stable (2942909925, 275676134)->(3263554832, -44968773)
[    3.231403] registered taskstats version 1
[    3.235111] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
[    3.243817] page_owner is disabled
[    3.250646] printk: console [netcon0] enabled
[    3.254543] netconsole: network logging started
[    3.258836] clk: Disabling unused clocks
[    4.104199] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input2
[    4.118473] EXT4-fs (vda2): INFO: recovery required on readonly filesystem
[    4.124798] EXT4-fs (vda2): write access will be enabled during recovery
[    4.159155] EXT4-fs (vda2): recovery complete
[    4.165097] EXT4-fs (vda2): mounted filesystem with ordered data mode. Opts: (null)
[    4.172058] VFS: Mounted root (ext4 filesystem) readonly on device 254:2.
[    4.179935] devtmpfs: mounted
[    4.187270] Freeing unused kernel image (initmem) memory: 4056K
[    4.192585] Write protecting the kernel read-only data: 24576k
[    4.200507] Freeing unused kernel image (text/rodata gap) memory: 2036K
[    4.207276] Freeing unused kernel image (rodata/data gap) memory: 416K
[    4.213085] Run /sbin/init as init process
[    4.216833]   with arguments:
[    4.218958]     /sbin/init
[    4.220841]     sched_verbose
[    4.222901]   with environment:
[    4.225057]     HOME=/
[    4.226732]     TERM=linux
[    4.228618]     selinux=0
[    4.340575] systemd[1]: Failed to find module 'autofs4'
[    4.374547] systemd[1]: systemd 256.9-2.fc41 running in system mode (+PAM +AUDIT +SELINUX -APPARMOR +IMA +SMACK +SECCOMP -GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN -IPTC +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +XKBCOMMON +UTMP +SYSVINIT +LIBARCHIVE)
[    4.409015] systemd[1]: Detected virtualization kvm.
[    4.413474] systemd[1]: Detected architecture x86-64.
[    4.431185] systemd[1]: Hostname set to <amdvm>.
[    4.756226] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[    5.153941] systemd[1]: Queued start job for default target multi-user.target.
[    5.173560] systemd[1]: Created slice system-getty.slice - Slice /system/getty.
[    5.188679] systemd[1]: Created slice system-modprobe.slice - Slice /system/modprobe.
[    5.204517] systemd[1]: Created slice system-serial\x2dgetty.slice - Slice /system/serial-getty.
[    5.221837] systemd[1]: Created slice system-sshd\x2dkeygen.slice - Slice /system/sshd-keygen.
[    5.238867] systemd[1]: Created slice system-systemd\x2dzram\x2dsetup.slice - Slice /system/systemd-zram-setup.
[    5.257195] systemd[1]: Created slice user.slice - User and Session Slice.
[    5.270469] systemd[1]: Started systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
[    5.287805] systemd[1]: Starting of proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point unsupported.
[    5.308196] systemd[1]: Expecting device dev-ttyS0.device - /dev/ttyS0...
[    5.319870] systemd[1]: Expecting device dev-zram0.device - /dev/zram0...
[    5.331654] systemd[1]: Reached target integritysetup.target - Local Integrity Protected Volumes.
[    5.347684] systemd[1]: Reached target remote-cryptsetup.target - Remote Encrypted Volumes.
[    5.363226] systemd[1]: Reached target remote-fs.target - Remote File Systems.
[    5.376339] systemd[1]: Reached target slices.target - Slice Units.
[    5.387984] systemd[1]: Reached target veritysetup.target - Local Verity Protected Volumes.
[    5.406529] systemd[1]: Listening on systemd-coredump.socket - Process Core Dump Socket.
[    5.423510] systemd[1]: Listening on systemd-creds.socket - Credential Encryption/Decryption.
[    5.439499] systemd[1]: Listening on systemd-initctl.socket - initctl Compatibility Named Pipe.
[    5.456560] systemd[1]: Listening on systemd-journald-audit.socket - Journal Audit Socket.
[    5.472257] systemd[1]: Listening on systemd-journald-dev-log.socket - Journal Socket (/dev/log).
[    5.488499] systemd[1]: Listening on systemd-journald.socket - Journal Sockets.
[    5.502044] systemd[1]: Listening on systemd-mountfsd.socket - DDI File System Mounter Socket.
[    5.517956] systemd[1]: Listening on systemd-nsresourced.socket - Namespace Resource Manager Socket.
[    5.534273] systemd[1]: systemd-oomd.socket - Userspace Out-Of-Memory (OOM) Killer Socket was skipped because of an unmet condition check (ConditionPathExists=/proc/pressure/memory).
[    5.549068] systemd[1]: systemd-pcrextend.socket - TPM PCR Measurements was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    5.558918] systemd[1]: systemd-pcrlock.socket - Make TPM PCR Policy was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    5.568226] systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
[    5.581004] systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
[    5.593728] systemd[1]: Listening on systemd-userdbd.socket - User Database Manager Socket.
[    5.610248] systemd[1]: Mounting dev-hugepages.mount - Huge Pages File System...
[    5.628240] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue File System...
[    5.644827] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug File System...
[    5.661199] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace File System...
[    5.675525] systemd[1]: kmod-static-nodes.service - Create List of Static Device Nodes was skipped because of an unmet condition check (ConditionFileNotEmpty=/lib/modules/5.10.238-00267-g01e7e36b8606/modules.devname).
[    5.694286] systemd[1]: Starting modprobe@configfs.service - Load Kernel Module configfs...
[    5.709009] systemd[1]: Starting modprobe@dm_mod.service - Load Kernel Module dm_mod...
[    5.725796] systemd[1]: Starting modprobe@drm.service - Load Kernel Module drm...
[    5.741570] systemd[1]: Starting modprobe@efi_pstore.service - Load Kernel Module efi_pstore...
[    5.760544] systemd[1]: Starting modprobe@fuse.service - Load Kernel Module fuse...
[    5.776893] systemd[1]: Starting modprobe@loop.service - Load Kernel Module loop...
[    5.793303] systemd[1]: Starting systemd-fsck-root.service - File System Check on Root Device...
[    5.809356] systemd[1]: systemd-hibernate-clear.service - Clear Stale Hibernate Storage Info was skipped because of an unmet condition check (ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
[    5.834391] systemd[1]: Starting systemd-journald.service - Journal Service...
[    5.849706] systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
[    5.864399] systemd[1]: Starting systemd-network-generator.service - Generate network units from Kernel command line...
[    5.865585] systemd-journald[179]: Collecting audit messages is enabled.
[    5.885065] systemd[1]: systemd-pcrmachine.service - TPM PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    5.903932] systemd[1]: Starting systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully...
[    5.925661] systemd[1]: systemd-tpm2-setup-early.service - Early TPM SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    5.942238] systemd[1]: Starting systemd-udev-load-credentials.service - Load udev Rules from Credentials...
[    5.965329] systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
[    5.983712] systemd[1]: Starting systemd-vconsole-setup.service - Virtual Console Setup...
[    6.006737] systemd[1]: Started systemd-journald.service - Journal Service.
[    6.017530] audit: type=1130 audit(1749104612.310:2): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    6.212416] audit: type=1130 audit(1749104612.500:3): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@configfs comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    6.229498] audit: type=1131 audit(1749104612.500:4): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@configfs comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    6.374988] audit: type=1130 audit(1749104612.660:5): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@dm_mod comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    6.392052] audit: type=1131 audit(1749104612.660:6): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@dm_mod comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    6.444462] audit: type=1130 audit(1749104612.730:7): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@drm comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    6.461994] audit: type=1131 audit(1749104612.730:8): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@drm comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    6.515921] audit: type=1130 audit(1749104612.800:9): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@efi_pstore comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    6.533060] audit: type=1131 audit(1749104612.810:10): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@efi_pstore comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    6.584515] audit: type=1130 audit(1749104612.870:11): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@fuse comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    7.216586] EXT4-fs (vda2): re-mounted. Opts: (null)
[    7.326190] systemd-journald[179]: Received client request to flush runtime journal.
[    7.336586] systemd-journald[179]: File /var/log/journal/cdd3633d1db54c31b12b5f6ef51577f4/system.journal corrupted or uncleanly shut down, renaming and replacing.
[    7.986766] virtio_net virtio0 enp0s2: renamed from eth0
[    8.039419] zram0: detected capacity change from 0 to 8589934592
[    9.815875] Adding 8388604k swap on /dev/zram0.  Priority:100 extents:1 across:8388604k SSDsc
[   21.738108] systemd-journald[179]: File /var/log/journal/cdd3633d1db54c31b12b5f6ef51577f4/user-1000.journal corrupted or uncleanly shut down, renaming and replacing.
[   26.531718] BUG: kernel NULL pointer dereference, address: 0000000000000168
[   26.538093] #PF: supervisor read access in kernel mode
[   26.542727] #PF: error_code(0x0000) - not-present page
[   26.548093] PGD 10f3e9067 P4D 10f332067 PUD 10f0c5067 PMD 0
[   26.553211] Oops: 0000 [#1] SMP NOPTI
[   26.556531] CPU: 2 PID: 541 Comm: main Not tainted 5.10.238-00267-g01e7e36b8606 #63
[   26.563816] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   26.572357] RIP: 0010:__mark_chain_precision+0x24b/0x4d0
[   26.576572] Code: 51 01 be 20 00 00 00 4c 89 ef 48 63 d2 e8 bd df 31 00 89 c1 83 f8 1f 7f 29 48 63 d1 48 89 d0 48 c1 e0 04 48 29 d0 48 8d 04 c3 <83> 38 01 75 c3 0f b6 74 24 06 80 78 74 00 c6 40 74 01 44 0f 44 f6
[   26.589100] RSP: 0018:ffa0000000ff7b60 EFLAGS: 00010216
[   26.592612] RAX: 0000000000000168 RBX: 0000000000000000 RCX: 0000000000000003
[   26.597416] RDX: 0000000000000003 RSI: 0000000000000020 RDI: ffa0000000ff7b78
[   26.601362] RBP: 0000000000000003 R08: ffa0000000ff7b70 R09: 0000000000000004
[   26.604261] R10: 0000000000000007 R11: ffa0000000425000 R12: ff11000102ee2000
[   26.607202] R13: ffa0000000ff7b78 R14: 0000000000000000 R15: ff1100010ee37140
[   26.610327] FS:  00000000007a0630(0000) GS:ff1100081c400000(0000) knlGS:0000000000000000
[   26.613678] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   26.616105] CR2: 0000000000000168 CR3: 0000000115e72002 CR4: 0000000000371ee0
[   26.619059] Call Trace:
[   26.620118]  adjust_reg_min_max_vals+0x133/0x340
[   26.622048]  ? krealloc+0x63/0xe0
[   26.623435]  do_check+0x38c/0xa80
[   26.624859]  do_check_common+0x15b/0x280
[   26.626496]  bpf_check+0xbe1/0xd30
[   26.627939]  ? srso_alias_return_thunk+0x5/0x7f
[   26.629796]  ? trace_hardirqs_on+0x1a/0xd0
[   26.631503]  ? srso_alias_return_thunk+0x5/0x7f
[   26.633402]  bpf_prog_load+0x422/0x8a0
[   26.634987]  ? srso_alias_return_thunk+0x5/0x7f
[   26.636864]  ? __handle_mm_fault+0x3cb/0x6d0
[   26.638658]  ? srso_alias_return_thunk+0x5/0x7f
[   26.640543]  ? lock_release+0xe3/0x110
[   26.642114]  __do_sys_bpf+0x485/0xdf0
[   26.643624]  do_syscall_64+0x33/0x40
[   26.645110]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
[   26.647190] RIP: 0033:0x409a6e
[   26.648470] Code: 24 28 44 8b 44 24 2c e9 70 ff ff ff cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 49 89 f2 48 89 fa 48 89 ce 48 89 df 0f 05 <48> 3d 01 f0 ff ff 76 15 48 f7 d8 48 89 c1 48 c7 c0 ff ff ff ff 48
[   26.656154] RSP: 002b:000000c00199edc0 EFLAGS: 00000212 ORIG_RAX: 0000000000000141
[   26.659451] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000409a6e
[   26.662375] RDX: 0000000000000098 RSI: 000000c00199f290 RDI: 0000000000000005
[   26.665267] RBP: 000000c00199ee00 R08: 0000000000000000 R09: 0000000000000000
[   26.668204] R10: 0000000000000000 R11: 0000000000000212 R12: 0000000000000000
[   26.671125] R13: 0000000000000080 R14: 000000c000002380 R15: 8080808080808080
[   26.674085] Modules linked in:
[   26.675363] CR2: 0000000000000168
[   26.676772] ---[ end trace 3fc192ee4dabbf12 ]---
[   26.678667] RIP: 0010:__mark_chain_precision+0x24b/0x4d0
[   26.680926] Code: 51 01 be 20 00 00 00 4c 89 ef 48 63 d2 e8 bd df 31 00 89 c1 83 f8 1f 7f 29 48 63 d1 48 89 d0 48 c1 e0 04 48 29 d0 48 8d 04 c3 <83> 38 01 75 c3 0f b6 74 24 06 80 78 74 00 c6 40 74 01 44 0f 44 f6
[   26.688665] RSP: 0018:ffa0000000ff7b60 EFLAGS: 00010216
[   26.690828] RAX: 0000000000000168 RBX: 0000000000000000 RCX: 0000000000000003
[   26.693777] RDX: 0000000000000003 RSI: 0000000000000020 RDI: ffa0000000ff7b78
[   26.696680] RBP: 0000000000000003 R08: ffa0000000ff7b70 R09: 0000000000000004
[   26.699651] R10: 0000000000000007 R11: ffa0000000425000 R12: ff11000102ee2000
[   26.702561] R13: ffa0000000ff7b78 R14: 0000000000000000 R15: ff1100010ee37140
[   26.705522] FS:  00000000007a0630(0000) GS:ff1100081c400000(0000) knlGS:0000000000000000
[   26.708806] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   26.711179] CR2: 0000000000000168 CR3: 0000000115e72002 CR4: 0000000000371ee0
[   26.714143] Kernel panic - not syncing: Fatal exception
[   26.716893] Kernel Offset: disabled
[   26.718911] Rebooting in 5 seconds..


--W74xIKzLWQUpHayz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86 5.10.190 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc (Debian 12.2.0-14) 12.2.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=120200
CONFIG_LD_VERSION=240000000
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=24000
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=y
CONFIG_LOG_BUF_SHIFT=24
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
CONFIG_CGROUP_DEBUG=y
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_LSM=y
CONFIG_BPF_SYSCALL=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
# CONFIG_BPF_JIT_ALWAYS_ON is not set
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
# CONFIG_BPF_PRELOAD is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_SLUB_CPU_PARTIAL=y
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_X2APIC is not set
# CONFIG_X86_MPPARSE is not set
# CONFIG_GOLDFISH is not set
# CONFIG_X86_CPU_RESCTRL is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
CONFIG_SCHED_OMIT_FRAME_POINTER=y
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
# CONFIG_X86_MCE_INJECT is not set
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
# CONFIG_MICROCODE_LATE_LOADING is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
# CONFIG_X86_PMEM_LEGACY is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_EFI is not set
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x1000000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
# CONFIG_LEGACY_VSYSCALL_EMULATE is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
# CONFIG_LIVEPATCH is not set
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_RETPOLINE=y
CONFIG_RETHUNK=y
CONFIG_CPU_UNRET_ENTRY=y
CONFIG_CPU_IBPB_ENTRY=y
CONFIG_CPU_IBRS_ENTRY=y
CONFIG_CPU_SRSO=y
# CONFIG_SLS is not set
# CONFIG_GDS_FORCE_MITIGATION is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_HIBERNATION is not set
# CONFIG_PM is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
# CONFIG_ACPI_EC_DEBUGFS is not set
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
# CONFIG_ACPI_BUTTON is not set
# CONFIG_ACPI_TINY_POWER_BUTTON is not set
# CONFIG_ACPI_FAN is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
# CONFIG_ACPI_THERMAL is not set
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_NFIT is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_ACPI_DPTF is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y
# CONFIG_SFI is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
# CONFIG_CPU_FREQ_STAT is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_P4_CLOCKMOD is not set

#
# shared options
#
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DMIID is not set
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_ARCH_HAS_CPU_FINALIZE_INIT=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
# CONFIG_SECCOMP is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_UNUSED_SYMBOLS=y
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
# CONFIG_BLK_DEV_INTEGRITY is not set
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_DEV_THROTTLING is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
CONFIG_ZSMALLOC=y
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
# CONFIG_ZONE_DEVICE is not set
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_BENCHMARK is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=y
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=y
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TABLE_PERTURB_ORDER=16
# CONFIG_INET_DIAG is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IPV6 is not set
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
# CONFIG_BPF_STREAM_PARSER is not set
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_WIRELESS is not set
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_FAILOVER=y
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
# CONFIG_PCIEAER is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
# CONFIG_VMD is not set

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# CONFIG_FW_LOADER_COMPRESS is not set
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

# CONFIG_CONNECTOR is not set
# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=y
# CONFIG_ZRAM_WRITEBACK is not set
# CONFIG_ZRAM_MEMORY_TRACKING is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=y
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_PVPANIC is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
# CONFIG_SCSI is not set
# end of SCSI device support

# CONFIG_ATA is not set
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=y
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=y
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

# CONFIG_ETHERNET is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_PHYLIB is not set
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
# CONFIG_WLAN is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=y
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set
# CONFIG_INPUT_SPARSEKMAP is not set
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
# CONFIG_SERIAL_8250_LPSS is not set
# CONFIG_SERIAL_8250_MID is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
# CONFIG_HW_RANDOM_INTEL is not set
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=y
# CONFIG_RAW_DRIVER is not set
# CONFIG_DEVPORT is not set
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_HPET_MMAP_DEFAULT=y
# CONFIG_HANGCHECK_TIMER is not set
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
# CONFIG_XILLYBUS is not set
CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_ACPI_I2C_OPREGION is not set
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
# CONFIG_I2C_CHARDEV is not set
# CONFIG_I2C_MUX is not set
# CONFIG_I2C_HELPER_AUTO is not set
# CONFIG_I2C_SMBUS is not set

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
# CONFIG_PPS is not set

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

# CONFIG_PINCTRL is not set
# CONFIG_GPIOLIB is not set
# CONFIG_W1 is not set
# CONFIG_POWER_RESET is not set
# CONFIG_POWER_SUPPLY is not set
# CONFIG_HWMON is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
# CONFIG_X86_PKG_TEMP_THERMAL is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
# CONFIG_RC_CORE is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=1
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
# CONFIG_DRM_DEBUG_MM is not set
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=y
CONFIG_DRM_TTM_DMA_PAGE_POOL=y
CONFIG_DRM_TTM_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=y
# CONFIG_DRM_BOCHS is not set
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
# CONFIG_BACKLIGHT_CLASS_DEVICE is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

# CONFIG_LOGO is not set
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
# CONFIG_HID is not set

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
# end of I2C HID support

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
# CONFIG_USB_SUPPORT is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8523 is not set
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8010 is not set
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_PCF2127 is not set
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_DS2404 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
# CONFIG_VFIO is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
# CONFIG_VIRTIO_PCI_LEGACY is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_MEM=m
CONFIG_VIRTIO_INPUT=y
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=y
# CONFIG_VDPA is not set
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_STAGING is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

# CONFIG_RAS is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

# CONFIG_LIBNVDIMM is not set
# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
# CONFIG_EXT4_FS_SECURITY is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
CONFIG_OVERLAY_FS_INDEX=y
CONFIG_OVERLAY_FS_XINO_AUTO=y
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
# CONFIG_CONFIGFS_FS is not set
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_EVM is not set
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_STACK_ALL_PATTERN is not set
# CONFIG_INIT_STACK_ALL_ZERO is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_ACOMP2=y
# CONFIG_CRYPTO_MANAGER is not set
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_PCRYPT is not set
# CONFIG_CRYPTO_CRYPTD is not set
# CONFIG_CRYPTO_AUTHENC is not set
# CONFIG_CRYPTO_TEST is not set

#
# Public-key cryptography
#
# CONFIG_CRYPTO_RSA is not set
# CONFIG_CRYPTO_DH is not set
# CONFIG_CRYPTO_ECDH is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_SEQIV is not set
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
# CONFIG_CRYPTO_CBC is not set
# CONFIG_CRYPTO_CFB is not set
# CONFIG_CRYPTO_CTR is not set
# CONFIG_CRYPTO_CTS is not set
# CONFIG_CRYPTO_ECB is not set
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_OFB is not set
# CONFIG_CRYPTO_PCBC is not set
# CONFIG_CRYPTO_XTS is not set
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_ESSIV is not set

#
# Hash modes
#
# CONFIG_CRYPTO_CMAC is not set
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
# CONFIG_CRYPTO_CRC32 is not set
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
# CONFIG_CRYPTO_XXHASH is not set
# CONFIG_CRYPTO_BLAKE2B is not set
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
# CONFIG_CRYPTO_CRCT10DIF is not set
# CONFIG_CRYPTO_GHASH is not set
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
CONFIG_CRYPTO_SHA256=y
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
# CONFIG_CRYPTO_AES_NI_INTEL is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAMELLIA_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
# CONFIG_CRYPTO_SM4 is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_TWOFISH_X86_64 is not set
# CONFIG_CRYPTO_TWOFISH_X86_64_3WAY is not set
# CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
# CONFIG_CRYPTO_DRBG_MENU is not set
# CONFIG_CRYPTO_JITTERENTROPY is not set
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_HW is not set

#
# Certificates for signature checking
#
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
# CONFIG_CORDIC is not set
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_LIB_MEMNEQ=y
# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=y
# CONFIG_CRC_T10DIF is not set
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
# CONFIG_LIBCRC32C is not set
# CONFIG_CRC8 is not set
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_XARRAY_MULTI=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_CMA is not set
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
# CONFIG_IRQ_POLL is not set
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_DYNAMIC_DEBUG_CORE is not set
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
CONFIG_DEBUG_INFO_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
CONFIG_READABLE_ASM=y
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# CONFIG_KCSAN is not set
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
# CONFIG_DEBUG_VM_RB is not set
# CONFIG_DEBUG_VM_PGFLAGS is not set
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=5
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=1
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
CONFIG_PROVE_RAW_LOCK_NESTING=y
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
# CONFIG_FUNCTION_PROFILER is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_FTRACE_SYSCALLS is not set
# CONFIG_TRACER_SNAPSHOT is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_SYNTH_EVENTS is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
# CONFIG_X86_VERBOSE_BOOTUP is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--W74xIKzLWQUpHayz--

