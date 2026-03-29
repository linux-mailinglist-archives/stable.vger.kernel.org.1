Return-Path: <stable+bounces-230903-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACmyOKEmyWm/vAUAu9opvQ
	(envelope-from <stable+bounces-230903-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:18:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 870CD352292
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF1AD3005A97
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB43374E6D;
	Sun, 29 Mar 2026 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVyznT5Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA2D374E5B
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790301; cv=none; b=NTk/lf8xraLnyjHFc2Bkw22DiF0nsy505bjpeyFYd2BOWfskIyYCb+F1gRzH/ZlGmZGTtM4iTVxH3bzKBB3SDsWHZ4D0OePL6jNJeefVnaSf19Rvq7wVNHx6clABsuKyySwb3WObhSgr2U3QpyXQ+R0uPEGrSJRbJLDeOkzEPgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790301; c=relaxed/simple;
	bh=h7YQ7kcmJJIElnFbevFKb2QZX6NAyom3F4FJgb6+Qok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jk+ffcIXEZfTgJcNo7pEoIXqbljkbD+YFbCKORaOZZDtU/xuK0qsxW3GXSNPZsmd4L3d82awr6Nvkpyn5Y16KhSaG2wHmLudLW1dPz6UUB+72Q0sdYAaYZQ1k5rpQpACrIBHVZNhSILghMPbHDLCa4qgXE2ecMFgzFnz3emmvQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVyznT5Y; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-953b15c764dso283688241.2
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 06:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774790299; x=1775395099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fe1zNSk27VRiSuFRJ0xvROsWr25dSoOLIfiHWlkT2jI=;
        b=VVyznT5YoP63MKaGvxIeI+oWj2jLB9E8pnJG2LLLva2/5Swjq76xVnZlIExGRsuV5M
         TGFztUzS0KYQtaZG6o9hSwIepS4fdTUQlt3Zn7zMiB3ZY/WE7wk7ogu9QiwOK82l1FxT
         PlqmWdJUyZO66SLzXLsBV6WtBYWYuvpx0Iy7OIE3pW88+oObTOKBF4YhQV2GrzeEKJey
         n4egWFFpObZydRv3viVcpcq+4mAu/kp0mQzkqIjexoHhkMiRlXfSyn5kOae7vApEkIJN
         ya0Vxl4oGsJisuIpcLF9olKkcxx/dMGs672d4x6WRzh1OOthQzMWRTMe6aF1Z6cP3Ob6
         aeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774790299; x=1775395099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fe1zNSk27VRiSuFRJ0xvROsWr25dSoOLIfiHWlkT2jI=;
        b=BwuUa00AuZQF45TBemrSDR/QlpN1LdHcG9NowN9co9K+uRZ/9yFknsCIoiV+KcBRRF
         JRufpscKkPOflpiNnUNTNjajMf6scmVboC2zI3kUxmAMV2Us36emnc2qBTzTNYxDrVoC
         hWx6XFNIajVs9Mj8jMa56aJc5df8RcYB/a+qGnNpsafucCtOWwP+50lcYpHHhoqmF2QF
         C8g7KWoLPCic5xdC7TAoH+fKTflagXEBzNnFZWYW+A4SHsHBa1GPfFAtPuXd5BEclvLL
         olP5dOJDMvJ5zym53IXtVzi0GcrABDFNJ3G8uiog4vT5wL1H/YUAuhEwILoU1iwdBRxh
         SbtA==
X-Forwarded-Encrypted: i=1; AJvYcCVBpVulsW1+rR0So45kD4EjgqlUwaIbgx6Up3OlDMz6BPM9Ape3Lz719jBsNscQuNI074esxyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUO6cqlR3YUNmpXm15fFvOzqu1anz4yz2a1D09MFgwqx0QCs70
	brc0qMD8uh2SX3MlmyWfO1e5PgKk/DlGmRAGeAMv3wl1eF1Id3evSy5y
X-Gm-Gg: ATEYQzxORcknpq5mVMNeZ3MPfbSj7AjbOf7NtBbv4vsNFsvZRqb/g40KBJ170o4YVOw
	8IeO1erDvNEhaTHEO6cb7jYdnBN/26U12p22eTFunSPj/IECyzuYY634R1ylHiaTMhVc73NlqWk
	8UnFK2bmkcJ6ssnVqzYkpHxbvDZL2l7w9LFMQG2HkhIklM2nRVmc3QKsD/US5WISXUPRqstAb1x
	XqcjNSDxkUzKkUsrXKev73XMpDcHUPDcW95ph4SNW93NNSBKvhPB2z/uvhgHRZuTBvWN97TTo6b
	YEDr5IslM0BbTVXa4Rqjto+0N1xveS6jmu+SLOWYxQySo8/+C1YWKsiBWRqGwW4FQ3tf7fiZDJP
	0otfnI7IJQ8SUsfjlrjmrlyggwJ4rMkbQM6rnXye+Vs5jEHqCF00JUCRzyQ1SNR2Y3QQzQnvFZC
	JDJZb0RIl96+iMrjaD+0cCUPdG
X-Received: by 2002:a05:6102:334f:b0:5fd:ff75:f437 with SMTP id ada2fe7eead31-604f92dd367mr3839634137.33.1774790299380;
        Sun, 29 Mar 2026 06:18:19 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:6d72:aa::11:1a4])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-605129b95e2sm5422888137.2.2026.03.29.06.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 06:18:18 -0700 (PDT)
