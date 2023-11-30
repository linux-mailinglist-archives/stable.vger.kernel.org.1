Return-Path: <stable+bounces-3295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8C17FF4EC
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BB2CB20DF8
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A2554F94;
	Thu, 30 Nov 2023 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j/vjT5BD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365AE495C2;
	Thu, 30 Nov 2023 16:24:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E821C433C8;
	Thu, 30 Nov 2023 16:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361468;
	bh=YdkA47v2XR/kEcjZJ++ftIJGwZSAAIuf7hOTPHds93E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j/vjT5BDASjn6S9rzYiQQjUi/QrbgWDanyblMlSnfywbjcFwJtq8kcvSivN+KA/wY
	 Ypc4Yw6F1aP6tmZYbREdoTJ3BO83mtg9R8Q8GjmdyeX5abhDXYoZ32K6ld5AJk/7U/
	 x3QBJ9muf2Zkhhwz+TfSu+tpuu///NjFkb5BF22o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 035/112] drm/panel: boe-tv101wum-nl6: Fine tune Himax83102-j02 panel HFP and HBP
Date: Thu, 30 Nov 2023 16:21:22 +0000
Message-ID: <20231130162141.439480728@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
References: <20231130162140.298098091@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Yang <yangcong5@huaqin.corp-partner.google.com>

[ Upstream commit cea7008190ad65b4aaae6e94667a358d2c10a696 ]

The refresh reported by modetest is 60.46Hz, and the actual measurement
is 60.01Hz, which is outside the expected tolerance. Adjust hporch and
pixel clock to fix it. After repair, modetest and actual measurement were
all 60.01Hz.

Modetest refresh = Pixel CLK/ htotal* vtotal, but measurement frame rate
is HS->LP cycle time(Vblanking). Measured frame rate is not only affecte
by Htotal/Vtotal/pixel clock, also affected by Lane-num/PixelBit/LineTime
/DSI CLK. Assume that the DSI controller could not make the mode that we
requested(presumably it's PLL couldn't generate the exact pixel clock?).
If you use a different DSI controller, you may need to readjust these
parameters. Now this panel looks like it's only used by me on the MTK
platform, so let's change this set of parameters.

Fixes: 1bc2ef065f13 ("drm/panel: Support for Starry-himax83102-j02 TDDI MIPI-DSI panel")
Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20231120020109.3216343-1-yangcong5@huaqin.corp-partner.google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 980b10244d4e6..d76a8ca9c40f8 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -2107,11 +2107,11 @@ static const struct panel_desc starry_qfh032011_53g_desc = {
 };
 
 static const struct drm_display_mode starry_himax83102_j02_default_mode = {
-	.clock = 161600,
+	.clock = 162850,
 	.hdisplay = 1200,
-	.hsync_start = 1200 + 40,
-	.hsync_end = 1200 + 40 + 20,
-	.htotal = 1200 + 40 + 20 + 40,
+	.hsync_start = 1200 + 50,
+	.hsync_end = 1200 + 50 + 20,
+	.htotal = 1200 + 50 + 20 + 50,
 	.vdisplay = 1920,
 	.vsync_start = 1920 + 116,
 	.vsync_end = 1920 + 116 + 8,
-- 
2.42.0




