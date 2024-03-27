Return-Path: <stable+bounces-33021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 409A788EE5A
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 19:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F007E29DD8A
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 18:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE46B14D6EB;
	Wed, 27 Mar 2024 18:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKSKVdXw"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F02012EBC4
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 18:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711564582; cv=none; b=evxsPC7FM33Ea0YL76q4UAI2wk0z4DAma0AL6nCEewT+8WndB/kI1ZaFAVS9fCoRR7RHmGaN+lpYOVKbLIu7kQf9rr+CNQPOZGs4g9Jasa4E0J/13Sld1dfptpn86368RDf5qen1RqpIBLC32zkPYcoqmU3KldgqYxfZ43/qIKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711564582; c=relaxed/simple;
	bh=6hBEjPmpgX5lKfL87UHkSOFD1SSOGCuu4G8/WS5wYuo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RkAsRy5oeEgIeghf5EeSIyTQ4BWjm4VHPqmFLFJ/lRgQNNj2iZyF3DoUyU7Xp2hNRDXIl5/QI3mGyXvv68dkeJ9mGk63/iEvqc2e6AtGDuuqIPWo4pfI+shSukWhcZyUvSfI4B3ICxy8SmAhOBVFpm/khONtnEQe5DUnmjRYDtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YKSKVdXw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711564579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I2bWCFj1GfAC/Cxgd7TgQ+aEXofAsAoNiK6GdlWrPsA=;
	b=YKSKVdXwcRson37P8kSQVE7I97D5AbB3plwp3K1OAkKxYIsEqOF9KCpKmWxEewRPMCxWn7
	anHTB1x/m1kJLTY3O7aoxLSwG0ZYLVNopnP1nkg8CNlWswslnKxFfyGVfR7vgLk5JFwfra
	RlSlQ44QIKd/EtSIbnu3qB+2jOmhDyQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-B4Top9XyNmeB4cp8DMum9A-1; Wed, 27 Mar 2024 14:36:16 -0400
X-MC-Unique: B4Top9XyNmeB4cp8DMum9A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41401eef944so547275e9.2
        for <stable@vger.kernel.org>; Wed, 27 Mar 2024 11:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711564575; x=1712169375;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I2bWCFj1GfAC/Cxgd7TgQ+aEXofAsAoNiK6GdlWrPsA=;
        b=MLFKGjFxDpCcGY7JJMUb96hj4hWgb8VnmzC0h+4CXB9sHQcBPxekPm/G10Net0n8So
         ijPK7N8aX369rfMYvT6eBuU8EJcQNhlvNlcetx0sFZKNPN8FF56rZbpLTSsjsJsWVaCY
         +cP+fKkFriBjuvIOmlf2Y2YPuFxATJq3RdSB+FoLSEoYJ4M5mK1cI1ptP7tqisFEplYC
         Z3HGjzjrH8GIHHYcsG82LB6XE6O0eA/oVReV02Uwh38tWjprR9Tkkf/vM4mIvspNXzNR
         ACzyklFen2IfEYuCw/FeSR69Buq9DVj4cIoMIgyC4g8j+M2spNfCrKwpbLibWWyOJL9e
         ocJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJypb7hYN2LXeSh29pPne2gJPXrjwnwbGL54BmL8rQXki/VC/P3e5cHG7ZGfL+zUNV14YT1v6MXCqdxwjND2yRsHUchZMz
X-Gm-Message-State: AOJu0YwoPTZYLHs8wBYjbbbdtz/tOAZ+/Mixq+rJhtdyeZF4lOGoW1jY
	F8PTcNpadCCze/g/V+keuYJrPKKlMylZiW8iyW5qdWyeceO33I9q4u9rQhvT86mqhkYNQMEHGf2
	yyS12VF5/ul+0iWurWZcob9KVyksCRH4U7zHAwmC6Z3QT4VAk5YeDpA==
X-Received: by 2002:a05:600c:4748:b0:414:90f6:c1 with SMTP id w8-20020a05600c474800b0041490f600c1mr687595wmo.8.1711564574828;
        Wed, 27 Mar 2024 11:36:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWcy9rj2bdTKILB+xfS8iDvvjLilRgDDG3BuxZpWUQR8XykYQYuWLOJgSMt+IQnmoDqECnZQ==
X-Received: by 2002:a05:600c:4748:b0:414:90f6:c1 with SMTP id w8-20020a05600c474800b0041490f600c1mr687575wmo.8.1711564574390;
        Wed, 27 Mar 2024 11:36:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c468600b0041477f3f99fsm2883688wmo.30.2024.03.27.11.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 11:36:13 -0700 (PDT)
Message-ID: <662d7dbd-4614-4621-bc68-a85ba644cf51@redhat.com>
Date: Wed, 27 Mar 2024 19:36:13 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vmwgfx: Create debugfs ttm_resource_manager entry only if
 needed
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com,
 tzimmermann@suse.de, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, daniel@ffwll.ch, stable@vger.kernel.org
References: <20240312093551.196609-1-jfalempe@redhat.com>
 <CABQX2QN729DjtdOzAS9jeEP_xHXT4zNaOcP59pa-KyXnME=xaw@mail.gmail.com>
 <0e1ed380-a25a-4a57-9395-56a13bf298c8@redhat.com>
In-Reply-To: <0e1ed380-a25a-4a57-9395-56a13bf298c8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I just pushed it to drm-misc-fixes.

Thanks for your reviews,

-- 

Jocelyn

On 14/03/2024 09:14, Jocelyn Falempe wrote:
> 
> 
> On 13/03/2024 18:57, Zack Rusin wrote:
>> On Tue, Mar 12, 2024 at 5:36 AM Jocelyn Falempe <jfalempe@redhat.com> 
>> wrote:
> [...]
>>
>> Thanks! That looks great. I can push it through drm-misc-fixes.
> 
> Thanks,
> 
> I think I only forget the "drm/" in the commit title, but yes you can 
> push it with this small correction.
> 
>>
>> Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>
>>
>> z
>>
> 
> Best regards,
> 


