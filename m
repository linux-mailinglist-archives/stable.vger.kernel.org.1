Return-Path: <stable+bounces-179169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF42B50F88
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 09:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DDB1C81FF0
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 07:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E77D30BB92;
	Wed, 10 Sep 2025 07:34:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC3630B532;
	Wed, 10 Sep 2025 07:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757489659; cv=none; b=N05B1plaEZz0tIbVgRM3RWZ6Ia46iGGehlVWCanMG3s0/ddTVJ3vuTGKDXNq8QFVjza5fGeKqVyUc5RDhlp7261ht6Jqc8YFrfZjLTd5yfb5NZsfZ1hszkIvgfISdeC2BPfsSKsOyJ1qRJaA8odkp610fNayWrE2WshliiWL+mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757489659; c=relaxed/simple;
	bh=7JVCTuxNSSrD3gp30fd3z1ICk15oPmTaX7Cu1euHSkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRPr85UAK/YcO6oxGYusnEE7xtMg4b62fyc1coAumKWNGKXCvVohovsfFRpX4/kySXSpAyHygeJi5PaKS1et7DiGCI1yQXLXwmCvtnCXKmMseiXlOsWMFt/l59N+LbTd94fQ1VQuY05tmLUAjlxD/aAcTbjuPN7UJpLQh9eyl3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-53410d0f4e7so5084178137.0;
        Wed, 10 Sep 2025 00:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757489654; x=1758094454;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FmLXE0lZ84N+xSM1hxrqEkto2TV6tPUT28zoISyt35g=;
        b=weyEneUHM33R3yV32qjP2qwivB4PTMVD6SxasglWcIjARU5TWVLFSHoQJJCq+bYHzO
         5hWZOew3ooLSo/BaRgLPQSNdKKisL6zIGqUt1oLDnlwG89SMGJ9j8kn0gS0fLd73qsqM
         Sc3dnX0TqjKJpbEULlSLt5eiJ9flGG2MZnMdWaeXsmVY4iaBzj75QgCg8u1guBd/+y0G
         HQxuopcalB48R+tCb19o2+HAbS4e75wZkLRw7FDmknYM9FZaXq/ehtFHFx1YHV4JEKpX
         ymCledvhwBgiilfim4slXnhmlyj2io5zX5WVh4+rMKMsOYeGYGq1Q1KMf4M/p3+Ovpre
         pvQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIy1fT6huDQfQrPjo7pZrD/UaDsiLdVci0vXqpMR6N0ahR6li2mZbMMHCVRfYqo0T9qocgdcXJR5x4358=@vger.kernel.org, AJvYcCVzPsezo66BiUcyhThd5tjMMcL8eOk0sNGDL+HhtMluQTRJ1WunMaYfdxNa+TzSvIExMecqx7pS@vger.kernel.org
X-Gm-Message-State: AOJu0YzKCjGk15SfTCsFqxEzN0PMNrvmi2A9NE+X+lLPBceJBEXugBFy
	l0frsb+37cHHiJo2/jXn2otqkVrRPNxiJAGmomqHc0hdd/SdqcQ1XuzMCOWujfW9
X-Gm-Gg: ASbGncvNfWJXTBtUUi1+GxBhXi5NIioLjgNIsLbZ5n0psx+GbH2xIe5DO5ef/lzU9Um
	BYeWy0sgcOiWiPekiJWRE0Z50yM+AWtLBcvs4KGvW3YyHt24mAbQzaUwq09Qu0iC+ArSviItLEu
	bZFHVBxr/GHS7C64M9wxL5eRRN7KZGVvOvkbxXVTKuDBtriBz9IpzCMZ4ELkKyNcHEBVxegs61J
	xrGw8mlZKtKuo5mDr09HeIpjuzHp5wkSdV/5grY0dkLStlPctOvu3eUfuOwvi3zxLMpk7xlCpjI
	M8S3I5TrfJFXT1dAD3/uX0QXxd3LcMx3mCrHXPEtdlqxJ3Au0expUc5c/uV03zCaje9PY8AOzef
	lhEzX6XmIVS/L1p4F8DkOHYi/l9pROPv0gQBEqSjU2ypV7k8lMOi7s9fBgfn4Vsr8lKxzqSA=
