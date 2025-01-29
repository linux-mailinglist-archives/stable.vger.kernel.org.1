Return-Path: <stable+bounces-111107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D83A21ABB
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 11:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038041888572
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 10:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C398191F92;
	Wed, 29 Jan 2025 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efCQwwYo"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECD2171CD
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738145450; cv=none; b=gC/5Yix7lDJL9LSGZnp98TE0ygkpgk2ONspfUhtX+xge0wJWUxeI917DovCGnxdOH1ffw0NFSdEbUMbcILAZBQpzQpqU3+JvV1QD5AjU6OQuPvhzDltLzXw7ts0eVEs6bYbUzsLT/6RiWJXJ22kANhTPTEKrr1cXMwLlpQnZTE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738145450; c=relaxed/simple;
	bh=2cmhX3SiaBDOmlDhoCnQW8LAo9uSMEqjwJRfVQ3bk88=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bzQH5WymEnJCnyqD3LNiPOsvngAxhWNuIXJeGLKUrmEgkosqoFJiMusfVbaPbMExXOB9d/0Fws7B3ZcAZRiQWZ829kX6INiQ44BSVT48TxbLaE1mOIuS4sZYBHA+dJJ1odko+DTemEtFPlyKVVoBrrdhc4K3Tzvu8gdMHYAfB3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=efCQwwYo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738145447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qZBAxKVcNOmMz7bK06WcrszPx+JkZyVjuNJwgFNHpPU=;
	b=efCQwwYoXxeHn3shsjZEjmi21NYZl0YOd6g36hNSGYMSIympeSg33hjqXXHLVQk0ttc4b0
	yFCCo8jcxAs6gjUlufGc+mdLup22j7T+Gdi+f8m1gWFJbTOvx6FeEknxgBJ0//Upzw4g3N
	cBDdIhKdkV7WY4CsVCSIaLKJjdB6zSo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-gDofOAZaORiMOi3-DHyd7g-1; Wed, 29 Jan 2025 05:10:45 -0500
X-MC-Unique: gDofOAZaORiMOi3-DHyd7g-1
X-Mimecast-MFC-AGG-ID: gDofOAZaORiMOi3-DHyd7g
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-436225d4389so2473955e9.1
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 02:10:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738145444; x=1738750244;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qZBAxKVcNOmMz7bK06WcrszPx+JkZyVjuNJwgFNHpPU=;
        b=VmYScX+v78u1TjSbgZziQ+RrcAoVFrmEYuGV1bkv7a//mZzrKYCIJD5rU1OFCPHfCU
         988VKbeaYeT8sKP3a5v1TF3vP4dm+ecPFxqX5U71NONY6Kn9q5VmAtzxrglAqoGitClC
         BmXGKmhP8GGSG7TVtmJq0njA/JzUZUD6jy9VSNaWkBEZPOO/2azmF0TWkl2pOe1Z6h3N
         UQA6JiysjflDR+cDrF2CzVI6gxe8WosuyA8A/xxPw7sijfntLfvafKYVK7sWglwxwhZt
         WtvWM+X2gmcWsJ+1un74wrEYd/eJrHwArFYj+anS57zaBe6UxmeJbcjUCpGKrgORE6vU
         NnMw==
X-Gm-Message-State: AOJu0YyMD7Iqh8ocJhKZk6fDLKreBvwRpUWD+5cBzRdZzGgXBU2yaU9J
	RMXPBVtNR4NnRyMOlPdHX+KOWSafOLp3fGjCx7AxE+UyMQl8XkWnel4QW9d26N13wgSVVRKQbyr
	pWTtf4EBepG+7opCFr0+fbZr1pfAy5n34kTwmoC2SROXi7Z2ix9cYZg==
X-Gm-Gg: ASbGncvGAWHs78dNBEg20uRbodVMxY0vGmNjFpCzzgwLMoIzn5Zb9EA0WSzxLauL81Y
	UKHxpEDbLYkdAIiNyFDwk0FIVr8Ic6bZGe0gmajsl+9UbMog+d3Nmz7+f9KH/ZL3IJRYsjMfzqC
	B6t7YSrp/1KD9wrVR13NpaD0F4yePfq0OcN0kRNRCM3sXsQzXEgnaLjGnvBOqekBWp+SJ7XNdZA
	ArO9u+PMLGvYLfYwCO6MykAJWGFQyOvgdEKUxpoZFQoKKcs0nqcplQeBb14xNdoTunn9p+ko5M1
	Bq6uNVGhB/zj0S7RVbv1hPmHZuAL2jixp+nKMq3QS3yW
X-Received: by 2002:a05:600c:4f0f:b0:434:fddf:5c06 with SMTP id 5b1f17b1804b1-438dbe8ca78mr21348585e9.1.1738145444646;
        Wed, 29 Jan 2025 02:10:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBPzW3m8objqfkQTJJB9YBCasvaC7BkSPKIlC03mwbU1xU7WmoynMSJnXRYI2mTeBYRgl58g==
X-Received: by 2002:a05:600c:4f0f:b0:434:fddf:5c06 with SMTP id 5b1f17b1804b1-438dbe8ca78mr21348295e9.1.1738145444306;
        Wed, 29 Jan 2025 02:10:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc13139sm17121495e9.3.2025.01.29.02.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 02:10:43 -0800 (PST)
Message-ID: <1972874d-50f7-418e-aeeb-a8b5a1c5f298@redhat.com>
Date: Wed, 29 Jan 2025 11:10:42 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/ast: Fix ast_dp connection status
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie
 <airlied@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20250124141142.2434138-1-jfalempe@redhat.com>
 <93bfabd4-20a8-4d56-898b-943dccb41df2@suse.de>
 <c0446bfe-5a06-47e1-b12a-3fae73365f36@redhat.com>
Content-Language: en-US, fr
In-Reply-To: <c0446bfe-5a06-47e1-b12a-3fae73365f36@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/01/2025 13:52, Jocelyn Falempe wrote:
> 
> Thanks, interesting that it doesn't affect all hardwares.
> I got reports from two different vendors about this issue.
> 
> If no other comments, I will push it to drm-misc-next tomorrow (only 
> adding reported-by: and tested-by: tags).
> 

I just pushed it to drm-misc-next.

Thanks

-- 

Jocelyn


