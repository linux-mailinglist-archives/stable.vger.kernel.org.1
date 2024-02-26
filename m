Return-Path: <stable+bounces-23782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123E4868415
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 23:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47AB5B215C7
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 22:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6122135A5B;
	Mon, 26 Feb 2024 22:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oej2VSZP"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FBC135419
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 22:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708988220; cv=none; b=VXZHGh+4vyFbUEcFVsHXGO365BevlGEuAN+gvrYN5wblS2z36W+0dq6QS5fKl5aCxP/JCJlS4n6a4IOoXVqcIJ4cO/a1GtXQ0yCcniEnSpYW1f9jj4xMWl99x5m7o3vQ8mYolNbLAHyE3udgfOUoyfuPx+2FbgOBUsAsw4Tc4F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708988220; c=relaxed/simple;
	bh=BY4yjPqK6m+yhqIEHOoRqXpbbR4sRRpARgLKgEPvpHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=McPJgUgpgoNpRGGz+RT/EPLykbYIgvIaKZxlGvmA6IY7/1yo8NYf6vjR4WmH0WzlVRoJsE5c+asfqA17gVGWDEdKpxN7EAWDBqZ0cRvosUqnE3VHA0VR4aqCyd08PIUmfUk+srGTsxhc5eZz/Lclq+BWgRBCTlgUlmkM7BZ83v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=oej2VSZP; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56454c695e6so6382505a12.0
        for <stable@vger.kernel.org>; Mon, 26 Feb 2024 14:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1708988212; x=1709593012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfKJBq26hOJvsm+iIu7w4P5R8/ik8TQdnQLZDaom8ws=;
        b=oej2VSZP4kmyBqYymdFHJJTtxzTluvTqVtv5qtsR8d5X3tdSGfdIz4zRXsvMVP1Lx7
         xpwKMlqwzgSa5DdyiORpaB0rBCAi4D/Fq+1KnU9LDkrEOsFteDjuqKqaQu9mFhYtBLdS
         lqTV1j/NR9P3ePCG/rQQItCvIKbil8Yom2X8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708988212; x=1709593012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfKJBq26hOJvsm+iIu7w4P5R8/ik8TQdnQLZDaom8ws=;
        b=h1L1/vEnoBmtkYxxVBr3TnYg6vJAWzVxt7cwe7EE9kJwW0HZVxKw5WdQAFjx57L3iI
         23bgRAYH2w9m3lTisuXxIjCBmcYn2bIwlhhgqxHBN3NA7fDh3oONBCt2mq+T+E1gf04f
         R2p+XSIHypMHsUSxLfIkDdIguhqDTMyRzOoSkC7NpSeR9mcrAuX0H3kGI7Mbyt15yChg
         mFSDZZFtMmBSn5vEileDdw+Tmy0lVfCNxqitFepCvyMcy6en+69RmZxsop4kHaS1cWI7
         OtuQoRfYu3Hgn7LUBrarG+v3sza3v9pEhm77WGCq85Dt/2qusdvL9MYWU74eGYh0roCL
         QriQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtlUYEKaJy7feCha1gXszOmKXBU0yRaEyjr1KanRjNs8HpVfE8w6jFy9QEUc/U3uSZT43bbaBemKgNkcpjJnzERECchK77
X-Gm-Message-State: AOJu0YxNNUho2dj37Cg3fYIB2rIBVWL/+/bsipJ0xqb7Uc8uol/T0i1P
	imhVf5cXl5eCshNCFtGBNqokVEvUlGS/WpQ2bxbuAm8Kmudz9jq39teprog/yi7XFXVdwkAcOsk
	ywxMgumdsWPl2lbjY5SeULt/5U0MrU1SGHal66twoxIwOswpmtCrIEQ==
X-Google-Smtp-Source: AGHT+IHsYoZ9fHFPHFyJRiHYvA8LVDvNhguHutZh7ska2jaz/K8V/hHlDIxWdxJotHTSKKg6fba3g4vsUY2fnkPhyVs=
X-Received: by 2002:aa7:c318:0:b0:565:211b:32ea with SMTP id
 l24-20020aa7c318000000b00565211b32eamr7521347edq.19.1708988211788; Mon, 26
 Feb 2024 14:56:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226100502.1845284-1-michael@amarulasolutions.com> <20240226223643.pay4tb66j3q44cuk@synopsys.com>
