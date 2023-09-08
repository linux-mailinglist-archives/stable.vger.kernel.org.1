Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EF8798B03
	for <lists+stable@lfdr.de>; Fri,  8 Sep 2023 18:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245340AbjIHQxe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 8 Sep 2023 12:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245289AbjIHQxd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 8 Sep 2023 12:53:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D63E1FEA
        for <stable@vger.kernel.org>; Fri,  8 Sep 2023 09:53:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5A3C4339A;
        Fri,  8 Sep 2023 16:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694191978;
        bh=sU4v+od5PLBYHh32sV9iILr3OVekzY6/oinl+MuYJc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZRtYlNKnhRGmsd2idCI4NELMh7bkJ6beh2B200er3XWCORMnC+np+rTmJLzExQywO
         ia8cbbdS8n1ATjGZwDn1pVpfNpvvC2pnXWPJSWBukfcth5hVDQYsA2hPvpZsQAnpV+
         XGKMV1F13PgLxlMW0Kmvnq+It66lsFoSLiVjroX4=
Date:   Fri, 8 Sep 2023 17:52:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        llvm@lists.linux.dev, bpf@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: Apply 13e07691a16f and co. to linux-6.1.y
Message-ID: <2023090821-octopus-unreal-87a2@gregkh>
References: <20230908161526.GA3344687@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908161526.GA3344687@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Sep 08, 2023 at 09:15:26AM -0700, Nathan Chancellor wrote:
> Hi Greg and Sasha,
> 
> Please consider applying the following commits to 6.1 (they all picked
> cleanly for me):
> 
> 630ae80ea1dd ("tools lib subcmd: Add install target")
> 77dce6890a2a ("tools lib subcmd: Make install_headers clearer")
> 5d890591db6b ("tools lib subcmd: Add dependency test to install_headers")
> 0e43662e61f2 ("tools/resolve_btfids: Use pkg-config to locate libelf")
> af03299d8536 ("tools/resolve_btfids: Install subcmd headers")
> 13e07691a16f ("tools/resolve_btfids: Alter how HOSTCC is forced")
> 56a2df7615fa ("tools/resolve_btfids: Compile resolve_btfids as host program")
> e0975ab92f24 ("tools/resolve_btfids: Tidy HOST_OVERRIDES")
> 2531ba0e4ae6 ("tools/resolve_btfids: Pass HOSTCFLAGS as EXTRA_CFLAGS to prepare targets")
> edd75c802855 ("tools/resolve_btfids: Fix setting HOSTCFLAGS")
> 
> The most critical change is 13e07691a16f, which resolves a missing
> EXTRA_CFLAGS to the libsubcmd build. Without that EXTRA_CFLAGS, the
> Android hermetic toolchain kernel build fails on host distributions
> using glibc 2.38 and newer. The majority of those commits are strictly
> needed due to dependency/fixes requirements, the few that are not still
> seem to be worth bringing in for ease of backporting the rest and do not
> appear to cause any problems.
> 
> I proposed another solution downstream, which may be more palatable if
> people have concerns about this list of changes and the risk of
> regressions, but Ian seemed to have some concerns on that thread around
> that path and suggested this series of backports instead:
> 
> https://android-review.googlesource.com/c/kernel/common/+/2745896
> 
> While the number of patches seems large, the final changes are pretty
> well self-contained.

All now queued up, thanks.

greg k-h
