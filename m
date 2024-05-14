Return-Path: <stable+bounces-43756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAC98C4C45
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 08:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3ECDB20EAE
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 06:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90501CD2B;
	Tue, 14 May 2024 06:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0JFi8OU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFAF182AE;
	Tue, 14 May 2024 06:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715668078; cv=none; b=JWYOXXFnUoeu2EDjXV9K2E3jyA9ylDfUH7lZUFnfcHaMEWyyIjVxDfo2XaeTYCTO+3uyICo9MVWjfIXa1Ak22RX2VrtQUN3A64JRjJBG30tLx9TtxuEyazXXwPd9mv7xOXsuxbzsiLn2TNjcmhYroTnX8QIYvNV9eflhqcxcn6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715668078; c=relaxed/simple;
	bh=4I8Ew75FwLD+XhoDdlADgouPQXvRuYmxxGY6OiEFMSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t0l9Nlr7Vsr9bIrWrwFWFigBZwKO4F1dDPDTr6A3+BhV+E3Zc8jyjRD6uWVYu5K0+hwN11EO3Rp7J94mKz/irSESLlNK2wv8mwTDgWTZ3yLtDlxCcOvaRyRpiC5mzseScopn8bkslVvVrnptUdFNbiQAA4Sai8Hk1U7CfMe30v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0JFi8OU; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7f82c932858so1370650241.0;
        Mon, 13 May 2024 23:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715668076; x=1716272876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhIouYRda4xn/j4cKFbLumMg8gYymQBHY+M0ZcFcX50=;
        b=f0JFi8OUs5MefNOUMr39vsF7zw5J/Ow35EPDOSOdWIBuu9TPfCQxKHEuvE64VifXOj
         Pf2TDBkLsgc96EelmN0IhIiTP4GdhxYuF9oYUXztb02k1eYPHdfiXlIfvQLspD3xws/1
         hEIfoV8CMFCwbe9fHRTaUgyb2UFx7pPPy7lEYDNbHxgFx57KSb6OjqOxX3ZXxpmqG2XE
         KCn7M31qfz3QbugAs49NktSsGMFSab//lVZ2MuEEogfJ9YQa2p0TGDpZ75HFQFNoKMfi
         F9lcuo42xyfat/UixpcV9Jb43UINTNxrLoPwIUalzofQtkPSHLgVqswP8lAGZqUFlrf1
         fLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715668076; x=1716272876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhIouYRda4xn/j4cKFbLumMg8gYymQBHY+M0ZcFcX50=;
        b=IXiRtLYsQJUP5DotyK0VeC/O9yhSbKWJd71niJewc1SRUlurV3bI6YKcqSSkwsXWQF
         UDygZ66KFWWgVee4CFPqYd8SSP1qX9Xm4hsa1w2q1As/m/1X8wtHjqD472eHDdCPvbBp
         wUDKYdfltWMlzQAbmuvOTmHLH6m5KiSLoQiDNdVquIcmgvGrT+JHYdboqPumBTy6dWUK
         5fTwdfU3PmqQF/hwCputW6fZ9Fy3G1detpYZHZJRCeFDLaexBoH8pzeTaj1zKY1eVhM0
         g6sQTJbwBttKYMTBbrG4drnq+CtStxRMni2zrV/kEJ5DFCdi6oAYhwiYpTI+MJG90SiN
         +5lA==
X-Forwarded-Encrypted: i=1; AJvYcCWom2EWkgyVSx3Ucc/pIphyfaeEuIPVjo7q/+5TJy0s0HnRZNPeo7E4zm275wuCoeQig1gEYxYKrn/joaCebBF4CYPOIDcGvS3yW1NfVC9xWx2OSdbvTtBvA0vCkalMFhQl7XcmQ70NV+Q=
X-Gm-Message-State: AOJu0YzXMs3atOjjW/0MzDuimEnLObxOmhkUAMjS/3Hh9HYCc74+2h6O
	NkEtWIpa/Pf+O2YcH10y1p8r+5hTwJrz0PliFSE/J7LeINJs6rRvo1km9inAVUHKhNJkvLMwDPX
	OhhHh/92N1LeNA3vqzXnyWDMo5p3QmucX
X-Google-Smtp-Source: AGHT+IGNFSwOrfQzHJ2L5VBUES2Agun4DroQZdbP1h03kx2PBnV2QHcMqlGbIu6c8Rh7JP3Wqe6OjRJxxZptv9tpVG0=
X-Received: by 2002:a05:6102:6d0:b0:47b:d3a9:e6ee with SMTP id
 ada2fe7eead31-48077de78b5mr11357701137.21.1715668074278; Mon, 13 May 2024
 23:27:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240425094907eucas1p10a82102ccb08868dda93d6860b9177ec@eucas1p1.samsung.com>
 <20240425094851.994055-1-m.szyprowski@samsung.com>
