Return-Path: <stable+bounces-227155-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNw9G4wNu2kSegIAu9opvQ
	(envelope-from <stable+bounces-227155-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 21:39:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C45EE2C28B7
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 21:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 616CC3057187
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 20:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDECA358D27;
	Wed, 18 Mar 2026 20:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RN7T+gvv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6541534107A
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 20:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773866366; cv=none; b=WRfmIH/dFGOC7SXZeI71C4IPKqg/KGgrFa1yzqNWLy7l/3ppYfvAijCkLmVpjwW37U2VvCqcp1He2cqnCPU9PV057LAQB2Oj2TAVm17SDSY89OJZo6HD2I4HvncBtqz1vdD/igFF0W8Tn5KEgs0S3+UkWyaKEBgbOoa/EOpyCIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773866366; c=relaxed/simple;
	bh=K6fFk6jgPk/ELODmU4K13Iuu5ExuxDeXbxGnbD9Iu4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBR2Wic1QwgP6oU42dhci2JLOTbXMdeMkM4qLcN1D7MH8rTmcd7pIwmpHkMTEZhyT/tTlDj95YSHR5c9Zpp0aBangCTAH+F3q+Q6EP8HX1reUTxUbcX2qr2RKo9WXL/Ftqypvu0MwKgT5WDr4RYxH8aIk2x1tPuTw3Sp3IuUe2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RN7T+gvv; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35b905e9dc0so209808a91.3
        for <stable@vger.kernel.org>; Wed, 18 Mar 2026 13:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773866364; x=1774471164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NO7l1j/JSa3nzmOJtX7R9PKY7mTRri7kyBMKzNUW53c=;
        b=RN7T+gvvm5AaZ9HDtKV/+SoBD4iY2amCMPOUrm+kVlrA6CkMBVBrFUaWta2g9dkWYb
         eSNMHP/0GiSNK/X/LYzjpZeQKLKzO9AKalxY9uHCEHb2AyXHU9civCm/iTTqzuqCa7yp
         Qgj3H4MWJZX/RS2DqaB70sHMeA0+DAp9Ae1bVHXjqUaCOGOghvSU9J5onZ8XN3kIj8oG
         lHV75Yo27R2+u92t7vONLgyx6FqJ6v/DYhrww2h0tVDqFbzLZfzfYJKHCOEnuB6As/iW
         slK+lz4BylxpMej90quh1UXz02LdE5jBgDBi7ZNlwHypJtEGgZPGDCREUlfQHndnWD6O
         tg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773866364; x=1774471164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NO7l1j/JSa3nzmOJtX7R9PKY7mTRri7kyBMKzNUW53c=;
        b=dXcbXzusY9sLKXYuI9pFI0XcXV89Xxgq8qsdp5rJBdIhnC1jXwsmYkBTPkE6Epyzur
         AcrAPaWfCPnBBtpZQ+IBRAbzt/0spBeGPEvnrRd3BXyfbzpima4WEz0sUI2lbrQ88EuV
         V5HqEDXViINSBCV/NsKT/eBnKakajMNWFhB+9QRUqKX0JE1BY1Pt5XALQhFGxgVku1Gd
         8Re3W2HrfeU79J6Kbdn46+U8ZSOXI+scUsSSMV2tOmdm8GV+12yt+cCsbKd8hY+0MPoH
         J2yjbzuaSpjYwBum9V3M1oRbCOZ8pAprN8gej8Gob7hgp2aJi8sxkFWa65lGv8mS/Vie
         Dr5A==
X-Forwarded-Encrypted: i=1; AJvYcCUQj9ydHfq+iQrR/fWXX4QXWI5A0itT0Nf2git4N3kiUoKZlfPLpL1rHH5niOqMM5rIYEBikgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDr1pLgUVQ7f/mcXCf6ytC2tA2r3dQcfSWOQYI4i1KuhapzxTK
	JIyseLU2sYsXlDV9YU1JlhzpioI/Zwp2FocttHVsQWnjBK2Dj56Je4nx
X-Gm-Gg: ATEYQzyzLKmJD42c7EfU2xmSAO9BX9Uty5hvV4x6A0PkhcDleVodV40JhNNnYjijSzr
	BZ2I4ArTQ0MBPICr57DdrwzfSXHLkyXCBlHICvAueVDBmbBPrsg/kythpyTQbmp1udoyh5hY06N
	FauxX7K5flNFVWuN/3Kxb91NP78DhmOjmABNX2BLvkNRr3XE5ha9kSU2fpIT7aqfvIROCW/zQy/
	rciTwDfayJCIeWEb819jcW7vEK+JsIjy+Uj9m9r/79XbSADB+B8OUZLWLIRMSHPkd5yoH1J4XOe
	eZy+yx9ttGOGaLY6/OBNypSo9K6DdhmjDiflm3CXv/3dFRbuXHZ/H9gTVnyOirMSL4CVGypbQi2
	kSHK9CVHL/aSvel+XxnvO6Nj+Fr6BtT04GQWAvxC4pZYRPZUj0PVrtJnmz7tlZzf6RLDg9oC1Lt
	Jo8v5YbWu1lSJq9nNHzC5hEkrZkyapWUwTR41q
X-Received: by 2002:a17:90b:2886:b0:359:fd9a:c506 with SMTP id 98e67ed59e1d1-35bb9f27187mr3873380a91.29.1773866363774;
        Wed, 18 Mar 2026 13:39:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc62b514bsm577096a91.3.2026.03.18.13.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 13:39:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 18 Mar 2026 13:39:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
Cc: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sanman Pradhan <psanman@juniper.net>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] hwmon: (pmbus/isl68137) Fix unchecked return
 value and use sysfs_emit()
