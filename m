Return-Path: <stable+bounces-16192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD4583F19A
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6247285F6A
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FFF200BC;
	Sat, 27 Jan 2024 23:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hmo/sWcY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A87115AF9
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397094; cv=none; b=DNV1EiwARtXrWVKiZppLuagSa9LIrDHnbJ/C8k7ceh3QwnEgDyrJWRH0Bk1q3tz3/c+oaIB5YMPgT+FMV24Q/cyuFmGFEn8RAa83D1GkwS/j5bX+AfBPiIE+C/N0TE720gvw8C9UgaIxVUS4qd33jb9Z8eSsSiYHg8ht/1xQNzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397094; c=relaxed/simple;
	bh=a1x2DbCSf8zEDPwr5E5dmAy2Xpq00G+7IG1Ho+3GeZg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=L6mRh674Tue+SPAMFTOb/sBFeZnEosEnx03ozuGrPq30sP7t+X3nLCsSMghoXlZI6AcnVaOHgr/mSSijb1QFtrhNvTG4Z5rwp/u131dptGuPr39w+cVDRP4vj6cI7eZ7a7aCrllIHzxmzopqu9tjEPLGom157N0EMdyfBytZ0/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hmo/sWcY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10054C433F1;
	Sat, 27 Jan 2024 23:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706397094;
	bh=a1x2DbCSf8zEDPwr5E5dmAy2Xpq00G+7IG1Ho+3GeZg=;
	h=Subject:To:Cc:From:Date:From;
	b=hmo/sWcYMqcYs3jahnjWL7G3Ei4HdEJiZM6++BGG51owD8ByDMOp/OdfVFWRlVBGJ
	 Rl7dKihMNqQIbTol6hlkr/ThPzQwa/5HmLrJJjUl6wJQaXyWQ5xFXepvqeaLubNdP/
	 Geja/tk64Yg0m4XxZ+CXNDvm/NPUx7cVgPTuFx5U=
Subject: FAILED: patch "[PATCH] drm/amd/display: fix a pipe mapping error in dcn32_fpu" failed to apply to 6.6-stable tree
To: wenjing.liu@amd.com,alexander.deucher@amd.com,chaitanya.dhere@amd.com,hamza.mahfooz@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:11:33 -0800
Message-ID: <2024012733-genre-immunity-c4f2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 613a81995575889753ca44d70d33e84a1d21bae5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012733-genre-immunity-c4f2@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

613a81995575 ("drm/amd/display: fix a pipe mapping error in dcn32_fpu")
df475cced6af ("drm/amd/display: add primary pipe check when building slice table for dcn3x")
c51d87202d1f ("drm/amd/display: do not attempt ODM power optimization if minimal transition doesn't exist")
39d39a019657 ("drm/amd/display: switch to new ODM policy for windowed MPO ODM support")
0b9dc439f404 ("drm/amd/display: Write flip addr to scratch reg for subvp")
96182df99dad ("drm/amd/display: Enable runtime register offset init for DCN32 DMUB")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 613a81995575889753ca44d70d33e84a1d21bae5 Mon Sep 17 00:00:00 2001
From: Wenjing Liu <wenjing.liu@amd.com>
Date: Mon, 6 Nov 2023 16:47:19 -0500
Subject: [PATCH] drm/amd/display: fix a pipe mapping error in dcn32_fpu

[why]
In dcn32 DML pipes are ordered the same as dc pipes but only for used
pipes. For example, if dc pipe 1 and 2 are used, their dml pipe indices
would be 0 and 1 respectively. However
update_pipe_slice_table_with_split_flags doesn't skip indices for free
pipes. This causes us to not reference correct dml pipe output when
building pipe topology.

[how]
Use two variables to iterate dc and dml pipes respectively and only
increment dml pipe index when current dc pipe is not free.

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 9ec4172d1c2d..44b0666e53b0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1192,13 +1192,16 @@ static bool update_pipe_slice_table_with_split_flags(
 	 */
 	struct pipe_ctx *pipe;
 	bool odm;
-	int i;
+	int dc_pipe_idx, dml_pipe_idx = 0;
 	bool updated = false;
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		pipe = &context->res_ctx.pipe_ctx[i];
+	for (dc_pipe_idx = 0;
+			dc_pipe_idx < dc->res_pool->pipe_count; dc_pipe_idx++) {
+		pipe = &context->res_ctx.pipe_ctx[dc_pipe_idx];
+		if (resource_is_pipe_type(pipe, FREE_PIPE))
+			continue;
 
-		if (merge[i]) {
+		if (merge[dc_pipe_idx]) {
 			if (resource_is_pipe_type(pipe, OPP_HEAD))
 				/* merging OPP head means reducing ODM slice
 				 * count by 1
@@ -1213,17 +1216,18 @@ static bool update_pipe_slice_table_with_split_flags(
 			updated = true;
 		}
 
-		if (split[i]) {
-			odm = vba->ODMCombineEnabled[vba->pipe_plane[i]] !=
+		if (split[dc_pipe_idx]) {
+			odm = vba->ODMCombineEnabled[vba->pipe_plane[dml_pipe_idx]] !=
 					dm_odm_combine_mode_disabled;
 			if (odm && resource_is_pipe_type(pipe, OPP_HEAD))
 				update_slice_table_for_stream(
-						table, pipe->stream, split[i] - 1);
+						table, pipe->stream, split[dc_pipe_idx] - 1);
 			else if (!odm && resource_is_pipe_type(pipe, DPP_PIPE))
 				update_slice_table_for_plane(table, pipe,
-						pipe->plane_state, split[i] - 1);
+						pipe->plane_state, split[dc_pipe_idx] - 1);
 			updated = true;
 		}
+		dml_pipe_idx++;
 	}
 	return updated;
 }


