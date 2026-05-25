Return-Path: <stable+bounces-254217-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FEQEC27FGo2PwcAu9opvQ
	(envelope-from <stable+bounces-254217-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 23:12:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CD75CED20
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 23:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 080CC3007B95
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 21:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DFA3932EE;
	Mon, 25 May 2026 21:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tSrIIs+8"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA9525392C
	for <stable@vger.kernel.org>; Mon, 25 May 2026 21:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779743530; cv=none; b=sgKQNmkiy6gTWAgtI0Kxx1FQg0PMc0rL5HulMhxOJHJr1rfCrBbq9Taj1MUpcPexzT4XkBU9Gip30ED6svAQQBPtXsNjewPXZNFs7ndWeYsR9yN7P+/pzKDxilyp0+HroAS7RDy6IzFahxf+bPT6iF2GDwTaRuKPlOnc/mrZ58o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779743530; c=relaxed/simple;
	bh=6xiNrX/k52YTkdf/AO5WqSiEU+jz5mJ3ulh1shDOgK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPKCvJwLlpL7sUVyH0MW9u8o/QB3pqFi0Kmzs1yHSHQRUXO9Hw3z+UYCgma5IuVBmZUnxRolVuz4QDCzAMu3Er931G7SewWAaVa8Mctzqcl9jsjXtBTBW94kG4ktZpyYAqSJMy0pTqmqt7i8Swbetjn67EJZMuFaYdqGrr7YQTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=tSrIIs+8; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gPT912Vm1z9srp;
	Mon, 25 May 2026 23:12:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1779743525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5vV62udXbmk9yxKYAlvayyIhtjZdNgxiaOjdz1VbT9k=;
	b=tSrIIs+8HlygjIQtWWfCGXABQQjj8wArEXyGEwHm2ZvZpv/ZZxebhWgp/yG1ovzw0P6iZ6
	t4PIfeb/+Dg97j+chCmN9eFPovSZUuc4ySrDCeX85jKzsR3bDp/z0go8tE0cZE0SGvITnH
	eu8IqeUDwacJNeLNXpuifjT9vD7ZI7KD0KcE5FCQ7/o5txtRKUWIe2W9yeOKIlH1qdqlfs
	xvVXs62W6XpHSt16fbAEthNXgdTcTxo5fx5KCaRgtxXwoyZS0/Xfaa/PU60RPY3sjaR97o
	G47iC7XS8xN/7XOD2u5mvXp3f+DxofdMdgGhm9nxvJDo+rbYuTqbnyHadMdnsw==
From: Lukas Beckmann <lbckmnn@mailbox.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	regressions@lists.linux.dev,
	Mike Galbraith <efault@gmx.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 6.12.y v2 2/5] sched/deadline: Fix dl_server_stopped()
Date: Mon, 25 May 2026 23:11:14 +0200
Message-ID: <20260525211117.630141-3-lbckmnn@mailbox.org>
In-Reply-To: <20260525211117.630141-1-lbckmnn@mailbox.org>
References: <https://lore.kernel.org/stable/20260522213120.1205100-1-lbckmnn@mailbox.org/>
 <20260525211117.630141-1-lbckmnn@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 25fe9b157d674aa3774
X-MBO-RS-META: wh8wegpaonxjok3dy84bz6famaxd831p
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmx.de,infradead.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254217-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lbckmnn@mailbox.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:email,mailbox.org:mid,mailbox.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,infradead.org:email]
X-Rspamd-Queue-Id: E4CD75CED20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Huacai Chen <chenhuacai@loongson.cn>

commit 4717432dfd99bbd015b6782adca216c6f9340038 upstream.

Commit cccb45d7c429 ("sched/deadline: Less agressive dl_server handling")
introduces dl_server_stopped(). But it is obvious that dl_server_stopped()
should return true if dl_se->dl_server_active is 0.

Fixes: cccb45d7c429 ("sched/deadline: Less agressive dl_server handling")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250809130419.1980742-1-chenhuacai@loongson.cn
Signed-off-by: Lukas Beckmann <lbckmnn@mailbox.org>
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 9c5fa95b345a..6ff9055a6981 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1879,7 +1879,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 static bool dl_server_stopped(struct sched_dl_entity *dl_se)
 {
 	if (!dl_se->dl_server_active)
-		return false;
+		return true;
 
 	if (dl_se->dl_server_idle) {
 		dl_server_stop(dl_se);
-- 
2.54.0


