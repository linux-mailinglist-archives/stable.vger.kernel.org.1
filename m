Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883F67346EC
	for <lists+stable@lfdr.de>; Sun, 18 Jun 2023 18:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjFRQJ4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 18 Jun 2023 12:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFRQJz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Jun 2023 12:09:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A03E56
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 09:09:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EED2460B2C
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 16:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B59BC433C8;
        Sun, 18 Jun 2023 16:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687104593;
        bh=GzYpFIcdNcs2kW2PB3HiGgDvEFfNlYRxZYIfSvGrOWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jh5ac0ysWI5CzUC6PDoAp6tCCwYCqNFI7J6XjIaDd4zLxXMeTZpf58B+9SOaw8lUf
         jOKKLv8+4BB2iKPGULFmCQ1AFADCwZtPaQQkIZBZG7OlLPb3z0hfbgbZwg9EnUo7OG
         9D3tm8o7ulY7M/p/ddIQCEVif4Ll7yCrsQjCC+BM=
Date:   Sun, 18 Jun 2023 18:09:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable <stable@vger.kernel.org>
Subject: Re: Build error in stable queues
Message-ID: <2023061840-disobey-yoyo-1bbf@gregkh>
References: <3f21adac-8a67-1789-22fb-86b2cd096ad2@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f21adac-8a67-1789-22fb-86b2cd096ad2@roeck-us.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Jun 18, 2023 at 08:40:51AM -0700, Guenter Roeck wrote:
> Seen in linux-5.15.y-queue and older.
> 
> Building mips:defconfig ... failed
> --------------
> Error log:
> arch/mips/kernel/cpu-probe.c: In function 'cpu_probe':
> arch/mips/kernel/cpu-probe.c:2039:9: error: duplicate case value
>  2039 |         case PRID_COMP_NETLOGIC:
>       |         ^~~~
> arch/mips/kernel/cpu-probe.c:2012:9: note: previously used here
>  2012 |         case PRID_COMP_NETLOGIC:
> 
> Guenter

Should now be fixed, I see Sasha dropped a patch.

thanks,

greg k-h
