Return-Path: <stable+bounces-249323-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4zPXN7QtC2plEQUAu9opvQ
	(envelope-from <stable+bounces-249323-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 17:18:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B32756FC41
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 17:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA94C3032829
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A6A375ADE;
	Mon, 18 May 2026 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaMNNXa/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A0D376463;
	Mon, 18 May 2026 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117325; cv=none; b=l7LzHILxKsIRQP7DI2NNFWFJJo55ri5sJ05AcyLCydx+RetezgczEmF+aZb5FiJR6oqk3EFQN1N483y3ZXAE8RG8/qjMbF4POXn+qgYQVi/buZiBeRCjDv437a+bKgDmDRrceUJy3cTl7Eji1+hWqQYKhc8oq+E1lFVeyzR2GRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117325; c=relaxed/simple;
	bh=9uDhlpHsb5w3hf5cOMdH2NCMUogL5P36dv20MAXaIc0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nt5TUnPKlzkwJCq7jQaqeAuSYhlQBrJdC41QuXAIbDUjr1N+apX4t66BRjwzBxp5TtrBSzeC0/rN/ZXoQt/kM2bzH2WZNo7wxT3OmOleggLXv7q355GcEMjllAL12MdjHh9KyvNf/FRGVMMD6MozUnurnPrqV9x1M8w/fNbndog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaMNNXa/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE68C2BCB7;
	Mon, 18 May 2026 15:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779117325;
	bh=9uDhlpHsb5w3hf5cOMdH2NCMUogL5P36dv20MAXaIc0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZaMNNXa/eepQWtVs6gg9j/1KeRlMaANc+jcdDBmHY016JKth4MiLg1onQZC/eQFUD
	 aMXgZsPMuKF+8NZzb/Eo2+6RInvVw7Q8LN7GLIy2AZDSMlpKug6/6LAxyLw0c0ZmM5
	 HOvYhEboyCesJURcGxcpoSylTS3Bms+KodiLPJSPueyeJIsvFE1+2hv4mg4R3/S+dn
	 0vBjt/+kINHqVtKUDriM5yDNhulFF+xa8ksbPfn5tjjdsCVX69+a5sAd+cWPLznT8a
	 vzdoNDfvvgZ2AVfhzbX3SCxB8QVU9a9Za6b1+YdOHxdZiP3QRGsRIsmIaVEf5lBEeI
	 zFlcy0YpFNqzA==
Date: Mon, 18 May 2026 16:15:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: mazziesaccount@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: pressure: rohm-bm1390: notify trigger on all
 error paths
Message-ID: <20260518161516.53f21777@jic23-huawei>
In-Reply-To: <20260518094238.1986-1-sozdayvek@gmail.com>
References: <20260517160801.269-1-sozdayvek@gmail.com>
	<20260518094238.1986-1-sozdayvek@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249323-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,baylibre.com,analog.com,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8B32756FC41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 18 May 2026 14:42:38 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

> bm1390_trigger_handler() returns from three error paths without
> calling iio_trigger_notify_done(). The success path at the end
> does, so on a single transient regmap or read failure the trigger
> use_count is never decremented, and the !atomic_read(&trig->use_count)
> guard in iio_trigger_poll_chained() drops every subsequent dispatch.
> The buffered-data flow stays wedged until the trigger is detached.
> 
> Funnel all returns through a single done label that calls
> iio_trigger_notify_done() and reports the outcome via IRQ_RETVAL().
> 
> Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>

These error path 'fixes' are fixes for hardware failure - so if anything
they are hardending  against a possible error condition. I don't mind
that bit it's not a bug to not do this so fixes tag an stable are not
appropriate for any of these.

Note however that hardening against these conditions is not this simple.
It takes careful analysis of exactly how the hardware behaves and what
each error condition 'might' mean.  Whilst they are probably harmless
I'm also very dubious about taking them without comprehensive testing
on the particular device.

> ---
> v2:
> - Use a bool and IRQ_RETVAL() instead of irqreturn_t (Andy)
> 
> v1: https://lore.kernel.org/all/20260517160801.269-1-sozdayvek@gmail.com/
> 
>  drivers/iio/pressure/rohm-bm1390.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
> index 08146ca0f..81368e578 100644
> --- a/drivers/iio/pressure/rohm-bm1390.c
> +++ b/drivers/iio/pressure/rohm-bm1390.c
> @@ -626,12 +626,15 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *idev = pf->indio_dev;
>  	struct bm1390_data *data = iio_priv(idev);
> +	bool handled = true;
>  	int ret, status;
>  
>  	/* DRDY is acked by reading status reg */
>  	ret = regmap_read(data->regmap, BM1390_REG_STATUS, &status);
So question 1.
- What actually is device state if this read fails?  We have no idea.
  It might have failed on the 'to device' path in which case the device
  didn't see the read.  Or it might have failed on the 'from device path'.

Gets more complex...

> -	if (ret || !status)
> -		return IRQ_NONE;

The trigger in use might well be the dataready trigger provided by this driver
(though I note this device has no validate callbacks so we do allow other
triggers - that may or may not be a bug!)  I really dislike read to clear
register designs as they make this stuff more complex.

Anyhow question 2:
- What happens if we don't clear it and do acknowledge the interrupt plus
ack the trigger (which is what iio_trigger_done() is doing?
  Two obvious options - wedged device, it re interrupts immediately.
If we are wedged, then meh device dead. Without adding retry loops
(don't) recovery path is reset the driver by unbinding and rebinding.

Fun follow up is what happens if having acked the data ready trigger
by this read, we get another read before getting to iio_trigger_notify_done()?

Quite possibly we wedge. This drivers trigger may be missing a reenable() callback
(which would typically reread the status register to clear any such interrupt).

Whether it does is again a device implementation specific thing.


> +	if (ret || !status) {
> +		handled = false;
> +		goto done;
> +	}
>  
>  	dev_dbg(data->dev, "DRDY trig status 0x%x\n", status);
>  
> @@ -639,7 +642,8 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
>  		ret = bm1390_pressure_read(data, &data->buf.pressure);
>  		if (ret) {
>  			dev_warn(data->dev, "sample read failed %d\n", ret);
> -			return IRQ_NONE;
> +			handled = false;
> +			goto done;

Hopefully all this stuff is unrelated to the trigger.  For these it is fair to
ack the trigger and the interrupt.  Curiously the driver does it partly for the
next one (IRQ_HANDLED).

>  		}
>  	}
>  
> @@ -648,15 +652,16 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
>  				       &data->buf.temp, sizeof(data->buf.temp));
>  		if (ret) {
>  			dev_warn(data->dev, "temp read failed %d\n", ret);
> -			return IRQ_HANDLED;
> +			goto done;
>  		}
>  	}
>  
>  	iio_push_to_buffers_with_ts(idev, &data->buf, sizeof(data->buf),
>  				    data->timestamp);
> +done:
>  	iio_trigger_notify_done(idev->trig);
>  
> -	return IRQ_HANDLED;
> +	return IRQ_RETVAL(handled);
If we are doing this Andy's suggestion of a helper is neater.

Anyhow, upshot is to get this stuff right requires device specific knowledge.
Ideally the author tests injecting errors at each point to verify if the
data capture survives.  However, it's up to a driver author to decide if they
care.  There are normally dozens of paths in a driver that will result in needing
a reset (unbind/bind for most IIO drivers) - that's expensive, complex, fragile
handling code to maintain, so personally I consider it optional.

Jonathan


>  }
>  
>  /* Get timestamps and wake the thread if we need to read data */


