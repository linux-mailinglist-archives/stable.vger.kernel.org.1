Return-Path: <stable+bounces-6590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9318F811121
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 13:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC65281A7F
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 12:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFE928E25;
	Wed, 13 Dec 2023 12:31:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from www.linuxtv.org (www.linuxtv.org [130.149.80.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF6610E
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 04:31:03 -0800 (PST)
Received: from hverkuil by www.linuxtv.org with local (Exim 4.92)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1rDOOC-005j4y-0O; Wed, 13 Dec 2023 12:31:00 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Wed, 13 Dec 2023 12:21:19 +0000
Subject: [git:media_stage/master] media: i2c: imx290: Properly encode registers as little-endian
To: linuxtv-commits@linuxtv.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Alexander Stein <alexander.stein@ew.tq-group.com>, stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1rDOOC-005j4y-0O@www.linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: i2c: imx290: Properly encode registers as little-endian
Author:  Alexander Stein <alexander.stein@ew.tq-group.com>
Date:    Thu Nov 2 10:50:48 2023 +0100

The conversion to CCI also converted the multi-byte register access to
big-endian. Correct the register definition by using the correct
little-endian ones.

Fixes: af73323b9770 ("media: imx290: Convert to new CCI register access helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
[Sakari Ailus: Fixed the Fixes: tag.]
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/i2c/imx290.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

---

diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
index 52ba6188911b..9967f3477433 100644
--- a/drivers/media/i2c/imx290.c
+++ b/drivers/media/i2c/imx290.c
@@ -41,18 +41,18 @@
 #define IMX290_WINMODE_720P				(1 << 4)
 #define IMX290_WINMODE_CROP				(4 << 4)
 #define IMX290_FR_FDG_SEL				CCI_REG8(0x3009)
-#define IMX290_BLKLEVEL					CCI_REG16(0x300a)
+#define IMX290_BLKLEVEL					CCI_REG16_LE(0x300a)
 #define IMX290_GAIN					CCI_REG8(0x3014)
-#define IMX290_VMAX					CCI_REG24(0x3018)
+#define IMX290_VMAX					CCI_REG24_LE(0x3018)
 #define IMX290_VMAX_MAX					0x3ffff
-#define IMX290_HMAX					CCI_REG16(0x301c)
+#define IMX290_HMAX					CCI_REG16_LE(0x301c)
 #define IMX290_HMAX_MAX					0xffff
-#define IMX290_SHS1					CCI_REG24(0x3020)
+#define IMX290_SHS1					CCI_REG24_LE(0x3020)
 #define IMX290_WINWV_OB					CCI_REG8(0x303a)
-#define IMX290_WINPV					CCI_REG16(0x303c)
-#define IMX290_WINWV					CCI_REG16(0x303e)
-#define IMX290_WINPH					CCI_REG16(0x3040)
-#define IMX290_WINWH					CCI_REG16(0x3042)
+#define IMX290_WINPV					CCI_REG16_LE(0x303c)
+#define IMX290_WINWV					CCI_REG16_LE(0x303e)
+#define IMX290_WINPH					CCI_REG16_LE(0x3040)
+#define IMX290_WINWH					CCI_REG16_LE(0x3042)
 #define IMX290_OUT_CTRL					CCI_REG8(0x3046)
 #define IMX290_ODBIT_10BIT				(0 << 0)
 #define IMX290_ODBIT_12BIT				(1 << 0)
@@ -78,28 +78,28 @@
 #define IMX290_ADBIT2					CCI_REG8(0x317c)
 #define IMX290_ADBIT2_10BIT				0x12
 #define IMX290_ADBIT2_12BIT				0x00
-#define IMX290_CHIP_ID					CCI_REG16(0x319a)
+#define IMX290_CHIP_ID					CCI_REG16_LE(0x319a)
 #define IMX290_ADBIT3					CCI_REG8(0x31ec)
 #define IMX290_ADBIT3_10BIT				0x37
 #define IMX290_ADBIT3_12BIT				0x0e
 #define IMX290_REPETITION				CCI_REG8(0x3405)
 #define IMX290_PHY_LANE_NUM				CCI_REG8(0x3407)
 #define IMX290_OPB_SIZE_V				CCI_REG8(0x3414)
-#define IMX290_Y_OUT_SIZE				CCI_REG16(0x3418)
-#define IMX290_CSI_DT_FMT				CCI_REG16(0x3441)
+#define IMX290_Y_OUT_SIZE				CCI_REG16_LE(0x3418)
+#define IMX290_CSI_DT_FMT				CCI_REG16_LE(0x3441)
 #define IMX290_CSI_DT_FMT_RAW10				0x0a0a
 #define IMX290_CSI_DT_FMT_RAW12				0x0c0c
 #define IMX290_CSI_LANE_MODE				CCI_REG8(0x3443)
-#define IMX290_EXTCK_FREQ				CCI_REG16(0x3444)
-#define IMX290_TCLKPOST					CCI_REG16(0x3446)
-#define IMX290_THSZERO					CCI_REG16(0x3448)
-#define IMX290_THSPREPARE				CCI_REG16(0x344a)
-#define IMX290_TCLKTRAIL				CCI_REG16(0x344c)
-#define IMX290_THSTRAIL					CCI_REG16(0x344e)
-#define IMX290_TCLKZERO					CCI_REG16(0x3450)
-#define IMX290_TCLKPREPARE				CCI_REG16(0x3452)
-#define IMX290_TLPX					CCI_REG16(0x3454)
-#define IMX290_X_OUT_SIZE				CCI_REG16(0x3472)
+#define IMX290_EXTCK_FREQ				CCI_REG16_LE(0x3444)
+#define IMX290_TCLKPOST					CCI_REG16_LE(0x3446)
+#define IMX290_THSZERO					CCI_REG16_LE(0x3448)
+#define IMX290_THSPREPARE				CCI_REG16_LE(0x344a)
+#define IMX290_TCLKTRAIL				CCI_REG16_LE(0x344c)
+#define IMX290_THSTRAIL					CCI_REG16_LE(0x344e)
+#define IMX290_TCLKZERO					CCI_REG16_LE(0x3450)
+#define IMX290_TCLKPREPARE				CCI_REG16_LE(0x3452)
+#define IMX290_TLPX					CCI_REG16_LE(0x3454)
+#define IMX290_X_OUT_SIZE				CCI_REG16_LE(0x3472)
 #define IMX290_INCKSEL7					CCI_REG8(0x3480)
 
 #define IMX290_PGCTRL_REGEN				BIT(0)

