Return-Path: <stable+bounces-62164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDFE93E657
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 17:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16B61C20B8A
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 15:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4CE78C7D;
	Sun, 28 Jul 2024 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5tOxok8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B8178C7A;
	Sun, 28 Jul 2024 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181472; cv=none; b=Kr3L4QetJpovciJD6WqiDAIhB37smx8uX8kqgzh+t1z92rHTG6LDdiq16h325a9SDQNkwoFPw+rA0OkFo0UwjHuIZdIYA6iNpRhvL3v8y66v1Orcgf0J4RHYcpXXpVizcS1eTI8bgxWAQlhtegE+4XgHoQoNPfZ2BmoLrvqhTAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181472; c=relaxed/simple;
	bh=PhUeR7yYmxaM6RyfVYIprb0Wbx/tF1HiF3qEf2iSiow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEXWmPbZKGJrM2LR6/qB9ZD11tM3puOou8hqAmYy2RcI/cZix5ykku2sjn5TYbAN6AtNaOaE+oemF1AbW5gLQPRd46j/bh1GdQpAyVVVqbzHT8lkIfrnmejoEdVI6FQ5It47vvP7BErz4Xe/kN6M71IwHreMRRCnlBnrf15/m7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5tOxok8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62459C116B1;
	Sun, 28 Jul 2024 15:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181472;
	bh=PhUeR7yYmxaM6RyfVYIprb0Wbx/tF1HiF3qEf2iSiow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A5tOxok8denubA8dZsbHkUq6IZpNfRkq5TSM6jgk0IserjfBNqzlUwwaPyEplJWc4
	 U99wR6OP1ojJfreYZN86WmsKywQKnURJNbs2t6cj6ptnap8EjAFRkdhGANplKjJeIk
	 495XJ1XkoBRTG4HLGKxMUYadBmtVQAcEIyrr0zJhW1jWCPlHkbwEuVkRsDdxrVsk1N
	 SJ+2aUyVeUIBvrg1cUEwG2pxDC2RQqWmW6T+pBQpxjNBVDd1A2AvxLPUkG8wLh1/hu
	 IVZzOhYFvA87ri9zK9c8mtaZ8239Ytl36TeZmeQcYQQqaGXvxMHzOzD9rZ73yHaqtU
	 zSn45/rmDPTSg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wenjing Liu <wenjing.liu@amd.com>,
	Dillon Varone <dillon.varone@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	jun.lei@amd.com,
	hamza.mahfooz@amd.com,
	chiahsuan.chung@amd.com,
	alvin.lee2@amd.com,
	george.shen@amd.com,
	alex.hung@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 20/34] drm/amd/display: remove dpp pipes on failure to update pipe params
Date: Sun, 28 Jul 2024 11:40:44 -0400
Message-ID: <20240728154230.2046786-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154230.2046786-1-sashal@kernel.org>
References: <20240728154230.2046786-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Wenjing Liu <wenjing.liu@amd.com>

[ Upstream commit 3ddd9c83ff7ac0ead38188425b14d03dc2f2c133 ]

[why]
There are cases where update pipe params could fail but dpp pipes are already
added to the state. In this case, we should remove dpp pipes so dc state is
restored back. If it is not restored, dc state is corrupted after calling this
function, so if we call the same interface with the corrupted state again, we
may end up programming pipe topology based on a corrupted dc state.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index a2ca66a268c2d..a51e5de6554ee 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2701,6 +2701,7 @@ bool resource_append_dpp_pipes_for_plane_composition(
 		struct dc_plane_state *plane_state)
 {
 	bool success;
+
 	if (otg_master_pipe->plane_state == NULL)
 		success = add_plane_to_opp_head_pipes(otg_master_pipe,
 				plane_state, new_ctx);
@@ -2708,10 +2709,15 @@ bool resource_append_dpp_pipes_for_plane_composition(
 		success = acquire_secondary_dpp_pipes_and_add_plane(
 				otg_master_pipe, plane_state, new_ctx,
 				cur_ctx, pool);
-	if (success)
+	if (success) {
 		/* when appending a plane mpc slice count changes from 0 to 1 */
 		success = update_pipe_params_after_mpc_slice_count_change(
 				plane_state, new_ctx, pool);
+		if (!success)
+			resource_remove_dpp_pipes_for_plane_composition(new_ctx,
+					pool, plane_state);
+	}
+
 	return success;
 }
 
@@ -2721,6 +2727,7 @@ void resource_remove_dpp_pipes_for_plane_composition(
 		const struct dc_plane_state *plane_state)
 {
 	int i;
+
 	for (i = pool->pipe_count - 1; i >= 0; i--) {
 		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
 
-- 
2.43.0


