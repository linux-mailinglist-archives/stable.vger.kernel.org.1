Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB5076FE71
	for <lists+stable@lfdr.de>; Fri,  4 Aug 2023 12:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjHDK1o (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 4 Aug 2023 06:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjHDK1m (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 Aug 2023 06:27:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A17F49D4
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 03:27:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0461161F89
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 10:27:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C06BC433C7;
        Fri,  4 Aug 2023 10:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691144859;
        bh=vARprLRm4WSYiNLe830FG9jjTyDkBRJ6GpZlh8LefAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JUAzO32H+yXD9n+akjohyXETNNWR0Hr/qHtoku/D8LlnF9kWB9UUt30nXm5AAeoNn
         zSFKcjRkSkzZZaIrKGuzfRVCX/OGRW0zadQRNkxB5ObkHsXNT21+BhY95QmvMzVERa
         AIMW83/KIYQ9Pbys011uBKVNXyTf6gQRBjFGAuWs=
Date:   Fri, 4 Aug 2023 12:27:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     jannh@google.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm: lock_vma_under_rcu() must check
 vma->anon_vma under vma" failed to apply to 6.4-stable tree
Message-ID: <2023080418-anvil-grumbly-c3ff@gregkh>
References: <2023080129-surface-stench-5e24@gregkh>
 <CAHk-=wjfdPq6=rwECsYaSzFaehBoGxGEHwyJmAVK0ekXoS89FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjfdPq6=rwECsYaSzFaehBoGxGEHwyJmAVK0ekXoS89FQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 01, 2023 at 09:34:10AM -0700, Linus Torvalds wrote:
> On Mon, 31 Jul 2023 at 23:28, <gregkh@linuxfoundation.org> wrote:
> >
> > The patch below does not apply to the 6.4-stable tree.
> 
> Ahh. The vma_is_tcp() checks are new.
> 
> I think you can literally just remove all occurrences of
> 
>      && !vma_is_tcp(vma)
> 
> in that patch to make it apply.
> 
> The end result should look something like the attached, afaik.

Thanks, that worked, now queued up.

greg k-h
