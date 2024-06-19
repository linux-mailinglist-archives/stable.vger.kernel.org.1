Return-Path: <stable+bounces-53739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63EC90E5F2
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06CF81C21533
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746A92AE9B;
	Wed, 19 Jun 2024 08:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DRh2c41E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351527E576
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786310; cv=none; b=oY8MHG/BU4D2JdwUFEyLXdf9o5MgbXQiHf0SwwQypSyAbDcbqb5laELL8hhgOZrXofTf0Ybx0scf5ua7axejvw8roy5eXQDSQvfqA5BPxtWe6duAf9C8+zjPp7y+9p34ZRWskMIXpzOFO3ePPijEUsYS688wXts2f5muYkziwmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786310; c=relaxed/simple;
	bh=1aW8E74CXA1AChzTv9OtfiuYgXAPvD7a5stU95mtBoY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XUw1U2viXpAaDZxfrNDRr46sk0fYLzH+gurxHdhRKCW07zO857dK/hvEP4kr5KDO4PgeCIvp+w5JxxDfFicTdVHjHFIsWDAnmZEooM2n8WpWgpK5GXBplN25IqB9ZOQg//zkHHpIhCItS1aAr5GVGM65wRmwIVhp/fXkBXME8w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DRh2c41E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6AFC2BBFC;
	Wed, 19 Jun 2024 08:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718786310;
	bh=1aW8E74CXA1AChzTv9OtfiuYgXAPvD7a5stU95mtBoY=;
	h=Subject:To:Cc:From:Date:From;
	b=DRh2c41EuF8qdUQBJMTTBSpPmfYYWzxCi1EyrdCjdoGFitcbIRr/8x3rshwIROrav
	 goA7HcBh7Qaot/ntLavQOTXxufL0r3AnabDxk60qdSJXk6jGPW9ibgVn2DrtD7gD7t
	 5vxSONX0F2iG4quumm8ww7P9KbgDztV3bDp8ocfw=
Subject: FAILED: patch "[PATCH] drm/amd/display: always reset ODM mode in context when adding" failed to apply to 6.9-stable tree
To: wenjing.liu@amd.com,alexander.deucher@amd.com,alvin.lee2@amd.com,hamza.mahfooz@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 10:38:22 +0200
Message-ID: <2024061921-hardcover-jubilance-30ec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.9-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.9.y
git checkout FETCH_HEAD
git cherry-pick -x 4a5b171299e59d51322f4c6bd376c5acbeca0a4a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061921-hardcover-jubilance-30ec@gregkh' --subject-prefix 'PATCH 6.9.y' HEAD^..

Possible dependencies:

4a5b171299e5 ("drm/amd/display: always reset ODM mode in context when adding first plane")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4a5b171299e59d51322f4c6bd376c5acbeca0a4a Mon Sep 17 00:00:00 2001
From: Wenjing Liu <wenjing.liu@amd.com>
Date: Fri, 22 Mar 2024 15:02:45 -0400
Subject: [PATCH] drm/amd/display: always reset ODM mode in context when adding
 first plane

[why]
In current implemenation ODM mode is only reset when the last plane is
removed from dc state. For any dc validate we will always remove all
current planes and add new planes. However when switching from no planes
to 1 plane, ODM mode is not reset because no planes get removed. This
has caused an issue where we kept ODM combine when it should have been
remove when a plane is added. The change is to reset ODM mode when
adding the first plane.

Cc: stable@vger.kernel.org
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index d1d326e9b9b6..4f9ef07d29ec 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -458,6 +458,15 @@ bool dc_state_add_plane(
 		goto out;
 	}
 
+	if (stream_status->plane_count == 0 && dc->config.enable_windowed_mpo_odm)
+		/* ODM combine could prevent us from supporting more planes
+		 * we will reset ODM slice count back to 1 when all planes have
+		 * been removed to maximize the amount of planes supported when
+		 * new planes are added.
+		 */
+		resource_update_pipes_for_stream_with_slice_count(
+				state, dc->current_state, dc->res_pool, stream, 1);
+
 	otg_master_pipe = resource_get_otg_master_for_stream(
 			&state->res_ctx, stream);
 	if (otg_master_pipe)


