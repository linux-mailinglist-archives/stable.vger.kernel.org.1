Return-Path: <stable+bounces-230888-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCDYBIQhyWkuvAUAu9opvQ
	(envelope-from <stable+bounces-230888-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 14:56:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B624435208C
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 14:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03FB33011C7A
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 12:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A630E36D4EF;
	Sun, 29 Mar 2026 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1vi0Vuo"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1933C07A
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774788990; cv=none; b=t0IX1hAw5c4PKjF3FhBIsh7LFjVom31GbZPLLAdcXae+MoBEiiwqWJYuWmQ7afRuhDzu0WJK7GxkY+o+EtkJClkN+izLVVQQIL0kulD6NFJR/GmqzAm4JZE4NTtlI1So+fkg7PkMxUaQtkNC3XNc7IviVyUAoo8Omgz6NVrOod0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774788990; c=relaxed/simple;
	bh=Ms/HxArMB7Rw9IZzQFgUB8jXVmKRl6GIiJdDjiPErSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IzXorar9eLRCTl5prRpgfHtY9M5ihdxyohJdoSbsEShuP+2nBi6kxI+SKSFgYNjjvrHzOfPnz01NqFsIgCGhuUFNaNqB9Sjex20zrPcA9qXDf0L8vvk49pqt+rBjm0yl8BQW2zHwhKyereC9dpW4HpnZoO/eMawihv9gyqWdXYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o1vi0Vuo; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56ba039eecbso1295352e0c.0
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 05:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774788988; x=1775393788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLprFJgbxBe60/TVSP4S8HKB3cVSRRFloryJ7ItXJ0c=;
        b=o1vi0Vuos7kNWbN2C7bDUALvy/OV3K/OoD7JuTneYiX64iIPgodjkk5Mor8Vk+2GwM
         xzE2jw9sVu/TbgqbDAb97/y6Y96EEyU7SRPFFUtqLDCej9ZFkKoM2TrPPtlBO/D9/fo7
         5OG2+qiEAtn15ITYHNcSYWQ3dZ1tndgh1chOSSGSfhluhCwn9ZKgd+UoeldMdtfgUiOZ
         zKfbavXVIb4cw3QfzfqPgWaHKxR2l04qpovk8/Y+euyININAodzy0xJ32ErZIocBZ55P
         lX+dFYPgG7KCvcxYELnVUeYAV3jw1E1mrwlfb8W8shKh+yTmYoE8mMbVMoutIbb1YzVP
         JsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774788988; x=1775393788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eLprFJgbxBe60/TVSP4S8HKB3cVSRRFloryJ7ItXJ0c=;
        b=GfOlPspu7l31gDfsT0IretkBzkruRQAv3CmHEw4vHalR7WbIFY1JrHf3HrKSFiZSeW
         jBmKKaq/wOg7bkvmz0+QromVsUawhsw5/wjGnw/+kQl6xJfB5syUI1QUJdrHc+vjSrzm
         gpzDH51N6tfjJsY9vEyXc4+sFE97me8+uXUrfFmt4Tz48ol2kxBZ6mJJGGnhPxWJcHno
         Wxv+9Jldw+HgXXxf+BzGSAaDvlmDiseynTdgVJ3ezKFMIQSFfUTWYF0mYksTcQBLd0au
         1j2YfDZNMgN99qzRkpNFxyI4z4beJbm7WZRNt/uk4UNLBxo/lwJSCv1Y49UEnNBBbtbK
         TCbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTuPFCUg7JZEC2Cb5tyx4OzEhARzqj1CUaO5FtSNGcj0u3Um4bNTsCqIkuz5NcOL1E9JSkV3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx14bbespNqN0IR2z9Ajq2pMO6BJyPYkFmXmpdW+Futvyf70ysA
	zpe15bI7+oCOal/sdZLryNuI0TgVbeNQeZ6inBq/g95561Bh+EjPjCqT
X-Gm-Gg: ATEYQzyAHTCIl9OcCj0sEFhNlA2Q82VwWQe/5BkQIiemUpUUuIg4MlGnHdbK8IJCAiN
	e9c1WfvPAX1p9oE9Ob9azrC6ha/+R5OOYr3n/IYLQVBpGp8JNVvHk6SJp7j4B47/OIctg2SYyaY
	0geTQBiuVuYSRcYeKZEumYEBVhu0/9G5GYO5SwJiXQyMTXmc8u0pbn1uDig8sufuedt40/0VMCe
	2qO3L8DfifB/ES9jNcBA0sf5dmkf4M6UxCPuY0eIpdnhcPQ1E1NInA8GTUTgDFepLsmMqo7HcNz
	3OtrWYUyIoO685lDwYfQGPF19qmeT8omFo430pFihEFLbfwie7xb2Q1wMdpGhbVHh24zTf05YT7
	YKPPz91Flj1XeQXoH4wk/B9cM6iyopCRdPMIBk2/tciSuD49afu/xKSYxPmy34ofp/EnzaK/Snd
	n2rTBq9iSW19YQSV+jBzCvYKQ3
X-Received: by 2002:a05:6122:208c:b0:56b:a673:27bb with SMTP id 71dfb90a1353d-56d4a5593f7mr3335443e0c.8.1774788987977;
        Sun, 29 Mar 2026 05:56:27 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:6d77:aa::11:1a4])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d58a33bf3sm5188524e0c.14.2026.03.29.05.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 05:56:27 -0700 (PDT)
