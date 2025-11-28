Return-Path: <stable+bounces-197561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86F3C91214
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 09:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C1333ABB16
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 08:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BC220322;
	Fri, 28 Nov 2025 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="PZnIGC5e"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5683E2C86D
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 08:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318064; cv=none; b=DNcbf6NukPkiIytJuCkQPLfC4Q34IqdMHxAajjdnEXTarmEMiVW6zLlxZKgadN195l8xql75po+S0hE9hNvNmx+c0LsWWZCkiThVaxqXE1unhdKa+5zxBSeJPfdWVz3BqYpwoCTpRmo6xIVPqoqAeCaXtPqW+QTehYh2pt9RY9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318064; c=relaxed/simple;
	bh=GQbJpoG1LtSGXft5pPIqFZfRwRxdDzYN9+kPyuTI2mU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Kshznw+2bq5Gd7kZnKPUIlcK/p97vF2V+b/XvZ39clUuL1KHjV5esauHR88QqlcLuycEYu4BliMmnGp+KgIv3/BLTvICwkUOEETvY4WEHyEY9VDXyj9hRSmbqStP2z2rqutfJWM89P9tx6LIaFuWY/qZacoMrt/gGCFCn27hrPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=PZnIGC5e; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1764318051;
	bh=a7GQkpFDWlYlJpQuTi5nw46ykB6o/vKL4q3CyuyyeG8=;
	h=From:To:Cc:Subject:Date;
	b=PZnIGC5egrXHxpaeyYog6D1f5J/wLCYsQPRZOAxnukeynwyVDfTkCDSDBeuA3udUX
	 231Fi7SrGaPJ83paN0HTg8fFylqnJtwsWvTH+aASIdzwQrOfgbJnW7XFldaXUopNO4
	 GMz9O0YMEnijYMRxsXCSPbO3rZm3LkWEaOwr6W+Y=
Received: from ubuntu24.. ([120.244.194.181])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id 5211B020; Fri, 28 Nov 2025 16:20:33 +0800
X-QQ-mid: xmsmtpt1764318033t2hfdjr8g
Message-ID: <tencent_F2AD3371E0603C1AC469096BAE3F7024DF09@qq.com>
X-QQ-XMAILINFO: MaaIYtAFx2QDXL/yklatKyCwsaUVdxPMcvUhkdTWGrp64QQ+wQhCn5JihNz4+5
	 Qi4o3pZtSgSLGZFFZKdBh/SR42SOG6lNdXmkXuAQnDHHsy7Q73u6YodFy3s2GEQdZqPZPFVRh0Bg
	 kHDwJ6mDHBaaz9cuJIaLgPAwFEKwAKJoSF0LuCwFYgin5b1Y6pQwtMyRu7khZPCKP8YBDwcWeSWz
	 4FvlQwytzqAMOed+QevyWwXc+w57bUyMGc4kFRXs6/rGte8VehphVqah7iWmt/y0FQYF4gI8nbbt
	 RwExj2hQGlQpW9Jd8u2OxTEAfe5g5rqP+EbATED361S7ZNdRmiYdV5WhgKNBomjN+jE9t/k2AxoR
	 O4BhH1nrsJB8ZHlkySAwC71Is4vCJdDLcBDIPJF2clFFkgPaqcUCkpEtdxed3BsRncHgvH1vJywX
	 AxhTF68mTsGuqJvczR0/WbaMRPb5biGKtfGCtLB6q4hN3cWjFBotsDiglDp6clIH+Jt0E5c1Pcl4
	 W0QnShJTpTQEMMLloqSLwmyc8g/k8WPMkRoHeMARTHl9Hdu6bYXkw7joF58m3BctNDE84c+Vg535
	 AGYcGBaL2sXhz6HL7+H2CpfacKZ0Yu0vVxz4X8v/7AS11utruGv/1LJLXjbbUUDVPrchVSsX6347
	 PLBKnQi1czFDmw1jyh5+ppN4aZMLwz3OpL3d2B51HoMehx0CEeRaNea6J9YF8473GBO9PnMA8pG3
	 Xl2m0Q9cF76GP2Xe+EuJv4FPOKSaTKX+ejseUwZ8ZmLNEzqV9gSe96Oa6VlscbAshD/0DUQHfN1c
	 DjP1jmUkbnPWVHHQeLW/+XvRRXTdPZlPpNoYE7s0d9yQQuszPfoQr6WIjcDR/Vq9t2fFuZoHwCXz
	 V78G55i8/9i6ajC4zezclOOgSWCF4lga2+YrVAZTm3OSEkyc6d+7C/XM9PUqYMG/TaWcSVqx2pTv
	 26KzDpb5905VLJmsQsqJEqBGyitzYjs6VQjDo6LqSNXYm0Rvhplp2hUmu3882IBv3XO93yWh6MPJ
	 C6zXdRdnqr4Gq9CPHKUHK+nZZ73ZhuppN2Z7YDUdY2MTUSrlQa5dZfVkMNfSljHR91reKJzw==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: alvalan9@foxmail.com
To: stable@vger.kernel.org
Cc: luoguangfei <15388634752@163.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.6.y] net: macb: fix unregister_netdev call order in macb_remove()
Date: Fri, 28 Nov 2025 08:20:24 +0000
X-OQ-MSGID: <20251128082024.4362-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: luoguangfei <15388634752@163.com>

[ Upstream commit 01b9128c5db1b470575d07b05b67ffa3cb02ebf1 ]

When removing a macb device, the driver calls phy_exit() before
unregister_netdev(). This leads to a WARN from kernfs:

  ------------[ cut here ]------------
  kernfs: can not remove 'attached_dev', no directory
  WARNING: CPU: 1 PID: 27146 at fs/kernfs/dir.c:1683
  Call trace:
    kernfs_remove_by_name_ns+0xd8/0xf0
    sysfs_remove_link+0x24/0x58
    phy_detach+0x5c/0x168
    phy_disconnect+0x4c/0x70
    phylink_disconnect_phy+0x6c/0xc0 [phylink]
    macb_close+0x6c/0x170 [macb]
    ...
    macb_remove+0x60/0x168 [macb]
    platform_remove+0x5c/0x80
    ...

The warning happens because the PHY is being exited while the netdev
is still registered. The correct order is to unregister the netdev
before shutting down the PHY and cleaning up the MDIO bus.

Fix this by moving unregister_netdev() ahead of phy_exit() in
macb_remove().

Fixes: 8b73fa3ae02b ("net: macb: Added ZynqMP-specific initialization")
Signed-off-by: luoguangfei <15388634752@163.com>
Link: https://patch.msgid.link/20250818232527.1316-1-15388634752@163.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Minor context change fixed. ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 7593255e6e53..bf7b5d1d5616 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5182,11 +5182,11 @@ static int macb_remove(struct platform_device *pdev)
 
 	if (dev) {
 		bp = netdev_priv(dev);
+		unregister_netdev(dev);
 		phy_exit(bp->sgmii_phy);
 		mdiobus_unregister(bp->mii_bus);
 		mdiobus_free(bp->mii_bus);
 
-		unregister_netdev(dev);
 		tasklet_kill(&bp->hresp_err_tasklet);
 		pm_runtime_disable(&pdev->dev);
 		pm_runtime_dont_use_autosuspend(&pdev->dev);
-- 
2.43.0


