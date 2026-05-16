Return-Path: <stable+bounces-249000-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOXdLX1sCGqToAMAu9opvQ
	(envelope-from <stable+bounces-249000-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 15:09:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D83A55BE3C
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 15:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 985493011F1E
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 13:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4912D2773EC;
	Sat, 16 May 2026 13:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NN+mchfk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D311E4BE;
	Sat, 16 May 2026 13:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778936951; cv=none; b=DloUb+MZJqNhm3JTgpEux8zZJd3Cl7VQld4qRUNZZm2bXq/jHuiEVpdel6VCKMYtrNV4XuGEpH39DNXRsTOG1xDE2A9KjnbHovy4qaGgbHRGP2TNdoyFB3OnLTUkrkBaCkwHA7/osoz9P8WNH/gvB6hBwf5T7j0H817DWSD9xdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778936951; c=relaxed/simple;
	bh=uAX/ioKdn5LkIKdFXTI4Zgcex39XS8ne1eSRva2GmWY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QEESjNQr5YgnXgTCpMVQLTlAxBSrHXfc4HF+tdx/gqQuAtch//lscNHg5ug5TVw/8K8ytvCMTfzLvhwCnOWLOUhulIGl6glERzg9NsP+t3t0wPnwS3p2Qv73LZ9hiZ8HuX6e0y4mUE3Ciuc5vp1LfocvecF/cEkGodKNVHxqj/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NN+mchfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD3DC19425;
	Sat, 16 May 2026 13:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778936950;
	bh=uAX/ioKdn5LkIKdFXTI4Zgcex39XS8ne1eSRva2GmWY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NN+mchfkb8qvZDAO/2dXdv1WeK6oLpiglpj9oiHqj6ZeqSvebC84Pq+QaD0GvKBRI
	 EOLQsp1qg59odcXtXmdG7lqXLZDW2vINsZmiKeKTW80BXjHJ0F5kHkxlk2n4QjYjeP
	 qGfuK9C7csj14RWZUwqIKVSPbV/wzD8764n0FMNDcMAn+17fNupbNBSTueF8FRu4FR
	 tUPxz6ZONZQ0fqotAMEPYEslA2yZpZ8NEy+er1swVHF21SUzJmS01Fj6yCGcxMy4tK
	 qzkb5qtnWLzPFdnfeG92jILwRHlzW1en4bJmVXmOj0pAEN134MOSKk+9cT/geB1FBD
	 hnzHrk5xdlITA==
Date: Sat, 16 May 2026 14:09:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rishi Gupta
 <gupt21@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: light: veml6030: fix channel type when
 pushing events
Message-ID: <20260516140902.2c3135ba@jic23-huawei>
In-Reply-To: <20260514-veml6030-fixes-v2-1-abdd5837be50@gmail.com>
References: <20260514-veml6030-fixes-v2-0-abdd5837be50@gmail.com>
	<20260514-veml6030-fixes-v2-1-abdd5837be50@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5D83A55BE3C
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
	TAGGED_FROM(0.00)[bounces-249000-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,analog.com,kernel.org,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, 14 May 2026 14:01:11 +1300
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The events are registered for IIO_LIGHT and not for IIO_INTENSITY.
> Use the correct channel type.
> 
> When at it, fix minor checkpatch code style warning (alignment).
> 
> Cc: stable@vger.kernel.org
> Fixes: 7b779f573c48 ("iio: light: add driver for veml6030 ambient light sensor")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied this one to the fixes-togreg branch of iio.git.

Thanks

Jonathan

> ---
>  drivers/iio/light/veml6030.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> index 6bcacae3863c..da8c32cabfd6 100644
> --- a/drivers/iio/light/veml6030.c
> +++ b/drivers/iio/light/veml6030.c
> @@ -875,9 +875,11 @@ static irqreturn_t veml6030_event_handler(int irq, void *private)
>  	else
>  		evtdir = IIO_EV_DIR_FALLING;
>  
> -	iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_INTENSITY,
> -					0, IIO_EV_TYPE_THRESH, evtdir),
> -					iio_get_time_ns(indio_dev));
> +	iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
> +						       0,
> +						       IIO_EV_TYPE_THRESH,
> +						       evtdir),
> +		       iio_get_time_ns(indio_dev));
>  
>  	return IRQ_HANDLED;
>  }
> 


