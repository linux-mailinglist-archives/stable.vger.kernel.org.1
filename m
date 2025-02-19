Return-Path: <stable+bounces-117418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1EFA3B68A
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB9E1795B2
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258F91E231E;
	Wed, 19 Feb 2025 08:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DmrbaoFR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CAC1E105E;
	Wed, 19 Feb 2025 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955223; cv=none; b=UGFPvsnPbLmdJsttVcDe7h4WvtI5TklKmh2flmMoo5KTreYhmTPSMK1m8vXBn4mCIBBG/oA6WZ2gDVvRWlI3SUvUqKzK/zCvql9QwzEQT8wS2HjI8eS29BkWN3NxA8ZFNUGB2C2i9eos29ePdgsa2EK0ryy+MEqIHOhO1tUjb0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955223; c=relaxed/simple;
	bh=L4n5rKvBhM9sK8m4YzXXdh1/jQ+YtKD2ZMo1OxAxkUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibVLf2q/SrLv3tZ3lBxrqWc6ULnqAlmHpk/eOaW3tVCMX+LLx3gYUrldHloJxeUbWOr1K68yip2XMNYNNCBQKvZ+kC1TCYifPcM5YpXB3ZaRZ8u/HWS8BN+zFJsmW4PJJkornSTqJI1uCKEv26Rs3XLu6Y1EPyO8pyaey7bdlEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DmrbaoFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CD5C4CED1;
	Wed, 19 Feb 2025 08:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739955223;
	bh=L4n5rKvBhM9sK8m4YzXXdh1/jQ+YtKD2ZMo1OxAxkUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DmrbaoFR0Vn7aVZ/z/EitlS53OLc4ViDCyYbc7wfZAa10YzvO5ZidBP5rZaxqGtP0
	 0QaYyp/d+lVVtj9uJSS2y5i9a5z8SybH/kHtVYp8BYt9gziNw4MGbnn/9wua+skTZQ
	 rQCpS3Yj840h/YXylpPX1IfHgyLoim2Vmq0dwC3M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fabio Porcedda <fabio.porcedda@gmail.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 6.12 127/230] USB: serial: option: fix Telit Cinterion FN990A name
Date: Wed, 19 Feb 2025 09:27:24 +0100
Message-ID: <20250219082606.654019720@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082601.683263930@linuxfoundation.org>
References: <20250219082601.683263930@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabio Porcedda <fabio.porcedda@gmail.com>

commit 12606fe73f33647c5e79bf666833bf0b225e649d upstream.

The correct name for FN990 is FN990A so use it in order to avoid
confusion with FN990B.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/option.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1370,15 +1370,15 @@ static const struct usb_device_id option
 	  .driver_info = NCTRL(2) | RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1063, 0xff),	/* Telit LN920 (ECM) */
 	  .driver_info = NCTRL(0) | RSVD(1) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1070, 0xff),	/* Telit FN990 (rmnet) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1070, 0xff),	/* Telit FN990A (rmnet) */
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1071, 0xff),	/* Telit FN990 (MBIM) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1071, 0xff),	/* Telit FN990A (MBIM) */
 	  .driver_info = NCTRL(0) | RSVD(1) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1072, 0xff),	/* Telit FN990 (RNDIS) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1072, 0xff),	/* Telit FN990A (RNDIS) */
 	  .driver_info = NCTRL(2) | RSVD(3) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1073, 0xff),	/* Telit FN990 (ECM) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1073, 0xff),	/* Telit FN990A (ECM) */
 	  .driver_info = NCTRL(0) | RSVD(1) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1075, 0xff),	/* Telit FN990 (PCIe) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1075, 0xff),	/* Telit FN990A (PCIe) */
 	  .driver_info = RSVD(0) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1080, 0xff),	/* Telit FE990 (rmnet) */
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },



