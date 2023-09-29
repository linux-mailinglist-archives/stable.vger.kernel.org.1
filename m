Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0967B2A33
	for <lists+stable@lfdr.de>; Fri, 29 Sep 2023 03:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjI2Bw3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 28 Sep 2023 21:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjI2Bw3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 28 Sep 2023 21:52:29 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEBF19C
        for <stable@vger.kernel.org>; Thu, 28 Sep 2023 18:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1695952348; x=1727488348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tw2SCLgaoTwPkQHyhu5itqnKuAvsUOnvElZcydaUrpI=;
  b=lPBGLzy60l8/SBRQnSc4cjgRwsA6W+IbrgFrndgTDKllt09zRttSJNQh
   G1cEXxtapa94RuQU1Su02TUQjLO1qCvPynhg3OHeiiDQb0wS2i3RuGVP6
   Bl1BC8ITsX6EM9sq+BAgDKCWNPXnhniUjrlVvsy7kF90Z4wGe7dwCXs9E
   Q=;
X-IronPort-AV: E=Sophos;i="6.03,185,1694736000"; 
   d="scan'208";a="241814277"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-9fe6ad2f.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 01:52:27 +0000
Received: from EX19MTAUWB002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-iad-1a-m6i4x-9fe6ad2f.us-east-1.amazon.com (Postfix) with ESMTPS id A65F68051B;
        Fri, 29 Sep 2023 01:52:25 +0000 (UTC)
Received: from EX19D010UWA004.ant.amazon.com (10.13.138.204) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 29 Sep 2023 01:52:25 +0000
Received: from u0acfa43c8cad58.ant.amazon.com (10.119.86.250) by
 EX19D010UWA004.ant.amazon.com (10.13.138.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 29 Sep 2023 01:52:24 +0000
From:   Munehisa Kamata <kamatam@amazon.com>
To:     <stable@vger.kernel.org>
CC:     <casey@schaufler-ca.com>, <vishal.goel@samsung.com>,
        <roberto.sassu@huawei.com>, <kamatam@amazon.com>
Subject: [PATCH for 4.19.y 3/3] smack: Record transmuting in smk_transmuted
Date:   Thu, 28 Sep 2023 18:51:38 -0700
Message-ID: <20230929015138.835462-4-kamatam@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929015138.835462-1-kamatam@amazon.com>
References: <20230929015033.835263-1-kamatam@amazon.com>
 <20230929015138.835462-1-kamatam@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.119.86.250]
X-ClientProxiedBy: EX19D042UWB004.ant.amazon.com (10.13.139.150) To
 EX19D010UWA004.ant.amazon.com (10.13.138.204)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

commit 2c085f3a8f23c9b444e8b99d93c15d7ce870fc4e upstream.

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
[4.19: adjusted for the lack of helper functions]
Fixes: d6d80cb57be4 ("Smack: Base support for overlayfs")
Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
---
 security/smack/smack.h     |  1 +
 security/smack/smack_lsm.c | 41 +++++++++++++++++++++++++++-----------
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index f7db791fb566..62aa4bc25426 100644
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
index db729834d8ba..266eb8ca3381 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1032,8 +1032,9 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len)
 {
+	struct task_smack *tsp = current_security();
 	struct inode_smack *issp = inode->i_security;
-	struct smack_known *skp = smk_of_current();
+	struct smack_known *skp = smk_of_task(tsp);
 	struct smack_known *isp = smk_of_inode(inode);
 	struct smack_known *dsp = smk_of_inode(dir);
 	int may;
@@ -1042,20 +1043,34 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
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
 
@@ -4677,8 +4692,10 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
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
2.34.1

