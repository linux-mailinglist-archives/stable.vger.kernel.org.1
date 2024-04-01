Return-Path: <stable+bounces-34790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3A48940DB
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC201C2172A
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DCE41C89;
	Mon,  1 Apr 2024 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rn8W1wIf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27D91E525;
	Mon,  1 Apr 2024 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989306; cv=none; b=LXocOYt/0F4uRu2Wk2k2UXkVrq9MJOLxPXQ9cpiUCpDQh8NEw8epxVOMNPJgFIYnOUWLfVcj3S9quNuCL2AK9ykJuft/qvcCEW1HgyqVefkiXdDdCny+xUgtlwgPYUtvb5HWxHv6oPMS0gAOF4c77TtiJjVDu/zzIRxtEDmM7x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989306; c=relaxed/simple;
	bh=oFAdhbkMsGDK7IJlxDjI/ZeDgklq9sbfsVs0ahlHEF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qd7t1nRGk6si2DvJt+/u/PpjtFIH3f2KY11ptk4HAGhQlTdacyJxczYrTpAdhRMJdfEMLpeTbgf75Iqxx/OXkjML8TZMN42iEOrY1sJr5tyXhh/H1bLJUEykQkhFa6lJNle9saH+/lvg1Xrk70RHqAc6nmX8He81E3Coa6nk3p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rn8W1wIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5194EC43390;
	Mon,  1 Apr 2024 16:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711989305;
	bh=oFAdhbkMsGDK7IJlxDjI/ZeDgklq9sbfsVs0ahlHEF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rn8W1wIfVwpjWpDKB8k8GJC2GxchSe5smu7lnlCcnAXALaoP1CmDc7jkYeQBo//Qi
	 OKQECg0UPHL0+RPNK5W8EEv+rXSGziU29dkL7Aoye+MWi8ElI08bawpzcWeHNHrh5Z
	 0D8HVpkKA/n8sKGD7BTTnIQ8ULDz79FTN/FBsfLg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 010/396] smack: Set SMACK64TRANSMUTE only for dirs in smack_inode_setxattr()
Date: Mon,  1 Apr 2024 17:40:59 +0200
Message-ID: <20240401152548.191731952@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roberto Sassu <roberto.sassu@huawei.com>

[ Upstream commit 9c82169208dde516510aaba6bbd8b13976690c5d ]

Since the SMACK64TRANSMUTE xattr makes sense only for directories, enforce
this restriction in smack_inode_setxattr().

Cc: stable@vger.kernel.org
Fixes: 5c6d1125f8db ("Smack: Transmute labels on specified directories") # v2.6.38.x
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/smack/smack_lsm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 1f1ea8529421f..0fe3ccec62a52 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1312,7 +1312,8 @@ static int smack_inode_setxattr(struct mnt_idmap *idmap,
 		check_star = 1;
 	} else if (strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0) {
 		check_priv = 1;
-		if (size != TRANS_TRUE_SIZE ||
+		if (!S_ISDIR(d_backing_inode(dentry)->i_mode) ||
+		    size != TRANS_TRUE_SIZE ||
 		    strncmp(value, TRANS_TRUE, TRANS_TRUE_SIZE) != 0)
 			rc = -EINVAL;
 	} else
-- 
2.43.0




