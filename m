Return-Path: <stable+bounces-211067-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yM8eCKs0cWlQfQAAu9opvQ
	(envelope-from <stable+bounces-211067-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:18:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE4C5D046
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 373E1AE423E
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FB23612DB;
	Wed, 21 Jan 2026 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N68TEWa9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D68376BE3;
	Wed, 21 Jan 2026 18:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020328; cv=none; b=haHclUZsq//M06j8Rw9JdZ8CRhzbw/D23NAUugXLxqS+fNZYtDvopoJPf3iDEus3vi8IhsQi9gonCb240++c6bW2Oq84f793+IEhySiDP3xw/Q0z27sFrV09Ez+zlpYtddZJsB5LUdbVKgl+/4NVO87HkZO8ov+P9aUxgkP6TCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020328; c=relaxed/simple;
	bh=JmuyBUzFe4OZpHtpbjid6IwC33+rYZf5/P3DrErATkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KK1YJh8aB555wXH+qJgkFLiBYt9+IyBZNS7SanvhR+7mOKssrRLwiOvuJqQoV5lfB/xn8yQNda0euNygs/z7zRXTnsVpbQvu586FWzeCKRU6+GA6ElgSn6F5yzZyfq1lUVA2VrWc0DBlosupE0Grutg8DwSJl2OxmdVagP60tuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N68TEWa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1E2C4CEF1;
	Wed, 21 Jan 2026 18:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020328;
	bh=JmuyBUzFe4OZpHtpbjid6IwC33+rYZf5/P3DrErATkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N68TEWa9GWGWC76n6S+ga8Gn1q9FcGtZAn3rDgo2hRzqiyV1KsuZFzzNYBfyiP38P
	 annugM+YLf9rYNOApHYJ5fBPzIytGWXZflOmxsOI/8TEBvfJfyFdTHjS6ofQFL6BH6
	 IWKl0u6n+ssIullL8cid3VryA8zIWDdShDOtGqBQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 6.18 125/198] USB: serial: ftdi_sio: add support for PICAXE AXE027 cable
Date: Wed, 21 Jan 2026 19:15:53 +0100
Message-ID: <20260121181423.048081338@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-211067-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,opendcc.de:url]
X-Rspamd-Queue-Id: 7DE4C5D046
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ethan Nelson-Moore <enelsonmoore@gmail.com>

commit c0afe95e62984ceea171c3ea319beaf84a21181c upstream.

The vendor provides instructions to write "0403 bd90" to
/sys/bus/usb-serial/drivers/ftdi_sio/new_id; see:
https://picaxe.com/docs/picaxe_linux_instructions.pdf

Cc: stable@vger.kernel.org
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/ftdi_sio.c     |    1 +
 drivers/usb/serial/ftdi_sio_ids.h |    2 ++
 2 files changed, 3 insertions(+)

--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -850,6 +850,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, LMI_LM3S_DEVEL_BOARD_PID, 1) },
 	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, LMI_LM3S_EVAL_BOARD_PID, 1) },
 	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, LMI_LM3S_ICDI_BOARD_PID, 1) },
+	{ USB_DEVICE(FTDI_VID, FTDI_AXE027_PID) },
 	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, FTDI_TURTELIZER_PID, 1) },
 	{ USB_DEVICE(RATOC_VENDOR_ID, RATOC_PRODUCT_ID_USB60F) },
 	{ USB_DEVICE(RATOC_VENDOR_ID, RATOC_PRODUCT_ID_SCU18) },
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -96,6 +96,8 @@
 #define LMI_LM3S_EVAL_BOARD_PID		0xbcd9
 #define LMI_LM3S_ICDI_BOARD_PID		0xbcda
 
+#define FTDI_AXE027_PID		0xBD90 /* PICAXE AXE027 USB download cable */
+
 #define FTDI_TURTELIZER_PID	0xBDC8 /* JTAG/RS-232 adapter by egnite GmbH */
 
 /* OpenDCC (www.opendcc.de) product id */



