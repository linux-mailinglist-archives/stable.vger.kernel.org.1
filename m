Return-Path: <stable+bounces-35563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFAE894D2D
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 10:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47FC41F227AD
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 08:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72573D548;
	Tue,  2 Apr 2024 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMQPio9Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C843D544;
	Tue,  2 Apr 2024 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712045371; cv=none; b=E2AL/h9y3/aJQt2564/7BRxb5GXPm5Glmp5fXfUZu/3z+/WJOHEP/dPeUK4/YFIK2wgV0ey18C5UiAQyJ39vvn2M41fBwCnt6ecASRqYjiu6RIl8sumb53OA9vujuzxBelgk/YLDqLLL8tphzrgFWLPpALeX/dtwDWf1pGQF7ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712045371; c=relaxed/simple;
	bh=ZzCmfLlRmQWAd8BZFDzu2/Q5ZhppnoVamII+p9EovOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJnqqI30NOC2bqsO9iWnm9XcRDhjYXNBLIh9VBmTVj6J42k2D1gYujcoZjoO8XlfIVMPxw04hOGwT1GDgiB4JfGrtHSLOnaiu0s54zuMib2WvlW0cLOXDcsD5C5ytbwxnYWgqpk27tVCIjdiE/UFlcBG1ccgAYkTNj19jMadjfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMQPio9Q; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso3973967a12.2;
        Tue, 02 Apr 2024 01:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712045369; x=1712650169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aPabVevQpgCOqyU7yl6aNZ4AREaAFhD+eH9lVYEoxAU=;
        b=aMQPio9QYPO4Rgct2mAlylee3sOKH+jOqV8cuELnQLrGaoM2MmGBeOtdah8eiBduRm
         CPTMT/T/KHrdrK2zlpgNWxsZEwBxeEPX+VdRREEAIXAng3+2RwVo6svD3+fdedR7q4w1
         AS2Y0F5Bl6N9FA0Pd9KnK7GTa7L7lcco9bUXuZ35c4a1fPALq9hN4TB19FyEwXxwcbdB
         2qj07SOxLlvosp+6p9drilE8enhJus71Lh0qBdk+hkkeBCPIW8mu5QS8MNbRL8XMK9pR
         DHojccyICA5QKCypd9/fqHkvxT8O3YYt9hDm0tqbNCR3huNUb291Cm8UzFd8hV49NqmP
         RIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712045369; x=1712650169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aPabVevQpgCOqyU7yl6aNZ4AREaAFhD+eH9lVYEoxAU=;
        b=ae3xNjvvDBhqZ4Ead4TIvxE5/7NcbWYPtZJqZGzpTLKyz8crmYjBolbrFdOO3XzgBE
         6dZ81psVJm7UjbsjfHQ9frjCt2tSAt5IKlsgao/Mp5beYhLcXXulwFnciyVwFjI/fQqN
         Od2bECa2DIcRcSoOT9/NsWyQ5KCbiWd3kg+qqCLWLZf3pS9Kr/LNVewk/VRrmHpHCkor
         1MwT0rkTtCBwcP6A4sPupDDzQ6+a69bmLF48r1p6knoyJRptItAIm2RbxrW1Wsp6QNNA
         FEWYG+k3xv8VnJrcMqaiW3dohqYb9xOBK0bfxoCvnDWQdKQdg129ZIjwOu5rxjTRDWct
         kJiA==
X-Forwarded-Encrypted: i=1; AJvYcCVM88iCWFZYkUDzlTKf16ZCHIm/jN854IhUZKgPWy4Kl9i5aeocmjj6iS+pgx3EqBE6boQLg293rnDl+ASLJI9pwFqPOlUSsRB9
X-Gm-Message-State: AOJu0YzsDBVZHYu2P+VcJx5CLU2UH1DQ4wtfi4k5wwmAY+iLTqckEFQD
	zSYxVJeG2wjOg1Kiahu6kCZNO2ttjBc46YycGvDDSLqfpgPW6v2QzkyXH8YL
X-Google-Smtp-Source: AGHT+IHTP2mpj+NEMTTvSo0+EkhBbGLzl0pC82IDkvx3xKRk8pK6f7Cd2YOdQRnbzDY/SCssbK8CaQ==
X-Received: by 2002:a05:6a20:3d0b:b0:1a7:2463:ae3b with SMTP id y11-20020a056a203d0b00b001a72463ae3bmr405372pzi.7.1712045369408;
        Tue, 02 Apr 2024 01:09:29 -0700 (PDT)
Received: from [192.168.43.30] ([1.47.155.123])
        by smtp.googlemail.com with ESMTPSA id e14-20020a170902784e00b001e010c1628fsm10524655pln.124.2024.04.02.01.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 01:09:28 -0700 (PDT)
Message-ID: <64053ff1-c447-45c5-ba87-e85307143dd4@gmail.com>
Date: Tue, 2 Apr 2024 15:09:12 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] USB: serial: option: add Lonsung U8300/U9300 product
 Update the USB serial option driver to support Longsung U8300/U9300.
