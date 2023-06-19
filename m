Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BC7734B9D
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 08:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjFSGOo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 02:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjFSGOi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 02:14:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F3D115
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 23:14:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F76161122
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 06:14:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2C4C433C0;
        Mon, 19 Jun 2023 06:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687155267;
        bh=pLpdWrNtxp49XvK0pNF2MVRq9wjxOQbKJ0Pu1Bis8WQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=on6+40TsGIsQMFyrghFRJA73OD8Yv26WwKHmbfotOJzxfYP3i11ZNVrCohzXrqOs+
         Qq5a0aUNc02pTYhCUgECXbZzNHjI7bORTmzB5YMrOgduagDQTLB5lCugVKBB9SjLp3
         0lkzgO/xWO4W0W1YpTlVni2zaXiiJfmwm0P8T94s=
Date:   Mon, 19 Jun 2023 08:14:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable <stable@vger.kernel.org>
Subject: Re: Build error in v4.19.y.queue (parisc)
Message-ID: <2023061914-plunging-certified-7780@gregkh>
References: <d76bca14-4d95-2d6d-f51a-7c6071dcbdbd@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d76bca14-4d95-2d6d-f51a-7c6071dcbdbd@roeck-us.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Jun 18, 2023 at 08:43:31AM -0700, Guenter Roeck wrote:
> Building parisc64:a500_defconfig ... failed
> --------------
> Error log:
> drivers/char/agp/parisc-agp.c: In function 'parisc_agp_tlbflush':
> drivers/char/agp/parisc-agp.c:98:9: error: implicit declaration of function 'asm_io_sync' [-Werror=implicit-function-declaration]
>    98 |         asm_io_sync();
>       |         ^~~~~~~~~~~
> drivers/char/agp/parisc-agp.c: In function 'parisc_agp_insert_memory':
> drivers/char/agp/parisc-agp.c:168:25: error: implicit declaration of function 'asm_io_fdc' [-Werror=implicit-function-declaration]
>   168 |                         asm_io_fdc(&info->gatt[j]);
>       |                         ^~~~~~~~~~
> 
> Those functions are indeed not available in v4.1.y.

Thanks, offending commit now dropped.

greg k-h
