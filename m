Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D386F977E
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 10:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjEGIMN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 04:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjEGIMF (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 04:12:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F73124BC
        for <stable@vger.kernel.org>; Sun,  7 May 2023 01:12:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE50D6184D
        for <stable@vger.kernel.org>; Sun,  7 May 2023 08:11:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5D7C433EF
        for <stable@vger.kernel.org>; Sun,  7 May 2023 08:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683447107;
        bh=MH52s9vIG4qpfQHaeRVg/+M59fyFmi3fLFRLo75uoug=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KK3JnDBkDb5qNiMVfetge5FUe5cQnTAB5TyJyFjFk+vVLH7UCKjZGcJMZiVbhDit2
         sXZ/89yakx5eQjyODt9tnjVnNDbK4VFCKldnUkv8g0/VM0A1TE9MXmPvAIj3v1Bxu7
         vO/9bfp8v5pGVHgHaN29IXY1ELDwFQdIZeGB3E5em6IljKO0Un4bSJU9qnAxRYmwqb
         HczWU11G/8vOed1mK/OF7mR/xlC4aynXRZ6mZ76MMVf0dAP9zAsRkgbokenEOb9WjA
         fTqBN4Ly879kxIxzhqu06TkhVaHex1IjtHV1YyGOtLw2eR2CzOnMatdEiaybO33cQA
         FwYzxL6jqD0Aw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4effb818c37so3898621e87.3
        for <stable@vger.kernel.org>; Sun, 07 May 2023 01:11:46 -0700 (PDT)
X-Gm-Message-State: AC+VfDzHYxxZuYxeL3CXMavIPBdtnrRZslYM1Mip/qlQxBFtC72jpiif
        WxVK1KE3h7D85hhIvetEYGHi1De1shln8drOqoE=
X-Google-Smtp-Source: ACHHUZ4gLt4hwtD9eRAuoe5ueG3Wo9qwI2p04JET1oRlP79SH5/WVyejJLYAfpNM3txsaZiJDYvTKhuGchTwSW6mrxw=
X-Received: by 2002:a19:7412:0:b0:4ef:eb50:4d3d with SMTP id
 v18-20020a197412000000b004efeb504d3dmr1984022lfe.18.1683447104133; Sun, 07
 May 2023 01:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230506123434.63470-1-ardb@kernel.org> <2023050757-starless-tacking-d9f9@gregkh>
In-Reply-To: <2023050757-starless-tacking-d9f9@gregkh>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 7 May 2023 10:11:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGx6xjtvbM9U_PPc9+WRDx3j-Z9hFBiJQra5dpmH2QqOQ@mail.gmail.com>
Message-ID: <CAMj1kXGx6xjtvbM9U_PPc9+WRDx3j-Z9hFBiJQra5dpmH2QqOQ@mail.gmail.com>
Subject: Re: [PATCH 5.10.y 1/2] arm64: Always load shadow stack pointer
 directly from the task struct
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, 7 May 2023 at 07:11, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, May 06, 2023 at 02:34:33PM +0200, Ard Biesheuvel wrote:
> > All occurrences of the scs_load macro load the value of the shadow call
> > stack pointer from the task which is current at that point. So instead
> > of taking a task struct register argument in the scs_load macro to
> > specify the task struct to load from, let's always reference the current
> > task directly. This should make it much harder to exploit any
> > instruction sequences reloading the shadow call stack pointer register
> > from memory.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Link: https://lore.kernel.org/r/20230109174800.3286265-2-ardb@kernel.org
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/include/asm/scs.h | 7 ++++---
> >  arch/arm64/kernel/entry.S    | 4 ++--
> >  arch/arm64/kernel/head.S     | 2 +-
> >  3 files changed, 7 insertions(+), 6 deletions(-)
>
> What is the git commit id of this in Linus's tree?
>

commit 2198d07c509f1db4a1185d1f65aaada794c6ea59 upstream.

Thanks,
