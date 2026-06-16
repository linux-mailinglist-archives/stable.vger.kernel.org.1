Return-Path: <stable+bounces-265902-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5ksJL5CSMWpZnAUAu9opvQ
	(envelope-from <stable+bounces-265902-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:14:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6608E693F13
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:14:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=dddWSme4;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265902-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-265902-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF1D930C517D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3C13D8125;
	Tue, 16 Jun 2026 18:13:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3DE3D47CE;
	Tue, 16 Jun 2026 18:13:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781633599; cv=none; b=b8YcQEN5XsKGRs5iX+K+7Nq6z7jsi8t6YbcEZBGd1dmpMVFJRAI4rQ7mcCaxSE160gZbhcaCsECbPKI0y4T80px24zOkSv3PPXih0iN3dv5UIOmAgNbJwTAFF06r2POhlumuUHBVdgURk+YqzaE2t5gjlOtXuTfHEZeCgSCi9cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781633599; c=relaxed/simple;
	bh=38jk3uO1FJK3Igc7wHQ8UE+6juMCJACIufX3xW7GrSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BI7PW5yVD4aTA5VsuwwCV5tIj8ZwoqW1FX24jYEUVJlhoKb7V7Ov05XFvFdJRLAtS9wxbfvgkNZ++7/9nRUuOf0E7RgJ3UKds1vZ8WAXMLJUATpG70V6iPeCWVb31N2Kvd0tKQzqoLla6HS/nKadwOLu/apYVAdmqiaFBqj/+2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dddWSme4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD3A1F00A3A;
	Tue, 16 Jun 2026 18:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781633598;
	bh=TCWg5OWGvs1jAMv9g4U8idC3jh4gqgu5hSYwM8d7gCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dddWSme4qmDq6T0hPB8AaVjHBGDXbI8CBEiPnheXzJ0vhZAfWrvJajeLPaRy+hdcW
	 BbTkrLLctsEFW9CBhoxrSbzpN4BRmBKsM66ziMnBcRTjf2uJHdUBJKx8Cz8CnqAh9z
	 iprDy21eG9Hv3hCS81SdcWJPII+pPMS2t+2BBQbQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Stephen J. Fuhry" <fuhrysteve@gmail.com>,
	stable <stable@kernel.org>
Subject: [PATCH 5.15 109/411] USB: quirks: add NO_LPM for Lenovo ThinkPad USB-C Dock Gen2 hub controllers
Date: Tue, 16 Jun 2026 20:25:47 +0530
Message-ID: <20260616145106.066169430@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-265902-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:fuhrysteve@gmail.com,m:stable@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6608E693F13

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen J. Fuhry <fuhrysteve@gmail.com>

commit 9ddb9c0deca48d2c2a22ebf4d2f35c925a520328 upstream.

The Lenovo ThinkPad USB-C Dock Gen2 (17ef:a391, 17ef:a392) hub
controllers exhibit link instability when USB Link Power Management
is enabled, similar to the dock's Ethernet adapter (17ef:a387) which
already carries USB_QUIRK_NO_LPM.

When the dock reconnects after a transient disconnect, the hub
controllers enter LPM states between re-enumeration retries, causing
repeated disconnect/reconnect cycles lasting up to two minutes.
Disabling LPM for these devices restores stable enumeration.

Signed-off-by: Stephen J. Fuhry <fuhrysteve@gmail.com>
Cc: stable <stable@kernel.org>
Link: https://patch.msgid.link/20260513171419.44849-1-fuhrysteve@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/quirks.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -497,6 +497,10 @@ static const struct usb_device_id usb_qu
 	/* Lenovo ThinkPad USB-C Dock Gen2 Ethernet (RTL8153 GigE) */
 	{ USB_DEVICE(0x17ef, 0xa387), .driver_info = USB_QUIRK_NO_LPM },
 
+	/* Lenovo ThinkPad USB-C Dock Gen2 USB 3.1 and USB 2.0 hub controllers */
+	{ USB_DEVICE(0x17ef, 0xa391), .driver_info = USB_QUIRK_NO_LPM },
+	{ USB_DEVICE(0x17ef, 0xa392), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* BUILDWIN Photo Frame */
 	{ USB_DEVICE(0x1908, 0x1315), .driver_info =
 			USB_QUIRK_HONOR_BNUMINTERFACES },



