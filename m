Return-Path: <stable+bounces-66616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C290594F065
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48BB5B26D4F
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B00F18453E;
	Mon, 12 Aug 2024 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gFMzMwfI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A130184538
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474164; cv=none; b=LeoAQ6BumiBE/RNBXTQBVDerv8Os5g2r1lN1zLk1t1r8Ah+3H3N02J+DeeNHoGFxpIvfqMmyBaWBNkkkW2A2X40cfmRJz12pV3TzyjJTksdsRYc5oo6iXwWxeYzmjQePEQcaa3Orqol5/Tkh0m7UtuwEPJATCsshoOtLxynvfmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474164; c=relaxed/simple;
	bh=tIioqp1BxjQZOUgNrkAc556y2J2NxynpoXBRPNXFwE4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=h2FBpEuhDI+W7IMksarO9FKgp1jWe4KfUVNJbaMXtFEs7OCtfTkpmUo70VlbAVbsGP3Nhev2wVcJ0mvPO97LuWeQ5Tez29UYWH9YbOO9iL/uDHONW6V41LCGOlms0Y6/fD5nRsCGbQsk/p4MPaY2Nrg2zn3FbNyIaFiDvjCEhFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gFMzMwfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE6DC32782;
	Mon, 12 Aug 2024 14:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474164;
	bh=tIioqp1BxjQZOUgNrkAc556y2J2NxynpoXBRPNXFwE4=;
	h=Subject:To:Cc:From:Date:From;
	b=gFMzMwfIlWrcKtazjhu507H1LIXtoPbgeVJlK/fFEGx/uvjQjfuCq0RQkxVLIABZ9
	 xjoOpBnd5HGfO+04HFkSr/hzDx8bGg20Zgh8UbQojm+124/jqgDU4xVXFWFHxJOe2e
	 vccCqAUkXdYE81hTd4kOPFN+gyMJ9r75JQlVKITg=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix cursor size issues" failed to apply to 5.10-stable tree
To: nevenko.stupar@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,sridevi.arvindekar@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:48:17 +0200
Message-ID: <2024081217-drinkable-module-42d6@gregkh>
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
git cherry-pick -x 51dbe0239b1fc7c435867ce28e5eb4394b6641e1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081217-drinkable-module-42d6@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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
 


