Return-Path: <stable+bounces-171813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1C0B2C845
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 17:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA0C1BA74D1
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 15:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6874D283FF5;
	Tue, 19 Aug 2025 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WC0PssGk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277212737E8
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755616580; cv=none; b=UTF0ZUWHMo4nGSXni0uTmVift7GTRoYKsWFyb8gVFV3x/+3aIGQjo2dSxhva5vcDUX8uhs/9fovKea1lpMzviGiwaYT9XV4HVBI9SMnNDkwr5PZ464Z4FlIVKAAziSDh8nncYLJ7U2gb4bAVDS2Q71LGGTr7SeVlhatEe49oq7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755616580; c=relaxed/simple;
	bh=BtktKvpByo5Zarkgv6+dQChYK4d1v1Rcm4lt0KhxFL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1dLL/6iXBrYm4+3g5g+WhMaG3wryxKSMcPhkeAvZYs4rBCQSgNn0Ht2o2NgsB7fpqfXfnDAkrcgzh7S97Nx9J/qzjh/aq4CpcTSHA5sj0wYbqWUSoAcTmsW/pmdXs1B0I2Ob1ws0+gbjUIw1OIDUtx6OBYK65eLKKCHgxbhu6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WC0PssGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3628C116B1;
	Tue, 19 Aug 2025 15:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755616579;
	bh=BtktKvpByo5Zarkgv6+dQChYK4d1v1Rcm4lt0KhxFL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WC0PssGkaTx2G3NShdUWWXp0UA5t+J7lSsLKrSUzzzGegeVxtrOhOs41xEq2wmTf1
	 cvdSGpyT0M2o7mfZofoVsInjuGIhRQ8vvfbVab2B4cy2nMPGj79j4gfTTBi9B0Wfjb
	 I0h/nXnnG2Z+9lr0u/fjFEJ1yB4UwUVkRuUtpa5n01YEcw4jFmJpEYiz+FGMRgGd11
	 nRnn83x1uGON9R3ZW1yd74aB16RIaJd4kOGatH9A3Bnv0M76WLCw+gN/4SWgwz3Cqn
	 FqjJzRmmkflzSuoqJm2l05d5yda6raHDHYT82c001CRA2q4Rb3y0oeVU+S3SQOmXzU
	 p6DpMA4Emry4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vedang Nagar <quic_vnagar@quicinc.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] media: venus: Fix OOB read due to missing payload bound check
Date: Tue, 19 Aug 2025 11:16:16 -0400
Message-ID: <20250819151616.535142-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819151616.535142-1-sashal@kernel.org>
References: <2025081854-pauper-opacity-6318@gregkh>
 <20250819151616.535142-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vedang Nagar <quic_vnagar@quicinc.com>

[ Upstream commit 06d6770ff0d8cc8dfd392329a8cc03e2a83e7289 ]

Currently, The event_seq_changed() handler processes a variable number
of properties sent by the firmware. The number of properties is indicated
by the firmware and used to iterate over the payload. However, the
payload size is not being validated against the actual message length.

This can lead to out-of-bounds memory access if the firmware provides a
property count that exceeds the data available in the payload. Such a
condition can result in kernel crashes or potential information leaks if
memory beyond the buffer is accessed.

Fix this by properly validating the remaining size of the payload before
each property access and updating bounds accordingly as properties are
parsed.

This ensures that property parsing is safely bounded within the received
message buffer and protects against malformed or malicious firmware
behavior.

Fixes: 09c2845e8fe4 ("[media] media: venus: hfi: add Host Firmware Interface (HFI)")
Cc: stable@vger.kernel.org
Signed-off-by: Vedang Nagar <quic_vnagar@quicinc.com>
Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Co-developed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/venus/hfi_msgs.c | 83 ++++++++++++++------
 1 file changed, 58 insertions(+), 25 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
