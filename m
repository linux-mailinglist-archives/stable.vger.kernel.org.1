Return-Path: <stable+bounces-249809-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cERkNwyUDWoMzwUAu9opvQ
	(envelope-from <stable+bounces-249809-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 12:59:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7278758C059
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 12:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF423301BF42
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 10:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528493D9DDB;
	Wed, 20 May 2026 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AU75cP9o"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E073D8916
	for <stable@vger.kernel.org>; Wed, 20 May 2026 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779274702; cv=none; b=pkOWEV6VjK8738lTYMIeOnIsc0sXwaasuw8DG7GWL0oK6+fD4axQ2OIwf3JNh/Yg5Wnp8WX77ykg9BuU/zH1gPLLrZfpf96xYN1VA5PYrUIqJhYHlOnskYLPFL8Mk9Gi1nmDQjlWmWgL2vD/bl9sQIUBdazs5l9ltLUOiNp8i98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779274702; c=relaxed/simple;
	bh=17v94OCKGdEk/7VAXlR2xnD/Jsvb9yNV4bAK1pD/z7A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uWPK5+0Y/FPds5fI3GZTD/xxciC8DUwrlJNahFVkMX8fRSPQeUDlWjhK6FLsbBQRV/k/Fxm/Q0Sdd2UHiPUUD+4I0lIoODTq31x1WA3hdNOize5cPYc+M35ecXKbekeM5v+CYGMdSI0l0fmfiMxfrWD/2QQzTJYNA9ASacrzLcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AU75cP9o; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b4583f0a1aso30040015ad.3
        for <stable@vger.kernel.org>; Wed, 20 May 2026 03:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779274699; x=1779879499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MpaQTw9IpMpA0HZfgbqByauqmXOHYN5iiaZ7k3HZ+l4=;
        b=AU75cP9o4yu9681zxC564p/rf2xgJzOQX2d+vir2g5jLoUQBj2eEJGkvJt40mPW8RP
         SV5hZAsvpjARtxB1bBHmRro5P4F/OTncmwUs6QtBGRfE3pB7L6XnLGG3cHYNFVJSW/K4
         VxRXvw9s+E3ceycy07R6Cs5aVh/vxchmvlrfumacUQcXWB0W4Ih33grmeG5e2KBKje7d
         D3fM4StOLfeplf0Sl8/+bm2yTdJ+Uv2lMAhTA2uznbiPjVMEyDLvRL2d6rhVpO8d/x/z
         O4D8OX1WSo5J9VhP9CtptHhrs0yH4rGIulR0pU4ATOl04BEDPUy35J0LLfX3RoBgOZlq
         pFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779274699; x=1779879499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpaQTw9IpMpA0HZfgbqByauqmXOHYN5iiaZ7k3HZ+l4=;
        b=dhICf3exSkfmUDsF7gvG/TSg9gCau+Pdfy8UylIlO9ej+236THIsgfjmFddMUzvCbO
         BICAZd1m+OiNksKkUPPH13Ge3oBlXmU4J/k0raFDm5ahUxXIhMQmlAmSoINV0DRfC59X
         GOTrRwc8qgS8QpR4pm5FQ48xB6DlLi28PEj5unIyFrNBR0L1q4fUyddwwct8OWrGeXGt
         8LwPs27CYG3wEmcKvPqCqZv15owJuEcEToa3AcGgcfyk3x+HQkm+8fUVfXzq3LbBbas0
         qWYK4QWdcuIGYVltUITu3BPaRzVwTHjjDWAx6L465/Ps3GWFwVoeirjURowDpp+Na5g8
         5BJg==
X-Forwarded-Encrypted: i=1; AFNElJ+wsnKqhYs/2/TFrQYtRjg2z6so3vje4oaZy/eW7xF3b7Q4j6t13s7HPQuoAEKowTKwP0S6NUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKuZvGXVco1UTCyS617zsBfz56oMkW+qR3BwaCTyNEvbYP+MP4
	QmEYENkuLk5mZdKVRFQYexYjxBhpvBM5NJbOIuCsq0lL8/5cMaUR3/nO
X-Gm-Gg: Acq92OEyQhdPBYLa3igA4ks+zUYCIgCfxbIVQWxFOuLgCDpRanzV7C1bQUJgaOR7+Bj
	ouRwke421NHHkTI3tSI5GSaUKO6joUB1wWsDFp4CmkCdgavt3aoyeNtEZtkY1bk42+exY3w+Cqi
	uuCf+blixQ9rL0zromGDtO6B2KKPYFrmFMRXMSHzLqvK+h6x2JJtOXzgF4q15/NIrHvWut5sfvy
	7holiUqZUUGi4dt0d9py2gQUoH3GMRBz13plfLWvaLuOUlhwZgzjq+8XOd/ZI7fSeXA/uq/KHTS
	RbabnGoxQ5xvFITMBb+t3OgHPxcc7iULi1xbCR40SvQwHYHJNo9PQj9zkWsvnZ1Ijqog1bzF39B
	Ch8m6MjMM+WMoDNJD7AQLhme0GeF99uCf8ND+m7YnnQ8FUlCH4iHoPY4OvHuidVTx2HyB3MgeVr
	1aoxD/W7dh7rm4Q1R9SyAHk47iiUtYK+2tSlXtYyjaLYsvp8VUWcs28zvZ/lURnQ==
X-Received: by 2002:a17:903:2f47:b0:2b9:ecb4:a3dd with SMTP id d9443c01a7336-2bd7e8f2641mr252178805ad.34.1779274699367;
        Wed, 20 May 2026 03:58:19 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe49c9sm220266615ad.49.2026.05.20.03.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 03:58:19 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: [PATCH wpan v3] ieee802154: ca8210: fix pointer truncation in kfifo on 64-bit
Date: Wed, 20 May 2026 16:27:50 +0530
Message-Id: <20260520105750.30144-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249809-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[bootlin.com,gmail.com,datenfreihafen.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shitalgandhi45@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cambiumnetworks.com:mid,cambiumnetworks.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7278758C059
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ca8210_test_int_driver_write() and ca8210_test_int_user_read() exchange
a kmalloc'd buffer pointer through a struct kfifo, but pass a literal
'4' as the byte count to kfifo_in()/kfifo_out().

This is correct on 32-bit (pointer = 4 bytes), but on 64-bit only the
low 4 bytes of the 8-byte pointer are written into the FIFO. The reader
then reads back 4 bytes into an 8-byte local pointer variable, leaving
the upper 4 bytes uninitialized stack data. The first dereference of
the reconstructed pointer (fifo_buffer[1]) accesses an arbitrary kernel
address and generally results in an oops.

Use sizeof(fifo_buffer) so the byte count matches pointer width on every
architecture.

The driver has no architecture restriction in Kconfig, so any 64-bit
build with CONFIG_IEEE802154_CA8210_DEBUGFS=y is exposed. Issue has
been latent since the driver was added in 2017 because it is most
commonly deployed on 32-bit MCUs.

Found via a custom Coccinelle semantic patch hunting for short-byte
kfifo I/O on byte-mode kfifos used to shuttle pointers.

Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
Changes in v3:
- Move declaration of `copied` to the top of the function (Miquèl)

Changes in v2:
- Use intermediate variable for kfifo_out() return value (Miquèl)
- Add Cc: stable@vger.kernel.org (Miquèl)
- Add Reviewed-by from Simon Horman (v1)

Link to v1: https://lore.kernel.org/linux-wpan/20260513153412.1284549-1-shitalkumar.gandhi@cambiumnetworks.com/
Link to v2: https://lore.kernel.org/all/20260520050707.38055-1-shitalkumar.gandhi@cambiumnetworks.com/

 drivers/net/ieee802154/ca8210.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 753215ebc67c..1f1dafc5c5f6 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -597,7 +597,7 @@ static int ca8210_test_int_driver_write(
 	fifo_buffer = kmemdup(buf, len, GFP_KERNEL);
 	if (!fifo_buffer)
 		return -ENOMEM;
-	kfifo_in(&test->up_fifo, &fifo_buffer, 4);
+	kfifo_in(&test->up_fifo, &fifo_buffer, sizeof(fifo_buffer));
 	wake_up_interruptible(&priv->test.readq);
 
 	return 0;
@@ -2528,6 +2528,7 @@ static ssize_t ca8210_test_int_user_read(
 	struct ca8210_priv *priv = filp->private_data;
 	unsigned char *fifo_buffer;
 	unsigned long bytes_not_copied;
+	unsigned int copied;
 
 	if (filp->f_flags & O_NONBLOCK) {
 		/* Non-blocking mode */
@@ -2541,7 +2542,8 @@ static ssize_t ca8210_test_int_user_read(
 		);
 	}
 
-	if (kfifo_out(&priv->test.up_fifo, &fifo_buffer, 4) != 4) {
+	copied = kfifo_out(&priv->test.up_fifo, &fifo_buffer, sizeof(fifo_buffer));
+	if (copied != sizeof(fifo_buffer)) {
 		dev_err(
 			&priv->spi->dev,
 			"test_interface: Wrong number of elements popped from upstream fifo\n"
-- 
2.25.1


