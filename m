Return-Path: <stable+bounces-96059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44679E05B9
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80AAD16D9D9
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC763209697;
	Mon,  2 Dec 2024 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V87mOW6I"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCA1209692
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150041; cv=none; b=F+HpCSkV5aLGHEMbmsf1U10OcavXs+9gFIfws6Td31FCvUAApamdVf/c6knI68eciNnpFNIG3et8ABXo/aDsHQLZvIRJX+mJU0474YJpYXmKPgeA1tZdEyGfZIPvS3rIK7RFt3Xz4yT5UwEFBr2Mg+x0xRYQJw7CCCYd/UNIduw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150041; c=relaxed/simple;
	bh=pPSluDrPZolihQ9FF0FDY4FMT7vtIp8TVNy3EC6ESfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fWi/xisXtLIFPFkJkTxQoEju/Cpo7ojFBJNBm2/Ta+17VPLtj52Maui/bqAUm1UgKSxzImRLp4iA6DzvQSiJv/2sFsY74BqDmLEaO104uzRa+4TM2Z53mOKs9/nGd1hGLnfGvwKsdMPEcNbzZZ5SIAsonSX7jNFJ04NyYUfCWoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V87mOW6I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733150039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J6Xej+sefl62+HuZJ02rOMvYBMjieqyUp/Rq6GPi75M=;
	b=V87mOW6Il4PA4jmBa4MRvyMBObr7f0EwxpjR1hwGBlMVSix/CtRJG49PArTVW/uYa3upqt
	w99qsjewTTaet0VCvgd1Qm6MibPxA3vFAyC9gbW7ScGfKIcm0JwAzPVK5mrREtvTUDoxHk
	OZeuOUMY6gxKwtvaG79E4+c2U27W684=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-BOAUuAwjP9ilFGEP3SNBOg-1; Mon, 02 Dec 2024 09:33:58 -0500
X-MC-Unique: BOAUuAwjP9ilFGEP3SNBOg-1
X-Mimecast-MFC-AGG-ID: BOAUuAwjP9ilFGEP3SNBOg
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5d0b5036394so2233924a12.3
        for <stable@vger.kernel.org>; Mon, 02 Dec 2024 06:33:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733150037; x=1733754837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6Xej+sefl62+HuZJ02rOMvYBMjieqyUp/Rq6GPi75M=;
        b=mRHPMNEoZAHMSSzL3G/f8C7M0G+vZ9HSWj78pQQH78Ud4eB2Yn2aci8tvIat6J7sLF
         lTQhaHTG++9YIX/WwR0pYZjKJmRsrlg3Abfofgv2j6ZlbXpAPn57LSWSAWzMH2d/81u6
         S4Y1HX8GYaYoWxXsmXzve7al6AnSFX4sqfqdTf8N3De0lyXCpCGBLx7oxFZX9QQjuFFl
         jVSk9YyzNLSvSWjE68nxeirQZu1cCuhO80/O62OEJ+nuGR/WoHr9ilYcEs8dlJ0/f5Tg
         wWO7vwV/XXftgVCRruTOqETU7rsVwoCQQN3xHIjQtRjjCmJJbT954Wtp3wpAz695MdUI
         hqHw==
X-Forwarded-Encrypted: i=1; AJvYcCU6nR6IoaJEG0ASeYIetspjvfVHQHIVsZmUs1SQuNv4uFzDecMUtzU+1ceMXW7FgqmJZdHpkcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb/PfFC1RM0YCD+b3b8nxip4/j3/LZ7WdHjTkejn8OleUdLCcx
	tya5C09MIsh10GV0VJYPFIBC7C5w8RNHnYiHQHbqCw2tlWrDntvEvnQsLmswZ9Jiq6ZznzA21z0
	M3SQ590LkiwDUa7hGrboGX7+3Ukn2iF88Qa+SQhr0CCJSkwEZxfm2xA==
