Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CC17DC305
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 00:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjJ3XPV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 30 Oct 2023 19:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjJ3XPU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Oct 2023 19:15:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3989010D
        for <stable@vger.kernel.org>; Mon, 30 Oct 2023 16:15:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C3DC433C9;
        Mon, 30 Oct 2023 23:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698707717;
        bh=oAcH7wY9SNyojp8UXbQPAveqy+m6PjH8DsovTpkomjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kXY9G9pHM1THVXZ8c79UINon0LLE4GfGQ4HwWnReJmcpGlHO+t/Zf5TAFy9WIuEBm
         DSvGycdy1JuYt2kN+NJJZAS6Z+rguLpHSysmFoCRDv32ugtECMr1p87dMZq0kCHcYB
         AZ4k9REwJNoveBwcH0SUpm4rSRpkpy4GdVxhRJkt9cyaNEE5hNSOS0OXlcroB+CJR7
         JihLeNPXfgrn/7KceGnqh1FLa8Un9cD+/IhKOeopSZIjUjXgiUl7cFOR2DL8rVSnLx
         0yBv5mnDk5xNs36mzFvvbQa+GY3YVTANdr1+5KIA6cJrojprIOEtPcGVS6JO32hciM
         8Lfqai5E9MtMA==
Date:   Mon, 30 Oct 2023 19:15:16 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: backport 790756c7e022 to 4.14 and 4.19?
Message-ID: <ZUA5BDnos1ASlFqM@sashalap>
References: <20231030212510.equbu7lxlslgoy3t@viti.kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231030212510.equbu7lxlslgoy3t@viti.kaiser.cx>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 30, 2023 at 10:25:10PM +0100, Martin Kaiser wrote:
>Dear all,
>
>after upgrading my toolchain to gcc 13.2 and GNU assembler (GNU
>Binutils) 2.41.0.20230926, compiling a 4.14 kernel fails
>
>arch/arm/mm/proc-arm926.S: Assembler messages:
>arch/arm/mm/proc-arm926.S:477: Error: junk at end of line, first
>unrecognized character is `#'
>
>The problem is that gas 2.41.0.20230926 does no longer support
>Solaris style section attributes like
>.section ".start", #alloc, #execinstr
>
>Commit 790756c7e022 ("ARM: 8933/1: replace Sun/Solaris style flag on
>section directive") fixed up the section attributes that used the legacy
>syntax. It seems that this commit landed in 5.5 and has already been
>backported to 5.4.
>
>Should we backport this commit to 4.19 and 4.14 as well? If so, should I
>submit patches that apply against the 4.19 and 4.14 trees or do you want
>to resolve the conflicts when you queue up the patch?

I'll queue it up, thanks!

-- 
Thanks,
Sasha
