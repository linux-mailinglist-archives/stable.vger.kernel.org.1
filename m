Return-Path: <stable+bounces-189138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A71F1C01E5A
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 16:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849E41A63EDE
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 14:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABEE30F80E;
	Thu, 23 Oct 2025 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJOUNYYW"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CEF32ED45
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231033; cv=none; b=TuW+gE3qHxV9z/5xwcIqjMWMdPueUwp5fmLL2g5jBhkQWGv2/jFSZhR+6Hp3BaAqvUT096TIwUouWWDhET81p12iwwzDGFC5LY0k5FnqCrzesyDrhn30G0vU/Zqiut8Aws/3azcwJVvmRSLYwa929N8zhMQzRok2qmKEgfDAHDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231033; c=relaxed/simple;
	bh=waBTP7RtsmhC1WI2NmWFK1HTs2arG4JeVs+IEMQ0HQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EH6UAp5SU6e0PKjMScgi41hmf8GZtQ8XpY3i3DWiVGzGxkTAfe7IX5y46N1zSf81UC10nAyogxpfnyNPtFDX0lwhuVh3IfdPD7qU944whG7RweO7OfEdrJKPwTLPMh5N69fPTqN4NxHNVGj47Nq6Om1Bhl0Cb26h8WGnbqlWvGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJOUNYYW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-475c696ab23so5486285e9.1
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 07:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761231030; x=1761835830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FassfAN01QkxVDyy+Sa+b0ImlRDr/lRNphkFcyroU20=;
        b=MJOUNYYWLMw7HcqSw6agbDQdkiAGR+T8i/4u+wu5uRk8mrBejYpLzAvM1XkfyIZNG2
         o3LuQ86oHQgHRBDwFlxX3KVyFPy7gHKSw9+Q/RuvaNlI5OqiIcuOnad+dnUB7KQDx5rP
         N408xobqk5EbAgZHR1xK1shlotJOt1Mxe2+oWx3dEVziSIySyxpMUfboWWRAIIoroOdr
         IB4zXM2VMSWhXyLmAKgXDZfKmZvymHYXQvODPIVHbNzsBEcjL5j8q1LnLKaTrtgCg24B
         Qqbk5xsYBvXFOYaOPXkeEpsL0rMS+0oqsvqztAPiIYIj8pJttI4M1UVM0YFiThTScpIW
         VP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761231030; x=1761835830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FassfAN01QkxVDyy+Sa+b0ImlRDr/lRNphkFcyroU20=;
        b=Y6XdKeJZ/7pz9fbbs/aNxjocLIrsoXAr6G5GDfoZMWAe+xVRYVZOugnfI9T5+O89mr
         c0dWknUt8wTW4YVItbUCdVwSl8EofX5wIR+Va33k3e41t6x7Bp9LUQJTZnbGHIUrai4E
         5HBQDxaLZnW9umYvWRBeHbH70FiSS9AVN9Ysq8xKrE1P/1uYJWYN5f/4v9gLRZCZVsBP
         J7J7GF8PN58DDsa33MSh3A7aJjU0rNtjUR3fsls+LNnvUV5xZYBuXYH+OR4RNNz8DzlV
         SgLcjFXk+82NlWnP2XWkpEiDBvslrGpRsmTmPPG/GIRIhLBNnKJtZlaVlWoi06ljgfWb
         7nyw==
X-Forwarded-Encrypted: i=1; AJvYcCWiC/HiXSWIt/h5AqCG69y+m0n4vZZMHOJA04//ShmGTyMgPRIuBBI+JjRfnqr1I+7+Q2OWfkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBI3PR2ISRtQH6BJ7DCgKpSQ5C1z7JgQJDdSoHxdRTd6qb4Wau
	U1qOk4DtXBf3LzLh9BlJSKmOwKhH+n4XkwT39BnYk6LjiQ5aymADuuOi
X-Gm-Gg: ASbGnctg7lPMc7bxpxuKBP7AlkDCF2FNxHcgVDxZQtQYfpqnRvAeNBcNK1aUFY2BeKG
	4sNvgYAwEeWa09xlSV1Z8sGL4G2nnORmaxDXlW6FLr/pku/5IZcc0mqkgkUtBqNk2+dZpFPucOY
	u9qelhN5IB9k378si1K7pv6N+o89YHzOz6w754rpGYlqAizae9NUdBB2pPVbySzuuxbwwn+QvBp
	DIQTW+dxdkJXt4G2LQxuSa4OpMD95QLN7HqQGIcdyZyOvJOSgdSZPe4coXopNOlcFYZWOIhmvXm
	MbhtMZmUlh5Z512OkbkUr0e6AUpO83wpRh/umhUpQ1lpCw38pFHfpxJGfe6zs5WbUNnxHxxi6L3
	i15Fd9+44DZXs45g5o8j0I91CPXi+itQJ2gFB0GtEnGGuDKDrKEL8RX4arbkWv2mdrfNz2sYJCn
	Jd3aG3tLjRz7ZiEJFQa5PrSl3+raazxmA92ceWhluUTKE=
X-Google-Smtp-Source: AGHT+IEs+GoltQcKBTrzCzP/DJpfopqS9pIvzCpIjkp1sHlc6JzXCwJNHAdY8xhjwduT8SXTQCUp/w==
X-Received: by 2002:a05:600c:3b03:b0:471:14af:c715 with SMTP id 5b1f17b1804b1-47117874978mr181531815e9.3.1761231030000;
        Thu, 23 Oct 2025 07:50:30 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:aac:705d:f374:5673:9521:bde3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428f709sm102312175e9.8.2025.10.23.07.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:50:29 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Russell King <linux@armlinux.org.uk>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] net: phy: dp83867: Disable EEE support as not implemented
Date: Thu, 23 Oct 2025 16:48:53 +0200
Message-ID: <20251023144857.529566-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

While the DP83867 PHYs report EEE capability through their feature
registers, the actual hardware does not support EEE (see Links).
When the connected MAC enables EEE, it causes link instability and
communication failures.

The issue is reproducible with a iMX8MP and relevant stmmac ethernet port.
Since the introduction of phylink-managed EEE support in the stmmac driver,
EEE is now enabled by default, leading to issues on systems using the
DP83867 PHY.

Call phy_disable_eee during phy initialization to prevent EEE from being
enabled on DP83867 PHYs.

Link: https://e2e.ti.com/support/interface-group/interface/f/interface-forum/1445244/dp83867ir-dp83867-disable-eee-lpi
Link: https://e2e.ti.com/support/interface-group/interface/f/interface-forum/658638/dp83867ir-eee-energy-efficient-ethernet
Fixes: 2a10154abcb7 ("net: phy: dp83867: Add TI dp83867 phy")
Cc: stable@vger.kernel.org
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 drivers/net/phy/dp83867.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index deeefb962566..36a0c1b7f59c 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -738,6 +738,12 @@ static int dp83867_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
+	/* Although the DP83867 reports EEE capability through the
+	 * MDIO_PCS_EEE_ABLE and MDIO_AN_EEE_ADV registers, the feature
+	 * is not actually implemented in hardware.
+	 */
+	phy_disable_eee(phydev);
+
 	if (phy_interface_is_rgmii(phydev) ||
 	    phydev->interface == PHY_INTERFACE_MODE_SGMII) {
 		val = phy_read(phydev, MII_DP83867_PHYCTRL);
-- 
2.43.0


