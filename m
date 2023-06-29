Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3164742569
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 14:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjF2MKJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 08:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjF2MKG (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 08:10:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EF7BC
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 05:10:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AE7A6153B
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 12:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AABEC433C8;
        Thu, 29 Jun 2023 12:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688040604;
        bh=4pLJqW81xARU74oR2QmpvC2RfXivxqTltCUN4mU7viQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RV4LYY6cMrN+9Imd4jqTfUO34QQ88ainMeYE9vBZJOexf4aYK7pEkxAdD08JNuF34
         0GXIqYfCTG921KT0yqEgL2WJXB+/+XetQ/ly8vbNKfQjvKFCJOvzAU50pJEp/k9UUc
         sRuOEhuiGEt8sAwRbz/OdAy0Lae6wjgErnZHL8vw=
Date:   Thu, 29 Jun 2023 14:10:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH 5.15.y v2] bpf: ensure main program has an extable
Message-ID: <2023062954-oppressor-curled-50ed@gregkh>
References: <20230628230339.GB1918@templeofstupid.com>
 <20230629013508.GF1918@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629013508.GF1918@templeofstupid.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jun 28, 2023 at 06:35:08PM -0700, Krister Johansen wrote:
> commit 0108a4e9f3584a7a2c026d1601b0682ff7335d95 upstream.
> 
> When subprograms are in use, the main program is not jit'd after the
> subprograms because jit_subprogs sets a value for prog->bpf_func upon
> success.  Subsequent calls to the JIT are bypassed when this value is
> non-NULL.  This leads to a situation where the main program and its
> func[0] counterpart are both in the bpf kallsyms tree, but only func[0]
> has an extable.  Extables are only created during JIT.  Now there are
> two nearly identical program ksym entries in the tree, but only one has
> an extable.  Depending upon how the entries are placed, there's a chance
> that a fault will call search_extable on the aux with the NULL entry.
> 
> Since jit_subprogs already copies state from func[0] to the main
> program, include the extable pointer in this state duplication.
> Additionally, ensure that the copy of the main program in func[0] is not
> added to the bpf_prog_kallsyms table. Instead, let the main program get
> added later in bpf_prog_load().  This ensures there is only a single
> copy of the main program in the kallsyms table, and that its tag matches
> the tag observed by tooling like bpftool.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1c2a088a6626 ("bpf: x64: add JIT support for multi-function programs")
> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Link: https://lore.kernel.org/r/6de9b2f4b4724ef56efbb0339daaa66c8b68b1e7.1686616663.git.kjlx@templeofstupid.com
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> ---
>  kernel/bpf/verifier.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Now queued up, thanks.

greg k-h
