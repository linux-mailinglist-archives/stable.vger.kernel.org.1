Return-Path: <stable+bounces-206066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1786ECFB764
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 01:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2BFD73003499
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 00:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F56199931;
	Wed,  7 Jan 2026 00:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O5nH88qF"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0E363B9
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 00:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767745582; cv=none; b=eeCsriFx0aYO4pxsh1LBoEwiGAD/wadvtWB6LqlBybAH/ChVpKjxictGlbwY8ZrwE+wplcgy3ND6OXMYHlx+OJ0U+r+zl3sju0uWMV9we8qPKETaLihI0LnQmGlTrlf9gH5IGURPmyXtFaTIlH88N32QGzAPVRJrluPFNbRYLaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767745582; c=relaxed/simple;
	bh=a90tVt9Smk2VDNjxnJoRyCpQzdd1ZxntL0cLJELflTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ub1mw1QMvxztNxkFyxfEZKW//7PUxRIbJUWRXsHzRGmIg82wbapV4gx0HDB4tHyZQqDrbkpRAfEVrCzfNSagQmnqnmOvzEYj1/mtGpejk0oCOtuxHgrdvcn6+HZfW7sdNUKugN98jLAiXGu/MH4k6tHA7bpzFJoFnVbjjECK2HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O5nH88qF; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b843e8a4fbfso109660666b.0
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 16:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1767745579; x=1768350379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dB8cungVgWy8W2sZ+u7GFf5f05SODi9guWKg/HoF/c=;
        b=O5nH88qFMKmLUUgt7yDG1iWTNNAX7qwaZCnIWOVu5GkPqoRklYfwmSzM3UrWhglwLN
         m5Xc0z+mOqlTT6i+53NUHeMbHsbeWQgiSuKcMwSsTJZTK1ko+w2wPBTBf1cgZh4rWj11
         QBjDnvcdk5S/io4wi16+qdebacUaWMYnq7060=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767745579; x=1768350379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2dB8cungVgWy8W2sZ+u7GFf5f05SODi9guWKg/HoF/c=;
        b=Rtp/feBrOw7ueWW3Z+LsGjqXatUmEQ9EK6mrQvRVJU/0aCcPiGX/oxi8EgoMXBl4x+
         i+k0e12ep9b6KnAQSeVaVHC53JP8XMNzCrVDEmueR5EzpqQ9dcVutWnDcGHoJ8IGpseQ
         Fa+Woyhcqiq01RUMaVBzL/MrcEL/LXpUEAnL1kfmnjwZ74UtV1F0VkDb70jiCUQ/ppxC
         nKHOlYGRSS56I3RW0rs5s1HKAQPp+2QPOAvnfS14qN1myXAF9iMmYb/SGn4kgRF6NuaY
         fJNjRoBAH5Zm1V9JYXsSSRoFsc/kK0eKumqsiiHJJGdaTad2QWlFs26tJO7if6wtnupC
         JbXg==
X-Gm-Message-State: AOJu0YyXB41JwbglW/B84Z9yGQ/QOdgbdzL2pzdt5+lx7VdLNUt5zGCS
	35eHtCkOr5m+tn8CLhLFnsk3z6H8S0Rc/mZ6ESi19h/IEvK9xNRwUScD6LsLFIN8I+ArWW99FPu
	ns6KM5T0=
X-Gm-Gg: AY/fxX6a4RFcGClDnPix/60SYf7D1m+HF3OdTthmtymRHyjJK2ZvQ8nnH5jogNrfVO0
	kcG39wx6eYD211h2FMuje8GXhv8bE7BH1YYWp1fWco4xkNf9CBHMOZSgrx3edZOGcu78+i0AsRE
	qNGno2HFB2JMCq8425pkcXdI3Fc+kE+HBgaR/1n2ehCowpWW0pTCrSMsru3yFLID3l3wYgiIqVE
	jGCuSuZNF4+LIEtph2xjXqyHgPENu7NfYZEBtPSDPuyfSnXvaigG5Fe8nt7bpZHVCWhZr2U3cwS
	rZf1M8DBeYMDZ/KatNGy5PjjOLc5j9dKuzlcCCCnfLeY+nlOF+OBe5a7coeXdX7vTgIsDU38F1t
	t2fe4ep0frzNOel6MdIjoumfB47gDsxDzJRvXulCyMicCARrrbq+lnY9Vb66TczON/hXwqSQKYz
	OGzybPkbXyqvsEDqLJk7Ir5s4chnuCVGlGIT0ZaTIPCWSU1NYyRnU/lNpy4cJ5GAA=
X-Google-Smtp-Source: AGHT+IEieyMoxIiw9MvughaiHTXkRwAZk05vpDwr40atYjQd81CF3N16a6zmqZHNWtazaKg4G+zJhA==
X-Received: by 2002:a17:907:3f9b:b0:b76:b76e:112a with SMTP id a640c23a62f3a-b844516a870mr82212966b.11.1767745578737;
        Tue, 06 Jan 2026 16:26:18 -0800 (PST)
Received: from januszek.c.googlers.com.com (3.23.91.34.bc.googleusercontent.com. [34.91.23.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a56962esm359953766b.66.2026.01.06.16.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 16:26:18 -0800 (PST)
From: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.6.y] xhci: dbgtty: fix device unregister: fixup
Date: Wed,  7 Jan 2026 00:25:20 +0000
Message-ID: <20260107002520.3158298-1-ukaszb@chromium.org>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
In-Reply-To: <2025122917-keenly-greyhound-4fa6@gregkh>
References: <2025122917-keenly-greyhound-4fa6@gregkh>
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
index f2c74e20b572..fc057391abd3 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -515,6 +515,7 @@ static int xhci_dbc_tty_register_device(struct xhci_dbc *dbc)
 static void xhci_dbc_tty_unregister_device(struct xhci_dbc *dbc)
 {
 	struct dbc_port		*port = dbc_to_port(dbc);
+	struct tty_struct	*tty;
 
 	if (!port->registered)
 		return;
@@ -522,7 +523,11 @@ static void xhci_dbc_tty_unregister_device(struct xhci_dbc *dbc)
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


