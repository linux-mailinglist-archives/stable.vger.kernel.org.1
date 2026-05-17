Return-Path: <stable+bounces-249123-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPoWGIf6CWpPvwQAu9opvQ
	(envelope-from <stable+bounces-249123-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 19:27:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A81562869
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 19:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1A3B3027B7B
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 17:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055723C5DDC;
	Sun, 17 May 2026 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqUikQcW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0383BE645;
	Sun, 17 May 2026 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779038790; cv=none; b=CJERXr/fU9s6uQP58pCuOA99qyHAKS1COxaj4u1l1Glpd29H/o788xtRL2Jy185RFqhfn4tnKaAqpuvQMZI0SAZ9nIKN5WPt8pKDeJPz0yfoLiBry6sW0fMXPU7SnUlv0lGocE8iJe6BXHfBsRSo/BH090uSFt+AEP41mVcXGE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779038790; c=relaxed/simple;
	bh=uSmhrok23qhHp/UuKR5PcZR4/GmFUZQCLIknry70ibk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JfnB1mcnP2vojCSfFHHjzyW5QM1AaAS7ZowIa5g3cK14P244PqbZ/6C/E5GbgbFcGaCPebN/jjbXtXw1gR54paGzgJWI0RNE5B9U3xqqpybIM5kRSjEYXM9pNr3yvBv+gdQptK+ECyU3zSBSLmIrRd2oF/18GL5dsPGpLH9HHWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqUikQcW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F86DC2BCB0;
	Sun, 17 May 2026 17:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779038790;
	bh=uSmhrok23qhHp/UuKR5PcZR4/GmFUZQCLIknry70ibk=;
	h=From:To:Cc:Subject:Date:From;
	b=ZqUikQcW9Evjr7yatHBQHdM3uw52R38uUb2fVpt+MrdYfo6kq2QMD2JriXVJBsQGL
	 RJge6mPFr6oFhn1WRoqOfYuN7jDjvfOq/bW4atI+sFaPa5Bc8lkuQDmtLu+mnreJyK
	 jRPDOiZfoyMrf079tRQ0dXet/yk9Kq0WrJlb5jPX7pO6yZ/Zhs12tB7SlsAQk+2JWq
	 xvVbykHyrTwobwMdsrodM6AShwRWHERnOBLqgRO5rCQBzJelvWjIA6rJ1w/rWEe/Xy
	 LCN68rn/qhHye2VrgQKYGhNT14q7nx6tSJhlzmki3hhScpglOQXXEw7ytWwrrwOns4
	 6wbm2jlOlfxLw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 2 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2] mm/damon/sysfs-schemes: delete tried region in regions_rmdirs()
Date: Sun, 17 May 2026 10:26:21 -0700
Message-ID: <20260517172624.888-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E9A81562869
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249123-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

DAMON sysfs maintains the DAMOS tried region directory objects via a
linked list.  When the user requests refresh of the directories, DAMON
sysfs removes all the region directories first, and then generate
updated regions directory on the empty space.  The removal function
(damon_sysfs_scheme_regions_rm_dirs()) only puts the kobj objects.
Deletion of the container region object from the linked list is done
inside the kobj release callback function.

If somehow the callback invocation is delayed, the list will contain
regions list that gonna be freed.  If the updated region directories
creation is started in this situation, the list can be corrupted and
use-after-free can happen.

Because the kobj objects are managed by only DAMON sysfs, the issue
cannot happen in normal situation.  But, such delays can be made on
kernels that built with CONFIG_DEBUG_KOBJECT_RELEASE.  On the kernel,
the issue can indeed be reproduced like below.

    # damo start --damos_action stat
    # cd /sys/kernel/mm/damon/admin/kdamonds/0/
    # for i in {1..10}; do echo update_schemes_tried_regions > state; done
    # dmesg | grep underflow
    [   89.296152] refcount_t: underflow; use-after-free.

Fix the issue by removing the region object from the list when
decrementing the reference count.

Also update damos_sysfs_populate_region_dir() to add the region object
to the list only after the kobject_init_and_add() is success, so that
fail of kobject_init_and_add() is not leaving the deallocated object on
the list.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260513011920.119183-1-sj@kernel.org

Fixes: 9277d0367ba1 ("mm/damon/sysfs-schemes: implement scheme region directory")
Cc: <stable@vger.kernel.org> # 6.2.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from RFC
- RFC: https://lore.kernel.org/20260516211436.1883-1-sj@kernel.org
- Add region to the list after kobject_init_and_add() success.

 mm/damon/sysfs-schemes.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 5d966ac864193..b625f616f57e7 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -88,7 +88,6 @@ static void damon_sysfs_scheme_region_release(struct kobject *kobj)
 	struct damon_sysfs_scheme_region *region = container_of(kobj,
 			struct damon_sysfs_scheme_region, kobj);
 
-	list_del(&region->list);
 	kfree(region);
 }
 
@@ -164,7 +163,7 @@ static void damon_sysfs_scheme_regions_rm_dirs(
 	struct damon_sysfs_scheme_region *r, *next;
 
 	list_for_each_entry_safe(r, next, &regions->regions_list, list) {
-		/* release function deletes it from the list */
+		list_del(&r->list);
 		kobject_put(&r->kobj);
 		regions->nr_regions--;
 	}
@@ -2992,15 +2991,16 @@ void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
 	region = damon_sysfs_scheme_region_alloc(r);
 	if (!region)
 		return;
-	region->sz_filter_passed = sz_filter_passed;
-	list_add_tail(&region->list, &sysfs_regions->regions_list);
-	sysfs_regions->nr_regions++;
 	if (kobject_init_and_add(&region->kobj,
 				&damon_sysfs_scheme_region_ktype,
 				&sysfs_regions->kobj, "%d",
 				sysfs_regions->nr_regions)) {
 		kobject_put(&region->kobj);
+		return;
 	}
+	region->sz_filter_passed = sz_filter_passed;
+	list_add_tail(&region->list, &sysfs_regions->regions_list);
+	sysfs_regions->nr_regions++;
 }
 
 int damon_sysfs_schemes_clear_regions(

base-commit: 950de73f0f8bb17fc322e8f9ec09a5fbb4a72ed8
-- 
2.47.3

