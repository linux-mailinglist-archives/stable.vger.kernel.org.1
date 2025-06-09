Return-Path: <stable+bounces-151994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC4CAD1935
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 09:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56373A91E3
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 07:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5EE281363;
	Mon,  9 Jun 2025 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="D9T/nIOB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D6B280CD1
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 07:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749455071; cv=none; b=uBYNu5NRy2T+TA21DQNtJ2mN8QYoD+NkcghKjHy4ByUi00Mz2k8FW4rGY6stzBZ4Bfgs8IqcMI7AsaHUzpJ40W07wRp2zc6ZMN6CxHj0Lfl0J0MRUc1Vzz7pHVIrl2nm1ZInt+SJ6P1fjUYoJKaUoPtcqnU6FnV1YaIaw1u1QQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749455071; c=relaxed/simple;
	bh=Aw74MEKOMSP3CtxTaewVFE8Ntfz0jyoHZgR+tmeysak=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=seFcjBoA0zMeL0mLaMbOCNa+Z3eWyc0A6fqrXftJNeqblkAeHlSN3D+CjDbeW202B/ogBxx5e3DdA0rCyHDiunVXaeDm5aKLDjp73R7urEQvk6DnkTTTM5TVy+TLTB5wxcLA1XkeOS8lXCrBJYMcyvym0OBZ9t/htAurLcWaYpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=D9T/nIOB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-234c5b57557so35917675ad.3
        for <stable@vger.kernel.org>; Mon, 09 Jun 2025 00:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1749455070; x=1750059870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2r8WQzb+JVgSyOxnE+i/6qtzBR+LExX67w7PlIfP4M=;
        b=D9T/nIOBr5rD/jqydN6oggzesNBzh6UoD+sv4Kbdx9WnnMuxasFCMbDoAvnsmT2Jhe
         z8h2A1BBRDjs64nxHHtHaj1lkdWgHmIEH/dWEU1hDS2VZ4ysNIGHLP8vViy/ccf7hrKz
         HP7674AFLHJ28q/3tweJKae+Y6VgtkNnE2XpfTQrIlvKxbVIDAI6ikR8SN/ymfsT5bIX
         D8YaJZDs7J0RX8Akqbhj97YAPuCXtAfB5BYlk/EDTZFYg0X+n9BYtZVSrOxaEufANs9z
         bnWzGaJ/nAabwI3iL7TZdVnS8au0bFN8L2b4yJm4NzZ/Wk+f0CdO8WmKA5qLZm/Melo0
         +Ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749455070; x=1750059870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2r8WQzb+JVgSyOxnE+i/6qtzBR+LExX67w7PlIfP4M=;
        b=tezUmuusx1CHr84Wekd0d3GH42xfv5/kAHKC3Go+Y3u+MIdQu8L6xKike/X90DFiLL
         KmdycdmEs92iutT8cGUn/cgJJp2nNyu0ZY8ZW3QqNY0wd+0pJ8APZNouV7yPM/gxwYiV
         e8zrj8Ypp+zQuTH8FiMR5Ds6eheM0NOs/YNRQ7lYazHdKyhJOgn2KRj2VjmelUYhkUOf
         HmhhSi8dhhXcd7MOVl4g06PlkYNdIuSxrNKbbRCKMWvEMhdDRy/kXQunIuhVs79TXcx6
         MJVC7u7720joNbZ8w8sBbKyyGUDqmw36aU2GJJG6zrxYbb/SexyIj2uoD5p3g2vhKmix
         RQmg==
X-Forwarded-Encrypted: i=1; AJvYcCXEvZ0DCUJWq+1YBXgcU4ZU00DZLiPfTI7obKj2Z7aXpiHsX5+TRW6TIY9K06yXUt+E99xA6xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpYD9p2NOeNZ5wTb9V2ezy/MtzNA5oALbaWJFoCtgVVpGxKCKW
	Bvfs0HgJJ6LxH7HtmZQBLo7pxvaHxSPXTfYg6FUo+5wbQqGQF0/tKNIvRiK7d+Bsa9E=
