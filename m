Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357B17429AB
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 17:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjF2P3W (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 11:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjF2P3T (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 11:29:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A4B30F0
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 08:29:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2BB761575
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 15:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75670C433C8;
        Thu, 29 Jun 2023 15:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688052547;
        bh=2Uvy2UbuCzcaUp0rfvGnKqPN5KswhX7RTrKtXr0QeSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lRBOaZxC/P8oenpZWxqXxGrwblCUGqMd0B2355gGdCqUPNZFh/dml61fweJFkILEz
         3IIbDaxrCraCd/LOX3w/pyAYCktDnkpchMbVySl+Q9cU3jD0uEEngWsLoweSBhP1UL
         S9nasbQKhKHSL6sySLfQEfnYRWHXS4CuqrwSU/1w=
Date:   Thu, 29 Jun 2023 17:29:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Helge Deller <deller@gmx.de>
Cc:     stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH][for-4.14] fbdev: imsttfb: Fix use after free bug in
 imsttfb_probe
Message-ID: <2023062948-deface-banker-462d@gregkh>
References: <ZJ2ZFfH6qos5MFjm@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJ2ZFfH6qos5MFjm@p100>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 29, 2023 at 04:45:41PM +0200, Helge Deller wrote:
> Hi Greg,
> 
> below is the manual backport of an upstream patch to fix the build failure
> in kernel v4.14 in imsttfb.c.
> 
> It's not sufficient to just return from init_imstt() as the kernel then
> may crash later when it tries to access the non-existent framebuffer or
> cmap. Instead return failure to imsttfb_probe() so that the kernel
> will skip using that hardware/driver.
> 
> Can you please apply this patch to the v4.14 stable queue?

Now queued up, thanks!

greg k-h
