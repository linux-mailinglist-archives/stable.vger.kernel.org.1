Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CB6745F60
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 17:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjGCPDr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 11:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjGCPDn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 11:03:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1A8E41
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 08:03:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93CAF60F95
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 15:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92862C433C7;
        Mon,  3 Jul 2023 15:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688396621;
        bh=QaNWgfQP+jFKpzJKdvnOLzgnGgIT9p6iW+rItqul7nM=;
        h=Date:From:To:Cc:Subject:From;
        b=kweRJAaPoSxF8xXCd0HCrTRADBTTOP7Auy1OW/gk4679XBPrRDby/tn6M3k6LjGCx
         c5K/Nx291poJKlUPRPlBS4ggL7+TqR3zEqJklWJo3eK1yYv4Hi+kiYf9ZV0BA8UfNL
         einWpmsT5TjL/XoGfp9NQorTjBX7tK6jl2uPgqkUVcWt1ATuIrNomvnpEO29GSr2+Y
         9B3Ig3AmOaJUyahp8h8hgujpO+LXnJbjVvn9d6YEQ5BXk5NK0Kweu5w9eRb0KErLbD
         A4h8NFrGCvH880wmRoj8Xxq6goSEVh6SUdOpLIUeuh21pKjjlgMJU1Ck4OKDPxX9iv
         +JXBKOi9XVYWA==
Date:   Mon, 3 Jul 2023 08:03:39 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, llvm@lists.linux.dev,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Apply clang '--target=' KBUILD_CPPFLAGS shuffle to linux-6.4.y and
 linux-6.3.y
Message-ID: <20230703150339.GA1975402@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg and Sasha,

Please consider applying the following patches to 6.4 and 6.3, they
should apply cleanly.

08f6554ff90e ("mips: Include KBUILD_CPPFLAGS in CHECKFLAGS invocation")
a7e5eb53bf9b ("powerpc/vdso: Include CLANG_FLAGS explicitly in ldflags-y")
cff6e7f50bd3 ("kbuild: Add CLANG_FLAGS to as-instr")
43fc0a99906e ("kbuild: Add KBUILD_CPPFLAGS to as-option invocation")
feb843a469fb ("kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS")

They resolve and help avoid build breakage with tip of tree clang, which
has become a little stricter in the flags that it will accept for a
particular target, which requires '--target=' to be passed along to all
invocations of $(CC). Our continuous integration does not currently show
any breakage with 6.1 and earlier; should these patches be needed there,
I will send them at a later time.

Cheers,
Nathan
