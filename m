Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6F9733F67
	for <lists+stable@lfdr.de>; Sat, 17 Jun 2023 10:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbjFQIFD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 17 Jun 2023 04:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346292AbjFQIE4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Jun 2023 04:04:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132C52965
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 01:04:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A49E960A5A
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 08:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8050DC433C0;
        Sat, 17 Jun 2023 08:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686989094;
        bh=2yrTitVxegN2Pm3bpwn7RK8jBO+Xv3NEmfvLXf3Q070=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LahX+J0KgpxXa4aNJP+rtLK3MpPFSqtao/FD7jdbi1BC7M2qMww253eyT+M++c8Kd
         lwxyC/4+ejoSXCwcSGYwT9b3JKFz0DFGsfFYv6oTy4hSzQkLDcWJTOCBxHEzl2PmJp
         Ru7gzBy1uuxC2rVfhAO7yRSB826EBp0LHHAXPe8c=
Date:   Sat, 17 Jun 2023 10:04:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.3 038/160] wifi: cfg80211: fix locking in regulatory
 disconnect
Message-ID: <2023061736-frail-broadcast-5885@gregkh>
References: <20230612101715.129581706@linuxfoundation.org>
 <20230612101716.793331479@linuxfoundation.org>
 <23db24e1efd0ce7904d0e57289009852cd58e29b.camel@sipsolutions.net>
 <2023061216-pry-mournful-beed@gregkh>
 <1bcc48094ecae8b810e394abb7101bb8f4acb860.camel@sipsolutions.net>
 <2023061628-nimbly-ebook-3635@gregkh>
 <dd21d369706b89d5a4033e6af344ed7045465077.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd21d369706b89d5a4033e6af344ed7045465077.camel@sipsolutions.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jun 16, 2023 at 10:06:38PM +0200, Johannes Berg wrote:
> On Fri, 2023-06-16 at 20:48 +0200, Greg Kroah-Hartman wrote:
> > On Fri, Jun 16, 2023 at 06:51:15PM +0200, Johannes Berg wrote:
> > > On Mon, 2023-06-12 at 14:10 +0200, Greg Kroah-Hartman wrote:
> > > > On Mon, Jun 12, 2023 at 01:43:23PM +0200, Johannes Berg wrote:
> > > > > On Mon, 2023-06-12 at 10:26 +0000, Greg Kroah-Hartman wrote:
> > > > > > From: Johannes Berg <johannes.berg@intel.com>
> > > > > > 
> > > > > > [ Upstream commit f7e60032c6618dfd643c7210d5cba2789e2de2e2 ]
> 
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commit/?id=996c3117dae4c02b38a3cb68e5c2aec9d907ec15
> 
> > I can pick them up from here, as the git ids are present and that's all
> > I need, right?
> 
> Correct, thanks!
> 
> Note that in 6.0 the indentation for the second patch changed, but
> otherwise the logic is the same (just additional indentation due to
> multi-link support.) But I can also just send a fixed version when you
> bounce it back due to not applying.

I fixed it up by hand, thanks.

greg k-h
