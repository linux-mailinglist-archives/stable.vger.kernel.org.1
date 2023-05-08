Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942516FA05A
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 08:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjEHG6N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 02:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbjEHG6A (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 02:58:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D841A113
        for <stable@vger.kernel.org>; Sun,  7 May 2023 23:57:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 974AE618E2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 06:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BCEC433D2;
        Mon,  8 May 2023 06:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683529045;
        bh=x3KXusVbKaCIt6MSM0JguaKUR0Moz7EadIhU//FbZBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jkBnZGXGyL1V07uCoZIWGrt625/X9cfSWPuD6ERqkbNu1jwzPJe9gXe6AORnhrOcF
         TWlGIwTQIyEXVU1A7FLR5HssOXm7c5t7l3dr0FrGksZ8/VF2JO6BGjGkay5Z71Cia3
         WB8vkLXt9E+Ru7zFDxk8lmniCGvfZY9HFfoM/Nis=
Date:   Mon, 8 May 2023 08:57:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 5.10.y 1/2] arm64: Always load shadow stack pointer
 directly from the task struct
Message-ID: <2023050814-backpack-diagram-0e26@gregkh>
References: <20230506123434.63470-1-ardb@kernel.org>
 <2023050757-starless-tacking-d9f9@gregkh>
 <CAMj1kXGx6xjtvbM9U_PPc9+WRDx3j-Z9hFBiJQra5dpmH2QqOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGx6xjtvbM9U_PPc9+WRDx3j-Z9hFBiJQra5dpmH2QqOQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, May 07, 2023 at 10:11:32AM +0200, Ard Biesheuvel wrote:
> On Sun, 7 May 2023 at 07:11, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, May 06, 2023 at 02:34:33PM +0200, Ard Biesheuvel wrote:
> > > All occurrences of the scs_load macro load the value of the shadow call
> > > stack pointer from the task which is current at that point. So instead
> > > of taking a task struct register argument in the scs_load macro to
> > > specify the task struct to load from, let's always reference the current
> > > task directly. This should make it much harder to exploit any
> > > instruction sequences reloading the shadow call stack pointer register
> > > from memory.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > > Link: https://lore.kernel.org/r/20230109174800.3286265-2-ardb@kernel.org
> > > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/arm64/include/asm/scs.h | 7 ++++---
> > >  arch/arm64/kernel/entry.S    | 4 ++--
> > >  arch/arm64/kernel/head.S     | 2 +-
> > >  3 files changed, 7 insertions(+), 6 deletions(-)
> >
> > What is the git commit id of this in Linus's tree?
> >
> 
> commit 2198d07c509f1db4a1185d1f65aaada794c6ea59 upstream.

Thanks, both now queued up!

greg k-h
