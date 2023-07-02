Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A374744DBF
	for <lists+stable@lfdr.de>; Sun,  2 Jul 2023 15:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjGBNmF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 2 Jul 2023 09:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjGBNmE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 2 Jul 2023 09:42:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69670E55
        for <stable@vger.kernel.org>; Sun,  2 Jul 2023 06:42:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFC9E60B01
        for <stable@vger.kernel.org>; Sun,  2 Jul 2023 13:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46F7C433C8;
        Sun,  2 Jul 2023 13:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688305320;
        bh=/P9ni87A8BjL3AltShw+ggKVyyQZCvEJqPMpHpWZuTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y80e4eDEAC/1qyQo12RS/9xpukaHSIXLNwEdShwVwb0ElSGUBhkV7WcAoqgowmmOm
         d8YLKM/2GWkva6aYS/XEEZWln+b7LoVlhrCcvse6XO6kyiQgoi0Jgbs4WJuMPFoNyh
         lOnayEgnwaxiH0V66uuj0WfNMhns8ve6viOMmtEU=
Date:   Sun, 2 Jul 2023 15:41:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org
Subject: Re: Fix regression on Stoney
Message-ID: <2023070229-slinky-explore-187e@gregkh>
References: <9ef5921a-2382-b006-75fe-1613ac727dc7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ef5921a-2382-b006-75fe-1613ac727dc7@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Jul 02, 2023 at 08:12:15AM -0500, Mario Limonciello wrote:
> Hi,
> 
> A regression [1] was reported on suspend for AMD Stoney on 6.3.10.
> It bisected down to:
> 
> 1ca399f127e0 ("drm/amd/display: Add wrapper to call planes and stream
> update")
> 
> This was requested by me to fix a PSR problem [2], which isn't used on
> Stoney.
> 
> This was also backported into 6.1.36 (as e538342002cb) and 5.15.119 (as
> 3c1aa91b37f9).
> 
> It's fixed on 6.3.y by cherry-picking:
> 
> 32953485c558 ("drm/amd/display: Do not update DRR while BW optimizations
> pending")
> 
> It's fixed in 6.1.y by cherry-picking:
> 
> 3442f4e0e555 ("drm/amd/display: Remove optimization for VRR updates")
> 32953485c558 ("drm/amd/display: Do not update DRR while BW optimizations
> pending")

All now queued up, thanks.

> On 5.15.y it's not a reasonable backport to take the fix to stable because
> there is a lot of missing Freesync code.  Instead it's better to revert the
> patch series that introduced it to 5.15.y because PSR-SU isn't even
> introduced until later kernels anyway.
> 
> 5a24be76af79 ("drm/amd/display: fix the system hang while disable PSR")
> 3c1aa91b37f9 ("drm/amd/display: Add wrapper to call planes and stream
> update")
> eea850c025b5 ("drm/amd/display: Use dc_update_planes_and_stream")
> 97ca308925a5 ("drm/amd/display: Add minimal pipe split transition state")

Can you please send these reverts with the discussion as to why they are
requried?

thanks,

greg k-h
