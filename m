Return-Path: <stable+bounces-185999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4051BE2B97
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6B0A5E046A
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 10:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBE72E11C3;
	Thu, 16 Oct 2025 10:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2YzU8pK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC03328601
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 10:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609170; cv=none; b=ERkXGZKg/711kpl1P/JkZb8uIf6Q2G+CwBD/Ba4MzNF7LVP3Qg1guZdI8zuyFumKIzHsR6nAD4kLsyT2GRFZPQ71evaSYz9CVzbVag/i7+txSQRTGTNwZAGl2JBBzvOxnVAORsMb9u5tdrud69EeZh71efWEVMao/Blp9WPO6Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609170; c=relaxed/simple;
	bh=0bN7P+gtpbAg1qEU7iDnh8GWbGACYzseXtB9zCSy3tM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qt5JdTwwdbeKjaoUmASZTmoPXxCgoRjjyw0E9kwe5RbK0sks1u/uslnVf1++KlHrZCNp3CD/ZEn4DzhsfIBppec4cWbENv9aJYOTkCiocGAF/DHGrBOfAW4HLdut7DJz9e8ua0OExnAjc5tCk3o8tbT335DMyY6lULjUOa2pTCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2YzU8pK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F241C116B1
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 10:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760609170;
	bh=0bN7P+gtpbAg1qEU7iDnh8GWbGACYzseXtB9zCSy3tM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c2YzU8pKwKpCZ7OkJZmRM1/0XGCmpM9sf812vOMN4oJC/fLuRYG5wfHfxFru3UkvA
	 ld9DlOU+vEXG/gVr7rvOwRVq8cBHMLu9jSnl8xEU82HdPkaliVzH/jvFN0ady/YbZT
	 1hIhtZcOIjeElT2D+CF9teDnaYKqnWi6EaiTF3/i8jdONENCP/9U/B+PYcPJV2ncyJ
	 kcSTKzjFl1JFDQoHuURhHGLnZ3oAufPVnaHDahs1M01DEcacWae9Qwb+GYHAElpwUL
	 4jkuVnHhqxSLUyGafps7+O+TDj06J9Z/y+5PIRq2xHPLUg/rmZyfvbEOm//re7Tuv5
	 /iA2yUmpovYCA==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7abc631ae5cso405259a34.1
        for <stable@vger.kernel.org>; Thu, 16 Oct 2025 03:06:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXKJ8o5vXHJH/P7jyHZgPMu0WESsE/yZSd1X3+IN0/gAAOynxHHVO2qWLCCvRygkF3uw/o/0n8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKzEbYQvojXkuQD6qGtYOO/IDnR1rMwvprAtuJIvDmHN0KSyWr
	HHb0FpiN1Q1E7Un0sI5m2xS4qgKafDlw1sb5MsMd0GIElXBRrwagaCYDWNOdN1nRgZdwAZipHH7
	E21zmj2I23hg/reZg7NYvxrlJPuDwfgs=
X-Google-Smtp-Source: AGHT+IHfgDy+V/bvWWn9Fgz/trJVQRilHVaPhAXQ7+cCwduGIusWo/bnfDCrPq1eBxIcfcjZxfUu3pVX2vqrifOY8fI=
X-Received: by 2002:a05:6808:d4a:b0:441:8f74:fad with SMTP id
 5614622812f47-4418f74207dmr14024408b6e.58.1760609169586; Thu, 16 Oct 2025
 03:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8da42386-282e-4f97-af93-4715ae206361@arm.com> <nd64xabhbb53bbqoxsjkfvkmlpn5tkdlu3nb5ofwdhyauko35b@qv6in7biupgi>
 <49cf14a1-b96f-4413-a17e-599bc1c104cd@arm.com> <CAJZ5v0hGu-JdwR57cwKfB+a98Pv7e3y36X6xCo=PyGdD2hwkhQ@mail.gmail.com>
 <7ctfmyzpcogc5qug6u3jm2o32vy2ldo3ml5gsoxdm3gyr6l3fc@jo7inkr3otua>
 <001601dc3d85$933dd540$b9b97fc0$@telus.net> <sw4p2hk4ofyyz3ncnwi3qs36yc2leailqmal5kksozodkak2ju@wfpqlwep7aid>
 <001601dc3ddd$a19f9850$e4dec8f0$@telus.net> <ewahdjfgiog4onnrd2i4vg4ucbrchesrkksrqqpr7apyy6b76p@uznmxhbcwctw>
 <CAJZ5v0inu-Ty-hh0owS0z0Q+d1Ck7KUR_kHQvUCVOc1SZFqyjw@mail.gmail.com> <ytv4w7uw23fwdkihbgrpegmco6yzkxmzjbakmxtricreou6p6k@rhwxcjq3jvnv>
In-Reply-To: <ytv4w7uw23fwdkihbgrpegmco6yzkxmzjbakmxtricreou6p6k@rhwxcjq3jvnv>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 16 Oct 2025 12:05:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ii-pBMj2aQmH8no920wb_XO7ReOVQmy+V=CozmFm8HfA@mail.gmail.com>
X-Gm-Features: AS18NWAfKXsVHMgRaJMtGIOc7V03yC_KT5OmPpvqxdp79_xFs9amUoBgdY_JNMs
Message-ID: <CAJZ5v0ii-pBMj2aQmH8no920wb_XO7ReOVQmy+V=CozmFm8HfA@mail.gmail.com>
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Doug Smythies <dsmythies@telus.net>, 
	Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 12:00=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (25/10/16 11:48), Rafael J. Wysocki wrote:
> > All right, let's see what RAPL on that system has to say.
> >
> > Please send the output of "grep .
> > /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_*"
>
> /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_0_max_power_uw:600=
0000
> /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_0_name:long_term
> /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_0_power_limit_uw:6=
000000
> /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_0_time_window_us:2=
7983872
> /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_1_max_power_uw:0
> /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_1_name:short_term
> /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_1_power_limit_uw:1=
2000000
> /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_1_time_window_us:9=
76

This looks reasonable, so I'd rather not recommend playing with it.

