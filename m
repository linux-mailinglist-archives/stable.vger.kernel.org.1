Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C457BB772
	for <lists+stable@lfdr.de>; Fri,  6 Oct 2023 14:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjJFMSB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 6 Oct 2023 08:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjJFMSB (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Oct 2023 08:18:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48A0CE
        for <stable@vger.kernel.org>; Fri,  6 Oct 2023 05:17:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C4EC433C8;
        Fri,  6 Oct 2023 12:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696594679;
        bh=WPh1cGZiz7RHnlhY89ZPP9kD7S3K5uVi1CWhfnihhYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aWLGCGeari9cOtTDmq5uOX72H72Rdz1cSwV/E0JX7I1XWDNBcmeqlLWI92Ul3QCJD
         Gxr/8ASdQEkX1JaZ9CM+B+pLg5jCdoBT/D6PnSQo+HXJMXlV5Frx2cGTvDrO1CsUEr
         T7rRqeBGSfQpc/f4wFyswdFbwqun5++/JkAKSOjBZ/kHP40OsoQpDlRcdZDkKXfkIx
         xsSsOQlN9wzn8wEP7WlKBQmZhLlylofK1XIr4HsYEs2QA2P2qzX9kcTXh3sSx9FuZu
         ZprJV6woXS9MmLAzv4fDMXQeJ6Aykd9MKMs/qO00MMWogxCwgApDPtYbcVRiOp4H0B
         YR0wUkqzp4R7Q==
Date:   Fri, 6 Oct 2023 08:17:57 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Patrick Rohr <prohr@google.com>, stable@vger.kernel.org,
        Lorenzo Colitti <lorenzo@google.com>
Subject: Re: [PATCH 6.1 0/3] net: add sysctl accept_ra_min_lft
Message-ID: <ZR_69QZ6H4Tr_nUY@sashalap>
References: <20230925211034.905320-1-prohr@google.com>
 <CANLD9C1gOnYNPtSn=dMv9YjBz3H0qW6xRZdM-PYkG+Gnz7q-bg@mail.gmail.com>
 <2023100653-diffusion-brownnose-4671@gregkh>
 <2023100618-abdominal-unscathed-8d62@gregkh>
 <CANP3RGdnYyEY8mYjcxcj2L-tWrVyN3TS1bb6u41QCR5WKQDf2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANP3RGdnYyEY8mYjcxcj2L-tWrVyN3TS1bb6u41QCR5WKQDf2A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 06, 2023 at 12:06:13AM -0700, Maciej Żenczykowski wrote:
>On Thu, Oct 5, 2023 at 11:21 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Fri, Oct 06, 2023 at 07:52:19AM +0200, Greg KH wrote:
>> > On Thu, Oct 05, 2023 at 02:37:59PM -0700, Patrick Rohr wrote:
>> > > On Mon, Sep 25, 2023 at 2:10 PM Patrick Rohr <prohr@google.com> wrote:
>> > > >
>> > > > This series adds a new sysctl accept_ra_min_lft which enforces a minimum
>> > > > lifetime value for individual RA sections; in particular, router
>> > > > lifetime, PIO preferred lifetime, and RIO lifetime. If any of those
>> > > > lifetimes are lower than the configured value, the specific RA section
>> > > > is ignored.
>> > > >
>> > > > This fixes a potential denial of service attack vector where rogue WiFi
>> > > > routers (or devices) can send RAs with low lifetimes to actively drain a
>> > > > mobile device's battery (by preventing sleep).
>> > > >
>> > > > In addition to this change, Android uses hardware offloads to drop RAs
>> > > > for a fraction of the minimum of all lifetimes present in the RA (some
>> > > > networks have very frequent RAs (5s) with high lifetimes (2h)). Despite
>> > > > this, we have encountered networks that set the router lifetime to 30s
>> > > > which results in very frequent CPU wakeups. Instead of disabling IPv6
>> > > > (and dropping IPv6 ethertype in the WiFi firmware) entirely on such
>> > > > networks, misconfigured routers must be ignored while still processing
>> > > > RAs from other IPv6 routers on the same network (i.e. to support IoT
>> > > > applications).
>> > > >
>> > > > Patches:
>> > > > - 1671bcfd76fd ("net: add sysctl accept_ra_min_rtr_lft")
>> > > > - 5027d54a9c30 ("net: change accept_ra_min_rtr_lft to affect all RA lifetimes")
>> > > > - 5cb249686e67 ("net: release reference to inet6_dev pointer")
>> > > >
>> > > > Patrick Rohr (3):
>> > > >   net: add sysctl accept_ra_min_rtr_lft
>> > > >   net: change accept_ra_min_rtr_lft to affect all RA lifetimes
>> > > >   net: release reference to inet6_dev pointer
>> > > >
>> > > >  Documentation/networking/ip-sysctl.rst |  8 ++++++++
>> > > >  include/linux/ipv6.h                   |  1 +
>> > > >  include/uapi/linux/ipv6.h              |  1 +
>> > > >  net/ipv6/addrconf.c                    | 13 +++++++++++++
>> > > >  net/ipv6/ndisc.c                       | 13 +++++++++++--
>> > > >  5 files changed, 34 insertions(+), 2 deletions(-)
>> > > >
>> > > > --
>> > > > 2.42.0.515.g380fc7ccd1-goog
>> > > >
>> > >
>> > > Was this rejected?
>> > > Any resolution on this (ACK or NAK) would be useful. Thanks!
>> >
>> > They are in our "to get to" queue, which is very long still due to
>> > multiple conferences and travel.
>> >
>> > But I will note, you didn't put the git id of the patches in the patches
>> > themselves, so it will take me extra work to add them there when
>> > applying.
>> >
>> > Also, why just 6.1?  What about newer stable kernels?  You can't update
>> > and have a regression, right?
>>
>> Note, because of this, we can not take these patches now at all anyway :(
>>
>> thanks,
>>
>> greg k-h
>
>Because without any knowledge of whether these patches would even be
>accepted into stable, or whether they would need to go in via ACK,
>preparing them for more trees seemed like pointless busywork...

FWIW, the above just means that we get to do the busywork rather than
the submitter...

-- 
Thanks,
Sasha
