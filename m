Return-Path: <stable+bounces-250788-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NBfGrfsDWo04wUAu9opvQ
	(envelope-from <stable+bounces-250788-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:17:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 13913593435
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5847E30905B8
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A870374178;
	Wed, 20 May 2026 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZlOGwPCC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3E6368968;
	Wed, 20 May 2026 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296314; cv=none; b=tF9Q06l3FlDmPfm02rLxxbPHwE4C728JZ1LJV536+hw57IpwQG7g5UbeIrzHj9QmjXaYm4uF3Tzb91/l6dmmZzvxr8w5Czrz7c5cbLFgE4vAyLkKVcni78LZWGhZG6KmmvDct6HND2y029FCuCCxfY8q2b6sqk4y/hWDrZmgPoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296314; c=relaxed/simple;
	bh=s8vZvvNOhEedifZdK2efRUFMLi0Rxs0AefxbxSGgSaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGuSFwFwjuhtA77/SPxXDiyOZiwUrKXDqSuQsbIfJsSRD56LxygmjCz42lSQ2DkuqUMssTvWN0I2R+iwat0X5xgnhwVZwMakl4goivLJmtVkabonWZhUciXDe7le4ITqa6YJLj9tQMfjj/xwS/NCWjO8Ae7eH77OceCX9Kt5hSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZlOGwPCC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E361F000E9;
	Wed, 20 May 2026 16:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296313;
	bh=ccrbawwvEBabTXmTlk3ejbjy3VuNWcuFLCCIrMypZWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZlOGwPCCMxVEy45lJsJBICtSevFr4fpwwTVUNpeRXgPjKcgKTkgMpN4WzEN5T6lNV
	 H7tM2iz/UUr5lV2mC3VhJE/rCb6NxsPzXUEkk+J3lmSwsMVd7+xtqKD5jxgFdg95gs
	 je5j9TpJtm3WO5L+ouCEE0sJ2soeAINgddsWfcSY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ray Wu <ray.wu@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0735/1146] drm/amd/display: Fix parameter mismatch in panel self-refresh helper
Date: Wed, 20 May 2026 18:16:25 +0200
Message-ID: <20260520162204.840554748@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-250788-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 13913593435
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit f2483b3f39c8e20d2de0cc16e512a1b2aa14baf9 ]

Align parameter names with function arguments.

The function controls panel self-refresh enable/disable based on vblank
and VRR state.

Fixes the below with gcc W=1:
../display/amdgpu_dm/amdgpu_dm_crtc.c:131 function parameter 'dm' not described in 'amdgpu_dm_crtc_set_panel_sr_feature'
../display/amdgpu_dm/amdgpu_dm_crtc.c:131 function parameter 'acrtc' not described in 'amdgpu_dm_crtc_set_panel_sr_feature'
../display/amdgpu_dm/amdgpu_dm_crtc.c:131 function parameter 'stream' not described in 'amdgpu_dm_crtc_set_panel_sr_feature'
../display/amdgpu_dm/amdgpu_dm_crtc.c:131 function parameter 'dm' not described in 'amdgpu_dm_crtc_set_panel_sr_feature'
../display/amdgpu_dm/amdgpu_dm_crtc.c:131 function parameter 'acrtc' not described in 'amdgpu_dm_crtc_set_panel_sr_feature'
../display/amdgpu_dm/amdgpu_dm_crtc.c:131 function parameter 'stream' not described in 'amdgpu_dm_crtc_set_panel_sr_feature'

Fixes: 754003486c3c ("drm/amd/display: Add Idle state manager(ISM)")
Cc: Ray Wu <ray.wu@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 21 +++++++++----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 304437c2284d8..527d0ad69348e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -101,23 +101,22 @@ bool amdgpu_dm_crtc_vrr_active(const struct dm_crtc_state *dm_state)
 
 /**
  * amdgpu_dm_crtc_set_panel_sr_feature() - Manage panel self-refresh features.
- *
- * @vblank_work:    is a pointer to a struct vblank_control_work object.
- * @vblank_enabled: indicates whether the DRM vblank counter is currently
- *                  enabled (true) or disabled (false).
- * @allow_sr_entry: represents whether entry into the self-refresh mode is
- *                  allowed (true) or not allowed (false).
+ * @dm: amdgpu display manager instance.
+ * @acrtc: CRTC whose panel self-refresh state is being updated.
+ * @stream: DC stream associated with @acrtc.
+ * @vblank_enabled: Whether the DRM vblank counter is currently enabled.
+ * @allow_sr_entry: Whether entry into self-refresh mode is allowed.
  *
  * The DRM vblank counter enable/disable action is used as the trigger to enable
  * or disable various panel self-refresh features:
  *
  * Panel Replay and PSR SU
  * - Enable when:
- *      - VRR is disabled
- *      - vblank counter is disabled
- *      - entry is allowed: usermode demonstrates an adequate number of fast
- *        commits)
- *     - CRC capture window isn't active
+ *   - VRR is disabled
+ *   - vblank counter is disabled
+ *   - entry is allowed: usermode demonstrates an adequate number of fast
+ *     commits
+ *   - CRC capture window isn't active
  * - Keep enabled even when vblank counter gets enabled
  *
  * PSR1
-- 
2.53.0




