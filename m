Return-Path: <stable+bounces-251250-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOJ3JsLwDWp+4wUAu9opvQ
	(envelope-from <stable+bounces-251250-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:34:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3105A594035
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA69B315E3FD
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACCB36F421;
	Wed, 20 May 2026 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v92UOaN0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11422372EDE;
	Wed, 20 May 2026 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297493; cv=none; b=dMD4iALghB8jnkaY4dP4vBIZJ0Y/GXyCB5ocJ2Bo2b42xySthWQzdA+eOZvcTDIr6tgLEJR5SbzL8bNhFUKbytXH99YPVlDmo1W7NHJLTsxcJzIviddp8oj4RckxT9YDHeAMjTnCHqv4EheJIXJI+Uip1n+/VlMr/RU/gLdZ418=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297493; c=relaxed/simple;
	bh=imZzZLAfC+wG77KtjjQM+2TlbfkPVyVH2/e7cocJlG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WkQoks2ZF5J+WiBJhOC1ce1fkx5VTahmIWX/LJGce9lKI7R9MdKNjO8A0O74gKWv/qSXw1PKlCEs35o51xWuTuVCBag1YuUqaZGDlUlfF6O19dJTCHrZgRKyAV/OoOBKnDUOW4yN4WPrQpUWgiqeAI+K40YDL4XDdg8N3Aha3gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v92UOaN0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DEC1F000E9;
	Wed, 20 May 2026 17:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297492;
	bh=ep56Hm5pUaJh1IikAppuiq0jbhAf3di+JkJZWDlOuCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=v92UOaN07vUrGpzSBHKL6yNhAP3QNnRKFJ3PiXC55kNC+5jQ4fRfEj6ytWGYXJ1mI
	 9Sh+5jN6BV2VBLEQmzcF+gj6ur6qPiRYRKBpIVScGa+BHI2QVxd5j5uQfVFONNCyL3
	 5d0VdP10EOXtwB2kJSUaCDQAMFpt48gBjSR6RviU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 053/957] sched/rt: Skip group schedulable check with rt_group_sched=0
Date: Wed, 20 May 2026 18:08:56 +0200
Message-ID: <20260520162135.709922709@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251250-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,infradead.org:email]
X-Rspamd-Queue-Id: 3105A594035
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Koutný <mkoutny@suse.com>

[ Upstream commit 8b016dcec9365675be81d26be88f2c09cf983bd4 ]

The warning from the commit 87f1fb77d87a6 ("sched: Add RT_GROUP WARN
checks for non-root task_groups") is wrong -- it assumes that only
task_groups with rt_rq are traversed, however, the schedulability check
would iterate all task_groups even when rt_group_sched=0 is disabled at
boot time but some non-root task_groups exist.

The schedulability check is supposed to validate:
  a) that children don't overcommit its parent,
  b) no RT task group overcommits global RT limit.
but with rt_group_sched=0 there is no (non-trivial) hierarchy of RT groups,
therefore skip the validation altogether. Otherwise, writes to the
global sched_rt_runtime_us knob will be rejected with incorrect
validation error.

This fix is immaterial with CONFIG_RT_GROUP_SCHED=n.

Fixes: 87f1fb77d87a6 ("sched: Add RT_GROUP WARN checks for non-root task_groups")
Signed-off-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260323-sched-rert_groups-v3-1-1e7d5ed6b249@suse.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/rt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 8cead8f37aa50..156824baef613 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2677,9 +2677,6 @@ static int tg_rt_schedulable(struct task_group *tg, void *data)
 	    tg->rt_bandwidth.rt_runtime && tg_has_rt_tasks(tg))
 		return -EBUSY;
 
-	if (WARN_ON(!rt_group_sched_enabled() && tg != &root_task_group))
-		return -EBUSY;
-
 	total = to_ratio(period, runtime);
 
 	/*
@@ -2823,6 +2820,8 @@ long sched_group_rt_period(struct task_group *tg)
 static int sched_rt_global_constraints(void)
 {
 	int ret = 0;
+	if (!rt_group_sched_enabled())
+		return ret;
 
 	mutex_lock(&rt_constraints_mutex);
 	ret = __rt_schedulable(NULL, 0, 0);
-- 
2.53.0




