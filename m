Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C990B78324E
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjHUTxU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjHUTxT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:53:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49727FA
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:53:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBC0D6447D
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0F8C433C8;
        Mon, 21 Aug 2023 19:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647597;
        bh=vsevAjzeEs68uQgUS842kKKvazz2Dxege4TpMoOL+TM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FjXQnok0FAjfmSpMg2rD1ji3otaHKa7IavlIUEmJRhKr4MbNaI1wCIbohprQr7IGN
         8SFLGACUxsQrgm9UR5XAvfgtK6ETLAE5gKSokudnU4AgPshdtWffTJnGoDc50U8QIU
         jlfMPlEF0rrqFMDstqorT5s/sZefxfET8u5sGNRI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 063/194] fs/ntfs3: Mark ntfs dirty when on-disk struct is corrupted
Date:   Mon, 21 Aug 2023 21:40:42 +0200
Message-ID: <20230821194125.541308461@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit e0f363a98830e8d7d70fbaf91c07ae0b7c57aafe ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/fsntfs.c  | 2 +-
 fs/ntfs3/index.c   | 6 ++++++
 fs/ntfs3/ntfs_fs.h | 2 ++
 fs/ntfs3/record.c  | 6 ++++++
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index b6e22bcb929ba..829b62d3bb889 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -154,7 +154,7 @@ int ntfs_fix_post_read(struct NTFS_RECORD_HEADER *rhdr, size_t bytes,
 	/* Check errors. */
 	if ((fo & 1) || fo + fn * sizeof(short) > SECTOR_SIZE || !fn-- ||
 	    fn * SECTOR_SIZE > bytes) {
-		return -EINVAL; /* Native chkntfs returns ok! */
+		return -E_NTFS_CORRUPT;
 	}
 
 	/* Get fixup pointer. */
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 9e9a9ffd92958..495cfb37962fa 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1103,6 +1103,12 @@ int indx_read(struct ntfs_index *indx, struct ntfs_inode *ni, CLST vbn,
 	*node = in;
 
 out:
+	if (err == -E_NTFS_CORRUPT) {
+		ntfs_inode_err(&ni->vfs_inode, "directory corrupted");
+		ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_ERROR);
+		err = -EINVAL;
+	}
+
 	if (ib != in->index)
 		kfree(ib);
 
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 24227b2e1b2b0..8c9abaf139e67 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -53,6 +53,8 @@ enum utf16_endian;
 #define E_NTFS_NONRESIDENT		556
 /* NTFS specific error code about punch hole. */
 #define E_NTFS_NOTALIGNED		557
+/* NTFS specific error code when on-disk struct is corrupted. */
+#define E_NTFS_CORRUPT			558
 
 
 /* sbi->flags */
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 07037ec773ac8..ba336c7280b85 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -180,6 +180,12 @@ int mi_read(struct mft_inode *mi, bool is_mft)
 	return 0;
 
 out:
+	if (err == -E_NTFS_CORRUPT) {
+		ntfs_err(sbi->sb, "mft corrupted");
+		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+		err = -EINVAL;
+	}
+
 	return err;
 }
 
-- 
2.40.1



