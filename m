Return-Path: <stable+bounces-127267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B07AEA76D8B
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 21:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9F9188AB0F
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 19:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87C8215067;
	Mon, 31 Mar 2025 19:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Yu3om6wM"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB321214201
	for <stable@vger.kernel.org>; Mon, 31 Mar 2025 19:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743450142; cv=none; b=hJs71ggIB7JQWZkQSZ24yAhBRHgBS4g7ywvgrU8vx+ZTDqfeE2q3zg4QQICrUuiT6f6DyccgumaKEyBHXUFFLCbrYql/rMXjvN+Qi7IWN5yHIciW86rOoaFEfzj+q1n06F60Hb3c0eEIfNiLtmqpuoPocJAtD5y8T9YQ0G6f28Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743450142; c=relaxed/simple;
	bh=iQAod1p3/4Hkg3w9dJjalCnEMYPlx2M1zSDZPSFJ+4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pOG3i9GUAE5eCU8KkqAPZyyfLdkseU2xX1JZ17b06zGYiVdvyyXYRcxJHoR/a1mQYDKSf+uSQ0NTclkpyN0zZKmtSBGC/w0NKLLpMHMQFEfIT0fULjNU7DIuJGS1nDNcU5zjLHrpAaPOxIY/S3eUC93B1S22BvOyZ07AxvChJfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Yu3om6wM; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+fX9dP9EqlD9Do0CtkXjQS12QiNKzBSBjEkM9iArbnI=; b=Yu3om6wM3QC4wKzjGtgdV3ELM3
	wMzd0ZfQTxQ17H4YDuccYH8iRWdHOIy+PnT5jzuQmvs7eyrfgBfKMLx1/8a46F3f3rnXdbN+7b7hf
	lIuF4FAh2O5/DO4Bfz8uYGs+uKovu5LCNFO3q0dhX1d2e9Yjk6qmMIv912+2npf1tlKt4+5zEdtZt
	/bOb8rczKoqTSbRYYOg4feBZa0FCZhgHFfZI4QfaDDJ5oSEedpye3xwn4DQRvX8KjHo7fJYvxhb3x
	Ls+XQJDVOpV/3X0KZCvCjbW/IPFlMfIOzBxccrNzmjN7yUOZnVndP4RQ3RFN3yjqh/0nB1xMYoKyV
	E+9c7sHA==;
Received: from [179.125.94.226] (helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tzL1N-009LPP-JX; Mon, 31 Mar 2025 21:42:10 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Imre Deak <imre.deak@intel.com>,
	Lyude Paul <lyude@redhat.com>,
	Wayne Lin <Wayne.Lin@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	kernel-dev@igalia.com,
	cascardo@igalia.com
Subject: [PATCH 6.6 1/3] drm/dp_mst: Factor out function to queue a topology probe work
Date: Mon, 31 Mar 2025 16:42:15 -0300
Message-ID: <20250331194217.763735-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Imre Deak <imre.deak@intel.com>

[ Upstream commit e9b36c5be2e7fdef2cc933c1dac50bd81881e9b8 ]

Factor out a function to queue a work for probing the topology, also
used by the next patch.

Cc: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240722165503.2084999-2-imre.deak@intel.com
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 08f8a22431fe..2a6feb83f786 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -2692,6 +2692,11 @@ static void drm_dp_mst_link_probe_work(struct work_struct *work)
 		drm_kms_helper_hotplug_event(dev);
 }
 
+static void drm_dp_mst_queue_probe_work(struct drm_dp_mst_topology_mgr *mgr)
+{
+	queue_work(system_long_wq, &mgr->work);
+}
+
 static bool drm_dp_validate_guid(struct drm_dp_mst_topology_mgr *mgr,
 				 u8 *guid)
 {
@@ -3643,7 +3648,7 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
 		/* Write reset payload */
 		drm_dp_dpcd_write_payload(mgr, 0, 0, 0x3f);
 
-		queue_work(system_long_wq, &mgr->work);
+		drm_dp_mst_queue_probe_work(mgr);
 
 		ret = 0;
 	} else {
@@ -3766,7 +3771,7 @@ int drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr,
 	 * state of our in-memory topology back into sync with reality. So,
 	 * restart the probing process as if we're probing a new hub
 	 */
-	queue_work(system_long_wq, &mgr->work);
+	drm_dp_mst_queue_probe_work(mgr);
 	mutex_unlock(&mgr->lock);
 
 	if (sync) {
-- 
2.47.2


