Return-Path: <stable+bounces-110865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4530CA1D642
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 13:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94FC9164665
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 12:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64D41FF1D9;
	Mon, 27 Jan 2025 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6HdJpuz"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B511E868
	for <stable@vger.kernel.org>; Mon, 27 Jan 2025 12:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737982364; cv=none; b=tjDRTzv/ce6tiWud7jj8BwZV3o2jwaNZjPa1q8usCk8uFU6Osjr6Yyt/NCcuqDY0b2DLkTwuIHzC/Q4vxaH8RVhWJ0x/1WEfulFc6RZ/pMbT/nsucwNoPXXL2E9TlbbslaK1a9kjY7o+s0j7bZsI/LOQ2UNTwtJQs9ZatJhpqxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737982364; c=relaxed/simple;
	bh=gsngLEWzbV2V0WBvqLs2N51oyiKeP/CUUWfaOy4ykb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JzLTm0l2rlP9UCX5hLSo20izeKRRW/az68IKfrCyAS0k4/Ear1yhZoH7QUDWzcZ1hUFgDGR/fdVpCG1FcFjGiD5/+8RMH6Uh7OzjR+oUDRzlOfamx6B8i7gQuNKZwTzleuyrGvkhU5qVnhNqksJVQXYthSZSLLFa/Q5NJks1UC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U6HdJpuz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737982360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=II3TarzP0vPWid8xA+lfzZLs90rFzqzn/s7scc+Ffkc=;
	b=U6HdJpuzlEUQ2rOtqpmv+y8S95rw0M3suKzsoq/mVjtaATGlJYFtqVVl22Vc3DeA/48XEu
	bib4sG+Qwk+91N6x9sWgrXNo6Oifi3CD8tmUs2Vx5LtFl+9IvFFnPF61XBdxd1W2oFPzZD
	d1T4iIgazMGzf9kG1AxYlzyWUGVPoOU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-6nXTFEUzOfWFOoU64Ggtsg-1; Mon, 27 Jan 2025 07:52:39 -0500
X-MC-Unique: 6nXTFEUzOfWFOoU64Ggtsg-1
X-Mimecast-MFC-AGG-ID: 6nXTFEUzOfWFOoU64Ggtsg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43626224274so25194245e9.0
        for <stable@vger.kernel.org>; Mon, 27 Jan 2025 04:52:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737982358; x=1738587158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=II3TarzP0vPWid8xA+lfzZLs90rFzqzn/s7scc+Ffkc=;
        b=XO2NDCukziO0fxULapgO3jwpuS2RDNV66GKw7Boymm4pgNIxRhFfcZKde5k+r7c9te
         kcVN5yqhzdvlTDgkNDMv8+2+ixVhCE5ZnXg/ADCEzKBC4jzqdAgGtkORDVej28zc1QYr
         SlTdHaKPhxB27JajsDQlPZ4xQBHifUS+/3K8MxZavNUGhDRnpUsg2UCYBDnXCVw9hBE/
         rTu9z3j6+/I/sIc4kn8iQLc8AhInJxTSadOptep/Y+Guejv07wLYz8F4L0YQQsb++PV+
         1YPOwG/lEMBT8lEmk/QmXaXLd0fCUSZQ2nMWxKEm7ZNGWeisfXJkWRe2sP2X4iY3i0kJ
         l0zg==
X-Gm-Message-State: AOJu0YwkfzxXiAqZFUNfNiEm3FdCWc8SpG1/MrM4zabzgG+9H7rU/jls
	038dNJpihqmOVsmAupSCItalq0r4GmTU9XEocBmXIj94uX0iuzhU6gX3H8vKySl8yNzxzYAdgX7
	L7rD/apir04achNcGqeudxPEgAxutrYeDXaliydvof3oQXk2hgTOybrYgu7Z04A==
