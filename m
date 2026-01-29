Return-Path: <stable+bounces-212806-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPgtJjmge2nOGAIAu9opvQ
	(envelope-from <stable+bounces-212806-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 19:00:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E51B355D
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 19:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88DA5300BDB4
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 17:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776283563E8;
	Thu, 29 Jan 2026 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDW8b2NY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A7A28DC4;
	Thu, 29 Jan 2026 17:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769709509; cv=none; b=GbjEKUWQUCoet55WE7V3zWmz/J/+KlybfzA5dElvedtG+2xmyCzIxQI3BNs/l1XNA9PHmKYUe/JkzPTpkMmpeLr6d3hwG78EotVko0qrEyN8Krw5O6q+Mu7fEQwWsOTiLvH1yNFt85KWysQp7CT1AwdxH7tOeyg3yfzhi4svZi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769709509; c=relaxed/simple;
	bh=UrNu7SeI/Qmjm7EweomXCRemGTSq9p35SefLVVVkeA8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nVeW9e/ajDhP5vG3lCm/GfhgJlH9wgia0tN8Rp2TtKG+6mLGF+z9vEBiOjdNIyVWhhrgxvwRiZDOKoe7x4ZHiA0pzqe6HEWPqhpmI03fSwAMU0u4Bv3V2FGasxiWSwlcsO1dpalsA06Ril4qkCsWjdmhlLdV9lZuAqIyIHsln5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDW8b2NY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD06C4CEF7;
	Thu, 29 Jan 2026 17:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769709508;
	bh=UrNu7SeI/Qmjm7EweomXCRemGTSq9p35SefLVVVkeA8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gDW8b2NYBiYP7ikUy4Bh+aegPVYBZCtllJjgKNGYDneXuOojvhdPzcJcFXqFKHCPW
	 6V2EJ2M2YvUHyM+skk2eGZ+VGTjkS+AHBxO4qc+IuxcnXVs96OnzzeSBaB2hE+Ob5/
	 nzhCt1C8lmOlHWnHPDdHMcQof64yGPTjnb5V7mR+iz6OdvRGC4kWCIF0+XvH+F4EZl
	 iDRBRt2lvIoAswjX0XTI+syyNb5VPJ2HfwPhU8BixwPc0SOwwL58koveRcxXl1uxXJ
	 +ahmouYCA8DgAW4TrTYDsw2glb3NLSBBEnC0phdNbCR5pKkHZhTw3EGllS9CKNUDWJ
	 SvuMDAIir266g==
Date: Thu, 29 Jan 2026 17:58:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, stable@vger.kernel.org,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, David Jander <david@protonic.nl>
Subject: Re: [PATCH v3 1/8] iio: dac: ds4424: fix -128 rejection and
 refactor raw access
Message-ID: <20260129175819.789a99ac@jic23-huawei>
In-Reply-To: <20260128153824.3679187-2-o.rempel@pengutronix.de>
References: <20260128153824.3679187-1-o.rempel@pengutronix.de>
	<20260128153824.3679187-2-o.rempel@pengutronix.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212806-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: 38E51B355D
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 16:38:17 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> The DS442x DAC uses sign-magnitude encoding, so -128 cannot be represented.
> Previously, passing -128 resulted in a truncated value that programmed 0mA.
> 
> Fix this by validating the input against the 7-bit magnitude limit.
> Additionally, refactor the raw access logic to use symmetrical bitwise
> operations, replacing the union structure.
> 
> Fixes: d632a2bd8ffc ("iio: dac: ds4422/ds4424 dac driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Hi Olkesij

This is good stuff but, this fails the test of being the minimal fix
suited for a trivial backport.

The right solution here is split it.  Just apply the correct
limit in the fix patch, then the refactors in a patch on top of
that which most likely won't be backported for stable.

Thanks,

Jonathan


> ---
> changes v3:
> - Remove "Rebase on top of regmap" note as this is now patch 1/8.
> - Add #include <linux/bits.h>
> - Clarify 0mA sink/source behavior in comments
> - Remove redundant blank line in write_raw
> changes v2:
> - Replace S8_MIN/MAX checks with abs() > DS4424_DAC_MASK to enforce the
>   correct [-127, 127] physical range.
> - Refactor read_raw/write_raw to use symmetrical bitwise operations,
>   removing the custom bitfield union.
> - Rebase on top of regmap port
> ---
>  drivers/iio/dac/ds4424.c | 55 +++++++++++++++-------------------------
>  1 file changed, 21 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
> index a8198ba4f98a..596ff5999271 100644
> --- a/drivers/iio/dac/ds4424.c
> +++ b/drivers/iio/dac/ds4424.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2017 Maxim Integrated
>   */
>  
> +#include <linux/bits.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/i2c.h>
> @@ -19,9 +20,10 @@
>  #define DS4422_MAX_DAC_CHANNELS		2
>  #define DS4424_MAX_DAC_CHANNELS		4
>  
> +#define DS4424_DAC_MASK			GENMASK(6, 0)
> +#define DS4424_DAC_SOURCE		BIT(7)
> +
>  #define DS4424_DAC_ADDR(chan)   ((chan) + 0xf8)
> -#define DS4424_SOURCE_I		1
> -#define DS4424_SINK_I		0
>  
>  #define DS4424_CHANNEL(chan) { \
>  	.type = IIO_CURRENT, \
> @@ -31,22 +33,6 @@
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
>  }
>  
> -/*
> - * DS4424 DAC control register 8 bits
> - * [7]		0: to sink; 1: to source
> - * [6:0]	steps to sink/source
> - * bit[7] looks like a sign bit, but the value of the register is
> - * not a two's complement code considering the bit[6:0] is a absolute
> - * distance from the zero point.
> - */
> -union ds4424_raw_data {
> -	struct {
> -		u8 dx:7;
> -		u8 source_bit:1;
> -	};
> -	u8 bits;
> -};
> -
>  enum ds4424_device_ids {
>  	ID_DS4422,
>  	ID_DS4424,
> @@ -108,21 +94,21 @@ static int ds4424_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan,
>  			   int *val, int *val2, long mask)
>  {
> -	union ds4424_raw_data raw;
> -	int ret;
> +	int ret, regval;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		ret = ds4424_get_value(indio_dev, val, chan->channel);
> +		ret = ds4424_get_value(indio_dev, &regval, chan->channel);
>  		if (ret < 0) {
>  			pr_err("%s : ds4424_get_value returned %d\n",
>  							__func__, ret);
>  			return ret;
>  		}
> -		raw.bits = *val;
> -		*val = raw.dx;
> -		if (raw.source_bit == DS4424_SINK_I)
> +
> +		*val = regval & DS4424_DAC_MASK;
> +		if (!(regval & DS4424_DAC_SOURCE))
>  			*val = -*val;
> +
>  		return IIO_VAL_INT;
>  
>  	default:
> @@ -134,25 +120,26 @@ static int ds4424_write_raw(struct iio_dev *indio_dev,
>  			     struct iio_chan_spec const *chan,
>  			     int val, int val2, long mask)
>  {
> -	union ds4424_raw_data raw;
> +	unsigned int abs_val;
>  
>  	if (val2 != 0)
>  		return -EINVAL;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		if (val < S8_MIN || val > S8_MAX)
> +		abs_val = abs(val);
> +		if (abs_val > DS4424_DAC_MASK)
>  			return -EINVAL;

Just this bit belongs in fix patch.


>  
> -		if (val > 0) {
> -			raw.source_bit = DS4424_SOURCE_I;
> -			raw.dx = val;
> -		} else {
> -			raw.source_bit = DS4424_SINK_I;
> -			raw.dx = -val;
> -		}
> +		/*
> +		 * Currents exiting the IC (Source) are positive. 0 is a valid
> +		 * value for no current flow; the direction bit (Source vs Sink)
> +		 * is treated as don't-care by the hardware at 0.
> +		 */
> +		if (val > 0)
> +			abs_val |= DS4424_DAC_SOURCE;
>  
> -		return ds4424_set_value(indio_dev, raw.bits, chan);
> +		return ds4424_set_value(indio_dev, abs_val, chan);
>  
>  	default:
>  		return -EINVAL;


