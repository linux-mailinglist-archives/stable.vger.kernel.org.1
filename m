Return-Path: <stable+bounces-208026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 52926D102B7
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 01:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2BC33301581E
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 00:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A23286A7;
	Mon, 12 Jan 2026 00:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iwell-eu.20230601.gappssmtp.com header.i=@iwell-eu.20230601.gappssmtp.com header.b="gt7928dy"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B62CA52
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 00:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768176655; cv=none; b=pvelhWL900lT/Ou4kM61pT7qmiOy9Dv99Uf41Sbdq2bhxPc8IAFqIUc5p6UK/uvcgUW3oYaVh9X+lYe6J6p/MfWS37SvdQMwASGwEelWzZo1EJvkA1hI+wbYI2LlvdRrVdkyZ4Ehdd9kg95/3AEvwMbeqROIFWiqraVxZvccr3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768176655; c=relaxed/simple;
	bh=kvCyYtiY0v4R29B6n0ipmfjn2WIRYvvpJMM9B74Hal0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TY8XzTHapHvjvPelsQZsmo6v5fh42pb8Yqy/uCDiRGVpn3eZLu/6yMQvNPjYNH0gMob+C4jJNFKLEqLKQzgXDQZoc4K8hvY6RP1NvJ1+fEg5CFTmqpvc8aSPt2dWS6uRIY6geUL0pxaIt/Vc/EBzXfP+3gBkTFgKZ5fhC9Rxdcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iwell.eu; spf=pass smtp.mailfrom=iwell.eu; dkim=pass (2048-bit key) header.d=iwell-eu.20230601.gappssmtp.com header.i=@iwell-eu.20230601.gappssmtp.com header.b=gt7928dy; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iwell.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwell.eu
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b7318f1b0so8240946a12.2
        for <stable@vger.kernel.org>; Sun, 11 Jan 2026 16:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iwell-eu.20230601.gappssmtp.com; s=20230601; t=1768176651; x=1768781451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FkBh8hOVItHXrECToFozYAl6O6uqbPqcIj68J5rzzDM=;
        b=gt7928dyB8dGaJbyaC+uWldfVARj/qgBeJ40DbQFfwLIbZxss4avrY3c3BHqledAKb
         E6s1w6QVdxQzd8BQWJCP02yAsEEVuMScZfXBCBrjLBQ+Ok97yvkgpX/IMvbvKmP2VDi8
         0IM5EEktQAbCOv98EfTz+NA4eE+hg/3wPyUWYsCzVaG7jADFy3nU4c/qaM9xuk/4viYe
         z7gwZaF46Avd1waWnepXuAA5md2MVmuavL0IVCV1QAtxor24N8+jOvNm+5HOUPG7dY6W
         2pxXQOB3H95ckuqUpiMpm8nHF1+CWgfmAAgDqeq/AnFl/N4G0os8kE4hmuZkzRTtFccj
         +Low==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768176651; x=1768781451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkBh8hOVItHXrECToFozYAl6O6uqbPqcIj68J5rzzDM=;
        b=MEkYl4uMk3ve4jcIgPAmL7m0d80Rr6j+X8i7Gnou3gTjRSfahHt+PXrNvYjSlQKC15
         BysWMU4GaGLxFNYSqVZvRD65svwie5/V4rN6qKv87wfY7EmVWxkSwZo2PSFAP/OJXGla
         czZ4a63afRwTYKECk34yTmHenwiUxXpfe/nFmvib0Boq2syJY6Rp4NQXIEhJjMxWoN8g
         oVQgpwSlsAy/Uzj5jYFngHvKxZVbWFJWSZ7LKkLZST4YomCAnj42Ahh/iREEApK3uaXd
         dBSGZTiZUJ3mkL6BmkdcIdsxBNq92jnS5AWZsjTd7qvD09EbQ1k1mnnJWhbYJYhrzBkO
         KU5g==
X-Forwarded-Encrypted: i=1; AJvYcCVepKU/9/kwiMNgkywkGBZzapAKBh7Vn4hXrfDTNEaXOIrF7QHuwEDBFuh53lY9/7T1DS9AgA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxERpPnui9i1dtw/SXIpntNcGvwcF6Nnq/rDx9GexjGHL4c4UNd
	Kf62woKKUiMCDdMUQIL9GOfy41UQLQ5h8V2ZGxe088w61+M0NW4zYJglt9ds64ufuOTQZzEq2zt
	LuyWRlJI=
