Return-Path: <stable+bounces-269693-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E5GVHos3QmoH2AkAu9opvQ
	(envelope-from <stable+bounces-269693-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 11:14:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F036D7F52
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 11:14:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=yandex.ru header.s=mail header.b=oFEeQzkK;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269693-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269693-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=yandex.ru;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B88B8304FA5E
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 09:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0FC3F7AB4;
	Mon, 29 Jun 2026 09:11:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [178.154.239.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF693F0747;
	Mon, 29 Jun 2026 09:11:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724277; cv=none; b=S/GgI26vGzMBrlaKeqs0xoPPfR4M8pqs+LqumKuTuXtpt0El0dePQ6itY9SeLwPIFDLb3emKRqKoxcdxGhRRjM4upuyyxszBRNbvLM/zLEgsq7MHrxOyZR98rZKejuxrKOQai2BOd6Q2iOKAkeRcLG5XiTRhU/jufKtfdOyvrgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724277; c=relaxed/simple;
	bh=OxAfcyH+8Zv1fFuZDzh0c3Nh09c0gOk2dNXllQCCaxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhtzXwAfljuccDfE36AwOKV9E0SBh3HfrsRN9eAgIu3231sIAPpRDlhsUGdrwIMvxr6ZHIBPjjpwjWpGxc9BY6HN5s40Wt5XkZGI4fBOlFSd+xDzL1akn32wQsQ2jse05faSlIu6OY6pwgVgj7ubE+a8Usmc2N2LbuTz2+1xnPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=oFEeQzkK; arc=none smtp.client-ip=178.154.239.211
Received: from mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:bb8b:0:640:6ac7:0])
	by forward100d.mail.yandex.net (postfix) with ESMTPS id D4A69C00F9;
	Mon, 29 Jun 2026 12:11:07 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (smtp) with ESMTPSA id ZAZXGGsiDOs0-SYImwU3y;
	Mon, 29 Jun 2026 12:11:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1782724266; bh=sM6D1HOqQeLKlOUIzQLXH1KXbMCFiNY+40aRY6mi29w=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=oFEeQzkKKDg2nhmtrxaFqL4852a639s7Ts1woroD9xE/zhNNnF9HDiEQ5/f3CkZHc
	 xJvdTg3+k9RBR+I/FXG040mgTNws4BKM7LoceYpE4ZyXobGmqK3+IEZTymrp9SIGHH
	 ZufbMbECzuPkDrasku8yNbM4DbKK4k8uVi/wDfRA=
From: Evgenii Burenchev <evg28bur@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Evgenii Burenchev <evg28bur@yandex.ru>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	mario.limonciello@amd.com,
	alex.hung@amd.com,
	superm1@kernel.org,
	timur.kristof@gmail.com,
	ivan.lipski@amd.com,
	ray.wu@amd.com,
	aurabindo.pillai@amd.com,
	chen-yu.chen@amd.com,
	mripard@kernel.org,
	Dillon.Varone@amd.com,
	mwen@igalia.com,
	chiahsuan.chung@amd.com,
	kenneth.feng@amd.com,
	srinivasan.shanmugam@amd.com,
	tzimmermann@suse.de,
	Alvin.Lee2@amd.com,
	dmitry.baryshkov@oss.qualcomm.com,
	chaitanya.kumar.borah@intel.com,
	ekurzinger@gmail.com,
	pierre-eric.pelloux-prayer@amd.com,
	HaoPing.Liu@amd.com,
	Tony.Cheng@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v4 3/3] drm/amd/display: Fix dangling pointer in connector reset function
