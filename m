Return-Path: <stable+bounces-82594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F91994D9D
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C869B254D3
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453DF1DE2A5;
	Tue,  8 Oct 2024 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OU6FUvz8"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7790B1C9B99
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 13:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392782; cv=none; b=imqLg3JsF9691AX/SIbKo+HyGDz4wh4095RQhExapPbR1WW6YiSLPkr4L+iz6VhkgdDphKgAxwpi2CHqxMFdUFxahOZMwEqXeLCA7I7nT2DBWLALX8sgeGWRvmStxi0QE1s/f3P86gyJdQa5h2jDYC2ZfRPfORWMQAhOJMwFiAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392782; c=relaxed/simple;
	bh=ZKIw9oF7kf8LXffReeWJYdMoxH5f/wyn1hn+qjxWSr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N0/rQUTYEWeQbwFy5RYGAv38b2wB8prdVvcDz0mQ/LqyoIHfBdcay2lgx28EKkyou180kmdjz2+DFtDBkvD7EEeU1Bm8KEOKwzjNgZuP3tch0kIg73R4ELrA/x6qm3csffcRbf4wabg1S25JLqlK9UvesC9ow/WL/lvUZnNgtHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OU6FUvz8; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5398ec2f3c3so7059696e87.1
        for <stable@vger.kernel.org>; Tue, 08 Oct 2024 06:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728392779; x=1728997579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AZXPuf1MP0+FBM36WN27binVhvXifToPc71Gg+RoyKY=;
        b=OU6FUvz8MeEBBALJyoNDcfBpzPRXCVHI49+SVwM+YJZIe4zqWK89Z3tNEZQVZz6h9t
         WrTWEBWupKx40DJOUTQLz6nxLeCFiaPF/ztBv2uct6DDpxp6QpTSMvzHiLuLlGwZakmn
         GbAfE2NzWCgoj6GnnmSJzCroex2He4xg3Ri+x6FFx3FqQ9apIlXmckMqId4TSXqOTlPA
         rh1il7kQsBWV8/EJYMz2O/P5+7zNrMpgt+Nbeo1WvumURUN2KjlosdReXCpRVXgmy7Go
         E9GAZr+iTxH5xcCCru0/Jq6flSsPJNMU237SDb/QRx6HRXmT+TayR86jLo3NGT8bjGtp
         Y1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728392779; x=1728997579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AZXPuf1MP0+FBM36WN27binVhvXifToPc71Gg+RoyKY=;
        b=sRESMi5fD76ZXLJczs5AGmi1EsLWsM+9+rWMaVzuQOpjQ2glP3C34LPZdtzIw6YTIG
         sLjd8kGNc1Yr8//qeoaprxJk1KTOtyrTXkzX6rTgmdgIDjhHzsuogIBGYEnycfKXXLpp
         Pxf/0zIlV5HlWfgpMAKFoevwp0E4lYzLL5iXS73SkyuFImY/eHDUZoUWadp28pgbc99e
         ejnDwj7zV2lwQ1w02BgHvsGWjBJLN9OX/n/rpZtXALsFmMC5Ox/6X9/NQ9FSxS7hrjWT
         k/BlGMZ/Qx2omDqdif3KpCGStae/zeuy80znxku7WxCzkqBVhvrhLBLG96gYxCmxZCBM
         HjeQ==
X-Gm-Message-State: AOJu0Ywkcs+4nhQZbqd9CDeleZgU3pJgMlrsI6MPanIxdAeO6j2LHV6E
	G3nb0R8JXh1Bd/estfn9VbkoinFnJVTOkKRijFd6AgslAXTdMqBMjDgMq6QwYdQv5UJUWB+4/Eh
	iMJ0aXU8w9p0IKtH3PthTcAonZAE=
X-Google-Smtp-Source: AGHT+IEV/+IR+5r1Sh95Cy2fpLNjCqLi0ZNRlhsYUJtW8+aX41RKCdv4VBpHsLr5CS2LyUwVAFy1s+L85Tc2Tot+SWs=
X-Received: by 2002:a05:6512:3d04:b0:539:9867:eed7 with SMTP id
 2adb3069b0e04-539ab88c3d2mr8669494e87.24.1728392778418; Tue, 08 Oct 2024
 06:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008115702.214071228@linuxfoundation.org> <20241008115719.272201292@linuxfoundation.org>
In-Reply-To: <20241008115719.272201292@linuxfoundation.org>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Tue, 8 Oct 2024 15:05:41 +0200
Message-ID: <CA+icZUUjDD6r1NMQ6Kiscq8Yt0a-vBYjh1SiW1oNMQEKPWXQbA@mail.gmail.com>
Subject: Re: [PATCH 6.11 432/558] perf python: Disable -Wno-cast-function-type-mismatch
 if present on clang
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 3:01=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.11-stable review patch.  If anyone has any objections, please let me kn=
ow.
>
> ------------------
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> commit 00dc514612fe98cfa117193b9df28f15e7c9db9c upstream.
>
> The -Wcast-function-type-mismatch option was introduced in clang 19 and
> its enabled by default, since we use -Werror, and python bindings do
> casts that are valid but trips this warning, disable it if present.
>
> Closes: https://lore.kernel.org/all/CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0=
C5pUMUUhG-UVKQ@mail.gmail.com
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: stable@vger.kernel.org # To allow building with the upcoming clang 19
> Link: https://lore.kernel.org/lkml/CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9uy3r2M=
zKXwTA5THtL7w@mail.gmail.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  tools/perf/util/setup.py |    2 ++
>  1 file changed, 2 insertions(+)
>
> --- a/tools/perf/util/setup.py
> +++ b/tools/perf/util/setup.py
> @@ -63,6 +63,8 @@ cflags =3D getenv('CFLAGS', '').split()
>  cflags +=3D ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-=
parameter', '-Wno-redundant-decls' ]
>  if cc_is_clang:
>      cflags +=3D ["-Wno-unused-command-line-argument" ]
> +    if clang_has_option("-Wno-cast-function-type-mismatch"):
> +        cflags +=3D ["-Wno-cast-function-type-mismatch" ]
>  else:
>      cflags +=3D ['-Wno-cast-function-type' ]
>
>
>

( I already responded to a stable-commits email sent to me, but here
might be better. )

Hi Greg,

You need both patches:

upstream 00dc514612fe98cfa117193b9df28f15e7c9db9c
"perf python: Disable -Wno-cast-function-type-mismatch if present on clang"
^^ You have only this one - sets only the warning flag

upstream b81162302001f41157f6e93654aaccc30e817e2a
"perf python: Allow checking for the existence of warning"
^^ Add this please to all stable trees affected, Thanks.

Explanations in [1] and initial report in [2].

Thanks.

BR,
-sed@-

[1] https://lore.kernel.org/all/CA+icZUUfk6bMCo+JXUy=3D5g-4qt20rDNR3b=3DHC9=
Ln_47UozXEDQ@mail.gmail.com/
[2] https://lore.kernel.org/all/CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMU=
UhG-UVKQ@mail.gmail.com/

