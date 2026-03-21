Return-Path: <stable+bounces-227784-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJstDo/bvmnZfgMAu9opvQ
	(envelope-from <stable+bounces-227784-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 18:55:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 899052E6A00
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 18:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DE55302206B
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 17:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64833446CA;
	Sat, 21 Mar 2026 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPBqAj1U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BEB33F37A;
	Sat, 21 Mar 2026 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774115676; cv=none; b=avIyBwvSwen7++nusbK8MGJz86kdcSXmYCX++72iY1QWFvBvxFPqIR2nBus5UahIZgVyb93clZR4i2lsv9+yPdQ7OfokHzGz48LiGr37EPZALqnqprMzGokOF0T6GyAEcKhy56xlpKmbgbqqBhym40Ys95O4dJmDwdDFqtVQUb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774115676; c=relaxed/simple;
	bh=ypF4xKp6F1pbIquY3/unFTj0ZaJ4QsmqDevrapmiqYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9mnHL9vwXoYrPQ1rCnCEPnsy4Wys8YQHPTt3eAKI8QrgTHAZacd0z6e11Vgfw0T/Kn94dJJRLTjlZQcKSxdiIK6xdTp5G/ClK48koTXEA41t7Eqqj8tQAj20xMeqR00ZaDMZQJ3t2dyYxZTXg2lJFWChQBENcEOJadMuQe9cyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPBqAj1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E350C2BCB4;
	Sat, 21 Mar 2026 17:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774115676;
	bh=ypF4xKp6F1pbIquY3/unFTj0ZaJ4QsmqDevrapmiqYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QPBqAj1UYUg3nMWYne8Sya+MKgu4V7EeGKLthl0o51iCB0NAPgs7sQgaXh4Xw8fds
	 2SU98NaNJ6MzubLEcUwGsVNIrEl9fomH6UIR1GjgcAr0qzkjoKQCVU3SbfxYkY2vZ/
	 uf2IwjhSs2FLSovNyLMfQUDal9VQijGA5yBmyICBzrzdUi/jhDx/WSjrYUnfLhsc3c
	 D0pPtbGN+xU9+tIGrC28zdpiWLbAFzGViZZ1ZbQB7/Z96r9ZVuZAw9JzvYt0FBTEXj
	 82ykqjvPVIW7xc+YYHt+LiyuD28YP5oqnjg/0115RkfzVYi01+0926YFH+/QpJMhFr
	 WpIlklGViaYsA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Josh Law <objecting@objecting.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 3/3] mm/damon/sysfs: check contexts->nr in repeat_call_fn
Date: Sat, 21 Mar 2026 10:54:26 -0700
Message-ID: <20260321175427.86000-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321175427.86000-1-sj@kernel.org>
References: <20260321175427.86000-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227784-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[objecting.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 899052E6A00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Josh Law <objecting@objecting.org>

damon_sysfs_repeat_call_fn() calls damon_sysfs_upd_tuned_intervals(),
damon_sysfs_upd_schemes_stats(), and
damon_sysfs_upd_schemes_effective_quotas() without checking
contexts->nr.  If nr_contexts is set to 0 via sysfs while DAMON is
running, these functions dereference contexts_arr[0] and cause a NULL
pointer dereference.  Add the missing check.

For example, the issue can be reproduced using DAMON sysfs interface and
DAMON user-space tool (damo) [1] like below.

    $ sudo damo start --refresh_interval 1s
    $ echo 0 | sudo tee \
            /sys/kernel/mm/damon/admin/kdamonds/0/contexts/nr_contexts

[1] https://github.com/damonitor/damo

Link: https://patch.msgid.link/20260320163559.178101-3-objecting@objecting.org
Fixes: d809a7c64ba8 ("mm/damon/sysfs: implement refresh_ms file internal work")
Cc: <stable@vger.kernel.org> # 6.17.x
Signed-off-by: Josh Law <objecting@objecting.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index ddc30586c0e61..6a44a2f3d8fc9 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1620,9 +1620,12 @@ static int damon_sysfs_repeat_call_fn(void *data)
 
 	if (!mutex_trylock(&damon_sysfs_lock))
 		return 0;
+	if (sysfs_kdamond->contexts->nr != 1)
+		goto out;
 	damon_sysfs_upd_tuned_intervals(sysfs_kdamond);
 	damon_sysfs_upd_schemes_stats(sysfs_kdamond);
 	damon_sysfs_upd_schemes_effective_quotas(sysfs_kdamond);
+out:
 	mutex_unlock(&damon_sysfs_lock);
 	return 0;
 }
-- 
2.47.3

