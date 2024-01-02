Return-Path: <stable+bounces-9223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED1A822502
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 23:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33F5B283F3F
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 22:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F42171DB;
	Tue,  2 Jan 2024 22:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UH/maBXO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A571917729
	for <stable@vger.kernel.org>; Tue,  2 Jan 2024 22:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso2696788a12.3
        for <stable@vger.kernel.org>; Tue, 02 Jan 2024 14:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704236151; x=1704840951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4SowcMGS/cxz8zwv9eFgdC73hvGSoN9UkdYSL0+83qw=;
        b=UH/maBXOL5KfQ5Mv8ysQanfNu+EXXIJPM40sHUwlgpuUfpjxGg8UbIUaAU7hrGqSN+
         7RqOpF+86MWqQX42zavDPVvVvpsguW7dpzytHsocqzx1vqA30cTODsJDfp5nKFpE3YHJ
         1nkAU+kTAmIP2n65zKs5czrKTNynWz9HcoQGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704236151; x=1704840951;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4SowcMGS/cxz8zwv9eFgdC73hvGSoN9UkdYSL0+83qw=;
        b=w5CJXhBJQraaYacq/pHBzf7pJqC5wJd3rzVAZKIHXmjvIRu6Lb32bnZT+E08GeLpr7
         7okGaTSZOfmGfueFcKyx7feuhehgjhBJ5vCnqQmzUpctqZGlciGO5+gUh9g98TZaii6W
         d0DQ+0HR2DMLzQGBDEGEm3XJ1jXkjBHLQ3jhxBsFLqZ66PtZBTNoHEjrjf9OnYu5D4eE
         Z7ZcE+3DWvrHX8UDAyObL4FHR8nv16fkLTGiXPN++vuVYKOfsFGwWt9zUkHLnGIe/T15
         c1IDkH0aTTNBD9EN9Hcp23MvUB4Ov23UT3ryFZk6Oe0TA6M3ifaohkY9U4+KFK2VZV0q
         T9VQ==
X-Gm-Message-State: AOJu0Yyv5hTUs+zQFDoMWYT23HFS4cvjcfYy1z80QV9jvjlxRoO0rpBw
	XmHFxJzC7EqLCnOSsZOg1dZ63UTi7x3l
X-Google-Smtp-Source: AGHT+IEv88HYlv6uoDUUcHkrfKcs+VOypwJCou2QEfZSFJEYrAITSr5GWljJbuzw9NsIcWFxA3BhUA==
X-Received: by 2002:a05:6a20:c601:b0:194:9750:fb9c with SMTP id gp1-20020a056a20c60100b001949750fb9cmr6732437pzb.54.1704236150889;
        Tue, 02 Jan 2024 14:55:50 -0800 (PST)
Received: from [10.20.136.39] ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id e14-20020a170902ed8e00b001d4c8eb6d8esm1807303plj.294.2024.01.02.14.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 14:55:50 -0800 (PST)
Message-ID: <72d6c2d0-03b7-41c6-92f1-027eeaf15096@broadcom.com>
Date: Tue, 2 Jan 2024 14:55:49 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vmwgfx: Unmap the surface before resetting it on a
 plane state
Content-Language: en-US
To: Zack Rusin <zack.rusin@broadcom.com>, dri-devel@lists.freedesktop.org
Cc: Stefan Hoffmeister <stefan.hoffmeister@econos.de>,
 Martin Krastev <martin.krastev@broadcom.com>,
 Ian Forbes <ian.forbes@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, stable@vger.kernel.org
