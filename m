Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EE8797921
	for <lists+stable@lfdr.de>; Thu,  7 Sep 2023 19:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbjIGRDO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 7 Sep 2023 13:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjIGRDN (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 7 Sep 2023 13:03:13 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3FDCDE
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 10:02:48 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9a5dff9d2d9so144989966b.3
        for <stable@vger.kernel.org>; Thu, 07 Sep 2023 10:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694106114; x=1694710914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3F5qdrNMRQPlna2b5xgS4IlqRcKmNFR4cjR9i9vXjTo=;
        b=WBqdw6zDs9TMSGgR9zZZp4mKpVLy8GBNbFCKH4g654xOvGCcu7X5xXNplsut5k4zns
         eMGcRl/oWZFy9lSlgjpivgy90ptIwZq4gBqG1J2uV3ioQPEr7ZDSvspRkOINV4Wn+9CU
         FTtkXV/wL2Mj3k67xAtCNnheakRRsv7FOmIme8ov2elotF1yStAua88yxbnPKXvaNqX+
         2RIC7xGATipqqymovE0F+AilXsg01LYS17NZmHGpzLvt0U+DIXGdwEtYOZljDWW66E4j
         LA34m34nx0UshMeJ/m/ctqQvXLeGkeyQQGVKUILaDYG5xEGuyYXcCHE3YzxD7YmoEf3s
         xJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694106114; x=1694710914;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3F5qdrNMRQPlna2b5xgS4IlqRcKmNFR4cjR9i9vXjTo=;
        b=H8Pu7zhviuoGb9ZaBrlpyRhH4SzyeMji91ANINwtxUdJGyUYlYTip+cu+c+RY2YIBr
         kmsuIuWSPm8Sk0BfDydhFj99HzLrlYsRyS4gc8DKI+7g3f6bns1yx9cZADBq4/xCOYbK
         xPnWQtlYhWkLq2ocKpT24myQTyzKKQbBbgtmQKrQ79YEMgo40/eszHGGk5j0LS5XDB2S
         7lfzDSZlfQXvd4iKRJsjcaXk4LIck5f4KgzSTt5BX00pfPA1/BRCWtfu1Tm0LHT3otDO
         zFh7ZuTxwrpnIuU6y+6iWIhQ1wAfXOb3854aP2gjHqeKhu5bQV/Abr9NgMhLKgFOz7V5
         RWPQ==
X-Gm-Message-State: AOJu0Yz4HjKulCfNx9oZZm7M7YC0Jc8BH9kPPN7jka5QIAi/zuSsZPTH
        PF74Qf38qyoifX9w2Gsryrqv8pMLkQoJNw==
X-Google-Smtp-Source: AGHT+IHbPtdiWTpEoOIk0yKaSTCjbk/QTr5OWN0TH26+HgSw2j2dCVX7TlqBvkQWqm+MnLaTeRFHaQ==
X-Received: by 2002:a17:906:768d:b0:9a6:3d19:df7 with SMTP id o13-20020a170906768d00b009a63d190df7mr4251180ejm.17.1694070228534;
        Thu, 07 Sep 2023 00:03:48 -0700 (PDT)
Received: from [192.168.178.25] ([134.19.111.81])
        by smtp.gmail.com with ESMTPSA id g4-20020a170906594400b0099b76c3041csm10004261ejr.7.2023.09.07.00.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 00:03:48 -0700 (PDT)
Message-ID: <f9db3fc9-2247-8998-0587-1cadc051be18@gmail.com>
Date:   Thu, 7 Sep 2023 09:03:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] drm/radeon: make fence wait in suballocator
 uninterrruptable
Content-Language: en-US
To:     Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org
Cc:     Simon Pilkington <simonp.git@gmail.com>, stable@vger.kernel.org
References: <20230906195517.1345717-1-alexander.deucher@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230906195517.1345717-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Am 06.09.23 um 21:55 schrieb Alex Deucher:
> Commit 254986e324ad ("drm/radeon: Use the drm suballocation manager implementation.")
> made the fence wait in amdgpu_sa_bo_new() interruptible but there is no
> code to handle an interrupt. This caused the kernel to randomly explode
> in high-VRAM-pressure situations so make it uninterruptible again.
>
> Fixes: 254986e324ad ("drm/radeon: Use the drm suballocation manager implementation.")
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2769
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> CC: stable@vger.kernel.org # 6.4+
> CC: Simon Pilkington <simonp.git@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

Going to push this to drm-misc-fixes in a minute.

Regards,
Christian.

> ---
>   drivers/gpu/drm/radeon/radeon_sa.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_sa.c b/drivers/gpu/drm/radeon/radeon_sa.c
> index c87a57c9c592..22dd8b445685 100644
> --- a/drivers/gpu/drm/radeon/radeon_sa.c
> +++ b/drivers/gpu/drm/radeon/radeon_sa.c
> @@ -123,7 +123,7 @@ int radeon_sa_bo_new(struct radeon_sa_manager *sa_manager,
>   		     unsigned int size, unsigned int align)
>   {
>   	struct drm_suballoc *sa = drm_suballoc_new(&sa_manager->base, size,
> -						   GFP_KERNEL, true, align);
> +						   GFP_KERNEL, false, align);
>   
>   	if (IS_ERR(sa)) {
>   		*sa_bo = NULL;

