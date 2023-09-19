Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3327B7A5BC4
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 09:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjISH5o (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 03:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjISH5n (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 03:57:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40D9115
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 00:57:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B0FC433C8;
        Tue, 19 Sep 2023 07:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695110256;
        bh=fLeSnVOwCSP/qTkJ10w9VhO6v1axFiLn6qQ2n1WA6z4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PZEuIVToE7yJGyBKwrS2QRed5jbLqeMRpY+H5udWwEbb2UAJZ96zMpn2Ayem5b6n0
         2XskIGygIR11xgP843UcpyHw0qNzIAjilbwjaOyHMZmaW6WDqSN1dauM9gPWj68D5c
         2jF6BOtjqlDNarJYV5JjgPdwKgunNmUryNJJHrgc=
Date:   Tue, 19 Sep 2023 09:57:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 261/406] leds: Fix BUG_ON check for
 LED_COLOR_ID_MULTI that is always false
Message-ID: <2023091901-vessel-giggling-55ee@gregkh>
References: <20230917191101.035638219@linuxfoundation.org>
 <20230917191108.094879104@linuxfoundation.org>
 <20230918160004.3511ae2e@dellmb>
 <2023091836-papaya-jackknife-2867@gregkh>
 <20230918181727.74a28f4a@dellmb>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230918181727.74a28f4a@dellmb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Sep 18, 2023 at 06:17:27PM +0200, Marek Behún wrote:
> On Mon, 18 Sep 2023 17:22:59 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Mon, Sep 18, 2023 at 04:00:04PM +0200, Marek Behún wrote:
> > > Greg, please drop this patch from both 5.10 and 5.15.
> > > 
> > > Reference: 
> > >   https://lore.kernel.org/linux-leds/ZQLelWcNjjp2xndY@duo.ucw.cz/T/  
> > 
> > But this is already in released kernels:
> > 	6.1.53 6.4.16 6.5.3 6.6-rc1
> > 
> > > I am going to send a fix to drop the check altogether.  
> > 
> > We will be glad to queue up the fix as well when it hits Linus's tree,
> > please be sure to tag it for stable backporting so we can get it in all
> > locations.
> > 
> > But for now, being bug-compatible makes more sense, right?  Or is this
> > really critical and should not be in these kernels now?
> 
> According to that e-mail, the patch breaks booting for some systems, so
> if it would be possible to avoid it...
> 
> I've sent a fixup patch which removes the BUG_ON altogether, and
> referenced the patch that broke booting in the Fixes tag. But I don't
> know how long it will take to hit Linus' tree, it may take several
> weeks.

Ok, thanks, now dropped from these trees.  Please pester the maintainers
to get this merged into Linus's tree soon so that the other stable trees
can be fixed up as well.

greg k-h
