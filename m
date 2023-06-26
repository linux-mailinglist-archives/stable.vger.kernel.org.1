Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFEB73E770
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjFZSPI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjFZSPA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:15:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21B09D
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:14:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8182060F4D
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF9BC433C8;
        Mon, 26 Jun 2023 18:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803298;
        bh=VqsY9zkU5RGM4pY6LXmOL/OUHAlDRYNb69Fob3DJmLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PnMmEN/Tg4XcporVLxbdWoANOyx6N8MBFWt4kz3GFOFgjr42lG4HDs965JmIeFl0H
         tjwKfgTwq7aw4WBOTM5MIomEHAsuBCxXvxw/nTTWlJbYA3nVfNxcmmjzHzTToVY2pE
         k/rqA7la54hwk7QEB2gyS4udMvR4C4HWoGS7Ik7s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org
Subject: [PATCH 6.3 014/199] afs: Fix waiting for writeback then skipping folio
Date:   Mon, 26 Jun 2023 20:08:40 +0200
Message-ID: <20230626180806.295572167@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Vishal Moola (Oracle) <vishal.moola@gmail.com>

commit 819da022dd007398d0c42ebcd8dbb1b681acea53 upstream.

Commit acc8d8588cb7 converted afs_writepages_region() to write back a
folio batch. The function waits for writeback to a folio, but then
proceeds to the rest of the batch without trying to write that folio
again. This patch fixes has it attempt to write the folio again.

[DH: Also remove an 'else' that adding a goto makes redundant]

Fixes: acc8d8588cb7 ("afs: convert afs_writepages_region() to use filemap_get_folios_tag()")
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/20230607204120.89416-2-vishal.moola@gmail.com/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/afs/write.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index fd433024070e..8750b99c3f56 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -731,6 +731,7 @@ static int afs_writepages_region(struct address_space *mapping,
 			 * (changing page->mapping to NULL), or even swizzled
 			 * back from swapper_space to tmpfs file mapping
 			 */
+try_again:
 			if (wbc->sync_mode != WB_SYNC_NONE) {
 				ret = folio_lock_killable(folio);
 				if (ret < 0) {
@@ -757,9 +758,10 @@ static int afs_writepages_region(struct address_space *mapping,
 #ifdef CONFIG_AFS_FSCACHE
 					folio_wait_fscache(folio);
 #endif
-				} else {
-					start += folio_size(folio);
+					goto try_again;
 				}
+
+				start += folio_size(folio);
 				if (wbc->sync_mode == WB_SYNC_NONE) {
 					if (skips >= 5 || need_resched()) {
 						*_next = start;
-- 
2.41.0



