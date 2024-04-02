Return-Path: <stable+bounces-35567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E64894D77
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 10:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC09C1F21BFB
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 08:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8790645BEF;
	Tue,  2 Apr 2024 08:29:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF02D45008
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712046597; cv=none; b=uo9OtEe3Q+gm09IG3LpBBGR5CibGzXdMbrMenXHb4P+7OaDGIKQvTLAUG/R3gVJySqgFAQBtS/1flbZTC4KUIJDqf3jPV1gqWc7uE2C6WWQSB2pB6uF7IIyDfm7cfX/KjndRg2K3eyBt4Opdo8MnSdmpvvR+ggMy8lmDepEsbbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712046597; c=relaxed/simple;
	bh=wq4ownMckaMf+Xfp6j7rIGn8vh+r7+TaYCO52U11Yjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=GfnmW9fDXvZ8PS679hqh8QBynGkSChYBbaBIOBMF31G9sHFxmzdDrMBk+C97/lMm4hfRRlfWjCtcI+QvU6fcLo0XW4nkSl/sPloPgMaZ6qTuW22zk2Goqof6lLUIPs1sALPJRH6484z93QdEMTq2y4zONOUgYrYbCNfmxehG3nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D9451042;
	Tue,  2 Apr 2024 01:30:26 -0700 (PDT)
Received: from [10.57.72.194] (unknown [10.57.72.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4023D3F64C;
	Tue,  2 Apr 2024 01:29:53 -0700 (PDT)
Message-ID: <945689b3-445d-4915-857e-dda84cc8352c@arm.com>
Date: Tue, 2 Apr 2024 09:29:56 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] thermal: devfreq_cooling: Fix perf state
 when calculate dfc" failed to apply to 5.15-stable tree
Content-Language: en-US
To: gregkh@linuxfoundation.org
References: <2024033050-imitation-unmixed-ef53@gregkh>
Cc: ye.zhang@rock-chips.com, d-gole@ti.com, rafael.j.wysocki@intel.com,
 stable@vger.kernel.org
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2024033050-imitation-unmixed-ef53@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Greg,

On 3/30/24 09:46, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Would you like my help? I can create a backport to v5.15.y and send
to the list.

Regards,
Lukasz

> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x a26de34b3c77ae3a969654d94be49e433c947e3b
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024033050-imitation-unmixed-ef53@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
>  From a26de34b3c77ae3a969654d94be49e433c947e3b Mon Sep 17 00:00:00 2001
> From: Ye Zhang <ye.zhang@rock-chips.com>
> Date: Thu, 21 Mar 2024 18:21:00 +0800
> Subject: [PATCH] thermal: devfreq_cooling: Fix perf state when calculate dfc
>   res_util
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> The issue occurs when the devfreq cooling device uses the EM power model
> and the get_real_power() callback is provided by the driver.
> 
> The EM power table is sorted ascending，can't index the table by cooling
> device state，so convert cooling state to performance state by
> dfc->max_state - dfc->capped_state.
> 
> Fixes: 615510fe13bd ("thermal: devfreq_cooling: remove old power model and use EM")
> Cc: 5.11+ <stable@vger.kernel.org> # 5.11+
> Signed-off-by: Ye Zhang <ye.zhang@rock-chips.com>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> index 50dec24e967a..8fd7cf1932cd 100644
> --- a/drivers/thermal/devfreq_cooling.c
> +++ b/drivers/thermal/devfreq_cooling.c
> @@ -214,7 +214,7 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
>   
>   		res = dfc->power_ops->get_real_power(df, power, freq, voltage);
>   		if (!res) {
> -			state = dfc->capped_state;
> +			state = dfc->max_state - dfc->capped_state;
>   
>   			/* Convert EM power into milli-Watts first */
>   			rcu_read_lock();
> 

