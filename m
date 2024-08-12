Return-Path: <stable+bounces-66606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBEC94F056
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF681C220AA
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4F117995B;
	Mon, 12 Aug 2024 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DctMU3jZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40D953370
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474131; cv=none; b=fv2nwFNUivd7bHKrP5tIYmPoFVUnQUxYCJ2mVzmT3a7jBvKOHQz48a+IYerTb6hUW/WzafHpoinKu2JMTLTxh3sNMaK8pgZRvDsw9rrL2xIjXSzuF1Lq+G8S2CQDHg5J0Ha9XpHcirayaigKWQZAFwkYsXnHon4fQFKwsiMCB2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474131; c=relaxed/simple;
	bh=eXGJ6awhtkHL7E9RaQPe4QyjzN0lprr/WujQ+wa4GI4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QPhY7CAx/rBnqkTf2YACDVBi69dcCsLv9JPJ8E+mfdY2P96++/iwdGTGyjL+r02qd2fNl3tPzd+TiYV30Y8wHiviv+rZ+Y2C2WDbOyvKRbTSlga6SYCFsWlGkoGD5R+jIcvlCiZVW1oXSBnv5CYagbyVJcazYw5pDEOQ9r78EOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DctMU3jZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54536C32782;
	Mon, 12 Aug 2024 14:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474131;
	bh=eXGJ6awhtkHL7E9RaQPe4QyjzN0lprr/WujQ+wa4GI4=;
	h=Subject:To:Cc:From:Date:From;
	b=DctMU3jZ+wuj/Oxvq6ub2NmmZ6eFFFejxuE18uHvCTulpRKomRG4B2mTanVMfr9/d
	 kg74bu64L36cJcSZS7DNheg99SXx7K3EA4m8gYnVHO0BE6yra5Te9tSxMFpSluRFdd
	 R4Bxuucf5TybwYjNtXXbAIBpKvD+ZxHrstD4iW5g=
Subject: FAILED: patch "[PATCH] drm/amd/display: Program CURSOR_DST_X_OFFSET in viewport" failed to apply to 6.6-stable tree
To: alvin.lee2@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,nevenko.stupar@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:48:05 +0200
Message-ID: <2024081205-caucus-fruit-5918@gregkh>
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
git cherry-pick -x e1e75cf7334c0e31f4c37d715b964784d45685fa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081205-caucus-fruit-5918@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

e1e75cf7334c ("drm/amd/display: Program CURSOR_DST_X_OFFSET in viewport space")
ee8287e068a3 ("drm/amd/display: Fix cursor issues with ODMs and HW rotations")
319d4615518c ("drm/amd/display: mirror case cleanup for cursors")
dd9d8c61ccff ("drm/amd/display: Minor cleanup for DCN401 cursor related code")
ed79ab5a07c1 ("drm/amd/display: DCN401 cusor code update")
827416d45476 ("drm/amd/display: Fix multiple cursors when using 4 displays on a contiguous large surface")
c2edec1676ca ("drm/amd/display: Fix incorrect cursor position for dcn401")
44b9a7cfc035 ("drm/amd/display: Fix ODM + underscan case with cursor")
70839da63605 ("drm/amd/display: Add new DCN401 sources")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e1e75cf7334c0e31f4c37d715b964784d45685fa Mon Sep 17 00:00:00 2001
From: Alvin Lee <alvin.lee2@amd.com>
Date: Thu, 13 Jun 2024 16:10:16 -0400
Subject: [PATCH] drm/amd/display: Program CURSOR_DST_X_OFFSET in viewport
 space

[WHAT & HOW]
According to register specifications, the CURSOR_DST_X_OFFSET
is relative to the start of the data viewport, not RECOUT space.
In this case we must transform the cursor coordinates passed to
hubp401_cursor_set_position into viewport space to program this
register. This fixes an underflow issue that occurs in scaled
mode with low refresh rate.

Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index a893160ae775..3f9ca9b40949 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -656,7 +656,9 @@ void hubp401_cursor_set_position(
 	int y_pos = pos->y - param->recout.y;
 	int rec_x_offset = x_pos - pos->x_hotspot;
 	int rec_y_offset = y_pos - pos->y_hotspot;
-	uint32_t dst_x_offset;
+	int dst_x_offset;
+	int x_pos_viewport = x_pos * param->viewport.width / param->recout.width;
+	int x_hot_viewport = pos->x_hotspot * param->viewport.width / param->recout.width;
 	uint32_t cur_en = pos->enable ? 1 : 0;
 
 	hubp->curs_pos = *pos;
@@ -668,7 +670,13 @@ void hubp401_cursor_set_position(
 	if (hubp->curs_attr.address.quad_part == 0)
 		return;
 
-	dst_x_offset = (rec_x_offset >= 0) ? rec_x_offset : 0;
+	/* Translate the x position of the cursor from rect
+	 * space into viewport space. CURSOR_DST_X_OFFSET
+	 * is the offset relative to viewport start position.
+	 */
+	dst_x_offset = x_pos_viewport - x_hot_viewport *
+			(1 + hubp->curs_attr.attribute_flags.bits.ENABLE_MAGNIFICATION);
+	dst_x_offset = (dst_x_offset >= 0) ? dst_x_offset : 0;
 	dst_x_offset *= param->ref_clk_khz;
 	dst_x_offset /= param->pixel_clk_khz;
 


