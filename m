Return-Path: <stable+bounces-164798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EAFB127D2
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 02:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0D5188B45C
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 00:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ADE53BE;
	Sat, 26 Jul 2025 00:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8vP6KNz"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1E47E9;
	Sat, 26 Jul 2025 00:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753488567; cv=none; b=aRLquMgRFvvgP7ZYCXwh9PQ7LvG89SbQZcs+t1Wb5B3AWc5giX4vXxbufLgdSnFBfpuirmLJPjQfIhdsbOC7TNkKxc4NpksKuJqU6DI5Nj3Rhv6tXyHGms3ms8PuutMaSJ3aJvDi3mNuCHnJSoCjUjoYGj/MR6Iwqy6Sr/iVIXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753488567; c=relaxed/simple;
	bh=so3kqgULjw6YNvt3ch12QiLwl9ZIZtBEKksOcAon+gM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KQiQS1Od22980df+gzfTPXDmR3VisCuQF1CnaS1boOs+Crxb/7gT/FwkE0OJ6LNeGKbzNLP7hkOV0f6tFjC1CsiLBudVEGreFGyhmnKsfIPpbK24P2LwIAH10EnCtOR/WGPna9PdEZcrJiY6qRfASZn/7IiwVBSAtoRT92hylEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8vP6KNz; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e62a1cbf81so374891585a.0;
        Fri, 25 Jul 2025 17:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753488565; x=1754093365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vK5CC/F8c8c+Y3fFwdimtYsYY35RKGShh4bXfS9Y+ao=;
        b=h8vP6KNz5Y1h8N/Vlg0v12bVP3MT2wbA5pN1RcCGDM7fXMqXKim3SOpi1sXIMGEX1S
         Tz99SPfygTLkcNFURRPTahG+IiOnBbTNJ3GOijkJlaMrDUcl9y5PTK1Rtu1zge7oFMN3
         +Qr1zslBe0pVD9U5XrZ0Tz4EmrEhtBszmyCOHJUXWvIxcrpYL3tlOGSCAgTbA2qx36JI
         W3LZ45FMsd322StWJWaXeTkDy9qn9aaQdG89is/bRikt0IVYdFWc04IFf6rNXFkhn3V7
         LlFksbkNpawthwMvsXV+Df/zfiNlTZcfdo7SCsd8I7lwQb+Pi12ToM6DRSwztG9XF4nJ
         TMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753488565; x=1754093365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vK5CC/F8c8c+Y3fFwdimtYsYY35RKGShh4bXfS9Y+ao=;
        b=hiyc2/qyvy+Iv2wAHT7QniioFzlqZFFz7aA+Oxxr8uUTOkLVvpbNrO2lqwaZQBNemL
         Kxe8lN90XI/vgsgWIeTI+8SGfWaExYwaRyjWK+smXFWACxfSsRvhh/0ssU1TZVhvaImH
         Lf4+qe1BOqjoEaU+L/ABm0tm6uNnmRd8zUZk3jZbF9Bz6ifxnusO1QJcgHfVmI4mb3sT
         NTLXjz9z3rNJUQXyF4bylgPmIP06FEnn753aKAydad59l8bkSBrQF5OJ7BR804ogxg3+
         aJzvN+LEWLFDfQn1GcbFCok+FcnStjIRNIG/nRTsN2eQNgvHV68pYHTeshzR1r2R7cpQ
         FFdA==
X-Forwarded-Encrypted: i=1; AJvYcCUEoWxY4U8+e69+CcKwzWCmNoh+qZ4IW8da2CoDmFKFQ5EborJqmpVBay8mUyCLT3EqVfMy4oon@vger.kernel.org, AJvYcCWhUKKysjNPqIwE5b5rKgMZhNOTugq+pLhPpcU0MIezNYPOStzPk7uHXHkW4tCqK7+eQL5zCutLGnttzPo=@vger.kernel.org, AJvYcCXDsG27BE+98nLKuwXUxtKr4GuwIPn7xCoDH5UMN0HLCAG8qgaUlvXVSj8Z4uXdRKAqR5XjDueA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/V6uAscAAzv+XadFe6TnTB7A2cW8Sb14DIVC+slgGKQDRasDy
	FBsp5Z2JEw4gedPw02bdqD5ErEHxnNYhuahZU8dqjM0Elfa6k3Z6exTg
