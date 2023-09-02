Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7C6790612
	for <lists+stable@lfdr.de>; Sat,  2 Sep 2023 10:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbjIBIUC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 2 Sep 2023 04:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjIBIUC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 2 Sep 2023 04:20:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAC1CC
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 01:19:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6BA1601CF
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 08:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E0DC433C7;
        Sat,  2 Sep 2023 08:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693642798;
        bh=H0jZqmHxH11HljCzA78hnoFPkjwFhKanZixbXINjobs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rkWAQIBxh+9EERTp4a5XHaPfTjO6yHFovioiIz4JRZdC5nZbd4AZAWgpnVrOxiPje
         HJZHuq6I0x2SAN5cRKt6SNZfiV5RipnFdhuauEJKpsMjn9Hrg17mz4lSMhc/wtryfK
         JIrAhbfd7ZCu3Z2GB283X6ctWfFO5ugSAY5dqWX8=
Date:   Sat, 2 Sep 2023 10:19:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     stable@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        keltargw <keltar.gw@gmail.com>
Subject: Re: [PATCH 6.5.y] erofs: ensure that the post-EOF tails are all
 zeroed
Message-ID: <2023090247-consonant-hangnail-ef8c@gregkh>
References: <20230831112959.99884-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831112959.99884-1-hsiangkao@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Aug 31, 2023 at 07:29:53PM +0800, Gao Xiang wrote:
> commit e4c1cf523d820730a86cae2c6d55924833b6f7ac upstream.
> 
> This was accidentally fixed up in commit e4c1cf523d82 but we can't
> take the full change due to other dependancy issues, so here is just
> the actual bugfix that is needed.
> 
> [Background]
> 
> keltargw reported an issue [1] that with mmaped I/Os, sometimes the
> tail of the last page (after file ends) is not filled with zeroes.
> 
> The root cause is that such tail page could be wrongly selected for
> inplace I/Os so the zeroed part will then be filled with compressed
> data instead of zeroes.
> 
> A simple fix is to avoid doing inplace I/Os for such tail parts,
> actually that was already fixed upstream in commit e4c1cf523d82
> ("erofs: tidy up z_erofs_do_read_page()") by accident.
> 
> [1] https://lore.kernel.org/r/3ad8b469-25db-a297-21f9-75db2d6ad224@linux.alibaba.com
> 
> Reported-by: keltargw <keltar.gw@gmail.com>
> Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/zdata.c | 2 ++
>  1 file changed, 2 insertions(+)

All now queued up, thanks.

greg k-h
