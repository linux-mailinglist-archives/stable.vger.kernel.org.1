Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BCA70C4B1
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 19:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbjEVRvv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 13:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbjEVRvv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 13:51:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A64102;
        Mon, 22 May 2023 10:51:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03EFE622B0;
        Mon, 22 May 2023 17:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CBAC433EF;
        Mon, 22 May 2023 17:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684777909;
        bh=vNnPOWke6lgIDP9BJRuduaGtTz3A2TJkE1uAy0zNEtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b+l7I0OpRds2V84dDBVDjidVF9z0+KHOEV1Q5Bvlslq+SUQ+GfYUbfL5e4xtwdGro
         hq/E0m9OrhrLaxD5oG3D6WlxklmgOOh3JYEOV5eQS1Au4Ij/Dnud2h3SDe/ar0eFXg
         SJTXHr4vdiiApcwitIIpk7gWoH9Nq7CQSRwBwEJ57KiBlNqvjfZ8yLoKkeXktosEwq
         /U+0KGvOa0N3WQ0HdRqY507EbRBR/vD3fuu5sK2woyZUELNPwdnXpb00H2AM6NKMMY
         PnxMpZszzTLExDp8dmdnK/J/VUv7pBPiRC8xIPJBoWPlA9Bu2LwJyUnhyDEkKwkoON
         7yn8aXSTydngg==
Date:   Mon, 22 May 2023 13:51:48 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     stable@vger.kernel.org, linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 6.1] crypto: testmgr - fix RNG performance in fuzz tests
Message-ID: <ZGurtNEsFJahQpSx@sashalap>
References: <20230516050850.59514-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230516050850.59514-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 15, 2023 at 10:08:50PM -0700, Eric Biggers wrote:
>From: Eric Biggers <ebiggers@google.com>
>
>commit f900fde28883602b6c5e1027a6c912b673382aaf upstream.

Thanks for the backport!

-- 
Thanks,
Sasha
