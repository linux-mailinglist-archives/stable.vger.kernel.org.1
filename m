Return-Path: <stable+bounces-150648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EDCACC067
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 08:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4020318903A1
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 06:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22482267F4A;
	Tue,  3 Jun 2025 06:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="kN3/iB2M"
X-Original-To: stable@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E4E1F5434;
	Tue,  3 Jun 2025 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748933094; cv=none; b=ro6GmoWBIxCmEAvqXvjXULUIQCLof0oa9fufmKbVRNCxqdWFvshjfIpLtQpgBO6/US/SeUhRNtSPOppdiORtpbTsOKdIvz9kff7Yoed0SWxWMlPCba8cSAdya9FaCF1nB8dJx9dsHZXLybM8zQMEcNQ1DZiangmB+Oj5ip1akUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748933094; c=relaxed/simple;
	bh=UVp0LbQx8sBlvoHqjY1yfV+T6PtviStZ9VovgcKpHh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2B3A67fX16UElQJhk5LnAvSB2mb8c3O7uTQD6piUdXqV/OPSOE0LCkfzkkTb/+5FaodR0RWXpbaCIyGlIw3MlA58CXM7w0DUBbzKuXxCvNJIMVWaGA/iUGTGhsE0BoGh3ZJajLVT8TmimS7pwzFlJOiy/09bk3nqkHCihp8jGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=kN3/iB2M; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7C96025E04;
	Tue,  3 Jun 2025 08:44:44 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CfiClaMm0-wl; Tue,  3 Jun 2025 08:44:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1748933083; bh=UVp0LbQx8sBlvoHqjY1yfV+T6PtviStZ9VovgcKpHh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kN3/iB2MXKttgpnuUEEUJMJPyEyGSQ9GzuKNbSfEfOu1Ts6kBOWvbPHShh4vtEL/8
	 XBY+k1wM3sxrQuida/SOfm9HWiNd+TRZ1Z47s5leTpSyx8JbGjgBymy568VgNLuudn
	 BHY+ON5CUsGzBAOGYLoTTxDoHDMXhPm9Gv61c2k44JHYxRZKi/PLOtwDk4Q6wW6KrY
	 3fGdjKNSohf8wLeKSR90RBirmacuHshHOiGwGOHbrth6opLhDWLWZEbMMWhutSYvI+
	 s+TirXSkyU/EzXye8RCHn4kABgayMToGCDNX6mvAqcvwKIa/fLG9pImHs+J9iooJaK
	 WY76iZft5GCpw==
Date: Tue, 3 Jun 2025 06:44:31 +0000
From: Yao Zi <ziyao@disroot.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Jianmin Lv <lvjianmin@loongson.cn>, WANG Xuerui <kernel@xen0n.name>,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] platform/loongarch: laptop: Get brightness setting
 from EC on probe
Message-ID: <aD6Zz8L9WJRXvwaW@pie.lan>
References: <20250531113851.21426-1-ziyao@disroot.org>
 <20250531113851.21426-2-ziyao@disroot.org>
 <CAAhV-H7pvaz5N0-EfvhDNHAXJtR13p9Xi5hfgDxOpeXi9zMbTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H7pvaz5N0-EfvhDNHAXJtR13p9Xi5hfgDxOpeXi9zMbTQ@mail.gmail.com>

On Tue, Jun 03, 2025 at 12:11:48PM +0800, Huacai Chen wrote:
> On Sat, May 31, 2025 at 7:39 PM Yao Zi <ziyao@disroot.org> wrote:
> >
> > Previously 1 is unconditionally taken as current brightness value. This
> > causes problems since it's required to restore brightness settings on
> > resumption, and a value that doesn't match EC's state before suspension
> > will cause surprising changes of screen brightness.
> laptop_backlight_register() isn't called at resuming, so I think your
> problem has nothing to do with suspend (S3).

It does have something to do with it. In loongson_hotkey_resume() which
is called when leaving S3 (suspension), the brightness is restored
according to props.brightness,

        bd = backlight_device_get_by_type(BACKLIGHT_PLATFORM);
        if (bd) {
                loongson_laptop_backlight_update(bd) ?
                pr_warn("Loongson_backlight: resume brightness failed") :
                pr_info("Loongson_backlight: resume brightness %d\n", bd->props
.brightness);
        }

and without this patch, props.brightness is always set to 1 when the
driver probes, but actually (at least with the firmware on my laptop)
the screen brightness is set to 80 instead of 1 on cold boot, IOW, a
brightness value that doesn't match hardware state is set to
props.brightness.

On resumption, loongson_hotkey_resume() restores the brightness
settings according to props.brightness. But as the value isn't what is
used by hardware before suspension. the screen brightness will look very
different (1 v.s. 80) comparing to the brightness before suspension.

Some dmesg proves this as well, without this patch it says

	loongson_laptop: Loongson_backlight: resume brightness 1

but before suspension, reading
/sys/class/backlight/loongson3_laptop/actual_brightness yields 80.

> But there is really a problem about hibernation (S4): the brightness
> is 1 during booting, but when switching to the target kernel, the
> brightness may jump to the old value.
> 
> If the above case is what you meet, please update the commit message.
> 
> Huacai

Thanks,
Yao Zi

> >
> > Let's get brightness from EC and take it as the current brightness on
> > probe of the laptop driver to avoid the surprising behavior. Tested on
> > TongFang L860-T2 3A5000 laptop.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 6246ed09111f ("LoongArch: Add ACPI-based generic laptop driver")
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> >  drivers/platform/loongarch/loongson-laptop.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/loongarch/loongson-laptop.c b/drivers/platform/loongarch/loongson-laptop.c
> > index 99203584949d..828bd62e3596 100644
> > --- a/drivers/platform/loongarch/loongson-laptop.c
> > +++ b/drivers/platform/loongarch/loongson-laptop.c
> > @@ -392,7 +392,7 @@ static int laptop_backlight_register(void)
> >         if (!acpi_evalf(hotkey_handle, &status, "ECLL", "d"))
> >                 return -EIO;
> >
> > -       props.brightness = 1;
> > +       props.brightness = ec_get_brightness();
> >         props.max_brightness = status;
> >         props.type = BACKLIGHT_PLATFORM;
> >
> > --
> > 2.49.0
> >
> >

