Return-Path: <stable+bounces-290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE06E7F7644
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 15:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07EA61C21132
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ACF2D03D;
	Fri, 24 Nov 2023 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NqlWzHjS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A612D2C842
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 14:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDA4C433D9;
	Fri, 24 Nov 2023 14:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700835765;
	bh=Yg0l0YPT6YAXw6F6Egw+IH4tfSguqx6fSPOdbaZWRqY=;
	h=Subject:To:Cc:From:Date:From;
	b=NqlWzHjS8RTk6Kh0+VC6Y6hVnJIMAwBEkfPkKcWYCPo6vLmI8yCddPsHPnanfbFKY
	 JU9hqeq3l4hvOai6jDYMLHXhLRHkWisOMTxw33948Y7WtJ3dGFCljVLFdyYednMhrp
	 acEqZDgQ5hg4L8n3Mwk9MCRaupM/p7z5ibaLyoro=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix encoder disable logic" failed to apply to 6.1-stable tree
To: nicholas.susanto@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,nicholas.kazlauskas@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 14:22:33 +0000
Message-ID: <2023112432-schilling-murkiness-4092@gregkh>
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
git cherry-pick -x 0ee057e66c4b782809a0a9265cdac5542e646706
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112432-schilling-murkiness-4092@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

0ee057e66c4b ("drm/amd/display: Fix encoder disable logic")
e0b394a87a11 ("drm/amd/display: Add DCN35 DIO")
25879d7b4986 ("drm/amd/display: Clean FPGA code in dc")
7b1b3f5818c3 ("drm/amd/display: update dig enable sequence")
98ce7d32e215 ("drm/amd/display: convert link.h functions to function pointer style")
22f1482aff4a ("drm/amd/display: add sysfs entry to read PSR residency from firmware")
c186c13e6528 ("drm/amd/display: Drop unnecessary DCN guards")
788c6e2ce5c7 ("drm/amd/display: replace all dc_link function call in link with link functions")
202a3816f37e ("drm/amd/display: move dc_link functions in protocols folder to dc_link_exports")
6455cb522191 ("drm/amd/display: link link_dp_dpia_bw.o in makefile")
76f5dc40ebb1 ("drm/amd/display: move dc_link functions in link root folder to dc_link_exports")
36516001a7c9 ("drm/amd/display: move dc_link functions in accessories folder to dc_link_exports")
1e88eb1b2c25 ("drm/amd/display: Drop CONFIG_DRM_AMD_DC_HDCP")
aee0c07a74d3 ("drm/amd/display: Unify DC logging for BW Alloc")
7ae1dbe6547c ("drm/amd/display: merge dc_link.h into dc.h and dc_types.h")
1099238b966e ("drm/amd/display: Update BW ALLOCATION Function declaration")
a06d565b4a1c ("drm/amd/display: Allocation at stream Enable")
c32699caeca8 ("drm/amd/display: Updating Video Format Fall Back Policy.")
c69fc3d0de6c ("drm/amd/display: Reduce CPU busy-waiting for long delays")
455ad25997ba ("drm/amdgpu: Select DRM_DISPLAY_HDCP_HELPER in amdgpu")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0ee057e66c4b782809a0a9265cdac5542e646706 Mon Sep 17 00:00:00 2001
From: Nicholas Susanto <nicholas.susanto@amd.com>
Date: Wed, 1 Nov 2023 15:30:10 -0400
Subject: [PATCH] drm/amd/display: Fix encoder disable logic

[WHY]
DENTIST hangs when OTG is off and encoder is on. We were not
disabling the encoder properly when switching from extended mode to
external monitor only.

[HOW]
Disable the encoder using an existing enable/disable fifo helper instead
of enc35_stream_encoder_enable.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nicholas Susanto <nicholas.susanto@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c
index 001f9eb66920..62a8f0b56006 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c
@@ -261,12 +261,6 @@ static void enc35_stream_encoder_enable(
 			/* invalid mode ! */
 			ASSERT_CRITICAL(false);
 		}
-
-		REG_UPDATE(DIG_FE_CLK_CNTL, DIG_FE_CLK_EN, 1);
-		REG_UPDATE(DIG_FE_EN_CNTL, DIG_FE_ENABLE, 1);
-	} else {
-		REG_UPDATE(DIG_FE_EN_CNTL, DIG_FE_ENABLE, 0);
-		REG_UPDATE(DIG_FE_CLK_CNTL, DIG_FE_CLK_EN, 0);
 	}
 }
 
@@ -436,6 +430,8 @@ static void enc35_disable_fifo(struct stream_encoder *enc)
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
 	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_ENABLE, 0);
+	REG_UPDATE(DIG_FE_EN_CNTL, DIG_FE_ENABLE, 0);
+	REG_UPDATE(DIG_FE_CLK_CNTL, DIG_FE_CLK_EN, 0);
 }
 
 static void enc35_enable_fifo(struct stream_encoder *enc)
@@ -443,6 +439,8 @@ static void enc35_enable_fifo(struct stream_encoder *enc)
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
 	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_READ_START_LEVEL, 0x7);
+	REG_UPDATE(DIG_FE_CLK_CNTL, DIG_FE_CLK_EN, 1);
+	REG_UPDATE(DIG_FE_EN_CNTL, DIG_FE_ENABLE, 1);
 
 	enc35_reset_fifo(enc, true);
 	enc35_reset_fifo(enc, false);


