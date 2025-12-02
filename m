Return-Path: <stable+bounces-198062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 67ADAC9AD6C
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 10:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A0558346EA4
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 09:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9F230B51F;
	Tue,  2 Dec 2025 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mx8Ffvg6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CFA2FFDC0
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764667584; cv=none; b=aOJE+VR73tirnkdoH6crCY6lLFfPe9pAQVJ0NNV3fzOhrI1vEewrEH0jNXe1xjt1jiPve3YxsGT/8rMmX3OMeA5WhJJeaDtcgz4RXeP03EZ6eBzg3w+LWSpVmCOBX2qWHNHHjMtw3GzzU7aX/skYq5l7xV/LRRXerCvS/7vRpvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764667584; c=relaxed/simple;
	bh=w+1ILYdGjvkaM1TG6974UZv9XQgEC6vJx10hNX4/UUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HBn0LMRkiNaMxhhIextw/s/TiEjDTtj3OLiLP8UTDgVv3MPh2lzEbkSqbdbw78afpl6TIGsdQxSMhXhbCMebenx0mKM24pVJPBFzin63kUATLo9N7EIwiGJfjuLaas7eAUHE/gNYXBlkz374DDdgoX2E6xZLv3R5+Im/BsCxVO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mx8Ffvg6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47778b23f64so30090065e9.0
        for <stable@vger.kernel.org>; Tue, 02 Dec 2025 01:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764667581; x=1765272381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zydHyiqAC3ZHYIZdC05XqLM2WAuCVhDvuFCoJaMA1lo=;
        b=Mx8Ffvg6uxvnyuk44VMMDUAJX1sujgy3DYKqEjHvBit3DHYfjr3gU+02h1iE7ThEIm
         vE1a2cBbC4bF2okQA56kZrd+ikb6B4xVB2J78myvZhWDOueAxYoqdey5pnF9hyVclHmg
         2zP6Cb8pyFdh17n8pegY2T9VgIlMbhdJiobeVPuTTKMp++ZpoLBmlXV9MfOdT27kiguX
         MkKOounhwBGN4cNlT3u6SBnUnTgV9mPa1fcLSERY0T9vJ/mEEONPIRZkKVMR8bu62kio
         9CAxhOsPnzSk3d+gzu7NnvxRfRsv768GkkxBpMhyGiGZ4kUf9TwNtEHRGnbLSy8qifYk
         rkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764667581; x=1765272381;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zydHyiqAC3ZHYIZdC05XqLM2WAuCVhDvuFCoJaMA1lo=;
        b=dBdLdug9v1u3nhKj5UM/T2j3wGtgv2U/epn6PvW/iTaaT1Rr/XZghcFgQqg1X5e5M9
         be7PRMqcsuJoQIfsIQwecApJt2/vNf4mbbm+eMEVVxrIB3v2tDdav2VzI61MXC3+lIrD
         ch8SkqNDGpaz6/CzcvjOInMVLwu2YJal9NZUUg94oA0S6HiPQk6EDSOoH/xVFrSpaIEE
         dE9nmjaI4bWcjzqL2esy9bnr7LUL+UVo3DpAxG7h7x1HpAEX5SsKlnbUpVy/2xz/aYDO
         PvP75HWF4wyiorCFf+RudBHmJ/iGapT0/Gvnfd7wtrSOeukVhneaS2nKuCM9Xs1KFNYp
         6W0g==
X-Forwarded-Encrypted: i=1; AJvYcCWc7LKtEM6Hf8+AH1xbr+YB5JyB9MRaj9CqKLTw4BE0h0ZgULV0SkMrR5M8k8h+Q3USQd49ecU=@vger.kernel.org
X-Gm-Message-State: AOJu0YysFzm1+cLI+UPrXoIuAWzso4wkFZBKTx9BcpauY2LH+C73gA5d
	xwgyC/mWjECoVPAdud4WoulIf3j/XJjYzS5FoVj+W1nwPrF20m05RGtoKgRAdGsc9Fg=
