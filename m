Return-Path: <stable+bounces-83736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C101299C122
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 09:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29201C221AB
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 07:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CA11482FE;
	Mon, 14 Oct 2024 07:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="upVMZZL1"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973301482E5
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 07:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728890533; cv=none; b=sTyGVPpaFdW7a87JkiyQu83uubPY7isUodRXqKWV9zeykMS6P+vrdMF8SJCKGYUooIEaKMiDKEBV4pAaBUUl+Hnh03czadpCkWc9I8pFw89+q0Uqzlo73f1bUdm5gI2P4j8X9mGprvTqxHLAQY2kzYeXK0FXa9SZ/q16jLX5e8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728890533; c=relaxed/simple;
	bh=mGHMGEUBr/F0CJwt3EUkiNJ4VsfSu5n2mHMo5boIc14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/10R047UEPSaz2x8Hvn4+EiwHIM/ShKzyx0YPdkku553ZkMYPPPSX5OvuHutpD0q0ytGg+2m0QbkTFNCa/K3UGmuI1uZAZxVaEgx5NsdspC8JepiTWKeaJOKG8g7+gQoHBF6dWboz6dfiMB7Qi5UWxyQxXnXyPRnLVBOpKIb3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=upVMZZL1; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539fb49c64aso309589e87.0
        for <stable@vger.kernel.org>; Mon, 14 Oct 2024 00:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728890530; x=1729495330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b4ocUAvfrOuY999lWMHtbPSHRKb+QYQGzjdGe4dWQvY=;
        b=upVMZZL1qC+G6arF834wyqxd5bEPezgXb5iSgqTViAkvbZEIL/v4nGxHcgUNvzIYor
         3Qm1wenGbUGOnv7PLwYIv9Itp1eT6dkEYgcY1UoFFVfebhoiRx/vy8OWrBgN5F329n7Z
         4xiqoFKdW1+XhuftyMHUYkHPKoxZhBj+ceqeGJ/OyREJJb2Fx4nPf3OKpVlvZNZuKDYt
         trlZwLwMZuZ1ld0yb479VlUqeo427XFJpvm0jzXBE3zYfkO/AC/IrLSQXlYBVjowiX9o
         p9S5Cc2Ev3sFsZHHmRkli+eglUd8TfCW4hxYXr2O3WVJqTms/Tt7Mg8rCKIuujbeQZN7
         rlwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728890530; x=1729495330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4ocUAvfrOuY999lWMHtbPSHRKb+QYQGzjdGe4dWQvY=;
        b=WRVBgXoEvBPglNHSM7PIiH5q44C0kIgjbTjbfagMpPTS4HdZtXDS5lB+/p1dakPkLY
         kKOsZtinQIhb4/z0XN08iaTP6WSfwK/QdjYl3cCJyvMy88qjWqEIqcxEjN/0DxNfwZWm
         QZ3BaVq/UEMg4fLT452rd2+G9VupdRtGTmjioS0suuLvkUtaDiCQ9dO8Iyu/X5ISVjZs
         ky6BH3NhoJN+VmRF4noboQ/ippD1FUWHDsZhSBip9PNXsTiNGoMu5i3AAWnKjyXJKeC8
         vuMwTnm3X/zL1SB0GatZJpP5k8+VJm/prNuovdn+L4NmTYBEfD8gnnBD4wwsTl8mXNkP
         aeGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrp+y8qFsvtg6m7G68gE9t4Xkcix7ApH9QuPDysrTPkA6qc/wuK4uHAFNHN+xlauyMqfw6GUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGSMjxgU9z2HEQQ538LMv+rmyGAkF9KD927b182RUFMnK9KYV4
	bqDsRf0xndUmdeLADGOqX7vwbEuBnnSmaM9Ofmpao9C+5vMkcNyggDkXLDQvsTQ=
X-Google-Smtp-Source: AGHT+IFHniEhvrxGEdUHxeYZmE+6k4vfJcTSoYQutpj/Ig9jc4ttnzu0ncfXZilDcnjNIiQCd0auLw==
X-Received: by 2002:a05:6512:1247:b0:536:55cc:963e with SMTP id 2adb3069b0e04-539e571cf75mr3510023e87.44.1728890529531;
        Mon, 14 Oct 2024 00:22:09 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99f86fa986sm240148566b.92.2024.10.14.00.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 00:22:09 -0700 (PDT)
Date: Mon, 14 Oct 2024 10:22:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Umang Jain <umang.jain@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] staging: vchiq_arm: Fix missing refcount decrement in
 error path for fw_node
Message-ID: <a4283afc-f869-4048-90b4-1775acb9adda@stanley.mountain>
References: <20241013-vchiq_arm-of_node_put-v1-1-f72b2a6e47d0@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013-vchiq_arm-of_node_put-v1-1-f72b2a6e47d0@gmail.com>

On Sun, Oct 13, 2024 at 12:42:32PM +0200, Javier Carrasco wrote:
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
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index 27ceaac8f6cc..792cf3a807e1 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -1332,7 +1332,8 @@ MODULE_DEVICE_TABLE(of, vchiq_of_match);
>  
>  static int vchiq_probe(struct platform_device *pdev)
>  {
> -	struct device_node *fw_node;
> +	struct device_node *fw_node __free(device_node) =
> +		of_find_compatible_node(NULL, NULL, "raspberrypi,bcm2835-firmware");
>  	const struct vchiq_platform_info *info;
>  	struct vchiq_drv_mgmt *mgmt;
>  	int ret;
> @@ -1341,8 +1342,6 @@ static int vchiq_probe(struct platform_device *pdev)
>  	if (!info)
>  		return -EINVAL;
>  
> -	fw_node = of_find_compatible_node(NULL, NULL,
> -					  "raspberrypi,bcm2835-firmware");

Perhaps it's better to declare the variable here so that the function and the
error handling are next to each other.

	if (!info)
		return -EINVAL;

	struct device_node *fw_node __free(device_node) =
		of_find_compatible_node(NULL, NULL, "raspberrypi,bcm2835-firmware");
	if (!fw_node) {

	...

This is why we lifted the rule that variables had to be declared at the start
of a function.

regards,
dan carpenter


