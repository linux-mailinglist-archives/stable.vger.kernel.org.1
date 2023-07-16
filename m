Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E97754F32
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 17:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjGPPIC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 11:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGPPIC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 11:08:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F41C9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 08:08:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91D1B6027E
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 15:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D9DC433C8;
        Sun, 16 Jul 2023 15:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689520080;
        bh=SQ7QeJWh6mrUS2cUGMfaU0vN4NdQUryuMpjX1bjcPXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hwhFTmfVLJrSOfhbw6nq5p6vCwN8x7x1uwgftU6qkpYjlVuXDbYuDYAcprFFJX1s3
         HVA3pMwpaIcD6imZRYNn0NRVIAqXbsZo+NdIU2MzcI/8NKYj88zEt3XaJ1wnh+48gu
         H/9AqplasGpq2Tsj/E2Xb+pCvPdWFPxU1YFBWFBc=
Date:   Sun, 16 Jul 2023 17:07:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Imre Deak <imre.deak@intel.com>
Cc:     stable@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 0/1] v6.1 stable backport request
Message-ID: <2023071610-coronary-parted-0250@gregkh>
References: <20230710141359.754365-1-imre.deak@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710141359.754365-1-imre.deak@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jul 10, 2023 at 05:13:58PM +0300, Imre Deak wrote:
> Stable team, please apply patch 1/1 in this patchset along with its
> dependencies to the v6.1 stable tree. The patch required a trivial
> rebase adding a header include, hence resending it, while its 2
> dependencies listed at Cc: stable lines in the commit message can be
> cherry-picked as-is.
> 
> Thanks,
> Imre
> 
> Imre Deak (1):
>   drm/i915/tc: Fix system resume MST mode restore for DP-alt sinks
> 
>  .../drm/i915/display/intel_display_types.h    |  1 +
>  drivers/gpu/drm/i915/display/intel_tc.c       | 51 +++++++++++++++++--
>  2 files changed, 48 insertions(+), 4 deletions(-)

All now queued up, thanks.

greg k-h
