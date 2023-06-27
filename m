Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE18273F714
	for <lists+stable@lfdr.de>; Tue, 27 Jun 2023 10:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjF0I1r (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 27 Jun 2023 04:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjF0I1q (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Jun 2023 04:27:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5651998
        for <stable@vger.kernel.org>; Tue, 27 Jun 2023 01:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687854416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8rtWVv0EL741DRzDjUllIDtQPY8B5mWR0btwemUl7xE=;
        b=R0Vo6zs+r9MF82220VeSbEVroVNLl+dnMW/P/IN6lD9zKJ234wYEjICV1miJVBs9b5RUQo
        94Bs71vwZrJN6R5TEkpMYTNrmyMTjelZHLC/dfMqxKGb7OEpRmh7uAL/L2uON9innAAvrn
        at0lxGI7z/Zl6HxTf1OwllppEDb9Mkw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-9MrQ-iCCMrqUlAdeYv2PIg-1; Tue, 27 Jun 2023 04:26:55 -0400
X-MC-Unique: 9MrQ-iCCMrqUlAdeYv2PIg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4edc5526c5fso3485069e87.2
        for <stable@vger.kernel.org>; Tue, 27 Jun 2023 01:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687854414; x=1690446414;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8rtWVv0EL741DRzDjUllIDtQPY8B5mWR0btwemUl7xE=;
        b=K8HaNQ1T4Si+s0gbva1Fz3hwggRqr/+P1sYiTdFC+8nbqyCE1ZPCUFPg/TWanI/GV+
         YgwB/C3vbSYiSPnSAVns4OS5AwcxG7AW/4e26288BhsWhRUzfIvFQZT523EroXTJjcyg
         j23bsQAIsx1Mr2TlfoJiJ5e3f3/jDyUMW1bkH+nJ+YMQ3iM7BskGDriP1W0giCtoybMY
         uJaJ88nwJSxA8FcEQedSf63Yw//YbTCWkL62ngZWey3QXyGI6LIaOv34gElQQwIQ1OUv
         D4NhggU6NgGZq5oBdGPCHkWYlNrgS2Rf0wMzEg0C0e/GxR3REQdDIXpHcSKOZeKBpFtX
         8e9g==
X-Gm-Message-State: AC+VfDxkXJmpW/YGQb1DPA6i6bEW826ILNhkcz24EREcJ94IpGlAk3Lm
        bFqqTACvNGpyPjGidCvvg4j4O7S4BFti1DONda4mq07f8O/7zeKRF/TUGssr03KicYRJoNXq+sS
        7rUM9Pe4ISPfQ+ZFa
X-Received: by 2002:a19:6457:0:b0:4f8:5604:4b50 with SMTP id b23-20020a196457000000b004f856044b50mr17471137lfj.64.1687854414092;
        Tue, 27 Jun 2023 01:26:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4gMLmvg0ErLZiC0/qz9kyD8D8kBlD0tBf8HFjVdpwUt1NiUlbupacFiOJlc/k+zzRwZBBYBg==
X-Received: by 2002:a19:6457:0:b0:4f8:5604:4b50 with SMTP id b23-20020a196457000000b004f856044b50mr17471127lfj.64.1687854413766;
        Tue, 27 Jun 2023 01:26:53 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d9-20020a5d6dc9000000b0030ae53550f5sm9635481wrz.51.2023.06.27.01.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 01:26:53 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Zack Rusin <zackr@vmware.com>, dri-devel@lists.freedesktop.org
Cc:     Maxime Ripard <mripard@kernel.org>,
        spice-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        David Airlie <airlied@linux.ie>, banackm@vmware.com,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        krastevm@vmware.com, ppaalanen@gmail.com,
        Dave Airlie <airlied@redhat.com>, stable@vger.kernel.org,
        iforbes@vmware.com, virtualization@lists.linux-foundation.org,
        mombasawalam@vmware.com, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 1/8] drm: Disable the cursor plane on atomic contexts
 with virtualized drivers
In-Reply-To: <20230627035839.496399-2-zack@kde.org>
References: <20230627035839.496399-1-zack@kde.org>
 <20230627035839.496399-2-zack@kde.org>
Date:   Tue, 27 Jun 2023 10:26:51 +0200
Message-ID: <875y7948fo.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Zack Rusin <zack@kde.org> writes:

Hello Zack,

> From: Zack Rusin <zackr@vmware.com>
>
> Cursor planes on virtualized drivers have special meaning and require
> that the clients handle them in specific ways, e.g. the cursor plane
> should react to the mouse movement the way a mouse cursor would be
> expected to and the client is required to set hotspot properties on it
> in order for the mouse events to be routed correctly.
>
> This breaks the contract as specified by the "universal planes". Fix it
> by disabling the cursor planes on virtualized drivers while adding
> a foundation on top of which it's possible to special case mouse cursor
> planes for clients that want it.
>
> Disabling the cursor planes makes some kms compositors which were broken,
> e.g. Weston, fallback to software cursor which works fine or at least
> better than currently while having no effect on others, e.g. gnome-shell
> or kwin, which put virtualized drivers on a deny-list when running in
> atomic context to make them fallback to legacy kms and avoid this issue.
>
> Signed-off-by: Zack Rusin <zackr@vmware.com>
> Fixes: 681e7ec73044 ("drm: Allow userspace to ask for universal plane list (v2)")
> Cc: <stable@vger.kernel.org> # v5.4+
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Gurchetan Singh <gurchetansingh@chromium.org>
> Cc: Chia-I Wu <olvaffe@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: spice-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/drm_plane.c          | 13 +++++++++++++
>  drivers/gpu/drm/qxl/qxl_drv.c        |  2 +-
>  drivers/gpu/drm/vboxvideo/vbox_drv.c |  2 +-
>  drivers/gpu/drm/virtio/virtgpu_drv.c |  2 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c  |  2 +-
>  include/drm/drm_drv.h                |  9 +++++++++
>  include/drm/drm_file.h               | 12 ++++++++++++
>  7 files changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> index 24e7998d1731..a4a39f4834e2 100644
> --- a/drivers/gpu/drm/drm_plane.c
> +++ b/drivers/gpu/drm/drm_plane.c
> @@ -678,6 +678,19 @@ int drm_mode_getplane_res(struct drm_device *dev, void *data,
>  		    !file_priv->universal_planes)
>  			continue;
>  
> +		/*
> +		 * If we're running on a virtualized driver then,
> +		 * unless userspace advertizes support for the
> +		 * virtualized cursor plane, disable cursor planes
> +		 * because they'll be broken due to missing cursor
> +		 * hotspot info.
> +		 */
> +		if (plane->type == DRM_PLANE_TYPE_CURSOR &&
> +		    drm_core_check_feature(dev, DRIVER_CURSOR_HOTSPOT)	&&

Nit: you have a tab instead of an space before && but this can just be
fixed when applying.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

