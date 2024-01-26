Return-Path: <stable+bounces-16000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D4A83E64F
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4C51C21D8F
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF2455E66;
	Fri, 26 Jan 2024 23:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FQPwJiJg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D118423751
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 23:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310727; cv=none; b=G/cAorv5g+yrzIoTrEX0hLSIPNwuNJetBp9RTOl0iQGcvZXe9pSpXiLGi7LkP4svOKDgQhARwa5D67L8UrI33FRy4qV/+iClnRJOA3F1DCsz092WB7Ma/q/QDHv5WHFSnf+nnr4PSZgV9FvG7Wj+CZAMejcjCof6PYRYXpWG2j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310727; c=relaxed/simple;
	bh=bpuEo9WWA/Fc/abBZHfJix4j0nEhaP+9asFQXWA+6jI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gpV48O7ZOATcU/oTrNjzhlpF4wL1x3DJSDaLmgC3Jddkux/qsqRV48xr9o158/SuawiOy+y6PZqn+1fnJ11sEAl+wqPK+WxuYizG524TFsZ62VCkQe7AxemiQNsjAwe+PNATnncQXbgtntfJGFh+2+VMcZh44HaXktnG8zdPFe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FQPwJiJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3A6C433F1;
	Fri, 26 Jan 2024 23:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706310727;
	bh=bpuEo9WWA/Fc/abBZHfJix4j0nEhaP+9asFQXWA+6jI=;
	h=Subject:To:Cc:From:Date:From;
	b=FQPwJiJgJmTUfjGY5KCdvuQM/Fh0s7L1MFVAwAWFQy5p1xZMb6gHxYoHPTb00ynD4
	 AstjCalFIAU9iCLUZSv1fhul6cZLedIiSH8iIMGixoFhgX01TpiyH2SUHLegHaToCT
	 ww9m7g9YBO25wOrphtq5JboSFr3Uq6x5g4KgcP84=
Subject: FAILED: patch "[PATCH] media: v4l2-cci: Add support for little-endian encoded" failed to apply to 6.7-stable tree
To: alexander.stein@ew.tq-group.com,hdegoede@redhat.com,hverkuil-cisco@xs4all.nl,laurent.pinchart@ideasonboard.com,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 15:12:06 -0800
Message-ID: <2024012606-frill-unheated-ca08@gregkh>
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
git cherry-pick -x d92e7a013ff33f4e0b31bbf768d0c85a8acefebf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012606-frill-unheated-ca08@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

d92e7a013ff3 ("media: v4l2-cci: Add support for little-endian encoded registers")
cd93cc245dfe ("media: v4l: cci: Add macros to obtain register width and address")
eba5058633b4 ("media: v4l: cci: Include linux/bits.h")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d92e7a013ff33f4e0b31bbf768d0c85a8acefebf Mon Sep 17 00:00:00 2001
From: Alexander Stein <alexander.stein@ew.tq-group.com>
Date: Thu, 2 Nov 2023 10:50:47 +0100
Subject: [PATCH] media: v4l2-cci: Add support for little-endian encoded
 registers

Some sensors, e.g. Sony IMX290, are using little-endian registers. Add
support for those by encoding the endianness into Bit 20 of the register
address.

