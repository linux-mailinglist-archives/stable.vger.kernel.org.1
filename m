Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CA778DB69
	for <lists+stable@lfdr.de>; Wed, 30 Aug 2023 20:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238776AbjH3SjK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 30 Aug 2023 14:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245555AbjH3Pdr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 30 Aug 2023 11:33:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A008113
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 08:33:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A6D86108C
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 15:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7EBC433C8;
        Wed, 30 Aug 2023 15:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693409624;
        bh=gzcbRtMaT4maj5dYPN1BKdQWxeis9Z2fvcWGGIyz/Jk=;
        h=Date:From:To:Cc:Subject:From;
        b=eYGOdS++mCbvQtDJw53dk31OQCUcdshDJwG+YBA3lwIDtL6hnWMkyh5tYVTMuTQ0z
         nxfF7FHvF4la/rs/jbA7PpwaV++Zdo7NOrVF+845gE6qySIMl3Rh6ScxCDZ9HHwpAb
         ITDsiHEu5VKnziZEnRYSQ2OkTvNXebFM2fZfH7cx/19NzwMkgctDDbL/ibDOXujo4A
         2x/5I9lgcUlnxxFcQof/BD+SOrzJB2d4pUzU4MSfRwPn1E1sEY7Fii+XYBTgCbybGb
         6pxmitgyqH286aLvwDQoNTq8oQTd5x9IS82AYqSU8QREvL/A51gm6xT8D34ZBdWnKW
         UwMHgicxcyYoQ==
Date:   Wed, 30 Aug 2023 08:33:42 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Apply 9451c79bc39e610882bdd12370f01af5004a3c4f to linux-5.4.y
Message-ID: <20230830153342.GA888898@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg and Sasha,

Please consider applying commit 9451c79bc39e ("powerpc/pmac/smp: Avoid
unused-variable warnings") to 5.4, as it resolves a build failure that
we see building ppc64_guest_defconfig with clang due to arch/powerpc
compiling with -Werror by default:

  arch/powerpc/platforms/powermac/smp.c:664:26: error: unused variable 'core99_l2_cache' [-Werror,-Wunused-variable]
    664 | volatile static long int core99_l2_cache;
        |                          ^~~~~~~~~~~~~~~
  arch/powerpc/platforms/powermac/smp.c:665:26: error: unused variable 'core99_l3_cache' [-Werror,-Wunused-variable]
    665 | volatile static long int core99_l3_cache;
        |                          ^~~~~~~~~~~~~~~
  2 errors generated.

I have verified that it applies cleanly and does not appear to have any
direct follow up fixes, although commit a4037d1f1fc4 ("powerpc/pmac/smp:
Drop unnecessary volatile qualifier") was in the same area around the
same time so maybe it makes sense to take that one as well but I don't
think it has any functional impact.

Cheers,
Nathan
