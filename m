Return-Path: <stable+bounces-179747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AD2B5A0CA
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 20:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D611BC3ADA
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 18:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D727A296BC5;
	Tue, 16 Sep 2025 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ivor7bH0"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADA2276022
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758048580; cv=none; b=lmvdz/eZ2qUZLZLN7G1/3y8ogqtuO6yMOoMsw4XcJliT0UtgVEo7c7BfKUk3JEKPm7ByPSjBh+dOGp+KGkOJ8LJzfSX2TGSEc+9jv4xl1cg96LFZyFPekzZbymDsJztDb2+j58lqMVya9EjJg1NOqVxviuxGpIwl9UxCjAGjIfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758048580; c=relaxed/simple;
	bh=CwOOs4p5u02QjXqSm9YrW/H146OYAmM/J1lCjI1ymXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9LF1fO7cVo6xoxGdDfhLHNs53sMd1dInz755ho2BsDtXOzDD6NdrARgD8h8c3faUabHUWxaw48uiQG3SPYD+4RvCFDjWvPgg63rC9CfnmCQOjspFKr1xBK7wIEIzEDNOA4Sxx7JgnqL8SLabYnIMmA3A3E3D884iOIhzt6z1H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ivor7bH0; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5725e554ec1so2403120e87.3
        for <stable@vger.kernel.org>; Tue, 16 Sep 2025 11:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758048577; x=1758653377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8hUNIcLNhEAjmbVQOmRE723/QAzc6hWPOqxBb/zUjE=;
        b=Ivor7bH0HTYeXm8+F/xGCgozMBD/vBzJzke2FwE/gOx/WG2duraJ4Vh0fLfHRuobJ/
         djA0jU3MEy7SkeVSPcqpSEAptX3Yvv/Md5chGgCAZts2r32w30TTE8bMO1rZKneyWihE
         FEmLGbI43rj2hCULqW8fSdaOb+7V6qVG+0h6H4PikVA+STkpJWADtFRcAuGz4s9SxmM+
         7QURmeHpDMii2/q2f+P6vREgkA2QtQj3/6DSU1ZdPq4ayxg5RIwp/rlMPgjOkxz0nWGm
         3jrfALFdHgHkl2isFh4eQTtL8PqzWNu6MiFObirx9HJIpKPGuS7rmxxb3estDpcA7FeT
         R/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758048577; x=1758653377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8hUNIcLNhEAjmbVQOmRE723/QAzc6hWPOqxBb/zUjE=;
        b=TO+WRCVHXeTkzO5N2WQ8LC25fAcZUK5yHE57An+nW2UAy20v1xAqjwHoMq+J6wo/cw
         utpklUDe1bqk7gW3OYgFzlEv3nCjy+39asQoo8FNEJvPdayDSnQq+hisZ5pY/FQltZ6Z
         tdm3V9fzpDdwJ1g52vSSMFQxBthaTnRPj1dsYNTi/A4zsqfwFF61w6I4Si48cw8ulB2N
         1JBvQH9b3fv5MkhAuMbzh/2waUckAb0J/GcM+pIPlQAzABP1Lj07e6O7rf5X/KAKQ7Cu
         uSMQsa34GbYJIPbIm1roGHtVlHq9CfrRCGPCJdEit5qZFDQv9F2plgcCjo7aTh1dPZJR
         jXng==
X-Forwarded-Encrypted: i=1; AJvYcCVAIT2WOdQqZ9qbncv7HJ01lZeB+YAumIFmf4/QXRos2tREiYtUZIPiXSWigfGimW5AdoOcKBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfywMN+YfNPO6GPKbgUPQlb0v0vMy+k/OSC+KLwNwhqKyKQo0x
	5mCAQydl2LJmlBQBjakYC8+P3chLu1oqJTyR2rXdg24CACm0LL+8zvFPHk1kpbuYhNPBNiGmfR6
	dNFFhkHmizVb3LVN3H3kbomHAhyg2bKCfCA9ziSMYdA==
X-Gm-Gg: ASbGncsvrloqpc6s9FOa0XgZvXm8ushKxM2e/j+KWhHoFeIsbgzB1WPpCq9Cifumo6+
	SAm3reDDs3qJ2g4PJXm8xX9GuMZ8IeV2wLO/nUFiEo4pCIevwLTt4KNFE8HInIgUhHZ0N+NrOKq
	MF6ifCvqYPV4eD7bwSlJGqSk/Poqld+mlgmDQ1MfuZhQX33qVPbdo5rsGetLnA/2fla8neFXzJH
	CZ4+f1TTINIkMHTmA==
X-Google-Smtp-Source: AGHT+IFWMB9ShdcYx8fMWtU8U+XlPFLnlPvnZn6DzK46kDUBhr9E6r4BDz2ZVs43BnlSb4Ka4zWE3fiiN85aWZ8NypA=
X-Received: by 2002:a05:651c:25c5:10b0:351:10a7:c6d6 with SMTP id
 38308e7fff4ca-3513e31948bmr41599921fa.24.1758048576899; Tue, 16 Sep 2025
 11:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250914-fsmc-v1-1-6d86d8b48552@linaro.org> <87h5x27ned.fsf@bootlin.com>
In-Reply-To: <87h5x27ned.fsf@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 16 Sep 2025 20:49:25 +0200
X-Gm-Features: AS18NWB8pXt8VlFK5JOJNRIBh51k88hkdes-XzTgU1xJ1txcw9ztLK9uIVVJE6w
Message-ID: <CACRpkdb-BxHb_xiyLf8Gx8PNTQ5nZEd8geJwb+PH+pd+SKpubQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: fsmc: Default to autodetect buswidth
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 11:33=E2=80=AFAM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> On 14/09/2025 at 00:35:37 +02, Linus Walleij <linus.walleij@linaro.org> w=
rote:

> > I don't know where or how this happened, I think some change
> > in the nand core.
>
> I had a look and honnestly could not find where we broke this. Could it
> be possible that it never worked with DT probing and only with platform
> data? Any idea of what was the previously working base?

I tested old kernels back to 4.20 and it didn't work.
Probably it never worked?

I tried to recompile something further back but I don't
have the required old toolchains around :P

> Anyhow, this is just curiosity, patch is relevant (just a little nit
> below?).
> > +             };
>
>                  ^
> There is a spurious ';' here, no?

Fixed in v2, also made a more elaborate handling if someone
would explicitly set the width to 2.

I think the SPEAr that is the primary user always sets the width
to 2 so they never saw this bug.

Yours,
Linus Walleij

