Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E29370152A
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 09:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjEMHxd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 03:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEMHxb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 03:53:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080324C1B
        for <stable@vger.kernel.org>; Sat, 13 May 2023 00:53:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 990FF60A6E
        for <stable@vger.kernel.org>; Sat, 13 May 2023 07:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5F5C433D2;
        Sat, 13 May 2023 07:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683964409;
        bh=230gTjEiKrVKiJZUmqAmuka3Sl8shN4MocC+tBfiCPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SHgCKRTUPecowrghms5Vus7eWUdoayjPkwhny/RbsjjdLiddJ+sE1AfpTPzYaB3k2
         +QZrDJxd8Cdk71MZ0H8HjaBh1pMCgYXTgEsOp0qsK2nmY8zGG+2t4c4Yrn1Hlruwoc
         +qly/zYmYYlI5+FVh+LFMT4ACAcp+c54739G2m+M=
Date:   Sat, 13 May 2023 16:28:21 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Gong, Richard" <richard.gong@amd.com>
Cc:     stable@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: AMD Navi3x dGPU experience improvement
Message-ID: <2023051312-visible-badland-1311@gregkh>
References: <5ca2e61d-08d6-3070-f281-e2483cb7718a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ca2e61d-08d6-3070-f281-e2483cb7718a@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 08, 2023 at 08:19:41AM -0500, Gong, Richard wrote:
> Hi,
> 
> Since AMD introduced Navi3x dGPUs, setting them up is more difficult than it
> need to be, as you need the GPU firmware binaries present in the filesystem
> before the kernel drivers can be loaded. If you don't, you'll just "hang" at
> a black screen. This is awkward because you must do
> modprobe.blacklist=amdgpu and then load the file.
> 
> A large commit series went into 6.3 that improve this experience, but not
> all of it is stable materiel.
> 
> As the dGPUs are supported on 6.1.y and 6.2.y, we can improve the experience
> specifically for these new produces by back-porting a small subset of
> commits that correspond to firmware files that are uniquely loaded by the
> new products. With these commits amdgpu driver will return an error code and
> you can continue to use framebuffer provided by UEFI GOP driver until you
> have GPU firmware binaries loaded onto your system.
> 
> Commits needed for 6.2.y
> 	cc42e76e7de5 "drm/amd: Load MES microcode during early_init"
> 	2210af50ae7f "drm/amd: Add a new helper for loading/validating microcode"
> 	11e0b0067ec0 "drm/amd: Use `amdgpu_ucode_*` helpers for MES"
> 
> Commits needed for 6.1.y
> 	6040517e4a29 "drm/amdgpu: remove deprecated MES version vars"
> 	cc42e76e7de5 "drm/amd: Load MES microcode during early_init"
> 	2210af50ae7f "drm/amd: Add a new helper for loading/validating microcode"
> 	11e0b0067ec0 "drm/amd: Use `amdgpu_ucode_*` helpers for MES"

All now queued up, thanks.

greg k-h
