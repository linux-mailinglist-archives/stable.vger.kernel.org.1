Return-Path: <stable+bounces-66618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AA594F064
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7073C281079
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB87184536;
	Mon, 12 Aug 2024 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PmD2KUIX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4206D183CC2
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474171; cv=none; b=A8fEHQUXgABEZnY0O42VggEhPeQZfsNxBUha+G/bgfqi4KytoDsqj64UtYcppZOxHpH3yjfbZmDWmraGy6QIM8/5dGKR/lgq9y6s0jmIsrcvsS74HExJCi65wkMkA93fpJujG0f1Fcj86K8g2RSU67YrIWmf8kFJfhHrk1b8hj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474171; c=relaxed/simple;
	bh=XN09kPGdKspAvv3qyJr/VMRWzMvU5SUcHR5tYbIYtdg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oUeUOj7YCLsctjDDMAmgL5/WIujoMEEzya+HE/8XaB9wgtbTPiZyyOmI6I6g15R/MhPV2foYB/h5o+ctQg79L2G/uTG5XQVb5ZcciujsGDkH4NcBPXCcTWXQyscuSy3GHmQ3xcMltNdacXJVjWH6NgiZfqtUSmAywoHKxiHkiEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PmD2KUIX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D066C32782;
	Mon, 12 Aug 2024 14:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474170;
	bh=XN09kPGdKspAvv3qyJr/VMRWzMvU5SUcHR5tYbIYtdg=;
	h=Subject:To:Cc:From:Date:From;
	b=PmD2KUIXBJIHSlKQyTP8xgk+tfZYCzgnveVM2v8EiFT7ruzMtHlY8MMZX9QXdja3v
	 7MYavhvacLDCtsUZj3UrZTFjwPXZ1BVNKKXbWtpnSS4NO6+G2Oz8rf/J1RE0V48E+3
	 cCdfbhGlFfjNpKsqPoyJGZXnL+acgmIEMRM/yCYY=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix cursor size issues" failed to apply to 5.4-stable tree
To: nevenko.stupar@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,sridevi.arvindekar@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:48:18 +0200
Message-ID: <2024081217-gratified-lazy-dce8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 51dbe0239b1fc7c435867ce28e5eb4394b6641e1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081217-gratified-lazy-dce8@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

51dbe0239b1f ("drm/amd/display: Fix cursor size issues")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
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
 


