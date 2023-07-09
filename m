Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55FD74C255
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjGILTZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjGILTY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:19:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9B7130
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:19:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E66260BCA
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0ED3C433C8;
        Sun,  9 Jul 2023 11:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901563;
        bh=yyH2au+Rqak31HUVZhw6F4nlzzchIFf7ftg7lXYNzHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ORfpy1kF940tlQt1UkF1qm8nuG5iiakh+jKPwVF1J3ZwtDlF06KdkX3rq/nazZWuB
         2H8ErH1Qhp3yFWbzFjmD5gRBZuQWBnovGlIedj3aypsX+2zxuXofJ8x2TRnY5Kd5kT
         i2mGNSzJIh82SO+XpE3wL4Xsu6TlUkqGUIOSEPME=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Anand Jain <anand.jain@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 036/431] btrfs: make btrfs_split_bio work on struct btrfs_bio
Date:   Sun,  9 Jul 2023 13:09:44 +0200
Message-ID: <20230709111451.944139638@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
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

[ Upstream commit 2cef0c79bb81d8bae1dbc45195771a824ca45e76 ]

btrfs_split_bio expects a btrfs_bio as argument and always allocates one.
Type both the orig_bio argument and the return value as struct btrfs_bio
to improve type safety.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: c731cd0b6d25 ("btrfs: fix file_offset for REQ_BTRFS_ONE_ORDERED bios that get split")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/bio.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index ada899613486a..67e5156f940d3 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -59,30 +59,31 @@ struct bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
 	return bio;
 }
 
-static struct bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
-				   struct bio *orig, u64 map_length,
-				   bool use_append)
+static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
+					 struct btrfs_bio *orig_bbio,
+					 u64 map_length, bool use_append)
 {
-	struct btrfs_bio *orig_bbio = btrfs_bio(orig);
+	struct btrfs_bio *bbio;
 	struct bio *bio;
 
 	if (use_append) {
 		unsigned int nr_segs;
 
-		bio = bio_split_rw(orig, &fs_info->limits, &nr_segs,
+		bio = bio_split_rw(&orig_bbio->bio, &fs_info->limits, &nr_segs,
 				   &btrfs_clone_bioset, map_length);
 	} else {
-		bio = bio_split(orig, map_length >> SECTOR_SHIFT, GFP_NOFS,
-				&btrfs_clone_bioset);
+		bio = bio_split(&orig_bbio->bio, map_length >> SECTOR_SHIFT,
+				GFP_NOFS, &btrfs_clone_bioset);
 	}
-	btrfs_bio_init(btrfs_bio(bio), orig_bbio->inode, NULL, orig_bbio);
+	bbio = btrfs_bio(bio);
+	btrfs_bio_init(bbio, orig_bbio->inode, NULL, orig_bbio);
 
-	btrfs_bio(bio)->file_offset = orig_bbio->file_offset;
-	if (!(orig->bi_opf & REQ_BTRFS_ONE_ORDERED))
+	bbio->file_offset = orig_bbio->file_offset;
+	if (!(orig_bbio->bio.bi_opf & REQ_BTRFS_ONE_ORDERED))
 		orig_bbio->file_offset += map_length;
 
 	atomic_inc(&orig_bbio->pending_ios);
-	return bio;
+	return bbio;
 }
 
 static void btrfs_orig_write_end_io(struct bio *bio);
@@ -631,8 +632,8 @@ static bool btrfs_submit_chunk(struct bio *bio, int mirror_num)
 		map_length = min(map_length, fs_info->max_zone_append_size);
 
 	if (map_length < length) {
-		bio = btrfs_split_bio(fs_info, bio, map_length, use_append);
-		bbio = btrfs_bio(bio);
+		bbio = btrfs_split_bio(fs_info, bbio, map_length, use_append);
+		bio = &bbio->bio;
 	}
 
 	/*
-- 
2.39.2



