Return-Path: <stable+bounces-3767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFF5802436
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 14:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F42280E83
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 13:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F53DF9EB;
	Sun,  3 Dec 2023 13:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zvsVfSMu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16883C8CB
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 13:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31FAC433C7;
	Sun,  3 Dec 2023 13:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701609765;
	bh=bVbtrJxjgV3VQQVYJ3y/pdOnlvqy0NT8nuzFRMlex50=;
	h=Subject:To:Cc:From:Date:From;
	b=zvsVfSMuAIgU8TkTGTs5W6NpuB7gXt5KGq6PY/KwBV4xoafEkfGhlKe4GG2scnwRI
	 8UyCQXGU0e9a82qGveVhi2FoLmWvyU1GE6m64imVmzggw+pglvH1USDLPfaI6uS4js
	 yYScXkBsf0l0jKhNRV6eus9W/WjeziuMkykZaQeI=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix black screen on video playback with" failed to apply to 6.1-stable tree
To: sungkim@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,nicholas.kazlauskas@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 Dec 2023 14:22:33 +0100
Message-ID: <2023120333-sliver-duplex-6926@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 47831f4860d4e8cdfee4910d2b76ccd892fd72d1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120333-sliver-duplex-6926@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

47831f4860d4 ("drm/amd/display: Fix black screen on video playback with embedded panel")
c0af8c744e7e ("drm/amd/display: Make driver backwards-compatible with non-IPS PMFW")
1288d7020809 ("drm/amd/display: Improve x86 and dmub ips handshake")
c0f8b83188c7 ("drm/amd/display: disable IPS")
93a66cef607c ("drm/amd/display: Add IPS control flag")
dc01c4b79bfe ("drm/amd/display: Update driver and IPS interop")
77ad5f6febdc ("drm/amd/display: Add new logs for AutoDPMTest")
0fa45b6aeae4 ("drm/amd/display: Add DCN35 Resource")
ec129fa356be ("drm/amd/display: Add DCN35 init")
65138eb72e1f ("drm/amd/display: Add DCN35 DMUB")
8774029f76b9 ("drm/amd/display: Add DCN35 CLK_MGR")
6f8b7565cca4 ("drm/amd/display: Add DCN35 HWSEQ")
920f879c8360 ("drm/amd/display: Add DCN35 PG_CNTL")
fb8c3ef80584 ("drm/amd/display: Update dc.h for DCN35 support")
5e77c339a291 ("drm/amd/display: Skip dmub memory flush when not needed")
0b9dc439f404 ("drm/amd/display: Write flip addr to scratch reg for subvp")
96182df99dad ("drm/amd/display: Enable runtime register offset init for DCN32 DMUB")
53f328807946 ("drm/amd/display: implement pipe type definition and adding accessors")
73d450926432 ("drm/amd/display: fix incorrect stream_res allocation for older ASIC")
198f0e895349 ("drm/amd/display: rename acquire_idle_pipe_for_layer to acquire_free_pipe_as_sec_dpp_pipe")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 47831f4860d4e8cdfee4910d2b76ccd892fd72d1 Mon Sep 17 00:00:00 2001
From: Sung Joon Kim <sungkim@amd.com>
Date: Fri, 10 Nov 2023 11:33:45 -0500
Subject: [PATCH] drm/amd/display: Fix black screen on video playback with
 embedded panel

[why]
We have dynamic power control in driver but
should be ignored when power is forced on.

[how]
Bypass any power control when it's forced on.

Cc: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 19f8d83698be..63a0b885b6f0 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -1132,7 +1132,6 @@ void dcn35_clk_mgr_construct(
 			ctx->dc->debug.disable_dpp_power_gate = false;
 			ctx->dc->debug.disable_hubp_power_gate = false;
 			ctx->dc->debug.disable_dsc_power_gate = false;
-			ctx->dc->debug.disable_hpo_power_gate = false;
 		} else {
 			/*let's reset the config control flag*/
 			ctx->dc->config.disable_ips = DMUB_IPS_DISABLE_ALL; /*pmfw not support it, disable it all*/
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
index 46f71ff08fd1..d19db8e9b8a5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
@@ -261,6 +261,7 @@ void pg_cntl35_hpo_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 	uint32_t power_gate = power_on ? 0 : 1;
 	uint32_t pwr_status = power_on ? 0 : 2;
 	uint32_t org_ip_request_cntl;
+	uint32_t power_forceon;
 	bool block_enabled;
 
 	if (pg_cntl->ctx->dc->debug.ignore_pg ||
@@ -277,6 +278,10 @@ void pg_cntl35_hpo_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 			return;
 	}
 
+	REG_GET(DOMAIN25_PG_CONFIG, DOMAIN_POWER_FORCEON, &power_forceon);
+	if (power_forceon)
+		return;
+
 	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
 	if (org_ip_request_cntl == 0)
 		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);
@@ -304,6 +309,7 @@ void pg_cntl35_io_clk_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 	uint32_t power_gate = power_on ? 0 : 1;
 	uint32_t pwr_status = power_on ? 0 : 2;
 	uint32_t org_ip_request_cntl;
+	uint32_t power_forceon;
 	bool block_enabled;
 
 	if (pg_cntl->ctx->dc->debug.ignore_pg ||
@@ -319,6 +325,10 @@ void pg_cntl35_io_clk_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 			return;
 	}
 
+	REG_GET(DOMAIN22_PG_CONFIG, DOMAIN_POWER_FORCEON, &power_forceon);
+	if (power_forceon)
+		return;
+
 	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
 	if (org_ip_request_cntl == 0)
 		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);


