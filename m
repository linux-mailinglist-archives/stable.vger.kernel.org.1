Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F697779E86
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 11:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbjHLJXA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 05:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjHLJW7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 05:22:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7154ADA
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 02:23:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 065E96135D
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 09:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161E2C433C9;
        Sat, 12 Aug 2023 09:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691832182;
        bh=WsdXb797bM6mBvFPKdq8lOXkJ7KyxJ9OeHNuiufSTLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PIQLa/Y9bbZY6amiaa3x0vPP0xmqXaIu+LwlvAU5ECL6UeiZvIUZbcvdO2YWf3YFy
         7fBbi+3J90txY1mN6W8vdwUSEBmSHk32W69Kigs2afUsY7TwVTCYZvuPMcKzSR1a57
         bwdcjje66FTGva/z+UTzEahzsRjf2aauGLtHsh0Q=
Date:   Sat, 12 Aug 2023 11:22:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org, Tianci.Yin@amd.com, Richard.Gong@amd.com,
        Aurabindo.Pillai@amd.com
Subject: Re: [PATCH 6.1.y 00/10] Fixups for some navi3x hangs
Message-ID: <2023081247-applicant-eggbeater-744d@gregkh>
References: <20230811210708.14512-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811210708.14512-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Aug 11, 2023 at 04:06:58PM -0500, Mario Limonciello wrote:
> Hi,
> 
> Rico tried to send out some fixups recently for some navi3x hangs, but
> made some process mistakes with the series.  It's an important series
> as it has a variety of people indicating problems, even as recently as
> 6.1.45 that it confirms to fix.
> 
> Some of Rico's selected patches were already merged, so they're dropped
> from the series.
> 
> Link: https://lore.kernel.org/stable/20230807022055.2798020-1-tianci.yin@amd.com/
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2760
> 
> Thanks!

Now queued up, thanks.

greg k-h
