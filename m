Return-Path: <stable+bounces-16160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 041A983F17B
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32AA01C20E40
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690CF200BC;
	Sat, 27 Jan 2024 23:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fvm2Ivmb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4A21F946
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706396938; cv=none; b=KKFpHcM9fAD/ljQYsoTbuVoestPK8YHMgOvlpdLuF4keh3j+/TC41JeIbFUdkymmCxkCKBVrwLyala6mZc3OhbG0zSLZOaduJboS75tUtdWw6GFzCL2Dzk1L7z6RoxaL3CIb8iW1lX7Wl1kffAVp2ZsGeD1KZo+pXnPB+CTw7gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706396938; c=relaxed/simple;
	bh=X6dVyACV82A6CMsNSfWGtbIbztpZqg9PIb8O8D7kYs4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TB4GD+XGGZpctx47QXeW2y+xcED5RBwM7B5cSexO+5wyEPDLEaiKgcSXudYtjH/0cZ5X+Se97bf3NUj1k8XNoCtoqHAvBZkvVn9wCcwGjUejdtK4IyPeMOhUB+K9Qsk088o5iOvJdO844SoyUW7X7qzO2ZHQDcQZ/C7PcrgSKvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fvm2Ivmb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8EBC433C7;
	Sat, 27 Jan 2024 23:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706396937;
	bh=X6dVyACV82A6CMsNSfWGtbIbztpZqg9PIb8O8D7kYs4=;
	h=Subject:To:Cc:From:Date:From;
	b=Fvm2IvmbYnBMr5EhnuPo1Kip2wV2+XKcQ2JlHgjGSgpuiamP7qeNgq/SGUllQlEAh
	 QdtHl8qNid210XpzZw3MYs4EttEHSyGbzE7aOJURihESjeES9AtCm88gksED2Y6NyE
	 p24vS3xCKFnAaQ/Xk6TqshiwT0VaCbhatugUzuXU=
Subject: FAILED: patch "[PATCH] drm/amdgpu/sdma5.2: add begin/end_use ring callbacks" failed to apply to 6.1-stable tree
To: alexander.deucher@amd.com,christian.koenig@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:08:56 -0800
Message-ID: <2024012756-effort-smelting-a27a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 94b1e028e15c94362420f9f3f711fafbf9d52996
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012756-effort-smelting-a27a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


