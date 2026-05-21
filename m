Return-Path: <stable+bounces-253510-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH2pNBXyDmqmDQYAu9opvQ
	(envelope-from <stable+bounces-253510-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:52:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 839775A446F
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAF9E305875D
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 11:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313913C5845;
	Thu, 21 May 2026 11:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyEqW6MM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB9333AD9D;
	Thu, 21 May 2026 11:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779364037; cv=none; b=NduD840F8eyQrq7UiZmAA3f2LxMB5RDjlxirS6eOQyzmmSqtYmCjNwJfmob39hHs+wKmcuxSd8D7SrcLXHRDrWcsOAsPcgLMIvE7otJK9Fwj93aPuNBFtIEkmXll1DunkvMOLNuscGezQgMKWT7YN6ahdh2Ewx/9mWLIE9orvl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779364037; c=relaxed/simple;
	bh=wjDDuXm6lRHzIfTgKnUcxIbVfI88qnABg9fUBKpi6T4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KYFmI2i9fl2WVmhijE7eqIXviBaTau5oKLCL+IubmAKd3TmGhrPHRry+xOpbU/fr5cuz+7Sk3pS8bSUi0GItJQ8t6X/Qgyq4DiWTm4KkLsXWw+f5MrwtyhQV0xgJepBE0pLJG5haBXmVViCGl4v6M8LLnP/Q/CTLDZR345YUvTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyEqW6MM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509051F000E9;
	Thu, 21 May 2026 11:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779364035;
	bh=KdJOxnT31Y8Esk9ERzVherPF9L0muzqHiiXC+LpqWW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iyEqW6MM3LKwURXJBylBpaDn4toeZ4v80p+KbeRnoVx0OdZXAcCHnHx4wmCOOGTnn
	 ZSIomndell9eSfreFE+SrRyjrxVBSqYYDQ7qegMu8e4JX5LmqE3XnwPeTM1h0LX/5l
	 B6fUi3CEO/EONCH/irn/LKCwgILiMiYlBUm1DXNU2TUdhrFGkqCpo9DES6MMGggUAu
	 E0T+n1vfKsfD8HAi3JQ3DNQeIORIt4y5h8YlMFeMq9fYsFUYCNQGAd+pdNqh7QMHnu
	 BUEKijWlevY6/Re/G3UWcQoue04N6o1yN4b1TRxBMciHSqDo9/I6N+REOVo/GUaxqH
	 wZ6W1vFB+1xow==
Date: Thu, 21 May 2026 12:47:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Li Xinyu <xinyuili@126.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linusw@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] iio: gyro: mpu3050: fix missing
 iio_trigger_unregister and irq cleanup
Message-ID: <20260521124708.177ac09b@jic23-huawei>
In-Reply-To: <20260520152236.2308686-1-xinyuili@126.com>
References: <20260520024153.1647951-1-xinyuili@126.com>
	<20260520152236.2308686-1-xinyuili@126.com>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[126.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253510-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 839775A446F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 23:22:36 +0800
Li Xinyu <xinyuili@126.com> wrote:

> mpu3050_trigger_probe() registers the DRDY trigger with
> iio_trigger_register() but neither mpu3050_common_remove() nor
> the error path in mpu3050_common_probe() calls
> iio_trigger_unregister(). On module unload or probe failure the
> trigger remains in the global trigger list while its memory is
> freed by devm, leaving a dangling entry.
> 
> Also fix a use-after-free risk: when iio_trigger_register() fails,
> mpu3050->irq remained set to a non-zero value, which would cause
> mpu3050_common_remove() to attempt a double-free of the IRQ and
> an unregister of a never-registered trigger. Clear mpu3050->irq
> in the error path to prevent this.
> 
> Revert the v2 devm approach as requested by Jonathan: the driver
> mixes devm and non-devm resource management, so the minimal fix
> is to add the missing unregister calls and keep the existing
> manual resource management style.
> 
> Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> Cc: stable@vger.kernel.org
> Signed-off-by: Li Xinyu <xinyuili@126.com>
> ---
> Changes in v3:
> - Thanks Jonathan for the feedback on v2. Instead of mixing devm
>   with non-devm resource management in probe, revert to plain
>   iio_trigger_register() and add the missing iio_trigger_unregister()
>   calls in the error path and remove callback.
> - Also noticed that mpu3050->irq was set but not cleared when
>   iio_trigger_register() fails in trigger_probe, which would
>   cause a double-free on module unload. Set mpu3050->irq = 0
>   in the error path to prevent this.

This is interesting. I wonder why we paper over the failed trigger
registration.   Generally that's an error case that should
result in the driver not loading.

The mix of devm and non devm in iio_trigger_register() is also
nasty.

Linus W, I think this was your code, any idea if we actually need
to do that and can't just fail?  If we can modify it to fail
I'd rather do that and avoid using ->irq as a flag to indicate
if we successfully registered or not

> 
> Changes in v2:
> - Fixed the name format in Signed-off-by. Thanks Maxime for
>   catching this.
> ---
>  drivers/iio/gyro/mpu3050-core.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index bcfa83a46737..459d02aa3d18 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -1127,7 +1127,7 @@ static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
>  	mpu3050->trig->ops = &mpu3050_trigger_ops;
>  	iio_trigger_set_drvdata(mpu3050->trig, indio_dev);
>  
> -	ret = devm_iio_trigger_register(mpu3050->dev, mpu3050->trig);
> +	ret = iio_trigger_register(mpu3050->trig);
>  	if (ret)
>  		goto err_iio_trigger;
>  
> @@ -1137,6 +1137,7 @@ static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
>  
>  err_iio_trigger:
>  	free_irq(mpu3050->irq, mpu3050->trig);
> +	mpu3050->irq = 0;
>  
>  	return ret;
>  }
> @@ -1260,8 +1261,10 @@ int mpu3050_common_probe(struct device *dev,
>  	pm_runtime_get_sync(dev);
>  	pm_runtime_put_noidle(dev);
>  	pm_runtime_disable(dev);
> -	if (irq)
> +	if (mpu3050->irq) {
> +		iio_trigger_unregister(mpu3050->trig);
>  		free_irq(mpu3050->irq, mpu3050->trig);
> +	}
>  	iio_triggered_buffer_cleanup(indio_dev);
>  err_power_down:
>  	mpu3050_power_down(mpu3050);
> @@ -1278,8 +1281,10 @@ void mpu3050_common_remove(struct device *dev)
>  	pm_runtime_get_sync(dev);
>  	pm_runtime_put_noidle(dev);
>  	pm_runtime_disable(dev);
> -	if (mpu3050->irq)
> +	if (mpu3050->irq) {
> +		iio_trigger_unregister(mpu3050->trig);
>  		free_irq(mpu3050->irq, mpu3050->trig);
> +	}
>  	iio_triggered_buffer_cleanup(indio_dev);
>  	mpu3050_power_down(mpu3050);
>  }


