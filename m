Return-Path: <stable+bounces-83046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E66995214
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 16:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666962849ED
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA821DF27A;
	Tue,  8 Oct 2024 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRHZYuB6"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1DC1DEFC7
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398461; cv=none; b=T+/oNFhT9tQt1GxdlIxSxFtx9YY0bZ0hRHjMHKR4x5v2i71byGR7ToL53phxvPNA0uRcCM2/rnRD3I/MIdIkfna//q53VS27ZDDuFiO2GLsE20Crcu2yhJIjdTcfGKpmpPBa+XVb9UqjSCiaI792vBexphpB/c+M82O4BUZH3s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398461; c=relaxed/simple;
	bh=PFjVtz4inbM50WtUyHtYw0Am2Az3EpMC8mLk1Ellgr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QfEmbEkHV35xJdnUXRsI2jTDpgjPDsBugm4PIB2cMxXQrzQjZygRKL1Xwe6zBIXUcZfQ4K82+MzcD56uBGES/oyNqbhGyUyy+YEoBFd4fAuP08oeYr1uj/XS4Dh1e/DSDXZ5KS97cbib19tslI3eYKAb+2LHlCbhwP7ut3Fo6rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRHZYuB6; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5398e53ca28so6343441e87.3
        for <stable@vger.kernel.org>; Tue, 08 Oct 2024 07:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728398457; x=1729003257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZyeaaLdT9Ra809qAoYWtXxMYfajBYOU3xJzmen+kJX0=;
        b=PRHZYuB6vtG1DP8yuZ0y1qzz+wJK1wjGUJUxr0rUpA/A1h/wQ4h5BsNDZUIUTM1Bgt
         I2gw2GGoB0uL9mfjSdsmXcqomUgAztP+5HxzzyXA43e3TlqdW84XxRg7ybueD/EhW3RN
         AJxqaqVyEqot+qsPFoWSMSwlCJbWAefpeVPBWxOktnnMZhkDLIPjffswFJzarLkDmXAx
         krQ2oMYiQMY5EAZldOCnWTGr27SMoElvfDx+GvEkRAc+Wj5zvknE7zqgv6ALCYMEfs7T
         Wdj77gndu5rNqRU5P1tMiMwlryO//PjK/ienA1EMrXpEx1ZvAwn1u5jSFRwpGRK3cXjm
         /qpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728398457; x=1729003257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZyeaaLdT9Ra809qAoYWtXxMYfajBYOU3xJzmen+kJX0=;
        b=OGyGXq5SofJe46fDF+pX2kI6rs6dmtW75igJHOCF92zq4IrKAf6SK5CJRtaMWjzsrg
         5qcnvm0rj8vaAVEzywWx2tmj17KAWAfhjlHIrcq3bF3Cw4Qr/3ycHM8/1Azu5+8+l9rD
         DLicOKVM57ThjRZYx/SniSDS2nPc/cbaSTsRycdJeTFDdm66FSqr6LOAWsuPGuwWMi0r
         CkCHZJeIvgqI1hMjxtjpRoZlnaxe7PyPm2jsOocsUmrT351KkCPQDO1itJiXQRAelDcX
         2TSmacujfhD9efAkt3SgbH0CPz5jiNENWqa5EZmMaclfiFaVoVdGk3JDT/5qKHHb7V/G
         Kp7g==
X-Gm-Message-State: AOJu0YzY7lbzCXzhMSc5/rf3KPtdVdKPWOM4cqN8Vf6y6Xe8MKPBD1Cc
	wOR9OSvA52ZAOmpu1Z7x2oh6uexXZ8fAYL7hdfInfea4chhFaT5q0Q+AUqL15XDOrwoGzKnsAo9
	c8btShVuzFbfw8V+UVS8UqY18n7Q=
X-Google-Smtp-Source: AGHT+IHkZ5rKBCsEBpDfsa1I3/8Mm3hBa4OOzVnd8soxtgOcDmi2R/2AKM9AT4MMrOEK8Pcdjg0UnOxJtpMlkN1DQOM=
X-Received: by 2002:a05:6512:124d:b0:539:9ee4:bab3 with SMTP id
 2adb3069b0e04-539ab9ed195mr8513939e87.59.1728398456989; Tue, 08 Oct 2024
 07:40:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008115702.214071228@linuxfoundation.org> <20241008115719.272201292@linuxfoundation.org>
 <CA+icZUUjDD6r1NMQ6Kiscq8Yt0a-vBYjh1SiW1oNMQEKPWXQbA@mail.gmail.com> <2024100859-enviable-phony-9be8@gregkh>
In-Reply-To: <2024100859-enviable-phony-9be8@gregkh>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Tue, 8 Oct 2024 16:40:20 +0200
Message-ID: <CA+icZUWV_ooRHbSmxj6JuaOGXhdkr1jUSK+TkfdvX-JaiG5MyQ@mail.gmail.com>
Subject: Re: [PATCH 6.11 432/558] perf python: Disable -Wno-cast-function-type-mismatch
 if present on clang
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 4:06=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Oct 08, 2024 at 03:05:41PM +0200, Sedat Dilek wrote:
> > On Tue, Oct 8, 2024 at 3:01=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > 6.11-stable review patch.  If anyone has any objections, please let m=
e know.
> > >
> > > ------------------
> > >
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > >
> > > commit 00dc514612fe98cfa117193b9df28f15e7c9db9c upstream.
> > >
> > > The -Wcast-function-type-mismatch option was introduced in clang 19 a=
nd
> > > its enabled by default, since we use -Werror, and python bindings do
> > > casts that are valid but trips this warning, disable it if present.
> > >
> > > Closes: https://lore.kernel.org/all/CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haF=
neX0C5pUMUUhG-UVKQ@mail.gmail.com
> > > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > Cc: Ian Rogers <irogers@google.com>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Cc: Nathan Chancellor <nathan@kernel.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: stable@vger.kernel.org # To allow building with the upcoming clan=
g 19
> > > Link: https://lore.kernel.org/lkml/CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9uy=
3r2MzKXwTA5THtL7w@mail.gmail.com
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  tools/perf/util/setup.py |    2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > --- a/tools/perf/util/setup.py
> > > +++ b/tools/perf/util/setup.py
> > > @@ -63,6 +63,8 @@ cflags =3D getenv('CFLAGS', '').split()
> > >  cflags +=3D ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unu=
sed-parameter', '-Wno-redundant-decls' ]
> > >  if cc_is_clang:
> > >      cflags +=3D ["-Wno-unused-command-line-argument" ]
> > > +    if clang_has_option("-Wno-cast-function-type-mismatch"):
> > > +        cflags +=3D ["-Wno-cast-function-type-mismatch" ]
> > >  else:
> > >      cflags +=3D ['-Wno-cast-function-type' ]
> > >
> > >
> > >
> >
> > ( I already responded to a stable-commits email sent to me, but here
> > might be better. )
> >
> > Hi Greg,
> >
> > You need both patches:
> >
> > upstream 00dc514612fe98cfa117193b9df28f15e7c9db9c
> > "perf python: Disable -Wno-cast-function-type-mismatch if present on cl=
ang"
> > ^^ You have only this one - sets only the warning flag
> >
> > upstream b81162302001f41157f6e93654aaccc30e817e2a
> > "perf python: Allow checking for the existence of warning"
> > ^^ Add this please to all stable trees affected, Thanks.
> >
> > Explanations in [1] and initial report in [2].
>
> Thanks, now queued up!
>
> greg k-h

Cool, that will be a nice stable-linux version 6.11.3 for us!

-sed@-

