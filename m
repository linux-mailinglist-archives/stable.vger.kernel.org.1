Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADEC789495
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 09:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjHZH63 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 03:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjHZH6G (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 03:58:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A37B3;
        Sat, 26 Aug 2023 00:58:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A8C461033;
        Sat, 26 Aug 2023 07:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56792C433C8;
        Sat, 26 Aug 2023 07:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693036683;
        bh=9CAqw9qqrwrFHVMfGoJeWY0huCNz56P8GDhfjSV1NRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ldCvLgug+XZGYVxo6ra9ADbpJ1SRvIDR0yNx4NHog8rfzYOm4oN08dIdC34RZ+CJN
         CIR67zyN01bVSf7hYE6J13qB8wGBp3hIKjO7D8w0yz8SHh8woyVHUXoTruf24AoYd2
         w6PXNowwFEVmEILFD08T43R4GOahJRIw+pEXC0dU=
Date:   Sat, 26 Aug 2023 09:58:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] parisc: led: Reduce CPU overhead for disk & lan LED
 computation
Message-ID: <2023082605-vista-probably-faac@gregkh>
References: <20230825180928.205499-1-deller@kernel.org>
 <2023082636-refreeze-plot-9f6e@gregkh>
 <15c20ace-62c9-a986-cb68-f74953bef624@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15c20ace-62c9-a986-cb68-f74953bef624@gmx.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Aug 26, 2023 at 09:54:55AM +0200, Helge Deller wrote:
> On 8/26/23 09:34, Greg KH wrote:
> > On Fri, Aug 25, 2023 at 08:09:26PM +0200, deller@kernel.org wrote:
> > > From: Helge Deller <deller@gmx.de>
> > > 
> > > Older PA-RISC machines have LEDs which show the disk- and LAN-activity.
> > > The computation is done in software and takes quite some time, e.g. on a
> > > J6500 this may take up to 60% time of one CPU if the machine is loaded
> > > via network traffic.
> > > 
> > > Since most people don't care about the LEDs, start with LEDs disabled and
> > > just show a CPU heartbeat LED. The disk and LAN LEDs can be turned on
> > > manually via /proc/pdc/led.
> > > 
> > > Signed-off-by: Helge Deller <deller@gmx.de>
> > > Cc: <stable@vger.kernel.org>
> > > ---
> > >   drivers/parisc/led.c | 7 +++++--
> > >   1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/parisc/led.c b/drivers/parisc/led.c
> > > index 8bdc5e043831..765f19608f60 100644
> > > --- a/drivers/parisc/led.c
> > > +++ b/drivers/parisc/led.c
> > > @@ -56,8 +56,8 @@
> > >   static int led_type __read_mostly = -1;
> > >   static unsigned char lastleds;	/* LED state from most recent update */
> > >   static unsigned int led_heartbeat __read_mostly = 1;
> > > -static unsigned int led_diskio    __read_mostly = 1;
> > > -static unsigned int led_lanrxtx   __read_mostly = 1;
> > > +static unsigned int led_diskio    __read_mostly;
> > > +static unsigned int led_lanrxtx   __read_mostly;
> > >   static char lcd_text[32]          __read_mostly;
> > >   static char lcd_text_default[32]  __read_mostly;
> > >   static int  lcd_no_led_support    __read_mostly = 0; /* KittyHawk doesn't support LED on its LCD */
> > > @@ -589,6 +589,9 @@ int __init register_led_driver(int model, unsigned long cmd_reg, unsigned long d
> > >   		return 1;
> > >   	}
> > > 
> > > +	pr_info("LED: Enable disk and LAN activity LEDs "
> > > +		"via /proc/pdc/led\n");
> > 
> > When drivers are working properly, they should be quiet.  Who is going
> > to see this message?
> 
> That patch shouldn't have gone to stable@ yet... git-send-patch just
> pulled the CC in and I didn't noticed.
> So, please don't apply it yet.

I will not, and it's fine to cc: stable@ on stuff that is still making
it's way into the kernel tree.  It gives us a heads-up on stuff, AND
sometimes it gives you an additional free review :)

> > I don't even understand it, are you saying that you now need to go
> > enable the led through proc?  And why are leds in proc, I thought they
> > had a real class for them?  Why not use that instead?
> 
> This is an old driver from the very beginning, and I don't want to change
> much in it for old kernels other than to reduce the CPU overhead it generates.

Ah, makes sense, that is a crazy amount of cpu time for a blinking led.

How about just default to it off (like the first chunk you have here),
which will go to stable trees, and then a rewrite to use the proper LED
api?  Or not, your call, I doubt many people actually have this hardware
to care about it...

thanks,

greg k-h
