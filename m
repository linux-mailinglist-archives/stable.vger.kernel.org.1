Return-Path: <stable+bounces-266772-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l88ADz+oMmo33QUAu9opvQ
	(envelope-from <stable+bounces-266772-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 15:59:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA4C69A58C
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 15:59:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cyaCzHfc;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266772-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-266772-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1294D3163CE6
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 13:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5B2436344;
	Wed, 17 Jun 2026 13:56:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93800429802;
	Wed, 17 Jun 2026 13:56:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781704583; cv=none; b=RBsRUbcCZrAKiM7+6Hq2rkZKqRWI0OouccH5pdL6w4cpFw7kLBj4UwGRq2b2PFqt4cd8hZkigDfQ68h5MkIQrmw1DbvX6uxGTG+JxJoha1rP+qW2GkTIlHJVPBF6sE8p/GabOyTwponlDFJaL/RJYFKuFoSfhE6Kv8Who9lrCsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781704583; c=relaxed/simple;
	bh=ms3mnDz+Ek5gjkdy+IsNqPfdvrEmdheVzOTBFeABAnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZFfdRGInkGd3KoKq9U625Q/trg873BtWwVKdNWtHNFO+CyVaNCb5F5FNmcIn5xjaqNRrvWq3nNNwJsA6oRmtViRV8h3tp647iEDJ94wldUp9HreExOHop6RZwRMAjZ4uM+fFipj8kA+fzMyKkNz2pLka4cKF17M3PmWDC5quUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyaCzHfc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B221F00A3A;
	Wed, 17 Jun 2026 13:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781704582;
	bh=304b+5TS5ljtcCjsmfNo5OTxh/l/vWic2mRv4DwMcZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cyaCzHfccCxiNdLe9RwuNDoWcG9TM+7UWaC6wYL0c1SFkbRS4UyuJQy2Cs3jMTC1s
	 TAOZdr6l0aQ9pIklCP/5b0Dk4l14FOUV88uanExxYm3tCcuset00oZTlFHz9cVXjhA
	 PZQ+kIdT6QFyng+u2uMXcrMbK35KJrAJd8U+7/3t+bJal1MmgCAs+s3A2ls5t38QXj
	 UHnfuD+x+RmSpKJ2Lf6soL/VRP67qh0usSCddqbYs/C7KQS9I0xiR80w+feDAjeL6Y
	 goad0Y8ab9+bTfRRBBYqlvwj7GJ7eHNUPz6Kf9fyPtLCU3c0YWaO7ZR1R/++wMtw7q
	 9Jz7zyVfPAuaA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 18 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 1/2] mm/damon/sysfs-schemes: fix dir put orders in access_pattern_add_dirs()
Date: Wed, 17 Jun 2026 06:55:48 -0700
Message-ID: <20260617135551.86013-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260617135551.86013-1-sj@kernel.org>
References: <20260617135551.86013-1-sj@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266772-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sj@kernel.org,m:stable@vger.kernel.org,m:akpm@linux-foundation.org,m:damon@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9AA4C69A58C

In access_pattern_add_dirs(), error handling path puts references
starting from setup failed directories.  If the failure happpened from
the initial allication in the setup functions, uninitialized memory
dereference happen.  The allocation failures will not commonly happen,
but the consequence is quite bad.  Fix the wrong reference put orders.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260617060005.86852-1-sj@kernel.org

Fixes: 7e84b1f8212a ("mm/damon/sysfs: support DAMON-based Operation Schemes")
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 329cfd0bbe9f3..7c00aa78b2f50 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1993,22 +1993,19 @@ static int damon_sysfs_access_pattern_add_dirs(
 	err = damon_sysfs_access_pattern_add_range_dir(access_pattern,
 			&access_pattern->sz, "sz");
 	if (err)
-		goto put_sz_out;
+		return err;
 
 	err = damon_sysfs_access_pattern_add_range_dir(access_pattern,
 			&access_pattern->nr_accesses, "nr_accesses");
 	if (err)
-		goto put_nr_accesses_sz_out;
+		goto put_sz_out;
 
 	err = damon_sysfs_access_pattern_add_range_dir(access_pattern,
 			&access_pattern->age, "age");
 	if (err)
-		goto put_age_nr_accesses_sz_out;
+		goto put_nr_accesses_sz_out;
 	return 0;
 
-put_age_nr_accesses_sz_out:
-	kobject_put(&access_pattern->age->kobj);
-	access_pattern->age = NULL;
 put_nr_accesses_sz_out:
 	kobject_put(&access_pattern->nr_accesses->kobj);
 	access_pattern->nr_accesses = NULL;
-- 
2.47.3

