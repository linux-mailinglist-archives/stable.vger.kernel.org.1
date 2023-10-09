Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04677BDDCA
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376935AbjJINNY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376903AbjJINNL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:13:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FB4173B
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:12:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C501AC433CC;
        Mon,  9 Oct 2023 13:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857134;
        bh=UsiV2q5H0s78jMY4EvZioJ6sWQPGQFuB9wyjOsmZ1fQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=en9WWnTilxUw+VCncHMh9agyN4wwx6LbcBh8YvO19Zqy85zf7dPjblgN71lG7Wfi5
         3ErmmCrAWZIrUhtFCWrZVCB4dsKzLl6A7GOpJhqaFOve45/dhNwzU6S2r/gRjOzBd4
         tn+xc9WfnCqA18igIU8SbpJ4bQOzrGEH89udcs7o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 108/163] ovl: fetch inode once in ovl_dentry_revalidate_common()
Date:   Mon,  9 Oct 2023 15:01:12 +0200
Message-ID: <20231009130127.006738954@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit c54719c92aa3129f330cce81b88cf34f1627f756 ]

d_inode_rcu() is right - we might be in rcu pathwalk;
however, OVL_E() hides plain d_inode() on the same dentry...

Fixes: a6ff2bc0be17 ("ovl: use OVL_E() and OVL_E_FLAGS() accessors")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/super.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 8e9c1cf83df24..1090c68e5b051 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -101,8 +101,8 @@ static int ovl_revalidate_real(struct dentry *d, unsigned int flags, bool weak)
 static int ovl_dentry_revalidate_common(struct dentry *dentry,
 					unsigned int flags, bool weak)
 {
-	struct ovl_entry *oe = OVL_E(dentry);
-	struct ovl_path *lowerstack = ovl_lowerstack(oe);
+	struct ovl_entry *oe;
+	struct ovl_path *lowerstack;
 	struct inode *inode = d_inode_rcu(dentry);
 	struct dentry *upper;
 	unsigned int i;
@@ -112,6 +112,8 @@ static int ovl_dentry_revalidate_common(struct dentry *dentry,
 	if (!inode)
 		return -ECHILD;
 
+	oe = OVL_I_E(inode);
+	lowerstack = ovl_lowerstack(oe);
 	upper = ovl_i_dentry_upper(inode);
 	if (upper)
 		ret = ovl_revalidate_real(upper, flags, weak);
-- 
2.40.1



