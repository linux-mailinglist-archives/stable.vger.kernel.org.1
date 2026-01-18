Return-Path: <stable+bounces-210205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9B5D3973E
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 15:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ED603010FFF
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 14:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E137F33BBBD;
	Sun, 18 Jan 2026 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaCQ26GS"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B79332F77B
	for <stable@vger.kernel.org>; Sun, 18 Jan 2026 14:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768747693; cv=none; b=JF5v6zIV0TFTX4sprco1vqnyHdUEqYJTHuFYUwg0y4tYFkMzoADth13sBoB2VFQx+gkZwjGbkdznLrKQ3qvTJw9XGLdNCPRDEfrElLPbh2Tz7EEDiqIqNG3qVPkwbXIqIiAAeM3uzSIFF09C8he7z0Fn7gj0Vz0E9Aq6/WZ1xM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768747693; c=relaxed/simple;
	bh=OPLhgS70WXTefJGjXohzpw1kQv8W5ourc0aIIIHgcSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e8zE3ojk+f0q72KObbh/fvFKrGSeHacSNSr9uDnD4Mxy0EvS4NeZTzyNjBvvHjO8bhSNlPUkkpJzTQpCOeBMG0w2QAIbxJ1eF6T49ZfOa52C63kwqOLjdj5t8HDWTC8YxZKlA49k3FeVEAj2/hcqMtm6ON6CRkYOokmzcCi1IoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaCQ26GS; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b871cfb49e6so580386266b.1
        for <stable@vger.kernel.org>; Sun, 18 Jan 2026 06:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768747690; x=1769352490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nwhHWcSuKh5FBKzHk5nDn2X2ZmAMO+jm5eGTbzgp59k=;
        b=WaCQ26GSjJFOqNGxhGka5HgIyg1ojQ0hC7mZZLOpGO+S8yHQH/aTHXAO1kdQxfiU+u
         3maoe5eEqgI+cXuR9zvsI1BJ0uaoqAcaaYXS1VGZJ3xIs+7t50AJOPrf1/sQ10m0TTaE
         QG51prfeDM6GLVS9hqojb5auy92wliqUsiaxxQuxaTUuJYrhRzPhtK2FYFbX3g0uoV1R
         qTI3yWWaVmOPaXIqkCRVN9We16yBZrbaH9BHO5mfKPP+kMOPyMy1wAZR1lLISmPPBiz4
         Wlvjz2jJKJcgWplUfeo/e9jcdiX1J+qp/oXO9TkGfH1XJU08Q64geJBleR/QvTU9epGu
         XvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768747690; x=1769352490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwhHWcSuKh5FBKzHk5nDn2X2ZmAMO+jm5eGTbzgp59k=;
        b=GfvV4wHRjjSZ28i3xkGHrBXXTkbgrorytj5dzQQ1Iygoe7X+1msIVUutJDOC56wXdt
         YzfuawItWaG8pM2Ls6Jewpz7ZNGUu4SFi3C9lLVbf21KPSBWmX61Ww7MlmeV0/El1M15
         LFFr38nDdyGUKrugM9PBRS0U6Lj8TPsJc16E0e969awXqNIDUpPHAIhzIxxGK5KHQCsF
         nCmQdvidoqhq4Sc7mIUmFDJHqgZ/A70E5Z7S69rqU/yNoczzjG7X2PE2ewlr7ngSmiCP
         vKdeF3f8+pEx+Rrpf+cUq00XNsJsJwT6nUUKzArVcE8p7ySGcWQCN0i64G134blL4JM1
         T+Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXgVPG6BQLoLGZ/hKssQOmaOw0hwKQlG7kAWcR38TU8fhywbefNLdL4xYgrSnkICJ46mhSrJE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzxqb+fu73rqhOjXFu4/5ivkFMTr7iuWH4ag0j/vr57rNlBkia
	5szd8cfSpTacdP0dWjYfogn++A/+MyVMtugYo79XM0sMAd7Z3pP5f9Dj
X-Gm-Gg: AY/fxX5E5WSbYLXtvv8VCcuzjGQZwiDj/x5J+2LVZ+i5NtFn2XaKWfN0qYAHdBTzANU
	pbAQRXRT4sqVV0/khT/MvaS/1PI/u9IsNB2VAMyx8hU5nBPyzu1BB1aIwNmKsuHz1SXp53XCggt
	WKOUoSs4z/68PHbVRNdjO7Uc9F6tN55L4fIjog3Aoz/NUaLlVHdc2fbA3p4a6Ag0gRLlgpgbdld
	b2joM691zCl8Qi1mLzRrGocr85VRvbNrPxYfM43Lblscli/nhEkJ/aj4oE6K8nc2PTu+FeKowOo
	qAmwgkLIqcPkOSIsIgz2MXJaMmH8PQ2U+saO3XrBhn0JcTg/5JCig0r7isRZT+U78Dkzqwhlb9H
	HnfM0aL/ez4bHQ6ykzjaDfhbu8K8BRkZp8kB8SYnAOx0ixWSboZtDFv/EnQyQKzRVhQ4zJdNBU/
	DpT7qjKY386TR773AFBM/nuoZNXA==
X-Received: by 2002:a17:907:3da8:b0:b83:8fc:c659 with SMTP id a640c23a62f3a-b87968d154dmr641819466b.3.1768747689514;
        Sun, 18 Jan 2026 06:48:09 -0800 (PST)
Received: from osama.. ([2a02:908:1b4:dac0:5d1e:7d5b:bff1:e1f7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795a31322sm853009766b.63.2026.01.18.06.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 06:48:08 -0800 (PST)
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
Subject: [PATCH] net: caif: fix memory leak in ldisc_receive
Date: Sun, 18 Jan 2026 15:47:54 +0100
Message-ID: <20260118144800.18747-1-osama.abdelkader@gmail.com>
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

The memory leak occurred because netdev_alloc_skb() would allocate an
skb, but if ser or ser->dev was NULL, the function would return early
without freeing the allocated skb. Additionally, ser->dev was accessed
before checking if it was NULL, which could cause a NULL pointer
dereference.

Reported-by: syzbot+f9d847b2b84164fa69f3@syzkaller.appspotmail.com
Closes:
https://syzkaller.appspot.com/bug?extid=f9d847b2b84164fa69f3
Fixes: 9b27105b4a44 ("net-caif-driver: add CAIF serial driver (ldisc)")
CC: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/net/caif/caif_serial.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
index c398ac42eae9..0ec9670bd35c 100644
--- a/drivers/net/caif/caif_serial.c
+++ b/drivers/net/caif/caif_serial.c
@@ -152,12 +152,16 @@ static void ldisc_receive(struct tty_struct *tty, const u8 *data,
 	int ret;
 
 	ser = tty->disc_data;
+	if (!ser)
+		return;
 
 	/*
 	 * NOTE: flags may contain information about break or overrun.
 	 * This is not yet handled.
 	 */
 
+	if (!ser->dev)
+		return;
 
 	/*
 	 * Workaround for garbage at start of transmission,
@@ -170,8 +174,6 @@ static void ldisc_receive(struct tty_struct *tty, const u8 *data,
 		return;
 	}
 
-	BUG_ON(ser->dev == NULL);
-
 	/* Get a suitable caif packet and copy in data. */
 	skb = netdev_alloc_skb(ser->dev, count+1);
 	if (skb == NULL)
-- 
2.43.0


