Return-Path: <stable+bounces-152691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999A2ADA8EE
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 09:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BAC416EC75
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 07:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577C61EB5C2;
	Mon, 16 Jun 2025 07:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="H3pHJRfV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1981E2823
	for <stable@vger.kernel.org>; Mon, 16 Jun 2025 07:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750057600; cv=none; b=txr4cM4cqXu7fonSF4LgdnLoiBHYKr7jikL2LX33I3XN5d51RM/WUBgWYSbNgvXIZ2wEnbSEcy2x9LgjtKMwxKnwBf0Tp6+0V5kvJaGjtqgSGmj39rm08hiugFh2yg4DMi27KJDvGx8YTClAcg1iUIYo4ivJPmnNyU7sE+R8cPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750057600; c=relaxed/simple;
	bh=EY+UxwT00Gxvd9RoM4wjPsUbsXoeX+8OSIw5twx9HiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7dFjOO2ctgL+QMMDps98reLiGJfRuFDFqYOuH965wPHBEJyugOEJ+urnIYcwRfXSrpBAStWXvLH+/60eae54cn2HbnZZawWgw5+tpdtsbvOMuIu6eO7j0/zMKkktVNODV/F5kcvTQr7Pa5aeivdC/sHZ79KDF40gZi9qLUz29k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=H3pHJRfV; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74800b81f1bso3324968b3a.1
        for <stable@vger.kernel.org>; Mon, 16 Jun 2025 00:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1750057595; x=1750662395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Way777zanj1AHSsRn1x5PFAgeudOHL+X1/Lx0w9Odik=;
        b=H3pHJRfVh4vjBshhOIorEvuWJdTIbYC0J2GKKMKPufosTigQlb1LbvA4IlbJS9fp8W
         MhclB4oSPUyXaY7b3jHLR+RU/IcyACHe/WaVE9yx1CHVo4GYiNxbXpit/YpIIN1bFO90
         8Fqn243WUDOaMZVf1msH57kFaTKuL/pbSvpjDq6J+V/NlCAzIuVg0mlqP0WoUT9gawdw
         RtW3qblaiguf3MrZd+dYLrBy97ANPyh6BBsgtFfMo6kHJJ20mX/iGqFD/Jc/cJoCsK+W
         V3udK/yrXPIO/f5E9d7UBstA8+UlOF62CRv1eAPbhIEdIwxvTkWY8JR0jPK+Y9h8o2TE
         oXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750057595; x=1750662395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Way777zanj1AHSsRn1x5PFAgeudOHL+X1/Lx0w9Odik=;
        b=eUpzJIuRGqpAcyIiJl4OQXaaUvIVqVMk3dNwPpEaNKeXzJG5KuUN0ki6DkuXhoxs0M
         DMJWUq31ijuaIiNhbaJQCzfOurpNUguPgeEhq4RNSaJd2V6kJPFSIbKpMBIdBXsPS2ZV
         GLgdZGQwJbkqAn1s2P7eo1775Gy3l9raOMrZMCbVfAnql1zdU8DwqcQoar6K7artwqWl
         ZJounQBCuewf6g1lgQjaLNpBR1IUpZM7qY+gaHM8fA/zBzr8L8pXgqz7B5tsAv7Bqs4C
         F9Sws+Jc+xlI3x1PsyuIM4Mml2qlKiaR+4SaU0zGAfK8ccUpVxp6QjTYGHaz3+K08PZS
         qWhA==
X-Forwarded-Encrypted: i=1; AJvYcCW1X4KCZLLLNhYgkmC5ipx72eh9H4sV/kiZbEtdgJC3RHw7R3P2Kn1nCcV54KpUF3DW+s2oKtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqIHDVUtNHU+CPaYeogX66Wff/T3XXLZbbXvwoukIDMNmwinuj
	6ULZfqBQrGAaTlzr1irYhhbKYcP0Bn1Q7NMV+w5jqed4BL9DqbOSOzyoOusRTtpMGQ==
