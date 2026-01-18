Return-Path: <stable+bounces-210231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A7FD3989E
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 18:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF2613005A84
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 17:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71C621ABAA;
	Sun, 18 Jan 2026 17:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3BA18oM"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A81A2FC891
	for <stable@vger.kernel.org>; Sun, 18 Jan 2026 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768758333; cv=none; b=XMrhoss5ns4Ni1aGEQFIb+chiur3qVg+nesKPy+dCx8edqHOEAZwZr1sSxzDwSaZlDHRgzF+Sy5mfzvMHJDzijfiiO7ZbU6ujsLMsoGerRtqSv1p3VdlqSzxX5VfZkr/SzRe8YoomEbWcu5TpCotJBzLG4vurrxyK4bf19a51Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768758333; c=relaxed/simple;
	bh=VcjR+Y1iNWZSa1ZtxEzMaBCTuPx9pXxpzhpYI/x/o48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pXvQIakEzIOR2D72F6mZrUGouxyeUiislyhNNuo1V8CsdStA4oX36bmDOP8nnMfOyjnISMmoIUX9XpgoYgS60vx26Sp0rXjDYwh6dsw40+JiWDiSkOyzqjTFo959oSFn8D6yN86FkA3rNxbe8vuh9fwYDchEGeVBlvoi77tJYOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3BA18oM; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-655af782859so4600973a12.2
        for <stable@vger.kernel.org>; Sun, 18 Jan 2026 09:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768758330; x=1769363130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PbagKvzCIQaOeLMD21+nxd4UKX2WNLT5bVzVk/tS3pc=;
        b=M3BA18oMmjUmADEe403rh92JvTWHfJCcY48LxqKL1hxU/xNRYO4P1I+s+d5Kojjg/D
         hY0Ioo6uA5GwfHoMf1Q1llyfqbp/liVpI7OapIk5cmoxODPRxbD8G6FfNVUALCGE1LbB
         MDau6kmCzdF0ZVVVdOiFRX2bcCqlCQVhrVMZEr6POMGnbiICD62EO2dmcW8wLZPLW8ta
         /A/ETvbfyys1Er8ifMxG8rrXODPLxnRalcx6HSAjp2jaj3JLgZkiaFkMRHJ7LOWtNn/8
         lG8xtzT6T0wPkQQrBecBuuBEwF0wXmwQapECu9MaMDOCNfIV5BG7Ms9Ohz9nxQapx2va
         Bz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768758330; x=1769363130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbagKvzCIQaOeLMD21+nxd4UKX2WNLT5bVzVk/tS3pc=;
        b=d1QsA1e4xrWyeAFQR+wp/VqsQ3Ya4Uxc7SzKdVXuQEAM0TbawhRpPm/X3ei8NaPFIK
         VeHnQ0ALUoazatRlIaau2XFTb6PsMRPu75jp9n+Llj83Z3N0WggjRZJhctCpHKYQUBp+
         6D8TBqZcMYjB83p4DMOI9iYRou2mKHiYFIbUJajhpgay9l8+ADIYu38VtrG4Tr+ejrG/
         6RP4EmZSmDqrxNDnoecNsuHcLeHrHeDxlKCNvQWKS+dwGB3/4LfY0BUyccvMUtj54uHG
         XWt642wdAOYO04OdTojcKNOyfaJB3Yqdd7P3fpmjjGRA1Qh88gvaQbFVqxjCVOevdEPP
         qIrw==
X-Forwarded-Encrypted: i=1; AJvYcCWWMx8xRKcFbgofWXxN1PnqV3qvkTF8TFji6WWdBhTzOvX7Mbm1ceRChBJCOxNZX4LKH+tOdp0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvd/TdMzXUjBWsNvG70gH1nvRMzAnH6+qPmah/k21kJtVpLICB
	lgXwC01pfK6ShM9kMDE5oGRBRfUmsPrwD747/rupwiJ0K6ehbkADv8aO
