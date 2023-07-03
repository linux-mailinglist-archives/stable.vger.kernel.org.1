Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97987454C7
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 07:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjGCFXg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 01:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGCFXf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 01:23:35 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE921AC
        for <stable@vger.kernel.org>; Sun,  2 Jul 2023 22:23:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvZ8J4CWDz4wxp;
        Mon,  3 Jul 2023 15:23:28 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     npiggin@gmail.com, christophe.leroy@csgroup.eu,
        ndesaulniers@google.com, trix@redhat.com,
        linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, stable@vger.kernel.org
In-Reply-To: <20230427-remove-power10-args-from-boot-aflags-clang-v1-1-9107f7c943bc@kernel.org>
References: <20230427-remove-power10-args-from-boot-aflags-clang-v1-1-9107f7c943bc@kernel.org>
Subject: Re: [PATCH] powerpc/boot: Disable power10 features after BOOTAFLAGS assignment
Message-Id: <168836167604.46386.2142822866200803568.b4-ty@ellerman.id.au>
Date:   Mon, 03 Jul 2023 15:21:16 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, 27 Apr 2023 12:34:53 -0700, Nathan Chancellor wrote:
> When building the boot wrapper assembly files with clang after
> commit 648a1783fe25 ("powerpc/boot: Fix boot wrapper code generation
> with CONFIG_POWER10_CPU"), the following warnings appear for each file
> built:
> 
>   '-prefixed' is not a recognized feature for this target (ignoring feature)
>   '-pcrel' is not a recognized feature for this target (ignoring feature)
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/boot: Disable power10 features after BOOTAFLAGS assignment
      https://git.kernel.org/powerpc/c/2b694fc96fe33a7c042e3a142d27d945c8c668b0

cheers
