Return-Path: <stable+bounces-241917-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOQ1Dk0x8mkjowEAu9opvQ
	(envelope-from <stable+bounces-241917-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 18:26:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D42497B5A
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 18:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B79B300748C
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 16:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1A93EDAC6;
	Wed, 29 Apr 2026 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiFmGPJS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453FB40FDA1
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777480003; cv=none; b=Tnmk0pya6vlHg273N0RI34IJEfCr/Xz48M2N095yC9kQGQ3/vMDcBkkQq0PbD2cR0Tw9KRKTaJnRN/GmlgC+dOYPTqQnDFOAMXyX9/cWeRKex/R5FXL+aqlqR3gLII+YWMNc/qfzEglu3SpkX+IPglmCvtWxzvVcMIBgM7SOsBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777480003; c=relaxed/simple;
	bh=2gXgQk1zvRzCuD6/I5xshjxzSLuvwhLDL5ZyIjbxG5U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sFSc+KTDCrLetYaJM2UugKkzHH1FvjLx3H8ZM9P1umO48/X6qn3Dys2u0hLAW/XZsQtOEloTymm6SfHovhQUvMa2FGB5z5lKZAlxWU2MgvK2DVcaZmgEeoLw3+KIJXm/0Cl9ekHVr38N9GRDvrI6CNUuXh/YZn8ag2VeKiF3SfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiFmGPJS; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-44509921fbcso2301540f8f.3
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 09:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777479995; x=1778084795; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gpqZ3+a3e+IW0wgilcrrSsFE8baGMm2gZVxtBkaZwTE=;
        b=LiFmGPJSAwCxoL/+D9ap6HspBoNyo/VpSSJEGEelC11a9ZGoAywfnEW5UDwhaG/jgF
         /67Bx+LpTU+B9qQtusR+RLTTQKc84RrEn9nxkfXLPK5YgcwOudAlcouDgJZm56wP5KNq
         QQygkd/uknz2XRWPqXwoXv3/xBVfxF4X2/ZtHdPICwtrGB8+YFItCUT4xPPdbSBSttrU
         o23ckPaS6iMHgqdKT9ziGpoqHmzekYYl2Xf3hw4Ceoc9qHydV4gxQBjPln+0qRKtxBsE
         Q/k1Y2enjtH353FwDKR9EiuX3x5AAr6a5z0GjO+9xkCq4Dt+QdEMWpeWyMPt24EnO5Aw
         OurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777479995; x=1778084795;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gpqZ3+a3e+IW0wgilcrrSsFE8baGMm2gZVxtBkaZwTE=;
        b=RAGNcfhglFrRcvefQtnt19FqZXhchFyC2kQiuK6QGcHYfwKabQ+HXiUidF5IG7MGCs
         YZhJ57AtZqavLPsjp1NSQriYdcJPOqVWO3muW8soNMjGqxrMeCC8vuM31zuZi88KIHct
         l0cg/m82FULeUHebFXpLQ5ZGbmAtFFZkLh0V8t9qetsd6oi1y0bB1VHC6BU76yOjbrfo
         aLALQ3C3YiQOGf+jsK4h+WQvYoqJYf5AnUW+l1P4BGtvEZPH8uRI7dDXcgaHu9FXiV4Z
         cqVYcxpI5vrRtUKkAZAmqFmgcw0jY6Z63qHey7kfcJyfedKzgPJJLrsBaiAOXLvG4xaK
         KaZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/gNmUFUR0f6xRiQofnyWdoJ/Ku0cPn8XhsGg04lG6W/hKJqqcCMLASfQacTuoRvUThrYek0Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXy4xXkUdOssNkTMU3on+jovw1R5OKkx1E0LA6RqK4waS3luJ/
	+O18cFo+Sld+xa8hvjXzCgSkqNjPg8eySa1Q8CqHEo9FtEm1o73RURq+
X-Gm-Gg: AeBDieuS2GLlLvXj5V6WnsFsifOOKV57bd2ZiF9hjjUY90cOc8CweeaqyBe4N5Oo7+D
	ZvXv/vViCk4u5tZ4rwH21VeoZ0v/k3M1LD1OYeh9s1F9kK3GxRHKpBt3/8StfUL9w/P594u96aF
	KpIUq5M3vaNSKPcuOwOOyXHHecLEiLc+PtrfWSNqOGx1tvb5wjw/K39ZLjjwNeW8cYfQKomgJkc
	H8qOAzuFfpoAlIW6Xy3Y2a3izjjySAbS2g6/osKoYUzkGkvp+on0JCpJDdj3lS8G3NXqKCH/kGf
	Izfhmvqy9H3BX9Rzx0QvGnBHsk7M2xTA6PTpiDZvTju2zm6PmBepaWtilwtljTuz1VLx3I6fZ7G
	VrY6VCIc8IxXhWxlEYfS95Mu0VBkvaZ5vO3YWkyo+YIOaHWGTT24RuFISdPGlMYLX4MSBM6Bivp
	cnqzZMK/jWqLq2gHtL2IgkQHks0Qo4OjQTDZdjmZpzAM3f7jnvvdrP9zJtX9mSRluk1vg=
X-Received: by 2002:a05:6000:40cb:b0:43e:b0f8:c564 with SMTP id ffacd0b85a97d-4478e3d0bb9mr8002971f8f.9.1777479994786;
        Wed, 29 Apr 2026 09:26:34 -0700 (PDT)
Received: from vitor-nb.Home (dsl-43-224.bl27.telepac.pt. [176.79.43.224])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b76e5c7csm6729780f8f.26.2026.04.29.09.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 09:26:34 -0700 (PDT)
Message-ID: <c0fe43a2339c802e9ce5900092cd530a2ba17a6b.camel@gmail.com>
Subject: Re: [PATCH v1] pmdomain: ti_sci: re-sync TIFS with genpd on resume
From: Vitor Soares <ivitro@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Tero
 Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Ulf
 Hansson <ulfh@kernel.org>
Cc: Vitor Soares <vitor.soares@toradex.com>, 
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tomi Valkeinen
 <tomi.valkeinen@ideasonboard.com>,  Kevin Hilman <khilman@baylibre.com>,
 vishalm@ti.com, sebin.francis@ti.com, d-gole@ti.com, Devarsh Thakkar
 <devarsht@ti.com>, stable@vger.kernel.org
Date: Wed, 29 Apr 2026 17:26:32 +0100
In-Reply-To: <1fb0739e-b84f-42f1-9c96-88b5cc5866a8@ti.com>
References: <20260427074808.3244226-2-ivitro@gmail.com>
	 <1fb0739e-b84f-42f1-9c96-88b5cc5866a8@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: E0D42497B5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-241917-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivitro@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

Hi Vignesh

Thank you for the review.

On Wed, 2026-04-29 at 10:03 +0530, Vignesh Raghavendra wrote:
> Hi Vitor
>=20
> On 27/04/26 13:18, Vitor Soares wrote:
> > From: Vitor Soares <vitor.soares@toradex.com>
> >=20
> > When a device in a TI SCI power domain is on the wakeup path of a
> > wakeup-capable child, the suspend path skips genpd_sync_power_off().
> > No put_device is sent to TIFS and the domain's genpd status remains
> > ON.
>=20
> Correction of terminologies: TIFS is Root of trust component and is not
> usually involved in power management, that would be DM (Device Manager)
>=20

Thank you for the clarification. I will address this on v2. Also, I was thi=
nking
to replace put_device/get_device with ti_sci_pd_power_off/ti_sci_pd_power_o=
n if
that makes more clear the content.

> But to be really sure who is doing what, Could you provide an example
> and the platform on which you see the issue / external abort?
>=20

This was reproduced on our Toradex Verdin AM62P WB and the driver for our W=
i-Fi
module on the SDIO bus calls device_init_wakeup() during the initialization=
.

After enter in suspend, it show the following error resume path:


[   41.759341] Internal error: synchronous external abort: 0000000096000010=
 [#1]
SMP
[   41.843286] CPU: 0 UID: 0 PID: 933 Comm: rtcwake Tainted: G   M       O =
   =20
6.18.21-dirty #3 PREEMPT
[   41.852762] Tainted: [M]=3DMACHINE_CHECK, [O]=3DOOT_MODULE
[   41.857891] Hardware name: Toradex Verdin AM62P WB on Verdin Development
Board (DT)
[   41.865537] pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[   41.872492] pc : regmap_mmio_read32le+0x8/0x20
[   41.876941] lr : regmap_mmio_read+0x44/0x70
[   41.881120] sp : ffff800081fdb8e0
[   41.884428] x29: ffff800081fdb8e0 x28: 0000000000000000 x27: ffffa95bb64=
aa9c8
[   41.891563] x26: 0000000000000000 x25: 0000000000000000 x24: 00000000000=
00000
[   41.898697] x23: 0000000080000000 x22: ffff000002df5c00 x21: ffff800081f=
db9b4
[   41.905831] x20: 0000000000000100 x19: ffff000001286400 x18: 00000000000=
00000
[   41.912965] x17: 2d69696d67722f79 x16: 687020726f662067 x15: ffff00007fb=
74f40
[   41.920100] x14: 00000000000002ea x13: 000000000000031f x12: 00000000000=
00000
[   41.927234] x11: 00000000000000c0 x10: 00000000000009e0 x9 : ffff800081f=
db7a0
[   41.934368] x8 : ffff00007fb6ce00 x7 : 0000000000000000 x6 : 00000000000=
00000
[   41.941502] x5 : ffffa95bb57948d8 x4 : 0000000000000100 x3 : 00000000000=
00100
[   41.948636] x2 : ffffa95bb5795034 x1 : 0000000000000100 x0 : ffff8000802=
5d100
[   41.955770] Call trace:
[   41.958211]  regmap_mmio_read32le+0x8/0x20 (P)
[   41.962655]  _regmap_bus_reg_read+0x70/0xb0
[   41.966839]  _regmap_read+0x64/0xdc
[   41.970327]  _regmap_update_bits+0xf4/0x140
[   41.974509]  regmap_update_bits_base+0x64/0x98
[   41.978952]  sdhci_am654_runtime_resume+0x138/0x208
[   41.983830]  pm_generic_runtime_resume+0x2c/0x44
[   41.988445]  __genpd_runtime_resume+0x30/0x7c
[   41.992804]  genpd_runtime_resume+0xdc/0x2e8
[   41.997073]  pm_runtime_force_resume+0x68/0xf4
[   42.001517]  dpm_run_callback+0x8c/0x14c
[   42.005439]  device_resume+0x11c/0x34c
[   42.009188]  dpm_resume+0x178/0x1f0
[   42.012673]  dpm_resume_end+0x18/0x34
[   42.016332]  suspend_devices_and_enter+0x4a4/0x668
[   42.021123]  pm_suspend+0x170/0x2dc
[   42.024610]  state_store+0x80/0x104
[   42.028096]  kobj_attr_store+0x18/0x2c
[   42.031845]  sysfs_kf_write+0x7c/0x94
[   42.035508]  kernfs_fop_write_iter+0x130/0x1fc
[   42.039949]  vfs_write+0x200/0x370
[   42.043351]  ksys_write+0x6c/0x100
[   42.046752]  __arm64_sys_write+0x1c/0x28
[   42.050673]  invoke_syscall.constprop.0+0x50/0xe4
[   42.055378]  do_el0_svc+0x40/0xc4
[   42.058691]  el0_svc+0x40/0x15c
[   42.061834]  el0t_64_sync_handler+0xa0/0xe4
[   42.066015]  el0t_64_sync+0x198/0x19c
[   42.069680] Code: aa0603e0 d65f03c0 f9400000 8b214000 (b9400000)

>=20
> >=20
> > TIFS powers off the hardware during deep sleep regardless, since it
> > was never informed to keep the domain active. On resume, because the
> > domain's genpd status is ON, no get_device is issued. The driver
> > then accesses registers of a powered-off domain, causing a
> > synchronous external abort (AXI bus error, ESR 0x96000010).
>=20
> Hmm, if something is wakeup source, I would expect even TIFS/DM not to
> turn if off, else module wakeup wouldn't work.
>=20

I tested UART as a wakeup source and I couldn't reproduce this issue. My
understanding is that UART has its own TI SCI domain and device_may_wakeup(=
) is
true directly on that domain device, so the set_device_constraint fires
correctly and DM keeps it powered.

Here is my tracking of the issue:

Wi-Fi driver registers as wakeup source:
device_init_wakeup(mmc0:0001)

During suspend/resume.
dpm_suspend()
->genpd_suspend_dev(fa20000.mmc)
   ->ti_sci_pd_suspend(fa20000.mmc)
      ->ti_sci_pd_set_wkup_constraint(fa20000.mmc)
        device_may_wakeup(fa20000.mmc)  =3D false
        set_device_constraint never sent to DM


dpm_suspend_noirq()
->genpd_finish_suspend(fa20000.mmc)
  ->device_awake_path(fa20000.mmc) =3D true
  ->GENPD_FLAG_ACTIVE_WAKEUP =3D true
    genpd status =3D GENPD_STATE_ON
    skip power_off (ti_sci_pd_power_off)

On deep sleep entry, DM powers off fa20000.mmc independently.
It received no set_device_constraint nor ti_sci_pd_power_off.

I attempted to fix this by calling set_device_constraint when=20
device_wakeup_path() is true but it prevented the system from entering deep
sleep entirely.

[...]

Best regards,
Vitor Soares

