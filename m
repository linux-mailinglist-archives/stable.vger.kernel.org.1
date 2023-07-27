Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4776A7651BA
	for <lists+stable@lfdr.de>; Thu, 27 Jul 2023 12:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjG0K5H (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Jul 2023 06:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjG0K5G (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Jul 2023 06:57:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7922125
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 03:57:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8441761E0C
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 10:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A855C433C8;
        Thu, 27 Jul 2023 10:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690455425;
        bh=HEIL8p98XVLM5cNcWdT7tOqyCSt79F8+VBka/BCAelQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fC8shhl2uGc6dcSsX2UvCYuPSSA5PHZmAwMjsc7T4yn6AyDCoaXRACe8T9WjFU8Ye
         YregIsIxuzYcDwHywX6C0UYiw+7FKo2i8kQ+faVIfOwIEWXg+vBvxfjBQaWg9ydhkd
         1KkoiEvaFe305ZGb7hpPEXIn8iw78cWF6EwH8r0Q=
Date:   Thu, 27 Jul 2023 12:57:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     August Wikerfors <git@augustwikerfors.se>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        evilsnoo@proton.me, ruinairas1992@gmail.com, nmschulte@gmail.com,
        Mario Limonciello <mario.limonciello@amd.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.4 102/227] ACPI: resource: Remove "Zen" specific match
 and quirks
Message-ID: <2023072744-mulch-repugnant-8d60@gregkh>
References: <20230725104514.821564989@linuxfoundation.org>
 <20230725104518.968673115@linuxfoundation.org>
 <5fbe6ee8-f907-ffec-7c6d-400aa74eaf20@augustwikerfors.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fbe6ee8-f907-ffec-7c6d-400aa74eaf20@augustwikerfors.se>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jul 27, 2023 at 01:06:25AM +0200, August Wikerfors wrote:
> Hi,
> 
> On 2023-07-25 12:44, Greg Kroah-Hartman wrote:
> > From: Mario Limonciello <mario.limonciello@amd.com>
> > 
> > [ Upstream commit a9c4a912b7dc7ff922d4b9261160c001558f9755 ]
> > 
> > commit 9946e39fe8d0 ("ACPI: resource: skip IRQ override on
> > AMD Zen platforms") attempted to overhaul the override logic so it
> > didn't apply on X86 AMD Zen systems.  This was intentional so that
> > systems would prefer DSDT values instead of default MADT value for
> > IRQ 1 on Ryzen 6000 systems which typically uses ActiveLow for IRQ1.
> > 
> > This turned out to be a bad assumption because several vendors
> > add Interrupt Source Override but don't fix the DSDT. A pile of
> > quirks was collecting that proved this wasn't sustaintable.
> > 
> > Furthermore some vendors have used ActiveHigh for IRQ1.
> > To solve this problem revert the following commits:
> > * commit 17bb7046e7ce ("ACPI: resource: Do IRQ override on all TongFang
> > GMxRGxx")
> > * commit f3cb9b740869 ("ACPI: resource: do IRQ override on Lenovo 14ALC7")
> > * commit bfcdf58380b1 ("ACPI: resource: do IRQ override on LENOVO IdeaPad")
> > * commit 7592b79ba4a9 ("ACPI: resource: do IRQ override on XMG Core 15")
> > * commit 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen
> > platforms")
> 
> Unfortunately this breaks the keyboard on Lenovo Yoga 7 14ARB7:
> https://lore.kernel.org/all/596b9c4a-fb83-a8ab-3a44-6052d83fa546@augustwikerfors.se/
> https://github.com/tomsom/yoga-linux/issues/47

Help to fix it in Linus's tree and then we will be glad to take the fix
into the stable trees as well.

thanks,

greg k-h
