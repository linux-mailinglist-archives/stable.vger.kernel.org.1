Return-Path: <stable+bounces-232911-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPKLFbj3zWmrjwYAu9opvQ
	(envelope-from <stable+bounces-232911-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 06:59:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1994383CBD
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 06:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1DE5301CF83
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 04:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6AD3346B2;
	Thu,  2 Apr 2026 04:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQNSxGvJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDA0175A92;
	Thu,  2 Apr 2026 04:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775105970; cv=none; b=BMP0vJmdRmfhujQFQekbzksK46Y160ulgMMiMarZyspyXL9ng7coG2CJufDk3mgl9caVPfDEvsmAskqxDmX7J+0T9SLoAg7Aq/TC0TCSGq1Tr6FET00pMl0sQ25fNUJXzUncztA/yrOiK2Ipq9xuw6APQRDZGmmi3sWDzbSV16w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775105970; c=relaxed/simple;
	bh=6b8L0fz6vN2/1FdAdwuuqgyRC2q1kGbwXl4DDedgmOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YEdCLCc77AFILfAfwPlAExJcd3SHPe1WihMOonyjHQCn0AcvQUB/Q01ipCnYUB+t94H4HvPxSg9Lf/IZVJjMD6/6Ip+omvH1fljjW2yGnIcjg5lOcT1L499Xbx1PJda0C11Ha1VpMviu5bx9LAL0VnWGMz0XXAfKcd9nAsNtJyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQNSxGvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3824C19423;
	Thu,  2 Apr 2026 04:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775105969;
	bh=6b8L0fz6vN2/1FdAdwuuqgyRC2q1kGbwXl4DDedgmOI=;
	h=From:To:Cc:Subject:Date:From;
	b=GQNSxGvJXNxyEJ8v1iJtxRdhpFpT1UYFKJ2nnOYJl+ulwa6klYQoB6lX5VLEG+JCF
	 4iGHNsT1VIi/PO83r/d2jEJjs9so9qxp1loeCIPhgDZ5Fcn6FOF4M6Zt5uBSKj5DX2
	 LDdEXkgxEY7Flg/ZYxqN41UwCVFiOY4w++btd031t1Odw9qIlxV/TP4wzgSAk3Wa50
	 fVuq9QOr3nyRik1CAnheYNYAHjU3JkiE5g5MtwalsHw0d/Y91Dcf2pwdiCRxmnYdSb
	 X72Eaifh5mxpADuWsJOClBuFA1CTpt6uBcyCaDLYL5sjLBPpatQko5uXVL9ONmHQRp
	 75aHoyYgf7eEQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH] mm/damon/stat: deallocate damon_call() failure leaking damon_ctx
Date: Wed,  1 Apr 2026 21:59:26 -0700
Message-ID: <20260402045928.71170-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232911-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1994383CBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

damon_stat_start() always allocates the module's damon_ctx object
(damon_stat_context).  Meanwhile, if damon_call() in the function fails,
the damon_ctx object is not deallocated.  Hence, if the damon_call() is
failed, and the user writes Y to “enabled” again, the previously
allocated damon_ctx object is leaked.

This cannot simply be fixed by deallocating the damon_ctx object when
damon_call() fails.  That's because damon_call() failure doesn't
guarantee the kdamond main function, which accesses the damon_ctx
object, is completely finished.  In other words, if damon_stat_start()
deallocates the damon_ctx object after damon_call() failure, the
not-yet-terminated kdamond could access the freed memory
(use-after-free).

Fix the leak while avoiding the use-after-free by keeping returning
damon_stat_start() without deallocating the damon_ctx object after
damon_call() failure, but deallocating it when the function is invoked
again and the kdamond is completely terminated.  If the kdamond is not
yet terminated, simply return -EAGAIN, as the kdamond will soon be
terminated.

The issue was discovered [1] by sashiko.

[1] https://lore.kernel.org/20260401012428.86694-1-sj@kernel.org

Fixes: 405f61996d9d ("mm/damon/stat: use damon_call() repeat mode instead of damon_callback")
Cc: <stable@vger.kernel.org> # 6.17.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from v1
(https://lore.kernel.org/20260402010457.66860-1-sj@kernel.org)
- Avoid use-after-free.
- Add RFC tag.

 mm/damon/stat.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index 5a742fc157e4..99ba346f9e32 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -245,6 +245,12 @@ static int damon_stat_start(void)
 {
 	int err;
 
+	if (damon_stat_context) {
+		if (damon_is_running(damon_stat_context))
+			return -EAGAIN;
+		damon_destroy_ctx(damon_stat_context);
+	}
+
 	damon_stat_context = damon_stat_build_ctx();
 	if (!damon_stat_context)
 		return -ENOMEM;
@@ -264,6 +270,7 @@ static void damon_stat_stop(void)
 {
 	damon_stop(&damon_stat_context, 1);
 	damon_destroy_ctx(damon_stat_context);
+	damon_stat_context = NULL;
 }
 
 static int damon_stat_enabled_store(

base-commit: 4fd04f750d79667937931314ed64c9d79b0d82ef
-- 
2.47.3

