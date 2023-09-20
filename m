Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAB37A7B7B
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbjITLwg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbjITLwf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:52:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11CD92
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:52:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15739C433C8;
        Wed, 20 Sep 2023 11:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210749;
        bh=o1KffXENgiohHCvgPczxBY7I33546zUOIx18S4Q8Mz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y8GedO2bKa+QRwxMQRatThj7OK60kYZHdnNxxhMMHFzCWpK3pYtELzhqNwOANIJBi
         VB/Sl72CIEoTXDXEXqOqp9uG/zST3i375z8ddlzBlhTvEKJQbNGKdcSm3/5G7eaxZ0
         Pk/OFtWhAfOp7EVgd1jD9o+U7iJ4pxepPQblQl64=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.5 183/211] btrfs: check for BTRFS_FS_ERROR in pending ordered assert
Date:   Wed, 20 Sep 2023 13:30:27 +0200
Message-ID: <20230920112851.548592017@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josef Bacik <josef@toxicpanda.com>

commit 4ca8e03cf2bfaeef7c85939fa1ea0c749cd116ab upstream.

If we do fast tree logging we increment a counter on the current
transaction for every ordered extent we need to wait for.  This means we
expect the transaction to still be there when we clear pending on the
ordered extent.  However if we happen to abort the transaction and clean
it up, there could be no running transaction, and thus we'll trip the
"ASSERT(trans)" check.  This is obviously incorrect, and the code
properly deals with the case that the transaction doesn't exist.  Fix
this ASSERT() to only fire if there's no trans and we don't have
BTRFS_FS_ERROR() set on the file system.

CC: stable@vger.kernel.org # 4.14+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/ordered-data.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -635,7 +635,7 @@ void btrfs_remove_ordered_extent(struct
 			refcount_inc(&trans->use_count);
 		spin_unlock(&fs_info->trans_lock);
 
-		ASSERT(trans);
+		ASSERT(trans || BTRFS_FS_ERROR(fs_info));
 		if (trans) {
 			if (atomic_dec_and_test(&trans->pending_ordered))
 				wake_up(&trans->pending_wait);


