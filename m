Return-Path: <stable+bounces-76605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3FD97B450
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 21:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED99D1C22CCD
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 19:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87061862B9;
	Tue, 17 Sep 2024 19:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b="ZfXsIk7l"
X-Original-To: stable@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9D9BA3D
	for <stable@vger.kernel.org>; Tue, 17 Sep 2024 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726600870; cv=none; b=t5ZoO5oLoqNFQeZ5vTSrwVK+1V4Yc+BOMchZ1El3f3ws4HCfbRxGhmyopdpQdsg+OXV+8vIERWR1pw3iA2MM9XAyL1gJHqXyUfjBOasidDxQ9LbrR3wpPKsJMW9Gir7/PztiTvjQUW2n1PDq2eMmdBXB+LFA/KR9n+g2v4CQEPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726600870; c=relaxed/simple;
	bh=jZ+rWeOBtK8vKHtCTWgxkjXuoDFbjO24SJQrZ1e9LLI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dDhYXwCgYagXkp1FvkyConZxficqBUXy+VxYWK5gh/F4nnzPwG+sBevf+9/Jt3nj39TBcuIEGudZmgyRQithOCQx/CDoLwwS3sdCT7Jb8vRg5TW5b2ABGzlH68xX8sXBPFJ5YL7RUxFFuqY1mZwMjKphwbgfnyvUSDrdWWfZ2ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru; spf=pass smtp.mailfrom=maxima.ru; dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b=ZfXsIk7l; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxima.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 68CF1C0005;
	Tue, 17 Sep 2024 22:20:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 68CF1C0005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxima.ru; s=sl;
	t=1726600855; bh=zS9Qr7Vs+AlELiwR44nf+DMJR30B7mTBuEPLIezVQVI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ZfXsIk7lL0ocLsIDd8GNIBrM84h1bNGAhBGUxfRp92GS2AzRMojRa6FaBDOdPjTIC
	 28gYXW/5vb6svNbDWualH9tpjXFevQeCXiHSC1XwOqG118iSfonulKrfIjBeIBgs4s
	 Rpkk5cvKA9rCwFcdqnVbmM9a81Q6vIU6EDVpMenTeSTzvC8L8z2i3wgHSKSP0zxXS9
	 OlsCiUBQojjtfQbBCDygDLS5GEy3lJ6GQjEt4WY4AK+qU3j/v5NkK8KQ4YL3+WsYy4
	 nRojQKQ/Iv8aGnwQ2W3bU4tAbdu3GeaztvLeYwL69O2U+y7sup9GRdWHejxE2X7CH8
	 50p52aOs2H5YQ==
