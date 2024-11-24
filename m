Return-Path: <stable+bounces-95064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9D09D7498
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEA98B2DAE7
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997332040B5;
	Sun, 24 Nov 2024 13:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCQGyXp/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A744205AA7;
	Sun, 24 Nov 2024 13:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455861; cv=none; b=fXER+3BYKqZNqyuZygtNhBclQQAKf9Ot7hzHLhPYgJkd0irlwffbvAehryOfu3HH/5qurPr3TZ+6lROVjZ9RInQwBtn4DapJNgAOTOdt+UkL4zyXUEmeX/USqXE/QW9ksSpn0E3KPFb/vZ7U1H8hKl4TiIiaYa+tuPFbwn3q7Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455861; c=relaxed/simple;
	bh=etKWQqRir1fnlJZqbLpLotJgPM+t6WIibgr+QZvh6WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUK+MVryAm97bjqq1mOH5ofeJUYGgTwRP+DFnQZmY+6ekMbtreCzXh27Aa2VQjgqGx6dDz8s2wrbZUSosQW4pF/FlmLXTOXqOAjDoJLqn92v12EjcWCFCWkGzukg3xcWrYcgyxxgnIQTUgH+c2MTDz8FsFFpg5B8KYUVgNvWki8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCQGyXp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF372C4CECC;
	Sun, 24 Nov 2024 13:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455861;
	bh=etKWQqRir1fnlJZqbLpLotJgPM+t6WIibgr+QZvh6WY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lCQGyXp/hKTF2//VOGlZPfU7p98FCcqun2SaHZl8CyETsSn0PhXBWEThkR/TG88Yk
	 ZRuVV/TL/1/Pa2zSegCrv5pUbJMota1fYO49VHgKPayvHoYwqNLunOWMrCKbImby2D
	 uDJUJnn17ZIk5Jii73IO8lBsC6FHb2KKloJ+TryjMqdxq7RbBBwuyIT8k5HAEZjV4X
	 PLImjSiPwXEJawwht2OKm7RT7Fv9bqqLVTPaVXaeIc9pXnUCWiJcH1OIA/O0/X+yi8
	 B/tHVOCdvrQRY52zt8p0XPNJpSwi6y55g5RvtjoqbSXIrd3mDJ7HsNijMifJ4EiO0d
	 K626uFwMKBuTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	claudiu.manoil@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 61/87] net: enetc: remove ERR050089 workaround for i.MX95
Date: Sun, 24 Nov 2024 08:38:39 -0500
Message-ID: <20241124134102.3344326-61-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 86831a3f4cd4c924dd78cf0d6e4d73acacfe1b11 ]

The ERR050089 workaround causes performance degradation and potential
functional issues (e.g., RCU stalls) under certain workloads. Since
new SoCs like i.MX95 do not require this workaround, use a static key
to compile out enetc_lock_mdio() and enetc_unlock_mdio() at runtime,
improving performance and avoiding unnecessary logic.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/freescale/enetc/enetc_hw.h   | 34 +++++++++++++------
 .../ethernet/freescale/enetc/enetc_pci_mdio.c | 28 +++++++++++++++
 2 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 1619943fb2637..6a7b9b75d660d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -396,18 +396,22 @@ struct enetc_hw {
  */
 extern rwlock_t enetc_mdio_lock;
 
+DECLARE_STATIC_KEY_FALSE(enetc_has_err050089);
+
 /* use this locking primitive only on the fast datapath to
  * group together multiple non-MDIO register accesses to
  * minimize the overhead of the lock
  */
 static inline void enetc_lock_mdio(void)
 {
-	read_lock(&enetc_mdio_lock);
+	if (static_branch_unlikely(&enetc_has_err050089))
+		read_lock(&enetc_mdio_lock);
 }
 
 static inline void enetc_unlock_mdio(void)
 {
-	read_unlock(&enetc_mdio_lock);
+	if (static_branch_unlikely(&enetc_has_err050089))
+		read_unlock(&enetc_mdio_lock);
 }
 
 /* use these accessors only on the fast datapath under
@@ -416,14 +420,16 @@ static inline void enetc_unlock_mdio(void)
  */
 static inline u32 enetc_rd_reg_hot(void __iomem *reg)
 {
-	lockdep_assert_held(&enetc_mdio_lock);
+	if (static_branch_unlikely(&enetc_has_err050089))
+		lockdep_assert_held(&enetc_mdio_lock);
 
 	return ioread32(reg);
 }
 
 static inline void enetc_wr_reg_hot(void __iomem *reg, u32 val)
 {
-	lockdep_assert_held(&enetc_mdio_lock);
+	if (static_branch_unlikely(&enetc_has_err050089))
+		lockdep_assert_held(&enetc_mdio_lock);
 
 	iowrite32(val, reg);
 }
@@ -452,9 +458,13 @@ static inline u32 _enetc_rd_mdio_reg_wa(void __iomem *reg)
 	unsigned long flags;
 	u32 val;
 
-	write_lock_irqsave(&enetc_mdio_lock, flags);
-	val = ioread32(reg);
-	write_unlock_irqrestore(&enetc_mdio_lock, flags);
+	if (static_branch_unlikely(&enetc_has_err050089)) {
+		write_lock_irqsave(&enetc_mdio_lock, flags);
+		val = ioread32(reg);
+		write_unlock_irqrestore(&enetc_mdio_lock, flags);
+	} else {
+		val = ioread32(reg);
+	}
 
 	return val;
 }
