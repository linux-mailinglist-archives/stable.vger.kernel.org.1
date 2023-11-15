Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00D07ECFE4
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbjKOTvb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbjKOTva (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:51:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF3A1A3
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:51:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D50C433CC;
        Wed, 15 Nov 2023 19:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077886;
        bh=6HwUKvVGtfSXGLQaiOvx/p9nfSWThs3mxBBIak257mo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q9alB8i71xtPIEk87nW1MsI0n/l4IrwbR20WxdmwbIp+mFiv+VE/R909UehBM828i
         somBo3OWHglXwhIVFT62x+1NJ8JlMY+n9d2YrhIPNsy7O7lVgMwgygzJz7WzsBo+X2
         y2ophYxgX9wyrW2qq1JQNq0p4jIAGhJ29R6MUKWA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 581/603] fs: dlm: Simplify buffer size computation in dlm_create_debug_file()
Date:   Wed, 15 Nov 2023 14:18:46 -0500
Message-ID: <20231115191651.605473683@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 19b3102c0b5350621e7492281f2be0f071fb7e31 ]

Use sizeof(name) instead of the equivalent, but hard coded,
DLM_LOCKSPACE_LEN + 8.

This is less verbose and more future proof.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/debug_fs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index fc44ab6657cab..c93359ceaae61 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -987,7 +987,7 @@ void dlm_create_debug_file(struct dlm_ls *ls)
 	/* format 2 */
 
 	memset(name, 0, sizeof(name));
-	snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_locks", ls->ls_name);
+	snprintf(name, sizeof(name), "%s_locks", ls->ls_name);
 
 	ls->ls_debug_locks_dentry = debugfs_create_file(name,
 							0644,
@@ -998,7 +998,7 @@ void dlm_create_debug_file(struct dlm_ls *ls)
 	/* format 3 */
 
 	memset(name, 0, sizeof(name));
-	snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_all", ls->ls_name);
+	snprintf(name, sizeof(name), "%s_all", ls->ls_name);
 
 	ls->ls_debug_all_dentry = debugfs_create_file(name,
 						      S_IFREG | S_IRUGO,
@@ -1009,7 +1009,7 @@ void dlm_create_debug_file(struct dlm_ls *ls)
 	/* format 4 */
 
 	memset(name, 0, sizeof(name));
-	snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_toss", ls->ls_name);
+	snprintf(name, sizeof(name), "%s_toss", ls->ls_name);
 
 	ls->ls_debug_toss_dentry = debugfs_create_file(name,
 						       S_IFREG | S_IRUGO,
@@ -1018,7 +1018,7 @@ void dlm_create_debug_file(struct dlm_ls *ls)
 						       &format4_fops);
 
 	memset(name, 0, sizeof(name));
-	snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_waiters", ls->ls_name);
+	snprintf(name, sizeof(name), "%s_waiters", ls->ls_name);
 
 	ls->ls_debug_waiters_dentry = debugfs_create_file(name,
 							  0644,
@@ -1029,7 +1029,7 @@ void dlm_create_debug_file(struct dlm_ls *ls)
 	/* format 5 */
 
 	memset(name, 0, sizeof(name));
-	snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_queued_asts", ls->ls_name);
+	snprintf(name, sizeof(name), "%s_queued_asts", ls->ls_name);
 
 	ls->ls_debug_queued_asts_dentry = debugfs_create_file(name,
 							      0644,
-- 
2.42.0



