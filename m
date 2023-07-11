Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0016674EB7F
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 12:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjGKKJd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 06:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjGKKJd (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 06:09:33 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF65A100
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 03:09:30 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so8720157e87.2
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 03:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689070169; x=1691662169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7dRYhDe8BiVEV0EBlHbMEnxi5wvB4qWMFbFVB8lXRts=;
        b=aFgnj794CZ/PSLsUzrOXSBGzhI4B7HswMutmsFqschHSz8cORA+/pDetACQMnLtiVf
         SmrzCFCT/cs+yM6BikKD/fqtRXullzc+RV31vTmrAL7rMnzI7g16FM72t2KqZivXVtiL
         fMRV7ruLnrIMLDcjsLJWEglSNQS1EXdKxUdtJ7xeV2OpYxq6LtL3o6/GCUCTxNGksEAq
         OaXuZwr3JCMIQ1l/iQaAsAXZe5TMsMdztIpr3EeEXtf9nprw/1zwlBw+P4lNXSRt+M6k
         rXc9W4f0n7upozPz3dJJtgCxGq6YYdfg3Q3boXohjB+hDA1PLH4SmzjbP61YS/E3XkvU
         pJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689070169; x=1691662169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7dRYhDe8BiVEV0EBlHbMEnxi5wvB4qWMFbFVB8lXRts=;
        b=WF1mDVvfATa001DXOZlKg1n7s+uVfnuvSrTXS9bbmbttC+T+P5i4GKn7ompTPgsORJ
         hzAO1BKLb/7t8lVh8o1eNe0b/by2Xr4YfXvvqnhD4YZGsH0JCWf9ULj4PXUocYJuL43D
         fpaX4NqT2HtXg9/olgLM6veqpE45Tfs3/w7XFx1NvJd7z9o/4yKfQQC3HiDtL/iO+YRl
         aruU/qs4QXCVdyiUkFZHP8tHBTcejSTnTVELiqXXoCyov9fjY2UDXv2ZoiW/svuldq6n
         tBZI41WcYI9ikLC2FaRcPQaEkeuRg4JSKEUBye9cW4h0p13sVrHVscwr+Klz22hTijA0
         Kt/w==
X-Gm-Message-State: ABy/qLZhrgcnlq8IFtLLnuZdOh44JOOPcErp+0czHG11JrE4DgOUFG0H
        4NyUtrRU3pfP+KG0zzxgVA65ow==
X-Google-Smtp-Source: APBJJlHdaYP6KQEeXomKRN9uoCu1+yo8uHO71sdRJ/mNUCNoupGWQiJZQ4tH2nJN9kqa4WSAGURoBQ==
X-Received: by 2002:a05:6512:2346:b0:4fb:7be5:8f4e with SMTP id p6-20020a056512234600b004fb7be58f4emr3008339lfu.6.1689070168929;
        Tue, 11 Jul 2023 03:09:28 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id 15-20020ac2482f000000b004fb88fffd19sm256372lft.146.2023.07.11.03.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 03:09:28 -0700 (PDT)
Message-ID: <1090089b-2fa9-9781-51a8-38957e261bfd@linaro.org>
Date:   Tue, 11 Jul 2023 13:09:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/client: Send hotplug event after registering a client
Content-Language: en-GB
To:     Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
        noralf@tronnes.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        amd-gfx@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Paul Schyska <pschyska@gmail.com>,
        Torsten Krah <krah.tm@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        freedreno@lists.freedesktop.org,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Moritz Duge <MoritzDuge@kolahilft.de>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230710091029.27503-1-tzimmermann@suse.de>
 <325dad0e-38ff-9f60-efc9-0fd711d63267@linaro.org>
 <117aea3d-c316-509d-7be7-ade155b4ae85@suse.de>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <117aea3d-c316-509d-7be7-ade155b4ae85@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 11/07/2023 09:07, Thomas Zimmermann wrote:
> Hi
> 
> Am 10.07.23 um 23:11 schrieb Dmitry Baryshkov:
> [...]
>>> ---
>>>   drivers/gpu/drm/armada/armada_fbdev.c     |  4 ----
>>>   drivers/gpu/drm/drm_client.c              | 21 +++++++++++++++++++++
>>>   drivers/gpu/drm/drm_fbdev_dma.c           |  4 ----
>>>   drivers/gpu/drm/drm_fbdev_generic.c       |  4 ----
>>>   drivers/gpu/drm/exynos/exynos_drm_fbdev.c |  4 ----
>>>   drivers/gpu/drm/gma500/fbdev.c            |  4 ----
>>>   drivers/gpu/drm/msm/msm_fbdev.c           |  4 ----
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # msm
> 
> Thanks.
> 
>>
>>>   drivers/gpu/drm/omapdrm/omap_fbdev.c      |  4 ----
>>>   drivers/gpu/drm/radeon/radeon_fbdev.c     |  4 ----
>>>   drivers/gpu/drm/tegra/fbdev.c             |  4 ----
>>>   10 files changed, 21 insertions(+), 36 deletions(-)
>>
>> BTW: As you have been clearing this area. I see that significant 
>> amount of DRM drivers use exactly the same code for 
>> msm_fbdev_client_funcs and for the significant part of 
>> foo_fbdev_setup(). Do you have any plans for moving that into a 
>> library / generic code? If not, I can take a look at crafting the patch.
>>
> 
> You're not the first to ask. :) I've so far not attempted to address 
> this duplication. I've been bitten by premature helperization before, so 
> I wanted to wait a bit longer. A lot of the fbdev and client code is 
> changing quite a bit. After things stabilized, I want to to try to do 
> some more code sharing.

Ack, thank you for sharing this.

-- 
With best wishes
Dmitry

