Return-Path: <stable+bounces-140169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0887AAA5B1
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8C717D28E
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A850B28DEE4;
	Mon,  5 May 2025 22:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i52HR5TG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645E827A91C;
	Mon,  5 May 2025 22:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484266; cv=none; b=DJo4OC1+0RG2HiJc/SPZMXwOonyXOZd+1nA5qj49CVoRBgjWuaDMEWEKCSbR0HzBnMkh3f3lyZT2l542r1Q8qF+NwdN7MT6DEWoJNwt4N2JESaIv7YbSjJb56oC4bWYbi5jCF4FqqtS9bcaCywG0E+3yftwkCLd3lWu1Sfor5f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484266; c=relaxed/simple;
	bh=y189VpPMbpZ6dF+UEMK+0AsBHh/vfjWRWuqkY/DBNI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iwd50WXr+rDFD4HOq6LZ/EdgL5of27fhVEuIq9LYXz2UigTWoyNezMC35uKiH0QKDkE1q4JpViXri1XG9kdPl1ennfDH9iDDlwCZ5enKutR5cj4FHkMjIliCKitQFekiMKChrLELzKrAkRvIssgQ7Z0NGbc6q7jacog7hX9GZHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i52HR5TG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E9FC4CEEE;
	Mon,  5 May 2025 22:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484265;
	bh=y189VpPMbpZ6dF+UEMK+0AsBHh/vfjWRWuqkY/DBNI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i52HR5TGUxcKU+SfsXsSlAB8x3/+RkJoJgx34zfg9QLJo4K/g9v5Q6+JcpdV3i4bQ
	 ILhqnJmG7H2QBxNvOjJTdICPVD/HBKVaHU80rVBjdkFRZ7XZVZIk4+nWDPJxKNMlkP
	 j2Vjke5DWmp+ucH+wUsxJjVqQ/XkatHLfvwfdDaKhxHXK9sjjsFu1CipWPjc8tm/9d
	 K3hcVX0B+ADVIRUB9zJrmsKRYOOtoOBNysB+uFHFOO5JBkNFu8FYnzU9gZb79Ver56
	 Bt5we6ahnUR5C19Fv5TayJ+OpcHAtAd8bYQshYdDaHYCIExWyux4P9srVUBtirGxX2
	 tuDDB6uWJVEbw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Andreev <andreev@swemel.ru>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Sasha Levin <sashal@kernel.org>,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 422/642] smack: Revert "smackfs: Added check catlen"
Date: Mon,  5 May 2025 18:10:38 -0400
Message-Id: <20250505221419.2672473-422-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Konstantin Andreev <andreev@swemel.ru>

[ Upstream commit c7fb50cecff9cad19fdac5b37337eae4e42b94c7 ]

This reverts commit ccfd889acb06eab10b98deb4b5eef0ec74157ea0

The indicated commit
* does not describe the problem that change tries to solve
* has programming issues
* introduces a bug: forever clears NETLBL_SECATTR_MLS_CAT
         in (struct smack_known *)skp->smk_netlabel.flags

Reverting the commit to reapproach original problem

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/smack/smackfs.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index d8f9922804974..a7886cfc9dc3a 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -812,7 +812,7 @@ static int smk_open_cipso(struct inode *inode, struct file *file)
 static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 				size_t count, loff_t *ppos, int format)
 {
-	struct netlbl_lsm_catmap *old_cat, *new_cat = NULL;
+	struct netlbl_lsm_catmap *old_cat;
 	struct smack_known *skp;
 	struct netlbl_lsm_secattr ncats;
 	char mapcatset[SMK_CIPSOLEN];
@@ -899,19 +899,8 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 
 		smack_catset_bit(cat, mapcatset);
 	}
-	ncats.flags = 0;
-	if (catlen == 0) {
-		ncats.attr.mls.cat = NULL;
-		ncats.attr.mls.lvl = maplevel;
-		new_cat = netlbl_catmap_alloc(GFP_ATOMIC);
-		if (new_cat)
-			new_cat->next = ncats.attr.mls.cat;
-		ncats.attr.mls.cat = new_cat;
-		skp->smk_netlabel.flags &= ~(1U << 3);
-		rc = 0;
-	} else {
-		rc = smk_netlbl_mls(maplevel, mapcatset, &ncats, SMK_CIPSOLEN);
-	}
+
+	rc = smk_netlbl_mls(maplevel, mapcatset, &ncats, SMK_CIPSOLEN);
 	if (rc >= 0) {
 		old_cat = skp->smk_netlabel.attr.mls.cat;
 		rcu_assign_pointer(skp->smk_netlabel.attr.mls.cat, ncats.attr.mls.cat);
-- 
2.39.5


