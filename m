Return-Path: <stable+bounces-271160-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VQSLEFGbRmr4ZwsAu9opvQ
	(envelope-from <stable+bounces-271160-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:09:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A06E6FB0F0
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:09:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=IL2LWanE;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271160-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271160-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C10863116377
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CA23612F1;
	Thu,  2 Jul 2026 16:47:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAC03101C8;
	Thu,  2 Jul 2026 16:47:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010827; cv=none; b=PEPqCzHf2XRYtobodCkbToDsud8TcrSI8o1AwBFoQl1fNJS260PMq7eJ7IylT53HoJTgdY6e7vBdp7icvAuxYli1nMdcOSXOl0QaI/E156BZoNewbNkhDCW4ueVrd0qNxkKOtaDzUgHJcjZ2h+NcoM9bGGUlOu7qz5jLO83LaPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010827; c=relaxed/simple;
	bh=2LeEiVDd13HzFwSkwPg/XqCETUDdQnTu1Y9yPqqcaaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqYCTdaAhemXe1svaESzJHGioVuWNHVipoSP3CAjgNFVJEYNvjxAl1SFEyXp6U8DlqpjNn6a4sEThNw9Hm1m1QqceBUoQypS41WWELs21zPCLeDm3o4TXRW9LSqHUOLU3gZT2cGhha6EuT152U+8fh/rkmBxNvxa3jI7vFlkk0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IL2LWanE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4030D1F000E9;
	Thu,  2 Jul 2026 16:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010826;
	bh=pLcPMyVFCbah2Nn54qiQSSFBlr3yf/mg9Tg4CQ9mYSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IL2LWanE2URiAMkRCDqWv96+aHoZPbU+sxCh9+ALwogUKOnB2zuqFNF3wzlUsTVzI
	 hgFdwgDNLtaJM5W2ZHevnqx5O+NrKZ6C9Qx27FOvsuXhfH6NN6P4aZlz+PmBQqSAjd
	 O6pbdV3tFSX4Kz+yvEZbaHIkOcT8RYdjChtSBQps=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 009/175] debugobjects: Use LD_WAIT_CONFIG instead of LD_WAIT_SLEEP
Date: Thu,  2 Jul 2026 18:18:30 +0200
Message-ID: <20260702155115.966071543@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155115.766838875@linuxfoundation.org>
References: <20260702155115.766838875@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271160-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:bigeasy@linutronix.de,m:tglx@linutronix.de,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url,linutronix.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A06E6FB0F0

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

commit 37de2dbc318ee10577c1c2704de5a803e75e55a2 upstream.

fill_pool_map is used to suppress nesting violations caused by acquiring
a spinlock_t (from within the memory allocator) while holding a
raw_spinlock_t. The used annotation is wrong.

LD_WAIT_SLEEP is for always sleeping lock types such as mutex_t.
LD_WAIT_CONFIG is for lock type which are sleeping while spinning on
PREEMPT_RT such as spinlock_t.

Use LD_WAIT_CONFIG as override.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251127153652.291697-3-bigeasy@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/debugobjects.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 5b462a45a9c17b..bebc00aacafedd 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -608,10 +608,10 @@ static void debug_objects_fill_pool(void)
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible() || system_state < SYSTEM_SCHEDULING) {
 		/*
 		 * Annotate away the spinlock_t inside raw_spinlock_t warning
-		 * by temporarily raising the wait-type to WAIT_SLEEP, matching
+		 * by temporarily raising the wait-type to LD_WAIT_CONFIG, matching
 		 * the preemptible() condition above.
 		 */
-		static DEFINE_WAIT_OVERRIDE_MAP(fill_pool_map, LD_WAIT_SLEEP);
+		static DEFINE_WAIT_OVERRIDE_MAP(fill_pool_map, LD_WAIT_CONFIG);
 		lock_map_acquire_try(&fill_pool_map);
 		fill_pool();
 		lock_map_release(&fill_pool_map);
-- 
2.53.0




