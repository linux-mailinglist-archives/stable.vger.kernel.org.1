Return-Path: <stable+bounces-223926-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2P/1GG38r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223926-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:11:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC9524A0CA
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5EFF30DD017
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC14F381AE3;
	Tue, 10 Mar 2026 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgIwRfG9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9F1386454;
	Tue, 10 Mar 2026 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141061; cv=none; b=WG9ForFekLnQ7vBgdfVWZPYucz3fTWqG/veot2n0rPBFZ5k3HhvINXC34pg69PRToeO5vatUSKfiy4mvXnqmYc8tXpTJBm0pzGqCvz5n0r2q7a6tDlq2bBDZ7EQ7G88tNlsCgllRsKH+jicVWHUHe/0ha2WhFjk0KHKuv2BC3FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141061; c=relaxed/simple;
	bh=EOT4YfhniW5i6lt6OGUrYUNuJ7+PtjrNe/NkflHT940=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cugi7fKQpwcbm6atwNoq4qkyuXlJVze88jp8JwGpmxGGDuvCjLXS2B7aKLXNJWi/CEx5k3NggT4s/iD33aEaYJY3YW7GQG/OfyRzftVnAZHjdT0n7mCbAqXjSgq7+kujrpol8ih8OaNjSoSR1qWG4X55sQ/za3826kGatn9Oigs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgIwRfG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92A9C2BC9E;
	Tue, 10 Mar 2026 11:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141061;
	bh=EOT4YfhniW5i6lt6OGUrYUNuJ7+PtjrNe/NkflHT940=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XgIwRfG90yOAezrJTSVu2rNM1boXI/diKhRRgn+j5GQ6FefhO0L4Hf50VXA4FIQLm
	 2cgo5hL/FEu+GciqsoKQoefGlU1TQXJQ+s1dPmKJyMNnG+X/lCPo0sZDtzASReA1t5
	 TXxkDAZjkRWJOy4xgOQA49Ebz3vhuiwrP9onhG9L6SpWqL5hH37PQn3o7vz1kiEu+h
	 79ig4C0KIjS0jq6XME65HdUTePRaRu8exJFRA1cSlArPCCFg+ZVN+rqYHiwqBF26wm
	 d9HibHtZfD8/fHgugo5ws/ILEfFPi1oCef/ltI+vpT1QEkIRUICQ+FCc3wgTJ8YSPd
	 h5zlbRTwBNi8A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 061/311] s390/vtime: Fix virtual timer forwarding
Date: Tue, 10 Mar 2026 07:01:48 -0400
Message-ID: <2558380cbc1b8b31cee2f9f3fbe613436e75dd0e.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BBC9524A0CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223926-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit dbc0fb35679ed5d0adecf7d02137ac2c77244b3b ]

Since delayed accounting of system time [1] the virtual timer is
forwarded by do_account_vtime() but also vtime_account_kernel(),
vtime_account_softirq(), and vtime_account_hardirq(). This leads
to double accounting of system, guest, softirq, and hardirq time.

Remove accounting from the vtime_account*() family to restore old behavior.

There is only one user of the vtimer interface, which might explain
why nobody noticed this so far.

Fixes: b7394a5f4ce9 ("sched/cputime, s390: Implement delayed accounting of system time") [1]
Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/vtime.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index 234a0ba305108..122d30b104401 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -225,10 +225,6 @@ static u64 vtime_delta(void)
 	return timer - lc->last_update_timer;
 }
 
-/*
- * Update process times based on virtual cpu times stored by entry.S
- * to the lowcore fields user_timer, system_timer & steal_clock.
- */
 void vtime_account_kernel(struct task_struct *tsk)
 {
 	struct lowcore *lc = get_lowcore();
@@ -238,27 +234,17 @@ void vtime_account_kernel(struct task_struct *tsk)
 		lc->guest_timer += delta;
 	else
 		lc->system_timer += delta;
-
-	virt_timer_forward(delta);
 }
 EXPORT_SYMBOL_GPL(vtime_account_kernel);
 
 void vtime_account_softirq(struct task_struct *tsk)
 {
-	u64 delta = vtime_delta();
-
-	get_lowcore()->softirq_timer += delta;
-
-	virt_timer_forward(delta);
+	get_lowcore()->softirq_timer += vtime_delta();
 }
 
 void vtime_account_hardirq(struct task_struct *tsk)
 {
-	u64 delta = vtime_delta();
-
-	get_lowcore()->hardirq_timer += delta;
-
-	virt_timer_forward(delta);
+	get_lowcore()->hardirq_timer += vtime_delta();
 }
 
 /*
-- 
2.51.0


