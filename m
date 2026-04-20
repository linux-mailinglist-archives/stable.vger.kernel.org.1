Return-Path: <stable+bounces-239977-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RdfPBK5t5ml+wQEAu9opvQ
	(envelope-from <stable+bounces-239977-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:17:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB0A432A5C
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 562273018742
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194403ACF1E;
	Mon, 20 Apr 2026 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cC+ZeEvU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC91D3ACEFE;
	Mon, 20 Apr 2026 18:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776709034; cv=none; b=TX+smH/+DNeWllCb+J6IG94oBn6aLgw26kqjEeuxthe/CQIvIgPwhfNly3bfVje1OkVb1N4blNOrb8m2MZbIH4/WEcfUmLsnRerUephwE1l3vJenDey39yvcy+nFfER60k47G660PpCw9NtCzyCfSJCjTDbeFG27zJi/QU+h8s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776709034; c=relaxed/simple;
	bh=I939YAlSQyQ60aQQDOOtNxBWKwdqX4j5CIaOSRzUtfI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZzm8ohuoLWEfPwkUBhHMe6Nps85YKh7FJvN38WkAmocWPfjB9gLInsZi21AXBntnsm4ftE2mnTaJnMR3864q4hbqXn/aolaxVwCNYUGhSf6qo061GVWIMt7mlgmSGiGqUsAOMl24rP7RuYpKRm1fxHClPPXFpQTiZveXw6aUyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cC+ZeEvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402D9C19425;
	Mon, 20 Apr 2026 18:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776709034;
	bh=I939YAlSQyQ60aQQDOOtNxBWKwdqX4j5CIaOSRzUtfI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cC+ZeEvUwk6l8MoXRbdOPdL4kWcUVWbvCObzk9aQSjRzB+Efvm4hU9HkmUH12pVYg
	 f7NGQim3SuLtHAN2n7AW9uy3/R7Jsutxc3iZcN+yTrnXll5y6sklSCyvCXBTKJeZPI
	 I9k3jHDLDwEWKxPRqVB/4Ep6pHgjYGxFXtsS06KTMXJ2Na8ZP7wMvx4zN64zD9zcjF
	 3LP7amUQ8ThrWqOEQOsjMbSC66jh0qBDyP/FQXPTHhZnymIU0JbM2hWOK9X1hsogvp
	 gnIcTCKmshC9nNdRycOqmoymWcB2fkaj6OPxuCLCuQ2hTU3phGkSl1jQn2DYl6U2bp
	 aa0qMjDcGzHyw==
Date: Mon, 20 Apr 2026 19:17:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Robert Garcia <rob_garcia@163.com>
Cc: stable@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Zicheng Qu <quzicheng@huawei.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Daniel Junho <djunho@gmail.com>, Alexandru
 Ardelean <alexandru.ardelean@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.15.y] iio: adc: ad7923: Fix buffer overflow for tx_buf
 and ring_xfer
Message-ID: <20260420191704.3dce3ae8@jic23-huawei>
In-Reply-To: <20260409065147.136824-1-rob_garcia@163.com>
References: <20260409065147.136824-1-rob_garcia@163.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239977-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[163.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,analog.com,huawei.com,metafoo.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 5CB0A432A5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu,  9 Apr 2026 14:51:47 +0800
Robert Garcia <rob_garcia@163.com> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> [ Upstream commit 3a4187ec454e19903fd15f6e1825a4b84e59a4cd ]
> 
> The AD7923 was updated to support devices with 8 channels, but the size
> of tx_buf and ring_xfer was not increased accordingly, leading to a
> potential buffer overflow in ad7923_update_scan_mode().
> 
> Fixes: 851644a60d20 ("iio: adc: ad7923: Add support for the ad7908/ad7918/ad7928")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
> Link: https://patch.msgid.link/20241029134637.2261336-1-quzicheng@huawei.com
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> [ Context change fixed. ]
> Signed-off-by: Robert Garcia <rob_garcia@163.com>

If it's not picked up already, then backporting as here looks fine to me.
Acked-by: Jonathan Cameron <jic23@kernel.org>

> ---
>  drivers/iio/adc/ad7923.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> index b8cc94b7dd80..a8e59fd2dcf3 100644
> --- a/drivers/iio/adc/ad7923.c
> +++ b/drivers/iio/adc/ad7923.c
> @@ -47,7 +47,7 @@
>  
>  struct ad7923_state {
>  	struct spi_device		*spi;
> -	struct spi_transfer		ring_xfer[5];
> +	struct spi_transfer		ring_xfer[9];
>  	struct spi_transfer		scan_single_xfer[2];
>  	struct spi_message		ring_msg;
>  	struct spi_message		scan_single_msg;
> @@ -63,7 +63,7 @@ struct ad7923_state {
>  	 * Length = 8 channels + 4 extra for 8 byte timestamp
>  	 */
>  	__be16				rx_buf[12] ____cacheline_aligned;
> -	__be16				tx_buf[4];
> +	__be16				tx_buf[8];
>  };
>  
>  struct ad7923_chip_info {


