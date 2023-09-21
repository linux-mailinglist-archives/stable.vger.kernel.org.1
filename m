Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290497A9753
	for <lists+stable@lfdr.de>; Thu, 21 Sep 2023 19:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjIURWj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 13:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjIURW1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 13:22:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74E144F59
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 10:13:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42584C16ABD;
        Thu, 21 Sep 2023 08:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695286356;
        bh=QGQ8UZdnGHm0xTOTGBK6kD7Sr0s+cgqVFS+jXeuxmvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=olxHUFCVyLJBzODuGfbl2XTEWhtSlD7Sau6qt46dUEuci6WddIF5DY/4994WpK9f6
         i30pdkDOavInfDKWpZ2vsBqNnss0uWueUbvy3ese+UW5aIlK0aqbtSL5rETNUOglz0
         FKw/YMo73Ffy6lQFjeBWwoWaRyZBagXkIHoQjW4Y=
Date:   Thu, 21 Sep 2023 10:52:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.14 055/186] ARM: dts: BCM53573: Use updated "spi-gpio"
 binding properties
Message-ID: <2023092124-pessimism-trading-3842@gregkh>
References: <20230920112836.799946261@linuxfoundation.org>
 <20230920112838.896837720@linuxfoundation.org>
 <b7cea4f70cefbff3fac4f4ca1d42e78f@milecki.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7cea4f70cefbff3fac4f4ca1d42e78f@milecki.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 20, 2023 at 02:49:15PM +0200, Rafał Miłecki wrote:
> On 2023-09-20 13:29, Greg Kroah-Hartman wrote:
> > 4.14-stable review patch.  If anyone has any objections, please let me
> > know.
> 
> I already replied to the queuing e-mail but it was missed I guess. This
> patch should not get backported to the 4.14 due its dependencies. See
> below for more details.
> 
> -------- Original Message --------
> Subject: Re: Patch "ARM: dts: BCM53573: Use updated "spi-gpio" binding
> properties" has been added to the 4.14-stable tree
> Date: 2023-09-11 09:04
> From: Rafał Miłecki <rafal@milecki.pl>
> To: Sasha Levin <sashal@kernel.org>
> Cc: stable-commits@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
> <conor+dt@kernel.org>
> 
> On 2023-09-09 01:47, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     ARM: dts: BCM53573: Use updated "spi-gpio" binding properties
> > 
> > to the 4.14-stable tree which can be found at:
> > 
> > http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      arm-dts-bcm53573-use-updated-spi-gpio-binding-proper.patch
> > and it can be found in the queue-4.14 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> The new binding became part of Linux release 4.17-rc1 as a result of
> commits:
> 77a060533c04 ("spi: spi-gpio: Augment device tree bindings")
> 9b00bc7b901f ("spi: spi-gpio: Rewrite to use GPIO descriptors")
> 
> Kernels older than 4.17-rc1 don't support new binding.
> 
> This patch should NOT be backported to the 4.14.

Thanks for letting me know, now dropped.

greg k-h
