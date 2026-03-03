Return-Path: <stable+bounces-222863-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGoBNDnPpmntWQAAu9opvQ
	(envelope-from <stable+bounces-222863-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 13:08:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA3C1EF07B
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 13:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE73530DF878
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 11:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A287033DEE0;
	Tue,  3 Mar 2026 11:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="R2F91bz8"
X-Original-To: stable@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AC8368961
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772539074; cv=none; b=QqqsXr4Z7UHufO+wjbgX9Zius6uLtMnau3ZwRJDkWJz9UZfBqqiLmaPahhr6CeGU8EGHVXHThf8fPoQY6TObN2r2Y6zhM0V/HPTNpGFAznQ6zgvf2HbCcgo4q6BCRmrfCG7cyAF9t2xpM5llqJagFZNJobMEX6qsglbISpVHNJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772539074; c=relaxed/simple;
	bh=q9D7nTsf7epzzlBy9rpoiqxMeDgk34e8bTmLmUqzuJk=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=iADQinQv35mKPolrebOMrNSqkKj0i5nlvxqLgPSKfZ8ZfJg9m6gs5Rwyte1FvyNm4Vy+cumoQMhMy9s2geCPK27Ejj5+5ToGquX7fHqxEHVHXzZakuIkMyKCc+GSCEPNNEDtI/SJv5ZkXPPO/fT4doM1QWVhDnC95t5cbZjhri4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=R2F91bz8; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1772539062;
	bh=eBubCQar9+5L9wnHp11Bopaac6qPmyBGrcmWaP0qPWk=;
	h=From:To:Cc:Subject:Date;
	b=R2F91bz8nykyfF2e9PG/ct+Ft7ggI1QWe1fadOhU6mWCIswZeUh/hRekT/lJn7c9N
	 fW9WF9K74EuoG1AoRUAQExiemu9Nm+C3PWZzDadA7ZI1H08UJLNFH4naJ3/tB30iRr
	 +R115Vz+1MngU/TSP4MYJnCs3DgCGG0VEKqZDMpU=
Received: from China-team ([60.247.85.88])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id E17AF88C; Tue, 03 Mar 2026 19:56:23 +0800
X-QQ-mid: xmsmtpt1772538983t9v3dkoln
Message-ID: <tencent_7BA7352F1F4B920BD6F63845300D0DE7B408@qq.com>
X-QQ-XMAILINFO: NU6czgUZ6QMQnlGjZmcMBfVYhO9hereqdHVIrNAkou1jqG5zqu5zhIVQAPABvr
	 7DO02saX1iG8WZIdBwBbSUQd/IquYCdmzL87zUDRVmck4EgPi7pzPmFNSDclOLw9lwIU7m1b4Rp8
	 g9j3BrcZAg6lpysx+dcKn5AiDj2v5B9ijqtqJok/YFOqwOnrvEcNIaN6fs4xRdZKt7Y//ZiYVjLE
	 CP/MZOcwbqdgMlEkRdb3Id3gdhAFnyHWJC9i7noQnNPK2wWRIUV5DKnhvHM181+57oN0LduegknC
	 YdsYNyklQW/OZQ2PjuKAKoEp/282/PxVELNt1zvSZhyfA12U0Hm2N1DUXST/Ujeg1aFugQmV5IhQ
	 cBdTL18DzNCL/+KpekeX0IDRUMbGn4tQHrnWFXGxSkH4UEIrhV8qYo7R0+1JlHm3ifqdRRhCI7Fq
	 auwNNLp4dzjU+wAYeoOOPd7Lm4Tk/y7+vn4JTzXLvYxacUwZV8WKq5BGld4OFxbaF4hh//fp9wFv
	 wwYtseiGpjhsS1VmSybPPPAeQGcgcuzIPBxXiLvP3TfCdm42l/k65BhyMnHsMtXLTf86hC/mNVYf
	 7J2zNBBZhYiLSQxPlueLAjcEegLpESvkyDboL1rKpKHXg0xpdGccFiXow0UZQ2ZWLPYOCocadX/9
	 Gs+rf3yZXDM8o3jRWaLtHhVy+q9kiCsXLpNtTaFTmAam8xfjkf4PXh3TGKS0EpH4TpQjtM61YU/W
	 M8nBtr34RMPcdV42GRDCXtsIS3a+0YG1SKSIVmTisg1KlUzvBhf20N4pqOKd1oLKJiMo6OZER33X
	 oEspAqgyGAOy5QwTjt1bdI3nvaQOdbgESqhWoj0R2z5NZrjRECYrJMq3oDKNa3hx+FXo/Zf3gwhl
	 uk4tQUH2vBeVvx2pllMVRwBqW+mmt+kHCU57erkF/w2CDNyY2WqmEafzDcR3Pz4JtJSUseoZKdkW
	 YgtLxoFsaCjaZNIEdpR5vMRTxUrBgOjqUVsygwAiWZlZ/Eom8OQI+gxS+VNUa1GiQnmjlEvbHnNE
	 j0aOcWG6ZeJzrmyfe0tTLugw5yfZggWu2N88bZEWBQ2pI5hHnEMJ2Xjg5Viip7kPHZqEiC66ylay
	 EWFwvE
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Alva Lan <alvalan9@foxmail.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Guchun Chen <guchun.chen@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.1.y] drm/amdgpu: drop redundant sched job cleanup when cs is aborted
Date: Tue,  3 Mar 2026 19:55:58 +0800
X-OQ-MSGID: <20260303115558.3689322-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9BA3C1EF07B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[foxmail.com];
	TAGGED_FROM(0.00)[bounces-222863-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[foxmail.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[amd.com,foxmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qq.com:mid,amd.com:email,foxmail.com:dkim,foxmail.com:email]
X-Rspamd-Action: no action

From: Guchun Chen <guchun.chen@amd.com>

[ Upstream commit 1253685f0d3eb3eab0bfc4bf15ab341a5f3da0c8 ]

Once command submission failed due to userptr invalidation in
amdgpu_cs_submit, legacy code will perform cleanup of scheduler
job. However, it's not needed at all, as former commit has integrated
job cleanup stuff into amdgpu_job_free. Otherwise, because of double
free, a NULL pointer dereference will occur in such scenario.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2457
Fixes: f7d66fb2ea43 ("drm/amdgpu: cleanup scheduler job initialization v2")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
[ Adjust context. The context change is irrelevant
to the current patch logic. ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index faeabe197dc6..71433aa375d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1244,7 +1244,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 		fence = &p->jobs[i]->base.s_fence->scheduled;
 		r = amdgpu_sync_fence(&leader->sync, fence);
 		if (r)
-			goto error_cleanup;
+			return r;
 	}
 
 	if (p->gang_size > 1) {
@@ -1270,7 +1270,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	}
 	if (r) {
 		r = -EAGAIN;
-		goto error_unlock;
+		mutex_unlock(&p->adev->notifier_lock);
+		return r;
 	}
 
 	p->fence = dma_fence_get(&leader->base.s_fence->finished);
@@ -1317,14 +1318,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	mutex_unlock(&p->adev->notifier_lock);
 	mutex_unlock(&p->bo_list->bo_list_mutex);
 	return 0;
-
-error_unlock:
-	mutex_unlock(&p->adev->notifier_lock);
-
-error_cleanup:
-	for (i = 0; i < p->gang_size; ++i)
-		drm_sched_job_cleanup(&p->jobs[i]->base);
-	return r;
 }
 
 /* Cleanup the parser structure */
-- 
2.43.0


