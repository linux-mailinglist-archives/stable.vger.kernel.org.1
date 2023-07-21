Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27DA75BD29
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 06:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjGUEN6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 00:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjGUEN4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 00:13:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6E8272C
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 21:13:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFB5F61040
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 04:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A93C433C8;
        Fri, 21 Jul 2023 04:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689912833;
        bh=2SBM4aNk51G/53dXx+bgk61fRXC75VS4DpSg4PoU1hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O5dRO2+HT/pVnoDZXAPU4xhbDPvG+Sehy1CS13IiYDTx8RkHd6+5/2T3qOCZjakjq
         Wq0lAmbl7ofE5ZGF95nXIF0jLT9TRvrY+/wLWvIACKSN6vec0FEkkqnnYNG69hH+7L
         g2xT0FXaUoOjap40oQAvQ2/OoXj44o/1y07BqIQs=
Date:   Fri, 21 Jul 2023 06:13:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: linux-stable regression: please backport 8ae071fc216a
Message-ID: <2023072135-getaway-wronged-b6b6@gregkh>
References: <CAK7LNAQNwjRYQDCD3=VoddnFmhxruzGpyppHr+2ZF3SgqDme-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQNwjRYQDCD3=VoddnFmhxruzGpyppHr+2ZF3SgqDme-w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jul 21, 2023 at 12:49:27PM +0900, Masahiro Yamada wrote:
> Hi Greg, Sasha,
> 
> 
> Please backport 8ae071fc216a ("kbuild: make modules_install copy
> modules.builtin(.modinfo)")
> with this tag:
> Stable-dep-of: 4243afdb9326 ("kbuild: builddeb: always make
> modules_install, to install modules.builtin*")
> 
> 
> 
> Recently, we back-ported 4243afdb9326, which depends on 8ae071fc216a
> 
> 
> Without the proper dependency, there was a regression report
> for Debian package builds with CONFIG_MODULES=n.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=217689#regzbot

Thanks for that, now queued up for 6.4.y

greg k-h