X-Gm-Gg: ASbGncv6ues2FOV+WLbOsvu8pzjHsCpAbIziIxwfX2rnNWttoDovKJzctkUNcfvR5Vh
	qYoWc6QcWnnxagVf9UHkOlQExcrvq2RErvqZSYxI1whT3ETEEH12sogYu7Hq0PFj1+F8PCxLdIj
	OFwj8LomVR1VrQDvqYY2AiAm7RY7RMxBBObf0/j59traxe6RcG+Cocem8MdubyS5hGE4Qz9Jrhm
	kADzpgflCqIiUrViPgRx1P+Ia0E1s0UKcPdIKi0yvHGlhU4KOohlWqdebDkyoxSGHuDcbqEKyrs
	yufokZEyoOYmwO05JpX7nhO6x5+Sj1f3td41YInqWyMJl/SCbnuxLubCVfa/PsfA5HFEmlqgrm/
	T2ruwAIK/Y6k8SMHk/m3zIEkZGIzoxNP2+6VvVxb999rvt9/1GPE=
X-Google-Smtp-Source: AGHT+IHPrWyECDnlzRG2GVTCcX4kqyujjTm5i7kuQFdb5jlO5KTC+R9ZOq/z7ocmTRhdSfSCqa7MTQ==
X-Received: by 2002:a05:6214:f27:b0:700:bc3e:4499 with SMTP id 6a1803df08f44-707204a233bmr56174836d6.10.1753488565219;
        Fri, 25 Jul 2025 17:09:25 -0700 (PDT)
Received: from Latitude-7490.ht.home ([2607:fa49:8c41:2600:afb4:9d47:7cc2:f4e8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70729a82d72sm5859516d6.29.2025.07.25.17.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 17:09:24 -0700 (PDT)
From: chalianis1@gmail.com
To: andrew@lunn.ch
Cc: hkallweit1@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Anis Chali <chalianis1@gmail.com>
Subject: [PATCH net] phy: dp83869: fix interrupts issue when using with an optical fiber sfp. to correctly clear the interrupts both status registers must be read.
Date: Fri, 25 Jul 2025 20:09:19 -0400
Message-Id: <20250726000919.27898-1-chalianis1@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anis Chali <chalianis1@gmail.com>

from datasheet of dp83869hm
7.3.6 Interrupt
The DP83869HM can be configured to generate an interrupt when changes of internal status occur. The interrupt
allows a MAC to act upon the status in the PHY without polling the PHY registers. The interrupt source can be
selected through the interrupt registers, MICR (12h) and FIBER_INT_EN (C18h). The interrupt status can be
read from ISR (13h) and FIBER_INT_STTS (C19h) registers. Some interrupts are enabled by default and can
be disabled through register access. Both the interrupt status registers must be read in order to clear pending
interrupts. Until the pending interrupts are cleared, new interrupts may not be routed to the interrupt pin.

Fixes: 0eaf8ccf2047 ("net: phy: dp83869: Set opmode from straps")

Cc: stable@vger.kernel.org
Signed-off-by: Anis Chali <chalianis1@gmail.com>
---
 drivers/net/phy/dp83869.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index a62cd838a9ea..1e8c20f387b8 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -41,6 +41,7 @@
 #define DP83869_IO_MUX_CFG	0x0170
 #define DP83869_OP_MODE		0x01df
 #define DP83869_FX_CTRL		0x0c00
+#define DP83869_FX_INT_STS		0x0c19
 
 #define DP83869_SW_RESET	BIT(15)
 #define DP83869_SW_RESTART	BIT(14)
@@ -195,6 +196,12 @@ static int dp83869_ack_interrupt(struct phy_device *phydev)
 	if (err < 0)
 		return err;
 
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, phydev->supported)) {
+		err = phy_read_mmd(phydev, DP83869_DEVADDR, DP83869_FX_INT_STS);
+		if (err < 0)
+			return err;		
+	}
+
 	return 0;
 }
 
-- 
2.49.0


