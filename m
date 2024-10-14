Return-Path: <stable+bounces-83753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6D599C48A
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 11:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDBE11C22365
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 09:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E6E15359A;
	Mon, 14 Oct 2024 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gKkpWWXi"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31D314A0AA;
	Mon, 14 Oct 2024 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896527; cv=none; b=j3Dps9jHxsA1KYdFE023vTgLZBFgwGk8EdBwhNr2B3Hrqt8QKo4mGyvdGVYUsbR/urEu9nuLqFl8t5Vfj3PKdpREy40VRVTe+LS1vYc/rMZjNpKoQNtFiq/ZSHPozuQtNDOYPOPVPJhgmgbAgReuZ3C92QL1XaJgD00ciEiBt5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896527; c=relaxed/simple;
	bh=JgJDxOULzDFw5oh7EJQ3xB9a5PJCmNZst+zlHiUa3Ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZlvcxH4wl8ngxoEkHDzAE8oanK4vTmdA62iJeh17djbAotBGPH9kWbDnuB7OWAVXNFkOvLN3Sb20D6KSkqZoLQK8OZ0Wbt2YPvdrVl/c33LQgQQf3Qu5B8LWTJvtlCpyM5Q53MvP515MzWLIhbks1FO5b92/Gw6vaY0PYK7vNzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=gKkpWWXi; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [IPV6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f] (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5AAC7667;
	Mon, 14 Oct 2024 11:00:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728896422;
	bh=JgJDxOULzDFw5oh7EJQ3xB9a5PJCmNZst+zlHiUa3Ew=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gKkpWWXiN61Cf+nKWd88mVQYbuMZxYcYLBJQ++kdieC+c4xqIuSE++l5GmA1T9z4A
	 VS4CBnB+I3E6tcSI/Y2R0Ydw2BReqNIfG4yFs8h8cuHRaxX24Q/G68fxWzuZ/2KMBe
	 NyAqBODnFFJDMJ5X1HgxxiBSi70Oi6tQjuEj66pU=
Message-ID: <a1588e43-2cb9-4356-ac73-b09593d0218c@ideasonboard.com>
Date: Mon, 14 Oct 2024 14:31:56 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: vchiq_arm: Utilize devm_kzalloc in the probe()
 function
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 kernel-list@raspberrypi.com, Stefan Wahren <wahrenst@gmx.net>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
References: <20241014075900.86537-1-umang.jain@ideasonboard.com>
Content-Language: en-US
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <20241014075900.86537-1-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

Please ignore this patch, it was a wrong-send (older version)

On 14/10/24 1:29 pm, Umang Jain wrote:
> The two resources, 'mgmt' and 'platform_state' are currently allocated
> dynamically using kzalloc(). Unfortunately, both are subject to memory
> leaks in the error handling paths of the probe() function.
>
> To address this issue, use device resource management helper devm_kzalloc()
> for proper cleanup during allocation.
>
> Cc: stable@vger.kernel.org
> Fixes: 1c9e16b73166 ("staging: vc04_services: vchiq_arm: Split driver static and runtime data")
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>   .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c   | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index 29e78700463f..373cfdd5b020 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -285,7 +285,7 @@ vchiq_platform_init_state(struct vchiq_state *state)
>   {
>   	struct vchiq_arm_state *platform_state;
>   
> -	platform_state = kzalloc(sizeof(*platform_state), GFP_KERNEL);
> +	platform_state = devm_kzalloc(state->dev, sizeof(*platform_state), GFP_KERNEL);
>   	if (!platform_state)
>   		return -ENOMEM;
>   
> @@ -1344,7 +1344,7 @@ static int vchiq_probe(struct platform_device *pdev)
>   		return -ENOENT;
>   	}
>   
> -	mgmt = kzalloc(sizeof(*mgmt), GFP_KERNEL);
> +	mgmt = devm_kzalloc(&pdev->dev, sizeof(*mgmt), GFP_KERNEL);
>   	if (!mgmt)
>   		return -ENOMEM;
>   
> @@ -1402,8 +1402,6 @@ static void vchiq_remove(struct platform_device *pdev)
>   
>   	arm_state = vchiq_platform_get_arm_state(&mgmt->state);
>   	kthread_stop(arm_state->ka_thread);
> -
> -	kfree(mgmt);
>   }
>   
>   static struct platform_driver vchiq_driver = {


