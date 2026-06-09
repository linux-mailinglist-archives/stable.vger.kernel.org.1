Return-Path: <stable+bounces-262292-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id APd0ENojKGqf+gIAu9opvQ
	(envelope-from <stable+bounces-262292-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 16:31:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D4E6610F2
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 16:31:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Vgd6qLQ2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262292-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262292-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A8473003426
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 14:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A331433F8BC;
	Tue,  9 Jun 2026 14:21:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621FB33D509;
	Tue,  9 Jun 2026 14:21:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014883; cv=none; b=RF9hAaD4CZHiPlcoF4w0NmCHol+yG/qpKKSBfIOhZE8W9h9O1p1sF2Aolx1oYwSohGpRxW0Gp/feqXJ/PgXFnWZTc0qGcTwkjj2kdLYy47fzDgL1jegjbp6DXGw0KB833UhP2NIfWf1LhJlwlskmv7CI6VukLFYL4xPVJahj1kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014883; c=relaxed/simple;
	bh=wlOodJMKwWlojPiGSUEaRK0mtYPwLBvKfjqYfKQwbM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J1IarG9QMs4X5ZJuH4VAgGqsE8dTntRirILopsMx3D4N5/qqgye3mSSAy4bEXIvPDPj/JQWT+Buk0BsXXpRaGNVgyBNLowLemiMKeZ/SwygVgBS3LofNoPiXOiIVyqkND8ylpFT7H5umutbbPE5HCqmJhFjnJpeefNgvlGcfhHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vgd6qLQ2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6FF1F00898;
	Tue,  9 Jun 2026 14:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781014882;
	bh=/I/SdsNq46aL/damhiClubyVX87JXrkNh5YqDS3XJXw=;
	h=From:To:Cc:Subject:Date;
	b=Vgd6qLQ2U/g3hmzeKh6rrNLiIX9mT7W+eOTz3YeN0q8c3rwLC0jp+y8pWWQAM98YC
	 +QZoW9QCtt17jZ2t8t8b/y66NhbQJUCGav/vkfdLpBnr9Bi/ByPyiDdIvyaXdqDpun
	 t9iJyq1k/gJL0SaPmJDU8cPTQfZyIjtiDGFexzecEBZdwTe8gt6oYI9JNX9z16TbZd
	 GX/kIxN9e4IN96SvipZ+ctWSjKHopOVp1+dMfhVBLQx4VrON/e1EjM4+A5zQb8YiRk
	 iiyvWAsIpBrAnr5Q+S9dRmn0wYi4EMEC5TK5pXKvduK8uInegjm0FzhQ6tqSGdtJhg
	 73oMtye6V7UWA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 0/2] samples/damon/mtier: handle damon_{start,stop}() failures
Date: Tue,  9 Jun 2026 07:21:15 -0700
Message-ID: <20260609142119.68120-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262292-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sj@kernel.org,m:stable@vger.kernel.org,m:akpm@linux-foundation.org,m:damon@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sj@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 23D4E6610F2

DAMON sample module mtier is not correctly handling failures from
damon_start() and damon_stop().  As a result, it can leak memory,
disrupt next DAMON operations, and dereference freed and random memory.
Fix those.

Changes from RFC v1
- RFC v1: https://lore.kernel.org/20260609005443.2122-1-sj@kernel.org
- Add damon_stop() failure handling fix to the series.

SeongJae Park (2):
  samples/damon/mtier: handle damon_start() failure
  samples/damon/mtier: handle damon_stop() failure

 samples/damon/mtier.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)


base-commit: f822d98f51b6e2b3ab41cad2e8bc1013d06f93bb
-- 
2.47.3

