Return-Path: <stable+bounces-259555-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RqjJJuSGHWrObQkAu9opvQ
	(envelope-from <stable+bounces-259555-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 15:19:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 105E061FE9F
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 15:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C6DF301CF83
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 13:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AF13A5443;
	Mon,  1 Jun 2026 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5Q4YBiM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FD33A5439
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780319851; cv=none; b=AsjO9HToBC7RiuN2ZNtgrxzg0BCilhLS6tZlsr+5NS3dSbnvPJ20gNGYit5vp5Y5CnN44/FGG9uHMqTitkYT0RvzMjQobG+IIfgzwgWuOeiwuxLpNeMTn0JFdFSYOGcRRVP8HU9KKzHGQzybFJzw7W5rzhcvKaQ3VBSJGg7Yqtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780319851; c=relaxed/simple;
	bh=qYKoVi+x36G94hE044+bUFL9jXAaWiJh/iNHARkiLjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nwnhMTXBX/TQg2SpqxauYMf0X2gZJIDocqNA678kDpqqhew1fDgZ3Ipn/Nqv6Qp+pAnoGVFMLH+WA1EMVIXPgLMUNSTyu2zmP/Sa/7bwvZtASypOqgKzNgr7gDY5zz37bBknOLeIZbAXDvBjLmaqNs2axpFEOkCNMK4nxiCSXBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5Q4YBiM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3C21F00898;
	Mon,  1 Jun 2026 13:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780319848;
	bh=ktRH/3S0TafftH4C0S6n/LcTYb88Elz+vYJlxl3VXPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d5Q4YBiM3Fa0uU80SW0kbUiXdZ9BGnNdPUPFIg5rSzUHaGHJoaTSe7QxCZfbIOtei
	 wz9Fk3TjIlUcjqSxR97VF7MZM7/dwAgBbEK+m2+ZNWSox4WUBDP3SDcOEjKRWlx4rA
	 zONN9E4YzhGaaojG76jV3rRcDADnCTwesCfAbUU+TUewk6HFDACDoA1YIxw1vLEXhS
	 Vw6xBgTwprEeh7rTb8eOYR8bdH2ZC6A1xho61m2KvcV6qssWZ76d/E2JBWNVUS15/z
	 CT1Cd6vXV1XLAliIQd1EnpFkRIrD5T+jqvoohKBlpwfvkiRYvLwZlrZrAwQbThf56f
	 ChisoMQh5P9hw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Iago Toral Quiroga <itoral@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] drm/v3d: Fix use-after-free of CPU job query arrays on error path
Date: Mon,  1 Jun 2026 09:17:24 -0400
Message-ID: <20260601131725.780793-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601131725.780793-1-sashal@kernel.org>
References: <2026052815-arose-kabob-9b34@gregkh>
 <20260601131725.780793-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259555-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,igalia.com:email]
X-Rspamd-Queue-Id: 105E061FE9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Maíra Canal <mcanal@igalia.com>

[ Upstream commit b0fe80c0b9250b35e2211bf3117e7aca814a21b0 ]

The CPU job ioctl's fail label calls kvfree() on cpu_job's timestamp and
performance query arrays after v3d_job_cleanup(), which drops the job's
last reference and frees cpu_job. Reading cpu_job at that point is a
use-after-free. Also, on the early v3d_job_init() failure path, it is a
NULL dereference, since v3d_job_deallocate() zeroes the local pointer.

In the success path, the arrays are released from the scheduler's
.free_job callback, but on the error path, they are freed manually, as
the job was never pushed to the scheduler. While the success path deals
with this correctly, the fail path doesn't.

On top of that, the manual kvfree() calls only free the array storage;
they don't drm_syncobj_put() the per-query syncobjs that
v3d_timestamp_query_info_free() and v3d_performance_query_info_free()
release on the success path. So the same fail path that triggers the
use-after-free also leaks one syncobj reference per query.

Unify the CPU job teardown into the CPU job's kref destructor, mirroring
v3d_render_job_free(). The scheduler's .free_job slot reverts to the
generic v3d_sched_job_free() and the fail label drops the manual
kvfree() calls, leaving a single teardown path that is reached from both
the scheduler and the ioctl error path. That removes the use-after-free,
the NULL dereference, and the syncobj leak by construction.

Cc: stable@vger.kernel.org
Fixes: 9ba0ff3e083f ("drm/v3d: Create a CPU job extension for the timestamp query job")
Assisted-by: Claude:claude-opus-4.7
Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
Link: https://patch.msgid.link/20260515-v3d-cpu-job-leaks-v1-1-7f147cbbf935@igalia.com
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Stable-dep-of: 6eb6e5acafa4 ("drm/v3d: Release indirect CSD GEM reference on CPU job free")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/v3d/v3d_sched.c  | 16 +---------------
 drivers/gpu/drm/v3d/v3d_submit.c | 19 ++++++++++++++++---
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 63564266135f6..c5b63ba46f3db 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -103,20 +103,6 @@ v3d_performance_query_info_free(struct v3d_performance_query_info *query_info,
 	}
 }
 
-static void
-v3d_cpu_job_free(struct drm_sched_job *sched_job)
-{
-	struct v3d_cpu_job *job = to_cpu_job(sched_job);
-
-	v3d_timestamp_query_info_free(&job->timestamp_query,
-				      job->timestamp_query.count);
-
-	v3d_performance_query_info_free(&job->performance_query,
-					job->performance_query.count);
-
-	v3d_job_cleanup(&job->base);
-}
-
 static void
 v3d_switch_perfmon(struct v3d_dev *v3d, struct v3d_job *job)
 {
@@ -846,7 +832,7 @@ static const struct drm_sched_backend_ops v3d_cache_clean_sched_ops = {
 
 static const struct drm_sched_backend_ops v3d_cpu_sched_ops = {
 	.run_job = v3d_cpu_job_run,
-	.free_job = v3d_cpu_job_free
+	.free_job = v3d_sched_job_free
 };
 
 int
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index ddc20191a1cee..40c21aaade0d6 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -118,6 +118,21 @@ v3d_render_job_free(struct kref *ref)
 	v3d_job_free(ref);
 }
 
+static void
+v3d_cpu_job_free(struct kref *ref)
+{
+	struct v3d_cpu_job *job = container_of(ref, struct v3d_cpu_job,
+					       base.refcount);
+
+	v3d_timestamp_query_info_free(&job->timestamp_query,
+				      job->timestamp_query.count);
+
+	v3d_performance_query_info_free(&job->performance_query,
+					job->performance_query.count);
+
+	v3d_job_free(ref);
+}
+
 void v3d_job_cleanup(struct v3d_job *job)
 {
 	if (!job)
@@ -1310,7 +1325,7 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 	trace_v3d_submit_cpu_ioctl(&v3d->drm, cpu_job->job_type);
 
 	ret = v3d_job_init(v3d, file_priv, &cpu_job->base,
-			   v3d_job_free, 0, &se, V3D_CPU);
+			   v3d_cpu_job_free, 0, &se, V3D_CPU);
 	if (ret) {
 		v3d_job_deallocate((void *)&cpu_job);
 		goto fail;
@@ -1393,8 +1408,6 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 	v3d_job_cleanup((void *)csd_job);
 	v3d_job_cleanup(clean_job);
 	v3d_put_multisync_post_deps(&se);
-	kvfree(cpu_job->timestamp_query.queries);
-	kvfree(cpu_job->performance_query.queries);
 
 	return ret;
 }
-- 
2.53.0


