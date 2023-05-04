Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A69B6F69E4
	for <lists+stable@lfdr.de>; Thu,  4 May 2023 13:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjEDL1n (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 4 May 2023 07:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjEDL1b (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 4 May 2023 07:27:31 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3093C49CA
        for <stable@vger.kernel.org>; Thu,  4 May 2023 04:27:27 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4ec8133c59eso441692e87.0
        for <stable@vger.kernel.org>; Thu, 04 May 2023 04:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683199645; x=1685791645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HlGAwr6Tz+0zx4SM+k0TA3M2k56Uc0XuDTrVr+UZgU0=;
        b=ag9tT8KSMR/1QiTcbUm/n0fjfOZDn9F0JggYgshuaHi/8EHM5qWZTGSjx5f6K3zMpm
         ueXi+kOghfjxbYmWMv9AsYq+oV3TkgumWRdxWVLRIx0M7/vutTuvRu3o8iOqkFEnJFpC
         IAYFoQRSISuzn0mrVhua5UaK7FMdkYqsPEvQgJkTXn/7DP/helFCxigMgA8QgX7uZZG/
         NHILxIV8M6ZYn6Dc3kSoMsOW8EcKJDHeL50g9QjSzip3soVWd4jv4qnndmwKDm67garI
         PurQgnnzGbn74JR0Pfn8ouDFcxjA6j/WX4+HHe/oONWRzJ/Y04FIA6Gwo6nm8gxSv6Fp
         RICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683199645; x=1685791645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlGAwr6Tz+0zx4SM+k0TA3M2k56Uc0XuDTrVr+UZgU0=;
        b=jL66u5rs0Js/1DYG8OtI2tbQLgQItu59/cKQA4SuXa04YeT+Ut5HyF5tbDDEOC2LT+
         OogvO98QJRnrFNWrO8DjUFbjAjc0kdiyA/leZvNfsTyF5Ns2a2d3Mj2BL+7iskquFgbC
         QmuklIZh2Uu2xPycqy0ZrWolj83aBwUjyl0iCF0jC5YNvXXW039OIdwuvRuD2U/YA2N2
         b8uV3LveLtJ55tNGuHAgZPweuzGBeU1Qd0azsyn+z83zg5STuEDmcEfXXxovxkLYfSmV
         s5pYLCKAUsUTgd2fi+31FRf/A7EwtwCozN/36lNTwyuWR+vBEgBWkkJvMIg5cNJL5WR2
         z2Eg==
X-Gm-Message-State: AC+VfDzxaq/Eg1BR5x+lKSNE7Sb0WS8Ws/etLWg89i6fKo6gMY95LNv2
        2lvDMMZ+tOdqA9/ZhDkKSuM=
X-Google-Smtp-Source: ACHHUZ78SqVNlDvF9KDWWYhViGgK0f+1J00vynjUGpbnemI0ngETowChZFGm2j5wmPM4SOi7Xl/jwg==
X-Received: by 2002:ac2:4e49:0:b0:4eb:1361:895c with SMTP id f9-20020ac24e49000000b004eb1361895cmr1819667lfr.55.1683199645107;
        Thu, 04 May 2023 04:27:25 -0700 (PDT)
Received: from gmail.com (host-95-193-100-112.mobileonline.telia.com. [95.193.100.112])
        by smtp.gmail.com with ESMTPSA id b25-20020a056512025900b004cb23904bd9sm6501560lfo.144.2023.05.04.04.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 04:27:24 -0700 (PDT)
Date:   Thu, 4 May 2023 13:27:22 +0200
From:   Jonas =?iso-8859-1?Q?=C5dahl?= <jadahl@gmail.com>
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     Zack Rusin <zackr@vmware.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "javierm@redhat.com" <javierm@redhat.com>,
        "airlied@redhat.com" <airlied@redhat.com>,
        "belmouss@redhat.com" <belmouss@redhat.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        Martin Krastev <krastevm@vmware.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "gurchetansingh@chromium.org" <gurchetansingh@chromium.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "spice-devel@lists.freedesktop.org" 
        <spice-devel@lists.freedesktop.org>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        Maaz Mombasawala <mombasawalam@vmware.com>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "airlied@linux.ie" <airlied@linux.ie>
Subject: Re: [PATCH v2 1/8] drm: Disable the cursor plane on atomic contexts
 with virtualized drivers
Message-ID: <ZFOWmhZGEmaksTAo@gmail.com>
References: <20220712033246.1148476-1-zack@kde.org>
 <20220712033246.1148476-2-zack@kde.org>
 <YvPfedG/uLQNFG7e@phenom.ffwll.local>
 <87lei7xemy.fsf@minerva.mail-host-address-is-not-set>
 <0dd2fa763aa0e659c8cbae94f283d8101450082a.camel@vmware.com>
 <87y1m5x3bt.fsf@minerva.mail-host-address-is-not-set>
 <17cc969e9f13fab112827e154495eca28c4bd2b6.camel@vmware.com>
 <20230504133904.4ad3011c@eldfell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504133904.4ad3011c@eldfell>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, May 04, 2023 at 01:39:04PM +0300, Pekka Paalanen wrote:
> On Thu, 4 May 2023 01:50:25 +0000
> Zack Rusin <zackr@vmware.com> wrote:
> 
> > On Wed, 2023-05-03 at 09:48 +0200, Javier Martinez Canillas wrote:
> > > Zack Rusin <zackr@vmware.com> writes:
> > >   
> > > > On Tue, 2023-05-02 at 11:32 +0200, Javier Martinez Canillas wrote:  
> 
> > > > > AFAICT this is the only remaining thing to be addressed for this series ?  
> > > > 
> > > > No, there was more. tbh I haven't had the time to think about whether the above
> > > > makes sense to me, e.g. I'm not sure if having virtualized drivers expose
> > > > "support
> > > > universal planes" and adding another plane which is not universal (the only
> > > > "universal" plane on them being the default one) makes more sense than a flag
> > > > that
> > > > says "this driver requires a cursor in the cursor plane". There's certainly a
> > > > huge
> > > > difference in how userspace would be required to handle it and it's way uglier
> > > > with
> > > > two different cursor planes. i.e. there's a lot of ways in which this could be
> > > > cleaner in the kernel but they all require significant changes to userspace,
> > > > that go
> > > > way beyond "attach hotspot info to this plane". I'd like to avoid approaches
> > > > that
> > > > mean running with atomic kms requires completely separate paths for virtualized
> > > > drivers because no one will ever support and maintain it.
> > > > 
> > > > It's not a trivial thing because it's fundamentally hard to untangle the fact
> > > > the
> > > > virtualized drivers have been advertising universal plane support without ever
> > > > supporting universal planes. Especially because most new userspace in general
> > > > checks
> > > > for "universal planes" to expose atomic kms paths.
> > > >   
> > > 
> > > After some discussion on the #dri-devel, your approach makes sense and the
> > > only contention point is the name of the driver feature flag name. The one
> > > you are using (DRIVER_VIRTUAL) seems to be too broad and generic (the fact
> > > that vkms won't set and is a virtual driver as well, is a good example).
> > > 
> > > Maybe something like DRIVER_CURSOR_HOTSPOT or DRIVER_CURSOR_COMMANDEERING
> > > would be more accurate and self explanatory ?  
> > 
> > Sure, or even more verbose DRIVER_NEEDS_CURSOR_PLANE_HOTSPOT, but it sounds like
> > Pekka doesn't agree with this approach. As I mentioned in my response to him, I'd be
> > happy with any approach that gets paravirtualized drivers working with atomic kms,
> > but atm I don't have enough time to be creating a new kernel subsystem or a new set
> > of uapi's for paravirtualized drivers and then porting mutter/kwin to those.
> 
> It seems I have not been clear enough, apologies. Once more, in short:
> 
> Zack, I'm worried about this statement from you (copied from above):
> 
> > > > I'd like to avoid approaches that mean running with atomic kms
> > > > requires completely separate paths for virtualized drivers
> > > > because no one will ever support and maintain it.
> 
> It feels like you are intentionally limiting your own design options
> for the fear of "no one will ever support it". I'm worried that over
> the coming years, that will lead to a hard to use, hard to maintain
> patchwork of vague or undocumented or just too many little UAPI details.
> 
> Please, don't limit your designs. There are good reasons why nested KMS
> drivers behave fundamentally differently to most KMS hardware drivers.
> Userspace that does not or cannot take that into account is unavoidably
> crippled.

From a compositor side, there is a valid reason to minimize the uAPI
difference between "nested virtual machine" code paths and "running on
actual hardware" code paths, which is to let virtual machines with a
viewer connected to KMS act as a testing environment, rather than a
production environment. Running a production environment in a virtual
machine doesn't really need to use KMS at all.

When using virtual machines for testing, I want to minimize the amount
of differentation between running on hardware and running in the VM
because otherwise the parts that are tested are not the same.

I realize that hotpspots and the cursor moving viewer side contradicts
that to some degree, but still, from a graphical testing witha VM point
of view, one has to compromise, as testing isn't just for the KMS layer,
but for the DE and distribution as a whole.


Jonas

> 
> 
> Thanks,
> pq


