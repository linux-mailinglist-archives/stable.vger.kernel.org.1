Return-Path: <stable+bounces-235772-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id R85sIPK+2mkC6AgAu9opvQ
	(envelope-from <stable+bounces-235772-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 23:36:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4303E1C3D
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 23:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 744D230209E0
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 21:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376CE280CFB;
	Sat, 11 Apr 2026 21:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GG59J4Qu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F571FC8;
	Sat, 11 Apr 2026 21:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775943404; cv=none; b=qIc0tFc4DFSD1R/eA+QFHOCGhgaonevEvFzMNMMWuM942kvjtC4QDFoMukkovULUXnFg2YSDBYyHvss1n2vpA7EbyFgz97GdBjF0cze39DGH8uYel/zyMvktThstTGk+6tE4SAqfP64+wbAfNojeUqfboDeE14XAspGfJRZr5k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775943404; c=relaxed/simple;
	bh=QPyTCBOcvix0CTzcdOfzWMx07raK0kRLMFwQNf37D0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CkjMT/rYXKRXGb8+9kWWgBZPl8NOZW+qlAs3H55cAhJbdBtO+ebCXRvrCGg99lBiEgcM8mADVdvDsZBHQPGCKF+4FP5ApR5ea47YYCfwxS0/3U+IAj7kyqegrvjQzrON6KhNXgd2j8UUsjcNaC49O49XRbFW109bLPnUs8DTDgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GG59J4Qu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E15C116C6;
	Sat, 11 Apr 2026 21:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775943403;
	bh=QPyTCBOcvix0CTzcdOfzWMx07raK0kRLMFwQNf37D0Y=;
	h=From:To:Cc:Subject:Date:From;
	b=GG59J4QuLV9E77nTCwE5A0NmaXg4XnCb9AHxSdTolltGc5w6hPwUzKtPiGUZt5ttt
	 WeivEuzp+8KD5CUscFpoGf5ckvEThPb/gBUGdGLiMgL7Aye8xX1BMseiH/8gDjJAL7
	 zDy0ZiH8NTtyr8QE7NuyvRhS80hHKPE4O5h/SXmkozeit7AdSD2c9Ir1UMDe3+IDMq
	 mHDYgkRfpYmxv+ax1TmLIuC+SVmwlGaFy+L9GchgfbxzRehhG5988aGS8l6rbOdDuG
	 MXUj9F4V5oR8b9sDZY357POBMSypneEah9DLjST58YwC/fvkHX7Yk6IoY2TwnT6yPn
	 hhj7jeZrblGzg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 18 . x" <stable@vger.kernel.org>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/damon/core: disallow non-power of two min_region_sz on damon_start()
Date: Sat, 11 Apr 2026 14:36:36 -0700
Message-ID: <20260411213638.77768-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235772-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA4303E1C3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit d8f867fa0825 ("mm/damon: add damon_ctx->min_sz_region")
introduced a bug that allows unaligned DAMON region address ranges.
Commit c80f46ac228b ("mm/damon/core: disallow non-power of two
min_region_sz") fixed it, but only for damon_commit_ctx() use case.
Still, DAMON sysfs interface can emit non-power of two min_region_sz via
damon_start().  Fix the path by adding the is_power_of_2() check on
damon_start().

The issue was discovered by sashiko [1].

[1] https://lore.kernel.org/20260403155530.64647-1-sj@kernel.org

Fixes: d8f867fa0825 ("mm/damon: add damon_ctx->min_sz_region")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3703f62a876b3..c107d74c77e74 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1368,6 +1368,11 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive)
 	int i;
 	int err = 0;
 
+	for (i = 0; i < nr_ctxs; i++) {
+		if (!is_power_of_2(ctxs[i]->min_region_sz))
+			return -EINVAL;
+	}
+
 	mutex_lock(&damon_lock);
 	if ((exclusive && nr_running_ctxs) ||
 			(!exclusive && running_exclusive_ctxs)) {

base-commit: 872b6168e577ea326324255fa8b6716a89124680
-- 
2.47.3

