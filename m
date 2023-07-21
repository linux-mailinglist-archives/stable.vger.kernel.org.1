Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2DF75BDC5
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 07:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjGUF3e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 01:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGUF3d (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 01:29:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547A2E42
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 22:29:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB3CA61040
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 05:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE5DC433C7;
        Fri, 21 Jul 2023 05:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689917371;
        bh=tuJeRgv7TQnIDYC22XsvhrtB1NsxJJcI8Voy1qzUk7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uOsGheJ3Zu5txt/o9FqthtwaVa//QAdmpBWH99K8J/rlRkxCXgXR9vbbX+SSJkeb2
         DfWLEWotewqRjH0z9modii95ubeRa6fiESnhnhT6UG3rhSsr4/8MpyELzj/BT7C7Vx
         RCXSOtphjJ3tc9mPrj7fEPLUFM837igcfOX9BZ2g=
Date:   Fri, 21 Jul 2023 07:29:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     stable@vger.kernel.org, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH stable 5.15.y] erofs: fix compact 4B support for 16k
 block size
Message-ID: <2023072115-problem-cleaver-9f4b@gregkh>
References: <20230721022221.23060-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721022221.23060-1-hsiangkao@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jul 21, 2023 at 10:22:21AM +0800, Gao Xiang wrote:
> commit 001b8ccd0650727e54ec16ef72bf1b8eeab7168e upstream.
> 
> In compact 4B, two adjacent lclusters are packed together as a unit to
> form on-disk indexes for effective random access, as below:
> 
> (amortized = 4, vcnt = 2)
>        _____________________________________________
>       |___@_____ encoded bits __________|_ blkaddr _|
>       0        .                                    amortized * vcnt = 8
>       .             .
>       .                  .              amortized * vcnt - 4 = 4
>       .                        .
>       .____________________________.
>       |_type (2 bits)_|_clusterofs_|
> 
> Therefore, encoded bits for each pack are 32 bits (4 bytes). IOWs,
> since each lcluster can get 16 bits for its type and clusterofs, the
> maximum supported lclustersize for compact 4B format is 16k (14 bits).
> 
> Fix this to enable compact 4B format for 16k lclusters (blocks), which
> is tested on an arm64 server with 16k page size.
> 
> Fixes: 152a333a5895 ("staging: erofs: add compacted compression indexes support")
> Link: https://lore.kernel.org/r/20230601112341.56960-1-hsiangkao@linux.alibaba.com
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> resolve a trivial conflict.

All now queued up.

thanks,

greg k-h
