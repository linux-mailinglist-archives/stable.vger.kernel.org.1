Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915297A37C4
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbjIQTYr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238814AbjIQTY1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:24:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7433E118
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:24:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B068FC433C7;
        Sun, 17 Sep 2023 19:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978661;
        bh=QvTgeUAQ0RR6VzOedpOYM64evmE33GXemPqamytETw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f3dIFmJ3iU+cGpJGJ4RmveNBZ4g2T4WvQ9yyZWXNf8kUh4IcX0tHVfIawP9WNBTJ8
         MJAEQyvHgeMgfrqOAHsKOiIpEP+ttam84U/dtmYJ/uJ3Ar6qvq15odllhanW9Bj4Fd
         0ozi1kHqsr0Tcwk49uVnNTTdEi7otoKA/7H3qbmY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Baokun Li <libaokun1@huawei.com>,
        Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 124/406] quota: rename dquot_active() to inode_quota_active()
Date:   Sun, 17 Sep 2023 21:09:38 +0200
Message-ID: <20230917191104.417210123@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 4b9bdfa16535de8f49bf954aeed0f525ee2fc322 ]

Now we have a helper function dquot_dirty() to determine if dquot has
DQ_MOD_B bit. dquot_active() can easily be misunderstood as a helper
function to determine if dquot has DQ_ACTIVE_B bit. So we avoid this by
renaming it to inode_quota_active() and later on we will add the helper
function dquot_active() to determine if dquot has DQ_ACTIVE_B bit.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Message-Id: <20230630110822.3881712-3-libaokun1@huawei.com>
Stable-dep-of: dabc8b207566 ("quota: fix dqput() to follow the guarantees dquot_srcu should provide")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/quota/dquot.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index de4bebdc6e773..bbe748bb9a0d5 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1420,7 +1420,7 @@ static int info_bdq_free(struct dquot *dquot, qsize_t space)
 	return QUOTA_NL_NOWARN;
 }
 
-static int dquot_active(const struct inode *inode)
+static int inode_quota_active(const struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 
@@ -1443,7 +1443,7 @@ static int __dquot_initialize(struct inode *inode, int type)
 	qsize_t rsv;
 	int ret = 0;
 
-	if (!dquot_active(inode))
+	if (!inode_quota_active(inode))
 		return 0;
 
 	dquots = i_dquot(inode);
@@ -1551,7 +1551,7 @@ bool dquot_initialize_needed(struct inode *inode)
 	struct dquot **dquots;
 	int i;
 
-	if (!dquot_active(inode))
+	if (!inode_quota_active(inode))
 		return false;
 
 	dquots = i_dquot(inode);
@@ -1662,7 +1662,7 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
 	int reserve = flags & DQUOT_SPACE_RESERVE;
 	struct dquot **dquots;
 
-	if (!dquot_active(inode)) {
+	if (!inode_quota_active(inode)) {
 		if (reserve) {
 			spin_lock(&inode->i_lock);
 			*inode_reserved_space(inode) += number;
@@ -1732,7 +1732,7 @@ int dquot_alloc_inode(struct inode *inode)
 	struct dquot_warn warn[MAXQUOTAS];
 	struct dquot * const *dquots;
 
-	if (!dquot_active(inode))
+	if (!inode_quota_active(inode))
 		return 0;
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		warn[cnt].w_type = QUOTA_NL_NOWARN;
@@ -1775,7 +1775,7 @@ int dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
 	struct dquot **dquots;
 	int cnt, index;
 
-	if (!dquot_active(inode)) {
+	if (!inode_quota_active(inode)) {
 		spin_lock(&inode->i_lock);
 		*inode_reserved_space(inode) -= number;
 		__inode_add_bytes(inode, number);
@@ -1817,7 +1817,7 @@ void dquot_reclaim_space_nodirty(struct inode *inode, qsize_t number)
 	struct dquot **dquots;
 	int cnt, index;
 
-	if (!dquot_active(inode)) {
+	if (!inode_quota_active(inode)) {
 		spin_lock(&inode->i_lock);
 		*inode_reserved_space(inode) += number;
 		__inode_sub_bytes(inode, number);
@@ -1861,7 +1861,7 @@ void __dquot_free_space(struct inode *inode, qsize_t number, int flags)
 	struct dquot **dquots;
 	int reserve = flags & DQUOT_SPACE_RESERVE, index;
 
-	if (!dquot_active(inode)) {
+	if (!inode_quota_active(inode)) {
 		if (reserve) {
 			spin_lock(&inode->i_lock);
 			*inode_reserved_space(inode) -= number;
@@ -1916,7 +1916,7 @@ void dquot_free_inode(struct inode *inode)
 	struct dquot * const *dquots;
 	int index;
 
-	if (!dquot_active(inode))
+	if (!inode_quota_active(inode))
 		return;
 
 	dquots = i_dquot(inode);
@@ -2087,7 +2087,7 @@ int dquot_transfer(struct inode *inode, struct iattr *iattr)
 	struct super_block *sb = inode->i_sb;
 	int ret;
 
-	if (!dquot_active(inode))
+	if (!inode_quota_active(inode))
 		return 0;
 
 	if (iattr->ia_valid & ATTR_UID && !uid_eq(iattr->ia_uid, inode->i_uid)){
-- 
2.40.1



