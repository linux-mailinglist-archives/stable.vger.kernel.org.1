Return-Path: <stable+bounces-242848-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FYCNpE8+GkArwIAu9opvQ
	(envelope-from <stable+bounces-242848-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 08:28:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 848724B8E5B
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 08:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 022DC30221E8
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 06:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B0F2BEC2A;
	Mon,  4 May 2026 06:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnVsuDcN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD3929994B
	for <stable@vger.kernel.org>; Mon,  4 May 2026 06:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777876010; cv=none; b=CyIP9nolBwPy9EzKx+2+CukMiwXHh/X39fLKAkaUGA6WPF0Hc9FNATUrjUyZYbsxXcsB2O33pUdD5Li1hx1y9vR5wm/GILeyc2tjBVymon7WzXonVs55HI+w2aGnLPhvALiqH/q86E3PS50T8nyTpw6ctnnQonYYX3sc3yYU/5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777876010; c=relaxed/simple;
	bh=aCG8MNZ/8GmwZj+cq5TGk551pXq/pPuRlkxbWXOvbpY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LkLTsOsRTWBYRqedu2sGSiwEcD0pg5oriZjLAcuIqPzwFbvWeVjUHyjSoQ69vn8ZoFYtmUrZeDNX3mCiIcKu5wu41EGuEenEIpJ9nVS8MdcvpghcNl3ohnBqyWQdjMUBo80qfAFbZRlRZQdjQ+HVosZ3AghorhkOWfJPY7HOa1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnVsuDcN; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so28770895e9.0
        for <stable@vger.kernel.org>; Sun, 03 May 2026 23:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777876007; x=1778480807; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QLia1GJ4m3iPqeHXXFyHuRSpmpWEtbo9/yBBaAnZii4=;
        b=PnVsuDcNcS0jG5bTMKnweCx4Tx06VM3+NHrnjbYJ/k03wH5zz8/73HGNHUcsVwYyjL
         qWpN75P6BBq9grULnVJHTv61ClmVj/ZJNgQNwTlY3IQfYeKOuYpjZZG+Uq+ssKN18LNP
         O/60tGrlGDPXqneaIhc8gWXUsKcUv2TEdPJrbW0MmTx4xQIFPxGwlh+0ern4nNMwcP/4
         wW+31avZtKPUJwfURoH7MJRgQWKNiHgHrsKw8NQhDlTdUZ4TByslU8/uUi8qXEXJxAHA
         cqyJZT5jKPsO+Pvf0GX7EdhXN3JjOKmdOBOP8MZtlDshQPHZdlsQJj+gg3c3cr5BBhHN
         xdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777876007; x=1778480807;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QLia1GJ4m3iPqeHXXFyHuRSpmpWEtbo9/yBBaAnZii4=;
        b=qaY2uexuU3tzvYPrQUUqLN8Uor5E/0dm5nnkeZM3VX1XZ/dwUwNPAJQYfw2CIJJptF
         KqCnnoIKg+X6/LRSxquoNC/qwApEQ2RG040376ZL31aKBulD5CiM+jEosnSzP2m9LLTI
         dnlAdWiZKBNMXzk2y1fqMvWOhJfwr8Tc+PpCM0ccWaqMm9vGiNzr5nDCtthwBymYhSc/
         THLwDKsAJ3fghsi7ySl9AICJqughHtbPnXr4VlN0hp1SAaJzESbGRqEKXUczO37IrJHJ
         3haqusOe98Ln0r5GZbHIjvkAurntfaUWzYU2XVf5c+u/4+7E8/gQIC2/VriUPv/T15U/
         8U7g==
X-Forwarded-Encrypted: i=1; AFNElJ/tm6Rxyx3sodFtjc92XdCgEY2ZW6D5QDi3b9TAgKiOfjMNQpUYigv0c9hlMBGB6NpvPCPRX7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBCrz1sh1kAFAJYojq6yc/RPH3Osjsdr2qUrcnRnYuDona2e9H
	3xf9JFBPC+sjXhlcrXmzvDn+Xd6TlaQXjuesD5juKaYkCFealAkizmzU
X-Gm-Gg: AeBDievPWMEDPqISV1RNV3EWdsFHyobOhgPhU6cl9wTGpMegyxB1pkyF0/fj3nDYaEF
	q8wIbaxps0wFOisZzstAYHQzxa7ieEmd1gWveqpS1i1P30VlYFmhYU1Wv/VYryGAve9O9/GUp4a
	4SC9If4rtxrdBtZnKzda49x/mf2VLSU4SkRSEouxbo4Scii0MRqrPqjWDvTtZCgKeWVJ7hhreUK
	Elj51opIyNJ+zy0jrq27/TIX0ki71dre/d8P+LUgUGaiyNKYlkqssRmFfFGKvCDJzJ+IY1Jxz62
	wxLy8Tjq0kbvP20AT7TpKTWTmYJS3ZrzBmMEdMLmUAnsfLDvWIyGSpH/1t+A+6Dg4qj5ZvShG/r
	njPt6PFC/dQedsBQU854NXDxxPtdWyOGmQt++9EpbWvIrLngEG1ObJ7EWXbhggt4vvSKFvtL27n
	netyaLSIsIMt7LmWIB3f9znN/4LhQbGUssXQSTIMliL8CoYhgCk0WU53mv46m+MM+iPCeSEA==
X-Received: by 2002:a05:600c:47cf:b0:48d:366:b962 with SMTP id 5b1f17b1804b1-48d0366bb8fmr38782655e9.6.1777876006815;
        Sun, 03 May 2026 23:26:46 -0700 (PDT)
Received: from vitor-nb.Home (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eba6f83sm238082165e9.9.2026.05.03.23.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 23:26:46 -0700 (PDT)
Message-ID: <0cad7e5e41b9e2c6ec545050dd0d3c6b3e085d2c.camel@gmail.com>
Subject: Re: [PATCH v1] pmdomain: ti_sci: re-sync TIFS with genpd on resume
From: Vitor Soares <ivitro@gmail.com>
To: Sebin Francis <sebin.francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>,  Nishanth Menon <nm@ti.com>, Tero Kristo
 <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Ulf Hansson
 <ulfh@kernel.org>
Cc: Vitor Soares <vitor.soares@toradex.com>, 
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tomi Valkeinen
 <tomi.valkeinen@ideasonboard.com>,  Kevin Hilman <khilman@baylibre.com>,
 vishalm@ti.com, d-gole@ti.com, Devarsh Thakkar <devarsht@ti.com>, 
 stable@vger.kernel.org, Kendall Willis <k-willis@ti.com>
Date: Mon, 04 May 2026 07:26:44 +0100
In-Reply-To: <17cbaadb-5aa7-40f4-848c-ba8e88fbd333@ti.com>
References: <20260427074808.3244226-2-ivitro@gmail.com>
	 <1fb0739e-b84f-42f1-9c96-88b5cc5866a8@ti.com>
	 <c0fe43a2339c802e9ce5900092cd530a2ba17a6b.camel@gmail.com>
	 <17cbaadb-5aa7-40f4-848c-ba8e88fbd333@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 848724B8E5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-242848-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivitro@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

Hello Sebin

On Thu, 2026-04-30 at 16:17 +0530, Sebin Francis wrote:
> Hi Vitor,
>=20
> On 29/04/26 21:56, Vitor Soares wrote:
> > Hi Vignesh
> >=20
> > Thank you for the review.
> >=20
> > On Wed, 2026-04-29 at 10:03 +0530, Vignesh Raghavendra wrote:
> > > Hi Vitor
> > >=20
> > > On 27/04/26 13:18, Vitor Soares wrote:
> > > > From: Vitor Soares <vitor.soares@toradex.com>
> > > >=20
> > > > When a device in a TI SCI power domain is on the wakeup path of a
> > > > wakeup-capable child, the suspend path skips genpd_sync_power_off()=
.
> > > > No put_device is sent to TIFS and the domain's genpd status remains
> > > > ON.
> > >=20
> > > Correction of terminologies: TIFS is Root of trust component and is n=
ot
> > > usually involved in power management, that would be DM (Device Manage=
r)
> > >=20
> >=20
> > Thank you for the clarification. I will address this on v2. Also, I was
> > thinking
> > to replace put_device/get_device with ti_sci_pd_power_off/ti_sci_pd_pow=
er_on
> > if
> > that makes more clear the content.
> >=20
> > > But to be really sure who is doing what, Could you provide an example
> > > and the platform on which you see the issue / external abort?
> > >=20
> >=20
> > This was reproduced on our Toradex Verdin AM62P WB and the driver for o=
ur
> > Wi-Fi
> > module on the SDIO bus calls device_init_wakeup() during the initializa=
tion.
> >=20
> > After enter in suspend, it show the following error resume path:
> >=20
> >=20
> > [=C2=A0=C2=A0 41.759341] Internal error: synchronous external abort: 00=
00000096000010
> > [#1]
> > SMP
> > [=C2=A0=C2=A0 41.843286] CPU: 0 UID: 0 PID: 933 Comm: rtcwake Tainted: =
G=C2=A0=C2=A0 M=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 O
> > 6.18.21-dirty #3 PREEMPT
> > [=C2=A0=C2=A0 41.852762] Tainted: [M]=3DMACHINE_CHECK, [O]=3DOOT_MODULE
> > [=C2=A0=C2=A0 41.857891] Hardware name: Toradex Verdin AM62P WB on Verd=
in Development
> > Board (DT)
> > [=C2=A0=C2=A0 41.865537] pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DI=
T -SSBS BTYPE=3D-
> > -)
> > [=C2=A0=C2=A0 41.872492] pc : regmap_mmio_read32le+0x8/0x20
> > [=C2=A0=C2=A0 41.876941] lr : regmap_mmio_read+0x44/0x70
> > [=C2=A0=C2=A0 41.881120] sp : ffff800081fdb8e0
> > [=C2=A0=C2=A0 41.884428] x29: ffff800081fdb8e0 x28: 0000000000000000 x2=
7:
> > ffffa95bb64aa9c8
> > [=C2=A0=C2=A0 41.891563] x26: 0000000000000000 x25: 0000000000000000 x2=
4:
> > 0000000000000000
> > [=C2=A0=C2=A0 41.898697] x23: 0000000080000000 x22: ffff000002df5c00 x2=
1:
> > ffff800081fdb9b4
> > [=C2=A0=C2=A0 41.905831] x20: 0000000000000100 x19: ffff000001286400 x1=
8:
> > 0000000000000000
> > [=C2=A0=C2=A0 41.912965] x17: 2d69696d67722f79 x16: 687020726f662067 x1=
5:
> > ffff00007fb74f40
> > [=C2=A0=C2=A0 41.920100] x14: 00000000000002ea x13: 000000000000031f x1=
2:
> > 0000000000000000
> > [=C2=A0=C2=A0 41.927234] x11: 00000000000000c0 x10: 00000000000009e0 x9=
 :
> > ffff800081fdb7a0
> > [=C2=A0=C2=A0 41.934368] x8 : ffff00007fb6ce00 x7 : 0000000000000000 x6=
 :
> > 0000000000000000
> > [=C2=A0=C2=A0 41.941502] x5 : ffffa95bb57948d8 x4 : 0000000000000100 x3=
 :
> > 0000000000000100
> > [=C2=A0=C2=A0 41.948636] x2 : ffffa95bb5795034 x1 : 0000000000000100 x0=
 :
> > ffff80008025d100
> > [=C2=A0=C2=A0 41.955770] Call trace:
> > [=C2=A0=C2=A0 41.958211]=C2=A0 regmap_mmio_read32le+0x8/0x20 (P)
> > [=C2=A0=C2=A0 41.962655]=C2=A0 _regmap_bus_reg_read+0x70/0xb0
> > [=C2=A0=C2=A0 41.966839]=C2=A0 _regmap_read+0x64/0xdc
> > [=C2=A0=C2=A0 41.970327]=C2=A0 _regmap_update_bits+0xf4/0x140
> > [=C2=A0=C2=A0 41.974509]=C2=A0 regmap_update_bits_base+0x64/0x98
> > [=C2=A0=C2=A0 41.978952]=C2=A0 sdhci_am654_runtime_resume+0x138/0x208
> > [=C2=A0=C2=A0 41.983830]=C2=A0 pm_generic_runtime_resume+0x2c/0x44
> > [=C2=A0=C2=A0 41.988445]=C2=A0 __genpd_runtime_resume+0x30/0x7c
> > [=C2=A0=C2=A0 41.992804]=C2=A0 genpd_runtime_resume+0xdc/0x2e8
> > [=C2=A0=C2=A0 41.997073]=C2=A0 pm_runtime_force_resume+0x68/0xf4
> > [=C2=A0=C2=A0 42.001517]=C2=A0 dpm_run_callback+0x8c/0x14c
> > [=C2=A0=C2=A0 42.005439]=C2=A0 device_resume+0x11c/0x34c
> > [=C2=A0=C2=A0 42.009188]=C2=A0 dpm_resume+0x178/0x1f0
> > [=C2=A0=C2=A0 42.012673]=C2=A0 dpm_resume_end+0x18/0x34
> > [=C2=A0=C2=A0 42.016332]=C2=A0 suspend_devices_and_enter+0x4a4/0x668
> > [=C2=A0=C2=A0 42.021123]=C2=A0 pm_suspend+0x170/0x2dc
> > [=C2=A0=C2=A0 42.024610]=C2=A0 state_store+0x80/0x104
> > [=C2=A0=C2=A0 42.028096]=C2=A0 kobj_attr_store+0x18/0x2c
> > [=C2=A0=C2=A0 42.031845]=C2=A0 sysfs_kf_write+0x7c/0x94
> > [=C2=A0=C2=A0 42.035508]=C2=A0 kernfs_fop_write_iter+0x130/0x1fc
> > [=C2=A0=C2=A0 42.039949]=C2=A0 vfs_write+0x200/0x370
> > [=C2=A0=C2=A0 42.043351]=C2=A0 ksys_write+0x6c/0x100
> > [=C2=A0=C2=A0 42.046752]=C2=A0 __arm64_sys_write+0x1c/0x28
> > [=C2=A0=C2=A0 42.050673]=C2=A0 invoke_syscall.constprop.0+0x50/0xe4
> > [=C2=A0=C2=A0 42.055378]=C2=A0 do_el0_svc+0x40/0xc4
> > [=C2=A0=C2=A0 42.058691]=C2=A0 el0_svc+0x40/0x15c
> > [=C2=A0=C2=A0 42.061834]=C2=A0 el0t_64_sync_handler+0xa0/0xe4
> > [=C2=A0=C2=A0 42.066015]=C2=A0 el0t_64_sync+0x198/0x19c
> > [=C2=A0=C2=A0 42.069680] Code: aa0603e0 d65f03c0 f9400000 8b214000 (b94=
00000)
> >=20
> > >=20
> > > >=20
> > > > TIFS powers off the hardware during deep sleep regardless, since it
> > > > was never informed to keep the domain active. On resume, because th=
e
> > > > domain's genpd status is ON, no get_device is issued. The driver
> > > > then accesses registers of a powered-off domain, causing a
> > > > synchronous external abort (AXI bus error, ESR 0x96000010).
> > >=20
> > > Hmm, if something is wakeup source, I would expect even TIFS/DM not t=
o
> > > turn if off, else module wakeup wouldn't work.
> > >=20
> >=20
> > I tested UART as a wakeup source and I couldn't reproduce this issue. M=
y
> > understanding is that UART has its own TI SCI domain and device_may_wak=
eup()
> > is
> > true directly on that domain device, so the set_device_constraint fires
> > correctly and DM keeps it powered.
> >=20
> > Here is my tracking of the issue:
> >=20
> > Wi-Fi driver registers as wakeup source:
> > device_init_wakeup(mmc0:0001)
> >=20
> > During suspend/resume.
> > dpm_suspend()
> > ->genpd_suspend_dev(fa20000.mmc)
> > =C2=A0=C2=A0=C2=A0 ->ti_sci_pd_suspend(fa20000.mmc)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ->ti_sci_pd_set_wkup_constraint(fa=
20000.mmc)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_may_wakeup(fa20=
000.mmc)=C2=A0 =3D false
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_device_constraint =
never sent to DM
> >=20
> >=20
> > dpm_suspend_noirq()
> > ->genpd_finish_suspend(fa20000.mmc)
> > =C2=A0=C2=A0 ->device_awake_path(fa20000.mmc) =3D true
> > =C2=A0=C2=A0 ->GENPD_FLAG_ACTIVE_WAKEUP =3D true
> > =C2=A0=C2=A0=C2=A0=C2=A0 genpd status =3D GENPD_STATE_ON
> > =C2=A0=C2=A0=C2=A0=C2=A0 skip power_off (ti_sci_pd_power_off)
> >=20
> > On deep sleep entry, DM powers off fa20000.mmc independently.
> > It received no set_device_constraint nor ti_sci_pd_power_off.
>=20
> In AM62P fa20000.mmc is part of main domain. During deepsleep the entire=
=20
> main domain is turned off by the DM, that is why you see the failures.
>=20
> In-order to debug this we need to check why pd off and pd on call is not=
=20
> getting called for fa20000.mmc during suspend and resume.

This is an expected behavior from genpd. On suspend, ti_sci_pd_power_off is=
 not
called because genpd_finish_suspend() takes an early return when both   =
=20
device_awake_path() and GENPD_FLAG_ACTIVE_WAKEUP are true.
                                                              =20
On resume, ti_sci_pd_power_on is not called because genpd sees the domain s=
tatus
as GENPD_STATE_ON (it was never cleared) and skips the power-on entirely.

>=20
> >=20
> > I attempted to fix this by calling set_device_constraint when
> > device_wakeup_path() is true but it prevented the system from entering =
deep
> > sleep entirely.
>=20
> In AM62P the DM manager selects the low power mode to enter based on the=
=20
> constrains set. The mode selection logic will ensure that if a=20
> constraint is set on the device, it will select a low power mode in=20
> which the device is kept on or can wake the system up. the MMC is part=
=20
> of main domain and there is no low power mode in which the MMC can stay=
=20
> alive or generate a wake up interrupt. so when a constraint is set of=20
> MMC, we cannot enter any low power mode. that why you see a failure.
>=20

This is consistent with what we observed. I am open to suggestions if there=
 is a
better way to handle this.

Thanks,
Vitor Soares


