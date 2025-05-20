Return-Path: <stable+bounces-145191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7A8ABDA79
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64401899CA1
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132AA245033;
	Tue, 20 May 2025 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a0dIDDMU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3153245038;
	Tue, 20 May 2025 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749431; cv=none; b=jCwmAl9VJW/FAZAsikMqLG+SE0dY8KN7dRdJZt8OpAWxZflHdkATVh18G7e8SXR5HAhXbuF5PROZ4j/1zmvSEKkM2Rp6BotfmGyID+YPKTQBhweKDE/dEQrEQUciz9xQfQPouG0NFcO3zhKDIAwqtZpxYMeEK5EXv6lS7DBvB28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749431; c=relaxed/simple;
	bh=/7+XQmqhthzb/8ge/MT1cTvLjoWuviMZ99i3vGrLkOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GaeGLKuTOEk1RzzPQv3i8tU4Tz8yJju23t5+9jlnX1EPAsUtDlV0F1Mo2oc3AJT9YoOcHrPgXHoFaQ4WD2QAgN43lFbkznme1edkyazvh7/vfmXRCA9yCw0TIxK9fBicbOyl/G/rEmSSj9RD9Zkuj3dNfXs/4rk5vZxZGGIYXzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a0dIDDMU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A7DC4CEE9;
	Tue, 20 May 2025 13:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747749431;
	bh=/7+XQmqhthzb/8ge/MT1cTvLjoWuviMZ99i3vGrLkOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a0dIDDMU9dx5EWPG1DXTbMLT9hnYFuxG3YK79DR3AUaqI9SEbw9ylcPREym23nvIA
	 J+ci2T8T9RTiq95zjpLmVSQ5fbFmWscXBFYBEX/gfFKJGgvs+tYrNOae34FI68mcAq
	 MBxfCVSku6csg0xZmSc6LzH0fvLn2ASyTn5BG1lY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Ray Wu <ray.wu@amd.com>,
	Wayne Lin <Wayne.Lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 6.1 43/97] drm/amd/display: Correct the reply value when AUX write incomplete
Date: Tue, 20 May 2025 15:50:08 +0200
Message-ID: <20250520125802.347756665@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125800.653047540@linuxfoundation.org>
References: <20250520125800.653047540@linuxfoundation.org>
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

commit d433981385c62c72080e26f1c00a961d18b233be upstream.

[Why]
Now forcing aux->transfer to return 0 when incomplete AUX write is
inappropriate. It should return bytes have been transferred.

[How]
aux->transfer is asked not to change original msg except reply field of
drm_dp_aux_msg structure. Copy the msg->buffer when it's write request,
and overwrite the first byte when sink reply 1 byte indicating partially
written byte number. Then we can return the correct value without
changing the original msg.

Fixes: 3637e457eb00 ("drm/amd/display: Fix wrong handling for AUX_DEFER case")
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 7ac37f0dcd2e0b729fa7b5513908dc8ab802b540)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           |    3 ++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c |   10 ++++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10707,7 +10707,8 @@ int amdgpu_dm_process_dmub_aux_transfer_
 		/* The reply is stored in the top nibble of the command. */
 		payload->reply[0] = (adev->dm.dmub_notify->aux_reply.command >> 4) & 0xF;
 
-	if (!payload->write && p_notify->aux_reply.length)
+	/*write req may receive a byte indicating partially written number as well*/
+	if (p_notify->aux_reply.length)
 		memcpy(payload->data, p_notify->aux_reply.data,
 				p_notify->aux_reply.length);
 
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -66,6 +66,7 @@ static ssize_t dm_dp_aux_transfer(struct
 	enum aux_return_code_type operation_result;
 	struct amdgpu_device *adev;
 	struct ddc_service *ddc;
+	uint8_t copy[16];
 
 	if (WARN_ON(msg->size > 16))
 		return -E2BIG;
@@ -81,6 +82,11 @@ static ssize_t dm_dp_aux_transfer(struct
 			(msg->request & DP_AUX_I2C_WRITE_STATUS_UPDATE) != 0;
 	payload.defer_delay = 0;
 
+	if (payload.write) {
+		memcpy(copy, msg->buffer, msg->size);
+		payload.data = copy;
+	}
+
 	result = dc_link_aux_transfer_raw(TO_DM_AUX(aux)->ddc_service, &payload,
 				      &operation_result);
 
@@ -104,9 +110,9 @@ static ssize_t dm_dp_aux_transfer(struct
 	 */
 	if (payload.write && result >= 0) {
 		if (result) {
-			/*one byte indicating partially written bytes. Force 0 to retry*/
+			/*one byte indicating partially written bytes*/
 			drm_info(adev_to_drm(adev), "amdgpu: AUX partially written\n");
-			result = 0;
+			result = payload.data[0];
 		} else if (!payload.reply[0])
 			/*I2C_ACK|AUX_ACK*/
 			result = msg->size;



