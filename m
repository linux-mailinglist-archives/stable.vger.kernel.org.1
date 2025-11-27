Return-Path: <stable+bounces-197079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A3AC8DBA5
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 11:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57EEF3AAF9A
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 10:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A06B319871;
	Thu, 27 Nov 2025 10:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cKBSUoLn"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A319274B37
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 10:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764238826; cv=none; b=stFJW4hHqc4fsaFXaptdDUjVjPXi9FsC+2fKzrRcTKIno5F+Oy1c5cvpUYcv8YZcWuMHhZIis1IsJYy21bO+TrfIOtHIZClEn2EZ0+RVem5UNatBS33uCn9bhB9ABlUeLNdmAeqbZtqIH2I7K+XHcPJ1q75ubq7TMM0DMXoDFoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764238826; c=relaxed/simple;
	bh=aWy9b2WniteZWbmAgQNdLt701CO+AWxD/PpU6c3KdUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rLPr+lrhewK7yyEEy43ILY36vM7LQD3mrBURhPRUQnm+/yr6hfDTybL6cTrMqaLdjaFK+MRsr8Zsb+4IcXnWq+TzUyqKYc7GUut5lyj/DbEHlCwzcUymc33SD/mV2zrCnHXL8NAewFfUCvmVFf+PwIIrfRR2pzVPMTPN6y1S108=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cKBSUoLn; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64198771a9bso1398116a12.2
        for <stable@vger.kernel.org>; Thu, 27 Nov 2025 02:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764238823; x=1764843623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WXael2kskO/3R1ZxQAzOYQw/gwekIyPXo028Fn8LRLY=;
        b=cKBSUoLncQ3XyAA9Ghh1iXVAGiTjMGKBDTMLOMp5H5MRp/J6AwQMjHgSMyvvzYs91z
         W9RuQCICtYcQvwIyj84g4d1RkXF/VvRPqieCKwfBbQmi1+QlIxpM4IjGnpREWC1bIOPR
         2MsY/s31gd4VPwaihGgUYLTy4E3aw27KkFI+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764238823; x=1764843623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXael2kskO/3R1ZxQAzOYQw/gwekIyPXo028Fn8LRLY=;
        b=gqpBTCASvBZXixrHkRKe11aMWKoyUzo/VDTI2z/NpiRRZnU4pTEj7MaelHHKw0hB4e
         U9QOdjS+q3xNXWkE94mYv+cHylgPXSBhS5z+TAdvZbWRf8iqs1zIS5X0sT4uDaTbBzGx
         PRrhS/cj4QKxf5b8gezwyI6NnD1Rh9vn4nVT2lGaB4Gd+f9kK3RP9lHfqA7jsrsJ6vYR
         hQY+prjkgeat/lkuV7FMXZ42lX1lbM4kpJV7BUFzCAWp8cigjJYAQlyJsSQImVM9WwCQ
         YR1pfUeeql5nTMTCR5IymLa7mcX8qCzwkoc/8jeQWOuvpjlduTt/kc/X6vENDxodAdHT
         3MVw==
X-Forwarded-Encrypted: i=1; AJvYcCWeDhhWmOg3eoVKYecnNJGoa9d0Gl3jzj+eQQj8Mg4M9hM7eIbk5EUNYYe/4SJoPQo8XaCtJBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB3vW7CWiKPJdQpe1s5BoLlrEfS2ftFpizXdKHnGUwZBr8Inja
	h1ShzGXfH1wSAz0q+6+s2HLhiSP9Yw7sUlvYKUIHI0ttqf3wyR9LqF0DMwYFeD1D
X-Gm-Gg: ASbGnctD8CRhPDS/rRYQe0x/yQPsyWuDQK4155sdT9S46mn/KH1gRw/aicHF890BjuU
	IaDHaY41Asi36gklrJ1DTwdxr0JaaoUBZeeilENkHe/2XhBNWYIgiPs4drMjQPPhEGCnTRyGAXy
	3ht+rU+LUaHiGQjYLJ/mIfr1WijICwZIwZX3fGHU3pPMNYR2bTDaWOEMMjJn5jJyC9q+S38gPjX
	hpRo8AQGPuY5ZAl8Ne0WUXC9CTjCShij//5chqJLYWis+Kb1hGtJ+BC+w35AmSS7uIyiMO6kfF8
	2bsL+1DRx1TJBLvzIM+958iF69pC30/puBD6YE1rGPUJFF93RBq3o8eXo9YTLKA0gWqhFzSgUBp
	yHTqdEeVAtsvc2rWg+dCSddiRDtR02ScRfJ8NGqxWh3g7h9Yo6HYcHBeXnje2STPUr83/CPmqHP
	E4otCNh758b8bDaJs6mDanX8jDIcWy9LCk/hvsTy7GfKI1r+oEUesrr64v7yCNHAM=
X-Google-Smtp-Source: AGHT+IGELg7kvkOexg4sKdSKB8OuMlycie6qkcLhO6MRMl9ksPcVgTqDyXpKboubGU2fnS9D15WSaw==
X-Received: by 2002:a05:6402:510b:b0:640:ccb0:f4da with SMTP id 4fb4d7f45d1cf-6455469bf9fmr18707107a12.29.1764238822812;
        Thu, 27 Nov 2025 02:20:22 -0800 (PST)
Received: from januszek.c.googlers.com.com (5.214.32.34.bc.googleusercontent.com. [34.32.214.5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64751062261sm1289411a12.33.2025.11.27.02.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 02:20:22 -0800 (PST)
From: "=?UTF-8?q?=C5=81ukasz=20Bartosik?=" <ukaszb@chromium.org>
X-Google-Original-From: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@google.com>
To: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] xhci: dbgtty: fix device unregister: fixup
Date: Thu, 27 Nov 2025 10:19:04 +0000
Message-ID: <20251127101904.3097504-1-ukaszb@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Łukasz Bartosik <ukaszb@chromium.org>

This fixup replaces tty_vhangup() call with call to
tty_port_tty_vhangup(). Both calls hangup tty device
synchronously however tty_port_tty_vhangup() increases
reference count during the hangup operation using
scoped_guard(tty_port_tty).

Fixes: 1f73b8b56cf3 ("xhci: dbgtty: fix device unregister")
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
 drivers/usb/host/xhci-dbgtty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index 57cdda4e09c8..90282e51e23e 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -554,7 +554,7 @@ static void xhci_dbc_tty_unregister_device(struct xhci_dbc *dbc)
 	 * Hang up the TTY. This wakes up any blocked
 	 * writers and causes subsequent writes to fail.
 	 */
-	tty_vhangup(port->port.tty);
+	tty_port_tty_vhangup(&port->port);
 
 	tty_unregister_device(dbc_tty_driver, port->minor);
 	xhci_dbc_tty_exit_port(port);
-- 
2.52.0.487.g5c8c507ade-goog


