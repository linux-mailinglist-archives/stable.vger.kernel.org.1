Return-Path: <stable+bounces-263757-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IfRzGkVYMWp1hQUAu9opvQ
	(envelope-from <stable+bounces-263757-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:05:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D17CB69037E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:05:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AtzWYf7P;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263757-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263757-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46C3E31C40C8
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 14:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0952351C17;
	Tue, 16 Jun 2026 14:02:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5BD28640B
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 14:02:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781618538; cv=none; b=k1LSUSKlmMJPCVAQ13mUPVDUyzYqJKLPuNwvmZQkmNcQ44I8yw7dT63twbMboMHpUim42vohJdr2e6nQ6ejEzdiX++kSDNlQLDzqsQKkULQZEsCmcI0i/Yiyc3AD7raBXvu4hVR6vGDrGJ4NYmIvAHVtZvxiiTbEHDXirhS5s8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781618538; c=relaxed/simple;
	bh=0DfsjCn9QMYaco+ZQHdWi40Bk2IuPNruDco4LXN6fW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+pA85O36d82apHoqiyV9cl+P1Wo2tZV9pkO+t7J4vTovh0ap3yDuyHARe5j7CrGPA74T74KfE/IoeflFP16PmNo6a0KnL/vVtcVKhR7gQTh3qrPUXMRcauh2r59vD/tjT7NszrU/gKk7hdQCkCCyhiUZwof3XUrxKJaPCFjytU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtzWYf7P; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80E51F00A3D;
	Tue, 16 Jun 2026 14:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781618537;
	bh=SLuv/fN4WIkD2SYDV5SY6GpRx/D1oMFUUL38gIhziKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AtzWYf7Pu+qlKR0uWtQYXIj/SQFAuVn4BwkeAq1N7io9niIt8+fZfTl1gxjGJqG+2
	 srcTo9YN82Vbm+u9py8X0CcmeHd/hiwwXy+96bT/Y80IcWDSb8YR9Nbb++HqsCT6zj
	 Q2KOoh/rdSNI75DOkj308sUQeXonZ5InDrI0kO9TrCKEHj9VbbAvSiS69Ff8lQdbXz
	 IDV5rNIIwEDQ/LxFD6rqVYu/j9zJcjl2sdYxL7fKSl9vu1mRvMQDYNSRjrMOVqgyxd
	 aeo208vObyS0063EeerceQ2S1GFl95l4Uf5JaIB/2P2GEHW80nqe+zhLrEcB48i9hc
	 BRY9uiJG04d4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yingjie Gao <gaoyingjie@uniontech.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] xfs: fix error returns in CoW fork repair
Date: Tue, 16 Jun 2026 10:02:14 -0400
Message-ID: <20260616140214.3285019-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616140214.3285019-1-sashal@kernel.org>
References: <2026061544-strife-handwork-2622@gregkh>
 <20260616140214.3285019-1-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-263757-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gaoyingjie@uniontech.com,m:djwong@kernel.org,m:cem@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,uniontech.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D17CB69037E

From: Yingjie Gao <gaoyingjie@uniontech.com>

[ Upstream commit fcf4faba9f986b3bb528da11913c9ec5d6e8f689 ]

xrep_cow_find_bad() returns success after the cleanup labels even if
AG setup, btree queries, or bitmap updates failed. This can make
repair continue with an incomplete bad-file-offset bitmap instead of
stopping at the original error.

The force-rebuild path has a related cleanup problem. If
xrep_cow_mark_file_range() fails, the function returns directly and
skips the scrub AG context and perag cleanup.

Let the force-rebuild path fall through to the existing cleanup code
and return the saved error after cleanup.

Fixes: dbbdbd008632 ("xfs: repair problems in CoW forks")
Cc: <stable@vger.kernel.org> # v6.8
Signed-off-by: Yingjie Gao <gaoyingjie@uniontech.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/cow_repair.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/scrub/cow_repair.c b/fs/xfs/scrub/cow_repair.c
index 3524695625e338..337bdd524b0103 100644
--- a/fs/xfs/scrub/cow_repair.c
+++ b/fs/xfs/scrub/cow_repair.c
@@ -297,18 +297,15 @@ xrep_cow_find_bad(
 	 * on the debugging knob, replace everything in the CoW fork.
 	 */
 	if ((sc->sm->sm_flags & XFS_SCRUB_IFLAG_FORCE_REBUILD) ||
-	    XFS_TEST_ERROR(sc->mp, XFS_ERRTAG_FORCE_SCRUB_REPAIR)) {
+	    XFS_TEST_ERROR(sc->mp, XFS_ERRTAG_FORCE_SCRUB_REPAIR))
 		error = xrep_cow_mark_file_range(xc, xc->irec.br_startblock,
 				xc->irec.br_blockcount);
-		if (error)
-			return error;
-	}
 
 out_sa:
 	xchk_ag_free(sc, &sc->sa);
 out_pag:
 	xfs_perag_put(pag);
-	return 0;
+	return error;
 }
 
 /*
-- 
2.53.0


