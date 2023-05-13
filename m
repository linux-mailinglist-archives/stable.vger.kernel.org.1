Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AB77016D2
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 15:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjEMNHD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 09:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjEMNHC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 09:07:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9743A82
        for <stable@vger.kernel.org>; Sat, 13 May 2023 06:07:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E254660AF0
        for <stable@vger.kernel.org>; Sat, 13 May 2023 13:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84F7C433D2;
        Sat, 13 May 2023 13:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683983219;
        bh=NDxWoqw/8CBhKTpd3XnN5HxXrWkvGPY0dEk2rKwsfAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LHtQ0aFSdAbcfGb1HJ7ViYzOgPqL6xHFLPNSZKjoyuIO7rUl2qL/QcUg1KLECi3Wo
         056qgzLpcM8XIlRK9QBKs5qk6kai6LjC3E9MqbG6i+GMN8w8roFH/Tdsk5yWh8NdJr
         lnvQOM9YFdo9YRlVnoCX0584pHkzeBw07W2IWNjk=
Date:   Sat, 13 May 2023 21:59:33 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mlimonci@amd.com>
Cc:     Martin.Leung@amd.com, Hanghong.Ma@amd.com,
        alexander.deucher@amd.com, daniel.wheeler@amd.com,
        mario.limonciello@amd.com, qingqing.zhuo@amd.com,
        stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] drm/amd/display: fix double memory
 allocation" failed to apply to 6.3-stable tree
Message-ID: <2023051308-step-handful-f179@gregkh>
References: <2023051306-elves-dividers-01e7@gregkh>
 <cca06775-c451-0247-9262-71c67a215a60@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cca06775-c451-0247-9262-71c67a215a60@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, May 13, 2023 at 07:28:20AM -0500, Mario Limonciello wrote:
> On 5/13/23 02:20, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.3-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x f5442b35e69e42015ef3082008c0d85cdcc0ca05
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051306-elves-dividers-01e7@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..
> > 
> > Possible dependencies:
> > 
> > f5442b35e69e ("drm/amd/display: fix double memory allocation")
> > b5006f873b99 ("drm/amd/display: initialize link_srv in virtual env")
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > ------------------ original commit in Linus's tree ------------------
> > 
> >  From f5442b35e69e42015ef3082008c0d85cdcc0ca05 Mon Sep 17 00:00:00 2001
> > From: Martin Leung <Martin.Leung@amd.com>
> > Date: Tue, 14 Mar 2023 09:27:20 -0400
> > Subject: [PATCH] drm/amd/display: fix double memory allocation
> > 
> > [Why & How]
> > when trying to fix a nullptr dereference on VMs,
> > accidentally doubly allocated memory for the non VM
> > case. removed the extra link_srv creation since
> > dc_construct_ctx is called in both VM and non VM cases
> > Also added a proper fail check for if kzalloc fails
> > 
> > Cc: stable@vger.kernel.org
> > Cc: Mario Limonciello <mario.limonciello@amd.com>
> > Reviewed-by: Leo Ma <Hanghong.Ma@amd.com>
> > Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> > Signed-off-by: Martin Leung <Martin.Leung@amd.com>
> > Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > 
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > index 40f2e174c524..52564b93f7eb 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > @@ -887,7 +887,10 @@ static bool dc_construct_ctx(struct dc *dc,
> >   	}
> >   	dc->ctx = dc_ctx;
> > +
> >   	dc->link_srv = link_create_link_service();
> > +	if (!dc->link_srv)
> > +		return false;
> >   	return true;
> >   }
> > @@ -986,8 +989,6 @@ static bool dc_construct(struct dc *dc,
> >   		goto fail;
> >   	}
> > -	dc->link_srv = link_create_link_service();
> > -
> >   	dc->res_pool = dc_create_resource_pool(dc, init_params, dc_ctx->dce_version);
> >   	if (!dc->res_pool)
> >   		goto fail;
> > 
> 
> FYI -
> This particular commit didn't need to come back to any stable channels as
> the commit it fixed
> b5006f873b99 ("drm/amd/display: initialize link_srv in virtual env")
> is only present in 6.4.

Any reason why a "Fixes:" tag wasn't added here?  That would have made
it much easier to figure this all out :)

thanks,

greg k-h
