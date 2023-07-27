Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A687651C6
	for <lists+stable@lfdr.de>; Thu, 27 Jul 2023 12:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjG0K6r (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Jul 2023 06:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjG0K6o (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Jul 2023 06:58:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFBE10D2
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 03:58:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 004C061E2B
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 10:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF70C433C7;
        Thu, 27 Jul 2023 10:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690455520;
        bh=RgL5gtrRvP/nr8iTczZXEXSK+SgBtMErrXOSVXAJhVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oReVT3bMdB2oDKZmalhjRrZlny5OxI9Y9vH/DIiBhubrg9EO5ncAPxmHitHYEb1b7
         ejUBAeVxmkLXOp/3Rb1aiUO8UI6mkLizKzfFkcMGJBuWv5SIXNEXGzRfsmu23cVw+A
         fUqIC9VHjewmpqSBorGsDHtsN+e5hZi/rH8zUobA=
Date:   Thu, 27 Jul 2023 12:58:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: 6.1 / 6.4 Dynamic speed switching backports
Message-ID: <2023072729-amusable-democrat-73b0@gregkh>
References: <1b5952d7-4421-597d-4f8c-74ce09f664cb@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b5952d7-4421-597d-4f8c-74ce09f664cb@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jul 25, 2023 at 09:49:13PM -0500, Mario Limonciello wrote:
> Hi,
> 
> A series landed in 6.5 that helps system hangs when AMD dGPUs are used in
> Intel hosts and the host advertises ASPM.
> 
> The whole series was CC stable 6.1+, but for some reason (unknown to me)
> these two commits in the series didn't apply to 6.1 and 6.4.
> 
> 188623076d0f ("drm/amd: Move helper for dynamic speed switch check out of
> smu13")
> e701156ccc6c ("drm/amd: Align SMU11 SMU_MSG_OverridePcieParameters
> implementation with SMU13")
> 
> The rest of the commits came back properly, and I double checked these were
> not in the queue and work when added into 6.4.6/6.1.41 so can you please
> bring them in to complete the stable backport?

All now queued up, thanks.

greg k-h
