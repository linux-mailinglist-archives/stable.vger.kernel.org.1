Return-Path: <stable+bounces-206071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DB4CFB7D9
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 01:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1964B30034A4
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 00:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2C114A4F9;
	Wed,  7 Jan 2026 00:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dpwBANgZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AE8168BD
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 00:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767746360; cv=none; b=VeD6PBQkEAN4xW6tDg3galyprXbvFbs8t5pYh4JhiEQEjl4jsUADLkWZGXQkIPM3izP7Q2MLrwebD2mLKirCk30TqlP/mv1bWLgQOQyxdV4yYskpFrAtTvidzlIJIFZSWl5FjbDbBeckUu7wUBiyzh/DwuLTWCOdbnYAlV4JwwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767746360; c=relaxed/simple;
	bh=wKbzeprCiCtQhv02wUlRgOm9/aXzpY6/H0Tl+PqtkOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rBUo9YmI7dDZ+p9KVOL06Zsi88OVF5xiMLRBKT53iTAl9UuA6e3gGkQ0dmOhEVjJraOGN9PeSxCo45jJeTQONohJMW+ZIWvrmfC5tjC3bG6qak+v6PsVCRFqLKY0XOg5Wdzr2whGPIJr9SddzbjbNNMa+AgEeImTLiYE774HQ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dpwBANgZ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6505d3adc3aso2319027a12.1
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 16:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1767746356; x=1768351156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vn10yLAa1QvhmLZdhlHfvIpuVo8jTNGcfirLqxvT0EM=;
        b=dpwBANgZI/VYrLXIccIaaEVAyJhfGICjUxW8f1R24ovsIefRx0VITt0F8yK34EKyx4
         LrcAcFHB4e6696iG1W3Ia70EuEpSnA4Mw0clyE+UL0iEc/QVugbAYEB2DSrPlzzy9644
         b45C/eoAEE0yIMQ054v3HMA9bW196wyXuWDs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767746356; x=1768351156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vn10yLAa1QvhmLZdhlHfvIpuVo8jTNGcfirLqxvT0EM=;
        b=at36vYZKWPx5OcHjUaIHjvitmQ60UJC6xKOJ4XVqqGqbcrij8DWfakwR3G2EmcCciI
         /Oqwk2c3vvmXlqg/bom8wv4jl1nOQ8hGR4wqjzsNA/09NfbinNqGb8Fh3maLkwsNnnZq
         IRSMGfpnbrWoXPRJV/82CFFx+SOkHzlpIkjsQCIrlSNDKzm3N2n8pY2eHyWTxsAdUPaz
         UVqgt+ZI6zq7TRCXaP61tkAS7HiPwOEmqTrPaoa/UlIkYYWCSSPpjFv7Pf6mBkf7QKqf
         l/80Ou9HA5G4UJ1qvY5gm1Y275p++A39ugjtqFLwldJ/dFXGUdohFUuCBHY5OuFEamIK
         yfkQ==
X-Gm-Message-State: AOJu0YwtNGc1SD+jnSWxjGhbLxbDMF2Zu8IsCqgoSY5alSfRSyR4s+PB
	RthGhk/xk7Q4RoleDSIdNmqj4WqTZ7xjAVOTV77LV34by3E6yajH9IAG1Hocltq2v4Ae1HJLUTb
	azo0Ny/U=
X-Gm-Gg: AY/fxX4h2AAKHAVoydd840311mDxUbV77G54EaYJ8b+pDBonKb269pBG/seQS9M6pTI
	WRl+x+h5moAfGnTaUtb/GDJKO7jeLCs8vAwuOaOGytV0pu6LxrfQX9bS19M1tZrPUHTOklNn/HU
	ooyX/U+7pT9wBE2HZ0ug4Dv06XuHvgHWJPG8yX1+xBQyc00OxF0j9bcqYV1kHAn+jjfm9zpNSnI
	x97BxJ0nIUvwLp0pRr9Xl+FPxxG2m4hxKOLo/pMho5Oi3J9NJI7gKfJ6baoYLnwIYiL4S/Y9OY8
	lRyaTQU5kIetoGns5bWeJq3N+R6Wj4XMdtM9pFQRE9VghDIPUhU62yFxP+HHtG2IG6B164KEmDN
	Y07tYuFu4eydoe6ILBGizBNt1jlyuoDXaEWAqsjJIuVRLkIy/BPFX2+tNPMII8eUxyPNvBwhNxR
	OfQC+X4Yju1qKi8+PoM3q5dvpwLgZQpwhxYGr5GfloOgSAB6u4BTZ5PejVbEUBk3M=
X-Google-Smtp-Source: AGHT+IGCDkNbVwPx05BfiZxz9KapcEItDV5PDtqZxAhmL3L/loYBq3BADmylLVZru23b7PSquvZICg==
X-Received: by 2002:a05:6402:31ab:b0:64b:93f4:bf85 with SMTP id 4fb4d7f45d1cf-65097de5a90mr591771a12.10.1767746355783;
        Tue, 06 Jan 2026 16:39:15 -0800 (PST)
Received: from januszek.c.googlers.com.com (3.23.91.34.bc.googleusercontent.com. [34.91.23.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b8c4048sm3358198a12.2.2026.01.06.16.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 16:39:15 -0800 (PST)
From: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.1.y] xhci: dbgtty: fix device unregister: fixup
Date: Wed,  7 Jan 2026 00:38:54 +0000
Message-ID: <20260107003854.3458891-1-ukaszb@chromium.org>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
In-Reply-To: <2025122918-sagging-divisible-a4a4@gregkh>
References: <2025122918-sagging-divisible-a4a4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This fixup replaces tty_vhangup() call with call to
tty_port_tty_vhangup(). Both calls hangup tty device
synchronously however tty_port_tty_vhangup() increases
reference count during the hangup operation using
scoped_guard(tty_port_tty).

Cc: stable <stable@kernel.org>
Fixes: 1f73b8b56cf3 ("xhci: dbgtty: fix device unregister")
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
Link: https://patch.msgid.link/20251127111644.3161386-1-ukaszb@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-dbgtty.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index d6652db4f7c1..d0b036603bcc 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -516,6 +516,7 @@ static int xhci_dbc_tty_register_device(struct xhci_dbc *dbc)
 static void xhci_dbc_tty_unregister_device(struct xhci_dbc *dbc)
 {
 	struct dbc_port		*port = dbc_to_port(dbc);
+	struct tty_struct	*tty;
 
 	if (!port->registered)
 		return;
@@ -523,7 +524,11 @@ static void xhci_dbc_tty_unregister_device(struct xhci_dbc *dbc)
 	 * Hang up the TTY. This wakes up any blocked
 	 * writers and causes subsequent writes to fail.
 	 */
-	tty_vhangup(port->port.tty);
+	tty = tty_port_tty_get(&port->port);
+	if (tty) {
+		tty_vhangup(tty);
+		tty_kref_put(tty);
+	}
 
 	tty_unregister_device(dbc_tty_driver, port->minor);
 	xhci_dbc_tty_exit_port(port);
-- 
2.52.0.351.gbe84eed79e-goog


