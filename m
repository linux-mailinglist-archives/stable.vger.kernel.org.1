Return-Path: <stable+bounces-249331-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAh9FoU4C2qWEwUAu9opvQ
	(envelope-from <stable+bounces-249331-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:04:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F29205708EB
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E973C304A622
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D109D48B365;
	Mon, 18 May 2026 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FehP4aGK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209CC48C412;
	Mon, 18 May 2026 15:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119252; cv=none; b=cjOKcCiHkBm7hLMdAnuRkqiFtZB7oEfeqFKb7ZrMGMY/UGsXcGBBOukPOJUBwFcf56VAldWmTnq60TiLWogEhIkZAO4dgIZ1kgf+2U6wR3Be0tWvOhQzskXWPUBxKiV8XSv1zjxzNfUOltVklemS/nEwIZbQb80/PvEtK4UnQxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119252; c=relaxed/simple;
	bh=wUP4HCFrB6MX5vlJebcDG589Qp6MWtnLG16Tg1qfRzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/tC0Pow0otK2YlgSRQfGLIKX/ahMcDLQqwfQQOs9Wyf2WUFyVd0P7QCHTxABsqWzbi9SgRbNKzqbyhScolSxlFdGrqhO+Qgv3gWxzuU3g2Uhb3EK2Zyw+xU70UoSpbw06YfpLjAKnpC9d3p+a+tN8LuBPK5FBa9wZuMC0TVTxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FehP4aGK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E4CC2BCB7;
	Mon, 18 May 2026 15:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779119250;
	bh=wUP4HCFrB6MX5vlJebcDG589Qp6MWtnLG16Tg1qfRzQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FehP4aGKJ8TqInoprZxmSRFNj3AUZEhiwnwiZXegGE9oiv5/dKo9xe1nETgPOdczZ
	 G5c/vcKi7EQqmsjfbKxU8JzTs4FOr0mkDBYeTUHd4E1zFObeq2NCh/h5iXMn64SVr9
	 HM74Pu/WNJE71MF4/5MW85XMZ/Tro0bmynNIRUDtmMaVkeGeTicraGmLr01Be+uHi7
	 my9u4h+MxpQjRUn3KuHVPlB8jMkHcHW5FGsH4g0ZGhxNVrSL9mb67qcZjUDhxc/3z8
	 5/yp7HkWCG8e5TkJ4IYspOOU9ZRtzpwrxvEhw6Kw3Cr+WlgbTE8dgbRyhYNrFpTYPX
	 4glOv3fVtv1kw==
Date: Mon, 18 May 2026 16:47:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 hcazarim@yahoo.com, gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: tmp006: use devm_iio_trigger_register
Message-ID: <20260518164721.73fcc8c7@jic23-huawei>
In-Reply-To: <20260517182614.218-1-sozdayvek@gmail.com>
References: <20260517182614.218-1-sozdayvek@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249331-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[baylibre.com,analog.com,kernel.org,yahoo.com,linuxfoundation.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F29205708EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 17 May 2026 23:26:13 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

> tmp006_probe() allocates the DRDY trigger with devm_iio_trigger_alloc()
> but registers it with plain iio_trigger_register(). The driver has no
> .remove() callback, so on module unload the trigger stays in the global
> trigger list while its memory is freed by devm, leaving a dangling
> entry.
> 
> Switch to devm_iio_trigger_register() so the registration is undone in
> the same devm scope as the allocation.
> 
> Fixes: 91f75ccf9f03 ("iio: temperature: tmp006: add triggered buffer support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
Looks 'obviously' correct enough that I'll pick it up with the very little time
it's been on list.  If anyone disagrees do shout!

Applied to the fixes-togreg branch of iio.git

Thanks

Jonathan

> ---
>  drivers/iio/temperature/tmp006.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
> index d8d8c8936..bf62143fa 100644
> --- a/drivers/iio/temperature/tmp006.c
> +++ b/drivers/iio/temperature/tmp006.c
> @@ -350,7 +350,7 @@ static int tmp006_probe(struct i2c_client *client)
>  
>  		data->drdy_trig->ops = &tmp006_trigger_ops;
>  		iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
> -		ret = iio_trigger_register(data->drdy_trig);
> +		ret = devm_iio_trigger_register(&client->dev, data->drdy_trig);
>  		if (ret)
>  			return ret;
>  


