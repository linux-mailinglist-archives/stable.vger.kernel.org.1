Return-Path: <stable+bounces-226215-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGztNBqGuWlyIgIAu9opvQ
	(envelope-from <stable+bounces-226215-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:49:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CECC2AE7B6
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4567E310A04B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4765E376BCA;
	Tue, 17 Mar 2026 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OTKiisfi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659FC3EDADB;
	Tue, 17 Mar 2026 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765746; cv=none; b=t7GbTKwKAH9KxiPWiFZXFQztA/FxwdQjiv49VWmT2o1muaX1VZ9j7DLjOxgJUyAJ3yMHeIrGgAzpldeA0jCIEvDkod3RkbE2EsqPsHz38njbwjBenqEfN+ipTj+xVqGIJh+EoDKakIMIDCje4KCkadclMr/+3bjkY/cjZZ13wTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765746; c=relaxed/simple;
	bh=9izNEn4/BweWIdsvM25m9BFUBohTdFcaArcB1QDu9Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bi+j7zsVWWzox3QvydbWPP08fhpH037/vfn31Nqqqm76ZuN1oXmV5mGXp4M+usJw5XWaSHhXh5JZlqR/1exnDrlIlfYKJrR8KeBr+uiToeBLkyEukP+wL9GisKtGhGW0iOAbgPCp0y2sAKMygtsN3WT7uHfF/TU3lXl8YM8Npag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OTKiisfi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5DDC4CEF7;
	Tue, 17 Mar 2026 16:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773765746;
	bh=9izNEn4/BweWIdsvM25m9BFUBohTdFcaArcB1QDu9Vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OTKiisfiIJVpJVH4AIPOZrEfli7wqq04WBnr/KYBVQq8FmzF6isHZlYuBu4AAzRHv
	 XVNMTDSWd7ifiiFZJBhIuUPGL71EEFVKIxZgMNWW69czae3AZHQdqxjXOVsa/Haml0
	 dViGW2EbNqvWKZ3jCwyZVK1e0ABIvyO7cjCZvq5U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 085/378] sched: idle: Make skipping governor callbacks more consistent
Date: Tue, 17 Mar 2026 17:30:42 +0100
Message-ID: <20260317163010.142868871@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226215-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 3CECC2AE7B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit d557640e4ce589a24dca5ca7ce3b9680f471325f ]

If the cpuidle governor .select() callback is skipped because there
is only one idle state in the cpuidle driver, the .reflect() callback
should be skipped as well, at least for consistency (if not for
correctness), so do it.

Fixes: e5c9ffc6ae1b ("cpuidle: Skip governor when only one idle state is available")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Reviewed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://patch.msgid.link/12857700.O9o76ZdvQC@rafael.j.wysocki
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpuidle/cpuidle.c | 10 ----------
 kernel/sched/idle.c       | 11 ++++++++++-
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 65fbb8e807b97..c7876e9e024f9 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -359,16 +359,6 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
 int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		   bool *stop_tick)
 {
-	/*
-	 * If there is only a single idle state (or none), there is nothing
-	 * meaningful for the governor to choose. Skip the governor and
-	 * always use state 0 with the tick running.
-	 */
-	if (drv->state_count <= 1) {
-		*stop_tick = false;
-		return 0;
-	}
-
 	return cpuidle_curr_governor->select(drv, dev, stop_tick);
 }
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index abf8f15d60c9e..69c70d509e1cf 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -221,7 +221,7 @@ static void cpuidle_idle_call(void)
 
 		next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
 		call_cpuidle(drv, dev, next_state);
-	} else {
+	} else if (drv->state_count > 1) {
 		bool stop_tick = true;
 
 		/*
@@ -239,6 +239,15 @@ static void cpuidle_idle_call(void)
 		 * Give the governor an opportunity to reflect on the outcome
 		 */
 		cpuidle_reflect(dev, entered_state);
+	} else {
+		tick_nohz_idle_retain_tick();
+
+		/*
+		 * If there is only a single idle state (or none), there is
+		 * nothing meaningful for the governor to choose.  Skip the
+		 * governor and always use state 0.
+		 */
+		call_cpuidle(drv, dev, 0);
 	}
 
 exit_idle:
-- 
2.51.0




