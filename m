Return-Path: <stable+bounces-104304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 788CD9F2847
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 02:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7CCF188067F
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 01:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA8E1798C;
	Mon, 16 Dec 2024 01:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="TxL5dtrl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E74E57D
	for <stable@vger.kernel.org>; Mon, 16 Dec 2024 01:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734314255; cv=none; b=ewwLlYfqe8Jn3NeS79ZHyH6M9GXfhzdhYrJBoN4RZGHciNtM6YqCtjaljKAO8ehSDDQ6S2v4SU5n2g/1zJTmoN6IXr2HjgfLTFwg1oxA4r5GkksZlnOsdsoV0JW7ElkIx77qW1Hvmz13oeqg5h96LWgxVfdmlSTEOyVvbMM7JWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734314255; c=relaxed/simple;
	bh=qhKwh3PIj1IPIEZGzZs/3km8En3UVpUizGUn0uCN11g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c7kMifIMPN5NMQvWfOVb6s1lmY7DFp54qZuoOAbKIDMjHU6Ex4MFOKKX5PRIWDpX87gfdMwVYXTSnRUvheU10hGtHq8ZZ8JXaDII5Vuvkw3o0BemNg1hxu/PMh1N2MRQwhxIWlvtj6cJz+0CxpoxuLubjloqsL+QaYZFPAMjjoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=TxL5dtrl; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-728e81257bfso2623627b3a.2
        for <stable@vger.kernel.org>; Sun, 15 Dec 2024 17:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734314253; x=1734919053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gm4kP5ZtpspMu3Kddf1CeW1Vs0wfn4Kb67Zu1TIf4DM=;
        b=TxL5dtrlQJwdaEReNgVPpJX9XzD8PGVF6B8ehcwRcUgmlOEhugxCIs5JqxvQ2YoKcl
         vrJ4exm7VcxtdYhn03dDfrZ7jSGAy3x546b5lxsVbdPga/9JVsYG/IOWLtEdUoWf971j
         qvA7CjIiXJ0JNPsGBncklVCBBkG+59KdCXGrEOFpWasQF2GGHQ6eSV2eJDdZw6ePG5J9
         Qn7tXAiDOi1dOBHD8eDXvffhradgNtBqacHidok5qwT+1LNEXGEa2gpZlcwuuLoc42OC
         TazypGVyymV9ltvPjJao4cwX+3BZLADmsTVgAJt06sfAxbq+KVTVAuSs8fDKVwVZ8EJf
         z4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734314253; x=1734919053;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gm4kP5ZtpspMu3Kddf1CeW1Vs0wfn4Kb67Zu1TIf4DM=;
        b=NEpLlx+Qw+T56H1li7LULVc4a6mEj7wWOpix/XdZCUwmR4h+ARzIVUTiXMM7T5qfpW
         3Phef76FK+4elYmcSomhePbsTwQRz1qlMOUScTr4DKsmBLQcWv9m9vwtg+aeUi1STI8W
         QT5Z+VTrl6wVEfkauQvjRnUQURFxLLKasQcNdiJSNdfwsCXG5rNGZF28WXRhm21avcdy
         Prpu5J0fYqeu7+IlfU4kVyxfmKCv1LqT+L+ePgqlPErkt9ts1n9K7RTVSQdUQXbP2eYm
         R2Sctw0nWWuot0NHOWioXU9/UWDNGGUeDgJrQqSbp9wpgzeWbnrda12iYYDXSF2H0AJv
         BE3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXahM+7NrxdYnFS7jpwiG8qErccJfhB9Hx4aCQJ52VkuP1atJkyyl8ISZvMRT+pbOszPaB9iqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsqYGaoGT28YaVivLURkOcWTFa8jiwFHI6Rk8hqZP48Qn4NLr3
	WDgUQeuuH2fvx/sa+XloFT7sEOVjUQcm2WS/0+meFUHULeWCwk+ggfaFUzfqPGs=
X-Gm-Gg: ASbGncsATAwD9QVzA2usJXFV5e+Hl9IVfxGw1htl2wFAriotIF358RQ/6LxtSYtfr0f
	ng9Hhxy+fCXRWDNm7ff5SXSDaFnnYymkti0fdl6elBfKUQ1zE1dMAWiUELo1nAWxZCsfAYO3Cz0
	U3ovPFEPLD9Kr7t6Y+Xz//VhnZMqJ3oHv1++Mmxe0LyCv/+okMnBt0njohEJZNpZAkmd+FGcB8i
	b/1OHsuZcf99lHm/l1ILGp0BJzJI90CM/lpcAVg2IZrST5vDJKmz/YsvQizV8qbx5ITbF8aV0Z2
	FZSfLm3hiuDquMADE8uLp51ajhOgfHdwOg==
X-Google-Smtp-Source: AGHT+IFBpSnCgBLl/f9/kZ1vy5+3BGTminuLI4aQdjneNm8IObmn/lVL65mFHvdlZbYUCY6woGxs5Q==
X-Received: by 2002:a05:6a20:734b:b0:1e0:d837:c929 with SMTP id adf61e73a8af0-1e1dfc1193emr17449538637.9.1734314253497;
        Sun, 15 Dec 2024 17:57:33 -0800 (PST)
