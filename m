Return-Path: <stable+bounces-94635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B069D64A5
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 20:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DC67B22C8F
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 19:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DCD1DE4E4;
	Fri, 22 Nov 2024 19:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtoSPed9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DE8158DA3
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 19:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732304396; cv=none; b=hx9EsIeMm98x19f15SBAvxhYAbeGjGtwea+weQRNQLaReW0EjQF+Zogs2TcnJ7mBZyp7swD0TduOkEnDUtrI3HrM+DFRmWpobTtvU4s53JQSF3TAmw1ow67390nYqjYFdwSwTCcq2IZFDRRiXCDz9XpqGlaKUty7GjX15Nk/nV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732304396; c=relaxed/simple;
	bh=q8CIqHww585PWMBfeBnAtTPkgJ0RvruHPjm+w85wXXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYbWNHmV9LsdIY+CY/NHqkMXrrfQdvXV34EptiqnNsR8bdVeVTqGaEHDDd3R164twK1r0aAeDuJcHdDej3qtByvckPcs2F9je5h84H3P6dc7qZ+pOmcezRLNMvMI79t3ReqRieceg1PjaigNFPrdUs9uDSo8wwUlGnAlTU39S7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtoSPed9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF1CC4CECE;
	Fri, 22 Nov 2024 19:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732304396;
	bh=q8CIqHww585PWMBfeBnAtTPkgJ0RvruHPjm+w85wXXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WtoSPed9QMLVOxHrwtxWJawIOFjOiORea1C8UogZ1mEEERtOp//L58Ucan/gNWIl8
	 hWk5DTvB2Qhl5LUbigjnP1k/S/0yW019LMeWxR0UAt+bn5++L14wTfED4hEaM3caOh
	 QDS0owGlQFMdDrlUqct0HzfX6/YAPjQV/TbiVGqfdruU+KxBGHJD0Gd9L8Zpb72UwZ
	 74NumN6eR0EEovF8n4dbIa0GDvOjdzYRkumrAylx1pQIURsGQWADlMguGWdRT/cxhN
	 /eumU5V5uz4s+Pj5vAhlm8Rwpmhfwe1cH0BafXBhJGByfruh3Fg5JuMeKN3XnaG6wZ
	 GBK6uvVVju3Kg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vasiliy Kovalev <kovalev@altlinux.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] scsi: core: Fix scsi_mode_sense() buffer length handling
Date: Fri, 22 Nov 2024 14:39:54 -0500
Message-ID: <20241122143809-33d114b3a6eaee8b@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241122190702.230010-2-kovalev@altlinux.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 17b49bcbf8351d3dbe57204468ac34f033ed60bc

WARNING: Author mismatch between patch and upstream commit:
Backport author: Vasiliy Kovalev <kovalev@altlinux.org>
Commit author: Damien Le Moal <damien.lemoal@wdc.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (different SHA1: e15de347faf4)
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-22 14:28:14.472822873 -0500
+++ /tmp/tmp.ZvzLslfZma	2024-11-22 14:28:14.464095287 -0500
@@ -1,3 +1,5 @@
+commit 17b49bcbf8351d3dbe57204468ac34f033ed60bc upstream.
+
 Several problems exist with scsi_mode_sense() buffer length handling:
 
  1) The allocation length field of the MODE SENSE(10) command is 16-bits,
@@ -36,15 +38,16 @@
 Link: https://lore.kernel.org/r/20210820070255.682775-2-damien.lemoal@wdc.com
 Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
 Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
+Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
 ---
  drivers/scsi/scsi_lib.c | 25 +++++++++++++++----------
  1 file changed, 15 insertions(+), 10 deletions(-)
 
 diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
-index 572673873ddf8..701d8e8480f22 100644
+index 64ae7bc2de604..0a9db3464fd48 100644
 --- a/drivers/scsi/scsi_lib.c
 +++ b/drivers/scsi/scsi_lib.c
-@@ -2075,7 +2075,7 @@ EXPORT_SYMBOL_GPL(scsi_mode_select);
+@@ -2068,7 +2068,7 @@ EXPORT_SYMBOL_GPL(scsi_mode_select);
  /**
   *	scsi_mode_sense - issue a mode sense, falling back from 10 to six bytes if necessary.
   *	@sdev:	SCSI device to be queried
@@ -53,7 +56,7 @@
   *	@modepage: mode page being requested
   *	@buffer: request buffer (may not be smaller than eight bytes)
   *	@len:	length of request buffer.
-@@ -2110,18 +2110,18 @@ scsi_mode_sense(struct scsi_device *sdev, int dbd, int modepage,
+@@ -2103,18 +2103,18 @@ scsi_mode_sense(struct scsi_device *sdev, int dbd, int modepage,
  		sshdr = &my_sshdr;
  
   retry:
@@ -77,7 +80,7 @@
  
  		cmd[0] = MODE_SENSE;
  		cmd[4] = len;
-@@ -2145,9 +2145,15 @@ scsi_mode_sense(struct scsi_device *sdev, int dbd, int modepage,
+@@ -2139,8 +2139,14 @@ scsi_mode_sense(struct scsi_device *sdev, int dbd, int modepage,
  			if ((sshdr->sense_key == ILLEGAL_REQUEST) &&
  			    (sshdr->asc == 0x20) && (sshdr->ascq == 0)) {
  				/*
@@ -88,24 +91,26 @@
 +				 * too large for MODE SENSE single byte
 +				 * allocation length field.
  				 */
- 				if (use_10_for_ms) {
-+					if (len > 255)
-+						return -EIO;
- 					sdev->use_10_for_ms = 0;
- 					goto retry;
- 				}
-@@ -2171,12 +2177,11 @@ scsi_mode_sense(struct scsi_device *sdev, int dbd, int modepage,
- 		data->longlba = 0;
- 		data->block_descriptor_length = 0;
- 	} else if (use_10_for_ms) {
--		data->length = buffer[0]*256 + buffer[1] + 2;
-+		data->length = get_unaligned_be16(&buffer[0]) + 2;
- 		data->medium_type = buffer[2];
- 		data->device_specific = buffer[3];
- 		data->longlba = buffer[4] & 0x01;
--		data->block_descriptor_length = buffer[6]*256
--			+ buffer[7];
-+		data->block_descriptor_length = get_unaligned_be16(&buffer[6]);
- 	} else {
- 		data->length = buffer[0] + 1;
- 		data->medium_type = buffer[1];
++				if (len > 255)
++					return -EIO;
+ 				sdev->use_10_for_ms = 0;
+ 				goto retry;
+ 			}
+@@ -2158,12 +2164,11 @@ scsi_mode_sense(struct scsi_device *sdev, int dbd, int modepage,
+ 			data->longlba = 0;
+ 			data->block_descriptor_length = 0;
+ 		} else if (use_10_for_ms) {
+-			data->length = buffer[0]*256 + buffer[1] + 2;
++			data->length = get_unaligned_be16(&buffer[0]) + 2;
+ 			data->medium_type = buffer[2];
+ 			data->device_specific = buffer[3];
+ 			data->longlba = buffer[4] & 0x01;
+-			data->block_descriptor_length = buffer[6]*256
+-				+ buffer[7];
++			data->block_descriptor_length = get_unaligned_be16(&buffer[6]);
+ 		} else {
+ 			data->length = buffer[0] + 1;
+ 			data->medium_type = buffer[1];
+-- 
+2.33.8
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

