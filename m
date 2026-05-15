Return-Path: <stable+bounces-247719-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IcBETYQB2qbrAIAu9opvQ
	(envelope-from <stable+bounces-247719-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:23:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B556454F67A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F5E031AE9E5
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A963D25C6;
	Fri, 15 May 2026 11:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aavd3qgk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BE825B0BD;
	Fri, 15 May 2026 11:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846310; cv=none; b=c6PgF2FgT/59ikOTsh+bITaWj1PdZrwCxTJlgK+z0dWGeWZKXx7lBxvBGEok0+K/PwCGhrEFwazz4ShF473wRSTqhUgrSogj7odOJRAUPjAmKYJJ6oC1kRubd9wDNVITRrXatzlNjz8oGH8WU94iE7fXFpI0FSWODRVye/R7pMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846310; c=relaxed/simple;
	bh=EiDxThBjH/orVAO+UXvFfacjhpPKOmWFFF3myJAIkOY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X69rW3ma0G96/8n+2EMtx+urqaSKVpmi/AZH7u7fxWSEIe1YreH4QhKSfD4NRIckuKPYzlBTKuQWazqNNx6jiJ6BcMzAHeX8sCzuCZdBqUKqKbrStktG5CIqvbxrAhRWKgPcmWNIV2LiuCZuzxlYTJhDuyuxSl+tCVnKPbYPTYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aavd3qgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0B4C2BCB0;
	Fri, 15 May 2026 11:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778846310;
	bh=EiDxThBjH/orVAO+UXvFfacjhpPKOmWFFF3myJAIkOY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aavd3qgkMJuJA1d78zTyZO5gj+yMhUOFCwv5gjGXBeNFrNRnJquuKqAmt9/q9GU6B
	 Fahk1hozxrbOeSUXqm75uHjeB4fG9Vw9MLIRt3yv2wBFyHGzj7ALThUUP/s3bx2QhD
	 P5MXXKPWqnrhoLQRWZ8SH60N6aX9uBLOwjGMeMROQp0ICfby2NcJ1JG54XcsVJy8wu
	 Lxz5YCp4V4IMFc6k11VPEJbKa/TyMDxML1AUkDGBtu48DSsKqz290Kzzb7kpY8N//O
	 ahdKjaX8GoBOwV5eSDkMc3lm6Ny/WGH5nzlTplvGpqaOhbTDyXDvkOoyqeABmdkRoX
	 8mS/VYAF3QDQw==
Date: Fri, 15 May 2026 12:58:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: magnetometer: ak8975: fix potential kernel
 stack memory leak
Message-ID: <20260515125821.520fe56f@jic23-huawei>
In-Reply-To: <20260515-magnetometer-kernel-mem-leak-v2-1-320e1ad4843d@gmail.com>
References: <20260515-magnetometer-kernel-mem-leak-v2-1-320e1ad4843d@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B556454F67A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-247719-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,baylibre.com,analog.com,kernel.org,parrot.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,joshua.crofts1.gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, 15 May 2026 12:28:23 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

> From: Joshua Crofts <joshua.crofts1@gmail.com>
> 
> Currently in the AK8975 driver there are four instances where potential
> uninitialized kernel stack memory leaks can occur. If
> i2c_smbus_read_i2c_block_data_or_emulated() returns a value less than
> the size of the buffer, uninitialized bytes are retained in the buffer
> and later the buffer is passed on to IIO buffers, potentially leaking
> memory to userspace.
> 
> Fix this by adding checks whether the return value of the function is
> equal to the size of the buffer and subsequently if the value is
> lesser than zero to distinguish from a returned error code.
> 
> Fixes: bc11ca4a0b84 ("iio:magnetometer:ak8975: triggered buffer support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260513-ak8975-fix-v1-1-104ea605dd54%40gmail.com
> Cc: stable@vger.kernel.org

I'm doubtful about a stable marking for the patch.

Personally I've never seen an i2c response that was short (yet correct
enough not to trigger an error return).  There are specific devices
that will do this because they are not ready for instance, but not on
a general read.

Whilst I know in theory they can occur, has anyone else ever seen one?

I don't mind hardening against it but not something I'd rush
to backport or even necessarily to take as a fix.

Patch looks fine to me and the thing sashiko is moaning about is already
fixed on my tree.  Note this is going the slow way at least partly because
of all the other work on the driver!

So picked up by stable tag dropped.  Applied to the togreg branch of iio.git

Thanks,

Jonathan

> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
> Changes in v2:
> - Added 2 additional checks
> - Removed nested if statements
> - Link to v1: https://lore.kernel.org/r/20260514-magnetometer-kernel-mem-leak-v1-1-35b48d699faf@gmail.com
> ---
>  drivers/iio/magnetometer/ak8975.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index b648b0afa5733fd7a54bdf2b8f92f00e924c074b..e085c5a6583dfe40c653abf4936594a5acd08f51 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -495,6 +495,10 @@ static int ak8975_who_i_am(struct i2c_client *client,
>  		dev_err(&client->dev, "Error reading WIA\n");
>  		return ret;
>  	}
> +	if (ret != sizeof(wia_val)) {
> +		dev_err(&client->dev, "Error reading WIA\n");
> +		return -EIO;
> +	}
>  
>  	if (wia_val[0] != AK8975_DEVICE_ID)
>  		return -ENODEV;
> @@ -619,6 +623,10 @@ static int ak8975_setup(struct i2c_client *client)
>  		dev_err(&client->dev, "Not able to read asa data\n");
>  		return ret;
>  	}
> +	if (ret != sizeof(data->asa)) {
> +		dev_err(&client->dev, "Error reading asa data\n");
> +		return -EIO;
> +	}
>  
>  	/* After reading fuse ROM data set power-down mode */
>  	ret = ak8975_set_mode(data, POWER_DOWN);
> @@ -758,6 +766,10 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
>  			sizeof(rval), (u8*)&rval);
>  	if (ret < 0)
>  		goto exit;
> +	if (ret != sizeof(rval)) {
> +		ret = -EIO;
> +		goto exit;
> +	}
>  
>  	/* Read out ST2 for release lock on measurement data. */
>  	ret = i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST2]);
> @@ -873,6 +885,8 @@ static void ak8975_fill_buffer(struct iio_dev *indio_dev)
>  							(u8 *)fval);
>  	if (ret < 0)
>  		goto unlock;
> +	if (ret != sizeof(fval))
> +		goto unlock;
>  
>  	mutex_unlock(&data->lock);
>  
> 
> ---
> base-commit: 86138b484d6367a57312f69af4ec958806c2673c
> change-id: 20260514-magnetometer-kernel-mem-leak-d88a85d28a60
> 
> Best regards,


