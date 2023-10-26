Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB6C7D7E47
	for <lists+stable@lfdr.de>; Thu, 26 Oct 2023 10:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjJZIRm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 26 Oct 2023 04:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjJZIRl (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Oct 2023 04:17:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE493CE
        for <stable@vger.kernel.org>; Thu, 26 Oct 2023 01:17:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16D6C433C7;
        Thu, 26 Oct 2023 08:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698308259;
        bh=ojZOcW/BqXMgwZHwQg+x9mJX6kchMvpymwXi0Cs2FPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xTWoU0GM+geuFaxEmj9Byg8H+m6yNmJJffxH51l0cgqYtpZ1mplPRkozJwWgc7EW4
         j6aSjIItMjrh2f1bfs8Rts23v0EONMO1OqAcqlmNLB5OxJWrhWMVPdrQw76DESCFI1
         hs0BP12oMFoMDF0MfE4wN6WqUKjFw/FA9ZpVIN1U=
Date:   Thu, 26 Oct 2023 10:17:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Sperbeck <jsperbeck@google.com>
Cc:     bp@alien8.de, jpoimboe@kernel.org, patches@lists.linux.dev,
        peterz@infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] objtool/x86: add missing embedded_insn check
Message-ID: <2023102648-regalia-unisexual-db49@gregkh>
References: <20231026015728.1601280-1-jsperbeck@google.com>
 <2023102618-tributary-knapsack-8d8a@gregkh>
 <CAFNjLiWtmsticUCB+_D_MMqXCtH=RGr4f1avNYhtk+_CVGgsDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFNjLiWtmsticUCB+_D_MMqXCtH=RGr4f1avNYhtk+_CVGgsDg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Oct 25, 2023 at 10:35:08PM -0700, John Sperbeck wrote:
> On Wed, Oct 25, 2023 at 10:17 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Oct 26, 2023 at 01:57:28AM +0000, John Sperbeck wrote:
> > > When dbf460087755 ("objtool/x86: Fixup frame-pointer vs rethunk")
> > > was backported to some stable branches, the check for dest->embedded_insn
> > > in is_special_call() was missed.  Add it back in.
> > >
> > > Signed-off-by: John Sperbeck <jsperbeck@google.com>
> > > ---
> > >
> > >
> > > I think 6.1.y, 5.15.y, and 5.10.y are the LTS branches missing the
> > > bit of code that this patch re-adds.
> >
> > Did you test this and find it solved anything for you?  Your changelog
> > is pretty sparse :(
> >
> > thanks,
> >
> > greg k-h
> 
> I wasn't sure what to write for the comment.  The original backported
> commit said that it prevented this objtool warning:
> 
>     vmlinux.o: warning: objtool: srso_untrain_ret+0xd: call without
> frame pointer save/setup
> 
> But because of the missing piece, the warning still appears.  That is,
> the backport had no effect at all.

Perhaps say that?

> With this patch, the message really is gone in my builds.  Shall I
> resend my patch with an updated comment?

Build warnings going away is good, but does the result still run
properly?

> I also wasn't sure whether a Fixes annotation was appropriate, and
> which commit to reference, if so.

That's fine, just more information might be nice here.

thanks,

greg k-h