X-Gm-Gg: ASbGncsEcYV6DlbDjJ8PipG83+5P6t2TidoMH8QgXINydwAwyr2dF6rdZx70D/LybBc
	Qty6K/eN6OrgD9yx/gGyc2dvGRpsFcaGpoUF3pgRWoDgupUrvxvzGAnZEUk6Q6AqFwE7c+Wlyyx
	Ylqrkng6mkIfQGHlgH1aeZsUBfvXH714EtvCtrtw/k4sgOchzyb+hqctr/5IERRFUFhVJT1temb
	qqvu97X2zpvmQRktEFSjnUlIR0tI7XIBVaD+yerQkn2cDeBVdU+MPyKOAERKJdcETTwJ6Pt6psP
	69VQU7vUh86N7yXtCR9SMbJmFSpYPL6KozsZKzWAmmYE7dyYV8QRPiQdBtote4mYNzg1s6hqQm5
	x+CeZXnlKZytB2/F/DKymAMJM2K34FZYE6fpioq+jFkX2SbxtU5ZxNBy/M/z+Lz3cXZd1lRH4KP
	qizBldxJFWpIAW1rMl
X-Google-Smtp-Source: AGHT+IE8k+HW7Nso1FCZIlB9mBQaNvvaXUAUAi2gwo61pv1tszj/rx1Sal4ecT4VI29+FHM/ydZiPA==
X-Received: by 2002:a05:600c:4f06:b0:471:9da:5248 with SMTP id 5b1f17b1804b1-477c114ef3dmr458806355e9.26.1764667581352;
        Tue, 02 Dec 2025 01:26:21 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca1a3f1sm32008361f8f.28.2025.12.02.01.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 01:26:20 -0800 (PST)
Message-ID: <3bec7ceb-61a8-4b38-a794-02ee2fc9e68c@linaro.org>
Date: Tue, 2 Dec 2025 09:26:19 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] coresight: etm3x: Fix cntr_val_show() to match
 cntr_val_store() behavior
To: Kuan-Wei Chiu <visitorckw@gmail.com>, suzuki.poulose@arm.com
Cc: mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
 gregkh@linuxfoundation.org, mathieu.poirier@linaro.org, leo.yan@arm.com,
 Al.Grant@arm.com, jserv@ccns.ncku.edu.tw, marscheng@google.com,
 ericchancf@google.com, milesjiang@google.com, nickpan@google.com,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251202082613.3265761-1-visitorckw@gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251202082613.3265761-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/12/2025 8:26 am, Kuan-Wei Chiu wrote:
> The cntr_val_show() function was intended to print the values of all
> counters using a loop. However, due to a buffer overwrite issue with
> sprintf(), it effectively only displayed the value of the last counter.
> 
> The companion function, cntr_val_store(), allows users to modify a
> specific counter selected by 'cntr_idx'. To maintain consistency
> between read and write operations and to align with the ETM4x driver
> behavior, modify cntr_val_show() to report only the value of the
> currently selected counter.
> 
> This change removes the loop and the "counter %d:" prefix, printing
> only the hexadecimal value. It also adopts sysfs_emit() for standard
> sysfs output formatting.
> 
> Fixes: a939fc5a71ad ("coresight-etm: add CoreSight ETM/PTM driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Build test only.
> 
> Changes in v3:
> - Switch format specifier to %#x to include the 0x prefix.
> - Add Cc stable
> 
> v2: https://lore.kernel.org/lkml/20251201095228.1905489-1-visitorckw@gmail.com/
> 
>   .../hwtracing/coresight/coresight-etm3x-sysfs.c   | 15 ++++-----------
>   1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> index 762109307b86..b3c67e96a82a 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> @@ -717,26 +717,19 @@ static DEVICE_ATTR_RW(cntr_rld_event);
>   static ssize_t cntr_val_show(struct device *dev,
>   			     struct device_attribute *attr, char *buf)
>   {
> -	int i, ret = 0;
>   	u32 val;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>   	struct etm_config *config = &drvdata->config;
>   
>   	if (!coresight_get_mode(drvdata->csdev)) {
>   		spin_lock(&drvdata->spinlock);
> -		for (i = 0; i < drvdata->nr_cntr; i++)
> -			ret += sprintf(buf, "counter %d: %x\n",
> -				       i, config->cntr_val[i]);
> +		val = config->cntr_val[config->cntr_idx];
>   		spin_unlock(&drvdata->spinlock);
> -		return ret;
> -	}
> -
> -	for (i = 0; i < drvdata->nr_cntr; i++) {
> -		val = etm_readl(drvdata, ETMCNTVRn(i));
> -		ret += sprintf(buf, "counter %d: %x\n", i, val);
> +	} else {
> +		val = etm_readl(drvdata, ETMCNTVRn(config->cntr_idx));
>   	}
>   
> -	return ret;
> +	return sysfs_emit(buf, "%#x\n", val);
>   }
>   
>   static ssize_t cntr_val_store(struct device *dev,

Reviewed-by: James Clark <james.clark@linaro.org>


