Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C72C774A14
	for <lists+stable@lfdr.de>; Tue,  8 Aug 2023 22:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjHHUQk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 16:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbjHHUQ1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 16:16:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55813D1B0
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 12:19:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75DE862B1A
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 19:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800C6C433C9;
        Tue,  8 Aug 2023 19:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691522292;
        bh=ZIw9v9Wvl/WfcoYtSSXo3dN9K/ZQ4KLPP3oJk0odJdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aCyaSD6AQiCaR6A8tx6CAtJ5fI+jpaenGYfjUoJBqSvoLKcwFnMF+FEDx9VTAi5tB
         zK94xHpQ3qdOU90YkPucyxUkPworJidM0Aw3KmgszAUksZCQBGD1trlgU7cuEqfDXA
         H98Br9AzjQooU0LKh7eKwDhlGDopWaOGHMDVnz8U=
Date:   Tue, 8 Aug 2023 21:18:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 6.4.y] drm/amdgpu: Use apt name for FW reserved region
Message-ID: <2023080800-possum-swinging-f07a@gregkh>
References: <20230808175137.3820-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808175137.3820-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 08, 2023 at 12:51:37PM -0500, Mario Limonciello wrote:
> From: Lijo Lazar <lijo.lazar@amd.com>
> 
> Use the generic term fw_reserved_memory for FW reserve region. This
> region may also hold discovery TMR in addition to other reserve
> regions. This region size could be larger than discovery tmr size, hence
> don't change the discovery tmr size based on this.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Reviewed-by: Le Ma <le.ma@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit db3b5cb64a9ca301d14ed027e470834316720e42)
> This change fixes reading IP discovery from debugfs.
> It needed to be hand modified because GC 9.4.3 support isn't
> introduced in older kernels until 228ce176434b ("drm/amdgpu: Handle
> VRAM dependencies on GFXIP9.4.3")
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2748
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 35 ++++++++++++++-----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  3 ++-
>  2 files changed, 21 insertions(+), 17 deletions(-)

Now queued up, thanks.

greg k-h
