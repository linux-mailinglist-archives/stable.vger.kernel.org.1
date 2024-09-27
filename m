Return-Path: <stable+bounces-77890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2F898808A
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 10:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34DA1C22A24
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 08:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5197189B91;
	Fri, 27 Sep 2024 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADRo1J/H"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF02188A13;
	Fri, 27 Sep 2024 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426466; cv=none; b=drZe6lKT0qQYjB3Xab0lqpUMCU/aSwJYpZfxDleH17fx7TpG3SPYeN+vWI6ycjcd+3X4wSGRYC/IBQ1ucm3vzRbt6HSNaiOqmT5n0JQ0l9Tokvk/f4TVqULivIW/YlUUl78F6DzSKWRt89lTqQsHBsgpbFgfmiBPe6W+jAUPxlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426466; c=relaxed/simple;
	bh=AOxp4hRhw4ffiQydMMnVDt7YirAsI2cruYRs3SLM/h8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hCtGxltUXSNsJ3/Vx/frIsXqV38+QXc51hFiI0lzhJ3wnIwN1TjUHWKrzV7A1FgjLG65sStPdPAUvewNgRhLsZnNp+U1qECEUxDYgpomrIQGG0BVs/DdMLX5hyP6rRZImKRPGQiFftuS3rNVkZcHfOvbHQzzbcqpgpwPSOQzoec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADRo1J/H; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2da4ea59658so1678569a91.0;
        Fri, 27 Sep 2024 01:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727426465; x=1728031265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ydo/pKZERVs0bqoqAlHXeOYxiKkpvzcXkDRwOGg+5o=;
        b=ADRo1J/H60Rx9VYYU+p1xOLf1alkR+0c/vwQFek2Q4wySe+nnJmh+CyXjJAJR4wCUq
         BuVhUWfK9rG0bUdqvw9BUyD5P8yEVF22zZ0365IIQ2TyfFQdbtR78Aq+Ylwa+XKvRruz
         ZMA+DhYu5pe6zxYeKNM+sdTWfv7sqqa22hJpsEXiS+N7eVx1t8HOt5GJ7Vx8CKLkvRI5
         bly7zbINlNqCx1Un1l+0ZZ7EX1iqPe47iKJ8XEmQd2fRSr6xVvJLPfrql9Kp5EW683nQ
         KaRiaim+2wDTQohYVX1bOp9js4sBUaMcy24UGtWKvBH3WL9qjV0BUZYyP2FBGgS5iS21
         ZQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727426465; x=1728031265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Ydo/pKZERVs0bqoqAlHXeOYxiKkpvzcXkDRwOGg+5o=;
        b=CT2B3i54ERMJrFxAPYSjONZ2nrEJyjM177FCCtY8Vo0vBuQp3hC6pfP+ESGjqiZRuW
         38jS6/3yVMqRnG4PILyvuVVzkbetdnm+CsUn1HB9gHDE7MhiLmLFZLmDasiGNsz3fj/6
         DueWl5KarbiixfdTPVL96HxmiZmWxJvIMwtuv0TNpu/PqfNZz7UuPz1MS8YBoN3hY5+t
         c2Z8HzkStLFjGTj+SqXHWD3sgXpelIgjPJVF8kRRyc2vPT7vhjaPDWkwtUVXvl93CHDm
         G30ODBsYPE71rpzady8rJjTBo2NqH+UC/k+RMALC12gT5FSCECk0rINX/ZmtIaOLj7Bu
         SuPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXiw8yD0me202eewovZSsk3n0LZo3e3biVs6JkgXao2musNUAJRONQF1zMGTd17EDbJ5q6mjRZy630vzk=@vger.kernel.org, AJvYcCWyyDz/aEmG18K1fOizv312tEcRHiiJzSjwcNxz2MCw1s44hhc0ibCqcobCsSiFDFCl9YZ40/6F@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0D15IeNLs+QRGMv+VmJlYg9QGbVTxiYxOjipWpLQWzpA99eQj
	TJC5ty0Q0BtsoeooOGl23zEen6HM0C/nypVHOuC6JHVfaTCJl9bl
X-Google-Smtp-Source: AGHT+IEMOi60RjhnrsN90Q1PLv2GM/tYKsZ2PE5A15HJTUNAtUl/wmC3n+nECtpIf0liaEVnHlkXng==
X-Received: by 2002:a17:90a:f00a:b0:2d8:3fe8:a18e with SMTP id 98e67ed59e1d1-2e0b8872d71mr3143054a91.5.1727426464532;
        Fri, 27 Sep 2024 01:41:04 -0700 (PDT)
Received: from tom-QiTianM540-A739.. ([106.39.42.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e08c35fed5sm2488411a91.0.2024.09.27.01.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 01:41:03 -0700 (PDT)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: amit@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] virtio: console: Fix atomicity violation in fill_readbuf()
Date: Fri, 27 Sep 2024 16:40:56 +0800
Message-Id: <20240927084056.7193-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The atomicity violation issue is due to the invalidation of the function 
port_has_data()'s check caused by concurrency. Imagine a scenario where a 
port that contains data passes the validity check but is simultaneously 
assigned a value with no data. This could result in an empty port passing 
the validity check, potentially leading to a null pointer dereference 
error later in the program, which is inconsistent.

To address this issue, we believe there is a problem with the original 
logic. Since the validity check and the read operation were separated, it 
could lead to inconsistencies between the data that passes the check and 
the data being read. Therefore, we moved the main logic of the 
port_has_data function into this function and placed the read operation 
within a lock, ensuring that the validity check and read operation are 
not separated, thus resolving the problem.

This possible bug is found by an experimental static analysis tool
developed by our team. This tool analyzes the locking APIs
to extract function pairs that can be concurrently executed, and then
analyzes the instructions in the paired functions to identify possible
concurrency bugs including data races and atomicity violations.

Fixes: 203baab8ba31 ("virtio: console: Introduce function to hand off data from host to readers")
Cc: stable@vger.kernel.org
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
---
 drivers/char/virtio_console.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index de7d720d99fa..5aaf07f71a4c 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -656,10 +656,14 @@ static ssize_t fill_readbuf(struct port *port, u8 __user *out_buf,
 	struct port_buffer *buf;
 	unsigned long flags;
 
-	if (!out_count || !port_has_data(port))
+	if (!out_count)
 		return 0;
 
-	buf = port->inbuf;
+	spin_lock_irqsave(&port->inbuf_lock, flags);
+	buf = port->inbuf = get_inbuf(port);
+	spin_unlock_irqrestore(&port->inbuf_lock, flags);
+	if (!buf)
+		return 0;
 	out_count = min(out_count, buf->len - buf->offset);
 
 	if (to_user) {
-- 
2.34.1

