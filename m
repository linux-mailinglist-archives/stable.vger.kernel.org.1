Return-Path: <stable+bounces-232768-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHrLEoANzWnhZgYAu9opvQ
	(envelope-from <stable+bounces-232768-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 14:20:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E2A37A5B5
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 14:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D509303F0B7
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 12:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931CA3FCB10;
	Wed,  1 Apr 2026 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRLeSSci"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC953DEAD4
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 12:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775045350; cv=none; b=UrPskIhAab8dQVwr9nKPsr6qJIFRh4NuhEOIAUKrjx88K9qgY1a7gM3Z8Dt8HaxaPvtvjFhz5wmZ88xsAR3pzw0nixuwIMrmsznCUWylqWwabnXxLaTHCcjarnwz1Bw1TkKEMKJWlhvWj48uas5dJO9ZOwlt6emN7KNXl7O8m3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775045350; c=relaxed/simple;
	bh=//Urz/K9pTwj4R51GVVhcOJ0Kf3oWTMWkp9QDOAgsFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nTvpvwa7XYmZY1/MBXHaFCMqfpJyHupr+pZ26WBCPv/Dgdnts4W/FldsnsWWpuZCDTkvDzr8xxtasdYy92uvD7hNR3Gk8k+Hiu3fZSs7T0OOS/85WLb3u+2+9gMKvU1rtfnSaw7+jNwr9tlNErleQEImIN0wN2h/21HA/9Xq160=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRLeSSci; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79853c0f5b9so41072917b3.0
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 05:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775045348; x=1775650148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gpu+nIydRNg4LqEAOn0F6sFr7pGZaX7fcnHuwE94M0Q=;
        b=MRLeSSciqg2O7b3M91LogUUfamZ/z0zzG9e47mxXhlA9luf2vFZzxqQm7u0ahiEaIu
         D8vspshsCBbsSQNtQmvzM8mNzCHStWaaoseh8j60L4QhAuO9ItHSHRk6ubywt/CYlpUr
         /9D9x3n6jAzxcIP3p0NyqfnuN+Ryq05pgaKSEuYJzXNfm9JB5iERWDvvxm3W7MbFPjO9
         WjKemuXS9KvESywpU96B64oZ0pGiFageDRcJIQhWXjytNiahLN3a5QD04B5lFntUIM2I
         MSrpvHulYd+QTyZ6H4u7scMw86wjF4cpjIW9rbhD4FLxETz8XCup/P6tOwGR8EiAF0gm
         fSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775045348; x=1775650148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpu+nIydRNg4LqEAOn0F6sFr7pGZaX7fcnHuwE94M0Q=;
        b=NHl3zpO8xHW9bTLaovzP6G6Z10Y0ICFP5bY7MEJewu4QWloxCJdAJ4hupBNY6Hurcb
         NKsHQco0b4kLCo4KEHXGbl7Ads6DO/mc05Al0/d0xOLgw7fuNROZSGeHfZ0DeNhLPoD7
         dHzNBX9Sb7mV7kmuQk9m4k9UvQWKiEttolnoeXI603WfxuBKzY3K1EfasFla6z1PhTqd
         fBJQQm3QYHPqEFiOD66aAf8jIghMzmK5vYOsWWLTGqHkEkIc4Fa+X3hO7lL9zcl5VceP
         2+njpVC+06n7zPmrze4/YhUp6zkqXPDM3BQLFbPU3DkbUcV7eqNBUzrR/kYrQCB4uPKL
         l7Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVHM3xc/7MyToRdyoCm1/ut88nI6+bpccT0OIdVtAqGIP08TPgerZsP06qWytJtz1pEs/YBTC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7TEex4CFGXFDBSWDKQ+fwuRRUMKNABlIaCFASz+q1ppMsvjYJ
	BK87S/pPIMHHRi2akLIe1LefmqvePUto1scbbMzHTQlgYckdpC8Xzv4S
X-Gm-Gg: ATEYQzyL3jQPiTt5f9qSGrQ9iU354FJT8WDDFHZUvD/O87qgj6A0AxN7CCok6uPTw0A
	MZ9D8jqvK35p/Nbzfz/ougkHds10xvODWdA2AYn2hAUIQwrkzAgS9FtgUeKwppa1K2zH8K2pAa8
	km0A3Hwo+xLUplbUU/btXHtaywQPtj37GlvF3HJtEyNKHNJ3HE2W2+6qy7xSE406GqSIWFjgZiS
	fngwZ8AOW/kPKTGtAl2hJuT8IzMiJAzcg30zMCusBQHwNegRT0DPAGU72E0mDldH5EH3u7egkPJ
	FzfE5oUKl25i78WWhnqQ0rEbdldGHVqTJr7afMwCV+EDuBlyfTPEKH5WxCN8+mwKbSEor4whkie
	duvRlZtnOKPyJ7RJI67cJcjSPh3Fq/3+bBJiUjHDpxyEADIrgMwPCKqQz5y4bwANVbLNb+3+Qi/
	NSmvGPVh07L6ohe2CGs1TfuG7w8RY3lbRPa8zs9/TK+8NFFKq9xKmAeYJ872mOOFTz88qLKIqC1
	SO5
X-Received: by 2002:a05:690c:388:b0:79d:dce:5880 with SMTP id 00721157ae682-7a20f4ff581mr33389067b3.7.1775045348153;
        Wed, 01 Apr 2026 05:09:08 -0700 (PDT)
Received: from localhost.localdomain (104.194.93.216.16clouds.com. [104.194.93.216])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb790c05asm61771647b3.16.2026.04.01.05.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 05:09:07 -0700 (PDT)
From: hkbinbin <hkbinbinbin@gmail.com>
To: valentina.manea.m@gmail.com,
	shuah@kernel.org,
	i@zenithal.me,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hkbinbin <hkbinbinbin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usbip: vhci: validate ret_submit number_of_packets
Date: Wed,  1 Apr 2026 12:08:57 +0000
Message-ID: <20260401120857.1443552-1-hkbinbinbin@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,zenithal.me,linuxfoundation.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232768-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[hkbinbinbin@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 50E2A37A5B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

vhci_recv_ret_submit() unpacks USBIP_RET_SUBMIT directly into the URB,
including number_of_packets from the remote server. For isochronous
URBs, iso_frame_desc[] was allocated using the original locally
submitted number_of_packets.

If a malicious or buggy USB/IP server returns a larger
number_of_packets, usbip_recv_iso() will iterate past the end of
urb->iso_frame_desc[] and write attacker-controlled ISO descriptors out
of bounds. Later completion paths may also walk past iso_frame_desc[]
if the poisoned number_of_packets is left in the URB after rejecting
the response.

Fix this by saving the original packet count before unpacking the PDU,
rejecting larger values from the server, restoring the original count
on error, and marking the connection as broken.

Fixes: 1325f85fa49f ("staging: usbip: bugfix add number of packets for isochronous frames")
Cc: stable@vger.kernel.org
Signed-off-by: hkbinbin <hkbinbinbin@gmail.com>
---
 drivers/usb/usbip/vhci_rx.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/usb/usbip/vhci_rx.c b/drivers/usb/usbip/vhci_rx.c
index a75f4a898a41..5bbfd5ae7755 100644
--- a/drivers/usb/usbip/vhci_rx.c
+++ b/drivers/usb/usbip/vhci_rx.c
@@ -60,6 +60,7 @@ static void vhci_recv_ret_submit(struct vhci_device *vdev,
 	struct usbip_device *ud = &vdev->ud;
 	struct urb *urb;
 	unsigned long flags;
+	int orig_number_of_packets;
 
 	spin_lock_irqsave(&vdev->priv_lock, flags);
 	urb = pickup_urb_and_free_priv(vdev, pdu->base.seqnum);
@@ -73,9 +74,33 @@ static void vhci_recv_ret_submit(struct vhci_device *vdev,
 		return;
 	}
 
+	/*
+	 * Save the original number_of_packets before it gets overwritten
+	 * by the server's response. The iso_frame_desc[] array was allocated
+	 * based on this value, so the server must not increase it.
+	 */
+	orig_number_of_packets = urb->number_of_packets;
+
 	/* unpack the pdu to a urb */
 	usbip_pack_pdu(pdu, urb, USBIP_RET_SUBMIT, 0);
 
+	/*
+	 * Validate number_of_packets from the server response against the
+	 * original URB allocation. A malicious server could set this to a
+	 * larger value, causing usbip_recv_iso() to write beyond the
+	 * iso_frame_desc[] array bounds.
+	 */
+	if (urb->number_of_packets < 0 ||
+	    urb->number_of_packets > orig_number_of_packets) {
+		dev_err(&urb->dev->dev,
+			"invalid number_of_packets in ret_submit: %d (max %d)\n",
+			urb->number_of_packets, orig_number_of_packets);
+		urb->number_of_packets = orig_number_of_packets;
+		urb->status = -EPROTO;
+		usbip_event_add(ud, VDEV_EVENT_ERROR_TCP);
+		goto error;
+	}
+
 	/* recv transfer buffer */
 	if (usbip_recv_xbuff(ud, urb) < 0) {
 		urb->status = -EPROTO;
-- 
2.51.0


