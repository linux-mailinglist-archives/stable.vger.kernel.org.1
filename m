Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071786FA817
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbjEHKhe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbjEHKhT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:37:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3E522F71
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:37:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26055627AF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78C6C433D2;
        Mon,  8 May 2023 10:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542236;
        bh=5OwhriKLAN/fkY8AB9fk04gRwc5KZGXUiaa2PNQe5Pc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N3+byGee35FniUrkoN6kznitMzhxhN8+1+KNe28CE5jK/sF/QXC7urJx6IghGQZRy
         zoaucjlGN3/Ti5t7BZcqS1w2ypi0KZdOmUjMl07DG9RD5EwdaiU/OIHDOHLr2nGGK3
         NDkNz227OpAV6hXYUK4pO3Jye7zy4ibV66fH7KTg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daeho Jeong <daehojeong@google.com>,
        Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 370/663] f2fs: fix to check return value of f2fs_do_truncate_blocks()
Date:   Mon,  8 May 2023 11:43:16 +0200
Message-Id: <20230508094440.136100767@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chao Yu <chao@kernel.org>

[ Upstream commit b851ee6ba3cc212641e622ebcf92b950c7bafa07 ]

Otherwise, if truncation on cow_inode failed, remained data may
pollute current transaction of atomic write.

Cc: Daeho Jeong <daehojeong@google.com>
Fixes: a46bebd502fe ("f2fs: synchronize atomic write aborts")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 23fb9861dba40..de92279a80020 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2117,7 +2117,11 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
 	} else {
 		/* Reuse the already created COW inode */
-		f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
+		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
+		if (ret) {
+			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
+			goto out;
+		}
 	}
 
 	f2fs_write_inode(inode, NULL);
-- 
2.39.2



