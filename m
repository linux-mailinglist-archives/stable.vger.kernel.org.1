Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2033473E872
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjFZS0G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjFZSZq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:25:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8976B2711
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:24:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA93560F30
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E24C433C8;
        Mon, 26 Jun 2023 18:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803891;
        bh=UkcvQeGlBwvWKAmrA6+9reRwq5WoIFucTljsXLzofnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hHp4gxRCrIIPONpKq82PCdFFpJ1EkUTOukx4URUDxbYdYQtH5QP72iiTRoJvOxIEb
         waivgsrV4NkBpj/55VtJ4QLDp/p1/1SgKjRSVtSjcFGbTztXBTpm9P/OPmX4hNmjaU
         iSywjX32n1tbPaWVSIwAmzIOsvt7Lr7DBsR5GxAE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        syzbot+53369d11851d8f26735c@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.19 13/41] nilfs2: prevent general protection fault in nilfs_clear_dirty_page()
Date:   Mon, 26 Jun 2023 20:11:36 +0200
Message-ID: <20230626180736.784492004@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180736.243379844@linuxfoundation.org>
References: <20230626180736.243379844@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ryusuke Konishi <konishi.ryusuke@gmail.com>

commit 782e53d0c14420858dbf0f8f797973c150d3b6d7 upstream.

In a syzbot stress test that deliberately causes file system errors on
nilfs2 with a corrupted disk image, it has been reported that
nilfs_clear_dirty_page() called from nilfs_clear_dirty_pages() can cause a
general protection fault.

In nilfs_clear_dirty_pages(), when looking up dirty pages from the page
cache and calling nilfs_clear_dirty_page() for each dirty page/folio
retrieved, the back reference from the argument page to "mapping" may have
been changed to NULL (and possibly others).  It is necessary to check this
after locking the page/folio.

So, fix this issue by not calling nilfs_clear_dirty_page() on a page/folio
after locking it in nilfs_clear_dirty_pages() if the back reference
"mapping" from the page/folio is different from the "mapping" that held
the page/folio just before.

Link: https://lkml.kernel.org/r/20230612021456.3682-1-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+53369d11851d8f26735c@syzkaller.appspotmail.com
Closes: https://lkml.kernel.org/r/000000000000da4f6b05eb9bf593@google.com
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nilfs2/page.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -372,7 +372,15 @@ void nilfs_clear_dirty_pages(struct addr
 			struct page *page = pvec.pages[i];
 
 			lock_page(page);
-			nilfs_clear_dirty_page(page, silent);
+
+			/*
+			 * This page may have been removed from the address
+			 * space by truncation or invalidation when the lock
+			 * was acquired.  Skip processing in that case.
+			 */
+			if (likely(page->mapping == mapping))
+				nilfs_clear_dirty_page(page, silent);
+
 			unlock_page(page);
 		}
 		pagevec_release(&pvec);


