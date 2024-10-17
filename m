Return-Path: <stable+bounces-86609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2F59A22CE
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 14:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51644282A30
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 12:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1031DD55A;
	Thu, 17 Oct 2024 12:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nn4zXdZb"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851571DD54D
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729169839; cv=none; b=jtrjRTkW+E1c4fMGr8v2iZTRrKBPzTfK0a6ImJn7YxLilS67ZN6DaqB3CjfY9xW4+HroBd7alfNCzDUKL9Yu53OuzbNY1DObOpI3ZRCtSbBdPQIKBn+Y4HPklcui/FkLjn9aWrNpLzrqoqDcs9A0ZmUsEGe5RMUetanZ9+TmVYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729169839; c=relaxed/simple;
	bh=RHBDSkGWzhZ3eGhZzXSo2vWVLr0vLO/96rqD063mZHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXg1MTXDXkd1YtYUoNzC4lgFG9zpAnofDmmptbD90njrGMemc12JWFBC+mSolB8ErBV9NNj/GH1tIqvIWEiumcquGUA+OJlX4CX/izcZ1VItANkW8+REyM7zcHjCs6+UljCwltSUB/ZmjqcFPdUVbGMwn6LFLykndHmwGnWwxac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nn4zXdZb; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb4ec17f5cso9912461fa.3
        for <stable@vger.kernel.org>; Thu, 17 Oct 2024 05:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729169835; x=1729774635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lM/6EyqTofKhNcaC/eZHyJO9iygvo6bNNH5rmkBUyRs=;
        b=Nn4zXdZbVX9hIqEr/55P9p8CDL1OadpAvH/R2gV8a2iLlVUAKMzTRsX20BHP1Jp9v4
         30zp3D/Zk8vQ88T4xBBTSbBO4u5Q78ZALq46gjALbTcTArenOPIKprFQA/I5SjsjoHVq
         rQix++94qrUAKSeFdq5X00Q0K6XY0rzdVDyD3nUp0o9xYQW1gAXyuALBSNMhz+6UhJVa
         b5rv2Kr9CdFxnOuNHvNkbzR/qSwT68OFNtWHYrKPHR1HVYVagsd9YQxZ7QCQZseNN80o
         lHND454qXbKMphFcC4xOu3L3aiZAQOXyP20M9aYsfJzZw7RlBarGq6naKlh/P3k1qT19
         rKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729169835; x=1729774635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lM/6EyqTofKhNcaC/eZHyJO9iygvo6bNNH5rmkBUyRs=;
        b=IC6UZ2YoWgWVBItfDEk8EVDx6m/5nu/Ee0N00tH4HbOiPdaGHRd7w/48XI7G+sNC1z
         YOKpi18NvfdXuyIK4Rd3pHZkaiQeNtlcUFyVjSbDfmqyp/0flmzpRjhuFKgIlH2Zq3Gf
         OH6+wCNGDFTUlm3lfWt3Fz/18VYs9UZMhIAamnYLAF4l4xY1dAehpIZDzJ5EDug7So7/
         ffrJgY9yxPdUQfJkW9/UBxC7ljMCKdRhP9jB2gGz2N8EFD33LVc1PUGQoXnoocPAFeOZ
         B2eY2k0QuqeMZda20Tt+xnvdgAqsQYpvRHoNT82IdzfO+80cTfagsUZf78uEsdEilgWZ
         Vipg==
X-Forwarded-Encrypted: i=1; AJvYcCXiq0f//WKWbmhwUKia0B/BQH3EiwIRhpKQtbfDkQgwpVRtgGbeTYVfStwwnLQzWvNDjKjrf2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx49StpS0Ebv0VegxScLu/d1h1MXmbLF7v1cnkaKnE89WoOkttk
	2fYi2yN9uALQex3NJ59mMu7pc5TIjk+HPLKcHyEZN6QCM9Y+eVXzi6nr63WatJG/3lD8CNsvqsj
	7mbuOcDGlntGT3ZdAqY5NDJCcUOyDULe+8hzF7E0CLhTV0e9h
X-Google-Smtp-Source: AGHT+IGtrITGsJ440cQ+NJ22p10H77zFvEUf3tKZTupFjLxmj4ShXkcJ1iATfsio4altMQLxvBi0+8F53/ukQnNuun4=
X-Received: by 2002:a2e:a987:0:b0:2fb:6169:c430 with SMTP id
 38308e7fff4ca-2fb6169c62bmr33603431fa.45.1729169834446; Thu, 17 Oct 2024
 05:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016-arm-kasan-vmalloc-crash-v2-0-0a52fd086eef@linaro.org>
 <20241016-arm-kasan-vmalloc-crash-v2-2-0a52fd086eef@linaro.org>
 <16e45f70-d1d6-4cca-95b0-24d3959e50be@foss.st.com> <CACRpkdaAnutxm-vrrWiqXPoJfsU_RNUOi+a0XP6FNysuYWiX+w@mail.gmail.com>
In-Reply-To: <CACRpkdaAnutxm-vrrWiqXPoJfsU_RNUOi+a0XP6FNysuYWiX+w@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 17 Oct 2024 14:57:03 +0200
Message-ID: <CACRpkdZ2tSC0Xqzv0KHfAGHKU-_s0QQFjhTmqi--58pcBXRh-w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: entry: Do a dummy read from VMAP shadow
To: Clement LE GOFFIC <clement.legoffic@foss.st.com>
Cc: Russell King <linux@armlinux.org.uk>, Kees Cook <kees@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Mark Brown <broonie@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Antonio Borneo <antonio.borneo@foss.st.com>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 2:55=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
> On Thu, Oct 17, 2024 at 12:20=E2=80=AFPM Clement LE GOFFIC
> <clement.legoffic@foss.st.com> wrote:
>
> > > +     add     r2, ip, lsr #KASAN_SHADOW_SCALE_SHIFT
> (...)
> > While ARM TRM says that if Rd is the same of Rn then it can be omitted,
> > such syntax causes error on my build.
> > Looking around for such syntax in the kernel, this line should be :
> > add     r2, r2, ip, lsr #KASAN_SHADOW_SCALE_SHIFT
>
> Yeah clearly my compilers allowed it :/
>
> I changed it to the archaic version, will repost as v3.

I think I meant the canonical version.. anglo-saxon is
sometimes not my strong card.

Yours,
Linus Walleij

