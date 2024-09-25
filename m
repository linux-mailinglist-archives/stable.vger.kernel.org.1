Return-Path: <stable+bounces-77641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C081D985F6B
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C73E28A5B1
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9475A18FDC9;
	Wed, 25 Sep 2024 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0DsF3jh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4356318FDC5;
	Wed, 25 Sep 2024 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266557; cv=none; b=QOpZX77ot+1UdaXUM0YK01hliuFbTUNEEPyux6QWyLrCbRB8Y2xhUDlWupVEy2wMPNzNY19PTBJx4FXXiycic5x/pPVO+6OkWGMWZMfIYEx+ah7vROfZQa1cNnwoXrA9PBpO6io+bhtvxwEsVjA8+qeUrtjjX0Nx+0ZWx+GlAIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266557; c=relaxed/simple;
	bh=ePsu3+jRcuhuaf2No/fiYjynmBLhiI2hseUO1XFg+9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHXVySUkd6vfozxAkMh1xEBCnD9un8+1rgB7lOUfAH9E4Bvbll+E6wHJ5SRO17fsgML4mmldaDb40+i1KqX8nx++VhAYBzBW/YiqcYPOtBegE1SkclMuj07KQ9H9BzwrO4U3h7/Qz1pujxWkRH9C/cNkoCEsS56Tqo2Y6KriaP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0DsF3jh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85704C4CEC7;
	Wed, 25 Sep 2024 12:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266557;
	bh=ePsu3+jRcuhuaf2No/fiYjynmBLhiI2hseUO1XFg+9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X0DsF3jhbaEgE3Cu9AVno6xjAzvz4JD1I3Te5H5vD3S9qsxMVMwjbo/pgPfnhKAfY
	 u60hnRlqBjkeexrjo3viKcblWHzUAjaFLxkog2ZtzkLLlCQKDJtgZhfcJ5FK8BTBE5
	 glkCnPSzMrhQjv3o2Qy0OxfAcD/KKeYqRLq+fduVUK0agnzx/vPkQlSnfOYMXBgtQ+
	 kd0Su8+18Nxf8zcAgRdtF+EGkmOBeTcAbYoopr5s7E5xqc4922xEOrer684h+EmsMj
	 Wu2BZ24Et3tc+IaAsqxNAAt+DqyQRG5FXVrZ59ID6U89xQueihSFETc690eMD/aEoO
	 JtMugDfKT3CPQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tim Huang <tim.huang@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Roman Li <roman.li@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	lewis.huang@amd.com,
	hamza.mahfooz@amd.com,
	alex.hung@amd.com,
	chiahsuan.chung@amd.com,
	srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 094/139] drm/amd/display: fix double free issue during amdgpu module unload
Date: Wed, 25 Sep 2024 08:08:34 -0400
Message-ID: <20240925121137.1307574-94-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Tim Huang <tim.huang@amd.com>

[ Upstream commit 20b5a8f9f4670a8503aa9fa95ca632e77c6bf55d ]

Flexible endpoints use DIGs from available inflexible endpoints,
so only the encoders of inflexible links need to be freed.
Otherwise, a double free issue may occur when unloading the
amdgpu module.

[  279.190523] RIP: 0010:__slab_free+0x152/0x2f0
[  279.190577] Call Trace:
[  279.190580]  <TASK>
[  279.190582]  ? show_regs+0x69/0x80
[  279.190590]  ? die+0x3b/0x90
[  279.190595]  ? do_trap+0xc8/0xe0
[  279.190601]  ? do_error_trap+0x73/0xa0
[  279.190605]  ? __slab_free+0x152/0x2f0
[  279.190609]  ? exc_invalid_op+0x56/0x70
[  279.190616]  ? __slab_free+0x152/0x2f0
[  279.190642]  ? asm_exc_invalid_op+0x1f/0x30
[  279.190648]  ? dcn10_link_encoder_destroy+0x19/0x30 [amdgpu]
[  279.191096]  ? __slab_free+0x152/0x2f0
[  279.191102]  ? dcn10_link_encoder_destroy+0x19/0x30 [amdgpu]
[  279.191469]  kfree+0x260/0x2b0
[  279.191474]  dcn10_link_encoder_destroy+0x19/0x30 [amdgpu]
[  279.191821]  link_destroy+0xd7/0x130 [amdgpu]
[  279.192248]  dc_destruct+0x90/0x270 [amdgpu]
[  279.192666]  dc_destroy+0x19/0x40 [amdgpu]
[  279.193020]  amdgpu_dm_fini+0x16e/0x200 [amdgpu]
[  279.193432]  dm_hw_fini+0x26/0x40 [amdgpu]
[  279.193795]  amdgpu_device_fini_hw+0x24c/0x400 [amdgpu]
[  279.194108]  amdgpu_driver_unload_kms+0x4f/0x70 [amdgpu]
[  279.194436]  amdgpu_pci_remove+0x40/0x80 [amdgpu]
[  279.194632]  pci_device_remove+0x3a/0xa0
[  279.194638]  device_remove+0x40/0x70
[  279.194642]  device_release_driver_internal+0x1ad/0x210
[  279.194647]  driver_detach+0x4e/0xa0
[  279.194650]  bus_remove_driver+0x6f/0xf0
[  279.194653]  driver_unregister+0x33/0x60
[  279.194657]  pci_unregister_driver+0x44/0x90
[  279.194662]  amdgpu_exit+0x19/0x1f0 [amdgpu]
[  279.194939]  __do_sys_delete_module.isra.0+0x198/0x2f0
[  279.194946]  __x64_sys_delete_module+0x16/0x20
[  279.194950]  do_syscall_64+0x58/0x120
[  279.194954]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[  279.194980]  </TASK>

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Tim Huang <tim.huang@amd.com>
Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/link/link_factory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 33bb96f770b86..eb7c9f226af5c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -403,7 +403,7 @@ static void link_destruct(struct dc_link *link)
 	if (link->panel_cntl)
 		link->panel_cntl->funcs->destroy(&link->panel_cntl);
 
-	if (link->link_enc) {
+	if (link->link_enc && !link->is_dig_mapping_flexible) {
 		/* Update link encoder resource tracking variables. These are used for
 		 * the dynamic assignment of link encoders to streams. Virtual links
 		 * are not assigned encoder resources on creation.
-- 
2.43.0


