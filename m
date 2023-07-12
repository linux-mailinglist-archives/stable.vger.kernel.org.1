Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF30874FE9C
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 07:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjGLFMx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 12 Jul 2023 01:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjGLFMu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 12 Jul 2023 01:12:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2516410E3
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 22:12:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B855B616D8
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 05:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CD4C433C8;
        Wed, 12 Jul 2023 05:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689138769;
        bh=CR/CPGiMoJyzAlRhQhFmyumoIdOCGsV+WvCfpWXXYoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pzQph3h7aFDVVczXel9dS+nv+QSapvRcgABjM2FQWvGlT1Gt6hLHYqBOnfrl9Nkbu
         yNkfPBavm8LinXjMcdsHBVC0BIohFkACbkGSPENK585Fb8cMfSnH0tO3ug23F/148z
         leAvOoeAjnSsNsfQkEI6+48qlZ1UOgR8WlkT6DZ0=
Date:   Wed, 12 Jul 2023 07:12:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/9] drm/amdgpu: make sure BOs are locked in
 amdgpu_vm_get_memory
Message-ID: <2023071254-undermost-ipod-729b@gregkh>
References: <20230707150734.746135-1-alexander.deucher@amd.com>
 <c065e6f4-35d5-526f-30ab-61fdcc008415@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c065e6f4-35d5-526f-30ab-61fdcc008415@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jul 11, 2023 at 04:40:44PM -0500, Mario Limonciello wrote:
> On 7/7/23 10:07, Alex Deucher wrote:
> > From: Christian König <christian.koenig@amd.com>
> > 
> > We need to grab the lock of the BO or otherwise can run into a crash
> > when we try to inspect the current location.
> > 
> > Signed-off-by: Christian König <christian.koenig@amd.com>
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > Acked-by: Guchun Chen <guchun.chen@amd.com>
> > Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > (cherry picked from commit e2ad8e2df432498b1cee2af04df605723f4d75e6)
> > Cc: stable@vger.kernel.org # 6.3.x
> > ---
> 
> Greg,
> 
> Just want to make sure you saw these 9 commits as you're processing queues
> since they don't stand out as being sent directly to stable.

Thanks for the pointer, no, I had missed them in the flood of stable
patches recently.  I have many hundreds of other patches to still get
to, and these are now in that review queue as well.

greg k-h
