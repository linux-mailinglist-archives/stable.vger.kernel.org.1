Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3437C9A6B
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 19:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjJORrR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 13:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJORrQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 13:47:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C0CAB
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 10:47:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A88FC433C7;
        Sun, 15 Oct 2023 17:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697392033;
        bh=2/J+LXjXoAcM4p6m6B57DsAvax45nPxRxE/2KozG+SE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XflcxxK9CByimEzy8jh19YQ48mQohXN0/HeC0pArWTfIJrBehHwmmky0c1L/EbRaL
         PM1oDYDGu/7PuWMKr/cU5aFd3IZAsQ1Ej6o3gGMc8lN1Hu6/Wj/ZOVe+LXwv7Iyabb
         stGN71WcXB17664K+ghR4z8O4NF6f3s1gxnyFI+A=
Date:   Sun, 15 Oct 2023 19:47:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aurelien Jarno <aurelien@aurel32.net>
Cc:     stable@vger.kernel.org, palmer@dabbelt.com,
        Andy Chiu <andy.chiu@sifive.com>
Subject: Re: [PATCH] riscv: signal: fix sigaltstack frame size checking
Message-ID: <2023101500-perm-barbed-0248@gregkh>
References: <20230822164904.21660-1-andy.chiu@sifive.com>
 <ZSvEYJfg2HksQhaW@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSvEYJfg2HksQhaW@aurel32.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Oct 15, 2023 at 12:52:16PM +0200, Aurelien Jarno wrote:
> Hi,
> 
> The patch below is an important fix, as it is necessary to run rustc on riscv.
> It has been merged as commit 14a270bfab7ab1c4b605c01eeca5557447ad5a2b. I have
> seen that other commits from the same pull request have already been queued for
> 6.5, but not this one. Would it be possible to queue it for stable 6.5?

Now queued up, thanks.

greg k-h