Received: from [192.168.0.78] (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bc058bsm3569227b3a.175.2024.12.15.17.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 17:57:33 -0800 (PST)
Message-ID: <bfd4895e-16e4-42dd-a84f-e129b70aaff6@pf.is.s.u-tokyo.ac.jp>
Date: Mon, 16 Dec 2024 10:57:29 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: chipidea: ci_hdrc_imx: decrement device's refcount
 on the error path of .probe()
To: Peter Chen <peter.chen@kernel.org>
Cc: gregkh@linuxfoundation.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-usb@vger.kernel.org,
 stable@vger.kernel.org
References: <20241212094945.3784866-1-joe@pf.is.s.u-tokyo.ac.jp>
 <20241216012921.GA4105602@nchen-desktop>
Content-Language: en-US
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <20241216012921.GA4105602@nchen-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peter,

Thank you for your review.

On 12/16/24 10:29, Peter Chen wrote:
> On 24-12-12 18:49:45, Joe Hattori wrote:
>> Current implementation of ci_hdrc_imx_probe() does not decrement the
>> refcount of the device obtained in usbmisc_get_init_data(). Add a
>> put_device() call before returning an error after the call.
>>
>> This bug was found by an experimental static analysis tool that I am
>> developing.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: f40017e0f332 ("chipidea: usbmisc_imx: Add USB support for VF610 SoCs")
>> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
>> ---
>>   drivers/usb/chipidea/ci_hdrc_imx.c | 24 ++++++++++++++++--------
>>   1 file changed, 16 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
>> index f2801700be8e..6418052264f2 100644
>> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
>> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
>> @@ -370,25 +370,29 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>>   		data->pinctrl = devm_pinctrl_get(dev);
>>   		if (PTR_ERR(data->pinctrl) == -ENODEV)
>>   			data->pinctrl = NULL;
>> -		else if (IS_ERR(data->pinctrl))
>> -			return dev_err_probe(dev, PTR_ERR(data->pinctrl),
>> +		else if (IS_ERR(data->pinctrl)) {
>> +			ret = dev_err_probe(dev, PTR_ERR(data->pinctrl),
>>   					     "pinctrl get failed\n");
>> +			goto err_put;
>> +		}
>>   
>>   		data->hsic_pad_regulator =
>>   				devm_regulator_get_optional(dev, "hsic");
>>   		if (PTR_ERR(data->hsic_pad_regulator) == -ENODEV) {
>>   			/* no pad regulator is needed */
>>   			data->hsic_pad_regulator = NULL;
>> -		} else if (IS_ERR(data->hsic_pad_regulator))
>> -			return dev_err_probe(dev, PTR_ERR(data->hsic_pad_regulator),
>> +		} else if (IS_ERR(data->hsic_pad_regulator)) {
>> +			ret = dev_err_probe(dev, PTR_ERR(data->hsic_pad_regulator),
>>   					     "Get HSIC pad regulator error\n");
>> +			goto err_put;
>> +		}
>>   
>>   		if (data->hsic_pad_regulator) {
>>   			ret = regulator_enable(data->hsic_pad_regulator);
>>   			if (ret) {
>>   				dev_err(dev,
>>   					"Failed to enable HSIC pad regulator\n");
>> -				return ret;
>> +				goto err_put;
>>   			}
>>   		}
>>   	}
>> @@ -402,13 +406,14 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>>   			dev_err(dev,
>>   				"pinctrl_hsic_idle lookup failed, err=%ld\n",
>>   					PTR_ERR(pinctrl_hsic_idle));
>> -			return PTR_ERR(pinctrl_hsic_idle);
>> +			ret = PTR_ERR(pinctrl_hsic_idle);
>> +			goto err_put;
>>   		}
>>   
>>   		ret = pinctrl_select_state(data->pinctrl, pinctrl_hsic_idle);
>>   		if (ret) {
>>   			dev_err(dev, "hsic_idle select failed, err=%d\n", ret);
>> -			return ret;
>> +			goto err_put;
>>   		}
>>   
>>   		data->pinctrl_hsic_active = pinctrl_lookup_state(data->pinctrl,
>> @@ -417,7 +422,8 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>>   			dev_err(dev,
>>   				"pinctrl_hsic_active lookup failed, err=%ld\n",
>>   					PTR_ERR(data->pinctrl_hsic_active));
>> -			return PTR_ERR(data->pinctrl_hsic_active);
>> +			ret = PTR_ERR(data->pinctrl_hsic_active);
>> +			goto err_put;
>>   		}
>>   	}
>>   
>> @@ -527,6 +533,8 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>>   	if (pdata.flags & CI_HDRC_PMQOS)
>>   		cpu_latency_qos_remove_request(&data->pm_qos_req);
>>   	data->ci_pdev = NULL;
>> +err_put:
>> +	put_device(data->usbmisc_data->dev);
>>   	return ret;
>>   }
>>   
> 
> Thanks for your fix, would you mind also add put_device at the end of
> ci_hdrc_imx_remove?

Thank you for pointing out. Fixed in the v2 patch.
> 
> Peter

Best,
joe

