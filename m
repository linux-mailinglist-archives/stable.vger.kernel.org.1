Return-Path: <stable+bounces-55814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9573C917574
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 03:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0372832B5
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 01:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E06BE4D;
	Wed, 26 Jun 2024 01:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqhgsVMv"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B831A6125;
	Wed, 26 Jun 2024 01:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719364283; cv=none; b=ek5MZt4FSVx0OYTKmu5SjnlCGEgcRT3VwWI44zjfT+mTpUhUaYvkXe8tTZeCWrlwWRc4Mb5M+59d8FYkfM6pFFeM2WaOdU9/S0BUxUiD3IH7Eg6fk6rrOmq8N+QrsNwT8BMV9jM8Lf8rVtBfKpCCtaXsEqLUZXnvejoxrFKWWXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719364283; c=relaxed/simple;
	bh=wCmBRhXWGxj9VULNLaj8yk8dzpHGdMEeXmASJF0aKQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLWGcdXyyiUJYNzKNr58ZSSHvuIYr3aHHNWtzPQZCvkzyj+pg7Tx3SBoYvSS7sz10B8WeUtVAMPgl3gWMjTuGi+AU4WOD1di5GJGJvIbS1Yik3Y7R2PccqcpwMqkknfQRVr5qaPbepYMmKs1MU2QWGaCLltIl1WE2cB036cPZlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqhgsVMv; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57d331cc9feso4287171a12.2;
        Tue, 25 Jun 2024 18:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719364280; x=1719969080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asyx3WntG4OThCRcShDwfSCXWLgRQ+/Uaa7W33Vqtyk=;
        b=IqhgsVMvdPKxJNF9nMs80uqnigyILgdSvCzz03A/3iDC2RUyGWJt50pX0tiyT6vfYX
         0Y9rxgKrASAprsNQMpwDo9Y2QEDLPbnWSOWjxC6IcpkNRg90d2s0o4W/9vpdoTvQ0gvf
         60Uma5X734pcb3zZdLym3h2o1dZ7DXmgtiRgs81jYwFICC2dphEUkEiRNygm0e+E7yPm
         FUNNtEvi8pg8lyN8JqUKGwrFsj0mTu18gfp1V6HCBkUMVIUN6IH6NVrENvPTUIJvN8lf
         NmH44Jn4bnAkFI0QjhCQNYWp+WB127FHhwIn8UtcT99gq4m2yVHqOZ9uNX40rJ4LtUng
         mjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719364280; x=1719969080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asyx3WntG4OThCRcShDwfSCXWLgRQ+/Uaa7W33Vqtyk=;
        b=T/NdzOu/mX4CS1ONLB1bcYjv4skIdOQrI+wpO+T/0+HVZG8wtiN87PwKVI8F13khbh
         bCXHsBcoEkFlxWrGghVp+F8R1lWnXmezzXGs2mK7PsfUhnxADau4BaWxsF6eFb+T95YW
         o/Uty1AFtia66LLKJV6jQ62oqrRm+oeeWyY+GafHcuLGsB2f0wCJ+5ZcoxiBLczBwSqr
         kvU/cyBr1xK1iHg4ziR0FakmZh/BcW21Gb76yQgf1Cw+c6FWYtJLV4fm5fB6xukknyCU
         NFizdk7y2l8hfwMEUcRwyHWrI4bMJBPlAjZsysg2DGSkzn1GwClswg8Xg5tx0162/k8F
         C7EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwswUNljKrwiXMtP++OdA0YWaJon4JkQ8HDOHiZ9TdlHgskKHLwQncsh/099aIh0V280w1nJ+YssluKQsa46Ri42z44bW0NgBMM3ldPBaerfTgw9Sh4LUGp8J+XJ4D2KkyrOku
X-Gm-Message-State: AOJu0Yw413yrvkzfkep34JS/oeIpx0eBJZvQXrqPXoNXadcqwykD7RzX
	akMCyY7nbly+xhTlMSc64ISuNw18M8So36/oZ7zy3lbGadDApROrk2qKlFL4+in+kZ5Y0iAnmDO
	POAL6COK0dHEBnjHT6SKjU5Gs+/c=
X-Google-Smtp-Source: AGHT+IFGmha0T9jNof/KuwAohpk4SnLJgwELl6O3jUe3eisCuLf5J9RjYsaDsvAcLzroKTOUT2WgmJb2X6FeYvkzxHQ=
X-Received: by 2002:a50:cd93:0:b0:57a:2fe7:6699 with SMTP id
 4fb4d7f45d1cf-57d4a281750mr7434714a12.14.1719364279832; Tue, 25 Jun 2024
 18:11:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fdaf2e41bb6a0c5118ff9cc21f4f62583208d885.1718655070.git.dsimic@manjaro.org>
 <CAKGbVbs8VmCXVOHbhkCYEHNJiKWwy10p0SV9J09h2h7xjs7hUg@mail.gmail.com>
 <CAKGbVbsM4rCprWdp+aGXE-pvCkb6N7weUyG2z4nXqFpv+y=LrA@mail.gmail.com>
 <20240618-great-hissing-skink-b7950e@houat> <4813a6885648e5368028cd822e8b2381@manjaro.org>
 <457ae7654dba38fcd8b50e38a1275461@manjaro.org> <2c072cc4bc800a0c52518fa2476ef9dd@manjaro.org>
