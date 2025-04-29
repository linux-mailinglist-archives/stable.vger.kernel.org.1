Return-Path: <stable+bounces-137271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC27AA12A6
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1985E981503
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A895248866;
	Tue, 29 Apr 2025 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AxhsHumI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B951C215060;
	Tue, 29 Apr 2025 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945571; cv=none; b=r6C/kKVJ4e6zWJ+/2e23ezw4CtXivYJUY0814yJlcFssZtf0Fn9mX3hyRxEZsy45Bs4oXhd7tUbXZwCux2IbwZ3FYoQ6NBQox/BESTjtaA9SHtJOZJIle1RPt7wDmAcjazMklcXjYVGkg9D1VPdLvzIKpFfzq96fnvTPo1VjKQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945571; c=relaxed/simple;
	bh=MBSKMlrpqHX72pE/XOXXOY2mDQbwF8jXuKEO14+fjgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYRKyOT0ZW7mJCt62qflbFBmQyENYwVQJdiIZ+xZ8vrLjrywl6LInaxy45b97qjQZhCBCpKEJ3waGZJUzr2a6UlPMEvW66G/SpYtN+50kXwAcBIt1sB7JtQEAGTs+ghtdspDGKbO98Q+w16189DQpHNwJCf+/mhRRlu8GYmA11w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AxhsHumI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E38CC4CEE3;
	Tue, 29 Apr 2025 16:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745945571;
	bh=MBSKMlrpqHX72pE/XOXXOY2mDQbwF8jXuKEO14+fjgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AxhsHumIXC4z5DiV5h7oswKafEePLeI8CR4RCWdVa0vRNuzajIBHYQiSWHKmpwMxQ
	 fCJn6PVBS26dTG6dEaSNTeU7osJfNlTq85N66f7a29N/0fOQBduVokhChJjL0MLvPY
	 UTxle5Y2lFvwD4ctizfvNRJiUapbVHXWXdy0dtRA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Ehrenreich <michideep@gmail.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.4 150/179] USB: serial: ftdi_sio: add support for Abacus Electrics Optical Probe
Date: Tue, 29 Apr 2025 18:41:31 +0200
Message-ID: <20250429161055.455763473@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161049.383278312@linuxfoundation.org>
References: <20250429161049.383278312@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ehrenreich <michideep@gmail.com>

commit b399078f882b6e5d32da18b6c696cc84b12f90d5 upstream.

Abacus Electrics makes optical probes for interacting with smart meters
over an optical interface.

At least one version uses an FT232B chip (as detected by ftdi_sio) with
a custom USB PID, which needs to be added to the list to make the device
work in a plug-and-play fashion.

Signed-off-by: Michael Ehrenreich <michideep@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/ftdi_sio.c     |    2 ++
 drivers/usb/serial/ftdi_sio_ids.h |    5 +++++
 2 files changed, 7 insertions(+)

--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1071,6 +1071,8 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 1) },
 	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 2) },
 	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 3) },
+	/* Abacus Electrics */
+	{ USB_DEVICE(FTDI_VID, ABACUS_OPTICAL_PROBE_PID) },
 	{ }					/* Terminating entry */
 };
 
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -436,6 +436,11 @@
 #define LINX_FUTURE_2_PID   0xF44C	/* Linx future device */
 
 /*
+ * Abacus Electrics
+ */
+#define ABACUS_OPTICAL_PROBE_PID	0xf458 /* ABACUS ELECTRICS Optical Probe */
+
+/*
  * Oceanic product ids
  */
 #define FTDI_OCEANIC_PID	0xF460  /* Oceanic dive instrument */



