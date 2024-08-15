Return-Path: <stable+bounces-68392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D1A9531F6
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D60F1C244FC
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DF519DFA4;
	Thu, 15 Aug 2024 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XIoBlZE1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BA51714DD;
	Thu, 15 Aug 2024 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730424; cv=none; b=YbsyHYMG/xxn6tK9ZY6m8vs6G5hWxevv+xUadeYEOjSnJ2GEN9b0BSpktTfiEn5oUNsjS/cJWhTW+C5HFxXUlPD61lt/ooc9LklufaBltfrbGPHWvjdrSq4BouQ5UWsOu4yrizzunhVxX/9Qg3BV/SkxiJ+X0eR68ama12xR2xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730424; c=relaxed/simple;
	bh=Bxzyc8twNc3nesZWzQm1u18La4CRrT17E1D9nyiuhZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQskx2LvkcSitc5EGWtPgG1l8aTXncrpCqd93GwKBUvBc34TWb5eZ4LJ71+W2tAGAbJ3I0bEacb3CPpFNfPdw2m9DAC0fczWA94bt3msrCYcLQc9NSvagNvZ50DDt9bDfeSwy/V02C6ysXqyN96Rr3eC9Bla7IQdWwKDkyeJhcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XIoBlZE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305EAC32786;
	Thu, 15 Aug 2024 14:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723730423;
	bh=Bxzyc8twNc3nesZWzQm1u18La4CRrT17E1D9nyiuhZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XIoBlZE1uq4MzLYrxdJavNXwVjkzl0/f3BZ31yAfARiAddKN9OcMgMJrVqhdv+1uN
	 UPlpoiovRG9oT5JiUqr3ceHhetQz3ddcOxbxb2AuV2gHT8PFL7N7smzyt8WRwTTCbx
	 6PmWXczSNPHwk6zMPQ1+VUgUa1FrlFJAQDT967W8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 364/484] net: dsa: bcm_sf2: Fix a possible memory leak in bcm_sf2_mdio_register()
Date: Thu, 15 Aug 2024 15:23:42 +0200
Message-ID: <20240815131955.493722416@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>

[ Upstream commit e3862093ee93fcfbdadcb7957f5f8974fffa806a ]

bcm_sf2_mdio_register() calls of_phy_find_device() and then
phy_device_remove() in a loop to remove existing PHY devices.
of_phy_find_device() eventually calls bus_find_device(), which calls
get_device() on the returned struct device * to increment the refcount.
The current implementation does not decrement the refcount, which causes
memory leak.

This commit adds the missing phy_device_free() call to decrement the
refcount via put_device() to balance the refcount.

Fixes: 771089c2a485 ("net: dsa: bcm_sf2: Ensure that MDIO diversion is used")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://patch.msgid.link/20240806011327.3817861-1-joe@pf.is.s.u-tokyo.ac.jp
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/bcm_sf2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 1fa392aee52de..f259b0add5b2e 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -638,8 +638,10 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
 			of_remove_property(child, prop);
 
 		phydev = of_phy_find_device(child);
-		if (phydev)
+		if (phydev) {
 			phy_device_remove(phydev);
+			phy_device_free(phydev);
+		}
 	}
 
 	err = mdiobus_register(priv->slave_mii_bus);
-- 
2.43.0




