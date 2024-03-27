Return-Path: <stable+bounces-32448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FA888D99C
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 09:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50BF1B21B4B
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 08:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556654503C;
	Wed, 27 Mar 2024 08:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHtMkjcz"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEE53A297
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529634; cv=none; b=XUtjwokfi7rQZG0T8KlV8G65HAtY9p8pR933KV59OZSayZCupj1fuE5M0JlhYmatfJBTsjquU0w6VwsNGqssvtdUOIUZ4iwvCMTFqc+89RwbyYHryZKhFJNx4lCnjOQjCPmv+wTSbE+XcSC7t5ZVLNqnuLiJrJenOc2Ozpi2Ya8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529634; c=relaxed/simple;
	bh=G+lQKyO8XYPtuMapTR34hMDUALueaAFeQ9enFHtzrQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aVWcWZ59/iC7yG4FJIUTUpN4wVAIaKFPUC+/3hD9JtcpMGaucTxAHARB87VuzC+FqRQ3ZHjCpuH2xkM0eCgwdcK/emFCzRfj/caNlSf+uHqMDY5p9ch4Nz5iSRzVt3784u+V69B/qXu3TFr18uH9Xgq6YAPVOZ9vydRwgxu5r6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CHtMkjcz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711529631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQayDiLeMZdAEU12a7XUqQdU0MXKYllLESqhbcKtdFY=;
	b=CHtMkjczv/0Q0y8r2+XsUrfvnVmW4ofkzkViAOPKlkfU6WIaAGB2M7subwZynPbFGML3TP
	pujBcXT0/b74+Z45UhwMnL2H3v3sKL5nOmNdfRDX1GdmgF3RpA1zFIKTZWYFpdNspUHyGy
	JrnvMRPH/VmZE9D3HTq7NQys+E6Y+Cw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-gXvGacKCO0OeKZCAhW1KSw-1; Wed, 27 Mar 2024 04:53:48 -0400
X-MC-Unique: gXvGacKCO0OeKZCAhW1KSw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-414105984aeso35196765e9.0
        for <stable@vger.kernel.org>; Wed, 27 Mar 2024 01:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711529627; x=1712134427;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EQayDiLeMZdAEU12a7XUqQdU0MXKYllLESqhbcKtdFY=;
        b=US+xADdC+zGPG1/F9RY5GnhH7sOlJkIZqGhSFfEWqrnoFqyPkUE4ZtRX0HObxyHD+F
         UQROSbRpXipR4YWszPdGrEPDPOoVsdsMcUGJbewk6oVAPSOcuiu+uxc1yMUXKt7yF++3
         VLA1yUJz+yooCHlNCKSNTfcOFZQZlbMh3cIpy9w6riyQtm69JtxCLbTMaXGMGdVgZED4
         IAZhvYUyP43u/ZoNgD9e14BG6svcduKrwI4YGpvKwsWscjSYB7Y9h6n33HEd3GCnCNsh
         js/CLfcRxC8jZCs+xNq3nNoLRUXqNY/9PHtryaDSUaFkdmCOs4braqImVByyGVnK5uBk
         bOQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPXxljfvjMEv8LT+u65LwLvhqQza+DHMgbNjraYa9QMxoBwVNnZVn/pDff/uE3pbD+6IAhc+vOsJBVOvDh5vwgMMBdMbJC
X-Gm-Message-State: AOJu0YzSCQtyIiO8JmUBjDxxUhx2dKVs8FXw1Qa4VgDYtREpPKy+RtTG
	ddrzXiKvKd7nMFM8ImiKOpHMXY/MIpduWDPPWr6blIDYfacnEMcJ3mUMK7Nq7bcMTH8rrQbjH3k
	gUDHqivjWp5jCzf3S1i7+2E6IGJC/y5KI0B/Z3wgH6IiAMgZcpi+MRg==
X-Received: by 2002:adf:f451:0:b0:33e:48f9:169d with SMTP id f17-20020adff451000000b0033e48f9169dmr501990wrp.31.1711529627013;
        Wed, 27 Mar 2024 01:53:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyYZsP9X3qxXI8cZXakmL7rjWFiYhk/YTocnXK2U91YBDzGTzDlmcuOk2/rHJDPaHGdtJnTA==
X-Received: by 2002:adf:f451:0:b0:33e:48f9:169d with SMTP id f17-20020adff451000000b0033e48f9169dmr501974wrp.31.1711529626671;
        Wed, 27 Mar 2024 01:53:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id bt17-20020a056000081100b00341b5cf0527sm4147245wrb.11.2024.03.27.01.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 01:53:46 -0700 (PDT)
Message-ID: <c04ebd16-f0b0-45be-a831-fae8b50b7011@redhat.com>
Date: Wed, 27 Mar 2024 09:53:45 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ast: Fix soft lockup
Content-Language: en-US, fr
To: Jammy Huang <orbit.huang@gmail.com>, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@redhat.com,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jammy Huang <jammy_huang@aspeedtech.com>, stable@vger.kernel.org
References: <20240325033515.814-1-jammy_huang@aspeedtech.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20240325033515.814-1-jammy_huang@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Thanks for your patch.
I'm wondering how you can trigger this infinite loop ?

Also this looks like a simple fix, that can be easily backported, so I'm 
adding stable in Cc.

If Thomas has no objections, I can push it to drm-misc-fixes.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

-- 

Jocelyn

On 25/03/2024 04:35, Jammy Huang wrote:
> Avoid infinite-loop in ast_dp_set_on_off().
> 
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>   drivers/gpu/drm/ast/ast_dp.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
> index ebb6d8ebd44e..1e9259416980 100644
> --- a/drivers/gpu/drm/ast/ast_dp.c
> +++ b/drivers/gpu/drm/ast/ast_dp.c
> @@ -180,6 +180,7 @@ void ast_dp_set_on_off(struct drm_device *dev, bool on)
>   {
>   	struct ast_device *ast = to_ast_device(dev);
>   	u8 video_on_off = on;
> +	u32 i = 0;
>   
>   	// Video On/Off
>   	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xE3, (u8) ~AST_DP_VIDEO_ENABLE, on);
> @@ -192,6 +193,8 @@ void ast_dp_set_on_off(struct drm_device *dev, bool on)
>   						ASTDP_MIRROR_VIDEO_ENABLE) != video_on_off) {
>   			// wait 1 ms
>   			mdelay(1);
> +			if (++i > 200)
> +				break;
>   		}
>   	}
>   }
> 
> base-commit: b0546776ad3f332e215cebc0b063ba4351971cca


