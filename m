Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650F3777F13
	for <lists+stable@lfdr.de>; Thu, 10 Aug 2023 19:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjHJRZB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 10 Aug 2023 13:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjHJRZA (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 10 Aug 2023 13:25:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F104A211C;
        Thu, 10 Aug 2023 10:24:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F3AF66446;
        Thu, 10 Aug 2023 17:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32A3C433C8;
        Thu, 10 Aug 2023 17:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691688299;
        bh=/Zv74iuYLIGvIl2fwN2rzFt5+sonZn4dvwTGENTN3Q8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e1ubrhY3Lvnofjcb2mBNUF+T6cw7W7HF8bfyW4IgfDUTmY0Rrr08K0FZVq+mMIZdS
         CDqllhxkWbyFwgcWkXNI+Wb0e63kiWOTj3OpUTntUVxRn/421VWQcMwgTp/xCUPrfJ
         hOBdpy72+fIHMD8AObZ0VG7Aj8svdaDwmcEiimZnTOCBM0gyDpJgS8VLdbhoDUWV8g
         2l3GjQ7t90keiPpIgynR4woYo0TCVxg5qFChItqNI4dbc+C0PRE/FN/8J7PVuDEqTv
         2YVIcFLv8nGsoT0xOJtmOZjXG04jEbIlPC36EI8G+8iS9gD6ZQAw7IfHz1XHUr5YhN
         ydpfXNmnp9v/A==
Date:   Thu, 10 Aug 2023 17:24:57 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Jens Axboe <axboe@kernel.dk>, Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, kernel-team@meta.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v4] blk-crypto: dynamically allocate fallback profile
Message-ID: <20230810172457.GC701926@google.com>
References: <20230810142346.96772-1-sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810142346.96772-1-sweettea-kernel@dorminy.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Aug 10, 2023 at 10:21:16AM -0400, Sweet Tea Dorminy wrote:
> +	/* Dynamic allocation is needed because of lockdep_register_key(). */
> +	blk_crypto_fallback_profile =
> +		kzalloc(sizeof(*blk_crypto_fallback_profile), GFP_KERNEL);
> +	if (!blk_crypto_fallback_profile)
>  		goto fail_free_bioset;

err needs to be set to -ENOMEM on failure here.  See the suggestion I gave in v1

- Eric
