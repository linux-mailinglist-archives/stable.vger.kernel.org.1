Return-Path: <stable+bounces-269588-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EJ3XCjWYQWrFsQkAu9opvQ
	(envelope-from <stable+bounces-269588-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 23:55:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7013F6D508F
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 23:55:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=odQNqTH2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269588-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269588-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC76D300CE74
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 21:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1843B71C5;
	Sun, 28 Jun 2026 21:54:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4223B71D7;
	Sun, 28 Jun 2026 21:54:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782683694; cv=none; b=E03eSEJMSJp6Zr891zbpIoskBkEOQKAqfkqJBtdJaKGH5VTWJQ6cw+IJw+ofrAw1dcIlia0ATPC2Ri1W//rBBT2Ga+9JGzk4TzczHut4dqpwWxXDSLVrOC6WzzWTczop82bCcs2rRsAI89PjU2Nw93sPh9xCeCQi9cJ8d/+erjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782683694; c=relaxed/simple;
	bh=RCTr6WzinCBRJCf76iFIZiBNOnNNLIMbUYmMVNswliY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fr7TdGB4AIfqmxEDSYReYxUrlhInTfe24x/tGudSsWMeIWC10oEkAczqcJq6VfU7UF6bXKE7e5zvSOC3CcVYvJzD7JljFffG1C/3AUSOXd7/vzjcnvEEMG58LGggS8BaIndQpFPYQjOiKuGpE+cHBIWb+evYTvU8mr5MR2C7Ees=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odQNqTH2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E499F1F000E9;
	Sun, 28 Jun 2026 21:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782683693;
	bh=wb/G2WI6U+bmHwkuU5P84fH/ZMN31r6Got3AOveygXo=;
	h=From:To:Cc:Subject:Date;
	b=odQNqTH2ZMrhe7ZozN5h/oAQeRqYWv82de3+V/fqJgmGDBk4t48gPKmL9/QgDbl3O
	 hFyMymvuoOnpaWxR5Qg5jdHIU8rv7ZTf2fJUom07/pKHToC8vka2u23rxOUJUQ5TRg
	 F0X0RE3Wl1TOgopWvBD075KKymx+dKmtqlbGxm3PrPDERUwc5ojjy8piMxg1fkRzK/
	 HSkLXPUm/qb8YSM5yN5WDE1RCcvuAhjNB/1Pk6K1DJ99Xcs4fcEwSqb6TXH7LUKKUm
	 LnGig2acjXxO5jfQ4/0ej89esSErXW2DdRqMWI/gWdnfLnGTPg5V9UVeE/7ytF6ueK
	 JUxZyyoShCbFw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"# 6 . 14 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/6] samples/damon: handle damon_{start,stop}() failures
Date: Sun, 28 Jun 2026 14:54:39 -0700
Message-ID: <20260628215447.96166-1-sj@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-269588-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:sj@kernel.org,m:stable@vger.kernel.org,m:damon@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 7013F6D508F

All DAMON sample modules are not correctly handling failures from
damon_start().  Among those, mtier also has an additional problem for
handling of damon_stop() failures.  wsse and prcl also have a problem in
their damon_call() failure handling.  As a result, memory leaks, next
DAMON operation disruptions, and use-after-free can happen.  Fix those.

Note that only the damon_start() failure caused issues can reliably be
reproduced.  Reproducing those issues require the admin permission,
though.

Changes from RFC v4
- RFC v4: https://lore.kernel.org/20260610135546.64943-1-sj@kernel.org/
- Collect R-b: from Zenghui Yu.
- Rebase to latest mm-new.
- Drop RFC.
Changes from RFC v3
- RFC v3: https://lore.kernel.org/20260610011420.3018-1-sj@kernel.org
- Add damon_Call() failure handling fixes for wsse and prcl.
Changes from RFC v2
- RFC v2: https://lore.kernel.org/20260609142119.68120-1-sj@kernel.org
- Add damon_start() failure handling fixes for wsse and prcl.
Changes from RFC v1
- RFC v1: https://lore.kernel.org/20260609005443.2122-1-sj@kernel.org
- Add damon_stop() failure handling fix to the series.

SJ Park (6):
  samples/damon/wsse: handle damon_start() failure
  samples/damon/prcl: handle damon_start() failure
  samples/damon/mtier: handle damon_start() failure
  samples/damon/mtier: handle damon_stop() failure
  samples/damon/wsse: stop and free damon ctx when damon_call() fails
  samples/damon/prcl: stop and free damon ctx when damon_call() fails

 samples/damon/mtier.c | 14 ++++++++++++--
 samples/damon/prcl.c  | 11 +++++++++--
 samples/damon/wsse.c  | 11 +++++++++--
 3 files changed, 30 insertions(+), 6 deletions(-)


base-commit: 77fe35dfe005f7d55c8e729e1543b87cfc805a21
-- 
2.47.3

