Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E907DCF19
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 15:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjJaOL3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 10:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjJaOL3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 10:11:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DFFF7
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 07:11:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A78EC433C7;
        Tue, 31 Oct 2023 14:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698761486;
        bh=QvCiKT4HO547FclbUnEEQTepKxvJEDElslDvcOTWQDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LqJACRWYTkfdoEHFfgSYI478ndwXe/rA0ZiQ59Xw3TsbbwxZEhJfqCr482pucXT7Q
         7qdkxFA46JVvUzCsTraeAiVFXwbuFAweczOjqGkWI6lgBaoR5KuFnWMJ84eAOshqtI
         Jbl0L6bV2wa/DzAusaS7jJDQkMWBa6XGmGEoVJTI=
Date:   Tue, 31 Oct 2023 15:11:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 5.15 2/2] drm/amd: Disable ASPM for VI w/ all Intel
 systems
Message-ID: <2023103103-embellish-tilt-8e64@gregkh>
References: <20231027083958.38445-1-mario.limonciello@amd.com>
 <20231027083958.38445-2-mario.limonciello@amd.com>
 <2023103136-shanty-fancy-f3fa@gregkh>
 <d8bbb3b4-25a3-418f-9ebf-545d1d826265@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8bbb3b4-25a3-418f-9ebf-545d1d826265@amd.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 31, 2023 at 08:42:37AM -0500, Mario Limonciello wrote:
> On 10/31/2023 06:51, Greg KH wrote:
> > On Fri, Oct 27, 2023 at 03:39:58AM -0500, Mario Limonciello wrote:
> > > Originally we were quirking ASPM disabled specifically for VI when
> > > used with Alder Lake, but it appears to have problems with Rocket
> > > Lake as well.
> > > 
> > > Like we've done in the case of dpm for newer platforms, disable
> > > ASPM for all Intel systems.
> > > 
> > > Cc: stable@vger.kernel.org # 5.15+
> > > Fixes: 0064b0ce85bb ("drm/amd/pm: enable ASPM by default")
> > > Reported-and-tested-by: Paolo Gentili <paolo.gentili@canonical.com>
> > > Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2036742
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > (cherry-picked from 64ffd2f1d00c6235dabe9704bbb0d9ce3e28147f)
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/vi.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Again, what about 6.1.y?
> 
> 6.1 & 6.5 queue has it already:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-6.1/drm-amd-disable-aspm-for-vi-w-all-intel-systems.patch
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-6.5/drm-amd-disable-aspm-for-vi-w-all-intel-systems.patch
> 
> > 
> > And why aren't you cc:ing all of the original developers on this patch?
> 
> I was just looking to make less noise as they'll get it when it's added to
> the queue.  If it should be part of the submission to @stable as well I'll
> make a point to do that in the future.
> 
> > 
> > I'll drop this series and wait for ones for all relevant trees.
> 
> Considering my above comment can you please restore?

No, I need a new patch 1/2 please, please resend both of these, they are
long gone from my queue.

thanks,

greg k-h