To: Coia Prant <coiaprant@gmail.com>, linux-usb@vger.kernel.org,
 Johan Hovold <johan@kernel.org>
Cc: stable@vger.kernel.org
References: <20240402073451.1751984-1-coiaprant@gmail.com>
Content-Language: en-US
From: Lars Melin <larsm17@gmail.com>
In-Reply-To: <20240402073451.1751984-1-coiaprant@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-04-02 14:34, Coia Prant wrote:
> ID 1c9e:9b05 OMEGA TECHNOLOGY (U8300)
> ID 1c9e:9b3c OMEGA TECHNOLOGY (U9300)
> 
> U8300
>   /: Bus
>      |__ Port 1: Dev 3, If 0, Class=Vendor Specific Class, Driver=option, 480M (Debug)
>          ID 1c9e:9b05 OMEGA TECHNOLOGY
>      |__ Port 1: Dev 3, If 1, Class=Vendor Specific Class, Driver=option, 480M (Modem / AT)
>          ID 1c9e:9b05 OMEGA TECHNOLOGY
>      |__ Port 1: Dev 3, If 2, Class=Vendor Specific Class, Driver=option, 480M (AT)
>          ID 1c9e:9b05 OMEGA TECHNOLOGY
>      |__ Port 1: Dev 3, If 3, Class=Vendor Specific Class, Driver=option, 480M (AT / Pipe / PPP)
>          ID 1c9e:9b05 OMEGA TECHNOLOGY
>      |__ Port 1: Dev 3, If 4, Class=Vendor Specific Class, Driver=qmi_wwan, 480M (NDIS / GobiNet / QMI WWAN)
>          ID 1c9e:9b05 OMEGA TECHNOLOGY
>      |__ Port 1: Dev 3, If 5, Class=Vendor Specific Class, Driver=, 480M (ADB)
>          ID 1c9e:9b05 OMEGA TECHNOLOGY
> 
> U9300
>   /: Bus
>      |__ Port 1: Dev 3, If 0, Class=Vendor Specific Class, Driver=, 480M (ADB)
>          ID 1c9e:9b3c OMEGA TECHNOLOGY
>      |__ Port 1: Dev 3, If 1, Class=Vendor Specific Class, Driver=option, 480M (Modem / AT)
>          ID 1c9e:9b3c OMEGA TECHNOLOGY
>      |__ Port 1: Dev 3, If 2, Class=Vendor Specific Class, Driver=option, 480M (AT)
>          ID 1c9e:9b3c OMEGA TECHNOLOGY
>      |__ Port 1: Dev 3, If 3, Class=Vendor Specific Class, Driver=option, 480M (AT / Pipe / PPP)
>          ID 1c9e:9b3c OMEGA TECHNOLOGY
>      |__ Port 1: Dev 3, If 4, Class=Vendor Specific Class, Driver=qmi_wwan, 480M (NDIS / GobiNet / QMI WWAN)
>          ID 1c9e:9b3c OMEGA TECHNOLOGY
> 
> Tested successfully using Modem Manager on U9300.
> Tested successfully AT commands using If=1, If=2 and If=3 on U9300.
> 
> Signed-off-by: Coia Prant <coiaprant@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>   drivers/usb/serial/option.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 55a65d941ccb..27a116901459 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -412,6 +412,10 @@ static void option_instat_callback(struct urb *urb);
>    */
>   #define LONGCHEER_VENDOR_ID			0x1c9e
>   
> +/* Longsung products */
> +#define LONGSUNG_U8300_PRODUCT_ID		0x9b05
> +#define LONGSUNG_U9300_PRODUCT_ID		0x9b3c
> +
>   /* 4G Systems products */
>   /* This one was sold as the VW and Skoda "Carstick LTE" */
>   #define FOUR_G_SYSTEMS_PRODUCT_CARSTICK_LTE	0x7605
> @@ -2054,6 +2058,10 @@ static const struct usb_device_id option_ids[] = {
>   	  .driver_info = RSVD(4) },
>   	{ USB_DEVICE(LONGCHEER_VENDOR_ID, ZOOM_PRODUCT_4597) },
>   	{ USB_DEVICE(LONGCHEER_VENDOR_ID, IBALL_3_5G_CONNECT) },
> +	{ USB_DEVICE(LONGCHEER_VENDOR_ID, LONGSUNG_U8300_PRODUCT_ID),
> +	  .driver_info = RSVD(4) | RSVD(5) },
> +	{ USB_DEVICE(LONGCHEER_VENDOR_ID, LONGSUNG_U9300_PRODUCT_ID),
> +	  .driver_info = RSVD(0) | RSVD(4) },
>   	{ USB_DEVICE(HAIER_VENDOR_ID, HAIER_PRODUCT_CE100) },
>   	{ USB_DEVICE_AND_INTERFACE_INFO(HAIER_VENDOR_ID, HAIER_PRODUCT_CE81B, 0xff, 0xff, 0xff) },
>   	/* Pirelli  */

Reviewed-by Lars Melin (larsm17@gmail.com

added the maintainer to the recipient list

