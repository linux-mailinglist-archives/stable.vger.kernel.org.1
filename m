Return-Path: <stable+bounces-67085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3085C94F3D4
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD1EEB21BDB
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2512B186E38;
	Mon, 12 Aug 2024 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xcOhW3Kh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CDA183CA6;
	Mon, 12 Aug 2024 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723479757; cv=none; b=rWm3XEJl3Z+pZEnehkneXtb78PXvi++mzKm35O0b7PcMGn3Ubvwz6d/WlJzVtRT7I0BIrlStIUtgaJjE6WzCFEpdWLEFv7uUFmng2vx7ED1d9Lmcu9nt4H20IvonA2H1yhffnWsmrFxdx591EUa4JFbP/iA96h64dI/9Bl5gi5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723479757; c=relaxed/simple;
	bh=O4UK4my+hVYpLhhdod3inT0Ofsa6FImipTLkRRjOimg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cF/9HuZvIpv/1hcyCXrA+AYI4B3UgxD5u6+jSscNgYQJz99aBDPDZgqJKfxeXXxwJQ/5/44AS8B/rYLSG7bijn5bIxx4w0gpKWBPFLXlQGQXXOy+wH+O3MaKEfKnZcMu/aH2ACCVDLDQqkfMyiB8lYP+sqou4Tsew1tm0qMG2+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xcOhW3Kh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4357DC32782;
	Mon, 12 Aug 2024 16:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723479757;
	bh=O4UK4my+hVYpLhhdod3inT0Ofsa6FImipTLkRRjOimg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xcOhW3KhHJ7W5OfUzC0QKhGXQRX8DV5vnUegjNh8H0PAXThbOor9VC7NmDRHQdwGc
	 I4AQyZdUzb1WOk64iQnYUKH47hPRVluHMkM056c/H9UWV1dTwkFtX65kBE3BBQcpXp
	 CgAiHx3ihPi44DVoXHVqZb8/RbPcmMOMd7ifSt5U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Hersen Wu <hersenxs.wu@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 6.6 182/189] drm/amd/display: Defer handling mst up request in resume
Date: Mon, 12 Aug 2024 18:03:58 +0200
Message-ID: <20240812160139.155029293@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160132.135168257@linuxfoundation.org>
References: <20240812160132.135168257@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wayne Lin <wayne.lin@amd.com>

commit 202dc359addab29451d3d18243c3d957da5392c8 upstream.

[Why]
Like commit ec5fa9fcdeca ("drm/amd/display: Adjust the MST resume flow"), we
want to avoid handling mst topology changes before restoring the old state.
If we enable DP_UP_REQ_EN before calling drm_atomic_helper_resume(), have
changce to handle CSN event first and fire hotplug event before restoring the
cached state.

[How]
Disable mst branch sending up request event before we restoring the cached state.
DP_UP_REQ_EN will be set later when we call drm_dp_mst_topology_mgr_resume().

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2350,7 +2350,6 @@ static void resume_mst_branch_status(str
 
 	ret = drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
 				 DP_MST_EN |
-				 DP_UP_REQ_EN |
 				 DP_UPSTREAM_IS_SRC);
 	if (ret < 0) {
 		drm_dbg_kms(mgr->dev, "mst write failed - undocked during suspend?\n");



