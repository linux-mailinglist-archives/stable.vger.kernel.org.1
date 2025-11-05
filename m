Return-Path: <stable+bounces-192491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7A4C3547E
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 12:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61EB8622440
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 10:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B0C30DEDE;
	Wed,  5 Nov 2025 10:53:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ABC30C617;
	Wed,  5 Nov 2025 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339998; cv=none; b=uexIENySkgynvAbtLY06s3qBIKWyYWPgZQBLh4qcCWHGeWBeBJiH1rYlxTFeo4BphmLvjomTO7w9QOVbbDbS5QO2JTAexkxymp4oQDYNxKkPitjwF2AqkF3ecCsAftmUPYjjR1oeoPwUDbxZcszTW34CUqEZz4u7oPVR98qspyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339998; c=relaxed/simple;
	bh=65j2zQ0hirApoK50aZu6uaJJ4JmRrtmhk68goetJMtM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uj7SCScfS5u0assKMyg935JClGMsJ2TcDTXOqiJHEMsKhfeIEmQtUSmlUREjplqTnz1iRN8ESo4FiA4km9r2HUypwK3zdCUAvqBlmDokJfcfxJWiRKOtyscf/pKkbCH/CawJG8f95nJARQ/EHW1K+pU77/OQQu9HyfHOqjrebE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4d1hsF5jL3z6HJcR;
	Wed,  5 Nov 2025 18:49:21 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id D5CD61402A5;
	Wed,  5 Nov 2025 18:53:13 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 5 Nov
 2025 10:53:13 +0000
Date: Wed, 5 Nov 2025 10:53:11 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Sasha Levin <sashal@kernel.org>
CC: <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>, Jonathan
 Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: Patch "iio: light: isl29125: Use iio_push_to_buffers_with_ts()
 to allow source size runtime check" has been added to the 6.17-stable tree
Message-ID: <20251105105311.000045bb@huawei.com>
In-Reply-To: <20251104233644.350147-1-sashal@kernel.org>
References: <20251104233644.350147-1-sashal@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue,  4 Nov 2025 18:36:44 -0500
Sasha Levin <sashal@kernel.org> wrote:

> This is a note to let you know that I've just added the patch titled
> 
>     iio: light: isl29125: Use iio_push_to_buffers_with_ts() to allow source size runtime check
> 
> to the 6.17-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      iio-light-isl29125-use-iio_push_to_buffers_with_ts-t.patch
> and it can be found in the queue-6.17 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 

This isn't a fix.  Harmless if another fix needs it for context but
in of itself not otherwise appropriate for stable.

The hardening is against code bugs and there isn't one here - longer
term we want to deprecate and remove the old interface.

J
> 
> 
> commit 72afc12515b357d26a5ce4f0149379ef797e3e37
> Author: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Date:   Sat Aug 2 17:44:29 2025 +0100
> 
>     iio: light: isl29125: Use iio_push_to_buffers_with_ts() to allow source size runtime check
>     
>     [ Upstream commit f0ffec3b4fa7e430f92302ee233c79aeb021fe14 ]
>     
>     Also move the structure used as the source to the stack as it is only 16
>     bytes and not the target of an DMA or similar.
>     
>     Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
>     Reviewed-by: Andy Shevchenko <andy@kernel.org>
>     Link: https://patch.msgid.link/20250802164436.515988-10-jic23@kernel.org
>     Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
> index 6bc23b164cc55..3acb8a4f1d120 100644
> --- a/drivers/iio/light/isl29125.c
> +++ b/drivers/iio/light/isl29125.c
> @@ -51,11 +51,6 @@
>  struct isl29125_data {
>  	struct i2c_client *client;
>  	u8 conf1;
> -	/* Ensure timestamp is naturally aligned */
> -	struct {
> -		u16 chans[3];
> -		aligned_s64 timestamp;
> -	} scan;
>  };
>  
>  #define ISL29125_CHANNEL(_color, _si) { \
> @@ -179,6 +174,11 @@ static irqreturn_t isl29125_trigger_handler(int irq, void *p)
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct isl29125_data *data = iio_priv(indio_dev);
>  	int i, j = 0;
> +	/* Ensure timestamp is naturally aligned */
> +	struct {
> +		u16 chans[3];
> +		aligned_s64 timestamp;
> +	} scan = { };
>  
>  	iio_for_each_active_channel(indio_dev, i) {
>  		int ret = i2c_smbus_read_word_data(data->client,
> @@ -186,10 +186,10 @@ static irqreturn_t isl29125_trigger_handler(int irq, void *p)
>  		if (ret < 0)
>  			goto done;
>  
> -		data->scan.chans[j++] = ret;
> +		scan.chans[j++] = ret;
>  	}
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
>  		iio_get_time_ns(indio_dev));
>  
>  done:
> 


