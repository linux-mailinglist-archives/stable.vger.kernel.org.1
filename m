Return-Path: <stable+bounces-250091-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA49HyHtDWpZ4wUAu9opvQ
	(envelope-from <stable+bounces-250091-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:19:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5E559354E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CB8E358899B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F64C3AC00;
	Wed, 20 May 2026 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E7hUqPiG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE42349AE6;
	Wed, 20 May 2026 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294522; cv=none; b=ZW0mVb1mfYLxELj/ccLPSHT4aPffR0SjTUSWQgqPfsf+FFXeN+NsVIRqg/WcJeE5hxHFn8Ruvudrlk6vn5UGLlbBgVXwa/AcxiAE/RLomTg0MgzwhwE54yhGk6DG9lFU5cDHasEmcyPBh66wCOFdpU9atYJhGNMGJWnX57TREoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294522; c=relaxed/simple;
	bh=2uHg12NYZAPjSSNvsi1yy8y7FlGKD+2ZisPR5ghxVfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T2TNjk5qwhVX5KwBQjuI4Qn0ZHrn5QX5iGvfH9Zzo0odNjLD1UlIe040bc8DVCkhNIErQl+9tlv40Qhcv1KKEPzUH8X1h/HUoKwmSMzCC3XYMQ0otn2bdClRfsecqzClp0zztjFd+FCmmhhoSv5vSMMrRMFNi5/L8Kj0S8IkUCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E7hUqPiG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F221F00894;
	Wed, 20 May 2026 16:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294519;
	bh=8FLsqtkZWouewFdxRnq9/DGRCsU/xodzlckR07jrxvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E7hUqPiG4RkG0DHWZxShhHF0HSGv7LfgUu13SWjv2u3zBS/uOWhanSkYcorZyTTYL
	 pXepUjZpf91QAyVTJvTHAx2M+G+kmss8er04PryBlMWYIQ9iqndG26xmCAs/x8HXym
	 +zt6TluB13zFufysI89AYAU/86spTj7J3/nSopdg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0069/1146] sched/rt: Skip group schedulable check with rt_group_sched=0
Date: Wed, 20 May 2026 18:05:19 +0200
Message-ID: <20260520162149.921042191@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250091-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.com:email]
X-Rspamd-Queue-Id: ED5E559354E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

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
index 87462d889f199..0cbee031858a5 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2685,9 +2685,6 @@ static int tg_rt_schedulable(struct task_group *tg, void *data)
 	    tg->rt_bandwidth.rt_runtime && tg_has_rt_tasks(tg))
 		return -EBUSY;
 
-	if (WARN_ON(!rt_group_sched_enabled() && tg != &root_task_group))
-		return -EBUSY;
-
 	total = to_ratio(period, runtime);
 
 	/*
@@ -2831,6 +2828,8 @@ long sched_group_rt_period(struct task_group *tg)
 static int sched_rt_global_constraints(void)
 {
 	int ret = 0;
+	if (!rt_group_sched_enabled())
+		return ret;
 
 	mutex_lock(&rt_constraints_mutex);
 	ret = __rt_schedulable(NULL, 0, 0);
-- 
2.53.0




