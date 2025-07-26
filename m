Return-Path: <stable+bounces-164799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41334B127D7
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 02:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6DE582DF9
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 00:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C512E370C;
	Sat, 26 Jul 2025 00:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqzFMXsM"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1B4645;
	Sat, 26 Jul 2025 00:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753488641; cv=none; b=TPsZCMWs+MYgzuOmjEd3s4zlBAmXICgeUwLfCb3477W9kRn/Oq3c8PjvP5YWYKII0xBUDiHktSJ8QLlYVryqeQxiQLI21bprCFEAcw+0fKa4ENJ5wvaplUszQDkvi1y+9VTmA6wQcLOX8LyM88ICYq3Xgq/fEz0c3f94O35wIeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753488641; c=relaxed/simple;
	bh=3U3VZpRXZx7iWvBkpY1+V+8G7vmDxvuZyt8BZC0PPlA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rVaDvwarnOZQC1PMD2EyiCeE7KpQypR/j5W8JXvL9ZYwJ0GodT2pwFYwQfJA90SM9viGqWlaqc0v5avWauWf6hfZ0YGBYMP5iId1CNhFblA3Doii9nQsy9mYoVWkCI2XrWerxr0XSavggP8vMtQ+nmQfYoktU6vJCHK4ef91HR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqzFMXsM; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e2c920058fso373384785a.0;
        Fri, 25 Jul 2025 17:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753488638; x=1754093438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a1FQPmb/qHDmwSuNXKex0cpD7XQ5W81hisvxDnetPzE=;
        b=bqzFMXsM7wfr3zq3Rc52ek+gYGsfR1RoSz6RKDCswY5lNpuiZw0QaTL2ydODUQiIWH
         HnEcLozNdEaywVv7LCFfHlXaqUsR2i2q0Xl5r5GaJ/UkGTanGL/YqNuw/lW7bHTHserj
         aHm6vhyrEtAUOlT1n+fkLERJKSS0b5o2Xh5dK+7vpYCT62tHLAlgppCKl1F/W+HTLieu
         B37X887oyoOIVPSrljkzeDPlfb6CvleHQIP6t2tXhotSj39orkA6YWrtqgzP52qoQwQM
         5pWm2fO65uIcd6ITnAHCIStkwQgz8iNOxUeZxW+qt5Rz6ICW3Zlfd3BZX46OYbp3wncM
         GRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753488638; x=1754093438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1FQPmb/qHDmwSuNXKex0cpD7XQ5W81hisvxDnetPzE=;
        b=ZkTL0Cf/jDdDtFgs3lLL10T3aj7tujxf2AZCvch7gaZZ3KH9Jb8cFIEOMxL9aquE/R
         ZDjIASLYWxR3JxPebheVDe6gG3HAhM1uH1iS0aMkoJfqV1TIuaxkQF9TepF1VtFMGuFK
         3sS1cdOzaZ9HmJ0vCHiiG8Va4V9B7fz+YWfq/B6wLbEMLMsh9u09nwjOb3QO6lIKDtY/
         pQdy+yAxRpJACRkzcL294kpQVDV3KmHOKuJ+ekkK0dEX5v4t9Q73wkmOQ4+kh2uDBECw
         q+f9Smg8/93BIC464utrDGhs2+AtA/DuHBbrUJli4/OkHNpoyULuJobl2myt4XY8SXC7
         N2Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVke5A5+EA93NdK9epCmQfzim7FYaWaDKylGg8W56ujehWwNTSzOmompAvjc8NVQ4eN00SXqK9s@vger.kernel.org, AJvYcCX/g7TSkfoxwrd9yQq/mbe3s50Tbj1Z/m3g4VHOl+0ZNUuZRiqhHMjPdTO77yNXBVJPfgtc5Vm0ByIY85s=@vger.kernel.org, AJvYcCXrJaCMCMVWsFgHieghrVhPUazMkN9Vjff0Ji/27aCv2rUCz5BsFLMFkHQrExcPwEQuf8qDSHDy@vger.kernel.org
X-Gm-Message-State: AOJu0YyJk72C1ETy/xCmMA+jmwG6h5T3M6/1xoqIFWTVJ/BUgv1GNMVi
	lrKt4FgEU89fmw+B/V1pkgbhiioRAcbt+IbGHFdy/6m5CgB0wmyh0KSk
X-Gm-Gg: ASbGncsco1oXrsbL4mi14/GLZZBb5Gy/m/22n0EbovtGP5imf07gLCoZmY8qcka9yBB
	poD7vRufX4ZJvJg3WkZ1slPeuMvFTUw5IoyZkRG6+RC8hDF7r1OS9wKEXYKmsPY9d39paFxCrZg
	RcNWc+B9NVWkorNreSNPlETzxFeT7WwJtZu991E4XgWGDG059OJZ7L8JFf62vxL4xZTVIGcajx6
	k9xTFnMMoPiD2LttFXFgLYApRsqpHI/icOXdcbMgJUSEwfkWqo8e0CUthevUXm16UfM76vsy/Cz
	vJmQeXyimNzlmmh3kySfiYNbd6bKCHzqHP7QMAU6SpHCZJAWU5++xROmSCra7o5/ISbVO/7uRQ3
	oozM2ES7MbTaSCH3JfCsDIc3e6zqRy2wFa/AwEh86
X-Google-Smtp-Source: AGHT+IFRfQ6n2S41EljA095+vRKxlLJIX5UD66O2bo6l3je5rKzjGm3XUho0sda/uehRTG4bGqSj9w==
X-Received: by 2002:a05:620a:1a06:b0:7e3:35aa:7707 with SMTP id af79cd13be357-7e63bad15b1mr496472785a.25.1753488638257;
        Fri, 25 Jul 2025 17:10:38 -0700 (PDT)
Received: from Latitude-7490.ht.home ([2607:fa49:8c41:2600:afb4:9d47:7cc2:f4e8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e64327ab69sm51992685a.1.2025.07.25.17.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 17:10:37 -0700 (PDT)
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
Date: Fri, 25 Jul 2025 20:10:34 -0400
Message-Id: <20250726001034.28885-1-chalianis1@gmail.com>
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

Fixes: 01db923e8377 ("net: phy: dp83869: Add TI dp83869 phy")

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


