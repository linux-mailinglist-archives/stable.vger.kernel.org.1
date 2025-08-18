Return-Path: <stable+bounces-170033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA24AB2A01B
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE7A207EA0
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 11:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1080A30F81E;
	Mon, 18 Aug 2025 11:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ytkpvwEZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D98132117
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755515406; cv=none; b=gIl0HtfJqZssGwixJJcpMI40l4Uo596OIIYaAM44hS/Zi8kl6iUbtfzz0TybR0Yl0z0Y6IHHQRKkAGKMmRe2uWl8GcnMBczi5+4f6auXrCaFfBzUCVMMX1pq5EmPwmfSUkkA53M4/LF3OUGIZctszopMW6N9xXd/IVbsExBeGME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755515406; c=relaxed/simple;
	bh=mwdJoXf02bHLZzwnzLSyuclJ7zHQAYBvLZ6vhE7fTok=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bPKhewM5CA+RAHY628BewBkAirzhBlaayCwvbQewdjx12GjHydgbInbzXys3HeNP312prJTsWLybV+85E3yWux4GczlNyPQmMCSFe/Mqdm06pq0LIx591ED5uF08YzrSsEQn+CxEgHpVEgt57gJMuOsXf+1tn/XR2T3oNzbmrDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ytkpvwEZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A933C4CEEB;
	Mon, 18 Aug 2025 11:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755515406;
	bh=mwdJoXf02bHLZzwnzLSyuclJ7zHQAYBvLZ6vhE7fTok=;
	h=Subject:To:Cc:From:Date:From;
	b=ytkpvwEZxjQcUoUMkc/5LoxXk/Wl8ZuzC4JE2FpZht867A5jCT4veT0V7pYIwFh3x
	 97i3iiPO68Mxsu40rUFYlAo+drXsQm/aOdxJFgeDHFRHeitmF98wq6Gd+QN91FOei7
	 ZCMbRE5Z98DUdZujK72WNZO6c5cRlW2oehdX/l4I=
Subject: FAILED: patch "[PATCH] media: venus: Fix OOB read due to missing payload bound check" failed to apply to 5.15-stable tree
To: quic_vnagar@quicinc.com,bod@kernel.org,bryan.odonoghue@linaro.org,hverkuil@xs4all.nl,quic_dikshita@quicinc.com,quic_vgarodia@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 13:09:55 +0200
Message-ID: <2025081855-other-whisking-9807@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 06d6770ff0d8cc8dfd392329a8cc03e2a83e7289
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081855-other-whisking-9807@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 06d6770ff0d8cc8dfd392329a8cc03e2a83e7289 Mon Sep 17 00:00:00 2001
From: Vedang Nagar <quic_vnagar@quicinc.com>
Date: Mon, 19 May 2025 12:42:22 +0530
Subject: [PATCH] media: venus: Fix OOB read due to missing payload bound check

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

diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
index 0a041b4db9ef..cf0d97cbc463 100644
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
 


