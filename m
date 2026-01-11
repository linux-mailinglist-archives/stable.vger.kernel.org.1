Return-Path: <stable+bounces-208008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DBAD0F053
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 15:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39941300ACD7
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 14:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B90933DEF2;
	Sun, 11 Jan 2026 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iwell-eu.20230601.gappssmtp.com header.i=@iwell-eu.20230601.gappssmtp.com header.b="nFdZuYcb"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B08318BAF
	for <stable@vger.kernel.org>; Sun, 11 Jan 2026 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768140008; cv=none; b=T8Mvx2btMemA6kh4jpD7OUEl1oTfECVKqLVeUcIN5na3N9/fWcoPUGQ98y0lZ5tUWKpEZsTyd/7XXBI1gDZEFVttG/LbLxzEQ6y73yY8wDRg2pfpFvk3SOgehe5gt+Wv+bJF2gI3xIS88W5bCemZtrLCYq6I7/dEYzIayr9pbRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768140008; c=relaxed/simple;
	bh=muAbc47f+KdV7pThOPib6X86PAnNbxXumD783ShwRa4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQFK/4q97aWfZID9EmDQ/10/mqyBc/yJLCgGhY84py7gDD+4hII+MDZVncmGxUo6MS+0FnzZK717+F7MG9LX3d8VpB8jtYZ1Vw5P5opm8vJx+hMPOFHOO43W7mPHrgCYatsAEZ7amBU4HD3mH12IxWLkWRZrw0qmnfiGYEKt8p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iwell.eu; spf=pass smtp.mailfrom=iwell.eu; dkim=pass (2048-bit key) header.d=iwell-eu.20230601.gappssmtp.com header.i=@iwell-eu.20230601.gappssmtp.com header.b=nFdZuYcb; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iwell.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwell.eu
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64b8123c333so8927648a12.3
        for <stable@vger.kernel.org>; Sun, 11 Jan 2026 06:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iwell-eu.20230601.gappssmtp.com; s=20230601; t=1768140004; x=1768744804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xShQI6nmF2mT1Lv36uqcWWMajb2SrUl2CNXN+SemGJ4=;
        b=nFdZuYcb0mjU5m53VLNXZk/nYWMjY3Ue0pHayH5IBHqfxbEq4bWMa8KDAoEHkuBfli
         vw++qrfkoNxW7SYsn0EvXv2h/jUo42WaGxhYu2nsUCaXn+RfSiGSWgO7Jk/7zt5tafqY
         3+Cp5vkp2piDCD17yCFN8Bwq9cKB/QBaJIqJhQPZsYyX7pUO0yRNIN1mkrizrCHTzDG+
         61bMeBwP4fNJjjcxfAKnBzXR0NxzooKXw6YV1uDpqY7u1nmYrgHTzYHnoeap5J50qwRJ
         e41dy9x2EjsNnmLlR2odlu7A3L58TVeUHX4MDi57Qx1gonJNavBokw3pL6zibXbDIPbj
         rF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768140004; x=1768744804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xShQI6nmF2mT1Lv36uqcWWMajb2SrUl2CNXN+SemGJ4=;
        b=uxGrL85YfvINkrCrjX3+TWGHJy57kSm4qTGoONqTg788tfqgFeqs9cgQeJhynV+mmy
         BqRuebOu2ob5rc6vcW3R6cIveut5XREbqhIaX7utTTEc+dQuvkuo10ghmw5Zhh0dpHgP
         wIyTJy+T0nRKZNkTAZWYb8Z8lr+SwSNCviMMC+VGlnensGgM2Ko7J2Ne1VXnTBy2UxK1
         biaPtJec1WQAn5YimYm0UaaKsWmiMjyP2UDg+5lY43wbGPpmS6SRD/FtrSMr8cJZkwBD
         YVQvxFQA+N64TFS3RxKfhflatL3202qw9gNc1c+JZ5jIVvYt8g4lvDCVM12xfd4p8Q49
         PMdw==
