Return-Path: <stable+bounces-66613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4018794F060
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1FE4282CB6
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B084D18454C;
	Mon, 12 Aug 2024 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IC1Zujy7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B04184547
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474154; cv=none; b=tBIknn5QKye3WoYZ5ZW8cNBExtf/wb9YHGOdcbyDWdqz2CHkvkGDi2jttd0KxEE4/NC2Z+lubwpddaV7ShmikX3LTRrg9Z3lbL70W0xzD1Y4bmFHV1722JFqWz3jsLHopVBDPgrY/PEVHuUNbK9iMyBplwHtEcPKX2LW2DfMg/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474154; c=relaxed/simple;
	bh=mIv+2G2FdM2adyMtwymF2tKcpCGLXHVEjc/I2CtYR6g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DIkXaqUh75E3++roMCVYlcmGb1SAXukhFrB+GQ7QXSjsrz0/UWRiuvX4tsgs/o6OC+o8y71glGvUqFgsK6w6TnK+elz8DNajNa/nzwS+yD1KAjRs4H1Qf2tqnP3k06tw/SlCgjuw5mc8jWcjXjI7XzjElSXgqZKBAzV1Zt7w+dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IC1Zujy7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FB6C4AF10;
	Mon, 12 Aug 2024 14:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474154;
	bh=mIv+2G2FdM2adyMtwymF2tKcpCGLXHVEjc/I2CtYR6g=;
	h=Subject:To:Cc:From:Date:From;
	b=IC1Zujy7yNFQy2w1hS2tgkHEAd1z9NJQ6+M+DZkl2pCwTg7XDCKF2H66+cs93TJta
	 2XUp7HBkdStFnI1dWdd+DvRNVlDydCLan+apaAWI56ITFsq1xuo4ztZq98n3CZVU/C
	 gSPnkYgEnUPtBioudld4J2i7JdJ8ezLi9PHmHHYw=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix cursor size issues" failed to apply to 6.1-stable tree
To: nevenko.stupar@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,sridevi.arvindekar@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:48:15 +0200
Message-ID: <2024081215-retrial-savings-0b41@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 51dbe0239b1fc7c435867ce28e5eb4394b6641e1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081215-retrial-savings-0b41@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

51dbe0239b1f ("drm/amd/display: Fix cursor size issues")
70839da63605 ("drm/amd/display: Add new DCN401 sources")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 51dbe0239b1fc7c435867ce28e5eb4394b6641e1 Mon Sep 17 00:00:00 2001
From: Nevenko Stupar <nevenko.stupar@amd.com>
Date: Tue, 11 Jun 2024 12:31:38 -0400
Subject: [PATCH] drm/amd/display: Fix cursor size issues

[WHY & HOW]
Fix the cursor size between ODM slices.

Reviewed-by: Sridevi Arvindekar <sridevi.arvindekar@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nevenko Stupar <nevenko.stupar@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 0cf55f557c3c..42753f56d31d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1169,6 +1169,20 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 		x_pos -= (prev_odm_width + prev_odm_offset);
 	}
 
+	/* If the position is negative then we need to add to the hotspot
+	 * to fix cursor size between ODM slices
+	 */
+
+	if (x_pos < 0) {
+		pos_cpy.x_hotspot -= x_pos;
+		x_pos = 0;
+	}
+
+	if (y_pos < 0) {
+		pos_cpy.y_hotspot -= y_pos;
+		y_pos = 0;
+	}
+
 	pos_cpy.x = (uint32_t)x_pos;
 	pos_cpy.y = (uint32_t)y_pos;
 


