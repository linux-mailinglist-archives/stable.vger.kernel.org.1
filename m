Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FE26F4037
	for <lists+stable@lfdr.de>; Tue,  2 May 2023 11:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbjEBJdK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 2 May 2023 05:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbjEBJdJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 2 May 2023 05:33:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46564C08
        for <stable@vger.kernel.org>; Tue,  2 May 2023 02:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683019945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qGbrqqVaDpm05AHuHwpsi1G8xPM+DXbg5Uuq7VcQFf0=;
        b=FnLPvUMGHeF2UYdCOXxDN5MZVj/S9yqjGViCRDEfm/V6hLlL7F6DhRkl/mf9r7WBY+yeCd
        o5+52E6zsVbOmSN89IFBAVsxc+0Gw1ifDzenM/YfR+QtR7e6X2MxltSMi+L7D7d1b0VX4R
        P5Gt3WQa72yfVytH7VAa0yvzVHQycns=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-IlzlPgWxO--2g3zvTLc2kQ-1; Tue, 02 May 2023 05:32:24 -0400
X-MC-Unique: IlzlPgWxO--2g3zvTLc2kQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f315735edeso99814815e9.1
        for <stable@vger.kernel.org>; Tue, 02 May 2023 02:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683019943; x=1685611943;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qGbrqqVaDpm05AHuHwpsi1G8xPM+DXbg5Uuq7VcQFf0=;
        b=QhsaQQxTxI5dcbNntT2KEOdcQPNXV6DH7z4r7uv+nK6JO/KjuJyPEPjNK6+Z6LG6J5
         qgbmvWB0PO2qgPY8esd3F76ttpobpWFNkJjQbhQ4Vx94LbqQSYAlBA8SCMX9aRRKGrWl
         2yqmdZfCYn8udLrgd8hyOmGpe+GkOz9lBXKZ/L39X/5fFQ3Gsf2NGKLw3d3agxe98Diz
         ZCv7I1awVusAfITzAqHbbMnfM7eFgVGT5WG2NhKKqz3AnHi2W6xPWoFTFpX6DL4uY8y9
         U+IF3yY+3oW8TqLndp204bcb1bCj/mOv20qcHkIIiGajHA+l84nIYYSoGuhPJbhAWZYo
         LSlw==
X-Gm-Message-State: AC+VfDwdwkGvlJmXcX6jzILpjgBH4Ou3jVUZgj+KDDhDqd2Al4cFc+a/
        jcpQgFLGrauVW+jitUZtbJwHWiwaDcAuHflSj8IP2WIwYglj3pNd+LcoOWSMEehIRzJLStsCU/M
        2r69WPqYREl9Ll4sa
X-Received: by 2002:adf:ed4c:0:b0:2fa:d00d:cab8 with SMTP id u12-20020adfed4c000000b002fad00dcab8mr10523011wro.18.1683019942996;
        Tue, 02 May 2023 02:32:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Ny0SyxqPYdHROomDFuM2aXgIRoSLjZ8P4kUjzBL7vSVfqP59DeMhAr12tCEWBDTuCR61IBQ==
X-Received: by 2002:adf:ed4c:0:b0:2fa:d00d:cab8 with SMTP id u12-20020adfed4c000000b002fad00dcab8mr10522995wro.18.1683019942677;
        Tue, 02 May 2023 02:32:22 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h16-20020a5d5490000000b00304b5b2f5ffsm12180965wrv.53.2023.05.02.02.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 02:32:22 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zackr@vmware.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        David Airlie <airlied@linux.ie>, stable@vger.kernel.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        krastevm@vmware.com, ppaalanen@gmail.com,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        spice-devel@lists.freedesktop.org,
        Dave Airlie <airlied@redhat.com>,
        virtualization@lists.linux-foundation.org, mombasawalam@vmware.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        Bilal Elmoussaoui <belmouss@redhat.com>
Subject: Re: [PATCH v2 1/8] drm: Disable the cursor plane on atomic contexts
 with virtualized drivers
In-Reply-To: <YvPfedG/uLQNFG7e@phenom.ffwll.local>
References: <20220712033246.1148476-1-zack@kde.org>
 <20220712033246.1148476-2-zack@kde.org>
 <YvPfedG/uLQNFG7e@phenom.ffwll.local>
Date:   Tue, 02 May 2023 11:32:21 +0200
Message-ID: <87lei7xemy.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Daniel Vetter <daniel@ffwll.ch> writes:

> On Mon, Jul 11, 2022 at 11:32:39PM -0400, Zack Rusin wrote:
>> From: Zack Rusin <zackr@vmware.com>
>> 
>> Cursor planes on virtualized drivers have special meaning and require
>> that the clients handle them in specific ways, e.g. the cursor plane
>> should react to the mouse movement the way a mouse cursor would be
>> expected to and the client is required to set hotspot properties on it
>> in order for the mouse events to be routed correctly.
>> 
>> This breaks the contract as specified by the "universal planes". Fix it
>> by disabling the cursor planes on virtualized drivers while adding
>> a foundation on top of which it's possible to special case mouse cursor
>> planes for clients that want it.
>> 
>> Disabling the cursor planes makes some kms compositors which were broken,
>> e.g. Weston, fallback to software cursor which works fine or at least
>> better than currently while having no effect on others, e.g. gnome-shell
>> or kwin, which put virtualized drivers on a deny-list when running in
>> atomic context to make them fallback to legacy kms and avoid this issue.
>> 
>> Signed-off-by: Zack Rusin <zackr@vmware.com>
>> Fixes: 681e7ec73044 ("drm: Allow userspace to ask for universal plane list (v2)")

[...]

>> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
>> index f6159acb8856..c4cd7fc350d9 100644
>> --- a/include/drm/drm_drv.h
>> +++ b/include/drm/drm_drv.h
>> @@ -94,6 +94,16 @@ enum drm_driver_feature {
>>  	 * synchronization of command submission.
>>  	 */
>>  	DRIVER_SYNCOBJ_TIMELINE         = BIT(6),
>> +	/**
>> +	 * @DRIVER_VIRTUAL:
>> +	 *
>> +	 * Driver is running on top of virtual hardware. The most significant
>> +	 * implication of this is a requirement of special handling of the
>> +	 * cursor plane (e.g. cursor plane has to actually track the mouse
>> +	 * cursor and the clients are required to set hotspot in order for
>> +	 * the cursor planes to work correctly).
>> +	 */
>> +	DRIVER_VIRTUAL                  = BIT(7),
>
> I think the naming here is unfortunate, because people will vonder why
> e.g. vkms doesn't set this, and then add it, and confuse stuff completely.
>
> Also it feels a bit wrong to put this onto the driver, when really it's a
> cursor flag. I guess you can make it some kind of flag in the drm_plane
> structure, or a new plane type, but putting it there instead of into the
> "random pile of midlayer-mistake driver flags" would be a lot better.
>
> Otherwise I think the series looks roughly how I'd expect it to look.
> -Daniel
>

AFAICT this is the only remaining thing to be addressed for this series ?

Zack, are you planning to re-spin a v3 of this patch-set? Asking because
we want to take virtio-gpu out of the atomic KMS deny list in mutter, but
first need this to land.

If you think that won't be able to do it in the short term, Bilal (Cc'ed)
or me would be glad to help with that.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

