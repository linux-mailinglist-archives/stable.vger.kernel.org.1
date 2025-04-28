Return-Path: <stable+bounces-136864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD00A9EFCD
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 13:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1533B60D4
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 11:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A9D265CD2;
	Mon, 28 Apr 2025 11:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YXhdw9TW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1711EDA13
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745841364; cv=none; b=kLj3F4hFt4TDKszFZrV7HVkzvOyLbOrBO0TPKh/uorOb3DSkHEmwHLf2RJpUbhpCgDjAM8p3lf3ZAzSwDqJ3ygphGsiUOYrYJ5SU797s42ybH3jkCOtnH7QtrjQy/OOaklr3FiVVLoC7pLIokXDopmmS3N2EtkdiMEGZIWh7Cjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745841364; c=relaxed/simple;
	bh=YKZHP2qAmH4LZ1lF0RnIv9445I2pdvEIrY/vVa3pcoU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mL61WktuJ1ym9EJbYAod2Z+ee3MtXTLOsmJDkqQkfwvPKgCvKb0zgg/a3lVfaj7RYxhlGju+usjG4F07EOswTn3Q8hUV5pihQ+rb0ax1XnjF+jqmUvUAfXUA32didPw6oQdJIvKD+Y8VgXxDqmpLiPW4IWfW5EL804E6NT25sU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YXhdw9TW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE849C4CEE4;
	Mon, 28 Apr 2025 11:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745841364;
	bh=YKZHP2qAmH4LZ1lF0RnIv9445I2pdvEIrY/vVa3pcoU=;
	h=Subject:To:Cc:From:Date:From;
	b=YXhdw9TWn6Fn5jwWzso5mopT3QFqz9lw8QZdox68LvcbojzWeUlFfkeNd13CRg9aq
	 zBaWoT/6CXnwdG2F27qic7y2OPX2Ii8Hs1wiBSgqHF84uy0LfdNDtyMmJnRrwunDKW
	 37HwauG8VUpzNARw+01jNCu2YrajNKQQegh9luls=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix gpu reset in multidisplay config" failed to apply to 5.10-stable tree
To: Roman.Li@amd.com,alexander.deucher@amd.com,aurabindo.pillai@amd.com,mario.limonciello@amd.com,mark.broadworth@amd.com,zaeem.mohamed@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Apr 2025 13:56:01 +0200
Message-ID: <2025042801-bucktooth-unstopped-52b8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 7eb287beeb60be1e4437be2b4e4e9f0da89aab97
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042801-bucktooth-unstopped-52b8@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7eb287beeb60be1e4437be2b4e4e9f0da89aab97 Mon Sep 17 00:00:00 2001
From: Roman Li <Roman.Li@amd.com>
Date: Tue, 1 Apr 2025 17:05:10 -0400
Subject: [PATCH] drm/amd/display: Fix gpu reset in multidisplay config

[Why]
The indexing of stream_status in dm_gpureset_commit_state() is incorrect.
That leads to asserts in multi-display configuration after gpu reset.

[How]
Adjust the indexing logic to align stream_status with surface_updates.

Fixes: cdaae8371aa9 ("drm/amd/display: Handle GPU reset for DC block")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3808
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Tested-by: Mark Broadworth <mark.broadworth@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit d91bc901398741d317d9b55c59ca949d4bc7394b)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9fed4471405f..8f3a778df646 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3355,16 +3355,16 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 	for (k = 0; k < dc_state->stream_count; k++) {
 		bundle->stream_update.stream = dc_state->streams[k];
 
-		for (m = 0; m < dc_state->stream_status->plane_count; m++) {
+		for (m = 0; m < dc_state->stream_status[k].plane_count; m++) {
 			bundle->surface_updates[m].surface =
-				dc_state->stream_status->plane_states[m];
+				dc_state->stream_status[k].plane_states[m];
 			bundle->surface_updates[m].surface->force_full_update =
 				true;
 		}
 
 		update_planes_and_stream_adapter(dm->dc,
 					 UPDATE_TYPE_FULL,
-					 dc_state->stream_status->plane_count,
+					 dc_state->stream_status[k].plane_count,
 					 dc_state->streams[k],
 					 &bundle->stream_update,
 					 bundle->surface_updates);


