Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC68A7352EA
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjFSKjb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjFSKj2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:39:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF46CC
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:39:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB9D260B7F
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B39C433C0;
        Mon, 19 Jun 2023 10:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171166;
        bh=z5apooxL/WflwyFuXC91lgbDas+8R4ZgJW5O6MkK7nM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UWz2N4b4U9sWuKTVfpJrChnz3YXgAq8/8db4jIqen+v7gSG6yjiJE8wkHhkjSZk9W
         qmsxXlfaewglgxCCZoSzcMDGeFlHwymhhGt6CumXFt250PaxkHN46GvNpYGCdkqqJF
         DsGyquAa/g63I0QnCLnyT8t9REzYeWVK9XMZeeMc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+4acc7d910e617b360859@syzkaller.appspotmail.com,
        Theodore Tso <tytso@mit.edu>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 171/187] ext4: drop the call to ext4_error() from ext4_get_group_info()
Date:   Mon, 19 Jun 2023 12:29:49 +0200
Message-ID: <20230619102205.929305854@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Fabio M. De Francesco <fmdefrancesco@gmail.com>

[ Upstream commit f451fd97dd2b78f286379203a47d9d295c467255 ]

A recent patch added a call to ext4_error() which is problematic since
some callers of the ext4_get_group_info() function may be holding a
spinlock, whereas ext4_error() must never be called in atomic context.

This triggered a report from Syzbot: "BUG: sleeping function called from
invalid context in ext4_update_super" (see the link below).

Therefore, drop the call to ext4_error() from ext4_get_group_info(). In
the meantime use eight characters tabs instead of nine characters ones.

Reported-by: syzbot+4acc7d910e617b360859@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/00000000000070575805fdc6cdb2@google.com/
Fixes: 5354b2af3406 ("ext4: allow ext4_get_group_info() to fail")
Suggested-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Link: https://lore.kernel.org/r/20230614100446.14337-1-fmdefrancesco@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/balloc.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index a38aa33af08ef..8e83b51e3c68a 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -322,17 +322,15 @@ static ext4_fsblk_t ext4_valid_block_bitmap_padding(struct super_block *sb,
 struct ext4_group_info *ext4_get_group_info(struct super_block *sb,
 					    ext4_group_t group)
 {
-	 struct ext4_group_info **grp_info;
-	 long indexv, indexh;
-
-	 if (unlikely(group >= EXT4_SB(sb)->s_groups_count)) {
-		 ext4_error(sb, "invalid group %u", group);
-		 return NULL;
-	 }
-	 indexv = group >> (EXT4_DESC_PER_BLOCK_BITS(sb));
-	 indexh = group & ((EXT4_DESC_PER_BLOCK(sb)) - 1);
-	 grp_info = sbi_array_rcu_deref(EXT4_SB(sb), s_group_info, indexv);
-	 return grp_info[indexh];
+	struct ext4_group_info **grp_info;
+	long indexv, indexh;
+
+	if (unlikely(group >= EXT4_SB(sb)->s_groups_count))
+		return NULL;
+	indexv = group >> (EXT4_DESC_PER_BLOCK_BITS(sb));
+	indexh = group & ((EXT4_DESC_PER_BLOCK(sb)) - 1);
+	grp_info = sbi_array_rcu_deref(EXT4_SB(sb), s_group_info, indexv);
+	return grp_info[indexh];
 }
 
 /*
-- 
2.39.2



