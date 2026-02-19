Return-Path: <stable+bounces-217464-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFprI4lBl2lXwAIAu9opvQ
	(envelope-from <stable+bounces-217464-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 17:59:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF49160DDC
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 17:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 57EAC3013442
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 16:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05C134D93E;
	Thu, 19 Feb 2026 16:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSs/0xO+"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D06334CFB9
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 16:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771520391; cv=none; b=DATikmG/6brl3GQTy4IJs5+gUXyDIx84jccXhAkhlhlTmoVBGcsB0g3kVCO8Ulgj5fltE/iQe/1cNza0QLCMEbZLnAKVyxoQKfR9FOunNNcknyDcbgu8E6Ha7utdN6L0EM3IMmXx0eVIc9/q+4/BKYBkbyd5ziV0MhTnROvjugU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771520391; c=relaxed/simple;
	bh=RtI4mwfwD+P3PGHnYKcB617QTsULwQHjdTQD30kM5yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZ9sZtNIPIZPLYBu2qQTzxpkFq8zP9/2+3+K3LqroROScK9n/QizyPpQ8rcgZD9k4mvFro2aRgd4y7IyU0STchuSmhrYMRK5Ru15knn4GJ0WLAiDituIT6ZQ843OOAxrbOzT8x2a8+Ax0ESGiTYRIK8BNjBmpjsuVTXCYs8OHMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSs/0xO+; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2ba895adfeaso1180958eec.0
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 08:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771520388; x=1772125188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2gvE0EmLNuGUVVdF/D3DSAFzHLiwuA/iBJjerEqpTAE=;
        b=CSs/0xO+xNcfj07lRrvq8rBQemimXV5BIrmNEUj99nlHY7+LPM89d70fkX54tbPkq0
         Z3NMTjHTXEBtfNvXXp66tZVCg9akCgH6n00Sa6fPYALxUfKPBxsTuBh5IFV8WEjXt9N2
         S82o5DBuFdAlAXMUg96YnOYrMTjNovNOEcT3EZI9oywseWqhGz9zwtYe7V6MnY88vb8i
         bRUowXZr7vXMobh5YfR43S4ndJgjwOeA3Dmg3oNvLyuZsuTW8i0YEHBleV4evMmyR85g
         qBLmHg5UCXxG/wpTx2xMq1eh43nWYOFCRWst2sY4q1KWKfODwHaXTTA9/fKUA64D3QAk
         wgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771520388; x=1772125188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gvE0EmLNuGUVVdF/D3DSAFzHLiwuA/iBJjerEqpTAE=;
        b=o2yaG4E3lh1UlCWZTBq4L1/jgJFngj79rZTnG4zD0R/2wotAdWF9dgLc6qNaZOTz8D
         samxfM6GdNoIjH/LfC0gcsEwHZT2XFEADD6ayF008uKv6gb1svF44fBSevcKBfXEmDFh
         dbQvnHhqPj9sJmXZ8MY0eSDtcTy4SkBk/xy93yty72LfGFUDAdtNcP+nN6B5HEO/XIVP
         8xNeg1iD+lux7br3dw2esCmPRMugnMcVhLhJEmh65L4ncqyCMRVm3KcvdZAsw/e0wU4K
         Kw1w3e21v8NwHwujBp7KJq2txqvIskclD3SFpQa0w19/+l9Dp4lqFfivfOR67bRn0ZWn
         ecwg==
X-Forwarded-Encrypted: i=1; AJvYcCXKnNWHHiCjXpaNnTWTbNZcvFyOnbgikwO/h521TnqfahPdraBWndushFuSKzMfxkL6agf7+K0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7uQvICso+8wn2Ed2iQ1mWf7qdwJ8a9w69EFh5hu1Q7wQCGLR3
	mwhzHEdfKsulC5zj8GiiBKSVV/LbZ8BTc/7vOX1vGlXhlamzuX+Tzdu2
X-Gm-Gg: AZuq6aLlhBjsja+rG9KG5X17puiHlB/OrEfv8TcnMXmYSQtsdtwFqoTBLo+62jSA1O8
	+n2kG9R6vx4oiOvA964JqeEDw2zeCp+zJwWzX62KR+5XjCEmvsJT20beiXQaaPsALLN+IDVErMw
	o9Dz5D5WyeaugeOcL/PUMYZ8Va0Jsj/eSk8tCDm9Bgvo4be/5jLYt9rsyUUt7jDbHnwtxZVnmQy
	rRUCtWR9W2MQPZGqA4kbub6Y+th5u0lKaDoEo1Co+UtTbIeUjFR5/hosUBTUB7Hr6pSAHvea45+
	muGo8IzYZ/yz9e5K1TlsnImbgfSDaq8cne1ed8Rj6GVPRS5n5qryACN1Lg9rkBYIScm+vxqysFS
	te/eyQT8uZtmhvhue+zUgsekY1t/ChNsDK92WLksZE2DuZLEMG6LsJSIvMWyBVL6r6K/XFHc8yv
	yIXelLnlPVXT0nvwNbyAIWLJNf8QaNnNak2KaK6h7gG2irsRBpRk/YVGGtzGsTYnqg
X-Received: by 2002:a05:693c:3108:b0:2ba:6854:8d4d with SMTP id 5a478bee46e88-2bd501701e4mr2840676eec.20.1771520388134;
        Thu, 19 Feb 2026 08:59:48 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:9c24:8181:603e:7ad7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb658fc4sm24932889eec.22.2026.02.19.08.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 08:59:47 -0800 (PST)
Date: Thu, 19 Feb 2026 08:59:45 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] gpiolib: normalize the return value of gc->get() on
 behalf of buggy drivers
