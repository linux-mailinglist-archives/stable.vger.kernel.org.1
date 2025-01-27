Return-Path: <stable+bounces-110872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D77A1D7C4
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 15:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28DD116623B
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 14:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5BC5672;
	Mon, 27 Jan 2025 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHsPM6l/"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8967525A643
	for <stable@vger.kernel.org>; Mon, 27 Jan 2025 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737986885; cv=none; b=GJGLz5z+TxiANeFbbtm9Yprh1aaMacn0ASqSo54GuzWT/90VMNcGx4pNq8mnkxWpxqW9eIVcIhYwlIP4W/z8LiQWfWMCrlvHaP9FDInm7GzW9hxbTAzIkr4aBnL+oe4dFFc84ed7Yv8CTjAKqSCc7mgZZHBlFRgeR4WFj/t0ugU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737986885; c=relaxed/simple;
	bh=C1RDE/iRxZXlFGXIp0NwQ66j+lYT6eO4SpkS0VQ8UiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S8F+WZvp7Dx6aslvd3FQyIE9P7CrjCzJfnu6mGggWBLNlo5z9n7R97MSDpy9Yjj3+EPfEahzCP8B9chQNeR3EkbYFPB3OqjORpmsjfyR60vTON3kQhfjbD+dLsqOfwe+UThdcwAwkEMhMLVyOhW80E2dY/8s/6Wj1us0uAy1UTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CHsPM6l/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737986882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zR8Lw8IGEDS84mnZ2x73Xq3Ymaut8qRwt5YhN2RHp0g=;
	b=CHsPM6l/kqKRBilvhHzDtuMmlcbIg2z7FZWTIau3OUQnVwSgkrV/gcqYoRBR86Szdyo0+J
	4w9SheXL12lyg9Ou+GxPQbrYO/tIBZbAzyezssSTfwi6B/sZMfS1+zG1DTutTHp3JXd2dv
	laRKdjjPf8jSoFu6eJsWXIpeTJMkIGI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-XSc_wKU5N_C85i4N03V4Vg-1; Mon, 27 Jan 2025 09:08:00 -0500
X-MC-Unique: XSc_wKU5N_C85i4N03V4Vg-1
X-Mimecast-MFC-AGG-ID: XSc_wKU5N_C85i4N03V4Vg
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385dcae001fso1672375f8f.1
        for <stable@vger.kernel.org>; Mon, 27 Jan 2025 06:07:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737986878; x=1738591678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zR8Lw8IGEDS84mnZ2x73Xq3Ymaut8qRwt5YhN2RHp0g=;
        b=KHRw4KM4OAEAbSYHZJcnwWV0pjmuE4Pb00Yw1EN/CA1ABQriTWVOnTn/BP0rbdhMoc
         I3RoO6E8rBY8fJanu2fbQhQ4YPZz5iUqrxAQaYFTTcGpENaWl5EIMOzBD8jZw5lP5Ihz
         7eBDmEchpF0GYCZEgovH//7MChaanUd9UvvN07YZtU8gaUMTHbQvT2y5gKT9rjgVtGjt
         i5mCHKA8t83UaovF8EpRx6JYcOmUA0t0GP4dM236QIeFfkVkajaGoxp3CoAXZwrrF+mp
         Crp+S2ExL8kI5h8OLa4dOrjbHxi/tdsYEd2v43/GEaaV4lAXQbu7ZybOZt+D7RciO58z
         NMGw==
X-Forwarded-Encrypted: i=1; AJvYcCUscbvY8iZt1xXtrnNDUY4PpoqkNLnHBTC4AUx+UlW2oL82Eb9ece6AXYRFkppcRsvyV3SjqK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2cs1zvRjzDbdwUVgDOoeGLmqydfHY3zeTaMEnVhB0VYtrg9Ux
	RvcF/Oc712tGkLw/BXpMQG35hwJBmIQGkH2xMHeOG0t91TLWYkdHR5AAwHXd3hqONBMlsDKjTB8
	rpR4DFSvqZ92vu4/FGn0SE7Q2u4qOIDAR5ozvOwkGhgEThDMkLJoZDydxE+zY1Q==
X-Gm-Gg: ASbGncsNCFZtY54ne1rxdfgpRla8zBI/imtpsVJVvhBGSxf7Uo+bpShbCX1nSx9otNQ
	7dwErtq312P2mu5D3aviveX0ziNn4ImpGmdgocNIhLMwhSI0VqUGBrZ2kcxCavz8x+SR4VJpxy9
	f0ITuVj2yQ6OFh2wIJMKLeFie+3MtZMzOq8vc0fgT1UXLCv+1CuQf5oHRQK2ZhzduYssVZ+bR2H
	qttddqxijGrc/f3CKl0EL+COc7opXo4nvkU2T/OLOu1cJgHgcCOVPjS9sxOJ0ceCkbsEZaZhsLx
	xduap5zTmeIrgd/yOauvE8geWHEfrfEW6cSnUMqxn0GX
