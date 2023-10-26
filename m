Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E417D88D1
	for <lists+stable@lfdr.de>; Thu, 26 Oct 2023 21:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjJZTPH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 26 Oct 2023 15:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjJZTPE (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Oct 2023 15:15:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7B51BB
        for <stable@vger.kernel.org>; Thu, 26 Oct 2023 12:14:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B39C433C8;
        Thu, 26 Oct 2023 19:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698347695;
        bh=H+MsyQu8g5N65Gg9ktlkHBBwf6jTB93WldhBOhGiFMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NlCl4aEIUHF/LO1aEO5gRKQNSLdudW8Trwwhz0VuXh+cEW5OidNzlhWM6cqqHafWB
         iU3/Zk+43lu1lCjRfngMpumTmDfDtyqkT5FQklsrK3zMsTk8ApAeRjskocd/zW/e/s
         bA64d6nNVIVbYaD1r2DhCx7H71ADARShEFklvlX4=
Date:   Thu, 26 Oct 2023 21:14:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     LihaSika <lihasika@gmail.com>
Cc:     stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: Linux kernel 6.1 - drivers/usb/storage/unusual_cypress.h "Super
 Top" minimum bcdDevice too high
Message-ID: <2023102630-enviable-stood-9b2d@gregkh>
References: <7bfd4f9e-9f8d-4102-ab03-7d0401f00513@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7bfd4f9e-9f8d-4102-ab03-7d0401f00513@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Oct 26, 2023 at 06:32:02PM +0300, LihaSika wrote:
> Hi,	
> 
> in kernel 6.1 (maybe 5.x - 6.x) there's an ATACB setting for "Super Top USB
> 2.0 SATA Bridge" -devices, where the minimum bcdDevice version to match has
> been set to 1.60. It's in the file drivers/usb/storage/unusual_cypress.h:
> 
> """
> UNUSUAL_DEV( 0x14cd, 0x6116, 0x0160, 0x0160,
>  		"Super Top",
>  		"USB 2.0  SATA BRIDGE",
>  		USB_SC_CYP_ATACB, USB_PR_DEVICE, NULL, 0),
> """
> 
> My old USB HDD with a "Super Top" bridge has bcdDevice version 1.50, thus
> the setting won't match and it will not mount.
> 
> I'm not sure when this changed (after kernel 4.x?), but it used to work
> before. Reading some earlier bug reports, it seems that the max version used
> to be 0x9999, which then caused corruption in "Super Top" devices with
> version >=2.20. So that's a reason for lowering the maximum value, but I
> wonder why the minimum value has also been set to 0x0160.
> 
> 
> I created a patch, changing 0x0160 to 0x0150 (though I should've left the
> max version as it was...):
> 
> """
> UNUSUAL_DEV( 0x14cd, 0x6116, 0x0150, 0x0150,
> """
> 
> Built, installed and rebooted; now the USB HDD can be mounted and works
> perfectly again. I did some write & read tests, checked with diff, cmp and
> md5sum - no corruption, everything OK 👍

Please submit a proper patch to the linux-usb@vger.kernel.org mailing
list and we will be glad to take it from there.

thanks,

greg k-h
