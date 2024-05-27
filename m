Return-Path: <stable+bounces-47023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DB48D0C42
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85FC31F21E6C
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1624015A84C;
	Mon, 27 May 2024 19:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vMUzI54J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AF7168C4;
	Mon, 27 May 2024 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716837466; cv=none; b=K6SJYwBg3rhzsY+teisxkBHbYtCN86eN4HQtzD7IZ1OE/yHPvDJp/IJs2F4716EIU9qjYOTYvyXyfbULWIB+vwu2sYNj8HET4WHYiCm0eaJp1bUby2ko5qZJge1Al3e1QtAYToUrFWJcf1zG4CHB538pFZ/V6ueaYC+51L/L7oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716837466; c=relaxed/simple;
	bh=OGC/KalHXOaVjDu8J4nkx5pY55pX9KqWG0DAFUKAQSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9vy9QvlePaUkvxqLkKqETfqKU5XUOQOUdTgK0i3zwAiW462oLJGRlW3H7S459v6Xn8LzxyFG3/myAajIO41pVnAOc2/IjycbbjiNW3S8PnM5dqH286GobeyKT5dz2C5dDe1GbzacXowC19tvYeLpKXyZDap0cTCRTD+MZ5HLKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vMUzI54J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5F9C2BBFC;
	Mon, 27 May 2024 19:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716837466;
	bh=OGC/KalHXOaVjDu8J4nkx5pY55pX9KqWG0DAFUKAQSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vMUzI54JcyOBpbZYkonSekLy0wEKKc0dJSTwTEtcXlu3DqM3WKpEa7uY8h7N6VQzi
	 XJOcSd8ffAklpoj10IGD5CDhoKuVAkMigHyU3Pf6/mOlX7nBRGir+Apt2vBAnMY3bf
	 N+IhLtAjFX4z3zMa+aGzqEOxCJD+eMSW5NtIV7yo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Romain Gantois <romain.gantois@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.8 022/493] net: ti: icssg_prueth: Fix NULL pointer dereference in prueth_probe()
Date: Mon, 27 May 2024 20:50:24 +0200
Message-ID: <20240527185628.725564862@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
References: <20240527185626.546110716@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Romain Gantois <romain.gantois@bootlin.com>

commit b31c7e78086127a7fcaa761e8d336ee855a920c6 upstream.

In the prueth_probe() function, if one of the calls to emac_phy_connect()
fails due to of_phy_connect() returning NULL, then the subsequent call to
phy_attached_info() will dereference a NULL pointer.

Check the return code of emac_phy_connect and fail cleanly if there is an
error.

Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
Cc: stable@vger.kernel.org
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: MD Danish Anwar <danishanwar@ti.com>
Link: https://lore.kernel.org/r/20240521-icssg-prueth-fix-v1-1-b4b17b1433e9@bootlin.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -2156,7 +2156,12 @@ static int prueth_probe(struct platform_
 
 		prueth->registered_netdevs[PRUETH_MAC0] = prueth->emac[PRUETH_MAC0]->ndev;
 
-		emac_phy_connect(prueth->emac[PRUETH_MAC0]);
+		ret = emac_phy_connect(prueth->emac[PRUETH_MAC0]);
+		if (ret) {
+			dev_err(dev,
+				"can't connect to MII0 PHY, error -%d", ret);
+			goto netdev_unregister;
+		}
 		phy_attached_info(prueth->emac[PRUETH_MAC0]->ndev->phydev);
 	}
 
@@ -2168,7 +2173,12 @@ static int prueth_probe(struct platform_
 		}
 
 		prueth->registered_netdevs[PRUETH_MAC1] = prueth->emac[PRUETH_MAC1]->ndev;
-		emac_phy_connect(prueth->emac[PRUETH_MAC1]);
+		ret = emac_phy_connect(prueth->emac[PRUETH_MAC1]);
+		if (ret) {
+			dev_err(dev,
+				"can't connect to MII1 PHY, error %d", ret);
+			goto netdev_unregister;
+		}
 		phy_attached_info(prueth->emac[PRUETH_MAC1]->ndev->phydev);
 	}
 