X-Gm-Gg: ASbGncuUEJYZZiXUm9PAG3YuuIS3B3gfLkuzv7csHcnuTCxi9pEbpSaghTt0rMQlp66
	lWgvacKJpiWsLFoIQaoj8dzzfif1ldPReTbjNVrXzXk33e+dwF6Td/m7+UwAjve8J08aGZpFxA7
	/l9EleFIH09LPvheilE6EmkRUbZGqwEuH8TFPxBCkWF0trfTjV3dFWJzQjWgB+s4TqmvDWJMhj+
	bvFDNAfn8cbJAuMYGEnd6li6fHmwrRWRmVDcqO58+Xya8f10uUcj7Gulc/BiKYV0F5huy9za7AQ
	88lI+srdxMEcF1V57aCjvKJrj1sTq5hM/YZOLYheBecaBGozH9BstdW1bK3zHo+OHxC70C+I2eO
	XOL6D9jo=
X-Google-Smtp-Source: AGHT+IH0AlOJywJqDHH8Kvr9xW10HB4S0RWDEkl7D8xlyHlFLTBnNd5ciw+WuDP3F2xbMPSohZb6nQ==
X-Received: by 2002:a05:6a00:22cf:b0:736:4fe0:2661 with SMTP id d2e1a72fcca58-7489cfbb83fmr9769152b3a.11.1750057595571;
        Mon, 16 Jun 2025 00:06:35 -0700 (PDT)
Received: from bytedance ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffee55bsm6023795b3a.1.2025.06.16.00.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 00:06:35 -0700 (PDT)
Date: Mon, 16 Jun 2025 15:06:17 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Pu Lehui <pulehui@huawei.com>,
	Luiz Capitulino <luizcap@amazon.com>,
	Wei Wei <weiwei.danny@bytedance.com>,
	Yuchen Zhang <zhangyuchen.lcr@bytedance.com>
Subject: Re: Host panic in bpf verifier when loading bpf prog in 5.10 stable
 kernel
Message-ID: <20250616070617.GA66@bytedance>
References: <20250605070921.GA3795@bytedance>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605070921.GA3795@bytedance>

Ping?

On Thu, Jun 05, 2025 at 03:09:21PM +0800, Aaron Lu wrote:
> Hello,
> 
> Wei reported when loading his bpf prog in 5.10.200 kernel, host would
> panic, this didn't happen in 5.10.135 kernel. Test on latest v5.10.238
> still has this panic.

If a fix is not easy for these stable kernels, I think we should revert
this commit? Because for whatever bpf progs, the bpf verifier should not
panic the kernel.

