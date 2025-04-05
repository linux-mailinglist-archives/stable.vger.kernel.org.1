Return-Path: <stable+bounces-128397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDA3A7C94F
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 15:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94F6D189A31F
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 13:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72C11E5218;
	Sat,  5 Apr 2025 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkvmSFme"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288B21D47A2;
	Sat,  5 Apr 2025 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743859560; cv=none; b=M8G0q94yW0bMW/MRv0CIGf5W1QKweYiEdgl/FaPjgHOEM3unE88eo5nPypZc8pLAeW4o2ZknOW7GRYCLH39rvjwTHjrnYWkhiNdIV1p8Bp48v8p8XQpjC2N59jYjNZO+EAXhv+ieUTOlQazr3L0lJ6KWSptzghGpyXoupT7r51o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743859560; c=relaxed/simple;
	bh=W0hFo83763PwHhqGjvqrSnEmlQxHpIjB+dI7T/lyDqw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qa7Od6APZzgtNT6F2ztH9hbJ1Czfjdx9zdWYNfUfoowSx3Xc3oEawQCfwXTCVRFp3QwTTDNvgrtFgblQv+ZaAnZwN80LrQ/GaoJMSSa5afKl3dLeAaoVH+//1HKhwExvmpNaKBKirFe+EobLmkD83NYBsoFK7rmvv7bBXiQuOtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkvmSFme; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-736dd9c4b40so2591979b3a.0;
        Sat, 05 Apr 2025 06:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743859558; x=1744464358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nKs0lwSpjYnhUeQPgpDR5O6PnIX9bK5Z7Homt3o7Oqw=;
        b=HkvmSFmel3Km6zqRJMxfwqRxUu0OJp5P48GNimoSYv/vHaaYHv61nhbwEWggt0ON0C
         Hzf/kOAMPys1Ub66FiKG5y/FHiRKzTvKzoH9r0eLoMV+eXuEqHmPZbK1NU2Luz7MLfE/
         SuXl2YOSja/z7nx7w00z2sQrPrO3A/AKYRHMNIBg0fu15RYPsuWkpILWk3/NFgCgRfJd
         tOEQuZWonUm+tN39VsGXbYEYbocujiCZjcvcN26RBwDi3yKJ8cGRZJMRuwQk8fi6MDVi
         SDU3JgaXr/RgeUrNylHef/e5YYRRYgmwvH/y2x1FMHC6ihBnTP7fVl3tdR91BA0CW49b
         Qklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743859558; x=1744464358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nKs0lwSpjYnhUeQPgpDR5O6PnIX9bK5Z7Homt3o7Oqw=;
        b=qz45hGSOXtyULqjsmCQjEdhVT2lWhYJ8zpdgraIyfSo6bkQp5LdhDK3jgj7XYScSa8
         xzW0Va1CmK3cqaqeZtffQ6F33SYv3COkRLpq56BHLWeM9a8eqqQwVWaUC9kUogt/dt8I
         wqY6clrlJ8Fh1y+vi7pGROJXhIeT4ufr7R/mWJdZHOSJN3fD9yXp/IklFDC14uCenj/f
         gHjnyIGOU/CVsyGfJb+Xf9PZn8gH6hIOfaes05VsSpCCZ+Bh+tAVbjvBZTKkIltmkk4l
         +wA06p/6qHm9oaHrtUfEn1QRcrAVy+kDj0TmedYC65ukNd1+eHHqvbDtVil0YRHbza4E
         SiPQ==
X-Forwarded-Encrypted: i=1; AJvYcCViwteBP1/xVXn8Do/evaBDR58tDHyhjSFBOggLYm3GcArWohvXSchsOMTDkEFZzLyXi2+TwKPtwnoK3Vo=@vger.kernel.org, AJvYcCX9qMYA1lTMevR7OVju2U4+5zmhoTk2WMHL9hMNmplwLLknu/icXcsCgrJDL19hMxA4xHp5spzf@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc61MFPyS0mgnfsfUe1FbWm26+jn8iDqPZKEK/R/X9pqsIvg6c
	4ckN2HVVApJeO5PFSdk1Qzyc4g3qrpyO3hyHqkuKzE1rA2LhdJ8M
X-Gm-Gg: ASbGncsb7sRoG1sIlfsPNZ98T9miERvp+L5cHJvnMCkwaS/b+ccD/PzP6hhVe5LlZw8
	l/60GoSS3JGNYAUiMxUNpvXCN15lkgHdhnbBjcuEZUqaKMRfAdlpyDeExibyKdP0FwCvHKKlp+5
	VPxQoOzurKs8D5JriKSbyU4le3v3saHW7SV1R+N1g1ZfwIfw6+FtZg3K6LATPL/HxyL9WP8tA67
	6j0zGgG84hE46KNDFykOhruuX5tY0IzTJ/P0yAyOqZBDJfMAtyc76elzKfvz15FLkOKvclv2YsQ
	XxsgX7wbcVqlljEK/TCbXCQ6vQVwcUM8eCYMTfPR6vcySYNZtMel3pAymmvApMp2CzvApvIdOpd
	4tyDZvAyg3yqi7CoYKDciP7gHNjHaAt8=
X-Google-Smtp-Source: AGHT+IG1Q4lj2kvYXbd1JXXsWrnfajZnJiCpu1OsmZxghmbQZjNxXaov1rF97YvrfNBWxpHmvMDgAQ==
X-Received: by 2002:a05:6a20:6f05:b0:1f3:237b:5997 with SMTP id adf61e73a8af0-2010517563amr9491084637.14.1743859558310;
        Sat, 05 Apr 2025 06:25:58 -0700 (PDT)
Received: from localhost.localdomain (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97ee2b3sm5200206b3a.46.2025.04.05.06.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 06:25:58 -0700 (PDT)
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
Subject: [PATCH] serial: sifive: lock port in startup()/shutdown() callbacks
Date: Sat,  5 Apr 2025 22:24:58 +0900
Message-Id: <20250405132458.488942-1-ryotkkr98@gmail.com>
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


