Return-Path: <stable+bounces-265702-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IlG6LcWOMWqNmgUAu9opvQ
	(envelope-from <stable+bounces-265702-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:58:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E42693AB3
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:58:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=hquEjS+Z;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265702-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265702-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D478531C53EB
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFA847B41C;
	Tue, 16 Jun 2026 17:55:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F55A478E55;
	Tue, 16 Jun 2026 17:55:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632546; cv=none; b=fujKS1/VUJbcefZaw3JBbmdVfKTTmNcIE723ND/zR52KHLu+GkSppPdrgONnxW7l1x3xMlkAleCGnnCeOfNKWzzA2ebAsoL9O0zMRVfmoELBNxu7c7yxV25UXfJm1Q9QItFpOfeRxd6AsctCYwSdblTSLFbLhFUdeIXKWfXXHc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632546; c=relaxed/simple;
	bh=hlHa1+CE2Fn0Vd3FSWmni9/19d2EoS5PS/0VeAfAlwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdkK7rcy8ZpuRlJe5Mmo0kG/4ZeKHfQqKS9eg9E8rTcaAz/RjnwV80hQjd0093jWkJfP0qTL3cSfrOfhGvNRfwkANJ/JEqI6wSOpNYKgACEcz7XpPpVlQeglv7zIPLpngV/MGHXj8I8B73rocG1GKDsLfm5A2QifBwiPFeEaCoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hquEjS+Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DA41F00A3A;
	Tue, 16 Jun 2026 17:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781632545;
	bh=tk28eEXyGKSmXtrqWRKZI7zDql6cKVdc0KGwihM9Z5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hquEjS+Zi57y3KifcUBmjUXugSr7WALgeAcJfOOLCkSuSJjz0vgmuTpcucFemo6wC
	 3B1aDYHVPhqJly00UBVmT+FMeYQXOxnE6XnqgFO/3t0UyCg0mTUNr7GvaHBRVL2qSZ
	 SQK+kSpuQx990/Ay55DYEmsCqGzLL86P0Xj3c2To=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guopeng Zhang <zhangguopeng@kylinos.cn>,
	Tejun Heo <tj@kernel.org>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Waiman Long <longman@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 431/522] cgroup/cpuset: Reset DL migration state on can_attach() failure
Date: Tue, 16 Jun 2026 20:29:38 +0530
Message-ID: <20260616145146.132165243@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
X-Spamd-Result: default: False [3.84 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_ALLOW(0.00)[linuxfoundation.org:s=korg];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-265702-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:zhangguopeng@kylinos.cn,m:tj@kernel.org,m:chenridong@huaweicloud.com,m:longman@redhat.com,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,kylinos.cn:email,huaweicloud.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20E42693AB3

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guopeng Zhang <zhangguopeng@kylinos.cn>

[ Upstream commit 4a39eda5fdd867fc39f3c039714dd432cee00268 ]

cpuset_can_attach() accumulates temporary SCHED_DEADLINE migration
state in the destination cpuset while walking the taskset.

If a later task_can_attach() or security_task_setscheduler() check
fails, cgroup_migrate_execute() treats cpuset as the failing subsystem
and does not call cpuset_cancel_attach() for it. The partially
accumulated state is then left behind and can be consumed by a later
attach, corrupting cpuset DL task accounting and pending DL bandwidth
accounting.

Reset the pending DL migration state from the common error exit when
ret is non-zero. Successful can_attach() keeps the state for
cpuset_attach() or cpuset_cancel_attach().

Fixes: 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach() fails")
Cc: stable@vger.kernel.org # v6.10+
Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Chen Ridong <chenridong@huaweicloud.com>
Reviewed-by: Waiman Long <longman@redhat.com>
[ omitted upstream context line `cs->dl_bw_cpu = cpu;` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/cgroup/cpuset.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2579,16 +2579,13 @@ static int cpuset_can_attach(struct cgro
 		int cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
 
 		if (unlikely(cpu >= nr_cpu_ids)) {
-			reset_migrate_dl_data(cs);
 			ret = -EINVAL;
 			goto out_unlock;
 		}
 
 		ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
-		if (ret) {
-			reset_migrate_dl_data(cs);
+		if (ret)
 			goto out_unlock;
-		}
 	}
 
 out_success:
@@ -3401,7 +3398,10 @@ static int cpuset_can_fork(struct task_s
 	 * changes which zero cpus/mems_allowed.
 	 */
 	cs->attach_in_progress++;
+
 out_unlock:
+	if (ret)
+		reset_migrate_dl_data(cs);
 	mutex_unlock(&cpuset_mutex);
 	return ret;
 }



