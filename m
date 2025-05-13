Return-Path: <stable+bounces-144123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 897F1AB4D46
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 09:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC4B1748F4
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 07:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467CD1F2C34;
	Tue, 13 May 2025 07:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vcocX/vp"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B861F1906
	for <stable@vger.kernel.org>; Tue, 13 May 2025 07:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747122467; cv=none; b=POk6KfJSIz5IvWfCxdJ0h4AWDQ7Fp8yzTenv6www9mhj5GDorZrixJc3fbHfBqzVQWr1vD4SHQjuTgRhF2I+nEVxTeiizPIzzL7aw19ENiD+kSVfGToW1mmYwu+M91uwJDQUCnzL08qFuSEwHSVMZ9i8mqF/J3YrLRR2UdTab5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747122467; c=relaxed/simple;
	bh=24LJEQNBtPANRsvRmA7VhJPkuYyfg6dz5LevvdvxJ1s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jucEALvHx6sFx/R76wZSqro4qFCI04pE5K1tgqx0pN0/Kni9yNQrN9yEXSGJGaHHP+TbJd9AgIo+3+kLJo7baxy3pC0Qt+nJQEbMsGQ0IQEC98F7NNpbtBA70zjGnItJyJcuwBwNgFdLBMLYWC39Ujo8IUW9mJmLTbztaks8Fvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vcocX/vp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so33670795e9.1
        for <stable@vger.kernel.org>; Tue, 13 May 2025 00:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747122462; x=1747727262; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2RtKA7NZNuHzBQS6CrTPRAttssEFDmPD1Z8kR1U88AY=;
        b=vcocX/vpjp8BiwIOfktZn7zPT3sQRvimXQxVQFKwW7SpKPHmz6dFJPKyXQ3d1O34zI
         CyZKRUcdlUDWQjlmJ6va0KGdloLmKanjgmxedpkTUkCPBRiu9KFh+gA+MXYfgk4FKlUG
         yZK8UjJcpZ9Lr+5mm0VLMbBrxuTVL6AA/QSkkhsLzmITL+ymveLa0cxhna3M5qbooUEr
         LmiDyaqAo1UCOgV2omgs0AUFj0stRLaOl/jl4g+s3wUXg8DPou+Jm7Ax48ew+9G5AZ9A
         eB2jw2ESEqNoiPFPKLMzhf6yW2nXqHocpe6R/0tv1Kia1F7Lo9cUjqB+dBnSlBwjnTh2
         FgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747122462; x=1747727262;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RtKA7NZNuHzBQS6CrTPRAttssEFDmPD1Z8kR1U88AY=;
        b=hfQEw/afzrQNS8dekvsX9inLq88EsdDKQXpB8+AKQavTG0623o5k4S/WaxYCKpLKIl
         5h+GHPuKGy1DlDvpVU0Ox4CKiWr86pW4Dyex4PRJEXRANlFINwVA2ER6yq10FORClEQt
         I7Lc/d5q+/OGKiNkC+tu4qSwWb1leq9QUjM+Mtmf1sBursmXpA1AQ6RUxGdZ2n5g/EJR
         YaUL8CEjGiYtV1TmvS7wm96q7IMJM6RxNMKWdolWtu412h01TPlGpwvd1Dtb50hyvw75
         CQO9sY3lALD3Pvaf89iP3A6UH2xE12dnKSo5U8SfAlnlrdWaKeFRtE6sM8zph/5hwm4Z
         Xndw==
X-Forwarded-Encrypted: i=1; AJvYcCXM803V9pmMb/iWWq6PsKgYxEcIJfQq9svz3ycsPtN2wMXxBOWW2qbOuOESNTZzr6aLnYQ7DdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YySg+4ZiOVSlv6fev7mWqmaYKfpIkDFFlUqIqkx1o6nusA3nPkS
	x4vymimkq9EXzp0u96R5b3qU9piYwqxZoVYF3HqbcwJimQt/F8z/3J3NvuBmov4=
X-Gm-Gg: ASbGncs+g7MCy2PCrI+OGrDuShZX55bp+8S1TRFET5iDMMhc3iEyvcNX993uj+SB7EX
	/ujRpffyLNaDBtW4nDNdJDei9nliBx/8D5xzZArNRjL3DPgVI5jtFyHY323Lw9M8Tc9JfRt6VfH
	CPC82LG9KqzFHJiH8y28/j4V591Jjf98UQ66D5XD4SuMSCNrAj/ZLUPmimdoBTlDJKlZQiPfT9/
	ZgtjLwZUbCA1T/bzrOZ69kOnJQuFlZ8So72VXZkgLJ4hJsNMRNEwO8zMTRt84rrzi0fhbJcHJJ2
	pd5fYLvDm0xRgPoxLeqao81CEcC0R/3jokM0pDEbWnvd5YGnKUc=
X-Google-Smtp-Source: AGHT+IFAnCZ6nPY5UPyadmr7YhyYRo5ZU39JgB3mmEwc8mv+oARHGq0H1ti0jbO/TdUIglDMyD/fWQ==
X-Received: by 2002:a05:600c:5d6:b0:442:e27c:48da with SMTP id 5b1f17b1804b1-442eacabc61mr13471135e9.8.1747122461595;
        Tue, 13 May 2025 00:47:41 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:780d:7cd3:15cf:b5d6])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a1f5a2d30asm15070456f8f.76.2025.05.13.00.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 00:47:41 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Da Xue <da@libre.computer>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,  Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,  Kevin Hilman
 <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  stable@vger.kernel.org,
  linux-amlogic@lists.infradead.org,  linux-clk@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] clk: meson-g12a: add missing fclk_div2 to spicc
In-Reply-To: <20250512142617.2175291-1-da@libre.computer> (Da Xue's message of
	"Mon, 12 May 2025 10:26:16 -0400")
References: <20250512142617.2175291-1-da@libre.computer>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 13 May 2025 09:47:40 +0200
Message-ID: <1jecwtymsj.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon 12 May 2025 at 10:26, Da Xue <da@libre.computer> wrote:

> SPICC is missing fclk_div2 which causes the spicc module to output sclk at
> 2.5x the expected rate. Adding the missing fclk_div2 resolves this.

I had to re-read that a few times to get the what the actual problem is.
If you don't mind, I'll amend the commit message with

'''
SPICC is missing fclk_div2, which means fclk_div5 and fclk_div7 indexes
are wrong on this clock. This causes the spicc module to output sclk at
2.5x the expected rate when clock index 3 is picked.

Adding the missing fclk_div2 resolves this.
'''

Is that OK with you Da ?

>
> Fixes: a18c8e0b7697 ("clk: meson: g12a: add support for the SPICC SCLK Source clocks")
> Cc: <stable@vger.kernel.org> # 6.1
> Signed-off-by: Da Xue <da@libre.computer>
> ---
> Changelog:
>
> v2 -> v3: remove gp0
> v1 -> v2: add Fixes as an older version of the patch was sent as v1
> ---
>  drivers/clk/meson/g12a.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index 4f92b83965d5a..b72eebd0fa474 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -4099,6 +4099,7 @@ static const struct clk_parent_data spicc_sclk_parent_data[] = {
>  	{ .hw = &g12a_clk81.hw },
>  	{ .hw = &g12a_fclk_div4.hw },
>  	{ .hw = &g12a_fclk_div3.hw },
> +	{ .hw = &g12a_fclk_div2.hw },
>  	{ .hw = &g12a_fclk_div5.hw },
>  	{ .hw = &g12a_fclk_div7.hw },
>  };

-- 
Jerome

