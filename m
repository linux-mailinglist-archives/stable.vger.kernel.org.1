Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2E67DCC21
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 12:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344042AbjJaLua (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 07:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344048AbjJaLu3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 07:50:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E33C1
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 04:50:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD382C433C7;
        Tue, 31 Oct 2023 11:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698753027;
        bh=mEK3u1Ey4XwYgcpUspSKy6acfN9nXHsuxv2jSY3hDLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MZ1FdbpqKLOYgInJbYYlM/l7f9UZfiRLUVDNTuYDI6AXrVfgWScXmhrwHFcc00Ma6
         XwqXgCHBl5UPGflCrLqLlbRAPYoDXS9a/9PzBUjktIMbPBxPSTWXHA359r9QvwY+bi
         PzDIY9PHrzK80FyB3VmLgD8W0OlBpFS5zL52CKmc=
Date:   Tue, 31 Oct 2023 12:50:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 5.15 1/2] drm/amd: Move helper for dynamic speed switch
 check out of smu13
Message-ID: <2023103102-antihero-gumming-5788@gregkh>
References: <20231027083958.38445-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027083958.38445-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 27, 2023 at 03:39:57AM -0500, Mario Limonciello wrote:
> This helper is used for checking if the connected host supports
> the feature, it can be moved into generic code to be used by other
> smu implementations as well.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Evan Quan <evan.quan@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit 5d1eb4c4c872b55664f5754cc16827beff8630a7)
> 
> The original problematic dGPU is not supported in 5.15.
> 
> Just introduce new function for 5.15 as a dependency for fixing
> unrelated dGPU that uses this symbol as well.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)

What about 6.5 and 6.1 for this commit?  We can't have someone upgrade
and have a regression, right?

thanks

greg k-h
