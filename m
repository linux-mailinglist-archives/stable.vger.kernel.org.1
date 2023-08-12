Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F2E779D73
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 08:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjHLGBN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 02:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbjHLGBM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 02:01:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CA02D44
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 23:01:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E4ED6424A
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 06:01:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735BEC433C8;
        Sat, 12 Aug 2023 06:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691820070;
        bh=ZcDOCVYHuKnNJg23bk93W+OEAJjw1vc4qXQlPr8PTSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O9tduuzCqOss7J58tvdGiSbRhr8n1pJoHL28aYqFZEcj2onN2GIrsZSAMKPS8egJH
         FDskXF95OmWrOZtw/I+GMvsPUC3qVFRkGO99PxfDR/UilZSex8+taQTTjSjhrm0bRh
         09aHpPUXD0Qmh5syEXHxeLFFnvDUmBaGzJPoksvY=
Date:   Sat, 12 Aug 2023 08:01:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org, Peichen Huang <peichen.huang@amd.com>
Subject: Re: [PATCH 6.1.y] drm/amd/display: limit DPIA link rate to HBR3
Message-ID: <2023081249-uninstall-pamperer-33a3@gregkh>
References: <20230807140047.9410-1-mario.limonciello@amd.com>
 <2023080911-shortage-slicing-6ef8@gregkh>
 <c85fa930-65e8-47e2-ade6-001566fe9f88@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c85fa930-65e8-47e2-ade6-001566fe9f88@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Aug 09, 2023 at 06:18:23AM -0500, Mario Limonciello wrote:
> On 8/9/23 04:05, Greg KH wrote:
> > On Mon, Aug 07, 2023 at 09:00:47AM -0500, Mario Limonciello wrote:
> > > From: Peichen Huang <peichen.huang@amd.com>
> > > 
> > > [Why]
> > > DPIA doesn't support UHBR, driver should not enable UHBR
> > > for dp tunneling
> > > 
> > > [How]
> > > limit DPIA link rate to HBR3
> > > 
> > > Cc: Mario Limonciello <mario.limonciello@amd.com>
> > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: stable@vger.kernel.org
> > > Acked-by: Stylon Wang <stylon.wang@amd.com>
> > > Signed-off-by: Peichen Huang <peichen.huang@amd.com>
> > > Reviewed-by: Mustapha Ghaddar <Mustapha.Ghaddar@amd.com>
> > > Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > (cherry picked from commit 0e69ef6ea82e8eece7d2b2b45a0da9670eaaefff)
> > > This was CC to stable, but failed to apply because the file was
> > > renamed in 6.3-rc1 as part of
> > > 54618888d1ea ("drm/amd/display: break down dc_link.c")
> > 
> > It also is not in 6.4.y, why not?  I can't take it for 6.1.y only,
> > otherwise people will have a regression when they move to a new kernel.
> > 
> > thanks,
> > 
> > greg k-h
> 
> This is one of those cases that the same commit landed in the tree twice as
> two hashes.
> 
> Here's the 6.4 hash (which is identical):
> 
> $ git describe --contains 7c5835bcb9176df94683396f1c0e5df6bf5094b3
> v6.4-rc7~9^2~2^2

Ah, what a mess, the drm tree never ceases to amaze me...

now queued up, thanks.

greg k-h
