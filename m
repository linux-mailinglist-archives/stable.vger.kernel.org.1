Return-Path: <stable+bounces-171675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A68B2B47A
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 01:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745B01779BB
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 23:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EF127603C;
	Mon, 18 Aug 2025 23:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GG5R9OxT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EE626FA6F
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755558842; cv=none; b=pqb+hvXR1ySJ7J9+C4uPkGF7An+SybO3Wy0TmU7GCAv4jWc1PbBv1dje0ByVmimbwKm6h5VV9z3FVd/1LDmPFZ3JQMDtJ8C/5aOpd7Nr7/qGmTtT7JLGBZPxczqpAf6W0O1FnNmoQwZSi2XYADsdAuyGyC3gB/DIwhKV7PysZIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755558842; c=relaxed/simple;
	bh=yczxjXkMiMB0Vw0Bsydz3hiH9iFXOh8e8eBn+28+ibM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jmNceFFPCFfAbyrMsajTsrghflokdkqX5upMIh2k9dWCJqJZ39ac02vAj23q9AEeLB+F0EY2FS8YQ68UOoOsljok1RpIC0T8Col5Bm20guwUhaP9Oo95PpXt5LUBl/hSJ3vkUFqdHl2v9tVFoBBQ9jtVwAYJQuYCrgSFYovECvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GG5R9OxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B3EC116B1;
	Mon, 18 Aug 2025 23:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755558841;
	bh=yczxjXkMiMB0Vw0Bsydz3hiH9iFXOh8e8eBn+28+ibM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GG5R9OxTfa8Pb6BgsZxg86yFfcyh7pbaktX9riqEEVpc+APIesyxhGgIO4RRpgPve
	 sN5Uuh0cPBdTNJMZp4oyrFLOEdTS8tZFsto/r3wXd6+QK7P8dhctDxOAJ0uGLOkTOV
	 Vp7B2/h+3N1P04glO7QKmA/0hAXTZKxPO6Iks4mDQ0Q/TyqtHgBsjlvTs/kJkSEI53
	 IXrbELJJCeLhrbkC+KiunquG98Ta9LmBCmkHGxnFoqdmmbFYj5e3ibLenayeCajbxf
	 8vSeB/mT83PZWaexB2uj8dL9VPuGPNx9N+wrczmcdK6YfrbZhzUEEMOD9iwxseEOjN
	 NGnISPTuFHQoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 2/2] cdc-acm: fix race between initial clearing halt and open
Date: Mon, 18 Aug 2025 19:13:58 -0400
Message-ID: <20250818231358.138342-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818231358.138342-1-sashal@kernel.org>
References: <2025081847-user-synthesis-c726@gregkh>
 <20250818231358.138342-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Oliver Neukum <oneukum@suse.com>

[ Upstream commit 64690a90cd7c6db16d3af8616be1f4bf8d492850 ]

On the devices that need their endpoints to get an
initial clear_halt, this needs to be done before
the devices can be opened. That means it needs to be
before the devices are registered.

Fixes: 15bf722e6f6c0 ("cdc-acm: Add support of ATOL FPrint fiscal printers")
Cc: stable <stable@kernel.org>
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Link: https://lore.kernel.org/r/20250717141259.2345605-1-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/class/cdc-acm.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 51f2caf0fb3e..4730089a771b 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1527,6 +1527,12 @@ static int acm_probe(struct usb_interface *intf,
 	usb_driver_claim_interface(&acm_driver, data_interface, acm);
 	usb_set_intfdata(data_interface, acm);
 
+	if (quirks & CLEAR_HALT_CONDITIONS) {
+		/* errors intentionally ignored */
+		usb_clear_halt(usb_dev, acm->in);
+		usb_clear_halt(usb_dev, acm->out);
+	}
+
 	tty_dev = tty_port_register_device(&acm->port, acm_tty_driver, minor,
 			&control_interface->dev);
 	if (IS_ERR(tty_dev)) {
@@ -1534,11 +1540,6 @@ static int acm_probe(struct usb_interface *intf,
 		goto alloc_fail6;
 	}
 
-	if (quirks & CLEAR_HALT_CONDITIONS) {
-		usb_clear_halt(usb_dev, acm->in);
-		usb_clear_halt(usb_dev, acm->out);
-	}
-
 	dev_info(&intf->dev, "ttyACM%d: USB ACM device\n", minor);
 
 	return 0;
-- 
2.50.1


