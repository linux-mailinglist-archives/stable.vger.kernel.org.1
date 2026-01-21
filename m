Return-Path: <stable+bounces-210625-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMu/A1gocGmyWwAAu9opvQ
	(envelope-from <stable+bounces-210625-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:14:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7F84EED1
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E66603A4F6E
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 01:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5982F39A3;
	Wed, 21 Jan 2026 01:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGkKHZqY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E0F28850E;
	Wed, 21 Jan 2026 01:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768958033; cv=none; b=qi6sGlKSYw0jxM7pORNa4etKcbZtlKWYRhk+elW1o5GBbMKv/mCrM3+8FPP5vkNF1xTZnHfBZOnrxmfNzipeeQ6CkX8GNroz+kpJGO6NYEsTP8w4RtbdoadcgkqSKTI8bH8u1XMM9TSGxqaNB9Jt+yML9Itv91gV/QIgBUoYpg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768958033; c=relaxed/simple;
	bh=uai1Xw1Kf9LGCGIchC0ILt4/1gjQzAIUN9i0sIXflfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6w1Enof0Xb6AeE6SJRVxRwPIJ24vA1buMwXBl7kpNVngp+xml69SG5RgXHXpVNvFU77pwENJbsN9BoMdEowtEorLGShSx/J4UEbPFGkmjRNEqzRGDgSKuRPGUiqer1hsh/DNUQ2sVKEwCmsb+csnkf9jnko/HgL+piD7ETO7ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGkKHZqY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BC0C16AAE;
	Wed, 21 Jan 2026 01:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768958033;
	bh=uai1Xw1Kf9LGCGIchC0ILt4/1gjQzAIUN9i0sIXflfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SGkKHZqYlm4D47FY3yLAV8d1VrfnlSH8TUtjCRERPXr/x+PmykiI8VCGS/HoN8Znx
	 KZ6b0SHre3MBwBa0kT5Zv+aybKLxvKIT6DaeqIMkM4NW6orcm6PtAW+1Wv8+YyFUsZ
	 igKjEGqBbnHXAhNqIsPNau/8BTJIywhr5jPTqfGqPklqXU+Zil1cX2S1SAsZmKWdL0
	 A9fbtK3kG/z+WWf+RwAD57j6F0gD1Ej0x9e03+XEwih/qymlHLGRZivtlD8fDYAqIf
	 hU5Sf9QQJScB2nO+oe3tAzRBvXGek1AFBAPanItRuREhk8VQ3l/g6aoqpfwKRip4HV
	 qOReeWvawySJA==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	chongjiapeng <jiapeng.chong@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/sysfs-scheme: cleanup quotas subdirs on scheme dir setup failure
Date: Tue, 20 Jan 2026 17:13:43 -0800
Message-ID: <20260121011343.164810-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026012001-thud-campfire-994f@gregkh>
References: <2026012001-thud-campfire-994f@gregkh>
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
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210625-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,alibaba.com:email,linux-foundation.org:email]
X-Rspamd-Queue-Id: 8A7F84EED1
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
 mm/damon/sysfs-schemes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 19d661889cf79..7e65223d63ee6 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1287,7 +1287,7 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 		goto put_access_pattern_out;
 	err = damon_sysfs_scheme_set_watermarks(scheme);
 	if (err)
-		goto put_quotas_access_pattern_out;
+		goto rmdir_put_quotas_access_pattern_out;
 	err = damon_sysfs_scheme_set_filters(scheme);
 	if (err)
 		goto put_watermarks_quotas_access_pattern_out;
@@ -1308,7 +1308,8 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
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


