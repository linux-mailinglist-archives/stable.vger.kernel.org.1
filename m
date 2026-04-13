Return-Path: <stable+bounces-235942-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEQSElmd3GkxUAkAu9opvQ
	(envelope-from <stable+bounces-235942-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 09:38:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4573E8534
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 09:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55809300CC33
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 07:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71505391E65;
	Mon, 13 Apr 2026 07:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="N4AOvUkP"
X-Original-To: stable@vger.kernel.org
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DC7366055
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 07:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776065621; cv=none; b=i8Wp0y0UqvHCOQA/mu+WcNw1lsKA0osCnNtz4koPsUjjVFAbWvpju/gWAXJQxTiCOdHVSoFFmgk1cgssfi+Id7HZnqCLL4GEeFupKXTqolSVrrdv+u2V+thqXHKW7t0SHaaRp5RrwhbaGts1zPHUHL8OgXOU06eviJpBlUXp9+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776065621; c=relaxed/simple;
	bh=n69w6rLScSwCCr1HV9wYvatYzWr3FsxDX7udJtq1lK4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dLGvffIuqcXMftdHssc50KjfuLCYHvOpCcxEWOcFcE0fhnfA1/WN4GLWkoTFLMCNmqPSsg9Tj5TCcvWC+Kb+N9CFdDq+YpBdU8e8o1JWdKPyQDb5ZsTLbkPBuXTJq9ZkqMDcnW18iCieylGK5r/cgFoeCQJHboLWk15wzXLOGUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=N4AOvUkP; arc=none smtp.client-ip=120.232.169.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=N4AOvUkPjan3tRJBDkwK62/MDc03XlbUZVEIjs8EI6OQlNKg1kD/3aU400YIrJgG/xYO2ia4GLNy/
	 r2Eyq3ThgOq3wR2APVH8oSiCMjC3dLzsDQfS6AwFIw5CoUmbixIPUlLrN5uEjarLPNssGo4ghqeHl9
	 p+Uhg0sEDXSeiql4=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from China-Mobile-Kernel-Team (unknown[223.104.41.220])
	by rmsmtp-lg-appmail-23-12026 (RichMail) with SMTP id 2efa69dc9c41163-c214a;
	Mon, 13 Apr 2026 15:33:26 +0800 (CST)
X-RM-TRANSID:2efa69dc9c41163-c214a
From: Leon Chen <leonchen.oss@139.com>
To: lincao12@amd.com,
	phasta@kernel.org,
	christian.koenig@amd.com,
	stable@vger.kernel.org
Subject: [PATCH 6.1.y] drm/scheduler: signal scheduled fence when kill job
Date: Mon, 13 Apr 2026 15:33:23 +0800
Message-Id: <20260413073323.7541-1-leonchen.oss@139.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235942-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[139.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[139.com];
	FROM_NEQ_ENVFROM(0.00)[leonchen.oss@139.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 8F4573E8534
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Lin.Cao" <lincao12@amd.com>

[ Upstream commit 471db2c2d4f80ee94225a1ef246e4f5011733e50 ]

When an entity from application B is killed, drm_sched_entity_kill()
removes all jobs belonging to that entity through
drm_sched_entity_kill_jobs_work(). If application A's job depends on a
scheduled fence from application B's job, and that fence is not properly
signaled during the killing process, application A's dependency cannot be
cleared.

This leads to application A hanging indefinitely while waiting for a
dependency that will never be resolved. Fix this issue by ensuring that
scheduled fences are properly signaled when an entity is killed, allowing
dependent applications to continue execution.

Signed-off-by: Lin.Cao <lincao12@amd.com>
Reviewed-by: Philipp Stanner <phasta@kernel.org>
Signed-off-by: Christian König <christian.koenig@amd.com>
Link: https://lore.kernel.org/r/20250515020713.1110476-1-lincao12@amd.com
[ Modified drm_sched_fence_scheduled(job->s_fence, NULL) to
  drm_sched_fence_scheduled(job->s_fence) for kernel 6.1.y ]
Signed-off-by: Leon Chen <leonchen.oss@139.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 3f68a47e3406..3af74eac83b6 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -196,6 +196,7 @@ static void drm_sched_entity_kill_jobs_work(struct work_struct *wrk)
 {
 	struct drm_sched_job *job = container_of(wrk, typeof(*job), work);
 
+	drm_sched_fence_scheduled(job->s_fence, NULL);
 	drm_sched_fence_finished(job->s_fence);
 	WARN_ON(job->s_fence->parent);
 	job->sched->ops->free_job(job);
-- 
2.35.3



