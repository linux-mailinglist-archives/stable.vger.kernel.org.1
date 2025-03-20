Return-Path: <stable+bounces-125662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7624A6A86C
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 15:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537363B6168
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 14:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773992248BE;
	Thu, 20 Mar 2025 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P56VTVfM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE04A224224;
	Thu, 20 Mar 2025 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480514; cv=none; b=JudMpeDwFpZgVkqht8JBdc1FuMzZJCFzI3PJHbL4nK7H0S1tLmzFZwOumkcOAVVNZbBpEJ3P8q45um+nTJJPf0o/XUNiHQnzqeVCSLHniiwSWFfWTPqgFtyE076RTvD/vni/DQCsUlW4l8/NrgqzLuZsFgWRyANUrnS4186trCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480514; c=relaxed/simple;
	bh=HWKsylmiW+BtMJkGcvcEyJY9de3c+e5FoR9mNHAPy0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oebNduOCBmOSCKf4gutC2n0eo0fLihBgvTuux/mffuf6W4/AD5gttMsgxfY761Z2W5fSVGWCzfWUZwFhTabX0TE9W1P+UTOhhfAbqXRVQT+a0QoqLZYeWepq8tx9ZrV1LpRXeEC/w/1i5gyms0tOvAXZcViPeexqW0BrpLUMBBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P56VTVfM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2264aefc45dso23171385ad.0;
        Thu, 20 Mar 2025 07:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742480512; x=1743085312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuntvFFwYkgUpcM/9nWOVbv7/IiYbYMm3ul7xyRax3Y=;
        b=P56VTVfMV/bPqzl8UZ1dn9g/h+px22u7Pb46bCVKB6zx0Q70IpVROLD+FYT8CwMdWt
         SMkubBMvdlSUgNSoD51+aghJZKV5NzNz1sw49KphFD+KIi3AKA6UQ49hZ6zC43C9jJug
         +f5hXaMMtvcd2Q3i9TpTf6cljLVEIR2e4wYzLq4fURwc/xP/GkWAs4ctLBotL2dX79Ex
         aou2xFqznMRwk67f6TQHo4NoOirG6o423lj+urvfGaBjAOvluVDSca24ZjdPvVY+fhTp
         9uanCes8nVW3EdEGhqeEFJFTGePBByP5pzZxcoQrtRqbNOgE3LKa8rk7G1f5ummv4quA
         7xnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742480512; x=1743085312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuntvFFwYkgUpcM/9nWOVbv7/IiYbYMm3ul7xyRax3Y=;
        b=wSVm1zkTq12kbZnUeq9qowpmzoLP3753BAINSW30IQ9MLVFHe8OzfzNKWmCIGiqpQ2
         ylthUnpXtKz2zK88vMMuERAsW+q4izxuNjKYPcmFEncjzlBHQ9TORUTorYBSQmiTAaYQ
         Sr700oiNMbylwfIUV9IlK1o2vNobjpVrMy+dvus4FNvj7SrI/sY3Lrz1683stob1W9BE
         JiL84ECajMlpRSGEl8ftH2vne4zUvCZ6f4bPendZWgnC0DFSsdgX+dYvWr/LCjhptBfd
         ZTzwXP615Ral5zHNcYQ+zcgnbYq3FdAnFA0U3l9LImiEDYZwxSm1sdegsDEjs8i6kKH4
         R4vg==
X-Forwarded-Encrypted: i=1; AJvYcCVlzJbiDc2e5Qc1XyRPKAq23D1YGjc90N1sSCjbFKhYW38NfiaDhXQninjC8JkdOF57SuDCcT0QqOqOa2E=@vger.kernel.org, AJvYcCW4rBAL/0C7WXrAplrtzmcGrjJgt/5wSnknKlFu+aiV1mxm2U7WxpjD17E9AU99ATalvCM9EnFE@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr6g7oYlvKAcoi1Y8Y5DKPAFOKj9eOboalM9nbQ1/ApAkKidbi
	Oa6Zq5YtOOmW7b7hB627P9c0dkIWOyuT7uk++1PP+MUHDUduOS5utauBCjA6YpDCtUCdaIh4lxu
	Yd8ob39tLyI8uGDMWx4kcTloBH3Y=
X-Gm-Gg: ASbGncv2Bh/xDcZDDEPG+1ubFwJr5PDfWMi09MYl8s+BopEpdwE2Cm1RupcusmtuRxS
	EBHKMqGAYNKXBeo+vFqyJeix+IbdiMRnS/uxGU+MQVYC+n81t33vUef6steqIW8PZEnt76FvYm/
	iwH8Ygjr1Df+sjndiamb/Xcncc
X-Google-Smtp-Source: AGHT+IEmYnUjCOXTNebABlXp5ns/0/fK6wHTVWN79SrrFblEXcoUnIgnSXUvB8rlNMcc/HVHPlN1hjo8fPoqtb++oe0=
X-Received: by 2002:a17:902:f711:b0:223:28a8:6101 with SMTP id
 d9443c01a7336-2265ee1ce6amr66594665ad.29.1742480511710; Thu, 20 Mar 2025
 07:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG8fp8S92hXFxMKQtMBkGqk1sWGu7pdHYDowsYbmurt0BGjfww@mail.gmail.com>
 <20250314084818.2826-1-akihiro.suda.cz@hco.ntt.co.jp> <Z9s5lam2QzWCOOKi@gmail.com>
