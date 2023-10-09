Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E572D7BDFE0
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377157AbjJINfC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377156AbjJINfC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:35:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3F091
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:35:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD6BC433C7;
        Mon,  9 Oct 2023 13:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858500;
        bh=myjTd087PEDcspmEDK8zsDVD0x9aquioGykBL7UAJ9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t/TlmKCX3o06OT6Mqzczqc3g3xZ6prFF+zQx3k3Nv2puJRQcbznZkCiKiT/pWt7k9
         WRvI5yd8hnTbguMoljJERRGlQpydNm0eh43TeR9V7rm+DGBh4NuNFbFug3UTwsfvfX
         //w59tDUkgA5nhjfEickO25zoCVFtxv4/ocj+PbQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lukas Czerner <lczerner@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 010/226] ext4: change s_last_trim_minblks type to unsigned long
Date:   Mon,  9 Oct 2023 14:59:31 +0200
Message-ID: <20231009130126.993359466@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Czerner <lczerner@redhat.com>

[ Upstream commit 2327fb2e23416cfb2795ccca2f77d4d65925be99 ]

There is no good reason for the s_last_trim_minblks to be atomic. There is
no data integrity needed and there is no real danger in setting and
reading it in a racy manner. Change it to be unsigned long, the same type
as s_clusters_per_group which is the maximum that's allowed.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Suggested-by: Andreas Dilger <adilger@dilger.ca>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Link: https://lore.kernel.org/r/20211103145122.17338-1-lczerner@redhat.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 45e4ab320c9b ("ext4: move setting of trimmed bit into ext4_try_to_trim_range()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/ext4.h    | 2 +-
 fs/ext4/mballoc.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index c3e9cb5037631..fec021e6bb600 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1580,7 +1580,7 @@ struct ext4_sb_info {
 	struct task_struct *s_mmp_tsk;
 
 	/* record the last minlen when FITRIM is called. */
-	atomic_t s_last_trim_minblks;
+	unsigned long s_last_trim_minblks;
 
 	/* Reference to checksum algorithm driver via cryptoapi */
 	struct crypto_shash *s_chksum_driver;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e0428cec6ff60..7bc17eb5ea74a 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5979,7 +5979,7 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 	ext4_lock_group(sb, group);
 
 	if (!EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) ||
-	    minblocks < atomic_read(&EXT4_SB(sb)->s_last_trim_minblks)) {
+	    minblocks < EXT4_SB(sb)->s_last_trim_minblks) {
 		ret = ext4_try_to_trim_range(sb, &e4b, start, max, minblocks);
 		if (ret >= 0)
 			EXT4_MB_GRP_SET_TRIMMED(e4b.bd_info);
@@ -6090,7 +6090,7 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 	}
 
 	if (!ret)
-		atomic_set(&EXT4_SB(sb)->s_last_trim_minblks, minlen);
+		EXT4_SB(sb)->s_last_trim_minblks = minlen;
 
 out:
 	range->len = EXT4_C2B(EXT4_SB(sb), trimmed) << sb->s_blocksize_bits;
-- 
2.40.1



