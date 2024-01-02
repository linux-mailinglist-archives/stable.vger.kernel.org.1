Return-Path: <stable+bounces-9173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 374F08219B3
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 11:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F2F282ECD
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 10:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DF6D27F;
	Tue,  2 Jan 2024 10:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TS5eOXNQ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863BDDDA7
	for <stable@vger.kernel.org>; Tue,  2 Jan 2024 10:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704191372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2A/k3NwCeVAup3mVWkxBmzDW6zyEIqnjTkrSFsMu7FM=;
	b=TS5eOXNQCQqKk/r9Ds+ortmy6Z/q1nPdWE6QimHwaPr5XqchsAGUdsgh8eH/z0JBfYiU27
	CgMqT4snScdNYvYRwmaED2A0eKfgQhgEogwkAXqum/KCxFk6E4i5TPmo/dfXOiQeBg7R2h
	+9TI5e7mRs3MAqT074HZOAwSdWuyh7E=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-s6Z6NNtLN9-NfSislhV6Yg-1; Tue, 02 Jan 2024 05:29:31 -0500
X-MC-Unique: s6Z6NNtLN9-NfSislhV6Yg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-28b3b3633f2so4058155a91.0
        for <stable@vger.kernel.org>; Tue, 02 Jan 2024 02:29:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704191370; x=1704796170;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2A/k3NwCeVAup3mVWkxBmzDW6zyEIqnjTkrSFsMu7FM=;
        b=GcnYuWf3b99NDfSzqwKVJgUwxbrf+puy5ME2fr5tY33L9fXdhyqcBZLf8OmNTMHKGJ
         NJy3aw5M3kXfTGO2GrQ50l6Fc06z3Rkw0afqJa9LzJ6+2XSSD4yKew487n+zW3lBTBnd
         qWxk/fdls3n+G7VmA/lLBDUXNGNYVrsyVA8j4+9TGNxi5L7621329BRjyXQ2mz0yC6fs
         xZYqb/Lv14b4lchmuU3eNquNMFqGCKE4AzJ/KD3zss5kyMA9UzrkKq5BEPRXjTqjxy9n
         PWe7tgt5e0kx/262y5RxfS98SFwuVhMai/ZwvZMQYf/dKXK287+Xnvn8aVIqK7/tzUAF
         7cBA==
X-Gm-Message-State: AOJu0YzHggaVtidLxEjRlGVoNWXPxV0ndixG7/VoQVj6VGYV2A3hfSuG
	rhoeSEX0SjWfrujokrDGHxtcFcQp6z9mxpcXoTCPbVYALcoRMGp2gP79JspePsW1ry5sjuHsi1M
	XSlQ7itAB9oLxVynDcKtqRe0Y
X-Received: by 2002:a17:90a:f40e:b0:28c:e568:5ebd with SMTP id ch14-20020a17090af40e00b0028ce5685ebdmr17129pjb.37.1704191370059;
        Tue, 02 Jan 2024 02:29:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExqlIDJkWXxAfGwgPdJEztWa7yaf98XBDHih7D2UIVxxIYpgEuw4kSSnbOhNNofbKAUPAVew==
X-Received: by 2002:a17:90a:f40e:b0:28c:e568:5ebd with SMTP id ch14-20020a17090af40e00b0028ce5685ebdmr17121pjb.37.1704191369711;
        Tue, 02 Jan 2024 02:29:29 -0800 (PST)
Received: from localhost ([195.166.127.210])
        by smtp.gmail.com with ESMTPSA id pv1-20020a17090b3c8100b0028cd86f321fsm2556660pjb.43.2024.01.02.02.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 02:29:29 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Zack Rusin <zack.rusin@broadcom.com>, dri-devel@lists.freedesktop.org
Cc: Martin Krastev <martin.krastev@broadcom.com>, stable@vger.kernel.org,
 Ian Forbes <ian.forbes@broadcom.com>, Maaz Mombasawala
 <maaz.mombasawala@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Stefan Hoffmeister
 <stefan.hoffmeister@econos.de>
Subject: Re: [PATCH] drm/vmwgfx: Unmap the surface before resetting it on a
 plane state
In-Reply-To: <20231224052540.605040-1-zack.rusin@broadcom.com>
References: <20231224052540.605040-1-zack.rusin@broadcom.com>
Date: Tue, 02 Jan 2024 11:29:23 +0100
Message-ID: <87r0j03u64.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zack Rusin <zack.rusin@broadcom.com> writes:

Hello Zack,

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

I'm not familiar with this driver but your explanation in the commit
message is very clear and from inspecting the code, the change looks
correct to me.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


