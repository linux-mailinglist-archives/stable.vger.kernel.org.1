Return-Path: <stable+bounces-17595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBF3845A71
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 15:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43CEE1C241AC
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 14:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF888662E;
	Thu,  1 Feb 2024 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="hPL59YBe"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F48D5D473
	for <stable@vger.kernel.org>; Thu,  1 Feb 2024 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706798513; cv=none; b=FH00SOHHi3b8yXxAn0Z38cbEVFxuYBerjz70U52+XirX9sGaELtgk3ucWJommw4hVlPLyNQctSkaZnqLtv0ZMd1VkxvPIwtkOiKhsYjFZd55N3KSst5EkhpXdrb3epU6CrjRVGWPlOGuy8K0R/M9DMOEaRx79jV5OXdzNFeT7AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706798513; c=relaxed/simple;
	bh=doMIEKjhlaw3cSONB3YjMbb/GGYi2CZhyJNDxYux14c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dfm+HIfI7/E0Gg2s52LRovxECl/ShguZOSkULZDeTm4Ct07w4G5yXDLh+t57Ve228XZTWQhVMb88HAuWh3pztDrQ7hE1xsZpczJIPb5jETjEh35ma29ljS8WowHT+kOEEKGvYjQS/1ZFNf5+RacU8IPq8mF9phPHKYmXGIfsAI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=hPL59YBe; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7c00cfd7156so39652239f.0
        for <stable@vger.kernel.org>; Thu, 01 Feb 2024 06:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1706798510; x=1707403310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsOO2ZkkdcJTbF0BB2qngAJPCReDSBqBxrVox/Wl9y0=;
        b=hPL59YBeQUlDw9dlCMxptrtDviz9KmYFLdS6CM4mGtJd8sX3Awm2yi1Qgwjx35/Oz4
         zPdvr/jKm8O9DW/yAigRytDE2M/JM1c9u2T1aYFq1Vqq3EGYkKwBvONgL6HsaK7rGkdl
         BuCMLA0MeoVxQF/NnComEU4VzyuQOIGAhk1OM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706798510; x=1707403310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zsOO2ZkkdcJTbF0BB2qngAJPCReDSBqBxrVox/Wl9y0=;
        b=JhknUDLz/qJm7dEnxJym9OP8Oyverw2IVTPj37O3JvXXTcjzh7nwMvsF38v8jMR07m
         N8AOHm0APMAP65q4ufam29VFrJrQgH9ySLgMC0RHv51EJGDzIuSMUbwab6YIwYhVQ25K
         +dwqbV74c/2lC3lVxWyv+vCArr3iEZCcFBBgLglhCobkMGadYDTkemYxyahZnuwZNIUU
         aMYWeZNKKtg23+enEb/ztdzk/omz24+QD7dOkvdq8Bo6EkgnIDt2OYBoj0D3NMsjb6aW
         wwE+AaLWXI6+nzTOXF5iWK3A+zDIg0le4D0bmM0avfZsfMhHC+CWrdC+iJRoXUDwnegr
         /VcQ==
X-Gm-Message-State: AOJu0YxV6h5Uoea7QN1f2pqHqJh09bdo2bw2cAuIrqhA/key3jxMjczh
	iEAHoVcKK2JXsJBun05/mk75f5jQ0QGNCyNhwX7UqLNX9OX97pjgjVooIregSpsJ6NVaVcUkf3r
	PDQ==
X-Google-Smtp-Source: AGHT+IECVTnWEov+jCFj2fZ8xKJaEYD2OTncqoNZ2iSakc0LTQBDrz1iGvP2dTC0GhxAXNyuIwhWjQ==
X-Received: by 2002:a6b:6911:0:b0:7c0:2b65:ae30 with SMTP id e17-20020a6b6911000000b007c02b65ae30mr3036362ioc.20.1706798509832;
        Thu, 01 Feb 2024 06:41:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU+JVK19vUxraI4zFgdUoGz9sdiNKmOzBPCPDVipHptddB3ovn+dPTUufhZvPPdfO+eCrNNZf1/2oAKcoUgxf6annXzFt60
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com. [209.85.166.170])
        by smtp.gmail.com with ESMTPSA id j27-20020a02cb1b000000b0046e7a350046sm3426204jap.3.2024.02.01.06.41.49
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 06:41:49 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36376bf7f6dso3815435ab.3
        for <stable@vger.kernel.org>; Thu, 01 Feb 2024 06:41:49 -0800 (PST)
