Return-Path: <stable+bounces-7071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8A3816FEA
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23738282CAF
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D1D74E35;
	Mon, 18 Dec 2023 13:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDb1mVSt"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF8B74E3F
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702904597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D4BR8c8goPXlqieZxmccl7pcjPueJY1A6406IGvIqgM=;
	b=JDb1mVStEf2u7XJLKgZrhJ8tiMR7TqBf/YUHakhSmGhhLHG0C9VX5WjMQ70owdeYoRX8+w
	jrI6o7nHHcYsSHtjSHJN8iydfRyAE6Khj5FHndP9cpYXQqgYf3iMG8YXREbfzWdh/PgpJb
	gfzC0RYWfdevwT2/7nyuSfwFOc3Rwcg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-pTOZXZ4fNZ6PM2W3MIUFRw-1; Mon, 18 Dec 2023 08:03:14 -0500
X-MC-Unique: pTOZXZ4fNZ6PM2W3MIUFRw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40c691ffb32so24602065e9.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 05:03:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702904593; x=1703509393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4BR8c8goPXlqieZxmccl7pcjPueJY1A6406IGvIqgM=;
        b=kxSgL6NSsP+ed8oo8nrk04ayj20oWg9T0JutLB62BhxveaGP5zrBHUo1X47v8ovHW3
         cyV3/oEhX0Z3QrgTLirf3jHA+OPqH6O5UPfODtKfEVLrHB1cD82c90G/UHXPWLKcr3JQ
         iKzQjEgbBnpCMBRJETfAOVTRUmtqen5MdKSfnJpMJForZIF/Spb+apMj+A1ZokpiwYto
         kdxv+0XxFq5l9jLuT7f9Rn4/xobJb/FrH0knEyxJM1x/GxoywNTKJD5MjipxgAfQ1D/L
         ytjcO7z8cQOTzLKI86pwpH7OlHmjmdlAjLCL6GKLSEO7nHr4fNSj1GUxoxWLPjolApTb
         KL9A==
X-Gm-Message-State: AOJu0YzUXfUf7EbjlnrBI7UgAt9LnLUi11EWz2xeYY7doSJL4KTJ+1yr
	QRYUc3NU7XW8TH4agUneI/3cPqFrIeCnsDCCv/E6n/wk6x91WAA4YKPYesUZLc6oX7rZjQz4SNn
	oVrI5Wm4SW1JSaz0a
X-Received: by 2002:a05:600c:829:b0:40b:5e21:c5aa with SMTP id k41-20020a05600c082900b0040b5e21c5aamr5328103wmp.120.1702904593423;
        Mon, 18 Dec 2023 05:03:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGw6Lconji7VbC6NL33uohkatwRsNiFsQCnToxefrUdxxqBn5nrq+SfFSjMJ7N/ZyfjKhGuuQ==
X-Received: by 2002:a05:600c:829:b0:40b:5e21:c5aa with SMTP id k41-20020a05600c082900b0040b5e21c5aamr5328097wmp.120.1702904593084;
        Mon, 18 Dec 2023 05:03:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id p32-20020a05600c1da000b0040b360cc65csm42399843wms.0.2023.12.18.05.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 05:03:12 -0800 (PST)
Message-ID: <beec3b5d-689a-4b25-be4b-9ff7532bb2e6@redhat.com>
Date: Mon, 18 Dec 2023 14:03:11 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mgag200: Fix gamma lut not initialized for G200ER,
 G200EV, G200SE
To: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 airlied@redhat.com, daniel@ffwll.ch, javierm@redhat.com
Cc: Roger Sewell <roger.sewell@cantab.net>, stable@vger.kernel.org
References: <20231214163849.359691-1-jfalempe@redhat.com>
 <641bc7e1-5c13-4af1-ae2e-8cdc58ee92a9@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <641bc7e1-5c13-4af1-ae2e-8cdc58ee92a9@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18/12/2023 12:31, Thomas Zimmermann wrote:
