Return-Path: <stable+bounces-93631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A4F9CFD65
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 09:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA86E2837F4
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 08:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0221922C4;
	Sat, 16 Nov 2024 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="RkBOLz2U"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F47B18FDD5
	for <stable@vger.kernel.org>; Sat, 16 Nov 2024 08:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731747320; cv=none; b=tJFQNAKHo6AZrXvgW3yAFDOYoV8uvCBuxly/SniMbGLNbWbXOYUpKDDfL1iSPg9j4QEHyjk/Tp+/uaajWr+pJfuiFm+D3M1fCZVmLXGxtyUyYWVdwsyZ+FuF53UJo2DG7nvUxuEhcwRPOjxOH1eVN8JvNyFqYaL5YFsc2yFuh3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731747320; c=relaxed/simple;
	bh=9bSkJer9TO0x5cLRPGif1lABerNmnAmgJ1nQXQT+9us=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P9UaUdgulU+WSdH6D2qC8+tqDL3qtdMNdOKEAzJ9u4FR6dOivTtHZl/p74EZ0uANGRMi3guNvcFWgj9yWtFGGYeJ9eU0sA8SCGtdrdYASSwndkxIF/QurQu3CAK3m2jkAXpxTqj8MJ7eflYteqcy9YY3RZj99Fnk9j3QfDu03a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=RkBOLz2U; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c714cd9c8so2769395ad.0
        for <stable@vger.kernel.org>; Sat, 16 Nov 2024 00:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1731747317; x=1732352117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QfGAQfgPppCq2YiD6ICG6LYvGNaSaL/5bbCHwooCkBg=;
        b=RkBOLz2UBwAQtVmOBwyNonl3H99CyUcIdiOECVBpJWpM+Irr4OBp97HrAslai2Cn0P
         jtFeAtcWbY1oh/03HF2rncx20wkTXSgafveF7i3M2zVVGuYXEJlP5G7VDo5+C71AIc+g
         v9ZIRPSW0QDtHrvP38IVvnNEmv78o6s7QPXJZ5AKBb7VuqgAaxYpMsv8VY8iCG+YZZlk
         xZ2/k3IELW6lZvkJmUOrVx5PxeKlIacGr10fjqu2S514gb/S2Al0ztY6eDkn8CqxUQAj
         swZ5FGIwjcCLNJUDsgKT6/Et+Fuw6dPMAi+alwPVx+xKk5ca5LbR7yo3nV91GRb9YHbi
         7VaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731747317; x=1732352117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QfGAQfgPppCq2YiD6ICG6LYvGNaSaL/5bbCHwooCkBg=;
        b=SM/CLWIdI3JAk3RRw7xHxPmQJWdZgN6QAGQ/JgVTnrZ0usyCJXxPptZufLiCQKDNzG
         YYXMdZOzhcF4PW/c0BzEWAXl6ynzR4iyCc++JaYjqcmK0i0eWtK8+3ggXplk4CXorntO
         DLxPbt/OnAqc6DGCZsb55J4a1yHXSWZpTeVUslmSzav2edAUSIXFbtoVcOQ1ViJzDxMH
         imCbOYOfEp5Pi+L7kPFmjZzw/LHBRtaRE8XlLDS1Da03UD1/xkcxPsd6um9SgquoWeSU
         QZXp3NClJkJOixgs+b6Vky4X346x7MRIPpA7nJL0u9liH/iPLe+bjbcqCE/4NBI0D2K/
         cPbg==
X-Forwarded-Encrypted: i=1; AJvYcCXTsZmXHNxC8ogKJnjzY+2AhcHum0Tm0lRTNlaD2ibn057j0AkfvKqDL65XDOuES++S7isuRjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YweJ2a68PAak31utkEOTI4PyCpaVq6WSkyjXvI7neEUFcdxqhoS
	cLn3u7ujooHM5zsQDWPj3FFVKUdMQEo3DfKjsM3kmaggIPiMODFyQwIVnNzlHGRoy5EMbZJxnhu
	v
X-Google-Smtp-Source: AGHT+IEX5SbnXmPwteCLfJBW+zv49vP3Iy7yPK8Hy6/jJp54yDb9UC9a4hQKHyJ45xNSELBqjoOAsw==
X-Received: by 2002:a17:902:c408:b0:20c:8d7f:8fec with SMTP id d9443c01a7336-211d0ed9f17mr84865095ad.56.1731747317569;
        Sat, 16 Nov 2024 00:55:17 -0800 (PST)
Received: from localhost.localdomain ([2001:f70:2520:9500:2c80:c37:9141:9411])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211ec2d47bcsm9077385ad.142.2024.11.16.00.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 00:55:17 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: typec: anx7411: fix OF node reference leaks in anx7411_typec_switch_probe()
Date: Sat, 16 Nov 2024 17:55:03 +0900
Message-Id: <20241116085503.3835860-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The refcounts of the OF nodes obtained in by of_get_child_by_name()
calls in anx7411_typec_switch_probe() are not decremented, so add
fwnode_handle_put() calls to anx7411_unregister_switch() and
anx7411_unregister_mux().

Fixes: e45d7337dc0e ("usb: typec: anx7411: Use of_get_child_by_name() instead of of_find_node_by_name()")
Cc: stable@vger.kernel.org
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
Changed in v2:
- Add the Cc: stable@vger.kernel.org tag.
---
 drivers/usb/typec/anx7411.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
index cdb7e8273823..d3c5d8f410ca 100644
--- a/drivers/usb/typec/anx7411.c
+++ b/drivers/usb/typec/anx7411.c
@@ -29,6 +29,8 @@
 #include <linux/workqueue.h>
 #include <linux/power_supply.h>
 
+#include "mux.h"
+
 #define TCPC_ADDRESS1		0x58
 #define TCPC_ADDRESS2		0x56
 #define TCPC_ADDRESS3		0x54
@@ -1094,6 +1096,7 @@ static void anx7411_unregister_mux(struct anx7411_data *ctx)
 {
 	if (ctx->typec.typec_mux) {
 		typec_mux_unregister(ctx->typec.typec_mux);
+		fwnode_handle_put(ctx->typec.typec_mux->dev.fwnode);
 		ctx->typec.typec_mux = NULL;
 	}
 }
@@ -1102,6 +1105,7 @@ static void anx7411_unregister_switch(struct anx7411_data *ctx)
 {
 	if (ctx->typec.typec_switch) {
 		typec_switch_unregister(ctx->typec.typec_switch);
+		fwnode_handle_put(ctx->typec.typec_switch->dev.fwnode);
 		ctx->typec.typec_switch = NULL;
 	}
 }
-- 
2.34.1


