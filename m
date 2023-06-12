Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9F372BCC5
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 11:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjFLJd0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 05:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjFLJbp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 05:31:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58525420F
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 02:25:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E98A062239
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 09:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E81C433A1;
        Mon, 12 Jun 2023 09:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686561922;
        bh=l8b/Dn/3G4Jn87eVPRfG9/pWmTwUtEFyc1KH6XTeq9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OFkGYFuF4XBGukoptr8VpHocYeNm2ehSoIBmX6omd+KjAmYIMNUHLAP7HemRrTkYj
         7UHxBAwXZwxNyj73pNfzR2RTwWwwcbKYeDkWv/0U4kKkXvDMCL46xt7mvPqUoKA459
         DStbOpaK2cbCY81eITppLdDGPRTYi+cz7HyPxsoc=
Date:   Mon, 12 Jun 2023 11:25:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, Rui Wang <wangrui@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 5.10.y] MIPS: locking/atomic: Fix
 atomic{_64,}_sub_if_positive
Message-ID: <2023061213-hatchet-error-d5b0@gregkh>
References: <20230610190019.2807608-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230610190019.2807608-1-linux@roeck-us.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Jun 10, 2023 at 12:00:19PM -0700, Guenter Roeck wrote:
> From: Rui Wang <wangrui@loongson.cn>
> 
> commit cb95ea79b3fc772c5873a7a4532ab4c14a455da2 upstream.
> 
> This looks like a typo and that caused atomic64 test failed.
> 
> Signed-off-by: Rui Wang <wangrui@loongson.cn>
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> I recently enabled atomic CONFIG_ATOMIC64_SELFTEST, which results in
> a crash when testing 64-bit little endian mips images in v5.10.y.
> This patch fixes the problem.
> 
>  arch/mips/include/asm/atomic.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Now queued up, thanks.

greg k-h