In-Reply-To: <20240226223643.pay4tb66j3q44cuk@synopsys.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 26 Feb 2024 23:56:40 +0100
Message-ID: <CAOf5uwkcFuSRZy3F44pSZFpHk5Hah-r8m01JLt3Gd1ngvg-CPQ@mail.gmail.com>
Subject: Re: [PATCH V3] usb: dwc3: gadget: Fix suspend/resume warning when
 no-gadget is connected
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-amarula@amarulasolutions.com" <linux-amarula@amarulasolutions.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Feb 26, 2024 at 11:36=E2=80=AFPM Thinh Nguyen <Thinh.Nguyen@synopsy=
s.com> wrote:
>
> Hi,
>
> On Mon, Feb 26, 2024, Michael Trimarchi wrote:
> > This patch avoid to disconnect an already gadget in not connected state
> >
> > [   45.597274] dwc3 31000000.usb: wait for SETUP phase timed out
> > [   45.599140] dwc3 31000000.usb: failed to set STALL on ep0out
> > [   45.601069] ------------[ cut here ]------------
> > [   45.601073] WARNING: CPU: 0 PID: 150 at drivers/usb/dwc3/ep0.c:289 d=
wc3_ep0_out_start+0xcc/0xd4
> > [   45.601102] Modules linked in: cfg80211 rfkill ipv6 rpmsg_ctrl rpmsg=
_char crct10dif_ce rti_wdt k3_j72xx_bandgap rtc_ti_k3 omap_mailbox sa2ul au=
thenc [last unloaded: ti_k3_r5_remoteproc]
> > [   45.601151] CPU: 0 PID: 150 Comm: sh Not tainted 6.8.0-rc5 #1
> > [   45.601159] Hardware name: BSH - CCM-M3 (DT)
> > [   45.601164] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [   45.601172] pc : dwc3_ep0_out_start+0xcc/0xd4
> > [   45.601179] lr : dwc3_ep0_out_start+0x50/0xd4
> > [   45.601186] sp : ffff8000832739e0
> > [   45.601189] x29: ffff8000832739e0 x28: ffff800082a21000 x27: ffff800=
0808dc630
> > [   45.601200] x26: 0000000000000002 x25: ffff800082530a44 x24: 0000000=
000000000
> > [   45.601210] x23: ffff000000e079a0 x22: ffff000000e07a68 x21: 0000000=
000000001
> > [   45.601219] x20: ffff000000e07880 x19: ffff000000e07880 x18: 0000000=
000000040
> > [   45.601229] x17: ffff7fff8e1ce000 x16: ffff800080000000 x15: fffffff=
ffffe5260
> > [   45.601239] x14: 0000000000000000 x13: 206e6f204c4c4154 x12: 5320746=
573206f74
> > [   45.601249] x11: 0000000000000001 x10: 000000000000000a x9 : ffff800=
083273930
> > [   45.601259] x8 : 000000000000000a x7 : ffffffffffff3f0c x6 : fffffff=
fffff3f00
> > [   45.601268] x5 : ffffffffffff3f0c x4 : 0000000000000000 x3 : 0000000=
000000000
> > [   45.601278] x2 : 0000000000000000 x1 : ffff000004e7e600 x0 : 0000000=
0ffffff92
> > [   45.601289] Call trace:
> > [   45.601293]  dwc3_ep0_out_start+0xcc/0xd4
> > [   45.601301]  dwc3_ep0_stall_and_restart+0x98/0xbc
> > [   45.601309]  dwc3_ep0_reset_state+0x5c/0x88
> > [   45.601315]  dwc3_gadget_soft_disconnect+0x144/0x160
> > [   45.601323]  dwc3_gadget_suspend+0x18/0xb0
> > [   45.601329]  dwc3_suspend_common+0x5c/0x18c
> > [   45.601341]  dwc3_suspend+0x20/0x44
> > [   45.601350]  platform_pm_suspend+0x2c/0x6c
> > [   45.601360]  __device_suspend+0x10c/0x34c
> > [   45.601372]  dpm_suspend+0x1a8/0x240
> > [   45.601382]  dpm_suspend_start+0x80/0x9c
> > [   45.601391]  suspend_devices_and_enter+0x1c4/0x584
> > [   45.601402]  pm_suspend+0x1b0/0x264
> > [   45.601408]  state_store+0x80/0xec
> > [   45.601415]  kobj_attr_store+0x18/0x2c
> > [   45.601426]  sysfs_kf_write+0x44/0x54
> > [   45.601434]  kernfs_fop_write_iter+0x120/0x1ec
> > [   45.601445]  vfs_write+0x23c/0x358
> > [   45.601458]  ksys_write+0x70/0x104
> > [   45.601467]  __arm64_sys_write+0x1c/0x28
> > [   45.601477]  invoke_syscall+0x48/0x114
> > [   45.601488]  el0_svc_common.constprop.0+0x40/0xe0
> > [   45.601498]  do_el0_svc+0x1c/0x28
> > [   45.601506]  el0_svc+0x34/0xb8
> > [   45.601516]  el0t_64_sync_handler+0x100/0x12c
> > [   45.601522]  el0t_64_sync+0x190/0x194
> > [   45.601531] ---[ end trace 0000000000000000 ]---
> > [   45.608794] Disabling non-boot CPUs ...
> > [   45.611029] psci: CPU1 killed (polled 0 ms)
> > [   45.611837] Enabling non-boot CPUs ...
> > [   45.612247] Detected VIPT I-cache on CPU1
> >
> > Tested on a am62x board with a usbnet gadget
> >
> > Fixes: 61a348857e86 ("usb: dwc3: gadget: Fix NULL pointer dereference i=
n dwc3_gadget_suspend)
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > ---
> > V2->V3:
> >       - Change the logic of the patch using the gadget connected state
> >       - Change of the commit message
> > V1->V2:
> >       - Add stable in CC
> > ---
> >  drivers/usb/dwc3/gadget.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index 4c8dd6724678..a7316a1703ad 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -2650,6 +2650,15 @@ static int dwc3_gadget_soft_disconnect(struct dw=
c3 *dwc)
> >       int ret;
> >
> >       spin_lock_irqsave(&dwc->lock, flags);
> > +     /*
> > +      * Attempt to disconnect a no connected gadget
> > +      */
> > +     if (!dwc->connected) {
> > +             dev_warn(dwc->dev, "No connected device\n");
> > +             spin_unlock_irqrestore(&dwc->lock, flags);
> > +             return 0;
> > +     }
> > +
> >       dwc->connected =3D false;
> >
> >       /*
> > --
> > 2.40.1
> >
>
> There's already a fix for this, and it's already in mainline. Let me
> know if this works for you:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Db191a18cb5c47109ca696370a74a5062a70adfd0
>

Can you explain to me the logic here? I mean pullsup_connected seems
never protected by spin lock and so I can not figure
out it easily and the commit message does not explain so much

Michael

> Thanks,
> Thinh

