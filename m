Return-Path: <stable+bounces-253786-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KQfCmGGEGqEYwYAu9opvQ
	(envelope-from <stable+bounces-253786-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 18:37:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1E75B7A66
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 18:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7890130A137A
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 13:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1663839478B;
	Fri, 22 May 2026 13:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1Wj369p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA63D395AC5
	for <stable@vger.kernel.org>; Fri, 22 May 2026 13:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779454986; cv=none; b=Q9ZMryM+sq/EgzzTox05XfacTMLrh8R+uPm+bYXR5sEFUbrZdJ8pfi9Sw185eiphHxxXbchTCMXHBLdv7zYHKtAQWhgniw6oaZwRwC4HJD4wmzRU6Td8Gf9X+yJLYuZ9a9SSiiUAX5VrTHaZdLPXrmmh9yWmebWPchqrJhr49Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779454986; c=relaxed/simple;
	bh=z/EJ8UdSaVGA1/bVLFyThiJBQkcsDaXRaFZjvMTtTgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrLb2cp9WTPE4h//dfLzrm8IvYFrygJXM4yYhLTLq3IQLveMjwBaODcN9l+J8nQLD5E+S8i0jzeOaBWCH4asRtkgWGZsI8pewRV8+st1/rRDBJ5MrEUD2qfrazrfD/gyUNZnjWTbDsiZ+GhrYSgijvdxhjmiQK/nCTWWeZUz17Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1Wj369p; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51251F00A3D;
	Fri, 22 May 2026 13:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779454985;
	bh=OkjnoivwQFzZ8fRhJNmVrVhqTGPPR+/fgIZ1ByTHi2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S1Wj369pgXy9/8H1XypsXshtmo31L3g0agFBg2qa/3MuJjWza07pmJP0T2vMlNHY0
	 17uK5HkvB1A14VYYqjO+c+gDgIP8xvldmYOSya8USKdwpb47qeuJok9BcqsNX0Y5ck
	 XBlvd/eEAFEzvX06YMt1z61KZ8AbnKKcA0ztyDJDm/LzcxuE1+eVD1WX5idHQKo5Rc
	 gp1pkakO5lGiihupoxIvVeBNeMu/vd3HxNrGj0U61Tf+wtm+oYqTSruAEvt2cHVwMS
	 NChlBKNdhvNqXy+9O4WHIFw0zpYIPt+QTBaNaSXsMA5mTl6KWHVbIFlptM90YGG0n1
	 d23B6I2W3r/6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guopeng Zhang <zhangguopeng@kylinos.cn>,
	Tejun Heo <tj@kernel.org>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Waiman Long <longman@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] cgroup/cpuset: Reset DL migration state on can_attach() failure
Date: Fri, 22 May 2026 09:03:03 -0400
Message-ID: <20260522130303.3869136-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051951-crisped-scared-d8c0@gregkh>
References: <2026051951-crisped-scared-d8c0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253786-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20260515];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.969];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,huaweicloud.com:email]
X-Rspamd-Queue-Id: 2B1E75B7A66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 kernel/cgroup/cpuset.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 77b07548c3027..3f0804794b98d 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2996,16 +2996,13 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
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
@@ -3014,7 +3011,10 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
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
-- 
2.53.0


