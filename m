Return-Path: <stable+bounces-210353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D061D3AADE
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 14:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D6F63000DDB
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 13:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C250036A01D;
	Mon, 19 Jan 2026 13:56:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60DF35B144
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768830969; cv=none; b=W/Y+H4jt08e03n89zbzGNhffqJx/TalwzoQJrio8jy8y8NBmmNbM7JyycX6/5ZhiyOyb8EW+X2rpXT3TwzLinz/lah5vZ/XrONfpOgQpS0Y0oaTpA8wE9TkTqYNmxkbbXmrgBoK/cg2s9GSX0v3buHR/MGjSjWECMFfWXZGTt24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768830969; c=relaxed/simple;
	bh=USU2dfqEi8y03HM3f87V6O1i0tfjkLsCH5ivCaeDP4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYrceaKGH/p5qouDPOGtNxt6JVZhNtX2WUI/ZfK2coDDasIhv92IvzmN0LHyLbgVibTtaIFPhsX3jlhM/dcJik4edwWolmITZhDgpMChKCw+FdAPzZGkeDimykPla8kSEKvupVEoUH6hLw9aiC+vB6Fa9k/+GBUj6x5fMGMpM18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-947fea7590cso8830241.2
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 05:56:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768830967; x=1769435767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+r64VZF3kohfXXfdlR1Pb964pfqiX29JMKKPRtqCraU=;
        b=ckgqZXIaPgv+sc1yX1Xlg8ywhwx4iklt0K2N0j5Fxyg3aIUuwInjKlOeSMPMkX/QWv
         4+Z+vB26j7j1qt82PSowdLeadI+hlzaGqTzgBSrUynb1OOaVwdid9n19yfC/1Sfqoe2q
         wC2RhLIB7m3P4LbJAZDUR5vBR5kWesB9LA2It70WwiMEU+PjLy+ZL9us9plNaNrnN7lY
         LmDPa8Ix9Q06Yt7DJDzCDMNz6ed2zgT53+cMkfn1etA+Xv8x6eRi0prOh3/bGoJh4/kJ
         gVZt/RTm8ubUEqiM3jhV1SreTkXZrnHlBlr9Rnl+fUhFwXZBXlaHKKKMn7OGRRNgu4zI
         kSgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtYPd31hWrAvg5RrBLb4EGmLqtjZ8rOmyJUJGHrOCggn4Ct4wHcIxroY6wBBCL8ZvPEeSXqAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2lpzemyFY02HwfdM+iKZrLvTYSYMsTScK7cROObaVQt9SKCnE
	hBOlxm9tSLhOGzDw6uQ/oLXCr4NuHV5y9nACXNYGoRcL6556oNdugREVmGe4SOgT
X-Gm-Gg: AY/fxX7ap0Unh3eJ3N5txrggwAbdJITWzWOxkQZzfgyZH5b2dhua+F7CMfgMosMhRi6
	EpENlOGP3ZEWngBKpP0BGDOFmcDg5GT6e00p4IWjy1ZdZJdAAVchkI17Gh2uUNMMBX60u7JTmsb
	pzRjdVjgoCP4dso5vNpshK6QqlkcDJYSS5F7EK+EMFDXSksNw/TrJ/WF4qcRHSM56EMMgWEExvq
	CZnPyN4+qEfVapDsWjUPpaBZ6AbxIYEWQn0s+krBFL8hVR+wmukfEvArOKG3+aC9NC2cbRWvlYd
	4hc2EoDSjw6SzoMBQKayj4tniieVv/CenBQb/CsFPUflbgDgpdjOMJSBtnTsfsoeAzjBY+xYlJ+
	rarerpeieXghVQ8UqcoSUKG/zu1eyCmMq8P/yo76ywIIOrkd6vc0bPn90y+xMb7QMVFV1p+qJVX
	GI8chK/pFp4JK/aIAl69NVP49dRzVFtXXjqDEhbPqdmT3m5+/4FtYq
X-Received: by 2002:a05:6102:c47:b0:5dd:b100:47df with SMTP id ada2fe7eead31-5f1a6fa452fmr2920527137.4.1768830966646;
        Mon, 19 Jan 2026 05:56:06 -0800 (PST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f1a6d3c9cdsm3457705137.9.2026.01.19.05.56.05
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 05:56:05 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5637886c92aso1040014e0c.0
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 05:56:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXdcB5vlq3l5zBEWePUvX02Wia2MduIXH2MbIIbjoK+nGt7DEKfp6HXO81ncVSvtDMowi16tEQ=@vger.kernel.org
X-Received: by 2002:a05:6122:3a10:b0:559:65d6:1674 with SMTP id
 71dfb90a1353d-563b738c18emr2498607e0c.14.1768830964978; Mon, 19 Jan 2026
 05:56:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118025756.96377-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260118025756.96377-1-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Jan 2026 14:55:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVkYUwYHOCtFb==YJ=1TK9+Tz1X=teaoyoooxe42eBYFw@mail.gmail.com>
X-Gm-Features: AZwV_QibGyBfaw9ULWtL_BEHCROa8nfd8JZ0JnZ6LzEfFQ4IkCqSKKVBJv4Vw8w
Message-ID: <CAMuHMdVkYUwYHOCtFb==YJ=1TK9+Tz1X=teaoyoooxe42eBYFw@mail.gmail.com>
Subject: Re: [PATCH] clk: rs9: Reserve 8 struct clk_hw slots for for 9FGV0841
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-clk@vger.kernel.org, stable@vger.kernel.org, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Sun, 18 Jan 2026 at 03:58, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> The 9FGV0841 has 8 outputs and registers 8 struct clk_hw, make sure
> there are 8 slots for those newly registered clk_hw pointers, else
> there is going to be out of bounds write when pointers 4..7 are set
> into struct rs9_driver_data .clk_dif[4..7] field.
>
> Since there are other structure members past this struct clk_hw
> pointer array, writing to .clk_dif[4..7] fields only corrupts the
> struct rs9_driver_data content, without crashing the kernel. However,

I am not sure that is true. As the last 3 fields are just bytes, up to 3
pointers may be written outside the structure, which is 32 or 64 bytes large.
So any buffer overflow may corrupt another object from the 32-byte or
64-byte slab.

> the kernel does crash when the driver is unbound or during suspend.
>
> Fix this, increase the struct clk_hw pointer array size to the
> maximum output count of 9FGV0841, which is the biggest chip that
> is supported by this driver.
>
> Cc: stable@vger.kernel.org
> Fixes: f0e5e1800204 ("clk: rs9: Add support for 9FGV0841")
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

The crash I saw is gone, so:
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

