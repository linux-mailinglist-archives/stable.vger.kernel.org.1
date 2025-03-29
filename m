Return-Path: <stable+bounces-126994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F22FA7553C
	for <lists+stable@lfdr.de>; Sat, 29 Mar 2025 09:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712DD164E19
	for <lists+stable@lfdr.de>; Sat, 29 Mar 2025 08:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E4F49641;
	Sat, 29 Mar 2025 08:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yl72oXYm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B3F440C
	for <stable@vger.kernel.org>; Sat, 29 Mar 2025 08:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743238039; cv=none; b=WOI5SeNRcvCrfzD/y6Pmoc+t9EwFugWfJweBShhb5fswDtx1ZPnav0G77YKx5uF0iVKQQztgkzl0uutdwj2SOabHzocT6dq/xlyliO+j31HlRqOOdRFpy5nDETbQs/Rqp6pB4ASH4gOKldrw1qhUFubXHO+VHyOOTlFttBmB1us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743238039; c=relaxed/simple;
	bh=UPs6afNysjVF8h/3+Y75VzGR39u1ywbOKXOZ8qPthPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bycp0KMhXQEWJJdAht/UuVxR+wLK2kbXSoXe/mQ40nA9ZONMLTXh0b58mFKs6FAsWOcYNeMM/C/Fo/oXs85lyptNoBo+Eww5fIfAxQIJPlwjpJKZ+nD8GgNmBMGhHLR6nWPUBSYM0jmVokqJxvqntfQldVayWcuzQt7mil+rYDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yl72oXYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E826C4CEEB
	for <stable@vger.kernel.org>; Sat, 29 Mar 2025 08:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743238038;
	bh=UPs6afNysjVF8h/3+Y75VzGR39u1ywbOKXOZ8qPthPk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Yl72oXYmvX3q8szjT5m48a1PdMNmH1xaHw7uXm97vmDe/A/rOqwx9AhwJlARJiTQ5
	 cKUreQwSu0TNLCX18YLW8RtAH5gjsDlhwOd1bNrlUGio+7hFmeLzztfNZgKtfQkS+M
	 0FHgFP+8U37OuPibh+k2KRLZJKbiIZAik+lCiFMXXBigQ3w5dBwhieg+PwRzN+JQ8Y
	 mvjC7oD/19rUgmu27p97DONxJD46PBltYErTa3uPvOQfOqhtI7bOMosSSV/y9ED6fv
	 7KNt24Go47baUNCwgJU36o6V3AZjNCXxEj7rRJ56pZQZUpPr0m4kBP9b2XnQUyYmRF
	 8iKmslesaY+pA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso576703466b.0
        for <stable@vger.kernel.org>; Sat, 29 Mar 2025 01:47:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAF6iu4v8yPsjaHmJx37fYuK3bGFtv1NMe6rLwJEDACiwokC9kz1JcXBpLxR2hhg+CMZxMTVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQebRmVBgSwAjwSmyBt1pP1wMfEbqvgAv5sHOzPZR1Xt+UsheJ
	JWT7fYxFx0Uzw1cdnSYsWrxpd9tbNWo5NdpwFziWcBllr0Zf6U+ppxPGtSUJdzkmia013mXJpA8
	SW1yc4fbK8j0L5FJysG85bP7oCi0=
X-Google-Smtp-Source: AGHT+IF0VwJJywkU/wSFDVMa3zB1GXQY8Jsc1CaI8i6cr3LbAsmuDOEj58wnqyoF+ZyYAKx5PRb6WxKG7WyUuzAv8Tc=
X-Received: by 2002:a17:907:9693:b0:ac3:3fe4:3378 with SMTP id
 a640c23a62f3a-ac738a0d30bmr188620766b.12.1743238036967; Sat, 29 Mar 2025
 01:47:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318111717.2161235-1-chenhuacai@loongson.cn>
 <b8c481f2-a280-4f86-8080-2c6dcffc4629@amd.com> <CAAhV-H7cch+koOSJAFe70c8Pk02snK7M=andyfwbCgiNdg4aVg@mail.gmail.com>
 <87d0601b-c1cb-402b-aecd-23a5d371da66@amd.com> <712b77ef-c7f7-47a4-9609-47b179f15662@amd.com>
 <CAAhV-H6AMm1X4zyhj7-jqiaCpd-Yfco88d4KODd5_jUfhyi8Cg@mail.gmail.com> <4a4e462a-ac83-4515-a64e-25238fb67ef2@amd.com>
