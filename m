Return-Path: <stable+bounces-289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E55B7F7645
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 15:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC6EFB216C6
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA99E2D057;
	Fri, 24 Nov 2023 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VEa/Qfln"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3192D040
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 14:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EDFC433D9;
	Fri, 24 Nov 2023 14:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700835763;
	bh=mDqJ/hTLKAm5IiDi5tL8nv0JeO9Lh66kR4G7RglwAeA=;
	h=Subject:To:Cc:From:Date:From;
	b=VEa/Qflnm+nr40CXEDIVhGeXyP/E+W7YKEG3pvabp4q+c+cZG1l6j4vRDIyKClzfs
	 mQ4Er7IOHIc344irVVgriJ1xQpV2p8a30hlzOeshuMPBV1sGrxwF5LkYz8ID4VEpfu
	 xS0UK1M7xYcNvyezUbyn9TyL0yvywS4dTuLdywoc=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix encoder disable logic" failed to apply to 6.5-stable tree
To: nicholas.susanto@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,nicholas.kazlauskas@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 14:22:32 +0000
Message-ID: <2023112432-yelp-squint-50c2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x 0ee057e66c4b782809a0a9265cdac5542e646706
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112432-yelp-squint-50c2@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

0ee057e66c4b ("drm/amd/display: Fix encoder disable logic")
e0b394a87a11 ("drm/amd/display: Add DCN35 DIO")

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


