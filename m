Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1717F3E44
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 07:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjKVGjr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 01:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjKVGjr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 01:39:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C8DF9
        for <stable@vger.kernel.org>; Tue, 21 Nov 2023 22:39:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A18BC433C7;
        Wed, 22 Nov 2023 06:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700635183;
        bh=Etz4oAJAetmI6EfiIAZSZ/ruTMf2eSf47lNctvlVRks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tkryfY1WgI5gdCBQX2g7co95XEi98VlTmTIacd0h1EWybYoUdimHNec+gI4kbHsXv
         oX7OYa8ahAUg3R1/ciGmsFSNwQ8mlEm34pTdWqwZW0xkyaOWYI9ow+GshjOfCphYfR
         HkwDBLkU00imhF5nb+0avAeMJFoAFoVbANM0s3hA=
Date:   Wed, 22 Nov 2023 07:39:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Nguyen, Max" <hphyperxdev@gmail.com>
Cc:     stable@vger.kernel.org, "Nguyen, Max" <maxwell.nguyen@hyperx.com>,
        carl.ng@hp.com
Subject: Re: [PATCH 6.5 153/191] Input: xpad - add HyperX Clutch Gladiate
 Support
Message-ID: <2023112205-viselike-barracuda-f0c6@gregkh>
References: <20231016084015.400031271@linuxfoundation.org>
 <20231016084018.949398466@linuxfoundation.org>
 <MW4PR84MB17804D57BB57C0E2FB66EFC6EBADA@MW4PR84MB1780.NAMPRD84.PROD.OUTLOOK.COM>
 <MW4PR84MB178083997D411DFFD45BEFCDEBB7A@MW4PR84MB1780.NAMPRD84.PROD.OUTLOOK.COM>
 <6b2973c5-469a-4af8-995b-ee9196d0818b@gmail.com>
 <2023111814-impeach-sweep-aa30@gregkh>
 <9c3e4b65-4781-4d45-a270-f1b75dfb48d3@gmail.com>
 <8b130415-4f70-495c-85dc-355e3cd2db17@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b130415-4f70-495c-85dc-355e3cd2db17@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Nov 21, 2023 at 04:17:54PM -0800, Nguyen, Max wrote:
> 
> On 11/20/2023 3:52 PM, Nguyen, Max wrote:
> > 
> > On 11/18/2023 3:32 AM, Greg KH wrote:
> > > On Fri, Nov 17, 2023 at 03:42:22PM -0800, Nguyen, Max wrote:
> > > > > Hi,
> > > > > 
> > > > > We would like to apply this patch to version 6.1 of the LTS branch.
> > > > > This is to add a project ID for Android support for a gamepad
> > > > > controller.  We would like it to apply sooner than waiting
> > > > > for the next
> > > > > LTS branch due to project schedules.
> > > > > 
> > > > > commite28a0974d749e5105d77233c0a84d35c37da047e
> > > > > 
> > > > > Regards,
> > > > > 
> > > > > Max
> > > > > 
> > > > Hi Linux team,
> > > > 
> > > > We would like to have this patch backported to LTS versions
> > > > 4.19, 5.4, 5.10,
> > > > and 5.15 as well.  The main purpose would to add our device ID
> > > > for support
> > > > across older android devices.  Feel free to let us know if there
> > > > are any
> > > > concerns or issues.
> > > Please provide a working backport that you have tested as I think it did
> > > not apply cleanly on its own, right?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Hi Greg,
> > 
> > Do you have any general suggestions or instructions on how I can create
> > a backport to test?  I apologize as this is new to me.
> > 
> > Also, what do you mean by the patch did not apply cleanly on its own?
> > 
> We found that the patch does not apply correctly to the previous LTS
> kernels.  This is most likely due to addition of newer devices over time. 
> We will be sending separate patches for each kernel shortly.

Why not send a series adding all of the missing backported patches?
That makes it better so that all of the supported devices are now
working on the older kernels, not just this one.

thanks,

greg k-h
