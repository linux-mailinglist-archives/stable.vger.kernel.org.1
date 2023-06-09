Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C0B7294DF
	for <lists+stable@lfdr.de>; Fri,  9 Jun 2023 11:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241417AbjFIJYJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 9 Jun 2023 05:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240457AbjFIJXn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Jun 2023 05:23:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014C849F0
        for <stable@vger.kernel.org>; Fri,  9 Jun 2023 02:17:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E23266555C
        for <stable@vger.kernel.org>; Fri,  9 Jun 2023 09:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF748C4339B;
        Fri,  9 Jun 2023 09:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686302226;
        bh=zBj/Rqxa8TfNWbnP5SpBj4X1VHnYklRkyyfhCezD3jc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l59uTn55mLSYDYSCiD+NSLeF0RZoBLOgv12cvsyZ7FHyxd/gsG/MnprtgzZ4r7vDa
         gEoIcwBl1kvBGtTZPWpfn1KJGt9crLOuh+y7o1jGw7qiIfYUeFp46oIqm1UEXIfef6
         fKN/eh5UW1Ndo/eNNZaRk1jPanqa+l9aOGjJfpk0=
Date:   Fri, 9 Jun 2023 11:17:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paul Barker <paul.barker@sancloud.com>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y 0/2] Backport GCC 13 fixes
Message-ID: <2023060903-pastel-aorta-4a99@gregkh>
References: <20230608213458.123923-1-paul.barker@sancloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608213458.123923-1-paul.barker@sancloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 08, 2023 at 10:34:56PM +0100, Paul Barker wrote:
> These two commits are required to build the linux-5.15.y branch
> successfully with GCC 13 in my testing. Both are backports from
> mainline, with a couple of tweaks to make them apply cleanly.
> 
> The result has been build tested against a few different gcc versions
> (9.5, 11.3 & 13.1) and defconfigs (x86_64_defconfig, i386_defconfig,
> ARM multi_v7_defconfig, ARM64 defconfig, RISCV defconfig,
> RISCV rv32_defconfig) via Yocto Project builds.

This is great, but I still can't build 'make allmodconfig' for 5.15 with
these patches, but the number of errors is much smaller now.  I'll work
to winnow them down to try to fix this so that I don't have to keep
older versions of gcc around on my test-build systems.

thanks,

greg k-h
