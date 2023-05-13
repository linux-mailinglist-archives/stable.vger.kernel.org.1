Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04305701631
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 12:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjEMKfo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 06:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjEMKfn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 06:35:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB17199
        for <stable@vger.kernel.org>; Sat, 13 May 2023 03:35:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FAF260DDF
        for <stable@vger.kernel.org>; Sat, 13 May 2023 10:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4403C433EF;
        Sat, 13 May 2023 10:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683974140;
        bh=GoGlWWxYLEbhLMsQEUwxsBFlFDlBaeFCSlUCg6z2HbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CYO4OnuqTzyYWWBQLkXUp25u8KIXxwYx1INNw1rSAkzWWr9I4MNWyZQ4oFSsxcluk
         rttruVEufFAaDL4WTEFeEna39MYcW0ZVosq6ZkSoHobuzxJ6ukvl1aFkh2DEoHlxs6
         hWmfkif407uj4mzCWgt/Hlkq0mNTtKxVBchn/99Q=
Date:   Sat, 13 May 2023 19:35:05 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     stable@kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] x86/retbleed: Fix return thunk alignment"
 failed to apply to 5.15-stable tree
Message-ID: <2023051353-robbing-idealness-e9ce@gregkh>
References: <2023051313-wrangle-brick-b43d@gregkh>
 <20230513102107.GCZF9kk4OdTl0z2qbW@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230513102107.GCZF9kk4OdTl0z2qbW@fat_crate.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, May 13, 2023 at 12:21:07PM +0200, Borislav Petkov wrote:
> On Sat, May 13, 2023 at 05:17:13PM +0900, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.15-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 9a48d604672220545d209e9996c2a1edbb5637f6
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051313-wrangle-brick-b43d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> > 
> > Possible dependencies:
> > 
> > 9a48d6046722 ("x86/retbleed: Fix return thunk alignment")
> > a149180fbcf3 ("x86: Add magic AMD return-thunk")
> > d9e9d2300681 ("x86,objtool: Create .return_sites")
> > 15e67227c49a ("x86: Undo return-thunk damage")
> > 0b53c374b9ef ("x86/retpoline: Use -mfunction-return")
> > 369ae6ffc41a ("x86/retpoline: Cleanup some #ifdefery")
> > a883d624aed4 ("x86/cpufeatures: Move RETPOLINE flags to word 11")
> > 22922deae13f ("Merge tag 'objtool-core-2022-05-23' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
> 
> Right, so that looks like this:
> 
> The patch which causes the misalignment is
> 
> c4691712b546 ("x86/linkage: Add ENDBR to SYM_FUNC_START*()")
> 
> which came in 5.18 (v5.17-rc8-21-gc4691712b546) and the one which adds
> the actual untraining sequence:
> 
> a149180fbcf3 ("x86: Add magic AMD return-thunk")
> 
> came in 5.19.
> 
> So adding a Fixes: tag pointing to a patch which goes before the actual
> patch didn't make any sense to me last night.
> 
> HOWEVER, Thadeu did backport it here as
> 
> a9c0926fc754 ("x86: Add magic AMD return-thunk")
> 
> but the other patch wasn't backported.
> 
> So the 5.15 build looks good:
> 
> ffffffff81c01f7f <zen_untrain_ret>:
> ffffffff81c01f7f:       f6                      .byte 0xf6
> 
> ffffffff81c01f80 <__x86_return_thunk>:
> ffffffff81c01f80:       c3                      ret
> ffffffff81c01f81:       cc                      int3
> ffffffff81c01f82:       0f ae e8                lfence
> ffffffff81c01f85:       eb f9                   jmp    ffffffff81c01f80 <__x86_return_thunk>
> ffffffff81c01f87:       cc                      int3
> 
> So 5.15 doesn't need it.

Great, thanks for looking into this, much appreciated.

greg k-h
