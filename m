Return-Path: <stable+bounces-262394-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gUs2Eru7KGpJIwMAu9opvQ
	(envelope-from <stable+bounces-262394-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 03:19:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A54206652BC
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 03:19:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RI9v+5GR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262394-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262394-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15E4131340A2
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 01:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F9923817E;
	Wed, 10 Jun 2026 01:14:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962F3233932;
	Wed, 10 Jun 2026 01:14:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781054069; cv=none; b=qpkBqMVfeNqnbZFAORmifrxsTKGbzvt/1jNIZqzGYW+6MJ9EIKyM9dLCFJDE3DI1yi/eBk2ckUcM3UpmuxJ6yuV/rYruaqVBfKEiM1KLWlZWAWSvuY90T0fY2aXVFiwof3PPqui19JW9Z6zykG60ZvNulelTKThZgLX2oStkAkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781054069; c=relaxed/simple;
	bh=uMVEwMVFrhCzwBVqhAabVTfwILN07guP822tmOWUmbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mKhwhL5skuqyCMzAfk7IRQtAIeZAavQ0/Nk1ABHpL3oWPR7O0T5wGCHBO3knmztrvUH7EOgIunZIX0DGUWjQ6oKZKZgwcqXfKfCx4RDwT9GZb9zUGwVhphzC4TlMKJKp7++WqrH1D6ELwgx2PFJoBNpqw9Ryq+SC3YdKL9RREnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RI9v+5GR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3711F00893;
	Wed, 10 Jun 2026 01:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781054068;
	bh=nk5e65x0+gfzE8iKCczyf6SQjc2ncZIrrJUIfyl4290=;
	h=From:To:Cc:Subject:Date;
	b=RI9v+5GRjs2r/QxLEZ1S9doOh/Anm/jAi+G9SyO9Z0i4DC1y237xMHA5wVdt3UpMa
	 3Mn+sBs6chHbnhJ9Dz2aud3Bc5xTdGAcVc0SQpMrsy3/yLivVP/Q/hk6cnHeMwUgmk
	 NCIvMQm0j6VryyFUyutC01DlaVzYwbCY9Qg/xgsNwMCzwpZj8swxWp3g88Z122cLMJ
	 9y9vk5f8nbqfVu9RnSKWsYLKv2rAL3bUI5flFiKwKcF/eedMiE0bf55/hJKVl1zJyO
	 rEbDyVYmW/qhknrdS+u8HfmVwMjaeY5Utcx1Yw2fqL+GE5B3zEYaXb/r/vPuPpy7Vz
	 lR7ZWlv1Jw4Nw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 14 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 0/4] samples/damon: handle damon_{start,stop}() failures
Date: Tue,  9 Jun 2026 18:14:13 -0700
Message-ID: <20260610011420.3018-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262394-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sj@kernel.org,m:stable@vger.kernel.org,m:akpm@linux-foundation.org,m:damon@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A54206652BC

All DAMON sample modules are not correctly handling failures from
damon_start().  Among those, mtier also has an additional problem for
handling of damon_stop() failures.  As a result, memory leaks, next
DAMON operation disruptions, and use-after-free can happen.  Fix those.

Changes from RFC v2
- RFC v2: https://lore.kernel.org/20260609142119.68120-1-sj@kernel.org
- Add damon_start() failure handling fix for wsse and prcl.
Changes from RFC v1
- RFC v1: https://lore.kernel.org/20260609005443.2122-1-sj@kernel.org
- Add damon_stop() failure handling fix to the series.

SeongJae Park (4):
  samples/damon/wsse: handle damon_start() failure
  samples/damon/prcl: handle damon_start() failure
  samples/damon/mtier: handle damon_start() failure
  samples/damon/mtier: handle damon_stop() failure

 samples/damon/mtier.c | 14 ++++++++++++--
 samples/damon/prcl.c  |  4 +++-
 samples/damon/wsse.c  |  4 +++-
 3 files changed, 18 insertions(+), 4 deletions(-)


base-commit: e38932476396c4da618a9e904ba4e45f1891d910
-- 
2.47.3

