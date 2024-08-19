Return-Path: <stable+bounces-69477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B5B956694
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF37C2866E6
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F1015CD42;
	Mon, 19 Aug 2024 09:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ivqGWG3R"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B482615B992
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058981; cv=none; b=Rcl04V4bhAYCEh4YQ60AJnarPdmpC/DyzQ/a5ZH2yb/LEE4zJ3lWxEryubyPuqNL22uynGCLCsmBGM4AXLJDAY/WDzI9xkrrlVdgspWkNlEsy9/yKeg05ENKGCKbU0I/dwkDpgsrHGzXGHgMkl5AB3ppReci2fIaulrE8GEfTmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058981; c=relaxed/simple;
	bh=/SJ6cDUryQNt2iMgIu4z5n5nPQDPmfv1hvOf3hfHiaU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=k/mtRrxxywaGiBsxwXRYwlaR4wSU4Z10jXm+skmCmAiNdbYFCM18+5hKtpaShoNhr5Ih90+vY6yKbTRsedJKIBMK41CpEz/hF5YMGKf1H7SF2KjAChbJVWPLRgig9Vw/3ULbdmVYz/cCy4QBMqBpsWROX8WxjIsj02R9MJXlXtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ivqGWG3R; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3718c176ed7so1819474f8f.2
        for <stable@vger.kernel.org>; Mon, 19 Aug 2024 02:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724058978; x=1724663778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pvl2PaSBcQgUbQ4OytRwa2UWEGEQRSF+ak+EtVFPL7s=;
        b=ivqGWG3Ri4DBnPfY8K8M1kDbdOFD6dl0bx9hWXKt4PHxhx8T00mwGV6eXbZfhVd4zQ
         shca4FKrdd168+7q39tSdZJ411F3WU6Mq08ICG2jZqHnCvmDl4Vv8ln+e4EaM9jx7EU9
         DJPyc2vBmP1RkWsdevuRRt1o1du1EnUNWU1M0VK97ismEIIVn8W7bMvs3QRsGAdYDHZ1
         ERWE53MX6NoMGm+NZOHZineJqfRjW2jEmrwMPMC40VvZteMnmSYSHKS/ZjCkTETXAer7
         xfnVRBJt/zSzbyN+dNKmXp+0/++gbT5FhcfNVeoRHDVtG76TOhhf48POpMMLrP6MtivE
         vBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724058978; x=1724663778;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pvl2PaSBcQgUbQ4OytRwa2UWEGEQRSF+ak+EtVFPL7s=;
        b=Da5RhvnRD5xlywsFWz4DPfBLenyWv9a1tdMURhcGomW6y+r5CX+LwFWZgXrTp3RU+e
         iTUvFyDV8bbvuSqmWea+K+u/zcTtIuxxxY9mHIjUIlbQF8bARv9mwYRLZXDYdpZUmCZl
         g2YHO8oHdcsxMOl2z2aRG5C2Jjd380dWSiVdd/YafkIU10GwBrUGSjbJfySpCyco6U/v
         uy6lrb7NamTvmIRKDSRE2hu6mweQCgYBgE+pSwcFeXjpq/YtGUS1J8pNi5nbE/r0Q79S
         6tI9hbPD9bFT+t+sh4swtaDs/b0W5RNrHhAkkyLQZ8pN05lbGTfUcNjIjfbFe1DN67hu
         3pAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQcL2hdK6KdTgyc7ygJxt0dHGZhOW+ylbtpXokkD97F55AxjZOvyDXnpxyetmj1FRgSwjQ5gPRHhnA6cCJlwSc4DnWGbjC
X-Gm-Message-State: AOJu0YxdAqadO9NFE7k93bHhrj+AqAGeLxfnsWsj+5IY4rhBm4KgRWdx
	fNKtSvNKdlbpPn/IDfMpi0DyDqjlSmOpNAvFSHGPFoviNe+vCXnBeSU0GyqeXpw=
X-Google-Smtp-Source: AGHT+IH9DRRUk43mndDIg0iz3Wbhu0iUr82wYHn15KerrEyOl0OYQJpN0f/P/FFzmBsSLLHR/KSclg==
X-Received: by 2002:adf:eec8:0:b0:367:9d05:cf1f with SMTP id ffacd0b85a97d-37194327f7fmr5971930f8f.14.1724058977604;
        Mon, 19 Aug 2024 02:16:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f54e:4b0a:5175:5727? ([2a01:e0a:982:cbb0:f54e:4b0a:5175:5727])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718985a347sm10025259f8f.60.2024.08.19.02.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 02:16:17 -0700 (PDT)
Message-ID: <b11d65db-d691-4f5d-b41a-db5b29a8ae01@linaro.org>
Date: Mon, 19 Aug 2024 11:16:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/3] usb: typec: ucsi: Move unregister out of atomic
 section
To: Bjorn Andersson <quic_bjorande@quicinc.com>,
 Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Chris Lew
 <quic_clew@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Stephen Boyd <swboyd@chromium.org>, Amit Pundir <amit.pundir@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 stable@vger.kernel.org
