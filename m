Return-Path: <stable+bounces-132215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF52AA856B3
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 10:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE814E0948
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 08:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D02E298CD5;
	Fri, 11 Apr 2025 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VaFdFzqt"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6331FBE8B
	for <stable@vger.kernel.org>; Fri, 11 Apr 2025 08:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744360495; cv=none; b=NMfFLi3t0dikanC2YJ57f3snMG4lFlARDZVvow3HeD2GDJrUKVslVv/ylPi/eHrb1DkAlOsOM96gDeZH0s794aB16XyYd4XYWV8BEBIp2if1T87IkUToojfzGhs6/+LAmz4U0ALSmyH9Q73SGTszO2pZnFbVlI8tTQGMt5q8pbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744360495; c=relaxed/simple;
	bh=SxEOvlRNSCwnamHv37LnY13ONkLeA0bnVhGqy2H0MVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hUabQVCUWyWzlp67hHXwqye4pABJfwkKUoumimLV7D5szjwHbHwRjWxF+AIKWhkn0O3HNtFdO/RH+eT+53aFa2IWV6BBvb1jYrT4W9RWM8cGyYxBOeRhZx3QUCIgS+0IpNsYJjGl0+XPOUwXAVf9uKj76HNDbEaoeAZgxPWMtPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VaFdFzqt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744360491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPEB9IovulTp9jemDnCHGCaMReQM8u/sCUs3hKREk5w=;
	b=VaFdFzqtW+VQNyErGaG4tf3hIm4IUs266qe4BLF1Ci45YvMWUSd2vZEp2TdrCP5BFyU5eh
	K6g0FHjz4GslR2xBI84yz/YmdooSlwkoJhXIX7Qj+rE7MHt8wOwKVHwfDveB4XDJ/nqnnY
	V8KWadfgtsH8qH1MnBY2KL2DqKU8jDM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-Rp2c0Qo9O1q74v5YI29U5A-1; Fri, 11 Apr 2025 04:34:49 -0400
X-MC-Unique: Rp2c0Qo9O1q74v5YI29U5A-1
X-Mimecast-MFC-AGG-ID: Rp2c0Qo9O1q74v5YI29U5A_1744360488
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac2bb3ac7edso179975766b.2
        for <stable@vger.kernel.org>; Fri, 11 Apr 2025 01:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744360488; x=1744965288;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hPEB9IovulTp9jemDnCHGCaMReQM8u/sCUs3hKREk5w=;
        b=U9EaxSDP4BrbILaOkv5XUtOBuxPy8DZcOOAGHsq+miraSgyZlN8DLPxiA9AadMFdam
         5vD3/2ZPk7Dvwxit2zL/5h+8hzPq3pLXFirdl9zLDbAZbrUVwAaPFa8dJR4viDLvZgq4
         T8g8DMTXdlEgAYTVymngl1aY+aWnBu6tkNxudj7VeCk4zJhjyACSOjxHCNl0I98pvMhT
         3k4/3mIAYGNHxdyhkbfpLs/vm981OtuEcvv01Ka82Pv9LCHrA/lLjEx4R1T+U9MkHXA1
         93yVSl95KtLKe/3fb957mgLa7wcTBbZ7/gpT7uqagU28BrBayjjwHI1LWWVxehj0lcPf
         kt8w==
X-Gm-Message-State: AOJu0YxnSHK+YNXaLYhhcr46QkpwfKx8M/v4XSxS2LdrCdw3ejKnGHaH
	ZQFuEWyxXKrkl+cKnDf89Z03kKNqvac2JESkNlrq5PoGz/L2Y48FkpEgGXsjh5aWzCBAA0lQX2j
	bR15e713K213oP/ZycgB14NcTlia1sZBCJYj1Ctnf1UyfHlLf1btiWQ==