Message-ID: <02d70fd5-de57-49d5-b0a3-ad59c957f057@roeck-us.net>
References: <20260318193952.47908-1-sanman.pradhan@hpe.com>
 <20260318193952.47908-2-sanman.pradhan@hpe.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318193952.47908-2-sanman.pradhan@hpe.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227155-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,roeck-us.net:mid,juniper.net:email]
X-Rspamd-Queue-Id: C45EE2C28B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 07:40:19PM +0000, Pradhan, Sanman wrote:
> From: Sanman Pradhan <psanman@juniper.net>
> 
> isl68137_avs_enable_show_page() uses the return value of
> pmbus_read_byte_data() without checking for errors. If the I2C transaction
> fails, a negative error code is passed through bitwise operations,
> producing incorrect output.
> 
> Add an error check to propagate the return value if it is negative.
> Additionally, modernize the callback by replacing sprintf()
> with sysfs_emit().
> 
> Fixes: 038a9c3d1e424 ("hwmon: (pmbus/isl68137) Add driver for Intersil ISL68137 PWM Controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanman Pradhan <psanman@juniper.net>

Applied.

Thanks,
Guenter

> ---
> v2:
>   - Kept explicit bitmask comparison instead of using !! operator
> ---
>  drivers/hwmon/pmbus/isl68137.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/isl68137.c b/drivers/hwmon/pmbus/isl68137.c
> index 97b61836f53a4..e7dac26b5be61 100644
> --- a/drivers/hwmon/pmbus/isl68137.c
> +++ b/drivers/hwmon/pmbus/isl68137.c
> @@ -98,8 +98,11 @@ static ssize_t isl68137_avs_enable_show_page(struct i2c_client *client,
>  {
>  	int val = pmbus_read_byte_data(client, page, PMBUS_OPERATION);
>  
> -	return sprintf(buf, "%d\n",
> -		       (val & ISL68137_VOUT_AVS) == ISL68137_VOUT_AVS ? 1 : 0);
> +	if (val < 0)
> +		return val;
> +
> +	return sysfs_emit(buf, "%d\n",
> +			   (val & ISL68137_VOUT_AVS) == ISL68137_VOUT_AVS);
>  }
>  
>  static ssize_t isl68137_avs_enable_store_page(struct i2c_client *client,

