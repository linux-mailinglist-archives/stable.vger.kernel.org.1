Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA2D6F96ED
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 07:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjEGFLU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 01:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEGFLS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 01:11:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DED9EF1
        for <stable@vger.kernel.org>; Sat,  6 May 2023 22:11:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF38B61007
        for <stable@vger.kernel.org>; Sun,  7 May 2023 05:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD69C433EF;
        Sun,  7 May 2023 05:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683436275;
        bh=9dMvR61Umk33l8NiH/Y6Inl8qXkruhqzkWVUyT4NMoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U1rC+NEVrfu4MX+T1SHinnpu8dJN7BlKA6FFbH8V+rJc+0JSsdqZkYBi4v5McZG+z
         4/LOpqpphgUdcrS+oAfqc03ZsnrhMOieU0O8ZcAgZcNz+54go8UPCrerXRRclMnM5/
         LPeATUe2ns2Akf2eiqd1kb9x23l2Uo4vJZmqeF94=
Date:   Sun, 7 May 2023 07:11:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 5.10.y 1/2] arm64: Always load shadow stack pointer
 directly from the task struct
Message-ID: <2023050757-starless-tacking-d9f9@gregkh>
References: <20230506123434.63470-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506123434.63470-1-ardb@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, May 06, 2023 at 02:34:33PM +0200, Ard Biesheuvel wrote:
> All occurrences of the scs_load macro load the value of the shadow call
> stack pointer from the task which is current at that point. So instead
> of taking a task struct register argument in the scs_load macro to
> specify the task struct to load from, let's always reference the current
> task directly. This should make it much harder to exploit any
> instruction sequences reloading the shadow call stack pointer register
> from memory.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Link: https://lore.kernel.org/r/20230109174800.3286265-2-ardb@kernel.org
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/include/asm/scs.h | 7 ++++---
>  arch/arm64/kernel/entry.S    | 4 ++--
>  arch/arm64/kernel/head.S     | 2 +-
>  3 files changed, 7 insertions(+), 6 deletions(-)

What is the git commit id of this in Linus's tree?

thanks,

greg k-h
