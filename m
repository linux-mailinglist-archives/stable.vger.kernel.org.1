Return-Path: <stable+bounces-176219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 229FAB36BCB
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 488CDA01198
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D645A3568EC;
	Tue, 26 Aug 2025 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UH6XnaU0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924802676E9;
	Tue, 26 Aug 2025 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219089; cv=none; b=HrFRLpth186sHAasoHSLJKNnkOHuPLkrJ7t78FVhpl6DV8q3TzrJwc4GshaFLapy8CPaeQBIM2Dsbqxu2lKum3tbp/1EIIfPF9vFCHJZkCF7PrTO3fZfWztdOMyVFudO3kmM6Rnw8tKRImBXBf8g9Wo5Aas6E2JghpSfY2FYvNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219089; c=relaxed/simple;
	bh=7HfNW/cfnHS+UwWudJQqh0Ln1U8csKf0J6d8Ppbhpec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJbloDroDHNLBre1228YDBrgNNN3grlJwuDFJKbFDgghWC/N2oJoLC8qglTsXe5DvuYHP6YDbPj08d2MEj/v2pXtV4oMIiwXYof30IZsG0gP+j6HwAwkx68Z1x80QugeQUWpETnY7ZhUxSwYA57rPEoiDJ7jpXmhmpl7BmzGlaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UH6XnaU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E40C4CEF1;
	Tue, 26 Aug 2025 14:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756219089;
	bh=7HfNW/cfnHS+UwWudJQqh0Ln1U8csKf0J6d8Ppbhpec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UH6XnaU0Lq2VnmxJ3JdUx3h2Rp6275a+CqyWhp+/slfReKsCXjozyfSnS8Qd3tMId
	 iGoOxy0ABal5aDOfFU7nUH1d/pWVSYsTAn/U5oHNcJMWAL5Z824rfh7twjoAJRDQ/x
	 cRFaxQZx9kBow4VJAfriKYsqX6LloHs8N2+8YSYo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 247/403] media: tc358743: Check I2C succeeded during probe
Date: Tue, 26 Aug 2025 13:09:33 +0200
Message-ID: <20250826110913.646430199@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110905.607690791@linuxfoundation.org>
References: <20250826110905.607690791@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

[ Upstream commit 303d81635e1d9c949b370215cc94526ed81f2e3d ]

The probe for the TC358743 reads the CHIPID register from
the device and compares it to the expected value of 0.
If the I2C request fails then that also returns 0, so
the driver loads thinking that the device is there.

Generally I2C communications are reliable so there is
limited need to check the return value on every transfer,
therefore only amend the one read during probe to check
for I2C errors.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/tc358743.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
index f4ebe93a495c..ce54d963457d 100644
--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -110,7 +110,7 @@ static inline struct tc358743_state *to_state(struct v4l2_subdev *sd)
 
 /* --------------- I2C --------------- */
 
-static void i2c_rd(struct v4l2_subdev *sd, u16 reg, u8 *values, u32 n)
+static int i2c_rd(struct v4l2_subdev *sd, u16 reg, u8 *values, u32 n)
 {
 	struct tc358743_state *state = to_state(sd);
 	struct i2c_client *client = state->i2c_client;
@@ -136,6 +136,7 @@ static void i2c_rd(struct v4l2_subdev *sd, u16 reg, u8 *values, u32 n)
 		v4l2_err(sd, "%s: reading register 0x%x from 0x%x failed\n",
 				__func__, reg, client->addr);
 	}
+	return err != ARRAY_SIZE(msgs);
 }
 
 static void i2c_wr(struct v4l2_subdev *sd, u16 reg, u8 *values, u32 n)
@@ -192,15 +193,24 @@ static void i2c_wr(struct v4l2_subdev *sd, u16 reg, u8 *values, u32 n)
 	}
 }
 
-static noinline u32 i2c_rdreg(struct v4l2_subdev *sd, u16 reg, u32 n)
+static noinline u32 i2c_rdreg_err(struct v4l2_subdev *sd, u16 reg, u32 n,
+				  int *err)
 {
+	int error;
 	__le32 val = 0;
 
-	i2c_rd(sd, reg, (u8 __force *)&val, n);
+	error = i2c_rd(sd, reg, (u8 __force *)&val, n);
+	if (err)
+		*err = error;
 
 	return le32_to_cpu(val);
 }
 
+static inline u32 i2c_rdreg(struct v4l2_subdev *sd, u16 reg, u32 n)
+{
+	return i2c_rdreg_err(sd, reg, n, NULL);
+}
+
 static noinline void i2c_wrreg(struct v4l2_subdev *sd, u16 reg, u32 val, u32 n)
 {
 	__le32 raw = cpu_to_le32(val);
@@ -229,6 +239,13 @@ static u16 i2c_rd16(struct v4l2_subdev *sd, u16 reg)
 	return i2c_rdreg(sd, reg, 2);
 }
 
+static int i2c_rd16_err(struct v4l2_subdev *sd, u16 reg, u16 *value)
+{
+	int err;
+	*value = i2c_rdreg_err(sd, reg, 2, &err);
+	return err;
+}
+
 static void i2c_wr16(struct v4l2_subdev *sd, u16 reg, u16 val)
 {
 	i2c_wrreg(sd, reg, val, 2);
@@ -2041,6 +2058,7 @@ static int tc358743_probe(struct i2c_client *client)
 	struct tc358743_platform_data *pdata = client->dev.platform_data;
 	struct v4l2_subdev *sd;
 	u16 irq_mask = MASK_HDMI_MSK | MASK_CSI_MSK;
+	u16 chipid;
 	int err;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
@@ -2072,7 +2090,8 @@ static int tc358743_probe(struct i2c_client *client)
 	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS;
 
 	/* i2c access */
-	if ((i2c_rd16(sd, CHIPID) & MASK_CHIPID) != 0) {
+	if (i2c_rd16_err(sd, CHIPID, &chipid) ||
+	    (chipid & MASK_CHIPID) != 0) {
 		v4l2_info(sd, "not a TC358743 on address 0x%x\n",
 			  client->addr << 1);
 		return -ENODEV;
-- 
2.39.5