References: <20231224052540.605040-1-zack.rusin@broadcom.com>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
In-Reply-To: <20231224052540.605040-1-zack.rusin@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/23/23 21:25, Zack Rusin wrote:
> Switch to a new plane state requires unreferencing of all held surfaces.
> In the work required for mob cursors the mapped surfaces started being
> cached but the variable indicating whether the surface is currently
> mapped was not being reset. This leads to crashes as the duplicated
> state, incorrectly, indicates the that surface is mapped even when
> no surface is present. That's because after unreferencing the surface
> it's perfectly possible for the plane to be backed by a bo instead of a
> surface.
>
> Reset the surface mapped flag when unreferencing the plane state surface
> to fix null derefs in cleanup. Fixes crashes in KDE KWin 6.0 on Wayland:
>
> Oops: 0000 [#1] PREEMPT SMP PTI
> CPU: 4 PID: 2533 Comm: kwin_wayland Not tainted 6.7.0-rc3-vmwgfx #2
> Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> RIP: 0010:vmw_du_cursor_plane_cleanup_fb+0x124/0x140 [vmwgfx]
> Code: 00 00 00 75 3a 48 83 c4 10 5b 5d c3 cc cc cc cc 48 8b b3 a8 00 00 00 48 c7 c7 99 90 43 c0 e8 93 c5 db ca 48 8b 83 a8 00 00 00 <48> 8b 78 28 e8 e3 f>
> RSP: 0018:ffffb6b98216fa80 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff969d84cdcb00 RCX: 0000000000000027
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff969e75f21600
> RBP: ffff969d4143dc50 R08: 0000000000000000 R09: ffffb6b98216f920
> R10: 0000000000000003 R11: ffff969e7feb3b10 R12: 0000000000000000
> R13: 0000000000000000 R14: 000000000000027b R15: ffff969d49c9fc00
> FS:  00007f1e8f1b4180(0000) GS:ffff969e75f00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000028 CR3: 0000000104006004 CR4: 00000000003706f0
> Call Trace:
>  <TASK>
>  ? __die+0x23/0x70
>  ? page_fault_oops+0x171/0x4e0
>  ? exc_page_fault+0x7f/0x180
>  ? asm_exc_page_fault+0x26/0x30
>  ? vmw_du_cursor_plane_cleanup_fb+0x124/0x140 [vmwgfx]
>  drm_atomic_helper_cleanup_planes+0x9b/0xc0
>  commit_tail+0xd1/0x130
>  drm_atomic_helper_commit+0x11a/0x140
>  drm_atomic_commit+0x97/0xd0
>  ? __pfx___drm_printfn_info+0x10/0x10
>  drm_atomic_helper_update_plane+0xf5/0x160
>  drm_mode_cursor_universal+0x10e/0x270
>  drm_mode_cursor_common+0x102/0x230
>  ? __pfx_drm_mode_cursor2_ioctl+0x10/0x10
>  drm_ioctl_kernel+0xb2/0x110
>  drm_ioctl+0x26d/0x4b0
>  ? __pfx_drm_mode_cursor2_ioctl+0x10/0x10
>  ? __pfx_drm_ioctl+0x10/0x10
>  vmw_generic_ioctl+0xa4/0x110 [vmwgfx]
>  __x64_sys_ioctl+0x94/0xd0
>  do_syscall_64+0x61/0xe0
>  ? __x64_sys_ioctl+0xaf/0xd0
>  ? syscall_exit_to_user_mode+0x2b/0x40
>  ? do_syscall_64+0x70/0xe0
>  ? __x64_sys_ioctl+0xaf/0xd0
>  ? syscall_exit_to_user_mode+0x2b/0x40
>  ? do_syscall_64+0x70/0xe0
>  ? exc_page_fault+0x7f/0x180
>  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> RIP: 0033:0x7f1e93f279ed
> Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff f>
> RSP: 002b:00007ffca0faf600 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 000055db876ed2c0 RCX: 00007f1e93f279ed
> RDX: 00007ffca0faf6c0 RSI: 00000000c02464bb RDI: 0000000000000015
> RBP: 00007ffca0faf650 R08: 000055db87184010 R09: 0000000000000007
> R10: 000055db886471a0 R11: 0000000000000246 R12: 00007ffca0faf6c0
> R13: 00000000c02464bb R14: 0000000000000015 R15: 00007ffca0faf790
>  </TASK>
> Modules linked in: snd_seq_dummy snd_hrtimer nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_ine>
> CR2: 0000000000000028
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:vmw_du_cursor_plane_cleanup_fb+0x124/0x140 [vmwgfx]
> Code: 00 00 00 75 3a 48 83 c4 10 5b 5d c3 cc cc cc cc 48 8b b3 a8 00 00 00 48 c7 c7 99 90 43 c0 e8 93 c5 db ca 48 8b 83 a8 00 00 00 <48> 8b 78 28 e8 e3 f>
> RSP: 0018:ffffb6b98216fa80 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff969d84cdcb00 RCX: 0000000000000027
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff969e75f21600
> RBP: ffff969d4143dc50 R08: 0000000000000000 R09: ffffb6b98216f920
> R10: 0000000000000003 R11: ffff969e7feb3b10 R12: 0000000000000000
> R13: 0000000000000000 R14: 000000000000027b R15: ffff969d49c9fc00
> FS:  00007f1e8f1b4180(0000) GS:ffff969e75f00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000028 CR3: 0000000104006004 CR4: 00000000003706f0
>
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> Fixes: 485d98d472d5 ("drm/vmwgfx: Add support for CursorMob and CursorBypass 4")
> Reported-by: Stefan Hoffmeister <stefan.hoffmeister@econos.de>
> Closes: https://gitlab.freedesktop.org/drm/misc/-/issues/34
> Cc: Martin Krastev <martin.krastev@broadcom.com>
> Cc: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
> Cc: Ian Forbes <ian.forbes@broadcom.com>
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v5.19+
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> index 65ed9b061753..e7bbe4b05233 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> @@ -693,6 +693,10 @@ vmw_du_cursor_plane_prepare_fb(struct drm_plane *plane,
>  	int ret = 0;
>  
>  	if (vps->surf) {
> +		if (vps->surf_mapped) {
> +			vmw_bo_unmap(vps->surf->res.guest_memory_bo);
> +			vps->surf_mapped = false;
> +		}
>  		vmw_surface_unreference(&vps->surf);
>  		vps->surf = NULL;
>  	}


LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

Thanks,

Maaz Mombasawala <maaz.mombasawala@broadcom.com>


