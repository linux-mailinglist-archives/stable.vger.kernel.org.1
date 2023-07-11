Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568DB74EA91
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 11:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjGKJbx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 05:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjGKJbs (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 05:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB9310EF
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 02:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689067765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ScNK1Ai1AQo1RxKaPMsH8fGKvEv6g/bLxIVdnSrKJew=;
        b=cOnVv9sUdZxxy2rJt0fJwc7rdguz/PSCmEEbYo23VOc8bxfgC1kTFTf7Mtqb3y7nxe54I9
        cXGBKYpuhxjkYHrigv0LyQbuqJrNxmatY2W4EBiaCRYh05qUVCQ4RoIUFRxJuYm0GQ+1TV
        HoBcN1Up1zDzYAzyZ55NfKJJPuaZsYs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-lZxJ7LeLMLej4LnlOcjJCg-1; Tue, 11 Jul 2023 05:29:24 -0400
X-MC-Unique: lZxJ7LeLMLej4LnlOcjJCg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fbefe1b402so34151025e9.1
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 02:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689067763; x=1691659763;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScNK1Ai1AQo1RxKaPMsH8fGKvEv6g/bLxIVdnSrKJew=;
        b=OPLnJdWLuMN8Z122zezTvGbz0qiNVueMIsZVm63KOdk0ZeQIf1/bsQJrpGECIa+GNC
         DBu5SViLj5OVx+tG+ngUKCUtLgO3Kq3ui+jL1pH/I/dHKVJwhbLOk+wG5sNqURuifoWE
         I3ROQG9a+n9R6pNz+tmYAh2Awf0POcFMhDfCg+ur0ZxpST4Gb94y9/TfB92YYyVWwqay
         SS9by9RQAnHKERob6nrekyhJOPe89tbBuN7N04pEU0UFcuctf/2qnOdC07NadaE0Nlqe
         32MMZZQm46m4/6mYnVotYoufhHo92ujdZG3b2zikoWfyVx0NvmTXAT/tBtM3gRNVsZOn
         Q1zg==
X-Gm-Message-State: ABy/qLZ7W21pBkxYCFqQysjk9ygX3965wrvFh5SvAByYUILaPrRNr5Ub
        bwvM/GsS/EHEaqlqUrU0nJnoydD/x028zFZphY+4We1nzHpkFmnhy2UgxEeriFu8yHjGQa12xXB
        vvSej/NNj+DuFRCJ4
X-Received: by 2002:a1c:ed0d:0:b0:3fa:934c:8350 with SMTP id l13-20020a1ced0d000000b003fa934c8350mr13498378wmh.27.1689067763098;
        Tue, 11 Jul 2023 02:29:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF7NRV/m35zkkZpb2UhaNQTGj9kpg+rTHuDLL+a7Z51IaBaVs7CGyqd34Y++AyjSk7TOj+Txg==
X-Received: by 2002:a1c:ed0d:0:b0:3fa:934c:8350 with SMTP id l13-20020a1ced0d000000b003fa934c8350mr13498364wmh.27.1689067762768;
        Tue, 11 Jul 2023 02:29:22 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k24-20020a05600c0b5800b003fc01189b0dsm1959301wmr.42.2023.07.11.02.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 02:29:22 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Jocelyn Falempe <jfalempe@redhat.com>, tzimmermann@suse.de,
        airlied@redhat.com, yizhan@redhat.com
Cc:     dri-devel@lists.freedesktop.org,
        Jocelyn Falempe <jfalempe@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/client: Fix memory leak in
 drm_client_modeset_probe
In-Reply-To: <20230711092203.68157-3-jfalempe@redhat.com>
References: <20230711092203.68157-1-jfalempe@redhat.com>
 <20230711092203.68157-3-jfalempe@redhat.com>
Date:   Tue, 11 Jul 2023 11:29:21 +0200
Message-ID: <87351uiyoe.fsf@minerva.mail-host-address-is-not-set>
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

> When a new mode is set to modeset->mode, the previous mode should be freed.
> This fixes the following kmemleak report:
>
> drm_mode_duplicate+0x45/0x220 [drm]
> drm_client_modeset_probe+0x944/0xf50 [drm]
> __drm_fb_helper_initial_config_and_unlock+0xb4/0x2c0 [drm_kms_helper]
> drm_fbdev_client_hotplug+0x2bc/0x4d0 [drm_kms_helper]
> drm_client_register+0x169/0x240 [drm]
> ast_pci_probe+0x142/0x190 [ast]
> local_pci_probe+0xdc/0x180
> work_for_cpu_fn+0x4e/0xa0
> process_one_work+0x8b7/0x1540
> worker_thread+0x70a/0xed0
> kthread+0x29f/0x340
> ret_from_fork+0x1f/0x30
>
> cc: <stable@vger.kernel.org>
> Reported-by: Zhang Yi <yizhan@redhat.com>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

