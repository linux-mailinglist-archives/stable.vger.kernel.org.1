Return-Path: <stable+bounces-151993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E41AD1932
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 09:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD3516980D
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 07:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2FA281359;
	Mon,  9 Jun 2025 07:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="grPvD35x"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB5C281352
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 07:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749455064; cv=none; b=JdBRu6mDlJHoWsxH4hVtpWS9mfj/WuCMwjDJSIGfN0z7EddZ9qVejA2FK8qMtuW5S9dOb50yZwSEu3GekNC2KjQp5SzkJ8X/mvkZ5d6Po2zGmJfpSkD9SuoGr67yDe/wN5doh9SSzIncU83F8eQJcMq2C6vDdprWRkDcVOMF4/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749455064; c=relaxed/simple;
	bh=sh1cGUiYYVGEGi8YqLowXFl/GRJaaw2ICSbcRxFVUtk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eJ1UXwwXvMUi8uOKiZ1iLvyTenpIunnQfJJ+ed5lC2rv5OTJiIEM7ni1DQqI88kMW8lQa7LQnx4P6toTb4//96fd3Bo73K1YAXy+gniCb+V16ZMGCxGOJW3RPmNugJG+e6iZOvdQbUIQCZxUO+Nw85ghJuzus8gl1zUTWC8H8FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=grPvD35x; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-235f9ea8d08so30281035ad.1
        for <stable@vger.kernel.org>; Mon, 09 Jun 2025 00:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1749455062; x=1750059862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tf3d4NxJrcGNbUN64elIQLb/pmeQW1fbqHye+etV/RM=;
        b=grPvD35xZq64cksE0uDYky34vJBZ4bByr2m+BlV3839saYONI7H2WaTe379QIXyo+L
         zSGy+12JIA2r3h2umsPDHjPox1dRycrlE3+CxcbBPZS3z5/35hRCvbLQn3NRJnfyP/V/
         HyOrgBjnlsHVGwMMUHGMdBvhZeM28xldjdxh+O06K6gHSfPYHPR32bWcZZDqzQxecuZD
         mMd/CD2K/jf4iJc+XyA7mhOBuOMApCLvhAyTFb7sTckOr0rXPM9S/pOdlBnyopEVw9n5
         eR3BtNegPzUxpVEvyhDIE4bmk1bTs2qLhprpgEowDy9ZrqtYUFkI/gLbViRM/Nqsb2P1
         NSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749455062; x=1750059862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tf3d4NxJrcGNbUN64elIQLb/pmeQW1fbqHye+etV/RM=;
        b=Owq+XjyMgfoY7ypl2YPcgsCYLN8goDlbxf6UAgZsoFHCRUHTLHcBX8QBe2UikB2pQ0
         4s9iKQd1HXfwWjPM+sUAVrhOWlNxAlBw4BSwzFJ5ggRxc3YTQmy4MX/hkBvxv6a1xxUD
         m7Uf7IzlU8timBxlwY3bL2K9dulYx3wv+f+HYD2cMRFjVWJ8P4MG37H/Q+ivul1vHYTJ
         Ow9J0u0T1bCnKFJBRY75oWBLHRo+o9/Ms2SNS4I5ZF4+4VWfm7qdXCSUxY7TM104QJb6
         yZr31x5yGrtmVrEu0nb4nAWlRg8IwaJ3S4D3gpaBK+5A/rI5piRv/Vi4p8f8kK8LnxDK
         TG4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUozvMr8PkQA3epir71V0IRMfD/rNgPW5Wz3vx43nDdN+L0WTdV7/kmC7Mu8fjthLLVsAVX9jM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGkkRI4BUSaBKaZ0/UMGCW5ZV/3w8zH5pE4E6yaQTyLdBWEGn7
	gUMLbrI73QR/jSrmWjv5NCUcVAOOlqFct47GaoYmJl+RX7pHRxTnvciDHe05T3510gE=
X-Gm-Gg: ASbGncvK951wefVnn2wT42cGJ2mnzAaJXtmkTK/Ri7079Bjbbm7dR93M88yE29PeKMb
	7kz52zkgSyog4D8Dt5n5XXGkr8SBcMwE3rk96sPcyeRa5DSFPgxA7t5s4zNWNTNnmiVxjWbmBHr
	PWSUkdPkx9BeUMYZwoyGO1at21+uYyfECCjMg4So1JpASlzGRxreA891fy2jgaJEeMhDb2v2N3P
	ZAyd6SBwsuH/F/4JKv7Tu0wGve+YQAoaz53gCEKo2aJVIp+rRRJrO6hHYsQJafkCi0DR4fvINW3
	wL8nVNZUQ0noacfS8ItEhS50ditUv8rG1+8L9z6hmKxCVV4U7l2VntIk90z0kbhfbTYTFhHpygG
	yunxn3Y4c+fdthWZ/99X19ptgHMPFNLQeCZ4FCx7HSA==
X-Google-Smtp-Source: AGHT+IEQ7dRItoYtft7Z73E1bG0AQUocTaShtV8m/XxHYF/+UtJ1i4g9HW/VM1Ga0ii/WT7qcpPUAw==
X-Received: by 2002:a17:902:d48e:b0:224:c46:d167 with SMTP id d9443c01a7336-23601e44edemr172981645ad.16.1749455062090;
        Mon, 09 Jun 2025 00:44:22 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030969ebsm48573715ad.72.2025.06.09.00.44.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Jun 2025 00:44:20 -0700 (PDT)
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
Subject: [PATCH v8 3/4] serial: 8250_dw: assert port->lock is held in dw8250_force_idle()
Date: Mon,  9 Jun 2025 15:43:47 +0800
Message-Id: <20250609074348.54899-3-cuiyunhui@bytedance.com>
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

Reading UART_RX and checking whether UART_LSR_DR is set should be
atomic. Ensure the caller of dw8250_force_idle() holds port->lock.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/tty/serial/8250/8250_dw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 1902f29444a1c..8b0018fadccea 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/lockdep.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
@@ -117,6 +118,9 @@ static void dw8250_force_idle(struct uart_port *p)
 	struct uart_8250_port *up = up_to_u8250p(p);
 	unsigned int lsr;
 
+	/* Reading UART_LSR and UART_RX should be atomic. */
+	lockdep_assert_held_once(&p->lock);
+
 	/*
 	 * The following call currently performs serial_out()
 	 * against the FCR register. Because it differs to LCR
-- 
2.39.5