Received: from ksmg01.maxima.ru (unknown [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Tue, 17 Sep 2024 22:20:55 +0300 (MSK)
Received: from localhost.maximatelecom.ru (10.0.247.12) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.4; Tue, 17 Sep 2024 22:20:52 +0300
From: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Vitaliy Shevtsov <v.shevtsov@maxima.ru>, Harry Wentland
	<harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira
	<Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Xinhui Pan
	<Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter
	<daniel@ffwll.ch>, Alex Hung <alex.hung@amd.com>, Wayne Lin
	<wayne.lin@amd.com>, Hersen Wu <hersenxs.wu@amd.com>
Subject: [PATCH 6.1/6.6] drm/amd/display: Add NULL pointer check for kzalloc
Date: Wed, 18 Sep 2024 00:20:27 +0500
Message-ID: <20240917192038.10528-1-v.shevtsov@maxima.ru>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch01.mt.ru
 (81.200.124.61)
X-KSMG-Rule-ID: 7
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187805 [Sep 17 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: v.shevtsov@maxima.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dmarc=none header.from=maxima.ru;spf=none smtp.mailfrom=maxima.ru;dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;maxima.ru:7.1.1;ksmg01.maxima.ru:7.1.1;127.0.0.199:7.1.2;81.200.124.61:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.61, {DNS response errors}
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/09/17 18:08:00 #26607868
X-KSMG-AntiVirus-Status: Clean, skipped

From: Hersen Wu <hersenxs.wu@amd.com>

commit 8e65a1b7118acf6af96449e1e66b7adbc9396912 upstream.

[Why & How]
Check return pointer of kzalloc before using it.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[v.shevtsov@maxima.ru: In order to adapt this patch to branches 6.1/6.6
changes related to files
drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c,
drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
were excluded.]
Signed-off-by: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  | 8 ++++++++
 .../gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 8 ++++++++
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c     | 3 +++
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c     | 5 +++++
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c   | 5 +++++
 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c   | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c   | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c     | 5 +++++
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c   | 2 ++
 9 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index 3ce0ee0d012f..367b163537c4 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -568,11 +568,19 @@ void dcn3_clk_mgr_construct(
 	dce_clock_read_ss_info(clk_mgr);
 
 	clk_mgr->base.bw_params = kzalloc(sizeof(*clk_mgr->base.bw_params), GFP_KERNEL);
+	if (!clk_mgr->base.bw_params) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
 
 	/* need physical address of table to give to PMFW */
 	clk_mgr->wm_range_table = dm_helpers_allocate_gpu_mem(clk_mgr->base.ctx,
 			DC_MEM_ALLOC_TYPE_GART, sizeof(WatermarksExternal_t),
 			&clk_mgr->wm_range_table_addr);
+	if (!clk_mgr->wm_range_table) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
 }
 
 void dcn3_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 1d84a04acb3f..3ade764d3323 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -816,11 +816,19 @@ void dcn32_clk_mgr_construct(
 	clk_mgr->smu_present = false;
 
 	clk_mgr->base.bw_params = kzalloc(sizeof(*clk_mgr->base.bw_params), GFP_KERNEL);
+	if (!clk_mgr->base.bw_params) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
 
 	/* need physical address of table to give to PMFW */
 	clk_mgr->wm_range_table = dm_helpers_allocate_gpu_mem(clk_mgr->base.ctx,
 			DC_MEM_ALLOC_TYPE_GART, sizeof(WatermarksExternal_t),
 			&clk_mgr->wm_range_table_addr);
+	if (!clk_mgr->wm_range_table) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
 }
 
 void dcn32_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 5a8d1a051314..6c58618f1b9c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2062,6 +2062,9 @@ bool dcn30_validate_bandwidth(struct dc *dc,
 
 	BW_VAL_TRACE_COUNT();
 
+	if (!pipes)
+		goto validate_fail;
+
 	DC_FP_START();
 	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate, true);
 	DC_FP_END();
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index d3f76512841b..73a7b1ec353e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1324,6 +1324,8 @@ static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 	hpo_dp_link_encoder31_construct(hpo_dp_enc31, ctx, inst,
 					&hpo_dp_link_enc_regs[inst],
@@ -1773,6 +1775,9 @@ bool dcn31_validate_bandwidth(struct dc *dc,
 
 	BW_VAL_TRACE_COUNT();
 
+	if (!pipes)
+		goto validate_fail;
+
 	DC_FP_START();
 	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate, true);
 	DC_FP_END();
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 6b8abdb5c7f8..1a4280b89a1f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -1372,6 +1372,8 @@ static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 	hpo_dp_link_encoder31_construct(hpo_dp_enc31, ctx, inst,
 					&hpo_dp_link_enc_regs[inst],
@@ -1743,6 +1745,9 @@ bool dcn314_validate_bandwidth(struct dc *dc,
 
 	BW_VAL_TRACE_COUNT();
 
+	if (!pipes)
+		goto validate_fail;
+
 	if (filter_modes_for_single_channel_workaround(dc, context))
 		goto validate_fail;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index b9b1e5ac4f53..e78954514e3e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1325,6 +1325,8 @@ static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 	hpo_dp_link_encoder31_construct(hpo_dp_enc31, ctx, inst,
 					&hpo_dp_link_enc_regs[inst],
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
index af3eddc0cf32..932fe9b5c08c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
@@ -1322,6 +1322,8 @@ static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 	hpo_dp_link_encoder31_construct(hpo_dp_enc31, ctx, inst,
 					&hpo_dp_link_enc_regs[inst],
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 2b8700b291a4..0762f58cffdb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1310,6 +1310,8 @@ static struct hpo_dp_link_encoder *dcn32_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 #undef REG_STRUCT
 #define REG_STRUCT hpo_dp_link_enc_regs
@@ -1852,6 +1854,9 @@ bool dcn32_validate_bandwidth(struct dc *dc,
 
 	BW_VAL_TRACE_COUNT();
 
+	if (!pipes)
+		goto validate_fail;
+
 	DC_FP_START();
 	out = dcn32_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate);
 	DC_FP_END();
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index aed92ced7b76..85430e5baa45 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1296,6 +1296,8 @@ static struct hpo_dp_link_encoder *dcn321_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 #undef REG_STRUCT
 #define REG_STRUCT hpo_dp_link_enc_regs
-- 
2.46.1


