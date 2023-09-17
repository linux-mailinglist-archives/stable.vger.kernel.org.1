Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B139B7A3409
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 09:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjIQHDU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 03:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjIQHDH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 03:03:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF23812D
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 00:03:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE73C433C8;
        Sun, 17 Sep 2023 07:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694934181;
        bh=XC5kDn60rdnYqHcXP7EfSPU4C50VEBOZPkA+i+KQGgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mk7RFSX3xg9D6HSc1CGwjueCUZWKf+aNyJnjbQlCBHd6JaHV4V3eTHNFgE5oS8WYc
         95e2CuxCkUs0xIKUcY9TG7C/wicSuT90v/UqepphM6oSCfRAsWaCsI6CdNDbMUrylG
         J+LMAaU9CpoxOznCnfi7KObDwaoI4wVBrmIAp8FM=
Date:   Sun, 17 Sep 2023 09:02:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: Only fiddle with CHECKFLAGS if `need-compiler'
Message-ID: <2023091744-blank-bulge-01bf@gregkh>
References: <alpine.DEB.2.21.2309161613540.57368@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2309161613540.57368@angie.orcam.me.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Sep 16, 2023 at 04:19:40PM +0100, Maciej W. Rozycki wrote:
> commit 4fe4a6374c4db9ae2b849b61e84b58685dca565a upstream.
> 
> We have originally guarded fiddling with CHECKFLAGS in our arch Makefile
> by checking for the CONFIG_MIPS variable, not set for targets such as
> `distclean', etc. that neither include `.config' nor use the compiler.
> 
> Starting from commit 805b2e1d427a ("kbuild: include Makefile.compiler
> only when compiler is needed") we have had a generic `need-compiler'
> variable explicitly telling us if the compiler will be used and thus its
> capabilities need to be checked and expressed in the form of compilation
> flags.  If this variable is not set, then `make' functions such as
> `cc-option' are undefined, causing all kinds of weirdness to happen if
> we expect specific results to be returned, most recently:
> 
> cc1: error: '-mloongson-mmi' must be used with '-mhard-float'
> 
> messages with configurations such as `fuloong2e_defconfig' and the
> `modules_install' target, which does include `.config' and yet does not
> use the compiler.
> 
> Replace the check for CONFIG_MIPS with one for `need-compiler' instead,
> so as to prevent the compiler from being ever called for CHECKFLAGS when
> not needed.
> 
> Reported-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> Closes: https://lore.kernel.org/r/85031c0c-d981-031e-8a50-bc4fad2ddcd8@collabora.com/
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Fixes: 805b2e1d427a ("kbuild: include Makefile.compiler only when compiler is needed")
> Cc: stable@vger.kernel.org # v5.13+
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
> Hi,
> 
>  This is a version of commit 4fe4a6374c4d for 6.1-stable and before, 
> resolving a conflict due to a change in how $(CHECKFLAGS) is set.
> 
>  No functional change, just a mechanical update.  Please apply.

Now queued up, thanks.

greg k-h
