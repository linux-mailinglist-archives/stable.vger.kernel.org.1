Return-Path: <stable+bounces-76207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB4E979FC0
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 12:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720F1284E77
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 10:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7A71514EE;
	Mon, 16 Sep 2024 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b="gbV6jSE2"
X-Original-To: stable@vger.kernel.org
Received: from ksmg02.maxima.ru (ksmg02.maxima.ru [81.200.124.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC53414F9FB;
	Mon, 16 Sep 2024 10:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726483840; cv=none; b=FJfeoMpEbD2IOEYMu/B725Div8On6Aa8Qiccpkq1dmYDtuVbb71vFuzWsK/ujkz2A6ZfAZeEwtV764twwwCCRoGl7NeQ5ToKH0unyNWsI8j6Q4rk1/ngq1mhQnvr2EtQAzsdT2ZylrTFyHDG6jlODW4ntLyXY2FaOqOwHoQ8Vbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726483840; c=relaxed/simple;
	bh=oNw8Deyr6aFEIEOV8LMP0ghfVKW8akh1YqccHHry+DQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZEVvHxjvOY0eYpg6bNsY7OPjUdSMEmO0kRcfmxHY/MB74imiANMWITTY2W7Dzi5dZ7GVT0Fuj3q7GfZplZ3Rp+rIobA7/WPtEr7X3Ke+OTEZYmO8a/9OV+/IvLteFJKWKIavc2c+YJj6KJ3owjQ8XyTp3Vy9NGTaehtaU4a7Ogo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru; spf=pass smtp.mailfrom=maxima.ru; dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b=gbV6jSE2; arc=none smtp.client-ip=81.200.124.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxima.ru
Received: from ksmg02.maxima.ru (localhost [127.0.0.1])
	by ksmg02.maxima.ru (Postfix) with ESMTP id 0CE481E0004;
	Mon, 16 Sep 2024 13:44:04 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg02.maxima.ru 0CE481E0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxima.ru; s=sl;
	t=1726483444; bh=ThbJ6N0R8e00LokNP2VgWULnWOsZlMXMwlpzar1AU8c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=gbV6jSE2Ssz1pyhMQKepO3iiL6sbXccEtWhqWaybBv62a4g5UyV/wrB5Nk+9Tdn4g
	 KdEi5+Pr6fiCD5v1DtC4vXjDIqYeUFHvnYrJSqW0BLPCuSqVxEi6d441IHuy66AHxX
	 n0RL8gEqmniCAW6OjaydzYguaYXeFXOjqz8DrMVcm3xpxhDyI6De3ne2+98UGo3zbG
	 4Sj1251IHUb1ZP7uVAoKsGh23odgIrDL4wOpqy8ujwuckm/hxcRniZxDi0WWdRhcqj
	 KHJ5S5p7kWH33JYtXnS4yDo18m+/+sH5Cbz9fp8DkTNrEhl2EqTjHdkhjdoqZRnQem
	 D9/y0JR9ACMNw==
Received: from ksmg02.maxima.ru (unknown [81.200.124.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg02.maxima.ru (Postfix) with ESMTPS;
	Mon, 16 Sep 2024 13:44:03 +0300 (MSK)
Received: from GS-NOTE-190.mt.ru (10.0.247.10) by mmail-p-exch02.mt.ru
 (81.200.124.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Mon, 16 Sep
 2024 13:44:00 +0300
From: Murad Masimov <m.masimov@maxima.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Murad Masimov <m.masimov@maxima.ru>, Harry Wentland
	<harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira
	<Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Pan, Xinhui"
	<Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter
	<daniel@ffwll.ch>, Alvin Lee <alvin.lee2@amd.com>, Sasha Levin
	<sashal@kernel.org>, Chaitanya Dhere <chaitanya.dhere@amd.com>, Tom Chung
	<chiahsuan.chung@amd.com>, Sohaib Nadeem <sohaib.nadeem@amd.com>, Hersen Wu
	<hersenxs.wu@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, Daniel
 Wheeler <daniel.wheeler@amd.com>, Rodrigo Siqueira
	<rodrigo.siqueira@amd.com>, Samson Tam <samson.tam@amd.com>
Subject: [PATCH 6.1] drm/amd/display: Fix subvp+drr logic errors
Date: Mon, 16 Sep 2024 13:43:23 +0300
Message-ID: <20240916104325.1532-1-m.masimov@maxima.ru>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch02.mt.ru
 (81.200.124.62)
X-KSMG-Rule-ID: 7
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187760 [Sep 16 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: m.masimov@maxima.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dmarc=none header.from=maxima.ru;spf=none smtp.mailfrom=maxima.ru;dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, maxima.ru:7.1.1;81.200.124.62:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;ksmg02.maxima.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.62, {DNS response errors}
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/09/16 05:22:00 #26594998
X-KSMG-AntiVirus-Status: Clean, skipped

From: Alvin Lee <alvin.lee2@amd.com>

commit 8a0f02b7beed7b2b768dbdf3b79960de68f460c5 upstream.

[Why]
There is some logic error where the wrong variable was used to check for
OTG_MASTER and DPP_PIPE.

[How]
Add booleans to confirm that the expected pipes were found before
validating schedulability.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Reviewed-by: Samson Tam <samson.tam@amd.com>
Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[m.masimov@maxima.ru: In order to adapt this patch to branch 6.1
only changes related to finding the SubVP pipe were applied
as in 6.1 drr_pipe is passed as a function argument.]
Signed-off-by: Murad Masimov <m.masimov@maxima.ru>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 85e0d1c2a908..4b0719392d28 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -862,6 +862,7 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context, struc
 	int16_t stretched_drr_us = 0;
 	int16_t drr_stretched_vblank_us = 0;
 	int16_t max_vblank_mallregion = 0;
+	bool subvp_found = false;
 
 	// Find SubVP pipe
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -873,10 +874,15 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context, struc
 			continue;
 
 		// Find the SubVP pipe
-		if (pipe->stream->mall_stream_config.type == SUBVP_MAIN)
+		if (pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
+			subvp_found = true;
 			break;
+		}
 	}
 
+	if (!subvp_found)
+		return false;
+
 	main_timing = &pipe->stream->timing;
 	phantom_timing = &pipe->stream->mall_stream_config.paired_stream->timing;
 	drr_timing = &drr_pipe->stream->timing;
-- 
2.39.2


