Return-Path: <stable+bounces-128402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0248FA7C9C1
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 16:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80BDF189AE13
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 14:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5911D47AD;
	Sat,  5 Apr 2025 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7qxemuh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B763C51C5A;
	Sat,  5 Apr 2025 14:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743864881; cv=none; b=OQuhQr12opkReYP63metO65hLe5uo7g3IZNNf3gPP0C4/anIIYvpoIIiZypkB37CEmmPTtaEYeRGDjps5WDqwEnluBMKzMUYW846L2xUFD3mUEFOrWM7fbeuuAkA8ziwGGKqLTyL3w9oLE7ogIdSvgm+MgUrO+cSkjIqe7mw9+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743864881; c=relaxed/simple;
	bh=W0hFo83763PwHhqGjvqrSnEmlQxHpIjB+dI7T/lyDqw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MZt6cFYHfLxK1VjxvZcIVBB9v0W136g9P+UsagVp7ympaNojeHT4gJJAXRa50K3KYZelPZuhVFvxsa7ZjK0K5ONb8kKt9tXk8K6+Me+nvVLURY6dZH61YrYJeq6tZ6l/8FiAxG29MlfI6Tf3Q7/89kYYfFGShwn2ZBMIFbSCoow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7qxemuh; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2264aefc45dso39739265ad.0;
        Sat, 05 Apr 2025 07:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743864879; x=1744469679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nKs0lwSpjYnhUeQPgpDR5O6PnIX9bK5Z7Homt3o7Oqw=;
        b=k7qxemuhxC82lHrW4JLnQUnrZsxYNqvECxL9xsv8LHbtXQHRMgiUqXrK5BnL8bK0J1
         96l6uf4qQ9CZjxKrw39nYtjpL3kqc6AcXTmqxRGn8ZHo9Ea1A6g0Dc47KXDFzYq5gtyW
         nNb1mVqMN9oPgXUY7o3H1QLfQ6UTwHqwJVpbZAYEZDG90x+Sd6drbb94MogkEShWNVwa
         0Zd4rYDGzQ72m3z1j3DAeQLsqnOH04vOXR/CA2048o8EYkl3TkAvncwzp4o2cdUOjmz2
         Fft+0Hif78JqYe3EdY8U2twOm+Rm/Mb7gAb9em5ReBM62vH3okLwdNF4ckwjk5B0HmFg
         nRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743864879; x=1744469679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nKs0lwSpjYnhUeQPgpDR5O6PnIX9bK5Z7Homt3o7Oqw=;
        b=iQqvW/kwHiMNLXEdB/CkECrSzd7c4Y1QCn8Pt8EEhgXivaAViRUoz6Z484bjTbVvGq
         1raJ7jEASJrnfiHb/MWjo7trIkXKYyXNzo1JEu4TO19EhB6H6t0pxxkWbL5T3W+iqO4r
         ASuFpyqhA5o8EFKmwvC5Gj+l8OwdGM+lLe4RBCfz/05vmuWAb566m/lD8alhqpmcGmRH
         io+jKLPbsDsex8e5H1/QsPlSjO8Ckac3PSrWTq5lezuq4WyJvvh5bksxwSOLshIXtMPc
         VIYjnetZoSpzmm+N48T1hhzchQnWRebAimTBE46fB8lSdMRSGCSOHCw3cGfQSxUkRkCc
         944g==
X-Forwarded-Encrypted: i=1; AJvYcCU459nXDQ8KkiRt9sl5hvTsOqO8RNLLqf9dydjhadAT7AF1G1Wqgxbo9NXbk4GIq1gSXp654GUw9Ra19hw=@vger.kernel.org, AJvYcCVVd0Nx9M/7AKaJ4i3qc6EiONSc7WUBMY22XIkSkFiOCdDDoxXRSpWExoHz87TgKEuoZ6XTgnV2@vger.kernel.org
X-Gm-Message-State: AOJu0YxObmSIZo1C0BKsUGcXUzdfEbhBnYsZEVA3pyYddhW6dF1HOrax
	RpEgN8g4dhTl/udmud8MV+fM94LtmDjXqivaLFaMS15YJq2XwVg/
