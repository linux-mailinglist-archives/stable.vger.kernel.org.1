Return-Path: <stable+bounces-42820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4338B7E7F
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 19:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9291C2257C
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 17:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64724180A69;
	Tue, 30 Apr 2024 17:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E3fQ7nWt"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968181802A0
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 17:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498214; cv=none; b=I9J/AOBlmLTt8CWQRbQsZtR5Eh6vwByChrAk/Qu/pHbTycEZfDaiHDDGHxiFBZKZePptc4WESbQA4j+kSyD+jEYpjr+sy8DCYCaSoF+YtKS/FiqBDFr5NuB6H4b8CbQ+xRgjffb0JAZbQYtD+ZYWcYGGL44WhdItb837qEb1pk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498214; c=relaxed/simple;
	bh=BR9Wkd6miBhzfBRCvTbhOcpLA80oqmQjUGpUH96Ratk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oV4XAxaE2Ojs0JhhsYyuM+JlsMkJtcoGbvDeIbsN3IpoYqnqAFqncfGHfT5tPHEsI/5LgpehdtzkMhDsafkKDhHwkDu31a5yG1kr2zf+8B/42Nh85yaOJoouXwVn1J59hrzdJFiCKfZaaFdEJYrbyjF4bfzFD8KpqsoPc3tmk5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E3fQ7nWt; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso945a12.1
        for <stable@vger.kernel.org>; Tue, 30 Apr 2024 10:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714498211; x=1715103011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awaW7AT0wOcGmKhgMWqej99cmUwIAXC84LCX446x4FU=;
        b=E3fQ7nWtq0h9yfZi/OzLRPTB2tGnydDkoPI1hk3+4siYKA3C8bStTw9+poPooBbbZY
         wpHOyB3udWf7SMQd5EumaDO/N5Vi38cZdZWKs27l8ssk6OYKKhPpP6vzgNpzLVEf73zq
         6Ko2G1+Gxtk+uuiJCUCn3sPRHMFKLZQ+OprCkert8yjmvB3tnqai3Aes1I6cePUlgc0k
         rMKCBgIrsQzf+tb/4hdP/iq1kUoXMz7FgC6d/RTLBTRKBsoasjIJC09iE5imzZRZqERe
         mrsUvIPDEggWeoBQ4PCvQ8BL5DmB0WuERrGAA2Y5SDsD5UM1r3d8LGgVoSJ4aliWkoo8
         U2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714498211; x=1715103011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awaW7AT0wOcGmKhgMWqej99cmUwIAXC84LCX446x4FU=;
        b=ZLnIAH2DSF1zqrx8aB1o5GwQELwVdk3tWylxFoJZ4pzugmDaVX+SMhehkPx+zYBKaN
         +BnLDbbsLJik5OBFDuQxjOeCfG1WnHZD6T5LXNZd67WVJ5nanYxBjh5i4Lb2ngbtrN37
         Vg3JWlhm+Ul5TTE6pIeac+LGf3f+bgeEgkhhW97+0lO0kjZfLoRO1/WdbnhLn/mxDI45
         bwrkas7egqXjArTZHSPyXAZd01iD09B8WtDv0FZUP8JXxVvK0uRD4znumAczEF7sWea5
         m6J7gTu8t2SgPJVfHwFvE2EmXGMlFMLva2p8/e4WQjh208+gzN1SIrLFPu5u0JW2tr4g
         ELHg==
X-Gm-Message-State: AOJu0YwR6LEXiPiw//RXK2jmFDbBo0sSJnognv/gOagbYCgYBC7/iZnU
	PMfX9FLsHnCdoHG1b2m4CTLJ7Dc0yPfSKq9A378iyHrltbX8Mt91zai9G8nvmpWyU2hKBCP63qS
	wAziZ2EpMwnA3YHF51qS377YPW4K1Z6Cc0Dfh
X-Google-Smtp-Source: AGHT+IH+9i4rJwPsBQqyArNc6DyoylM2VtMH1uR90G8+UmkTIaIfFTHI45q8A/gfsHjMbdT2dAMNGIl7Sk7gnVSSnaI=
X-Received: by 2002:a05:6402:3105:b0:572:9960:c21 with SMTP id
 dc5-20020a056402310500b0057299600c21mr145767edb.7.1714498210546; Tue, 30 Apr
 2024 10:30:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430010628.430427-1-edliaw@google.com> <2024043037-debate-capsize-e44c@gregkh>
In-Reply-To: <2024043037-debate-capsize-e44c@gregkh>
From: Edward Liaw <edliaw@google.com>
Date: Tue, 30 Apr 2024 10:29:43 -0700
Message-ID: <CAG4es9VL8CdROKVygYi3YAo3ZuugXgiyt6uhf+3yq6s8iKfQeg@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] kselftest: Add a ksft_perror() helper
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>, kernel-team@android.com, 
	Mark Brown <broonie@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 12:51=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Tue, Apr 30, 2024 at 01:06:27AM +0000, Edward Liaw wrote:
> > From: Mark Brown <broonie@kernel.org>
> >
> > [ Upstream commit 907f33028871fa7c9a3db1efd467b78ef82cce20 ]
> >
> > The standard library perror() function provides a convenient way to pri=
nt
> > an error message based on the current errno but this doesn't play nicel=
y
> > with KTAP output. Provide a helper which does an equivalent thing in a =
KTAP
> > compatible format.
> >
> > nolibc doesn't have a strerror() and adding the table of strings requir=
ed
> > doesn't seem like a good fit for what it's trying to do so when we're u=
sing
> > that only print the errno.
> >
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> > Stable-dep-of: 071af0c9e582 ("selftests: timers: Convert posix_timers t=
est to generate KTAP output")
> > Signed-off-by: Edward Liaw <edliaw@google.com>
> > ---
> >  tools/testing/selftests/kselftest.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
>
> This commit is already in 6.6.29, why submit it again?

Hi Greg,
I double checked and I don't see this commit in 6.6.29.   As far as I
can tell the earliest it has been merged is in 6.7.1.  Do you mind
rechecking?

Thank you,
Edward

>
> confused,
>
> greg k-h

