Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220267DCC2B
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 12:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344089AbjJaLxv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 07:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344103AbjJaLxt (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 07:53:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE51DB
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 04:53:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99203C433C7;
        Tue, 31 Oct 2023 11:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698753227;
        bh=IcYpxELlEsCRY/nFifH+3qrg4uIaZwP8SRdyz3S+JQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f8xFE3hFOwEi3V0k2fagXi7Lxj4HWoA0fDGSBLW2377WGPz239zrs/VBmxWr18SmJ
         1ua9ciMI7EQU6HXZCLOJ8OLlKPNpGcDxsQezYQf4o3hHz277prDiRnFip7GrjE9nsf
         neGKCqatXjB85SCvOj8wBiX9fuphghV93ZGIow0A=
Date:   Tue, 31 Oct 2023 12:53:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc:     stable@vger.kernel.org,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Karol Wachowski <karol.wachowski@linux.intel.com>
Subject: Re: [PATCH 6.5] accel/ivpu/37xx: Fix missing VPUIP interrupts
Message-ID: <2023103135-tattoo-feminize-9cff@gregkh>
References: <20231028175320.6791-1-stanislaw.gruszka@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028175320.6791-1-stanislaw.gruszka@linux.intel.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Oct 28, 2023 at 07:53:20PM +0200, Stanislaw Gruszka wrote:
> From: Karol Wachowski <karol.wachowski@linux.intel.com>
> 
> commit b132ac51d7a50c37683be56c96ff64f8c887930f upstream.
> 
> Move sequence of masking and unmasking global interrupts from buttress
> interrupt handler to generic one that handles both VPUIP and BTRS
> interrupts. Unmasking global interrupts will re-trigger MSI for any
> pending interrupts.
> 
> Lack of this sequence will cause the driver to miss any
> VPUIP interrupt that comes after reading VPU_37XX_HOST_SS_ICB_STATUS_0
> and before clearing all active interrupt sources.
> 
> Fixes: 35b137630f08 ("accel/ivpu: Introduce a new DRM driver for Intel VPU")
> Cc: stable@vger.kernel.org
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/20231024161952.759914-1-stanislaw.gruszka@linux.intel.com
> ---
>  drivers/accel/ivpu/ivpu_hw_mtl.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 

Now queued up, thanks.

greg k-h
