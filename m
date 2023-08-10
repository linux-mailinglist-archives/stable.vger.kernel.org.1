Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2229776F4E
	for <lists+stable@lfdr.de>; Thu, 10 Aug 2023 06:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjHJE7K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 10 Aug 2023 00:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjHJE7K (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 10 Aug 2023 00:59:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0390C1BCF;
        Wed,  9 Aug 2023 21:59:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89DFB63FAB;
        Thu, 10 Aug 2023 04:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DE7C433C8;
        Thu, 10 Aug 2023 04:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691643548;
        bh=MOXfvY/smRlZ6Fw2y7tT0hpcb3a2PrHa62ZRHy7oHrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UwL28J1ByMYT0T4TNq3msws572zFhHgMuOQR5aOpxrT80OVNhL01BE5d/2gtVFo9m
         5ZTZpwpy2rUZyns+IIyzSJC2yWGZN1mSB50/qqA9kUJGmIo/UQP8m61LPUpdcV9aJf
         xPVem5hX0Jxlg2Bzpb1QcCJIU9J/uNR1LsH0Y9KmzpgSF0VO2DAaJ0a+LEJ7ACxNZd
         SX1GGEPg+7tQRy8uKi/XG6dB4NjSzgQ6JZWrUefQPxO+VINiczL9IbWrP22Kq87gwv
         PFvWUYwyAIehhNk+ON9opE7gtUQ8PwdHzu+MUfcZGxiIGpJJfl+Fs68vt0LLEP7J1l
         mQC/wqGEPW3kA==
Date:   Wed, 9 Aug 2023 21:59:07 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Jens Axboe <axboe@kernel.dk>, Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, kernel-team@meta.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] blk-crypto: dynamically allocate fallback profile
Message-ID: <20230810045907.GB923@sol.localdomain>
References: <20230809125628.529884-1-sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809125628.529884-1-sweettea-kernel@dorminy.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Aug 09, 2023 at 08:56:22AM -0400, Sweet Tea Dorminy wrote:
>  
> +	blk_crypto_fallback_profile =
> +		kzalloc(sizeof(*blk_crypto_fallback_profile), GFP_KERNEL);
> +

I think you missed part of my feedback on v1.

- Eric
