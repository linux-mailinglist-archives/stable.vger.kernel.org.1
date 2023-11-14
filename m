Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303DF7EB45F
	for <lists+stable@lfdr.de>; Tue, 14 Nov 2023 17:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbjKNQFV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 14 Nov 2023 11:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjKNQFU (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 14 Nov 2023 11:05:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95BB12C
        for <stable@vger.kernel.org>; Tue, 14 Nov 2023 08:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699977917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j565Cy9XLw29CBi7bfBFtO6psEQo+EfQSVIEvDNtFvA=;
        b=iJYuPWuX+L7j7aLa2wBj9A+hq9VMQN/Dqu+h3iwsaD814vky+rb7jGnLef0vWlZcjjou0E
        BRxoO2LmRabB8OKHBNcjwokaq32RyFlU4AgZk7/IVgEb4ICZSEGUsxlPhbKJvUuWXxOJIn
        mNXhG0T6MWbu9LTKgA70ToK+xUvPIUo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-OofeMEXhPeWLvfoaLRZ1lQ-1; Tue, 14 Nov 2023 11:05:15 -0500
X-MC-Unique: OofeMEXhPeWLvfoaLRZ1lQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-66fbd3bc8ebso73573686d6.1
        for <stable@vger.kernel.org>; Tue, 14 Nov 2023 08:05:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699977915; x=1700582715;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j565Cy9XLw29CBi7bfBFtO6psEQo+EfQSVIEvDNtFvA=;
        b=RAiIFxhqf+ZolpQWt5jumCbbql8NnQhdS/01wvF6Z/nQEiTho+3hu9B/RfGvIK04fD
         4PrlHVIiqiJ1D3Q3UEEBBIpofbNq3kTEQlXK2EzoSdR8YzCcvZfOadwdanAOgsl9zbPV
         8AIj5yppJlAoIB7rynQlg2K49NmtM3gxZzU9lP92c2XKN188GOgtGSdtb4zbcoccyctz
         k3IutZilGDCk8nsSbpx24ltv3FY6LNHJ42G9i5pHRq1t42wkOrS/UAx3ZDW6tgD0UV3o
         PYHEJN1yX/1InvqkhBA07y8imLcsIRpp/S8g6+U9Zitlb8DNFSHudDE2KoSIcyob5H3C
         7fVg==
X-Gm-Message-State: AOJu0YycFOoE15d75f6GxDPEVTP8W8hMJpMjLRvdpGP4KP1gA0UH7BL6
        JWhrfJJml5g6wimbKUXY75RZQiWVINnJELwxCP1UkvyMCLkIteExqqKCES+uSBGykDzRQ4eGuCy
        VzuGxDI6i0OLxBLpL
X-Received: by 2002:a0c:f74a:0:b0:66d:37be:47d2 with SMTP id e10-20020a0cf74a000000b0066d37be47d2mr2515136qvo.37.1699977915003;
        Tue, 14 Nov 2023 08:05:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFG72Y2KWMfjoNvHFLMOeHbUicAjGXWzGnJiPCUY7t9jfN0rIz/VFTXo03rJ2HlwwIWkmmcoA==
X-Received: by 2002:a0c:f74a:0:b0:66d:37be:47d2 with SMTP id e10-20020a0cf74a000000b0066d37be47d2mr2515103qvo.37.1699977914680;
        Tue, 14 Nov 2023 08:05:14 -0800 (PST)
Received: from localhost ([195.166.127.210])
        by smtp.gmail.com with ESMTPSA id h13-20020a0ceecd000000b00671b009412asm2967374qvs.141.2023.11.14.08.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 08:05:14 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, Gerd Hoffmann <kraxel@redhat.com>,
        nerdopolis <bluescreen_avenger@verizon.net>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Bilal Elmoussaoui <belmouss@redhat.com>,
        Maxime Ripard <mripard@kernel.org>, stable@vger.kernel.org,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        Erico Nunes <nunes.erico@gmail.com>
Subject: Re: [PATCH 2/6] drm: Add
 drm_atomic_helper_buffer_damage_{iter_init, merged}() helpers
In-Reply-To: <6e663e37-b735-47f7-a841-fa0f93fdddaf@suse.de>
References: <20231109172449.1599262-1-javierm@redhat.com>
 <20231109172449.1599262-3-javierm@redhat.com>
 <6e663e37-b735-47f7-a841-fa0f93fdddaf@suse.de>
Date:   Tue, 14 Nov 2023 17:05:12 +0100
Message-ID: <87zfzg5nif.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi
>
> Am 09.11.23 um 18:24 schrieb Javier Martinez Canillas:

[...]

>>   	struct drm_rect src;
>>   	memset(iter, 0, sizeof(*iter));
>> @@ -223,7 +224,8 @@ __drm_atomic_helper_damage_iter_init(struct drm_atomic_helper_damage_iter *iter,
>>   	iter->plane_src.x2 = (src.x2 >> 16) + !!(src.x2 & 0xFFFF);
>>   	iter->plane_src.y2 = (src.y2 >> 16) + !!(src.y2 & 0xFFFF);
>>   
>> -	if (!iter->clips || !drm_rect_equals(&state->src, &old_state->src)) {
>> +	if (!iter->clips || !drm_rect_equals(&state->src, &old_state->src) ||
>> +	    (buffer_damage && old_state->fb != state->fb)) {
>
> I'd assume that this change effectivly disables damage handling. AFAICT 
> user space often does a page flip with a new framebuffer plus damage 
> data. Now, with each change of the framebuffer we ignore the damage 
> information. It's not a blocker as that's the behavior before 6.4, but 
> we should be aware of it.
>

Yes, which is the goal of this patch since page flip with a new framebuffer
attached to a plane plus damage information can't be supported by drivers
that do per-buffer uploads.

This was causing some weston and wlroots to have flickering artifacts, due
the framebuffers being changed since the last plane update.

For now it was decided with Sima, Simon and Pekka that is the best we can
do and the reason why I add a TODO in patch #6.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

