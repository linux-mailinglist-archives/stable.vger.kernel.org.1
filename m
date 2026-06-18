Return-Path: <stable+bounces-266963-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OVXeMppCM2oQ+wUAu9opvQ
	(envelope-from <stable+bounces-266963-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 02:58:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E62B69CF1D
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 02:58:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BzvG7YBd;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266963-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-266963-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9318304C13E
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 00:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8D927A907;
	Thu, 18 Jun 2026 00:57:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9541327466A;
	Thu, 18 Jun 2026 00:57:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781744225; cv=none; b=Ft1kJ9U3Oly9esNZGtX0J0xUJnbDNJWD1ndvNnyXqJzduk/k3cNZya1vZcrEqsuGhsPfeC4io6VletvBXY3o3xhBtkvo4BRRa0XYuSkTbVBQ/qx8JHrdWO5KqPUZz+Ymhp4EpCcDdWhutkSGNYs5L+mEvNgFJ1/xQDQAjULIg5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781744225; c=relaxed/simple;
	bh=6Z4Q4SHb73Mx95B4ZI8V5uOZVQrl/2f/XsP/iI3CXkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qG24smX7CySd2aaQJlyq4mSyD1KGBlhe2YVY6PlQuxBZZ2DqBDB8FmeIWesN0sIH16R/52GEW+aurvhSQBahmULVdtFTrHH5kiejoJuQ9TJTiTaDLfb5xJvbih1t4oIsUgfUkdbOVcgX/cwAMpunpx9CCgZJeS9xiGFZKw2FO0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzvG7YBd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B301F000E9;
	Thu, 18 Jun 2026 00:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781744224;
	bh=vj1ysZXTzQEftM04gbB5WCu/uXQrIziK86sFp/rbmQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BzvG7YBdMMtJ2AqIrAKsD7LQV9XdMyH5w+jvu/0hi1pAnks/GEAGun40xtq8a+j0n
	 ZKjopGiUxwhtnsAdY9WjnLujhgVVr+vuNJlN7jZQjqVQQC3hnisf52E+cOOW47zHSO
	 mIkNjYcIPF8MMgnpCNVW/vgU4ARygL0kMQu4huZBWdEWJ54MDXRck2NofGTbLieEcP
	 6QDKfv9dAEQaRJACGJwjWFcNXbLV5EsgsrBhx0mhfLpoMoz0vwdezEAxNz8HduN2Wt
	 Yivavv1q7OtrtjkOp4vgAQtPqmobPg1CUINZF18h5i3qb6lVThJWOtUFYiaH7qI78o
	 3+TEy+4uwE48w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 2 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/2] mm/damon/sysfs-schemes: put stats for scheme_add_dirs() internal error
Date: Wed, 17 Jun 2026 17:56:48 -0700
Message-ID: <20260618005650.83868-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618005650.83868-1-sj@kernel.org>
References: <20260618005650.83868-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266963-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:sj@kernel.org,m:stable@vger.kernel.org,m:damon@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E62B69CF1D

damon_sysfs_scheme_add_dirs() setup the tried_regions directory after
the stats directory setup is completed.  When the tried_regions
directory setup is failed, the setup function ensures the reference for
the tried regions directory is released.  Hence the error path should
put references on setup succeeded directory objects, starting from the
stats directory.  However, the error path is putting the tried_regions
directory instead of the stats directory.

As a direct result, the stats directory object is leaked.  Worse yet, if
the tried_regions directory setup failed from the initial allocation,
the scheme->tried_regions field remains uninitialized.  The following
kobject_put(&scheme->tried_regions->kobj) call in the error path will
dereference the uninitialized memory.  The setup failures should not be
common.  But once it happens, the consequence is quite bad.

Fix this issue by correctly putting the stats directory instead of the
tried_regions directory.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260617005223.96813-1-sj@kernel.org

Fixes: 5181b75f438d ("mm/damon/sysfs-schemes: implement schemes/tried_regions directory")
Cc: <stable@vger.kernel.org> # 6.2.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 7c00aa78b2f50..0134111c3c1ff 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2513,12 +2513,12 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 		goto put_filters_watermarks_quotas_access_pattern_out;
 	err = damon_sysfs_scheme_set_tried_regions(scheme);
 	if (err)
-		goto put_tried_regions_out;
+		goto put_stats_out;
 	return 0;
 
-put_tried_regions_out:
-	kobject_put(&scheme->tried_regions->kobj);
-	scheme->tried_regions = NULL;
+put_stats_out:
+	kobject_put(&scheme->stats->kobj);
+	scheme->stats = NULL;
 put_filters_watermarks_quotas_access_pattern_out:
 	kobject_put(&scheme->ops_filters->kobj);
 	scheme->ops_filters = NULL;
-- 
2.47.3

