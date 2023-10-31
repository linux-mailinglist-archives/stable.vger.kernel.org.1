Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A605B7DD4E3
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346874AbjJaRpD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346974AbjJaRpC (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:45:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A2FF5
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:45:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BD4C433B6;
        Tue, 31 Oct 2023 17:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774299;
        bh=6K+arDBEUtDJE504Zx5IFbZ7Y6ip4GqpK60djqYfepM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W6cS5PTm0m/z9sWPOJ1DdXbG6RisSU+FwXac8qZY0fnOhRj2MyE0jJ7FLThPsbK5U
         d83PibaqtsoopaKwaTCJWoe/Tbc/PVOh2GKCwcPg2jkpv2D2Uz7BVh5NPZ/nIeT6Kq
         JCc83nc+DQYbNC7wy3FdpLlSKQNiFszL7HjjbZM8=
Date:   Tue, 31 Oct 2023 18:44:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Takashi Iwai <tiwai@suse.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 05/86] ASoC: codecs: wcd938x: Convert to platform
 remove callback returning void
Message-ID: <2023103133-skating-last-e2f6@gregkh>
References: <20231031165918.608547597@linuxfoundation.org>
 <20231031165918.777236098@linuxfoundation.org>
 <958957ff-bbaa-4fbc-a796-30e2fdf61453@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <958957ff-bbaa-4fbc-a796-30e2fdf61453@sirena.org.uk>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 31, 2023 at 05:11:27PM +0000, Mark Brown wrote:
> On Tue, Oct 31, 2023 at 06:00:30PM +0100, Greg Kroah-Hartman wrote:
> 
> > The .remove() callback for a platform driver returns an int which makes
> > many driver authors wrongly assume it's possible to do error handling by
> > returning an error code. However the value returned is (mostly) ignored
> > and this typically results in resource leaks. To improve here there is a
> > quest to make the remove callback return void. In the first step of this
> > quest all drivers are converted to .remove_new() which already returns
> > void.
> > 
> > Trivially convert this driver from always returning zero in the remove
> > callback to the void returning variant.
> 
> This doesn't seem like obvious stable material - it's not fixing any
> leaks or anything, just preparing for an API transition?

It was taken to make the patch after this one apply cleanly, that's all.

thanks,

greg k-h
