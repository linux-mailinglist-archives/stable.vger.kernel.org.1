Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F80270161C
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 12:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjEMKVQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 06:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEMKVP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 06:21:15 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8EE3AAE
        for <stable@vger.kernel.org>; Sat, 13 May 2023 03:21:13 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 653791EC054E;
        Sat, 13 May 2023 12:21:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1683973271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Mns+QpZj53S2jvKSCqZNev45AjpJjRZqMEQzTGqakyU=;
        b=Z+Ph8OnUBxa4nq4Wp526W2N1Q2dV5rk4hwAgu+DJqpBYxJ1kZRGSQwiQAHJxcvxiVZP03h
        Q7rAYymCD/tMdh1lCH3dbFstIqyI5koBAiBxlWL9MJgHaEGt6z0Rqn37OG6t9uKn9pYNGG
        TphT8U8EPjqiA+yqGAopDkkfQEUX96w=
Date:   Sat, 13 May 2023 12:21:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     gregkh@linuxfoundation.org
Cc:     stable@kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] x86/retbleed: Fix return thunk alignment"
 failed to apply to 5.15-stable tree
Message-ID: <20230513102107.GCZF9kk4OdTl0z2qbW@fat_crate.local>
References: <2023051313-wrangle-brick-b43d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023051313-wrangle-brick-b43d@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, May 13, 2023 at 05:17:13PM +0900, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x 9a48d604672220545d209e9996c2a1edbb5637f6
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051313-wrangle-brick-b43d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> 
> Possible dependencies:
> 
> 9a48d6046722 ("x86/retbleed: Fix return thunk alignment")
> a149180fbcf3 ("x86: Add magic AMD return-thunk")
> d9e9d2300681 ("x86,objtool: Create .return_sites")
> 15e67227c49a ("x86: Undo return-thunk damage")
> 0b53c374b9ef ("x86/retpoline: Use -mfunction-return")
> 369ae6ffc41a ("x86/retpoline: Cleanup some #ifdefery")
> a883d624aed4 ("x86/cpufeatures: Move RETPOLINE flags to word 11")
> 22922deae13f ("Merge tag 'objtool-core-2022-05-23' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")

Right, so that looks like this:

The patch which causes the misalignment is

c4691712b546 ("x86/linkage: Add ENDBR to SYM_FUNC_START*()")

which came in 5.18 (v5.17-rc8-21-gc4691712b546) and the one which adds
the actual untraining sequence:

a149180fbcf3 ("x86: Add magic AMD return-thunk")

came in 5.19.

So adding a Fixes: tag pointing to a patch which goes before the actual
patch didn't make any sense to me last night.

HOWEVER, Thadeu did backport it here as

a9c0926fc754 ("x86: Add magic AMD return-thunk")

but the other patch wasn't backported.

So the 5.15 build looks good:

ffffffff81c01f7f <zen_untrain_ret>:
ffffffff81c01f7f:       f6                      .byte 0xf6

ffffffff81c01f80 <__x86_return_thunk>:
ffffffff81c01f80:       c3                      ret
ffffffff81c01f81:       cc                      int3
ffffffff81c01f82:       0f ae e8                lfence
ffffffff81c01f85:       eb f9                   jmp    ffffffff81c01f80 <__x86_return_thunk>
ffffffff81c01f87:       cc                      int3

So 5.15 doesn't need it.

Now lemme look at 5.10.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
