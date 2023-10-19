Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C1B7CFD91
	for <lists+stable@lfdr.de>; Thu, 19 Oct 2023 17:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345809AbjJSPHO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 19 Oct 2023 11:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345800AbjJSPHO (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Oct 2023 11:07:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92D511D
        for <stable@vger.kernel.org>; Thu, 19 Oct 2023 08:07:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8B6C433C8;
        Thu, 19 Oct 2023 15:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697728032;
        bh=rMxa5lEZueEMosiipY5GxEHJR2SlyKgxLptuRFSln78=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=peYmqz9Hxdi2Xi9JoleQ1P29pjUOzdT6o/fHw4IFNJbxioyeImsvDKxlA7cwjQzmd
         3XsgAZvR59O4o3xm6tNL68kZf6ESP2hdU5G7NeD7zwi7xC1nhfiFO60E0MKC3jfXCV
         PpuY9GFzUqHr5C1d+smldTykHkV1qij5wnRmRzuPR4g345QMAV3UMt01iz9Cj2GmWt
         l5ew43QsssiY/qQH6IOvgfpRAqGqWRSwZe3dMN3qkZDmh3KelbniKKE9vI35P87HDE
         4G2uTDVUzENVsy4i0uTyXKJDFMmcDp9aqkoeCKw+7N6uVW04N13ROeJFVX2aN8B72Y
         zBHDXhZXWOawg==
Date:   Fri, 20 Oct 2023 00:07:08 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Francis Laniel <flaniel@linux.microsoft.com>,
        linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 0/2] Return EADDRNOTAVAIL when func matches several
 symbols during kprobe creation
Message-Id: <20231020000708.e33ec727fcd322b7cde292cd@kernel.org>
In-Reply-To: <20231019095104.006a7252@gandalf.local.home>
References: <20231018144030.86885-1-flaniel@linux.microsoft.com>
        <20231018130042.3430f000@gandalf.local.home>
        <20231019211843.56f292be3eee75cdd377e5a2@kernel.org>
        <20231019095104.006a7252@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, 19 Oct 2023 09:51:04 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 19 Oct 2023 21:18:43 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > So why is this adding stable? (and as Greg's form letter states, that's not
> > > how you do that)
> > > 
> > > I don't see this as a fix but a new feature.  
> > 
> > I asked him to make this a fix since the current kprobe event' behavior is
> > somewhat strange. It puts the probe on only the "first symbol" if user
> > specifies a symbol name which has multiple instances. In this case, the
> > actual probe address can not be solved by name. User must specify the
> > probe address by unique name + offset. Unless, it can put a probe on
> > unexpected address, especially if it specifies non-unique symbol + offset,
> > the address may NOT be the instruction boundary.
> > To avoid this issue, it should check the given symbol is unique.
> >
> 
> OK, so what is broken is that when you add a probe to a function that has
> multiple names, it will attach to the first one and not necessarily the one
> you want.
> 
> The change log needs to be more explicit in what the "bug" is. It does
> state this in a round about way, but it is written in a way that it doesn't
> stand out.
> 
>     Previously to this commit, if func matches several symbols, a kprobe,
>     being either sysfs or PMU, would only be installed for the first
>     matching address. This could lead to some misunderstanding when some
>     BPF code was never called because it was attached to a function which
>     was indeed not called, because the effectively called one has no
>     kprobes attached.
> 
>     So, this commit returns EADDRNOTAVAIL when func matches several
>     symbols. This way, user needs to use address to remove the ambiguity.
> 
> 
> What it should say is:
> 
>     When a kprobe is attached to a function that's name is not unique (is
>     static and shares the name with other functions in the kernel), the
>     kprobe is attached to the first function it finds. This is a bug as the
>     function that it is attaching to is not necessarily the one that the
>     user wants to attach to.
> 
>     Instead of blindly picking a function to attach to what is ambiguous,
>     error with EADDRNOTAVAIL to let the user know that this function is not
>     unique, and that the user must use another unique function with an
>     address offset to get to the function they want to attach to.
> 

Great!, yes this looks good to me too.

> And yes, it should have:
> 
> Cc: stable@vger.kernel.org
> 
> which is how to mark something for stable, and
> 
> Fixes: ...
> 
> To the commit that caused the bug.

Yes, this should be the first one.

Fixes: 413d37d1eb69 ("tracing: Add kprobe-based event tracer")

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
