Return-Path: <stable+bounces-214755-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MEwA0sXh2nBTQQAu9opvQ
	(envelope-from <stable+bounces-214755-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 11:43:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB1C105980
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 11:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0527D301AF7F
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 10:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9CD33E351;
	Sat,  7 Feb 2026 10:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBmezeGz"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F3F311599
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770460992; cv=none; b=rCAED2VeKst58WxpCReCn/gZxJnvDYcjY2TDc2zouHfzM04yLFJPSGM8hUbcY/V3kXDCmSA8w4ydNm/tpEnPvWWVm7k32uC5b6yOA46P1U9tOutxbe5sOhNmlcDKAPRoNvxvhB9/wfUoBnmdEWjmXhylzoYb5n2Q7b77GI14pSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770460992; c=relaxed/simple;
	bh=VpylFaXQ5R9Ce/kUeXCB7cheL20SuIrXZ7nduGMGXJw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BY1D1DwTdrFze2MDMHAD4PrqY9Bswu7YZBL5ymf/GHvVbdTgEc/PIZeT6h1j5SxdYPGZWYRbZSBoI3rwLZXeYxcsvJkUXKEIpv4YfHWHDlDk2op0aO5YE3GSSJDPcUoFK/90kmblTOnlE4Q7bPUOPG8V1dHTPi/z7nuQribcm2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBmezeGz; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4806fbc6bf3so17027705e9.2
        for <stable@vger.kernel.org>; Sat, 07 Feb 2026 02:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770460990; x=1771065790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nip7PxraMmxt86GWPJ7mOALMTbQ7LbZ8aEjfsVnU+KA=;
        b=RBmezeGzM1CPVl4ZZOIomSaKBNoCtr/TMk9cmDAoGFvSZAexiZwA+CdYaQ/FqrfI5N
         cpL/AM30x1w+byQ0LJEvuajI4kXSGlDWHMf9VniV6EpP/r7POyKF1+9IVo0HQU5TrrhP
         PwFo91RHG6SGMcjA8L2GNn+ZXCjS2fjn+jOb9pOm1TtJP8MwXRryuIceQDkwcvXPnZ47
         fXgCub9yF4lQzU2kHQtV/IUd1xbTgE3bLjZJWSpIXJenAXDHvahUSyR2+NmRbmSXjo4g
         QyXQ1EindK2jWotPCH+w/xZgp0vnw00qihd6NtM6brNP65ReUd6Km2nW6LfzhtiXgTiw
         +h3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770460990; x=1771065790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nip7PxraMmxt86GWPJ7mOALMTbQ7LbZ8aEjfsVnU+KA=;
        b=wSNk88koS2sf7DQ8s5GVo3dVsot7acIswTYxZhKIFHRaNpL+eQum2NxK0zp164kMGS
         akl95pb/bB7aFoLcrMrqy/aVPmjV1RRHUxBjTH8UR2DTK/fQB0UHTXzeRPPyoq+WVNlH
         eN/DcUK5Kg1ociOq23eJyblS7eJnutQHRaCBUYIzdECTcQXE2nf7dkbcjv7YLiv4TIoT
         Ts9vl/hm5FtvCBkgXAtb/cRvwHcjlaTvYxWQgNX/Wc1LbR7O26T0eL1uy6XY4utYp8VB
         nq2ZYYcTFXPD8vOVocwFl+keBuRcDZ1TcY/P0spF39t4nD8AddqlbVHB7fvU8jK1CRvZ
         aWGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqi3M0wFUqMvkz50PJo439HcxfjUUJi/myWjlLtWwzfuL1WsO1OZeJLgc1tthh8aOmvYrArpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJGKaM+yWYFmuYvFLKcsZGrOoYEdapdZNg02HIR7WJPx3Ze6Y6
	dT6AER0z1bVJngxjgRKHH4JKxKLEcNBmwT9a7MoEgrdEAdKpYlDsu4Nc
X-Gm-Gg: AZuq6aLyx+S+tlPQtHCtoSME7WRH1J2Fs2I2rrWkw0CDOhxb0LmhD+EMtWJnhR+dZyF
	zSiSmmyPEvxdJ17Bixy6OLAQvnniBrMBQS+uc2v/UMBgOrkJQjXlaPtUKNkk+2fQXlzmTKs48+N
	mQzcRLvlrFEvlWhdHCXZAioMSjAzO+sa6UvrfjIoOMRJpxYB+2qCYR9IKrAOuVkPW0I9SHKjJHI
	g+EWQcgWd15FUaXWW0W37JaZyv7+1BXDd+wR7PPSHN7Z6o6hqSshNW+b2pazXuZorEV9rEc7JC+
	Rx1kWWYIvft6NdRu0vGkdsu1cA2oKUbrNVdixh3sV2rbuDDKe8VVEoprIHGcYK5iuArNrU0uo79
	A/H5eks527uXBZ/yrP0M1z+xbrMrOIdhz61M7AfOfW1yUJH1PRDr5YeBTKsmna5Nouns7x+Ucu7
	/Q7RbSufsGC4J2hP7ONbd8c7+r7i0m/z4p3eM2xk99MfKb+sXG1vMm
X-Received: by 2002:a05:600c:8489:b0:47d:3ffa:5f03 with SMTP id 5b1f17b1804b1-483202161b8mr88947085e9.21.1770460990170;
        Sat, 07 Feb 2026 02:43:10 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483203d606fsm42725245e9.2.2026.02.07.02.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 02:43:09 -0800 (PST)
Date: Sat, 7 Feb 2026 10:43:08 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: linux@roeck-us.net, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, Ben Hutchings
 <ben@decadent.org.uk>, stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (max16065) Use READ/WRITE_ONCE to avoid compiler
 optimization induced race
Message-ID: <20260207104308.1bc31102@pumpkin>
In-Reply-To: <20260203121443.5482-1-hanguidong02@gmail.com>
References: <20260203121443.5482-1-hanguidong02@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214755-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[roeck-us.net,vger.kernel.org,gmail.com,decadent.org.uk];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: DCB1C105980
X-Rspamd-Action: no action

On Tue,  3 Feb 2026 20:14:43 +0800
Gui-Dong Han <hanguidong02@gmail.com> wrote:

> Simply copying shared data to a local variable cannot prevent data
> races. The compiler is allowed to optimize away the local copy and
> re-read the shared memory, causing a Time-of-Check Time-of-Use (TOCTOU)
> issue if the data changes between the check and the usage.

While the compiler is allowed to do this, is there any indication
that either gcc or clang have ever done it?
ISTR someone saying that they never did - although I thought that
was the original justification for adding ACCESS_ONCE().

READ_ONCE() also includes barriers to guarantee ordering between cpu.
These are empty on x86 but add code to architectures where the cpu
can (IIRC) re-order writes.
This is worst on alpha but affects arm and probably ppc.

For these cases is it enough to add the compile-time barrier() after
reading the variable to a local.
That will also generate better code on x86.

The WRITE_ONCE() aren't needed at all, the compilers definitely
guarantee to do a single memory access for aligned accesses that are
less than the size of a word.

This all stinks of being an AI generated patch.

	David

> 
> To enforce the use of the local variable, use READ_ONCE() when reading
> the shared data and WRITE_ONCE() when updating it. Apply these macros to
> the three identified locations (curr_sense, adc, and fault) where local
> variables are used for error validation, ensuring the value remains
> consistent.
> 
> Reported-by: Ben Hutchings <ben@decadent.org.uk>
> Closes: https://lore.kernel.org/all/6fe17868327207e8b850cf9f88b7dc58b2021f73.camel@decadent.org.uk/
> Fixes: f5bae2642e3d ("hwmon: Driver for MAX16065 System Manager and compatibles")
> Fixes: b8d5acdcf525 ("hwmon: (max16065) Use local variable to avoid TOCTOU")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
> ---
>  drivers/hwmon/max16065.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/hwmon/max16065.c b/drivers/hwmon/max16065.c
> index 4c9e7892a73c..43fbb9b26b10 100644
> --- a/drivers/hwmon/max16065.c
> +++ b/drivers/hwmon/max16065.c
> @@ -151,27 +151,27 @@ static struct max16065_data *max16065_update_device(struct device *dev)
>  		int i;
>  
>  		for (i = 0; i < data->num_adc; i++)
> -			data->adc[i]
> -			  = max16065_read_adc(client, MAX16065_ADC(i));
> +			WRITE_ONCE(data->adc[i],
> +				   max16065_read_adc(client, MAX16065_ADC(i)));
>  
>  		if (data->have_current) {
> -			data->adc[MAX16065_NUM_ADC]
> -			  = max16065_read_adc(client, MAX16065_CSP_ADC);
> -			data->curr_sense
> -			  = i2c_smbus_read_byte_data(client,
> -						     MAX16065_CURR_SENSE);
> +			WRITE_ONCE(data->adc[MAX16065_NUM_ADC],
> +				   max16065_read_adc(client, MAX16065_CSP_ADC));
> +			WRITE_ONCE(data->curr_sense,
> +				   i2c_smbus_read_byte_data(client, MAX16065_CURR_SENSE));
>  		}
>  
>  		for (i = 0; i < 2; i++)
> -			data->fault[i]
> -			  = i2c_smbus_read_byte_data(client, MAX16065_FAULT(i));
> +			WRITE_ONCE(data->fault[i],
> +				   i2c_smbus_read_byte_data(client, MAX16065_FAULT(i)));
>  
>  		/*
>  		 * MAX16067 and MAX16068 have separate undervoltage and
>  		 * overvoltage alarm bits. Squash them together.
>  		 */
>  		if (data->chip == max16067 || data->chip == max16068)
> -			data->fault[0] |= data->fault[1];
> +			WRITE_ONCE(data->fault[0],
> +				   data->fault[0] | data->fault[1]);
>  
>  		data->last_updated = jiffies;
>  		data->valid = true;
> @@ -185,7 +185,7 @@ static ssize_t max16065_alarm_show(struct device *dev,
>  {
>  	struct sensor_device_attribute_2 *attr2 = to_sensor_dev_attr_2(da);
>  	struct max16065_data *data = max16065_update_device(dev);
> -	int val = data->fault[attr2->nr];
> +	int val = READ_ONCE(data->fault[attr2->nr]);
>  
>  	if (val < 0)
>  		return val;
> @@ -203,7 +203,7 @@ static ssize_t max16065_input_show(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
>  	struct max16065_data *data = max16065_update_device(dev);
> -	int adc = data->adc[attr->index];
> +	int adc = READ_ONCE(data->adc[attr->index]);
>  
>  	if (unlikely(adc < 0))
>  		return adc;
> @@ -216,7 +216,7 @@ static ssize_t max16065_current_show(struct device *dev,
>  				     struct device_attribute *da, char *buf)
>  {
>  	struct max16065_data *data = max16065_update_device(dev);
> -	int curr_sense = data->curr_sense;
> +	int curr_sense = READ_ONCE(data->curr_sense);
>  
>  	if (unlikely(curr_sense < 0))
>  		return curr_sense;


