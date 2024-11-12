Return-Path: <stable+bounces-92631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BC39C5577
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BE611F21976
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE532309A4;
	Tue, 12 Nov 2024 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UqUNJjrd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6824E2309AE;
	Tue, 12 Nov 2024 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408078; cv=none; b=b7UM0Sq0IXfBPqC/GWU3m51BG2xyGU5e4qlzfAhiIP0aMnFA5MtWWvh56mV/PZ2gfO9qQckcdD5TVHJPn5zFdyOTAbk2mQQxdluPSA3TOy5gmsH79d54s0FnVfpO3VKPczXPhidPiAN/uojS3NHd6X1HxExvXd1D/sN7Jy4hlx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408078; c=relaxed/simple;
	bh=muUbxRwQd8HvaNL+yNVIwALoOq+en8sCrNkv/2Iu4tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8f3A2akkRxDoJy6er3qYEpEccXsW0ABSRE9cnotTZMz21JCLHenLKTaT+8zTMZzT8/3wm5p/SIqtYWHwM2RnNo4N6YDsf3oZuvkl2CBrYqkaDID1uwaoWjw0nCGQJvnImYXEDCYI5+7rmtkdLlBlS/MLGf54ekfWgCdS1y83/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UqUNJjrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5BAC4CECD;
	Tue, 12 Nov 2024 10:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731408078;
	bh=muUbxRwQd8HvaNL+yNVIwALoOq+en8sCrNkv/2Iu4tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UqUNJjrduV0OW+l1jr5bRL4jMCGrso+EgeIbbBcrKj9/B1oc6QeBWl/ScLzEOuFBT
	 NB2iGofsIbStFLI4QKQo818/DvyP21CAleyHh+R63EPeNV7Yzk8nJp1EvIKStP6Qc5
	 cl9BQfZxTbZAYWJQ9w4y5/E86xWu8955UI916URI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Diogo Silva <diogompaissilva@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 052/184] net: phy: ti: add PHY_RST_AFTER_CLK_EN flag
Date: Tue, 12 Nov 2024 11:20:10 +0100
Message-ID: <20241112101902.858346449@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101900.865487674@linuxfoundation.org>
References: <20241112101900.865487674@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Diogo Silva <diogompaissilva@gmail.com>

[ Upstream commit 256748d5480bb3c4b731236c6d6fc86a8e2815d8 ]

DP83848	datasheet (section 4.7.2) indicates that the reset pin should be
toggled after the clocks are running. Add the PHY_RST_AFTER_CLK_EN to
make sure that this indication is respected.

In my experience not having this flag enabled would lead to, on some
boots, the wrong MII mode being selected if the PHY was initialized on
the bootloader and was receiving data during Linux boot.

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Fixes: 34e45ad9378c ("net: phy: dp83848: Add TI DP83848 Ethernet PHY")
Link: https://patch.msgid.link/20241102151504.811306-1-paissilva@ld-100007.ds1.internal
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/dp83848.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/dp83848.c b/drivers/net/phy/dp83848.c
index 937061acfc613..351411f0aa6f4 100644
--- a/drivers/net/phy/dp83848.c
+++ b/drivers/net/phy/dp83848.c
@@ -147,6 +147,8 @@ MODULE_DEVICE_TABLE(mdio, dp83848_tbl);
 		/* IRQ related */				\
 		.config_intr	= dp83848_config_intr,		\
 		.handle_interrupt = dp83848_handle_interrupt,	\
+								\
+		.flags		= PHY_RST_AFTER_CLK_EN,		\
 	}
 
 static struct phy_driver dp83848_driver[] = {
-- 
2.43.0




