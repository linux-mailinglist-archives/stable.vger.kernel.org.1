Return-Path: <stable+bounces-222914-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id U3ILH+MVp2m+dgAAu9opvQ
	(envelope-from <stable+bounces-222914-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 18:09:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DC01F46BD
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 18:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFD003029613
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 17:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4BF3C278E;
	Tue,  3 Mar 2026 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bn7Ejcfv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3483A5E8B;
	Tue,  3 Mar 2026 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772557717; cv=none; b=AAICmyXvSQ20k1lkwrn9XINVs30ClwHaVIVnXTDnc6NFvfNGQjPbpR3tfXp9PovWsSslfUQF4uFcyBCa5RMMMB53B3SUVRmiZJ+gmWu0o8CWT/QAs+/liNHl7hyC/G3tlVG/+KGJa0yK4j+brW/xrG5cBFfDMW6jJ/7yt8KI3tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772557717; c=relaxed/simple;
	bh=85T4a9tDQeqQgooF6tLkpLk28kfophnD+5HJrDO7yL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uF52vEvKnP9NuOA4aVinAAGoiD2ke2jyBefcK0huhQ7X9W8GfZBZ5lNYRL9Fh9+mjmSFqUDIidzxdeWNbphHz8NPMqyjDAl9bgaEAU4l0TQwIwCgEVnLZaPwwgnOtXTjCMArA5jHfGyOHAbkFAlevzjhO/NvEuM7GP8x+o4PyzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bn7Ejcfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4121CC116C6;
	Tue,  3 Mar 2026 17:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772557717;
	bh=85T4a9tDQeqQgooF6tLkpLk28kfophnD+5HJrDO7yL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bn7EjcfvRbg+Thd6vuxfhpPxFqqEEcwc382lrTPGG4QOEhN77ueGA/wkLWHXHipMr
	 Pgf1mQp/IUc5oJR0HEWBSV5qmNjsTjpeJkFJXf2Ls0eJvGotkbjKaCYXpxv/OJUEs5
	 96sdGA3e1z0XAB5lSLpdAkpLWCCcOPTXIPUsPjAYH3mKVcSein0UPvppqUS/Qw4MYR
	 U971430TKLY6+eI9I9BTjKuWiSiTh2y+cHhj9zWmU1d1E7amZyFh1qk4QDKwsMPG1D
	 ckITIwpFSy03VlAuvl7jgrXxyFCSjTjLR1cCv/kTh2GrwUjM94/JRIyVrDgAnwKwtA
	 /JqV98R/gUH4Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vxTEZ-000000001CE-0JaU;
	Tue, 03 Mar 2026 18:08:35 +0100
From: Johan Hovold <johan@kernel.org>
To: Dave Penkler <dpenkler@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] gpib: fix unintended binding of FTDI 8U232AM devices
Date: Tue,  3 Mar 2026 18:07:21 +0100
Message-ID: <20260303170722.4516-2-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260303170722.4516-1-johan@kernel.org>
References: <20260303170722.4516-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B0DC01F46BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-222914-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

The LPVO USB GPIB adapter apparently uses an FTDI 8U232AM with the
default PID, but this device id is already handled by the ftdi_sio
serial driver.

Stop binding to the default PID to avoid breaking existing setups with
FTDI 8U232AM.

Anyone using this driver should blacklist the ftdi_sio driver and add
the device id manually through sysfs (e.g. using udev rules).

Fixes: fce79512a96a ("staging: gpib: Add LPVO DIY USB GPIB driver")
Fixes: e6ab504633e4 ("staging: gpib: Destage gpib")
Cc: Dave Penkler <dpenkler@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index 6fc4e3452b88..ee781d2f0b8e 100644
--- a/drivers/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -38,8 +38,10 @@ MODULE_DESCRIPTION("GPIB driver for LPVO usb devices");
 /*
  * Table of devices that work with this driver.
  *
- * Currently, only one device is known to be used in the
- * lpvo_usb_gpib adapter (FTDI 0403:6001).
+ * Currently, only one device is known to be used in the lpvo_usb_gpib
+ * adapter (FTDI 0403:6001) but as this device id is already handled by the
+ * ftdi_sio USB serial driver the LPVO driver must not bind to it by default.
+ *
  * If your adapter uses a different chip, insert a line
  * in the following table with proper <Vendor-id>, <Product-id>.
  *
@@ -50,7 +52,6 @@ MODULE_DESCRIPTION("GPIB driver for LPVO usb devices");
  */
 
 static const struct usb_device_id skel_table[] = {
-	{ USB_DEVICE(0x0403, 0x6001) },
 	{ }					   /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, skel_table);
-- 
2.52.0


