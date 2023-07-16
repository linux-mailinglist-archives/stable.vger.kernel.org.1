Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D48F754F09
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 16:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjGPOg3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 10:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGPOg2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 10:36:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2701FE66
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 07:36:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFA0C60C90
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 14:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B847AC433C8;
        Sun, 16 Jul 2023 14:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689518187;
        bh=kN1BusoXm4sbmfRwMFsiw7nfSxlOatfA/VwSoEFdJIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=btgJVYagHyBp0ODen4Um4iEv5wPHkQp+S+zuhlpD5ewoNQc4InJzSQZDEkeSby2BH
         TC2AJttWaFWxnW4AN1SZ5ieOoxhScu+sM6ga8akP519GWH0V1Nv2Lpc08J0W6vdEGr
         nCfaHAdrxJeK2V6m3HtsPJgQzaR4TitbvXvp36DY=
Date:   Sun, 16 Jul 2023 16:36:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chris Paterson <Chris.Paterson2@renesas.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: 4.14.321-rc1 build error
Message-ID: <2023071616-overture-flatbed-28e0@gregkh>
References: <TY2PR01MB37883616B104E56A1DDCA286B737A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY2PR01MB37883616B104E56A1DDCA286B737A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jul 13, 2023 at 08:15:11AM +0000, Chris Paterson wrote:
> Hello Greg,
> 
> I know you haven't formally released 4.14.321-rc1 for review yet, but our CI picked up a build issue so I thought I may as well report it in case it's useful information for you.
> 
> SHA: Linux 4.14.321-rc1 (bc1094b21392)
> Failed build log: https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/4635722359
> defconfig used: https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/master/4.14.y/arm/moxa_mxc_defconfig
> 
> Error log:
> /builds/cip-project/cip-testing/linux-stable-rc-ci/gcc/gcc-11.1.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-ld: arch/arm/probes/kprobes/core.o: in function `jprobe_return':
> /builds/cip-project/cip-testing/linux-stable-rc-ci/arch/arm/probes/kprobes/core.c:555: undefined reference to `kprobe_handler'
> Makefile:1049: recipe for target 'vmlinux' failed
> make: *** [vmlinux] Error 1
> 
> Problem patch:
> Reverting 1c18f6ba04d8 ("ARM: 9303/1: kprobes: avoid missing-declaration warnings") makes the problem go away.

SHould now be fixed, thanks.

greg k-h
