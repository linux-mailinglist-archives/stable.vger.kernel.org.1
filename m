Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC0A738EE8
	for <lists+stable@lfdr.de>; Wed, 21 Jun 2023 20:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjFUSem (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 21 Jun 2023 14:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjFUSek (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Jun 2023 14:34:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9275E199F
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 11:34:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB21161657
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 18:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE804C433C0;
        Wed, 21 Jun 2023 18:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687372471;
        bh=nVh7vSp7iEktJTC6uClRqJWe2XTX8B/qdkEDY7q50I8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U7ptex5Xvgf0XzEsgA+6OAUnUOwDYbsg1rS2xhQaZ4XiQ5Dsj9z8Uv++YMpV2wycf
         DHpacSx89Vr9+YWTdhWws0wX0ewikxHww17qIuNjP8TvUNFc395PU/qXKZK5aLlPNn
         j9XR+aYgspVK3HxJVFYNE5NJNfaZW52eW5U5Y++8=
Date:   Wed, 21 Jun 2023 20:34:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4.14 4.19 5.4] nilfs2: reject devices with insufficient
 block count
Message-ID: <2023062120-whiff-slip-72d2@gregkh>
References: <20230619105524.3932-1-konishi.ryusuke@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619105524.3932-1-konishi.ryusuke@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jun 19, 2023 at 07:55:24PM +0900, Ryusuke Konishi wrote:
> commit 92c5d1b860e9581d64baca76779576c0ab0d943d upstream.
> 
> The current sanity check for nilfs2 geometry information lacks checks for
> the number of segments stored in superblocks, so even for device images
> that have been destructively truncated or have an unusually high number of
> segments, the mount operation may succeed.
> 
> This causes out-of-bounds block I/O on file system block reads or log
> writes to the segments, the latter in particular causing
> "a_ops->writepages" to repeatedly fail, resulting in sync_inodes_sb() to
> hang.
> 
> Fix this issue by checking the number of segments stored in the superblock
> and avoiding mounting devices that can cause out-of-bounds accesses.  To
> eliminate the possibility of overflow when calculating the number of
> blocks required for the device from the number of segments, this also adds
> a helper function to calculate the upper bound on the number of segments
> and inserts a check using it.
> 
> Link: https://lkml.kernel.org/r/20230526021332.3431-1-konishi.ryusuke@gmail.com
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Reported-by: syzbot+7d50f1e54a12ba3aeae2@syzkaller.appspotmail.com
>   Link: https://syzkaller.appspot.com/bug?extid=7d50f1e54a12ba3aeae2
> Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> Please apply this patch to the above stable trees instead of the patch
> that could not be applied to them.  The hang issue reported by syzbot was
> confirmed to reproduce on these stable kernels using its reproducer.
> This fixes it.
> 
> In this patch, "sb_bdev_nr_blocks()" and "nilfs_err()" are replaced with
> their equivalents since they don't yet exist in these kernels.  With these
> tweaks, this patch is applicable from v4.8 to v5.8.  Also, this patch has
> been tested against the title stable trees.

Now queued up, thanks.

greg k-h
