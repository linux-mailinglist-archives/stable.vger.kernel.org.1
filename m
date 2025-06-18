Return-Path: <stable+bounces-154654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82A9ADEAFC
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 13:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78183A1ADF
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 11:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A581298274;
	Wed, 18 Jun 2025 11:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c2inLkLS"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CAB285056
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750247871; cv=none; b=hRwRqqflE2VQ5B6a8vOG6JTY7+/eCm0IAfR4eM9P7TjpahlF9IpDfXZAPLbFOrxwOdEf2fPQlVaEz6u0nknf7ROt1mSlmYpxLC4CWzu3Ck0MW7nO7hryv5EYpIPiplrtpAcjSRPXMzw9IL5jz/zPQJCmEp1ZIBge7vefNmPomEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750247871; c=relaxed/simple;
	bh=vXnEOwfbKTy01z7cobE4+Hk1SMKWVRbeCD9p5sV/Oz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQCsUJQ0FpZJzp5fIDgW+2bZjoPKQivfh+kftrCrs8b8V41QfOORPDTryAUp726of6wyHPoPXtBw1DfmScOLaDc2zoYIMdjBr4dH1ijmGGf3E+x5QJ8dDPW1ry9RMFtPsqEOh035CYXN21vz+QUTtk1gcUGZkMEcKAZ5UKHSW3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c2inLkLS; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32a9e5b6395so56885441fa.0
        for <stable@vger.kernel.org>; Wed, 18 Jun 2025 04:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750247868; x=1750852668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXnEOwfbKTy01z7cobE4+Hk1SMKWVRbeCD9p5sV/Oz0=;
        b=c2inLkLS7uGMLLdc1vIjANQFCN+KjvLGE0lzx15n5a/kdBh6e6fgOgAs6X82G8szrE
         ERff8kCPgF9bM67uZrv+RLnANOldReYE5+mQfj7YShoMIKwvkpu462a0TiGOIuF6f8e3
         fp06/R+ytLUpdJ5qmOI46Urdi08IHS6zpFSpVwOHO/D1pjmICqT8EdbIEXRc2Jz4zoue
         yDnLfAEMLWp/I6K57JSdJzcIeQO4R1YAPNRyKcumwkhGSEukZzB3Ysa4TY4AzEz+p/3t
         pHIxftSoZb95mqOo8xfgwhl28AYTftoblB7l9+8oorIetLY9mkKuKz2HNGf0mBQLaYM+
         Pz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750247868; x=1750852668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXnEOwfbKTy01z7cobE4+Hk1SMKWVRbeCD9p5sV/Oz0=;
        b=l/yRPmbk33Jz75GiAVNsEGON2OsiHfh+B4LaFAr1hm3yHK3e3hi1m+ys8mbqkkC/US
         CuWbPH7FoWzn0Ti4TBHshSzyt/bWIF7Dh+52sFyBAYDsmmh6GbRKoqsvmLwomAkY2e39
         DS+c5u/L7gcBNZ/X/7rVqsKJ2o4F169THQIkCKaYgapBb+u2KzyCQ2meekdiT+0QguQe
         WOqvLZkB04/MQyX7533KtqK2KdMaD3+ZUDS66sRgtRpReZSkyjKvt2RcGaegquvEls88
         Ts4BPu4Ce4L5v8sPqx5er4n+FqCQp9io1eepSguSDMowHUKC0TKW5Gk2f/ixwLAqZJXs
         pIHg==
X-Forwarded-Encrypted: i=1; AJvYcCW+2yrtf0ag2UK0nn1oN764EJxRfGPhREqHNunyezYA7FUCeI8zUmKtFNTT7UODJtHrvfJpvY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKyI9B8W+x1c5+hw76+MXRv1b2nNuOdb9n2m9fQGEVXzCMnJAk
	7P6cLhWnbI8XPmjFZZB2lWOjPpJTN4PHdEeoP6T/GSdnUS0l4fvZM7ToLhZxbFNEpYBIm8ekYf2
	q7gID0n25pC2eqGk3QRGdMMMghwBcDO+uT50m8bo28Q==
X-Gm-Gg: ASbGncsvOvTwxEuv1oztp7M8D2tKkva8PRir8M225YEdXz/SoDeFI+LYL0MJPuuF+D8
	axomTSTPywIpv0vBIUAsCCE15QftJPcgMp1/T3rbkoWG3TX2b0ZOUKnvoH70L4aas4RVkOZi5I6
	i9ywnxRq1mzU1CjQTvg0KneB8JxFxOGu88f3PF92CN1dA=
X-Google-Smtp-Source: AGHT+IH7vnMyWvDeuT22AfjJ72jh8AlElSg/X6zhBdg5qjqst8eEHaOrlL3lefZJep/KKAH4d2AwxAgcyFjM7bagkmM=
X-Received: by 2002:a05:651c:b20:b0:32a:847c:a1c0 with SMTP id
 38308e7fff4ca-32b4a0c5893mr49570841fa.6.1750247868176; Wed, 18 Jun 2025
 04:57:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612091448.41546-1-brgl@bgdev.pl>
In-Reply-To: <20250612091448.41546-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 18 Jun 2025 13:57:36 +0200
X-Gm-Features: AX0GCFtRDJgqMbmd8SADniLZIBDm0lbd_j7zrP-SEcNHH7wJbISn24C8wb9wJDI
Message-ID: <CACRpkdb9OkfBS49zjo38L_0zouz2SJmfJK3EaH+YZMPqXacODw@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: qcom: msm: mark certain pins as invalid for interrupts
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 11:14=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> On some platforms, the UFS-reset pin has no interrupt logic in TLMM but
> is nevertheless registered as a GPIO in the kernel. This enables the
> user-space to trigger a BUG() in the pinctrl-msm driver by running, for
> example: `gpiomon -c 0 113` on RB2.
>
> The exact culprit is requesting pins whose intr_detection_width setting
> is not 1 or 2 for interrupts. This hits a BUG() in
> msm_gpio_irq_set_type(). Potentially crashing the kernel due to an
> invalid request from user-space is not optimal, so let's go through the
> pins and mark those that would fail the check as invalid for the irq chip
> as we should not even register them as available irqs.
>
> This function can be extended if we determine that there are more
> corner-cases like this.
>
> Fixes: f365be092572 ("pinctrl: Add Qualcomm TLMM driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Patch applied for fixes!

Yours,
Linus Walleij

