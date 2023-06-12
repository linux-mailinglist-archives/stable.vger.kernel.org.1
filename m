Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C409F72C3B2
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 14:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjFLMKl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 08:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjFLMKk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 08:10:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECCC9E
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 05:10:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C70076176F
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 12:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76B3C433D2;
        Mon, 12 Jun 2023 12:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686571837;
        bh=woWcCxLImDvq1oizXs1M0cVggKJm/m5bOTJ+QkYngls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qm0K0duwDljOJSNBNPM8i+fABmP44/OHut3UUIFic76sSye+CBsGzQXQukvfs2eKI
         icIzgR+Y5eywQM7QrnenwTO2UnAg6mYV743ENQKMKTdxCk2jWg6Gv8/3zFwdFj1GUd
         9DuB73M7yAM0KRF4ACRSNwzDmGw9Xj3DFT62pL2Q=
Date:   Mon, 12 Jun 2023 14:10:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.3 038/160] wifi: cfg80211: fix locking in regulatory
 disconnect
Message-ID: <2023061216-pry-mournful-beed@gregkh>
References: <20230612101715.129581706@linuxfoundation.org>
 <20230612101716.793331479@linuxfoundation.org>
 <23db24e1efd0ce7904d0e57289009852cd58e29b.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23db24e1efd0ce7904d0e57289009852cd58e29b.camel@sipsolutions.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jun 12, 2023 at 01:43:23PM +0200, Johannes Berg wrote:
> On Mon, 2023-06-12 at 10:26 +0000, Greg Kroah-Hartman wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> > 
> > [ Upstream commit f7e60032c6618dfd643c7210d5cba2789e2de2e2 ]
> > 
> > This should use wiphy_lock() now instead of requiring the
> > RTNL, since __cfg80211_leave() via cfg80211_leave() is now
> > requiring that lock to be held.
> 
> You should perhaps hold off on this. While all this is correct, I missed
> something that Dan found later:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commit/?id=996c3117dae4c02b38a3cb68e5c2aec9d907ec15
> 
> I'll have this in the next pull request.
> 
> I suppose _both_ should go to stable, and nobody ever seems to run into
> this patch (at least lockdep would loudly complain), but stills seems
> better in the short term to have missing locking than a deadlock.

Thanks for letting me know, I've dropped this from all queues now.

greg k-h
