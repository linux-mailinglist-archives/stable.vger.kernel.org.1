Return-Path: <stable+bounces-227837-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UI0ZJ7v8v2lZCgQAu9opvQ
	(envelope-from <stable+bounces-227837-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 15:29:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 453092E9A82
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 15:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4F2F303EC00
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 14:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C0D363C45;
	Sun, 22 Mar 2026 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Og93x7Ac"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C81363C4C
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774189483; cv=none; b=pufGQ4sOBUqKO/LLe5i0FH8bCtjEVkuhwnh1U1zf+FtE2RuvUmwXqLx+XXnmLv2RA/cCCPZi+blF6193IG4NzjTNT6zwIUKVaq5QWSyoEarPqtuggE3n1qWs6umpm6tHO6D4XQJDsUrpj3ue/TnR1x/zpg+WCMNhDgRYFwISM6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774189483; c=relaxed/simple;
	bh=VIlUeXSRZeypu85+shu2R+cv4doMcmzCkSnA4JU5Acg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAIsoivrUkpgBhgdP+nR+tcT7xouIEn53HEhBhKbywjanB1JqpgdK+dmPJDMDbHmpjBrieGi5YDEtAAb6FYtLxh+MkD+HlwxLHgo2yVwdMUDqbFZ7Dbf8XTtPeu/guO5Y7A2o5p3LOoXTZRh9J07o0HA+ADjl+YQZhe1vxInWYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Og93x7Ac; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1271195d2a7so4557962c88.0
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 07:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774189469; x=1774794269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48LFT5xoLd6RtM1k0dj2BLq7NNeYZZaAFGyC2+2DipQ=;
        b=Og93x7AcCCZ0861JLjSZN2iQroNB23vh9a0Ie3jqr9sG+WTVjZ97kvtOUDDDsIBp2o
         6W3QlWumdieLAa6zh807i4imkWmj5NS9t1mAamfdW7xKGNJG/GqzSrRVZh+LXZ50McrF
         wZ18dJPx6V02MrhqIzoBIp9MtAt5Sg8FZLnZxAP+rwYROjTqEEQyZJ6M1sA7S2lZB0b5
         3QpXNoaC90MJSE+yeKSuDkawTHnoyKm8++3bxwzYR2flNtkyr+L7wQbKgSORD59Dh+a3
         PkAQWwFe/kxNLBzlVKzC/vsolbRMwJYL6I4POZKktMi4rui4c+duplQq0+YFDYImxC53
         NDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774189469; x=1774794269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=48LFT5xoLd6RtM1k0dj2BLq7NNeYZZaAFGyC2+2DipQ=;
        b=EppjSGjETAg11A4Eqejk4E0yzPqdKnrykeB0J1exCSYtT1ExY83dl/VHboz0Ygbp0f
         xPUEtHvdBWwHDplZEDTl6qLUrR//JU7KGSjhSDj4iWbJNrkddMb0Ny7r4h6c0Y+j0vqj
         XYDqGR7bjgl+Dif1mxRdpK27dZaImYUz5ejvVVfpLOOP2mS4vc22zBUt14uVbmQKjC8E
         zKNolbEc4Qy6m59XAhkGcJf/glOb7bv3gjDnEM+PIdlMZOcgIn5LSpIRqALwO3aEs6yn
         ZvgGTOrK1N3HYk7bInIFZUi47gb8mj07eOgfpQjehquNIlO08DTgwgOm25Dl0LWp3Mcw
         PUug==
X-Forwarded-Encrypted: i=1; AJvYcCXrpxAijB2k6a9tIuAVjdcSfR3giSR4lDsLW1njcH+ZvVVpm/Og6+OBAH0B/M61mPwdW4ZDXWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNIGgYk/uyCpyZ7X7Ic0yyCT51mdjjsj0eqXpC7l39M0xpiE8I
	6ZFtiCJFNnpLWtmMgKaa508jRKlUHmK1IRlTavkKJJWTW4U6xX04nyIJ
X-Gm-Gg: ATEYQzyAJinQwyzOtY5QUKkDkvHXp2bR8Aa9hOHHAEkZFzYNmZVcouyWC+4WkduHd3b
	NBxj24Jlm/UOSGngnhQxgY8pI3jlOcv+wMGi1S82k874PLv9p08c5KwqUuKf8Bz03g4pzQDboqz
	mwG+LW8l4aecS10R7uO1kd3y/jRl5aevQT1+wNPHh+cAXiKekMY9BkXnHbweSQaPu5Y7+xrgQ0M
	MYAWbjT6yIVw+iQxdFnsJQPCtGya09+ZG23428DCBN8zALgNX2KvgtFid4Gv25aiKYvwzqQh5dv
	uF5XZcVTbBnP/yfnwglQLKHQ1jpWzcqu2sekBhqPr0cE/e7Iuzkb/ogRW6HwhkLoCtIhtZ2Tw/S
	C9YoXVrNp2sYBGMZTzWefW56tn0LeFrjZ9eE9SbD7Tc1xgBkLkcHkQGf+kEeEeqNHGaT2vLXEsd
	P65EZE+HghN/7HjvZ615Nfs/s6f4jE3KCr6rh0
X-Received: by 2002:a05:7022:fa9:b0:12a:6c19:d20d with SMTP id a92af1059eb24-12a726da820mr3866661c88.39.1774189468978;
        Sun, 22 Mar 2026 07:24:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a733b4a39sm7242713c88.3.2026.03.22.07.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 07:24:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 22 Mar 2026 07:24:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
Cc: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sanman Pradhan <psanman@juniper.net>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] hwmon: (pmbus/isl68137) Add mutex protection for
 AVS enable sysfs attributes
