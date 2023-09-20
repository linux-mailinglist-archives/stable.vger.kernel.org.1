Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEFF7A79FF
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbjITLGG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbjITLGG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:06:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D3EB4
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:06:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C634C433C8;
        Wed, 20 Sep 2023 11:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695207960;
        bh=eCQG8JWz1FkhsR2b4Lgi5Dz2aILnJGbKx6vsfJKsFD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0czvp9QMCPcxKoYFnlSJQTYowWmaCnglUIVTHnaQuJoXYsYvr4d8mn+FB60wbifdq
         Kkc/4GJBs5XdW1biZ4FP3jeujgDiuYGfw0XooxS7FbXHzzyFnoinJ3upxSgBvma+Xc
         /bSFSJ9sCrIf0OBR16lm6f6YlCdbPh17bHPEUR6Q=
Date:   Wed, 20 Sep 2023 13:05:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     stable@vger.kernel.org, sashal@kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix amdgpu_cs_p1_user_fence
Message-ID: <2023092050-cottage-eastcoast-71e6@gregkh>
References: <20230918204831.2270796-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230918204831.2270796-1-alexander.deucher@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Sep 18, 2023 at 04:48:31PM -0400, Alex Deucher wrote:
> From: Christian König <christian.koenig@amd.com>
> 
> The offset is just 32bits here so this can potentially overflow if
> somebody specifies a large value. Instead reduce the size to calculate
> the last possible offset.
> 
> The error handling path incorrectly drops the reference to the user
> fence BO resulting in potential reference count underflow.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> (cherry picked from commit 35588314e963938dfdcdb792c9170108399377d6)
> ---
> 
> This is a backport of 35588314e963 ("drm/amdgpu: fix amdgpu_cs_p1_user_fence")
> to 6.5 and older stable kernels because the original patch does not apply
> cleanly as is.
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)

Now queued up, thanks.

greg k-h
