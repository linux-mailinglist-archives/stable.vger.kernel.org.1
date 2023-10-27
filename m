Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471537D97C2
	for <lists+stable@lfdr.de>; Fri, 27 Oct 2023 14:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjJ0MU2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 08:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjJ0MU1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 08:20:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4872121
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 05:20:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B4CC433C7;
        Fri, 27 Oct 2023 12:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698409225;
        bh=zx93QDZrVw/BB4U92kYTb2WBHaOHHlzDEZ/hBUM/w28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CexU+1/XRTP3Hkpw/IOXvsTUMevbV00E7HM47uBprs/Rh6WMJCh2T8StHlkU358T6
         QIrYn/0bPP5dYTHK1+o+KSY5GdyGqdpvZjHyUfOuPSl5tDCriQfXci3Gjx4nU+ciFf
         LM1arxtUYYquA46B/aCrrsHxXhtGQeSBOWNPNKoc=
Date:   Fri, 27 Oct 2023 14:20:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc:     stable@vger.kernel.org,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: Re: [PATCH 6.5] accel/ivpu: Don't enter d0i3 during FLR
Message-ID: <2023102712-domestic-finch-3f70@gregkh>
References: <20231024061827.62996-1-stanislaw.gruszka@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024061827.62996-1-stanislaw.gruszka@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 24, 2023 at 08:18:27AM +0200, Stanislaw Gruszka wrote:
> commit 828d63042aeca132a93938b98dc7f1a6c97bbc51 upstream.
> 
> Avoid HW bug on some platforms where we enter D0i3 state
> and CPU is in low power states (C8 or above).
> 
> Fixes: 852be13f3bd3 ("accel/ivpu: Add PM support")
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/20231003064213.1527327-1-stanislaw.gruszka@linux.intel.com
> -
> ---
>  drivers/accel/ivpu/ivpu_drv.c    | 11 ++++++++---
>  drivers/accel/ivpu/ivpu_drv.h    |  1 +
>  drivers/accel/ivpu/ivpu_hw.h     |  8 ++++++++
>  drivers/accel/ivpu/ivpu_hw_mtl.c |  1 +
>  drivers/accel/ivpu/ivpu_pm.c     |  3 ++-
>  5 files changed, 20 insertions(+), 4 deletions(-)

Now queued up, thanks.

greg k-h