In-Reply-To: <20240425094851.994055-1-m.szyprowski@samsung.com>
From: Inki Dae <daeinki@gmail.com>
Date: Tue, 14 May 2024 15:27:18 +0900
Message-ID: <CAAQKjZMwAJrKfccC+2cB8pqGrdrgBToSkvEa0BRnfU+CO9n2Cg@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos: hdmi: report safe 640x480 mode as a fallback
 when no EDID found
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marek,

2024=EB=85=84 4=EC=9B=94 25=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 6:49, M=
arek Szyprowski <m.szyprowski@samsung.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
>
> When reading EDID fails and driver reports no modes available, the DRM
> core adds an artificial 1024x786 mode to the connector. Unfortunately
> some variants of the Exynos HDMI (like the one in Exynos4 SoCs) are not
> able to drive such mode, so report a safe 640x480 mode instead of nothing
> in case of the EDID reading failure.
>
> This fixes the following issue observed on Trats2 board since commit
> 13d5b040363c ("drm/exynos: do not return negative values from .get_modes(=
)"):

Applied.

Thanks,
Inki Dae

>
> [drm] Exynos DRM: using 11c00000.fimd device for DMA mapping operations
> exynos-drm exynos-drm: bound 11c00000.fimd (ops fimd_component_ops)
> exynos-drm exynos-drm: bound 12c10000.mixer (ops mixer_component_ops)
> exynos-dsi 11c80000.dsi: [drm:samsung_dsim_host_attach] Attached s6e8aa0 =
device (lanes:4 bpp:24 mode-flags:0x10b)
> exynos-drm exynos-drm: bound 11c80000.dsi (ops exynos_dsi_component_ops)
> exynos-drm exynos-drm: bound 12d00000.hdmi (ops hdmi_component_ops)
> [drm] Initialized exynos 1.1.0 20180330 for exynos-drm on minor 1
> exynos-hdmi 12d00000.hdmi: [drm:hdmiphy_enable.part.0] *ERROR* PLL could =
not reach steady state
> panel-samsung-s6e8aa0 11c80000.dsi.0: ID: 0xa2, 0x20, 0x8c
> exynos-mixer 12c10000.mixer: timeout waiting for VSYNC
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 11 at drivers/gpu/drm/drm_atomic_helper.c:1682 drm_a=
tomic_helper_wait_for_vblanks.part.0+0x2b0/0x2b8
> [CRTC:70:crtc-1] vblank wait timed out
> Modules linked in:
> CPU: 1 PID: 11 Comm: kworker/u16:0 Not tainted 6.9.0-rc5-next-20240424 #1=
4913
> Hardware name: Samsung Exynos (Flattened Device Tree)
> Workqueue: events_unbound deferred_probe_work_func
> Call trace:
>  unwind_backtrace from show_stack+0x10/0x14
>  show_stack from dump_stack_lvl+0x68/0x88
>  dump_stack_lvl from __warn+0x7c/0x1c4
>  __warn from warn_slowpath_fmt+0x11c/0x1a8
>  warn_slowpath_fmt from drm_atomic_helper_wait_for_vblanks.part.0+0x2b0/0=
x2b8
>  drm_atomic_helper_wait_for_vblanks.part.0 from drm_atomic_helper_commit_=
tail_rpm+0x7c/0x8c
>  drm_atomic_helper_commit_tail_rpm from commit_tail+0x9c/0x184
>  commit_tail from drm_atomic_helper_commit+0x168/0x190
>  drm_atomic_helper_commit from drm_atomic_commit+0xb4/0xe0
>  drm_atomic_commit from drm_client_modeset_commit_atomic+0x23c/0x27c
>  drm_client_modeset_commit_atomic from drm_client_modeset_commit_locked+0=
x60/0x1cc
>  drm_client_modeset_commit_locked from drm_client_modeset_commit+0x24/0x4=
0
>  drm_client_modeset_commit from __drm_fb_helper_restore_fbdev_mode_unlock=
ed+0x9c/0xc4
>  __drm_fb_helper_restore_fbdev_mode_unlocked from drm_fb_helper_set_par+0=
x2c/0x3c
>  drm_fb_helper_set_par from fbcon_init+0x3d8/0x550
>  fbcon_init from visual_init+0xc0/0x108
>  visual_init from do_bind_con_driver+0x1b8/0x3a4
>  do_bind_con_driver from do_take_over_console+0x140/0x1ec
>  do_take_over_console from do_fbcon_takeover+0x70/0xd0
>  do_fbcon_takeover from fbcon_fb_registered+0x19c/0x1ac
>  fbcon_fb_registered from register_framebuffer+0x190/0x21c
>  register_framebuffer from __drm_fb_helper_initial_config_and_unlock+0x35=
0/0x574
>  __drm_fb_helper_initial_config_and_unlock from exynos_drm_fbdev_client_h=
otplug+0x6c/0xb0
>  exynos_drm_fbdev_client_hotplug from drm_client_register+0x58/0x94
>  drm_client_register from exynos_drm_bind+0x160/0x190
>  exynos_drm_bind from try_to_bring_up_aggregate_device+0x200/0x2d8
>  try_to_bring_up_aggregate_device from __component_add+0xb0/0x170
>  __component_add from mixer_probe+0x74/0xcc
>  mixer_probe from platform_probe+0x5c/0xb8
>  platform_probe from really_probe+0xe0/0x3d8
>  really_probe from __driver_probe_device+0x9c/0x1e4
>  __driver_probe_device from driver_probe_device+0x30/0xc0
>  driver_probe_device from __device_attach_driver+0xa8/0x120
>  __device_attach_driver from bus_for_each_drv+0x80/0xcc
>  bus_for_each_drv from __device_attach+0xac/0x1fc
>  __device_attach from bus_probe_device+0x8c/0x90
>  bus_probe_device from deferred_probe_work_func+0x98/0xe0
>  deferred_probe_work_func from process_one_work+0x240/0x6d0
>  process_one_work from worker_thread+0x1a0/0x3f4
>  worker_thread from kthread+0x104/0x138
>  kthread from ret_from_fork+0x14/0x28
> Exception stack(0xf0895fb0 to 0xf0895ff8)
> ...
> irq event stamp: 82357
> hardirqs last  enabled at (82363): [<c01a96e8>] vprintk_emit+0x308/0x33c
> hardirqs last disabled at (82368): [<c01a969c>] vprintk_emit+0x2bc/0x33c
> softirqs last  enabled at (81614): [<c0101644>] __do_softirq+0x320/0x500
> softirqs last disabled at (81609): [<c012dfe0>] __irq_exit_rcu+0x130/0x18=
4
> ---[ end trace 0000000000000000 ]---
> exynos-drm exynos-drm: [drm] *ERROR* flip_done timed out
> exynos-drm exynos-drm: [drm] *ERROR* [CRTC:70:crtc-1] commit wait timed o=
ut
> exynos-drm exynos-drm: [drm] *ERROR* flip_done timed out
> exynos-drm exynos-drm: [drm] *ERROR* [CONNECTOR:74:HDMI-A-1] commit wait =
timed out
> exynos-drm exynos-drm: [drm] *ERROR* flip_done timed out
> exynos-drm exynos-drm: [drm] *ERROR* [PLANE:56:plane-5] commit wait timed=
 out
