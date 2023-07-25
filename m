Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4F9761A48
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 15:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjGYNos (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 09:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjGYNos (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 09:44:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDE21FF5
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 06:44:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC2CC616FD
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 13:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AB7C433C8;
        Tue, 25 Jul 2023 13:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690292648;
        bh=YWE/8RkY8IwL7upamSd1WGx59zrwlmId8h4DayhPkjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=00vSltNdqJePYM+LsR2Xkdteezq8WkeCME9mcDGEh8WpPsKrYBEqzRfWjwsyzX/pF
         fPef+7E7d0VO1t2ydjJ7I0+GZnJ/YwpXrxRY8a3z8HBKmbq6G3BDi6T7Tuie1lktY0
         uF7ESnik6XpA82rw1/A2fIFeZWatJnjP1+K2tVL0=
Date:   Tue, 25 Jul 2023 15:44:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Alex G." <mr.nuke.me@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Wang, Chao-kai (Stylon)" <Stylon.Wang@amd.com>,
        "Wu, Hersen" <hersenxs.wu@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
        "Wheeler, Daniel" <Daniel.Wheeler@amd.com>,
        "eniac-xw.zhang@hp.com" <eniac-xw.zhang@hp.com>
Subject: Re: [PATCH 6.1 146/223] drm/amd/display: edp do not add non-edid
 timings
Message-ID: <2023072548-basics-estranged-5e99@gregkh>
References: <20230721160520.865493356@linuxfoundation.org>
 <20230721160527.097927704@linuxfoundation.org>
 <18e9e042-12ec-8e09-1225-ca44810e2b82@gmail.com>
 <BL1PR12MB5144A568ECEB3E9E18BA74C4F702A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <2023072503-subduing-entertain-878c@gregkh>
 <774e7690-527a-7042-e61b-2f3a73c46c36@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <774e7690-527a-7042-e61b-2f3a73c46c36@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jul 25, 2023 at 08:22:17AM -0500, Mario Limonciello wrote:
> On 7/25/23 02:13, Greg Kroah-Hartman wrote:
> > On Mon, Jul 24, 2023 at 07:38:24PM +0000, Deucher, Alexander wrote:
> > > [AMD Official Use Only - General]
> > > 
> > > > -----Original Message-----
> > > > From: Alex G. <mr.nuke.me@gmail.com>
> > > > Sent: Monday, July 24, 2023 3:23 PM
> > > > To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> > > > stable@vger.kernel.org
> > > > Cc: patches@lists.linux.dev; Limonciello, Mario
> > > > <Mario.Limonciello@amd.com>; Deucher, Alexander
> > > > <Alexander.Deucher@amd.com>; Wang, Chao-kai (Stylon)
> > > > <Stylon.Wang@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; Li, Roman
> > > > <Roman.Li@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>; eniac-
> > > > xw.zhang@hp.com
> > > > Subject: Re: [PATCH 6.1 146/223] drm/amd/display: edp do not add non-edid
> > > > timings
> > > > 
> > > > Hi Greg,
> > > > 
> > > > This patch was
> > > >       * originally added to v6.1.35
> > > >       * reverted in v6.1.39
> > > >       * added back in v6.1.40
> > > > 
> > > > This patch is still reverted in mainline. Was this patch re-added by mistake in
> > > > v6.1.y stable?
> > > 
> > > Yes, this patch should stay reverted.
> > 
> > Where was it reverted in the 6.1.y tree?  And where was it reverted in
> > Linus's tree?
> > 
> > I think the confusion here is you have the same commit in the tree with
> > two different commit ids.  So when I see the patches flow by, I applied
> > just this one to the tree, and I only see it in 6.1.40 with that id,
> > missing any possible revert of a previous version as the ids don't match
> > up.
> > 
> > In other words, what am I supposed to do here when you duplicate
> > commits?  What's the revert of this commit, is it also in the tree
> > twice?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Here is the revert from Linus' tree (6.5-rc1):
> d6149086b45e150c170beaa4546495fd1880724c
> 
> Here are the two times it landed in Linus' tree (6.4-rc7 and 6.5-rc1)
> e749dd10e5f292061ad63d2b030194bf7d7d452c
> 7a0e005c7957931689a327b2a4e7333a19f13f95
> 
> It should be reverted in 6.1.

Ick, what a mess, and now you can see why I missed that.  And everyone
missed the original revert should have also gone to 5.15.y :(

I've queued it up everywhere now, hopefully that's it.  But next time,
PLEASE make this more obvious somehow.  Applying the same patch twice,
and only having one revert looks like it was applied, reverted, and then
applied, not reverted again once more.

thanks,

greg k-h
