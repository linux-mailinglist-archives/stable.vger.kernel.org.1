Return-Path: <stable+bounces-256450-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEASEnHXGGoToAgAu9opvQ
	(envelope-from <stable+bounces-256450-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 02:01:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEDE5FB957
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 02:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DF38306A970
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 00:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90B02E06EF;
	Fri, 29 May 2026 00:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPK4lzw5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D8A286D56;
	Fri, 29 May 2026 00:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780012876; cv=none; b=rdM2lvKO8H4U9sf94YdbU0HmOr4f0HCoKKGwvDAobkacTf6e0aSb2DIiVGHqLjizJdfUY9pd/r0jmd/J9t79NHKYhfgNih6zFth3fyw7ed8tooGIDwLwAnIPdPzo9ir2XEJFP4wt5Z4ECqLV3LBbUlh2UTcHddafENxKAEJB6mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780012876; c=relaxed/simple;
	bh=AdN/hy8tqgKT4tGivSx63b8BAAWdMuJmHpvP00ByD3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKLEDsnyTkQwph4nLQvQHsIQOiXpUQWrQeZvtLbAMh5blrSUyo/h/WsYZJjEjP8NVG1WhCt16n324zcK2rRsE+Cn1uKdofo14gCkNaPL7+b0UcYjJ1jdpSArhhHHHC1S9H5Jom6B6VmVLulDBP92c08dY8bLN8k84PYZ6cehxMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPK4lzw5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF281F00A3E;
	Fri, 29 May 2026 00:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780012875;
	bh=CK6rWCS8LFvFBXjfIvuhhFhQ6PGQWXZdEx0+rj0MOdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fPK4lzw5k7IzIyNZpg+Qt+0FuVA88Hrx6vLXTH50CRMamVCLc5aY9RMKTq6dzEFCY
	 lvAoE0Rey1ZVJs/Bfegtwbc6ZTodQOniz44JS4A9BnSGs1EdaVGri0W0ms5LSvFvD9
	 3d1X7Riy+QEXVIL6UYHpPGSSp4WSwaL3m2lqBlN8ZH5gFPZPVMrrooj4KgpGg630Zp
	 5BEsb1gmfsZT8yRzOxxfyKjRoaaSd7WA8eOvlC9p+TmJR+qpOw761exZbPiN1ZAPQF
	 3wrkaDXV4WQ/iEsCezgxV/llqDGlXaNA2aQgWvEk4+SvlWuCmZpYqPQoLloEfr5fFP
	 EhGE7Sp1RRF9g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 18 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/2] mm/damon/reclaim: handle ctx allocation failure
Date: Thu, 28 May 2026 17:01:02 -0700
Message-ID: <20260529000104.7006-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529000104.7006-1-sj@kernel.org>
References: <20260529000104.7006-1-sj@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256450-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BEEDE5FB957
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DAMON_RECLAIM allocates the damon_ctx object for its kdamond in its init
function.  damon_reclaim_enabled_store() wrongly assumes the allocation
will always succeed once tried.  If the damon_ctx allocation was failed,
therefore, code execution reaches to damon_commit_ctx() while 'ctx' is
NULL.  As a result, it dereferences the NULL 'ctx' pointer.  Avoid the
NULL dereference by returning -ENOMEM if 'ctx' is NULL.

Fixes: 3f7a914ab9a5 ("mm/damon/reclaim: use damon_initialized()")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index ed446d00ef1cf..ce4499cf4b8b0 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -399,6 +399,10 @@ static int damon_reclaim_enabled_store(const char *val,
 	if (!damon_initialized())
 		return 0;
 
+	/* damon_modules_new_paddr_ctx_target() in the init function failed. */
+	if (!ctx)
+		return -ENOMEM;
+
 	return damon_reclaim_turn(enabled);
 }
 
-- 
2.47.3

