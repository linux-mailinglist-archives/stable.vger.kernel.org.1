Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA3A782EA1
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 18:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjHUQk5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 12:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjHUQk4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 12:40:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A392136
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 09:40:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFE2763B9D
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 16:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE90C433C8;
        Mon, 21 Aug 2023 16:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692636051;
        bh=7Bv/d/KyGV6FnHi9UcRinVPzL0SAAQujidf97jpI3eg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j4xxw1a3RKj/PVFTr8kidc0OgZ2zMRA136cPAnJcXGF0lvyRK0tUmxdkMa6wQoav2
         Wig5Yj0C6xpNUN9N27GiMeTMQDkRCcNkZxcXA4RtVTvw8g3ciQ/JiucXy7un7gf7eB
         PZ6GsSBQwVKgPz8zHuvl/+q0QCqMiqIEGAtxoTH0=
Date:   Mon, 21 Aug 2023 18:40:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Tim Huang <Tim.Huang@amd.com>, sashal@kernel.org,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: skip the RLC stop when S0i3 suspend for
 SMU v13.0.4/11
Message-ID: <2023082139-retinal-surreal-fc1f@gregkh>
References: <20230817134037.1535484-1-alexander.deucher@amd.com>
 <1337fb94-3a31-4aca-897d-8a59e7500dac@amd.com>
 <2023082112-matchbook-favoring-48cc@gregkh>
 <2023082101-diocese-likely-63c5@gregkh>
 <0b151c40-3edd-4511-a647-4e11e2308841@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b151c40-3edd-4511-a647-4e11e2308841@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Aug 21, 2023 at 11:30:29AM -0500, Limonciello, Mario wrote:
> 
> 
> On 8/21/2023 10:37 AM, Greg KH wrote:
> > On Mon, Aug 21, 2023 at 02:56:41PM +0200, Greg KH wrote:
> > > On Mon, Aug 21, 2023 at 07:15:53AM -0500, Limonciello, Mario wrote:
> > > > 
> > > > 
> > > > On 8/17/2023 8:40 AM, Alex Deucher wrote:
> > > > > From: Tim Huang <Tim.Huang@amd.com>
> > > > > 
> > > > > For SMU v13.0.4/11, driver does not need to stop RLC for S0i3,
> > > > > the firmwares will handle that properly.
> > > > > 
> > > > > Signed-off-by: Tim Huang <Tim.Huang@amd.com>
> > > > > Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > > > (cherry picked from commit 730d44e1fa306a20746ad4a85da550662aed9daa)
> > > > > Cc: stable@vger.kernel.org # 6.1.x
> > > > 
> > > > Greg,
> > > > 
> > > > Just want to make sure this one didn't get accidentally skipped since you
> > > > populated the stable queues and didn't see it landed.
> > > 
> > > I'm still working on catching up on the stable backlog as I was gone
> > > last week, this is in my "to get to soon" queue, it's not lost :)
> > 
> > Wait, I'm confused.  You have 2 patches in this series, yet one says
> > "6.1.x" and one "6.4.x"?  But both actually to both trees.  So where are
> > these supposed to be applied to?
> > 
> > Please always give me a hint, and never mix/match kernel versions in a
> > patch series, what would you do if you recieved that?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Yeah I see the confusion here.  Sorry about that.
> I looked over both and they should both apply to 6.1.y and 6.4.y.

Thanks, both now queued up to both trees.

greg k-h
