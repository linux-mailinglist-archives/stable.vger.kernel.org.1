Return-Path: <stable+bounces-128541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCA6A7DF7F
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 15:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E546A3B63B5
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 13:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF95188596;
	Mon,  7 Apr 2025 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/sjckEC"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A36618132A
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744032801; cv=none; b=DhE+ybIT0czD3D1D+Z0AgR7/DDbt7pdE8K4q9MsiUMPH6MWbeqD+24OxJLIDWP7uNnuKkvIlK16OIphVkJ2BDH6nTyzkMJMIG3L29Gzls8xmSHYBN0fuuo2UrswcKeuEtJuk0yFrynOAsGHXMHWKteklhvgToWQ21tBFzQK5y+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744032801; c=relaxed/simple;
	bh=or+KEFGTrsg1nsPIdmkEwhSXILQOsSETwxadfTI6AhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LRdYAouDpTKDhw71T0IHK9zEMocv6JFLpepKcxy4BddUUubBSMKsF2ktuM0o10S3KyOFayJnsN2+OgC7dqqbXmWpmmnIVP0Ha722vyqpjyLkipu/fc/3KLMT4PIoMiI/6kxoGWoQAe6Lvs1DuvTguU+OySZ5zxK6kp6GqiM89M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O/sjckEC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744032796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=afbb7WkLp8lyjypZ4x8CYxgmQXgkeIvIjBj+73twv/o=;
	b=O/sjckECl3gKM7pPUtvJx2DRF3Sjg8byGLMEYaFGy6rH+lVBOZx/mRqalu/LCHr3eP//fp
	6k9yxjO2DrgudNXjed7zi3vTwi7CDcNYQ9hw0BA2WcU18vuIgVbBJYYUne8H5kXBNHkj7z
	dvy3/7OMnOX2QViDR3JrdWGkWjCjizI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-LBi2O8sQNaKMhYxmZ_fDNQ-1; Mon, 07 Apr 2025 09:33:13 -0400
X-MC-Unique: LBi2O8sQNaKMhYxmZ_fDNQ-1
X-Mimecast-MFC-AGG-ID: LBi2O8sQNaKMhYxmZ_fDNQ_1744032792
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3913d8d7c3eso2369752f8f.0
        for <stable@vger.kernel.org>; Mon, 07 Apr 2025 06:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744032792; x=1744637592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=afbb7WkLp8lyjypZ4x8CYxgmQXgkeIvIjBj+73twv/o=;
        b=N54adI8AGF12nWVS7QHHVmB5ztg8MnFd0I8Sf8A+TvbwYJ/FZSnvNcZ5t9DG9H3e/h
         Yx8wBz2BEp09edhgJnF1x2GGGk220KS0UPW/TumhEuol3kH59mJsTxEYTQtmlz3bym7N
         c97MmDFezn7nw0BbqZ3EyZ3z3a1N1QW9AH13lnKr08OiZs12CTMlhk/xPFParrguxzhR
         ET/hVl7+8K5Udjtr42jL5Md7mlhwH17+0EVLPWUNCz9N0LsxTuS0B1lFhL8vZ2eA61q+
         0o1dBjCRIHAfbRenqcWH7yhdiktM6P8jn5GhZtveWg/+2wjzORtp6NJtp4d6+K3fSpLU
         LNAw==
X-Forwarded-Encrypted: i=1; AJvYcCUUsRM3zC2h076bTObY4Paa+AC7WAhfgxqQ20jYGodLPQcR1WdAwo0e7RklCELCl2mGuYmQcc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqH3Gd2MI0YxDZYwNIuJcGxQVIvaRiNBhtlMNraQZpTqrCq4YG
	78ZPvrdzeI56r/ZZ2BDSHPDMRTSsyyPEVtSRXba4HqPoqh16EY6/PJmUNwpdPlGAZRz/aeXEEhz
	7WzCZGhHtbvW8Mv4egvSRn2mm/WaKf0mNxt6fZJ2OM28gALj+s+l/mQ==
X-Gm-Gg: ASbGncvIznOa12254Kvf8lUrICdKzv4fvVDStFmbv1RymGWNmr/4mHeCn+sKjssX/Em
	os1NpAQs79/dHo1LXu5SSojwcMxcoc/MaG/2VlFmjk8kIbn8/vNrg6xyJHQ6HC7C9drzI1KjRR6
	by9lAvRZbqS9AVzdZ4bNGNv2hF2kZoqso4SPsQSyI9sTsdjMqc3TBiYB26WvjlvDF3yhxCRF1os
	nLudzY26b3kiQfB7J2i6j3AE5AITtpg9imaDx/HsgQeUINRRAVHFmf3dCONNZad9U9+XhgYFvgs
	xUV+wnsoYBPUWXMdeFo=
X-Received: by 2002:a5d:5f85:0:b0:391:4559:876a with SMTP id ffacd0b85a97d-39d0de66a76mr10099031f8f.46.1744032792511;
        Mon, 07 Apr 2025 06:33:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE21qC+qO+axlamg3PP6rk4oRrAkKrbz3ds7kuXha7eToDMkVaV6kV/fgeW4vqYEdmW3QBD9A==
X-Received: by 2002:a5d:5f85:0:b0:391:4559:876a with SMTP id ffacd0b85a97d-39d0de66a76mr10099001f8f.46.1744032792149;
        Mon, 07 Apr 2025 06:33:12 -0700 (PDT)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301b6a1esm12135521f8f.45.2025.04.07.06.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 06:33:11 -0700 (PDT)
Message-ID: <a1661517-536b-49bb-95af-8cf7baf91b39@redhat.com>
Date: Mon, 7 Apr 2025 15:33:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] media: uvcvideo: Fix Fix deferred probing error
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Douglas Anderson <dianders@chromium.org>
References: <20250313-uvc-eprobedefer-v3-0-a1d312708eef@chromium.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250313-uvc-eprobedefer-v3-0-a1d312708eef@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ricardo,

On 13-Mar-25 13:20, Ricardo Ribalda wrote:
> uvc_gpio_parse() can return -EPROBE_DEFER when the GPIOs it depends on
> have not yet been probed.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thank you for your continued work on the UVC driver,
I've have merged this series into:

https://gitlab.freedesktop.org/linux-media/users/uvc/-/commits/next/

now.

Regards,

Hans




> ---
> Changes in v3:
> - Remove duplicated error messages in uvc_probe()
> - Link to v2: https://lore.kernel.org/r/20250303-uvc-eprobedefer-v2-0-be7c987cc3ca@chromium.org
> 
> Changes in v2:
> - Add follow-up patch for using dev_err_probe
> - Avoid error_retcode style
> - Link to v1: https://lore.kernel.org/r/20250129-uvc-eprobedefer-v1-1-643b2603c0d2@chromium.org
> 
> ---
> Ricardo Ribalda (2):
>       media: uvcvideo: Fix deferred probing error
>       media: uvcvideo: Use dev_err_probe for devm_gpiod_get_optional
> 
>  drivers/media/usb/uvc/uvc_driver.c | 38 ++++++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 12 deletions(-)
> ---
> base-commit: f4b211714bcc70effa60c34d9fa613d182e3ef1e
> change-id: 20250129-uvc-eprobedefer-b5ebb4db63cc
> 
> Best regards,


