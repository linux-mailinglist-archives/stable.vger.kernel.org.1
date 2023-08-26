Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3840789459
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 09:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjHZHfd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 03:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjHZHfE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 03:35:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2212137;
        Sat, 26 Aug 2023 00:35:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7188B61115;
        Sat, 26 Aug 2023 07:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7A1C433C8;
        Sat, 26 Aug 2023 07:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693035301;
        bh=Ire7ypYxtufnlRxtBcnyW07jEaxvrn0kOHcZFJ1ADw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IQeJrNGeNdNXuaE1IkUKvft0JchpXnlcAKrUFoeUKxYGjIwqYlL9HuLkK5cdb1K1k
         VqtrQg2VjqFbrobseVVTSa2EnVL9FoFMZKJJ3nkbhMN5GC2EraSPpkEkKvbftqMtp6
         Ju6c0c9gkpOQgf0UVToPbvbbt52SQoLsc2TgQh+M=
Date:   Sat, 26 Aug 2023 09:34:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     deller@kernel.org
Cc:     linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/3] parisc: led: Reduce CPU overhead for disk & lan LED
 computation
Message-ID: <2023082636-refreeze-plot-9f6e@gregkh>
References: <20230825180928.205499-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825180928.205499-1-deller@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Aug 25, 2023 at 08:09:26PM +0200, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Older PA-RISC machines have LEDs which show the disk- and LAN-activity.
> The computation is done in software and takes quite some time, e.g. on a
> J6500 this may take up to 60% time of one CPU if the machine is loaded
> via network traffic.
> 
> Since most people don't care about the LEDs, start with LEDs disabled and
> just show a CPU heartbeat LED. The disk and LAN LEDs can be turned on
> manually via /proc/pdc/led.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: <stable@vger.kernel.org>
> ---
>  drivers/parisc/led.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/parisc/led.c b/drivers/parisc/led.c
> index 8bdc5e043831..765f19608f60 100644
> --- a/drivers/parisc/led.c
> +++ b/drivers/parisc/led.c
> @@ -56,8 +56,8 @@
>  static int led_type __read_mostly = -1;
>  static unsigned char lastleds;	/* LED state from most recent update */
>  static unsigned int led_heartbeat __read_mostly = 1;
> -static unsigned int led_diskio    __read_mostly = 1;
> -static unsigned int led_lanrxtx   __read_mostly = 1;
> +static unsigned int led_diskio    __read_mostly;
> +static unsigned int led_lanrxtx   __read_mostly;
>  static char lcd_text[32]          __read_mostly;
>  static char lcd_text_default[32]  __read_mostly;
>  static int  lcd_no_led_support    __read_mostly = 0; /* KittyHawk doesn't support LED on its LCD */
> @@ -589,6 +589,9 @@ int __init register_led_driver(int model, unsigned long cmd_reg, unsigned long d
>  		return 1;
>  	}
>  	
> +	pr_info("LED: Enable disk and LAN activity LEDs "
> +		"via /proc/pdc/led\n");

When drivers are working properly, they should be quiet.  Who is going
to see this message?

I don't even understand it, are you saying that you now need to go
enable the led through proc?  And why are leds in proc, I thought they
had a real class for them?  Why not use that instead?

And finally, you shouldn't split strings across lines :)

thanks,

greg k-h
