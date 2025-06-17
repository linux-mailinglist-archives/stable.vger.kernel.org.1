Return-Path: <stable+bounces-154391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3477DADD8DA
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0AF93BF58C
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BC02FA633;
	Tue, 17 Jun 2025 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="coI0L8JE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BA52FA624;
	Tue, 17 Jun 2025 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179043; cv=none; b=RmOwuyGv5pGtDMWihgVboIO1d5SFjaXDfGxymVSDTOHz2Ckgd3nWwIjcK6faPM7WMuaM0Y0upRi5gZ9r2Nf5pJhaIf8pqrSMkPzt8L5H0uMTQZDFH9CdsioHuk1rLduAdr0cqD/nIVcEM3BQuYUQcurGc8XTerMy6PdJIgscgOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179043; c=relaxed/simple;
	bh=Qrdansc+N233ul2CjwDF/ZmPeHohLDZ2io3BpJJTnrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eplnx7HUyfmfVEQc7MTNRHyjSePPyrdpm1ZYTrUJLf7WlCbt1F+Y7ePWQAU4P8XdgauYZrJz8LbC/RUtRbgoHkeo6rwsWRc29xxeo+V1wYPr05vT05vLEgXNV/DcmB3fMvZygsGuHmM8IcuGdH5WCyI/mg2Btl3LqMfpJPhcmXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=coI0L8JE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02ACCC4CEE3;
	Tue, 17 Jun 2025 16:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750179043;
	bh=Qrdansc+N233ul2CjwDF/ZmPeHohLDZ2io3BpJJTnrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=coI0L8JELReZ3GNFW7hWE6crqn4Rz7DvHSC121Ml6T6wxLLQoBL79NdpJgz7Aeahk
	 e1hE5qUqToai1/akES1zlhiEnsBFBAMpGbERnRUBvkLc8IFBLx+8yqfyq4YbB8ym+h
	 hTMlshRmSxw/2Z/AANP+frDABgb3QTipoIHek4xU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 630/780] drm/xe/pxp: Clarify PXP queue creation behavior if PXP is not ready
Date: Tue, 17 Jun 2025 17:25:38 +0200
Message-ID: <20250617152517.130284199@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

[ Upstream commit 69a58ef4fa77759b0e0c2f79834fa51b00a50c0b ]

The expected flow of operations when using PXP is to query the PXP
status and wait for it to transition to "ready" before attempting to
create an exec_queue. This flow is followed by the Mesa driver, but
there is no guarantee that an incorrectly coded (or malicious) app
will not attempt to create the queue first without querying the status.
Therefore, we need to clarify what the expected behavior of the queue
creation ioctl is in this scenario.

Currently, the ioctl always fails with an -EBUSY code no matter the
error, but for consistency it is better to distinguish between "failed
to init" (-EIO) and "not ready" (-EBUSY), the same way the query ioctl
does. Note that, while this is a change in the return code of an ioctl,
the behavior of the ioctl in this particular corner case was not clearly
spec'd, so no one should have been relying on it (and we know that Mesa,
which is the only known userspace for this, didn't).

v2: Minor rework of the doc (Rodrigo)

Fixes: 72d479601d67 ("drm/xe/pxp/uapi: Add userspace and LRC support for PXP-using queues")
Signed-off-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: John Harrison <John.C.Harrison@Intel.com>
Cc: José Roberto de Souza <jose.souza@intel.com>
Reviewed-by: José Roberto de Souza <jose.souza@intel.com>
Reviewed-by: John Harrison <John.C.Harrison@Intel.com>
Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://lore.kernel.org/r/20250522225401.3953243-7-daniele.ceraolospurio@intel.com
(cherry picked from commit 21784ca96025b62d95b670b7639ad70ddafa69b8)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_pxp.c | 8 ++++++--
 include/uapi/drm/xe_drm.h   | 5 +++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pxp.c b/drivers/gpu/drm/xe/xe_pxp.c
index 454ea7dc08ac8..b5bc15f436fa2 100644
--- a/drivers/gpu/drm/xe/xe_pxp.c
+++ b/drivers/gpu/drm/xe/xe_pxp.c
@@ -541,10 +541,14 @@ int xe_pxp_exec_queue_add(struct xe_pxp *pxp, struct xe_exec_queue *q)
 	 */
 	xe_pm_runtime_get(pxp->xe);
 
-	if (!pxp_prerequisites_done(pxp)) {
-		ret = -EBUSY;
+	/* get_readiness_status() returns 0 for in-progress and 1 for done */
+	ret = xe_pxp_get_readiness_status(pxp);
+	if (ret <= 0) {
+		if (!ret)
+			ret = -EBUSY;
 		goto out;
 	}
+	ret = 0;
 
 wait_for_idle:
 	/*
diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index 616916985e3f3..5e5442d03f878 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -1206,6 +1206,11 @@ struct drm_xe_vm_bind {
  *    there is no need to explicitly set that. When a queue of type
  *    %DRM_XE_PXP_TYPE_HWDRM is created, the PXP default HWDRM session
  *    (%XE_PXP_HWDRM_DEFAULT_SESSION) will be started, if isn't already running.
+ *    The user is expected to query the PXP status via the query ioctl (see
+ *    %DRM_XE_DEVICE_QUERY_PXP_STATUS) and to wait for PXP to be ready before
+ *    attempting to create a queue with this property. When a queue is created
+ *    before PXP is ready, the ioctl will return -EBUSY if init is still in
+ *    progress or -EIO if init failed.
  *    Given that going into a power-saving state kills PXP HWDRM sessions,
  *    runtime PM will be blocked while queues of this type are alive.
  *    All PXP queues will be killed if a PXP invalidation event occurs.
-- 
2.39.5




