Return-Path: <stable+bounces-266802-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gEqpLqW0Mmq03wUAu9opvQ
	(envelope-from <stable+bounces-266802-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:52:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2287E69AAD3
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:52:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UVxXd2YX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266802-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266802-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09F1731BDC04
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 14:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C695F19EED3;
	Wed, 17 Jun 2026 14:48:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4D443D4EE;
	Wed, 17 Jun 2026 14:48:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707715; cv=none; b=NnWV29cQYFt9tu70Hn6LKBDp4EIAfD7Yi8SgYVFu5aNgtYEEOv0UIcFd2OjO0WzreNGxId+89IUQo/b8LdyfDPriAA+o1+zeu0vn9mCUT15LSaIS312Wx92YiMd1nMdVNYHDP1OPeIt0A1gu6X0SyvtfzhlDBTs9VRtJM5AzoOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707715; c=relaxed/simple;
	bh=HWdAP7bN8wgLM9Uk9w1J0MsTcc9ctSj3NsL8gL3RJmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1m0SuprDejMszcj54Un7tei2gxO/l0NbqxHrv8eXFkXAzUGKEPXJ/vrAcHc/ovv1Hxt3OzibJW9TWVR/i3e99W/KMpCZUOBPPBngvUr1xrZoFngj1dgPjqmB+KN9gU8WHfs+u9c7w9A5W1PJ2aurf5Gnn8cRFTHMGYbGnDvOEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVxXd2YX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF3A1F000E9;
	Wed, 17 Jun 2026 14:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781707712;
	bh=f+ZFI7Qgbe7xnOZyetZ4L3vI22eJ2l2ckq5hmR8a2XY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UVxXd2YXwpYsPaBtMxM9HElDwEg9rP0hxcsnpXi1/rBg5I54lAOndY2s1LZcLjtJS
	 a4528TTqCrHARYcSxWzsGnb7j7l7qv68OOZZ5OjgHdSuGw809Zbrn5M+Rhp3nhr2SG
	 H7D9jNT/owCWRE2mxBKG9AikIEbr5Upnf0ULRT8lxTTiNXHE1BZCo5AdpKvN+Q4VhO
	 IooLKTCvvSUzXfYZOTE26gZ6YwLBtDUijfjBwhpOwjMuT3C6F2k/eXXZDzQ9oAmesE
	 KBe74AwM91+YT5ksiBxqUIDm2m1JyIRXCRoOCUKjOBuZnO+qKI1uoz+ecKXQ4m7RsE
	 3P+dlmPi7BVCQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 18 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 02/11] mm/damon/sysfs: kobject_del() region and target (error) dirs
Date: Wed, 17 Jun 2026 07:47:56 -0700
Message-ID: <20260617144807.91441-3-sj@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266802-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2287E69AAD3

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts. Fix
those issues for the normal creation path of region directories and the
error path of target directories, by adding kobject_del() calls.

Fixes: 2031b14ea757 ("mm/damon/sysfs: support the physical address space monitoring")
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index dba1c67fc188f..3c349f0fe80f0 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -107,8 +107,10 @@ static void damon_sysfs_regions_rm_dirs(struct damon_sysfs_regions *regions)
 	struct damon_sysfs_region **regions_arr = regions->regions_arr;
 	int i;
 
-	for (i = 0; i < regions->nr; i++)
+	for (i = 0; i < regions->nr; i++) {
+		kobject_del(&regions_arr[i]->kobj);
 		kobject_put(&regions_arr[i]->kobj);
+	}
 	regions->nr = 0;
 	kfree(regions_arr);
 	regions->regions_arr = NULL;
@@ -372,13 +374,15 @@ static int damon_sysfs_targets_add_dirs(struct damon_sysfs_targets *targets,
 
 		err = damon_sysfs_target_add_dirs(target);
 		if (err)
-			goto out;
+			goto del_out;
 
 		targets_arr[i] = target;
 		targets->nr++;
 	}
 	return 0;
 
+del_out:
+	kobject_del(&target->kobj);
 out:
 	damon_sysfs_targets_rm_dirs(targets);
 	kobject_put(&target->kobj);
-- 
2.47.3

