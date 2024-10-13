Return-Path: <stable+bounces-83617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C5999B936
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 13:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28D00281ED2
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 11:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BCB13D279;
	Sun, 13 Oct 2024 11:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Yk9kdM+6"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D481E495;
	Sun, 13 Oct 2024 11:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728819371; cv=none; b=PmIRqan459JjNMWhrouyn7wCm1AbZPjURuqYRgyt7sbX09Es4xkrGONYs418wJ32Mun/nRTz2ToSLzHk9Dv3VSgQjhrB64rRDuby541xVl4A0uUrueeNwa72O6FK/Do00884cZAxI9j1ff6lCzsd7P5sR25w0t5hjvxHTY8LAak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728819371; c=relaxed/simple;
	bh=2MtX1u7PVUKx3luNKp/nNbTbnOd06T6BXf2SHZVwZME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Js3eFUs52AyLlsleU51z7fpmctkbN68leuJtY+n9oZH1GhNzBoYS07vdYUU+JCy29tNsTOf+lBJ0pBY8SahKsNYIiBYhryilnZP6j7cu/qFQ7Dm/yNEPNWOFsJ/kRxw0tMW6l6VvRVJ1MdkT1Wmy0qlCtUf7gZE03zt46tPdOyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Yk9kdM+6; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [IPV6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f] (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id AD47B82E;
	Sun, 13 Oct 2024 13:34:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728819268;
	bh=2MtX1u7PVUKx3luNKp/nNbTbnOd06T6BXf2SHZVwZME=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Yk9kdM+6CAdEWorO9f1lXmQ5gOpNFdcGHcLR2hP/kNAkXEcUtseBuKdfVM8PmnHKb
	 OB71huGtHIqN+Opr2jg67AwGeAitQE9P4qYcfvV6nXhzYQVr9byOjGvE2NM2T5bB9G
	 XHedPr4QNPphGEaWJMAebknObYtvVMy37iSX21cw=
Message-ID: <e88e5faf-d88a-4ce9-948a-c976c2969cad@ideasonboard.com>
Date: Sun, 13 Oct 2024 17:06:02 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: vchiq_arm: Fix missing refcount decrement in
 error path for fw_node
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stefan Wahren <wahrenst@gmx.net>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241013-vchiq_arm-of_node_put-v1-1-f72b2a6e47d0@gmail.com>
Content-Language: en-US
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <20241013-vchiq_arm-of_node_put-v1-1-f72b2a6e47d0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Javier,

Thank you for the patch.

On 13/10/24 4:12 pm, Javier Carrasco wrote:
> An error path was introduced without including the required call to
> of_node_put() to decrement the node's refcount and avoid leaking memory.
> If the call to kzalloc() for 'mgmt' fails, the probe returns without
> decrementing the refcount.
>
> Use the automatic cleanup facility to fix the bug and protect the code
> against new error paths where the call to of_node_put() might be missing
> again.
>
> Cc: stable@vger.kernel.org
> Fixes: 1c9e16b73166 ("staging: vc04_services: vchiq_arm: Split driver static and runtime data")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index 27ceaac8f6cc..792cf3a807e1 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -1332,7 +1332,8 @@ MODULE_DEVICE_TABLE(of, vchiq_of_match);
>   
>   static int vchiq_probe(struct platform_device *pdev)
>   {
> -	struct device_node *fw_node;
> +	struct device_node *fw_node __free(device_node) =
> +		of_find_compatible_node(NULL, NULL, "raspberrypi,bcm2835-firmware");

How about :

+	struct device_node *fw_node __free(device_node) = NULL;

>   	const struct vchiq_platform_info *info;
>   	struct vchiq_drv_mgmt *mgmt;
>   	int ret;
> @@ -1341,8 +1342,6 @@ static int vchiq_probe(struct platform_device *pdev)
>   	if (!info)
>   		return -EINVAL;
>   
> -	fw_node = of_find_compatible_node(NULL, NULL,
> -					  "raspberrypi,bcm2835-firmware");

And undo this (i.e. keep the of_find_compatible_node() call here

This helps with readability as there is a NULL check just after this.
>   	if (!fw_node) {
>   		dev_err(&pdev->dev, "Missing firmware node\n");
>   		return -ENOENT;
> @@ -1353,7 +1352,6 @@ static int vchiq_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	mgmt->fw = devm_rpi_firmware_get(&pdev->dev, fw_node);
> -	of_node_put(fw_node);

And this change remains the same.
>   	if (!mgmt->fw)
>   		return -EPROBE_DEFER;
>   
>
> ---
> base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
> change-id: 20241013-vchiq_arm-of_node_put-60a5eaaafd70
>
> Best regards,


