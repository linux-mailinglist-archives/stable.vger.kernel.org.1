Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F09782E8F
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 18:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbjHUQj4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 12:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236676AbjHUQjz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 12:39:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EB9101
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 09:39:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D567063E71
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 16:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDD6C433C7;
        Mon, 21 Aug 2023 16:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692635993;
        bh=sqOgFLvNGSR7iSRCkD/iDunBAnMl6t2cV1U9jmdsebI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lfd60vWwJYj9fYt4EV5KrdAlVWNebdOnn9B2WYHxbwTeNQi+GkA4BT5kjCSZyUjSO
         tl1SfHm45ePlYQrS5WAoYK40pSwyAhhj6OvyBkN8nCqrLnWet4gSxOIgavPwa9/Kd2
         O6ZdFJm1oEFaZQdt9zZfqsV8p5JMWFlO9RRmpTpQ=
Date:   Mon, 21 Aug 2023 18:39:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     stable@vger.kernel.org, David Spickett <David.Spickett@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 6.1.y] arm64/ptrace: Ensure that SME is set up for target
 when writing SSVE state
Message-ID: <2023082140-frisbee-flatterer-fd6e@gregkh>
References: <2023082121-chewing-regroup-4f67@gregkh>
 <20230821135834.216609-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821135834.216609-1-broonie@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Aug 21, 2023 at 02:58:33PM +0100, Mark Brown wrote:
> When we use NT_ARM_SSVE to either enable streaming mode or change the
> vector length for a process we do not currently do anything to ensure that
> there is storage allocated for the SME specific register state.  If the
> task had not previously used SME or we changed the vector length then
> the task will not have had TIF_SME set or backing storage for ZA/ZT
> allocated, resulting in inconsistent register sizes when saving state
> and spurious traps which flush the newly set register state.
> 
> We should set TIF_SME to disable traps and ensure that storage is
> allocated for ZA and ZT if it is not already allocated.  This requires
> modifying sme_alloc() to make the flush of any existing register state
> optional so we don't disturb existing state for ZA and ZT.
> 
> Fixes: e12310a0d30f ("arm64/sme: Implement ptrace support for streaming mode SVE registers")
> Reported-by: David Spickett <David.Spickett@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: <stable@vger.kernel.org> # 5.19.x
> Link: https://lore.kernel.org/r/20230810-arm64-fix-ptrace-race-v1-1-a5361fad2bd6@kernel.org
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> (cherry picked from commit 5d0a8d2fba50e9c07cde4aad7fba28c008b07a5b)
> Signed-off-by: Mark Brown <broonie@kernel.org>

Thanks, now queued up.

greg k-h
