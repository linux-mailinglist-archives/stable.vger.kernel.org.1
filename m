Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7C2726C39
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjFGUbk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjFGUbk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:31:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D71FC
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:31:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D938A64505
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44DCC433EF;
        Wed,  7 Jun 2023 20:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169898;
        bh=R6ZREAQmfVXLiAaCeaUoSgdL0RyPA/Zp7rW4wxAagXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lO84TnVjAGLNog5jhAe2LsT8XFah8P78AJ0BDw+fkgW6t23h0ePO3A2+RbxX2GlCX
         /isiNJhlXgCj94qgIYWZCUupgDboJXC33H2t7185bIJ6HVYYRxrlzEHTK+4yFrzrtr
         uHZeQFLzagIBmw0CvUteCZf5wE5y3lxv+6+ZoIyY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, pengfuyuan <pengfuyuan@kylinos.cn>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.3 228/286] btrfs: fix csum_tree_block page iteration to avoid tripping on -Werror=array-bounds
Date:   Wed,  7 Jun 2023 22:15:27 +0200
Message-ID: <20230607200930.738597904@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: pengfuyuan <pengfuyuan@kylinos.cn>

commit 5ad9b4719fc9bc4715c7e19875a962095b0577e7 upstream.

When compiling on a MIPS 64-bit machine we get these warnings:

    In file included from ./arch/mips/include/asm/cacheflush.h:13,
	             from ./include/linux/cacheflush.h:5,
	             from ./include/linux/highmem.h:8,
		     from ./include/linux/bvec.h:10,
		     from ./include/linux/blk_types.h:10,
                     from ./include/linux/blkdev.h:9,
	             from fs/btrfs/disk-io.c:7:
    fs/btrfs/disk-io.c: In function ‘csum_tree_block’:
    fs/btrfs/disk-io.c:100:34: error: array subscript 1 is above array bounds of ‘struct page *[1]’ [-Werror=array-bounds]
      100 |   kaddr = page_address(buf->pages[i]);
          |                        ~~~~~~~~~~^~~
    ./include/linux/mm.h:2135:48: note: in definition of macro ‘page_address’
     2135 | #define page_address(page) lowmem_page_address(page)
          |                                                ^~~~
    cc1: all warnings being treated as errors

We can check if i overflows to solve the problem. However, this doesn't make
much sense, since i == 1 and num_pages == 1 doesn't execute the body of the loop.
In addition, i < num_pages can also ensure that buf->pages[i] will not cross
the boundary. Unfortunately, this doesn't help with the problem observed here:
gcc still complains.

To fix this add a compile-time condition for the extent buffer page
array size limit, which would eventually lead to eliminating the whole
for loop.

CC: stable@vger.kernel.org # 5.10+
Signed-off-by: pengfuyuan <pengfuyuan@kylinos.cn>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/disk-io.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -96,7 +96,7 @@ static void csum_tree_block(struct exten
 	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
 			    first_page_part - BTRFS_CSUM_SIZE);
 
-	for (i = 1; i < num_pages; i++) {
+	for (i = 1; i < num_pages && INLINE_EXTENT_BUFFER_PAGES > 1; i++) {
 		kaddr = page_address(buf->pages[i]);
 		crypto_shash_update(shash, kaddr, PAGE_SIZE);
 	}


