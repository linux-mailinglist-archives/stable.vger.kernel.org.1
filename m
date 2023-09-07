Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B18797814
	for <lists+stable@lfdr.de>; Thu,  7 Sep 2023 18:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjIGQlc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 7 Sep 2023 12:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239587AbjIGQlX (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 7 Sep 2023 12:41:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1613C18
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 09:16:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329B9C116C9;
        Thu,  7 Sep 2023 11:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694085806;
        bh=4PQ0r6Whs3/u2D1exHcbwHc/kzs9rZhXXMiso1efvbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ksrmbNSGbGBhhNyTc+AzehnfRCTpmcXTJlHmQmcE1hPqvYE3dJjANmcAdOjHSw03m
         AXKhExpXGZFS3DFjoYo9QGzZzgpoMi4MbQF8FlkYkiGX2GaQZGBhJ/z7EY9vlFzT08
         40gcfRKl8kwZsbgnGg5eoNOSI87+EKAtikEqJ2ZM=
Date:   Thu, 7 Sep 2023 12:23:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Will Deacon <will@kernel.org>
Cc:     stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Joey Gouly <joey.gouly@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        John Hsu <John.Hsu@mediatek.com>
Subject: Re: [STABLE PATCH 5.15.y] arm64: lib: Import latest version of Arm
 Optimized Routines' strncmp
Message-ID: <2023090716-extenuate-jittery-25bd@gregkh>
References: <20230906180336.4973-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906180336.4973-1-will@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 06, 2023 at 07:03:36PM +0100, Will Deacon wrote:
> From: Joey Gouly <joey.gouly@arm.com>
> 
> commit 387d828adffcf1eb949f3141079c479793c59aac upstream.
> 
> Import the latest version of the Arm Optimized Routines strncmp function based
> on the upstream code of string/aarch64/strncmp.S at commit 189dfefe37d5 from:
>   https://github.com/ARM-software/optimized-routines
> 
> This latest version includes MTE support.
> 
> Note that for simplicity Arm have chosen to contribute this code to Linux under
> GPLv2 rather than the original MIT OR Apache-2.0 WITH LLVM-exception license.
> Arm is the sole copyright holder for this code.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Link: https://lore.kernel.org/r/20220301101435.19327-3-joey.gouly@arm.com
> (cherry picked from commit 387d828adffcf1eb949f3141079c479793c59aac)
> Cc: <stable@vger.kernel.org> # 5.15.y only
> Fixes: 020b199bc70d ("arm64: Import latest version of Cortex Strings' strncmp")
> Reported-by: John Hsu <John.Hsu@mediatek.com>
> Link: https://lore.kernel.org/all/e9f30f7d5b7d72a3521da31ab2002b49a26f542e.camel@mediatek.com/
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
> 
> This is a clean cherry-pick of the latest MTE-safe strncmp()
> implementation for arm64 which landed in v5.18 and somewhat accidentally
> fixed an out-of-bounds read introduced in v5.14.
> An alternative would be to disable the optimised code altogether, but
> given that this is self-contained and applies cleanly, I'd favour being
> consistent with more recent kernels.
> 
>  arch/arm64/lib/strncmp.S | 244 +++++++++++++++++++++++----------------
>  1 file changed, 146 insertions(+), 98 deletions(-)

Now queued up, thanks.

greg k-h