X-Gm-Gg: ASbGncvt6CA9SGA6uAoUeCiV4GC5DYzFXAqlm140BVC1mL4JiYWoEPg8Xk+YzK00J05
	lPPVKbq24ohql0l9KkQERCr56VdA4QJ5IsfL9XEWG2TAumWrBpg5F5Geqju45bdx06OT9MnouU2
	gWDhBCCQKVeFLmOsgh9U+FHDl8hRLTbS+prbiBCvTwKA7KaYAjhIZRJVlrC13wmACypkdPpfG3G
	b/sf+5+HRajurhpH08O1dEGFeyYWpzneQ1FR8lGOCw2Gdiunltox3Nino7qLkmib2OqvoxCDGF0
	IUbQeAtOOYduc77djJK7ulsFoTkeDZqYhbOZxoF+1Fsr/PJHprpJaMWyZ4KizeJP/dNHd+ZOe88
	bacuEyya0WM2gNOoKwOYtVAAqCJ3uhW8sLoJ7Fl3/rQ==
X-Google-Smtp-Source: AGHT+IGaG+x1ud/97AzdLIBHj4DsVwQhF6qAy3rP10DkocE71F8Il3Fty01NOhrk0Z8YGiYjGzJaQg==
X-Received: by 2002:a17:902:e552:b0:220:c813:dfcc with SMTP id d9443c01a7336-22a8a8b80a3mr92472285ad.40.1743864878867;
        Sat, 05 Apr 2025 07:54:38 -0700 (PDT)
Received: from localhost.localdomain (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866dccbsm50694485ad.176.2025.04.05.07.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 07:54:38 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	bigeasy@linutronix.de,
	conor.dooley@microchip.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	pmladek@suse.com,
	samuel.holland@sifive.com,
	u.kleine-koenig@baylibre.com
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	stable@vger.kernel.org,
	Ryo Takakura <ryotkkr98@gmail.com>
Subject: [PATCH v2] serial: sifive: lock port in startup()/shutdown() callbacks
Date: Sat,  5 Apr 2025 23:53:54 +0900
Message-Id: <20250405145354.492947-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

startup()/shutdown() callbacks access SIFIVE_SERIAL_IE_OFFS.
The register is also accessed from write() callback.

If console were printing and startup()/shutdown() callback
gets called, its access to the register could be overwritten.

Add port->lock to startup()/shutdown() callbacks to make sure
their access to SIFIVE_SERIAL_IE_OFFS is synchronized against
write() callback.

Fixes: 45c054d0815b ("tty: serial: add driver for the SiFive UART")
Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
Cc: stable@vger.kernel.org
---

This patch used be part of a series for converting sifive driver to
nbcon[0]. It's now sent seperatly as the rest of the series does not
need be applied to the stable branch.

Sincerely,
Ryo Takakura

[0] https://lore.kernel.org/all/20250405043833.397020-1-ryotkkr98@gmail.com/

---
 drivers/tty/serial/sifive.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 5904a2d4c..054a8e630 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -563,8 +563,11 @@ static void sifive_serial_break_ctl(struct uart_port *port, int break_state)
 static int sifive_serial_startup(struct uart_port *port)
 {
 	struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
+	unsigned long flags;
 
+	uart_port_lock_irqsave(&ssp->port, &flags);
 	__ssp_enable_rxwm(ssp);
+	uart_port_unlock_irqrestore(&ssp->port, flags);
 
 	return 0;
 }
@@ -572,9 +575,12 @@ static int sifive_serial_startup(struct uart_port *port)
 static void sifive_serial_shutdown(struct uart_port *port)
 {
 	struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
+	unsigned long flags;
 
+	uart_port_lock_irqsave(&ssp->port, &flags);
 	__ssp_disable_rxwm(ssp);
 	__ssp_disable_txwm(ssp);
+	uart_port_unlock_irqrestore(&ssp->port, flags);
 }
 
 /**
-- 
2.34.1


