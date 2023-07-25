Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B1B761E2B
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 18:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjGYQOX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 12:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjGYQOJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 12:14:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A64E78
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 09:14:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C4DE61777
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 16:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63136C433C8;
        Tue, 25 Jul 2023 16:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690301647;
        bh=eEmH4253Zrw0uIVPXVVtcN9ynNTF5NNQUGdCv7XBues=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hNo11HisnojVzIpPxfh5fLfqusZs9yaMqg417qVXC1KRfFkp5loIzbXwEhkOV+X/Q
         53eI1NIaJoJMCCTcVnq9Q2hHwXDWle73I3bU/ZFfUEVgF7Dw3HI5YGqh6DHJJdfbmo
         Tm9AIHZtt56LVsBvEY6kiDV+U1wF3H/G9uQC696ka7SLeA6DRfdsbDqUNGXdKcAZqI
         +QPs23zHCPIidi8fVf4iRdK7Bupf0k+0EyCeZMFtaz9gX8T3EKX4VzmOk6dmNBH9/M
         R+xgRLA3pfcpoHfU2rAfSUlJ9fFY4+frt/lh4GDjZs0LueY56vQdbwYg/AZLnKKQe9
         9VkaDn5CpQtiQ==
Date:   Tue, 25 Jul 2023 09:14:05 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 114/313] crypto: skcipher - remove
 crypto_has_ablkcipher()
Message-ID: <20230725161405.GB2295@sol.localdomain>
References: <20230725104521.167250627@linuxfoundation.org>
 <20230725104525.956502242@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725104525.956502242@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jul 25, 2023 at 12:44:27PM +0200, Greg Kroah-Hartman wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> [ Upstream commit cec0cb8a28f9060367099beeafd0dbdb76fdfae2 ]
> 
> crypto_has_ablkcipher() has no users, and it does the same thing as
> crypto_has_skcipher() anyway.  So remove it.  This also removes the last
> user of crypto_skcipher_type() and crypto_skcipher_mask(), so remove
> those too.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> Stable-dep-of: efbc7764c444 ("crypto: marvell/cesa - Fix type mismatch warning")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  Documentation/crypto/api-skcipher.rst |  2 +-
>  include/linux/crypto.h                | 31 ---------------------------
>  2 files changed, 1 insertion(+), 32 deletions(-)

How is this a Stable-dep-of "crypto: marvell/cesa - Fix type mismatch warning"?

I don't understand why this is being backported.

- Eric