Date: Mon, 29 Jun 2026 12:04:31 +0300
Message-ID: <20260629090435.9729-5-evg28bur@yandex.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629090435.9729-2-evg28bur@yandex.ru>
References: <20260629090435.9729-2-evg28bur@yandex.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[yandex.ru,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[yandex.ru:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269693-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[evg28bur@yandex.ru,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[yandex.ru,amd.com,igalia.com,gmail.com,ffwll.ch,kernel.org,suse.de,oss.qualcomm.com,intel.com,lists.freedesktop.org,vger.kernel.org,linuxtesting.org];
	FREEMAIL_FROM(0.00)[yandex.ru];
	RCPT_COUNT_TWELVE(0.00)[36];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:evg28bur@yandex.ru,m:harry.wentland@amd.com,m:sunpeng.li@amd.com,m:siqueira@igalia.com,m:alexander.deucher@amd.com,m:christian.koenig@amd.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:mario.limonciello@amd.com,m:alex.hung@amd.com,m:superm1@kernel.org,m:timur.kristof@gmail.com,m:ivan.lipski@amd.com,m:ray.wu@amd.com,m:aurabindo.pillai@amd.com,m:chen-yu.chen@amd.com,m:mripard@kernel.org,m:Dillon.Varone@amd.com,m:mwen@igalia.com,m:chiahsuan.chung@amd.com,m:kenneth.feng@amd.com,m:srinivasan.shanmugam@amd.com,m:tzimmermann@suse.de,m:Alvin.Lee2@amd.com,m:dmitry.baryshkov@oss.qualcomm.com,m:chaitanya.kumar.borah@intel.com,m:ekurzinger@gmail.com,m:pierre-eric.pelloux-prayer@amd.com,m:HaoPing.Liu@amd.com,m:Tony.Cheng@amd.com,m:amd-gfx@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:timurkristof@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[evg28bur@yandex.ru,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[yandex.ru:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9F036D7F52

amdgpu_dm_connector_funcs_reset() frees the old state before allocating
a new one. If kzalloc_obj() fails, the function returns without updating
the state pointer, leaving a dangling pointer to already freed memory.

Fix this by allocating the new state first. On allocation failure, the
old state remains untouched and the function safely returns.

Additionally restore the explicit kfree(old_state) which was lost when
the function was refactored, as __drm_atomic_helper_connector_destroy_state()
only frees resources but not the state structure itself.

Fixes: e7b07ceef2a6 ("drm/amd/display: Merge amdgpu_dm_types and amdgpu_dm")
Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 39 ++++++++++---------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d3a8d681227a..b1f91dd0ab61 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8151,33 +8151,34 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 
 void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)
 {
-	struct dm_connector_state *state =
+	struct dm_connector_state *old_state =
 		to_dm_connector_state(connector->state);
+	struct dm_connector_state *state;
+
+	state = kzalloc_obj(*state);
+	if (!state)
+		return;
 
 	if (connector->state)
 		__drm_atomic_helper_connector_destroy_state(connector->state);
 
-	kfree(state);
+	kfree(old_state);
 
-	state = kzalloc_obj(*state);
+	__drm_atomic_helper_connector_reset(connector, &state->base);
 
-	if (state) {
-		state->scaling = RMX_OFF;
-		state->underscan_enable = false;
-		state->underscan_hborder = 0;
-		state->underscan_vborder = 0;
-		state->base.max_requested_bpc = 8;
-		state->vcpi_slots = 0;
-		state->pbn = 0;
-
-		if (connector->connector_type == DRM_MODE_CONNECTOR_eDP) {
-			if (amdgpu_dm_abm_level <= 0)
-				state->abm_level = ABM_LEVEL_IMMEDIATE_DISABLE;
-			else
-				state->abm_level = amdgpu_dm_abm_level;
-		}
+	state->scaling = RMX_OFF;
+	state->underscan_enable = false;
+	state->underscan_hborder = 0;
+	state->underscan_vborder = 0;
+	state->base.max_requested_bpc = 8;
+	state->vcpi_slots = 0;
+	state->pbn = 0;
 
-		__drm_atomic_helper_connector_reset(connector, &state->base);
+	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP) {
+		if (amdgpu_dm_abm_level <= 0)
+			state->abm_level = ABM_LEVEL_IMMEDIATE_DISABLE;
+		else
+			state->abm_level = amdgpu_dm_abm_level;
 	}
 }
 
-- 
2.43.0


