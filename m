Return-Path: <stable+bounces-178965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F21B49B32
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 22:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88C1E1893BB4
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 20:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D119A1798F;
	Mon,  8 Sep 2025 20:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0vNb+A+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910CC21B9D9
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 20:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757364414; cv=none; b=GPBH9Oj+BNcxgXw8DhJNa3hZmu9xrTIDdhHtP/jkpH9HZTm2q36+wmxq2qARGUqPFJEhtfZ19hr/lQdUZopxQRi2G+LMejnAiMcX2sZ2l3aIRUVl6mbPameIOFeEJX7V15nhyY3wKH6RSDExdzhB/a3/5s09mwvUBxs/wLL5rVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757364414; c=relaxed/simple;
	bh=xKfhcHH3Hk+OZNB/5EHimwRdvwJ9NTkPxLflNpW6ECE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JXjwZQmjVekfTcOtlpd1Q+R/6N9c9zXK70wCEJU2/x4TLc+corjZVjHTjdBbXdEtjdB2/cjB966ihG+GNo9/757PdLHZbcdAOFAJI071ME69crJcEN3uSWyAS9S6Dro7tXeBZ7QDitXvzrWP+NHNcU/bZ6vz7xLlbxg8VdtZFsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0vNb+A+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69377C4CEF1;
	Mon,  8 Sep 2025 20:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757364413;
	bh=xKfhcHH3Hk+OZNB/5EHimwRdvwJ9NTkPxLflNpW6ECE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R0vNb+A+Qc8zawp2ENX30hcPQ1UglQIgkTKkRRQ0kva4Yh3n0P3mD8sqVq9fGi8ZK
	 qS1hxJv2A/RHvTOYpXPo4F8mhlfXQoE2QYA/KRe4PIOIkVWguHP1MHlL+zzXrnvimf
	 xRP0xlBZ109ccYMeOK7eL4F3tKWVrq9CIRxGLJtKuF7ZMPGuCh4GvtyIG53Iam9Gl8
	 E3+PQLZmHzBawK0XYigbhHDaNQsBYuY2lOK6ZvzfvI1ovH7zJhj7duzH1JrWx1sxU+
	 uFZUs55E/8jIRSL4lwXVA6HQuWAnTJ+8Yb698bGvyupjPFl0mnzby1FAS5PodQI+wc
	 5aNDM7RMz94cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] media: i2c: imx214: Fix link frequency validation
Date: Mon,  8 Sep 2025 16:46:50 -0400
Message-ID: <20250908204650.2336993-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025041716-art-upriver-d0a6@gregkh>
References: <2025041716-art-upriver-d0a6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: André Apitzsch <git@apitzsch.eu>

[ Upstream commit acc294519f1749041e1b8c74d46bbf6c57d8b061 ]

The driver defines IMX214_DEFAULT_LINK_FREQ 480000000, and then
IMX214_DEFAULT_PIXEL_RATE ((IMX214_DEFAULT_LINK_FREQ * 8LL) / 10),
which works out as 384MPix/s. (The 8 is 4 lanes and DDR.)

Parsing the PLL registers with the defined 24MHz input. We're in single
PLL mode, so MIPI frequency is directly linked to pixel rate.  VTCK ends
up being 1200MHz, and VTPXCK and OPPXCK both are 120MHz.  Section 5.3
"Frame rate calculation formula" says "Pixel rate
[pixels/s] = VTPXCK [MHz] * 4", so 120 * 4 = 480MPix/s, which basically
agrees with my number above.

3.1.4. MIPI global timing setting says "Output bitrate = OPPXCK * reg
0x113[7:0]", so 120MHz * 10, or 1200Mbit/s. That would be a link
frequency of 600MHz due to DDR.
That also matches to 480MPix/s * 10bpp / 4 lanes / 2 for DDR.

Keep the previous link frequency for backward compatibility.

Acked-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: André Apitzsch <git@apitzsch.eu>
Fixes: 436190596241 ("media: imx214: Add imx214 camera sensor driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
[ changed dev_err() to dev_err_probe() for the final error case ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/imx214.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
index 83c1737abeece..3a0b641e93e4a 100644
--- a/drivers/media/i2c/imx214.c
+++ b/drivers/media/i2c/imx214.c
@@ -20,7 +20,9 @@
 #include <media/v4l2-subdev.h>
 
 #define IMX214_DEFAULT_CLK_FREQ	24000000
-#define IMX214_DEFAULT_LINK_FREQ 480000000
+#define IMX214_DEFAULT_LINK_FREQ	600000000
+/* Keep wrong link frequency for backward compatibility */
+#define IMX214_DEFAULT_LINK_FREQ_LEGACY	480000000
 #define IMX214_DEFAULT_PIXEL_RATE ((IMX214_DEFAULT_LINK_FREQ * 8LL) / 10)
 #define IMX214_FPS 30
 #define IMX214_MBUS_CODE MEDIA_BUS_FMT_SRGGB10_1X10
@@ -892,17 +894,26 @@ static int imx214_parse_fwnode(struct device *dev)
 		goto done;
 	}
 
-	for (i = 0; i < bus_cfg.nr_of_link_frequencies; i++)
+	if (bus_cfg.nr_of_link_frequencies != 1)
+		dev_warn(dev, "Only one link-frequency supported, please review your DT. Continuing anyway\n");
+
+	for (i = 0; i < bus_cfg.nr_of_link_frequencies; i++) {
 		if (bus_cfg.link_frequencies[i] == IMX214_DEFAULT_LINK_FREQ)
 			break;
-
-	if (i == bus_cfg.nr_of_link_frequencies) {
-		dev_err(dev, "link-frequencies %d not supported, Please review your DT\n",
-			IMX214_DEFAULT_LINK_FREQ);
-		ret = -EINVAL;
-		goto done;
+		if (bus_cfg.link_frequencies[i] ==
+		    IMX214_DEFAULT_LINK_FREQ_LEGACY) {
+			dev_warn(dev,
+				 "link-frequencies %d not supported, please review your DT. Continuing anyway\n",
+				 IMX214_DEFAULT_LINK_FREQ);
+			break;
+		}
 	}
 
+	if (i == bus_cfg.nr_of_link_frequencies)
+		ret = dev_err_probe(dev, -EINVAL,
+				    "link-frequencies %d not supported, please review your DT\n",
+				    IMX214_DEFAULT_LINK_FREQ);
+
 done:
 	v4l2_fwnode_endpoint_free(&bus_cfg);
 	fwnode_handle_put(endpoint);
-- 
2.51.0