In-Reply-To: <Z9s5lam2QzWCOOKi@gmail.com>
From: Akihiro Suda <suda.kyoto@gmail.com>
Date: Thu, 20 Mar 2025 23:21:40 +0900
X-Gm-Features: AQ5f1JoCemEwjjJ1t8QAlfRbPd3hmNLLAzSmBA2xrOQAsbuzCMbLQ9EipLAQ1bc
Message-ID: <CAG8fp8RgxFz2pwv3BXJ=dMWxoLSKjBL8PN0N8kWqkDOCB2_ivg@mail.gmail.com>
Subject: Re: [PATCH] x86/pkeys: Disable PKU when XFEATURE_PKRU is missing
To: Ingo Molnar <mingo@kernel.org>
Cc: Akihiro Suda <suda.gitsendemail@gmail.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, stable@vger.kernel.org, regressions@lists.linux.dev, 
	aruna.ramakrishna@oracle.com, tglx@linutronix.de, 
	Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Ingo, but we may have to reconsider whether cpu_has_xfeatures
works in this place
https://lore.kernel.org/all/1b8745e0-ae80-4add-b015-affdaa69b369@intel.com/

The current code might be accidentally disabling PKU on other
PKU-compatible environments?

2025=E5=B9=B43=E6=9C=8820=E6=97=A5(=E6=9C=A8) 6:39 Ingo Molnar <mingo@kerne=
l.org>:
>
>
> * Akihiro Suda <suda.gitsendemail@gmail.com> wrote:
>
> > Even when X86_FEATURE_PKU and X86_FEATURE_OSPKE are available,
> > XFEATURE_PKRU can be missing.
> > In such a case, pkeys has to be disabled to avoid hanging up.
> >
> >   WARNING: CPU: 0 PID: 1 at arch/x86/kernel/fpu/xstate.c:1003 get_xsave=
_addr_user+0x28/0x40
> >   (...)
> >   Call Trace:
> >    <TASK>
> >    ? get_xsave_addr_user+0x28/0x40
> >    ? __warn.cold+0x8e/0xea
> >    ? get_xsave_addr_user+0x28/0x40
> >    ? report_bug+0xff/0x140
> >    ? handle_bug+0x3b/0x70
> >    ? exc_invalid_op+0x17/0x70
> >    ? asm_exc_invalid_op+0x1a/0x20
> >    ? get_xsave_addr_user+0x28/0x40
> >    copy_fpstate_to_sigframe+0x1be/0x380
> >    ? __put_user_8+0x11/0x20
> >    get_sigframe+0xf1/0x280
> >    x64_setup_rt_frame+0x67/0x2c0
> >    arch_do_signal_or_restart+0x1b3/0x240
> >    syscall_exit_to_user_mode+0xb0/0x130
> >    do_syscall_64+0xab/0x1a0
> >    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > This fix is known to be needed on Apple Virtualization.
> > Tested with macOS 13.5.2 running on MacBook Pro 2020 with
> > Intel(R) Core(TM) i7-1068NG7 CPU @ 2.30GHz.
> >
> > Fixes: 70044df250d0 ("x86/pkeys: Update PKRU to enable all pkeys before=
 XSAVE")
> > Link: https://lore.kernel.org/regressions/CAG8fp8QvH71Wi_y7b7tgFp7knK38=
rfrF7rRHh-gFKqeS0gxY6Q@mail.gmail.com/T/#u
> > Link: https://github.com/lima-vm/lima/issues/3334
> >
> > Signed-off-by: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
> > ---
> >  arch/x86/kernel/cpu/common.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.=
c
> > index e9464fe411ac..4c2c268af214 100644
> > --- a/arch/x86/kernel/cpu/common.c
> > +++ b/arch/x86/kernel/cpu/common.c
> > @@ -517,7 +517,8 @@ static bool pku_disabled;
> >  static __always_inline void setup_pku(struct cpuinfo_x86 *c)
> >  {
> >       if (c =3D=3D &boot_cpu_data) {
> > -             if (pku_disabled || !cpu_feature_enabled(X86_FEATURE_PKU)=
)
> > +             if (pku_disabled || !cpu_feature_enabled(X86_FEATURE_PKU)=
 ||
> > +                 !cpu_has_xfeatures(XFEATURE_PKRU, NULL))
> >                       return;
>
> Note that silent quirks are counterproductive, as they don't give VM
> vendors any incentives to fix their VM for such bugs.
>
> So I changed your quirk to be:
>
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -519,6 +519,17 @@ static __always_inline void setup_pku(struct cpuinfo=
_x86 *c)
>         if (c =3D=3D &boot_cpu_data) {
>                 if (pku_disabled || !cpu_feature_enabled(X86_FEATURE_PKU)=
)
>                         return;
> +               if (!cpu_has_xfeatures(XFEATURE_PKRU, NULL)) {
> +                       /*
> +                        * Missing XFEATURE_PKRU is not really a valid CP=
U
> +                        * configuration at this point, but apparently
> +                        * Apple Virtualization is affected by this,
> +                        * so return with a FW warning instead of crashin=
g
> +                        * the bootup:
> +                        */
> +                       WARN_ONCE(1, FW_BUG "Invalid XFEATURE_PKRU config=
uration.\n");
> +                       return;
> +               }
>                 /*
>                  * Setting CR4.PKE will cause the X86_FEATURE_OSPKE cpuid
>                  * bit to be set.  Enforce it.
>
> This is noisy in the syslog, but it's a WARN_ONCE() and it doesn't
> crash the bootup.
>
> Thanks,
>
>         Ingo