@@ -463,9 +473,13 @@ static inline void _enetc_wr_mdio_reg_wa(void __iomem *reg, u32 val)
 {
 	unsigned long flags;
 
-	write_lock_irqsave(&enetc_mdio_lock, flags);
-	iowrite32(val, reg);
-	write_unlock_irqrestore(&enetc_mdio_lock, flags);
+	if (static_branch_unlikely(&enetc_has_err050089)) {
+		write_lock_irqsave(&enetc_mdio_lock, flags);
+		iowrite32(val, reg);
+		write_unlock_irqrestore(&enetc_mdio_lock, flags);
+	} else {
+		iowrite32(val, reg);
+	}
 }
 
 #ifdef ioread64
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
index a1b595bd79935..e178cd9375a13 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
@@ -9,6 +9,28 @@
 #define ENETC_MDIO_BUS_NAME	ENETC_MDIO_DEV_NAME " Bus"
 #define ENETC_MDIO_DRV_NAME	ENETC_MDIO_DEV_NAME " driver"
 
+DEFINE_STATIC_KEY_FALSE(enetc_has_err050089);
+EXPORT_SYMBOL_GPL(enetc_has_err050089);
+
+static void enetc_emdio_enable_err050089(struct pci_dev *pdev)
+{
+	if (pdev->vendor == PCI_VENDOR_ID_FREESCALE &&
+	    pdev->device == ENETC_MDIO_DEV_ID) {
+		static_branch_inc(&enetc_has_err050089);
+		dev_info(&pdev->dev, "Enabled ERR050089 workaround\n");
+	}
+}
+
+static void enetc_emdio_disable_err050089(struct pci_dev *pdev)
+{
+	if (pdev->vendor == PCI_VENDOR_ID_FREESCALE &&
+	    pdev->device == ENETC_MDIO_DEV_ID) {
+		static_branch_dec(&enetc_has_err050089);
+		if (!static_key_enabled(&enetc_has_err050089.key))
+			dev_info(&pdev->dev, "Disabled ERR050089 workaround\n");
+	}
+}
+
 static int enetc_pci_mdio_probe(struct pci_dev *pdev,
 				const struct pci_device_id *ent)
 {
@@ -62,6 +84,8 @@ static int enetc_pci_mdio_probe(struct pci_dev *pdev,
 		goto err_pci_mem_reg;
 	}
 
+	enetc_emdio_enable_err050089(pdev);
+
 	err = of_mdiobus_register(bus, dev->of_node);
 	if (err)
 		goto err_mdiobus_reg;
@@ -71,6 +95,7 @@ static int enetc_pci_mdio_probe(struct pci_dev *pdev,
 	return 0;
 
 err_mdiobus_reg:
+	enetc_emdio_disable_err050089(pdev);
 	pci_release_region(pdev, 0);
 err_pci_mem_reg:
 	pci_disable_device(pdev);
@@ -88,6 +113,9 @@ static void enetc_pci_mdio_remove(struct pci_dev *pdev)
 	struct enetc_mdio_priv *mdio_priv;
 
 	mdiobus_unregister(bus);
+
+	enetc_emdio_disable_err050089(pdev);
+
 	mdio_priv = bus->priv;
 	iounmap(mdio_priv->hw->port);
 	pci_release_region(pdev, 0);
-- 
2.43.0


