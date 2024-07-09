Return-Path: <stable+bounces-58487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DCB92B74B
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900A7282438
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8B01586C7;
	Tue,  9 Jul 2024 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v0FxJYhx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDCF15821A;
	Tue,  9 Jul 2024 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524089; cv=none; b=Ve/CQMUtgOOyyr8CbgLngY1cU1GuhRkQfTkUOSuxydsxuI6OmBlpcAkq8i/UpeHT7ThPmHwHZRfvrVv4Z/m9aTZ4TsXHky9iM8fi5rtHRhzglUgHT0XY6Z7hF7QIy3DBuohs2+RnQqh0hYNyKfcWoKqtGKMUaHi9VCInXKBLCn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524089; c=relaxed/simple;
	bh=p4Y7Ifqy6cG+LtPrJdPMgq+RdFQlkfmXwWmNgsV/D5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQ8YoULrvajmSJcC8nBd8EZQRE+msESKkfLyQjkeJmR2jgjPVxIc3H5gZfDZhDxR4FS+WOFOqvudJq3UPUhqM2bQYHYtIizGmPCBIl9eoM45k87bnxRVIfQRAEX2J64qwVN8Vr1feT65Ic6MD6vEZMvWd9+SIPZLQ/Jczc3zki4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v0FxJYhx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5739FC32786;
	Tue,  9 Jul 2024 11:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720524089;
	bh=p4Y7Ifqy6cG+LtPrJdPMgq+RdFQlkfmXwWmNgsV/D5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v0FxJYhxWV17nAmjeEtR+ZXi7oaq7p6N3HA28geF3r0DYCGaUs5zXcCrWcxusFh/4
	 d+1d3budsOcdBJMOQW9h0tHDuVGd0wqRjS/1VSEPrinXQCtzP11lHch69czYApCmyR
	 gClvtpIrqdz24N3cBSHD+Vil0+tZwbxrcp1BfRpo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 035/197] drm/amd/display: ASSERT when failing to find index by plane/stream id
Date: Tue,  9 Jul 2024 13:08:09 +0200
Message-ID: <20240709110710.278617366@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110708.903245467@linuxfoundation.org>
References: <20240709110708.903245467@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 01eb50e53c1ce505bf449348d433181310288765 ]

[WHY]
find_disp_cfg_idx_by_plane_id and find_disp_cfg_idx_by_stream_id returns
an array index and they return -1 when not found; however, -1 is not a
valid index number.

[HOW]
When this happens, call ASSERT(), and return a positive number (which is
fewer than callers' array size) instead.

This fixes 4 OVERRUN and 2 NEGATIVE_RETURNS issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index a52c594e1ba4b..e1f1b5dd13203 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -88,7 +88,8 @@ static int find_disp_cfg_idx_by_plane_id(struct dml2_dml_to_dc_pipe_mapping *map
 			return  i;
 	}
 
-	return -1;
+	ASSERT(false);
+	return __DML2_WRAPPER_MAX_STREAMS_PLANES__;
 }
 
 static int find_disp_cfg_idx_by_stream_id(struct dml2_dml_to_dc_pipe_mapping *mapping, unsigned int stream_id)
@@ -100,7 +101,8 @@ static int find_disp_cfg_idx_by_stream_id(struct dml2_dml_to_dc_pipe_mapping *ma
 			return  i;
 	}
 
-	return -1;
+	ASSERT(false);
+	return __DML2_WRAPPER_MAX_STREAMS_PLANES__;
 }
 
 // The master pipe of a stream is defined as the top pipe in odm slice 0
-- 
2.43.0




