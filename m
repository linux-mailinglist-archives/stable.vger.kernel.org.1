Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9B47DCF09
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 15:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjJaOK5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 10:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbjJaOKu (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 10:10:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3B6F3
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 07:10:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBF5C433C9;
        Tue, 31 Oct 2023 14:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698761447;
        bh=ffigHGoqU2GYHDpANVGR/CjuI7UEJO1iQTJ3jBF2oaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yeXqwIZ35g/o9xifVARV7IYU5Wb1Zn+jzO+zpdPDViYTyRa2IZ9Igk6zrTymKazqf
         uVrjNivNxSC6g7EmC7CUFHhxqPEjt49MCo2skn1ziQttkF+cDACvCtRviVKIzlRenA
         EXvg0RiEezY5jPdg0nwvYJAFqA4BKRA/y2Qb30VI=
Date:   Tue, 31 Oct 2023 15:10:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 5.15 1/2] drm/amd: Move helper for dynamic speed switch
 check out of smu13
Message-ID: <2023103133-wanting-appraiser-7846@gregkh>
References: <20231027083958.38445-1-mario.limonciello@amd.com>
 <2023103102-antihero-gumming-5788@gregkh>
 <571daf65-0f07-4b45-acbb-0613d724c742@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <571daf65-0f07-4b45-acbb-0613d724c742@amd.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 31, 2023 at 08:44:42AM -0500, Mario Limonciello wrote:
> On 10/31/2023 06:50, Greg KH wrote:
> > On Fri, Oct 27, 2023 at 03:39:57AM -0500, Mario Limonciello wrote:
> > > This helper is used for checking if the connected host supports
> > > the feature, it can be moved into generic code to be used by other
> > > smu implementations as well.
> > > 
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > Reviewed-by: Evan Quan <evan.quan@amd.com>
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > (cherry picked from commit 5d1eb4c4c872b55664f5754cc16827beff8630a7)
> > > 
> > > The original problematic dGPU is not supported in 5.15.
> > > 
> > > Just introduce new function for 5.15 as a dependency for fixing
> > > unrelated dGPU that uses this symbol as well.
> > > 
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 +++++++++++++++++++
> > >   2 files changed, 20 insertions(+)
> > 
> > What about 6.5 and 6.1 for this commit?  We can't have someone upgrade
> > and have a regression, right?
> > 
> > thanks
> > 
> > greg k-h
> 
> Kernel 6.5-rc2 introduced this commit.
> 
> Kernel 6.1.y already has this commit.  Here's the hash:
> 
> 32631ac27c91 ("drm/amd: Move helper for dynamic speed switch check out of
> smu13")

Then the commit listed above is wrong in the patch, please fix up and
resend the series with the correct id.

Yet-another-problem due to the drm layer having duplicate commits in
their trees, sorry, you all did it to yourself...

greg k-h
