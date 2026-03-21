Return-Path: <stable+bounces-227796-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPX6NNwdv2mavAMAu9opvQ
	(envelope-from <stable+bounces-227796-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 23:38:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 620B82E7810
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 23:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F40E301FFA2
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 22:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748DF346A11;
	Sat, 21 Mar 2026 22:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b="W9Th2fm/"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A02C31A07B
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 22:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774132658; cv=none; b=f/rFep9GSj3V7ZUlINfjk6wUJDdjJUBeRYRpMRShmWMxYt9wkVrrKymbakWTTcbkl6GN5K7jX9mBPPQXePy75Nq+7Bh0jpdFXgSxCgRG/Gkv9dz5icXYKVVhSFp547mYQCQnhaeXYhn8AceWyDhw3VfyedAhjRwxyJmdN/m7+H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774132658; c=relaxed/simple;
	bh=ZB4v3IPFDRnk0aKPXENNDAE3F/R3GHcKa0Ja8oqgihA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5gt4NBwawwPKD29Pc6MaMA4i8laxiC22B6mDHDJ0gM9Se8nLN1SP9H38TEJ0MjTOgUdBzj3dPyEn11xYhohkOOTHEpnlL5DWLS6Kii6kDlMWSi6mbkXSSeYdR6pj2aUmawvENNs11bbWZnf8BIdc1ecSlyDYiqiZpxR5h8nFN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com; spf=pass smtp.mailfrom=jphein.com; dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b=W9Th2fm/; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jphein.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c0c482e069so1359537eec.0
        for <stable@vger.kernel.org>; Sat, 21 Mar 2026 15:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jphein.com; s=google; t=1774132656; x=1774737456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWxv10dmacQCe02GOaZYv2taNeWbAdkdfAH3ZWq85RY=;
        b=W9Th2fm/6CV0ExkYq2CSLa1B0+JWr42lcCki+pT4AKbBJNyxV6nBP0Ey97SJvpEvkS
         9rFO/hl5eKcPDoB27CDJbQaNT5rIrspSgFZy8fF8UNO8/2NU2ILginMGojw+iitwwU6V
         BLYQo4WfLXFtsdd1ceTp2q4JmIBecZjL+UEuqfi7oskxINKb0E0pX3uyHgAl+J5kfFxM
         QM/SvI/G6QyXLghY240XmogS0pWYvJFNPhbLN7keZTv9G+9rzOlK7vDVSLO2NsuD3eW1
         VckPE9A5wUtiAA7m4xN4WTh7ovCTP0NsDS2x09YottEzf2T5j4a247/AeJKDzArDmWiY
         uDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774132656; x=1774737456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zWxv10dmacQCe02GOaZYv2taNeWbAdkdfAH3ZWq85RY=;
        b=nlrS6OGIfJSBBNZj51eb92MlhEydXwEdGbBLW0ExNzuNjMBqKz4D/w2NPLm6Y64ql7
         WgivdCw0+8PIdWDDb45MFSJbgjUAusQ4y4nlbynyBhnSDyhFikw8oUuturpwI7y+uGqL
         HY7BICMGr4uPl5hG38SZBbONgzLniL9MkocdQtCRS76+MZLC95QUtwwCnyES858I2378
         vOX7ZPwZ66RB4dewuw8vve0OOmqzm+lKALaN3IcRv5zd9Ew5pYn+aEpKAZz3EfA3e/Wv
         fWxZufp9Dt1Buam6+GjOsG8XQVuz6uTn9h7W8oNlcpZnkKdKZJOE1DG62xGuzDvGSRWY
         akMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKM9zqwIsQnXZCiNN38MxzcU9tt07FPDWkrkwGvQGapf68dNcMQlpqT0fCscH88UjNQpWyzTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YztQLWbEZ03L08h1+lSK2oIfGZn+eUlJwZ9k6DTTr/Re7FZfG+L
	qCi2lSPI2o6wqpMLKkQV/V1RF3AyQu+KCd04r87M/bnzvY+VKI2Fx1cqQIZ3h0et+4t6ilDJML0
	rkF0=
X-Gm-Gg: ATEYQzz4ZXdaFJKpgKAFI+H1DT741cPdqwOuVg3dSapzdWVBAopDSViV6S22ZEX0ZxB
	1o5Lbhx1rSlMY4gbf7KMOB9u6nd9orYbga1iJWD6iNbdLpEDni3/PMBS79Wz06VK8otk9FOpW79
	EymEzFZvi0UuHK7Sm1wkBxXyardlQFx0ZVdEUoEubMsm3QqYN+Rjm/nYb3kqjXu0frYe918qmep
	4t/Peuevk1q2cvEFUaoGTOB0OUsQnJabTyRsD0ZE3XAI+YlYgljtiwamJ8BfDPIFSstGMiOOhVk
	y7UKsorzeaKccSRw6owyQEZ5eu1SX7nkNJkCAaYAUy1rBf/Iwx+Iquj0HrYR6a8MvA/k7n3t6NQ
	4lBzLddXKZyNZtr0ekOiY4VtbbU6BbD2/1IxSictxo6CK/Mx/xiwH575oVUXvsAUloz93eFCwY7
	u9h82KosBZ
X-Received: by 2002:a05:7301:3d1a:b0:2ba:9835:112d with SMTP id 5a478bee46e88-2c109565648mr3372368eec.3.1774132656039;
        Sat, 21 Mar 2026 15:37:36 -0700 (PDT)
Received: from katana.lan ([108.74.4.89])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b14c985sm7982131eec.2.2026.03.21.15.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 15:37:35 -0700 (PDT)
From: JP Hein <jp@jphein.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-media@vger.kernel.org,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	JP Hein <jp@jphein.com>
Subject: [PATCH 1/3] USB: core: add NO_LPM quirk for Razer Kiyo Pro webcam
Date: Sat, 21 Mar 2026 15:37:03 -0700
Message-ID: <20260321223713.1219297-2-jp@jphein.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260321223713.1219297-1-jp@jphein.com>
References: <20260321223713.1219297-1-jp@jphein.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[jphein.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[jphein.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[jphein.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227796-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jp@jphein.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[launchpad.net:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 620B82E7810
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Razer Kiyo Pro (1532:0e05) is a USB 3.0 UVC webcam whose firmware
does not handle USB Link Power Management transitions reliably. When LPM
is active, the device can enter a state where it fails to respond to
control transfers, producing EPIPE (-32) errors on UVC probe control
SET_CUR requests. In the worst case, the stalled endpoint triggers an
xHCI stop-endpoint command that times out, causing the host controller
to be declared dead and every USB device on the bus to be disconnected.

This has been reported as Ubuntu Launchpad Bug #2061177. The failure
mode is:

  1. UVC probe control SET_CUR returns -32 (EPIPE)
  2. xHCI host not responding to stop endpoint command
  3. xHCI host controller not responding, assume dead
  4. All USB devices on the affected xHCI controller disconnect

Disabling LPM prevents the firmware from entering the problematic low-
power states that precede the stall. This is the same approach used for
other webcams with similar firmware issues (e.g., Logitech, Realtek).

Cc: stable@vger.kernel.org
Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2061177
Signed-off-by: JP Hein <jp@jphein.com>
---
 drivers/usb/core/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -493,6 +493,8 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* Razer - Razer Blade Keyboard */
 	{ USB_DEVICE(0x1532, 0x0116), .driver_info =
 			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
+	/* Razer - Razer Kiyo Pro Webcam */
+	{ USB_DEVICE(0x1532, 0x0e05), .driver_info = USB_QUIRK_NO_LPM },

 	/* Lenovo ThinkPad OneLink+ Dock twin hub controllers (VIA Labs VL812) */
 	{ USB_DEVICE(0x17ef, 0x1018), .driver_info = USB_QUIRK_RESET_RESUME },
--
2.43.0

