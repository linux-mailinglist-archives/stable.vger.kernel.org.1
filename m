Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705847A7C31
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbjITL7B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbjITL67 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:58:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A10AB6
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:58:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9309FC433C7;
        Wed, 20 Sep 2023 11:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211133;
        bh=U7PTNF0aio2HS7U5MpOgBwQnvgZ6r+O61xlJVzV62ZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qdKgee8oIEmFxDmF5U0i4SyJ5qBA6SeboqUZ1tFYennqQ3Cf2euPUSQC3/BjKDij0
         C8LkDUk2sdV0cd7gNsVUKURnFgeyhSJ21cxx/EtFvq00uMzgbhS8zE22uVetvaDoOx
         sjDeTgkeoJc/QP8jLRd4eCuR+NIElMITzSNbt48M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.1 121/139] btrfs: check for BTRFS_FS_ERROR in pending ordered assert
Date:   Wed, 20 Sep 2023 13:30:55 +0200
Message-ID: <20230920112840.086032276@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112835.549467415@linuxfoundation.org>
References: <20230920112835.549467415@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -580,7 +580,7 @@ void btrfs_remove_ordered_extent(struct
 			refcount_inc(&trans->use_count);
 		spin_unlock(&fs_info->trans_lock);
 
-		ASSERT(trans);
+		ASSERT(trans || BTRFS_FS_ERROR(fs_info));
 		if (trans) {
 			if (atomic_dec_and_test(&trans->pending_ordered))
 				wake_up(&trans->pending_wait);


