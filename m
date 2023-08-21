Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E37A782A48
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 15:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjHUNRj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 09:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjHUNRi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 09:17:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFA8B1
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 06:17:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4AF0616C7
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FC9C433C8;
        Mon, 21 Aug 2023 13:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692623832;
        bh=QRbVYdkISTB1JEgThMzHttizW7x+znLDgouSfrg58bs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y9UpXin2FTm3GqP7l1JUE0js52PMR31oSJGoiawdmKCV/Edg5ZFmQHYV9diOMpAvS
         SGJqZrBA6uP1SRvkCLTXFsGDMbXZBCTRF234pLwl2GGTZfhfmHl7kzeTiei4PiKVL4
         3zwFeD25Vy5D9WacfuYXV3ASM4tGIbDqOTJK0Xts=
Date:   Mon, 21 Aug 2023 15:17:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     t.martitz@avm.de
Cc:     stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: proc_lseek backport request
Message-ID: <2023082138-unscrew-washbasin-1a74@gregkh>
References: <2023081752-giddily-anytime-237e@gregkh>
 <OF964B0E9A.174E142D-ONC1258A0E.0032FEAA-C1258A0E.00337FA7@avm.de>
 <OF38330399.317AA8E2-ONC1258A12.00239743-C1258A12.00239746@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF38330399.317AA8E2-ONC1258A12.00239743-C1258A12.00239746@avm.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Aug 21, 2023 at 08:28:44AM +0200, t.martitz@avm.de wrote:
> >Attempting to keep kernel code outside of the kernel tree is, on
> >purpose, very expensive in time and resources. The very simple way
> >to
> >solve this is to get your drivers merged properly into the mainline
> >kernel tree.
> >
> >Have you submitted your drivers and had them rejected?
> 
> Most drivers affected by the above patch are delivered to us by
> chip vendors that we cannot post publicly without their consent.

As it's all GPLv2 code, you don't need their "consent" to post the code
publicly, in fact, you are obligated to do so :)

> It's
> also not our job to get their crappy code (and it's a lot of that!) to a
> state that meets your quality standards. We can and do ask for mainline
> drivers but our influence is limited.

You can write this into your contract in order to pick their chips.
That's how this was resolved decades ago for scsi and ethernet
chips/drivers, you have more influence here than you might think.

> Also, would driver code for chips that aren't publicly available any useful for you?

Of course it would, it's available for someone, right?

> There is also some in-house code affected but that "drivers" don't usually
> drive hardware but simply provide F!OS-specific proc interfaces (F!OS
> is the name of the firmware that runs on our devices). These are just
> software, often device or vendor specific, and not suitable for the wider
> kernel community. Also we don't have the resources to get our code
> top-notch for potential mainline inclusion (although it's usually better
> than the vendor code we receive).

As stated many times before, by many companies, you will save time and
money if you get your code merged upstream.  If you have time and money
to burn (like nvidia), then sure, keep the code out of the kernel tree,
it's your choice.

> On the positive side, we do realize that mainlining things can be a net win for us
> long term and we have started an internal process that allows us to selectively
> mainline portions of our in-house code, but it's limited by resources and
> therefore a slow process. See [1] for example.
> 
> [1] https://lore.kernel.org/all/20230619071444.14625-1-jnixdorf-oss@avm.de/

That's great!

> >Have you taken advantage of the projects that are willing to take
> >out-of-tree drivers and get them merged upstream properly for free?
> 
> I don't know about any such project. Interesting to hear they exist! Who are they?

The old "driverdevel" mailing list would do this, but that got removed
many years ago when companies stopped needing this.  If you are
interested, email me off-list and we can take it from there.

thanks,

greg k-h
