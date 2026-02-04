Return-Path: <stable+bounces-213574-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBzBIhlig2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213574-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:13:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF59CE824B
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80B81305DBB7
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AE041B34E;
	Wed,  4 Feb 2026 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="es/5ZF5L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA4227F749;
	Wed,  4 Feb 2026 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216789; cv=none; b=nW6MmpxlKErWsSLUUmKsUBvzkPwZ+AsiE7n7+kDCyoZffIzD3uZ2nKh+4fspgiK5LPnr0KcM7lNDJKrbUajaSUNomFlPTr+ZXLeJJ0cyGQb052GtjohrUx6IOfogD0WjRp88ZQR/RG0636encszyCGVhjcodmCtCJ8LENUPW6+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216789; c=relaxed/simple;
	bh=TRy+/3hnquhpm/3TbeK1IK/Bjgmaxz/JRam5wILkV80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCw95/xQdP8zyDylB+Nin71Cagi2AglQU+FuhFDeMeuMlGhpJHFIjmI16IKXn5YEhFMMQY6eIqYD1HcRFrM93+Baw8F2hvJPVngvS5z+OCZHCf7PAtR96de7b7LMGRGFFJr0A29eC1N0SJEU9zJqk+vlOWUYJ7CbaTvNtMx7cks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=es/5ZF5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BD4C19423;
	Wed,  4 Feb 2026 14:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216789;
	bh=TRy+/3hnquhpm/3TbeK1IK/Bjgmaxz/JRam5wILkV80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=es/5ZF5Lo7Q5ny3XIQXjbxS4vR3AOt/xhSROTt1Us4kLIkgkeQeLnsoL2h/Up9pdz
	 uKNzMTrWDF6Jg181meBzPeYLNMvKNzuHXruQfov9gHgPVJcGk1JqcWvI3bVP2a3Mlj
	 sXWli+JQxnrsB9eUXYq5ivqi24sv7YWud4x5C1CA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.15 032/206] USB: serial: ftdi_sio: add support for PICAXE AXE027 cable
Date: Wed,  4 Feb 2026 15:37:43 +0100
Message-ID: <20260204143859.359452039@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143858.193781818@linuxfoundation.org>
References: <20260204143858.193781818@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213574-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[opendcc.de:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF59CE824B
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -828,6 +828,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, LMI_LM3S_DEVEL_BOARD_PID, 1) },
 	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, LMI_LM3S_EVAL_BOARD_PID, 1) },
 	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, LMI_LM3S_ICDI_BOARD_PID, 1) },
+	{ USB_DEVICE(FTDI_VID, FTDI_AXE027_PID) },
 	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, FTDI_TURTELIZER_PID, 1) },
 	{ USB_DEVICE(RATOC_VENDOR_ID, RATOC_PRODUCT_ID_USB60F) },
 	{ USB_DEVICE(RATOC_VENDOR_ID, RATOC_PRODUCT_ID_SCU18) },
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -89,6 +89,8 @@
 #define LMI_LM3S_EVAL_BOARD_PID		0xbcd9
 #define LMI_LM3S_ICDI_BOARD_PID		0xbcda
 
+#define FTDI_AXE027_PID		0xBD90 /* PICAXE AXE027 USB download cable */
+
 #define FTDI_TURTELIZER_PID	0xBDC8 /* JTAG/RS-232 adapter by egnite GmbH */
 
 /* OpenDCC (www.opendcc.de) product id */



