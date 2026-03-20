Return-Path: <stable+bounces-227574-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMvnHI13vWmt9wIAu9opvQ
	(envelope-from <stable+bounces-227574-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 17:36:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C91F2DD834
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 17:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D44A300BC9A
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 16:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983D33B38A9;
	Fri, 20 Mar 2026 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="O317TOCR"
X-Original-To: stable@vger.kernel.org
Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FFA2641CA;
	Fri, 20 Mar 2026 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774024579; cv=pass; b=pZRoV/whDUlBMYanzrQFmGkwArY2SKq6VBupbUxpmfiNwWEr0GgqgYcYnB8m6ZdnD7C8V1tnYrOe0MywqAyMjHhf56qN6bPwLFKux49KU93DayWhOXvNHtNmFStvA1Q+sN1PnSgAh1ZRIPY1h5zxD+SiO+A6t20bmI1h0r01WP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774024579; c=relaxed/simple;
	bh=UxrDQ+bV476tvqQrvgRHKh9A8SplKNnFA7Ijhyo2+sg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jUrIANmJv+aO5jbNZtp0l8vDFGgMSWqM7Yawg3t1bei+ue8vJkRrdWmr/g0D4AcT+ztCOVnoaq1yjB5DTZILSkE4pCo0ggjcbdSgW7j3ltYd8/GGGUsGSI0JCLCdylB+GbKabpZNv9Z7xh70Iy79fzLsLPI6VSqYNhMYvwpW36I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=O317TOCR; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
ARC-Seal: i=1; a=rsa-sha256; t=1774024564; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=HzAb7DtkmPMMaHFoOtSy1ByOBce8Z2VsonMAgK3g7nAu1gS9o7GrQ9Y/z0xdTbtxrXsr18PpDiLO/NFezHOBw2DZQKExMfZjQztVz5W6d+/JkWrwA20CmYBBjAxhTXYfmFdSbYJ5Rt7Dumh8ozSmc497CFyfTmJJx5QfRj4h184=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774024564; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HdwGly0+BqBUHkF/IVpHh4nGFQLNRDEsFnAVEweW3Yw=; 
	b=RQTJMzmaKNcGEZIM0a0wqaVr0Rt73Z1x7zQ4w6S1YIPk649spcPUtC6azCFKp2LbBuUohC/4ua830oFdYWQ0mmyNrpWUElkd9COVdyrLGvKDq4sUUHqKUhMQwiEezbc3D2PWdxhMGXtaZ19sX373vL2jrldHQGd29jVc52dZWOg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774024564;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=HdwGly0+BqBUHkF/IVpHh4nGFQLNRDEsFnAVEweW3Yw=;
	b=O317TOCR0B+3T99gsNHIJKWes3cGthXqIYy6ZdbnlKhlZlbWf1aaYEk3lgRRV8Jy
	seuTTJJG68epxgzugQRpXwl/8EB56ZmjQRI/xWlVCR+pWjmNviU0yzLCY7EHlpY3CdP
	gxwIScXISBAC46AXC0oC0MoYa1NeI0VuWPnC1T7o=
Received: by mx.zoho.eu with SMTPS id 1774024561416667.7402047367142;
	Fri, 20 Mar 2026 17:36:01 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] mm/damon/sysfs: fix param_ctx leak on damon_sysfs_new_test_ctx() failure
Date: Fri, 20 Mar 2026 16:35:57 +0000
Message-Id: <20260320163559.178101-1-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[objecting.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[objecting.org:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227574-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[objecting.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[objecting@objecting.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[objecting.org:dkim,objecting.org:email,objecting.org:mid]
X-Rspamd-Queue-Id: 7C91F2DD834
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When damon_sysfs_new_test_ctx() fails in damon_sysfs_commit_input(),
param_ctx is leaked because the early return skips the cleanup at the
out label. Destroy param_ctx before returning.

Fixes: f0c5118ebb0e ("mm/damon/sysfs: catch commit test ctx alloc failure")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: Josh Law <objecting@objecting.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 576d1ddd736b..b573b9d60784 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1524,8 +1524,10 @@ static int damon_sysfs_commit_input(void *data)
 	if (IS_ERR(param_ctx))
 		return PTR_ERR(param_ctx);
 	test_ctx = damon_sysfs_new_test_ctx(kdamond->damon_ctx);
-	if (!test_ctx)
+	if (!test_ctx) {
+		damon_destroy_ctx(param_ctx);
 		return -ENOMEM;
+	}
 	err = damon_commit_ctx(test_ctx, param_ctx);
 	if (err)
 		goto out;
-- 
2.34.1


