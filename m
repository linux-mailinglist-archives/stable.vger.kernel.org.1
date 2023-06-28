Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61DF741C89
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 01:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjF1XjW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 19:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjF1XjU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 19:39:20 -0400
Received: from cheetah.elm.relay.mailchannels.net (cheetah.elm.relay.mailchannels.net [23.83.212.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5C2132
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 16:39:19 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 01D595C17BC
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 23:39:19 +0000 (UTC)
Received: from pdx1-sub0-mail-a212.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 61BBF5C1DB7
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 23:39:18 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1687995558; a=rsa-sha256;
        cv=none;
        b=HJe8StJ3x5lCAsqAVh79CFg9/vCgp+uBffLcs0YQsMXfnATIqWbqiwdtD0n6yX2wc5oUY0
        pBUjmfHNQ+4xJXVvcdl+ABa1SrKz4D4mxBtSKs2u7Pxu00MJJdPbOffls7Yi6CD8NoWsZD
        h8NLENS+jHBugEhrCqnZo0+U0F64TsBnI7kWbBQbFsZRKcE+zaMvCc6Sk19m39YjqFAltw
        DSCJvAdZEa3TnUkeJ4WZVWFhRueTwCShFqXs08d6y+wdee37So6/xsOoOpVPgqNriu4U/K
        AD/agkFqSWPlg0xtHr+r2R4VDUruZQxVWpLQ39X4M1TAwWd0KhH2OfkYoI9ssQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1687995558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=B7lcoTs7w6lIquy5g4GeX2UREmgd7V76HkDIWThAuoI=;
        b=20nYo32XcTglUNapKRJlogTrOBLMbRdJrLpMUF93vNilm786dq6539xUzcJLNemfID1VLA
        ClsO1155qIvcxYYGG5WzyRbjDwUCDf/ZuTQ3iJglrviRK5DSW8ZD4L9inHn62p/s6Z7q5v
        HNXzfrhhhLXfiR9iuX4xPnyY7oulm8dII9wfC+RrlKkEODzWNAvUmMT5HU8S9RzFGlFYLK
        WCXRWvsNaClvbRljOvB3Y9jcerlnq+77RHpAzXcxxvcGo+b6FCVSmwHJQB9VR5QgZJavcu
        3koSjISgw10QKl9vln+AL2kEczGMpaXJwxhW1bnBhpHDWKwSocPtCtEQtyYAyQ==
ARC-Authentication-Results: i=1;
        rspamd-9fcc56855-sbcmx;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Bitter-Vacuous: 3f8d3ced3daaa6bc_1687995558609_172846614
X-MC-Loop-Signature: 1687995558609:1037416525
X-MC-Ingress-Time: 1687995558608
Received: from pdx1-sub0-mail-a212.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.17 (trex/6.9.1);
        Wed, 28 Jun 2023 23:39:18 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a212.dreamhost.com (Postfix) with ESMTPSA id 4Qryj21GFTzVN
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 16:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1687995558;
        bh=B7lcoTs7w6lIquy5g4GeX2UREmgd7V76HkDIWThAuoI=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=rSezyb+7h/ZChGSIiEGQFBGblHhp4WqDpDr0LQ++h3s3F6itWm1reXrxG53CoUYcP
         kWjunMKhnI98ykDEM4/IgAeGXXSFx7A7Hi6d/kCyAwQiQZstHfncmGF68K2ZS8IQkc
         13icuJXKbre3BE93zsTcK3dJ1zT6/5fPfVpIcXXk=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e003b
        by kmjvbox (DragonFly Mail Agent v0.12);
        Wed, 28 Jun 2023 16:39:05 -0700
Date:   Wed, 28 Jun 2023 16:39:05 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     stable@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Yonghong Song <yhs@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5.15.y] bpf: ensure main program has an extable
Message-ID: <20230628233905.GE1918@templeofstupid.com>
References: <2023062341-reunite-senior-f0c0@gregkh>
 <20230628230339.GB1918@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628230339.GB1918@templeofstupid.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jun 28, 2023 at 04:03:39PM -0700, Krister Johansen wrote:
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
>  kernel/bpf/verifier.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4f2271f27a1d..a89cd34eb5d4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12588,9 +12588,10 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>  	}
>  
>  	/* finally lock prog and jit images for all functions and
> -	 * populate kallsysm
> +	 * populate kallsysm. Begin at the first subprogram, since
> +	 * bpf_prog_load will add the kallsyms for the main program.
>  	 */
> -	for (i = 0; i < env->subprog_cnt; i++) {
> +	for (i = 1; i < env->subprog_cnt; i++) {
>  		bpf_prog_lock_ro(func[i]);
>  		bpf_prog_kallsyms_add(func[i]);
>  	}
> @@ -12615,6 +12616,9 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>  
>  	prog->jited = 1;
>  	prog->bpf_func = func[0]->bpf_func;
> +	prog->jited_len = func[0]->jited_len;

This 'prog->jited_len' line wasn't part of the original commit and
appears to have snuck in during manual conflict resolution.  Let me
clean up and resubmit.  Apologies.

> +	prog->aux->extable = func[0]->aux->extable;
> +	prog->aux->num_exentries = func[0]->aux->num_exentries;
>  	prog->aux->func = func;
>  	prog->aux->func_cnt = env->subprog_cnt;
>  	bpf_prog_jit_attempt_done(prog);

-K