> exynos-mixer 12c10000.mixer: timeout waiting for VSYNC
>
> Cc: stable@vger.kernel.org
> Fixes: 13d5b040363c ("drm/exynos: do not return negative values from .get=
_modes()")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_hdmi.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exyno=
s/exynos_hdmi.c
> index 5fdeec8a3875..9d246db6ef2b 100644
> --- a/drivers/gpu/drm/exynos/exynos_hdmi.c
> +++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
> @@ -887,11 +887,11 @@ static int hdmi_get_modes(struct drm_connector *con=
nector)
>         int ret;
>
>         if (!hdata->ddc_adpt)
> -               return 0;
> +               goto no_edid;
>
>         edid =3D drm_get_edid(connector, hdata->ddc_adpt);
>         if (!edid)
> -               return 0;
> +               goto no_edid;
>
>         hdata->dvi_mode =3D !connector->display_info.is_hdmi;
>         DRM_DEV_DEBUG_KMS(hdata->dev, "%s : width[%d] x height[%d]\n",
> @@ -906,6 +906,9 @@ static int hdmi_get_modes(struct drm_connector *conne=
ctor)
>         kfree(edid);
>
>         return ret;
> +
> +no_edid:
> +       return drm_add_modes_noedid(connector, 640, 480);
>  }
>
>  static int hdmi_find_phy_conf(struct hdmi_context *hdata, u32 pixel_cloc=
k)
> --
> 2.34.1
>
>