X-Gm-Gg: AY/fxX7XjzAMosFuPpMlat13h1qu8iJPwqEyDy3FInIDuDDWemgW5JC0uNTKwHr0m7Z
	RmX2WhFsXgUKbW6bAf+J8sJvjOdzk9WvNcr4h4FjJKyeJfBCzgVGNCc3DcDhxIlqvUijYd1xqkt
	4P/w27yCEenNsBatOvh2bkIZN1mV1ZtSGAgvy4ejUOy+u70STsyTE70YsvUSUKxYrmOz/fjzUBL
	OWlF34Ct9iXpuph5ccP9oEAqh36SNNgFwJRf8HqDlgVhAj0ElfrzfqigBJEtachilZ37EmiOIKS
	Aub1Pv/EBmAL8a0EEXokkIjbRyh3QHUFNtA2nFNnqzMQJsXiEM5fouOTC5C2XQj7HI//7fT486R
	5dYTBNkXGEjPU4zY5HDJkRyOmthJ+2eP7EEH2aEobv8ccOkBkU7TLQ5mPPo+mqV7Q2n3W7MmP0V
	r0dBLjCGSXhTIITw==
X-Received: by 2002:a05:6402:3491:b0:64b:5562:c8f4 with SMTP id 4fb4d7f45d1cf-654524cf27fmr7018655a12.7.1768758330277;
        Sun, 18 Jan 2026 09:45:30 -0800 (PST)
Received: from osama.. ([2a02:908:1b4:dac0:5466:5c6:1ae0:13b7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65452bce411sm8105189a12.7.2026.01.18.09.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 09:45:28 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	Sjur Braendeland <sjur.brandeland@stericsson.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: syzbot+f9d847b2b84164fa69f3@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] net: caif: fix memory leak in ldisc_receive
Date: Sun, 18 Jan 2026 18:44:16 +0100
Message-ID: <20260118174422.10257-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NULL pointer checks for ser and ser->dev in ldisc_receive() to
prevent memory leaks when the function is called during device close
or in race conditions where tty->disc_data or ser->dev may be NULL.

The memory leak occurred because ser->dev was accessed before checking
if ser or ser->dev was NULL, which could cause a NULL pointer
dereference or use of freed memory. Additionally, set tty->disc_data
to NULL in ldisc_close() to prevent receive_buf() from using a freed
ser pointer after the line discipline is closed.

Reported-by: syzbot+f9d847b2b84164fa69f3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f9d847b2b84164fa69f3
Fixes: 9b27105b4a44 ("net-caif-driver: add CAIF serial driver (ldisc)")
CC: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v2:
1.Combine NULL pointer checks for ser and ser->dev in ldisc_receive()
2.Set tty->disc_data = NULL in ldisc_close() to prevent receive_buf()
from using a freed ser pointer after close.
3.Add NULL pointer check for ser in ldisc_close()
---
 drivers/net/caif/caif_serial.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
index c398ac42eae9..970237a3ccca 100644
--- a/drivers/net/caif/caif_serial.c
+++ b/drivers/net/caif/caif_serial.c
@@ -152,6 +152,8 @@ static void ldisc_receive(struct tty_struct *tty, const u8 *data,
 	int ret;
 
 	ser = tty->disc_data;
+	if (!ser || !ser->dev)
+		return;
 
 	/*
 	 * NOTE: flags may contain information about break or overrun.
@@ -170,8 +172,6 @@ static void ldisc_receive(struct tty_struct *tty, const u8 *data,
 		return;
 	}
 
-	BUG_ON(ser->dev == NULL);
-
 	/* Get a suitable caif packet and copy in data. */
 	skb = netdev_alloc_skb(ser->dev, count+1);
 	if (skb == NULL)
@@ -355,11 +355,15 @@ static void ldisc_close(struct tty_struct *tty)
 {
 	struct ser_device *ser = tty->disc_data;
 
+	if (!ser)
+		return;
+
 	tty_kref_put(ser->tty);
 
 	spin_lock(&ser_lock);
 	list_move(&ser->node, &ser_release_list);
 	spin_unlock(&ser_lock);
+	tty->disc_data = NULL;
 	schedule_work(&ser_release_work);
 }
 
-- 
2.43.0