In-Reply-To: <4a4e462a-ac83-4515-a64e-25238fb67ef2@amd.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 29 Mar 2025 16:47:09 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4+nxxoLrDb2rgGt_n3wZ4Pw6wOyJJWZ7+16XqLVorvJg@mail.gmail.com>
X-Gm-Features: AQ5f1JpyQoLNtPjEGukjRjzBdFnwj3P_EQtLLbLcbs6kZ5m_sAja3ipoAi8Y-2Y
Message-ID: <CAAhV-H4+nxxoLrDb2rgGt_n3wZ4Pw6wOyJJWZ7+16XqLVorvJg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/display: Protect dml2_create()/dml2_copy()/dml2_create_copy()
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Alex Hung <alex.hung@amd.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	stable@vger.kernel.org, Austin.Zheng@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Aurabindo,

On Sat, Mar 29, 2025 at 2:27=E2=80=AFAM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
>
>
> On 2025-03-26 21:40, Huacai Chen wrote:
> > Hi, Alex,
> >
> > On Thu, Mar 27, 2025 at 8:10=E2=80=AFAM Alex Hung <alex.hung@amd.com> w=
rote:
> >>
> >> The following error messages showed up on an APU and a dGPU during tes=
ting.
> >>
> >> <3> [100.231411] BUG: sleeping function called from invalid context at
> >> include/linux/sched/mm.h:321
> >> <3> [100.231414] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid=
:
> >> 1711, name: kms_color
> >> <3> [100.231416] preempt_count: 2, expected: 0
> >> <3> [100.231417] RCU nest depth: 0, expected: 0
> >> <3> [100.231418] Preemption disabled at:
> >> <3> [100.231419] [<ffffffffc0c2843b>] dc_fpu_begin+0x2b/0xc0 [amdgpu]
> >> <4> [100.231626] CPU: 4 UID: 0 PID: 1711 Comm: kms_color Tainted: G
> >>     W          6.12.0+ #1
> >> <4> [100.231629] Tainted: [W]=3DWARN
> >> <4> [100.231631] Call Trace:
> >> <4> [100.231632]  <TASK>
> >> <4> [100.231633]  dump_stack_lvl+0x5b/0x70
> >> <4> [100.231638]  dump_stack+0x10/0x20
> >> <4> [100.231639]  __might_resched+0x170/0x1d0
> >> <4> [100.231643]  __might_sleep+0x44/0x70
> >> <4> [100.231645]  __alloc_pages_noprof+0x22f/0x370
> >> <4> [100.231649]  ___kmalloc_large_node+0x95/0x150
> >> <4> [100.231651]  ? preempt_count_add+0x4e/0xc0
> >> <4> [100.231653]  __kmalloc_large_noprof+0x1d/0xb0
> >> <4> [100.231655]  dml2_create_copy+0x27/0x60 [amdgpu]
> >> <4> [100.231827]  dc_state_create_copy+0x7e/0x170 [amdgpu]
> >> <4> [100.231995]  update_planes_and_stream_state+0x23c/0x600 [amdgpu]
> >> <4> [100.232189]  update_planes_and_stream_v2+0x22b/0x530 [amdgpu]
> >> <4> [100.232366]  ? amdgpu_dm_atomic_commit_tail+0x1310/0x4100 [amdgpu=
]
> >> <4> [100.232569]  ? commit_tail+0x96/0x140 [drm_kms_helper]
> >> <4> [100.232577]  dc_update_planes_and_stream+0x5b/0xe0 [amdgpu]
> >> <4> [100.232730]  amdgpu_dm_atomic_commit_tail+0x1fa7/0x4100 [amdgpu]
> >> <4> [100.232908]  ? stack_depot_save_flags+0x2c/0x730
> >> <4> [100.232915]  ? wait_for_completion_timeout+0x1d/0x30
> >> <4> [100.232917]  commit_tail+0x96/0x140 [drm_kms_helper]
> >> <4> [100.232923]  drm_atomic_helper_commit+0x12b/0x150 [drm_kms_helper=
]
> >> <4> [100.232927]  drm_atomic_commit+0xad/0xe0 [drm]
> >> <4> [100.232939]  ? __pfx___drm_printfn_info+0x10/0x10 [drm]
> >> <4> [100.232956]  drm_atomic_helper_set_config+0x80/0xc0 [drm_kms_help=
er]
> >> <4> [100.232961]  drm_mode_setcrtc+0x22e/0x910 [drm]
> >> <4> [100.232975]  ? kfree+0x18f/0x350
> >> <4> [100.232977]  ? __pfx_drm_mode_setcrtc+0x10/0x10 [drm]
> >> <4> [100.232987]  drm_ioctl_kernel+0xa7/0x100 [drm]
> >> <4> [100.233004]  drm_ioctl+0x29d/0x500 [drm]
> >> <4> [100.233015]  ? __pfx_drm_mode_setcrtc+0x10/0x10 [drm]
> >> <4> [100.233026]  ? _raw_spin_unlock_irqrestore+0x1f/0x40
> >> <4> [100.233029]  amdgpu_drm_ioctl+0x4b/0x80 [amdgpu]
> >> <4> [100.233131]  __x64_sys_ioctl+0x92/0xd0
> >> <4> [100.233133]  x64_sys_call+0x1205/0x20d0
> >> <4> [100.233136]  do_syscall_64+0x50/0x110
> >> <4> [100.233138]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >> <4> [100.233142] RIP: 0033:0x7fb21e71a94f
> >> <4> [100.233144] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24
> >> 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 0=
0
> >> 0f 05 <41> 89 c0 3d 00 f0 ff ff 77 1f 48 8b 44 24 18 64 48 2b 04 25 28=
 00
