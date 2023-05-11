Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384696FFD68
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 01:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239514AbjEKXj2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 11 May 2023 19:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbjEKXj1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 11 May 2023 19:39:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6C1B3
        for <stable@vger.kernel.org>; Thu, 11 May 2023 16:39:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A0C9652A4
        for <stable@vger.kernel.org>; Thu, 11 May 2023 23:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB4FC433EF;
        Thu, 11 May 2023 23:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683848365;
        bh=Gv5MfhydX+49jiZzdsRRXtDqpEBgMyuFb+CambfuEgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WlyBUMXJ5U8ucF0yUrps0uElu/wpeLWSctmlsnq2FA8UfHJnL6tHxG28AjI6/Ktyw
         DW38TJRoQRtmcizvqX/kU9Pc7ukF2OU096a7HJVcFN9uzLH54TMTP4qEHSqG7d438W
         OJuThv6BnUlBIOmBMb8Tko+Hzu5CmklK8t0L1L4WoScJ3GV9+Xli6myQsYHDkfx7Of
         LpLzhbBkhaGUVyywI5y6n1M+AiwtoGgP41b0mCwx5dHLgaVIKpgwdMRGHddyC+Em6h
         5UY41OOZPZDwRjZtoKWKyDTbGNdTlxtqRKdTvXfyl17udrLnuiuXMigLFzXZBJLBqT
         eJx4FvSUdCL9g==
Date:   Thu, 11 May 2023 19:39:25 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     stable@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        palmer@dabbelt.com, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 6.1 v1] RISC-V: fix lock splat in
 riscv_cpufeature_patch_func()
Message-ID: <ZF18raXiQKGbxl76@sashalap>
References: <20230509-suspend-labrador-3eb6f0a8ac77@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230509-suspend-labrador-3eb6f0a8ac77@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 09, 2023 at 10:36:42PM +0100, Conor Dooley wrote:
>From: Conor Dooley <conor.dooley@microchip.com>
>
>Guenter reported a lockdep splat that appears to have been present for a
>while in v6.1.y & the backports of the riscv_patch_in_stop_machine dance
>did nothing to help here, as the lock is not being taken when
>patch_text_nosync() is called in riscv_cpufeature_patch_func().
>Add the lock/unlock; elide the splat.

Is this not a problem upstream?

-- 
Thanks,
Sasha
