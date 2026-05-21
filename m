Return-Path: <stable+bounces-253532-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMnTHbsFD2qFEQYAu9opvQ
	(envelope-from <stable+bounces-253532-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:16:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8292C5A587D
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 981AB311B02A
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D723E349CD9;
	Thu, 21 May 2026 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbxfYqZM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A198D3A3830
	for <stable@vger.kernel.org>; Thu, 21 May 2026 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368277; cv=none; b=M2rMNrwH+X+0iCwrw9ksojK8/O2gz4rZvOnY043tcp6RaqA3K4VSab57Bocd18s1huANQhTxgm/aS9898MjGpmT6psStSVlo8ibjcDzZoAqyb8dWe/r/Rr6Dva0bDuSm/9QGVZtHQPo/DrRWyqlv5JMU/Gdx26k76GB/HTowiCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368277; c=relaxed/simple;
	bh=/CuhVwU/w07Qcw2gC+ELJ/a144Zl5BOnW9ipwqbMK9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OrSuROGyDfQpo+ibjH0PbsVeDftIN+1aPYG3GmyEjo0cWxAxNMoMUwMMgV+/oYTOJVFWqyr1foF7Zi+XahYAUXNY2sa1RauXg/TOXL9cHe97YU7XqcJuw0LGupYKgerg+z+g1y8BbqAdSQbLqCZZioX58K6YJ7yHKKwvQlxp+1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbxfYqZM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FF21F00A3C;
	Thu, 21 May 2026 12:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779368276;
	bh=8Q7nzUFVJbD6sXdtCSmhHSlGfU+IDd31q0R03rAFoQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kbxfYqZMhvrHnzsymzbOHGrojNdNa/9bcKTdN/UssI18vzFe34woxRWU/nRlItTGf
	 AtkCCqT0kvsYENqKYaf89APBsxNOUhddfYWXBr+MMXbD8RACWEHGrAbW+/hZAivHSC
	 4ehjSVgB8n0s8CpC8tUTgTBFdtTYAnES24EtkDGwiPS+KH9cn2c5NgJ5mWCWhBa/Ai
	 ATee41ZM7sjUzfJmb+UK9LdADGf1Ja90tDFf1raNlBz61ZqK5LQvcYWrqUyYzQ9OeP
	 NOWNPNJepZX5detDcn+Eutw/jYNB9NQXO9C1tG0L3nQy8ZO34OP6JxHGynbsOFsff2
	 Ny0MLMCWmkCDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 2/2] sched_ext: Avoid UAF in scx_root_enable_workfn() init failure path
Date: Thu, 21 May 2026 08:57:53 -0400
Message-ID: <20260521125753.1164691-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521125753.1164691-1-sashal@kernel.org>
References: <2026051526-prelude-boil-36f5@gregkh>
 <20260521125753.1164691-1-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-253532-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 8292C5A587D
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
[ kept `scx_init_task()` call site instead of `__scx_init_task()`/`task_rq_lock` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ec4a1d754d211..3a8f2b338ae89 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5239,10 +5239,10 @@ static void scx_enable_workfn(struct kthread_work *work)
 
 		ret = scx_init_task(p, task_group(p), false);
 		if (ret) {
-			put_task_struct(p);
 			scx_task_iter_stop(&sti);
 			scx_error(sch, "ops.init_task() failed (%d) for %s[%d]",
 				  ret, p->comm, p->pid);
+			put_task_struct(p);
 			goto err_disable_unlock_all;
 		}
 
-- 
2.53.0


