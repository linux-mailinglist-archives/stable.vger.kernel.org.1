Return-Path: <stable+bounces-108792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D11DCA12047
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C513A16D0
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AB7248BBC;
	Wed, 15 Jan 2025 10:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MLUBIYIN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E55248BA1;
	Wed, 15 Jan 2025 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937820; cv=none; b=hyJoREI/Ja3hZcZ7zbPq30SoidbznerFwsfal7VREjNRa47PYyPbBXqpTPzPsOauMY2jHwhFDb/rLK8IEJXeNey9f9yOYjeQtxcOaQfwwf81W9sGVMCGBNgyUdlTMuK+z3t6UwKjo1jJrC7yrsCeaT22B7UYKb/ASnCvbuCPV78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937820; c=relaxed/simple;
	bh=jWPmMjFA/1/zrHWCm+n3R2uqcasNZthJPWLMoTQ1avI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pj0Tz//lS1htfX4+2B776V2z/eDdR5VAUSTon0azSywj710bOLwkIyaCu0tXf6ZIIyJWrB7qCFVTHsiZkHXopv17sV1SU6KgZGbr0DdV/LbyMVWLFNRjv+6RoGgHOjDoWRNxFFzhdlCwG5/5pA+AVnJa2JMyCluQB5Stbp2MN38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MLUBIYIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED21C4CEE2;
	Wed, 15 Jan 2025 10:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736937819;
	bh=jWPmMjFA/1/zrHWCm+n3R2uqcasNZthJPWLMoTQ1avI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MLUBIYINYaN6ez6CQ5tNBkKnpRlKhf6z2cHHX4a57OxAtWevWpyZOvmtlinedvq5P
	 2YA4KBhQsYvjhpWumbUefueflUREdGQbB4jHe5d34EJm3NXjW1FvEOgnW07QrRbZap
	 PsT8TYVl2UE4HyVKSdUKAF7wXRmKghuAUk9fPW6c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Lianqin Hu <hulianqin@vivo.com>
Subject: [PATCH 6.1 62/92] usb: gadget: u_serial: Disable ep before setting port to null to fix the crash caused by port being null
Date: Wed, 15 Jan 2025 11:37:20 +0100
Message-ID: <20250115103550.033905016@linuxfoundation.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115103547.522503305@linuxfoundation.org>
References: <20250115103547.522503305@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lianqin Hu <hulianqin@vivo.com>

commit 13014969cbf07f18d62ceea40bd8ca8ec9d36cec upstream.

Considering that in some extreme cases, when performing the
unbinding operation, gserial_disconnect has cleared gser->ioport,
which triggers gadget reconfiguration, and then calls gs_read_complete,
resulting in access to a null pointer. Therefore, ep is disabled before
gserial_disconnect sets port to null to prevent this from happening.

Call trace:
 gs_read_complete+0x58/0x240
 usb_gadget_giveback_request+0x40/0x160
 dwc3_remove_requests+0x170/0x484
 dwc3_ep0_out_start+0xb0/0x1d4
 __dwc3_gadget_start+0x25c/0x720
 kretprobe_trampoline.cfi_jt+0x0/0x8
 kretprobe_trampoline.cfi_jt+0x0/0x8
 udc_bind_to_driver+0x1d8/0x300
 usb_gadget_probe_driver+0xa8/0x1dc
 gadget_dev_desc_UDC_store+0x13c/0x188
 configfs_write_iter+0x160/0x1f4
 vfs_write+0x2d0/0x40c
 ksys_write+0x7c/0xf0
 __arm64_sys_write+0x20/0x30
 invoke_syscall+0x60/0x150
 el0_svc_common+0x8c/0xf8
 do_el0_svc+0x28/0xa0
 el0_svc+0x24/0x84

Fixes: c1dca562be8a ("usb gadget: split out serial core")
Cc: stable <stable@kernel.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lianqin Hu <hulianqin@vivo.com>
Link: https://lore.kernel.org/r/TYUPR06MB621733B5AC690DBDF80A0DCCD2042@TYUPR06MB6217.apcprd06.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/u_serial.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -1393,6 +1393,10 @@ void gserial_disconnect(struct gserial *
 	/* REVISIT as above: how best to track this? */
 	port->port_line_coding = gser->port_line_coding;
 
+	/* disable endpoints, aborting down any active I/O */
+	usb_ep_disable(gser->out);
+	usb_ep_disable(gser->in);
+
 	port->port_usb = NULL;
 	gser->ioport = NULL;
 	if (port->port.count > 0) {
@@ -1404,10 +1408,6 @@ void gserial_disconnect(struct gserial *
 	spin_unlock(&port->port_lock);
 	spin_unlock_irqrestore(&serial_port_lock, flags);
 
-	/* disable endpoints, aborting down any active I/O */
-	usb_ep_disable(gser->out);
-	usb_ep_disable(gser->in);
-
 	/* finally, free any unused/unusable I/O buffers */
 	spin_lock_irqsave(&port->port_lock, flags);
 	if (port->port.count == 0)



