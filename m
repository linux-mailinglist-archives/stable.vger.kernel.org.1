Return-Path: <stable+bounces-77085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BA3985444
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 09:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E1001F22581
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 07:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDF115747D;
	Wed, 25 Sep 2024 07:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p202t+ig"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ACC156F36
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 07:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727249786; cv=none; b=K+pcBtjCybX3S/7cR3ejClmuS8PPGptXtRpzo1h91Ebe8cLedxw36lfhf3iN1xqflmDfHI1Fpr2pqnCdwEyoUdPeg7hy7FnSvo6y1+hvsPPfi9Y2JQqjtm9PlFo+t/6DBlLxW+jH/DCabMUNq2f5X3/nqd3aNseVv9oBgjBZs6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727249786; c=relaxed/simple;
	bh=76YZEW6EtMBCZakQkJCNvbiRu8dlMF37D1Q+43uqe1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dylUlqPIut6UfS2bgKEYM0vkMr9AQ2GODPZRxWgrgXYoU6wy1Q1c+ZyvPGm1Xz45BXen2vI7/QgfDVVKten1dnKcBIihJBWUTgIckX7bgprz7Ei6uavA4NG4k8z7Y9Xk5JI0RZl77L0MTsMrsPwRpIQsVa8sbdjK9cLuA0gaEeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p202t+ig; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cc8782869so61053175e9.2
        for <stable@vger.kernel.org>; Wed, 25 Sep 2024 00:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727249783; x=1727854583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9lGMEBKLmjkFGLc4RAIsnVl2S5q5Z9TpSNkls4n+Ws=;
        b=p202t+igmRJ9mK9abq69iukKOUVns4icu9YwvmskOq+P0hDAvVnRH9cLCQHk1iL2cB
         DK96OCTj/7QMmIL+mNVdUCtJmB/Hd9d738OKllZl+uGKs3tTcQM0dREoX/cx5b4B+sPb
         x3/t7nlFIEtgZcIYbbWkNUKrQMF7V+hUT9psKxVc6oxnp8IJ5AQ7vXa6qyQhNiEuugMy
         dTlknZRx/nc+H/A6I1H7ZPmj6nh8a7CdYieFzvH52NpxiXD1fI9Un8aw5bxBTQnRgllC
         P7VT3lBnr6znz8YRemqAOkOSDf20nfCaESeZPmERcrw1IVH3JYlcKPKI0nv5YIQBlqTH
         e0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727249783; x=1727854583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9lGMEBKLmjkFGLc4RAIsnVl2S5q5Z9TpSNkls4n+Ws=;
        b=NT6OTlR+JdOQ/jAxu3PW+NR1EzVsX0gIb/8yLk0GetYhKuu9haWNu3X/1Whc23KCPs
         7b3NhpsCzSL0eGMG1gLezUm/NfFzIAOHy06ea+hPSzlmk1IyS4KPz9kyuENIt03GOQrc
         0Mg7yu3YBaGNW1pHf8r8n1SUwOI6uYswV0wLvoQXt1j49K0DPxsQe0hlEh4D0RsA1mp5
         WtSWul1JuyvFe9Jo2ZqBeAy7ez/6vkTfJQ8aD10pwbONWdKhNIcAqOiS0Eg6UTXJx8Ed
         Ntc4sEA5WhhSSO0dhM34J9iJckSmb+vVFpeQ46K0TVtRWP+8qplMeRieMe9o55LouYl1
         FzMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP+yYsn+PQpjmIbd6iHM1wDLmriHmPENg2J9B63IPNzX37zCvVVlANWtgYDL+xC1YKspESfco=@vger.kernel.org
X-Gm-Message-State: AOJu0YwktCqtDRmidKxty5nkQIMUGYAu1Vvp+12A73yCAjfLwFwu+vgW
	WHAXlScAquCNuUbXHCPgk/S5phEXX96UPocEWmEGqFfpmROWJWH9Qqs6/H5SAVFXSttEBplmKzG
	pl66fC61IBklsDxM0ut+Sc5erXNpzytz8Bz/o
X-Google-Smtp-Source: AGHT+IHyBbdDcep9gi4oTP7ZRY8fm3ZApdXR9IqYfSNFTflsLrQ+XaG6asyE21skiag9+r0Zf8wb345V8KH+mwpGAzo=
X-Received: by 2002:a05:600c:4706:b0:42c:bb41:a077 with SMTP id
 5b1f17b1804b1-42e961363b1mr11521475e9.23.1727249783070; Wed, 25 Sep 2024
 00:36:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924184401.76043-1-cmllamas@google.com> <20240924184401.76043-5-cmllamas@google.com>
In-Reply-To: <20240924184401.76043-5-cmllamas@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 25 Sep 2024 09:36:10 +0200
Message-ID: <CAH5fLgiDjNtt2G4S4NrHLGvGudSVT1udCKjkpTC+71v_3TuLZg@mail.gmail.com>
Subject: Re: [PATCH 4/4] binder: fix BINDER_WORK_FROZEN_BINDER debug logs
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Yu-Ting Tseng <yutingtseng@google.com>, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 8:44=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> The BINDER_WORK_FROZEN_BINDER type is not handled in the binder_logs
> entries and it shows up as "unknown work" when logged:
>
>   proc 649
>   context binder-test
>     thread 649: l 00 need_return 0 tr 0
>     ref 13: desc 1 node 8 s 1 w 0 d 0000000053c4c0c3
>     unknown work: type 10
>
> This patch add the freeze work type and is now logged as such:
>
>   proc 637
>   context binder-test
>     thread 637: l 00 need_return 0 tr 0
>     ref 8: desc 1 node 3 s 1 w 0 d 00000000dc39e9c6
>     has frozen binder
>
> Fixes: d579b04a52a1 ("binder: frozen notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  drivers/android/binder.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index d955135ee37a..2be9f3559ed7 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -6408,6 +6408,9 @@ static void print_binder_work_ilocked(struct seq_fi=
le *m,
>         case BINDER_WORK_CLEAR_DEATH_NOTIFICATION:
>                 seq_printf(m, "%shas cleared death notification\n", prefi=
x);
>                 break;
> +       case BINDER_WORK_FROZEN_BINDER:
> +               seq_printf(m, "%shas frozen binder\n", prefix);
> +               break;

What about BINDER_WORK_CLEAR_FREEZE_NOTIFICATION?

Alice

