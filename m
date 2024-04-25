Return-Path: <stable+bounces-41469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E848B2A9F
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 23:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA3D2844DB
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 21:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BA51553BF;
	Thu, 25 Apr 2024 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YVZ0RW8b"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0D3153812
	for <stable@vger.kernel.org>; Thu, 25 Apr 2024 21:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714080269; cv=none; b=d2HLrovKgD8po2HOs/v63IyriT2CyNvh34TVFmre+YG1qA1T+MJtXNP9oLkcpf819vWvhEMoUW5NEpQpLu8idWAu2naSa2i5juHnjtyvIm8E7byqEMFBfan9QhvLrJ5G10LQy8xoeD98IbwhK9x01AhbMLcERTX+IaO5TtbMsmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714080269; c=relaxed/simple;
	bh=7hgElzkGGU4LOW+W09DF7A1KIdz9b4uk5d/lmNS5l4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l3v5vDYCf+nz4nf6vIzlBdJMuB1xBQH0osqF9hjTIQkkKA46Pdun1xYCJUpas5x+8W+FvnVqc/UoV9xNGPwR1e0U6Ylmgp+30G07vS1ALq8ooXFlHA/lGMQ/Li3P8FrJSeYEfsjk78jAkYhY0QOTStHs+hI0HbrIkBe8trRKWoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YVZ0RW8b; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f0b9f943cbso1391886b3a.0
        for <stable@vger.kernel.org>; Thu, 25 Apr 2024 14:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714080267; x=1714685067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ra+gBoWOeuJuI+Ezc3sgY9mFyzgfI39aGWs6cfLFtkw=;
        b=YVZ0RW8b2YU0w5ikFhI1oKRO3CtsVJwztxuMBahCWDlEkk6G/7C11aeFzT41+UfbGO
         2uwbJ+4PQUCXyHzAkJSuciA8R6d7Yp/QaolOsZgKPZwNicVY/YaRMOnvR91q8P+Slw4H
         WQsZluYKYrl9m2Uj2PVX24FnSGaIUn9pp+2L8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714080267; x=1714685067;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ra+gBoWOeuJuI+Ezc3sgY9mFyzgfI39aGWs6cfLFtkw=;
        b=Btc0YXd9eQTfgo8rBaCirEeIqF2rraFagwK73pv8SEDGvGzXuUQvwsHT4IZbdMtuL5
         0TL2OIqyzbzLFqKm+2W/PD42klNamt/LDq9lfTIClo5fwFwTau0CewCLef9j2bxbJa6+
         wdEA5u08v+1sNBHD8cK26t8JpfSQGJDWGO/EdSOQ7b2THwTrM9gJ2F6JI7GXdcEfUHih
         vhEAf0lGxMR2nMYXZ2mkivhkelEp67tblaf39tsb3LvjN3Aq04TFwGJ3jxxMxgsC5UG2
         mXr1xkuwe3R/MMwj8c6knH0swQWyDl65EXEtjg/iCnU5K+EVap0JnVyLYTPD+0J6Bi5Q
         ulhg==
X-Forwarded-Encrypted: i=1; AJvYcCVVtGaVsFGqLMgQgV98jNkw4eVpXeo0voU0vceFTBNsz8sM/lVgebbsTJCIRA+b3lHASQ/N2CPebLyJqOomaSwDg1+m7RIY
X-Gm-Message-State: AOJu0Yyi52wwdQGv0xqjbIslOGDS/pQ9WeOVDAz4GvX7zUBit04xcI8W
	dRUMnD9lOz9R4INQBMTFAqWyu7/aXqxOeLsXfCBlsMopbl4xPLj6rvccqSDnNw==
X-Google-Smtp-Source: AGHT+IFjRI1KL92CI5//kxL5g2K5AdC261aXqb0p/mvglOwYKbX0B59aSLlt6Vxzy9YL74iEhxcDrw==
X-Received: by 2002:a05:6a20:d41f:b0:1aa:9c29:b98d with SMTP id il31-20020a056a20d41f00b001aa9c29b98dmr968628pzb.24.1714080267556;
        Thu, 25 Apr 2024 14:24:27 -0700 (PDT)
Received: from [10.211.41.59] ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902d50100b001e2b8c91f04sm14230143plg.22.2024.04.25.14.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 14:24:27 -0700 (PDT)
Message-ID: <e2569ac9-85ba-46b2-a285-161ddf3b3cd3@broadcom.com>
Date: Thu, 25 Apr 2024 14:24:25 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vmwgfx: Fix invalid reads in fence signaled events
To: Zack Rusin <zack.rusin@broadcom.com>, dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, ian.forbes@broadcom.com,
 martin.krastev@broadcom.com, zdi-disclosures@trendmicro.com,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240425192748.1761522-1-zack.rusin@broadcom.com>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <20240425192748.1761522-1-zack.rusin@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/25/24 12:27, Zack Rusin wrote:
> Correctly set the length of the drm_event to the size of the structure
> that's actually used.
> 
> The length of the drm_event was set to the parent structure instead of
> to the drm_vmw_event_fence which is supposed to be read. drm_read
> uses the length parameter to copy the event to the user space thus
> resuling in oob reads.
> 
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> Fixes: 8b7de6aa8468 ("vmwgfx: Rework fence event action")
> Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-23566
> Cc: David Airlie <airlied@gmail.com>
> CC: Daniel Vetter <daniel@ffwll.ch>
> Cc: Zack Rusin <zack.rusin@broadcom.com>
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: <stable@vger.kernel.org> # v3.4+
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_fence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
> index 2a0cda324703..5efc6a766f64 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
> @@ -991,7 +991,7 @@ static int vmw_event_fence_action_create(struct drm_file *file_priv,
>  	}
>  
>  	event->event.base.type = DRM_VMW_EVENT_FENCE_SIGNALED;
> -	event->event.base.length = sizeof(*event);
> +	event->event.base.length = sizeof(event->event);
>  	event->event.user_data = user_data;
>  
>  	ret = drm_event_reserve_init(dev, file_priv, &event->base, &event->event.base);

LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

Thanks,

Maaz Mombasawala <maaz.mombasawala@broadcom.com>

