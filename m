Return-Path: <stable+bounces-76584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C083E97B087
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 15:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 501BB1F239DF
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 13:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAE91741D0;
	Tue, 17 Sep 2024 13:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrYyBea9"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7ED16A930
	for <stable@vger.kernel.org>; Tue, 17 Sep 2024 13:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726578245; cv=none; b=Rq1BIk4F2Oq6Zz2O4pNQq5h0vV8WCX9TgOVgI7PPwVvPnamb09xUTRcSC4o337mOAoecn90QVfWDcqMA3SCJfOwfD04uOtVcjMsZOvYLHe1JSo7+nAkFBqRfH7Br7teUdnIliSub2hOzVxLzOXiRIxveLCj1x3qMsA5lvBOh9Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726578245; c=relaxed/simple;
	bh=oBXOVT8eXpsVUTP8TJ3FTtAqcWmIK89WtoRldp+yOmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awIwkqKIY61WRb53E1MFFlmKjSCyMwLr9ktvAHY0NjWMrt+pdzcX5oZhnpkS/BJXLzfv35vo70serz1svf0HjOaGfk5anLsa05bXdkm3dx0GPwZ5OBHZWib5L/LvEaUAIL40h1lPkfWG4sdH/QtFH/wp7M6k5PE+0pzhaXs6cdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WrYyBea9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726578241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r9sq3qQyyGyxnaltKrQcaIg8ym8e8TuQdTwGOVY9y/A=;
	b=WrYyBea9oBPlPkS5xUlwEZE8RDGE3BRnBy8f7ICUddp1VmpazrfMCmiptyTUOFctUnriNp
	Gv5hIGKpNQTSddQr5/5qjTsZ2BeuOMsxKGHC5z3b9lAmQ2M/D0YolXm7wrJPDNhThqHAx8
	0CypHm/Uo+7dIpPhRhiL5shEX+Y0j2s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-QLscycnON06b8ul6EJi10A-1; Tue, 17 Sep 2024 09:04:00 -0400
X-MC-Unique: QLscycnON06b8ul6EJi10A-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a8d10954458so410120266b.3
        for <stable@vger.kernel.org>; Tue, 17 Sep 2024 06:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726578239; x=1727183039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r9sq3qQyyGyxnaltKrQcaIg8ym8e8TuQdTwGOVY9y/A=;
        b=qqziBt6aKA5n2o/p3vfO8fJz8dMHI5D1EJ3ErfTGXGgE0j5WK5HdxFBWXmBsueJ54/
         Ue1eSx/zUi5wuqkzHORdSuzTFx5NPm0mOjJwESuVCvWfmB4P9LplqdcNzIZEDzZcqQ99
         BNdrgd6ULZY1AeDrZ0rEp64IvYb4/LZN4jC+VIpY5osY1gd34ajAEwbmdJmsVlRN02pp
         7QOce8JirAtGYn2Nh+zrVzM3HTQqzhi9JiRYBGSkM6EFe/dPaTX0+Dfzh6Pj/MBtm1oe
         P0ieNkPehNpvbZeg5fKhnzIbDdx0QnPa4V/pbnvgrQWrguxpi85SQVHDgPZL5d8YO9Sk
         f9IA==
X-Forwarded-Encrypted: i=1; AJvYcCW7jz+zRFvc8U45mQZZb75RucMoot6uist7wmxnbzW0U+xlwvgGOFzAJ6Jdad5SszNVS3TX/3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy08txMmM4G5jKj1sZy1Wg+yenok1GtOWef9i9wu6Rx5KA7Mgxz
	CA6xgqcGV7FWmk+iVzCvYrMTrHBGjcm9FkywTJLimWG1rauni+95vSwRcm1vZgV3rXKA2zLEFIj
	5PpYc4ymIjGMMGiVu58UHH55QgKj4Te/EQfnT4UxBKJyOpors4+wsP8amENmlMQ==
X-Received: by 2002:a17:906:d7c5:b0:a8d:2359:3163 with SMTP id a640c23a62f3a-a90294d0a4cmr1761320566b.31.1726578239017;
        Tue, 17 Sep 2024 06:03:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5wsLYbYcfBZWTfBqsKqege5SI/JZ5IeMZmQU+K4lOz46Q2dm2rgfx+E+QNMzCQqdyQkGFnw==
X-Received: by 2002:a17:906:d7c5:b0:a8d:2359:3163 with SMTP id a640c23a62f3a-a90294d0a4cmr1761317466b.31.1726578238482;
        Tue, 17 Sep 2024 06:03:58 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610968b9sm446201966b.5.2024.09.17.06.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 06:03:57 -0700 (PDT)
Message-ID: <ae37b670-a42d-4130-911c-90e0c8b828bc@redhat.com>
Date: Tue, 17 Sep 2024 15:03:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1] platform/x86: android-platform: deref after free in
 x86_android_tablet_init() fix
To: Aleksandr Burakov <a.burakov@rosalinux.ru>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Mark Gross <markgross@kernel.org>
Cc: linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 lvc-patches@linuxtesting.org, platform-driver-x86@vger.kernel.org
References: <20240917120458.7300-1-a.burakov@rosalinux.ru>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240917120458.7300-1-a.burakov@rosalinux.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Thank you for your patch.

On 9/17/24 2:04 PM, Aleksandr Burakov wrote:
> No upstream commit exists for this commit.

Right, which is bad, especially since the upstream code actually still has this bug.

NACK.

Note that upstream in drivers/platform/x86/x86-android-tablets/core.c
the same issue is also present around line 447:

                pdevs[pdev_count] = platform_device_register_data(&pdev->dev, "gpio-keys",
                                                                  PLATFORM_DEVID_AUTO,
                                                                  &pdata, sizeof(pdata));
                if (IS_ERR(pdevs[pdev_count])) {
                        x86_android_tablet_remove(pdev);
                        return PTR_ERR(pdevs[pdev_count]);
                }
                pdev_count++;

Please submit a fix for both issues upstream, once that has been merged
you can submit a backport with a proper upstream commit reference.

Regards,

Hans





> 
> Pointer '&pdevs[i]' is dereferenced at x86_android_tablet_init()
> after the referenced memory was deallocated by calling function
> 'x86_android_tablet_cleanup()'.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 5eba0141206e ("platform/x86: x86-android-tablets: Add support for instantiating platform-devs")
> Signed-off-by: Aleksandr Burakov <a.burakov@rosalinux.ru>
> ---
>  drivers/platform/x86/x86-android-tablets.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/x86-android-tablets.c b/drivers/platform/x86/x86-android-tablets.c
> index 9178076d9d7d..9838c5332201 100644
> --- a/drivers/platform/x86/x86-android-tablets.c
> +++ b/drivers/platform/x86/x86-android-tablets.c
> @@ -1853,8 +1853,9 @@ static __init int x86_android_tablet_init(void)
>  	for (i = 0; i < pdev_count; i++) {
>  		pdevs[i] = platform_device_register_full(&dev_info->pdev_info[i]);
>  		if (IS_ERR(pdevs[i])) {
> +			int ret = PTR_ERR(pdevs[i]);
>  			x86_android_tablet_cleanup();
> -			return PTR_ERR(pdevs[i]);
> +			return ret;
>  		}
>  	}
>  


