Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64EF74EA8F
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 11:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjGKJbn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 05:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjGKJba (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 05:31:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B100273A
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 02:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689067726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ElB96/B5cF3SirD9nOg8hph9QYwwBNtS7UKQZC5Rq/I=;
        b=TT0esI0RrQC/jU72+UuT/ufp96pCgfQeRfoiuCZAKc+cesV0uFgq4FgCGi3GS+pFhHL9hS
        jsVUCcDpcxumiL6gmYCH2p2DOpRSjRE55cuHDNiocJL+pMA94W2cjAWmcIFnVWbCj3vouB
        Vg66sb/YMzVxiWK5iaYWMRIXBDzrRlQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-5zklw1jNOn-wdCms7iyqDQ-1; Tue, 11 Jul 2023 05:28:44 -0400
X-MC-Unique: 5zklw1jNOn-wdCms7iyqDQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fa8db49267so34478945e9.3
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 02:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689067724; x=1691659724;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ElB96/B5cF3SirD9nOg8hph9QYwwBNtS7UKQZC5Rq/I=;
        b=YRYud2+RLkcYm+wGySupbbtgcJvYoJybcSPrCN59ydrJ0zSYUPYAbI5XcuUdUaqC4S
         C1YBP1luqfI1viT1jFp3m1gWy5NoDdDG33XwVBP8p4qu3sEolXZ2h4GW9f482XOyYCel
         nIaj5cZMEzEaNWhJjD6RLMLgywJBwUNhhzcc2WhVPEQtl3Eeks7pjTfvvWZKuEhq9hAG
         4lu4efHYuHc/te8vD/jlNqcjsARh7VZ/QiFOwllJ3k+kzRF4BNeyUDHJ9zAo1sLa/31V
         rkvZRugPksMcrjzqsRVCmXmgRH1b3ha+xvONnmpcsTuZHHMvCVZ4Nmt62sEhjSczrJyX
         9Xug==
X-Gm-Message-State: ABy/qLblLQVBJTYhdI8NqDmgHXIrJfhixnFTRRigy4O+Dmkrik4TL4V8
        g067qetgI+alv/8l9i5dMlwTHtCnKsw7J9zmX6hWicStRIAla2Z0reNOLoPKZtfF13mH8zMmklO
        MNVc5CPd4iXS6z+z+
X-Received: by 2002:a1c:770c:0:b0:3fc:e7d:ca57 with SMTP id t12-20020a1c770c000000b003fc0e7dca57mr5867888wmi.2.1689067723893;
        Tue, 11 Jul 2023 02:28:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlErR0pfbKYYTEqqfjV/R8pmlUAtY5LKpmt2vZVYMiehafSoIpETSiV+tOoHig0IhHmT5DXRsw==
X-Received: by 2002:a1c:770c:0:b0:3fc:e7d:ca57 with SMTP id t12-20020a1c770c000000b003fc0e7dca57mr5867870wmi.2.1689067723572;
        Tue, 11 Jul 2023 02:28:43 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u13-20020a7bcb0d000000b003fbc9b9699dsm1963148wmj.45.2023.07.11.02.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 02:28:43 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Jocelyn Falempe <jfalempe@redhat.com>, tzimmermann@suse.de,
        airlied@redhat.com, yizhan@redhat.com
Cc:     dri-devel@lists.freedesktop.org,
        Jocelyn Falempe <jfalempe@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/client: Fix memory leak in
 drm_client_target_cloned
In-Reply-To: <20230711092203.68157-2-jfalempe@redhat.com>
References: <20230711092203.68157-1-jfalempe@redhat.com>
 <20230711092203.68157-2-jfalempe@redhat.com>
Date:   Tue, 11 Jul 2023 11:28:42 +0200
Message-ID: <875y6qiyph.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Jocelyn Falempe <jfalempe@redhat.com> writes:

Hello Jocelyn,

> dmt_mode is allocated and never freed in this function.
> It was found with the ast driver, but most drivers using generic fbdev
> setup are probably affected.
>
> This fixes the following kmemleak report:
>   backtrace:
>     [<00000000b391296d>] drm_mode_duplicate+0x45/0x220 [drm]
>     [<00000000e45bb5b3>] drm_client_target_cloned.constprop.0+0x27b/0x480 [drm]
>     [<00000000ed2d3a37>] drm_client_modeset_probe+0x6bd/0xf50 [drm]
>     [<0000000010e5cc9d>] __drm_fb_helper_initial_config_and_unlock+0xb4/0x2c0 [drm_kms_helper]
>     [<00000000909f82ca>] drm_fbdev_client_hotplug+0x2bc/0x4d0 [drm_kms_helper]
>     [<00000000063a69aa>] drm_client_register+0x169/0x240 [drm]
>     [<00000000a8c61525>] ast_pci_probe+0x142/0x190 [ast]
>     [<00000000987f19bb>] local_pci_probe+0xdc/0x180
>     [<000000004fca231b>] work_for_cpu_fn+0x4e/0xa0
>     [<0000000000b85301>] process_one_work+0x8b7/0x1540
>     [<000000003375b17c>] worker_thread+0x70a/0xed0
>     [<00000000b0d43cd9>] kthread+0x29f/0x340
>     [<000000008d770833>] ret_from_fork+0x1f/0x30
> unreferenced object 0xff11000333089a00 (size 128):
>
> cc: <stable@vger.kernel.org>
> Fixes: 1d42bbc8f7f9 ("drm/fbdev: fix cloning on fbcon")
> Reported-by: Zhang Yi <yizhan@redhat.com>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---

The patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

