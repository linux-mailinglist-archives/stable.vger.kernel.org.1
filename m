Return-Path: <stable+bounces-185669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FA2BD9CF5
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 15:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3876B4E805A
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 13:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32B721E0BB;
	Tue, 14 Oct 2025 13:49:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0D52248B4
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760449777; cv=none; b=UqdruxQ1GAf4VyzRCXnrjYYFcxV6C6b5XojjatO8I/jaNDnAqoyJa+2jDqe1fUApRDo/Cj4XglcoJrmfUlKiQIqWw+brRLCxQTf9d80MKYQ6ztjmTKssQJso9lb2g7lVPxZs11fWGBYOppF7O/MDus2zoY8uhC7Cg3SW/k43cXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760449777; c=relaxed/simple;
	bh=SfCFNYBXcCrtPxXmsfTBPO4f4d2n6Mu4PuSlLeMvCo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUI+260cHizUNNRZpu7JEv1chGQKDCSrlqmXJsVN8Amtw0oIfGB3zOpcRkqFYpVsaQ0Qq5BQJBMA36V71M1kLpk8vByTrDdzPs2ObLfYzZMdjkwhPuD5L/PfRCEdkzNgJgilRUHT5xtzbAjwo9G4gwz/5BXgJk+f4umiRC7ul3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44D201A9A;
	Tue, 14 Oct 2025 06:49:27 -0700 (PDT)
Received: from [10.57.66.74] (unknown [10.57.66.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 686983F66E;
	Tue, 14 Oct 2025 06:49:34 -0700 (PDT)
Message-ID: <325e1296-b2c1-498b-9c56-6d94bfcf22d5@arm.com>
Date: Tue, 14 Oct 2025 14:49:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y] cpuidle: governors: menu: Avoid using invalid
 recent intervals data
To: Sergey Senozhatsky <senozhatsky@chromium.org>, stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
References: <20251014130300.2365621-1-senozhatsky@chromium.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20251014130300.2365621-1-senozhatsky@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/25 14:03, Sergey Senozhatsky wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> [ Upstream commit fa3fa55de0d6177fdcaf6fc254f13cc8f33c3eed ]
> 
> Marc has reported that commit 85975daeaa4d ("cpuidle: menu: Avoid
> discarding useful information") caused the number of wakeup interrupts
> to increase on an idle system [1], which was not expected to happen
> after merely allowing shallower idle states to be selected by the
> governor in some cases.
> 
> However, on the system in question, all of the idle states deeper than
> WFI are rejected by the driver due to a firmware issue [2].  This causes
> the governor to only consider the recent interval duriation data
> corresponding to attempts to enter WFI that are successful and the
> recent invervals table is filled with values lower than the scheduler
> tick period.  Consequently, the governor predicts an idle duration
> below the scheduler tick period length and avoids stopping the tick
> more often which leads to the observed symptom.
> 
> Address it by modifying the governor to update the recent intervals
> table also when entering the previously selected idle state fails, so
> it knows that the short idle intervals might have been the minority
> had the selected idle states been actually entered every time.
> 
> Fixes: 85975daeaa4d ("cpuidle: menu: Avoid discarding useful information")
> Link: https://lore.kernel.org/linux-pm/86o6sv6n94.wl-maz@kernel.org/ [1]
> Link: https://lore.kernel.org/linux-pm/7ffcb716-9a1b-48c2-aaa4-469d0df7c792@arm.com/ [2]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Tested-by: Christian Loehle <christian.loehle@arm.com>
> Tested-by: Marc Zyngier <maz@kernel.org>
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>
> Link: https://patch.msgid.link/2793874.mvXUDI8C0e@rafael.j.wysocki
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> (cherry picked from commit 7337a6356dffc93194af24ee31023b3578661a5b)
> ---
>  drivers/cpuidle/governors/menu.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index 4edac724983a..0b3c917d505d 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -158,6 +158,14 @@ static inline int performance_multiplier(unsigned int nr_iowaiters)
>  
>  static DEFINE_PER_CPU(struct menu_device, menu_devices);
>  
> +static void menu_update_intervals(struct menu_device *data, unsigned int interval_us)
> +{
> +	/* Update the repeating-pattern data. */
> +	data->intervals[data->interval_ptr++] = interval_us;
> +	if (data->interval_ptr >= INTERVALS)
> +		data->interval_ptr = 0;
> +}
> +
>  static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev);
>  
>  /*
> @@ -288,6 +296,14 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  	if (data->needs_update) {
>  		menu_update(drv, dev);
>  		data->needs_update = 0;
> +	} else if (!dev->last_residency_ns) {
> +		/*
> +		 * This happens when the driver rejects the previously selected
> +		 * idle state and returns an error, so update the recent
> +		 * intervals table to prevent invalid information from being
> +		 * used going forward.
> +		 */
> +		menu_update_intervals(data, UINT_MAX);
>  	}
>  
>  	/* determine the expected residency time, round up */
> @@ -542,10 +558,7 @@ static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>  
>  	data->correction_factor[data->bucket] = new_factor;
>  
> -	/* update the repeating-pattern data */
> -	data->intervals[data->interval_ptr++] = ktime_to_us(measured_ns);
> -	if (data->interval_ptr >= INTERVALS)
> -		data->interval_ptr = 0;
> +	menu_update_intervals(data, ktime_to_us(measured_ns));
>  }
>  
>  /**

For the backport:
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Thank you Sergey!

