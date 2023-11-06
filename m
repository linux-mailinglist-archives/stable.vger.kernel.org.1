Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1257E2005
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 12:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjKFLaQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 06:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFLaQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 06:30:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF975BB
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 03:30:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22329C433C7;
        Mon,  6 Nov 2023 11:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699270213;
        bh=Mx6qhRdw/Aw2a2q4h2EM1H0s17mIdJfguU6q2EsYv2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oTB9PGoEnTaINwX23UUdSAFsRTwwv9o6gmMij6qrnNGUuKNgvRag3MGZNX5MlP6t7
         RkQVm63CTbnpkklrtKps38BrAFxTKMGVBc18cKzi2CaKv0KkCLgcpt6vpoK4aJXIY7
         OTUCsB70w4gFK4C2xKI+83sQ/OokobwF3E4X2suU=
Date:   Mon, 6 Nov 2023 12:30:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 5.15 v2 1/2] drm/amd: Move helper for dynamic speed
 switch check out of smu13
Message-ID: <2023110658-wrangle-pancreas-de47@gregkh>
References: <20231031160451.5429-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031160451.5429-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 31, 2023 at 11:04:50AM -0500, Mario Limonciello wrote:
> This helper is used for checking if the connected host supports
> the feature, it can be moved into generic code to be used by other
> smu implementations as well.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Evan Quan <evan.quan@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit 188623076d0f1a500583d392b6187056bf7cc71a)
> 
> The original problematic dGPU is not supported in 5.15.
> 
> Just introduce new function for 5.15 as a dependency for fixing
> unrelated dGPU that uses this symbol as well.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Both now queued up, thanks.

greg k-h
