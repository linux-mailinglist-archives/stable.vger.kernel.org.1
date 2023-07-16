Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B877550F9
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjGPT2e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGPT2d (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:28:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7C2199
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:28:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4855660E08
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578A3C433C7;
        Sun, 16 Jul 2023 19:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689535711;
        bh=uYS765a6JKO6DxL/KnFYMXvghkKuSZWOKjtN2BlCytI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y9yyWDNhLldUoopYMvPjHTdOyfQSREULLEyzAgvcklfYT9B7ZIGkFOfir1eXqpP+J
         t1/VGJY5ljS6N9kp7HbekrURVAFC9FwAinDiO0UXAk4lQ5apGGwUtoik87xHOzmmJ4
         lVhoRFt/ZMEPdEiwteHITVQZpHvLd2wyk//xIkys=
Date:   Sun, 16 Jul 2023 21:28:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: Re: [PATCH 1/9] drm/amdgpu: make sure BOs are locked in
 amdgpu_vm_get_memory
Message-ID: <2023071654-flattery-fidgety-0e31@gregkh>
References: <20230707150734.746135-1-alexander.deucher@amd.com>
 <2023071649-gradation-reckless-5db5@gregkh>
 <bfb99ba9-8fb3-1af7-d0b2-c617bbd5c2b6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bfb99ba9-8fb3-1af7-d0b2-c617bbd5c2b6@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Jul 16, 2023 at 02:22:36PM -0500, Mario Limonciello wrote:
> On 7/16/23 14:16, Greg KH wrote:
> > On Fri, Jul 07, 2023 at 11:07:26AM -0400, Alex Deucher wrote:
> > > From: Christian König <christian.koenig@amd.com>
> > > 
> > > We need to grab the lock of the BO or otherwise can run into a crash
> > > when we try to inspect the current location.
> > > 
> > > Signed-off-by: Christian König <christian.koenig@amd.com>
> > > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > > Acked-by: Guchun Chen <guchun.chen@amd.com>
> > > Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > (cherry picked from commit e2ad8e2df432498b1cee2af04df605723f4d75e6)
> > > Cc: stable@vger.kernel.org # 6.3.x
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 69 +++++++++++++++-----------
> > >   1 file changed, 39 insertions(+), 30 deletions(-)
> > 
> > I've applied the first 7 patches here to 6.4.y, which I am guessing is
> > where you want them applied to, yet you didn't really say?
> > 
> > The last 2 did not apply :(
> > 
> > And some of these should go into 6.1.y also?  Please send a patch series
> > and give me a hint as to where they should be applied to next time so I
> > don't have to guess...
> > 
> > thanks,
> > 
> > greg k-h
> 
> In this case the individual patches with specific requirements have:
> 
> Cc: stable@vger.kernel.org # version
> 
> They were sent before 6.3 went EOL, so here is the updated summary from
> them:
> 6.4.y:
> 1, 2, 3, 4, 5, 6, 7, 8, 9
> 
> 6.1.y:
> 3, 4, 5, 6, 7, 8, 9
> 
> 3 is particularly important for 6.1.y as we have active regressions reported
> related to it on 6.1.y.
> 
> So can you please take 3-7 to 6.1.y and I'll look more closely at what is
> wrong with 8 and 9 on 6.1.y and 6.4.y and resend them?

I can't really pick out these for 6.1 from the larger series as I'm
drowning in patches at the moment.  Please send a backported series and
I'll be glad to queue that up.

thanks,

greg k-h
