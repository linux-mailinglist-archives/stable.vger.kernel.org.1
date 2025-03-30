Return-Path: <stable+bounces-127013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2C9A7584C
	for <lists+stable@lfdr.de>; Sun, 30 Mar 2025 03:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A961888624
	for <lists+stable@lfdr.de>; Sun, 30 Mar 2025 01:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A28B664;
	Sun, 30 Mar 2025 01:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKrV3ib0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0613F33FE;
	Sun, 30 Mar 2025 01:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743297425; cv=none; b=r8hT8PsexQRqQxtwlxbcmJXbUTUauP2VQ7xiENPYz6Lxw1Geybo5t8U1wM6Ut8BQdYu3iOUriqkpfS1NkmLp3+q7Qf/6YbaxnORHua3yGkrSb12qtp8SU3n6NkzlEkI5qBvWF+PXf779tSsVtjQ6q1Ug7O833CrZrgdp4zN9xAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743297425; c=relaxed/simple;
	bh=JH5PhsEjqUV63zXAEJGLPDt8Og1iMsdPVSrpr74+ndc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UwgqSj5l7vqQa+GvbyeItCFMzUAMD9vH2/iwrB057mFsDykfxseyVbhcJe+EKWuWoFz6nVPkNSMu15WJG0eF9kkhJIgWnmwV2ZWggqYA1/BfrLLgmyQNaqhhbuKlj+OtYhLw/4SU4pFpxPIeW5YiASCZcdmWMm+OOYybeHkb7lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKrV3ib0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223f4c06e9fso63442855ad.1;
        Sat, 29 Mar 2025 18:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743297423; x=1743902223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovcY3FlJhLAlcHfJCYvAAuLol4KahlQ6od7r+edeYnQ=;
        b=QKrV3ib09kCrHp9RxL2yCzKyodJ8gZdpDfZzPO9cB6DQ/tAbOrsrAClyev73IzDvta
         FhkULTk96stKLBYQIdAg9GUUXrxYSekdSuzzq9PtqKihsVFNKN3g+kinMVoX/NjZdCa6
         pOq4lpLupp2Ev+I6XOryClgPsN0ydrhFD7nYN6VY8Cqkq+iC0CMM/5+QbTMF5iMzCB4D
         oCllrP7i58iwNYgNXzty9CiuGCK0ygDgfc4apLIghr0ya84ddKwFZkSlu2pl4Re/Pz7h
         pZUKgVNyd2CuhvpgSVKzCuogH4kT5pAWGf9OO3it93blS5fwskuaS81e8fHnWEa08rAY
         bZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743297423; x=1743902223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovcY3FlJhLAlcHfJCYvAAuLol4KahlQ6od7r+edeYnQ=;
        b=jPzheD+mRU+Is0/2k4RtJAvmb2nDim5nXc/eELD1NM5aVVc++XzLN3cDQZJqM6YZBM
         9EM5UpOXgB/xQtat4TWzexbFJpqWm+4klArFka5mwIiuio4d0thOvAdUOkVQefDzeltQ
         q1VliRSfnSCU4Zu6SI+DwMjfxqCAdGRB4LrSaUfdAP19C5dGzc3ekucPnr26O2aCGKUH
         aKDi3QDFyO7CAuWJ3nYJroU7KeTaPSfUT98P+83THby7f2DJlEU+g0Ni8muvJCUPYmic
         aSjieTie1eVQigDbfOMcoYdD1GeDYE9eyK/8y34naaIMRSHv/bI/mEqWeaO3CF336mKx
         H1ig==
X-Forwarded-Encrypted: i=1; AJvYcCUMa4XEMN9IyF1ePW5xL7UDF3CR53/ycVfyR56omHoTUZ/t+eR/UJ6IN0W7n4z+JtMXM0jNG+km@vger.kernel.org, AJvYcCWNxRMGaeqKN1O3YzBCa2gyMG4MURBhfaQBkrZbUu7SODX3o5yGpM8kC3Zj1IM0QazTTB6OaYa920LVzyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6xLkoN+LXGhGh8UGaeU3mykVadzxbORbWbKbMCRW7UxqM2Z63
	IsBsnbGmAZ7IKQjgIFZRnMGbUKmkja2/iVmtMQSnBH15LclvWGDw
X-Gm-Gg: ASbGncsvkpZCr/YJlB41T07l54pe9QszF4weaxxy9yzHqhp8kOw8HdQXQFNmY6ZLfqB
	jNePIucprduBdcXOvrBfa0u98LmIV1b0RCtBoPVRhYAPHx+KkJeiam/0PwnxaJAIqxk+PNr5U1t
	N1PdCBjRqbtYKN52YmpqFc4om4cnEApvnxwsteptR44fnQwkeHmsqdQKisxZKkPPBVPXvdfbne9
	8wSAmfQvMHEUbwTe2LI1kDFrYZWSyedpEndfB/ol7HHk7fhqKjG+s4il8VYCI/G9GVHPhDDgVe+
	82zRViqYXvvTAGiy6uo7lMRrjKVZrNna18J05FYytWPrxLpOxqN4Npbko+TyOdo2BqJK3CB9WAK
	xQU0zIZKFH9B6cIQCB3Z5glpEcFI4RfE=
X-Google-Smtp-Source: AGHT+IExY0Kwk0LiQcVFg3q5/x15pk5JiYTn786iSOPSIwCtGaKXfANA/cjX9M8xUqFQ2DVybK8rug==
X-Received: by 2002:a17:902:e5cd:b0:225:abd2:5e5a with SMTP id d9443c01a7336-22921c7af8dmr108875945ad.4.1743297423271;
        Sat, 29 Mar 2025 18:17:03 -0700 (PDT)
Received: from localhost.localdomain (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eee210csm43496455ad.70.2025.03.29.18.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 18:17:02 -0700 (PDT)
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
	u.kleine-koenig@baylibre.com,
	lkp@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	stable@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	Ryo Takakura <ryotkkr98@gmail.com>
Subject: Re: [PATCH v2 1/2] serial: sifive: lock port in startup()/shutdown() callbacks
Date: Sun, 30 Mar 2025 10:16:10 +0900
Message-Id: <20250330011610.388077-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Z-iSb0ryR-tiUCj0@42be267012b8>
References: <Z-iSb0ryR-tiUCj0@42be267012b8>
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

Hi,

I'm sorry that I wasn't aware of how Cc stable should be done. 

I added Cc for stable but please tell me if this patch should be
resent or if there is any that is missing.

Sincerely,
Ryo Takakura

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


