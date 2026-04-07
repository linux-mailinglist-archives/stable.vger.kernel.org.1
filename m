Return-Path: <stable+bounces-233715-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BtvC6Na1WkH5QcAu9opvQ
	(envelope-from <stable+bounces-233715-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 21:27:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8685D3B38B2
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 21:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2327B307C87B
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 19:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00ADE3783DE;
	Tue,  7 Apr 2026 19:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNMomS95"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E31359703
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 19:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775589713; cv=none; b=g7k0L3M2ACWffQxm+ahyql+B7p7Q8173kEXvEg6ueb3CCn7BNc867jbc2l9lFqn9r2bE7rz0OT34yShp+6BIqhmm3yAHNNKbLdlFSD72zuKh1bWnTBDxpDMCembHaIjwhbuq6oTgFgJP06kIVgJvL4FlhuNGxfnLByLcXhRKl8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775589713; c=relaxed/simple;
	bh=MKoE3h0DuYR0lgEIvM6gIM01XUL/EcIa7FItQK0XwVc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQ8lEuJUftxOIX3cktvRvNTy/EoyzSHh3kXu6ogoXBjkdPI4uU1bT7GKbukJ7su35ogW+DfDoh2KQKlrPWf5BpxU+yLnHfcOSM2yWOupxRRjJNX+QRBBhjX8ooV+k2SZIAkBZNHbNQx6nhvHaGsgmGepdFbD0SDreDfOwNWGehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pNMomS95; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43cfd832155so3419569f8f.1
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 12:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775589710; x=1776194510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTFUY1Kqg7irJGktxqz9kIPDduQ1qlHcsqGBW7GGikk=;
        b=pNMomS951hcgDieBfxDZMBBrZfWj31yTNhj1ZBSRMXs5AOxfeIp0FNSEltIl7xq6z/
         GYkqWg7TAINL1FXSK01WZgk1GtTSOF4dg1OiZGfE6+TjlVwmLsRJqaaAIHdUQMNy4Djq
         2ZPqRmpWz+qJOgxI9f+onxFPnXHmS0HCf/cFhoCxIurNSDsCEVgFSqYO2NUb4oLGlkOb
         yljSEcd5FHYSTcjr1NlbvCEUM3DOAwcuol7r+HxczNIN7NxF+XDvl/TY7Tcf6Ts9KZnz
         o7EGYCVR9oJYAYoqu1mA+rqhfk0gCjVt39CUVcsRvrDSr/XYVhcWadTCrOz8X3bSF7Vi
         8IXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775589710; x=1776194510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XTFUY1Kqg7irJGktxqz9kIPDduQ1qlHcsqGBW7GGikk=;
        b=UIEVA6djRdsEN3x2dNzKh6sABatfhDm3a7N8GCGiZzI/Q+uo0GndYemqdeXzIrxOcI
         oztRkRVN06tk3CDSdA1QJwDSd989jC+lqofdM0LKiSFNhLFgUtmG4kEXCzAiM3RPKTgI
         N+chKPOJ36d13DmSaFiZCrcbsrnjDo3yFiqglMImGxh1+WgKknCQYDfI0FMaHbk8zITO
         uGuhlzZY/WVZ7aySCIVdD0Vwrkr4k+YJ25OBT2HL7eJF37uqh48CLcLkmpzPCsHDcojX
         xQbfVfabHIgIETDf00fAZEhG33Bksmv5BJgydN3WZfkmEnGLzuDAp3UTpe+EkVlKJVF0
         6wEg==
X-Forwarded-Encrypted: i=1; AJvYcCU4mPvxIJbnLmdMBdea71UYSs8JWTGcBgZj9il2X51DeuaQnZ43Rr7cal9T5iiGTQf52p79BO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK6PSLSlK4atsa/+GrbEgetr8RZ9XDNAqOzziR87EZY1QSpBrG
	raD1RMpFnVYDZisdGKRVG2t21oJQ5XLpYYhlaFwI6rusKEgFuQJnWB8d
X-Gm-Gg: AeBDietsXIbKVslv/zDkRDJJm2mJo6KhMcsSlJrEnoRav2hOn6Ligj0NP2B+oFqFTA4
	qx0dedBY+FuazRKjnMwlQ2h/Q4yb0yoDCOUXLvR8ec+V2bwF9ICQ8mBcHR6CJvwjzQaZkF6gFMX
	79qTn6nngSFjuMfg3F7W9lhu2gGFA5C9rsa2vSM8ZH35M4A5Lpl5JWqA5VEwuzYYNPyJ476cRLg
	+qJX5Mk+hTTxfUBBrUMt8JIZWj/zn5CaRnYAz6G6NxD2LwKbYiBTNt3cj17Zo66pOLl2mVrcPpE
	jZj9c0Oo9lPV4RjKanHYmvwqV4pkB7OppmxcvtVcacNCIBB/7gyohiNL6WxzaY3EoJD/Q7pqJto
	++mQJeMI5WMDTz2H8fVp8RcW/miLsIGHb/jPgqygzMi9piHclOgqgyY8ZrXxDQw056pdRLRMGWS
	lzcyv8cF+v93tw2zOVPbnljdY4gkdi3s4GMYMCozIlA3tBpejPC1jrmGjwyxveOVl2nlfg4ovwG
	Ds=
X-Received: by 2002:a05:6000:2c01:b0:43c:f0c0:c571 with SMTP id ffacd0b85a97d-43d2930fee1mr27805566f8f.47.1775589709607;
        Tue, 07 Apr 2026 12:21:49 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e1c27sm49956069f8f.26.2026.04.07.12.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 12:21:49 -0700 (PDT)
Date: Tue, 7 Apr 2026 20:21:46 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
Cc: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "linux@roeck-us.net" <linux@roeck-us.net>, "linux@weissschuh.net"
 <linux@weissschuh.net>, "cosmo.chou@quantatw.com"
 <cosmo.chou@quantatw.com>, "mail@carsten-spiess.de"
 <mail@carsten-spiess.de>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Sanman Pradhan <psanman@juniper.net>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] hwmon: (isl28022) Fix integer overflow in power
 calculation on 32-bit
