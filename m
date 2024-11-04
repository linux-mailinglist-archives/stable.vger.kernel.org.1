Return-Path: <stable+bounces-89703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FF69BB692
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 14:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0FD11F23466
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 13:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49626A33B;
	Mon,  4 Nov 2024 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RZieaUKH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038918BEE
	for <stable@vger.kernel.org>; Mon,  4 Nov 2024 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727817; cv=none; b=rLvr1KLSXwmWs9qTMeHaXwGhOOubZI1e7NAl6cvSst6+ESFezrzko0DLmscrTVn8Tv4WYBXe7kJgal+Eq1M72qB0s5Ny6GzoQWEyatkF5JkzByqw2+kCd0yUr6xD2ENg7m35rhyJAo5hwujfw94t1JQZ4IxAn3keV0kVgCzfA9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727817; c=relaxed/simple;
	bh=4nsxE0zJBnfMaOT5zdVUiPyRYA3ahACMLCgNgO/61dE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lgj3fYO66ifcIHRUhmtZ+a4E0DiY6Qnqm0XqJA3vvWNYfYvXVTgK345WrhxJf0i0OxPgNwVFXTPoJ2f8Nie/xSaIw+Sx7kCwqCpv1znQx1wM5QZVYdGJGNIawi38VGeQ0FsctOh3r8RbACxJUjszNilg7iO4Xavw3kXJk0+IA+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RZieaUKH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so37346045e9.1
        for <stable@vger.kernel.org>; Mon, 04 Nov 2024 05:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730727814; x=1731332614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NNjkltu1YzUC3aRdfVm7mD8mGte+fZLAnIacrLlFn+g=;
        b=RZieaUKHmlTHCycAIAm/G5fCEyemiczTkfDF23xsE8mrEzhh9yyrzuWwtdpz/LkVh8
         W8DWyw8vGJI2mkXps4dXiiBcIDMCdmq3egj+FT1ga4HqgoASmq4GNs22CwfXVaNl+Fs6
         LHd04fkv5SJ22itdSv3cm0kfUJrF2+sivwiFlEO85de3OO+ympEgZBiFRzwqqMF1dAhf
         k9Z46dMe08ZP3caNg8NzHur8Oh2ObwWWg5DJ2p5h78E2vjoMcaMofxcsX/oF9tZDemds
         tfKcyYsgwLTEnU0agrNcQU35yWh5d0FiBiuJGeZHgqRjLERAftqfYNpPPhTGemo6AZsZ
         6IlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730727814; x=1731332614;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NNjkltu1YzUC3aRdfVm7mD8mGte+fZLAnIacrLlFn+g=;
        b=FhkHqKwRKQ3Q4uEnR/DlBE85h4Tsnr/m4zvzyv2z6ts4QBzZP6N++RIG0RNoGOWs6Q
         MERJf4vYTFEMi+6WxMw9UTPuKprIhC6/RwJ13aQaaGmujSxGVCrArWrB26glgemI/5Oc
         Ly77b6t1DZjpjMTTLXRwp8fykUOlfw6ky2FQVK68KLm1t5iBdMjdBaKHfadl39XzRoZH
         GvJcdQW+M/IVa+Tmy1H6yRuA4/FUbXIRphwHe9m1OBuJmV1+OPEB2JUNqJAqTlDymYrz
         KCkh1F0FwDhTWM3sar2aENJ/veSd19F3cY4ifUHVzdK4HH9c2Sw5CfttDqkFr4pbKpcf
         XaNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYMNxXO+zcDiBemCwMb9euJPzKgcGXmXf32VAG2TNbG2jFMOPyPgK+uIUWsPfWz08ghQKsLa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmAlAl8AzQxlh/fBOhHaQfEHGrB+MBEJIBHp4JOhSg4l6x3cde
	FalCShSn2WRIhfhdGUXCvGwkt3n28gAm/l6T2Cr1FCUlSUQBE8sfb3n58Es3iUs=
X-Google-Smtp-Source: AGHT+IEed2JitaHA4d9lMoLwcdDd2R7X2lHOruaIu+gEcl2mSwdKfmp3De+9Vn93SoLYA8x9eAsCSw==
X-Received: by 2002:a05:600c:4f8a:b0:431:51e5:2316 with SMTP id 5b1f17b1804b1-4327b822402mr132269895e9.34.1730727814373;
        Mon, 04 Nov 2024 05:43:34 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5b00:c640:4c96:8a97? ([2a01:e0a:982:cbb0:5b00:c640:4c96:8a97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d6848b5sm153584445e9.32.2024.11.04.05.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 05:43:33 -0800 (PST)
Message-ID: <5a08460d-6907-41ad-b520-b191429a6eef@linaro.org>
Date: Mon, 4 Nov 2024 14:43:31 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] scsi: ufs: Start the RTC update work later
To: Bart Van Assche <bvanassche@acm.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, Bean Huo <beanhuo@micron.com>,
 stable@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Peter Wang <peter.wang@mediatek.com>, Avri Altman <avri.altman@wdc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Maramaina Naresh <quic_mnaresh@quicinc.com>, Mike Bi <mikebi@micron.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Luca Porzio <lporzio@micron.com>
References: <20241031212632.2799127-1-bvanassche@acm.org>
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
In-Reply-To: <20241031212632.2799127-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/10/2024 22:26, Bart Van Assche wrote:
> The RTC update work involves runtime resuming the UFS controller. Hence,
> only start the RTC update work after runtime power management in the UFS
> driver has been fully initialized. This patch fixes the following kernel
> crash:
> 
> Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
> Workqueue: events ufshcd_rtc_work
> Call trace:
>   _raw_spin_lock_irqsave+0x34/0x8c (P)
>   pm_runtime_get_if_active+0x24/0x9c (L)
>   pm_runtime_get_if_active+0x24/0x9c
>   ufshcd_rtc_work+0x138/0x1b4
>   process_one_work+0x148/0x288
>   worker_thread+0x2cc/0x3d4
>   kthread+0x110/0x114
>   ret_from_fork+0x10/0x20
> 
> Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
> Closes: https://lore.kernel.org/linux-scsi/0c0bc528-fdc2-4106-bc99-f23ae377f6f5@linaro.org/
> Fixes: 6bf999e0eb41 ("scsi: ufs: core: Add UFS RTC support")
> Cc: Bean Huo <beanhuo@micron.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/ufs/core/ufshcd.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 585557eaa9a2..ed82ff329314 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -8633,6 +8633,14 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
>   		ufshcd_init_clk_scaling_sysfs(hba);
>   	}
>   
> +	/*
> +	 * The RTC update code accesses the hba->ufs_device_wlun->sdev_gendev
> +	 * pointer and hence must only be started after the WLUN pointer has
> +	 * been initialized by ufshcd_scsi_add_wlus().
> +	 */
> +	schedule_delayed_work(&hba->ufs_rtc_update_work,
> +			      msecs_to_jiffies(UFS_RTC_UPDATE_INTERVAL_MS));
> +
>   	ufs_bsg_probe(hba);
>   	scsi_scan_host(hba->host);
>   
> @@ -8727,8 +8735,6 @@ static int ufshcd_post_device_init(struct ufs_hba *hba)
>   	ufshcd_force_reset_auto_bkops(hba);
>   
>   	ufshcd_set_timestamp_attr(hba);
> -	schedule_delayed_work(&hba->ufs_rtc_update_work,
> -			      msecs_to_jiffies(UFS_RTC_UPDATE_INTERVAL_MS));
>   
>   	if (!hba->max_pwr_info.is_valid)
>   		return 0;

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK

Thanks!
Neil

