Return-Path: <stable+bounces-137938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E013AA15FF
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92BA9A20EE
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0587D2522B4;
	Tue, 29 Apr 2025 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="whCXxPc8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A382517BE;
	Tue, 29 Apr 2025 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947591; cv=none; b=t1pfv3foK7+rAxnJPxIpWdf6uO8MzsRVIVdXgmF9xXQit+AfGu3PPl6feNEqmrHg1Za1kDR8CbyDidhyvhPX2mn4BdsnxdwWcJwm8pji/t4/tp63p+2wll/UqHZrVcaIHuKCqgY/9/vKiCdsC+1J9VT5IeXIQpK1If8y7SrSaAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947591; c=relaxed/simple;
	bh=7GOPtIgRHNfkCDsBtf+mY0OmAxHKKW31Vrsa9nqP2AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5d1u4QbMjl+/WIyMyoVXR12oo90+iopMVdkO8RLqaPI6L/+FSuVczv9zCbZvR+yZS8/kAMxByt3bhjNZZkKTYlYPxEbzJQaDoR+lC2+Ke+37b2bND+fJKPNB40y3wS1+h0+oF44Hk4vT1L+Jq3wEOAuwef07Fg0lA9K8IlrMtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=whCXxPc8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBD4C4CEE3;
	Tue, 29 Apr 2025 17:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745947591;
	bh=7GOPtIgRHNfkCDsBtf+mY0OmAxHKKW31Vrsa9nqP2AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=whCXxPc8XgIlvOiKhEJ3JHS3bUcbALTmJ2KP3v0KLS+3HTfwFF5jES1Zy8vKj4ymZ
	 dE5fluGmGAdcM31Z0MNCbYH0Ftt4rIZMTGfTeFAyp+rfC3IRU2Ww7tf2bJmaoHtYWI
	 EVTN2rlGL21Jkn7cLGcApUH0FTJzgPUcH+sCnI78=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bryan ODonoghue <bryan.odonoghue@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 015/280] media: ov08x40: Move ov08x40_identify_module() function up
Date: Tue, 29 Apr 2025 18:39:16 +0200
Message-ID: <20250429161115.705483103@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>
References: <20250429161115.008747050@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 7a39639e448f070cbe37317ac922886b6080ff43 ]

Move the ov08x40_identify_module() function to above ov08x40_set_stream()
this is a preparation patch for adding a missing ov08x40_identify_module()
call to ov08x40_set_stream().

No functional changes, just moving code around.

Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Stable-dep-of: ebf185efadb7 ("media: ov08x40: Add missing ov08x40_identify_module() call on stream-start")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov08x40.c | 52 ++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/media/i2c/ov08x40.c b/drivers/media/i2c/ov08x40.c
index 67b86dabc67eb..8b9c70dd70b88 100644
--- a/drivers/media/i2c/ov08x40.c
+++ b/drivers/media/i2c/ov08x40.c
@@ -1869,6 +1869,32 @@ static int ov08x40_stop_streaming(struct ov08x40 *ov08x)
 				 OV08X40_REG_VALUE_08BIT, OV08X40_MODE_STANDBY);
 }
 
+/* Verify chip ID */
+static int ov08x40_identify_module(struct ov08x40 *ov08x)
+{
+	struct i2c_client *client = v4l2_get_subdevdata(&ov08x->sd);
+	int ret;
+	u32 val;
+
+	if (ov08x->identified)
+		return 0;
+
+	ret = ov08x40_read_reg(ov08x, OV08X40_REG_CHIP_ID,
+			       OV08X40_REG_VALUE_24BIT, &val);
+	if (ret)
+		return ret;
+
+	if (val != OV08X40_CHIP_ID) {
+		dev_err(&client->dev, "chip id mismatch: %x!=%x\n",
+			OV08X40_CHIP_ID, val);
+		return -ENXIO;
+	}
+
+	ov08x->identified = true;
+
+	return 0;
+}
+
 static int ov08x40_set_stream(struct v4l2_subdev *sd, int enable)
 {
 	struct ov08x40 *ov08x = to_ov08x40(sd);
@@ -1906,32 +1932,6 @@ static int ov08x40_set_stream(struct v4l2_subdev *sd, int enable)
 	return ret;
 }
 
-/* Verify chip ID */
-static int ov08x40_identify_module(struct ov08x40 *ov08x)
-{
-	struct i2c_client *client = v4l2_get_subdevdata(&ov08x->sd);
-	int ret;
-	u32 val;
-
-	if (ov08x->identified)
-		return 0;
-
-	ret = ov08x40_read_reg(ov08x, OV08X40_REG_CHIP_ID,
-			       OV08X40_REG_VALUE_24BIT, &val);
-	if (ret)
-		return ret;
-
-	if (val != OV08X40_CHIP_ID) {
-		dev_err(&client->dev, "chip id mismatch: %x!=%x\n",
-			OV08X40_CHIP_ID, val);
-		return -ENXIO;
-	}
-
-	ov08x->identified = true;
-
-	return 0;
-}
-
 static const struct v4l2_subdev_video_ops ov08x40_video_ops = {
 	.s_stream = ov08x40_set_stream,
 };
-- 
2.39.5




