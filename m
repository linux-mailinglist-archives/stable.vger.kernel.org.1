Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F25E703981
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244442AbjEORnK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244451AbjEORmz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:42:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AF416909
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:40:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D274162E43
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA923C433D2;
        Mon, 15 May 2023 17:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172433;
        bh=9/6LlRfl/kUD2BqVQtsuiqByjr8LxB7egT0JkvGpwCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wPAkyZ1Z9nH0aG5h6TMZ91hHFloSBWRW3m6vexx3um7Stk7YO1gnnHPQUq6ywlGxu
         qIAHK3te7CGLW68of77i8Z/Z1AP9n1nVidVLJbaUEltL2/nYY6XPbGqCr8MWjJ4xrS
         UlJeA9HAL6mSILkevKu2dbduMRBQZFFnVWS1Enqw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yangtao Li <frank.li@vivo.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 151/381] f2fs: handle dqget error in f2fs_transfer_project_quota()
Date:   Mon, 15 May 2023 18:26:42 +0200
Message-Id: <20230515161743.662184743@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Yangtao Li <frank.li@vivo.com>

[ Upstream commit 8051692f5f23260215bfe9a72e712d93606acc5f ]

We should set the error code when dqget() failed.

Fixes: 2c1d03056991 ("f2fs: support F2FS_IOC_FS{GET,SET}XATTR")
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d56fcace18211..a0d8aa52b696b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3013,15 +3013,16 @@ int f2fs_transfer_project_quota(struct inode *inode, kprojid_t kprojid)
 	struct dquot *transfer_to[MAXQUOTAS] = {};
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct super_block *sb = sbi->sb;
-	int err = 0;
+	int err;
 
 	transfer_to[PRJQUOTA] = dqget(sb, make_kqid_projid(kprojid));
-	if (!IS_ERR(transfer_to[PRJQUOTA])) {
-		err = __dquot_transfer(inode, transfer_to);
-		if (err)
-			set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
-		dqput(transfer_to[PRJQUOTA]);
-	}
+	if (IS_ERR(transfer_to[PRJQUOTA]))
+		return PTR_ERR(transfer_to[PRJQUOTA]);
+
+	err = __dquot_transfer(inode, transfer_to);
+	if (err)
+		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
+	dqput(transfer_to[PRJQUOTA]);
 	return err;
 }
 
-- 
2.39.2



