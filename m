Return-Path: <stable+bounces-234389-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0L3sIDae1mkEGwgAu9opvQ
	(envelope-from <stable+bounces-234389-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:28:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F36783C0C4C
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F34E2300DD67
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC5C3D3D06;
	Wed,  8 Apr 2026 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o/9O9vhK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E13A3A16A0;
	Wed,  8 Apr 2026 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672732; cv=none; b=ZLAQTBTdmipDg3kRMGXnXbBIEJTjE4WIMCFw1XpvlpKItueoJ4J7bqHH+sTNmlLWKHaJsZZHNKtNQf3dbbb2oNzPwKopoJhsnI8WKHfdNRJ9hxD0nEesC0XwcVZv8afTfuCG+66OuHfLdo0L9j2/kNlHvBnR45EaGC+6XvxiEQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672732; c=relaxed/simple;
	bh=zl5I1CmpIIawUnYqsoNQ+nELbDLqKOX3yYuNhQYIfDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZCdjZrI86RUZMdGkQ3kQ/m43i7Y8E9E35QaTHYow4g6yEuMen/ISoBbmBi754AOiT8fTreQEy38mXyi2+ZemrhMEaSu9RL6UlwrO/Kh4MtKxP/zH7GvYxu/c0MtMqJwz6q+oCHEsToBe16hIGC+nr+AJ8o5dZAcY3B59JQ6zXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o/9O9vhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F96CC19421;
	Wed,  8 Apr 2026 18:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672731;
	bh=zl5I1CmpIIawUnYqsoNQ+nELbDLqKOX3yYuNhQYIfDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o/9O9vhK0pU/PBe+zyjfRHRjkAxHH2TrZNjRptHM/Rx7WQk3DiE4N8qf0qeWQZ0p2
	 +Rgw3+oAqSilszYnfCzBSyOV0+bTmzuYNUcuexfMpI50sShJeMm9D0e3Gmy5dtDlhT
	 Z4XCDJxaOOjT0DVQm0BysW3m9aO5ofMHBdkoYsWw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 6.6 120/160] comedi: me_daq: Fix potential overrun of firmware buffer
Date: Wed,  8 Apr 2026 20:03:27 +0200
Message-ID: <20260408175917.673285742@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175913.177092714@linuxfoundation.org>
References: <20260408175913.177092714@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234389-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mev.co.uk:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: F36783C0C4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Abbott <abbotti@mev.co.uk>

commit cc797d4821c754c701d9714b58bea947e31dbbe0 upstream.

`me2600_xilinx_download()` loads the firmware that was requested by
`request_firmware()`.  It is possible for it to overrun the source
buffer because it blindly trusts the file format.  It reads a data
stream length from the first 4 bytes into variable `file_length` and
reads the data stream contents of length `file_length` from offset 16
onwards.  Although it checks that the supplied firmware is at least 16
bytes long, it does not check that it is long enough to contain the data
stream.

Add a test to ensure that the supplied firmware is long enough to
contain the header and the data stream.  On failure, log an error and
return `-EINVAL`.

Fixes: 85acac61096f9 ("Staging: comedi: add me_daq driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://patch.msgid.link/20260205140130.76697-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/comedi/drivers/me_daq.c |   35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

--- a/drivers/comedi/drivers/me_daq.c
+++ b/drivers/comedi/drivers/me_daq.c
@@ -344,6 +344,25 @@ static int me2600_xilinx_download(struct
 	unsigned int file_length;
 	unsigned int i;
 
+	/*
+	 * Format of the firmware
+	 * Build longs from the byte-wise coded header
+	 * Byte 1-3:   length of the array
+	 * Byte 4-7:   version
+	 * Byte 8-11:  date
+	 * Byte 12-15: reserved
+	 */
+	if (size >= 4) {
+		file_length = (((unsigned int)data[0] & 0xff) << 24) +
+			      (((unsigned int)data[1] & 0xff) << 16) +
+			      (((unsigned int)data[2] & 0xff) << 8) +
+			      ((unsigned int)data[3] & 0xff);
+	}
+	if (size < 16 || file_length > size - 16) {
+		dev_err(dev->class_dev, "Firmware length inconsistency\n");
+		return -EINVAL;
+	}
+
 	/* disable irq's on PLX */
 	writel(0x00, devpriv->plx_regbase + PLX9052_INTCSR);
 
@@ -358,22 +377,6 @@ static int me2600_xilinx_download(struct
 	sleep(1);
 
 	/*
-	 * Format of the firmware
-	 * Build longs from the byte-wise coded header
-	 * Byte 1-3:   length of the array
-	 * Byte 4-7:   version
-	 * Byte 8-11:  date
-	 * Byte 12-15: reserved
-	 */
-	if (size < 16)
-		return -EINVAL;
-
-	file_length = (((unsigned int)data[0] & 0xff) << 24) +
-	    (((unsigned int)data[1] & 0xff) << 16) +
-	    (((unsigned int)data[2] & 0xff) << 8) +
-	    ((unsigned int)data[3] & 0xff);
-
-	/*
 	 * Loop for writing firmware byte by byte to xilinx
 	 * Firmware data start at offset 16
 	 */