From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
To: security@kernel.org
Cc: gregkh@linuxfoundation.org,
	shuah@kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Sebasti=C3=A1n=20Alba=20Vives?= <sebasjosue84@gmail.com>
Subject: [PATCH] usbip: vhci: validate number_of_packets in RET_SUBMIT response
Date: Sun, 29 Mar 2026 06:53:33 -0600
Message-ID: <20260329125437.517980-2-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260329125437.517980-1-sebasjosue84@gmail.com>
References: <20260329125437.517980-1-sebasjosue84@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230888-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B624435208C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sebastián Alba Vives <sebasjosue84@gmail.com>

vhci_recv_ret_submit() calls usbip_pack_pdu() which overwrites
urb->number_of_packets with the value from the network PDU reply
without any validation. A malicious USB/IP server can set
number_of_packets to a value larger than the original URB allocation,
causing usbip_recv_iso() and usbip_pad_iso() to access
urb->iso_frame_desc[] entries beyond the allocated array.

This leads to a heap buffer overflow in kernel memory, reachable over
the network without authentication.

The attack chain is:
  1. Client sends isochronous URB with number_of_packets = N
  2. Server replies with number_of_packets = N' >> N
  3. usbip_pack_pdu() blindly copies N' into urb->number_of_packets
  4. usbip_recv_iso() loops N' times over iso_frame_desc[N] → OOB
  5. usbip_pad_iso() also loops N' times → second OOB

Save the original number_of_packets before usbip_pack_pdu() and
validate the returned value does not exceed it. Also add a defensive
bounds check in usbip_recv_iso() against USBIP_MAX_ISO_PACKETS and
use array_size() to prevent integer overflow in the allocation.

Note that stub_rx.c already validates number_of_packets against
USBIP_MAX_ISO_PACKETS for CMD_SUBMIT on the server side, but no
equivalent validation existed on the client side for RET_SUBMIT.

Cc: stable@vger.kernel.org
Signed-off-by: Sebastián Alba Vives <sebasjosue84@gmail.com>
---
 drivers/usb/usbip/usbip_common.c | 18 ++++++++++++++----
 drivers/usb/usbip/vhci_rx.c      | 27 +++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/usbip/usbip_common.c b/drivers/usb/usbip/usbip_common.c
