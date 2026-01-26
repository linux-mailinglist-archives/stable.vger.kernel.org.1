Return-Path: <stable+bounces-211670-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFiLILuqd2kZkAEAu9opvQ
	(envelope-from <stable+bounces-211670-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 18:56:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F7E8BD11
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 18:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0BF6301C134
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 17:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E01346E51;
	Mon, 26 Jan 2026 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIg9TBfv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78D22356D9
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769450166; cv=none; b=BDdP1HwPW8LJG0n7H4sLYbXbj5OqvGpK9L7DZHBPGHDE6ee3h/8roO/k33cNMg7Sg0475WJpv0rruD1sobpt015FcluNafFYRnSvf69nMXw37otOUznV0s6GsvvZ1xCzwHM37QWAu63meJ+6oEJ/72VwXM3I5HA/GjOROAEr7Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769450166; c=relaxed/simple;
	bh=fbPLfifWTNhK1gQxEqunj3rMsW0UeXfpTzWwVdcArMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8TH7a7B6IPOAIjsU3sW8grWdcG7FE4QkYrbrTAzfkoSAJ3sMYzbvFwAxJ9xZAdhMgcD7U+T4nbJQJOCy1IFFRGTfQ6aO0dUWOcNRhBDyVc1eDOgCaASwcYK4QXPqvUyjVknXwmMzxtmLV1jM/aMkOXJDseNf1WZA8XLzU/Q2RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIg9TBfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC270C116C6;
	Mon, 26 Jan 2026 17:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769450166;
	bh=fbPLfifWTNhK1gQxEqunj3rMsW0UeXfpTzWwVdcArMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pIg9TBfviamVgLYg4ZgF0Vz0fWxp7Po7uBBygcN9GmMChBq2NGQ4AWZnC6H7zuVaR
	 /bCxjiFwrIhnyQ+E7sZtB0Tk4fhAecMjen0MsLA1qJmmfzd8v7bOjpLFbBNz7cIGpW
	 xmCCKD04zezIqeX3Lgt6nRToL8p0zDM9MFDfu0/xw9GpwPi0Wa3L9jBd1zmhiqmLQ/
	 E1YiWNNsOKB8kq35zCGWw1aot51GYH5lW8L7X5xd3wdxCiJmmjXwIWpRDJ1aSFIPQz
	 aiYB/dK7MEjDOO99zpWss3dRrMkSr4eXAJPMKv5J/7lhBY2t/+75QuIFcZ/KQHwjG9
	 SdRTjF00qWKuQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] comedi: Fix getting range information for subdevices 16 to 255
Date: Mon, 26 Jan 2026 12:56:03 -0500
Message-ID: <20260126175603.3482391-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012651-shivering-gizzard-0e35@gregkh>
References: <2026012651-shivering-gizzard-0e35@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211670-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mev.co.uk:email,linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E8F7E8BD11
X-Rspamd-Action: no action

From: Ian Abbott <abbotti@mev.co.uk>

[ Upstream commit 10d28cffb3f6ec7ad67f0a4cd32c2afa92909452 ]

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
Cc: stable@vger.kernel.org #5.17+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://patch.msgid.link/20251203162438.176841-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/comedi/comedi.h      | 2 +-
 drivers/staging/comedi/comedi_fops.c | 2 +-
 drivers/staging/comedi/range.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/comedi/comedi.h b/drivers/staging/comedi/comedi.h
index b5d00a006dbb2..a4e2a61e7cb05 100644
--- a/drivers/staging/comedi/comedi.h
+++ b/drivers/staging/comedi/comedi.h
@@ -640,7 +640,7 @@ struct comedi_chaninfo {
 
 /**
  * struct comedi_rangeinfo - used to retrieve the range table for a channel
- * @range_type:		Encodes subdevice index (bits 27:24), channel index
+ * @range_type:		Encodes subdevice index (bits 31:24), channel index
  *			(bits 23:16) and range table length (bits 15:0).
  * @range_ptr:		Pointer to array of @struct comedi_krange to be filled
  *			in with the range table for the channel or subdevice.
diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index de89922e73974..1c36d34f9e331 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -1095,7 +1095,7 @@ static int do_chaninfo_ioctl(struct comedi_device *dev,
 		for (i = 0; i < s->n_chan; i++) {
 			int x;
 
-			x = (dev->minor << 28) | (it->subdev << 24) | (i << 16) |
+			x = (it->subdev << 24) | (i << 16) |
 			    (s->range_table_list[i]->length);
 			if (put_user(x, it->rangelist + i))
 				return -EFAULT;
diff --git a/drivers/staging/comedi/range.c b/drivers/staging/comedi/range.c
index a4e6fe0fb7296..1f38c896ed5b8 100644
--- a/drivers/staging/comedi/range.c
+++ b/drivers/staging/comedi/range.c
@@ -52,7 +52,7 @@ int do_rangeinfo_ioctl(struct comedi_device *dev,
 	const struct comedi_lrange *lr;
 	struct comedi_subdevice *s;
 
-	subd = (it->range_type >> 24) & 0xf;
+	subd = (it->range_type >> 24) & 0xff;
 	chan = (it->range_type >> 16) & 0xff;
 
 	if (!dev->attached)
-- 
2.51.0


