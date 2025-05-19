Return-Path: <stable+bounces-144871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BD4ABC13F
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 16:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE56B3B8520
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 14:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0901DE2A7;
	Mon, 19 May 2025 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hntFdLCu"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0531CD21C;
	Mon, 19 May 2025 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747666028; cv=none; b=Yi/vKxI0yFP76flpKjKSNqHGuBSywAcfbgme8vz2Ew9uFdfZBKfgjJnEWaYN+gyJfUk85Vpw0c3cK1955SY3LnBiuSWtEjVyBgYMV2kt9MbRJTheZbkquIzT9LD6eVTyH5KIKVO8hvWdOaUdKbC0/3WdICEuw8xTpWtxdY88zuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747666028; c=relaxed/simple;
	bh=3qnV08bZhkf4pfjJZBx8dUF6Qff3QUhvneWIe9at9jA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q+Q/2aW31w3YBwFXEjvRuSgJuxr3LSggMPbWwsadxWFg13LzCHFd0ntzps4PHDSIEsqA2+dzDr4H/V7TtC6/XgYfIxnGFuklh73ulfJFP624qVuTr0SSscCTnLDmbFv7kzJJoscaCbL9mbfcr63K+5lXojbWZQUnl77y/q7M6ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hntFdLCu; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6f8b81fda4aso28390826d6.1;
        Mon, 19 May 2025 07:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747666026; x=1748270826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E8Jd7Qi9TWpcjCpG46oFCwsLyC3CfnqUMVCo075QTSo=;
        b=hntFdLCuvNpu0kuBMD8S6ipRLDVfGnsqNbIlmJ0GfDNJVQFOuFw4Rl5j5ry3BRSZwu
         m/y/Km/wtx9ZRd4U9fMc2q23hW7tEjZnVHZHOvAZ20bzdlipbDwyTnRSWYybk2lO1hu6
         yuNwK6Tl68oIWWcA8PS4ihemkchjuVG9otaL/TfPeiyjVyFQoMKqOB2SGY5Gd4CS0kQf
         0LPBry+UkBh03P5nAW1kf+mg/4BIOSIocsIxOahvOGvylckxwKmZ1aGGzN+Oxv9TuynE
         qN+4ujcXrdoOIxU2Kr2h9ZD2mqF4ry2TNgD2YKa8bbtN0o7+Ui6a+wjIzgECRQRRkRK8
         0CYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747666026; x=1748270826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E8Jd7Qi9TWpcjCpG46oFCwsLyC3CfnqUMVCo075QTSo=;
        b=IRvJ2/ZxhsU79qCABpxI5oRi8RXVdApKq29CkQuw5hqH1dXM/+ukyou5hxZ/5g6zQt
         4OgIHbhuh827JzHkcryU1a2Enu5lRS/AjVxHeOmeCPEO36+EfQnSKRcX6a3qqrXxETI4
         9FYZXnzRIE2jVaqhTPEDJ9vebenDrGu5c82UP6J++vDkVD+dEaa6xLPs8znYMu6oFjV9
         UZ7PG3CLGuJo9OLemUyRB/i/z3rv/ki7FxwoO0V+ve6rEEtaVSWWsyF+zCKcZaZUiLHC
         8YfGmEoygXpJrE4UK1vg3giyHjdL7Mg0lVRKZF8jGYoSMfQtlkxft2LDzrygMUS2Eg82
         V98Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrWyLB1UlsisNJXmeJFik3mqUNPMmz1w/YRRzsACvyP+buh769+OyurHqTGGnE68MHhS8T78K7@vger.kernel.org, AJvYcCXpAC3CsWqbcCEp2tRxUl0bU2CJzU1gzUB/Zcn7X3eXL0fbLbSl5iRqNYrdFV2r+3QGL2EFnSrso/U0Yg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl1/N/4pXElCZCHnVhcs+l+o0ieMT0YLk9yU/uZOI5MofsUS+v
	CTFJlpOQiQWJXexy9xF7xlcfAXtSd+LyBf62j4m4IwloHQGkIaUznAmCj88tGDFWfik=
X-Gm-Gg: ASbGnctkbnaQrK6OdxquCNw4uHyv5fm4/R0kDoh8i7Ca5eZ8yyHraq1+bWZm6O9oF7+
	O4glFUbfkWaUqVKejRSgC/d6MPlAqIuVV7E34oshPhrUgO5zj+lGjiY3fae0+JpzHe1Rd4oxtDr
	SVBOFBf5R32S/fUTe40yTndjdlws8dQFwDVzyznBInw+ZM7dJCBXn7cgPfgPi+Sahaivb1x8svU
	R6PCxkjy607omaip7KEuto5VJSb3YHnwjB2ShnQH/qU6RrYGrdYu5xcNCGrL8kBAAZzCHoWK3f1
	uP9ciDm0VYaYR2nyFjIJF8xMhtGSdHu/hC73U1rigRZvq/PmbUvD
X-Google-Smtp-Source: AGHT+IH9gfQ+apMRIS3qcJyKjW6PWaqbuvRhWH7s8idH69K7FwlmtGsTZZNFdqKx6LjWZmqCtVkvgQ==
X-Received: by 2002:a05:6214:2403:b0:6e8:fcde:58d5 with SMTP id 6a1803df08f44-6f8b08e56ddmr210246136d6.42.1747666026022;
        Mon, 19 May 2025 07:47:06 -0700 (PDT)
Received: from CNCMK0001D007E.ht.home ([2607:fa49:8c41:2600::f21d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b096ddb4sm57405716d6.78.2025.05.19.07.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 07:47:05 -0700 (PDT)
From: chalianis1@gmail.com
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Anis Chali <chalianis1@gmail.com>
Subject: [PATCH net] phy: dp83869: fix interrupts issue when using with an optical fiber sfp. to correctly clear the interrupts both status registers must be read.
Date: Mon, 19 May 2025 10:47:01 -0400
Message-ID: <20250519144701.92264-1-chalianis1@gmail.com>
X-Mailer: git-send-email 2.49.0
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
Fixes: interrupts issue when using with an optical fiber sfp.

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


