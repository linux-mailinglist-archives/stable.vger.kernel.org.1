Return-Path: <stable+bounces-37963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC15289F1E2
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 14:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7592A285D64
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 12:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1310D15B137;
	Wed, 10 Apr 2024 12:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3+tJcnx"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154C1155733
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712751540; cv=none; b=VZiyZ0dZuNtkvh4I6QIkwO59IOMKXJGKuqSSKSeO3zsnkIRmB/AaD87qD7MY9j1hABPidvh8lKpwfMHmOu5+2HVMq3cP/+VQcZF+AItgrpPPCDxMngMZ0FikB/Qy4DPZopuRhDfqFaLFnwM+XCTTRsZyUt21FAF+qVgMh5C/XJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712751540; c=relaxed/simple;
	bh=byys/lIDWjNClFwYa2FGoI08ARZ3w2eW/MMJTTl7lf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bxEpAsWZEM+Gc37zXaBZmfz9ubN0sGIwCskl1uNIyCqBv01YJ8RI9rY4N5JN+WoMkUOvZN/odpg+phEyI1F99389TEr7wCa+ERUPI+/IadFPzxJWaSBCAJx/Cixz5jjt3tZkuxWO8d7o+MM/1eFvgGDRFYSE6y3PiZs7MGkIwN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U3+tJcnx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712751537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=46LrrPp64WiWPNLe7QqFP1tIPhMl34xsYWDYBYEnKuA=;
	b=U3+tJcnx82cVcNyW4xesOF+84vLBw+d5dqcO6vDomK5WQXvbDSdF08HhoXsElSFK9zUwrX
	OsnIoGdm7KBj2RHuhjnsGyGxGki7tXJvxGmoxmb/Wx7+dqjtH4B5UmSsBF04aiq8iQXeGO
	YmLS8lCKEDmHo9A75H3P9k7mBWymcyU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-DDsHzvbCMxWu7jrmjgYYfA-1; Wed, 10 Apr 2024 08:18:56 -0400
X-MC-Unique: DDsHzvbCMxWu7jrmjgYYfA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-343c6bb1f21so3981363f8f.1
        for <stable@vger.kernel.org>; Wed, 10 Apr 2024 05:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712751534; x=1713356334;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46LrrPp64WiWPNLe7QqFP1tIPhMl34xsYWDYBYEnKuA=;
        b=dZqkIu98KBEOBi/Ciz0kDunvWmIy+58desODZqgYDLaXD3NZ5kYWu6C8nXzZE3usSz
         aOR0Slr5nADKK+KNlhv2FURkdb9Mk0eMvFwg9yXI/RAyNRwHq9FykrMwywjmQd2GwF6S
         zsATLLJWeEHmafdGwELtXbv7+0qGX60v0uZYFWz7Uvfky6z0diiBLBr5qTFKKIMWgMiZ
         x3eAy9XnWf+3oE2tnAUku7cK6gK6nHryb/AaPnoMEOOKSPgvd0xhu/r05UWwhqyMHtE3
         VU3fc8Tu/C8zKmwRK6EJY3kOWuwFEh2JyW/6Bf6Qd3kJEmCAZYoeFE/qXoj6nr6RRT3e
         7p8A==
X-Forwarded-Encrypted: i=1; AJvYcCUrNWT+rTHOJLxUY2Ac189MUPMyB1pJUSYTO8snaUv6xxSpgKjNlTWlVTDPlDx+TP6mgDICO67Q5n4cBGH+ey9RTcTxadWi
X-Gm-Message-State: AOJu0YzXF3Tj1XFCooxqUKeCfYqLQy3KLn71z2JDlsXylSaCtL6v/uCM
	lhjg7rGWvkT+gqwbAIdstbfQP11rwQ/lSSgCm40l2PvSnzBtTMO1CN5lMHk1LC892d2m/IU6au8
	c2nRfiQligOdHELPhJiLl1474760GrXIXHzd2jmtNHhpHGQY/NHYLMA==
X-Received: by 2002:adf:a38d:0:b0:33e:363b:a7dd with SMTP id l13-20020adfa38d000000b0033e363ba7ddmr1549962wrb.20.1712751534705;
        Wed, 10 Apr 2024 05:18:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECpl1L/oL4mnI82GvOzKPu/U7OJYDEiQinWbtlDFweKbfzg1DEEsIWDiBj0EEBB5P9zTRBxw==
X-Received: by 2002:adf:a38d:0:b0:33e:363b:a7dd with SMTP id l13-20020adfa38d000000b0033e363ba7ddmr1549950wrb.20.1712751534349;
        Wed, 10 Apr 2024 05:18:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:d5:a000:f101:edd0:5929:7a40? ([2a01:e0a:d5:a000:f101:edd0:5929:7a40])
        by smtp.gmail.com with ESMTPSA id m6-20020adff386000000b00343300a4eb8sm13584588wro.49.2024.04.10.05.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 05:18:53 -0700 (PDT)
Message-ID: <ea86e546-c804-4384-9cd1-82739fc6205f@redhat.com>
Date: Wed, 10 Apr 2024 14:18:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/ast: Set DDC timeout in milliseconds
Content-Language: en-US, fr
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com
Cc: dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, stable@vger.kernel.org
References: <20240403103325.30457-1-tzimmermann@suse.de>
 <20240403103325.30457-2-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20240403103325.30457-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Thanks for the patch, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

-- 

Jocelyn


On 03/04/2024 12:31, Thomas Zimmermann wrote:
> Compute the i2c timeout in jiffies from a value in milliseconds. The
> original values of 2 jiffies equals 2 milliseconds if HZ has been
> configured to a value of 1000. This corresponds to 2.2 milliseconds
> used by most other DRM drivers. Update ast accordingly.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 312fec1405dd ("drm: Initial KMS driver for AST (ASpeed Technologies) 2000 series (v2)")
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Jocelyn Falempe <jfalempe@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v3.5+
> ---
>   drivers/gpu/drm/ast/ast_ddc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_ddc.c b/drivers/gpu/drm/ast/ast_ddc.c
> index b7718084422f3..3e156a6b6831d 100644
> --- a/drivers/gpu/drm/ast/ast_ddc.c
> +++ b/drivers/gpu/drm/ast/ast_ddc.c
> @@ -153,7 +153,7 @@ struct ast_ddc *ast_ddc_create(struct ast_device *ast)
>   
>   	bit = &ddc->bit;
>   	bit->udelay = 20;
> -	bit->timeout = 2;
> +	bit->timeout = usecs_to_jiffies(2200);
>   	bit->data = ddc;
>   	bit->setsda = ast_ddc_algo_bit_data_setsda;
>   	bit->setscl = ast_ddc_algo_bit_data_setscl;


