Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C41F7B2A32
	for <lists+stable@lfdr.de>; Fri, 29 Sep 2023 03:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjI2Bw2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 28 Sep 2023 21:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjI2Bw1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 28 Sep 2023 21:52:27 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CAF19C
        for <stable@vger.kernel.org>; Thu, 28 Sep 2023 18:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1695952346; x=1727488346;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6TUuqM0qwzF//Q2SXN4xDuKk0XQnQ0nzwv6trSXXt9A=;
  b=rJK/ITTLbPxcgOYafsuzcb/NvzT/sUZswfwJhtVs/rwAMcTRJhVbx03S
   34WYqW6rpvHfecd7uwgwhXulzUI0XJHNXjrPQfRdIM8lUtPzVHSfUoz96
   e4yD15tq85V8AzLCbc6k79yF2zyJnKVzPlTIjMAwOizo+kGV9DNYmtvuO
   M=;
X-IronPort-AV: E=Sophos;i="6.03,185,1694736000"; 
   d="scan'208";a="353960023"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 01:52:25 +0000
Received: from EX19MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com (Postfix) with ESMTPS id 18B79807E6;
        Fri, 29 Sep 2023 01:52:23 +0000 (UTC)
Received: from EX19D010UWA004.ant.amazon.com (10.13.138.204) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 29 Sep 2023 01:52:23 +0000
Received: from u0acfa43c8cad58.ant.amazon.com (10.119.86.250) by
 EX19D010UWA004.ant.amazon.com (10.13.138.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 29 Sep 2023 01:52:23 +0000
From:   Munehisa Kamata <kamatam@amazon.com>
To:     <stable@vger.kernel.org>
CC:     <casey@schaufler-ca.com>, <vishal.goel@samsung.com>,
        <roberto.sassu@huawei.com>, <kamatam@amazon.com>
Subject: [PATCH for 4.19.y 2/3] smack: Retrieve transmuting information in smack_inode_getsecurity()
Date:   Thu, 28 Sep 2023 18:51:37 -0700
Message-ID: <20230929015138.835462-3-kamatam@amazon.com>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
---
 security/smack/smack_lsm.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a09a9c6bbdf6..db729834d8ba 100644
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
2.34.1

