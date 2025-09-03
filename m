Return-Path: <stable+bounces-177617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FC6B4206D
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 15:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C35684706
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 13:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D3A3019AB;
	Wed,  3 Sep 2025 13:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="PDVxDmUr"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D17E30100C
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904764; cv=none; b=WXExzQKqh3tvE0dzLLiy1HV1IEBha/CtKYQxgtEKZT2pvMBUciq1gHWANk8BySiZlzEJAOqCQ4Pvugm88zRrhrE6InNvGlMJwEMfOjrsZlp78Bw3JTSJ+RQIFuIANjtzVq7ndAAIB6sl6rJSkgrucex+WUcMw0BAgpv4vJIsFQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904764; c=relaxed/simple;
	bh=opK+eoV/7ps1WaBTTGCDe+X41cv1kkgjod7U/GTxNmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p68FlgZDmk6AnHHfHO93SLh4VDGnbtdXBEtOTsx/u29QPwoSh13ZwDZm2RPnCo0heIMGVEYLBis7nZAq9TorvP6ymPH4M+9SAPywSxCtqyewvS6tHp+zl8KJ28Pwbj9yUiXIl4gjH+IxE25L35F1B2XheRAtgAt8YuFOcpf90NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=PDVxDmUr; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55f6b0049fbso5669490e87.0
        for <stable@vger.kernel.org>; Wed, 03 Sep 2025 06:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756904761; x=1757509561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TceoMbVPyrzcVBNVbAOHGzxGRGxrO0zSw59TjOdJc7U=;
        b=PDVxDmUrO2ardprfNDxPl6E56Ek5dGP6yifeFdTnxOYL3/W1FRs2+NxfcBb0hMpt1R
         tHCUCAtgjsPZYKncnZumEG2QTGRALsCv32lr4tasPhAeQ7n3DUSDdMx3ksbA/LmlPvfn
         PJXEa57RchLe+bxvrtKapnyjnmfMtyCC90VkjVF8WV2G6PO9K3yD0NDgbWzmrqwBx1om
         xuJjGebhyWFAFdijDZcUFX8nWDoKYB7DaIzMo87oRlI3b5mw4bOm8qxVdaA9kxRf2+ok
         12L4rBHsctkY2wrbchP6EC0/8EF6cM4oIMTyJEL/B69SybspPTnTdLZeGOUPnrdOcOSg
         2P3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756904761; x=1757509561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TceoMbVPyrzcVBNVbAOHGzxGRGxrO0zSw59TjOdJc7U=;
        b=BQ5YFm0odJ5wbfs5vfOP7hGmpLye4jsez0U4Q9ih3gb5LMNYMSajmOo0WvhN6G4czY
         5Q2tsI5KUauMCRucCqMcXlXT/vGRau9gpQH3D0nySxkaaGDPk5HaXkrPBGahopMAz4hW
         gZrmGzEBuH+six1mH2jMmdAwo+x1QyFZUKBpHXzyrpQcKmNPgJS/dxhqMnOl3wUCItuP
         xLpdeLZUlIim7A7+ELUdhiHvHM7udsoMgunglxQ5FPEv6uT+JkwEWBUD3aYo8VzIApPe
         G2ROXKKxSm/rpSoWo+Aa2zxHVLAqVxXn3D4yYOaSrB3sdDgD3GpCoqVUBvBv8met8VTP
         C44w==
X-Forwarded-Encrypted: i=1; AJvYcCWNDj3qDygZMLHSHdb5NsyE4huiUMDMaFzRYSLMke3u5xsv3rQFVBRS9hFfFaKX6Djl2y9IXKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo/myWyAOImdNVNcTG0YijcC180hfZboobS/ucKhaRkTB1ei0q
	QZD/TYpRkLhDKTlmUDlfsY3EBNlmIxHIvrBfblFGenZnNwTBDm29c0Iw0xF7/jXevl6YdTbQC26
	pi+njO5TBtqzn7tP8s4R+XIipPjql9hzp/DJdAhQHCA==
X-Gm-Gg: ASbGncsSIyxPRiz8IAId35px0EecKiXtbXAUoZz19DXRAhO9sjIxSjWhQ695d79DDkM
	PgauP8CJ1XvqilotMdhOd2UmB3PDtROlsLOw7IWFNBWHT1Hki6GdPbaRtn7kyXbo4z13udJYmZ6
	89Op19DuAVmxqwc6jqm1nbVgNu7Xd+eEtFuj/BGE4W+s7z7EMgzhV8o/dRsCQFxRcmVIyMPtlTO
	bUy7NtJrh0H8WKoWt/82glMwimspLFbBCEoznKeYKOlCV3iGrSQs9XPD2f/
X-Google-Smtp-Source: AGHT+IFWW9Hzk4QvmFEIuxTuSzFqwAls1HtiU6FKjjOhdyOYjenmw3Gr/l6kYIu5clusIxlO2SHNIG7AoIrDQKR+nnE=
X-Received: by 2002:a05:6512:6812:b0:55f:43ba:93f2 with SMTP id
 2adb3069b0e04-55f708b5457mr3760512e87.18.1756904760711; Wed, 03 Sep 2025
 06:06:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-gpio-mmio-mfd-conv-v1-0-68c5c958cf80@linaro.org>
 <20250903090922.GE2163762@google.com> <20250903125524.GP2163762@google.com>
In-Reply-To: <20250903125524.GP2163762@google.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 3 Sep 2025 15:05:49 +0200
X-Gm-Features: Ac12FXy3NMzM2aB5ePiUft0RXfVSx9L7KjPMSrAtYJCok4KyCrb9wj58C2zdW0k
Message-ID: <CAMRc=Mfn-F+99EmwUABOy8=qh7W+ixL6hoEKvnmXd=EiW6QiaQ@mail.gmail.com>
Subject: Re: [GIT PULL v2] Immutable branch between MFD and GPIO due for the
 v6.18 merge window
To: Lee Jones <lee@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Pawel Moll <pawel.moll@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 2:55=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> This time with the correct commits!
>
> The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d5=
85:
>
>   Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-gpio-v=
6.18
>
> for you to fetch changes up to 9b33bbc084accb4ebde3c6888758b31e3bdf1c57:
>
>   mfd: vexpress-sysreg: Use new generic GPIO chip API (2025-09-03 12:45:3=
3 +0100)
>
> ----------------------------------------------------------------
> Immutable branch between MFD and GPIO due for the v6.18 merge window
>
> ----------------------------------------------------------------
> Bartosz Golaszewski (2):
>       mfd: vexpress-sysreg: Check the return value of devm_gpiochip_add_d=
ata()
>       mfd: vexpress-sysreg: Use new generic GPIO chip API
>
>  drivers/mfd/vexpress-sysreg.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]

Thanks! Pulled.

Bartosz

