Return-Path: <stable+bounces-53830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F6990E924
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0610A1F22DC3
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 11:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CD184FC3;
	Wed, 19 Jun 2024 11:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6DSPamK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5D64D8B2;
	Wed, 19 Jun 2024 11:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718795942; cv=none; b=kGmRvhyHUu+7WREs/EJJfxU57qt/03KzLv/6Mh5gdbjomKMqRcY91YP1kaU6Vt197VoJAu4Gb3NwJmpWL3omqrvMU2W/uhMpA+fKJSOqNUqDOKy2+gFhePZVvp/nxH/9Y/r+EDtTm+hd4y9VA8YBUm6qBiKGCEaB7F+b/P/zHNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718795942; c=relaxed/simple;
	bh=qx/037j5l/h26XirlFV4UFdaLFteBY/swy2KfQlGKZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMFfBpZovvbHjgcSLoZ6MS+0ROhkXCrg9WOU++ehlsTPaqe7b5CjoGInU3P11qMVEGrPfvd/wXm5XqdDI3M5RWPs6sVhBPSdfVqIV5yraCZh/5hwEd4loTKKj0v412FKf0zssp70E2aWt+o1Ia4CMnk338LlBfgt3IX+ZOMfldg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6DSPamK; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6fb341a7f2so67262166b.1;
        Wed, 19 Jun 2024 04:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718795939; x=1719400739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLVIq+eeSfRMQKg1AreCKiYpS4TWzLzpMNboeHds0vI=;
        b=S6DSPamKmdPt97iIn48RyFjcnlYlNEjo+0/esIimma7Cro/BMLhARI7rxwg+du0YLt
         lGdHhnIzp+P1TvMezbqYUoppeiw/49fSPgdaXKhcSdNWSoS9Jtdugzl5UWgpmfs24498
         jB7W2ADUvGBXZl1/XO6/N2cVK4anm/lUMPZ49I8WFrbkG5MDacICFqOb+AoyRg1fWW9T
         XGu9B+3Pu4Ogxobr2KJl62o853Cp5bbP0e4C6snoRaf1rC0r7O0rXthrgzp8S5mXm7hf
         H7XwHt+Fp1qoUo4M68sO05Ah/zI2RmwYLUxYxJoDfT7VmS+n+OswFs0bFAltkYGTQD2v
         MWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718795939; x=1719400739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLVIq+eeSfRMQKg1AreCKiYpS4TWzLzpMNboeHds0vI=;
        b=wIn3Pw74joJF/vMlfQzA6URNoYpfpTFEjm3PHFUg97wlwmDfzp9lRfELqEctzwrwhK
         1YlDxZjGXvj4OpjwJ8YtPi1Dg3b8/txQaSxJBxUwbqAZrEK6ZZyKLWcaFnz1KT1y3wMV
         Sd/pM0IaGRgthFnkQeGI+trzd73j380n8DYVg3TqQ68LSl6YGVzHRNP2ltNbv1X8kAMp
         VNgdzxo8fWGGrbEf31v9fiNTW3D1jazvKnL5jGV5Oq0mSgDxkSS7PerFBusj8wqGMkHl
         rb1qaYIn2B3xMk317JcELQJDUp80jThqEannC+h1PznOylS7kzK4MxmBDP7IJzBMJEKw
         8IlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkoytWEBWgMbWOleV6r4NfFRPOQVfE154VksPiMdiaqRzwyirrnMZfpapwAZWRJj5mMFs6T9vjHfPy/HmiQ1Mh77h6uJbHPHiBQbb43MZMR7xp62wmdHpWnUMp9S1WNLc5/U67vWNZholoH2d8otmK4qOSfdAzc/jXlnUU9ZNZ
X-Gm-Message-State: AOJu0YxHhI7GgVddOEUDt5ikSS2rk4YGmQ/susavZingJROrt3fUaWZD
	Nxs79+v4tVlvb1ij3Gvr/5xWRwuUWx1bxcwbxcT5Tii/YCKU7WZ3aBXx5DiSHCF4BbtyPjNOXMC
	tip/0QHSLnCiTLLIghrIhsFTqo6g=
X-Google-Smtp-Source: AGHT+IGICb+ryxdnC8Bm0bzuX9pSGgnIGjfjrPhkvEs3vkcekNWZ9OOSOET2zfCNqCAEIzzbZUhrHh6rWIR1j2CxIys=
X-Received: by 2002:a17:906:2814:b0:a6f:4e1f:e613 with SMTP id
 a640c23a62f3a-a6fab6488famr127124966b.37.1718795938561; Wed, 19 Jun 2024
 04:18:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619050125.4444-1-joswang1221@gmail.com> <2024061947-grandpa-bucktooth-4f55@gregkh>
In-Reply-To: <2024061947-grandpa-bucktooth-4f55@gregkh>
From: joswang <joswang1221@gmail.com>
Date: Wed, 19 Jun 2024 19:18:48 +0800
Message-ID: <CAMtoTm3+eSCeF_FQtyBZ1Yb43Sb_ABKDQv7zEueAHwXYGnv72Q@mail.gmail.com>
Subject: Re: [PATCH v6] usb: dwc3: core: Workaround for CSR read timeout
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Jos Wang <joswang@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 1:10=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Jun 19, 2024 at 01:01:25PM +0800, joswang wrote:
> > From: Jos Wang <joswang@lenovo.com>
> >
> > This is a workaround for STAR 4846132, which only affects
> > DWC_usb31 version2.00a operating in host mode.
> >
> > There is a problem in DWC_usb31 version 2.00a operating
> > in host mode that would cause a CSR read timeout When CSR
> > read coincides with RAM Clock Gating Entry. By disable
> > Clock Gating, sacrificing power consumption for normal
> > operation.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jos Wang <joswang@lenovo.com>
> > ---
> > v5 -> v6: no change
> > v4 -> v5: no change
>
> If there was no change, why was there new versions submitted?  Please
> always document what was done.
>
> greg k-h

Ok, I will submit a new version and add the differences.

Thanks,
Jos Wang

