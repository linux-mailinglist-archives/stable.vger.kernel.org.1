Return-Path: <stable+bounces-54400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7643190EDFE
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D181C21329
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F7D144D3E;
	Wed, 19 Jun 2024 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vxM4dQfm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202A6143757;
	Wed, 19 Jun 2024 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803469; cv=none; b=XSnQjg+z5qF4yIhnlWUgo1mOzhZRY5xNadJpDzdiWgLPB0YYL5Ilx0hMPTgGx/q39slLeeIhB9ILtydRcDepgEHC3JawnoXJ9GliY8MiL35Tope6OoCYEF42dN4fuGgMbCBuFzTrbpQz9dVxwYqidDqkMCzmaY1O2NmMXlaT7b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803469; c=relaxed/simple;
	bh=HkSvvLInmpRoFnJPR2abKYHjamjfJB0f7Sl8jOJVZqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KehnrJ2v8dXwME8vCWStrlgd5dU7iOPvPF68GvYQOh21WyqMkY2K8DPIZtDOHlimZAe1S62uaOuJKchu4PxglI2tEWxKotddaxvkWn3O1nQsrgsfYykRHiHtzqyycREHb1YGh5NtJRDqS/l850DJfzOFYV717MEtfSroSNOL8dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vxM4dQfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D965C2BBFC;
	Wed, 19 Jun 2024 13:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718803468;
	bh=HkSvvLInmpRoFnJPR2abKYHjamjfJB0f7Sl8jOJVZqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vxM4dQfmstdERhVpvzP+lxUPZYRuo6DKBTkWwRUBvOh4P5ropvKGYzN1sU+v1NWHy
	 vy73+slnQqoStqf6g37S3HUF5o6oVNVS8vXFxis83tbTIH1iSI79T1wJhCv+CCy57R
	 FQjMvd3zds3Bat0XMHwsqlwsXNE3yV6itgWpXn2Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	xingwei lee <xrivendell7@gmail.com>,
	yue sun <samsun1006219@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Shichao Lai <shichaorai@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 276/281] usb-storage: alauda: Check whether the media is initialized
Date: Wed, 19 Jun 2024 14:57:15 +0200
Message-ID: <20240619125620.601368304@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125609.836313103@linuxfoundation.org>
References: <20240619125609.836313103@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shichao Lai <shichaorai@gmail.com>

[ Upstream commit 16637fea001ab3c8df528a8995b3211906165a30 ]

The member "uzonesize" of struct alauda_info will remain 0
if alauda_init_media() fails, potentially causing divide errors
in alauda_read_data() and alauda_write_lba().
- Add a member "media_initialized" to struct alauda_info.
- Change a condition in alauda_check_media() to ensure the
  first initialization.
- Add an error check for the return value of alauda_init_media().

Fixes: e80b0fade09e ("[PATCH] USB Storage: add alauda support")
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Shichao Lai <shichaorai@gmail.com>
Link: https://lore.kernel.org/r/20240526012745.2852061-1-shichaorai@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/storage/alauda.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
index 115f05a6201a1..40d34cc28344a 100644
--- a/drivers/usb/storage/alauda.c
+++ b/drivers/usb/storage/alauda.c
@@ -105,6 +105,8 @@ struct alauda_info {
 	unsigned char sense_key;
 	unsigned long sense_asc;	/* additional sense code */
 	unsigned long sense_ascq;	/* additional sense code qualifier */
+
+	bool media_initialized;
 };
 
 #define short_pack(lsb,msb) ( ((u16)(lsb)) | ( ((u16)(msb))<<8 ) )
@@ -476,11 +478,12 @@ static int alauda_check_media(struct us_data *us)
 	}
 
 	/* Check for media change */
-	if (status[0] & 0x08) {
+	if (status[0] & 0x08 || !info->media_initialized) {
 		usb_stor_dbg(us, "Media change detected\n");
 		alauda_free_maps(&MEDIA_INFO(us));
-		alauda_init_media(us);
-
+		rc = alauda_init_media(us);
+		if (rc == USB_STOR_TRANSPORT_GOOD)
+			info->media_initialized = true;
 		info->sense_key = UNIT_ATTENTION;
 		info->sense_asc = 0x28;
 		info->sense_ascq = 0x00;
-- 
2.43.0




