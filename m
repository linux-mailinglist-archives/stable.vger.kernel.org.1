Return-Path: <stable+bounces-267727-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3JUkHmRCOWrnpQcAu9opvQ
	(envelope-from <stable+bounces-267727-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 16:10:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDF46B0333
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 16:10:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gcv08X6g;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267727-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267727-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 85219300D765
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 14:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A413B813C;
	Mon, 22 Jun 2026 14:10:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8F33B7B7D;
	Mon, 22 Jun 2026 14:10:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782137442; cv=none; b=aGarQAdn8WV21YJT+8PdT49mZ86AGnCOoW6XOiSXNEl26hk3lk1c6UMiBNStggBsexgsDptybpyQ2FUSyJ7V+FozvuHgxeio/ieGuThGdWgeqtL8fVaqHQ5Wb4fhBET+AJx6Um3npjnwrBy7UDfcQeIFbdglHg/xe4EyhgxSv2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782137442; c=relaxed/simple;
	bh=OOUNiPc0YFi3U6tqHjBq24RtvvXF3rGtt39m2q5mqRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bSI5aPF3snRPSKbjhT4Fo/Olgwg9edzte2tzUYQQ3hOriGSCgsDkm8hOEKwctA5d7wn0KMV1F0v2/glGnRRJ0hPqvXTNW/ZjmxBe71GljqQv/i8yTTv68NNvSCqqlBXudLOOwcJka9YnL2JNI7/FDh4ps8C5kch5KBpcehBIFr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcv08X6g; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7891F000E9;
	Mon, 22 Jun 2026 14:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782137441;
	bh=J9rAqV+BtrJJS3bA6hXAT31xn9dA5LK7yhOjyVOIFTU=;
	h=From:To:Cc:Subject:Date;
	b=gcv08X6g+i3LbrmFn2qQmBt8NVRzGcb4Q8CY7KbQ/jd26MwiQqtKCDJ/rcrAupG35
	 Qq6NQ33NLOmy/DVUyS4OXRoHQweV8dgowskar4kXyD4fWUgO3rdjPqw8CaqM5SVsSo
	 YCq3PHQFmNpv40lgnjtlGKkUgKp6V8ltuADGJEg3r8XERIm1snV0mzCmq63/PW4/eL
	 hrenBujrrOs/KW5WQSSBQlPXPccbyVaW2vtpKSe2bMxLdw8sHSND3ZNlbexQVOC2Pc
	 s+8ys4Qd9W/7bVWJBmjWVhG7GfLFDljJZczYkahTJQLpUv4ku/Xbs/wIBssdVu/skW
	 3IvOnE+NNA8mw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 16 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 0/2] mm/damon: handle zero {sample,aggr} intervals for DAMOS quota score
Date: Mon, 22 Jun 2026 07:10:23 -0700
Message-ID: <20260622141027.29145-1-sj@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267727-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sj@kernel.org,m:stable@vger.kernel.org,m:akpm@linux-foundation.org,m:damon@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DCDF46B0333

When the intervals are zero, divide-by-zero can happen during DAMOS
quota score calculation.  Fixing it alone enables out-of-bound array
access.  Fix those.

Changes from v1
- v1: https://lore.kernel.org/20260621154808.86431-1-sj@kernel.org
- Add out-of-bound array access bug fix as patch 2.
- Add the RFC tag again.
Changes from RFC v1.1
- RFC v1.1: https://lore.kernel.org/20260620171413.89555-1-sj@kernel.org
- Wordsmith commit message.
- Drop RFC tag.
Changes from RFC v1
- RFC v1: https://lore.kernel.org/20260619205144.150664-1-sj@kernel.org
- Handle zero aggr_interval case.

SeongJae Park (2):
  mm/damon/core: handle zero intervals in damon_max_nr_accesses()
  mm/damon/ops-common: prevent >DAMON_MAX_SUBSCORE freq_subscore

 include/linux/damon.h | 8 ++++++--
 mm/damon/ops-common.c | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)


base-commit: 42306d32afd75f28e3f13a1259c3b52191b4ff2c
-- 
2.47.3

