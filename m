Return-Path: <stable+bounces-220212-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBkwOzUto2me+AQAu9opvQ
	(envelope-from <stable+bounces-220212-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:00:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C0E1C550C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5F59307EECD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1C44DA530;
	Sat, 28 Feb 2026 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0V1kkM+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C7E4DB549;
	Sat, 28 Feb 2026 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300118; cv=none; b=K+SxVDErSGr7h7i6Ug1oSBMSePHcBevcmd2G6/pUI4TwXa8lr7NMQzeJyExJCFBYLrvjMueUl9iPcfwb8iipeH//Uf1q4gM0OmHO5wPXspGcX9/wb8csq09VhXUoQh+dpgNt9Z7b+DPXu8C1yW3P3QEisBe/VoBpNa1z7aS2CN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300118; c=relaxed/simple;
	bh=TywdRE/Kigswv+zpZOJ5QiFmh2zPbE8rx25M2o9DWgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9tdYKF7WS/Z+upjE+vbaOILMTKqNzn2JIkRsmT7uSU9KU23+IW3uEb7Wt9ONX0NQcrqQMxW+C3pV9tFl2USTRQ7BhN4YmCru2vlBGKhHC9Em7MrKMOStLj2dQNWVapQ/b5OAMjqz6yFd5nNBEUu/I0FtuhRWqqt6pP1pKmCxDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0V1kkM+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5E5C19423;
	Sat, 28 Feb 2026 17:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300117;
	bh=TywdRE/Kigswv+zpZOJ5QiFmh2zPbE8rx25M2o9DWgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V0V1kkM+VEJcGRQEacnO6gR1mybos/tG0T/2lXHsEN+59fU+C9QmcqIzLRYJPUIIt
	 NCSnu+h8nOB/aHTzJUjOpEtZcFWzcfhUktN0xZrPR92tbm1KVoTMR0i+BSri8ReucC
	 hW9WSK0C5ibRFpXiVN+Qcy892uJbFm3XRHbRqhID5JQ+95ReiNMpcw234CGR2VpN6f
	 1vIbuEh9wl1ykLChozujyS+3DCj/fzCmHTsO7kQIRp5eazpFwYaXBZOk8D9wC7C7n0
	 fy71aOi3CMnAYvuwkOyF6rdfTjFl0tk/tkj7jdWLUb5p/7kh6w2Dgty/I1DVxKoLkB
	 0e9vF2Mo2F9QA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Alvin Lee <alvin.lee2@amd.com>,
	Roman Li <roman.li@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 134/844] drm/amd/display: Fix wrong x_pos and y_pos for cursor offload
Date: Sat, 28 Feb 2026 12:20:47 -0500
Message-ID: <20260228173244.1509663-135-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220212-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59C0E1C550C
X-Rspamd-Action: no action

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit c02288724b98cbc018231200891d66578f83f848 ]

[Why]
The hubp401_cursor_set_position function programs a different value
than it stores for use with cursor offload.

This can cause a desync when switching between cursor programming paths.

[How]
We do the translation to destination space currently twice: once in the
HWSS layer, and then again in the HUBP layer since we never store the
translated result.

HUBP expects to program the pos->x and pos->y directly for other ASIC,
so follow that pattern here as well.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c   | 14 ++++++--------
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |  3 +++
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index f01eae50d02f7..c205500290ecd 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -733,10 +733,8 @@ void hubp401_cursor_set_position(
 	const struct dc_cursor_mi_param *param)
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
-	int x_pos = pos->x - param->recout.x;
-	int y_pos = pos->y - param->recout.y;
-	int rec_x_offset = x_pos - pos->x_hotspot;
-	int rec_y_offset = y_pos - pos->y_hotspot;
+	int rec_x_offset = pos->x - pos->x_hotspot;
+	int rec_y_offset = pos->y - pos->y_hotspot;
 	int dst_x_offset;
 	int x_pos_viewport = 0;
 	int x_hot_viewport = 0;
@@ -748,10 +746,10 @@ void hubp401_cursor_set_position(
 	 * within preceeding ODM slices.
 	 */
 	if (param->recout.width) {
-		x_pos_viewport = x_pos * param->viewport.width / param->recout.width;
+		x_pos_viewport = pos->x * param->viewport.width / param->recout.width;
 		x_hot_viewport = pos->x_hotspot * param->viewport.width / param->recout.width;
 	} else {
-		ASSERT(!cur_en || x_pos == 0);
+		ASSERT(!cur_en || pos->x == 0);
 		ASSERT(!cur_en || pos->x_hotspot == 0);
 	}
 
@@ -790,8 +788,8 @@ void hubp401_cursor_set_position(
 
 	if (!hubp->cursor_offload) {
 		REG_SET_2(CURSOR_POSITION, 0,
-			CURSOR_X_POSITION, x_pos,
-			CURSOR_Y_POSITION, y_pos);
+			CURSOR_X_POSITION, pos->x,
+			CURSOR_Y_POSITION, pos->y);
 
 		REG_SET_2(CURSOR_HOT_SPOT, 0,
 			CURSOR_HOT_SPOT_X, pos->x_hotspot,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 5eda7648d0d2b..5ffe41a96864a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1215,6 +1215,9 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	if (recout_y_pos + (int)hubp->curs_attr.height <= 0)
 		pos_cpy.enable = false;  /* not visible beyond top edge*/
 
+	pos_cpy.x = x_pos;
+	pos_cpy.y = y_pos;
+
 	hubp->funcs->set_cursor_position(hubp, &pos_cpy, &param);
 	dpp->funcs->set_cursor_position(dpp, &pos_cpy, &param, hubp->curs_attr.width, hubp->curs_attr.height);
 }
-- 
2.51.0


