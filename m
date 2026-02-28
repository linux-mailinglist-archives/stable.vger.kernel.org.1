Return-Path: <stable+bounces-220655-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNnTIshRo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220655-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:36:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5C61C8702
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7017C3301537
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925563F12E6;
	Sat, 28 Feb 2026 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KB9TWycq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E9C3F12DB;
	Sat, 28 Feb 2026 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300536; cv=none; b=s89dG/y6GxBq/ghMP/cC/DFhAap4DDflbhfF5/h5flAowE0NbVde2dopjn+sXpWj3hlesrWcwhFcheATX5KeWuc0smQmIorjbss4IRP5ludBZiMdcKPmqj7Trlw3FT0ObfVxmx9p6kX77qWfSeq8FCw4H4x4sSn9r3a4Pw/BzSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300536; c=relaxed/simple;
	bh=IeEKI5M4X0R0nj1w52Z4QhE2K1LzmG7yNEma1ec3+jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3f3cT4c+FCHCCeYm7UyK5Kvi+lsMhpHJ2bPNjn0am8sxouXm0zHT1yChR/sS+NLU5TnqID/ylPpLoWw4VB8EXDWjVQfIDsFRh2FpaUkMW77Ln23Etuq4ZZhXr+B8fIXeY+v8ZLZaiNd5AE96ldKYxO6OdY1cX84thWQaajB8VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KB9TWycq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70425C19424;
	Sat, 28 Feb 2026 17:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300536;
	bh=IeEKI5M4X0R0nj1w52Z4QhE2K1LzmG7yNEma1ec3+jM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KB9TWycqCaNR2m+9090WGVLscCLRzkl9VdjLZL8mdv1o+F31/voPk+oqrELq/k97S
	 W8zdhV1St8INFXKoUH8OjgYDUkI5s0YOmZWrEBr4vZBXTWv1sRKEf1S9Aetpd2TI8v
	 tIMDlv7uI+tF6Wy6gDBCIuQiqhqmXVrQiZYKDYMM8/Bj5euKOupny8ixGzuXT8icgM
	 tzd1/7KG70i9TbveJNv54L13du3evRLXCBtn4HCK8tdbF4OCzaVn/yLPjCz75LrZd5
	 up7VqaErFvBhZEdW5PZSMPTR3WQxTdZPzFED228PG0B4UD9YNKBBlISipdE3bNkX5Y
	 CqSh4zmu88vmw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 576/844] media: i2c: ov01a10: Fix the horizontal flip control
Date: Sat, 28 Feb 2026 12:28:09 -0500
Message-ID: <20260228173244.1509663-577-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220655-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7D5C61C8702
X-Rspamd-Action: no action

From: Hans de Goede <hansg@kernel.org>

[ Upstream commit ada20c3db0db4f2834d9515f6105111871f04a4d ]

During sensor calibration I noticed that with the hflip control set
to false/disabled the image was mirrored.

So it seems that the horizontal flip control is inverted and needs to
be set to 1 to not flip (just like the similar problem recently fixed
on the ov08x40 sensor).

Invert the hflip control to fix the sensor mirroring by default.

As the comment above the newly added OV01A10_MEDIA_BUS_FMT define explains
the control being inverted also means that the native Bayer-order of
the sensor actually is GBRG not BGGR, but so as to not break userspace
the Bayer-order is kept at BGGR.