index c11bf20daace..4f522d3a74dc 100644
--- a/drivers/media/platform/qcom/venus/hfi_msgs.c
+++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
@@ -33,8 +33,9 @@ static void event_seq_changed(struct venus_core *core, struct venus_inst *inst,
 	struct hfi_buffer_requirements *bufreq;
 	struct hfi_extradata_input_crop *crop;
 	struct hfi_dpb_counts *dpb_count;
+	u32 ptype, rem_bytes;
+	u32 size_read = 0;
 	u8 *data_ptr;
-	u32 ptype;
 
 	inst->error = HFI_ERR_NONE;
 
@@ -44,86 +45,118 @@ static void event_seq_changed(struct venus_core *core, struct venus_inst *inst,
 		break;
 	default:
 		inst->error = HFI_ERR_SESSION_INVALID_PARAMETER;
-		goto done;
+		inst->ops->event_notify(inst, EVT_SYS_EVENT_CHANGE, &event);
+		return;
 	}
 
 	event.event_type = pkt->event_data1;
 
 	num_properties_changed = pkt->event_data2;
-	if (!num_properties_changed) {
-		inst->error = HFI_ERR_SESSION_INSUFFICIENT_RESOURCES;
-		goto done;
-	}
+	if (!num_properties_changed)
+		goto error;
 
 	data_ptr = (u8 *)&pkt->ext_event_data[0];
+	rem_bytes = pkt->shdr.hdr.size - sizeof(*pkt);
+
 	do {
+		if (rem_bytes < sizeof(u32))
+			goto error;
 		ptype = *((u32 *)data_ptr);
+
+		data_ptr += sizeof(u32);
+		rem_bytes -= sizeof(u32);
+
 		switch (ptype) {
 		case HFI_PROPERTY_PARAM_FRAME_SIZE:
-			data_ptr += sizeof(u32);
+			if (rem_bytes < sizeof(struct hfi_framesize))
+				goto error;
+
 			frame_sz = (struct hfi_framesize *)data_ptr;
 			event.width = frame_sz->width;
 			event.height = frame_sz->height;
-			data_ptr += sizeof(*frame_sz);
+			size_read = sizeof(struct hfi_framesize);
 			break;
 		case HFI_PROPERTY_PARAM_PROFILE_LEVEL_CURRENT:
-			data_ptr += sizeof(u32);
+			if (rem_bytes < sizeof(struct hfi_profile_level))
+				goto error;
+
 			profile_level = (struct hfi_profile_level *)data_ptr;
 			event.profile = profile_level->profile;
 			event.level = profile_level->level;
-			data_ptr += sizeof(*profile_level);
+			size_read = sizeof(struct hfi_profile_level);
 			break;
 		case HFI_PROPERTY_PARAM_VDEC_PIXEL_BITDEPTH:
-			data_ptr += sizeof(u32);
+			if (rem_bytes < sizeof(struct hfi_bit_depth))
+				goto error;
+
 			pixel_depth = (struct hfi_bit_depth *)data_ptr;
 			event.bit_depth = pixel_depth->bit_depth;
-			data_ptr += sizeof(*pixel_depth);
+			size_read = sizeof(struct hfi_bit_depth);
 			break;
 		case HFI_PROPERTY_PARAM_VDEC_PIC_STRUCT:
-			data_ptr += sizeof(u32);
+			if (rem_bytes < sizeof(struct hfi_pic_struct))
+				goto error;
+
 			pic_struct = (struct hfi_pic_struct *)data_ptr;
 			event.pic_struct = pic_struct->progressive_only;
-			data_ptr += sizeof(*pic_struct);
+			size_read = sizeof(struct hfi_pic_struct);
 			break;
 		case HFI_PROPERTY_PARAM_VDEC_COLOUR_SPACE:
-			data_ptr += sizeof(u32);
+			if (rem_bytes < sizeof(struct hfi_colour_space))
+				goto error;
+
 			colour_info = (struct hfi_colour_space *)data_ptr;
 			event.colour_space = colour_info->colour_space;
-			data_ptr += sizeof(*colour_info);
+			size_read = sizeof(struct hfi_colour_space);
 			break;
 		case HFI_PROPERTY_CONFIG_VDEC_ENTROPY:
-			data_ptr += sizeof(u32);
+			if (rem_bytes < sizeof(u32))
+				goto error;
+
 			event.entropy_mode = *(u32 *)data_ptr;
-			data_ptr += sizeof(u32);
+			size_read = sizeof(u32);
 			break;
 		case HFI_PROPERTY_CONFIG_BUFFER_REQUIREMENTS:
-			data_ptr += sizeof(u32);
+			if (rem_bytes < sizeof(struct hfi_buffer_requirements))
+				goto error;
+
 			bufreq = (struct hfi_buffer_requirements *)data_ptr;
 			event.buf_count = hfi_bufreq_get_count_min(bufreq, ver);
-			data_ptr += sizeof(*bufreq);
+			size_read = sizeof(struct hfi_buffer_requirements);
 			break;
 		case HFI_INDEX_EXTRADATA_INPUT_CROP:
-			data_ptr += sizeof(u32);
+			if (rem_bytes < sizeof(struct hfi_extradata_input_crop))
+				goto error;
+
 			crop = (struct hfi_extradata_input_crop *)data_ptr;
 			event.input_crop.left = crop->left;
 			event.input_crop.top = crop->top;
 			event.input_crop.width = crop->width;
 			event.input_crop.height = crop->height;
-			data_ptr += sizeof(*crop);
+			size_read = sizeof(struct hfi_extradata_input_crop);
 			break;
 		case HFI_PROPERTY_PARAM_VDEC_DPB_COUNTS:
-			data_ptr += sizeof(u32);
+			if (rem_bytes < sizeof(struct hfi_dpb_counts))
+				goto error;
+
 			dpb_count = (struct hfi_dpb_counts *)data_ptr;
 			event.buf_count = dpb_count->fw_min_cnt;
-			data_ptr += sizeof(*dpb_count);
+			size_read = sizeof(struct hfi_dpb_counts);
 			break;
 		default:
+			size_read = 0;
 			break;
 		}
+		data_ptr += size_read;
+		rem_bytes -= size_read;
 		num_properties_changed--;
 	} while (num_properties_changed > 0);
 
-done:
+	inst->ops->event_notify(inst, EVT_SYS_EVENT_CHANGE, &event);
+	return;
+
+error:
+	inst->error = HFI_ERR_SESSION_INSUFFICIENT_RESOURCES;
 	inst->ops->event_notify(inst, EVT_SYS_EVENT_CHANGE, &event);
 }
 
-- 
2.50.1


