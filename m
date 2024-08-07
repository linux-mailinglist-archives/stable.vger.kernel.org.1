Return-Path: <stable+bounces-65794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAE194ABED
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 17:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4741F209AB
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 15:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54F580BF8;
	Wed,  7 Aug 2024 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BNUGq4MR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8350478C92;
	Wed,  7 Aug 2024 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043426; cv=none; b=LIA2AhsSGDEWGAU0Q0avKvLRVLk7gz+FXm8nKzbTFkhN+ljobWEoYyFpinO5nVHPecpih/omaoOIzRBuqCNPznUp03IuV54RoB1Dnbm24wZQqtibl/RsVnLq2DLJrnryyXYyL9oFZce8r7as5BjzSGVA0XAygH9elM9rbqHEBIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043426; c=relaxed/simple;
	bh=FIGYimcaMq1i1qId/9i3RYI6XrdZe6aJzUMsCIsSqv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5hXZP1srZvkAeMUYfBuOgvh0uiVENccL3+5BJmx4WigpxPb7ePU/vriyjaBEokQZpKt3GBiPemflkUfL8JlNrXYXcffpXjEKMlX00Nx67hP0nLL0qJApfci+2jwIjb1lVxmQ8zHSKQd62FcD+RaDio4vIteDt779F0b2CPpecU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BNUGq4MR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132A5C32781;
	Wed,  7 Aug 2024 15:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723043426;
	bh=FIGYimcaMq1i1qId/9i3RYI6XrdZe6aJzUMsCIsSqv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BNUGq4MRqp/DDHqemUgF0T9qfgH0pD1C/EXaWZAOOjJI/2UAW9Eduy/pZ+Xzr/T0m
	 spL7ysatQtPclHePkRXbQSwxsoXmQa1FwFKY67/R8Bv3tL5Uy6Cez3AE9tPkjTKB+I
	 a2kL9RjqOBXyS5wP1T5yXrGQ7ORdfmEM+2YOgFd4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Russell Senior <russell@personaltelco.net>,
	Mark Mentovai <mark@mentovai.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 058/121] net: phy: realtek: add support for RTL8366S Gigabit PHY
Date: Wed,  7 Aug 2024 16:59:50 +0200
Message-ID: <20240807150021.312464799@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807150019.412911622@linuxfoundation.org>
References: <20240807150019.412911622@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Mentovai <mark@mentovai.com>

[ Upstream commit 225990c487c1023e7b3aa89beb6a68011fbc0461 ]

The PHY built in to the Realtek RTL8366S switch controller was
previously supported by genphy_driver. This PHY does not implement MMD
operations. Since commit 9b01c885be36 ("net: phy: c22: migrate to
genphy_c45_write_eee_adv()"), MMD register reads have been made during
phy_probe to determine EEE support. For genphy_driver, these reads are
transformed into 802.3 annex 22D clause 45-over-clause 22
mmd_phy_indirect operations that perform MII register writes to
MII_MMD_CTRL and MII_MMD_DATA. This overwrites those two MII registers,
which on this PHY are reserved and have another function, rendering the
PHY unusable while so configured.

Proper support for this PHY is restored by providing a phy_driver that
declares MMD operations as unsupported by using the helper functions
provided for that purpose, while remaining otherwise identical to
genphy_driver.

Fixes: 9b01c885be36 ("net: phy: c22: migrate to genphy_c45_write_eee_adv()")
Reported-by: Russell Senior <russell@personaltelco.net>
Closes: https://github.com/openwrt/openwrt/issues/15981
Link: https://github.com/openwrt/openwrt/issues/15739
Signed-off-by: Mark Mentovai <mark@mentovai.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/realtek.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 337899c69738e..2604d9663a5b2 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -1083,6 +1083,13 @@ static struct phy_driver realtek_drvs[] = {
 		.handle_interrupt = genphy_handle_interrupt_no_ack,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
+	}, {
+		PHY_ID_MATCH_EXACT(0x001cc960),
+		.name		= "RTL8366S Gigabit Ethernet",
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+		.read_mmd	= genphy_read_mmd_unsupported,
+		.write_mmd	= genphy_write_mmd_unsupported,
 	},
 };
 
-- 
2.43.0




