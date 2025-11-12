Return-Path: <stable+bounces-194626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BCEC530CA
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 16:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8AD76349010
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 15:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632D933B6D8;
	Wed, 12 Nov 2025 15:16:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B2B339709;
	Wed, 12 Nov 2025 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960574; cv=none; b=XxelbmVY7YjtOEgwEHLoDCslVFrRY8zYrclo/kfqlmPs4NYqdubzVnSPkcSLplCGQBfvx+NwswsMUfwigs/7YlAXhqgk13xgvZB81qCJGOepI700CNT6v9C3laBCei166M0Ph/kS1upRr/cjdamgkTsAxTIWbc8p9asvq7ldZsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960574; c=relaxed/simple;
	bh=VjzI/xAoKXIBnhn0+6eOVbyFBTg4EM/5WUtL/krrwOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SGVjr0JFYUhvvlIdCl2rlPE9kcTFHHHdvYFY9jw2xyFtnDNtAg/RTGPLhBuBSiViq8ku9S+amIQfgWNcygyEJmd0mXPmVbej3L8we8I7VXWjKQ7ug+9SvVAKiV62ucmLAkLgH5IOG3ltyimSXkJ/QIVDoBD+wZwrwu/foOfWxzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 100A01515;
	Wed, 12 Nov 2025 07:16:03 -0800 (PST)
Received: from [10.1.196.87] (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34D2D3F66E;
	Wed, 12 Nov 2025 07:16:09 -0800 (PST)
Message-ID: <197141a4-bbfc-40df-8860-1291b810f676@arm.com>
Date: Wed, 12 Nov 2025 15:15:34 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] coresight: etm-perf: Fix reference count leak in
 etm_setup_aux
To: Ma Ke <make24@iscas.ac.cn>, suzuki.poulose@arm.com,
 mike.leach@linaro.org, james.clark@linaro.org,
 alexander.shishkin@linux.intel.com, mathieu.poirier@linaro.org
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 stable@vger.kernel.org
References: <20251112012405.11731-1-make24@iscas.ac.cn>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20251112012405.11731-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/25 01:24, Ma Ke wrote:

> @@ -454,6 +454,11 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>  		goto err;
>  
>  out:
> +	if (user_sink) {
> +		put_device(&user_sink->dev);
> +		user_sink = NULL;
> +	}

After searched kernel, I prefer to put device in coresight_get_sink_by_id().
Please refer acpi_dev_present() how to do that.

I would like Suzuki's confirmation in case I introduce noise.

Thanks,
Leo  

