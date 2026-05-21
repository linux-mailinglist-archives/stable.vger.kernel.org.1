Return-Path: <stable+bounces-253589-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCbaFHc4D2qIHwYAu9opvQ
	(envelope-from <stable+bounces-253589-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:53:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 518795A9A8C
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A5A633355B05
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 14:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7084025B0A0;
	Thu, 21 May 2026 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSytyQjD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B6233A708
	for <stable@vger.kernel.org>; Thu, 21 May 2026 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375136; cv=none; b=SkyJ17BpLnaCD/sWdiTQL+2BWXohnUjNZzu8T327RlFlQ7EIhNu/xsgONyP7h15tSqy50CjyqkUG1Dd03dMaQRxfwx58oB8pmHkeOwk2OXpqlGq7rZppLfc8GL+7ah8LKyQfp7NLA1KjgdL8yCeHp6cFzZeJ00pTvoD8MMrufP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375136; c=relaxed/simple;
	bh=pZUlxb97jxLUErfJJvlpP4ZEoq304nxzgDkQ+rKjT/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwcMJ8ShlMzn1j3pq0m77+4VIEeMdZZyq8lSi6kX1vdJm6rBVEhVgAZDWE0kEUSvsm2dMXVZqueXiC8gUF6zqDB92bCY7EwBNjoXyNxSZclZCalPEOCdyaORSTprcZmCbvUdGuh2JHJrBd9VmfEXQdcatxDoiUJzNY/1Goi0QMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSytyQjD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514801F00A3D;
	Thu, 21 May 2026 14:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779375134;
	bh=javepyaLx8zADndMYOPh4V8vNOaRySKDLZukay1UIzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QSytyQjDOSNsD1i99WO9lOVZcEj+lqK74qxDC3uyPBNDZBS3142GazX18E6COw8Bk
	 YRdlxrFt9jm8+NkSZ0rc1AEZdi9GsvQ6LLpKlu9SNmDWzs+Q/WE/XGGvLLLyGTt6ms
	 nPr6mhD2aGSqt/ye/jhQ/EwG/e/UJg9chx6tz9R/zrFfyAcVFJ8+LSNC1on84TeWrZ
	 1lsSIoTtjX3fyAQkoXQL8ZJBuG+NNasxuUVi2JzNaifuapY25NPlWEYVQp9ST17Zk6
	 D7CjLWpZnepDIPyzyxfkGKFji7xaorv3q9i3AiSMs3qtXWvzrlogBwgwdSOuulbeEI
	 m/NgaVyCx0aKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] sched_ext: Avoid UAF in scx_root_enable_workfn() init failure path
Date: Thu, 21 May 2026 10:52:11 -0400
Message-ID: <20260521145211.1316611-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521145211.1316611-1-sashal@kernel.org>
References: <2026051527-snort-dawn-9645@gregkh>
 <20260521145211.1316611-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253589-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 518795A9A8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 9a415cc53711f2238e0f0ca8a6bcc796c003b127 ]

In scx_root_enable_workfn(), put_task_struct(p) is called before scx_error()
dereferences p->comm and p->pid. If the iterator's reference is the last
drop, the task is freed synchronously and the deref becomes a UAF.

Move put_task_struct() past scx_error().

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260511214031.AF5E9C2BCB0@smtp.kernel.org/
Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Tejun Heo <tj@kernel.org>
[ adapted fix to pre-refactor scx_ops_enable_workfn() with scx_task_iter_relock() instead of upstream scx_root_enable_workfn() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index e55e0db83400f..1b66cca7b5fce 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5406,11 +5406,11 @@ static void scx_ops_enable_workfn(struct kthread_work *work)
 
 		ret = scx_ops_init_task(p, task_group(p), false);
 		if (ret) {
-			put_task_struct(p);
 			scx_task_iter_relock(&sti);
 			scx_task_iter_stop(&sti);
 			scx_ops_error("ops.init_task() failed (%d) for %s[%d]",
 				      ret, p->comm, p->pid);
+			put_task_struct(p);
 			goto err_disable_unlock_all;
 		}
 
-- 
2.53.0


