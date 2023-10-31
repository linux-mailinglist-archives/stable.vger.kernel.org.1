Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DD57DCF2D
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 15:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbjJaOQP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 10:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbjJaOQN (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 10:16:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23897C1
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 07:16:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41450C433C7;
        Tue, 31 Oct 2023 14:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698761770;
        bh=3wOFY53qdKiXd5u5qTX7PA/Wli4b8yrPdivU5ydj6uk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D4tP+QBkq5TbWHqbJbIL9wHPDcoXSVO9egDXcXcC89U+5HlDTlGIL7u7kc7ekv7h7
         yqpmFQZVmKy7/zwzn/QfrmLDSh4l4XKBxHVNVjtugzo69RmYkiFS4Tfw56JwqCbbyz
         DkQyLLtjAp3j+BIfPdRKPIuGyBCmFz5HP1G5AH8U=
Date:   Tue, 31 Oct 2023 15:16:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 5.4.y 0/1] Return EADDRNOTAVAIL when func matches several
 symbols during kprobe creation
Message-ID: <2023103148-bride-railing-ece8@gregkh>
References: <2023102137-mobster-sheath-bfb3@gregkh>
 <20231023113623.36423-1-flaniel@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023113623.36423-1-flaniel@linux.microsoft.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 23, 2023 at 02:36:22PM +0300, Francis Laniel wrote:
> Hi.
> 
> 
> There was problem to apply upstream patch on kernel 5.4.
> 
> I adapted the patch and came up with the attached one, it was tested and
> validated:
> root@vm-amd64:~# uname -a
> Linux vm-amd64 5.4.258+ #121 SMP Mon Oct 23 14:22:43 EEST 2023 x86_64 GNU/Linux
> root@vm-amd64:~# echo 'p:probe/name_show name_show' > /sys/kernel/tracing/kprobe_events
> bash: echo: write error: Cannot assign requested address
> 
> As I had to modify the patch, I would like to get reviews before getting it
> merged in stable.
> 
> Francis Laniel (1):
>   tracing/kprobes: Return EADDRNOTAVAIL when func matches several
>     symbols
> 
>  kernel/trace/trace_kprobe.c | 74 +++++++++++++++++++++++++++++++++++++
>  kernel/trace/trace_probe.h  |  1 +
>  2 files changed, 75 insertions(+)
> 

I don't see a 5.10.y version of this, did I miss it somewhere?

thanks,

greg k-h
