Return-Path: <stable+bounces-146370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D75FAC4010
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 15:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CE537A9AEE
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 13:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C5B202C5D;
	Mon, 26 May 2025 13:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5sLfTHG"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD0D1FFC4B
	for <stable@vger.kernel.org>; Mon, 26 May 2025 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748265132; cv=none; b=AuEiW1iYuaBJVaRqYlj8SjAg0e3B0BMRGbXjX3t7xlmixzEr3EirdYKWm+5WaklgRssIagVSjZ0GZFr8007aePt7PcT3pVnlTc8mRoHWBOcRa0tYRRnrc7uHvbNF1i16a8RSgeazpaOs6UDgxJLK4SiMRBBgEHPYKQm8XoblU9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748265132; c=relaxed/simple;
	bh=44bXjYgEx472ZLSVxB8lwvgofdNnAFTyYjXw5ZsM7p4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i7E2v2pgIkDHb5kv1fhpoeVbtYWcCgcCD+wLyPN7DY7SeMXVfS85Uq0PQuoz2+QLkrMldUXqHAjbv67Ej1sKKrHQIXkb5pzCSNe7h/DrkAqPlAP4cIZAPTNsgeK7UyOO989tysW1wgQEGIMWpv4hiXp73rvVdqWhiP1ZppJpWcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q5sLfTHG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748265129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xq9c/4s+1JsjImWn/4Dy2VS9W8X+CykJQ3FUvjdqC4o=;
	b=Q5sLfTHG0RnVFe0GZ6yitAYAfZsXPsgnghR75dW4Pev16vWv88u8LvSbYTRKpviYcwxpl/
	beXcafZZv0Mjibuut7jYNnjUbI5//5xlqdAgtcRur/8ZEuIT5HkVMXAqI8HkPlhx3lLLyo
	1RhUjJyYYL+KGF0zZoAlAM+91pYYFOM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-JqUoottpMByAOFIgJoDZlg-1; Mon, 26 May 2025 09:12:07 -0400
X-MC-Unique: JqUoottpMByAOFIgJoDZlg-1
X-Mimecast-MFC-AGG-ID: JqUoottpMByAOFIgJoDZlg_1748265126
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-acb61452b27so176039666b.2
        for <stable@vger.kernel.org>; Mon, 26 May 2025 06:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748265126; x=1748869926;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xq9c/4s+1JsjImWn/4Dy2VS9W8X+CykJQ3FUvjdqC4o=;
        b=P/kxoGgRD0jz20/NPjYcWNrDxWjiJ4bumPld3nMtK1X0o++kqPeSaw3LgR0/NlGnYj
         1WBENkdnABxNMWSQbTDGpf+EBYCfuULEoaN4nq1UuCqSh+N7RadQS1c1rAFey0/8uAe0
         fr8XIU9lb/agVR6ODVuIYp5hJOhpOQ8jEwHKvSKk6ssjOzynU7l+jlwLHfNmMaXClybU
         COJjP0ZuChTo93ELTZaK0qg2ZbKEtiv98GPVk2j0Uxx8Om1L4L/poNrtY/wwAbIBcl/T
         F14cCNhngDIh/kZQQGoEAvi1GzBHmOSu1oi6BpE5pQ5n/ZrnXZfn8a9K0GLmvsa4N3wK
         5VIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuCqP18+K6BBWvT0oXf75R3ZQMobgc0z0XO4thXrtX8o2RJ43/3vX2cSItXRHLrWtP5Zeiojg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlS48IPkFcztqPOFGMkmudhNuPpIHd1uGxOxl6ZwIY81CGXT3N
	5Xm03xpuE76pYA41fohB6YGq8JFddfzKV+M8bIjHX22zBMrvXc4ktkf+JrX+rRi6JqCaz+q0InQ
	RC4u1em7CZ3/pMxFTjF3DaSQKy4qURdcDuxDhJRIzP1zam2/YM+/BpvyCtw==
X-Gm-Gg: ASbGncsUx2edQfz5N9B/dp9s7Sb3RVSqZ3TqlT3pE0lkXgzaFR5+3iUdmeo3zDN0lIk
	+XKdzCAqGELNMGhKTWlL/3l+ijowDaNHOTdFSTHO1JGENbhc7B65oFKk1tB4JG+TEpisRYUreNU
	TElTbt9mU9T96lLoQlNGtXej0kQ1i0qRISWi2zXFtwF68qsfRA2WpgZbGeNOyRahMmuVEnwmH/N
	psknPIdut9iMDXIEFRCrrxDc2TgQ2oTiyoLI7AHao45MCXKLC17wohGY00/v/9xJ558S4n8IW5S
	aXNs0YU5uN62mzY=
X-Received: by 2002:a17:907:c26:b0:ad2:43b6:dd6d with SMTP id a640c23a62f3a-ad85b051c94mr849211666b.12.1748265125718;
        Mon, 26 May 2025 06:12:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTalOSdIadkbqa2qSmFa/eDGnX0/I30Frc7K2IlJnfyDCKJR+uuIozDsv6EgrW7jIXkRBXUA==
X-Received: by 2002:a17:907:c26:b0:ad2:43b6:dd6d with SMTP id a640c23a62f3a-ad85b051c94mr849207766b.12.1748265125351;
        Mon, 26 May 2025 06:12:05 -0700 (PDT)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d04b073sm1662864566b.27.2025.05.26.06.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 06:12:04 -0700 (PDT)
Message-ID: <7ff90036-a890-40d5-9305-72c0debb3594@redhat.com>
Date: Mon, 26 May 2025 15:12:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] media: uvcvideo: Do not mark valid metadata as
 invalid
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250404-uvc-meta-v5-0-f79974fc2d20@chromium.org>
 <20250404-uvc-meta-v5-1-f79974fc2d20@chromium.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250404-uvc-meta-v5-1-f79974fc2d20@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4-Apr-25 08:37, Ricardo Ribalda wrote:
> Currently, the driver performs a length check of the metadata buffer
> before the actual metadata size is known and before the metadata is
> decided to be copied. This results in valid metadata buffers being
> incorrectly marked as invalid.
> 
> Move the length check to occur after the metadata size is determined and
> is decided to be copied.
> 
> Cc: stable@vger.kernel.org
> Fixes: 088ead255245 ("media: uvcvideo: Add a metadata device node")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

Regards,

Hans



> ---
>  drivers/media/usb/uvc/uvc_video.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index e3567aeb0007c1f0a766f331e4e744359e95a863..b113297dac61f1b2eecd72c36ea61ef2c1e7d28a 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -1433,12 +1433,6 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
>  	if (!meta_buf || length == 2)
>  		return;
>  
> -	if (meta_buf->length - meta_buf->bytesused <
> -	    length + sizeof(meta->ns) + sizeof(meta->sof)) {
> -		meta_buf->error = 1;
> -		return;
> -	}
> -
>  	has_pts = mem[1] & UVC_STREAM_PTS;
>  	has_scr = mem[1] & UVC_STREAM_SCR;
>  
> @@ -1459,6 +1453,12 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
>  				  !memcmp(scr, stream->clock.last_scr, 6)))
>  		return;
>  
> +	if (meta_buf->length - meta_buf->bytesused <
> +	    length + sizeof(meta->ns) + sizeof(meta->sof)) {
> +		meta_buf->error = 1;
> +		return;
> +	}
> +
>  	meta = (struct uvc_meta_buf *)((u8 *)meta_buf->mem + meta_buf->bytesused);
>  	local_irq_save(flags);
>  	time = uvc_video_get_time();
> 


