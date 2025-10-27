Return-Path: <stable+bounces-189935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48398C0C375
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 09:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6F49634392D
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 08:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59C42E54A7;
	Mon, 27 Oct 2025 08:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="FoAs+Uzs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="02K3F5x1"
X-Original-To: stable@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9512E0407
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761552157; cv=none; b=jnQ6C52JWtrJuagNWqKZYrwjX6d10tEVGoy5C4cIzo7Itbdz+OsjDlDolwllwkJUN6OAG/kngskS2NqlqkjJGuvUTeKAfCTzU9LtK84wi7Ee1xFFYEcx25g2aAzAd+LK1JChMQia4+fce1RkhsJH1h8fKduJZbL6Vl3LaOCKkHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761552157; c=relaxed/simple;
	bh=bElmMkwiwOo4JMtzF5WY4J9SptXaNzCTyFikG9LRkGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHiKyMEHD8e76cbpbpxQ510FHPz0pWMVb0DI1aYjG2w4WGvdnH4aTe8WOpvYKVlj6QkuH68sRlqqp+VgprEN1keV+lteH+2SSVdGDJkU1ZH2bkGKpJ+MeS/zkrOuTQy0MmBwCsaR27KRkDZNCw8KLb6ipv2vtAQM6T2nwBZXbsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=FoAs+Uzs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=02K3F5x1; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B0F661D00101;
	Mon, 27 Oct 2025 04:02:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 27 Oct 2025 04:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761552153; x=1761638553; bh=LLm7Cikno9
	xF1Sc0S4H/43tcR7lqz1pRtaMukreDWlE=; b=FoAs+Uzsr1FxsFOVX8wgHKvUFL
	dn6nFJh36Oh0ytiwWKDQPfKB3eHLjM/CULA3A5F1CGK7CgwAGql0SKepDnlzmjBR
	dGkDxIvHyAGX8OmiswJcEGpkMU34GOHbB9J/GiJZ+b4o0YjnDt/YlGs9zbTVBXPu
	sa8MFoDBQdC3iLkeng5kHyg/VyWY8Hh7Qm+LKnihuNHDX4CWMlqA2OGIrIpnN0iQ
	eiJ0lYI8aQq9Tu3xt9rufI4kHWLRU1VAyQjYAteDbwgMr0KEX1pSGpfV01YX3CjH
	Uc9tX5Yg6D24X+BPvfFU+AHB70gdI4qF5VNEizzkycgyQHXV2wMC5pe7ossA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761552153; x=1761638553; bh=LLm7Cikno9xF1Sc0S4H/43tcR7lqz1pRtaM
	ukreDWlE=; b=02K3F5x1VfX0UOScrKleZ4hWStgH5VTlh+VsTmbphyNlXIi29QI
	7s8vBdjggrDmHMjt10MukQ6UVWILjJZ7hm1kbJwRNhi1gNdT4C1lbVHWaaHxFisi
	05z0pL9uProkljAUXfidc88o5zrKSPitCVkLUmld9KKy5vUxclxUDNQNJjj4A9XW
	xvmkJTi8NsX0YKJKRcA4EdPrP2iol9tOJkHMyHmRSOnaU50aMO3zB0yt700weFX8
	vmIwYpy9D6C5puZZWU9bTeO+YnMxm0TCBhEDKsX6KRcMh/tsTxUM0GewBvGt3L5n
	eFqZjKL78VO8TwFpZQVR+3rAiAAJp3hSyyA==
X-ME-Sender: <xms:GSf_aGwrJmZbFgJQBGXt18GNwtVsDqlmKnNzemDJm_jW_pb3b6Y-Sg>
    <xme:GSf_aAzDWViC-EJGsEa0OOiva8E8NOhMWbRDrF5d_Z7ELPR7He-KeGccGvFr2JdDY
    Fp9Huqa135DEIR29xrdQOZ52gbfub4HMeQtRkf6fhzGxFhDMg>
X-ME-Received: <xmr:GSf_aPLvgPBj3WFSe_90IuXMu_cGXNiYsuzYajwLTY-aXknvB6DwGIrq2zZqDm5lQMMMFfjTTdw8F_1DJjtC-nkq33Hb6DuXbl3fjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehueehgf
    dtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepudei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghshhgrlheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepfigsgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhkrdgtrg
    hvvggrhihlrghnugesnhhuthgrnhhigidrtghomhdprhgtphhtthhopehmfigrlhhlvges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoh
    eslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgv
    ihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrghrthhoshiirdhgohhlrghsii
    gvfihskhhisehlihhnrghrohdrohhrgh
