Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC1679E0D9
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 09:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjIMHa2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 03:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjIMHa1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 03:30:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0CC1727
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 00:30:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBC2C433C8;
        Wed, 13 Sep 2023 07:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694590223;
        bh=YQhbnNEy+5tfRNoqjZFdQ0pDZvX5MXx4/xET608ITls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t8oJp6GM/HC2Y/SSflPHhg1mHEGyH94YL7SkDd/QdTeqfnnk/0qRNsrdl1T5GLsH4
         LL1dKgKgOZ1YJ7t2Vx8RpJNjm2EJoL/odPeWp7tn7JfEwJkQhzsn7wlyE6Iz4L1B7H
         NP7yk2BNGLruFJU0e9F8AyF+V0/f0FI2ljJNCLAI=
Date:   Wed, 13 Sep 2023 09:30:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <mdaenzer@redhat.com>,
        "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>
Subject: Re: [PATCH 6.4 737/737] Revert "drm/amd/display: Do not set drr on
 pipe commit"
Message-ID: <2023091327-unaligned-nastiness-3bfa@gregkh>
References: <20230911134650.286315610@linuxfoundation.org>
 <20230911134711.107793802@linuxfoundation.org>
 <CH0PR12MB5284A97461111A04912017798BF1A@CH0PR12MB5284.namprd12.prod.outlook.com>
 <2023091212-simplify-underfoot-a4d6@gregkh>
 <CH0PR12MB528496066990E49D4F93CD208BF1A@CH0PR12MB5284.namprd12.prod.outlook.com>
 <2023091211-contact-limping-4fe0@gregkh>
 <6cbf86ee-14ea-7a46-2aa0-5434e3c3443b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cbf86ee-14ea-7a46-2aa0-5434e3c3443b@amd.com>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Sep 12, 2023 at 12:04:20PM -0400, Aurabindo Pillai wrote:
> 
> 
> On 9/12/2023 11:39 AM, Greg Kroah-Hartman wrote:
> > On Tue, Sep 12, 2023 at 03:31:16PM +0000, Pillai, Aurabindo wrote:
> > > [AMD Official Use Only - General]
> > > 
> > > Hi Greg,
> > > 
> > > It was reverted but has been re-applied.
> > > 
> > > Here is a chronological summary of what happened:
> > > 
> > > 
> > >    1.  Michel bisected some major issues to "drm/amd/display: Do not set drr on pipe commit" and was revered in upstream. ". Along with that patch, "drm/amd/display: Block optimize on consecutive FAMS enables" was also reverted due to dependency.
> > >    2.  We found that reverting these patches caused some multi monitor configurations to hang on RDNA3.
> > >    3.  We debugged Michel's issue and merged a workaround (https://gitlab.freedesktop.org/agd5f/linux/-/commit/cc225c8af276396c3379885b38d2a9e28af19aa9
> > >    4.  Subsequently, the two patches were reapplied (https://gitlab.freedesktop.org/agd5f/linux/-/commit/bfe1b43c1acee1251ddb09159442b9d782800aef and https://gitlab.freedesktop.org/agd5f/linux/-/commit/f3c2a89c5103b4ffdd88f09caa36488e0d0cf79d)
> > > 
> > > Hence, the stable kernel should have all 3 patches - the workaround and 2 others. Hope that clarifies the situation.
> > 
> > Great, what are the ids of those in Linus's tree?
> 
> 
> 3b6df06f01cd drm/amd/display: Block optimize on consecutive FAMS enables

Ok, I'll add this one.

> 09c8cbedba5f drm/amd/display: Do not set drr on pipe commit

This is already in the 6.5-rc queue

> 613a7956deb3 drm/amd/display: Add monitor specific edid quirk

This is already in the 6.5 release.

So all that was needed was the one additional one?  I'll go queue that
up now, thanks.

greg k-h
