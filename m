Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A93A7DF93A
	for <lists+stable@lfdr.de>; Thu,  2 Nov 2023 18:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjKBRzI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 2 Nov 2023 13:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjKBRzH (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 2 Nov 2023 13:55:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A522131
        for <stable@vger.kernel.org>; Thu,  2 Nov 2023 10:55:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8EDC433C8;
        Thu,  2 Nov 2023 17:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698947701;
        bh=eNyLiJ3uo1qygaTV2uokhL8xwomApdjRSSf10+Tj/YQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YZDFWC5H4kixNGUF57cNRaMtENJ2kqLaJkHV43fFry6fzZ4nmq4Q2PVYL19DnCI+o
         RYTgiNXtSMhPwmF3+eCRUPQKYH7m6r3JywxDzUc6bTVCSh+bXQfUXnCcC6PEa2oN5N
         eHay9OqUfxVSkZpuolKrkLY0RcR8PuKDWXInB+FQ=
Date:   Thu, 2 Nov 2023 18:54:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-stable <stable@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Sasha Levin <sashal@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: stable-rc: 5.15 - all builds failed - ld.lld: error: undefined
 symbol: kallsyms_on_each_symbol
Message-ID: <2023110251-animal-onset-3b21@gregkh>
References: <CA+G9fYuFUTr+riZ5bREOowR_QsspR9n_UC4pLCJQGxksU46M2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuFUTr+riZ5bREOowR_QsspR9n_UC4pLCJQGxksU46M2Q@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Nov 01, 2023 at 08:54:56PM +0530, Naresh Kamboju wrote:
> Hi Greg,
> 
> I see the following build warning / errors everywhere on stable-rc 5.15 branch.
> 
> ld.lld: error: undefined symbol: kallsyms_on_each_symbol
> >>> referenced by trace_kprobe.c
> >>>               trace/trace_kprobe.o:(create_local_trace_kprobe) in archive kernel/built-in.a
> >>> referenced by trace_kprobe.c
> >>>               trace/trace_kprobe.o:(__trace_kprobe_create) in archive kernel/built-in.a
> make[1]: *** [Makefile:1227: vmlinux] Error 1
> 
> Links,
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2XXALLRIZaXJVcqhff4ZmGTeZoQ/
> 
> - Naresh

Offending commit now dropped, thanks.

greg k-h
