Return-Path: <stable+bounces-40376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CE58ACE20
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 15:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63035282311
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 13:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B6614F9EE;
	Mon, 22 Apr 2024 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ch0AApT9"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF5714F13F
	for <stable@vger.kernel.org>; Mon, 22 Apr 2024 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792364; cv=none; b=VMGpoxRkzTALOWL4OxfUt1Ynvu9Pen0ju+6ODCqiV2wR9b8kP7uwIF2jXaovacuCWD5LkFAEO4+CwfBRxkTcgXMLkXwvEk8DEivEumLsWEowQYCb3JZENut8g90F5QB5EUaq/ENtrknRGXOrbegcskMxzHKc1Zu6vDvZzfTvJdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792364; c=relaxed/simple;
	bh=zzX5eE4yMUDKe0LvVLzQNY6kTp+yzD1J3zOF3ag/LAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ni7q3iAGBKReWZKYMKY4u2/h5DVRoDYSTA71ilxxfgbJj1EYLZf+F4sdr3MDjWEYZsWMyJ7PtCmuSsKEsFPwA5OCJcI16AF0wY1Vf6U3huv/6x+vs7x0bgQrBzZhc/MvhJMOgjEtKYGeUxoIT/yj0rCyiEmawvGViL+vPlxcO6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ch0AApT9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713792360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ol/2RA90vNCMdV3wT9xM2JZGkm3yoQFPbLwEAxBwTSc=;
	b=ch0AApT91ZX8faBkSPrP/+d5UoVZ/hBzb4P7fhFYaxVTtu+PmCZWebYrwrjIAiOd6ggjyQ
	Sg6WmyMsMhPsPo5I4BySJy/ztlxUnFbqufpZi4sNLpGoMIhODtct0BVYbMipJkF0WPETH1
	nAIsus3c0Nt8wIcvmy0Xg0hMV/HvNcc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-9DHiWZ9rPT2RYYlGcCsO0w-1; Mon, 22 Apr 2024 09:25:56 -0400
X-MC-Unique: 9DHiWZ9rPT2RYYlGcCsO0w-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a52233a228aso261747766b.1
        for <stable@vger.kernel.org>; Mon, 22 Apr 2024 06:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713792355; x=1714397155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ol/2RA90vNCMdV3wT9xM2JZGkm3yoQFPbLwEAxBwTSc=;
        b=S69GoumAAF7j8+S2BflMfTaNqe5BUmnTpO2tRDrEx9/ainQjAsbnQebrh4AUAyBL1O
         m/qeOJBS4pcKSqdP66GyqkAGif5yvwzla3kccIje9a5mJKSZ08eU9yrDLMavZeFb7aK/
         GVPQ4Gwi4uM8QM3MBp2kRvuKdECA1/sSsMIWPq5+eN/5Hm/ZKIvgtwJFd0F0UrbQsL+4
         SlsFJs16+B8z0BkbZgFv2TFf82HfWIOfBScdEDpz+Xb9f9ptBe2bXKAPBpJXOwQldeoY
         HL2vHSFMjpGQj1ev/XlMXov1k16ZNY6IdZJB7HdqOqaM+duVtMI9gXlKx2EHVUsa/EFZ
         Y2mA==
X-Forwarded-Encrypted: i=1; AJvYcCXVJXjI0my0kPRPfGSCjg0TfYA+cUPCnaKMo5nrJ730+WcSPAr6QATOz3dLz16O42gwdfOj1yCyT4ZSXxA4pcTVDvKNuS67
X-Gm-Message-State: AOJu0YywmQOM39E2FOjEAeAVp+du31H/ZLRAIBYB0aw3hZbOwNBy6fMh
	ugKfBuYIGLRO6Ihsy2huH+uyDH4kEsa6zinHBMGiB6iFn8C1wJEkwzXAue1V0FdO5dJRdpICsLX
	gOlbLnK8pbWhoF/emX0rdciH92HPXbIh7+ju9ImzWrmn0X1GJXyV5oC6EKaHejsqW
X-Received: by 2002:a17:906:fe0b:b0:a55:ab92:8baa with SMTP id wy11-20020a170906fe0b00b00a55ab928baamr4660377ejb.9.1713792355113;
        Mon, 22 Apr 2024 06:25:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFizyCClaD48IQHzVKa86p3t7HomFbWXivDIP/CjLWOxs68n/orswhkEk93S6EN8g/eJimpuQ==
X-Received: by 2002:a17:906:fe0b:b0:a55:ab92:8baa with SMTP id wy11-20020a170906fe0b00b00a55ab928baamr4660363ejb.9.1713792354738;
        Mon, 22 Apr 2024 06:25:54 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id x20-20020a1709060a5400b00a524b2ffed6sm5761118ejf.56.2024.04.22.06.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 06:25:54 -0700 (PDT)
Message-ID: <12ef6031-35e1-4d48-9771-8c431f7abe33@redhat.com>
Date: Mon, 22 Apr 2024 15:25:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/intel-uncore-freq: Don't present root domain
 on error
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240415215210.2824868-1-srinivas.pandruvada@linux.intel.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240415215210.2824868-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/15/24 11:52 PM, Srinivas Pandruvada wrote:
> If none of the clusters are added because of some error, fail to load
> driver without presenting root domain. In this case root domain will
> present invalid data.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Fixes: 01c10f88c9b7 ("platform/x86/intel-uncore-freq: tpmi: Provide cluster level control")
> Cc: <stable@vger.kernel.org> # 6.5+
> ---
> This error can be reproduced in the pre production hardware only.
> So can go through regular cycle and they apply to stable.

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> 
>  .../x86/intel/uncore-frequency/uncore-frequency-tpmi.c     | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
> index bd75d61ff8a6..587437211d72 100644
> --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
> +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
> @@ -240,6 +240,7 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
>  	bool read_blocked = 0, write_blocked = 0;
>  	struct intel_tpmi_plat_info *plat_info;
>  	struct tpmi_uncore_struct *tpmi_uncore;
> +	bool uncore_sysfs_added = false;
>  	int ret, i, pkg = 0;
>  	int num_resources;
>  
> @@ -384,9 +385,15 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
>  			}
>  			/* Point to next cluster offset */
>  			cluster_offset >>= UNCORE_MAX_CLUSTER_PER_DOMAIN;
> +			uncore_sysfs_added = true;
>  		}
>  	}
>  
> +	if (!uncore_sysfs_added) {
> +		ret = -ENODEV;
> +		goto remove_clusters;
> +	}
> +
>  	auxiliary_set_drvdata(auxdev, tpmi_uncore);
>  
>  	tpmi_uncore->root_cluster.root_domain = true;