X-Google-Smtp-Source: AGHT+IF1pdYJmL8lY5Um+FQWAdWQl1HNKnEQ6zcaLTAcKPk7CCZJPvcMokltoiFUPNY7CEvqDDTe1w==
X-Received: by 2002:a05:6102:1612:b0:521:d81:6dc2 with SMTP id ada2fe7eead31-53d2490eb0bmr4921349137.33.1757489653959;
        Wed, 10 Sep 2025 00:34:13 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8943b7f2516sm11692667241.7.2025.09.10.00.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 00:34:13 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-890190d9f89so3349541241.2;
        Wed, 10 Sep 2025 00:34:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVBXCId7mZeFfVDUB4Z3CXS6Y4s1h05lmsjrlHT5YVRwLCsYPbLFYURf1AV8OSgusCvU1xxJBuGtgLjn8=@vger.kernel.org, AJvYcCUqbD+rbOEvecRI8URtb6xSkld4D5XrUmS8145t0qN5incxv3Q7W+fA/ujJKnIhlIUVaiwFXqMM@vger.kernel.org
X-Received: by 2002:a67:e7cc:0:b0:51c:77b:2999 with SMTP id
 ada2fe7eead31-53d1aead9a3mr4809500137.2.1757489653635; Wed, 10 Sep 2025
 00:34:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909145243.17119-1-lance.yang@linux.dev> <yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov>
 <b7db49106e6e7985ea949594f2e43cd53050d839.camel@physik.fu-berlin.de>
In-Reply-To: <b7db49106e6e7985ea949594f2e43cd53050d839.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 10 Sep 2025 09:34:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVMw3nUMtXhfhB5mgmsEZNuagna=6ywOuRsRRMFXHYwbA@mail.gmail.com>
X-Gm-Features: AS18NWB-ENOaKkolta8T4p93QhD1mf7fceGRiGIwhtOyM-0RvPLUO80okR5zeVM
Message-ID: <CAMuHMdVMw3nUMtXhfhB5mgmsEZNuagna=6ywOuRsRRMFXHYwbA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] hung_task: fix warnings caused by unaligned lock pointers
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Lance Yang <lance.yang@linux.dev>, 
	akpm@linux-foundation.org, amaindex@outlook.com, anna.schumaker@oracle.com, 
	boqun.feng@gmail.com, fthain@linux-m68k.org, ioworker0@gmail.com, 
	joel.granados@kernel.org, jstultz@google.com, leonylgao@tencent.com, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	longman@redhat.com, mhiramat@kernel.org, mingo@redhat.com, 
	mingzhe.yang@ly.com, oak@helsinkinet.fi, peterz@infradead.org, 
	rostedt@goodmis.org, senozhatsky@chromium.org, tfiga@chromium.org, 
	will@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Sept 2025 at 18:55, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Tue, 2025-09-09 at 12:46 -0400, Kent Overstreet wrote:
> > On Tue, Sep 09, 2025 at 10:52:43PM +0800, Lance Yang wrote:
> > > From: Lance Yang <lance.yang@linux.dev>
> > >
> > > The blocker tracking mechanism assumes that lock pointers are at least
> > > 4-byte aligned to use their lower bits for type encoding.
> > >
> > > However, as reported by Eero Tamminen, some architectures like m68k
> > > only guarantee 2-byte alignment of 32-bit values. This breaks the
> > > assumption and causes two related WARN_ON_ONCE checks to trigger.
> >
> > Isn't m68k the only architecture that's weird like this?
>
> Yes, and it does this on Linux only. I have been trying to change it upstream
> though as the official SysV ELF ABI for m68k requires a 4-byte natural alignment [1].

M68k does this on various OSes and ABIs that predate or are not
explicitly compatible with the SysV ELF ABI.

Other architectures like CRIS (1-byte alignment!) are no longer supported
by Linux.

FWIW, doubles (and doublewords) are not naturally aligned in the
SysV ELF ABI for i386, while doubles (no mention of doublewords)
are naturally aligned in the SysV ELF ABI for m68k.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

