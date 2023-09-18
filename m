Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6027A3F83
	for <lists+stable@lfdr.de>; Mon, 18 Sep 2023 04:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjIRCxh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 22:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235866AbjIRCxZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 22:53:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808B298
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 19:53:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA78DC433C7;
        Mon, 18 Sep 2023 02:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695005600;
        bh=GJjOhUP4OKDfkDNhn3pYK9zC2cKS3WVCHaHu8CtXp2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eYXQOChEKhGUCuReprgPoeSS9k2OlXKjRVPcKueJJMmFRqhnxdCalw2wowD6ApjLC
         qzof5cpD21OmyUDih5Vs3dEnrk0EhitbOftxbULF0ad4FaiJWOib/0rvQwNwNk/7OK
         sA7CdeDvDxOKe0f8eS3L+08a3zfAxul7fDVeHAousNvgXm6T6Qo0YMB+PsB4uW4M0j
         fHPNzbYhTIB346x/IoZV+cYdano9Tsw7DNzn575Bu06ZlAqmq+AOYpLm9V97hmrajm
         3o+i8AD4YNdPDlKTje/LIO0PLawT0cFqQzFoOxMkIcTclQiJoOWAO2Q4ZhI+6gMFC+
         KsSBpjddvdyZQ==
Date:   Sun, 17 Sep 2023 19:53:18 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 096/406] crypto: blake2b - sync with blake2s
 implementation
Message-ID: <20230918025318.GA5356@sol.localdomain>
References: <20230917191101.035638219@linuxfoundation.org>
 <20230917191103.663752909@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917191103.663752909@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Sep 17, 2023 at 09:09:10PM +0200, Greg Kroah-Hartman wrote:
> 5.10-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Eric Biggers <ebiggers@google.com>
> 
> [ Upstream commit 28dcca4cc0c01e2467549a36b1b0eacfdb01236c ]
> 
> Sync the BLAKE2b code with the BLAKE2s code as much as possible:
> 
> - Move a lot of code into new headers <crypto/blake2b.h> and
>   <crypto/internal/blake2b.h>, and adjust it to be like the
>   corresponding BLAKE2s code, i.e. like <crypto/blake2s.h> and
>   <crypto/internal/blake2s.h>.
> 
> - Rename constants, e.g. BLAKE2B_*_DIGEST_SIZE => BLAKE2B_*_HASH_SIZE.
> 
> - Use a macro BLAKE2B_ALG() to define the shash_alg structs.
> 
> - Export blake2b_compress_generic() for use as a fallback.
> 
> This makes it much easier to add optimized implementations of BLAKE2b,
> as optimized implementations can use the helper functions
> crypto_blake2b_{setkey,init,update,final}() and
> blake2b_compress_generic().  The ARM implementation will use these.
> 
> But this change is also helpful because it eliminates unnecessary
> differences between the BLAKE2b and BLAKE2s code, so that the same
> improvements can easily be made to both.  (The two algorithms are
> basically identical, except for the word size and constants.)  It also
> makes it straightforward to add a library API for BLAKE2b in the future
> if/when it's needed.
> 
> This change does make the BLAKE2b code slightly more complicated than it
> needs to be, as it doesn't actually provide a library API yet.  For
> example, __blake2b_update() doesn't really need to exist yet; it could
> just be inlined into crypto_blake2b_update().  But I believe this is
> outweighed by the benefits of keeping the code in sync.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> Stable-dep-of: 9ae4577bc077 ("crypto: api - Use work queue in crypto_destroy_instance")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

1.) This isn't a Stable-dep-of 9ae4577bc077.   I don't see why this is being
backported.

2.) On lore.kernel.org, there is no record of this patch being queued to 5.10.
See https://lore.kernel.org/all/?q=%22sync+with+blake2s+implementation%22.  The
first mention of 5.10 and this patch is this thread, which is already the -rc1
review.  I guess the only list that the initial "patch was queued" email was
sent to is stable-commits, and stable-commits is not archived on
lore.kernel.org.  That is surprising and makes it harder for people to give
feedback on patches going into stable.  stable-commits should be archived on
lore.kernel.lorg, and patches should generally be sent to more lists as well.
(I'm probably shouting into a void here as I've given this same feedback on
other patches before and nothing changed, but here it is again...)

- Eric
