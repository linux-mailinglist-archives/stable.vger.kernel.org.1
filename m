Return-Path: <stable+bounces-171812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE0CB2C84E
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 17:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D1316DCBD
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 15:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF3E28314C;
	Tue, 19 Aug 2025 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKSp3mmJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D4A2737E8
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755616578; cv=none; b=EGYjMgi126MXAizek2mUy+kvyj81GPwosgVUqWwknrHzafVe657ZbNMVNFOq/F2wWcHbrr8o3Xg8qgQx1xSH9XxwyeqqGyfHS9lFSm6+tWutlaJCidvDX46OC5Eszlj9wQFQS63BLNt1NguxbkihJi2R6h0+KjBDZzvXHcg9SWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755616578; c=relaxed/simple;
	bh=vS17Mwwxr7s49Y+YkxTd4fQFVckyDByj0m23QelnKU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZlrhrS7rNtSpHnBeC4kDtF5Ak8svdlWekH5KTDVC3nA7g7IioNNDkjGG7edHpobz/2peD1TmqrPi5U45rEjNJLOZ99dIvt8y2HZRb3jZ1jq0WIyvzp/vSGb5Il4WS/JyZO1M1fIqfeqdmfrFTfsVcCnFEK6WOpuST2HC8ig4s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKSp3mmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF4AC4CEF1;
	Tue, 19 Aug 2025 15:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755616578;
	bh=vS17Mwwxr7s49Y+YkxTd4fQFVckyDByj0m23QelnKU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AKSp3mmJLR20rDYo/rjF2APK/N4heNkCluo+u2xaTcPLZpRbTZ2ir7nLESyRiHjcy
	 mLED0VQfESMyD2GN6RlbzwQROX0B9k5Hwl8DroBjcDgLKbe3YfYVVBZIUYbTrbs8wW
	 gIujyCMEMYekQb2gZ6u1YrhM4krtU8NYdIHnOx+5RuCFNWGMl9LdOagyEkSHrUzhck
	 HXbp6zKQK4BKVU8vTy/k4RkhDMHIX+An0t0INgh8Ri2fi4GklzUZxkTx/0Y3w0Q6nB
	 JZC/5yJ0x21A9BPdM4vrCLC2YICLT1H3miwt81IWzDRZgSqbL9allHG3MYecfnWrt/
	 C/VZS3BGU6AZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] media: venus: Introduce accessors for remapped hfi_buffer_reqs members
Date: Tue, 19 Aug 2025 11:16:15 -0400
Message-ID: <20250819151616.535142-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081854-pauper-opacity-6318@gregkh>
References: <2025081854-pauper-opacity-6318@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit bbfc89e6f67ccb1ddefc3e8a284248bcfea58544 ]

Currently we have macros to access these, but they don't provide a
way to override the remapped fields. Replace the macros with actual
get/set pairs to fix that.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Stable-dep-of: 06d6770ff0d8 ("media: venus: Fix OOB read due to missing payload bound check")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/venus/helpers.c   |  2 +-
 .../media/platform/qcom/venus/hfi_helper.h    | 61 ++++++++++++++++---
 drivers/media/platform/qcom/venus/hfi_msgs.c  |  2 +-
 drivers/media/platform/qcom/venus/vdec.c      |  8 +--
 .../media/platform/qcom/venus/vdec_ctrls.c    |  2 +-
 drivers/media/platform/qcom/venus/venc.c      |  4 +-
 .../media/platform/qcom/venus/venc_ctrls.c    |  2 +-
 7 files changed, 63 insertions(+), 18 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index ca6555bdc92f..652ad33cbc4b 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -189,7 +189,7 @@ int venus_helper_alloc_dpb_bufs(struct venus_inst *inst)
 	if (ret)
 		return ret;
 
