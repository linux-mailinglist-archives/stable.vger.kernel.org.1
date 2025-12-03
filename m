Return-Path: <stable+bounces-199898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A305CA090B
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 18:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A96D300441C
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A880233769B;
	Wed,  3 Dec 2025 17:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="RYh5JCth"
X-Original-To: stable@vger.kernel.org
Received: from smtp126.iad3b.emailsrvr.com (smtp126.iad3b.emailsrvr.com [146.20.161.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C77C33B6CC
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764783712; cv=none; b=CRXuDPqeDnIasYRjUUVwqno9CJqiAXymvOZrlME4gEdF7kBKNyc+wWTnaZhulaC4Q2tIf3h0rw1/EDicZEozmEaXy/45m1tqWF4p4iZOtaFtO0mRtVwaXq+AIaob+ttiY449/MnoXWRFD1RkjejZF3QMEWF+VzHPoRi26rwqM6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764783712; c=relaxed/simple;
	bh=WCav8nkVt90g2JQRZbYoi88Ep53HirQkcWsI+6DNw3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mjZ6fzn81MygR5f1InKwianbyUFclliSnWj62Z+7+grObHTPo0+eM83jQ6Y3Up/RbUT/MJjF+Ey39hU+Fjfdmpa5sIlktK/3dunYADXkf641SAvTUYwioqo8Tgn5VzKEyn7JeVqh2KsbZWpv8ddso0MtL5CGCSMmrqWxY//M0V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=RYh5JCth; arc=none smtp.client-ip=146.20.161.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1764779092;
	bh=WCav8nkVt90g2JQRZbYoi88Ep53HirQkcWsI+6DNw3E=;
	h=From:To:Subject:Date:From;
	b=RYh5JCthTAfLdZaLSXSTZWR0rjhTY3wD50sp8nm04c4Xah5sHGmCxEWNnaBhYAl6U
	 mP/rsIgXEfPmW1r070+Eg1bsFJZHr6VGaNRKUOExBwMFofa808V+cx6IV3vF0EGunf
	 GrxyU/ndSrK9Qtm+SSJlimkxYGuP3KMePO6ydgBk=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp16.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id AAC5EC0202;
	Wed,  3 Dec 2025 11:24:51 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	stable@vger.kernel.org
Subject: [PATCH] comedi: Fix getting range information for subdevices 16 to 255
Date: Wed,  3 Dec 2025 16:24:38 +0000
Message-ID: <20251203162438.176841-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: b9f2cd84-f0fb-458a-b437-5d246ca440aa-1-1

The `COMEDI_RANGEINFO` ioctl does not work properly for subdevice
indices above 15.  Currently, the only in-tree COMEDI drivers that
support more than 16 subdevices are the "8255" driver and the
"comedi_bond" driver.  Making the ioctl work for subdevice indices up to
255 is achievable.  It needs minor changes to the handling of the
`COMEDI_RANGEINFO` and `COMEDI_CHANINFO` ioctls that should be mostly
harmless to user-space, apart from making them less broken.  Details
follow...

The `COMEDI_RANGEINFO` ioctl command gets the list of supported ranges
(usually with units of volts or milliamps) for a COMEDI subdevice or
channel.  (Only some subdevices have per-channel range tables, indicated
by the `SDF_RANGETYPE` flag in the subdevice information.)  It uses a
`range_type` value and a user-space pointer, both supplied by
user-space, but the `range_type` value should match what was obtained
using the `COMEDI_CHANINFO` ioctl (if the subdevice has per-channel
range tables)  or `COMEDI_SUBDINFO` ioctl (if the subdevice uses a
single range table for all channels).  Bits 15 to 0 of the `range_type`
value contain the length of the range table, which is the only part that
user-space should care about (so it can use a suitably sized buffer to
fetch the range table).  Bits 23 to 16 store the channel index, which is
assumed to be no more than 255 if the subdevice has per-channel range
tables, and is set to 0 if the subdevice has a single range table.  For
`range_type` values produced by the `COMEDI_SUBDINFO` ioctl, bits 31 to
24 contain the subdevice index, which is assumed to be no more than 255.
But for `range_type` values produced by the `COMEDI_CHANINFO` ioctl,
bits 27 to 24 contain the subdevice index, which is assumed to be no
more than 15, and bits 31 to 28 contain the COMEDI device's minor device
number for some unknown reason lost in the mists of time.  The
`COMEDI_RANGEINFO` ioctl extract the length from bits 15 to 0 of the
user-supplied `range_type` value, extracts the channel index from bits
23 to 16 (only used if the subdevice has per-channel range tables),
extracts the subdevice index from bits 27 to 24, and ignores bits 31 to
28.  So for subdevice indices 16 to 255, the `COMEDI_SUBDINFO` or
`COMEDI_CHANINFO` ioctl will report a `range_type` value that doesn't
work with the `COMEDI_RANGEINFO` ioctl.  It will either get the range
table for the subdevice index modulo 16, or will fail with `-EINVAL`.

To fix this, always use bits 31 to 24 of the `range_type` value to hold
the subdevice index (assumed to be no more than 255).  This affects the
`COMEDI_CHANINFO` and `COMEDI_RANGEINFO` ioctls.  There should not be
anything in user-space that depends on the old, broken usage, although
it may now see different values in bits 31 to 28 of the `range_type`
values reported by the `COMEDI_CHANINFO` ioctl for subdevices that have
per-channel subdevices.  User-space should not be trying to decode bits
31 to 16 of the `range_type` values anyway.

Fixes: ed9eccbe8970 ("Staging: add comedi core")
Cc: <stable@vger.kernel.org> #5.17+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
Backports needed for kernels prior to 5.17 due to .c and .h files moving
to different parts of the tree.
---
 drivers/comedi/comedi_fops.c | 2 +-
 drivers/comedi/range.c       | 2 +-
 include/uapi/linux/comedi.h  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 657c98cd723e..2c3eb9e89571 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -1155,7 +1155,7 @@ static int do_chaninfo_ioctl(struct comedi_device *dev,
 		for (i = 0; i < s->n_chan; i++) {
 			int x;
 
-			x = (dev->minor << 28) | (it->subdev << 24) | (i << 16) |
+			x = (it->subdev << 24) | (i << 16) |
 			    (s->range_table_list[i]->length);
 			if (put_user(x, it->rangelist + i))
 				return -EFAULT;
diff --git a/drivers/comedi/range.c b/drivers/comedi/range.c
index 8f43cf88d784..5b8f662365e3 100644
--- a/drivers/comedi/range.c
+++ b/drivers/comedi/range.c
@@ -52,7 +52,7 @@ int do_rangeinfo_ioctl(struct comedi_device *dev,
 	const struct comedi_lrange *lr;
 	struct comedi_subdevice *s;
 
-	subd = (it->range_type >> 24) & 0xf;
+	subd = (it->range_type >> 24) & 0xff;
 	chan = (it->range_type >> 16) & 0xff;
 
 	if (!dev->attached)
diff --git a/include/uapi/linux/comedi.h b/include/uapi/linux/comedi.h
index 7314e5ee0a1e..798ec9a39e12 100644
--- a/include/uapi/linux/comedi.h
+++ b/include/uapi/linux/comedi.h
@@ -640,7 +640,7 @@ struct comedi_chaninfo {
 
 /**
  * struct comedi_rangeinfo - used to retrieve the range table for a channel
- * @range_type:		Encodes subdevice index (bits 27:24), channel index
+ * @range_type:		Encodes subdevice index (bits 31:24), channel index
  *			(bits 23:16) and range table length (bits 15:0).
  * @range_ptr:		Pointer to array of @struct comedi_krange to be filled
  *			in with the range table for the channel or subdevice.
-- 
2.51.0


