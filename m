Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC80734C78
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 09:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjFSHlZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 03:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjFSHlY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 03:41:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2E21BE
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 00:41:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB8016152D
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 07:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2009C433C0;
        Mon, 19 Jun 2023 07:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687160482;
        bh=mqkt45oM5MguNfYHmjfenwAmA+zrtI7uUVBleNRwRGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eZpETtsWpc/RVQD+RTM7ElnmWPRWuW4NFtP3S4eaHTleF43KUpbaxvJ1OFZH7U0ii
         NJYV6Fh7Pqi3E/5EXWTFxBVFtBXD3KFeLlLDy4HCEFVtdwJmGWln7kIIpd4DcUjiMf
         VVTYjurtD1sBAmqFJih6XJkVaTCzoFwlyGlZBnr8=
Date:   Mon, 19 Jun 2023 09:41:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alyssa Ross <hi@alyssa.is>
Cc:     stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 4.14.y] powerpc: Fix defconfig choice logic when cross
 compiling
Message-ID: <2023061909-armhole-jelly-a6de@gregkh>
References: <20230614142300.1292641-1-hi@alyssa.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614142300.1292641-1-hi@alyssa.is>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jun 14, 2023 at 02:23:01PM +0000, Alyssa Ross wrote:
> From: Michael Ellerman <mpe@ellerman.id.au>
> 
> Our logic for choosing defconfig doesn't work well in some situations.
> 
> For example if you're on a ppc64le machine but you specify a non-empty
> CROSS_COMPILE, in order to use a non-default toolchain, then defconfig
> will give you ppc64_defconfig (big endian):
> 
>   $ make CROSS_COMPILE=~/toolchains/gcc-8/bin/powerpc-linux- defconfig
>   *** Default configuration is based on 'ppc64_defconfig'
> 
> This is because we assume that CROSS_COMPILE being set means we
> can't be on a ppc machine and rather than checking we just default to
> ppc64_defconfig.
> 
> We should just ignore CROSS_COMPILE, instead check the machine with
> uname and if it's one of ppc, ppc64 or ppc64le then use that
> defconfig. If it's none of those then we fall back to ppc64_defconfig.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> (cherry picked from commit af5cd05de5dd38cf25d14ea4d30ae9b791d2420b)
> Signed-off-by: Alyssa Ross <hi@alyssa.is>
> ---
>  arch/powerpc/Makefile | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 9c78ef298257..cbc7c05a6165 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -29,11 +29,10 @@ endif
>  
>  export CROSS32CC CROSS32AR
>  
> -ifeq ($(CROSS_COMPILE),)
> -KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
> -else
> -KBUILD_DEFCONFIG := ppc64_defconfig
> -endif
> +# If we're on a ppc/ppc64/ppc64le machine use that defconfig, otherwise just use
> +# ppc64_defconfig because we have nothing better to go on.
> +uname := $(shell uname -m)
> +KBUILD_DEFCONFIG := $(if $(filter ppc%,$(uname)),$(uname),ppc64)_defconfig
>  
>  ifeq ($(CONFIG_PPC64),y)
>  new_nm := $(shell if $(NM) --help 2>&1 | grep -- '--synthetic' > /dev/null; then echo y; else echo n; fi)
> 
> base-commit: 1914956342c8cf52a377aecc4944e63f9229cb9b

Both now queued up, thanks.

greg k-h
