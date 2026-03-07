Return-Path: <stable+bounces-223421-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tDQbCP0crGkOlAEAu9opvQ
	(envelope-from <stable+bounces-223421-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 13:41:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 976A522BB8E
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 13:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 85FBE300B9F4
	for <lists+stable@lfdr.de>; Sat,  7 Mar 2026 12:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D55B3909BB;
	Sat,  7 Mar 2026 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGDkphF9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F1333B6EB;
	Sat,  7 Mar 2026 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772887287; cv=none; b=nJYI6xIp83lX3YxrVyuWDvnFy1Cd3sNhMKGIAi28vg+iZE0XVgWXr5/WX7u9M5w090JLsIQ5okDYvTCODJOsuxJsmWO2MYuQSJnGxXin1z7XoUCi0giYNlErepChI2PSbsthDa7CxzdrzmdyrpG0mSdUNJmDFaWQNRhrYYlwGfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772887287; c=relaxed/simple;
	bh=cohMBJH2d1BVbpUwzitQc8rDzCnYSvKbs9OXEa4sgqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oA7fMFgmyfzbtWRFF6+T3wmU+OWP4qO3UBSk9A/iUL73Hrp/LwXcvMpCYWHReqDi9AKBEWTdNQ19izBGn5ovyKRTb6be/okZ7tpQbbvCb5gwAOayeVcv85f91ihgb3ytwoFUyGNdaBw80SuQzVcFrybM/5XUWsRJ2chh4h1jYec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGDkphF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA09C19422;
	Sat,  7 Mar 2026 12:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772887286;
	bh=cohMBJH2d1BVbpUwzitQc8rDzCnYSvKbs9OXEa4sgqw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AGDkphF9NBOJWhRSQ2if2XUnZ9H5dw6ibncSjdIWFCmQqIFUcQdAqqk+5gg+66H0R
	 eF0GvvNF9VAD4S1bGO5JtnSDydZzkBbtlqgvbvIfPJq7LgCF0mI/iYZZTIn/SDMzBv
	 n3cqoW+M22vs+xJsuTcYpeuhXf5IHBUK2eupsbVyXonLPkqpgZDTJzaSgHW4E1dZ6R
	 wKUoX0RKn8Fmh/yr1eOZxvOPySV9+H2/574N7+h7/olIrK5bZF4hOPonQhTt1R6LbA
	 aBsnZHXNXRExAvuubWBOT6SjDS6EpCio/pP3ojkDSwVCfexIvGmEVdarS9w8P+wthE
	 05yvlaWcrD+UQ==
Date: Sat, 7 Mar 2026 12:41:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Christofer Jonason <christofer.jonason@guidelinegeo.com>
Cc: lars@metafoo.de, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, michal.simek@amd.com, victor.jonsson@guidelinegeo.com,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in
 postdisable for dual mux
Message-ID: <20260307124118.1d527749@jic23-huawei>
In-Reply-To: <20260304090727.1800289-1-christofer.jonason@guidelinegeo.com>
References: <20260304090727.1800289-1-christofer.jonason@guidelinegeo.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 976A522BB8E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223421-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.924];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed,  4 Mar 2026 10:07:27 +0100
Christofer Jonason <christofer.jonason@guidelinegeo.com> wrote:

> xadc_postdisable() unconditionally sets the sequencer to continuous
> mode. For dual external multiplexer configurations this is incorrect:
> simultaneous sampling mode is required so that ADC-A samples through
> the mux on VAUX[0-7] while ADC-B simultaneously samples through the
> mux on VAUX[8-15]. In continuous mode only ADC-A is active, so
> VAUX[8-15] channels return incorrect data.
> 
> Since postdisable is also called from xadc_probe() to set the initial
> idle state, the wrong sequencer mode is active from the moment the
> driver loads.
> 
> The preenable path already uses xadc_get_seq_mode() which returns
> SIMULTANEOUS for dual mux. Fix postdisable to do the same.
> 
> Fixes: bdc8cda1d010 ("iio:adc: Add Xilinx XADC driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christofer Jonason <christofer.jonason@guidelinegeo.com>

I'll leave this on list for a little longer as I'd really like a confirmation
of this one from the AMD Xilinx folk.

Thanks,

Jonathan

> ---
> Changes in v2:
>   - Align continuation line to opening parenthesis (Andy)
>  drivers/iio/adc/xilinx-xadc-core.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index e257c1b94..3980dfacb 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -817,6 +817,7 @@ static int xadc_postdisable(struct iio_dev *indio_dev)
>  {
>  	struct xadc *xadc = iio_priv(indio_dev);
>  	unsigned long scan_mask;
> +	int seq_mode;
>  	int ret;
>  	int i;
>  
> @@ -824,6 +825,12 @@ static int xadc_postdisable(struct iio_dev *indio_dev)
>  	for (i = 0; i < indio_dev->num_channels; i++)
>  		scan_mask |= BIT(indio_dev->channels[i].scan_index);
>  
> +	/*
> +	 * Use the correct sequencer mode for the idle state: simultaneous
> +	 * mode for dual external mux configurations, continuous otherwise.
> +	 */
> +	seq_mode = xadc_get_seq_mode(xadc, scan_mask);
> +
>  	/* Enable all channels and calibration */
>  	ret = xadc_write_adc_reg(xadc, XADC_REG_SEQ(0), scan_mask & 0xffff);
>  	if (ret)
> @@ -834,11 +841,11 @@ static int xadc_postdisable(struct iio_dev *indio_dev)
>  		return ret;
>  
>  	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK,
> -		XADC_CONF1_SEQ_CONTINUOUS);
> +				  seq_mode);
>  	if (ret)
>  		return ret;
>  
> -	return xadc_power_adc_b(xadc, XADC_CONF1_SEQ_CONTINUOUS);
> +	return xadc_power_adc_b(xadc, seq_mode);
>  }
>  
>  static int xadc_preenable(struct iio_dev *indio_dev)


