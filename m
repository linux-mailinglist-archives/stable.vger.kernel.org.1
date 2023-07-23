Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F5475E4DE
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 22:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjGWUer (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 16:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjGWUeq (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 16:34:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD374E49
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 13:34:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE11160E9D
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 20:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881CFC433C8;
        Sun, 23 Jul 2023 20:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690144484;
        bh=9WgpUAOc96B6MygGPgzEPDsjIP9TxlbrSmGa6QoZwIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dnXlFkC4eqyy8CCJpQUsv1drhveAWkoP2ySZaSbHfEIUfKlWqeugHAu+5X8QKI+g+
         W+8rmr/hw87JcmyUs92jWXjV9cED4Xp9O0d8mYLpEfmaZGWdjSAXYrE8AGNzWilIRq
         bYRAaJ2l7OtytbbfJQacLYFiYQRICtf/ZTQ38DNA=
Date:   Sun, 23 Jul 2023 22:34:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH 6.4.y] i2c: busses: i2c-nomadik: Remove a useless call in
 the remove function
Message-ID: <2023072303-ranking-wife-05ae@gregkh>
References: <2023072154-animal-dropkick-6a92@gregkh>
 <62fe6800d41e04a4eb5adfa18a9e1090cbc72256.1688160163.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62fe6800d41e04a4eb5adfa18a9e1090cbc72256.1688160163.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jul 21, 2023 at 07:47:41PM +0200, Christophe JAILLET wrote:
> Since commit 235602146ec9 ("i2c-nomadik: turn the platform driver to an amba
> driver"), there is no more request_mem_region() call in this driver.
> 
> So remove the release_mem_region() call from the remove function which is
> likely a left over.
> 
> Fixes: 235602146ec9 ("i2c-nomadik: turn the platform driver to an amba driver")
> Cc: <stable@vger.kernel.org> # v3.6+
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> The patch below that should fix a merge conflict related to commit
> 9c7174db4cdd1 ("i2c: nomadik: Use devm_clk_get_enabled()") has been 
> HAND MODIFIED.

I don't understand, that commit is not in the stable trees.  What do you
mean by "hand modified"?

> I hope it is fine, but is provided as-is. Especially line numbers should be
> wrong, but 'patch' should be able to deal with it. (sorry if it does not apply)
> 
> I guess that it should also apply to all previous branches.
> 
> I've left the commit description as it was. Not sure what to do with A-b and R-b
> tags.

Why isn't this needed in Linus's tree?

confused,

greg k-h
