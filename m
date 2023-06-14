Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10B172BBFF
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 11:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbjFLJXS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 05:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjFLJWd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 05:22:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227AB10E6;
        Mon, 12 Jun 2023 02:15:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96C99621CC;
        Mon, 12 Jun 2023 09:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6266C433D2;
        Mon, 12 Jun 2023 09:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686561355;
        bh=XOG/RsdSJ+aicyuSW2LirWTPSLdP9sd3V25gI5Q2FCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FQi8nX62z2OC1zqvxGnKoTIi9Msa6ErmniAZt/w2h2I7lpoUmPRB8CgGqPyi3b3UH
         0I4ah64f9Ms14kn+CIIkRQbsvj1Q/UqB1H5Rphh/Sj4M0GOewG6dP9bbpaol5phQf3
         ZTnVK8HUQp5XRcPm7mLNnP8dQmicNmWz1QH791fM=
Date:   Mon, 12 Jun 2023 11:15:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        Leah Rumancik <leah.rumancik@gmail.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        stable@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Danila Chernetsov <listdansp@mail.ru>
Subject: Re: [PATCH 6.1] xfs: verify buffer contents when we skip log replay
Message-ID: <2023061246-rockfish-subsector-ff57@gregkh>
References: <20230605075258.308475-1-amir73il@gmail.com>
 <CAOQ4uxgkS2Ma36o2c6FBtnXnxr=KEF02646UL11hT1k489-wYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgkS2Ma36o2c6FBtnXnxr=KEF02646UL11hT1k489-wYA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jun 09, 2023 at 03:49:13PM +0300, Amir Goldstein wrote:
> On Mon, Jun 5, 2023 at 10:53 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > From: "Darrick J. Wong" <djwong@kernel.org>
> >
> > commit 22ed903eee23a5b174e240f1cdfa9acf393a5210 upstream.
> >
> > syzbot detected a crash during log recovery:
> >
> > XFS (loop0): Mounting V5 Filesystem bfdc47fc-10d8-4eed-a562-11a831b3f791
> > XFS (loop0): Torn write (CRC failure) detected at log block 0x180. Truncating head block from 0x200.
> > XFS (loop0): Starting recovery (logdev: internal)
> > ==================================================================
> > BUG: KASAN: slab-out-of-bounds in xfs_btree_lookup_get_block+0x15c/0x6d0 fs/xfs/libxfs/xfs_btree.c:1813
> > Read of size 8 at addr ffff88807e89f258 by task syz-executor132/5074
> >
> > CPU: 0 PID: 5074 Comm: syz-executor132 Not tainted 6.2.0-rc1-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
> >  print_address_description+0x74/0x340 mm/kasan/report.c:306
> >  print_report+0x107/0x1f0 mm/kasan/report.c:417
> >  kasan_report+0xcd/0x100 mm/kasan/report.c:517
> >  xfs_btree_lookup_get_block+0x15c/0x6d0 fs/xfs/libxfs/xfs_btree.c:1813
> >  xfs_btree_lookup+0x346/0x12c0 fs/xfs/libxfs/xfs_btree.c:1913
> >  xfs_btree_simple_query_range+0xde/0x6a0 fs/xfs/libxfs/xfs_btree.c:4713
> >  xfs_btree_query_range+0x2db/0x380 fs/xfs/libxfs/xfs_btree.c:4953
> >  xfs_refcount_recover_cow_leftovers+0x2d1/0xa60 fs/xfs/libxfs/xfs_refcount.c:1946
> >  xfs_reflink_recover_cow+0xab/0x1b0 fs/xfs/xfs_reflink.c:930
> >  xlog_recover_finish+0x824/0x920 fs/xfs/xfs_log_recover.c:3493
> >  xfs_log_mount_finish+0x1ec/0x3d0 fs/xfs/xfs_log.c:829
> >  xfs_mountfs+0x146a/0x1ef0 fs/xfs/xfs_mount.c:933
> >  xfs_fs_fill_super+0xf95/0x11f0 fs/xfs/xfs_super.c:1666
> >  get_tree_bdev+0x400/0x620 fs/super.c:1282
> >  vfs_get_tree+0x88/0x270 fs/super.c:1489
> >  do_new_mount+0x289/0xad0 fs/namespace.c:3145
> >  do_mount fs/namespace.c:3488 [inline]
> >  __do_sys_mount fs/namespace.c:3697 [inline]
> >  __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x7f89fa3f4aca
> > Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fffd5fb5ef8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
> > RAX: ffffffffffffffda RBX: 00646975756f6e2c RCX: 00007f89fa3f4aca
> > RDX: 0000000020000100 RSI: 0000000020009640 RDI: 00007fffd5fb5f10
> > RBP: 00007fffd5fb5f10 R08: 00007fffd5fb5f50 R09: 000000000000970d
> > R10: 0000000000200800 R11: 0000000000000206 R12: 0000000000000004
> > R13: 0000555556c6b2c0 R14: 0000000000200800 R15: 00007fffd5fb5f50
> >  </TASK>
> >
> > The fuzzed image contains an AGF with an obviously garbage
> > agf_refcount_level value of 32, and a dirty log with a buffer log item
> > for that AGF.  The ondisk AGF has a higher LSN than the recovered log
> > item.  xlog_recover_buf_commit_pass2 reads the buffer, compares the
> > LSNs, and decides to skip replay because the ondisk buffer appears to be
> > newer.
> >
> > Unfortunately, the ondisk buffer is corrupt, but recovery just read the
> > buffer with no buffer ops specified:
> >
> >         error = xfs_buf_read(mp->m_ddev_targp, buf_f->blf_blkno,
> >                         buf_f->blf_len, buf_flags, &bp, NULL);
> >
> > Skipping the buffer leaves its contents in memory unverified.  This sets
> > us up for a kernel crash because xfs_refcount_recover_cow_leftovers
> > reads the buffer (which is still around in XBF_DONE state, so no read
> > verification) and creates a refcountbt cursor of height 32.  This is
> > impossible so we run off the end of the cursor object and crash.
> >
> > Fix this by invoking the verifier on all skipped buffers and aborting
> > log recovery if the ondisk buffer is corrupt.  It might be smarter to
> > force replay the log item atop the buffer and then see if it'll pass the
> > write verifier (like ext4 does) but for now let's go with the
> > conservative option where we stop immediately.
> >
> > Link: https://syzkaller.appspot.com/bug?extid=7e9494b8b399902e994e
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > Reviewed-by: Dave Chinner <dchinner@redhat.com>
> > Signed-off-by: Dave Chinner <david@fromorbit.com>
> > Reported-by: Danila Chernetsov <listdansp@mail.ru>
> > Link: https://lore.kernel.org/linux-xfs/20230601164439.15404-1-listdansp@mail.ru
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > Acked-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >
> > Greg,
> >
> > This is the backport proposed by Danila for 5.10.y.
> > I've already tested it on 6.1.y as well as 5.10.y, but waiting for Leah to
> > test 5.15.y before requesting apply to 5.10.y.
> >
> 
> Greg,
> 
> Leah has tested and posted for 5.15.
> So please apply to 5.10 as well.

Now queued up, thanks.

greg k-h
