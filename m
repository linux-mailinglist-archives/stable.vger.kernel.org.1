Return-Path: <stable+bounces-3757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8E780242B
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 14:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C0DE1C20911
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 13:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099ECEED5;
	Sun,  3 Dec 2023 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hN1npLVO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87F7C8CB
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 13:20:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283BCC433C8;
	Sun,  3 Dec 2023 13:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701609638;
	bh=ffAleLvAf9q6aN/xc8jtftroafqMeiU8WQg1Yr/bgIc=;
	h=Subject:To:Cc:From:Date:From;
	b=hN1npLVONvlM0cxrSueAb0T++/FuXVH6fgmiXKIc8gJ5x55TGmhWKMkT7gJ5ji9Sx
	 1oggYGBLLCsKsDun1ZCR7+5FNVtrPKcHNH2yeEk9r40OwBmW41gcFSHskU0VKb18b+
	 yKwnnwtq9Isxo1TwkZ4o5aTMlD6C8Bkxy0RNJNmQ=
Subject: FAILED: patch "[PATCH] drm/amd/display: fix a pipe mapping error in dcn32_fpu" failed to apply to 6.6-stable tree
To: wenjing.liu@amd.com,alexander.deucher@amd.com,chaitanya.dhere@amd.com,hamza.mahfooz@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 Dec 2023 14:20:35 +0100
Message-ID: <2023120334-shredder-scheming-284d@gregkh>
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
git cherry-pick -x dc9b0c2af004fe7d9d7b67015fadcb0a7123c740
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120334-shredder-scheming-284d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

dc9b0c2af004 ("drm/amd/display: fix a pipe mapping error in dcn32_fpu")
df475cced6af ("drm/amd/display: add primary pipe check when building slice table for dcn3x")
c51d87202d1f ("drm/amd/display: do not attempt ODM power optimization if minimal transition doesn't exist")
39d39a019657 ("drm/amd/display: switch to new ODM policy for windowed MPO ODM support")
0b9dc439f404 ("drm/amd/display: Write flip addr to scratch reg for subvp")
96182df99dad ("drm/amd/display: Enable runtime register offset init for DCN32 DMUB")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dc9b0c2af004fe7d9d7b67015fadcb0a7123c740 Mon Sep 17 00:00:00 2001
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