> >> <4> [100.233145] RSP: 002b:00007ffdd9a52e50 EFLAGS: 00000246 ORIG_RAX:
> >> 0000000000000010
> >> <4> [100.233148] RAX: ffffffffffffffda RBX: 00007ffdd9a52ee0 RCX:
> >> 00007fb21e71a94f
> >> <4> [100.233149] RDX: 00007ffdd9a52ee0 RSI: 00000000c06864a2 RDI:
> >> 0000000000000005
> >> <4> [100.233149] RBP: 00000000c06864a2 R08: 0000000000000000 R09:
> >> 00005609537f7b08
> >> <4> [100.233150] R10: 0000000000000000 R11: 0000000000000246 R12:
> >> 0000000000000000
> >> <4> [100.233151] R13: 0000000000000005 R14: 0000000000000000 R15:
> >> 00005609537e2848
> >> <4> [100.233152]  </TASK>
> > This seems caused by dml2_allocate_memory(), to fix this we can only
> > protect FPU in DML2, I can do it in the new version, but I want to
> > listen Aurabindo's opinion.
> >
> >
>
> It looks like dml21_apply_soc_bb_overrides() does have some division on
> double variables. I'm curious why we dont see this on our side. Was this
> seen on x86 or Loongson?
It is seen on Loongson.

>
> I think your approach is correct. Thanks for taking time to fix this. We
> can add it to weekly testing if you send us a patch.
V2 is sent, please take a look.
https://lore.kernel.org/dri-devel/20250327095334.3327111-1-chenhuacai@loong=
son.cn/T/#t

Huacai

