Return-Path: <stable+bounces-143588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D27AB4092
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61DA68C2D93
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 17:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE457293B6B;
	Mon, 12 May 2025 17:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f/S8/fj/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C22254863;
	Mon, 12 May 2025 17:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072437; cv=none; b=jQcU96mR4Tl+OPN4NVEF43XP3nhbccgP/v4izeACz6Z+trV+KbPtTDWQC2T7FK6C9xwR/WETsWjyY1ovEedpe1RtT6BTHwcj8Gve7nJoLG4uDjGEDizWqsNnF5NC7D3TTF+C8gSY50N+LijIlmaOMFRE8/plHMpSh/drkHbKd0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072437; c=relaxed/simple;
	bh=Kih3zhLz7H6bXICcQHz0aIRhxpmTkVtxOAvh3/yTDIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgmEROAOULo7SVfpwybnB9o1O2BuPrUim0mK5PE2BXzQqLkSi1fKd5fsTEpnrCbMBxHp2PFsprJnpkrehSVcyqm7S9jVRowD/8POQQLt/mLtfrVQ7nLmlTbfyAbR5LnJQ8NIURgkEBly5uAw1b263xr/SCdRuDVkhxN4xy3F6yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f/S8/fj/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120EBC4CEE7;
	Mon, 12 May 2025 17:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747072437;
	bh=Kih3zhLz7H6bXICcQHz0aIRhxpmTkVtxOAvh3/yTDIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f/S8/fj/LWNkOcg9ClCLkWOfpf5TOG+3mi7o87zVcWJwCLoNc998vO4bOlyNbEDri
	 SKfjVlu9Lq+Cv/sKSaU0S1+5HLjiYsk1vUnYwpRCG4ATNqTfGAsOBv+1VyR27dOF0i
	 nbQt1w/aHa+xlq9U9ZrSOgmgjGCuj4nlS7Oq7WjA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Ray Wu <ray.wu@amd.com>,
	Wayne Lin <Wayne.Lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 6.1 41/92] drm/amd/display: Fix wrong handling for AUX_DEFER case
Date: Mon, 12 May 2025 19:45:16 +0200
Message-ID: <20250512172024.793675089@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172023.126467649@linuxfoundation.org>
References: <20250512172023.126467649@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wayne Lin <Wayne.Lin@amd.com>

commit 65924ec69b29296845c7f628112353438e63ea56 upstream.

[Why]
We incorrectly ack all bytes get written when the reply actually is defer.
When it's defer, means sink is not ready for the request. We should
retry the request.

[How]
Only reply all data get written when receive I2C_ACK|AUX_ACK. Otherwise,
reply the number of actual written bytes received from the sink.
Add some messages to facilitate debugging as well.

Fixes: ad6756b4d773 ("drm/amd/display: Shift dc link aux to aux_payload")
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 3637e457eb0000bc37d8bbbec95964aad2fb29fd)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c |   28 ++++++++++--
 1 file changed, 24 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -55,6 +55,9 @@ bool is_timing_changed(struct dc_stream_
 		       struct dc_stream_state *new_stream);
 
 
+/*
+ * This function handles both native AUX and I2C-Over-AUX transactions.
+ */
 static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 				  struct drm_dp_aux_msg *msg)
 {
@@ -91,15 +94,25 @@ static ssize_t dm_dp_aux_transfer(struct
 	if (adev->dm.aux_hpd_discon_quirk) {
 		if (msg->address == DP_SIDEBAND_MSG_DOWN_REQ_BASE &&
 			operation_result == AUX_RET_ERROR_HPD_DISCON) {
-			result = 0;
+			result = msg->size;
 			operation_result = AUX_RET_SUCCESS;
 		}
 	}
 
-	if (payload.write && result >= 0)
-		result = msg->size;
+	/*
+	 * result equals to 0 includes the cases of AUX_DEFER/I2C_DEFER
+	 */
+	if (payload.write && result >= 0) {
+		if (result) {
+			/*one byte indicating partially written bytes. Force 0 to retry*/
+			drm_info(adev_to_drm(adev), "amdgpu: AUX partially written\n");
+			result = 0;
+		} else if (!payload.reply[0])
+			/*I2C_ACK|AUX_ACK*/
+			result = msg->size;
+	}
 
-	if (result < 0)
+	if (result < 0) {
 		switch (operation_result) {
 		case AUX_RET_SUCCESS:
 			break;
@@ -118,6 +131,13 @@ static ssize_t dm_dp_aux_transfer(struct
 			break;
 		}
 
+		drm_info(adev_to_drm(adev), "amdgpu: DP AUX transfer fail:%d\n", operation_result);
+	}
+
+	if (payload.reply[0])
+		drm_info(adev_to_drm(adev), "amdgpu: AUX reply command not ACK: 0x%02x.",
+			payload.reply[0]);
+
 	return result;
 }
 



