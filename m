Return-Path: <stable+bounces-263821-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id StZlAY1oMWqgigUAu9opvQ
	(envelope-from <stable+bounces-263821-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:15:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49569690DC6
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:15:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SJYO+ksc;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263821-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263821-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29C3B31EAE2A
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF8443D4E8;
	Tue, 16 Jun 2026 15:08:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C002A429802;
	Tue, 16 Jun 2026 15:08:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622539; cv=none; b=T1fGnUw9alSOh6ipJCYlw3e4u0q0kBRK+dFPRDWq8GW6ygHdJvA5mP6/LL32EJH+sLNqHvulswqoEUR/V4/LtNKsq31Wfq6qbbDaji2K/v9qiixX4AM7jKVNd1xCTDC4KoRGO04ann+qGGd3lh44tUQF0H9KthjvKEAai5nbKkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622539; c=relaxed/simple;
	bh=6W7C4aAq2s1Rk5FD/MQNumBs51TXYYqQDXWyDqzXX4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jusfCtrZMajDKn9WN3Om2+bUE+KR+Qh2FOiK9ZU/zPLa7iL9yNe+It3lhLtlQ2j17VJRx1ShOS2vVFkdkasSOY3TKG1syiiw3v2r0UEuH/gp1iZKyTyWYwI8IYEwuEpzBSiYJgmZoAAQCR1lv5azSQCerkh4yekpN/9Zxx0RMac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJYO+ksc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165321F00A3D;
	Tue, 16 Jun 2026 15:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781622538;
	bh=fRYCEJGGbsLwqfrNLbJ3qqnMcfvhiZNMWDaTEuP0qWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SJYO+kscTWI6vZEd4GRfFOpZeqxztssiWSx5yfldPZKiVEFxnvVdD0kABQSOkpm9o
	 i7oKnn0L/ybhKo1PzJa1O4y77wnivc0iE8hD+isFjA6/v6mJGqQtmR5duBNUisGX2E
	 sjxevFbAf52YMHgK9KLZxzkldJF3QijoMiq1Zht+11VOHaZ/Xsg1yIFTN3TUeV5AgG
	 V1VWEaMGNfwd+ce3U/NXAkJ9XqsZGMC6MI/YE9Dh+ZydgXM4qI/eAJVK1X8M2wzn4Z
	 vclJFW5LIX/QUX/EDnnS7wdn6kv68YE5ifBCvSwRhUvuj3jIlGn2vjzu0mTAWceX9h
	 TcYByUfZC9ixw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 18 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/9] mm/damon/sysfs: kobject_del() target, context and kdamond dirs
Date: Tue, 16 Jun 2026 08:08:35 -0700
Message-ID: <20260616150844.88305-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616150844.88305-1-sj@kernel.org>
References: <20260616150844.88305-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sj@kernel.org,m:stable@vger.kernel.org,m:akpm@linux-foundation.org,m:jiapeng.chong@linux.alibaba.com,m:damon@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263821-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49569690DC6

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts.
Fix those issues for target, context and kdamond directories by adding
kobject_del() calls.

Fixes: c951cd3b8901 ("mm/damon: implement a minimal stub for sysfs-based DAMON interface")
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 2e95e3bac774d..d93f7919c3ca1 100644
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
@@ -2501,6 +2503,7 @@ static void damon_sysfs_kdamonds_rm_dirs(struct damon_sysfs_kdamonds *kdamonds)
 
 	for (i = 0; i < kdamonds->nr; i++) {
 		damon_sysfs_kdamond_rm_dirs(kdamonds_arr[i]);
+		kobject_del(&kdamonds_arr[i]->kobj);
 		kobject_put(&kdamonds_arr[i]->kobj);
 	}
 	kdamonds->nr = 0;
-- 
2.47.3

