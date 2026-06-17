Return-Path: <stable+bounces-266801-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7dBZI3W0Mmqd3wUAu9opvQ
	(envelope-from <stable+bounces-266801-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:51:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3D169AAC5
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:51:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CDB7fXxh;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266801-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-266801-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97581318D713
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 14:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA243B38A2;
	Wed, 17 Jun 2026 14:48:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9177A3F58E0;
	Wed, 17 Jun 2026 14:48:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707712; cv=none; b=POf+T35YDWe6byhlzRjrpoU1vDVvVuIHb5X7xPMnQHQaIvxPkYmYmtIj3qqU6NjBv8gsuiFxPYTI25G3H+AgYNIpr30OrBoPyZHXdCV1qFNcPDsx6/04AYBjBAvLRQCMADrur5R/St/emueEHNNTNBKwSVMCVCld0yvIFFx8QdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707712; c=relaxed/simple;
	bh=RrzjsI1WUKmi96R0Jjhfss4SKJGUgjQ7X7/YuTliBO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSLd29TPfXU/NTt9IIrwEw0RpuDA+DtA8sVKvOL07iHxvjwvEsYLmrdlItkzutgDhY78aAvRWGEioVj7Z6ZmVwCQLVx5BBSUZFc6EwXH2QpDMKwLXP36S2oeu9g0l/t1obuVxBthH5nX9otYtEP6pama6iP9a1pIuEHlKJ1T/uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDB7fXxh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7971F00A3F;
	Wed, 17 Jun 2026 14:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781707711;
	bh=L6MPeEDmuSnl5VMNAu0xLTOn+1aNO6rM35POBLTCeUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CDB7fXxhsPsBc6x2ZY3EvKqaB7hcb+fFR4C4FwWmmKS6s+Psk+6eZdopSyUqN0mfv
	 LfSxp9kMoGQDZv5MAauhg2oYEX64ASfCiJ4P1kM9DGP7dS35M1Eyeg/vyVNp4jcSoX
	 +2k684OkfKYEt3y0hnPP9lW3cSOjg0Fx4xqRWPwXAJtTu1ZnA4Z8+RoLRlWt7YRMlR
	 8DbtDejnCiQZpqlNzTv8K8X50X8FIrc5j5Y8maUZgrdWgjqbK0CbjDELLnQrNP1fjl
	 hl+WgC1bIlavfXd6vUQUvNaBl10q4H/Ki2kNKjTbkq0rP4vuOS2BBejPYhjfWqO1Rd
	 YTwTOjus8k3rg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 18 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 01/11] mm/damon/sysfs: kobject_del() target (normal), context and kdamond dirs
Date: Wed, 17 Jun 2026 07:47:55 -0700
Message-ID: <20260617144807.91441-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260617144807.91441-1-sj@kernel.org>
References: <20260617144807.91441-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sj@kernel.org,m:stable@vger.kernel.org,m:akpm@linux-foundation.org,m:jiapeng.chong@linux.alibaba.com,m:damon@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266801-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA3D169AAC5

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts. Fix
those issues for normal creation paths of target, context and kdamond
directories, and error paths of context and kdamond directories by
adding kobject_del() calls.

Note that this fix for target directories is not complete since it has a
similar issue in the damon_sysfs_targets_add_dirs() error path.  Because
the normal path issue and the error path issue are introduced by
different commits, this commit is fixing only the normal path issue.  A
commit for the error path will be added next.

Fixes: c951cd3b8901 ("mm/damon: implement a minimal stub for sysfs-based DAMON interface")
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 2e95e3bac774d..dba1c67fc188f 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -333,6 +333,7 @@ static void damon_sysfs_targets_rm_dirs(struct damon_sysfs_targets *targets)
 
 	for (i = 0; i < targets->nr; i++) {
 		damon_sysfs_target_rm_dirs(targets_arr[i]);
+		kobject_del(&targets_arr[i]->kobj);
 		kobject_put(&targets_arr[i]->kobj);
 	}
 	targets->nr = 0;
@@ -1642,6 +1643,7 @@ static void damon_sysfs_contexts_rm_dirs(struct damon_sysfs_contexts *contexts)
 
 	for (i = 0; i < contexts->nr; i++) {
 		damon_sysfs_context_rm_dirs(contexts_arr[i]);
+		kobject_del(&contexts_arr[i]->kobj);
 		kobject_put(&contexts_arr[i]->kobj);
 	}
 	contexts->nr = 0;
@@ -1680,13 +1682,15 @@ static int damon_sysfs_contexts_add_dirs(struct damon_sysfs_contexts *contexts,
 
 		err = damon_sysfs_context_add_dirs(context);
 		if (err)
-			goto out;
+			goto del_out;
 
 		contexts_arr[i] = context;
 		contexts->nr++;
 	}
 	return 0;
 
+del_out:
+	kobject_del(&context->kobj);
 out:
 	damon_sysfs_contexts_rm_dirs(contexts);
 	kobject_put(&context->kobj);
@@ -2501,6 +2505,7 @@ static void damon_sysfs_kdamonds_rm_dirs(struct damon_sysfs_kdamonds *kdamonds)
 
 	for (i = 0; i < kdamonds->nr; i++) {
 		damon_sysfs_kdamond_rm_dirs(kdamonds_arr[i]);
+		kobject_del(&kdamonds_arr[i]->kobj);
 		kobject_put(&kdamonds_arr[i]->kobj);
 	}
 	kdamonds->nr = 0;
@@ -2555,13 +2560,15 @@ static int damon_sysfs_kdamonds_add_dirs(struct damon_sysfs_kdamonds *kdamonds,
 
 		err = damon_sysfs_kdamond_add_dirs(kdamond);
 		if (err)
-			goto out;
+			goto del_out;
 
 		kdamonds_arr[i] = kdamond;
 		kdamonds->nr++;
 	}
 	return 0;
 
+del_out:
+	kobject_del(&kdamond->kobj);
 out:
 	damon_sysfs_kdamonds_rm_dirs(kdamonds);
 	kobject_put(&kdamond->kobj);
-- 
2.47.3

