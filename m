Return-Path: <stable+bounces-100132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 575779E9146
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 12:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB931885BE3
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 11:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6FB217F35;
	Mon,  9 Dec 2024 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1npOaQ1"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021FA218596
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 11:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742083; cv=none; b=joOz/lh6qvpnIfBohypEcuWb7zAL0+LwR+OLIM1cDbmj/31+5TFR4juITS3pgzt5OusJk1adXXAgIq9F4RREbwjM4ixbeUOX0KbUOoU7/it8r+J2uWxUXCU9q65KLZBPGaYzWZhqz9e4OhFIaO8zfEVnttP4X1oJrOF6hg+eMWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742083; c=relaxed/simple;
	bh=T+YxWHS3C9ZSiHc+chPHEh+AeP96E4yR7QuzR5ljdKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pICGdCdeFMseDpVX7EAKMx8QFdksfBma7VRz5qFNS2RjMJOOkPmz8DFzg4zBMUMmpsztWZiQQORPrTL0N2nuUXAetqbWBEwJ4ugO8zWGdYWw65gk3k5fgU7q5sCm9QizwBBrZksV22NO/p5o3SxY4oAd20IrUJR8TVovlPBExV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G1npOaQ1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733742081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NO6ec67okvv9M56zFhDtp0FFmwC2iQhXha5CQcXffcY=;
	b=G1npOaQ1cBil4FJeuGd37h30FP/oVlxC5fayh+CcjEwX1Np1NEyKcmlvaUk1tnSYn9aFBJ
	5lUWgI428VK4ok1bJEd43IdAwjM1heBz6QBwIGvsZE5D9IxAxNQLj03kOpQTZlSp2c6/0C
	GXNC8uydAMxsSh+WEfiWikAmV4fd66U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-U7ufIsK4OhemdoXc0tBJfA-1; Mon, 09 Dec 2024 06:01:20 -0500
X-MC-Unique: U7ufIsK4OhemdoXc0tBJfA-1
X-Mimecast-MFC-AGG-ID: U7ufIsK4OhemdoXc0tBJfA
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa68fd5393cso63403566b.0
        for <stable@vger.kernel.org>; Mon, 09 Dec 2024 03:01:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733742078; x=1734346878;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NO6ec67okvv9M56zFhDtp0FFmwC2iQhXha5CQcXffcY=;
        b=jtRJQY7jm7RyKQH9pOOX1wrNaugYto2kpRNXDyn6T162XLtN2csMas91bjulr+WgJK
         mkZg/YDqZbtjC+hyA3gVasRqWMG6cRW34lRRqa8zX1ZMlENuAbjspHkURGjD1zvtP6IL
         GQPkplcWcGkaiN/eyVCfXSkPJ5xvkCT3tQ1I63C8r9R+GgSXW46s2uJLXovKqTmtk/pf
         Nk7+K9CAlnGiLcXWXXV4z8vp1FdoJ7kaz/qNBcaAyM9u5ZGnIUDrPthrTvzk6keZEvcA
         xir9st4fIibfCqsonasLnkk2X3EAIgCKe5L487794vQBMeVHBEJUaHxv2J958rMfvQER
         BNsw==
X-Forwarded-Encrypted: i=1; AJvYcCV98uVBI8qmgEXFcV0C+LC1JsuxoZgR3GV/gIrBz4WPO4C0m/1AqIqMK7eafm2JvEHzuMMSko4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQkH7upx9eNEX92HuSFJGQ6tqQJLGM3nSZKsIvUkQ46fn49Jwl
	OKwafpDBplOC3MV1ZhQcBL8PpGTqo+cWsF/5dNFYn7bkydpnuF/Gr4w24QfAUH2rWBsN5trzk2O
	JbXD4w7ZaOnX7GD73rwilzOLUj20Sr6ctQxfFUwmxErO2EOlhcHk/TQ==