Fixes: af73323b9770 ("media: imx290: Convert to new CCI register access helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
[Sakari Ailus: Fixed commit message.]
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

diff --git a/drivers/media/v4l2-core/v4l2-cci.c b/drivers/media/v4l2-core/v4l2-cci.c
index 3179160abde3..10005c80f43b 100644
--- a/drivers/media/v4l2-core/v4l2-cci.c
+++ b/drivers/media/v4l2-core/v4l2-cci.c
@@ -18,6 +18,7 @@
 
 int cci_read(struct regmap *map, u32 reg, u64 *val, int *err)
 {
+	bool little_endian;
 	unsigned int len;
 	u8 buf[8];
 	int ret;
@@ -25,6 +26,7 @@ int cci_read(struct regmap *map, u32 reg, u64 *val, int *err)
 	if (err && *err)
 		return *err;
 
+	little_endian = reg & CCI_REG_LE;
 	len = CCI_REG_WIDTH_BYTES(reg);
 	reg = CCI_REG_ADDR(reg);
 
@@ -40,16 +42,28 @@ int cci_read(struct regmap *map, u32 reg, u64 *val, int *err)
 		*val = buf[0];
 		break;
 	case 2:
-		*val = get_unaligned_be16(buf);
+		if (little_endian)
+			*val = get_unaligned_le16(buf);
+		else
+			*val = get_unaligned_be16(buf);
 		break;
 	case 3:
-		*val = get_unaligned_be24(buf);
+		if (little_endian)
+			*val = get_unaligned_le24(buf);
+		else
+			*val = get_unaligned_be24(buf);
 		break;
 	case 4:
-		*val = get_unaligned_be32(buf);
+		if (little_endian)
+			*val = get_unaligned_le32(buf);
+		else
+			*val = get_unaligned_be32(buf);
 		break;
 	case 8:
-		*val = get_unaligned_be64(buf);
+		if (little_endian)
+			*val = get_unaligned_le64(buf);
+		else
+			*val = get_unaligned_be64(buf);
 		break;
 	default:
 		dev_err(regmap_get_device(map), "Error invalid reg-width %u for reg 0x%04x\n",
@@ -68,6 +82,7 @@ EXPORT_SYMBOL_GPL(cci_read);
 
 int cci_write(struct regmap *map, u32 reg, u64 val, int *err)
 {
+	bool little_endian;
 	unsigned int len;
 	u8 buf[8];
 	int ret;
@@ -75,6 +90,7 @@ int cci_write(struct regmap *map, u32 reg, u64 val, int *err)
 	if (err && *err)
 		return *err;
 
+	little_endian = reg & CCI_REG_LE;
 	len = CCI_REG_WIDTH_BYTES(reg);
 	reg = CCI_REG_ADDR(reg);
 
@@ -83,16 +99,28 @@ int cci_write(struct regmap *map, u32 reg, u64 val, int *err)
 		buf[0] = val;
 		break;
 	case 2:
-		put_unaligned_be16(val, buf);
+		if (little_endian)
+			put_unaligned_le16(val, buf);
+		else
+			put_unaligned_be16(val, buf);
 		break;
 	case 3:
-		put_unaligned_be24(val, buf);
+		if (little_endian)
+			put_unaligned_le24(val, buf);
+		else
+			put_unaligned_be24(val, buf);
 		break;
 	case 4:
-		put_unaligned_be32(val, buf);
+		if (little_endian)
+			put_unaligned_le32(val, buf);
+		else
+			put_unaligned_be32(val, buf);
 		break;
 	case 8:
-		put_unaligned_be64(val, buf);
+		if (little_endian)
+			put_unaligned_le64(val, buf);
+		else
+			put_unaligned_be64(val, buf);
 		break;
 	default:
 		dev_err(regmap_get_device(map), "Error invalid reg-width %u for reg 0x%04x\n",
diff --git a/include/media/v4l2-cci.h b/include/media/v4l2-cci.h
index 406772a4e32e..4e96e90ee636 100644
--- a/include/media/v4l2-cci.h
+++ b/include/media/v4l2-cci.h
@@ -43,12 +43,17 @@ struct cci_reg_sequence {
 #define CCI_REG_WIDTH_BYTES(x)		FIELD_GET(CCI_REG_WIDTH_MASK, x)
 #define CCI_REG_WIDTH(x)		(CCI_REG_WIDTH_BYTES(x) << 3)
 #define CCI_REG_ADDR(x)			FIELD_GET(CCI_REG_ADDR_MASK, x)
+#define CCI_REG_LE			BIT(20)
 
 #define CCI_REG8(x)			((1 << CCI_REG_WIDTH_SHIFT) | (x))
 #define CCI_REG16(x)			((2 << CCI_REG_WIDTH_SHIFT) | (x))
 #define CCI_REG24(x)			((3 << CCI_REG_WIDTH_SHIFT) | (x))
 #define CCI_REG32(x)			((4 << CCI_REG_WIDTH_SHIFT) | (x))
 #define CCI_REG64(x)			((8 << CCI_REG_WIDTH_SHIFT) | (x))
+#define CCI_REG16_LE(x)			(CCI_REG_LE | (2U << CCI_REG_WIDTH_SHIFT) | (x))
+#define CCI_REG24_LE(x)			(CCI_REG_LE | (3U << CCI_REG_WIDTH_SHIFT) | (x))
+#define CCI_REG32_LE(x)			(CCI_REG_LE | (4U << CCI_REG_WIDTH_SHIFT) | (x))
+#define CCI_REG64_LE(x)			(CCI_REG_LE | (8U << CCI_REG_WIDTH_SHIFT) | (x))
 
 /**
  * cci_read() - Read a value from a single CCI register


