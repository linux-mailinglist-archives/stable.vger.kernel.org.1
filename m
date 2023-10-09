Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA087BE19A
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376857AbjJINwB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377424AbjJINwB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:52:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608FEB9
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:51:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4374C433C7;
        Mon,  9 Oct 2023 13:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859519;
        bh=ksy/RqhkqY1CtcO/DkUL8UddfUWRyZDyxKi2g3mu5DM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bkFnsysgefFqoisouvdIy5BcLt389kV6Fq8ck/E4/Ku2K4tA0dVKbfXad8D7PIx7z
         bnnRkdWHE2GIxZU/mjwqIFCAPmgiRBofKSJV3lvFy+umLXa0tbE2HkN9WN5FxSvs6L
         DBIP1MGONZqdgIvgLZiPBUvlt0wRjRzmVQ9N6AFQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Roberto Sassu <roberto.sassu@huawei.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Munehisa Kamata <kamatam@amazon.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 47/91] smack: Retrieve transmuting information in smack_inode_getsecurity()
Date:   Mon,  9 Oct 2023 15:06:19 +0200
Message-ID: <20231009130113.151054464@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.518916887@linuxfoundation.org>
References: <20231009130111.518916887@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roberto Sassu <roberto.sassu@huawei.com>

commit 3a3d8fce31a49363cc31880dce5e3b0617c9c38b upstream.

Enhance smack_inode_getsecurity() to retrieve the value for
SMACK64TRANSMUTE from the inode security blob, similarly to SMACK64.

This helps to display accurate values in the situation where the security
labels come from mount options and not from xattrs.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
[4.19: adjusted for the lack of helper functions]
Fixes: d6d80cb57be4 ("Smack: Base support for overlayfs")
Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/smack/smack_lsm.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a09a9c6bbdf63..db729834d8ba9 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1490,10 +1490,19 @@ static int smack_inode_getsecurity(struct inode *inode,
 	struct super_block *sbp;
 	struct inode *ip = (struct inode *)inode;
 	struct smack_known *isp;
+	struct inode_smack *ispp;
+	size_t label_len;
+	char *label = NULL;
 
-	if (strcmp(name, XATTR_SMACK_SUFFIX) == 0)
+	if (strcmp(name, XATTR_SMACK_SUFFIX) == 0) {
 		isp = smk_of_inode(inode);
-	else {
+	} else if (strcmp(name, XATTR_SMACK_TRANSMUTE) == 0) {
+		ispp = inode->i_security;
+		if (ispp->smk_flags & SMK_INODE_TRANSMUTE)
+			label = TRANS_TRUE;
+		else
+			label = "";
+	} else {
 		/*
 		 * The rest of the Smack xattrs are only on sockets.
 		 */
@@ -1515,13 +1524,18 @@ static int smack_inode_getsecurity(struct inode *inode,
 			return -EOPNOTSUPP;
 	}
 
+	if (!label)
+		label = isp->smk_known;
+
+	label_len = strlen(label);
+
 	if (alloc) {
-		*buffer = kstrdup(isp->smk_known, GFP_KERNEL);
+		*buffer = kstrdup(label, GFP_KERNEL);
 		if (*buffer == NULL)
 			return -ENOMEM;
 	}
 
-	return strlen(isp->smk_known);
+	return label_len;
 }
 
 
-- 
2.40.1