Message-ID: <c4117b2c-c86e-48b7-834a-7701d32ea3b6@roeck-us.net>
References: <20260319173055.125271-1-sanman.pradhan@hpe.com>
 <20260319173055.125271-3-sanman.pradhan@hpe.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319173055.125271-3-sanman.pradhan@hpe.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227837-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,roeck-us.net:mid,juniper.net:email]
X-Rspamd-Queue-Id: 453092E9A82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 05:31:29PM +0000, Pradhan, Sanman wrote:
> From: Sanman Pradhan <psanman@juniper.net>
> 
> The custom avs0_enable and avs1_enable sysfs attributes access PMBus
> registers through the exported API helpers (pmbus_read_byte_data,
> pmbus_read_word_data, pmbus_write_word_data, pmbus_update_byte_data)
> without holding the PMBus update_lock mutex. These exported helpers do
> not acquire the mutex internally, unlike the core's internal callers
> which hold the lock before invoking them.
> 
> The store callback is especially vulnerable: it performs a multi-step
> read-modify-write sequence (read VOUT_COMMAND, write VOUT_COMMAND, then
> update OPERATION) where concurrent access from another thread could
> interleave and corrupt the register state.
> 
> Add pmbus_lock_interruptible()/pmbus_unlock() around both the show and
> store callbacks to serialize PMBus register access with the rest of the
> driver.
> 
> Fixes: 038a9c3d1e424 ("hwmon: (pmbus/isl68137) Add driver for Intersil ISL68137 PWM Controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanman Pradhan <psanman@juniper.net>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/isl68137.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/isl68137.c b/drivers/hwmon/pmbus/isl68137.c
> index f42b13fe9fc18..48059ac4a08be 100644
> --- a/drivers/hwmon/pmbus/isl68137.c
> +++ b/drivers/hwmon/pmbus/isl68137.c
> @@ -94,7 +94,15 @@ static ssize_t isl68137_avs_enable_show_page(struct i2c_client *client,
>  					     int page,
>  					     char *buf)
>  {
> -	int val = pmbus_read_byte_data(client, page, PMBUS_OPERATION);
> +	int val;
> +
> +	val = pmbus_lock_interruptible(client);
> +	if (val)
> +		return val;
> +
> +	val = pmbus_read_byte_data(client, page, PMBUS_OPERATION);
> +
> +	pmbus_unlock(client);
>  
>  	if (val < 0)
>  		return val;
> @@ -116,6 +124,10 @@ static ssize_t isl68137_avs_enable_store_page(struct i2c_client *client,
>  
>  	op_val = result ? ISL68137_VOUT_AVS : 0;
>  
> +	rc = pmbus_lock_interruptible(client);
> +	if (rc)
> +		return rc;
> +
>  	/*
>  	 * Writes to VOUT setpoint over AVSBus will persist after the VRM is
>  	 * switched to PMBus control. Switching back to AVSBus control
> @@ -127,17 +139,20 @@ static ssize_t isl68137_avs_enable_store_page(struct i2c_client *client,
>  		rc = pmbus_read_word_data(client, page, 0xff,
>  					  PMBUS_VOUT_COMMAND);
>  		if (rc < 0)
> -			return rc;
> +			goto unlock;
>  
>  		rc = pmbus_write_word_data(client, page, PMBUS_VOUT_COMMAND,
>  					   rc);
>  		if (rc < 0)
> -			return rc;
> +			goto unlock;
>  	}
>  
>  	rc = pmbus_update_byte_data(client, page, PMBUS_OPERATION,
>  				    ISL68137_VOUT_AVS, op_val);
>  
> +unlock:
> +	pmbus_unlock(client);
> +
>  	return (rc < 0) ? rc : count;
>  }
>  