From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
To: security@kernel.org
Cc: gregkh@linuxfoundation.org,
	shuah@kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Sebasti=C3=A1n=20Alba=20Vives?= <sebasjosue84@gmail.com>
Subject: [PATCH] usbip: validate iso_frame_desc offset and length in usbip_recv_iso()
Date: Sun, 29 Mar 2026 07:17:37 -0600
Message-ID: <20260329131810.522006-2-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260329131810.522006-1-sebasjosue84@gmail.com>
References: <20260329125437.517980-1-sebasjosue84@gmail.com>
 <20260329131810.522006-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230903-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 870CD352292
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sebastián Alba Vives <sebasjosue84@gmail.com>

usbip_recv_iso() receives isochronous packet descriptors from the
network and unpacks them into urb->iso_frame_desc[] via
usbip_pack_iso(). The offset and actual_length fields in each
descriptor come directly from the remote peer without validation.

These fields are subsequently used by usbip_pad_iso() in memmove
operations:

  memmove(urb->transfer_buffer + iso_frame_desc[i].offset,
          urb->transfer_buffer + actualoffset,
          iso_frame_desc[i].actual_length);

A malicious USB/IP server can craft iso frame descriptors with
offset and/or actual_length values exceeding the transfer buffer
bounds, causing an out-of-bounds memmove that corrupts kernel heap
memory. This is exploitable over the network without authentication.

This is a separate vulnerability from the number_of_packets
validation issue. Even with a valid number_of_packets, the
individual descriptor fields can still cause OOB access.

Add validation that each iso_frame_desc entry's offset +
actual_length falls within the transfer buffer bounds. Return
-EPROTO and trigger a connection reset if any entry is invalid.

Cc: stable@vger.kernel.org
Signed-off-by: Sebastián Alba Vives <sebasjosue84@gmail.com>
---
 drivers/usb/usbip/usbip_common.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/usb/usbip/usbip_common.c b/drivers/usb/usbip/usbip_common.c
index f1eeab3a5..8b6ca8f83 100644
--- a/drivers/usb/usbip/usbip_common.c
+++ b/drivers/usb/usbip/usbip_common.c
@@ -711,6 +711,34 @@ int usbip_recv_iso(struct usbip_device *ud, struct urb *urb)
 
 	kfree(buff);
 
+	/*
+	 * Validate each iso_frame_desc entry. The offset and actual_length
+	 * come from the network and must not exceed the transfer buffer.
+	 * Without this check, a malicious server could craft iso descriptors
+	 * with out-of-bounds offset/length values, causing usbip_pad_iso()
+	 * to perform memmove operations beyond the transfer buffer, leading
+	 * to heap buffer overflow.
+	 */
+	for (i = 0; i < np; i++) {
+		unsigned int offset = urb->iso_frame_desc[i].offset;
+		unsigned int length = urb->iso_frame_desc[i].actual_length;
+
+		if (offset > urb->transfer_buffer_length ||
+		    length > urb->transfer_buffer_length - offset) {
+			dev_err(&urb->dev->dev,
+				"iso frame %d: offset %u + length %u > buffer %u\n",
+				i, offset, length,
+				urb->transfer_buffer_length);
+
+			if (ud->side == USBIP_STUB || ud->side == USBIP_VUDC)
+				usbip_event_add(ud, SDEV_EVENT_ERROR_TCP);
+			else
+				usbip_event_add(ud, VDEV_EVENT_ERROR_TCP);
+
+			return -EPROTO;
+		}
+	}
+
 	if (total_length != urb->actual_length) {
 		dev_err(&urb->dev->dev,
 			"total length of iso packets %d not equal to actual length of buffer %d\n",
-- 
2.43.0