X-Gm-Gg: ASbGncsBsJpZGrhSHP0ILkk9zS/tixcPkDLX6Nay2qpilZPsVSYJiwZexeG4kHl7WLM
	78cRvJA78IsEe0SadOEsQxQy/o/IcwkuNw8anjDEqBEJAC8dBuLaFYhAAj7wx4L8au5FFkp6Ezr
	5wt60bo9u+Qj6u3BlyFuCfHcFZuSsynsqzeQUEmyWe+HU7wGmTC39XmaMNMEvtVy6BdenjaCCBx
	8Byxu+bNc6pfw5G10KHEaRZCGnNOMHBEs/n2F2TFbs8wX4WipuHJyDJcl2XLQ/z4c5VaFtdJGS1
	BxkFOwYTYjtD2+zbM82pB/w6U1IvGVB76PtYkyNKPO34OLwgavE3pHzMtUMlxdIiXP1F2IzwPm0
	84vwiu1J2uyKsehNfJ60fZL9vmQC80DDs3oGAfAkxpg==
X-Google-Smtp-Source: AGHT+IGpx0fPdgm1EKp0dazP5RH9EWCW35YAP9lCiJDVJ2NhKqFRJ8viahaNntjBxyQhSeZ1tKrS8A==
X-Received: by 2002:a17:903:32cf:b0:235:6f7:b918 with SMTP id d9443c01a7336-23601d225cdmr180747485ad.28.1749455069674;
        Mon, 09 Jun 2025 00:44:29 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030969ebsm48573715ad.72.2025.06.09.00.44.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Jun 2025 00:44:28 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: arnd@arndb.de,
	andriy.shevchenko@linux.intel.com,
	benjamin.larsson@genexis.eu,
	cuiyunhui@bytedance.com,
	gregkh@linuxfoundation.org,
	heikki.krogerus@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	jirislaby@kernel.org,
	jkeeping@inmusicbrands.com,
	john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	markus.mayer@linaro.org,
	matt.porter@linaro.org,
	namcao@linutronix.de,
	paulmck@kernel.org,
	pmladek@suse.com,
	schnelle@linux.ibm.com,
	sunilvl@ventanamicro.com,
	tim.kryger@linaro.org,
	stable@vger.kernel.org
Subject: [PATCH v8 4/4] serial: 8250_dw: fix PSLVERR on RX_TIMEOUT
Date: Mon,  9 Jun 2025 15:43:48 +0800
Message-Id: <20250609074348.54899-4-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250609074348.54899-1-cuiyunhui@bytedance.com>
References: <20250609074348.54899-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DW UART may trigger the RX_TIMEOUT interrupt without data
present and remain stuck in this state indefinitely. The
dw8250_handle_irq() function detects this condition by checking
if the UART_LSR_DR bit is not set when RX_TIMEOUT occurs. When
detected, it performs a "dummy read" to recover the DW UART from
this state.

When the PSLVERR_RESP_EN parameter is set to 1, reading the UART_RX
while the FIFO is enabled and UART_LSR_DR is not set will generate a
PSLVERR error, which may lead to a system panic. There are two methods
to prevent PSLVERR: one is to check if UART_LSR_DR is set before reading
UART_RX when the FIFO is enabled, and the other is to read UART_RX when
the FIFO is disabled.

Given these two scenarios, the FIFO must be disabled before the
"dummy read" operation and re-enabled afterward to maintain normal
UART functionality.

Fixes: 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from bogus rx timeout interrupt")
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: stable@vger.kernel.org
---
 drivers/tty/serial/8250/8250_dw.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 8b0018fadccea..686f9117a3339 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -301,9 +301,17 @@ static int dw8250_handle_irq(struct uart_port *p)
 		uart_port_lock_irqsave(p, &flags);
 		status = serial_lsr_in(up);
 
-		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
+		if (!(status & (UART_LSR_DR | UART_LSR_BI))) {
+			/* To avoid PSLVERR, disable the FIFO first. */
+			if (up->fcr & UART_FCR_ENABLE_FIFO)
+				serial_out(up, UART_FCR, 0);
+
 			serial_port_in(p, UART_RX);
 
+			if (up->fcr & UART_FCR_ENABLE_FIFO)
+				serial_out(up, UART_FCR, up->fcr);
+		}
+
 		uart_port_unlock_irqrestore(p, flags);
 	}
 
-- 
2.39.5


