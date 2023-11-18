Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF217EFF43
	for <lists+stable@lfdr.de>; Sat, 18 Nov 2023 12:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjKRLcz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 18 Nov 2023 06:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKRLcy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 18 Nov 2023 06:32:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58B91A1
        for <stable@vger.kernel.org>; Sat, 18 Nov 2023 03:32:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EA8C433C7;
        Sat, 18 Nov 2023 11:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700307170;
        bh=lsal5EteU5D+tkysSD2d5xRZHKN+ruj/XNzi/9rNe3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G3lErMqBZqiXIkzfCCLhNnTpeEh78Buxnaebat2PUkG+zXjcyhRCa06kdxkhlRnY9
         lvE4rzlcYzrDtwRoRxhLoWvT4aq6wMfhXr6fxwe54enQjK/6ZhGbwAyLGUdPqj+Ccf
         v/w5CrqdFaYRCxXvQkI4Od3bQGEwnX4FVceC7CUg=
Date:   Sat, 18 Nov 2023 06:32:45 -0500
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Nguyen, Max" <hphyperxdev@gmail.com>
Cc:     stable@vger.kernel.org, "Nguyen, Max" <maxwell.nguyen@hyperx.com>,
        carl.ng@hp.com
Subject: Re: [PATCH 6.5 153/191] Input: xpad - add HyperX Clutch Gladiate
 Support
Message-ID: <2023111814-impeach-sweep-aa30@gregkh>
References: <20231016084015.400031271@linuxfoundation.org>
 <20231016084018.949398466@linuxfoundation.org>
 <MW4PR84MB17804D57BB57C0E2FB66EFC6EBADA@MW4PR84MB1780.NAMPRD84.PROD.OUTLOOK.COM>
 <MW4PR84MB178083997D411DFFD45BEFCDEBB7A@MW4PR84MB1780.NAMPRD84.PROD.OUTLOOK.COM>
 <6b2973c5-469a-4af8-995b-ee9196d0818b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b2973c5-469a-4af8-995b-ee9196d0818b@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Nov 17, 2023 at 03:42:22PM -0800, Nguyen, Max wrote:
> 
> > Hi,
> > 
> > We would like to apply this patch to version 6.1 of the LTS branch. 
> > This is to add a project ID for Android support for a gamepad
> > controller.  We would like it to apply sooner than waiting for the next
> > LTS branch due to project schedules.
> > 
> > commite28a0974d749e5105d77233c0a84d35c37da047e
> > 
> > Regards,
> > 
> > Max
> > 
> Hi Linux team,
> 
> We would like to have this patch backported to LTS versions 4.19, 5.4, 5.10,
> and 5.15 as well.  The main purpose would to add our device ID for support
> across older android devices.  Feel free to let us know if there are any
> concerns or issues.

Please provide a working backport that you have tested as I think it did
not apply cleanly on its own, right?

thanks,

greg k-h
