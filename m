Return-Path: <stable+bounces-128364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD606A7C7A1
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 06:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87BFD3B31B7
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 04:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1491AD3F6;
	Sat,  5 Apr 2025 04:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GflzerBU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB9B3209;
	Sat,  5 Apr 2025 04:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743828255; cv=none; b=VTlBYaGAsx2Kopq5XlCR6ueRC/eCCwuud3fROLXpf6H4VOnQ7zZ4ZV4YQ923XYAhwMVl5/e7vsTbSxpoeg6v073CaGGuU1fwsdThRUd2R2ayODA1vl+pa9idlll0mVOzDryMBT8uM60c2Tl7ihDiYF9/b9IDhhhy+FHWil9mU6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743828255; c=relaxed/simple;
	bh=ECt91EY7sdi+ZAZgpiRGsq2myEddr0gF5Q/4CRaCPSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GdvrW2zuD8D4OxZI9J2e6tx3ynEL4SS+fjj1I8jfwcphSxaztvRsLv15ykGxdlVVIpO60zoMZ6PItlUN7yQBK7iol5ddO9rc1iDf7Opkg1Tyam+So7emxgxH7Jrto3PExL6uncZ0ceLTDLyFv+gc3byeoh/KP6UJ2PrqDBVyg0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GflzerBU; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7394945d37eso2278167b3a.3;
        Fri, 04 Apr 2025 21:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743828253; x=1744433053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bOkg965odz+QE9cKXvYVRkNTxhqTHUa1qzYcFa9wPk=;
        b=GflzerBUUFahB2xxCzC/pAFn8RTEtbsVca82RV5/bphc1gC8fpxfhg17zmolZ8MTpK
         tVsvjwat8U6Bw3DgIIi8+8ZHTAAmNwEzVhp/qjl3xshRKw5rW26kSy/LQRYhsP4u8DT5
         riCt3c0IhBxHw2pBcubefoaOlb34M4mkor6Z7UvZtBgvy+npuC2ThrIKxBj7yyMQiiIw
         bbXE/IIL6/Gye5ZZfnFSsW9zN/VRFsupvIXoyJLLNLZJgSsjxn23mSvDluMwKjmZDNgm
         3EhSjUmTWLHVv22yuOrGJFnhRv2grsCndTwZrXtKLhSpG2ZZWh8QLzZiglvVQGr7d7Ec
         XsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743828253; x=1744433053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bOkg965odz+QE9cKXvYVRkNTxhqTHUa1qzYcFa9wPk=;
        b=h1PJW2YPYg9PxNuz+NJ1EQIk4ihxzc3tVi/BtxZWJlHkPQvpwWxVS8Mdq0deNf1kOU
         7P29ie/yi2d3g0Okg4mKshvv3/GViU2QmL3ITVKnJXUtpvdE5P2LAMV29KKd8QDTVewX
         1oQYivxt19F9GFk8E0DQ+wo9Xyyn7+1ExE9yr7DcVKeqlYRLrHb+HC/SnTtdp2QgCrVr
         yEdG8KeocEDULi+bqlMgCPkhniid8a7R3y9KNeKrwMzBMI2n354joY0u0EkSQiMPubfL
         bwhVZd5tLIi+rrkz6oX6h2O6EtnKbSMnHsMwfIPpj1QftgCfMVdlVifdhrRYJj/bI0hf
         ZkRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI7vgpdW5Ua1at5n8nPQnQhxIOIPaLEbf+VBYewHd9791v9h38F1U1J8LmlMJGrCiAXTKFpn5o@vger.kernel.org, AJvYcCVb8aktieriFnyz61emcCGKzTRLzcsTWcq5GdIfRp4AR7nuvBXJinEaF2Owm5cCN257uAzlOuhvLmDRCN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOa5pu+C4MSECPPi0OoACJ6qsASgSf0pY6i8sHUKK2AJXu0TSC
	GuNbix3EmNTGsF8CzSJF1M7y2R+HtuhhEc8pUC632OZew/bg+Y/C
X-Gm-Gg: ASbGncvbXEh6SS0zJEDxTzLue9fX2qWlknAEK3DqNQzaovOE/qjkuAV5WokFIceWz7K
	FmIk/MauuiMcim+B+lhEc08YjpB5Zs5UWnHpVIdzs6qI+k811ZZ7pm2Ofv5DMKbXui0hBTJvYr2
	OxpuUfqIBWwAV7l1zyegXtIC88cL5f47pGK7OSvfmdWfxIOBJm98XZmaF12T+FMRVHGSTCo+JXa
	j6oeX6AdpI+SuO+qRb1sdcu/ge21ea03hm75Zj+6RLGKjfKwP+tHflEppwPsYTpd3E2M/ezOzLm
	kX8PJv1KuEEE7SSFzVP7ho/cW5h/Fih/kN5YKTOG/ofypz9MUZHSUq5EK5GyRF/xlZAwtDFRgaZ
	ayGXmDhnE2nq4DYgu3uDxzJoqVCODcY0=
X-Google-Smtp-Source: AGHT+IH6x7bxx7g+YFTtM+ge7TYGa+a/bsXzLkrOIrtKg+MV0AgtjofqDOvWHcwFk7z0p2vkRCK1/w==
X-Received: by 2002:a05:6a00:1414:b0:736:5725:59b4 with SMTP id d2e1a72fcca58-739e47da9cdmr8628640b3a.3.1743828252726;
        Fri, 04 Apr 2025 21:44:12 -0700 (PDT)
Received: from localhost.localdomain (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0b4317sm4486035b3a.148.2025.04.04.21.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 21:44:12 -0700 (PDT)
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
Subject: [PATCH v4 1/2] serial: sifive: lock port in startup()/shutdown() callbacks
Date: Sat,  5 Apr 2025 13:43:38 +0900
Message-Id: <20250405044338.397237-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250405043833.397020-1-ryotkkr98@gmail.com>
References: <20250405043833.397020-1-ryotkkr98@gmail.com>
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


