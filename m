Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F42779B859
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240479AbjIKWWR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239417AbjIKOUF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:20:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746F7E40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:20:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AFDC433C7;
        Mon, 11 Sep 2023 14:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442000;
        bh=pRsCyx63h9wzlsa2URGHq4iN7xnBT2Ea64LHoc8ZFbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=st10hAdDdYFsqO3dhR4SCsm5v7JcSQfBlZnGSrM3v6hPDcC8R8UjoLgVNRqtloxwH
         RC4c4Zx6KhiqAFI9wiouUS4WSAmIJqH7w5RcIfT7Vqb/VqM6mYwJa398lXwgmIZVuR
         itfcifASrBFP0cAbUvF+zzI1QrsbySOzzlA9MxCU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 584/739] f2fs: compress: fix to assign compress_level for lz4 correctly
Date:   Mon, 11 Sep 2023 15:46:23 +0200
Message-ID: <20230911134707.416767582@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <chao@kernel.org>

[ Upstream commit 091a4dfbb1d32b06c031edbfe2a44af100c4604f ]

After remount, F2FS_OPTION().compress_level was assgin to
LZ4HC_DEFAULT_CLEVEL incorrectly, result in lz4hc:9 was enabled, fix it.

1. mount /dev/vdb
/dev/vdb on /mnt/f2fs type f2fs (...,compress_algorithm=lz4,compress_log_size=2,...)
2. mount -t f2fs -o remount,compress_log_size=3 /mnt/f2fs/
3. mount|grep f2fs
/dev/vdb on /mnt/f2fs type f2fs (...,compress_algorithm=lz4:9,compress_log_size=3,...)

Fixes: 00e120b5e4b5 ("f2fs: assign default compression level")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a067466a694c9..8d9d2ee7f3c7f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -591,7 +591,7 @@ static int f2fs_set_lz4hc_level(struct f2fs_sb_info *sbi, const char *str)
 	unsigned int level;
 
 	if (strlen(str) == 3) {
-		F2FS_OPTION(sbi).compress_level = LZ4HC_DEFAULT_CLEVEL;
+		F2FS_OPTION(sbi).compress_level = 0;
 		return 0;
 	}
 
-- 
2.40.1



