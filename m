Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204677DA482
	for <lists+stable@lfdr.de>; Sat, 28 Oct 2023 02:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjJ1AuT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 20:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ1AuT (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 20:50:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2BCE3
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 17:50:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC97C433C8;
        Sat, 28 Oct 2023 00:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698454216;
        bh=NYgCCBDHbEbm8NDWR2MFk9rmJsQIHpqcX78i8+6zTkM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j4LQDcAKes269DLKsYxfm6IR4RphkGjoYVbEIhr4AAAchZboDPt5j6pMDee54KJa2
         EA60/4tOTYDHFGK3j5ICVfQLf9wwNHF11y2b7s2OreZBUMibJmAI0X3lMGKuxFqPTT
         3CwpoVQdjs/4oP+c5+9LNTe4YaAs54bQFsb7Lqf9VzncvqbUJ4mG/xYVTFTAeoJTae
         glxWaz7XIK2Vq/ZT53Ay37LQ6egn0jR30MlbE6CB3X7dOr8Sr0qR11p6xpjWiByWGy
         tZ5Wb2li1ttW6vijhelZoGxy9HRVW8bvsbc8Mtt9LgrcJj1w9AFjBzJnzSNUBCglDA
         Ij6vOZifknCpA==
Date:   Sat, 28 Oct 2023 09:50:11 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        bpf@vger.kernel.org, Francis Laniel <flaniel@linux.microsoft.com>,
        stable@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] tracing/kprobes: Fix symbol counting logic by looking
 at modules as well
Message-Id: <20231028095011.d3fce4fbeb80a1b1e06a1689@kernel.org>
In-Reply-To: <CAPhsuW4aLOvH7t2m6tm8CjPWKr_hvsvh_TacDgpggg7bL3b7aw@mail.gmail.com>
References: <20231027233126.2073148-1-andrii@kernel.org>
        <CAPhsuW4aLOvH7t2m6tm8CjPWKr_hvsvh_TacDgpggg7bL3b7aw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, 27 Oct 2023 16:37:29 -0700
Song Liu <song@kernel.org> wrote:

> On Fri, Oct 27, 2023 at 4:31 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Recent changes to count number of matching symbols when creating
> > a kprobe event failed to take into account kernel modules. As such, it
> > breaks kprobes on kernel module symbols, by assuming there is no match.
> >
> > Fix this my calling module_kallsyms_on_each_symbol() in addition to
> > kallsyms_on_each_match_symbol() to perform a proper counting.
> >
> > Cc: Francis Laniel <flaniel@linux.microsoft.com>
> > Cc: stable@vger.kernel.org
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Fixes: b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> Acked-by: Song Liu <song@kernel.org>

Good catch! Thanks!



-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
