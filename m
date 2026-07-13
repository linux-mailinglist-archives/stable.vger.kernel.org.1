Return-Path: <stable+bounces-273841-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V3crHYb2VGpFiAAAu9opvQ
	(envelope-from <stable+bounces-273841-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 16:30:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A564774C683
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 16:30:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Y5R975aO;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273841-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273841-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1089B3069E2F
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 13:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8404C43B3D7;
	Mon, 13 Jul 2026 13:58:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03292437465;
	Mon, 13 Jul 2026 13:58:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951128; cv=none; b=Q3ufc94JJZdi3ITXqRrEFK+N9OC8XM3TifoTpZWIZoEkQfxHRwfpNDmAsGKIFegqtJtmm82IzlVn6LVkS2IjQ+PHsGrKOalS5EK9Mmez0pfNY8rU0ZlPg4OzZaJ6F1D1m/sQZGvgZOonBuLXtVTf2K93RfyV/meDTHF4hGZU7qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951128; c=relaxed/simple;
	bh=NMKcm1pkCs64lfIHYa2THibb8WzHVI8aMRYFrV5tuv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c3gr9jE+00ENba2MuQL2IktcD7lu0GjIOyFphrELgsR9lSoY3I/j1ObITTh1uRYPWDHjY47ebruGVGiiBPSq+8BwFJLPmI2O/LYsqr7/BSknEsGak3FiVSFmkE83+FMF+X0vYcrgPgTFp8+9QUyMKlkE+tWWHiRNsCeuddtqxyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5R975aO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A171F00A3A;
	Mon, 13 Jul 2026 13:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783951125;
	bh=kw48eNAzxFRXO6yZLVXQ5NvQIurCQHZvh9V8CBG541c=;
	h=From:To:Cc:Subject:Date;
	b=Y5R975aOCRLNoN4CCClsQVWkZ2zFMRMZznKjqildidyehZoUelNcs6ATVc3mjonKW
	 A18YnBR5cIur/f3whvlhNNuah1hRPblBSy1hd3uqGawgTIQFjpK+WXqn/lFZmdHfA2
	 hZEcSj/xhioRp4fTT47PJGTQHhCt1xIcGj91Jo1AhY21n675b+mlSokY3/0KnQNC1i
	 PlifB5A1j0TlHIPDT47wu/8VYo+584fQQ68909KnlC4UIHGc5BQ06b41eVdHz1xi7b
	 E7s5eufe1vv68EP5xHYuv3576UvvEuz4n1x4kIaCmpuFtoH7tt5JQutxxgYLpKfgCO
	 BRMhdprJ47juw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Fernand Sieber <sieberf@amazon.com>,
	Leonard Foerster <foersleo@amazon.de>,
	SeongJae Park <sjpark@amazon.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 0/5] mm/damon: unurgent fixes for infinite loop, NULL de-ref and races
Date: Mon, 13 Jul 2026 06:58:31 -0700
Message-ID: <20260713135838.32730-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273841-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sj@kernel.org,m:stable@vger.kernel.org,m:akpm@linux-foundation.org,m:brendan.higgins@linux.dev,m:davidgow@davidgow.net,m:sieberf@amazon.com,m:foersleo@amazon.de,m:sjpark@amazon.de,m:shakeel.butt@linux.dev,m:damon@lists.linux.dev,m:kunit-dev@googlegroups.com,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-mm@kvack.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A564774C683

Sashiko found a few issues in DAMON that could cause infinite loop, NULL
dereference and monitoring results degradation.  The first two sounds
scary but the infinite loop happens only under unreasonable user setup.
The NULL dereference is only in a unit test.  Monitoring results
degradation is trivial since it is only best-effort, and those happens
from only unlikely races.  Still those are bugs that better to fix if
possible. Fix those.

Changes from RFC v1.1
- RFC v1.1: https://lore.kernel.org/20260712170328.91144-1-sj@kernel.org
- Remove same_target param from __damon_va_check_access().
Changes from RFC
- RFC: https://lore.kernel.org/20260711180409.82093-1-sj@kernel.org
- Rebase to mm-new.

SJ Park (5):
  mm/damon/core: avoid infinite kdamond_merge_regions() internal loop
  mm/damon/tests/core-kunit: catch test failure in
    test_merge_regions_of()
  mm/damon/vaddr: drop last same folio access check optimization
  mm/damon/paddr: drop last same folio access check reuse optimization
  mm/damon/sysfs: read ops_id only once

 mm/damon/core.c             | 13 +++++++++----
 mm/damon/paddr.c            | 20 ++++----------------
 mm/damon/sysfs.c            |  6 ++++--
 mm/damon/tests/core-kunit.h |  3 +++
 mm/damon/vaddr.c            | 33 ++++++---------------------------
 5 files changed, 26 insertions(+), 49 deletions(-)


base-commit: 9d192aa422c3f9c503a40e5eb98093df671accf8
-- 
2.47.3