References: <20240818-pmic-glink-v6-11-races-v1-0-f87c577e0bc9@quicinc.com>
 <20240818-pmic-glink-v6-11-races-v1-2-f87c577e0bc9@quicinc.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20240818-pmic-glink-v6-11-races-v1-2-f87c577e0bc9@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/08/2024 01:17, Bjorn Andersson wrote:
> Commit 'caa855189104 ("soc: qcom: pmic_glink: Fix race during
> initialization")' moved the pmic_glink client list under a spinlock, as
> it is accessed by the rpmsg/glink callback, which in turn is invoked
> from IRQ context.
> 
> This means that ucsi_unregister() is now called from IRQ context, which
> isn't feasible as it's expecting a sleepable context. An effort is under
> way to get GLINK to invoke its callbacks in a sleepable context, but
> until then lets schedule the unregistration.
> 
> A side effect of this is that ucsi_unregister() can now happen
> after the remote processor, and thereby the communication link with it, is
> gone. pmic_glink_send() is amended with a check to avoid the resulting
> NULL pointer dereference, but it becomes expecting to see a failing send
> upon shutting down the remote processor (e.g. during a restart following
> a firmware crash):
> 
>    ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: failed to send UCSI write request: -5
> 
> Fixes: caa855189104 ("soc: qcom: pmic_glink: Fix race during initialization")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>   drivers/soc/qcom/pmic_glink.c       | 10 +++++++++-
>   drivers/usb/typec/ucsi/ucsi_glink.c | 28 +++++++++++++++++++++++-----
>   2 files changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
> index 58ec91767d79..e4747f1d3da5 100644
> --- a/drivers/soc/qcom/pmic_glink.c
> +++ b/drivers/soc/qcom/pmic_glink.c
> @@ -112,8 +112,16 @@ EXPORT_SYMBOL_GPL(pmic_glink_register_client);
>   int pmic_glink_send(struct pmic_glink_client *client, void *data, size_t len)
>   {
>   	struct pmic_glink *pg = client->pg;
> +	int ret;
>   
> -	return rpmsg_send(pg->ept, data, len);
> +	mutex_lock(&pg->state_lock);
> +	if (!pg->ept)
> +		ret = -ECONNRESET;
> +	else
> +		ret = rpmsg_send(pg->ept, data, len);
> +	mutex_unlock(&pg->state_lock);
> +
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(pmic_glink_send);
>   
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index ac53a81c2a81..a33056eec83d 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -68,6 +68,9 @@ struct pmic_glink_ucsi {
>   
>   	struct work_struct notify_work;
>   	struct work_struct register_work;
> +	spinlock_t state_lock;
> +	unsigned int pdr_state;
> +	unsigned int new_pdr_state;
>   
>   	u8 read_buf[UCSI_BUF_SIZE];
>   };
> @@ -244,8 +247,22 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
>   static void pmic_glink_ucsi_register(struct work_struct *work)
>   {
>   	struct pmic_glink_ucsi *ucsi = container_of(work, struct pmic_glink_ucsi, register_work);
> +	unsigned long flags;
> +	unsigned int new_state;
> +
> +	spin_lock_irqsave(&ucsi->state_lock, flags);
> +	new_state = ucsi->new_pdr_state;
> +	spin_unlock_irqrestore(&ucsi->state_lock, flags);
> +
> +	if (ucsi->pdr_state != SERVREG_SERVICE_STATE_UP) {
> +		if (new_state == SERVREG_SERVICE_STATE_UP)
> +			ucsi_register(ucsi->ucsi);
> +	} else {
> +		if (new_state == SERVREG_SERVICE_STATE_DOWN)
> +			ucsi_unregister(ucsi->ucsi);
> +	}
>   
> -	ucsi_register(ucsi->ucsi);
> +	ucsi->pdr_state = new_state;
>   }
>   
>   static void pmic_glink_ucsi_callback(const void *data, size_t len, void *priv)
> @@ -269,11 +286,12 @@ static void pmic_glink_ucsi_callback(const void *data, size_t len, void *priv)
>   static void pmic_glink_ucsi_pdr_notify(void *priv, int state)
>   {
>   	struct pmic_glink_ucsi *ucsi = priv;
> +	unsigned long flags;
>   
> -	if (state == SERVREG_SERVICE_STATE_UP)
> -		schedule_work(&ucsi->register_work);
> -	else if (state == SERVREG_SERVICE_STATE_DOWN)
> -		ucsi_unregister(ucsi->ucsi);
> +	spin_lock_irqsave(&ucsi->state_lock, flags);
> +	ucsi->new_pdr_state = state;
> +	spin_unlock_irqrestore(&ucsi->state_lock, flags);
> +	schedule_work(&ucsi->register_work);
>   }
>   
>   static void pmic_glink_ucsi_destroy(void *data)
> 

Looks good, I'll run it on the 8550/8650 platforms

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

