Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633A6775DED
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbjHILma (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbjHILm3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:42:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E0B1FD2
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:42:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2BB0636E4
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED490C433C8;
        Wed,  9 Aug 2023 11:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581348;
        bh=4CV7nWb+q+Lx+9Lce86mil4/a9QJlqbHjNsA6iLXmpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L6beQrvYsTF6p4eeGJ+r+SmSed8y5l+5PD8j9txUEqESC7pXKr/LXdCnLh9J/ALmy
         FvS6xvMsEpz4Mm0zJxYPyNKuGzT0y8Z/3qDZdaopnGkg39fM1oFwp98ii7DCFNjKNi
         T1spdEsg3aoJvhag3YUnrca7g9z6fg463TBKYZFo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuezhang Mo <Yuezhang.Mo@sony.com>,
        Andy Wu <Andy.Wu@sony.com>,
        Aoyama Wataru <wataru.aoyama@sony.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 194/201] exfat: support dynamic allocate bh for exfat_entry_set_cache
Date:   Wed,  9 Aug 2023 12:43:16 +0200
Message-ID: <20230809103650.353831735@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yuezhang Mo <Yuezhang.Mo@sony.com>

[ Upstream commit a3ff29a95fde16906304455aa8c0bd84eb770258 ]

In special cases, a file or a directory may occupied more than 19
directory entries, pre-allocating 3 bh is not enough. Such as
  - Support vendor secondary directory entry in the future.
  - Since file directory entry is damaged, the SecondaryCount
    field is bigger than 18.

So this commit supports dynamic allocation of bh.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Andy Wu <Andy.Wu@sony.com>
Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Stable-dep-of: d42334578eba ("exfat: check if filename entries exceeds max filename length")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exfat/dir.c      | 15 +++++++++++++++
 fs/exfat/exfat_fs.h |  5 ++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 0e1886f9a6241..185aa13945d3d 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -609,6 +609,10 @@ int exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync)
 			bforget(es->bh[i]);
 		else
 			brelse(es->bh[i]);
+
+	if (IS_DYNAMIC_ES(es))
+		kfree(es->bh);
+
 	kfree(es);
 	return err;
 }
@@ -844,6 +848,7 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 	/* byte offset in sector */
 	off = EXFAT_BLK_OFFSET(byte_offset, sb);
 	es->start_off = off;
+	es->bh = es->__bh;
 
 	/* sector offset in cluster */
 	sec = EXFAT_B_TO_BLK(byte_offset, sb);
@@ -863,6 +868,16 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 	es->num_entries = num_entries;
 
 	num_bh = EXFAT_B_TO_BLK_ROUND_UP(off + num_entries * DENTRY_SIZE, sb);
+	if (num_bh > ARRAY_SIZE(es->__bh)) {
+		es->bh = kmalloc_array(num_bh, sizeof(*es->bh), GFP_KERNEL);
+		if (!es->bh) {
+			brelse(bh);
+			kfree(es);
+			return NULL;
+		}
+		es->bh[0] = bh;
+	}
+
 	for (i = 1; i < num_bh; i++) {
 		/* get the next sector */
 		if (exfat_is_last_sector_in_cluster(sbi, sec)) {
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 436683da2515c..11e579a2598d8 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -170,10 +170,13 @@ struct exfat_entry_set_cache {
 	bool modified;
 	unsigned int start_off;
 	int num_bh;
-	struct buffer_head *bh[DIR_CACHE_SIZE];
+	struct buffer_head *__bh[DIR_CACHE_SIZE];
+	struct buffer_head **bh;
 	unsigned int num_entries;
 };
 
+#define IS_DYNAMIC_ES(es)	((es)->__bh != (es)->bh)
+
 struct exfat_dir_entry {
 	struct exfat_chain dir;
 	int entry;
-- 
2.40.1



