Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC82775620
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 11:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjHIJHr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 05:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjHIJHq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 05:07:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552D51BD9
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 02:07:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E842B6307D
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 09:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E74EC433C8;
        Wed,  9 Aug 2023 09:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691572065;
        bh=3YU0iEyzKdvhUIE3UCOAD5CZpwKhDxR+e6WQeekyLv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I7z5DAssWTsYT6y2YBPn7jEqWUDca+1cKYmFdwe0jKIRuPmFk4k/Ne7IepG/3KOYY
         eN8xZ7tgnCuC+wPY04CA6GCbHch4JBeAI185hqI71B/Zgeg6jfPfiLdbhGicdcPMpY
         fsC1MY77/sm123TR3LWsaW3o8PfFmdNi6h+bjogc=
Date:   Wed, 9 Aug 2023 11:07:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 6.1.y] arm64/ptrace: Don't enable SVE when setting
 streaming SVE
Message-ID: <2023080934-doorstep-afraid-cb52@gregkh>
References: <2023080713-schedule-tuition-b3a5@gregkh>
 <20230807195634.309031-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807195634.309031-1-broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Aug 07, 2023 at 08:56:33PM +0100, Mark Brown wrote:
> Systems which implement SME without also implementing SVE are
> architecturally valid but were not initially supported by the kernel,
> unfortunately we missed one issue in the ptrace code.
> 
> The SVE register setting code is shared between SVE and streaming mode
> SVE. When we set full SVE register state we currently enable TIF_SVE
> unconditionally, in the case where streaming SVE is being configured on a
> system that supports vanilla SVE this is not an issue since we always
> initialise enough state for both vector lengths but on a system which only
> support SME it will result in us attempting to restore the SVE vector
> length after having set streaming SVE registers.
> 
> Fix this by making the enabling of SVE conditional on setting SVE vector
> state. If we set streaming SVE state and SVE was not already enabled this
> will result in a SVE access trap on next use of normal SVE, this will cause
> us to flush our register state but this is fine since the only way to
> trigger a SVE access trap would be to exit streaming mode which will cause
> the in register state to be flushed anyway.
> 
> Fixes: e12310a0d30f ("arm64/sme: Implement ptrace support for streaming mode SVE registers")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20230803-arm64-fix-ptrace-ssve-no-sve-v1-1-49df214bfb3e@kernel.org
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> (cherry picked from commit 045aecdfcb2e060db142d83a0f4082380c465d2c)
> [Fix up backport -- broonie]
> Signed-off-by: Mark Brown <broonie@kernel.org>

Now queued up, thanks.

greg k-h