X-Forwarded-Encrypted: i=1; AJvYcCWuxuJkiC+B0RD9jW1LiS6iKkaRKbXQPeoNovDjbvjgGDOsUbL/QVsmJgwnwuWya/TdrIE7tYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzob2ceO4GDqOw9P2+hY82+fFekmQAYIGL/5p+dGYH5ntURckfQ
	TRE9Z4t2qcBF77D19Aa8ShIh//GBoZ6Jjsiow4w7b90g/E1OVuTo06GQpy0JjaLSqV0=
X-Gm-Gg: AY/fxX7PEAMIFaUrRIiPXt9uRranhcG0FoQoxWECiAj3BLSIr62quisRjVidbXweUBi
	vrvdbqxxt8fa9iZbll0fDHgAoZLE5379FpjM+2OiREuk9Q8jmoLig5okAlKJcWCszZ8/AxT5fdA
	w3vDDFFq9OSf2xUx/7yHrUxP24u0DSC+gyhqCfOrRyUIc3mTT9Qo9c51CTpxzWXqrnk2Jy/ZnZy
	8q27+lrOx9ANwb7+wub72d2ctMVNMvt3Q++bmlJLXOFQNFAnjnQptY4jbUYQOgnk/qbu5bjh4pu
	cah372h5CFHWSQS043CexNz29kF502bf9ExJM3fpiqf+j876HQJQ5mzXimfTfBaBZmKimthHLKq
	9fA6SUwXdEBoWNHNdALHV4XupjQJLLkvBbroXZlUp0ptU5nbQodVDjLcj36wSTTa3hTa69cjVHq
	j1QTrsbjrM4+KzIB32s4FUC3p1ZtfnQmMxm09dgYdSEfRVCA==
X-Google-Smtp-Source: AGHT+IFdxFqrMjfzOnLiMqQ1xgseF6uVa69RCR0RmsJGx0nrevh7/kvqJLjRGbGScdx1/jalJcuukw==
X-Received: by 2002:a05:6402:348a:b0:64b:6e44:217 with SMTP id 4fb4d7f45d1cf-65097ceaecemr13531308a12.0.1768140003970;
        Sun, 11 Jan 2026 06:00:03 -0800 (PST)
Received: from localhost.localdomain ([178.224.217.169])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b8c4048sm15488184a12.2.2026.01.11.06.00.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Jan 2026 06:00:03 -0800 (PST)
From: Marnix Rijnart <marnix.rijnart@iwell.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	regressions@lists.linux.dev,
	Marnix Rijnart <marnix.rijnart@iwell.eu>,
	stable@vger.kernel.org
Subject: [PATCH v2] serial: 8250_pci: Fix broken RS485 for F81504/508/512
Date: Sun, 11 Jan 2026 14:59:17 +0100
Message-ID: <20260111135933.31316-1-marnix.rijnart@iwell.eu>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://patch.msgid.link/20250923221756.26770-1-marnix.rijnart@iwell.eu
Changes: 
 * Added fixes tags
 * Cc stable

Commit 4afeced ("serial: core: fix sanitizing check for RTS settings")
introduced a regression making it impossible to unset
SER_RS485_RTS_ON_SEND from userspace if SER_RS485_RTS_AFTER_SEND is
unsupported. Because these devices need RTS to be low on TX (fecf27a)
they are effectively broken.

The hardware supports both RTS_ON_SEND and RTS_AFTER_SEND,
so fix this by announcing support for SER_RS485_RTS_AFTER_SEND,
similar to commit 068d35a.

Fixes: 4afeced55baa ("serial: core: fix sanitizing check for RTS settings")
Fixes: fecf27a373f5 ("serial: 8250_pci: add RS485 for F81504/508/512")
Cc: stable@vger.kernel.org
Signed-off-by: Marnix Rijnart <marnix.rijnart@iwell.eu>
---
 drivers/tty/serial/8250/8250_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 152f914c599d..a9da222bd174 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1645,7 +1645,7 @@ static int pci_fintek_rs485_config(struct uart_port *port, struct ktermios *term
 }
 
 static const struct serial_rs485 pci_fintek_rs485_supported = {
-	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND,
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
 	/* F81504/508/512 does not support RTS delay before or after send */
 };
 
-- 
2.52.0


