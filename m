Return-Path: <stable+bounces-266562-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BTesB0CiMWrJogUAu9opvQ
	(envelope-from <stable+bounces-266562-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:21:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 613CA694F2B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:21:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FKaKmY5E;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266562-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-266562-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C133303102F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26F13DD879;
	Tue, 16 Jun 2026 19:21:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768D13DB332
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 19:21:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781637691; cv=none; b=QSAnGTx2zsbC0u5pcuPpJclyJMzXWmf/3vXcvtCYMDwFlTkh53ldTfjWw+G0xyXBdNayw0OGLEixEDV+B63hKmiFUKdbDJf8I7mZPm4weP9tTYRMEo7W1aZqo75Wrijibpc23gLXN1SDLYDTwGHMKmA8xz+XDROOtAI/aBZrAYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781637691; c=relaxed/simple;
	bh=36u5z43Y4yET9L4B45tDjUygTcKerVhoLNRoj8NL2y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4N42SQgHUUKpJRvjp5Sn23k7JnOtrzqDiinrbpVP5M7ly4aepgVMvoddRrjFoTTDjSXRyWJrByeeN3VHOiX14BvD87WLlJeq/vbn1fAJz41UmEAnh361E7KpiQwZ0Ij86X/aVV8neDh4qQoT9V53vQAEhwDZHuEOey/QjrJr9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKaKmY5E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E38C1F000E9;
	Tue, 16 Jun 2026 19:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781637690;
	bh=tRYxbkQCgYsSdLp4X49L/g+w6hxo18wZzxuMrCVMOFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FKaKmY5EFhY/JCuY5lsa+ZZxsiyi9S0dnh/C2QUs4yfxxpUGb1ufhh9fW6+wSpCNe
	 iDevgxFwl6TgFP5G+gWf5w8wTbgH/rEBeG/vOhH6f71w1emIMXI+dXhbxpCLVL3hpI
	 xbbk8iG6Q2wOv4Y9FSu9KsQWacHWIqV/Fv/fPwFSroplYtWRdHGVOWZN77GHtqu1eI
	 jdDHcyeiabwU/zsUrRHkkWAszY8hTTpMN0H+lUG6ECgCCQau0j0tbMkr5eyxR44vpt
	 AMZeLOkX2IllABKjmvsfTXepvZCFO4mxd85CW62tn0m+55eGMHcRQ+E1nM4lHOb+2a
	 2M/KPFaPkTeuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ji'an Zhou <eilaimemedsnaimel@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] futex/requeue: Prevent NULL pointer dereference in remove_waiter() on self-deadlock
Date: Tue, 16 Jun 2026 15:21:28 -0400
Message-ID: <20260616192128.3499944-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061528-headband-manmade-880e@gregkh>
References: <2026061528-headband-manmade-880e@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266562-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:eilaimemedsnaimel@gmail.com,m:tglx@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 613CA694F2B

From: Ji'an Zhou <eilaimemedsnaimel@gmail.com>

[ Upstream commit 74e144274af39935b0f410c0ee4d2b91c3730414 ]

When FUTEX_CMP_REQUEUE_PI requeues a non-top waiter that already owns the
target PI futex, task_blocks_on_rt_mutex() returns -EDEADLK before setting
waiter->task.

The subsequent remove_waiter() in rt_mutex_start_proxy_lock() dereferences
the NULL waiter->task, causing a kernel crash.

Add a self-deadlock check for non-top waiters before calling
rt_mutex_start_proxy_lock(), analogous to the top-waiter check in
futex_lock_pi_atomic().

Fixes: 3bfdc63936dd4773109b7b8c280c0f3b5ae7d349 ("rtmutex: Use waiter::task instead of current in remove_waiter()")
Signed-off-by: Ji'an Zhou <eilaimemedsnaimel@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/futex/requeue.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index 60b08247b07dd5..8cf1234be584d7 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -629,6 +629,12 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 			continue;
 		}
 
+		/* Self-deadlock: non-top waiter already owns the PI futex. */
+		if (rt_mutex_owner(&pi_state->pi_mutex) == this->task) {
+			ret = -EDEADLK;
+			break;
+		}
+
 		ret = rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
 						this->rt_waiter,
 						this->task);
-- 
2.53.0


