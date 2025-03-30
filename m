Return-Path: <stable+bounces-127011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B65BA7583C
	for <lists+stable@lfdr.de>; Sun, 30 Mar 2025 01:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CCD43AD2E6
	for <lists+stable@lfdr.de>; Sun, 30 Mar 2025 00:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DAC6136;
	Sun, 30 Mar 2025 00:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caSTsdDh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7AA23BE;
	Sun, 30 Mar 2025 00:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743294962; cv=none; b=PoCQEh1/qaDh4fm2Wt6QD4Og4Uma66ACLouY8lUXjc5Rh4h2aLCd21yUBHyIsurG9RCb4uM/kOqUaUG9vk4jhhpgPmJctGxAq+ix7BddFKJgQH3nnA8iGr0Y4MAPEYJZ37fildPrRFjWiV9kZY/3NchbnNA5w98AEn6ILydogeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743294962; c=relaxed/simple;
	bh=Zf8GQHACb/QY6q4rifOfdQaOE8Zsusu8WvNUFSwPXko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IIRLzgYgFucuTqze9aGJcBgCwnSZk+Sw1LM4++NYrlmevHN+Z5Dz94dmctyOXZGgNEDIHhEQkcskI7AjP5waSrqDI0zloVoY/FKahVgL1tt1ZFOrtCh/yUecLTxH4MOjwxKeIJV7gSFyK7dgo4zqxD7n1AZXS4ZTx7efn24JgeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caSTsdDh; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff69365e1dso4427828a91.3;
        Sat, 29 Mar 2025 17:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743294960; x=1743899760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I87PBBHC1/SKne6uhKC4Z9to2SP1rEfx4IDoCZFQKwE=;
        b=caSTsdDh5285kZ2DWt6lka3yDEN/AxjFt2PW+Ubbptd8dzfwYiWOQ0jZjHjKaMCjwX
         eeSRTxNIP8ejQjNtXColsSD8M5NbLDrFJz5Ltd+2xS6P5QH3qANfVQZc/SeND+6sXtaK
         8Uw86KCiDogEa2Xho6zpljroGZxiZ/LLBZ/pz/uyb/t5Mdumj+vEIb0qeP5EIramul1q
         UH63X1PKRSM96ZaiTE0Uan3YEfHoZ4RvyAIKvKW/OUTYSfe5BOKvkjsmHP5YGQOZWZSh
         fyiFu9Ep5lz4ZOblwcbhboyfcnLtB7Q9yArRMJsUxdoS9tInmSA926piflQ8Jxi1gCgw
         9XeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743294960; x=1743899760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I87PBBHC1/SKne6uhKC4Z9to2SP1rEfx4IDoCZFQKwE=;
        b=vvYNYGf4xwWAId1A1CpF9urKD8ypGwa2pJsafP2Nu7scQnG7b/izRBx9dThuNUU4y4
         cOb19/PIuFNHl2+WOoGTip2PLECkGKmTWn1pkbRMQnrGQhcwyTDQun5VSNbMcT8IWsM3
         eTRUUP+qT+slRaHc30NyP71/tWDH8ITM2oPRH1Nqio4AfA5HsiNvAt2raeD7G1Fn+9L9
         SIcOj3sficKxKnSfDFSTrQSty8mpNTdVd85yHpJ8E4noL4+K1LYfevmXqF9GLpXytr5P
         uf8rnx4JnO5vOioXNeH4d+7exM758FSvATa10gL5vFgnIJv6ymtieTLI4Qjg0ztHjMSM
         K60A==
X-Forwarded-Encrypted: i=1; AJvYcCUQj+KLlQ9I5kJjycO3WAIGN1lCDUHa0AHnVnaRZbMm2ayPqj39niS6cJbLSpxQDV8Yqs0G61ID@vger.kernel.org, AJvYcCVObuSW0XmMfIAJJWhsFgPM2RPeXjSG45omgibtX1r9tV2xrICrV8LTpvq7LAArIEzgqaoJMliVXDCQSBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1NBpW1Op3Ls3ge/dMThqewCOvLDg4bVLr/uIXZ2UKiDfrX/OX
	mBLbAUNokwW0yvUuOq3oTSr9ozVAQF4qqx3xon13Qbpa4zJamopa
X-Gm-Gg: ASbGncvP5oxMvh7bDfhxqT0Ji6mgzqr6teiAa7WkGTdWk8O5gGWvUoIUFbIjA/XmLsQ
	WYtUYvWLH5jcO+U+IYRwqfeQGXOlTNvKmcOQz0E1pIKDaqAaZ7JSbq9LEJd3glL6mTowAFx0XCu
	Lg6UIlESYZeud0bwUtMcAQhgRuFG/AKLs1sd8Ya3VkAVg7xvTHXp7ECIil0ruoQmBrB0LyDLVc7
	0bk4B+BoBkHv2g86eN3wdVOU4bRtVHgse2oro8uqoVtC44ynzXbALuGqfBCgFR4WYlQjgLGv402
	A1+1Tz0NFmLcMdLgO/Vyn/7juaJleyrjfomRKf0BxTaSkLHhT3sIcWxjwCFTBOtGkcuPyDLrewp
	Z/mEChdUXghL/8h4YGyio0xs1bjwMSfI=
X-Google-Smtp-Source: AGHT+IF+X3s/+j/bH4Ir4u2sBQ7YQHvm8oQ/bbO3cAsu+okzmktZT1hFzu6w65mr5QVvFL19LQNe4Q==
X-Received: by 2002:a17:90b:4a04:b0:2ee:d63f:d73 with SMTP id 98e67ed59e1d1-30531fa18acmr8077696a91.11.1743294960613;
        Sat, 29 Mar 2025 17:36:00 -0700 (PDT)
Received: from localhost.localdomain (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3051cd7fcc8sm1846368a91.1.2025.03.29.17.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 17:36:00 -0700 (PDT)
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
Subject: [PATCH v2 1/2] serial: sifive: lock port in startup()/shutdown() callbacks
Date: Sun, 30 Mar 2025 09:35:22 +0900
Message-Id: <20250330003522.386632-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250330003058.386447-1-ryotkkr98@gmail.com>
References: <20250330003058.386447-1-ryotkkr98@gmail.com>
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


