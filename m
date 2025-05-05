Return-Path: <stable+bounces-141201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD36AAB158
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248D0169F54
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC632283136;
	Tue,  6 May 2025 00:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNn22iVk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266662D113B;
	Mon,  5 May 2025 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485476; cv=none; b=LRqBdXHG21qaI+d9iEf4hhFD7LxDnCsLoHkX1Oooeap/a1GcIDZoGdcVnNX9nX5LBh78/+w2zt4j1tMzkvh4971xWpbn6NtAi/y4s18S9dmQzLNfnDCn304ZGQIJRmysYVwfxjducOY2lGEOoW88vC5upzkAIZRlW/y1j1jAlrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485476; c=relaxed/simple;
	bh=KIDLk6KyiEPX8YtWc7GFI7aZ7J9iJ+RTxHcjOuBptu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zb9bvSQyel1grGt/jOAsBkffOfZd0vXCa4jZejRgD0sJKdjeI1+lhm+OFGrGKA27Ldz2fP3be4/pnZh1tKEzJ5R1PLdcV+SNT1LRMvqDGUxMeIfIQ6ww4IxsvOQh/HtSru/u9dIkBpLqhwLbkbyqd2ZQ9V5yIQvLiyi5K3iBUVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNn22iVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05485C4CEED;
	Mon,  5 May 2025 22:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485475;
	bh=KIDLk6KyiEPX8YtWc7GFI7aZ7J9iJ+RTxHcjOuBptu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oNn22iVk26hSEIrUA2zmF7/1YyehV2cjLqgOEBcSDBFRGaU5NHovHyaUFy/pmSCU2
	 v2P7qJ9H+T81Mws0GOC+yl5egoXvSfhd2+vdejzHu6N5tfHdDFoycL79/5wGOtE6nK
	 +bTZEr+sJrZwzOI6uG0KVa7IbxSPi+sqBbyQrWeHywwMLDroSKxTp2hrGxccS9WvHg
	 tzNHjl6AduKcnchDWCLie4coWDe9fTuNQ9uazqhfLvJdlFu5sTtZIKvvh+drRyfPxe
	 ZuujBnOhJcip+eP4Wskgr2r0xInIRPTkLd1HTKioUemCyP4snqugLbo9xh/S58Hd1m
	 QGYXqQbQ+aV7g==
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
Subject: [PATCH AUTOSEL 6.12 333/486] smack: Revert "smackfs: Added check catlen"
Date: Mon,  5 May 2025 18:36:49 -0400
Message-Id: <20250505223922.2682012-333-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index d27e8b916bfb9..1e35c9f807b2b 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -830,7 +830,7 @@ static int smk_open_cipso(struct inode *inode, struct file *file)
 static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 				size_t count, loff_t *ppos, int format)
 {
-	struct netlbl_lsm_catmap *old_cat, *new_cat = NULL;
+	struct netlbl_lsm_catmap *old_cat;
 	struct smack_known *skp;
 	struct netlbl_lsm_secattr ncats;
 	char mapcatset[SMK_CIPSOLEN];
@@ -917,19 +917,8 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 
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


