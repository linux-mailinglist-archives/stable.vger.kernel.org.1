Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C84761084
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjGYKVr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjGYKVr (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:21:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A842410CB
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:21:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 447B0615FC
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:21:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BDDC433C9;
        Tue, 25 Jul 2023 10:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690280505;
        bh=5ZM/AI65T9Osu9OX3c3PwH7mxZcoiM3P67YwG9qaNsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ER8f3GRhjTwXVFS0DTN71sLY+Icob9WxdP8s14pAQ7FzxWa/hXDD2R1NlBOoh7Y02
         v356au8oNYg+xiY+9hiof/eCAp8E/b/bF1oMBPMT7bCesNWpD7SS1WHlvMNCZ7fA2y
         OupyF5f4okSBsutzwDEEtsqQI/DyHO1itwWG6LCA=
Date:   Tue, 25 Jul 2023 12:21:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Stable <stable@vger.kernel.org>
Subject: Re: Kernel 6.4.y stable backports for "drm/amd/display: Add polling
 method to handle MST reply packet"
Message-ID: <2023072531-everyday-residency-2b27@gregkh>
References: <4eac08e2-2a13-1e13-536d-a8a7949796ff@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eac08e2-2a13-1e13-536d-a8a7949796ff@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jul 24, 2023 at 02:59:09PM -0500, Limonciello, Mario wrote:
> Hi,
> 
> The patch "4f6d9e38c4d2 ("drm/amd/display: Add polling method to handle MST
> reply packet")" was tagged for stable, but it failed to apply to both 6.4.y
> and 6.1.y.
> 
> The 6.4.y backport is missing a dependency.  So to fix this can you please
> apply:
> 
> 87279fdf5ee0 ("drm/amd/display: Clean up errors & warnings in amdgpu_dm.c")
> 4f6d9e38c4d2 ("drm/amd/display: Add polling method to handle MST reply
> packet")

Now queued up, thanks.

greg k-h
