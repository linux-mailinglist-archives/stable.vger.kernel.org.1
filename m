Return-Path: <stable+bounces-197086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 853B7C8DEC6
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 12:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D8A334D50B
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 11:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288AD253B73;
	Thu, 27 Nov 2025 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kAxInnwr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F8D2D73BC
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 11:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764242227; cv=none; b=Suz9UZZcD0EoGz8PBm5S14wjOXRTiChi1qZiwleLnihlWF1Fd+pzEvxPdiQoPTQTtPmrYKVaEuEFNP4x1bN1N8RsfRFfDw7zw96VDjnlTG+CDEBQHhcCSy55Yy6NwVEeRFy30hZTwW2ad6BHRtyPiYMEEQW9x7/vW/fIP85I8n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764242227; c=relaxed/simple;
	bh=5eIN9fmc1QGV8trA/A9yTegASUpqMC9vmn8r3paozxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f4We82M7ohMK/0IfnjFn/aKe1pBmwJH2pZKlwwOzH+7vkmvzS6hBDnWBvVDHaSSwiK++GUOGGQO7rcY8xc2nUW3gLlBy834P6o3yRYfNgCTZkAZDh4A4oMukWjaaGF+uEj588fyguDe8F3tyVeG28Ik/TQQHjGlOm+aPG5X6jOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kAxInnwr; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b727f452fffso306392966b.1
        for <stable@vger.kernel.org>; Thu, 27 Nov 2025 03:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764242224; x=1764847024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GJVJA3oiVaBETKowUaWc1AtovR4cPiTo2+ur0NTpWtI=;
        b=kAxInnwrzrbnyQi6iANFodU1cLRlU5o8Hq3LYIw2UD02KUadQxIHmHbfu9SHvYJ5fn
         pvMIciZFq9JAAf4z44q/8yZydFiTurBGfzZ/2N3Fi7BCGCyvGtoJdCm702lCQ1YHAdrT
         BqOpHtCPLnVj7E/FsE/XcelPL/Pv4mAQKTI98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764242224; x=1764847024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJVJA3oiVaBETKowUaWc1AtovR4cPiTo2+ur0NTpWtI=;
        b=N8ihvLhx+AlRLnuPD2O5rcdUDTHmh7MjqyMEHDlYUaCDIXPKR1PVBrET2Ifa5ygX6E
         OVZ7tA4spTi52X1os1EyxCjc4MGZywgtkJ+7hAZ3kiOh1fuOyIzWrLpz2Xa+ml9+0tVs
         rNPhi5LGOAFk7RSc7zii6Y+6Js1KKcuMOyuZQEepkRJWea/0HkPxJ26Ygl816JxScgq0
         ifpXwn9g4YylIEGk7BChIi31v6arJGc5cdDgjMWedELN8nXLobtjfNInKHllAfAtzSbf
         fJsh9saYvEdBfaynmiNKgm3ZJeKHwq9njO6i0yzXLeOEPcFkWdAUyZ2Y3hPuz2u0a3TM
         Onbw==
X-Forwarded-Encrypted: i=1; AJvYcCUIfxT7L5whYHlzPlt/83erdTdTkub/ffeTsuD1vL6sDpuRBVXlPpizUAw8pAD7F/E3lN4zjGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrB5osef5d2qBdUr8Ji2TWQeMfUIoelPpdyJt/yaWLWCc9cQhZ
	5aeTc4Y1A5Naqr/Dlpd7ZJJ39myKxbJR7azsKsNrLKNmuTGWpPWMrGKYezIskuZY
X-Gm-Gg: ASbGncuvESRDGBx2qcXlmNbpHH9xdujN4+gNq5qgBDiXIxHuXViK2hDUkOHg6jRoMtv
	d3fkEFEAcRBl4uaWBinSXlbcPgM4EdsdBrpEirdcuavrce1HiIyqdEQzE6Yz3Jiun+az269xMQE
	G2cMbiLt3b7VbSlD0/GJLH5sgH1kyyj0uKIFwHJaWm7LafkdFsuDTT4v55YFc4PmSLHZPRCZ0fN
	ZgR3LY36hzMat0WH9s+VdF2kDN56RVKWUJMQ1UUYLPhFoFIgh4lFqSAQFU/WIXINr6+62DhRZUK
	YWAN6sAeQFJ7TnI9SmHhnc7fwUWEV3e+yqhXVnHM+WjisNh4n4t07NbpRc8YMw2uzzCdXAF5rSM
	SbfSls4JUIrvPM5mbKgjlF/9TQTWTWSpJUSsSDAd2qg7pwBXVCTRj+tpFtbzelaBux48F+ntRoi
	zwCNNcpVmQJ9D3m51hSVQla+xm5W3w7tPjKNQSl7C6pRkn9z2Y+m08ats2eTsb62A=
X-Google-Smtp-Source: AGHT+IE+huPMKVkx99Dz9smUQr+C4LOMabu9B98nf9uQG/iI4ndCFTmSTFC7MWlwCN2ZTQviKYWA0w==
X-Received: by 2002:a17:907:7246:b0:b3a:8070:e269 with SMTP id a640c23a62f3a-b766ef1d667mr2775997566b.14.1764242224446;
        Thu, 27 Nov 2025 03:17:04 -0800 (PST)
Received: from januszek.c.googlers.com.com (5.214.32.34.bc.googleusercontent.com. [34.32.214.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5a48c7bsm131702266b.64.2025.11.27.03.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 03:17:04 -0800 (PST)
From: "=?UTF-8?q?=C5=81ukasz=20Bartosik?=" <ukaszb@chromium.org>
X-Google-Original-From: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@google.com>
To: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] xhci: dbgtty: fix device unregister: fixup
Date: Thu, 27 Nov 2025 11:16:44 +0000
Message-ID: <20251127111644.3161386-1-ukaszb@google.com>
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

Cc: stable@vger.kernel.org
Fixes: 1f73b8b56cf3 ("xhci: dbgtty: fix device unregister")
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
Link: https://lore.kernel.org/stable/20251127101904.3097504-1-ukaszb%40google.com
---
Changes in V2:
- Added CC: stable@vger.kernel.org

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