> Hi
> 
> Am 14.12.23 um 17:38 schrieb Jocelyn Falempe:
>> When mgag200 switched from simple KMS to regular atomic helpers,
>> the initialization of the gamma settings was lost.
>> This leads to a black screen, if the bios/uefi doesn't use the same
>> pixel color depth.
>> This has been fixed with commit ad81e23426a6 ("drm/mgag200: Fix gamma
>> lut not initialized.") for most G200, but G200ER, G200EV, G200SE use
>> their own version of crtc_helper_atomic_enable() and need to be fixed
>> too.
>>
>> Fixes: 1baf9127c482 ("drm/mgag200: Replace simple-KMS with regular 
>> atomic helpers")
>> Cc: <stable@vger.kernel.org> #v6.1+
>> Reported-by: Roger Sewell <roger.sewell@cantab.net>
>> Suggested-by: Roger Sewell <roger.sewell@cantab.net>
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>> ---
>>   drivers/gpu/drm/mgag200/mgag200_drv.h    |  4 ++++
>>   drivers/gpu/drm/mgag200/mgag200_g200er.c |  2 ++
>>   drivers/gpu/drm/mgag200/mgag200_g200ev.c |  2 ++
>>   drivers/gpu/drm/mgag200/mgag200_g200se.c |  2 ++
>>   drivers/gpu/drm/mgag200/mgag200_mode.c   | 26 ++++++++++++++----------
>>   5 files changed, 25 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.h 
>> b/drivers/gpu/drm/mgag200/mgag200_drv.h
>> index 57c7edcab602..ed90a92b5fcd 100644
>> --- a/drivers/gpu/drm/mgag200/mgag200_drv.h
>> +++ b/drivers/gpu/drm/mgag200/mgag200_drv.h
>> @@ -392,6 +392,10 @@ void 
>> mgag200_primary_plane_helper_atomic_disable(struct drm_plane *plane,
>>       .destroy = drm_plane_cleanup, \
>>       DRM_GEM_SHADOW_PLANE_FUNCS
>> +void mgag200_crtc_set_gamma(struct mga_device *mdev,
>> +                const struct drm_format_info *format,
>> +                struct drm_property_blob *gamma_lut);
>> +
>>   enum drm_mode_status mgag200_crtc_helper_mode_valid(struct drm_crtc 
>> *crtc,
>>                               const struct drm_display_mode *mode);
>>   int mgag200_crtc_helper_atomic_check(struct drm_crtc *crtc, struct 
>> drm_atomic_state *new_state);
>> diff --git a/drivers/gpu/drm/mgag200/mgag200_g200er.c 
>> b/drivers/gpu/drm/mgag200/mgag200_g200er.c
>> index bce267e0f7de..38815cb94c61 100644
>> --- a/drivers/gpu/drm/mgag200/mgag200_g200er.c
>> +++ b/drivers/gpu/drm/mgag200/mgag200_g200er.c
>> @@ -202,6 +202,8 @@ static void 
>> mgag200_g200er_crtc_helper_atomic_enable(struct drm_crtc *crtc,
>>       mgag200_g200er_reset_tagfifo(mdev);
>> +    mgag200_crtc_set_gamma(mdev, format, crtc_state->gamma_lut);
>> +
>>       mgag200_enable_display(mdev);
>>       if (funcs->enable_vidrst)
>> diff --git a/drivers/gpu/drm/mgag200/mgag200_g200ev.c 
>> b/drivers/gpu/drm/mgag200/mgag200_g200ev.c
>> index ac957f42abe1..e698a3a499bf 100644
>> --- a/drivers/gpu/drm/mgag200/mgag200_g200ev.c
>> +++ b/drivers/gpu/drm/mgag200/mgag200_g200ev.c
>> @@ -203,6 +203,8 @@ static void 
>> mgag200_g200ev_crtc_helper_atomic_enable(struct drm_crtc *crtc,
>>       mgag200_g200ev_set_hiprilvl(mdev);
>> +    mgag200_crtc_set_gamma(mdev, format, crtc_state->gamma_lut);
>> +
>>       mgag200_enable_display(mdev);
>>       if (funcs->enable_vidrst)
>> diff --git a/drivers/gpu/drm/mgag200/mgag200_g200se.c 
>> b/drivers/gpu/drm/mgag200/mgag200_g200se.c
>> index bd6e573c9a1a..7e4ea0046a6b 100644
>> --- a/drivers/gpu/drm/mgag200/mgag200_g200se.c
>> +++ b/drivers/gpu/drm/mgag200/mgag200_g200se.c
>> @@ -334,6 +334,8 @@ static void 
>> mgag200_g200se_crtc_helper_atomic_enable(struct drm_crtc *crtc,
>>       mgag200_g200se_set_hiprilvl(mdev, adjusted_mode, format);
>> +    mgag200_crtc_set_gamma(mdev, format, crtc_state->gamma_lut);
>> +
>>       mgag200_enable_display(mdev);
>>       if (funcs->enable_vidrst)
>> diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c 
>> b/drivers/gpu/drm/mgag200/mgag200_mode.c
>> index af3ce5a6a636..d2a04b317232 100644
>> --- a/drivers/gpu/drm/mgag200/mgag200_mode.c
>> +++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
>> @@ -65,9 +65,9 @@ static void mgag200_crtc_set_gamma_linear(struct 
>> mga_device *mdev,
>>       }
>>   }
>> -static void mgag200_crtc_set_gamma(struct mga_device *mdev,
>> -                   const struct drm_format_info *format,
>> -                   struct drm_color_lut *lut)
>> +static void mgag200_crtc_set_gamma_table(struct mga_device *mdev,
>> +                     const struct drm_format_info *format,
>> +                     struct drm_color_lut *lut)
>>   {
>>       int i;
>> @@ -103,6 +103,16 @@ static void mgag200_crtc_set_gamma(struct 
>> mga_device *mdev,
>>       }
>>   }
>> +void mgag200_crtc_set_gamma(struct mga_device *mdev,
>> +                const struct drm_format_info *format,
>> +                struct drm_property_blob *gamma_lut)
>> +{
>> +    if (gamma_lut)
>> +        mgag200_crtc_set_gamma_table(mdev, format, gamma_lut->data);
>> +    else
>> +        mgag200_crtc_set_gamma_linear(mdev, format);
>> +}
> 
> Please keep this open-coded its callers. With that changed
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for the review, yes I will change that.
If no other comments, I will push it to drm-misc-fixes tomorrow.

-- 

Jocelyn
> 
>> +
>>   static inline void mga_wait_vsync(struct mga_device *mdev)
>>   {
>>       unsigned long timeout = jiffies + HZ/10;
>> @@ -616,10 +626,7 @@ void mgag200_crtc_helper_atomic_flush(struct 
>> drm_crtc *crtc, struct drm_atomic_s
>>       if (crtc_state->enable && crtc_state->color_mgmt_changed) {
>>           const struct drm_format_info *format = 
>> mgag200_crtc_state->format;
>> -        if (crtc_state->gamma_lut)
>> -            mgag200_crtc_set_gamma(mdev, format, 
>> crtc_state->gamma_lut->data);
>> -        else
>> -            mgag200_crtc_set_gamma_linear(mdev, format);
>> +        mgag200_crtc_set_gamma(mdev, format, crtc_state->gamma_lut);
>>       }
>>   }
>> @@ -642,10 +649,7 @@ void mgag200_crtc_helper_atomic_enable(struct 
>> drm_crtc *crtc, struct drm_atomic_
>>       if (funcs->pixpllc_atomic_update)
>>           funcs->pixpllc_atomic_update(crtc, old_state);
>> -    if (crtc_state->gamma_lut)
>> -        mgag200_crtc_set_gamma(mdev, format, 
>> crtc_state->gamma_lut->data);
>> -    else
>> -        mgag200_crtc_set_gamma_linear(mdev, format);
>> +    mgag200_crtc_set_gamma(mdev, format, crtc_state->gamma_lut);
>>       mgag200_enable_display(mdev);
>>
>> base-commit: 6c9dbee84cd005bed5f9d07b3a2797ae6414b435
> 


