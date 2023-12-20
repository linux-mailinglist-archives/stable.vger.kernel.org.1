Return-Path: <stable+bounces-7974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B52D819F7C
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 14:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15FF92872F5
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 13:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69A524B2C;
	Wed, 20 Dec 2023 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLWp91ie"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1707636AF0
	for <stable@vger.kernel.org>; Wed, 20 Dec 2023 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703077595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JcDrbjyjMazetuP2IXFq19+KBQ/5Rh6HiivXC6HpT8A=;
	b=QLWp91iev6Qa/la6/Yj6I7bobn1xUV9HSE21UmMuqCby6Qzg/OpCd7GxjlkPUnsiWL+G0i
	i8lrnRrkhm3npTv13sgvw/o7EIhgoPb6btb3Z9EVn94GG2xFikUEzR489nKtTsK8g0Oxyt
	Ciw8EGfdgAcSdT8uZxRMuOSqUJFyTxE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-zrJie5wXPBaZgiDutnlC4w-1; Wed, 20 Dec 2023 08:06:33 -0500
X-MC-Unique: zrJie5wXPBaZgiDutnlC4w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40d39bbe215so1553445e9.1
        for <stable@vger.kernel.org>; Wed, 20 Dec 2023 05:06:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703077592; x=1703682392;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JcDrbjyjMazetuP2IXFq19+KBQ/5Rh6HiivXC6HpT8A=;
        b=pSIre4f39jGWUW1Lc1L1+E9gGuMNbRkSc6/+juQsbsLB4Un4GjEMoz+PZaAlAva7pb
         pCDZgAayaIxvXJMAIvRHzOnDItekqOY5UJy3TebSqqsg1iUQ5dnKR+hHdjTmGGm+slv6
         xKY4al8MrmrZskfLHjID5H10Cp7cTiHvshdb4l2h3qnWvU4gWT0rmHZx2eM/PhhR6Wm3
         mQ2HFzMAZA5DwYzAuSS3gcxc3E62pYcQLZQG3revjDlxSv6qx3OlJXT8Ky7xxQf274Bq
         uU68p1d3Vj3U3IsdmW8OI7/PHPDCLBbam4VDxQOWf7YCKeCke8Xge5o7HZNDWGrRnruU
         UGAg==
X-Gm-Message-State: AOJu0Ywg7fVUrhivmMK7rPqG8779iLLP0Ns62gIDCUT8EIlSjzg9Mnoh
	eOXyInYa1FXjZKQHS/nm0kvkZU4NizR04ih8kwW2Hi5HyGmrWEEDv0/LvS1ckA2UMVJtYeazwY3
	/01J5gohLrPM9LNtO
X-Received: by 2002:a05:600c:35c5:b0:40d:2399:e8ab with SMTP id r5-20020a05600c35c500b0040d2399e8abmr1373985wmq.119.1703077592267;
        Wed, 20 Dec 2023 05:06:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRoNwYKhAj9t3QDcijJmqblCCgPo565UJi8JqwdyfEV+aS8fatsnVqDe5IgX5UWy1Iu5IsxQ==
X-Received: by 2002:a05:600c:35c5:b0:40d:2399:e8ab with SMTP id r5-20020a05600c35c500b0040d2399e8abmr1373972wmq.119.1703077591912;
        Wed, 20 Dec 2023 05:06:31 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b0040c03c3289bsm7180907wmq.37.2023.12.20.05.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 05:06:31 -0800 (PST)
Message-ID: <3b2fbb7f-3243-4f98-90bc-edb1b4db2bb4@redhat.com>
Date: Wed, 20 Dec 2023 14:06:30 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mgag200: Fix gamma lut not initialized for G200ER,
 G200EV, G200SE
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 airlied@redhat.com, daniel@ffwll.ch, javierm@redhat.com
Cc: Roger Sewell <roger.sewell@cantab.net>, stable@vger.kernel.org
References: <20231214163849.359691-1-jfalempe@redhat.com>
 <641bc7e1-5c13-4af1-ae2e-8cdc58ee92a9@suse.de>
 <beec3b5d-689a-4b25-be4b-9ff7532bb2e6@redhat.com>
In-Reply-To: <beec3b5d-689a-4b25-be4b-9ff7532bb2e6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I just merged it to drm-misc-fixes:

https://cgit.freedesktop.org/drm/drm-misc/commit/?h=drm-misc-fixes&id=11f9eb899ecc8c02b769cf8d2532ba12786a7af7

Thanks,

-- 

Jocelyn