X-Gm-Gg: ASbGncu4mmj2IYsQw5zllseHNclHapuxb4JoOK4cWRsRjGSZLFf9nym4WdqCljBGcc4
	Z43ijkr+EWbI0a0LPwYS71i9KzxSBgfuRBDXOmwkt6HZDzXYsqrEeV740b4zO47kCG6l9TwTxB4
	RbN9CegshhymM2X6/TccdcvnsIfYRGe6V1M3QhQFCJrShcXsXJG2yGoaaZ3jpPCu8GPdNEvocr4
	zLMvlMDbprmzWPhAjgtvtBBDBT0OTZJZXmAuPeLMlHUQtnYyK/qjN0aWTiU+2qK/AKUvKenwcuc
	sm0aCPSCtvrntIlAA+B+uzSIuz+JJNqUlXWtCKyY8dF3
X-Received: by 2002:a5d:540c:0:b0:385:ebea:969d with SMTP id ffacd0b85a97d-38bf56633c2mr24794251f8f.22.1737982357914;
        Mon, 27 Jan 2025 04:52:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBOs3kUg6vEfQKQP86bbISePUJi081XdPSeBGkIciE74yl+jOUXVAzcvfUZBr82cEr/lcCUg==
X-Received: by 2002:a5d:540c:0:b0:385:ebea:969d with SMTP id ffacd0b85a97d-38bf56633c2mr24794228f8f.22.1737982357478;
        Mon, 27 Jan 2025 04:52:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1c3c8csm11224247f8f.90.2025.01.27.04.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 04:52:37 -0800 (PST)
Message-ID: <c0446bfe-5a06-47e1-b12a-3fae73365f36@redhat.com>
Date: Mon, 27 Jan 2025 13:52:36 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/ast: Fix ast_dp connection status
To: Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie
 <airlied@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20250124141142.2434138-1-jfalempe@redhat.com>
 <93bfabd4-20a8-4d56-898b-943dccb41df2@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <93bfabd4-20a8-4d56-898b-943dccb41df2@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/01/2025 12:55, Thomas Zimmermann wrote:
> Hi
> 
> 
> Am 24.01.25 um 15:11 schrieb Jocelyn Falempe:
>> ast_dp_is_connected() used to also check for link training success
>> to report the DP connector as connected. Without this check, the
>> physical_status is always connected. So if no monitor is present, it
>> will fail to read the EDID and set the default resolution to 640x480
>> instead of 1024x768.
>>
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>> Fixes: 2281475168d2 ("drm/ast: astdp: Perform link training during 
>> atomic_enable")
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: Dave Airlie <airlied@redhat.com>
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: <stable@vger.kernel.org> # v6.12+
> 
> I cannot reproduce the problem, but the patch looks correct. My AST2600 
> with ASTDP still works correctly with the patch allied.

Thanks, interesting that it doesn't affect all hardwares.
I got reports from two different vendors about this issue.

If no other comments, I will push it to drm-misc-next tomorrow (only 
adding reported-by: and tested-by: tags).

-- 

Jocelyn

> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> Best regards
> Thomas
> 
>> ---
>>   drivers/gpu/drm/ast/ast_dp.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
>> index 0e282b7b167c..30aad5c0112a 100644
>> --- a/drivers/gpu/drm/ast/ast_dp.c
>> +++ b/drivers/gpu/drm/ast/ast_dp.c
>> @@ -17,6 +17,12 @@ static bool ast_astdp_is_connected(struct 
>> ast_device *ast)
>>   {
>>       if (!ast_get_index_reg_mask(ast, AST_IO_VGACRI, 0xDF, 
>> AST_IO_VGACRDF_HPD))
>>           return false;
>> +    /*
>> +     * HPD might be set even if no monitor is connected, so also 
>> check that
>> +     * the link training was successful.
>> +     */
>> +    if (!ast_get_index_reg_mask(ast, AST_IO_VGACRI, 0xDC, 
>> AST_IO_VGACRDC_LINK_SUCCESS))
>> +        return false;
>>       return true;
>>   }
>>
>> base-commit: 798047e63ac970f105c49c22e6d44df901c486b2
> 


