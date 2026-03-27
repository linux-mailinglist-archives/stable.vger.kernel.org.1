Return-Path: <stable+bounces-230556-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBJWEyDQxWm5BwUAu9opvQ
	(envelope-from <stable+bounces-230556-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 01:32:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DB033D921
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 01:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D99B301184A
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A8E25EFBE;
	Fri, 27 Mar 2026 00:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNRNrlnn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560408635D;
	Fri, 27 Mar 2026 00:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774571547; cv=none; b=hwQvD7Y25f2YdG2r5+aZ37SPxci/uHtmM/Jah62kN/oYmV0jJx0NCpea4Xj9oTi6SAfOzsr7jHipDv0oSNZDuc3czDOnU5/W9yvHZgwLd//YNa59ak8BPN/GLCEbs7sme+bD1FYQrU3YsFhB3r18SuoQYaovApTUYIcsf8civVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774571547; c=relaxed/simple;
	bh=477C8/cGg78aynYBDYa7PrZfozFomytf/sPOXH4AIRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fn/oTjIcuwo/FEcrMeOIKMV/v0jr6ivZdxL+e2dQW5VHEMTMDK5PTsjHFh4dPuRc6vJ0LsmEUajR0MJdeGFk9ahLR0PVARNSIbsO8tX59Xt7YNkbUkiIj8w9X2sx+gMAAU5GhywcCGQqCT4TOVLzWMIGPLtpUl1e72vN0pe8wTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNRNrlnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BA6C116C6;
	Fri, 27 Mar 2026 00:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774571546;
	bh=477C8/cGg78aynYBDYa7PrZfozFomytf/sPOXH4AIRQ=;
	h=From:To:Cc:Subject:Date:From;
	b=VNRNrlnndzxNHwOR3H1P0LyEaSzC3fKlp9bvoAeQkgrbwDSrawZ4MQkHylGTEEu2U
	 QBbB2PNMZdbpNGVoFrbc/3d2L/K+IKXmRc91AtWvqFsSlvqSLdQejHRLE+RFXQ9F0t
	 U61RAX23zAH4AbAk00tdOUv5kSLg0y7SLSd/VUjRukFBarHMbw5Tal48SSE/eGqqI7
	 Latq5hJEOWLZOAbOd/djTMFhKn83suMfR0eoAqbDBLLMWuLErFja/Luhf7fL7bfsIz
	 vQIiJplsCZfeCPdcakTUF/u6BMrTigjSs2yd4/ogxT01t6dERfBDfOn5s8W46HJ3ff
	 GsVDiATzoWyBA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/damon/sysfs: dealloc repeat_call_control if damon_call() fails
Date: Thu, 26 Mar 2026 17:32:22 -0700
Message-ID: <20260327003224.55752-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230556-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: A7DB033D921
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

damon_call() for repeat_call_control of DAMON_SYSFS could fail if
somehow the kdamond is stopped before the damon_call().  It could
happen, for example, when te damon context was made for monitroing of a
virtual address processes, and the process is terminated immediately,
before the damon_call() invocation.  In the case, the dyanmically
allocated repeat_call_control is not deallocated and leaked.

Fix the leak by deallocating the repeat_call_control under the
damon_call() failure.

This issue is discovered by sashiko [1].

[1] https://lore.kernel.org/20260320020630.962-1-sj@kernel.org

Fixes: 04a06b139ec0 ("mm/damon/sysfs: use dynamically allocated repeat mode damon_call_control")
Cc: <stable@vger.kernel.org> # 6.17.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from RFC
(https://lore.kernel.org/20260326062347.88569-2-sj@kernel.org)
- Split out from the series.
- Drop RFC tag.
- Add Fixes: and Cc: stable.

 mm/damon/sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 6a44a2f3d8fc..eefa959aa30a 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1670,7 +1670,8 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
 	repeat_call_control->data = kdamond;
 	repeat_call_control->repeat = true;
 	repeat_call_control->dealloc_on_cancel = true;
-	damon_call(ctx, repeat_call_control);
+	if (damon_call(ctx, repeat_call_control))
+		kfree(repeat_call_control);
 	return err;
 }
 

base-commit: dd478b2be41492a9f7be5abbdbd4dceddc46818f
-- 
2.47.3

