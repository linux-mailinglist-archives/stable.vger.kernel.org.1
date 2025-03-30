Return-Path: <stable+bounces-127017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6832DA759C0
	for <lists+stable@lfdr.de>; Sun, 30 Mar 2025 13:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C25188B326
	for <lists+stable@lfdr.de>; Sun, 30 Mar 2025 11:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D2B19AA63;
	Sun, 30 Mar 2025 11:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2jRadxj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681B54A05;
	Sun, 30 Mar 2025 11:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743333339; cv=none; b=vF/laMWZ+z1ArYbhOdl/zPA/VZpCN8LPg8Hb25JXBK8N8jx5GvIGpZzy28fm54hL2C/EsJj5jQJ81hWYbKPddBy9zZGrdjt3QH8HtBEZHOwUpclBRVcdRt/yxMu1bttavbtWX9FkdoW/nyfhl6R72LdksLjPYUlCab+K4uPxzhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743333339; c=relaxed/simple;
	bh=ECt91EY7sdi+ZAZgpiRGsq2myEddr0gF5Q/4CRaCPSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HPZ6uW5O5vlPTQ2VyzU1JmNtiaHBM5LHeZ5FME8WvCl9weGWE2DbD5+OURw05zxTF5RQBkSDBK3IYDVIwffjLHmCDnktxO/3BE2RSy1gBtOr9bOMy6DRXU10xQUgSOrKHkKlgAk+tnSTTaT24F04Qc3fpVhk6mzZIPe2R7Qv4rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2jRadxj; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff69365e1dso4679700a91.3;
        Sun, 30 Mar 2025 04:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743333338; x=1743938138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bOkg965odz+QE9cKXvYVRkNTxhqTHUa1qzYcFa9wPk=;
        b=F2jRadxj2QRL0OVEnz4ekVsfNSAZOUpI0CaZKF7i3j3uftyqgW9KaM5yrhm/0cL2iX
         QA/e++wPMiFR8pqASE2y3Tr3eFwtUGn+e8pGYGXpjhyXEIa4UTgy1CNngkeFnslzKdaJ
         ojI42iF8Ukb7VdPTdRDP+CPTtAVBHNe3rfDgNTVlVnXgzE/Sx9XYZZKrpOWN47e1HpMh
         OqR+LNFy8gm6BmJYASEO9s///+KG28OsmAfh9n2gAnCgXgo6kjD0YERqJP5xpH+WQrBn
         BEPzoKmtsSP2W0WIr6JQM2yj+9NXMoZqfw25BbD0JM/+9/PY2cUZki5cMndD8YJnARNx
         cO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743333338; x=1743938138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bOkg965odz+QE9cKXvYVRkNTxhqTHUa1qzYcFa9wPk=;
        b=AtjQtS/NSyFJeIWY52zdcq/Q3vwPz9Ggr5wfwaslkOEQPlKo4jieOoNJ7Snm+sV85o
         2uWudJBYgPyJMzqCmj0qDGrAKt8hxCds2PWMpNdjuOiPF+XYAHdsIo7E4vpxDlhS2ZP2
         j+dG/MEp2ENnsy6+Yvr5VXPH3YJtELSE7v/pF/b6tP00hOeOvBR1ZclLNw5V0rS30/aH
         gZGuAh6sfts8otgliT8n08srVsOagQ/5cdbphobjM89rz7irvZVlLkslIrOWmDMP7raE
         m2Ekc4fM+e4WtFbbde5d8HXe0uDuxDstHn9z3PSImp6h0UkeptuyjRbdoYE/lpLygqKJ
         Z6wA==
X-Forwarded-Encrypted: i=1; AJvYcCVjL4jxo19zhR/DsppGjbIxryx5svD6250Wvn+Gm8GAO6I/O6Sc1AZBNZwdRNTrJTJzvNTGvbynRRxIpIk=@vger.kernel.org, AJvYcCXxN8XUQGSm4EolanXDKrZjbK48ymevMHhobvYEZBX3Me6ZLDMRGum1ja+EtuVj6//L/KwiaXsq@vger.kernel.org
X-Gm-Message-State: AOJu0YwGXs1kh6wCxQBW88U77+lVbvnmYlYH8niXMc1a2AFUjzJtyhzz
	wYtpO/5jetbx2G3LRdE82GbhKMUKegfZTXN2JM0sLiikR0nZ+rhU
X-Gm-Gg: ASbGnctChLqqJnpBwrhNvWiJdZEc5gq2F1sCZGFRn9h9MfO83xlJhVKa+YNAa/8prvl
	HxN8par9SpCJOvU93em2zPAdwlBB6cfCQDt2yXeOKDlJq9+S3199Jk0TiD/ihIk7fQuge+8UDoZ
	Npx4BMy/8LBO5OWnd+0DtKoOFWWBgS5g8yYSLd5FHvoFh8z3eZvmCaQ/PEFIVEI7BBZSmS4ThkE
	JN4Q3bVDTitT2331UZCodAlhnhe2TquStBkwGtmt7XW8d0rSjRAApnzqrNUq8FKvSEedDAwnd3L
	YRn7y5PZYBgZaaDo+ayvIkuGi9CKyvQJb6P02Ns9mslYr8u0B4sPai34Fz7uKijjZq9nnaC+HPh
	wqpvrCakMMRAqUBpZ4WL+7IlffmvcmhIaQRRpW+1vbQ==
X-Google-Smtp-Source: AGHT+IEr5XA09hAhyrlbGXwVWq56SHCAv4LzqL2X4GJ5+M6iunRrNMxXVWWj1zZU1Aw/S704vfVyAg==
X-Received: by 2002:a17:90b:1dd0:b0:2ff:7b28:a51a with SMTP id 98e67ed59e1d1-305320b171cmr10716832a91.17.1743333337650;
        Sun, 30 Mar 2025 04:15:37 -0700 (PDT)
Received: from DESKTOP-NBGHJ1C.flets-east.jp (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039dff0c76sm7552658a91.20.2025.03.30.04.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 04:15:37 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	pmladek@suse.com,
	samuel.holland@sifive.com,
	bigeasy@linutronix.de,
	conor.dooley@microchip.com,
	u.kleine-koenig@baylibre.com
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	stable@vger.kernel.org,
	Ryo Takakura <ryotkkr98@gmail.com>
Subject: [PATCH v3 1/2] serial: sifive: lock port in startup()/shutdown() callbacks
Date: Sun, 30 Mar 2025 20:15:15 +0900
Message-Id: <20250330111515.393038-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250330110957.392460-1-ryotkkr98@gmail.com>
References: <20250330110957.392460-1-ryotkkr98@gmail.com>
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

Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
Cc: stable@vger.kernel.org
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


