Return-Path: <stable+bounces-249329-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SK6XNWY1C2qgEgUAu9opvQ
	(envelope-from <stable+bounces-249329-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 17:51:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 439235704EE
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 17:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61770305F099
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8152C40587A;
	Mon, 18 May 2026 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfCosSOI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F250288530;
	Mon, 18 May 2026 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118858; cv=none; b=UiT6Lcvrg4VShkFEbXPf+q0Dl7149f95TGkWBBLqkJ1x9Dw2D0LPIonQtvHYKQV2GvLK6DwFZ2USGe3aSrGLKK1BUdbvZt6grIrezC8v59vgIMFZfSl8zwlycmiwlwY5DrPcZ3+d9985Qt6hc/sG7G2iMvqHg4o2wdB65nJC/c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118858; c=relaxed/simple;
	bh=TCIx526+A3AbMfZ+N+q4IsjoBWU4M5CvRsNZ0djzGpI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M+aOUljHXcU4QiWjJxQhRdoxDvXmodR5TGxaaEZ2yk1eyv+gtHMWsfd+omB68YpC9FzomkVy2/YhL6/izyVxipOvYskekFbCvSg17rV0HCLv0ZpAcflNl8K8btr2a4520EBIgc4YWQ2leh2IGZdPmkmmVa2AB/Ml2QScOSMqD3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfCosSOI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F01DC2BCB7;
	Mon, 18 May 2026 15:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779118857;
	bh=TCIx526+A3AbMfZ+N+q4IsjoBWU4M5CvRsNZ0djzGpI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nfCosSOI00g829TCsgb1ycYjZPoPEjNP7bP3FIZVEPTEiliGWUup22kXrJO2NPXz4
	 krNqVqyOqjjHjWPoC8jlpqd/SHtStcxRA+BWXuuNI2zZXTiNmB3WBoOxK6m8LT75m3
	 5AQAwGz2Kdx5D7f8HtwnvE1SpBQJBeRlCws7iyO58KqCXt1Goe0AhcjAzeq9v7JiOf
	 KoHIGaV7PrIZ/5SXunJrWo/DQDk064UF5Z568eptLD6gfOY5XCZLtioLP5t1YzR2+I
	 6t99BeuqADc3CIGVao9GJ2b1FZ3kBwrCjS2JLhO+WIjf1+WIH8viz0To0lV1FFQpCB
	 /znQDxEfBNhOg==
Date: Mon, 18 May 2026 16:40:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 hcazarim@yahoo.com, joshua.crofts1@gmail.com, gregkh@linuxfoundation.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: tsl2591: return actual error from probe
 IRQ failure
Message-ID: <20260518163647.3b4966fb@jic23-huawei>
In-Reply-To: <20260518094311.2000-1-sozdayvek@gmail.com>
References: <20260517181042.668-1-sozdayvek@gmail.com>
	<20260518094311.2000-1-sozdayvek@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249329-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[baylibre.com,analog.com,kernel.org,yahoo.com,gmail.com,linuxfoundation.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 439235704EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 18 May 2026 14:43:11 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

> When devm_request_threaded_irq() fails, probe logs the error and
> then returns -EINVAL, dropping the real error code and breaking the
> deferred-probe flow for -EPROBE_DEFER.
> 
> Return ret directly; the IRQ subsystem already prints on failure.
> 
> Fixes: 2335f0d7c790 ("iio: light: Added AMS tsl2591 driver implementation")

Hmm. To me borderline on whether it's a fix.  In theory a board may exist
where the defer is a possibility.  In practice probably not given I don't
think we've ever had a report of this.

Meh, it's harmless enough and maybe helps someone.

> Cc: stable@vger.kernel.org
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
New series versions should never be in reply to older series.

It tends to hide them in people's inboxes and brings little nor no benefit.
> ---
> v2:
> - Drop dev_err_probe(); just return ret (Andy)
> - Add Cc: stable@ as suggested by Joshua
Mostly for IIO I add those to patches that I think need it but don't object
if people feel strongly enough and add them themselves.

Applied to the iio-fixes branch of iio.git.

> 
> v1: https://lore.kernel.org/all/20260517181042.668-1-sozdayvek@gmail.com/
> 
>  drivers/iio/light/tsl2591.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
> index c5557867e..c5ccd833d 100644
> --- a/drivers/iio/light/tsl2591.c
> +++ b/drivers/iio/light/tsl2591.c
> @@ -1137,10 +1137,8 @@ static int tsl2591_probe(struct i2c_client *client)
>  						NULL, tsl2591_event_handler,
>  						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>  						"tsl2591_irq", indio_dev);
> -		if (ret) {
> -			dev_err_probe(&client->dev, ret, "IRQ request error\n");
> -			return -EINVAL;
> -		}
> +		if (ret)
> +			return ret;
>  		indio_dev->info = &tsl2591_info;
>  	} else {
>  		indio_dev->info = &tsl2591_info_no_irq;


