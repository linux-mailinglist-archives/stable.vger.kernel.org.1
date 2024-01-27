Return-Path: <stable+bounces-16159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2654283F17A
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBA411F21B54
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7820200AC;
	Sat, 27 Jan 2024 23:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xl3c43q6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812D81F946
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706396936; cv=none; b=NDwFgi2pKc8Mqjb7cjcgDBDwi0Iztd/q0SXY9nBmDQh9ohHTFustZLEvjNyDl5M0HVn787aH53YvCDMwNm3PRW4tOHJ3uqW/LA8gasSUxLEglA2n/rFj0edTJnu6d8L5vxK1Q/tvsvZ3wCuEQOCsKpV4Ooaho0RqQfF8X7x7gCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706396936; c=relaxed/simple;
	bh=CXIbb04yIerw94vAJbgUK24+w2Le5MQVz3ht6X1VOT4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=N1GxZJJaY5E/s2bzb6TWc+nwbV/0rpVT1TpjNXuUu5qcoDmwqYyB4aD7a7W4U22rg9aJqgLNu6f7XixrbagnzUvjOag1tNqJylb+1WTTPqY4dedndoNZknh4liCj+GLnCH7+9j05m6zNUR6Ohut/GgAQeLhWyDg2kWuO7wMoFm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xl3c43q6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C60C43390;
	Sat, 27 Jan 2024 23:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706396935;
	bh=CXIbb04yIerw94vAJbgUK24+w2Le5MQVz3ht6X1VOT4=;
	h=Subject:To:Cc:From:Date:From;
	b=xl3c43q6X5QxucGavbZX5gq7h5mzWZ95YE6pt/A3TtYwMnoneasFk1Gsf8paceCSl
	 f++nCbSFKQ2X0PaJMDiz4Ex3MNaRFk/wcQYNGUiMRkVCacrcpwWFwnhnBO5+ZaY1tV
	 pmkSkJ1oo+5Vu2ZWiO+skb/TlhECjz0RomMklQ8s=
Subject: FAILED: patch "[PATCH] drm/amdgpu/sdma5.2: add begin/end_use ring callbacks" failed to apply to 6.6-stable tree
To: alexander.deucher@amd.com,christian.koenig@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:08:55 -0800
Message-ID: <2024012754-roping-hug-8954@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 94b1e028e15c94362420f9f3f711fafbf9d52996
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012754-roping-hug-8954@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

94b1e028e15c ("drm/amdgpu/sdma5.2: add begin/end_use ring callbacks")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 94b1e028e15c94362420f9f3f711fafbf9d52996 Mon Sep 17 00:00:00 2001
From: Alex Deucher <alexander.deucher@amd.com>
Date: Thu, 7 Dec 2023 10:14:41 -0500
Subject: [PATCH] drm/amdgpu/sdma5.2: add begin/end_use ring callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add begin/end_use ring callbacks to disallow GFXOFF when
SDMA work is submitted and allow it again afterward.

This should avoid corner cases where GFXOFF is erroneously
entered when SDMA is still active.  For now just allow/disallow
GFXOFF in the begin and end helpers until we root cause the
issue.  This should not impact power as SDMA usage is pretty
minimal and GFXOSS should not be active when SDMA is active
anyway, this just makes it explicit.

v2: move everything into sdma5.2 code.  No reason for this
to be generic at this point.
v3: Add comments in new code

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2220
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com> (v1)
Tested-by: Mario Limonciello <mario.limonciello@amd.com> (v1)
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 5.15+

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 83c240f741b5..0058f3f7cf6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1643,6 +1643,32 @@ static void sdma_v5_2_get_clockgating_state(void *handle, u64 *flags)
 		*flags |= AMD_CG_SUPPORT_SDMA_LS;
 }
 
+static void sdma_v5_2_ring_begin_use(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	/* SDMA 5.2.3 (RMB) FW doesn't seem to properly
+	 * disallow GFXOFF in some cases leading to
+	 * hangs in SDMA.  Disallow GFXOFF while SDMA is active.
+	 * We can probably just limit this to 5.2.3,
+	 * but it shouldn't hurt for other parts since
+	 * this GFXOFF will be disallowed anyway when SDMA is
+	 * active, this just makes it explicit.
+	 */
+	amdgpu_gfx_off_ctrl(adev, false);
+}
+
+static void sdma_v5_2_ring_end_use(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	/* SDMA 5.2.3 (RMB) FW doesn't seem to properly
+	 * disallow GFXOFF in some cases leading to
+	 * hangs in SDMA.  Allow GFXOFF when SDMA is complete.
+	 */
+	amdgpu_gfx_off_ctrl(adev, true);
+}
+
 const struct amd_ip_funcs sdma_v5_2_ip_funcs = {
 	.name = "sdma_v5_2",
 	.early_init = sdma_v5_2_early_init,
@@ -1690,6 +1716,8 @@ static const struct amdgpu_ring_funcs sdma_v5_2_ring_funcs = {
 	.test_ib = sdma_v5_2_ring_test_ib,
 	.insert_nop = sdma_v5_2_ring_insert_nop,
 	.pad_ib = sdma_v5_2_ring_pad_ib,
+	.begin_use = sdma_v5_2_ring_begin_use,
+	.end_use = sdma_v5_2_ring_end_use,
 	.emit_wreg = sdma_v5_2_ring_emit_wreg,
 	.emit_reg_wait = sdma_v5_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = sdma_v5_2_ring_emit_reg_write_reg_wait,


