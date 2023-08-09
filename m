Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA9F775626
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 11:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjHIJKH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 05:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjHIJKG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 05:10:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90F81FD0
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 02:10:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8806E6307A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 09:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A568C433C8;
        Wed,  9 Aug 2023 09:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691572204;
        bh=q9t3uz9eA3sAO4VYLnCJ9JrowTtV5lckre4fGvHHoFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KGntHkVMFF0cDnVpLwWxL1MBDcLVJ0IYNpzuvj0ns4aElBVq2K86yIXToHx9CKMEx
         y44/YCpSayi6idz0aMsFWpr2Ato8yx4C/0NCKtaTQfpy95nEBWbJflcMd7B+5lMn8D
         fobNdEw0OZeaIRaUJ5IExA8hyZoPDMbaW+mybw3E=
Date:   Wed, 9 Aug 2023 11:09:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y 0/3] Fix accessing IP discovery from debugfs
Message-ID: <2023080945-polio-singular-ec58@gregkh>
References: <20230808175055.3761-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808175055.3761-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 08, 2023 at 12:50:52PM -0500, Mario Limonciello wrote:
> As part of debugging https://gitlab.freedesktop.org/drm/amd/-/issues/2748
> one issue that was noticed was that debugfs access for the IP discovery
> blob wasn't working in 6.1.y.  It worked in 6.5-rc1 though.
> 
> This series fixes this issue for 6.1.y.
> 
> Lijo Lazar (1):
>   drm/amdgpu: Use apt name for FW reserved region
> 
> Luben Tuikov (1):
>   drm/amdgpu: Remove unnecessary domain argument
> 
> Tong Liu01 (1):
>   drm/amdgpu: add vram reservation based on vram_usagebyfirmware_v2_2
> 
>  .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 104 ++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  10 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  89 +++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   8 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |   1 -
>  drivers/gpu/drm/amd/include/atomfirmware.h    |  63 +++++++++--
>  7 files changed, 217 insertions(+), 60 deletions(-)
> 
> -- 
> 2.34.1
> 

All now queued up, thanks.

greg k-h
