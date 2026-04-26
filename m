Return-Path: <stable+bounces-241177-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJdsOyhN7mnPsAAAu9opvQ
	(envelope-from <stable+bounces-241177-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 19:36:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E3F46AAE6
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 19:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3D2B301494E
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 17:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51CE257ACF;
	Sun, 26 Apr 2026 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XU6vj17C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673C5EEC0;
	Sun, 26 Apr 2026 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777224994; cv=none; b=nCH3/J58/shVEpbBiwl/8j5ju2AvuWw/F0tajw/l868Sb5eJbabWMPPagO9vsZcwohbH8efHvJ/3yVqhbDmIqiB1mUHTy08L5hnk1tXa2pZwxAQZHS1O/PJuhR9tfsWx223I5R3VoIWgfo1gShdJmXGcjaFiCwdLWEA+j94pzl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777224994; c=relaxed/simple;
	bh=KvSnvOhyWjleirQU9z5e2xFONCdcqdSmhG+4jkdX/YU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uj6p3K98CbS3OeZ+3yUvhKZ/HzUVy6AHHggUnRYLiTdShHxwmfwein2wITd84GqeBhENZVvhHvcbh6xFD2grKQ7FUf5g+mEQ/W9bdaLWdTJtwWpaHLGbAjsVXbu69xyPgj1vq5km8tQOPmwS3XBEYbI+JziKODRKBOICfq2yZT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XU6vj17C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D409DC2BCAF;
	Sun, 26 Apr 2026 17:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777224994;
	bh=KvSnvOhyWjleirQU9z5e2xFONCdcqdSmhG+4jkdX/YU=;
	h=From:To:Cc:Subject:Date:From;
	b=XU6vj17CgcR2KLRsj+KMMZ6pRz/MMIqmQOMrQgFe3KscTBSoSVL9eYF0w+xg2g6sc
	 SvJQGqCEoYJuVGL3mrOf0AZZuRQ76jBixxLoqBmkndxxdSOgmdX5LHcGpHeqrufgc2
	 h7UitJfkqGzTYtQR147S9JSEhD26GtPfFWQ+XbxLl5sp5ir2E2hujgoWvkYIDxo0uZ
	 21/ni0TpcVRd7fk8xdbXG2+yG5wLSwDgRDY/TDHbYVibANzffV3nSJSGRCUFsN26Nl
	 NQdtLMghgf8O+Kb16POFvumzXVisB0RDQaO7skwAbHm0MDqUmVl4GOkbI84nfdXP4E
	 Z4gdQbCNFUXvA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 3 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/damon/sysfs-schemes: call missing mem_cgroup_iter_break()
Date: Sun, 26 Apr 2026 10:36:12 -0700
Message-ID: <20260426173625.86521-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 38E3F46AAE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241177-lists,stable=lfdr.de];
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

damon_sysfs_memcg_path_to_id() breaks mem_cgroup_iter() loop without
calling mem_cgroup_iter_break().  This leaks the cgroup reference.  Fix
the issue by calling mem_cgroup_iter_break() before the break.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260423004148.74722-1-sj@kernel.org

Fixes: 29cbb9a13f05 ("mm/damon/sysfs-schemes: implement scheme filters")
Cc: <stable@vger.kernel.org> # 6.3.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from RFC
- rfc: https://lore.kernel.org/20260425202446.108095-1-sj@kernel.org
- Rebase to latest mm-new.

 mm/damon/sysfs-schemes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 245d63808411a..04746cbb33272 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2594,6 +2594,7 @@ static int damon_sysfs_memcg_path_to_id(char *memcg_path, u64 *id)
 		if (damon_sysfs_memcg_path_eq(memcg, path, memcg_path)) {
 			*id = mem_cgroup_id(memcg);
 			found = true;
+			mem_cgroup_iter_break(NULL, memcg);
 			break;
 		}
 	}

base-commit: 63037c6230622d20536f4327a162b82cd59fb483
-- 
2.47.3

