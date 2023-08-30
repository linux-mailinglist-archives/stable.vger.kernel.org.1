Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620F578DB6B
	for <lists+stable@lfdr.de>; Wed, 30 Aug 2023 20:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238788AbjH3SjK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 30 Aug 2023 14:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245596AbjH3Pj1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 30 Aug 2023 11:39:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C60D185
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 08:39:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F47BB81F55
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 15:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3970BC433C7;
        Wed, 30 Aug 2023 15:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693409961;
        bh=ne4Gc5MN3+77rtGMwaPZrR9E+QAA8QsqVqxCBZ0rPBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z0eu/k18sxOxR+B3cSOhiqjW50rAMxUSR2ntv0kFJ6Um38IrQv4a81J9p/G0+9MJG
         vi2dBGfwvsPsprnfOo4ZiAroD6MvcyCDgRzvTA6WutxyIpLM15sG4vEBVnrPcInxfZ
         1+Yf5yPbxTKs/ToAgO8GMahlv1b7RfRzUHkHukeA=
Date:   Wed, 30 Aug 2023 17:39:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Apply 9451c79bc39e610882bdd12370f01af5004a3c4f to linux-5.4.y
Message-ID: <2023083056-figure-plasma-1774@gregkh>
References: <20230830153342.GA888898@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830153342.GA888898@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Aug 30, 2023 at 08:33:42AM -0700, Nathan Chancellor wrote:
> Hi Greg and Sasha,
> 
> Please consider applying commit 9451c79bc39e ("powerpc/pmac/smp: Avoid
> unused-variable warnings") to 5.4, as it resolves a build failure that
> we see building ppc64_guest_defconfig with clang due to arch/powerpc
> compiling with -Werror by default:
> 
>   arch/powerpc/platforms/powermac/smp.c:664:26: error: unused variable 'core99_l2_cache' [-Werror,-Wunused-variable]
>     664 | volatile static long int core99_l2_cache;
>         |                          ^~~~~~~~~~~~~~~
>   arch/powerpc/platforms/powermac/smp.c:665:26: error: unused variable 'core99_l3_cache' [-Werror,-Wunused-variable]
>     665 | volatile static long int core99_l3_cache;
>         |                          ^~~~~~~~~~~~~~~
>   2 errors generated.
> 
> I have verified that it applies cleanly and does not appear to have any
> direct follow up fixes, although commit a4037d1f1fc4 ("powerpc/pmac/smp:
> Drop unnecessary volatile qualifier") was in the same area around the
> same time so maybe it makes sense to take that one as well but I don't
> think it has any functional impact.

Now queued up.

greg k-h