X-ME-Proxy: <xmx:GSf_aMjh9x4dfUCNkyAzmx-DzAtO4u4Ar_xu5zoMNwpzvLC7713x0g>
    <xmx:GSf_aAMQxEjXAPrpWKqQVPDyCMdZJ29swJoomJ_pn1-t9Kd1O9ja4A>
    <xmx:GSf_aH4B2rpg3pTnNRkh4i9IR5PQpfAH9Bvmq_YOVZp1KZtYAPNq3w>
    <xmx:GSf_aHnc_u6c3T_sZDiHDf0wBfveisxJxegocqnNLasMzY8oQ4LeuQ>
    <xmx:GSf_aM9IHaj-cAKficmvdmPpxbeHSVN3zzVGgEoXHZZynsW9vWjXosuN>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 04:02:32 -0400 (EDT)
Date: Mon, 27 Oct 2025 09:02:30 +0100
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, William Breathitt Gray <wbg@kernel.org>,
	Mark Cave-Ayland <mark.caveayland@nutanix.com>,
	Michael Walle <mwalle@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 6.12.y] gpio: idio-16: Define fixed direction of the GPIO
 lines
Message-ID: <2025102724-womb-width-695a@gregkh>
References: <2025102619-shortage-tabby-5157@gregkh>
 <20251026225104.272662-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026225104.272662-1-sashal@kernel.org>

On Sun, Oct 26, 2025 at 06:51:03PM -0400, Sasha Levin wrote:
> From: William Breathitt Gray <wbg@kernel.org>
> 
> [ Upstream commit 2ba5772e530f73eb847fb96ce6c4017894869552 ]
> 
> The direction of the IDIO-16 GPIO lines is fixed with the first 16 lines
> as output and the remaining 16 lines as input. Set the gpio_config
> fixed_direction_output member to represent the fixed direction of the
> GPIO lines.
> 
> Fixes: db02247827ef ("gpio: idio-16: Migrate to the regmap API")
> Reported-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Closes: https://lore.kernel.org/r/9b0375fd-235f-4ee1-a7fa-daca296ef6bf@nutanix.com
> Suggested-by: Michael Walle <mwalle@kernel.org>
> Cc: stable@vger.kernel.org # ae495810cffe: gpio: regmap: add the .fixed_direction_output configuration parameter
> Cc: stable@vger.kernel.org
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: William Breathitt Gray <wbg@kernel.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Link: https://lore.kernel.org/r/20251020-fix-gpio-idio-16-regmap-v2-3-ebeb50e93c33@kernel.org
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> [ Adjust context ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/gpio/gpio-idio-16.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-idio-16.c b/drivers/gpio/gpio-idio-16.c
> index 2c95125892972..f7e557c2c9cd4 100644
> --- a/drivers/gpio/gpio-idio-16.c
> +++ b/drivers/gpio/gpio-idio-16.c
> @@ -3,6 +3,7 @@
>   * GPIO library for the ACCES IDIO-16 family
>   * Copyright (C) 2022 William Breathitt Gray
>   */
> +#include <linux/bitmap.h>
>  #include <linux/bits.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> @@ -106,6 +107,7 @@ int devm_idio_16_regmap_register(struct device *const dev,
>  	struct idio_16_data *data;
>  	struct regmap_irq_chip *chip;
>  	struct regmap_irq_chip_data *chip_data;
> +	DECLARE_BITMAP(fixed_direction_output, IDIO_16_NGPIO);
>  
>  	if (!config->parent)
>  		return -EINVAL;
> @@ -163,6 +165,9 @@ int devm_idio_16_regmap_register(struct device *const dev,
>  	gpio_config.irq_domain = regmap_irq_get_domain(chip_data);
>  	gpio_config.reg_mask_xlate = idio_16_reg_mask_xlate;
>  
> +	bitmap_from_u64(fixed_direction_output, GENMASK_U64(15, 0));
> +	gpio_config.fixed_direction_output = fixed_direction_output;
> +
>  	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &gpio_config));
>  }
>  EXPORT_SYMBOL_GPL(devm_idio_16_regmap_register);
> -- 
> 2.51.0
> 
> 

Breaks the build :(