X-Received: by 2002:a5d:6b8b:0:b0:38a:8b2c:53ac with SMTP id ffacd0b85a97d-38bf57b3fe9mr27112548f8f.42.1737986878505;
        Mon, 27 Jan 2025 06:07:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEE3g8f4oZ3mR7Gu+X5ihE0o/p/nxzvRr76U53vdHbo533RF2hLIvkpnKEtGmuyjpJGP5WYSA==
X-Received: by 2002:a5d:6b8b:0:b0:38a:8b2c:53ac with SMTP id ffacd0b85a97d-38bf57b3fe9mr27112512f8f.42.1737986878119;
        Mon, 27 Jan 2025 06:07:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a188a61sm11357664f8f.52.2025.01.27.06.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 06:07:57 -0800 (PST)
Message-ID: <83d74018-0029-413b-ac6b-77658b109e4a@redhat.com>
Date: Mon, 27 Jan 2025 15:07:56 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ast: astdp: Fix timeout for enabling video signal
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org
References: <20250127134423.84266-1-tzimmermann@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20250127134423.84266-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/01/2025 14:44, Thomas Zimmermann wrote:
> The ASTDP transmitter sometimes takes up to second for enabling the
> video signal, while the timeout is only 200 msec. This results in a
> kernel error message. Increase the timeout to 1 second. An example
> of the error message is shown below.
> 
> [  697.084433] ------------[ cut here ]------------
> [  697.091115] ast 0000:02:00.0: [drm] drm_WARN_ON(!__ast_dp_wait_enable(ast, enabled))
> [  697.091233] WARNING: CPU: 1 PID: 160 at drivers/gpu/drm/ast/ast_dp.c:232 ast_dp_set_enable+0x123/0x140 [ast]
> [...]
> [  697.272469] RIP: 0010:ast_dp_set_enable+0x123/0x140 [ast]
> [...]
> [  697.415283] Call Trace:
> [  697.420727]  <TASK>
> [  697.425908]  ? show_trace_log_lvl+0x196/0x2c0
> [  697.433304]  ? show_trace_log_lvl+0x196/0x2c0
> [  697.440693]  ? drm_atomic_helper_commit_modeset_enables+0x30a/0x470
> [  697.450115]  ? ast_dp_set_enable+0x123/0x140 [ast]
> [  697.458059]  ? __warn.cold+0xaf/0xca
> [  697.464713]  ? ast_dp_set_enable+0x123/0x140 [ast]
> [  697.472633]  ? report_bug+0x134/0x1d0
> [  697.479544]  ? handle_bug+0x58/0x90
> [  697.486127]  ? exc_invalid_op+0x13/0x40
> [  697.492975]  ? asm_exc_invalid_op+0x16/0x20
> [  697.500224]  ? preempt_count_sub+0x14/0xc0
> [  697.507473]  ? ast_dp_set_enable+0x123/0x140 [ast]
> [  697.515377]  ? ast_dp_set_enable+0x123/0x140 [ast]
> [  697.523227]  drm_atomic_helper_commit_modeset_enables+0x30a/0x470
> [  697.532388]  drm_atomic_helper_commit_tail+0x58/0x90
> [  697.540400]  ast_mode_config_helper_atomic_commit_tail+0x30/0x40 [ast]
> [  697.550009]  commit_tail+0xfe/0x1d0
> [  697.556547]  drm_atomic_helper_commit+0x198/0x1c0
> 
> This is a cosmetical problem. Enabling the video signal still works
> even with the error message. The problem has always been present, but
> only recent versions of the ast driver warn about missing the timeout.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 4e29cc7c5c67 ("drm/ast: astdp: Replace ast_dp_set_on_off()")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Jocelyn Falempe <jfalempe@redhat.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.13+
> ---
>   drivers/gpu/drm/ast/ast_dp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
> index 30aad5c0112a1..2d7482a65f62a 100644
> --- a/drivers/gpu/drm/ast/ast_dp.c
> +++ b/drivers/gpu/drm/ast/ast_dp.c
> @@ -201,7 +201,7 @@ static bool __ast_dp_wait_enable(struct ast_device *ast, bool enabled)
>   	if (enabled)
>   		vgacrdf_test |= AST_IO_VGACRDF_DP_VIDEO_ENABLE;
>   
> -	for (i = 0; i < 200; ++i) {
> +	for (i = 0; i < 1000; ++i) {
>   		if (i)
>   			mdelay(1);
>   		vgacrdf = ast_get_index_reg_mask(ast, AST_IO_VGACRI, 0xdf,