In-Reply-To: <2c072cc4bc800a0c52518fa2476ef9dd@manjaro.org>
From: Qiang Yu <yuq825@gmail.com>
Date: Wed, 26 Jun 2024 09:11:07 +0800
Message-ID: <CAKGbVbsGm7emEPzGuf0Xn5k22Pbjfg9J9ykJHtvDF3SacfDg6A@mail.gmail.com>
Subject: Re: [PATCH] drm/lima: Mark simple_ondemand governor as softdep
To: Dragan Simic <dsimic@manjaro.org>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
	lima@lists.freedesktop.org, maarten.lankhorst@linux.intel.com, 
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	linux-kernel@vger.kernel.org, Philip Muller <philm@manjaro.org>, 
	Oliver Smith <ollieparanoid@postmarketos.org>, Daniel Smith <danct12@disroot.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 2:15=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello everyone,
>
> Just checking, any further thoughts about this patch?
>
I'm OK with this as a temp workaround because it's simple and do no harm
even it's not perfect. If no other better suggestion for short term, I'll s=
ubmit
this at weekend.

> On 2024-06-18 21:22, Dragan Simic wrote:
> > On 2024-06-18 12:33, Dragan Simic wrote:
> >> On 2024-06-18 10:13, Maxime Ripard wrote:
> >>> On Tue, Jun 18, 2024 at 04:01:26PM GMT, Qiang Yu wrote:
> >>>> On Tue, Jun 18, 2024 at 12:33=E2=80=AFPM Qiang Yu <yuq825@gmail.com>=
 wrote:
> >>>> >
> >>>> > I see the problem that initramfs need to build a module dependency=
 chain,
> >>>> > but lima does not call any symbol from simpleondemand governor mod=
ule.
> >>>> > softdep module seems to be optional while our dependency is hard o=
ne,
> >>>> > can we just add MODULE_INFO(depends, _depends), or create a new
> >>>> > macro called MODULE_DEPENDS()?
> >>
> >> I had the same thoughts, because softdeps are for optional module
> >> dependencies, while in this case it's a hard dependency.  Though,
> >> I went with adding a softdep, simply because I saw no better option
> >> available.
> >>
> >>>> This doesn't work on my side because depmod generates modules.dep
> >>>> by symbol lookup instead of modinfo section. So softdep may be our
> >>>> only
> >>>> choice to add module dependency manually. I can accept the softdep
> >>>> first, then make PM optional later.
> >>
> >> I also thought about making devfreq optional in the Lima driver,
> >> which would make this additional softdep much more appropriate.
> >> Though, I'm not really sure that's a good approach, because not
> >> having working devfreq for Lima might actually cause issues on
> >> some devices, such as increased power consumption.
> >>
> >> In other words, it might be better to have Lima probing fail if
> >> devfreq can't be initialized, rather than having probing succeed
> >> with no working devfreq.  Basically, failed probing is obvious,
> >> while a warning in the kernel log about no devfreq might easily
> >> be overlooked, causing regressions on some devices.
> >>
> >>> It's still super fragile, and depends on the user not changing the
> >>> policy. It should be solved in some other, more robust way.
> >>
> >> I see, but I'm not really sure how to make it more robust?  In
> >> the end, some user can blacklist the simple_ondemand governor
> >> module, and we can't do much about it.
> >>
> >> Introducing harddeps alongside softdeps would make sense from
> >> the design standpoint, but the amount of required changes wouldn't
> >> be trivial at all, on various levels.
> >
> > After further investigation, it seems that the softdeps have
> > already seen a fair amount of abuse for what they actually aren't
> > intended, i.e. resolving hard dependencies.  For example, have
> > a look at the commit d5178578bcd4 (btrfs: directly call into
> > crypto framework for checksumming) [1] and the lines containing
> > MODULE_SOFTDEP() at the very end of fs/btrfs/super.c. [2]
> >
> > If a filesystem driver can rely on the abuse of softdeps, which
> > admittedly are a bit fragile, I think we can follow the same
> > approach, at least for now.
> >
> > With all that in mind, I think that accepting this patch, as well
> > as the related Panfrost patch, [3] should be warranted.  I'd keep
> > investigating the possibility of introducing harddeps in form
> > of MODULE_HARDDEP() and the related support in kmod project,
> > similar to the already existing softdep support, [4] but that
> > will inevitably take a lot of time, both for implementing it
> > and for reaching various Linux distributions, which is another
> > reason why accepting these patches seems reasonable.
> >
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dd5178578bcd4
> > [2]
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/fs/btrfs/super.c#n2593
> > [3]
> > https://lore.kernel.org/dri-devel/4e1e00422a14db4e2a80870afb704405da16f=
d1b.1718655077.git.dsimic@manjaro.org/
> > [4]
> > https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/commit/?id=3D=
49d8e0b59052999de577ab732b719cfbeb89504d

