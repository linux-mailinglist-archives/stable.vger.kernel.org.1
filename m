Return-Path: <stable+bounces-160250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B7BAF9F4B
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 11:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94F90161DFC
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 09:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFEE243968;
	Sat,  5 Jul 2025 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvS/y+Ti"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A151F91E3;
	Sat,  5 Jul 2025 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751706775; cv=none; b=TsHhmYQjyp6fBRyBbdC5WhxqBohocfoGs/zKEohkwQ8w/g1++EOSWT74/gCkG/nbdNn5qVgpgBqacOP3HUloiU+3tOHd3qihcYyJeRRWjsNF72leRm+ucJSviTRxkZzN5tooS/6X/1nrqvk/Y82Qbn4tMFGxO5tIymvqOZUYF0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751706775; c=relaxed/simple;
	bh=689kMGlfw/AXPQyRh4q1p7yztV4sChW1owy0XyzKNNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rOjMTvVRpownpG+j6WSXlMTX3GNNsmUt5zeaWX0VkMz1LofAL6Z8Cw9+vRoPb2FB9MrgQrGv+KJmzLg5cN5jesXys5U0UBROxCOkA12Uz5Oeojji5/P7tYZi7QRO2C/Iy9BgDK6KlLOIOTWWYQE0H4ORZWF9yiM9keeF+XwX0S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvS/y+Ti; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b2fca9dc5f8so1515607a12.1;
        Sat, 05 Jul 2025 02:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751706774; x=1752311574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfCXkXHDaEjNnEyIkF2hEs+NlnYvPJOJtgT08NxFhD4=;
        b=OvS/y+TilN5QBhdDGWj1upF+9suz+Un03g4Jt1GkZIbDczZNw164KoZFErbDepHkKY
         qsOp3/oGUD/XZSdsgvafXMFYdldzNLnP2mCk7EAGP78TA4xMDEO0hzkqc1zC9fNKT04A
         qfoTTR+Y6fCMOXGzurcxUMpvhs59TMFzixzM1LhctloGH7riOWMHq604kpcg51RpuJsa
         3bRT5vPc4RFtsA1DgvzbyaEhDQ0mKuKlcD2q4PzxUzZrSCMart7PUg88Dx4Mij7KvGHB
         nuepB/Iwbl/Wztq5ENvNizxsvd0zW/BLrH+RaeAVklp69NcGngK5yFtPC7QKKggsqdZC
         /KUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751706774; x=1752311574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfCXkXHDaEjNnEyIkF2hEs+NlnYvPJOJtgT08NxFhD4=;
        b=cvpue7WVeGiCEDdx9usKTSLxZ44AznGKM1ve4MiKl+docxhvVTrbkmU+nO4EEhrHSk
         7OcrGt+fTuVuzg63z90SaShEdzigSQhK+oIUG68y4Rdex374PqjnxNfjfM74Lj81oy0o
         uATPfNOz1iHHhxxHCt4Iksrmpr2VIpG0Wgk8voV3MEmR/11zgY41FxWvILE5G2t0QcbD
         D2Bb+CU+Tg4mTdBGBQlAyn37efW5LJMyvaD9Ud+gYtx2YPWa0Dj7F7HC5vYgZyjbYit7
         8YGZHa6eWCv9letrFKD6yPxXf2n0QvVsqCpoY//lPjpf1ObgEFXdiI6zZITVPY9a/Wh3
         aZ5w==
X-Forwarded-Encrypted: i=1; AJvYcCWI+YWiMvsZij8+1lQwxKFVdYiA5d5NJqWi0oWuyy7yvOH2QDGcMNsoSSaSvFrFCdS75FGsxeGHdyQ4qF4=@vger.kernel.org, AJvYcCWXQN9GvEykQqWWyjr89qVsncHCg3F2lACg893bbXcHMCbDQlGPPdyeZeY4HLsRnUrLhIMsqgWA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ebPhkznyNeR+RJwDWfDdct1reWWDxcZ1Rl7qzUQZBoGwVVUO
	C+PVFLoaaQ3dXfP2FRf1afd+pxuOZ+/kew3LUHyJZ673E34NuC8BU8d1Uxus0TJy/Ei2tQnLeXf
	a0gj1W/UvsakktojqZpFknc07qHNQ2pg=
X-Gm-Gg: ASbGncu0r4m1uj/nK7m8nBXubv2qn1BtJo6bVnkX8ktKMdXQyb+PM7aAyxQLjAhvQCb
	9AU37gX4cowdARr6HCkUTnsWEMcxg+/c4eWt3qrzBSDvmfcfsZRATbHNRrKrPGWiUWxmOpoViHE
	rajsF4026vHw6fW8YiXFOqhxzDdYCeUkq1qRE5dzlPFe9zoZ2HkCMmoChpFr0piOfh+CDD
X-Google-Smtp-Source: AGHT+IG/WtW0xjZh0wKEbz7+4/Sg6thCz7rb+9uIqEpg1KInw/zMM4qoCcIvo6ocYuGVF4Fhm4aZz9v3eod7uv50HTg=
X-Received: by 2002:a17:90b:5408:b0:311:fde5:c4c2 with SMTP id
 98e67ed59e1d1-31aba824c2cmr2361813a91.1.1751706773736; Sat, 05 Jul 2025
 02:12:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704125604.759558342@linuxfoundation.org> <7cc923fe-ee44-4bdd-9b1e-1fc227f36bf6@sirena.org.uk>
In-Reply-To: <7cc923fe-ee44-4bdd-9b1e-1fc227f36bf6@sirena.org.uk>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Sat, 5 Jul 2025 11:12:41 +0200
X-Gm-Features: Ac12FXzx8W3c29yzVdoZqq3towFPGPGuutw5N4ckvtlhKb85jxxx06YsndN2rg0
Message-ID: <CADo9pHh7GcQj=eqQ314fp-R4O0Pf8h-Ku2UL-XoYeb9bbY3pgw@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/263] 6.15.5-rc2 review
To: Mark Brown <broonie@kernel.org>, Luna Jernberg <droidbittin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, hargar@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Luna Jernberg <droidbittin@gmail.com>

AMD Ryzen 5 5600 6-Core Processor:
https://www.inet.se/produkt/5304697/amd-ryzen-5-5600-3-5-ghz-35mb on a
https://www.gigabyte.com/Motherboard/B550-AORUS-ELITE-V2-rev-12
https://www.inet.se/produkt/1903406/gigabyte-b550-aorus-elite-v2
motherboard :)

running Arch Linux with the testing repos enabled:
https://archlinux.org/ https://archboot.com/
https://wiki.archlinux.org/title/Arch_Testing_Team

Den l=C3=B6r 5 juli 2025 kl 09:58 skrev Mark Brown <broonie@kernel.org>:
>
> On Fri, Jul 04, 2025 at 04:44:42PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.15.5 release.
> > There are 263 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
>
> Tested-by: Mark Brown <broonie@kernel.org>

