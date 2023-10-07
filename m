Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13D97BC684
	for <lists+stable@lfdr.de>; Sat,  7 Oct 2023 11:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbjJGJsw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 7 Oct 2023 05:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbjJGJsv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 7 Oct 2023 05:48:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7148AB9
        for <stable@vger.kernel.org>; Sat,  7 Oct 2023 02:48:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC05C433C8;
        Sat,  7 Oct 2023 09:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696672129;
        bh=qJBVs27u3oLGreQgkJS+VW/7XPVBlg+Eg71v4R7CZq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yqvIhI5pydwfP2jj59jC1DLnZk8r/0Jv9JUOiwMUmNEPZnJuMFVHlKHW2KkA3k3Sg
         0Va9nM1RManxEYC4e/F5nMsgpaPuBVRPf1NNSeU9aLSaOCLsdwuv03H6Jc+M0bbKFD
         tG4Uast3m/vAEry3Tp62NBFoqjiTzgLKP+rV4wK4=
Date:   Sat, 7 Oct 2023 11:48:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Cc:     Sasha Levin <sashal@kernel.org>, Patrick Rohr <prohr@google.com>,
        stable@vger.kernel.org, Lorenzo Colitti <lorenzo@google.com>
Subject: Re: [PATCH 6.1 0/3] net: add sysctl accept_ra_min_lft
Message-ID: <2023100719-scouts-diabetic-37e2@gregkh>
References: <20230925211034.905320-1-prohr@google.com>
 <CANLD9C1gOnYNPtSn=dMv9YjBz3H0qW6xRZdM-PYkG+Gnz7q-bg@mail.gmail.com>
 <2023100653-diffusion-brownnose-4671@gregkh>
 <2023100618-abdominal-unscathed-8d62@gregkh>
 <CANP3RGdnYyEY8mYjcxcj2L-tWrVyN3TS1bb6u41QCR5WKQDf2A@mail.gmail.com>
 <ZR_69QZ6H4Tr_nUY@sashalap>
 <CANP3RGevdZXoWS2UNfZpQJc34D2fA=ydAJuOSG3JCVgsTe=pJA@mail.gmail.com>
 <2023100703-configure-smudge-8204@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023100703-configure-smudge-8204@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Oct 07, 2023 at 11:30:41AM +0200, Greg KH wrote:
> On Fri, Oct 06, 2023 at 12:40:36PM -0700, Maciej Żenczykowski wrote:
> > > >> > > Was this rejected?
> > > >> > > Any resolution on this (ACK or NAK) would be useful. Thanks!
> > > >> >
> > > >> > They are in our "to get to" queue, which is very long still due to
> > > >> > multiple conferences and travel.
> > > >> >
> > > >> > But I will note, you didn't put the git id of the patches in the patches
> > > >> > themselves, so it will take me extra work to add them there when
> > > >> > applying.
> > > >> >
> > > >> > Also, why just 6.1?  What about newer stable kernels?  You can't update
> > > >> > and have a regression, right?
> > > >>
> > > >> Note, because of this, we can not take these patches now at all anyway :(
> > > >
> > > >Because without any knowledge of whether these patches would even be
> > > >accepted into stable, or whether they would need to go in via ACK,
> > > >preparing them for more trees seemed like pointless busywork...
> > >
> > > FWIW, the above just means that we get to do the busywork rather than
> > > the submitter...
> > 
> > We're certainly willing to do the work, but we're not entirely sure
> > what you want,
> > and whether you will indeed even accept these patches...
> > We're just trying to be mindful of everyone's time...
> > 
> > For example as a reviewer myself I know that in many cases it is
> > simply easier to do the
> > clean (!) cherrypick yourself (you presumably have scripts that
> > automate the entire thing),
> > rather than try to verify that someone else's cherrypick is actually
> > indeed clean.
> > 
> > These patches cleanly cherry pick, build, and pass our tests on
> > current 6.5 and 6.1 LTS.
> > 
> > git checkout remotes/linux-stable/v6.5.6 && git cherry-pick
> > 1671bcfd76fdc0b9e65153cf759153083755fe4c && git cherry-pick
> > 5027d54a9c30bc7ec808360378e2b4753f053f25 && git cherry-pick
> > 5cb249686e67dbef3ffe53887fa725eefc5a7144  && run_uml_ack_net_test
> > 
> > (and same thing with 6.1.56)
> > 
> > Do you simply want the upstream sha1s?
> 
> For things that cherry-pick cleanly, yes, that's easiest.

And I've cherry-picked these for 6.1.y and 6.5.y now.  If you all want
them in older kernels, please send working backports.

thanks,

greg k-h
