Return-Path: <stable+bounces-188332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 222FCBF6779
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 14:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB9A405A9E
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 12:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078EB2F2909;
	Tue, 21 Oct 2025 12:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5f5FCtJ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3589832E73D
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049941; cv=none; b=ZsXTdeKvSVvCRjD7iUNhNIPIyyztHPhmCDo3LmJgGE+4Y0bcBf7f58fAncQxp1CUOHf8kezq8BjwbyHJ7+fEGmf9AqUXttc/Jl4Y/Y8lH85iPlxXR1grTQYxFokO3nVXNGDZXW4EMdfoAdynw0vyddjweMD7mB1eiT7JT7j9Jy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049941; c=relaxed/simple;
	bh=ccp1VoQpjJs+I5YqP3Z87X9N7Yw3gj2MXIMQRc8Nclw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uDAW2KevvAeRm0FKngUguYIUAPhlobzUX8G+RNZ3gOpmCH0fI73OHgaIQGhOdsmKBUpJX9IjwP+lwL1c2e3rBb/wb/ypcFDr3UmfDbBYye4bGtCtd8byyxeAlYAlKhZHulPXlOvvYlVZ9UYt85vktgREoaoW8CyQEwKEsti174E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q5f5FCtJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761049939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=snHXFbUKVcqPgriwKGeD9+p0jAafcLSmWXFrDke0XWU=;
	b=Q5f5FCtJJGGvLTlc5sBqaZpeBhHJfR9TXIEvFTOO9GXaKFCyVkd8bvlR3TTrQmi4TCfI9v
	qe7Cs24QAMvzSefti1RGLNeju19CLSkid8CfRcEnolbXNn1tzpBjm8kX+oNksmpyrOPAEz
	OPG5FrnQGqoOiL43egViHjcM9/WZvMQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-XYtgPOEzNwCZrF5KPQyPuQ-1; Tue, 21 Oct 2025 08:32:18 -0400
X-MC-Unique: XYtgPOEzNwCZrF5KPQyPuQ-1
X-Mimecast-MFC-AGG-ID: XYtgPOEzNwCZrF5KPQyPuQ_1761049937
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3f6b44ab789so2890417f8f.3
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 05:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761049937; x=1761654737;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=snHXFbUKVcqPgriwKGeD9+p0jAafcLSmWXFrDke0XWU=;
        b=H3pqUqlUJ8Q2v9Sc799fsbsoZhhQrqFxYP67Zz6Nzhs+rgauI4qTAGPT7CJsEHqdYU
         hKFRWcfsKMPixusflKQFRW/cFlEmelUGV1gTLMA+VdvOjusBRv2DUwNfFDQ99FDAEUJJ
         oGmbZrkiRsJ2rTd9UkhelT7ud/NM2NTe009+DM2bMtdH81cNQev5qLPP1GRc9qY9rKW+
         WbM/Dij5TRYGHWEIY+JAysZg8j5iOam6iMSqVvoef34Ckdp0BUKkc6uvTUqdf+0r/arV
         ZjvAmcVLvCdHQXW3vW8MrrbTtC1Scd0Ngfk0O/oUIsL/sxI7ujmPT6PFXGiB3DnpaBry
         SkxQ==
X-Gm-Message-State: AOJu0YxXiBN4rJBGxBL/jeg+fwba2qZkdlGF8I5v4glQgUvdTmvoSQrZ
	w8KR7E2b48zgjlXIZeVRLiVk7iud7F/zS7StpVVmzGMMIL8CSs1B6j9tc+54mUDCcKZg/InT6Ey
	O1Yy3rzcLTc3JlUGdjKtFwl9vt/B9Jad71etbQMZWbpqWHqvmyIDkv/uFAQ==
X-Gm-Gg: ASbGnctwOMNJe6cOE1M3CdAqqI8Yl/j7Kqpmn2Y7tJ3nvTZ3L9Jx2DrlnxeHepE0wOK
	ccFq7b9tSbmJyr/FkitUVni+O+r3mCSWs33MUU34/V2HM8X1q+mZxBKfW9vhv1csV3hEWkPP4d1
	Mb3l6agft+3cC+NfMH1KVUqeFUTO8g+MITwBggE1t/XTzYLtQ08f38imc+SiWrQgSQKajeFRB5u
	KGzx1cvIm9JHLwiD372kI8x78GEQGoAGfloIaVK6V8FVy4hgczo56HehXXdCm0nZDtrk76PIYz8
	uPsFG06eI6TW4UEQdeuLbdQOi6g5YBQU7/z/Kemvvr14eEPanmAgY9qSzpeGeg9NOSpi3qk0mG3
	Z1Qpb/tG4cGfgSmx9Vr6dFgpuIKZ7GJPmFt8BiOM=
X-Received: by 2002:a05:6000:2305:b0:427:928:7888 with SMTP id ffacd0b85a97d-42709287b06mr8917163f8f.55.1761049936845;
        Tue, 21 Oct 2025 05:32:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBU6pyNtgJdNbG8KrDXp4BEjrSCFEszvqCmaWd2PrAFmOwM+9q033VKMpwkTA1TH8Zuz1XMA==
X-Received: by 2002:a05:6000:2305:b0:427:928:7888 with SMTP id ffacd0b85a97d-42709287b06mr8917142f8f.55.1761049936420;
        Tue, 21 Oct 2025 05:32:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce586sm20603530f8f.49.2025.10.21.05.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 05:32:16 -0700 (PDT)
Message-ID: <2819877d-610f-42cf-9b3c-ee2d836e2df0@redhat.com>
Date: Tue, 21 Oct 2025 14:32:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] drm/panic: Fixes found with kunit.
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20251009122955.562888-1-jfalempe@redhat.com>
 <f8f1e0ec-46fe-4d71-94aa-bdd081ec35fb@redhat.com>
 <13bc66cd-a63b-44b9-92fb-98b5b36ce2dd@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <13bc66cd-a63b-44b9-92fb-98b5b36ce2dd@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/10/2025 13:24, Thomas Zimmermann wrote:
> Hi
> 
> Am 21.10.25 um 11:35 schrieb Jocelyn Falempe:
>> On 09/10/2025 14:24, Jocelyn Falempe wrote:
>>> A few fixes for drm panic, that I found when writing unit tests with 
>>> kunit.
>>
>> Pushed to drm-misc-fixes.
> 
> There are many patches without Fixes tag here. Commits in -fixes should 
> preferably have a Fixes tag to help with backporting. No need to revert, 
> but something to keep in mind for next time.

Ok, sorry for that. I'll add it next time.

Best regards,

-- 

Jocelyn>
> Best regards
> Thomas
> 
>>
>> Thanks Javier for your reviews.
>>
>>>
>>> Jocelyn Falempe (6):
>>>    drm/panic: Fix drawing the logo on a small narrow screen
>>>    drm/panic: Fix overlap between qr code and logo
>>>    drm/panic: Fix qr_code, ensure vmargin is positive
>>>    drm/panic: Fix kmsg text drawing rectangle
>>>    drm/panic: Fix divide by 0 if the screen width < font width
>>>    drm/panic: Fix 24bit pixel crossing page boundaries
>>>
>>>   drivers/gpu/drm/drm_panic.c | 60 +++++++++++++++++++++++++++++++++----
>>>   1 file changed, 54 insertions(+), 6 deletions(-)
>>>
>>>
>>> base-commit: e4bea919584ff292c9156cf7d641a2ab3cbe27b0
>>
> 


