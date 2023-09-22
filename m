Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1997AADC8
	for <lists+stable@lfdr.de>; Fri, 22 Sep 2023 11:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjIVJYI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 22 Sep 2023 05:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjIVJYH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 22 Sep 2023 05:24:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEF3195
        for <stable@vger.kernel.org>; Fri, 22 Sep 2023 02:24:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA32C433C7;
        Fri, 22 Sep 2023 09:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695374641;
        bh=DwZlnZLgXMNE+ZzleFxHPJhiKoucAi8CLZr5qGACYT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XuEReGEy6/Fflv32/L1U+m1afbZOqvChX5fHEAAK03QFmA1nRDGs+lfwZfY9U83GT
         UfcTXROIP8itTGH8xpqrufbAZRPIGHR1cG97Mua1itShcTYu8XEa+AC6y0evCUcvLR
         oMZ4GD1p3XnUMHMoZY07mxaNF4mH8mAaUSAam5KI=
Date:   Fri, 22 Sep 2023 11:23:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhangshida <starzhangzsd@gmail.com>
Cc:     stable@vger.kernel.org, Shida Zhang <zhangshida@kylinos.cn>,
        stable@kernel.org, Andreas Dilger <adilger@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] ext4: fix rec_len verify error
Message-ID: <2023092232-squash-buggy-51c7@gregkh>
References: <2023092057-company-unworried-210b@gregkh>
 <20230922053915.2176290-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922053915.2176290-1-zhangshida@kylinos.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Sep 22, 2023 at 01:39:15PM +0800, zhangshida wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
> 
> [ Upstream commit 7fda67e8c3ab6069f75888f67958a6d30454a9f6 ]
> 
> With the configuration PAGE_SIZE 64k and filesystem blocksize 64k,
> a problem occurred when more than 13 million files were directly created
> under a directory:
> 
> EXT4-fs error (device xx): ext4_dx_csum_set:492: inode #xxxx: comm xxxxx: dir seems corrupt?  Run e2fsck -D.
> EXT4-fs error (device xx): ext4_dx_csum_verify:463: inode #xxxx: comm xxxxx: dir seems corrupt?  Run e2fsck -D.
> EXT4-fs error (device xx): dx_probe:856: inode #xxxx: block 8188: comm xxxxx: Directory index failed checksum
> 
> When enough files are created, the fake_dirent->reclen will be 0xffff.
> it doesn't equal to the blocksize 65536, i.e. 0x10000.
> 
> But it is not the same condition when blocksize equals to 4k.
> when enough files are created, the fake_dirent->reclen will be 0x1000.
> it equals to the blocksize 4k, i.e. 0x1000.
> 
> The problem seems to be related to the limitation of the 16-bit field
> when the blocksize is set to 64k.
> To address this, helpers like ext4_rec_len_{from,to}_disk has already
> been introduced to complete the conversion between the encoded and the
> plain form of rec_len.
> 
> So fix this one by using the helper, and all the other in this file too.
> 
> Cc: stable@kernel.org
> Fixes: dbe89444042a ("ext4: Calculate and verify checksums for htree nodes")
> Suggested-by: Andreas Dilger <adilger@dilger.ca>
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Link: https://lore.kernel.org/r/20230803060938.1929759-1-zhangshida@kylinos.cn
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  fs/ext4/namei.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)

What stable tree(s) are you asking this to be backported to?

thanks,

greg k-h
