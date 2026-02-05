Return-Path: <stable+bounces-214461-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBblEHafhGmI3wMAu9opvQ
	(envelope-from <stable+bounces-214461-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 14:47:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D304F3802
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 14:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 778A1301022C
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 13:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7753382F7;
	Thu,  5 Feb 2026 13:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="yJbtVxFn"
X-Original-To: stable@vger.kernel.org
Received: from smtp108.iad3b.emailsrvr.com (smtp108.iad3b.emailsrvr.com [146.20.161.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6293B5302
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770299187; cv=none; b=Mn6E8KDNSTVwRQfI/Isw2G6urIp3XDK+jJrn8vg6pADY02QSSVfyEIVI7RYpVA1287LfOC7oimVuwFEfO0PQiLw9zBjIQ9HFBQZAPgJuKu6rt705dAJfy+jgcZG4XWRfYfRfFtYKGM7MS01iF9Re4dLRf7Ge64hkH5YnCVgbYJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770299187; c=relaxed/simple;
	bh=6RFjsnwE7oRBF/UOXwO8EHiTojFkgrhOShswYXvJUFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ks5y6LKjzUMrbaZJQPFldIiwWBZNo/LNikx9Hu5V9bKoYABHRkAE70Ou1yu6igYM5WlYques5be2OlWEBM5YYQX9WNDlgRqZrA4ySDYp/fY+AAv7XfPA8UJNL4DWgA3EN/QcU7s1T2CoUy5OY8JBfcvPUApQJpKY/rtDmSBcacU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=yJbtVxFn; arc=none smtp.client-ip=146.20.161.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1770298805;
	bh=6RFjsnwE7oRBF/UOXwO8EHiTojFkgrhOShswYXvJUFE=;
	h=From:To:Subject:Date:From;
	b=yJbtVxFnrIkNDVgQyIvkvhVdPmY35/Qo6g9cX5zsMp2e84ro3l1njHkT0YnlzFs6A
	 yhaO46nYVxG/PNEFj6vMb3HPinV+Rs9MimI1N5TzAQzV9paChjFR6KlC904aPTH+o5
	 S+MaIPmQcbHagYen9k/FE+jAQLIRoT7vn60YlN4U=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp22.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id E34036029C;
	Thu,  5 Feb 2026 08:40:04 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	stable@vger.kernel.org
Subject: [PATCH] comedi: me4000: Fix potential overrun of firmware buffer
Date: Thu,  5 Feb 2026 13:39:49 +0000
Message-ID: <20260205133949.71722-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: b0f65736-4d63-416c-bbcc-335a45d6056c-1-1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mev.co.uk,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[mev.co.uk:s=20221208-6x11dpa4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214461-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abbotti@mev.co.uk,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mev.co.uk:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mev.co.uk:email,mev.co.uk:dkim,mev.co.uk:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D304F3802
X-Rspamd-Action: no action

`me4000_xilinx_download()` loads the firmware that was requested by
`request_firmware()`.  It is possible for it to overrun the source
buffer because it blindly trusts the file format.  It reads a data
stream length from the first 4 bytes into variable `file_length` and
reads the data stream contents of length `file_length` from offset 16
onwards.

Add a test to ensure that the supplied firmware is long enough to
contain the header and the data stream.  On failure, log an error and
return `-EINVAL`.

Note: The firmware loading was totally broken before commit ac584af59945
("staging: comedi: me4000: fix firmware downloading"), but that is the
most sensible target for this fix.

Fixes: ac584af59945 ("staging: comedi: me4000: fix firmware downloading")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/drivers/me4000.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/comedi/drivers/me4000.c b/drivers/comedi/drivers/me4000.c
index 7dd3a0071863..effe9fdbbafe 100644
--- a/drivers/comedi/drivers/me4000.c
+++ b/drivers/comedi/drivers/me4000.c
@@ -315,6 +315,18 @@ static int me4000_xilinx_download(struct comedi_device *dev,
 	unsigned int val;
 	unsigned int i;
 
+	/* Get data stream length from header. */
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
 	if (!xilinx_iobase)
 		return -ENODEV;
 
@@ -346,10 +358,6 @@ static int me4000_xilinx_download(struct comedi_device *dev,
 	outl(val, devpriv->plx_regbase + PLX9052_CNTRL);
 
 	/* Download Xilinx firmware */
-	file_length = (((unsigned int)data[0] & 0xff) << 24) +
-		      (((unsigned int)data[1] & 0xff) << 16) +
-		      (((unsigned int)data[2] & 0xff) << 8) +
-		      ((unsigned int)data[3] & 0xff);
 	usleep_range(10, 1000);
 
 	for (i = 0; i < file_length; i++) {
-- 
2.51.0


