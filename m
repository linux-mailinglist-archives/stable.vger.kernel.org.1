Return-Path: <stable+bounces-80670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA1F98F4AB
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 18:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BDA01C21212
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 16:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D791A705F;
	Thu,  3 Oct 2024 16:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="H+pHav0p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADB81527B4;
	Thu,  3 Oct 2024 16:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974724; cv=none; b=SgqozB4bqm24E67V886vvTSqygjdRm1aOtusoNWhnXtof8NVo7yQlO3kEjkUO/n3ffrer/mDXcKDFIhy98AXXy8qlMS5W4YqxgmjM3MCCfa4MciQjdS/73mAGvnbXzVOj5QfCV42AKNyPKEEIwjdgWHIvm+xLxcfzHUQzgIHlyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974724; c=relaxed/simple;
	bh=1Al4baQ71iMJJ13PmLC6k6S9j8rDp1uq/IEjKpLC6f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRskJ6YprGCECcPVKAUfhJxlP0xXnGjmhl+xT8TVIaoXsEwnUAN8vXOPSeAzRIG0RMyTBpJaUrz2WRQ9DVKJv6MFg7JWffsDQGzEIM2kHDp8dQGUo+SRuKVyD4Vo9CiD+NZsLtdoNsyaW4AtahGBmZ1LQGdXSpOjTrx2CLMqnfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=H+pHav0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F991C4CECD;
	Thu,  3 Oct 2024 16:58:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="H+pHav0p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1727974720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JbBrNj2eqHQv+7fvlRDY7fHhBUnB7DyQvXIYqhKfZHQ=;
	b=H+pHav0p9CMpg+FMUHWpVGdaL9wygdPJOHppCT/KZpBFeqZRXH2BPquTToVjwpMd/5K3bg
	KZPD1NhcC3Y5gmWAf9b1MuMRf89oybFOo2qe7Iuoi4XROuKeYHGa/9ax9Okuy4ODQp5Tbd
	BflIavbwvVIN4B63tzKD7eBbzgxxLCw=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id edef60f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Oct 2024 16:58:40 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2879a491707so667973fac.2;
        Thu, 03 Oct 2024 09:58:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVBXRIEQI+jc6L0pHGYPUVM/xKtu2hFm4QgZQaB1XU1AYMXE6TF06qA8EbXPgJr7fEF5QD5tjD@vger.kernel.org, AJvYcCVIvXSFK2j9gKZB/wyTWuQnHadgPwCcz7fV205ut57/SRFpMxCgUXWJJvSbzD+UpSocEgI0Fc8no/10jd35kA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaSZTrfJyzsFN+UoRKSlU6HupVxVOIxd9NLWePUuZ0KK7kAuZY
	6RsIYeCgJvnfjooOOYE3mfS4ENhCAE0lY1uAwP9zaCCpRE/Zp7vMe4nS3xOBim/6Nt3zLsA6yZH
	/z8Y+dEiAJUSZNnjxVkX04DQWy6Y=
X-Google-Smtp-Source: AGHT+IGS7NNFaJheZFknD3mgdAwyV/CEMqa7JdYW9zI2y7wfJqeXYetwAWZKRFD8Mpr5O0/SRTN/rUkuEloKfTMADvY=
X-Received: by 2002:a05:6870:40c2:b0:278:64e:c5ef with SMTP id
 586e51a60fabf-287c228c35fmr41709fac.37.1727974719068; Thu, 03 Oct 2024
 09:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHmME9rFjE7nt4j5ZWwh=CrpPmtuZ_UdS5O4bQOgH8cVwEjr0Q@mail.gmail.com>
 <433ff0ca-92d1-475e-ad8b-d4416601d4ba@linuxfoundation.org>
 <ZvwLAib3296hIwI_@zx2c4.com> <279d123d-9a8d-446f-ac72-524979db6f7d@linuxfoundation.org>
 <ZvwPTngjm_OEPZjt@zx2c4.com> <2db8ba9e-853c-4733-be39-4b4207da2367@linuxfoundation.org>
 <ZvzIeenvKYaG_B1y@zx2c4.com> <2024100227-zesty-procreate-1d48@gregkh>
 <Zv18ICE_3-ASLGp_@zx2c4.com> <7657fb39-da01-4db9-b4b2-5801c38733e4@linuxfoundation.org>
 <Zv20olVBlnxL9UnS@zx2c4.com> <fa9e15b3-4478-4ba7-a00a-6632c98271a3@linuxfoundation.org>
In-Reply-To: <fa9e15b3-4478-4ba7-a00a-6632c98271a3@linuxfoundation.org>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 3 Oct 2024 18:58:26 +0200
X-Gmail-Original-Message-ID: <CAHmME9qNd=bZ2NwxebQfwKBWsfNOawqGGWNedMRjNQdug0xccA@mail.gmail.com>
Message-ID: <CAHmME9qNd=bZ2NwxebQfwKBWsfNOawqGGWNedMRjNQdug0xccA@mail.gmail.com>
Subject: Re: Patch "selftests: vDSO: skip getrandom test if architecture is
 unsupported" has been added to the 6.11-stable tree
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Greg KH <greg@kroah.com>, stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>, 
	stable-commits@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 6:53=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.or=
g> wrote:
> > The x86 test from 6.12 works just fine on 6.11.
>
> Yes x86 test is a good example to look at that handles 32-bit
> and 640-bit issues you brought up in your email.

The x86 test is only for 64-bit. It doesn't get compiled on 32-bit.
That changes in the series I attached.

> 1. Ideally selftests should compile on all architectures.
>     Exception to this are few architecture specific
>     features which can be selectively compiled either
>     with ifdef statements in the code or Makefile arch
>     checks.

The thing is, this *is* a test with an architecture-specific feature:
it's not available on all archs, especially not 32-bit ones. There's
the workaround (in the attached series) that I think might help
things. But for the chacha one, it just won't compile on systems that
lack the implementation.

> 2. Selftest from mainline should run on stable releases
>     handling missing features and missing config options
>     with skip so we don't have to deal false failures.

Noted. I would like to point out, though, that this is the "opposite"
stability guarantee that Linux usually offers of old binaries working
on new systems. You want new binaries working on old systems.

> 3. Reported results are clear to the users and testers.

Patch 3/3 fixes this up.

> Thank you for the patches. I will review your patches and give you
> feedback.

Great, okay. I think the series matches your expectations.

I have additional ideas too for the chacha test, if you think it's
necessary to go further, but maybe things are good enough now.

Jason