index a2b2da125..f1eeab3a5 100644
--- a/drivers/usb/usbip/usbip_common.c
+++ b/drivers/usb/usbip/usbip_common.c
@@ -662,7 +662,6 @@ int usbip_recv_iso(struct usbip_device *ud, struct urb *urb)
 	void *buff;
 	struct usbip_iso_packet_descriptor *iso;
 	int np = urb->number_of_packets;
-	int size = np * sizeof(*iso);
 	int i;
 	int ret;
 	int total_length = 0;
@@ -674,12 +673,23 @@ int usbip_recv_iso(struct usbip_device *ud, struct urb *urb)
 	if (np == 0)
 		return 0;
 
-	buff = kzalloc(size, GFP_KERNEL);
+	/*
+	 * Sanity check to prevent heap overflow. USBIP_MAX_ISO_PACKETS
+	 * is validated on the stub (server) side for CMD_SUBMIT, but the
+	 * client must also validate in case of a malicious server reply.
+	 * Also rejects negative values.
+	 */
+	if (np < 0 || np > USBIP_MAX_ISO_PACKETS) {
+		dev_err(&urb->dev->dev, "recv iso: invalid np %d\n", np);
+		return -EPROTO;
+	}
+
+	buff = kzalloc(array_size(np, sizeof(*iso)), GFP_KERNEL);
 	if (!buff)
 		return -ENOMEM;
 
-	ret = usbip_recv(ud->tcp_socket, buff, size);
-	if (ret != size) {
+	ret = usbip_recv(ud->tcp_socket, buff, np * sizeof(*iso));
+	if (ret != np * sizeof(*iso)) {
 		dev_err(&urb->dev->dev, "recv iso_frame_descriptor, %d\n",
 			ret);
 		kfree(buff);
diff --git a/drivers/usb/usbip/vhci_rx.c b/drivers/usb/usbip/vhci_rx.c
index a75f4a898..4ca7cda62 100644
--- a/drivers/usb/usbip/vhci_rx.c
+++ b/drivers/usb/usbip/vhci_rx.c
@@ -60,6 +60,7 @@ static void vhci_recv_ret_submit(struct vhci_device *vdev,
 	struct usbip_device *ud = &vdev->ud;
 	struct urb *urb;
 	unsigned long flags;
+	int orig_number_of_packets;
 
 	spin_lock_irqsave(&vdev->priv_lock, flags);
 	urb = pickup_urb_and_free_priv(vdev, pdu->base.seqnum);
@@ -73,9 +74,35 @@ static void vhci_recv_ret_submit(struct vhci_device *vdev,
 		return;
 	}
 
+	/*
+	 * Save the original number_of_packets before usbip_pack_pdu()
+	 * overwrites it with the value from the network PDU. The
+	 * iso_frame_desc array was allocated based on this original value,
+	 * so the reply must not claim more packets than were originally
+	 * submitted.
+	 */
+	orig_number_of_packets = urb->number_of_packets;
+
 	/* unpack the pdu to a urb */
 	usbip_pack_pdu(pdu, urb, USBIP_RET_SUBMIT, 0);
 
+	/*
+	 * Validate that the server did not return more isochronous packets
+	 * than were originally submitted. A malicious server could set
+	 * number_of_packets to a value larger than the original, causing
+	 * usbip_recv_iso() and usbip_pad_iso() to access iso_frame_desc
+	 * entries beyond the allocated array, resulting in heap buffer
+	 * overflow.
+	 */
+	if (urb->number_of_packets < 0 ||
+	    urb->number_of_packets > orig_number_of_packets) {
+		dev_err(&urb->dev->dev,
+			"pdu number_of_packets %d > original %d\n",
+			urb->number_of_packets, orig_number_of_packets);
+		urb->status = -EPROTO;
+		goto error;
+	}
+
 	/* recv transfer buffer */
 	if (usbip_recv_xbuff(ud, urb) < 0) {
 		urb->status = -EPROTO;
-- 
2.43.0