X-Gm-Gg: ASbGncufPawCLHUIAjLtBStkAHMCk0UWRcEsriq86IcQIicA0p1AxdsglNbokJncoMR
	MImAGZecjuPFQTBSV0sAHYDNb7yiNYM8GP4vKgN1dq0qNjYkkZ9qBOrLrIooDO5B1uc3LZxkZnb
	DSgJ6T8a4GkS/VCBUGU/dIpk9UnKiNnXczos5L9+YJXLMHDYC/+oTTDnCi1rnJOMbVE5cI7rELT
	sXxpFfplfhf350mjbeWMxlH6lUnfsKv6SqBzdva6C2gAqbEM09x8A==
X-Received: by 2002:a17:906:3114:b0:aa5:427e:6af6 with SMTP id a640c23a62f3a-aa580ef3240mr1773025466b.3.1733150036774;
        Mon, 02 Dec 2024 06:33:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPHol0jCmNI2H8UjxKDJtgKrB4os1/jOlRU53xbQS9RZk2bYe0rO/MZNOZt8QSSYzr7GbqJw==
X-Received: by 2002:a17:906:3114:b0:aa5:427e:6af6 with SMTP id a640c23a62f3a-aa580ef3240mr1773021766b.3.1733150036328;
        Mon, 02 Dec 2024 06:33:56 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599953f7esm512624166b.191.2024.12.02.06.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 06:33:55 -0800 (PST)
Message-ID: <6acfcc52-c547-4823-b8e2-4555ddc64085@redhat.com>
Date: Mon, 2 Dec 2024 15:33:54 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] media: uvcvideo: Only save async fh if success
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241202-uvc-fix-async-v5-0-6658c1fe312b@chromium.org>
 <20241202-uvc-fix-async-v5-1-6658c1fe312b@chromium.org>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241202-uvc-fix-async-v5-1-6658c1fe312b@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2-Dec-24 3:24 PM, Ricardo Ribalda wrote:
> Now we keep a reference to the active fh for any call to uvc_ctrl_set,
> regardless if it is an actual set or if it is a just a try or if the
> device refused the operation.
> 
> We should only keep the file handle if the device actually accepted
> applying the operation.
> 
> Cc: stable@vger.kernel.org
> Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thank you, nice patch, better then my original suggestion :)

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I'll let this sit on the list to give others a chance to reply
and if there are no remarks I'll merge this next Monday.

Regards,

Hans



> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 4fe26e82e3d1..9a80a7d8e73a 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1811,7 +1811,10 @@ int uvc_ctrl_begin(struct uvc_video_chain *chain)
>  }
>  
>  static int uvc_ctrl_commit_entity(struct uvc_device *dev,
> -	struct uvc_entity *entity, int rollback, struct uvc_control **err_ctrl)
> +				  struct uvc_fh *handle,
> +				  struct uvc_entity *entity,
> +				  int rollback,
> +				  struct uvc_control **err_ctrl)
>  {
>  	struct uvc_control *ctrl;
>  	unsigned int i;
> @@ -1859,6 +1862,10 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
>  				*err_ctrl = ctrl;
>  			return ret;
>  		}
> +
> +		if (!rollback && handle &&
> +		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
> +			ctrl->handle = handle;
>  	}
>  
>  	return 0;
> @@ -1895,8 +1902,8 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
>  
>  	/* Find the control. */
>  	list_for_each_entry(entity, &chain->entities, chain) {
> -		ret = uvc_ctrl_commit_entity(chain->dev, entity, rollback,
> -					     &err_ctrl);
> +		ret = uvc_ctrl_commit_entity(chain->dev, handle, entity,
> +					     rollback, &err_ctrl);
>  		if (ret < 0) {
>  			if (ctrls)
>  				ctrls->error_idx =
> @@ -2046,9 +2053,6 @@ int uvc_ctrl_set(struct uvc_fh *handle,
>  	mapping->set(mapping, value,
>  		uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
>  
> -	if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
> -		ctrl->handle = handle;
> -
>  	ctrl->dirty = 1;
>  	ctrl->modified = 1;
>  	return 0;
> @@ -2377,7 +2381,7 @@ int uvc_ctrl_restore_values(struct uvc_device *dev)
>  			ctrl->dirty = 1;
>  		}
>  
> -		ret = uvc_ctrl_commit_entity(dev, entity, 0, NULL);
> +		ret = uvc_ctrl_commit_entity(dev, NULL, entity, 0, NULL);
>  		if (ret < 0)
>  			return ret;
>  	}
> 


