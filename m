Return-Path: <stable+bounces-94632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A209D6467
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 20:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B0E283462
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 19:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB371DF250;
	Fri, 22 Nov 2024 19:07:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395001632C9
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 19:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732302450; cv=none; b=AuaUQw+25SW/I2Po6o81FPq2gW7PoxYUn2LTCP/k768Eqw2DjjUFOKdUPjXtYARSzQv40amDYC9STelHPohlbpMALql/F8n9p3xsSEJ4P22z2etU6SeK6iWKTYvPDoEgIW8gn4LjgVJsdEFeZtLhZXxTJMsvy5tkgBXDYslo1yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732302450; c=relaxed/simple;
	bh=rj8oaKqavdn8ZuuGIHe/zuWcG/wwuIthrYkaB9p/GtI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hvJWMjTsItw+HxBRLSlwyYUM4xK4Suq/McUSP5D9yxtGfcQkQEvq1kMFwWzEc/5OHCSBIpAkUGtYVosMZ+i76Pfrf59VyDWRe1SmF9TDNWJ139dVBVGw73Mvvdqs3rvb4IgdPHyoA8Clft3AUW6JEW+h5tc+CQRhHM+7dtm5trw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 6D21D233A5;
	Fri, 22 Nov 2024 22:07:19 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Cc: lvc-project@linuxtesting.org,
	nickel@altlinux.org,
	dutyrok@altlinux.org,
	gerben@altlinux.org,
	kovalev@altlinux.org
Subject: [PATCH 5.10.y] scsi: core: Fix scsi_mode_sense() buffer length handling
Date: Fri, 22 Nov 2024 22:07:02 +0300
Message-Id: <20241122190702.230010-2-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20241122190702.230010-1-kovalev@altlinux.org>
References: <20241122190702.230010-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Damien Le Moal <damien.lemoal@wdc.com>

commit 17b49bcbf8351d3dbe57204468ac34f033ed60bc upstream.

Several problems exist with scsi_mode_sense() buffer length handling:

 1) The allocation length field of the MODE SENSE(10) command is 16-bits,
    occupying bytes 7 and 8 of the CDB. With this command, access to mode
    pages larger than 255 bytes is thus possible. However, the CDB
    allocation length field is set by assigning len to byte 8 only, thus
    truncating buffer length larger than 255.

 2) If scsi_mode_sense() is called with len smaller than 8 with
    sdev->use_10_for_ms set, or smaller than 4 otherwise, the buffer length
    is increased to 8 and 4 respectively, and the buffer is zero filled
    with these increased values, thus corrupting the memory following the
    buffer.

Fix these 2 problems by using put_unaligned_be16() to set the allocation
length field of MODE SENSE(10) CDB and by returning an error when len is
too small.

Furthermore, if len is larger than 255B, always try MODE SENSE(10) first,
even if the device driver did not set sdev->use_10_for_ms. In case of
invalid opcode error for MODE SENSE(10), access to mode pages larger than
255 bytes are not retried using MODE SENSE(6). To avoid buffer length
overflows for the MODE_SENSE(10) case, check that len is smaller than 65535
bytes.

While at it, also fix the folowing:

 * Use get_unaligned_be16() to retrieve the mode data length and block
   descriptor length fields of the mode sense reply header instead of using
   an open coded calculation.

 * Fix the kdoc dbd argument explanation: the DBD bit stands for Disable
   Block Descriptor, which is the opposite of what the dbd argument
   description was.

Link: https://lore.kernel.org/r/20210820070255.682775-2-damien.lemoal@wdc.com
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/scsi/scsi_lib.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 64ae7bc2de604..0a9db3464fd48 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2068,7 +2068,7 @@ EXPORT_SYMBOL_GPL(scsi_mode_select);
 /**
  *	scsi_mode_sense - issue a mode sense, falling back from 10 to six bytes if necessary.
  *	@sdev:	SCSI device to be queried
- *	@dbd:	set if mode sense will allow block descriptors to be returned
+ *	@dbd:	set to prevent mode sense from returning block descriptors
  *	@modepage: mode page being requested
  *	@buffer: request buffer (may not be smaller than eight bytes)
  *	@len:	length of request buffer.
@@ -2103,18 +2103,18 @@ scsi_mode_sense(struct scsi_device *sdev, int dbd, int modepage,
 		sshdr = &my_sshdr;
 
  retry:
-	use_10_for_ms = sdev->use_10_for_ms;
+	use_10_for_ms = sdev->use_10_for_ms || len > 255;
 
 	if (use_10_for_ms) {
-		if (len < 8)
-			len = 8;
+		if (len < 8 || len > 65535)
+			return -EINVAL;
 
 		cmd[0] = MODE_SENSE_10;
-		cmd[8] = len;
+		put_unaligned_be16(len, &cmd[7]);
 		header_length = 8;
 	} else {
 		if (len < 4)
-			len = 4;
+			return -EINVAL;
 
 		cmd[0] = MODE_SENSE;
 		cmd[4] = len;
@@ -2139,8 +2139,14 @@ scsi_mode_sense(struct scsi_device *sdev, int dbd, int modepage,
 			if ((sshdr->sense_key == ILLEGAL_REQUEST) &&
 			    (sshdr->asc == 0x20) && (sshdr->ascq == 0)) {
 				/*
-				 * Invalid command operation code
+				 * Invalid command operation code: retry using
+				 * MODE SENSE(6) if this was a MODE SENSE(10)
+				 * request, except if the request mode page is
+				 * too large for MODE SENSE single byte
+				 * allocation length field.
 				 */
+				if (len > 255)
+					return -EIO;
 				sdev->use_10_for_ms = 0;
 				goto retry;
 			}
@@ -2158,12 +2164,11 @@ scsi_mode_sense(struct scsi_device *sdev, int dbd, int modepage,
 			data->longlba = 0;
 			data->block_descriptor_length = 0;
 		} else if (use_10_for_ms) {
-			data->length = buffer[0]*256 + buffer[1] + 2;
+			data->length = get_unaligned_be16(&buffer[0]) + 2;
 			data->medium_type = buffer[2];
 			data->device_specific = buffer[3];
 			data->longlba = buffer[4] & 0x01;
-			data->block_descriptor_length = buffer[6]*256
-				+ buffer[7];
+			data->block_descriptor_length = get_unaligned_be16(&buffer[6]);
 		} else {
 			data->length = buffer[0] + 1;
 			data->medium_type = buffer[1];
-- 
2.33.8


