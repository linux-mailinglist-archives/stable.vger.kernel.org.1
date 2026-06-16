Return-Path: <stable+bounces-265108-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RsWjLJqEMWrBlQUAu9opvQ
	(envelope-from <stable+bounces-265108-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:15:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8FB692E94
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:15:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=FDX5CC0+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265108-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265108-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 47E9E304F2A4
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF0443D4E9;
	Tue, 16 Jun 2026 17:05:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A8943D4E8;
	Tue, 16 Jun 2026 17:05:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629513; cv=none; b=VpT2e+fRc+jORpUK39X+OIadzKbzzUG8pk40cHr3fQ5BZb0LTrIKW2IYIMN/ycEoYpKwhTyazinyORMARbW5hVRhbwYKfL9PDSpLgdg3s1kyyfz8Uh7ZtjU7mSpzBlVTV4QynEjG3VnVc5yNuHiakagnEVPAl4sYi7v4dt/T0U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629513; c=relaxed/simple;
	bh=m3ZlHccrlG+3p8NNVTmxyiY9WBq6UQutydFTbi7t7jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hd9Zxn/1LrAOW2UtbXdIbXnLA4Xj++bwGGJN4kA2XX0OGHrjOfE0HcFDXoRv1vt0D5Qjqqu1gCQGWzXiWee/zGExiXKg3Kj/jtc7xgknlkqa+lK/XVoDKdwGUF6iOAZApnAj5JTm0znB8SOxGPj7eofIr82valOidO5CL4+kznw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FDX5CC0+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E291F000E9;
	Tue, 16 Jun 2026 17:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781629512;
	bh=li2Q4FTphL8nCS1el0dhHPUaS0RdGcTQMBRpAjxdrWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FDX5CC0+tQMzDBR9gXagXsFN1KSzBtGLWe1Shtkvw3PmH2Gy6PU9JBJ0NjM+gtfH3
	 HIJZiP56rVKeaaTYMR0mdtBb/tNQYIueOjwWJCg9r5nA8t8Mkt2GeAIvWi2SQCKToC
	 LkMM6qlG9vWtHnzZ+u3uOjarY/G5dyi4uhC5LRbE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adrian Korwel <adriank20047@gmail.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 6.6 300/452] USB: serial: io_ti: fix heap overflow in get_manuf_info()
Date: Tue, 16 Jun 2026 20:28:47 +0530
Message-ID: <20260616145133.279759282@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-265108-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:adriank20047@gmail.com,m:johan@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB8FB692E94

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Korwel <adriank20047@gmail.com>

commit 183c1076eca43bbb3e7bdf597456f91d81c73e74 upstream.

get_manuf_info() reads le16_to_cpu(rom_desc->Size) bytes from the
device I2C EEPROM into a buffer allocated with kmalloc_obj(), which
is sizeof(struct edge_ti_manuf_descriptor) = 10 bytes.

The Size field comes from the device and is only validated (in
check_i2c_image()) to make sure the descriptor fits within
TI_MAX_I2C_SIZE (16384 bytes), not against the destination buffer size.
A malicious USB device can therefore set Size to any value up to 16377,
causing a heap overflow of up to 16367 bytes when plugged into a host
running this driver.

valid_csum() is called after read_rom() and also iterates
buffer[0..Size-1], compounding the out-of-bounds access.

Fix by rejecting descriptors with unexpected length before calling
read_rom().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Korwel <adriank20047@gmail.com>
[ johan: amend commit message; also check for short descriptors ]
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/io_ti.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/usb/serial/io_ti.c
+++ b/drivers/usb/serial/io_ti.c
@@ -773,6 +773,12 @@ static int get_manuf_info(struct edgepor
 	}
 
 	/* Read the descriptor data */
+	if (le16_to_cpu(rom_desc->Size) != sizeof(struct edge_ti_manuf_descriptor)) {
+		dev_err(dev, "unexpected Edge descriptor length: %u\n",
+			le16_to_cpu(rom_desc->Size));
+		status = -EINVAL;
+		goto exit;
+	}
 	status = read_rom(serial, start_address+sizeof(struct ti_i2c_desc),
 					le16_to_cpu(rom_desc->Size), buffer);
 	if (status)