-	count = HFI_BUFREQ_COUNT_MIN(&bufreq, ver);
+	count = hfi_bufreq_get_count_min(&bufreq, ver);
 
 	for (i = 0; i < count; i++) {
 		buf = kzalloc(sizeof(*buf), GFP_KERNEL);
diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
index d2d6719a2ba4..d71355a64c91 100644
--- a/drivers/media/platform/qcom/venus/hfi_helper.h
+++ b/drivers/media/platform/qcom/venus/hfi_helper.h
@@ -1150,14 +1150,6 @@ struct hfi_buffer_display_hold_count_actual {
 	u32 hold_count;
 };
 
-/* HFI 4XX reorder the fields, use these macros */
-#define HFI_BUFREQ_HOLD_COUNT(bufreq, ver)	\
-	((ver) == HFI_VERSION_4XX ? 0 : (bufreq)->hold_count)
-#define HFI_BUFREQ_COUNT_MIN(bufreq, ver)	\
-	((ver) == HFI_VERSION_4XX ? (bufreq)->hold_count : (bufreq)->count_min)
-#define HFI_BUFREQ_COUNT_MIN_HOST(bufreq, ver)	\
-	((ver) == HFI_VERSION_4XX ? (bufreq)->count_min : 0)
-
 struct hfi_buffer_requirements {
 	u32 type;
 	u32 size;
@@ -1169,6 +1161,59 @@ struct hfi_buffer_requirements {
 	u32 alignment;
 };
 
+/* On HFI 4XX, some of the struct members have been swapped. */
+static inline u32 hfi_bufreq_get_hold_count(struct hfi_buffer_requirements *req,
+					    u32 ver)
+{
+	if (ver == HFI_VERSION_4XX)
+		return 0;
+
+	return req->hold_count;
+};
+
+static inline u32 hfi_bufreq_get_count_min(struct hfi_buffer_requirements *req,
+					   u32 ver)
+{
+	if (ver == HFI_VERSION_4XX)
+		return req->hold_count;
+
+	return req->count_min;
+};
+
+static inline u32 hfi_bufreq_get_count_min_host(struct hfi_buffer_requirements *req,
+						u32 ver)
+{
+	if (ver == HFI_VERSION_4XX)
+		return req->count_min;
+
+	return 0;
+};
+
+static inline void hfi_bufreq_set_hold_count(struct hfi_buffer_requirements *req,
+					     u32 ver, u32 val)
+{
+	if (ver == HFI_VERSION_4XX)
+		return;
+
+	req->hold_count = val;
+};
+
+static inline void hfi_bufreq_set_count_min(struct hfi_buffer_requirements *req,
+					    u32 ver, u32 val)
+{
+	if (ver == HFI_VERSION_4XX)
+		req->hold_count = val;
+
+	req->count_min = val;
+};
+
+static inline void hfi_bufreq_set_count_min_host(struct hfi_buffer_requirements *req,
+						 u32 ver, u32 val)
+{
+	if (ver == HFI_VERSION_4XX)
+		req->count_min = val;
+};
+
 struct hfi_data_payload {
 	u32 size;
 	u8 data[1];
diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
index 1c5cc5a5f89a..c11bf20daace 100644
--- a/drivers/media/platform/qcom/venus/hfi_msgs.c
+++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
@@ -99,7 +99,7 @@ static void event_seq_changed(struct venus_core *core, struct venus_inst *inst,
 		case HFI_PROPERTY_CONFIG_BUFFER_REQUIREMENTS:
 			data_ptr += sizeof(u32);
 			bufreq = (struct hfi_buffer_requirements *)data_ptr;
-			event.buf_count = HFI_BUFREQ_COUNT_MIN(bufreq, ver);
+			event.buf_count = hfi_bufreq_get_count_min(bufreq, ver);
 			data_ptr += sizeof(*bufreq);
 			break;
 		case HFI_INDEX_EXTRADATA_INPUT_CROP:
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 3b51d603605e..e803a405cc35 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -865,13 +865,13 @@ static int vdec_num_buffers(struct venus_inst *inst, unsigned int *in_num,
 	if (ret)
 		return ret;
 
-	*in_num = HFI_BUFREQ_COUNT_MIN(&bufreq, ver);
+	*in_num = hfi_bufreq_get_count_min(&bufreq, ver);
 
 	ret = venus_helper_get_bufreq(inst, HFI_BUFFER_OUTPUT, &bufreq);
 	if (ret)
 		return ret;
 
-	*out_num = HFI_BUFREQ_COUNT_MIN(&bufreq, ver);
+	*out_num = hfi_bufreq_get_count_min(&bufreq, ver);
 
 	return 0;
 }
@@ -985,14 +985,14 @@ static int vdec_verify_conf(struct venus_inst *inst)
 		return ret;
 
 	if (inst->num_output_bufs < bufreq.count_actual ||
-	    inst->num_output_bufs < HFI_BUFREQ_COUNT_MIN(&bufreq, ver))
+	    inst->num_output_bufs < hfi_bufreq_get_count_min(&bufreq, ver))
 		return -EINVAL;
 
 	ret = venus_helper_get_bufreq(inst, HFI_BUFFER_INPUT, &bufreq);
 	if (ret)
 		return ret;
 
-	if (inst->num_input_bufs < HFI_BUFREQ_COUNT_MIN(&bufreq, ver))
+	if (inst->num_input_bufs < hfi_bufreq_get_count_min(&bufreq, ver))
 		return -EINVAL;
 
 	return 0;
diff --git a/drivers/media/platform/qcom/venus/vdec_ctrls.c b/drivers/media/platform/qcom/venus/vdec_ctrls.c
index fbe12a608b21..7e0f29bf7fae 100644
--- a/drivers/media/platform/qcom/venus/vdec_ctrls.c
+++ b/drivers/media/platform/qcom/venus/vdec_ctrls.c
@@ -79,7 +79,7 @@ static int vdec_op_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_MIN_BUFFERS_FOR_CAPTURE:
 		ret = venus_helper_get_bufreq(inst, HFI_BUFFER_OUTPUT, &bufreq);
 		if (!ret)
-			ctrl->val = HFI_BUFREQ_COUNT_MIN(&bufreq, ver);
+			ctrl->val = hfi_bufreq_get_count_min(&bufreq, ver);
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index abd25720b96b..43b033623f3a 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -1177,7 +1177,7 @@ static int venc_verify_conf(struct venus_inst *inst)
 		return ret;
 
 	if (inst->num_output_bufs < bufreq.count_actual ||
-	    inst->num_output_bufs < HFI_BUFREQ_COUNT_MIN(&bufreq, ver))
+	    inst->num_output_bufs < hfi_bufreq_get_count_min(&bufreq, ver))
 		return -EINVAL;
 
 	ret = venus_helper_get_bufreq(inst, HFI_BUFFER_INPUT, &bufreq);
@@ -1185,7 +1185,7 @@ static int venc_verify_conf(struct venus_inst *inst)
 		return ret;
 
 	if (inst->num_input_bufs < bufreq.count_actual ||
-	    inst->num_input_bufs < HFI_BUFREQ_COUNT_MIN(&bufreq, ver))
+	    inst->num_input_bufs < hfi_bufreq_get_count_min(&bufreq, ver))
 		return -EINVAL;
 
 	return 0;
diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
index 7468e43800a9..d9d2a293f3ef 100644
--- a/drivers/media/platform/qcom/venus/venc_ctrls.c
+++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
@@ -358,7 +358,7 @@ static int venc_op_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_MIN_BUFFERS_FOR_OUTPUT:
 		ret = venus_helper_get_bufreq(inst, HFI_BUFFER_INPUT, &bufreq);
 		if (!ret)
-			ctrl->val = HFI_BUFREQ_COUNT_MIN(&bufreq, ver);
+			ctrl->val = hfi_bufreq_get_count_min(&bufreq, ver);
 		break;
 	default:
 		return -EINVAL;
-- 
2.50.1


