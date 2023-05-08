Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C24E6FA81A
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbjEHKhh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbjEHKhW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:37:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F6822F7D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:37:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C768627AF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CE6C433EF;
        Mon,  8 May 2023 10:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542239;
        bh=Mjst7bmZpPUiUZSg5yWZVfjDObcqJtMSa9f60EMADcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f7uQJ74zUNZluZJU5rbJoZh0+KK94XKkkMWHHDDqvyL20KeSvjpk/LvOwmOv5kxFC
         /QTfVsyVvPcDmazN9LZs19JWsQn1FqViBHXcqutABlL2VBh2ZnMRy6GOnRoMgv/2y6
         ToOCbW+ID8XJO+udfrBOZJgi6KdB3ns0iq3BxbBE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daeho Jeong <daehojeong@google.com>,
        Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 371/663] f2fs: fix to check return value of inc_valid_block_count()
Date:   Mon,  8 May 2023 11:43:17 +0200
Message-Id: <20230508094440.165160253@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Chao Yu <chao@kernel.org>

[ Upstream commit 935fc6fa6466cf18dd72dd1518ebc7bfc4cd58a4 ]

In __replace_atomic_write_block(), we missed to check return value
of inc_valid_block_count(), for extreme testcase that f2fs image is
run out of space, it may cause inconsistent status in between SIT
table and total valid block count.

Cc: Daeho Jeong <daehojeong@google.com>
Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/segment.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 2822b04082eec..06991cf643296 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -246,10 +246,16 @@ static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
 	} else {
 		blkcnt_t count = 1;
 
+		err = inc_valid_block_count(sbi, inode, &count);
+		if (err) {
+			f2fs_put_dnode(&dn);
+			return err;
+		}
+
 		*old_addr = dn.data_blkaddr;
 		f2fs_truncate_data_blocks_range(&dn, 1);
 		dec_valid_block_count(sbi, F2FS_I(inode)->cow_inode, count);
-		inc_valid_block_count(sbi, inode, &count);
+
 		f2fs_replace_block(sbi, &dn, dn.data_blkaddr, new_addr,
 					ni.version, true, false);
 	}
-- 
2.39.2



