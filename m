Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3987BC670
	for <lists+stable@lfdr.de>; Sat,  7 Oct 2023 11:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbjJGJap (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 7 Oct 2023 05:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjJGJap (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 7 Oct 2023 05:30:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C12ABC
        for <stable@vger.kernel.org>; Sat,  7 Oct 2023 02:30:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C54C433C8;
        Sat,  7 Oct 2023 09:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696671043;
        bh=ug/Mw6Bc8tfzlo5aAMWSf42Ev5bzB4yq0/3y7s3HQBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LxXRlgykqOIcp+qIEG0Y/N0bq6Ixw4cm8VmpVkZN43ZfF/4quHwEo+Juq4RpObGEm
         Fm1Pheo5/Q1hmbEARgj4RkePWu/f1J6SLT4EFScoeHmQbQP/x0NFxphS1BMCEv47Ov
         VE9hYNGuqY1U6/tL6UuWPf8Jrm+66bWr54AClx2k=
Date:   Sat, 7 Oct 2023 11:30:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Cc:     Sasha Levin <sashal@kernel.org>, Patrick Rohr <prohr@google.com>,
        stable@vger.kernel.org, Lorenzo Colitti <lorenzo@google.com>
Subject: Re: [PATCH 6.1 0/3] net: add sysctl accept_ra_min_lft
Message-ID: <2023100703-configure-smudge-8204@gregkh>
References: <20230925211034.905320-1-prohr@google.com>
 <CANLD9C1gOnYNPtSn=dMv9YjBz3H0qW6xRZdM-PYkG+Gnz7q-bg@mail.gmail.com>
 <2023100653-diffusion-brownnose-4671@gregkh>
 <2023100618-abdominal-unscathed-8d62@gregkh>
 <CANP3RGdnYyEY8mYjcxcj2L-tWrVyN3TS1bb6u41QCR5WKQDf2A@mail.gmail.com>
 <ZR_69QZ6H4Tr_nUY@sashalap>
 <CANP3RGevdZXoWS2UNfZpQJc34D2fA=ydAJuOSG3JCVgsTe=pJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANP3RGevdZXoWS2UNfZpQJc34D2fA=ydAJuOSG3JCVgsTe=pJA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 06, 2023 at 12:40:36PM -0700, Maciej Żenczykowski wrote:
> > >> > > Was this rejected?
> > >> > > Any resolution on this (ACK or NAK) would be useful. Thanks!
> > >> >
> > >> > They are in our "to get to" queue, which is very long still due to
> > >> > multiple conferences and travel.
> > >> >
> > >> > But I will note, you didn't put the git id of the patches in the patches
> > >> > themselves, so it will take me extra work to add them there when
> > >> > applying.
> > >> >
> > >> > Also, why just 6.1?  What about newer stable kernels?  You can't update
> > >> > and have a regression, right?
> > >>
> > >> Note, because of this, we can not take these patches now at all anyway :(
> > >
> > >Because without any knowledge of whether these patches would even be
> > >accepted into stable, or whether they would need to go in via ACK,
> > >preparing them for more trees seemed like pointless busywork...
> >
> > FWIW, the above just means that we get to do the busywork rather than
> > the submitter...
> 
> We're certainly willing to do the work, but we're not entirely sure
> what you want,
> and whether you will indeed even accept these patches...
> We're just trying to be mindful of everyone's time...
> 
> For example as a reviewer myself I know that in many cases it is
> simply easier to do the
> clean (!) cherrypick yourself (you presumably have scripts that
> automate the entire thing),
> rather than try to verify that someone else's cherrypick is actually
> indeed clean.
> 
> These patches cleanly cherry pick, build, and pass our tests on
> current 6.5 and 6.1 LTS.
> 
> git checkout remotes/linux-stable/v6.5.6 && git cherry-pick
> 1671bcfd76fdc0b9e65153cf759153083755fe4c && git cherry-pick
> 5027d54a9c30bc7ec808360378e2b4753f053f25 && git cherry-pick
> 5cb249686e67dbef3ffe53887fa725eefc5a7144  && run_uml_ack_net_test
> 
> (and same thing with 6.1.56)
> 
> Do you simply want the upstream sha1s?

For things that cherry-pick cleanly, yes, that's easiest.

> Or do you want us to follow up with patches?

For kernels that cherry-picking does not apply cleanly, yes.

thanks,

greg k-h
