Return-Path: <stable+bounces-235946-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MND/Du2f3GkEUgkAu9opvQ
	(envelope-from <stable+bounces-235946-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 09:49:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 983DB3E882A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 09:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F868301D696
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 07:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B3A396B65;
	Mon, 13 Apr 2026 07:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="3FeC+dzV"
X-Original-To: stable@vger.kernel.org
Received: from n169-113.mail.139.com (n169-113.mail.139.com [120.232.169.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B01B318146
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 07:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066094; cv=none; b=aU98cpholiltAfUso7lFSYoys0ZYWFP03drikKYbgo9X9WZFafkhpqA0eU0TFApSut5UecMzXdisAcNmwsI0SeMuwxrjRI+TxcjOLWiEnARyz9WVyhM5SXi5U7heb7AmawZp+p/BJ9UYcMB5IWdAKJNAKCzGS/s9a+GN1a+uDFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066094; c=relaxed/simple;
	bh=Ql89zuRDrqT1IbYdpqT9/C+78Rm+tZU1ijx7qpY+jEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p9kYNHz+gxiU/Mf0puNmFW0pP+jV2T+HXoPKiGKWNylmZhH12Ad/m9FB1WjwbsRTelql/WVljVne2HNjLGwx8MjAAdDGA2kh47E7tcqmbsOfQhSra3Aetf5n7bFZ704r8/j1YIJr/apLyXOdY0dQOw5M84l6rw41ZcE9homNJVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=3FeC+dzV; arc=none smtp.client-ip=120.232.169.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=3FeC+dzVLCax7ef04CFljJ+wC+jTj6pvn7yNDEj9xYLYLbItiL22fY2q7wKBVTUVrMgAB+qxuRK+w
	 J/EkybRb9OJVfae4av82vLlzEXR5FLF9OVXQlg1cRx5KP7HfkUCGaVmX9ZFJLrIFwSTGIsqKebgjwd
	 8919VwMP54oy3DnA=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from China-Mobile-Kernel-Team (unknown[223.104.41.220])
	by rmsmtp-lg-appmail-33-12047 (RichMail) with SMTP id 2f0f69dc9e265ae-c271c;
	Mon, 13 Apr 2026 15:41:29 +0800 (CST)
X-RM-TRANSID:2f0f69dc9e265ae-c271c
From: Leon Chen <leonchen.oss@139.com>
To: leonchen.oss@139.com
Cc: christian.koenig@amd.com,
	lincao12@amd.com,
	phasta@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 6.1.y] drm/scheduler: signal scheduled fence when kill job
Date: Mon, 13 Apr 2026 15:41:27 +0800
Message-Id: <20260413074127.8080-1-leonchen.oss@139.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20260413073323.7541-1-leonchen.oss@139.com>
References: <20260413073323.7541-1-leonchen.oss@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.54 / 15.00];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235946-lists,stable=lfdr.de];
	DMARC_NA(0.00)[139.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[139.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[leonchen.oss@139.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.863];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,139.com:email,139.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 983DB3E882A
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
v1 -> v2:
Forgot to git commit after modifying drm_sched_fence_scheduled(job->s_fence, NULL)
to drm_sched_fence_scheduled(job->s_fence)
---
 drivers/gpu/drm/scheduler/sched_entity.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 3f68a47e3406..3469ba0f990b 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -196,6 +196,7 @@ static void drm_sched_entity_kill_jobs_work(struct work_struct *wrk)
 {
 	struct drm_sched_job *job = container_of(wrk, typeof(*job), work);
 
+	drm_sched_fence_scheduled(job->s_fence);
 	drm_sched_fence_finished(job->s_fence);
 	WARN_ON(job->s_fence->parent);
 	job->sched->ops->free_job(job);
-- 
2.35.3



