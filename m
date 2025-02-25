Return-Path: <stable+bounces-119476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC3FA43CD4
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 12:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A511734A8
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 11:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6FD268FDA;
	Tue, 25 Feb 2025 11:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="k14C2U6n"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3902D2676FA
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 11:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481382; cv=none; b=arTPpegZRmetLCu2/2v5y8a2mispgI6feWDtcFNt6AlGhY3V18OhnnLH669HCa4FCcqKPvR0dfqVUZXMQ4keR7C4r1mbZOLk5f7FHQmmR+TZUsa+9ccWhBVQ4DFnnjWF7D8v1AS9Iow1nwgI1YzdlYji5d8JLn7zDD5xrTfO28U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481382; c=relaxed/simple;
	bh=EFoTjmBvFXfXjWb+GX1/FcvwY+PND4is0Ol1b2EMzJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfL6lGyZjxqM1wsR3P/quZtN4JXHlYjwvoJo3PKIFcdoWaczxwD6f4FKJE7hr1GmUoTWyD9SiIjyhh+WWos886UZqCBzsFMFcuuRL6D0xvNs75TH6/9Lxz69Iz2K1WdAGWdjKzbkub/46V4wRDGOCCr/AkT/uSkJ9UNkjfn5MJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=k14C2U6n; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-439846bc7eeso34040565e9.3
        for <stable@vger.kernel.org>; Tue, 25 Feb 2025 03:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740481378; x=1741086178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1g90tifgQM9MVDjBzO/J2Q9Ytv3puck/TcrC4X2HffE=;
        b=k14C2U6nGMHsF8/MEKTGyx66X/GNX/AXIuxMBjthOmHyCVh3Qs3d6RCIodf3FL2KB8
         ZOEgIsQ5L9Yisrg4dL+bMYNoduIE2WpcEkyrlN3WZwoPLKL0EVjvxLWhcasXzjLWhXaH
         8Dw+UHLTblJvNiXztWWwWvP+49ExEwDcWxFvOlpPxayZkWHXyz9yTXBHo/DLHowNO5Ls
         C6A++u09CDhYP1b3aZx/MP7jurtIkfa3+p2T89o5IcUJirKjAVyYaMD7fXnDZvgH9lMS
         xmKyYNs48gjm91WmA7YsSqYrnicAaIWdRBgeJpuKXL2mWdIaZtu1kNJsZoyCPaPPvVT0
         7HcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740481378; x=1741086178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1g90tifgQM9MVDjBzO/J2Q9Ytv3puck/TcrC4X2HffE=;
        b=QrRQ4FJNQsraUvXe6Mboo2b/V1jWBkCNva7V0nPQbY2oDabTtfv4lmmuo9n519HvKD
         4OlzEpp2+NHTncrwV4o3cfQp+r8S6Ik79GIPwhwl793g5siGD0xkCngvuvUgHIUTdC7O
         C4JCMqpivS8rK0G5A8pG+kr7vEESfwPZIRxJ+8envbYRW3ZYMwJsVIzWlPz6kOZDmKws
         dPmivxI+mqLzHxD24Gg01RSJprwA5ors20eZD2+VpoWmsooBc9nm44kTN6D14C3ObrGL
         gzhI0fnIkw55mycgesT2ubvw8XZuFlycdklrtLVmk4YDOjS/1KXY5LCVBwqM1tqPE4cI
         biJg==
X-Forwarded-Encrypted: i=1; AJvYcCUrOcjPkO4rvq/zLkMVzUMxjpDWR7t/UuA/VaUyOKXgmUus8lSYsawrFBzC5es+tf+zcaK2q78=@vger.kernel.org
X-Gm-Message-State: AOJu0YwghQpvoOLrY2FNM+8d0Cxa6xKCJwniHB4vcLJV4PiBwTxH2SjX
	TW8k6M4nY78Y7cbqFKiSWV6Z9sE8OdV5GbfvUx5TitgYYr79xGPCUeLXY596ar4=
X-Gm-Gg: ASbGnctQlDLK8KDYaMPSCJ8OSA6xjZE/XBzuFvPCN9lltdCJhwPKILgmgMhIR4pv23b
	9f7EsyIT5qFB3yKVPCwcOAYs9gC+TnRx5+Hn+8cLwmoOqEfqHojyiDeEVdfIUi8Kf6gy2Qm970h
	i7gaT80Gu2fQGUgyC3efVvagAJpN2MvXyJ1PUF0JTm6LttlAFUOXPB/6LRZCth8J/r7cmVQVvPu
	THSh2XjWXJmADGuDQ3J2X4v+bQJ37TJDtoFZgCItntMusQHEskDa6Sn93g5QOzrdNU4UGPVFkM7
	O7XS6eLA4S2ipt2ni+D5fVY+LZOA6bmTBz7DqrXV7aYTx/6TsKQmrho=
X-Google-Smtp-Source: AGHT+IH9p4vFb/WlIcpRZOBte7JgwwPLkhCZmRimhOlrCUbR7HFlC6wBkzx+vvYw/CKT/Zad3bHmmw==
X-Received: by 2002:a05:600c:4f84:b0:439:955d:7ad9 with SMTP id 5b1f17b1804b1-439ae1f145cmr171014845e9.14.1740481378537;
        Tue, 25 Feb 2025 03:02:58 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab1532dccsm21972385e9.7.2025.02.25.03.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:02:58 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	geert+renesas@glider.be,
	biju.das.jz@bp.renesas.com,
	yoshihiro.shimoda.uh@renesas.com,
	phil.edworthy@renesas.com,
	balbi@ti.com,
	laurent.pinchart@ideasonboard.com,
	kuninori.morimoto.gx@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] usb: renesas_usbhs: Use devm_usb_get_phy()
Date: Tue, 25 Feb 2025 13:02:47 +0200
Message-ID: <20250225110248.870417-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225110248.870417-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250225110248.870417-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The gpriv->transceiver is retrieved in probe() through usb_get_phy() but
never released. Use devm_usb_get_phy() to handle this scenario.

This issue was identified through code investigation. No issue was found
without this change.

Fixes: b5a2875605ca ("usb: renesas_usbhs: Allow an OTG PHY driver to provide VBUS")
Cc: stable@vger.kernel.org
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- collected tags

 drivers/usb/renesas_usbhs/mod_gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index 105132ae87ac..e8e5723f5412 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -1094,7 +1094,7 @@ int usbhs_mod_gadget_probe(struct usbhs_priv *priv)
 		goto usbhs_mod_gadget_probe_err_gpriv;
 	}
 
-	gpriv->transceiver = usb_get_phy(USB_PHY_TYPE_UNDEFINED);
+	gpriv->transceiver = devm_usb_get_phy(dev, USB_PHY_TYPE_UNDEFINED);
 	dev_info(dev, "%stransceiver found\n",
 		 !IS_ERR(gpriv->transceiver) ? "" : "no ");
 
-- 
2.43.0