X-Gm-Gg: ASbGncv6NpNhIyAYDwtFNi/aPJErHM7J4j8H0Mqv2R83j+qo1A2GiSQOkCxzkpgnJ1K
	rYEuOGIqY9GRb78HX9LUH1ammXqSHBSiYgL/vjkNC4OjyeraHx5guhvTzipFLVN9Yv0m0ieqhAq
	z3nF0BxR08Oh864R2meSAcnfkEQQzHHXLsJ9fXTVKF7rJ90NN5O9VG0Hc6lwDJN+IWeBZFouWsU
	WF+CWD8Odw/BDok8VP+3QMFtSj59G17kqJpQEH2IYXpxvsXxIZbEQ==
X-Received: by 2002:a17:907:7854:b0:aa6:79c0:d8ce with SMTP id a640c23a62f3a-aa679c0dd17mr431692666b.1.1733742077715;
        Mon, 09 Dec 2024 03:01:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHn/LCpkxsb9dv/71P5EH3sArKezZObZ8yWTt35AHgOIcEPgweUp9Z0CUhOTo5YwwEpuOfKYw==
X-Received: by 2002:a17:907:7854:b0:aa6:79c0:d8ce with SMTP id a640c23a62f3a-aa679c0dd17mr431688966b.1.1733742077280;
        Mon, 09 Dec 2024 03:01:17 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa69448304asm65009866b.45.2024.12.09.03.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 03:01:16 -0800 (PST)
Message-ID: <e3316372-d109-4d2e-ad2b-8989babdf546@redhat.com>
Date: Mon, 9 Dec 2024 12:01:16 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] media: uvcvideo: Two +1 fixes for async controls
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241203-uvc-fix-async-v6-0-26c867231118@chromium.org>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241203-uvc-fix-async-v6-0-26c867231118@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3-Dec-24 10:20 PM, Ricardo Ribalda wrote:
> This patchset fixes two +1 bugs with the async controls for the uvc driver.
> 
> They were found while implementing the granular PM, but I am sending
> them as a separate patches, so they can be reviewed sooner. They fix
> real issues in the driver that need to be taken care.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Ricardo, Thank you for your patches.

I have merged patches 1-4 into:

https://gitlab.freedesktop.org/linux-media/users/uvc/-/commits/next/

now.

Regards,

Hans



> ---
> Changes in v6:
> - Swap order of patches
> - Use uvc_ctrl_set_handle again
> - Move loaded=0 to uvc_ctrl_status_event()
> - Link to v5: https://lore.kernel.org/r/20241202-uvc-fix-async-v5-0-6658c1fe312b@chromium.org
> 
> Changes in v5:
> - Move set handle to the entity_commit
> - Replace uvc_ctrl_set_handle with get/put_handle.
> - Add a patch to flush the cache of async controls.
> - Link to v4: https://lore.kernel.org/r/20241129-uvc-fix-async-v4-0-f23784dba80f@chromium.org
> 
> Changes in v4:
> - Fix implementation of uvc_ctrl_set_handle.
> - Link to v3: https://lore.kernel.org/r/20241129-uvc-fix-async-v3-0-ab675ce66db7@chromium.org
> 
> Changes in v3:
> - change again! order of patches.
> - Introduce uvc_ctrl_set_handle.
> - Do not change ctrl->handle if it is not NULL.
> 
> Changes in v2:
> - Annotate lockdep
> - ctrl->handle != handle
> - Change order of patches
> - Move documentation of mutex
> - Link to v1: https://lore.kernel.org/r/20241127-uvc-fix-async-v1-0-eb8722531b8c@chromium.org
> 
> ---
> Ricardo Ribalda (5):
>       media: uvcvideo: Only save async fh if success
>       media: uvcvideo: Remove redundant NULL assignment
>       media: uvcvideo: Remove dangling pointers
>       media: uvcvideo: Annotate lock requirements for uvc_ctrl_set
>       media: uvcvideo: Flush the control cache when we get an event
> 
>  drivers/media/usb/uvc/uvc_ctrl.c | 83 ++++++++++++++++++++++++++++++++++------
>  drivers/media/usb/uvc/uvc_v4l2.c |  2 +
>  drivers/media/usb/uvc/uvcvideo.h |  9 ++++-
>  3 files changed, 82 insertions(+), 12 deletions(-)
> ---
> base-commit: 291a8d98186f0a704cb954855d2ae3233971f07d
> change-id: 20241127-uvc-fix-async-2c9d40413ad8
> 
> Best regards,


