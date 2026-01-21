Return-Path: <stable+bounces-210632-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BOLJwwrcGmyWwAAu9opvQ
	(envelope-from <stable+bounces-210632-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:25:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8DB4F103
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CACF268F79F
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 01:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49143093CF;
	Wed, 21 Jan 2026 01:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkFNPLSv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800393019CB;
	Wed, 21 Jan 2026 01:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768958612; cv=none; b=ASGeiNgR6RP6D3iksQd5E8lZNjXJdcj2ZwDW4I64r9PkuUUNaMEgS5PYH1FW1/6zBtCW7TjK5Qb0Zn23+OxJUhzXcsewZ7BKDWKx6AIwsUNV3P4g5bEExtKyfQO5YnC5jFwtU23sYuL4YCC8eJIk8Fg746n5x9ILZlSPpdnSqrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768958612; c=relaxed/simple;
	bh=ZVl8zwmV6QFDiCpZpunlApXWiZSpvgx9ANB4Zbbvq54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VImXREtndSNc6D09LBXeOpufVgaL2UaAh8kGwqpCCnogvi5gb8B5y4m8ETM+74fPG0iDLnaXwUbF23VEqgVs+eDHRC9nDUmGf0fPMlkxHL+X/Szr3du6273TxKeXiMhJx7V8IwqvPgEk5kB1oxI2NGEqJhakLqBQnPEHPc5Bg2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkFNPLSv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BA9C16AAE;
	Wed, 21 Jan 2026 01:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768958612;
	bh=ZVl8zwmV6QFDiCpZpunlApXWiZSpvgx9ANB4Zbbvq54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VkFNPLSvzo+DpxZQvBkGFk+s0/VVGhwTKonm70yPVUipnem0lkGFHkFg3aW8p5HHQ
	 W53/kKHypPZSaONS4VA3YWUnseKKKC561SL8XGG5dnTdmgZ+sxFhf9QuuMWUwVVSF3
	 FJvgthbMMmbUCIVKQfDaBjVow+hc/xg3+Qc3ElIQlUVbmdNYBBa5UeuXbvLEUabT85
	 GVwTFOtwYMslFgaFOZSmPGnXpA0NOyKj61kb8nFD1UpkTKz9RQ1bz8xG/jrJlxun1a
	 esiKQcgb4AFoLa6xCf18zWq0T/C4EwebmfWEmYx7+Llx8CzsZB3koEnrpjQFxvs+1j
	 X7bHe9WfR5YXg==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	chongjiapeng <jiapeng.chong@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/sysfs-scheme: cleanup quotas subdirs on scheme dir setup failure
Date: Tue, 20 Jan 2026 17:23:21 -0800
Message-ID: <20260121012321.243917-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026012002-resume-although-c862@gregkh>
References: <2026012002-resume-although-c862@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210632-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,alibaba.com:email]
X-Rspamd-Queue-Id: 3D8DB4F103
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a DAMOS-scheme DAMON sysfs directory setup fails after setup of
quotas/ directory, subdirectories of quotas/ directory are not cleaned up.
As a result, DAMON sysfs interface is nearly broken until the system
reboots, and the memory for the unremoved directory is leaked.

Cleanup the directories under such failures.

Link: https://lkml.kernel.org/r/20251225023043.18579-4-sj@kernel.org
Fixes: 1b32234ab087 ("mm/damon/sysfs: support DAMOS watermarks")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: chongjiapeng <jiapeng.chong@linux.alibaba.com>
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit dc7e1d75fd8c505096d0cddeca9e2efb2b55aaf9)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 18f459a3c9fff..9621e31016f85 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -859,7 +859,7 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 		goto put_access_pattern_out;
 	err = damon_sysfs_scheme_set_watermarks(scheme);
 	if (err)
-		goto put_quotas_access_pattern_out;
+		goto rmdir_put_quotas_access_pattern_out;
 	err = damon_sysfs_scheme_set_stats(scheme);
 	if (err)
 		goto put_watermarks_quotas_access_pattern_out;
@@ -868,7 +868,8 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 put_watermarks_quotas_access_pattern_out:
 	kobject_put(&scheme->watermarks->kobj);
 	scheme->watermarks = NULL;
-put_quotas_access_pattern_out:
+rmdir_put_quotas_access_pattern_out:
+	damon_sysfs_quotas_rm_dirs(scheme->quotas);
 	kobject_put(&scheme->quotas->kobj);
 	scheme->quotas = NULL;
 put_access_pattern_out:
-- 
2.47.3


