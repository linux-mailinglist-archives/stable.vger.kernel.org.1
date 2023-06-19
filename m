Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D89B734CAA
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 09:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjFSHtT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 03:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjFSHtS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 03:49:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7DAC0
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 00:49:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81A6F61546
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 07:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DDBC433C8;
        Mon, 19 Jun 2023 07:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687160955;
        bh=l7dUVwYmbODu4Z76mwOSPosqr22uhn2ouKKwZmwWWZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CI5VtOcG+dujnYJFfNOR8xqOJMjMCfD4rPRhqDd3uSGWHmaxkh0DlcBgvskj46Qjq
         4TQAoyHb3bLlC/Nbx1QWS1WumO/Gbx0hRBjYiGIz3W0SgFb2F8rQkUBo1MsOR8Uy4S
         wRwzzEIlPW7ubvpE1umXqEp2fcp5AX1qPF91Scd4=
Date:   Mon, 19 Jun 2023 09:49:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5.10 5.15] nilfs2: reject devices with insufficient block
 count
Message-ID: <2023061957-unsigned-antirust-a017@gregkh>
References: <20230618183519.2411-1-konishi.ryusuke@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230618183519.2411-1-konishi.ryusuke@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jun 19, 2023 at 03:35:19AM +0900, Ryusuke Konishi wrote:
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
> In this patch, "sb_bdev_nr_blocks()" is replaced with its equivalent since
> it doesn't yet exist in these kernels.  With this tweak, this patch is
> applicable from v5.9 to v5.15.  Also, this patch has been tested against
> the title stable trees.
> 

Now queued up, thanks.

greg k-h