Message-ID: <aZdA_1gHt_8no6m0@google.com>
References: <20260219-gpiolib-set-normalize-v2-1-f84630e45796@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219-gpiolib-set-normalize-v2-1-f84630e45796@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217464-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2AF49160DDC
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 10:51:33AM +0100, Bartosz Golaszewski wrote:
> Commit 86ef402d805d ("gpiolib: sanitize the return value of
> gpio_chip::get()") started checking the return value of the .get()
> callback in struct gpio_chip. Now - almost a year later - it turns out
> that there are quite a few drivers in tree that can break with this
> change. Partially revert it: normalize the return value in GPIO core but
> also emit a warning.
> 
> Cc: stable@vger.kernel.org
> Fixes: 86ef402d805d ("gpiolib: sanitize the return value of gpio_chip::get()")
> Reported-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Closes: https://lore.kernel.org/all/aZSkqGTqMp_57qC7@google.com/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
> Changes in v2:
> - it's gpio_chip::get() that needs normalizing, not gpio_chip::set()
> - Link to v1: https://patch.msgid.link/20260219-gpiolib-set-normalize-v1-1-f0d53a009db4@oss.qualcomm.com
> ---
>  drivers/gpio/gpiolib.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index c52200eaaaff82b12f22dd1ee8459bdd8ec10d81..c9cd751e7de2307fc5994eb682c53f2b3ce39233 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -3268,8 +3268,12 @@ static int gpiochip_get(struct gpio_chip *gc, unsigned int offset)
>  
>  	/* Make sure this is called after checking for gc->get(). */
>  	ret = gc->get(gc, offset);
> -	if (ret > 1)
> -		ret = -EBADE;
> +	if (ret > 1) {
> +		gpiochip_warn(gc,
> +			"invalid return value from gc->get(): %d, consider fixing the driver\n",
> +			ret);
> +		ret = !!ret;
> +	}
>  
>  	return ret;
>  }

Thank you Bartosz. I guess this could turn out to be pretty noisy but
maybe that will make users report it faster ;)

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

-- 
Dmitry

