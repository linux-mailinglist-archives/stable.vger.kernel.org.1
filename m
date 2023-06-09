Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11470729539
	for <lists+stable@lfdr.de>; Fri,  9 Jun 2023 11:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240924AbjFIJcG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 9 Jun 2023 05:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241283AbjFIJbx (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Jun 2023 05:31:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9216588
        for <stable@vger.kernel.org>; Fri,  9 Jun 2023 02:26:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F91B655C5
        for <stable@vger.kernel.org>; Fri,  9 Jun 2023 09:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CECC433D2;
        Fri,  9 Jun 2023 09:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686302795;
        bh=Dm4N5lx1Zr5YktopIxebSxu4UMy0K2avASVT3hL/RQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=goDHTPNQlzFazIjcDdNH0VW6mV+PwOG6x3nLzhviNwwpl/2El+V6ADgBhxYl8KIM1
         W5ErWBg/O7PIHYarPuSx3te049la4QLR3pzlBgsB+syYyVEA9aXD90SMmkqjOqSrK5
         vlXxU3JkGavO6Age1h7RmNm5wvizBcHClrAfKJ50=
Date:   Fri, 9 Jun 2023 11:26:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paul Barker <paul.barker@sancloud.com>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 5.10.y 0/2] Backport GCC 13 fixes
Message-ID: <2023060908-numbly-desolate-6782@gregkh>
References: <20230608221335.124520-1-paul.barker@sancloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608221335.124520-1-paul.barker@sancloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 08, 2023 at 11:13:33PM +0100, Paul Barker wrote:
> These two commits are required to build the linux-5.10.y branch
> successfully with GCC 13 in my testing. Both are backports from
> mainline, with a couple of tweaks to make them apply cleanly.
> 
> The result has been build tested against a few different gcc versions
> (9.5, 11.3 & 13.1) and defconfigs (x86_64_defconfig, i386_defconfig,
> ARM multi_v7_defconfig, ARM64 defconfig, RISCV defconfig,
> RISCV rv32_defconfig) via Yocto Project builds.

Nice, with these I can build 5.10.y with gcc13 now (unlike 5.15.y, which
is odd.)

thanks for the patches, all now queued up.

greg k-h
