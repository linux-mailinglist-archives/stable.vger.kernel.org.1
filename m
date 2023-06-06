Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AF47249DB
	for <lists+stable@lfdr.de>; Tue,  6 Jun 2023 19:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238412AbjFFRI6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 6 Jun 2023 13:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238491AbjFFRIp (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Jun 2023 13:08:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348C21982
        for <stable@vger.kernel.org>; Tue,  6 Jun 2023 10:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686071262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hWZqH/DfxUDS3EmO66peoQfkbOHLBsPYPaBvXKUz69g=;
        b=MN1iWLw7efAPaSjfwPBeorkrA4VAq0PQGnP2biTUSygrLmjDRYkB0kvM4+nvZMKm2pzGan
        uPj4lmrRoaAT5qh2aOcVkdE/8ciOmSyA14C1yw5Lpu1GVCJSXqU5TfonlVpNba1b+U78/R
        l5/uOAJDdoZC531rxZth9kqT4yhTLLs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-WFGx96moNSWJZkWzg-tu-Q-1; Tue, 06 Jun 2023 13:07:41 -0400
X-MC-Unique: WFGx96moNSWJZkWzg-tu-Q-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-75ebcb68276so241095185a.1
        for <Stable@vger.kernel.org>; Tue, 06 Jun 2023 10:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686071259; x=1688663259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWZqH/DfxUDS3EmO66peoQfkbOHLBsPYPaBvXKUz69g=;
        b=LsH4q+Bq2iVIINmpA910H5LjQiBikWfNPyAldBZsWEd2VP1UpAzwsfUz7UkjP0NClZ
         3NkOfCDAuc/emh6iU9Ci/Ioq3gYLrrDjZyDkFaDOUYEVA70L75YDMaFmpp1CZPmZWO6f
         hbmfX69aVTuJfufTRfcWWGP0Gq9rNRaiVcCdm4xr9ExkauwxLuh+/2Ov7b8lepB6LEEz
         5TBQHnrWlKs6qT3KdFykosy7hw2D53jw5D/VvW6A8ZmieT1cc46iMhtAlTQJyLEltAFc
         juZGfp2ffHssyB2cka6r00A0Dq90aa6Gkwm8fTgvo9sDb7BNe3+WxOFA3KJuGjI4U1hj
         saUA==
X-Gm-Message-State: AC+VfDy9IppsUoBJpuPGuqzxn4UrBcx5cK/nPyQa/V1jXpEGKonexJZA
        kapfbsPmvJAeBekHqmIpsbmoyIFNoSOZRrXEy36mKChAwnc1SAABKbV2KbTdAVAY6dsEdGv9aI6
        YdD2YYuzIaJkeTgK61AndOsC7
X-Received: by 2002:a05:6214:2a84:b0:623:66ee:79b2 with SMTP id jr4-20020a0562142a8400b0062366ee79b2mr99844qvb.36.1686071259549;
        Tue, 06 Jun 2023 10:07:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ70J7muTAtRF8iWj3uSA40DRLOYan2beXWU5SWfIJzakVL2jgDbSZm98AaIU6LpwLgbLB3EWA==
X-Received: by 2002:a05:6214:2a84:b0:623:66ee:79b2 with SMTP id jr4-20020a0562142a8400b0062366ee79b2mr99768qvb.36.1686071258425;
        Tue, 06 Jun 2023 10:07:38 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id z4-20020ad44144000000b0062629cbff11sm5500143qvp.11.2023.06.06.10.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 10:07:37 -0700 (PDT)
Date:   Tue, 6 Jun 2023 10:07:36 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     vasant.hegde@amd.com, Stable@vger.kernel.org, jroedel@suse.de,
        suravee.suthikulpanit@amd.com
Subject: Re: FAILED: patch "[PATCH] iommu/amd/pgtbl_v2: Fix domain max
 address" failed to apply to 6.3-stable tree
Message-ID: <q4kcej2yljr3quyr23t6tktvjmga2ftsafy4onj3473suzc2vx@ayrdsar332wq>
References: <2023060548-rake-strongman-fdbe@gregkh>
 <qlookcllwfzobdymwx3vsx4r3nn6sk5y4glqkxiyczxrjtkn7t@owslivpdbc6t>
 <2023060606-stalemate-stoneware-292c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023060606-stalemate-stoneware-292c@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jun 06, 2023 at 11:56:41AM +0200, Greg KH wrote:
> On Mon, Jun 05, 2023 at 03:43:19PM -0700, Jerry Snitselaar wrote:
> > On Mon, Jun 05, 2023 at 10:38:48PM +0200, gregkh@linuxfoundation.org wrote:
> > > 
> > > The patch below does not apply to the 6.3-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git commit
> > > id to <stable@vger.kernel.org>.
> > > 
> > > To reproduce the conflict and resubmit, you may use the following commands:
> > > 
> > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
> > > git checkout FETCH_HEAD
> > > git cherry-pick -x 11c439a19466e7feaccdbce148a75372fddaf4e9
> > > # <resolve conflicts, build, test, etc.>
> > > git commit -s
> > > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023060548-rake-strongman-fdbe@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..
> > > 
> > > Possible dependencies:
> > > 
> > > 
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > > 
> > 
> > I'm not sure what happened, but it works for me:
> 
> I think you skipped the line above that said:
> 
> > > # <resolve conflicts, build, test, etc.>
> 
> Did you test-build this?
> 
> thanks,
> 
> greg k-h

Sigh, nope skipped right over that. I even sent a reply when the original patch was sent saying it would need
to be changed for stable:

    For the stable releases, this will need to be PAGE_MODE_4_LEVEL
    instead of amd_iommu_gpt_level? The 6.4 merge window is when
    amd_iommu_gpt_level arrived with the 5 level page table changes.

Sorry for the noise.

