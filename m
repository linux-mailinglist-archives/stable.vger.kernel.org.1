Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C51C7CFBAC
	for <lists+stable@lfdr.de>; Thu, 19 Oct 2023 15:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345821AbjJSNvK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 19 Oct 2023 09:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345774AbjJSNvK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Oct 2023 09:51:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A27C132
        for <stable@vger.kernel.org>; Thu, 19 Oct 2023 06:51:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F71C433C9;
        Thu, 19 Oct 2023 13:51:07 +0000 (UTC)
Date:   Thu, 19 Oct 2023 09:51:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Francis Laniel <flaniel@linux.microsoft.com>,
        linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 0/2] Return EADDRNOTAVAIL when func matches several
 symbols during kprobe creation
Message-ID: <20231019095104.006a7252@gandalf.local.home>
In-Reply-To: <20231019211843.56f292be3eee75cdd377e5a2@kernel.org>
References: <20231018144030.86885-1-flaniel@linux.microsoft.com>
        <20231018130042.3430f000@gandalf.local.home>
        <20231019211843.56f292be3eee75cdd377e5a2@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, 19 Oct 2023 21:18:43 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > So why is this adding stable? (and as Greg's form letter states, that's not
> > how you do that)
> > 
> > I don't see this as a fix but a new feature.  
> 
> I asked him to make this a fix since the current kprobe event' behavior is
> somewhat strange. It puts the probe on only the "first symbol" if user
> specifies a symbol name which has multiple instances. In this case, the
> actual probe address can not be solved by name. User must specify the
> probe address by unique name + offset. Unless, it can put a probe on
> unexpected address, especially if it specifies non-unique symbol + offset,
> the address may NOT be the instruction boundary.
> To avoid this issue, it should check the given symbol is unique.
>

OK, so what is broken is that when you add a probe to a function that has
multiple names, it will attach to the first one and not necessarily the one
you want.

The change log needs to be more explicit in what the "bug" is. It does
state this in a round about way, but it is written in a way that it doesn't
stand out.

    Previously to this commit, if func matches several symbols, a kprobe,
    being either sysfs or PMU, would only be installed for the first
    matching address. This could lead to some misunderstanding when some
    BPF code was never called because it was attached to a function which
    was indeed not called, because the effectively called one has no
    kprobes attached.

    So, this commit returns EADDRNOTAVAIL when func matches several
    symbols. This way, user needs to use address to remove the ambiguity.


What it should say is:

    When a kprobe is attached to a function that's name is not unique (is
    static and shares the name with other functions in the kernel), the
    kprobe is attached to the first function it finds. This is a bug as the
    function that it is attaching to is not necessarily the one that the
    user wants to attach to.

    Instead of blindly picking a function to attach to what is ambiguous,
    error with EADDRNOTAVAIL to let the user know that this function is not
    unique, and that the user must use another unique function with an
    address offset to get to the function they want to attach to.

And yes, it should have:

Cc: stable@vger.kernel.org

which is how to mark something for stable, and

Fixes: ...

To the commit that caused the bug.

-- Steve
