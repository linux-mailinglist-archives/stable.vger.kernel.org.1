Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5000076113B
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjGYKtA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjGYKs6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:48:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5F0199D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:48:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95AF76165C
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C41C433CC;
        Tue, 25 Jul 2023 10:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282135;
        bh=w5efejBajAcnpsxg88S9kTJUWo3v09h5RvOz38U7ueE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CcJ1O7UcktuKFJAD82z/gRWczK4rFX0cMkK1bAwvfhGyennuRdayJA023u98yrBbA
         RSapdPzCy2ARo73rptAxR0AjC493L7dbsAWdfhkENVy2PlhcxSk04iTe5eQoSFygBm
         tnvvkG0burLryGJqAdUU7N6hWAexQuZUnXX2dS+w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.4 020/227] btrfs: set_page_extent_mapped after read_folio in btrfs_cont_expand
Date:   Tue, 25 Jul 2023 12:43:07 +0200
Message-ID: <20230725104515.637638060@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

commit 17b17fcd6d446b95904a6929c40012ee7f0afc0c upstream.

While trying to get the subpage blocksize tests running, I hit the
following panic on generic/476

  assertion failed: PagePrivate(page) && page->private, in fs/btrfs/subpage.c:229
  kernel BUG at fs/btrfs/subpage.c:229!
  Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
  CPU: 1 PID: 1453 Comm: fsstress Not tainted 6.4.0-rc7+ #12
  Hardware name: QEMU KVM Virtual Machine, BIOS edk2-20230301gitf80f052277c8-26.fc38 03/01/2023
  pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
  pc : btrfs_subpage_assert+0xbc/0xf0
  lr : btrfs_subpage_assert+0xbc/0xf0
  Call trace:
   btrfs_subpage_assert+0xbc/0xf0
   btrfs_subpage_clear_checked+0x38/0xc0
   btrfs_page_clear_checked+0x48/0x98
   btrfs_truncate_block+0x5d0/0x6a8
   btrfs_cont_expand+0x5c/0x528
   btrfs_write_check.isra.0+0xf8/0x150
   btrfs_buffered_write+0xb4/0x760
   btrfs_do_write_iter+0x2f8/0x4b0
   btrfs_file_write_iter+0x1c/0x30
   do_iter_readv_writev+0xc8/0x158
   do_iter_write+0x9c/0x210
   vfs_iter_write+0x24/0x40
   iter_file_splice_write+0x224/0x390
   direct_splice_actor+0x38/0x68
   splice_direct_to_actor+0x12c/0x260
   do_splice_direct+0x90/0xe8
   generic_copy_file_range+0x50/0x90
   vfs_copy_file_range+0x29c/0x470
   __arm64_sys_copy_file_range+0xcc/0x498
   invoke_syscall.constprop.0+0x80/0xd8
   do_el0_svc+0x6c/0x168
   el0_svc+0x50/0x1b0
   el0t_64_sync_handler+0x114/0x120
   el0t_64_sync+0x194/0x198

This happens because during btrfs_cont_expand we'll get a page, set it
as mapped, and if it's not Uptodate we'll read it.  However between the
read and re-locking the page we could have called release_folio() on the
page, but left the page in the file mapping.  release_folio() can clear
the page private, and thus further down we blow up when we go to modify
the subpage bits.

Fix this by putting the set_page_extent_mapped() after the read.  This
is safe because read_folio() will call set_page_extent_mapped() before
it does the read, and then if we clear page private but leave it on the
mapping we're completely safe re-setting set_page_extent_mapped().  With
this patch I can now run generic/476 without panicing.

CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/inode.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4734,9 +4734,6 @@ again:
 		ret = -ENOMEM;
 		goto out;
 	}
-	ret = set_page_extent_mapped(page);
-	if (ret < 0)
-		goto out_unlock;
 
 	if (!PageUptodate(page)) {
 		ret = btrfs_read_folio(NULL, page_folio(page));
@@ -4751,6 +4748,17 @@ again:
 			goto out_unlock;
 		}
 	}
+
+	/*
+	 * We unlock the page after the io is completed and then re-lock it
+	 * above.  release_folio() could have come in between that and cleared
+	 * PagePrivate(), but left the page in the mapping.  Set the page mapped
+	 * here to make sure it's properly set for the subpage stuff.
+	 */
+	ret = set_page_extent_mapped(page);
+	if (ret < 0)
+		goto out_unlock;
+
 	wait_on_page_writeback(page);
 
 	lock_extent(io_tree, block_start, block_end, &cached_state);


