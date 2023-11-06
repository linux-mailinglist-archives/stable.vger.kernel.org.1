Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26067E23ED
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjKFNQW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbjKFNQT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:16:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF4CD79
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:16:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E88C433C8;
        Mon,  6 Nov 2023 13:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276571;
        bh=+xLBHA0chZR9ni5Oh1uz7f+bSjcqPwPbhCgr6/2QZOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZyGW9dg5SkKlaq3/bQF6kehsptyUAERBiWRkpD5Ht3a3cUQURFx8jXc/vIZ6pOew3
         d7jQ+/xsMWKtZFTXI9KkafJjJhqDDDJ7f+4hUSNlKg66qSoztsekdbu/lmp66YK9pq
         yLsQIpwFS+zLjA/IGiz6MR7h8cxbxP0hCw/QY9Fo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 25/88] fs/ntfs3: Do not allow to change label if volume is read-only
Date:   Mon,  6 Nov 2023 14:03:19 +0100
Message-ID: <20231106130306.713298678@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
References: <20231106130305.772449722@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit e52dce610a2d53bf2b5e94a8843c71cb73a91ea5 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/super.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index d699819c70a14..32c5de5699929 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -498,7 +498,12 @@ static ssize_t ntfs3_label_write(struct file *file, const char __user *buffer,
 	struct super_block *sb = pde_data(file_inode(file));
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
 	ssize_t ret = count;
-	u8 *label = kmalloc(count, GFP_NOFS);
+	u8 *label;
+
+	if (sb_rdonly(sb))
+		return -EROFS;
+
+	label = kmalloc(count, GFP_NOFS);
 
 	if (!label)
 		return -ENOMEM;
-- 
2.42.0



