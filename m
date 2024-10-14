Return-Path: <stable+bounces-83981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 755D199CD87
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 201EB1F23A8B
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82E91AD3E5;
	Mon, 14 Oct 2024 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FA8hKe5f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DCD1AB507;
	Mon, 14 Oct 2024 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916396; cv=none; b=FEoFHjoIXo1OKLDPDWQunXQgdob4ElqjkuG8jSx791qU8C/rLdqABlVIG1MaogFbPuuIZsEIj++36Mvsjs2r2nR2Fm+cK9hsNsJrzvP3rjRpi53crRBGEbhE+9WY0zdHWylDPZR6Dfw6mtApO7oedU8AE7N8QFJHldoXSg534q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916396; c=relaxed/simple;
	bh=aQEbvS92iMd3nCruHJJvzVP8PMDPRbpiI24PZUvN1Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjQx9wlCyqx8yb7lwfreVP8BvFReJuit+62ClswAWV33Zqwz6ZbHzv6HGCOE+FAVciWZPBB3dtb6MkUCAGOG3cy6BwqGM/tWgoVYEKroaLL2dV0InWBJBZJbfTCA3lib/Vy8VRBAo6diLLIIyZUw18HoaCLJh99zhM1sqbOwArM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FA8hKe5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DF6C4CEC3;
	Mon, 14 Oct 2024 14:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728916396;
	bh=aQEbvS92iMd3nCruHJJvzVP8PMDPRbpiI24PZUvN1Ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FA8hKe5f3vlT8HaAxfrQtSwyw3xlApnxNzndS6ivP5RrtfYLKC5Q9au0bWaAjTZ39
	 hG6p1Xis6g3OzuvWVMPMR+uwXHrgozZh3ZI8Uk2nzP0mM5wrYlnasOh6582eCR5fFg
	 7zo6G2TEVvQoBSvH3PsvjMfoWkqRDfHFjiQ/7t3s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Melissa Wen <mwen@igalia.com>,
	Aric Cyr <aric.cyr@amd.com>,
	Josip Pavic <Josip.Pavic@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.11 172/214] drm/amd/display: Clear update flags after update has been applied
Date: Mon, 14 Oct 2024 16:20:35 +0200
Message-ID: <20241014141051.690959585@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141044.974962104@linuxfoundation.org>
References: <20241014141044.974962104@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josip Pavic <Josip.Pavic@amd.com>

commit 0a9906cc45d21e21ca8bb2b98b79fd7c05420fda upstream.

[Why]
Since the surface/stream update flags aren't cleared after applying
updates, those same updates may be applied again in a future call to
update surfaces/streams for surfaces/streams that aren't actually part
of that update (i.e. applying an update for one surface/stream can
trigger unintended programming on a different surface/stream).

For example, when an update results in a call to
program_front_end_for_ctx, that function may call program_pipe on all
pipes. If there are surface update flags that were never cleared on the
surface some pipe is attached to, then the same update will be
programmed again.

[How]
Clear the surface and stream update flags after applying the updates.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3441
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3616
Cc: Melissa Wen <mwen@igalia.com>
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 7671f62c10f2a4c77d89b39fd50fab7f918d6809)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c |   45 +++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 11 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5120,11 +5120,26 @@ static bool update_planes_and_stream_v3(
 	return true;
 }
 
+static void clear_update_flags(struct dc_surface_update *srf_updates,
+	int surface_count, struct dc_stream_state *stream)
+{
+	int i;
+
+	if (stream)
+		stream->update_flags.raw = 0;
+
+	for (i = 0; i < surface_count; i++)
+		if (srf_updates[i].surface)
+			srf_updates[i].surface->update_flags.raw = 0;
+}
+
 bool dc_update_planes_and_stream(struct dc *dc,
 		struct dc_surface_update *srf_updates, int surface_count,
 		struct dc_stream_state *stream,
 		struct dc_stream_update *stream_update)
 {
+	bool ret = false;
+
 	dc_exit_ips_for_hw_access(dc);
 	/*
 	 * update planes and stream version 3 separates FULL and FAST updates
@@ -5141,10 +5156,16 @@ bool dc_update_planes_and_stream(struct
 	 * features as they are now transparent to the new sequence.
 	 */
 	if (dc->ctx->dce_version >= DCN_VERSION_4_01)
-		return update_planes_and_stream_v3(dc, srf_updates,
+		ret = update_planes_and_stream_v3(dc, srf_updates,
 				surface_count, stream, stream_update);
-	return update_planes_and_stream_v2(dc, srf_updates,
+	else
+		ret = update_planes_and_stream_v2(dc, srf_updates,
 			surface_count, stream, stream_update);
+
+	if (ret)
+		clear_update_flags(srf_updates, surface_count, stream);
+
+	return ret;
 }
 
 void dc_commit_updates_for_stream(struct dc *dc,
@@ -5154,6 +5175,8 @@ void dc_commit_updates_for_stream(struct
 		struct dc_stream_update *stream_update,
 		struct dc_state *state)
 {
+	bool ret = false;
+
 	dc_exit_ips_for_hw_access(dc);
 	/* TODO: Since change commit sequence can have a huge impact,
 	 * we decided to only enable it for DCN3x. However, as soon as
@@ -5161,17 +5184,17 @@ void dc_commit_updates_for_stream(struct
 	 * the new sequence for all ASICs.
 	 */
 	if (dc->ctx->dce_version >= DCN_VERSION_4_01) {
-		update_planes_and_stream_v3(dc, srf_updates, surface_count,
+		ret = update_planes_and_stream_v3(dc, srf_updates, surface_count,
 				stream, stream_update);
-		return;
-	}
-	if (dc->ctx->dce_version >= DCN_VERSION_3_2) {
-		update_planes_and_stream_v2(dc, srf_updates, surface_count,
+	} else if (dc->ctx->dce_version >= DCN_VERSION_3_2) {
+		ret = update_planes_and_stream_v2(dc, srf_updates, surface_count,
 				stream, stream_update);
-		return;
-	}
-	update_planes_and_stream_v1(dc, srf_updates, surface_count, stream,
-			stream_update, state);
+	} else
+		ret = update_planes_and_stream_v1(dc, srf_updates, surface_count, stream,
+				stream_update, state);
+
+	if (ret)
+		clear_update_flags(srf_updates, surface_count, stream);
 }
 
 uint8_t dc_get_current_stream_count(struct dc *dc)



