Return-Path: <stable+bounces-86801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7929A3A2F
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 11:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04EFB1C23A04
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 09:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1295D1E1C2C;
	Fri, 18 Oct 2024 09:39:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F76179965;
	Fri, 18 Oct 2024 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729244365; cv=none; b=nuSKiI6ETXx66ljkbpRf7PZgESWpaMzlPvgqGDH/OjQdebT+GQiFx4SQzSgqhfYDObhNXDRM3lG58Clc8jT+nguJoqAu0HhK+vJqNGFbLh7zNUNcdOMKkCbkhZk6JDeXbb/0PB5giBsM0refPeItZGXM70MOeMVbqYjbkEU+6p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729244365; c=relaxed/simple;
	bh=4VpjvciPKCyIBPuGr0O2yTsp1zf+Y6OpaD0A4XO/8jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ky/GB8oP8SLunHqDK8YC3BwfYShb4EnGo5kKivy55CQRu/A3aXK9da/Rp+E8/QfmabG8hO+CqjdimHvsHvRaPXVqbKjnc2rJZlZ6MaSpnKGRyeD/55KVZyrnHTaPBD94ZFCZ8irfhLeiX8lD6LcBXC3xAre6a3SijHvt/zCSNLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF260FEC;
	Fri, 18 Oct 2024 02:39:52 -0700 (PDT)
Received: from [10.57.22.188] (unknown [10.57.22.188])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 45FE93F58B;
	Fri, 18 Oct 2024 02:39:21 -0700 (PDT)
Message-ID: <026951f9-05af-4ee4-85d2-30236292f7f8@arm.com>
Date: Fri, 18 Oct 2024 10:39:20 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amba: Fix atomicity violation in amba_match()
Content-Language: en-GB
To: Qiu-ji Chen <chenqiuji666@gmail.com>, linux@armlinux.org.uk,
 rmk+kernel@armlinux.org.uk, sumit.garg@linaro.org,
 gregkh@linuxfoundation.org, andi.shyti@kernel.org, krzk@kernel.org
Cc: linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
 stable@vger.kernel.org
References: <20241018081539.1358921-1-chenqiuji666@gmail.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20241018081539.1358921-1-chenqiuji666@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/10/2024 09:15, Qiu-ji Chen wrote:
> Atomicity violation occurs during consecutive reads of
> pcdev->driver_override. Consider a scenario: after pvdev->driver_override
> passes the if statement, due to possible concurrency,
> pvdev->driver_override may change. This leads to pvdev->driver_override
> passing the condition with an old value, but entering the
> return !strcmp(pcdev->driver_override, drv->name); statement with a new
> value. This causes the function to return an unexpected result.
> Since pvdev->driver_override is a string that is modified byte by byte,
> without considering atomicity, data races may cause a partially modified
> pvdev->driver_override to enter both the condition and return statements,
> resulting in an error.
> 
> To fix this, we suggest protecting all reads of pvdev->driver_override
> with a lock, and storing the result of the strcmp() function in a new
> variable retval. This ensures that pvdev->driver_override does not change
> during the entire operation, allowing the function to return the expected
> result.
> 
> This possible bug is found by an experimental static analysis tool
> developed by our team. This tool analyzes the locking APIs
> to extract function pairs that can be concurrently executed, and then
> analyzes the instructions in the paired functions to identify possible
> concurrency bugs including data races and atomicity violations.
> 
> Fixes: 5150a8f07f6c ("amba: reorder functions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
> ---
>   drivers/amba/bus.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 34bc880ca20b..e310f4f83b27 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -209,6 +209,7 @@ static int amba_match(struct device *dev, const struct device_driver *drv)
>   {
>   	struct amba_device *pcdev = to_amba_device(dev);
>   	const struct amba_driver *pcdrv = to_amba_driver(drv);
> +	int retval;
>   
>   	mutex_lock(&pcdev->periphid_lock);
>   	if (!pcdev->periphid) {
> @@ -230,8 +231,14 @@ static int amba_match(struct device *dev, const struct device_driver *drv)
>   	mutex_unlock(&pcdev->periphid_lock);
>   
>   	/* When driver_override is set, only bind to the matching driver */
> -	if (pcdev->driver_override)
> -		return !strcmp(pcdev->driver_override, drv->name);
> +
> +	device_lock(dev);
> +	if (pcdev->driver_override) {
> +		retval = !strcmp(pcdev->driver_override, drv->name);
> +		device_unlock(dev);
> +		return retval;
> +	}
> +	device_unlock(dev);
>   
>   	return amba_lookup(pcdrv->id_table, pcdev) != NULL;
>   }


Looks correct to me

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>