X-Gm-Gg: ASbGncs1ofTyPj2rMpGbDJfhSSkdSxnpogVGWUFNP7xcWErgksmcQ1Yrd65fq0Uui8F
	/m0NrIKEeZNrZIc7qWgNLkebZHEhrlryIclaM9m/+iimhawyhb8gdBKhlmB4prDcjSbz9Z1lfvI
	qZy/+tvri9upUY4L5SVlMkwad+iTt29VcoecuNr0+IfjKE0jt4VwARcxIr5L4B41Rfo6v4YgMiY
	Lq3bzMEkqQUfoH66wX+8T8CQZGOH/jcXWpZgHg4d/dya4Rqg06zh7w0iss5CcxAsloamXnGyYh+
	RE9EHe8H5KjigMgmJmpd/KVv57nFo87H5nz/AYWykZTfxW/4sdU1KN8sQFAmolsJcL2MRsbaurm
	S66gTV8DdMFRe9V05IV0hsOA33odBF52brsm1dcl2PkEnaZnIhHth5hyKtJ02Sg==
X-Received: by 2002:a17:907:7f07:b0:ac1:e53c:d13f with SMTP id a640c23a62f3a-acad36d7d8fmr150816666b.50.1744360488162;
        Fri, 11 Apr 2025 01:34:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6pWWSi4ZddLNGE8X9DxVLsJsPyLfarGqt4dAhpX0DvdFBYFdRGsy0qsVpjpPb+WaJjDXMjA==
X-Received: by 2002:a17:907:7f07:b0:ac1:e53c:d13f with SMTP id a640c23a62f3a-acad36d7d8fmr150814266b.50.1744360487788;
        Fri, 11 Apr 2025 01:34:47 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1cb4110sm411444066b.91.2025.04.11.01.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 01:34:47 -0700 (PDT)
Message-ID: <3fd83bea-abd2-4d2c-b39e-20d3eb981a99@redhat.com>
Date: Fri, 11 Apr 2025 10:34:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] media: i2c: change lt6911uxe irq_gpio name to
 "hpd"
To: Dongcheng Yan <dongcheng.yan@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, sakari.ailus@linux.intel.com,
 hverkuil@xs4all.nl, andriy.shevchenko@linux.intel.com,
 u.kleine-koenig@baylibre.com, ricardo.ribalda@gmail.com,
 bingbu.cao@linux.intel.com
Cc: stable@vger.kernel.org, dongcheng.yan@linux.intel.com, hao.yao@intel.com
References: <20250411082357.392713-1-dongcheng.yan@intel.com>
 <20250411082357.392713-2-dongcheng.yan@intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250411082357.392713-2-dongcheng.yan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11-Apr-25 10:23 AM, Dongcheng Yan wrote:
> lt6911uxe is used in IPU6 / x86 platform, worked with an out-of-tree
> int3472 patch and upstream intel/ipu6 before.
> The upstream int3472 driver uses "hpd" instead of "readystat" now.
> this patch updates the irq_gpio name to "hpd" accordingly, so that
> mere users can now use the upstream version directly without relying
> on out-of-tree int3472 pin support.
> 
> The new name "hpd" (Hotplug Detect) aligns with common naming
> conventions used in other drivers(like adv7604) and documentation.
> 
> Fixes: e49563c3be09d4 ("media: i2c: add lt6911uxe hdmi bridge driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dongcheng Yan <dongcheng.yan@intel.com>

The commit message needs an extra sentence to explain that this change
is ok to make since at the moment this driver is only used on ACPI
platforms which will use the new "hpd" name and there are no devicetree
bindings for this driver.

Regards,

Hans



> ---
>  drivers/media/i2c/lt6911uxe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/i2c/lt6911uxe.c b/drivers/media/i2c/lt6911uxe.c
> index c5b40bb58a37..24857d683fcf 100644
> --- a/drivers/media/i2c/lt6911uxe.c
> +++ b/drivers/media/i2c/lt6911uxe.c
> @@ -605,10 +605,10 @@ static int lt6911uxe_probe(struct i2c_client *client)
>  		return dev_err_probe(dev, PTR_ERR(lt6911uxe->reset_gpio),
>  				     "failed to get reset gpio\n");
>  
> -	lt6911uxe->irq_gpio = devm_gpiod_get(dev, "readystat", GPIOD_IN);
> +	lt6911uxe->irq_gpio = devm_gpiod_get(dev, "hpd", GPIOD_IN);
>  	if (IS_ERR(lt6911uxe->irq_gpio))
>  		return dev_err_probe(dev, PTR_ERR(lt6911uxe->irq_gpio),
> -				     "failed to get ready_stat gpio\n");
> +				     "failed to get hpd gpio\n");
>  
>  	ret = lt6911uxe_fwnode_parse(lt6911uxe, dev);
>  	if (ret)


