Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C85F761E2A
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 18:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjGYQNv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 12:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjGYQNr (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 12:13:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E539E78
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 09:13:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DADFD617DC
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 16:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1912BC433C7;
        Tue, 25 Jul 2023 16:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690301625;
        bh=pA6OkiGQ+L6zB+DkGYGhgcqo0H9GLDXi4G7aQNpHWEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L8F+k6yL95qjEOtSRSatYMaRUVi+5eNUAKOVxlSCsnQwCHl1BFDpxqC0dIURr7pge
         QNt0Ddn16O+nSqVYu9Ev+7qg+1TqWC8NZucEm9TlSSpH4K631ZOf1AsQFSjRAOHwB9
         LaqquOy2KT1jzRiu+GTKpi9TH6HX/Qyf7uKy72Z5T0RAprm5wYzCwYgV1kHQUct+KH
         X0/cow+60LU6GGYXRY+fIxqpNQ2Miy8kc4KQ6741uCbiDfYwvffcptB6WTTV2rACdD
         CV1cADUJdIZgS5dceFQdqZYAGBqTp4rQaE95Lxh4LRI8Ql+i9f9zhGTwYEa0UVoetx
         nksdvzbx6FBNw==
Date:   Tue, 25 Jul 2023 09:13:43 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 113/313] crypto: skcipher - unify the
 crypto_has_skcipher*() functions
Message-ID: <20230725161343.GA2295@sol.localdomain>
References: <20230725104521.167250627@linuxfoundation.org>
 <20230725104525.907419883@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725104525.907419883@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jul 25, 2023 at 12:44:26PM +0200, Greg Kroah-Hartman wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> [ Upstream commit d3ca75a8b3d77f2788e6c119ea7c3e3a1ab1e1ca ]
> 
> crypto_has_skcipher() and crypto_has_skcipher2() do the same thing: they
> check for the availability of an algorithm of type skcipher, blkcipher,
> or ablkcipher, which also meets any non-type constraints the caller
> specified.  And they have exactly the same prototype.
> 
> Therefore, eliminate the redundancy by removing crypto_has_skcipher()
> and renaming crypto_has_skcipher2() to crypto_has_skcipher().
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> Stable-dep-of: efbc7764c444 ("crypto: marvell/cesa - Fix type mismatch warning")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  crypto/skcipher.c         |  4 ++--
>  include/crypto/skcipher.h | 19 +------------------
>  2 files changed, 3 insertions(+), 20 deletions(-)

How is this a Stable-dep-of "crypto: marvell/cesa - Fix type mismatch warning"?

I don't understand why this is being backported.

- Eric
