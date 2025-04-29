Return-Path: <stable+bounces-137812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C0AAA1554
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E13D3B4D80
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032142459EC;
	Tue, 29 Apr 2025 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E+EIha5L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35AF24500A;
	Tue, 29 Apr 2025 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947203; cv=none; b=VC8XDL6YTRUtFR2K5fHOxYdq8kSpIkTUJvKPlGewub/YHyd1GJUKm3YPupNnWWrbOZDESC0nWykHxf99yFywI8PAq+gDC9Z4W1GNnJjvXeP3NzLrbZQXOnTEu6Up9WIwYkLoYve6d6e1rVeH4Z3YoYl57EJxZo1OmHcaeHPltds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947203; c=relaxed/simple;
	bh=Xjaubn7XPQPMvCENcpMCDreXOK8bQvhVeNl+ObAOU3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVFC+nAJb2uyaDukz9KsdilNH1ut1bka9j7t+pWZpoVMKrh94NnFlgyvnuEsaH4uKI4xo7zlWSdFM1QzvYu4vBDVxKwlXmXakaf+KkFCmDQOiZp3Hso1lqU7N3o7QlLYgmoQCMo7401Mn7kLa5IUddwY1FgW3c+LySsc4TkE4cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E+EIha5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F4FC4CEE3;
	Tue, 29 Apr 2025 17:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745947203;
	bh=Xjaubn7XPQPMvCENcpMCDreXOK8bQvhVeNl+ObAOU3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E+EIha5Lgs2kbXJEkTv44aiEWE/oX1Fb0KJGzdlCx5QfLWgspk/64H8SD9U0nSfb/
	 zQoblofVQibou/G4VQzV5O9xMXWEcrr9JEc9Spm2QA7hDtEV00JirXz2xYrqT3zs55
	 7POnuVQV98O9aGrztj0pnsecidr91MEpzac3gfdA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 206/286] media: venus: Create hfi platform and move vpp/vsp there
Date: Tue, 29 Apr 2025 18:41:50 +0200
Message-ID: <20250429161116.428579014@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161107.848008295@linuxfoundation.org>
References: <20250429161107.848008295@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stanimir Varbanov <stanimir.varbanov@linaro.org>

[ Upstream commit aa6033892b1d8ea956ce0358867806e171a620d1 ]

Introduce a new hfi platform to cover differences between hfi
versions. As a start move vpp/vsp freq data in that hfi
platform, more platform data will come later.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: 9edaaa8e3e15 ("media: venus: hfi_parser: refactor hfi packet parsing logic")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/venus/Makefile    |  3 +-
 drivers/media/platform/qcom/venus/core.c      | 17 ------
 drivers/media/platform/qcom/venus/core.h      | 12 +---
 drivers/media/platform/qcom/venus/helpers.c   | 54 ++++++++---------
 drivers/media/platform/qcom/venus/helpers.h   |  2 +-
 .../media/platform/qcom/venus/hfi_platform.c  | 49 +++++++++++++++
 .../media/platform/qcom/venus/hfi_platform.h  | 34 +++++++++++
 .../platform/qcom/venus/hfi_platform_v4.c     | 60 +++++++++++++++++++
 .../media/platform/qcom/venus/pm_helpers.c    |  9 +--
 drivers/media/platform/qcom/venus/vdec.c      |  6 +-
 drivers/media/platform/qcom/venus/venc.c      |  6 +-
 11 files changed, 179 insertions(+), 73 deletions(-)
 create mode 100644 drivers/media/platform/qcom/venus/hfi_platform.c
 create mode 100644 drivers/media/platform/qcom/venus/hfi_platform.h
 create mode 100644 drivers/media/platform/qcom/venus/hfi_platform_v4.c

diff --git a/drivers/media/platform/qcom/venus/Makefile b/drivers/media/platform/qcom/venus/Makefile
index dfc6368657091..09ebf46716925 100644
--- a/drivers/media/platform/qcom/venus/Makefile
+++ b/drivers/media/platform/qcom/venus/Makefile
@@ -3,7 +3,8 @@
 
 venus-core-objs += core.o helpers.o firmware.o \
 		   hfi_venus.o hfi_msgs.o hfi_cmds.o hfi.o \
-		   hfi_parser.o pm_helpers.o dbgfs.o
+		   hfi_parser.o pm_helpers.o dbgfs.o \
+		   hfi_platform.o hfi_platform_v4.o \
 
 venus-dec-objs += vdec.o vdec_ctrls.o
 venus-enc-objs += venc.o venc_ctrls.o
diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 1859dd3f7f546..987b1d010c047 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -529,17 +529,6 @@ static const struct freq_tbl sdm845_freq_table[] = {
 	{  244800, 100000000 },	/* 1920x1080@30 */
 };
 
-static const struct codec_freq_data sdm845_codec_freq_data[] =  {
-	{ V4L2_PIX_FMT_H264, VIDC_SESSION_TYPE_ENC, 675, 10 },
-	{ V4L2_PIX_FMT_HEVC, VIDC_SESSION_TYPE_ENC, 675, 10 },
-	{ V4L2_PIX_FMT_VP8, VIDC_SESSION_TYPE_ENC, 675, 10 },
-	{ V4L2_PIX_FMT_MPEG2, VIDC_SESSION_TYPE_DEC, 200, 10 },
-	{ V4L2_PIX_FMT_H264, VIDC_SESSION_TYPE_DEC, 200, 10 },
-	{ V4L2_PIX_FMT_HEVC, VIDC_SESSION_TYPE_DEC, 200, 10 },
-	{ V4L2_PIX_FMT_VP8, VIDC_SESSION_TYPE_DEC, 200, 10 },
-	{ V4L2_PIX_FMT_VP9, VIDC_SESSION_TYPE_DEC, 200, 10 },
-};
-
 static const struct bw_tbl sdm845_bw_table_enc[] = {
 	{ 1944000, 1612000, 0, 2416000, 0 },	/* 3840x2160@60 */
 	{  972000,  951000, 0, 1434000, 0 },	/* 3840x2160@30 */
@@ -561,8 +550,6 @@ static const struct venus_resources sdm845_res = {
 	.bw_tbl_enc_size = ARRAY_SIZE(sdm845_bw_table_enc),
 	.bw_tbl_dec = sdm845_bw_table_dec,
 	.bw_tbl_dec_size = ARRAY_SIZE(sdm845_bw_table_dec),
-	.codec_freq_data = sdm845_codec_freq_data,
-	.codec_freq_data_size = ARRAY_SIZE(sdm845_codec_freq_data),
 	.clks = {"core", "iface", "bus" },
 	.clks_num = 3,
 	.vcodec0_clks = { "core", "bus" },
@@ -584,8 +571,6 @@ static const struct venus_resources sdm845_res_v2 = {
 	.bw_tbl_enc_size = ARRAY_SIZE(sdm845_bw_table_enc),
 	.bw_tbl_dec = sdm845_bw_table_dec,
 	.bw_tbl_dec_size = ARRAY_SIZE(sdm845_bw_table_dec),
-	.codec_freq_data = sdm845_codec_freq_data,
-	.codec_freq_data_size = ARRAY_SIZE(sdm845_codec_freq_data),
 	.clks = {"core", "iface", "bus" },
 	.clks_num = 3,
 	.vcodec0_clks = { "vcodec0_core", "vcodec0_bus" },
@@ -635,8 +620,6 @@ static const struct venus_resources sc7180_res = {
 	.bw_tbl_enc_size = ARRAY_SIZE(sc7180_bw_table_enc),
 	.bw_tbl_dec = sc7180_bw_table_dec,
 	.bw_tbl_dec_size = ARRAY_SIZE(sc7180_bw_table_dec),
-	.codec_freq_data = sdm845_codec_freq_data,
-	.codec_freq_data_size = ARRAY_SIZE(sdm845_codec_freq_data),
 	.clks = {"core", "iface", "bus" },
 	.clks_num = 3,
 	.vcodec0_clks = { "vcodec0_core", "vcodec0_bus" },
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index e56d7b8142152..53d3202460ae9 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -36,13 +36,6 @@ struct reg_val {
 	u32 value;
 };
 
-struct codec_freq_data {
-	u32 pixfmt;
-	u32 session_type;
-	unsigned long vpp_freq;
-	unsigned long vsp_freq;
-};
-
 struct bw_tbl {
 	u32 mbs_per_sec;
 	u32 avg;
@@ -61,8 +54,6 @@ struct venus_resources {
 	unsigned int bw_tbl_dec_size;
 	const struct reg_val *reg_tbl;
 	unsigned int reg_tbl_size;
-	const struct codec_freq_data *codec_freq_data;
-	unsigned int codec_freq_data_size;
 	const char * const clks[VIDC_CLKS_NUM_MAX];
 	unsigned int clks_num;
 	const char * const vcodec0_clks[VIDC_VCODEC_CLKS_NUM_MAX];
@@ -280,7 +271,8 @@ struct venus_buffer {
 struct clock_data {
 	u32 core_id;
 	unsigned long freq;
-	const struct codec_freq_data *codec_freq_data;
+	unsigned long vpp_freq;
+	unsigned long vsp_freq;
 };
 
 #define to_venus_buffer(ptr)	container_of(ptr, struct venus_buffer, vb)
diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 5fdce5f07364e..9ad8abdc4d4f2 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -15,6 +15,7 @@
 #include "helpers.h"
 #include "hfi_helper.h"
 #include "pm_helpers.h"
+#include "hfi_platform.h"
 
 struct intbuf {
 	struct list_head list;
@@ -1040,36 +1041,6 @@ int venus_helper_set_work_mode(struct venus_inst *inst, u32 mode)
 }
 EXPORT_SYMBOL_GPL(venus_helper_set_work_mode);
 
-int venus_helper_init_codec_freq_data(struct venus_inst *inst)
-{
-	const struct codec_freq_data *data;
-	unsigned int i, data_size;
-	u32 pixfmt;
-	int ret = 0;
-
-	if (!IS_V4(inst->core))
-		return 0;
-
-	data = inst->core->res->codec_freq_data;
-	data_size = inst->core->res->codec_freq_data_size;
-	pixfmt = inst->session_type == VIDC_SESSION_TYPE_DEC ?
-			inst->fmt_out->pixfmt : inst->fmt_cap->pixfmt;
-
-	for (i = 0; i < data_size; i++) {
-		if (data[i].pixfmt == pixfmt &&
-		    data[i].session_type == inst->session_type) {
-			inst->clk_data.codec_freq_data = &data[i];
-			break;
-		}
-	}
-
-	if (!inst->clk_data.codec_freq_data)
-		ret = -EINVAL;
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(venus_helper_init_codec_freq_data);
-
 int venus_helper_set_num_bufs(struct venus_inst *inst, unsigned int input_bufs,
 			      unsigned int output_bufs,
 			      unsigned int output2_bufs)
@@ -1535,6 +1506,29 @@ void venus_helper_m2m_job_abort(void *priv)
 }
 EXPORT_SYMBOL_GPL(venus_helper_m2m_job_abort);
 
+int venus_helper_session_init(struct venus_inst *inst)
+{
+	enum hfi_version version = inst->core->res->hfi_version;
+	u32 session_type = inst->session_type;
+	u32 codec;
+	int ret;
+
+	codec = inst->session_type == VIDC_SESSION_TYPE_DEC ?
+			inst->fmt_out->pixfmt : inst->fmt_cap->pixfmt;
+
+	ret = hfi_session_init(inst, codec);
+	if (ret)
+		return ret;
+
+	inst->clk_data.vpp_freq = hfi_platform_get_codec_vpp_freq(version, codec,
+								  session_type);
+	inst->clk_data.vsp_freq = hfi_platform_get_codec_vsp_freq(version, codec,
+								  session_type);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(venus_helper_session_init);
+
 void venus_helper_init_instance(struct venus_inst *inst)
 {
 	if (inst->session_type == VIDC_SESSION_TYPE_DEC) {
diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
index a4a0562bc83f5..5407979bf234b 100644
--- a/drivers/media/platform/qcom/venus/helpers.h
+++ b/drivers/media/platform/qcom/venus/helpers.h
@@ -33,7 +33,6 @@ int venus_helper_set_output_resolution(struct venus_inst *inst,
 				       unsigned int width, unsigned int height,
 				       u32 buftype);
 int venus_helper_set_work_mode(struct venus_inst *inst, u32 mode);
-int venus_helper_init_codec_freq_data(struct venus_inst *inst);
 int venus_helper_set_num_bufs(struct venus_inst *inst, unsigned int input_bufs,
 			      unsigned int output_bufs,
 			      unsigned int output2_bufs);
@@ -48,6 +47,7 @@ unsigned int venus_helper_get_opb_size(struct venus_inst *inst);
 void venus_helper_acquire_buf_ref(struct vb2_v4l2_buffer *vbuf);
 void venus_helper_release_buf_ref(struct venus_inst *inst, unsigned int idx);
 void venus_helper_init_instance(struct venus_inst *inst);
+int venus_helper_session_init(struct venus_inst *inst);
 int venus_helper_get_out_fmts(struct venus_inst *inst, u32 fmt, u32 *out_fmt,
 			      u32 *out2_fmt, bool ubwc);
 int venus_helper_alloc_dpb_bufs(struct venus_inst *inst);
diff --git a/drivers/media/platform/qcom/venus/hfi_platform.c b/drivers/media/platform/qcom/venus/hfi_platform.c
new file mode 100644
index 0000000000000..65559cae21aaa
--- /dev/null
+++ b/drivers/media/platform/qcom/venus/hfi_platform.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+#include "hfi_platform.h"
+
+const struct hfi_platform *hfi_platform_get(enum hfi_version version)
+{
+	switch (version) {
+	case HFI_VERSION_4XX:
+		return &hfi_plat_v4;
+	default:
+		break;
+	}
+
+	return NULL;
+}
+
+unsigned long
+hfi_platform_get_codec_vpp_freq(enum hfi_version version, u32 codec, u32 session_type)
+{
+	const struct hfi_platform *plat;
+	unsigned long freq = 0;
+
+	plat = hfi_platform_get(version);
+	if (!plat)
+		return 0;
+
+	if (plat->codec_vpp_freq)
+		freq = plat->codec_vpp_freq(session_type, codec);
+
+	return freq;
+}
+
+unsigned long
+hfi_platform_get_codec_vsp_freq(enum hfi_version version, u32 codec, u32 session_type)
+{
+	const struct hfi_platform *plat;
+	unsigned long freq = 0;
+
+	plat = hfi_platform_get(version);
+	if (!plat)
+		return 0;
+
+	if (plat->codec_vpp_freq)
+		freq = plat->codec_vsp_freq(session_type, codec);
+
+	return freq;
+}
diff --git a/drivers/media/platform/qcom/venus/hfi_platform.h b/drivers/media/platform/qcom/venus/hfi_platform.h
new file mode 100644
index 0000000000000..8b07ecbb4c825
--- /dev/null
+++ b/drivers/media/platform/qcom/venus/hfi_platform.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __HFI_PLATFORM_H__
+#define __HFI_PLATFORM_H__
+
+#include <linux/types.h>
+#include <linux/videodev2.h>
+
+#include "hfi.h"
+#include "hfi_helper.h"
+
+struct hfi_platform_codec_freq_data {
+	u32 pixfmt;
+	u32 session_type;
+	unsigned long vpp_freq;
+	unsigned long vsp_freq;
+};
+
+struct hfi_platform {
+	unsigned long (*codec_vpp_freq)(u32 session_type, u32 codec);
+	unsigned long (*codec_vsp_freq)(u32 session_type, u32 codec);
+};
+
+extern const struct hfi_platform hfi_plat_v4;
+
+const struct hfi_platform *hfi_platform_get(enum hfi_version version);
+unsigned long hfi_platform_get_codec_vpp_freq(enum hfi_version version, u32 codec,
+					      u32 session_type);
+unsigned long hfi_platform_get_codec_vsp_freq(enum hfi_version version, u32 codec,
+					      u32 session_type);
+#endif
diff --git a/drivers/media/platform/qcom/venus/hfi_platform_v4.c b/drivers/media/platform/qcom/venus/hfi_platform_v4.c
new file mode 100644
index 0000000000000..4fc2fd04ca9d1
--- /dev/null
+++ b/drivers/media/platform/qcom/venus/hfi_platform_v4.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+#include "hfi_platform.h"
+
+static const struct hfi_platform_codec_freq_data codec_freq_data[] =  {
+	{ V4L2_PIX_FMT_H264, VIDC_SESSION_TYPE_ENC, 675, 10 },
+	{ V4L2_PIX_FMT_HEVC, VIDC_SESSION_TYPE_ENC, 675, 10 },
+	{ V4L2_PIX_FMT_VP8, VIDC_SESSION_TYPE_ENC, 675, 10 },
+	{ V4L2_PIX_FMT_MPEG2, VIDC_SESSION_TYPE_DEC, 200, 10 },
+	{ V4L2_PIX_FMT_H264, VIDC_SESSION_TYPE_DEC, 200, 10 },
+	{ V4L2_PIX_FMT_HEVC, VIDC_SESSION_TYPE_DEC, 200, 10 },
+	{ V4L2_PIX_FMT_VP8, VIDC_SESSION_TYPE_DEC, 200, 10 },
+	{ V4L2_PIX_FMT_VP9, VIDC_SESSION_TYPE_DEC, 200, 10 },
+};
+
+static const struct hfi_platform_codec_freq_data *
+get_codec_freq_data(u32 session_type, u32 pixfmt)
+{
+	const struct hfi_platform_codec_freq_data *data = codec_freq_data;
+	unsigned int i, data_size = ARRAY_SIZE(codec_freq_data);
+	const struct hfi_platform_codec_freq_data *found = NULL;
+
+	for (i = 0; i < data_size; i++) {
+		if (data[i].pixfmt == pixfmt && data[i].session_type == session_type) {
+			found = &data[i];
+			break;
+		}
+	}
+
+	return found;
+}
+
+static unsigned long codec_vpp_freq(u32 session_type, u32 codec)
+{
+	const struct hfi_platform_codec_freq_data *data;
+
+	data = get_codec_freq_data(session_type, codec);
+	if (data)
+		return data->vpp_freq;
+
+	return 0;
+}
+
+static unsigned long codec_vsp_freq(u32 session_type, u32 codec)
+{
+	const struct hfi_platform_codec_freq_data *data;
+
+	data = get_codec_freq_data(session_type, codec);
+	if (data)
+		return data->vsp_freq;
+
+	return 0;
+}
+
+const struct hfi_platform hfi_plat_v4 = {
+	.codec_vpp_freq = codec_vpp_freq,
+	.codec_vsp_freq = codec_vsp_freq,
+};
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 12c5811fefdf9..7c3541c35ab69 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -18,6 +18,7 @@
 #include "hfi_parser.h"
 #include "hfi_venus_io.h"
 #include "pm_helpers.h"
+#include "hfi_platform.h"
 
 static bool legacy_binding;
 
@@ -506,7 +507,7 @@ min_loaded_core(struct venus_inst *inst, u32 *min_coreid, u32 *min_load)
 		if (inst_pos->state != INST_START)
 			continue;
 
-		vpp_freq = inst_pos->clk_data.codec_freq_data->vpp_freq;
+		vpp_freq = inst_pos->clk_data.vpp_freq;
 		coreid = inst_pos->clk_data.core_id;
 
 		mbs_per_sec = load_per_instance(inst_pos);
@@ -555,7 +556,7 @@ static int decide_core(struct venus_inst *inst)
 		return 0;
 
 	inst_load = load_per_instance(inst);
-	inst_load *= inst->clk_data.codec_freq_data->vpp_freq;
+	inst_load *= inst->clk_data.vpp_freq;
 	max_freq = core->res->freq_tbl[0].freq;
 
 	min_loaded_core(inst, &min_coreid, &min_load);
@@ -940,10 +941,10 @@ static unsigned long calculate_inst_freq(struct venus_inst *inst,
 	if (inst->state != INST_START)
 		return 0;
 
-	vpp_freq = mbs_per_sec * inst->clk_data.codec_freq_data->vpp_freq;
+	vpp_freq = mbs_per_sec * inst->clk_data.vpp_freq;
 	/* 21 / 20 is overhead factor */
 	vpp_freq += vpp_freq / 20;
-	vsp_freq = mbs_per_sec * inst->clk_data.codec_freq_data->vsp_freq;
+	vsp_freq = mbs_per_sec * inst->clk_data.vsp_freq;
 
 	/* 10 / 7 is overhead factor */
 	if (inst->session_type == VIDC_SESSION_TYPE_ENC)
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 6e9b62645e917..68390143d37df 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -767,7 +767,7 @@ static int vdec_session_init(struct venus_inst *inst)
 {
 	int ret;
 
-	ret = hfi_session_init(inst, inst->fmt_out->pixfmt);
+	ret = venus_helper_session_init(inst);
 	if (ret == -EALREADY)
 		return 0;
 	else if (ret)
@@ -778,10 +778,6 @@ static int vdec_session_init(struct venus_inst *inst)
 	if (ret)
 		goto deinit;
 
-	ret = venus_helper_init_codec_freq_data(inst);
-	if (ret)
-		goto deinit;
-
 	return 0;
 deinit:
 	hfi_session_deinit(inst);
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 9f1b02e31b98c..bc62cb02458c9 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -726,7 +726,7 @@ static int venc_init_session(struct venus_inst *inst)
 {
 	int ret;
 
-	ret = hfi_session_init(inst, inst->fmt_cap->pixfmt);
+	ret = venus_helper_session_init(inst);
 	if (ret == -EALREADY)
 		return 0;
 	else if (ret)
@@ -747,10 +747,6 @@ static int venc_init_session(struct venus_inst *inst)
 	if (ret)
 		goto deinit;
 
-	ret = venus_helper_init_codec_freq_data(inst);
-	if (ret)
-		goto deinit;
-
 	ret = venc_set_properties(inst);
 	if (ret)
 		goto deinit;
-- 
2.39.5




