Return-Path: <stable+bounces-225720-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBebIJCXuGk8gQEAu9opvQ
	(envelope-from <stable+bounces-225720-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 00:51:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E87B02A2193
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 00:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 418193055120
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 23:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EC5379987;
	Mon, 16 Mar 2026 23:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BU0ZTXFD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EBE371D08;
	Mon, 16 Mar 2026 23:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773705087; cv=none; b=bwSOS+fU20yfcOuQ4Dw2Ud6c8jpZvBfuiY2v9VJCL5UigZ29qwUjG4Y0nqj7fzPkeINLvJDid8DlZ0HswQeLiMwaJwUMQFUKHVOuB5OhI7aaZeO4Aougd5n/4Kpnbi+sNa0+FSroY0RC+b5rTm2xI4iNmrTbNZ8BzRf3ye9RDLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773705087; c=relaxed/simple;
	bh=2RCyDp6yxdkFkrGuSTJt1rP/JNUEB1SMSr+RxZLc1Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eM5KVOqwtx6pDW3HwuKcCsJDGpGxB96oFcqnGd+MP76nd70eE4Jir/vr97+qU38wQNnabH007/iMnX8jg2/GT6hwJnApgrVvXP5K/j6mcxUq9uibj6Oc4wySC1yKH9RgNml6CrX+hT6CXc2v6mgS58y7KBunxkXgKxBR9n83q+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BU0ZTXFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A991C19421;
	Mon, 16 Mar 2026 23:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773705087;
	bh=2RCyDp6yxdkFkrGuSTJt1rP/JNUEB1SMSr+RxZLc1Yo=;
	h=From:To:Cc:Subject:Date:From;
	b=BU0ZTXFDpWubidgl3UQVb54EaQZZ8ggCdnoXsw55JpLalSmMYn1MHJaoMJ9YkzDox
	 6uY7qUvHyQEp8cevIiPGRAkRaJXrxiCzsHt6Y4XjhGBgV+6yjBgLXi9U7o7AC9H/WS
	 NGsM5+KXu0+tUT3VLMh+74u2xjCcySAr2684Ke7n2fCT+WmTu6qjz5J37MZkBI1Ufq
	 WGfiQq9bqNepsmiZtT9qblRdCiYyq0sy4Op06g3F1HDjijsLAOALfWTmonkKPOog3u
	 GF4/O/4w9gr7aq71he6g1nyVr89t7BLblLBkJSKF8EJ2ZHL4vfh3yx1re4wayahpGb
	 dGNOlTTnjyZ5A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3] mm/damon/stat: monitor all System RAM resources
Date: Mon, 16 Mar 2026 16:51:17 -0700
Message-ID: <20260316235118.873-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225720-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E87B02A2193
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DAMON_STAT usage document (Documentation/admin-guide/mm/damon/stat.rst)
says it monitors the system's entire physical memory.  But, it is
monitoring only the biggest System RAM resource of the system.  When
there are multiple System RAM resources, this results in monitoring only
an unexpectedly small fraction of the physical memory.  For example,
suppose the system has a 500 GiB System RAM, 10 MiB non-System RAM, and
500 GiB System RAM resources in order on the physical address space.
DAMON_STAT will monitor only the first 500 GiB System RAM.  This
situation is particularly common on NUMA systems.

Select a physical address range that covers all System RAM areas of the
system, to fix this issue and make it work as documented.

Fixes: 369c415e6073 ("mm/damon: introduce DAMON_STAT module")
Cc: <stable@vger.kernel.org> # 6.17.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from v2
(https://lore.kernel.org/20260315162717.80870-1-sj@kernel.org)
- Rebase to mm-hotfixes-unstable
Changes from v1
(https://lore.kernel.org/20260313044449.4038-1-sj@kernel.org)
- Fix wrong argument for damon_set_regions().

 mm/damon/stat.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index 25fb44ccf99d0..c5af8ad4bcb65 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -145,12 +145,57 @@ static int damon_stat_damon_call_fn(void *data)
 	return 0;
 }
 
+struct damon_stat_system_ram_range_walk_arg {
+	bool walked;
+	struct resource res;
+};
+
+static int damon_stat_system_ram_walk_fn(struct resource *res, void *arg)
+{
+	struct damon_stat_system_ram_range_walk_arg *a = arg;
+
+	if (!a->walked) {
+		a->walked = true;
+		a->res.start = res->start;
+	}
+	a->res.end = res->end;
+	return 0;
+}
+
+static unsigned long damon_stat_res_to_core_addr(resource_size_t ra,
+		unsigned long addr_unit)
+{
+	/*
+	 * Use div_u64() for avoiding linking errors related with __udivdi3,
+	 * __aeabi_uldivmod, or similar problems.  This should also improve the
+	 * performance optimization (read div_u64() comment for the detail).
+	 */
+	if (sizeof(ra) == 8 && sizeof(addr_unit) == 4)
+		return div_u64(ra, addr_unit);
+	return ra / addr_unit;
+}
+
+static int damon_stat_set_monitoring_region(struct damon_target *t,
+		unsigned long addr_unit, unsigned long min_region_sz)
+{
+	struct damon_addr_range addr_range;
+	struct damon_stat_system_ram_range_walk_arg arg = {};
+
+	walk_system_ram_res(0, -1, &arg, damon_stat_system_ram_walk_fn);
+	if (!arg.walked)
+		return -EINVAL;
+	addr_range.start = damon_stat_res_to_core_addr(
+			arg.res.start, addr_unit);
+	addr_range.end = damon_stat_res_to_core_addr(
+			arg.res.end + 1, addr_unit);
+	return damon_set_regions(t, &addr_range, 1, min_region_sz);
+}
+
 static struct damon_ctx *damon_stat_build_ctx(void)
 {
 	struct damon_ctx *ctx;
 	struct damon_attrs attrs;
 	struct damon_target *target;
-	unsigned long start = 0, end = 0;
 
 	ctx = damon_new_ctx();
 	if (!ctx)
@@ -180,8 +225,8 @@ static struct damon_ctx *damon_stat_build_ctx(void)
 	if (!target)
 		goto free_out;
 	damon_add_target(ctx, target);
-	if (damon_set_region_biggest_system_ram_default(target, &start, &end,
-							ctx->min_region_sz))
+	if (damon_stat_set_monitoring_region(target, ctx->addr_unit,
+				ctx->min_region_sz))
 		goto free_out;
 	return ctx;
 free_out:

base-commit: 10125b79cb0e7037fff6cd8cc9fafacfda8113a0
-- 
2.47.3

