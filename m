Return-Path: <stable+bounces-249747-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JNtCJ9BDWprvAUAu9opvQ
	(envelope-from <stable+bounces-249747-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 07:07:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B84A8587B25
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 07:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED1103036428
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD7136894B;
	Wed, 20 May 2026 05:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5sokyBb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751BC2DB79F
	for <stable@vger.kernel.org>; Wed, 20 May 2026 05:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779253657; cv=none; b=fe+v2D0i+k1IhJe+zTi/oUoZMTnxOW4j25GD03VE02YT1uU0nNcFCFxlMTIYQ1vpqHVRUq9QxTwjYpSUbi59RCY6Eo0gQSzeZzA0/98R+tzXdrmRnby/xjibvLBF4CN+NBYK43x8G96P0MbSrXypAvw44meeTozVlfwxkSzp8dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779253657; c=relaxed/simple;
	bh=5VTmq0pQUVhJbzGCPIsAQcdY2+RM/h7nWn5604rVx4c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MxeqeUccNqMWswjiDqSfxD0RXz/k/Q+1DErKZlUqY1+mKJxMsZqW9Xep4aze1HDfvS34akTgZU9lTCLqksikGm0BTVLGaJ0L/GMxyP/RR+mt7+mEO3mbsBaAoz7xsG91FoGOEXbFnQyM5JqqqH0QfKS/i1+/Cs8I++iwj3ozy10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5sokyBb; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-835399c11e0so1993591b3a.0
        for <stable@vger.kernel.org>; Tue, 19 May 2026 22:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779253656; x=1779858456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DsftlmHk5XxvL2LUl7ijPdE9313QNEaY7MNbZlADkzE=;
        b=b5sokyBbd16H5karwnkOcrZNoFc4nw1dcw0I45h/IaiU+3O6/KgXM/ZVWaEfftI3EC
         5xgDwWOrH1cKIWn7rFXQeyLA2JI6FqSo0eNYeJzt88tvOo5YPI7gB0NN+QevlM2YWmKY
         cT6I2HwWkoJMKtLWY5fG/tvhEs7cUMNFdbjYVi4lSzJYM9RzKp2/Rjv5JRw9uo2+GD8o
         S/201oNDtPnih2zN/N8dviTsCOHYCspw09IfBVBlXdPlVdA/K2VGWwug0YDMIqvO8QxX
         xxgduQOohRmZjaU67coIPo2VZ1xJ/4BPfUX2vWIiyDfai3L38VLWcRhdgu+WWhjjnSwo
         65pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779253656; x=1779858456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsftlmHk5XxvL2LUl7ijPdE9313QNEaY7MNbZlADkzE=;
        b=JF2dx0uVlaT1SKZjnDwvHB1viCOoms2Oind8oV6jL88DrnIlwEFPYoC+CPIlkoKIJA
         yUm6WJ79yvjc7yrGGJBMT46hV+JZPVhp7/BTamPm95gWqf4muLaPYZVe1pJmHqbcLadK
         fonX2GA9Ardkg6c00DHTY8oD8QxlB1WUN2rXb3v1iwrggtD4afgDxHZE8O82sUQ0agXc
         Ji/oogjjj+l/ea5WwFlCENeP8CQOuQJtuvLvr6zfQr6qx6pCsETHHUsq2N+k1cextjGL
         ABkwBXjviLmpDT6M28HjjqBqqoGManarmaXTJt9lp+qkMbxGaVXN5xvLTExlbELfrsCI
         39bA==
X-Forwarded-Encrypted: i=1; AFNElJ92noirpYssETLDMZB/CdpLV8xuKpnvIc25Fgj/5gnVOaowzJ0p16sfs3P8r70mWX+v0fYvIG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnWRtxyaMSpdSJL6XgEQFQ0k0SBoAn+JKekzwtyj5Bi3uFTBHs
	K0X1ulsmFG8J8xb2l7iRSYFYveB9qS4+p1Z/pkOcWQQuqAJ/p2MA9P38
X-Gm-Gg: Acq92OFxLz0d+qds3+FJH9f+NjlWnQgS3Eenxz4Lf911muNkpe94Ycgv0kJHVcqCbWb
	SKykTmAfycEjYR2mEASIiOV1jcDBYRs9qSdFmA9V7noxC1Au7cIuQ0WOYDt+l7bJpshXHE4YPUG
	oO4NV+S9k0X4GCYuMfAymUNBr8shbATNEP8MbhTfS0KLMpus3uCraT77B00tSUweIJ6C8p9oVyO
	Aa20NG2zzj2ElK5u3FuKgL2urmRm/oWTBhuB1QOn8tTexj0/sB7UfVYTNnVRgXk3doBlAT0eVId
	llEWJzHRsN/bQxt4T8IVNbSGQx7EOpSY+QQJLHHyiLyDCEi2sSkrWBIt3leGf5/AV/Ed/WQYhAi
	MKUNHbDfQbIzo9fi955TwDKvvastwzX1FYA6qPA8PwbtkkgAV/5cXsnhgPR0c4msuRw1ZKW6v0A
	5onIx0PO2+lpYEgFb3nlb8pHj8VKjfZgvowlJ324ZufI82fqNQBiD5uP4R05fwow==
X-Received: by 2002:a05:6a00:3e1f:b0:83d:43be:d537 with SMTP id d2e1a72fcca58-83f33cc3782mr21034334b3a.17.1779253655686;
        Tue, 19 May 2026 22:07:35 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c5ce1fsm19786672b3a.35.2026.05.19.22.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 22:07:35 -0700 (PDT)
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
Subject: [PATCH wpan v2] ieee802154: ca8210: fix pointer truncation in kfifo on 64-bit
Date: Wed, 20 May 2026 10:37:07 +0530
Message-Id: <20260520050707.38055-1-shitalkumar.gandhi@cambiumnetworks.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249747-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B84A8587B25
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
Changes in v2:
- Use intermediate variable for kfifo_out() return value (Miquèl)
- Add Cc: stable@vger.kernel.org (Miquèl)
- Add Reviewed-by from Simon Horman (v1)

Link to v1: https://lore.kernel.org/linux-wpan/20260513153412.1284549-1-shitalkumar.gandhi@cambiumnetworks.com/

 drivers/net/ieee802154/ca8210.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 753215ebc67c..828cee8a6101 100644
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
@@ -2540,8 +2540,10 @@ static ssize_t ca8210_test_int_user_read(
 			!kfifo_is_empty(&priv->test.up_fifo)
 		);
 	}
+	unsigned int copied;
 
-	if (kfifo_out(&priv->test.up_fifo, &fifo_buffer, 4) != 4) {
+	copied = kfifo_out(&priv->test.up_fifo, &fifo_buffer, sizeof(fifo_buffer));
+	if (copied != sizeof(fifo_buffer)) {
 		dev_err(
 			&priv->spi->dev,
 			"test_interface: Wrong number of elements popped from upstream fifo\n"
-- 
2.25.1


