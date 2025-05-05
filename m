Return-Path: <stable+bounces-141202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 316C3AAB153
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61BFF1BC20A5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1E43E58A7;
	Tue,  6 May 2025 00:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZiKyAkb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396CD2D1129;
	Mon,  5 May 2025 22:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485475; cv=none; b=l73dcIJ8ug9q50mAE2QSJ9VMwVKdcKfxchOuWLjtkYSz9t/rSBigj7GWW/3vkSXo8N6R6zDNw5QyE20SbT7os/vutV8W6tDFxarRPoDijFjLHU6/iF366U1wp+MX2e5ZHKF6ZxByKmy5YWMs/VOmeT6QlyZTKg4mAoHvOE4a0I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485475; c=relaxed/simple;
	bh=ywp+pIIcgYByOUSKGeAyjlKlGwm8eSXEf/1ZjQIEgr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d94U1FSlIs0FF956hIOkiVRR3FS+IX8nCsh1n6aaw9k4SuXdV71GJ1ecJveWZo2u0FfaSXuqLIoqVfqfkZ0RS2pLRSAtvSSD8Fh1ooIeYDGZ+nhHge91dS3NW/Ky6DGnK/2XLdqAt2hP+S4ZiD76USy1W1XRogSETH4AYxuhenk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZiKyAkb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB90C4CEEE;
	Mon,  5 May 2025 22:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485473;
	bh=ywp+pIIcgYByOUSKGeAyjlKlGwm8eSXEf/1ZjQIEgr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jZiKyAkbyygvfZy5E5KrM0dxhKP8fkes76852J/KBRoAFZ+u9x+8MVEwrHPXHKQgW
	 VNVs7T6cYM1ygfye4yjuCTirNqKu2m+D9ubgmWQTDBsEmEFa6EjsERlk/x1r55BvsC
	 tSKPsmZsGxxSY5H3Jbj00v6xiAKGXkf9dHKV5lEFfgTdMmCa8kybdhPxKwD1k60CLx
	 DOAuHVnHXslJchcZhR8kgX8EhSz0j53xps/47j15kw7iaioINbt0yJaa0lGFVe5krt
	 uGRqzcOd6UXV2bP0cF8rd9SCG52PP/uUD/sDXWF+FJL3Jd+PBba1zjygTczUpH+pM9
	 +/KfSsjL3gCEg==
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
Subject: [PATCH AUTOSEL 6.12 332/486] smack: recognize ipv4 CIPSO w/o categories
Date: Mon,  5 May 2025 18:36:48 -0400
Message-Id: <20250505223922.2682012-332-sashal@kernel.org>
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

[ Upstream commit a158a937d864d0034fea14913c1f09c6d5f574b8 ]

If SMACK label has CIPSO representation w/o categories, e.g.:

| # cat /smack/cipso2
| foo  10
| @ 250/2
| ...

then SMACK does not recognize such CIPSO in input ipv4 packets
and substitues '*' label instead. Audit records may look like

| lsm=SMACK fn=smack_socket_sock_rcv_skb action=denied
|   subject="*" object="_" requested=w pid=0 comm="swapper/1" ...

This happens in two steps:

1) security/smack/smackfs.c`smk_set_cipso
   does not clear NETLBL_SECATTR_MLS_CAT
   from (struct smack_known *)skp->smk_netlabel.flags
   on assigning CIPSO w/o categories:

| rcu_assign_pointer(skp->smk_netlabel.attr.mls.cat, ncats.attr.mls.cat);
| skp->smk_netlabel.attr.mls.lvl = ncats.attr.mls.lvl;

2) security/smack/smack_lsm.c`smack_from_secattr
   can not match skp->smk_netlabel with input packet's
   struct netlbl_lsm_secattr *sap
   because sap->flags have not NETLBL_SECATTR_MLS_CAT (what is correct)
   but skp->smk_netlabel.flags have (what is incorrect):

| if ((sap->flags & NETLBL_SECATTR_MLS_CAT) == 0) {
| 	if ((skp->smk_netlabel.flags &
| 		 NETLBL_SECATTR_MLS_CAT) == 0)
| 		found = 1;
| 	break;
| }

This commit sets/clears NETLBL_SECATTR_MLS_CAT in
skp->smk_netlabel.flags according to the presense of CIPSO categories.
The update of smk_netlabel is not atomic, so input packets processing
still may be incorrect during short time while update proceeds.

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/smack/smackfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 5dd1e164f9b13..d27e8b916bfb9 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -933,6 +933,10 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 	if (rc >= 0) {
 		old_cat = skp->smk_netlabel.attr.mls.cat;
 		rcu_assign_pointer(skp->smk_netlabel.attr.mls.cat, ncats.attr.mls.cat);
+		if (ncats.attr.mls.cat)
+			skp->smk_netlabel.flags |= NETLBL_SECATTR_MLS_CAT;
+		else
+			skp->smk_netlabel.flags &= ~(u32)NETLBL_SECATTR_MLS_CAT;
 		skp->smk_netlabel.attr.mls.lvl = ncats.attr.mls.lvl;
 		synchronize_rcu();
 		netlbl_catmap_free(old_cat);
-- 
2.39.5


