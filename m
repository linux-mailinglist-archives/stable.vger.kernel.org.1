Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAAC6F5232
	for <lists+stable@lfdr.de>; Wed,  3 May 2023 09:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjECHts (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 3 May 2023 03:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECHtr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 3 May 2023 03:49:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DA61981
        for <stable@vger.kernel.org>; Wed,  3 May 2023 00:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683100140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i8GuagGh12Y8dqwOG9xS20hgt65TOsDgcxOw1iS+qhg=;
        b=U4+ToPNyc5tscVvSoEe9+X4D4jKRvAOVeRveu9YlZ4EztqNtn1N5tz/1eBWRRs1ouBr7LX
        iziO3Amf3uD+wo3lWBebYT+mqb6ENR08zVQDEiwBxSaJx+BSlEP/L9bvZjp1TVlCa8pOS0
        aOabBe4KIa4fQTlIgrnoqUnEMM8u64Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-LuyNTls9MoCeXrTSKvIZ5A-1; Wed, 03 May 2023 03:48:57 -0400
X-MC-Unique: LuyNTls9MoCeXrTSKvIZ5A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f250e9e090so15169445e9.0
        for <stable@vger.kernel.org>; Wed, 03 May 2023 00:48:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683100136; x=1685692136;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8GuagGh12Y8dqwOG9xS20hgt65TOsDgcxOw1iS+qhg=;
        b=KfSjodx8w3M2THK7p0trTGMTd7aQmw9avdhl/kOKkUwuIF+4wZkCtw81SdYY7WRVZ5
         zXslzuiyiUP5C56yGWsRJN+mEq37QYpKj5EIc7sCxmxD92oKNEOaJw6rMhsY/LTFsVhq
         U8NQoCarhWPBjVbfEsm+7B8cVkA4gUG2orUrSWsvQp1Qr66zE+mWvTIS81EhEzbcdLiA
         quiCr7g6+6cuj4lRDcVeBJp489JfDPeB7fz323A0g2Y7ERoE3uyFfVcRBkjYnQBx6jfD
         uHGN04Yx17/8P5lw/q/1FgDGhOZW5MuOKixPPvsCB65qdzUPOekiS4J+g/GlI+/No6Ay
         csmQ==
X-Gm-Message-State: AC+VfDxlQ/dz4rkpqWw6xucffciDEUXv+Hs+gFvD0QV2bdfZvbE0VVS7
        UJgKO/NqhXbBhcLiSG749G/IvqkYk0SAMOonrkBPAxQb6KmEvULHXsMxGepAt3/WGV+svYm+KOx
        YcyzaPcMJTzUyTT6+
X-Received: by 2002:adf:e647:0:b0:306:3153:d2fe with SMTP id b7-20020adfe647000000b003063153d2femr4822119wrn.27.1683100136084;
        Wed, 03 May 2023 00:48:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5eW0PIBX8uPAgG/Q8Ux09ES8w2XRlQ17kdIQmtm473aruCX7JTiFMviLSM1O6xcF9inhGdBg==
X-Received: by 2002:adf:e647:0:b0:306:3153:d2fe with SMTP id b7-20020adfe647000000b003063153d2femr4822101wrn.27.1683100135671;
        Wed, 03 May 2023 00:48:55 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k1-20020a7bc301000000b003eddc6aa5fasm1011062wmj.39.2023.05.03.00.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 00:48:55 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Zack Rusin <zackr@vmware.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>
Cc:     Maaz Mombasawala <mombasawalam@vmware.com>,
        "airlied@redhat.com" <airlied@redhat.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "gurchetansingh@chromium.org" <gurchetansingh@chromium.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        Martin Krastev <krastevm@vmware.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "belmouss@redhat.com" <belmouss@redhat.com>,
        "spice-devel@lists.freedesktop.org" 
        <spice-devel@lists.freedesktop.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "ppaalanen@gmail.com" <ppaalanen@gmail.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        Jonas =?utf-8?Q?=C3=85dahl?= <jadahl@gmail.com>
Subject: Re: [PATCH v2 1/8] drm: Disable the cursor plane on atomic contexts
 with virtualized drivers
In-Reply-To: <0dd2fa763aa0e659c8cbae94f283d8101450082a.camel@vmware.com>
References: <20220712033246.1148476-1-zack@kde.org>
 <20220712033246.1148476-2-zack@kde.org>
 <YvPfedG/uLQNFG7e@phenom.ffwll.local>
 <87lei7xemy.fsf@minerva.mail-host-address-is-not-set>
 <0dd2fa763aa0e659c8cbae94f283d8101450082a.camel@vmware.com>
Date:   Wed, 03 May 2023 09:48:54 +0200
Message-ID: <87y1m5x3bt.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Zack Rusin <zackr@vmware.com> writes:

> On Tue, 2023-05-02 at 11:32 +0200, Javier Martinez Canillas wrote:
>> !! External Email
>>=20
>> Daniel Vetter <daniel@ffwll.ch> writes:
>>=20
>> > On Mon, Jul 11, 2022 at 11:32:39PM -0400, Zack Rusin wrote:
>> > > From: Zack Rusin <zackr@vmware.com>
>> > >=20
>> > > Cursor planes on virtualized drivers have special meaning and require
>> > > that the clients handle them in specific ways, e.g. the cursor plane
>> > > should react to the mouse movement the way a mouse cursor would be
>> > > expected to and the client is required to set hotspot properties on =
it
>> > > in order for the mouse events to be routed correctly.
>> > >=20
>> > > This breaks the contract as specified by the "universal planes". Fix=
 it
>> > > by disabling the cursor planes on virtualized drivers while adding
>> > > a foundation on top of which it's possible to special case mouse cur=
sor
>> > > planes for clients that want it.
>> > >=20
>> > > Disabling the cursor planes makes some kms compositors which were br=
oken,
>> > > e.g. Weston, fallback to software cursor which works fine or at least
>> > > better than currently while having no effect on others, e.g. gnome-s=
hell
>> > > or kwin, which put virtualized drivers on a deny-list when running in
>> > > atomic context to make them fallback to legacy kms and avoid this is=
sue.
>> > >=20
>> > > Signed-off-by: Zack Rusin <zackr@vmware.com>
>> > > Fixes: 681e7ec73044 ("drm: Allow userspace to ask for universal plan=
e list
>> > > (v2)")
>>=20
>> [...]
>>=20
>> > > diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
>> > > index f6159acb8856..c4cd7fc350d9 100644
>> > > --- a/include/drm/drm_drv.h
>> > > +++ b/include/drm/drm_drv.h
>> > > @@ -94,6 +94,16 @@ enum drm_driver_feature {
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * synchronization of command submissi=
on.
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> > > =C2=A0=C2=A0=C2=A0=C2=A0 DRIVER_SYNCOBJ_TIMELINE=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D BIT(6),
>> > > +=C2=A0=C2=A0=C2=A0 /**
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * @DRIVER_VIRTUAL:
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0 *
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * Driver is running on top of virtual hard=
ware. The most significant
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * implication of this is a requirement of =
special handling of the
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * cursor plane (e.g. cursor plane has to a=
ctually track the mouse
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * cursor and the clients are required to s=
et hotspot in order for
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * the cursor planes to work correctly).
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> > > +=C2=A0=C2=A0=C2=A0 DRIVER_VIRTUAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D B=
IT(7),
>> >=20
>> > I think the naming here is unfortunate, because people will vonder why
>> > e.g. vkms doesn't set this, and then add it, and confuse stuff complet=
ely.
>> >=20
>> > Also it feels a bit wrong to put this onto the driver, when really it'=
s a
>> > cursor flag. I guess you can make it some kind of flag in the drm_plane
>> > structure, or a new plane type, but putting it there instead of into t=
he
>> > "random pile of midlayer-mistake driver flags" would be a lot better.
>> >=20
>> > Otherwise I think the series looks roughly how I'd expect it to look.
>> > -Daniel
>> >=20
>>=20
>> AFAICT this is the only remaining thing to be addressed for this series ?
>
> No, there was more. tbh I haven't had the time to think about whether the=
 above
> makes sense to me, e.g. I'm not sure if having virtualized drivers expose=
 "support
> universal planes" and adding another plane which is not universal (the on=
ly
> "universal" plane on them being the default one) makes more sense than a =
flag that
> says "this driver requires a cursor in the cursor plane". There's certain=
ly a huge
> difference in how userspace would be required to handle it and it's way u=
glier with
> two different cursor planes. i.e. there's a lot of ways in which this cou=
ld be
> cleaner in the kernel but they all require significant changes to userspa=
ce, that go
> way beyond "attach hotspot info to this plane". I'd like to avoid approac=
hes that
> mean running with atomic kms requires completely separate paths for virtu=
alized
> drivers because no one will ever support and maintain it.
>
> It's not a trivial thing because it's fundamentally hard to untangle the =
fact the
> virtualized drivers have been advertising universal plane support without=
 ever
> supporting universal planes. Especially because most new userspace in gen=
eral checks
> for "universal planes" to expose atomic kms paths.
>

After some discussion on the #dri-devel, your approach makes sense and the
only contention point is the name of the driver feature flag name. The one
you are using (DRIVER_VIRTUAL) seems to be too broad and generic (the fact
that vkms won't set and is a virtual driver as well, is a good example).

Maybe something like DRIVER_CURSOR_HOTSPOT or DRIVER_CURSOR_COMMANDEERING
would be more accurate and self explanatory ?

> The other thing blocking this series was the testing of all the edge case=
s, I think
> Simon and Pekka had some ideas for things to test (e.g. run mutter with s=
upport for
> this and wayland without support for this in at the same time in differen=
t consoles
> and see what happens). I never had the time to do that either.
>

I understand that every new feature needs tests but I fail to see why
the bar is higher for this feature than others? I would prefer if this
series are not blocked due some potential issues on hypothetical corner
cases that might not happen in practice. Or do people really run two or
more compositors on different console and switch between them ?

>> Zack, are you planning to re-spin a v3 of this patch-set? Asking because
>> we want to take virtio-gpu out of the atomic KMS deny list in mutter, but
>> first need this to land.
>>=20
>> If you think that won't be able to do it in the short term, Bilal (Cc'ed)
>> or me would be glad to help with that.
>
> This has been on my todo for a while I just never had the time to go thro=
ugh all the
> remaining issues. Fundamentally it's not so much a technical issue anymor=
e, it's
> about picking the least broken solution and trying to make the best out o=
f a pretty
> bad situation. In general it's hard to paint a bikeshed if all you have i=
s a million
> shades of gray ;)
>

Agreed. And I believe that other than the driver cap name, everyone agrees
with the color of your bikeshed :)

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

