Return-Path: <stable+bounces-214465-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPTOBcuihGmI3wMAu9opvQ
	(envelope-from <stable+bounces-214465-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:01:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B750F3B3C
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B88A30022E5
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 14:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE683E9F8E;
	Thu,  5 Feb 2026 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="LEtRJA8b"
X-Original-To: stable@vger.kernel.org
Received: from smtp109.iad3b.emailsrvr.com (smtp109.iad3b.emailsrvr.com [146.20.161.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40EC217F24
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770300103; cv=none; b=qjMvnCQoeDZyBkTkMdv8q8cd3ztjMaSsAIdJwh2Rbu0pZwzlLNXdnVl28RQF6PlCM0jc7eKA6ZdfmqWOhAXXdtb1tw7q4/490wpgLyFXeJ4zu1xk0Nd8gxJtua3H5O2RskAiJmdfPQgFk6B94yEQv3ptj9UwHnTqY5MYz6nORu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770300103; c=relaxed/simple;
	bh=Kh/c3EgSWaE34dStd7ZhLaGQD/ZXd875rbFUsvE2IdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uijyqvexyx9EXsyQp5Jj3tzCy/y5Ofy+6GT4943mE79VlI9OxxvQy0mrXjdJ+bTtE+jJTtXuVVdWGOUDN3kpf7NLf4pk+1/AeHRxPmrF7EIoPxjxcJu/jhWAzsYGl2pZ6LxHI99HooaA3yXXtkR3f1tujJ/efTeRs5C4dunfQqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=LEtRJA8b; arc=none smtp.client-ip=146.20.161.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1770300101;
	bh=Kh/c3EgSWaE34dStd7ZhLaGQD/ZXd875rbFUsvE2IdY=;
	h=From:To:Subject:Date:From;
	b=LEtRJA8bFFVz90dNeHYDPIQbF9rLvYviFLZuKeSA5yEWirrhnNkD51RMT0VYrb8ey
	 xW13s7vgBZKPdDAkIVqsgcsG5/oFMZW3XAAndwYj8DSUrRkLKekBlwKjOD9quBMGgK
	 XmvuZzGzho4VfQuPoxWKo0DpMUU8pCk230KH3VSs=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp22.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 365C3602F2;
	Thu,  5 Feb 2026 09:01:41 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	stable@vger.kernel.org
Subject: [PATCH] comedi: me_daq: Fix potential overrun of firmware buffer
Date: Thu,  5 Feb 2026 14:01:30 +0000
Message-ID: <20260205140130.76697-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 79309c74-3530-4dd5-bfaf-2608ccd316b7-1-1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mev.co.uk,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[mev.co.uk:s=20221208-6x11dpa4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214465-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abbotti@mev.co.uk,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mev.co.uk:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mev.co.uk:email,mev.co.uk:dkim,mev.co.uk:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1B750F3B3C
X-Rspamd-Action: no action

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/drivers/me_daq.c | 35 ++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/comedi/drivers/me_daq.c b/drivers/comedi/drivers/me_daq.c
index 076b15097afd..2f2ea029cffc 100644
--- a/drivers/comedi/drivers/me_daq.c
+++ b/drivers/comedi/drivers/me_daq.c
@@ -344,6 +344,25 @@ static int me2600_xilinx_download(struct comedi_device *dev,
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
 
@@ -357,22 +376,6 @@ static int me2600_xilinx_download(struct comedi_device *dev,
 	writeb(0x00, dev->mmio + 0x0);
 	sleep(1);
 
-	/*
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
 	/*
 	 * Loop for writing firmware byte by byte to xilinx
 	 * Firmware data start at offset 16
-- 
2.51.0


