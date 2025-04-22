Return-Path: <stable+bounces-135079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25237A96550
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 12:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBD043BB360
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 10:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E5E20B7EC;
	Tue, 22 Apr 2025 10:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FPLeId+N"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E539D200BBC
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745316155; cv=none; b=k69pHNZyapmlxsJzPB/npO8Cc7ELqgDV0kSpU+zEdu8zsg/lvncFGGjy0YxvbWtzcNuSvMoo25cYi/IQSGrUNoihToVgnqUTNOPdvlfBL0fwvedv5kzf9YWsXsM23QSbpCdVrqbE64RDa8rtiPm4UK6bTw6NbkAXa7MfRnTMD7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745316155; c=relaxed/simple;
	bh=r6si7KxlGkOoATAg7ilVznuwbtqgYzdFtBjWKcTszJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZEkp4L/zhPIFDRKd69i8sTOhbb0J6w1ULW8/buIK36ltYX0WTAO93l1So5sE94mtquCWU7UWgRnWAZveWd3/bUfDtBgDaI2XpTtUiVK3Wvhx16YXX1rv/TrzjHrDuwNWvvgIhxw9pm35hzV4oOkuTYQSE0cww6QyIfD/52i0YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FPLeId+N; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39ee5ac4321so5263331f8f.1
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 03:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745316152; x=1745920952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2lwX66HK8eTxAxJezuea/KRjoMND3umFRpU7IdR4G0w=;
        b=FPLeId+NVXCtZvebuQRmAzc9kWvDpITGAqw+N9z7hTXK49DrYxUgREe2UNtbenzvP6
         XLxg2CROL8Iu2VpTy8POM2xXlfg+FcLTOd7MdleIfP3OVc8ROjbhx19xSMfmMtG15JX7
         ngPqizDJxgLBbJOrF5udCnrsw/Y6L07+v0bcjasEQ0oS9ca1YWgAcYilZpMrGBfTYkBD
         BlzplR/PXXXJdoQYjbZwc3qXJIL6jxXvyLoHpuuyPVRvjxm64BsuZ2g33qSABpTgTPrf
         1CnKgsceMR6jPRBqgWt6DuNn5eYW1TzMO+p6JLXOd5A6pkZsV6icZ+ipkNDI45cK0bkd
         G6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745316152; x=1745920952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lwX66HK8eTxAxJezuea/KRjoMND3umFRpU7IdR4G0w=;
        b=DFGaZeAbVT8Ao+pYY57jqCpRm2TrSGq9Ym9Kufz+0gYGp4yeKeO4V+ks0wD83mJci/
         Kv8Wuq62jSoueuuvQRAMwWo3FU+zA3x/hSmq5mmt9lYFXg/Wy2b1HXrZ4fbEGhVTtKkz
         orMkJlerFcGalRZ3vI9ycZG9JqOuR5sqZpX5ToMZiRRxDBM7SUqvJc3XHGyqas9tyUXc
         lFYk3Q2CEvf58s17d/eyIXEltPM3SJAqrheAymaN3LNN1Je50mZGYWBFqjQ8tFnZaeq7
         vmzpw51DJhAe2trKWqVEdKJ110Ojqka9NM0HReECa6Kb4NZOjgM1umGP2hQJ3d7gy85b
         +t/A==
X-Forwarded-Encrypted: i=1; AJvYcCXPsH1jvSjlfNXW9vPDZLFItLjcmHLF0nJUJpyWqQlbWyVz2uNzX8bejlZmi1DxowRTkTMvmwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwylghFhF2hZlz0HmGyyrJ7vjUJz5Ve31iRqCX3IqOiSgmomP4M
	OQ1F66eGOJJh8rBzyWUB7d8CnT7VPGdN9QMENuSZpenji8vHO6AhKwWudIVWB4La4C11nWVYz+C
	d
X-Gm-Gg: ASbGncu0hAQa2RAk32+C5X26ehhzzSOrPiZiqNrQnDh+GyGR4ubBTdxg0Wp5/8rHgYj
	5Od9RuJeT1v/IEd/frG1EiZTJSBVVGDhaohgEksCGOhafeUDXaw0lp2lCjkCVrwqrAr8KBbZv4N
	zlRTIm20nKpMlB25vmtjvxb9Sf4jurPHLGImlHMjrUCUFO+rnnMeq8Aqum4IO6dTU+7pPfTEKnc
	2er7yG6Tf+yAVpAdTHbtR+BC06tkcvDUfWlKkNbqVd4j2KRTz5DAbPhWMtXAVE5fbmXroIYJp78
	8OyEg4HwDYPiBxmOC0RrgclfQNxAWje2R8dtzTpvo970Ow==
X-Google-Smtp-Source: AGHT+IF1ZkfPi2gJ652NKkarwIY/ypcd5ApofOa/AQ+PxbuhRTF4pbWiSN2ZlQ7ALpKKQfQcvtNEOA==
X-Received: by 2002:a5d:5f8a:0:b0:391:2bcc:11f2 with SMTP id ffacd0b85a97d-39efba2c924mr10978756f8f.1.1745316152148;
        Tue, 22 Apr 2025 03:02:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4406d5acec8sm165056665e9.16.2025.04.22.03.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 03:02:31 -0700 (PDT)
Date: Tue, 22 Apr 2025 13:02:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, Michael.Hennerich@analog.com,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] staging: iio: ad5933: Correct settling cycles
 encoding per datasheet
Message-ID: <ce0c0684-2f5e-4e23-824e-8bcad56e6b0c@stanley.mountain>
References: <20250420003000.842747-1-gshahrouzi@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250420003000.842747-1-gshahrouzi@gmail.com>

On Sat, Apr 19, 2025 at 08:30:00PM -0400, Gabriel Shahrouzi wrote:
> Implement the settling cycles encoding as specified in the AD5933
> datasheet, Table 13 ("Number of Settling Times Cycles Register"). The
> previous logic did not correctly translate the user-requested effective
> cycle count into the required 9-bit base + 2-bit multiplier format
> (D10..D0) for values exceeding 511.
> 
> Clamp the user input for out_altvoltage0_settling_cycles to the
> maximum effective value of 2044 cycles (511 * 4x multiplier).
> 
> Fixes: f94aa354d676 ("iio: impedance-analyzer: New driver for AD5933/4 Impedance Converter, Network Analyzer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> ---
> Changes in v3:
> 	- Only include fix (remove refactoring which will be its own
> 	  separate patch).
> Changes in v2:
>         - Fix spacing in comment around '+'.
>         - Define mask and values for settling cycle multipliers.
> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index d5544fc2fe989..f8fcc10ea8150 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -411,7 +411,7 @@ static ssize_t ad5933_store(struct device *dev,
>  		ret = ad5933_cmd(st, 0);
>  		break;
>  	case AD5933_OUT_SETTLING_CYCLES:
> -		val = clamp(val, (u16)0, (u16)0x7FF);
> +		val = clamp(val, (u16)0, (u16)0x7FC);

We have a fancy clamp() define now so the ugly casts are no longer
required.

regards,
dan carpenter


