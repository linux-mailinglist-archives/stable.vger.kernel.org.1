Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA3A7345E0
	for <lists+stable@lfdr.de>; Sun, 18 Jun 2023 13:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjFRLEu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 18 Jun 2023 07:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjFRLEt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Jun 2023 07:04:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A4118B
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 04:04:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6B6060C5B
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 11:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE204C433C0;
        Sun, 18 Jun 2023 11:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687086285;
        bh=+BUa/KOOyk85JrnmLws6QcIKhV5MYI3YBxT/1KUvsDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PGyxi9JJxyqYdCT23wXkwJuYItNH9UTzWy4mLHiIXHTy4mxvXCMdvYck8RXyY52ur
         f3DNK6V5GF9Cw0W1EWjKmSWZvjhGXnl9tz+um59+zhSROsKJno2+TCDuIGRAizOYAX
         r5NEH0qKIA9YEJJrASk2sPPt9CiYQ9GKv+PTIf/k=
Date:   Sun, 18 Jun 2023 13:04:42 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc:     "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "romain.izard.pro@gmail.com" <romain.izard.pro@gmail.com>
Subject: Re: [PATCH 1/2] usb: gadget: f_ncm: Add OS descriptor support
Message-ID: <2023061834-relative-gem-0d53@gregkh>
References: <20230531173358.910767-1-joakim.tjernlund@infinera.com>
 <5533972aab4a15ab2177497edc9aa0ba1b97aaba.camel@infinera.com>
 <2023061854-daydream-outage-de91@gregkh>
 <afbf34e128a744bb37f8e533248b69c2b0fdff9e.camel@infinera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afbf34e128a744bb37f8e533248b69c2b0fdff9e.camel@infinera.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Jun 18, 2023 at 09:58:14AM +0000, Joakim Tjernlund wrote:
> On Sun, 2023-06-18 at 09:36 +0200, Greg KH wrote:
> > On Sat, Jun 17, 2023 at 04:03:06PM +0000, Joakim Tjernlund wrote:
> > > Ping ?
> > > 
> > > Did I do something wrong with submission or is it queued for later ?
> > > 4.19 is missing these which make USB NCM unusable with Win >= 10. 
> > > 
> > >  Jocke
> > > 
> > > On Wed, 2023-05-31 at 19:33 +0200, Joakim Tjernlund wrote:
> > > > From: Romain Izard <romain.izard.pro@gmail.com>
> > > > 
> > > > To be able to use the default USB class drivers available in Microsoft
> > > > Windows, we need to add OS descriptors to the exported USB gadget to
> > > > tell the OS that we are compatible with the built-in drivers.
> > > > 
> > > > Copy the OS descriptor support from f_rndis into f_ncm. As a result,
> > > > using the WINNCM compatible ID, the UsbNcm driver is loaded on
> > > > enumeration without the need for a custom driver or inf file.
> > > > 
> > > > Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> > > > Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> > > > Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
> > > > Cc: stable@vger.kernel.org # v4.19
> > > > ---
> > > > 
> > > >  Seems to have been forgotten when backporting NCM fixes.
> > > >  Needed to make Win10 accept Linux NCM gadget ethernet
> > > > 
> > > >  drivers/usb/gadget/function/f_ncm.c | 47 +++++++++++++++++++++++++++--
> > > >  drivers/usb/gadget/function/u_ncm.h |  3 ++
> > > >  2 files changed, 47 insertions(+), 3 deletions(-)
> > 
> > What is the git commit id of this change in Linus's tree?
> > 
> > thanks,
> > 
> > greg k-h
> For this patch:
> 	793409292382027226769d0299987f06cbd97a6e
> 
> and for "usb: gadget: f_ncm: Fix NTP-32 support"
> 	550eef0c353030ac4223b9c9479bdf77a05445d6

Ah, yeah, they did get lost in the deluge, sorry.

Can you please resend these _with_ the git commit id in the message so
that we know what is going on?

thanks,

greg k-h