Regarding revert, per my test, the following four commits in linux-5.10.y
branch have to be reverted and after that, the kernel does not panic
anymore:
commit 2474ec58b96d("bpf: allow precision tracking for programs with subprogs")
commit 7ca3e7459f4a("bpf: stop setting precise in current state")
commit 1952a4d5e4cf("bpf: aggressively forget precise markings during
state checkpointing")
commit 4af2d9ddb7e7("selftests/bpf: make test_align selftest more
robust")

> 
> [   26.531718] BUG: kernel NULL pointer dereference, address: 0000000000000168
> [   26.538093] #PF: supervisor read access in kernel mode
> [   26.542727] #PF: error_code(0x0000) - not-present page
> [   26.548093] PGD 10f3e9067 P4D 10f332067 PUD 10f0c5067 PMD 0
> [   26.553211] Oops: 0000 [#1] SMP NOPTI
> [   26.556531] CPU: 2 PID: 541 Comm: main Not tainted 5.10.238-00267-g01e7e36b8606 #63
> [   26.563816] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [   26.572357] RIP: 0010:__mark_chain_precision+0x24b/0x4d0
> [   26.576572] Code: 51 01 be 20 00 00 00 4c 89 ef 48 63 d2 e8 bd df 31 00 89 c1 83 f8 1f 7f 29 48 63 d1 48 89 d0 48 c1 e0 04 48 29 d0 48 8d 04 c3 <83> 38 01 75 c3 0f b6 74 24 06 80 78 74 00 c6 40 74 01 44 0f 44 f6
> [   26.589100] RSP: 0018:ffa0000000ff7b60 EFLAGS: 00010216
> [   26.592612] RAX: 0000000000000168 RBX: 0000000000000000 RCX: 0000000000000003
> [   26.597416] RDX: 0000000000000003 RSI: 0000000000000020 RDI: ffa0000000ff7b78
> [   26.601362] RBP: 0000000000000003 R08: ffa0000000ff7b70 R09: 0000000000000004
> [   26.604261] R10: 0000000000000007 R11: ffa0000000425000 R12: ff11000102ee2000
> [   26.607202] R13: ffa0000000ff7b78 R14: 0000000000000000 R15: ff1100010ee37140
> [   26.610327] FS:  00000000007a0630(0000) GS:ff1100081c400000(0000) knlGS:0000000000000000
> [   26.613678] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   26.616105] CR2: 0000000000000168 CR3: 0000000115e72002 CR4: 0000000000371ee0
> [   26.619059] Call Trace:
> [   26.620118]  adjust_reg_min_max_vals+0x133/0x340
> [   26.622048]  ? krealloc+0x63/0xe0
> [   26.623435]  do_check+0x38c/0xa80
> [   26.624859]  do_check_common+0x15b/0x280
> [   26.626496]  bpf_check+0xbe1/0xd30
> [   26.627939]  ? srso_alias_return_thunk+0x5/0x7f
> [   26.629796]  ? trace_hardirqs_on+0x1a/0xd0
> [   26.631503]  ? srso_alias_return_thunk+0x5/0x7f
> [   26.633402]  bpf_prog_load+0x422/0x8a0
> [   26.634987]  ? srso_alias_return_thunk+0x5/0x7f
> [   26.636864]  ? __handle_mm_fault+0x3cb/0x6d0
> [   26.638658]  ? srso_alias_return_thunk+0x5/0x7f
> [   26.640543]  ? lock_release+0xe3/0x110
> [   26.642114]  __do_sys_bpf+0x485/0xdf0
> [   26.643624]  do_syscall_64+0x33/0x40
> [   26.645110]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
> [   26.647190] RIP: 0033:0x409a6e
> [   26.648470] Code: 24 28 44 8b 44 24 2c e9 70 ff ff ff cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 49 89 f2 48 89 fa 48 89 ce 48 89 df 0f 05 <48> 3d 01 f0 ff ff 76 15 48 f7 d8 48 89 c1 48 c7 c0 ff ff ff ff 48
> [   26.656154] RSP: 002b:000000c00199edc0 EFLAGS: 00000212 ORIG_RAX: 0000000000000141
> [   26.659451] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000409a6e
> [   26.662375] RDX: 0000000000000098 RSI: 000000c00199f290 RDI: 0000000000000005
> [   26.665267] RBP: 000000c00199ee00 R08: 0000000000000000 R09: 0000000000000000
> [   26.668204] R10: 0000000000000000 R11: 0000000000000212 R12: 0000000000000000
> [   26.671125] R13: 0000000000000080 R14: 000000c000002380 R15: 8080808080808080
> [   26.674085] Modules linked in:
> [   26.675363] CR2: 0000000000000168
> [   26.676772] ---[ end trace 3fc192ee4dabbf12 ]---
> [   26.678667] RIP: 0010:__mark_chain_precision+0x24b/0x4d0
> [   26.680926] Code: 51 01 be 20 00 00 00 4c 89 ef 48 63 d2 e8 bd df 31 00 89 c1 83 f8 1f 7f 29 48 63 d1 48 89 d0 48 c1 e0 04 48 29 d0 48 8d 04 c3 <83> 38 01 75 c3 0f b6 74 24 06 80 78 74 00 c6 40 74 01 44 0f 44 f6
> [   26.688665] RSP: 0018:ffa0000000ff7b60 EFLAGS: 00010216
> [   26.690828] RAX: 0000000000000168 RBX: 0000000000000000 RCX: 0000000000000003
> [   26.693777] RDX: 0000000000000003 RSI: 0000000000000020 RDI: ffa0000000ff7b78
> [   26.696680] RBP: 0000000000000003 R08: ffa0000000ff7b70 R09: 0000000000000004
> [   26.699651] R10: 0000000000000007 R11: ffa0000000425000 R12: ff11000102ee2000
> [   26.702561] R13: ffa0000000ff7b78 R14: 0000000000000000 R15: ff1100010ee37140
> [   26.705522] FS:  00000000007a0630(0000) GS:ff1100081c400000(0000) knlGS:0000000000000000
> [   26.708806] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   26.711179] CR2: 0000000000000168 CR3: 0000000115e72002 CR4: 0000000000371ee0
> [   26.714143] Kernel panic - not syncing: Fatal exception
> [   26.716893] Kernel Offset: disabled
> [   26.718911] Rebooting in 5 seconds..

