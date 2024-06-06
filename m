Return-Path: <stable+bounces-49924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BD38FF591
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 21:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69B41F25448
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 19:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9727971748;
	Thu,  6 Jun 2024 19:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b="P4LKfkuu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F3645979
	for <stable@vger.kernel.org>; Thu,  6 Jun 2024 19:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717703915; cv=none; b=rOH/gcVz3fTrSmbgVhuMmQ6j8L0BHcvQDXrjb4Pg+PCbtxaWQaH+VNWc7NOAH1gdRPeFYbjvbmthMvU3+HAkjAjz5KPwD5xXGEIxZU57HGg9bJ2qA2j2Vzqy/xU4TmG7rQZENgh5GkodIJZGw6OxAXHfB6Lu4xIN7Cu1quH2CaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717703915; c=relaxed/simple;
	bh=skqVWGCzgo9ma611abjtaugTbbDm70/JjjTaxlkXm1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vmw1iZ4acJIIDzbrkEOK7CWrDysS6v65VX1spZtfbyP1LGrjiRT8Olcz8cwvbjhfWCxszVq4OBuIEb/CzZDymwYzKUSIq1vfRBSmOu+0KLtxIbw/bsZvEFlxwP86/B6HGWD00cMgdiUJkbzsGxusKmqEFiHp//9BnEXaH5gBMzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com; spf=pass smtp.mailfrom=schmorgal.com; dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b=P4LKfkuu; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmorgal.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7024ae1971bso61788b3a.2
        for <stable@vger.kernel.org>; Thu, 06 Jun 2024 12:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google; t=1717703913; x=1718308713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhCrgBpdzAke7VNUV68QTusfCqXgr2XrKc4HM00cRt0=;
        b=P4LKfkuuq5W51aYf8n5QbPXkB09fm0NUkiUVMzZQNr7fp2m6xWAso7c0FFVD6ZB7kj
         aJOtfqjFWTeyHat1PnNYjheWqSWTlVjGeN8/3GygMAJyrsnsDkVdUvIvqkTcCcsZRqwj
         MHI1zJfqt1lSCvzXkzGRz5lQDoQHACwQAQDps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717703913; x=1718308713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhCrgBpdzAke7VNUV68QTusfCqXgr2XrKc4HM00cRt0=;
        b=qNspa9vt/O9XBwJQpimX/pyhtkTrE9Ohvqel5F6jITDH7QyPBIEAqRPXRKv9NL+B92
         bo3AFTsMFwlLiejcyRjCYa+xh1emf6CqFNZtfb8ouiD9AcFDubChuAUxukklkAAh8bmy
         DyyGeBWtpyrZ9n8sXlYDP2i2YD4yPXyKndjR4K4zphlq4lEAhMkSzoEUH2Z2sFNsPg35
         vDuYKdhjXOjENBFidcVLTSYVqBq6r/QPY7/LFWJgupau5dlwRrBDNExSBBjO+kOCLumC
         CE1JTc82ZgooV379Op1iD++b3fGvfr1H6QWWnUz3tBEs7YP5pZEBfIjgiWZdZMM8X1nB
         1Y6A==
X-Forwarded-Encrypted: i=1; AJvYcCVFr0Ojzexh5DxhUla8hro86xKJsPh97Tmj3tdVVY2T+3Rr7IDuHuQLqUANkhRAnxswE5perVDVKbPde5mqWZRQ/jHXbzld
X-Gm-Message-State: AOJu0YxzmKIK7yRQb5SQiDwEeepC0lPAnOVhju38VpZ20zKgUlXnYT2d
	AAMKPZkknhzkV7Fsw03tSGSgXLBmswYE60kRuF2++Fgy4RpBEk6ml1+JjY4LMFE=
X-Google-Smtp-Source: AGHT+IF7Ftlwe/U4NDtIPz39i7uTg5EUekjT2xSqVdbcRSCmGjClmjOuqdckU5olHmr84Y1emnijAg==
X-Received: by 2002:aa7:870e:0:b0:6f4:9b4a:aba4 with SMTP id d2e1a72fcca58-7040c739b89mr461133b3a.2.1717703913066;
        Thu, 06 Jun 2024 12:58:33 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.37.206.39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd394f20sm1446787b3a.55.2024.06.06.12.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 12:58:32 -0700 (PDT)
From: Doug Brown <doug@schmorgal.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Jonas Gorski <jonas.gorski@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org,
	stable@vger.kernel.org,
	Doug Brown <doug@schmorgal.com>
Subject: [PATCH v2 2/3] serial: core: introduce uart_port_tx_limited_flags()
Date: Thu,  6 Jun 2024 12:56:32 -0700
Message-Id: <20240606195632.173255-3-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606195632.173255-1-doug@schmorgal.com>
References: <20240606195632.173255-1-doug@schmorgal.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonas Gorski <jonas.gorski@gmail.com>

Analogue to uart_port_tx_flags() introduced in commit 3ee07964d407
("serial: core: introduce uart_port_tx_flags()"), add a _flags variant
for uart_port_tx_limited().

Fixes: d11cc8c3c4b6 ("tty: serial: use uart_port_tx_limited()")
Cc: stable@vger.kernel.org
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 include/linux/serial_core.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 3fb9a29e025f..aea25eef9a1a 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -850,6 +850,24 @@ enum UART_TX_FLAGS {
 			__count--);					      \
 })
 
+/**
+ * uart_port_tx_limited_flags -- transmit helper for uart_port with count limiting with flags
+ * @port: uart port
+ * @ch: variable to store a character to be written to the HW
+ * @flags: %UART_TX_NOSTOP or similar
+ * @count: a limit of characters to send
+ * @tx_ready: can HW accept more data function
+ * @put_char: function to write a character
+ * @tx_done: function to call after the loop is done
+ *
+ * See uart_port_tx_limited() for more details.
+ */
+#define uart_port_tx_limited_flags(port, ch, flags, count, tx_ready, put_char, tx_done) ({ \
+	unsigned int __count = (count);							   \
+	__uart_port_tx(port, ch, flags, tx_ready, put_char, tx_done, __count,		   \
+			__count--);							   \
+})
+
 /**
  * uart_port_tx -- transmit helper for uart_port
  * @port: uart port
-- 
2.34.1