Fixes: 0827b58dabff ("media: i2c: add ov01a10 image sensor driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hansg@kernel.org>
Tested-by: Mehdi Djait <mehdi.djait@linux.intel.com> # Dell XPS 9315
Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov01a10.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/media/i2c/ov01a10.c b/drivers/media/i2c/ov01a10.c
index 141cb6f75b555..e5df01f979781 100644
--- a/drivers/media/i2c/ov01a10.c
+++ b/drivers/media/i2c/ov01a10.c
@@ -75,6 +75,15 @@
 #define OV01A10_REG_X_WIN		0x3811
 #define OV01A10_REG_Y_WIN		0x3813
 
+/*
+ * The native ov01a10 bayer-pattern is GBRG, but there was a driver bug enabling
+ * hflip/mirroring by default resulting in BGGR. Because of this bug Intel's
+ * proprietary IPU6 userspace stack expects BGGR. So we report BGGR to not break
+ * userspace and fix things up by shifting the crop window-x coordinate by 1
+ * when hflip is *disabled*.
+ */
+#define OV01A10_MEDIA_BUS_FMT		MEDIA_BUS_FMT_SBGGR10_1X10
+
 struct ov01a10_reg {
 	u16 address;
 	u8 val;
@@ -185,14 +194,14 @@ static const struct ov01a10_reg sensor_1280x800_setting[] = {
 	{0x380e, 0x03},
 	{0x380f, 0x80},
 	{0x3810, 0x00},
-	{0x3811, 0x08},
+	{0x3811, 0x09},
 	{0x3812, 0x00},
 	{0x3813, 0x08},
 	{0x3814, 0x01},
 	{0x3815, 0x01},
 	{0x3816, 0x01},
 	{0x3817, 0x01},
-	{0x3820, 0xa0},
+	{0x3820, 0xa8},
 	{0x3822, 0x13},
 	{0x3832, 0x28},
 	{0x3833, 0x10},
@@ -411,7 +420,7 @@ static int ov01a10_set_hflip(struct ov01a10 *ov01a10, u32 hflip)
 	int ret;
 	u32 val, offset;
 
-	offset = hflip ? 0x9 : 0x8;
+	offset = hflip ? 0x8 : 0x9;
 	ret = ov01a10_write_reg(ov01a10, OV01A10_REG_X_WIN, 1, offset);
 	if (ret)
 		return ret;
@@ -420,8 +429,8 @@ static int ov01a10_set_hflip(struct ov01a10 *ov01a10, u32 hflip)
 	if (ret)
 		return ret;
 
-	val = hflip ? val | FIELD_PREP(OV01A10_HFLIP_MASK, 0x1) :
-		val & ~OV01A10_HFLIP_MASK;
+	val = hflip ? val & ~OV01A10_HFLIP_MASK :
+		      val | FIELD_PREP(OV01A10_HFLIP_MASK, 0x1);
 
 	return ov01a10_write_reg(ov01a10, OV01A10_REG_FORMAT1, 1, val);
 }
@@ -610,7 +619,7 @@ static void ov01a10_update_pad_format(const struct ov01a10_mode *mode,
 {
 	fmt->width = mode->width;
 	fmt->height = mode->height;
-	fmt->code = MEDIA_BUS_FMT_SBGGR10_1X10;
+	fmt->code = OV01A10_MEDIA_BUS_FMT;
 	fmt->field = V4L2_FIELD_NONE;
 	fmt->colorspace = V4L2_COLORSPACE_RAW;
 }
@@ -751,7 +760,7 @@ static int ov01a10_enum_mbus_code(struct v4l2_subdev *sd,
 	if (code->index > 0)
 		return -EINVAL;
 
-	code->code = MEDIA_BUS_FMT_SBGGR10_1X10;
+	code->code = OV01A10_MEDIA_BUS_FMT;
 
 	return 0;
 }
@@ -761,7 +770,7 @@ static int ov01a10_enum_frame_size(struct v4l2_subdev *sd,
 				   struct v4l2_subdev_frame_size_enum *fse)
 {
 	if (fse->index >= ARRAY_SIZE(supported_modes) ||
-	    fse->code != MEDIA_BUS_FMT_SBGGR10_1X10)
+	    fse->code != OV01A10_MEDIA_BUS_FMT)
 		return -EINVAL;
 
 	fse->min_width = supported_modes[fse->index].width;
-- 
2.51.0


