Return-Path: <stable+bounces-109612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11A0A17E20
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 13:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE24167979
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 12:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A5E1F2C3B;
	Tue, 21 Jan 2025 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="RGag2DzS"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D721F2394
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 12:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737464183; cv=none; b=ddh6rfBtwbm/H+Oo5vjYEMBv9OogLxuDuK+j0TC7g6ClsyaXIhwZr0d/5EVDH2LEYw/728O20mkJ7tKPXyTO3MSGl/WOM1dxYT5dXWIqPV67/L/KN+i5IheOtJqYCH1UnG0e4gxvGOqMdBOE4g4zLnWg7ekQhTEOXPhTC+LT+tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737464183; c=relaxed/simple;
	bh=Jb7gtavYJSMtEM+1uRO8th0lvhKIdkwy3noPsT0wP/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jIxZUolE+eB00Ev3mwh62+zws+fb57SunlUhlgVQkN6iwMBaR1J5t3ZBtPPuHP7rk6Ax2JF7wdWcivEUvQGfbFyKQh6aOdkXNMDwf+TN7cZ/52raao9yPWuLC34dHILBxN3RGn6j7Kmh8QWHbIBlRhO5E3m8+Rnl8eLhI3ya024=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com; spf=pass smtp.mailfrom=thaumatec.com; dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b=RGag2DzS; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thaumatec.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab2e308a99bso1161849766b.1
        for <stable@vger.kernel.org>; Tue, 21 Jan 2025 04:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1737464180; x=1738068980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bx8ohLBrU/OokPvPfSuPsXKrA57TpfEKGJT/XmjQiVY=;
        b=RGag2DzSdABul/PR6TzDDb9klUcDYtHNw+rkbrp7QAl5fnDnZVXjb6gxklQWOYmPv3
         uT3tYQr3naxXq5osxTapigCqdlJt2ii/dUzs61H9PE12jcX4Xyb7JelnXZGDh7HxXpSG
         c4xrSgJvyQc+z3VXtwUp48UawbQ2BEKtB7MU6RhrnMqQRjgZ15wdHd9uggXqB/YwJfJ9
         M4+erak8NmqXQBh2AyDaiNbnvqkfq9VAWoYYzqKUsbztAVnxDrNGFgcwEbz4GsPFWyKO
         WCBAW1jUVz7yjj51LGRaXboIzofRyfUv5soIx0A0eEsEwXrUaiCUpPrId612X5i3YWmi
         sY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737464180; x=1738068980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bx8ohLBrU/OokPvPfSuPsXKrA57TpfEKGJT/XmjQiVY=;
        b=Jvoftx5Ah0B1vjzS2XicvO3o2CUj41DJFtj/TJ+6A1dgs3yDrcuZNRhqjFKxVGEvSu
         fNADgPWXqJBlyho9NpFYXhyvaokZcKML8/eC8g5wr8LQFWioK0clirDoDoIqrkY1S7zb
         G2zH5Nvo4BrOEbHnegeY0eVVtPFNcSQzPKFthqp8Ti0aQyMqKJLATGZ1OtDeWo61troV
         P/u+U4jPOQWyblLelIQaQba3ZoA/Bb+qF0/P80DchdQUGqtBv4nIO/rokHVf87ZHlDS/
         X22qO7d4BK0Q/4vumOPHw0Zu6SlVGuhPIbgJQr3qzMMGSAl2d+TQrxiPpDv2tpjQjb5+
         qjaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdQJ9TyDjNlMYFF9Fa4jf/dgpYdnMDLKRJSMog9B/B/fz45crdlbig94IG1vG4/YRhZ647zDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUrD8DOZGtTp/+f4LHL6TnKTJzxNoMMji/0xbnL/W5+5NeODZk
	Ha4K+hsuZseNAc6EQTBp/2f2WkR4dH+tS9H6QAvMJ/0WPyJMfNYswMTji3E7trM=
X-Gm-Gg: ASbGncucqsbx7HqxZCEb8hS8TP0yXORfhghTDlLEZJGFWfOQ8TBn1GzuNcE4H9O7F/t
	Rr6mliQ+Ie0tvcm16toUacvaIQ5P8zwMBECgcEEWUwdJbVHm0wl5YzN289g2pTLk9Hc9l9Kf8L4
	KDuYN37mf2AH38tVL1mt+DuEw+Sop9DxAcTMaSwoUNz/ieiQdWnTXWLLBBqx59A9ZuVaJkIUkD8
	fzfpcKm8FdQxSQ2zNDOmXzYqdcHoCNQ7AuCRo8T7C5JPvGbfwgMlcgI0FjCNJwULyavJEy9iNi4
	MVA1dhqrG6B0pI3CjjKzIOVTNg==
X-Google-Smtp-Source: AGHT+IH2YjsrPDohH7bzIMs9wAWWL8aTE7Di9cAl1bb+50e+R1QaTdoPlQwcV1unai0DN5r3lzmS/w==
X-Received: by 2002:a17:907:7b8a:b0:aa6:8dcb:365b with SMTP id a640c23a62f3a-ab38cba3335mr1373905766b.5.1737464179884;
        Tue, 21 Jan 2025 04:56:19 -0800 (PST)
Received: from lczechowski-Latitude-5440.. ([78.9.4.190])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384ce0529sm740943866b.43.2025.01.21.04.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 04:56:19 -0800 (PST)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
To: linux-arm-kernel@lists.infradead.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: quentin.schulz@cherry.de,
	Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: rockchip: Disable DMA for uart5 on px30-ringneck
Date: Tue, 21 Jan 2025 13:56:04 +0100
Message-ID: <20250121125604.3115235-3-lukasz.czechowski@thaumatec.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250121125604.3115235-1-lukasz.czechowski@thaumatec.com>
References: <20250121125604.3115235-1-lukasz.czechowski@thaumatec.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

UART controllers without flow control seem to behave unstable
in case DMA is enabled. The issues were indicated in the message:
https://lore.kernel.org/linux-arm-kernel/CAMdYzYpXtMocCtCpZLU_xuWmOp2Ja_v0Aj0e6YFNRA-yV7u14g@mail.gmail.com/
In case of PX30-uQ7 Ringneck SoM, it was noticed that after couple
of hours of UART communication, the CPU stall was occurring,
leading to the system becoming unresponsive.
After disabling the DMA, extensive UART communication tests for
up to two weeks were performed, and no issues were further
observed.
The flow control pins for uart5 are not available on PX30-uQ7
Ringneck, as configured by pinctrl-0, so the DMA nodes were
removed on SoM dtsi.

Cc: stable@vger.kernel.org
Fixes: c484cf93f61b ("arm64: dts: rockchip: add PX30-µQ7 (Ringneck) SoM with Haikou baseboard")
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
index 2c87005c89bd3..e80412abec081 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
@@ -397,6 +397,8 @@ &u2phy_host {
 };
 
 &uart5 {
+	/delete-property/ dmas;
+	/delete-property/ dma-names;
 	pinctrl-0 = <&uart5_xfer>;
 };
 
-- 
2.43.0


