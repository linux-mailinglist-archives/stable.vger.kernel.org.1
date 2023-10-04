Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07AA7B87D6
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243901AbjJDSJ5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243903AbjJDSJ4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:09:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FCFC6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:09:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE299C433C8;
        Wed,  4 Oct 2023 18:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442992;
        bh=d+toaOfJlZz2zeeRbxp14+gAy0ORhqbc5RAgcJKqiZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1CsSW0B2p0S0TkHgom8wECAZq1m6S/f6bu+nOJMiguyyAcEhYIr2QQkxHoxScb0y1
         MSGG10lfjjfXLyAEtXu37v0YFcIE5U/SHs+dCQiOZIN+q+7Hkgc8553PPh7KpDiMg7
         +7hFN99vFg/+0FdqNVCNRbzS4K3dIEQtKCfa3l9Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Roberto Sassu <roberto.sassu@huawei.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 154/183] smack: Record transmuting in smk_transmuted
Date:   Wed,  4 Oct 2023 19:56:25 +0200
Message-ID: <20231004175210.478606667@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roberto Sassu <roberto.sassu@huawei.com>

[ Upstream commit 2c085f3a8f23c9b444e8b99d93c15d7ce870fc4e ]

smack_dentry_create_files_as() determines whether transmuting should occur
based on the label of the parent directory the new inode will be added to,
and not the label of the directory where it is created.

This helps for example to do transmuting on overlayfs, since the latter
first creates the inode in the working directory, and then moves it to the
correct destination.

However, despite smack_dentry_create_files_as() provides the correct label,
smack_inode_init_security() does not know from passed information whether
or not transmuting occurred. Without this information,
smack_inode_init_security() cannot set SMK_INODE_CHANGED in smk_flags,
which will result in the SMACK64TRANSMUTE xattr not being set in
smack_d_instantiate().

Thus, add the smk_transmuted field to the task_smack structure, and set it
in smack_dentry_create_files_as() to smk_task if transmuting occurred. If
smk_task is equal to smk_transmuted in smack_inode_init_security(), act as
if transmuting was successful but without taking the label from the parent
directory (the inode label was already set correctly from the current
credentials in smack_inode_alloc_security()).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/smack/smack.h     |  1 +
 security/smack/smack_lsm.c | 41 +++++++++++++++++++++++++++-----------
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index 99c3422596ab9..a71b7a1ca24c2 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -120,6 +120,7 @@ struct inode_smack {
 struct task_smack {
 	struct smack_known	*smk_task;	/* label for access control */
 	struct smack_known	*smk_forked;	/* label when forked */
+	struct smack_known	*smk_transmuted;/* label when transmuted */
 	struct list_head	smk_rules;	/* per task access rules */
 	struct mutex		smk_rules_lock;	/* lock for the rules */
 	struct list_head	smk_relabel;	/* transit allowed labels */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 3f3f56f6be4da..84df97d0d3c58 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -955,8 +955,9 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len)
 {
+	struct task_smack *tsp = smack_cred(current_cred());
 	struct inode_smack *issp = smack_inode(inode);
-	struct smack_known *skp = smk_of_current();
+	struct smack_known *skp = smk_of_task(tsp);
 	struct smack_known *isp = smk_of_inode(inode);
 	struct smack_known *dsp = smk_of_inode(dir);
 	int may;
@@ -965,20 +966,34 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 		*name = XATTR_SMACK_SUFFIX;
 
 	if (value && len) {
-		rcu_read_lock();
-		may = smk_access_entry(skp->smk_known, dsp->smk_known,
-				       &skp->smk_rules);
-		rcu_read_unlock();
+		/*
+		 * If equal, transmuting already occurred in
+		 * smack_dentry_create_files_as(). No need to check again.
+		 */
+		if (tsp->smk_task != tsp->smk_transmuted) {
+			rcu_read_lock();
+			may = smk_access_entry(skp->smk_known, dsp->smk_known,
+					       &skp->smk_rules);
+			rcu_read_unlock();
+		}
 
 		/*
-		 * If the access rule allows transmutation and
-		 * the directory requests transmutation then
-		 * by all means transmute.
+		 * In addition to having smk_task equal to smk_transmuted,
+		 * if the access rule allows transmutation and the directory
+		 * requests transmutation then by all means transmute.
 		 * Mark the inode as changed.
 		 */
-		if (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
-		    smk_inode_transmutable(dir)) {
-			isp = dsp;
+		if ((tsp->smk_task == tsp->smk_transmuted) ||
+		    (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
+		     smk_inode_transmutable(dir))) {
+			/*
+			 * The caller of smack_dentry_create_files_as()
+			 * should have overridden the current cred, so the
+			 * inode label was already set correctly in
+			 * smack_inode_alloc_security().
+			 */
+			if (tsp->smk_task != tsp->smk_transmuted)
+				isp = dsp;
 			issp->smk_flags |= SMK_INODE_CHANGED;
 		}
 
@@ -4685,8 +4700,10 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
 		 * providing access is transmuting use the containing
 		 * directory label instead of the process label.
 		 */
-		if (may > 0 && (may & MAY_TRANSMUTE))
+		if (may > 0 && (may & MAY_TRANSMUTE)) {
 			ntsp->smk_task = isp->smk_inode;
+			ntsp->smk_transmuted = ntsp->smk_task;
+		}
 	}
 	return 0;
 }
-- 
2.40.1



