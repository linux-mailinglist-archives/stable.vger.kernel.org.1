Return-Path: <stable+bounces-189811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D2FC0AA59
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 15:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 977C74E1C55
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 14:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D43C1A9F92;
	Sun, 26 Oct 2025 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lQlgNXJS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E175C96
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761489335; cv=none; b=kvCynckkCMV6I2rfBsGv0XmoQjPapzOe1LaCQcO8b3TIWLzyYk9w3nuwq/qDngqKl97Y2eyjt79Mxf7s/wepHrGu2yLkSs9UNfPSjcO8RtBE/xVwJif9Mb1TyQo6PG05b8qWqYJ0UnjeEcaS6jSngOliuTLyft0B4jmqq+Q3BPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761489335; c=relaxed/simple;
	bh=w6I4ZnobLqlEaYeWmNbSUSDagA8x37h6KrXMPL/prws=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dggLl7a2RBvKwSKzUEP3BcmqhthfPMxpzwhyN9KU0WZiNRybCQPMQU/r7HNHDs8qyYKJfaY3CpnVYTOALCJcTSotTZGJhf6Ps+Rif47cXvYh1NezGbXI/JjPGeY23Up3XAFGmzxcQOS/mCc8y0xTGp7EajXO+8ScR9vnL9IIzho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lQlgNXJS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41365C4CEE7;
	Sun, 26 Oct 2025 14:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761489335;
	bh=w6I4ZnobLqlEaYeWmNbSUSDagA8x37h6KrXMPL/prws=;
	h=Subject:To:Cc:From:Date:From;
	b=lQlgNXJSk7hAJpZ+mv3mA5k3/ZUhCAHvCZABDRJAtSMeEED286nhVL9BTIZgw9SUC
	 U9UVyZLJ5dIk4vBVPeVWnNTWJjC4dUvAaMv1RnqtU/0dJgZGc3TIViV5JWbiDI+VYh
	 ptjj8OYrIJbMBCGfUL0aiKCsR+z/P5KsgHeqmeD4=
Subject: FAILED: patch "[PATCH] drm/amd/display: use GFP_NOWAIT for allocation in interrupt" failed to apply to 6.17-stable tree
To: aurabindo.pillai@amd.com,alexander.deucher@amd.com,mario.limonciello@amd.com,sunpeng.li@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 26 Oct 2025 15:35:33 +0100
Message-ID: <2025102633-shimmy-ferocity-c891@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.17-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.17.y
git checkout FETCH_HEAD
git cherry-pick -x 72a1eb3cf573ab957ae412f0efb0cf6ff0876234
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102633-shimmy-ferocity-c891@gregkh' --subject-prefix 'PATCH 6.17.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 72a1eb3cf573ab957ae412f0efb0cf6ff0876234 Mon Sep 17 00:00:00 2001
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Date: Thu, 25 Sep 2025 10:23:59 -0400
Subject: [PATCH] drm/amd/display: use GFP_NOWAIT for allocation in interrupt
 handler

schedule_dc_vmin_vmax() is called by dm_crtc_high_irq(). Hence, we
cannot have the former sleep. Use GFP_NOWAIT for allocation in this
function.

Fixes: c210b757b400 ("drm/amd/display: fix dmub access race condition")
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit c04812cbe2f247a1c1e53a9b6c5e659963fe4065)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6597475e245d..bfa3199591b6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -551,13 +551,13 @@ static void schedule_dc_vmin_vmax(struct amdgpu_device *adev,
 	struct dc_stream_state *stream,
 	struct dc_crtc_timing_adjust *adjust)
 {
-	struct vupdate_offload_work *offload_work = kzalloc(sizeof(*offload_work), GFP_KERNEL);
+	struct vupdate_offload_work *offload_work = kzalloc(sizeof(*offload_work), GFP_NOWAIT);
 	if (!offload_work) {
 		drm_dbg_driver(adev_to_drm(adev), "Failed to allocate vupdate_offload_work\n");
 		return;
 	}
 
-	struct dc_crtc_timing_adjust *adjust_copy = kzalloc(sizeof(*adjust_copy), GFP_KERNEL);
+	struct dc_crtc_timing_adjust *adjust_copy = kzalloc(sizeof(*adjust_copy), GFP_NOWAIT);
 	if (!adjust_copy) {
 		drm_dbg_driver(adev_to_drm(adev), "Failed to allocate adjust_copy\n");
 		kfree(offload_work);


