Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A4E7BB174
	for <lists+stable@lfdr.de>; Fri,  6 Oct 2023 08:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjJFGVr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 6 Oct 2023 02:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJFGVq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Oct 2023 02:21:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8675290
        for <stable@vger.kernel.org>; Thu,  5 Oct 2023 23:21:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69880C433C7;
        Fri,  6 Oct 2023 06:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696573305;
        bh=pWydn80YDBT4fHDUGh7UY1DMRYNorKp6jfzCwdHy/BQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MBcqWJof+KFCevUMBdWDAMhskY7lR+WjsyCDTqg9nI+ao7HYzwwiVpgML73NMfk+H
         0Vb2MpCy8+iaPygTuEczrq7R0MDGy7xOjLT0I18da5YzlPCvmfUfS5c9BQU3LnINHh
         6/Bnlwez4d8cYksRibB+v8QD6l8yz9o6kMoQAYuk=
Date:   Fri, 6 Oct 2023 08:21:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Patrick Rohr <prohr@google.com>
Cc:     stable@vger.kernel.org,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 0/3] net: add sysctl accept_ra_min_lft
Message-ID: <2023100618-abdominal-unscathed-8d62@gregkh>
References: <20230925211034.905320-1-prohr@google.com>
 <CANLD9C1gOnYNPtSn=dMv9YjBz3H0qW6xRZdM-PYkG+Gnz7q-bg@mail.gmail.com>
 <2023100653-diffusion-brownnose-4671@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023100653-diffusion-brownnose-4671@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 06, 2023 at 07:52:19AM +0200, Greg KH wrote:
> On Thu, Oct 05, 2023 at 02:37:59PM -0700, Patrick Rohr wrote:
> > On Mon, Sep 25, 2023 at 2:10 PM Patrick Rohr <prohr@google.com> wrote:
> > >
> > > This series adds a new sysctl accept_ra_min_lft which enforces a minimum
> > > lifetime value for individual RA sections; in particular, router
> > > lifetime, PIO preferred lifetime, and RIO lifetime. If any of those
> > > lifetimes are lower than the configured value, the specific RA section
> > > is ignored.
> > >
> > > This fixes a potential denial of service attack vector where rogue WiFi
> > > routers (or devices) can send RAs with low lifetimes to actively drain a
> > > mobile device's battery (by preventing sleep).
> > >
> > > In addition to this change, Android uses hardware offloads to drop RAs
> > > for a fraction of the minimum of all lifetimes present in the RA (some
> > > networks have very frequent RAs (5s) with high lifetimes (2h)). Despite
> > > this, we have encountered networks that set the router lifetime to 30s
> > > which results in very frequent CPU wakeups. Instead of disabling IPv6
> > > (and dropping IPv6 ethertype in the WiFi firmware) entirely on such
> > > networks, misconfigured routers must be ignored while still processing
> > > RAs from other IPv6 routers on the same network (i.e. to support IoT
> > > applications).
> > >
> > > Patches:
> > > - 1671bcfd76fd ("net: add sysctl accept_ra_min_rtr_lft")
> > > - 5027d54a9c30 ("net: change accept_ra_min_rtr_lft to affect all RA lifetimes")
> > > - 5cb249686e67 ("net: release reference to inet6_dev pointer")
> > >
> > > Patrick Rohr (3):
> > >   net: add sysctl accept_ra_min_rtr_lft
> > >   net: change accept_ra_min_rtr_lft to affect all RA lifetimes
> > >   net: release reference to inet6_dev pointer
> > >
> > >  Documentation/networking/ip-sysctl.rst |  8 ++++++++
> > >  include/linux/ipv6.h                   |  1 +
> > >  include/uapi/linux/ipv6.h              |  1 +
> > >  net/ipv6/addrconf.c                    | 13 +++++++++++++
> > >  net/ipv6/ndisc.c                       | 13 +++++++++++--
> > >  5 files changed, 34 insertions(+), 2 deletions(-)
> > >
> > > --
> > > 2.42.0.515.g380fc7ccd1-goog
> > >
> > 
> > Was this rejected?
> > Any resolution on this (ACK or NAK) would be useful. Thanks!
> 
> They are in our "to get to" queue, which is very long still due to
> multiple conferences and travel.
> 
> But I will note, you didn't put the git id of the patches in the patches
> themselves, so it will take me extra work to add them there when
> applying.
> 
> Also, why just 6.1?  What about newer stable kernels?  You can't update
> and have a regression, right?

Note, because of this, we can not take these patches now at all anyway :(

thanks,

greg k-h
