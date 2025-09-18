Return-Path: <stable+bounces-170072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC36B2A251
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828A2189B40D
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9D2319860;
	Mon, 18 Aug 2025 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YK8qLnwd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193BF31770C;
	Mon, 18 Aug 2025 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521422; cv=none; b=ozJc+vYmaDHp8Zpgbs1r5TQ6TW/sBwjTkYqhaCMInBZdNqXGlTRYK4mpm/TNXqckAknOfsxvDeLdWgaELbxy7gVuQuBYrjFFT3anW6WLjnfDRtwnvRME1+IiUwHfltpwNVjpJ8q9RocQHwe87hRJqTwUUjJUyKy2KQklnR8rjlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521422; c=relaxed/simple;
	bh=Q8nXC99nLHhdoQPUCSH92PYxXlWML5rCOWf3cZWYFCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKMXYvQtnSF4KjTL9eK/ECku5vbj5jrYVHBAsJo+o+SFAZhknJYpHwLgMgCfcdTCth4s+AE0lOsQMJtxE09GsblrNehhphmmQG32C/+vsiGFkMdTgBbWzKtJ9Ry3C3g95R8b0x9r8xZMtU7SEU+g7rg/6haSxSV5gCelCaNncJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YK8qLnwd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B596C4CEEB;
	Mon, 18 Aug 2025 12:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755521421;
	bh=Q8nXC99nLHhdoQPUCSH92PYxXlWML5rCOWf3cZWYFCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YK8qLnwdj4OanX/Et5MtBoHBsz3KJQ5xtqlrmddSmdhNAwc0addlVtI8PrSbwgCHa
	 wDwL25EDj+28J/PBjZS9DZAmHyXmlVd7FAq2AyLDfpvdfXkmfzbWBQXUF3yDXwAhmJ
	 uG8WKriuh1s+V4vTb8ulZfz5M26mxTBMPR9qPOy0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 016/444] net: ftgmac100: fix potential NULL pointer access in ftgmac100_phy_disconnect
Date: Mon, 18 Aug 2025 14:40:42 +0200
Message-ID: <20250818124449.511247436@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
References: <20250818124448.879659024@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

commit e88fbc30dda1cb7438515303704ceddb3ade4ecd upstream.

After the call to phy_disconnect() netdev->phydev is reset to NULL.
So fixed_phy_unregister() would be called with a NULL pointer as argument.
Therefore cache the phy_device before this call.

Fixes: e24a6c874601 ("net: ftgmac100: Get link speed and duplex for NC-SI")
Cc: stable@vger.kernel.org
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Link: https://patch.msgid.link/2b80a77a-06db-4dd7-85dc-3a8e0de55a1d@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/faraday/ftgmac100.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1730,16 +1730,17 @@ err_register_mdiobus:
 static void ftgmac100_phy_disconnect(struct net_device *netdev)
 {
 	struct ftgmac100 *priv = netdev_priv(netdev);
+	struct phy_device *phydev = netdev->phydev;
 
-	if (!netdev->phydev)
+	if (!phydev)
 		return;
 
-	phy_disconnect(netdev->phydev);
+	phy_disconnect(phydev);
 	if (of_phy_is_fixed_link(priv->dev->of_node))
 		of_phy_deregister_fixed_link(priv->dev->of_node);
 
 	if (priv->use_ncsi)
-		fixed_phy_unregister(netdev->phydev);
+		fixed_phy_unregister(phydev);
 }
 
 static void ftgmac100_destroy_mdio(struct net_device *netdev)