X-Gm-Gg: AY/fxX5HQ5+Xulb/imVVlZMBvrW9Pl1x9oUbIqHS4CjAhCkclG9PJIBxQnwkbrKv+gR
	u94q+nEEIKtLg060KtK0WslGP5Gf252avTTpJFnwX/FPWbJZ4VEUJX1/JcYrrjs5auJqXuEwpUZ
	U9GkYtOek8w1g8FJSA3TsOVPOTi+zTMiCFhqNMMRiPLi4ayzNts8+/GxDL7kXJpLEhe169aDU0d
	ei0YZ8kvOCTnzSA/sRyA59K8rJXb8KZuMKPWugJQNF3uLXOZVchMWhMbLIEy7dOAZCd/MIf3nnH
	AQcFv6EaCXhVeAC2vdSYBAm45ovgXoX90TWfo5jDSzL/xMtyBfAtrajlL2caOnQRW/4Fd0iQviT
	UB+2RwykGArHMd4DsA0MULqjyRkaedpAOusHgrJIIetptvgfI2QnAfqYFXOOPk/mx1NFxqVIdiG
	v87AtoT2jJd8NHTI1q9MXZgDf3wLNb9oLDqheLi0f+L91pdw==
X-Google-Smtp-Source: AGHT+IGUGs/1ia/yH5M8iEeDtiuWEQc2pvZNjndbCLfMd1tYAUWcPTkr5LhD3ULnD/zcl7ZQwjXZgw==
X-Received: by 2002:a05:6402:1453:b0:650:2820:38bd with SMTP id 4fb4d7f45d1cf-65097de5b35mr16955783a12.11.1768176650936;
        Sun, 11 Jan 2026 16:10:50 -0800 (PST)
Received: from localhost.localdomain ([178.224.217.169])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507be641e0sm16003130a12.22.2026.01.11.16.10.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Jan 2026 16:10:50 -0800 (PST)
From: Marnix Rijnart <marnix.rijnart@iwell.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	regressions@lists.linux.dev,
	Marnix Rijnart <marnix.rijnart@iwell.eu>,
	stable@vger.kernel.org
Subject: [PATCH v3] serial: 8250_pci: Fix broken RS485 for F81504/508/512
Date: Mon, 12 Jan 2026 01:08:23 +0100
Message-ID: <20260112000931.61703-1-marnix.rijnart@iwell.eu>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fintek F81504/508/512 can support both RTS_ON_SEND and RTS_AFTER_SEND, 
but pci_fintek_rs485_supported only announces the former.

This makes it impossible to unset SER_RS485_RTS_ON_SEND from 
userspace because of uart_sanitize_serial_rs485(). Some devices 
with these chips need RTS low on TX, so they are effectively broken.

Fix this by announcing the support for SER_RS485_RTS_AFTER_SEND,
similar to commit 068d35a7be65 ("serial: sc16is7xx: announce support 
for SER_RS485_RTS_ON_SEND").

Fixes: 4afeced55baa ("serial: core: fix sanitizing check for RTS settings")
Cc: stable@vger.kernel.org
Signed-off-by: Marnix Rijnart <marnix.rijnart@iwell.eu>
---

Changes in v3:
- Rewrite commit message to clarify problem
- Use longer commit hashes
- v2: https://patch.msgid.link/20260111135933.31316-1-marnix.rijnart@iwell.eu

Changes in v2:
 - Added fixes tags
 - Cc stable
 - v1: https://patch.msgid.link/20250923221756.26770-1-marnix.rijnart@iwell.eu

---
 drivers/tty/serial/8250/8250_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 152f914c599d..a9da222bd174 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1645,7 +1645,7 @@ static int pci_fintek_rs485_config(struct uart_port *port, struct ktermios *term
 }
 
 static const struct serial_rs485 pci_fintek_rs485_supported = {
-	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND,
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
 	/* F81504/508/512 does not support RTS delay before or after send */
 };
 
-- 
2.52.0