Message-ID: <20260407202146.59b1476f@pumpkin>
In-Reply-To: <20260407173624.247803-3-sanman.pradhan@hpe.com>
References: <20260407173624.247803-1-sanman.pradhan@hpe.com>
	<20260407173624.247803-3-sanman.pradhan@hpe.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233715-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[juniper.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hpe.com:email]
X-Rspamd-Queue-Id: 8685D3B38B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 7 Apr 2026 17:38:01 +0000
"Pradhan, Sanman" <sanman.pradhan@hpe.com> wrote:

> From: Sanman Pradhan <psanman@juniper.net>
> 
> isl28022_read_power() computes:
> 
>   *val = ((51200000L * ((long)data->gain)) /
>           (long)data->shunt) * (long)regval;
> 
> On 32-bit platforms, 'long' is 32 bits. With gain=8 and shunt=10000
> (the default configuration):
> 
>   (51200000 * 8) / 10000 = 40960
>   40960 * 65535 = 2,684,313,600
> 
> This exceeds LONG_MAX (2,147,483,647), resulting in signed integer
> overflow.
> 
> Additionally, dividing before multiplying by regval loses precision
> unnecessarily.
> 
> Use u64 intermediates with div_u64() and multiply before dividing
> to retain precision. Power is inherently non-negative, so unsigned
> types are the natural fit. Clamp the result to LONG_MAX before
> returning it through the hwmon callback, following the pattern used
> by ina238.
> 
> Fixes: 39671a14df4f2 ("hwmon: (isl28022) new driver for ISL28022 power monitor")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanman Pradhan <psanman@juniper.net>
> ---
> v2:
>  - Switch from s64/div_s64() to u64/div_u64() since power is
>    inherently non-negative, avoiding implicit u32-to-s32 narrowing
>    of the shunt divisor

There is no such thing as u32-to-s32 narrowing.
Basically nothing happens to the bit pattern.
But the values are almost certainly never negative.

> 
>  drivers/hwmon/isl28022.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/isl28022.c b/drivers/hwmon/isl28022.c
> index c2e559dde63f..d233a7b3f327 100644
> --- a/drivers/hwmon/isl28022.c
> +++ b/drivers/hwmon/isl28022.c
> @@ -9,6 +9,7 @@
>  #include <linux/err.h>
>  #include <linux/hwmon.h>
>  #include <linux/i2c.h>
> +#include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
>  
> @@ -178,6 +179,7 @@ static int isl28022_read_power(struct device *dev, u32 attr, long *val)
>  	struct isl28022_data *data = dev_get_drvdata(dev);
>  	unsigned int regval;
>  	int err;
> +	u64 tmp;
>  
>  	switch (attr) {
>  	case hwmon_power_input:
> @@ -185,8 +187,9 @@ static int isl28022_read_power(struct device *dev, u32 attr, long *val)
>  				  ISL28022_REG_POWER, &regval);
>  		if (err < 0)
>  			return err;
> -		*val = ((51200000L * ((long)data->gain)) /
> -			(long)data->shunt) * (long)regval;
> +		tmp = (u64)51200000 * data->gain * regval;
> +		tmp = div_u64(tmp, data->shunt);
> +		*val = clamp_val(tmp, 0, LONG_MAX);

Don't use clamp_val(), you don't need to and it is completely
broken by design.
Just use min().
You could just write:
	*val = min(div_u64(51200000ULL * data->gain * regval, data->shunt), LONG_MAX);

Have you checked that the multiply can't overflow 64bits?
That might be why the last multiply was done after the divide.

	David   


>  		break;
>  	default:
>  		return -EOPNOTSUPP;


