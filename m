Return-Path: <stable+bounces-80227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A3C98DC87
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3821C20FE1
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE271D2795;
	Wed,  2 Oct 2024 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y5r615Yu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482C93D994;
	Wed,  2 Oct 2024 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879752; cv=none; b=NmuqK884LgvVjuk2Ca3iH1WBM53YwWP2SElWKwq+ZPfiaMSr8GrIwnjla5KSsC2qRGORI1lCooGhkbWGYr2msHzKkKf3sWz9VcM5yz/w1L0L3lS/Y6Q9hz8T1ES6LngV6F1v7J5knCVI6qoF5VPrKm8LOoyiIHOZJWPbpRrm+YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879752; c=relaxed/simple;
	bh=z/T7CXFLfelAeeDxCHMEke4rzzCOschEH0fJ+sUvYx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrqrSuOI6nIh90+kzbxAnaZBkX66OvhsC54w0Pgj+JHUwWEEnaKWvzu1c5KaJhQA/HU3z/FKgn7rQpJDzTxemlrkKmu9Odv7onzFIAq7yRxQbpYjp7Ro+ivReLPyLxrGXSNgz9IhSH11A4ugIEdureN+eZ3KfZRsfiSwue/9nyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y5r615Yu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68EBC4CEC2;
	Wed,  2 Oct 2024 14:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727879752;
	bh=z/T7CXFLfelAeeDxCHMEke4rzzCOschEH0fJ+sUvYx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y5r615YukMSLvLtv2GJRyu0ysJuY6hH5TVTX7FAEaZvAokEje/vkxs5r6QF861rEP
	 UC3W9ns6vdEEACwWR6XcmPpLE5VyEYnLFgbhR2E2fpNPdh4hZIJgDZ2WgTQxKyecR+
	 xd5c+k0IwDwK1GMIaw1zABsJ4FblKJOV129xfcxo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiawei Ye <jiawei.ye@foxmail.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 225/538] smackfs: Use rcu_assign_pointer() to ensure safe assignment in smk_set_cipso
Date: Wed,  2 Oct 2024 14:57:44 +0200
Message-ID: <20241002125801.135108957@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
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

From: Jiawei Ye <jiawei.ye@foxmail.com>

[ Upstream commit 2749749afa071f8a0e405605de9da615e771a7ce ]

In the `smk_set_cipso` function, the `skp->smk_netlabel.attr.mls.cat`
field is directly assigned to a new value without using the appropriate
RCU pointer assignment functions. According to RCU usage rules, this is
illegal and can lead to unpredictable behavior, including data
inconsistencies and impossible-to-diagnose memory corruption issues.

This possible bug was identified using a static analysis tool developed
by myself, specifically designed to detect RCU-related issues.

To address this, the assignment is now done using rcu_assign_pointer(),
which ensures that the pointer assignment is done safely, with the
necessary memory barriers and synchronization. This change prevents
potential RCU dereference issues by ensuring that the `cat` field is
safely updated while still adhering to RCU's requirements.

Fixes: 0817534ff9ea ("smackfs: Fix use-after-free in netlbl_catmap_walk()")
Signed-off-by: Jiawei Ye <jiawei.ye@foxmail.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/smack/smackfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index e22aad7604e8a..5dd1e164f9b13 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -932,7 +932,7 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 	}
 	if (rc >= 0) {
 		old_cat = skp->smk_netlabel.attr.mls.cat;
-		skp->smk_netlabel.attr.mls.cat = ncats.attr.mls.cat;
+		rcu_assign_pointer(skp->smk_netlabel.attr.mls.cat, ncats.attr.mls.cat);
 		skp->smk_netlabel.attr.mls.lvl = ncats.attr.mls.lvl;
 		synchronize_rcu();
 		netlbl_catmap_free(old_cat);
-- 
2.43.0




