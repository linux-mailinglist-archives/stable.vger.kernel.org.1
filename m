Return-Path: <stable+bounces-16006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7556B83E6FC
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1974DB23B68
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B1733090;
	Fri, 26 Jan 2024 23:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nEBQRdts"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CAF56779
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 23:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706311889; cv=none; b=Pz6+I83D/DxDsPpOq04QcGL8pmxgQmKMXzlfWxwBq6aNn4NrRpBuvHi2+qMtkY2BIxavROh3XLzZk3RFZVcwsgr5BaKSjheJkSmBOFeGNz+e/qciaD1BXvCV5mT5LL3ydpDJdYc9ChEnQkHUweYv2hoAS9fk/ZyMbs+iC1QrQzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706311889; c=relaxed/simple;
	bh=V6ixbqLlhsvD5dZrQ05NmxvRgwPG2Xx+bu0EQ2dhJrk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sCxUexTfNP6Lk+z60Bjc9O4xWC7AzzjPG9Cit8BWPU+J/8HB+v5g7FiL5UE2wXKV1+hUkVn27pOOP24DGiY+fegW+Td93gIcXS0UNGl8m1CzvY2bAXYpWh1Mm98+gBhD2rQzbyxEqqpEJm9XH8OfAuV3/AM4B29GYYR37yPcwYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nEBQRdts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8BEC433F1;
	Fri, 26 Jan 2024 23:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706311888;
	bh=V6ixbqLlhsvD5dZrQ05NmxvRgwPG2Xx+bu0EQ2dhJrk=;
	h=Subject:To:Cc:From:Date:From;
	b=nEBQRdtso5X78x44M+4qDtrPjG85M4K0YMRYNbuhfLbE3YA3jk7QZ54pqB5zXQTvR
	 qULc5BMrf7Zj/UAuZvST7ueMp5hqFKa3iPY3rejmqdKHiFe+YhVw0MUcbiCF03cCHQ
	 3AxibekIKMu21ZRoWNEpnJnlyxPN2oGcmdZ8PiWE=
Subject: FAILED: patch "[PATCH] media: i2c: imx290: Properly encode registers as" failed to apply to 6.7-stable tree
To: alexander.stein@ew.tq-group.com,hdegoede@redhat.com,hverkuil-cisco@xs4all.nl,laurent.pinchart@ideasonboard.com,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 15:31:27 -0800
Message-ID: <2024012627-siesta-magnetic-bcd0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x 60fc87a69523c294eb23a1316af922f6665a6f8c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012627-siesta-magnetic-bcd0@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

60fc87a69523 ("media: i2c: imx290: Properly encode registers as little-endian")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 60fc87a69523c294eb23a1316af922f6665a6f8c Mon Sep 17 00:00:00 2001
From: Alexander Stein <alexander.stein@ew.tq-group.com>
Date: Thu, 2 Nov 2023 10:50:48 +0100
Subject: [PATCH] media: i2c: imx290: Properly encode registers as
 little-endian

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


