Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54B4738EED
	for <lists+stable@lfdr.de>; Wed, 21 Jun 2023 20:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjFUSgp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 21 Jun 2023 14:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjFUSgo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Jun 2023 14:36:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3701710
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 11:36:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4470C61698
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 18:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248A3C433C8;
        Wed, 21 Jun 2023 18:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687372602;
        bh=o7D/TKdFT4P7AwrculzCYjOw5WM+rsw0DCeoB3HDtZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mcp23CUn0BNBohoIezrHOiVU9jI6gPoEDYCWFrTsVTq9ha7KyidwEgP1VTf/4Dr2E
         fd0WCNnoWRVkW7FOeHu8zFcvKn7eBLSdMt8myEaTJy0jMaICVkgKMPnd/TvO3mDbZF
         FjCUt63kYbW1PcVSZCGvpKlouTs6dupx1K9/M4pQ=
Date:   Wed, 21 Jun 2023 20:36:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     stable@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Young <dyoung@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Rudo <prudo@redhat.com>,
        Ross Zwisler <zwisler@google.com>,
        Simon Horman <horms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4.19.y] x86/purgatory: remove PGO flags
Message-ID: <2023062129-jockstrap-unripe-5215@gregkh>
References: <2023061700-surplus-art-1fef@gregkh>
 <20230619113806.218802-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619113806.218802-1-ribalda@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jun 19, 2023 at 01:38:06PM +0200, Ricardo Ribalda wrote:
> If profile-guided optimization is enabled, the purgatory ends up with
> multiple .text sections.  This is not supported by kexec and crashes the
> system.
> 
> Link: https://lkml.kernel.org/r/20230321-kexec_clang16-v7-2-b05c520b7296@chromium.org
> Fixes: 930457057abe ("kernel/kexec_file.c: split up __kexec_load_puragory")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> Cc: <stable@vger.kernel.org>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Philipp Rudo <prudo@redhat.com>
> Cc: Ross Zwisler <zwisler@google.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tom Rix <trix@redhat.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 97b6b9cbba40a21c1d9a344d5c1991f8cfbf136e)
> Signed-off-by: Ricardo Ribalda Delgado <ribalda@chromium.org>
> ---
>  arch/x86/purgatory/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Now queued up, thanks.

greg k-h