X-Received: by 2002:a05:6e02:2389:b0:35f:b61f:a8a8 with SMTP id
 bq9-20020a056e02238900b0035fb61fa8a8mr7594283ilb.26.1706798509204; Thu, 01
 Feb 2024 06:41:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129170014.969142961@linuxfoundation.org> <20240129170015.067909940@linuxfoundation.org>
 <ZbkfGst991YHqJHK@fedora64.linuxtx.org> <87h6iudc7j.fsf@meer.lwn.net>
 <CAFbkSA2tft--ejgJ58o3G-OxNqnm-C6fK4-kXThsN92NYF8V0A@mail.gmail.com> <2024020151-purchase-swerve-a3b3@gregkh>
In-Reply-To: <2024020151-purchase-swerve-a3b3@gregkh>
From: Justin Forbes <jforbes@fedoraproject.org>
Date: Thu, 1 Feb 2024 08:41:38 -0600
X-Gmail-Original-Message-ID: <CAFbkSA25o88DjaWHc3GRk5vkvANnpi-NJ61XJudz4=ARTyrhtw@mail.gmail.com>
Message-ID: <CAFbkSA25o88DjaWHc3GRk5vkvANnpi-NJ61XJudz4=ARTyrhtw@mail.gmail.com>
Subject: Re: [PATCH 6.6 003/331] docs: kernel_feat.py: fix potential command injection
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, stable@vger.kernel.org, patches@lists.linux.dev, 
	Jani Nikula <jani.nikula@intel.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 8:25=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Feb 01, 2024 at 06:43:46AM -0600, Justin Forbes wrote:
> > On Tue, Jan 30, 2024 at 10:21=E2=80=AFAM Jonathan Corbet <corbet@lwn.ne=
t> wrote:
> > >
> > > Justin Forbes <jforbes@fedoraproject.org> writes:
> > >
> > > > On Mon, Jan 29, 2024 at 09:01:07AM -0800, Greg Kroah-Hartman wrote:
> > > >> 6.6-stable review patch.  If anyone has any objections, please let=
 me know.
> > > >>
> > > >> ------------------
> > > >>
> > > >> From: Vegard Nossum <vegard.nossum@oracle.com>
> > > >>
> > > >> [ Upstream commit c48a7c44a1d02516309015b6134c9bb982e17008 ]
> > > >>
> > > >> The kernel-feat directive passes its argument straight to the shel=
l.
> > > >> This is unfortunate and unnecessary.
> > > >>
> > > >> Let's always use paths relative to $srctree/Documentation/ and use
> > > >> subprocess.check_call() instead of subprocess.Popen(shell=3DTrue).
> > > >>
> > > >> This also makes the code shorter.
> > > >>
> > > >> This is analogous to commit 3231dd586277 ("docs: kernel_abi.py: fi=
x
> > > >> command injection") where we did exactly the same thing for
> > > >> kernel_abi.py, somehow I completely missed this one.
> > > >>
> > > >> Link: https://fosstodon.org/@jani/111676532203641247
> > > >> Reported-by: Jani Nikula <jani.nikula@intel.com>
> > > >> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> > > >> Cc: stable@vger.kernel.org
> > > >> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> > > >> Link: https://lore.kernel.org/r/20240110174758.3680506-1-vegard.no=
ssum@oracle.com
> > > >> Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > >
> > > > This patch seems to be missing something. In 6.6.15-rc1 I get a doc
> > > > build failure with:
> > > >
> > > > /builddir/build/BUILD/kernel-6.6.14-332-g1ff49073b88b/linux-6.6.15-=
0.rc1.1ff49073b88b.200.fc39.noarch/Documentation/sphinx/kerneldoc.py:133: S=
yntaxWarning: invalid escape sequence '\.'
> > > >   line_regex =3D re.compile("^\.\. LINENO ([0-9]+)$")
> > >
> > > Ah ... you're missing 86a0adc029d3 (Documentation/sphinx: fix Python
> > > string escapes).  That is not a problem with this patch, though; I wo=
uld
> > > expect you to get the same error (with Python 3.12) without.
> >
> > Well, it appears that 6.6.15 shipped anyway, with this patch included,
> > but not with 86a0adc029d3.  If anyone else builds docs, this thread
> > should at least show them the fix.  Perhaps we can get the missing
> > patch into 6.6.16?
>
> Sure, but again, that should be independent of this change, right?

I am not sure I would say independent. This particular change causes
docs to fail the build as I mentioned during rc1.  There were no
issues building 6.6.14 or previous releases, and no problem building
6.7.3.

Justin

> thanks,
>
> greg k-h
>
>
> >
> > Jusitn
> >
> > > Thanks,
> > >
> > > jon
> > >
> >
>

