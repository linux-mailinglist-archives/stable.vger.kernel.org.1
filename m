Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF637BE1A2
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377450AbjJINwZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377424AbjJINwX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:52:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29D69C
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:52:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AC5C433C7;
        Mon,  9 Oct 2023 13:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859541;
        bh=2Lhr20GyeDSS67iGenFmOdc9m870WsyNPyo9pDI/jU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=086rpFwIAflWbxxDQ8XXb703kdXAfQF7gI+0rkYThgQ9Y2bk6yJBsfGd2ahCsglxD
         aMqxXVV9Z6r9qAM17cTNt2zDDBe31DiyLPH4Qt+kPNYBIqEcdMdiVOm5aAAbVOnn4p
         n0M6DMAosytDGAf18YJJ3UTcpa7KzxoSpOrwV6KM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 54/91] btrfs: properly report 0 avail for very full file systems
Date:   Mon,  9 Oct 2023 15:06:26 +0200
Message-ID: <20231009130113.390623657@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.518916887@linuxfoundation.org>
References: <20231009130111.518916887@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josef Bacik <josef@toxicpanda.com>

commit 58bfe2ccec5f9f137b41dd38f335290dcc13cd5c upstream.

A user reported some issues with smaller file systems that get very
full.  While investigating this issue I noticed that df wasn't showing
100% full, despite having 0 chunk space and having < 1MiB of available
metadata space.

This turns out to be an overflow issue, we're doing:

  total_available_metadata_space - SZ_4M < global_block_rsv_size

to determine if there's not enough space to make metadata allocations,
which overflows if total_available_metadata_space is < 4M.  Fix this by
checking to see if our available space is greater than the 4M threshold.
This makes df properly report 100% usage on the file system.

CC: stable@vger.kernel.org # 4.14+
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/super.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2196,7 +2196,7 @@ static int btrfs_statfs(struct dentry *d
 	 * calculated f_bavail.
 	 */
 	if (!mixed && block_rsv->space_info->full &&
-	    total_free_meta - thresh < block_rsv->size)
+	    (total_free_meta < thresh || total_free_meta - thresh < block_rsv->size))
 		buf->f_bavail = 0;
 
 	buf->f_type = BTRFS_SUPER_MAGIC;


