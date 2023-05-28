Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B41F713EDD
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjE1Tjk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjE1Tjj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:39:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799E8A3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:39:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DC0B61EA3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6B2C433D2;
        Sun, 28 May 2023 19:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302777;
        bh=+xuEf/1ExUTyBa98kx2TRpnYGYVcduMSKDC5qkBlMlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qdP/O796XywayR0IZ2f7GSjdSQDHBotwr6f4iTIyPBtscznJRavrJmvBOOup2wQa7
         a1aP0LHgx5tqWHcIPpGFuadn2NeVDHO1s06TXh0z6VmAzt4UFg7blSYnU7BQ/ifw4D
         b/Ag9EaxRc5Td49J+8wm0Xdi6PQOIC21Iaps3u4M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Austin Kim <austindh.kim@gmail.com>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 021/211] ext4: remove an unused variable warning with CONFIG_QUOTA=n
Date:   Sun, 28 May 2023 20:09:02 +0100
Message-Id: <20230528190844.051359664@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Austin Kim <austindh.kim@gmail.com>

[ Upstream commit 3bbef91bdd2180c67407285ba160b023eb4d5306 ]

The 'enable_quota' variable is only used in an CONFIG_QUOTA.
With CONFIG_QUOTA=n, compiler causes a harmless warning:

fs/ext4/super.c: In function ‘ext4_remount’:
fs/ext4/super.c:5840:6: warning: variable ‘enable_quota’ set but not used
  [-Wunused-but-set-variable]
  int enable_quota = 0;
              ^~~~~

Move 'enable_quota' into the same #ifdef CONFIG_QUOTA block
to remove an unused variable warning.

Signed-off-by: Austin Kim <austindh.kim@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20210824034929.GA13415@raspberrypi
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: a44be64bbecb ("ext4: don't clear SB_RDONLY when remounting r/w until quota is re-enabled")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 8694be5132415..d75aa45a846d1 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5792,11 +5792,11 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	unsigned long old_sb_flags, vfs_flags;
 	struct ext4_mount_options old_opts;
-	int enable_quota = 0;
 	ext4_group_t g;
 	unsigned int journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
 	int err = 0;
 #ifdef CONFIG_QUOTA
+	int enable_quota = 0;
 	int i, j;
 	char *to_free[EXT4_MAXQUOTAS];
 #endif
@@ -5994,7 +5994,9 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 					err = -EROFS;
 					goto restore_opts;
 				}
+#ifdef CONFIG_QUOTA
 			enable_quota = 1;
+#endif
 		}
 	}
 
-- 
2.39.2



