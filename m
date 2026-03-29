Return-Path: <stable+bounces-230911-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHiMIcgmyWm/vAUAu9opvQ
	(envelope-from <stable+bounces-230911-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:19:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB223522DA
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C8213005A8E
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F50372692;
	Sun, 29 Mar 2026 13:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qS8e9ppN"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21BE2FD7D3
	for <Stable@vger.kernel.org>; Sun, 29 Mar 2026 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790340; cv=none; b=As4buA3wPQixVP33RI/bRxOeeg+MB/YNBsmFfQxdLJT37RKzqKNftzSl5B74eEX/dF/49RCQAFLj2Gww5r3349Bc3KDnjLhRCKv5ShJ2yPElL0OlRcR4D0lX3I3blmnwVL8YBEwSulL6wORcMRSrNcr99AbOoYmsAzINHb37dXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790340; c=relaxed/simple;
	bh=t8U37bvT6WAcTpvHf0Q6DnkRGK7u6O6bFtYnRgXVNg0=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=q4imnzkwY+xnySmXddoB1ULFFHQ7dTLYHwm4R4eUaCHCfhVU7d5I/BLJAr+fkZXAkn0EIPrCXhMhZFFycm9rzXSUtRZbl7OVEJ+nUPVyytdcfr/k0BISdhjQD35pUF67E95+SLXBux3aRCzHpqI35X+ebkZI1ttVu+DqexGPeVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qS8e9ppN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46073C116C6;
	Sun, 29 Mar 2026 13:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774790339;
	bh=t8U37bvT6WAcTpvHf0Q6DnkRGK7u6O6bFtYnRgXVNg0=;
	h=Subject:To:From:Date:From;
	b=qS8e9ppN31l54+BUjG/9DMtnCCNxk8OSKM+ZP2CWZWDzWJYLjN8PEPB38GZ1EdpHA
	 GJwNbhHE5wm2D4bhLhD/7j0kMtLUCtOMhIpLFGy26NXrmUBB284vGo0YAGMkexGOBY
	 gk9YOcuJKRpeRsudUJ09WrWuiY8/j4dfOoobtWTA=
Subject: patch "iio: add IIO_DECLARE_QUATERNION() macro" added to char-misc-linus
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 14:50:14 +0200
Message-ID: <2026032914-muzzle-bok-0c90@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230911-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,huawei.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 2FB223522DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This is a note to let you know that I've just added the patch titled

    iio: add IIO_DECLARE_QUATERNION() macro

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 56bd57e7b161f75535df91b229b0b2c64c6e5581 Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 28 Feb 2026 14:02:22 -0600
Subject: iio: add IIO_DECLARE_QUATERNION() macro

Add a new IIO_DECLARE_QUATERNION() macro that is used to declare the
field in an IIO buffer struct that contains a quaternion vector.

Quaternions are currently the only IIO data type that uses the .repeat
feature of struct iio_scan_type. This has an implicit rule that the
element in the buffer must be aligned to the entire size of the repeated
element. This macro will make that requirement explicit. Since this is
the only user, we just call the macro IIO_DECLARE_QUATERNION() instead
of something more generic.

Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/iio/iio.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index a9ecff191bd9..2c91b7659ce9 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -931,6 +931,18 @@ static inline void *iio_device_get_drvdata(const struct iio_dev *indio_dev)
 #define IIO_DECLARE_DMA_BUFFER_WITH_TS(type, name, count) \
 	__IIO_DECLARE_BUFFER_WITH_TS(type, name, count) __aligned(IIO_DMA_MINALIGN)
 
+/**
+ * IIO_DECLARE_QUATERNION() - Declare a quaternion element
+ * @type: element type of the individual vectors
+ * @name: identifier name
+ *
+ * Quaternions are a vector composed of 4 elements (W, X, Y, Z). Use this macro
+ * to declare a quaternion element in a struct to ensure proper alignment in
+ * an IIO buffer.
+ */
+#define IIO_DECLARE_QUATERNION(type, name) \
+	type name[4] __aligned(sizeof(type) * 4)
+
 struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv);
 
 /* The information at the returned address is guaranteed to be cacheline aligned */
-- 
2.53.0



