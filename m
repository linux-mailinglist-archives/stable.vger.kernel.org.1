Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B3576AEEB
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbjHAJnK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbjHAJm7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:42:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5706C1985
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:40:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D5F5614FF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303A5C433C7;
        Tue,  1 Aug 2023 09:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882829;
        bh=YlXPdq0/gnn+e+PpeOS7ou8G1R9CDfXYYKkci43QBtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PKCFiwik4pOTet/m9/vRQpuKgj2bNQ1QXKdJg9f00Y456U+H3Tfjfwl2IXp/chDOQ
         ZBUoLqIepatcHGtfEl0pRHdrfdy09I1GiK+c3X9/WK29tzB2350yClnePUhQgwdi2v
         kcKMQGCIPUGXQBlI8wLQUpNzuKEAqUr0qtkj3bFQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 018/239] btrfs: factor out a btrfs_verify_page helper
Date:   Tue,  1 Aug 2023 11:18:02 +0200
Message-ID: <20230801091926.301499300@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit ed9ee98ecb4fdbdfe043ee3eec0a65c0745d8669 ]

Split all the conditionals for the fsverity calls in end_page_read into
a btrfs_verify_page helper to keep the code readable and make additional
refactoring easier.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 2c14f0ffdd30 ("btrfs: fix fsverify read error handling in end_page_read")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a37a6587efaf0..496c2c9920fc6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -478,6 +478,15 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 			       start, end, page_ops, NULL);
 }
 
+static bool btrfs_verify_page(struct page *page, u64 start)
+{
+	if (!fsverity_active(page->mapping->host) ||
+	    PageError(page) || PageUptodate(page) ||
+	    start >= i_size_read(page->mapping->host))
+		return true;
+	return fsverity_verify_page(page);
+}
+
 static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
@@ -486,11 +495,7 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 	       start + len <= page_offset(page) + PAGE_SIZE);
 
 	if (uptodate) {
-		if (fsverity_active(page->mapping->host) &&
-		    !PageError(page) &&
-		    !PageUptodate(page) &&
-		    start < i_size_read(page->mapping->host) &&
-		    !fsverity_verify_page(page)) {
+		if (!btrfs_verify_page(page, start)) {
 			btrfs_page_set_error(fs_info, page, start, len);
 		} else {
 			btrfs_page_set_uptodate(fs_info, page, start, len);
-- 
2.39.2



