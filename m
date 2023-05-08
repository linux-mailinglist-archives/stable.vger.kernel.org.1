Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3230B6FABA7
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbjEHLPy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbjEHLPw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:15:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F1636CFA
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:15:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0CAA62BF2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BF1C4339B;
        Mon,  8 May 2023 11:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544551;
        bh=XYimaoFb/8Yn/HWuShv7fLZpcnAwmofCQoHNfTNrtq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qgpC8esu8JTI6VoFzM2lXVMGKsOj/I7lv/SvM/PkuRZR7tFM6FnUZY33Hi8SE25b3
         uD/j+qnJG1CBq44qS9vWtR5B0QeVaYfkG0MwfVZHErfufQ7l+UsiETAL9BDr+ZoUKj
         BDlWZN1kbiGSoZ7ksKBmPuptiMySxk8e+vpe9p6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daeho Jeong <daehojeong@google.com>,
        Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 416/694] f2fs: fix to check return value of f2fs_do_truncate_blocks()
Date:   Mon,  8 May 2023 11:44:11 +0200
Message-Id: <20230508094446.775733977@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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
index 4f684b99ba5a3..16e286cea6301 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2113,7 +2113,11 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
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



