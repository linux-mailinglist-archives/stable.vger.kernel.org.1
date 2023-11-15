Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40397ECF01
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbjKOTpm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbjKOTpl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:45:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA72DAB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:45:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68913C433CA;
        Wed, 15 Nov 2023 19:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077537;
        bh=AuFAGQyyUYq7GNf6wMgklPOhSLk5XAW3AFFQw3SiROc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OT849bWstp2djRIBLyfHdgpLhOQ3AUY69Ge30J9qzwuCy2ge548y0tiDuN8G48ExP
         5ZPXpwBH6tVRwU0s04GQhQmlEMgNvaggp+XQDu0Ej9sGYWtIZ8eEDdP/jAwjMgXgbB
         TiL3psNLceR/nIKUyyZTy2G0J56mDJrzNR65Vaic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Theodore Tso <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 364/603] ext4: add missing initialization of call_notify_error in update_super_work()
Date:   Wed, 15 Nov 2023 14:15:09 -0500
Message-ID: <20231115191638.705115909@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

[ Upstream commit ee6a12d0d4d85f3833d177cd382cd417f0ef011b ]

Fixes: ff0722de896e ("ext4: add periodic superblock update check")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dbebd8b3127e5..6f48dec19f4a2 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -768,7 +768,8 @@ static void update_super_work(struct work_struct *work)
 	 */
 	if (!sb_rdonly(sbi->s_sb) && journal) {
 		struct buffer_head *sbh = sbi->s_sbh;
-		bool call_notify_err;
+		bool call_notify_err = false;
+
 		handle = jbd2_journal_start(journal, 1);
 		if (IS_ERR(handle))
 			goto write_directly;
-- 
2.42.0



