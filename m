Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E827BE09E
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377313AbjJINmK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377357AbjJINmJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:42:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2063AEA
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:42:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A403C433C8;
        Mon,  9 Oct 2023 13:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858927;
        bh=PohkrbMvq0zZkAkshANu6sj5P4FsN/13h/b8VbwoxzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HcGY/Q5qIX9tMdWhYuqecwKIh1u2yI/TzuknKA4/SCGzXmDRnxHZKihvl3BO5vRh2
         VntBv3bKVTjK9aGW5iFd0iG8qaa003xV9FnMeXKHzlKrgfGcCOO/AYjv7DgEcqw3xI
         QKjAPa162O13rx3FJqGO7HAdiuWevoap0zxxPWL0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vishal Goel <vishal.goel@samsung.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 144/226] Smack:- Use overlay inode label in smack_inode_copy_up()
Date:   Mon,  9 Oct 2023 15:01:45 +0200
Message-ID: <20231009130130.490323391@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vishal Goel <vishal.goel@samsung.com>

[ Upstream commit 387ef964460f14fe1c1ea29aba70e22731ea7cf7 ]

Currently in "smack_inode_copy_up()" function, process label is
changed with the label on parent inode. Due to which,
process is assigned directory label and whatever file or directory
created by the process are also getting directory label
which is wrong label.

Changes has been done to use label of overlay inode instead
of parent inode.

Signed-off-by: Vishal Goel <vishal.goel@samsung.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/smack/smack_lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 6bfc3c8d93102..814518ad4402b 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4663,7 +4663,7 @@ static int smack_inode_copy_up(struct dentry *dentry, struct cred **new)
 	/*
 	 * Get label from overlay inode and set it in create_sid
 	 */
-	isp = smack_inode(d_inode(dentry->d_parent));
+	isp = smack_inode(d_inode(dentry));
 	skp = isp->smk_inode;
 	tsp->smk_task = skp;
 	*new = new_creds;
-- 
2.40.1



