Return-Path: <stable+bounces-269408-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t0+0FtwBQGrKbAkAu9opvQ
	(envelope-from <stable+bounces-269408-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 19:01:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7506D25EA
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 19:01:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PesMaXNu;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269408-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269408-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6F493007AF4
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 17:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB14314B6D;
	Sat, 27 Jun 2026 17:01:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F57223DCE;
	Sat, 27 Jun 2026 17:01:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782579668; cv=none; b=UvRSQIuWrY+8W9hSmtqtIoJ2Xm44fpOVDjP/nI+Iu8jiLd9ENGDsU/banqfEdWv4/m4biO8pPiKI47ZfPUVfSCcoThJHRGjn0/d8j3u2RZZ9BC2hocFbcas2oJn3wdrNcjjVDvVZLfYOrpfcE6KKbGU05eRhh1swHkKo1iTAj+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782579668; c=relaxed/simple;
	bh=TulduVJ3UOJV8TsyJ7ffk1l75Pt4FkT2/HyvATqxan4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JC1Adp5X5OhnQBBuXZ8wM/SpWDHO4CCPRmfCtwjbAfckru0vWUKIECQ5d/YhFT2NRzEoZFdyQtsnlbKAgBtJqrZLCLv1s41YU6DoSxWTON3tAshTbVHo7HbII5GveYnNBDQa5TdXlkBG86UmXdkAJgRvXguG/Jnkaq7LzF8bp4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PesMaXNu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E9F1F000E9;
	Sat, 27 Jun 2026 17:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782579666;
	bh=hEn2zn5pWhG25VPBcYCkS7+7B1NjobplNjZ+d8XjyHk=;
	h=From:To:Cc:Subject:Date;
	b=PesMaXNupjJJGZuvo+yqSgEunZs+pIOijrjAHoAz5KrDeHs0eigW5qDmImhC3o89x
	 3b05rCW3a4MZW5+hrLKEXgTaI6tudKUTTVvihDNtu3HdxuR1GuIj2Mzxgr6RiY1SWh
	 MsmNSEeCYz2UitAgd6o8IWpfmoVHW0ELS1mJAMEDeDOzBRoNaW4L14iN1um4STbEmJ
	 Rm6tlfZuBEb4TplCTLPpgBz2BYti0F6F65IB9CEOdRVIlh1MPC7NU+uakrRCaYMKC2
	 vxE+vucgP/CpLxAX0vYqKHLzaVSul7ngSaIxty8mvzcKvekNwYDXW7dmjT+X5k3KoU
	 FpI7CLVly3dqw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [RFC PATCH] mm/damon/core: validate ranges in damon_set_regions()
Date: Sat, 27 Jun 2026 10:00:56 -0700
Message-ID: <20260627170057.1867-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269408-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sj@kernel.org,m:akpm@linux-foundation.org,m:yangyingliang@huawei.com,m:damon@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A7506D25EA

DAMON core logic assumes zero length regions don't exist.  However, a
few DAMON API callers including DAMON_SYSFS, DAMON_RECLAIM and
DAMON_LRU_SORT allow users to set empty monitoring target regions.  This
could result in WARN_ONCE() on CONFIG_DAMON_DEBUG_SANITY enabled kernel,
and divide-by-zero from damon_merge_two_regions().

For example, the WANR_ONCE() can be triggered like below.

    # grep DAMON_DEBUG_SANITY /boot/config-$(uname -r)
    # CONFIG_DAMON_DEBUG_SANITY=y
    # damo start
    # cd /sys/kernel/mm/damon/admin/kdamonds/0
    # echo 0 > contexts/0/targets/0/regions/0/start
    # echo 0 > contexts/0/targets/0/regions/0/end
    # echo commit > state
    # dmesg
    [....]
    [   73.705780] ------------[ cut here ]------------
    [   73.707552] start 0 >= end 0
    [   73.708452] WARNING: mm/damon/core.c:359 at damon_new_region+0x6e/0x80, CPU#1: kdamond.0/758
    [...]

Disallow empty region user inputs by updating the validation logic.

Fixes: 43b0536cb471 ("mm/damon: introduce DAMON-based Reclamation (DAMON_RECLAIM)")
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7e4b9affc5b06..b3100d7fa5596 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -358,6 +358,11 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 	unsigned int i;
 	int err;
 
+	for (i = 0; i < nr_ranges; i++) {
+		if (ranges[i].start >= ranges[i].end)
+			return -EINVAL;
+	}
+
 	/* Remove regions which are not in the new ranges */
 	damon_for_each_region_safe(r, next, t) {
 		for (i = 0; i < nr_ranges; i++) {

base-commit: f5cde2d41633df3fb1965efa00bfa827ca41836c
-- 
2.47.3

