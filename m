Return-Path: <stable+bounces-132973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 593BAA918DC
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B63DD7AC617
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6F722AE6B;
	Thu, 17 Apr 2025 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HOnCkiJN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA88B22576A
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884687; cv=none; b=WixhcUwQc7qJBqbX7olF55jC6Wsg+vlha3WN2fqI96VyHcVX9qJKgWEVMCAzL+vhP8TrqE81M58ksK1wVTiS2+aQ0MLumHhrMpEZYyPdd/PDoezugafYJXxFyhMD46CJuqbxRfZGCeUB/dJno3FRk7BDsBJ4HpJ4ldtA88rjjF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884687; c=relaxed/simple;
	bh=Lo5SdoixNVx/uR2Wr3GqXhbRn5VNxg1/+kJuS/1cdA8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DhfqvPyIxvFJLmjFcvIIxg2vMBz0yAzfYX6cuZWhCCpVgU/x15uLY+btNGgABlCiBwBI2PWYaDxh59Vp4H5C6igfK7WmQ22/VGgyCkqPwBwVah2Pn21Kf3GcgfngdB/YL2Iu4EYDhtMwq9MPKdQAjEK1hAC1PBmPN7ikL6w2ECo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HOnCkiJN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCE8C4CEEE;
	Thu, 17 Apr 2025 10:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744884687;
	bh=Lo5SdoixNVx/uR2Wr3GqXhbRn5VNxg1/+kJuS/1cdA8=;
	h=Subject:To:Cc:From:Date:From;
	b=HOnCkiJNs+EIT7gYNSphr1L+2DhtEEjxkZrTu26tak8K6/PcUj4uczD3nQNM8DF7h
	 9e0FJbap0Hbd1LFNq/Sv9x+b3Ha5SUrzwMtZRscr2wTwB9TS2fcne82EHq9wROh0SU
	 5fFcMRQMAjHtxXfp36/CMAEfoxyyxkta06iPigS8=
Subject: FAILED: patch "[PATCH] media: i2c: imx214: Fix link frequency validation" failed to apply to 6.1-stable tree
To: git@apitzsch.eu,hverkuil@xs4all.nl,ribalda@chromium.org,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 12:11:14 +0200
Message-ID: <2025041714-famished-unpleased-e24e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x acc294519f1749041e1b8c74d46bbf6c57d8b061
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041714-famished-unpleased-e24e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From acc294519f1749041e1b8c74d46bbf6c57d8b061 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>
Date: Fri, 20 Dec 2024 14:26:12 +0100
Subject: [PATCH] media: i2c: imx214: Fix link frequency validation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
index 4d7044cd9b7f..6c3f6f3c8b1f 100644
--- a/drivers/media/i2c/imx214.c
+++ b/drivers/media/i2c/imx214.c
@@ -31,7 +31,9 @@
 #define IMX214_REG_FAST_STANDBY_CTRL	CCI_REG8(0x0106)
 
 #define IMX214_DEFAULT_CLK_FREQ	24000000
-#define IMX214_DEFAULT_LINK_FREQ 480000000
+#define IMX214_DEFAULT_LINK_FREQ	600000000
+/* Keep wrong link frequency for backward compatibility */
+#define IMX214_DEFAULT_LINK_FREQ_LEGACY	480000000
 #define IMX214_DEFAULT_PIXEL_RATE ((IMX214_DEFAULT_LINK_FREQ * 8LL) / 10)
 #define IMX214_FPS 30
 
@@ -1225,18 +1227,26 @@ static int imx214_parse_fwnode(struct device *dev)
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
-		dev_err_probe(dev, -EINVAL,
-			      "link-frequencies %d not supported, Please review your DT\n",
-			      IMX214_DEFAULT_LINK_FREQ);
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


