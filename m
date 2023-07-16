Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C3675517B
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjGPT44 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjGPT4y (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:56:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18504E57
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:56:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B06160EBA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87676C433C8;
        Sun, 16 Jul 2023 19:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537411;
        bh=SJsOHt8BOFwNN6Z7WOr6qMxOobgPom4z1awsDZI7qMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nuv4XWvmmhvW64che+NEXRsJKPH0s49Q7GkEWXnooP5nr7apSTvXEcUIvqxEqpG9Q
         /4uICKTxc+K6wzLkK+B46GtoXNPVXfMZo8YGmLymU/buHhzGD2HPIqLeaTfZYpmkDr
         /eTDYoWakb3FKv1hUlfsut6ftc7hD6PwcuWgCpy0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 059/800] btrfs: fix file_offset for REQ_BTRFS_ONE_ORDERED bios that get split
Date:   Sun, 16 Jul 2023 21:38:32 +0200
Message-ID: <20230716194950.459268887@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit c731cd0b6d255e4855a7cac9f276864032ab2387 ]

If a bio gets split, it needs to have a proper file_offset for checksum
validation and repair to work properly.

Based on feedback from Josef, commit 852eee62d31a ("btrfs: allow
btrfs_submit_bio to split bios") skipped this adjustment for ONE_ORDERED
bios.  But if we actually ever need to split a ONE_ORDERED read bio, this
will lead to a wrong file offset in the repair code.  Right now the only
user of the file_offset is logging of an error message so this is mostly
harmless, but the wrong offset might be more problematic for additional
users in the future.

Fixes: 852eee62d31a ("btrfs: allow btrfs_submit_bio to split bios")
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/bio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index b3ad0f51e6162..b86faf8126e77 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -95,8 +95,7 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 	btrfs_bio_init(bbio, fs_info, NULL, orig_bbio);
 	bbio->inode = orig_bbio->inode;
 	bbio->file_offset = orig_bbio->file_offset;
-	if (!(orig_bbio->bio.bi_opf & REQ_BTRFS_ONE_ORDERED))
-		orig_bbio->file_offset += map_length;
+	orig_bbio->file_offset += map_length;
 
 	atomic_inc(&orig_bbio->pending_ios);
 	return bbio;
-- 
2.39.2



