Return-Path: <stable+bounces-197912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA32EC97828
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 14:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA1FA4E1B95
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 13:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A2B31197E;
	Mon,  1 Dec 2025 13:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="BFzekFpZ"
X-Original-To: stable@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC45F30FC39
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 13:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764594539; cv=none; b=GpYzJRS+GN84kKpK6jlhuJbW45IVTdowGJYyQhLnui8HXY05uRSscRj2PwT+mCUzR8ERPiBthc8DlT+uia3zMHnmlD0zAnCmBQzv2V5VS5fW/BvkuTckZ0drjvuFBNzmAmdR6Ad6LAP6+gXFuUDo6Vrs6/d3k8jz2yyKWumAqOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764594539; c=relaxed/simple;
	bh=SjMVAft78GG56/BCuZt3Bp0Uvy9eItZAxGbPXPwpVLQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=U/+D3s/N6R3cejvTaAf43Dn1jZddtrR+DwK2vhg58HyJ1fL0m3xCXZnSUK8mwU42u6uE6qljyG9OJiQEWk/7SH9liy5B/5+ocjiKJBzULB7RdKbA7/84VLRUamzc8pWt7oBGHDW5JWuBbbjI4hqe/anDQOFQSSh/bZzRFIlt6RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=BFzekFpZ; arc=none smtp.client-ip=43.163.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1764594531;
	bh=jNrnDOKauSrYoCvdV7jabzNAEAFD3X6uOVQpB2ugiCM=;
	h=From:To:Cc:Subject:Date;
	b=BFzekFpZVCZmyCbOukx8jfx42jlqiSkmj2fZM+BHZUtQAfWQuPLfjFBf5B9Pcimqv
	 0fTWoaSuPjbnW5ciY9q+WdEBOkI53to+88rmZp087ebWvZiVgCb3kUQKh5LJXuTW9V
	 NR+Q3zoFCtqpcHahHiEbFrFaIRJJHZCxX5OEzGWI=
Received: from ubuntu24.. ([120.244.194.103])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 21D1B696; Mon, 01 Dec 2025 21:08:29 +0800
X-QQ-mid: xmsmtpt1764594509triz09dbl
Message-ID: <tencent_8FC790E487B53D4E3B0C5D0332AD47CDC706@qq.com>
X-QQ-XMAILINFO: NQJsl5QovJ//PoZwCnbw1Xs6A8kRLSdJzIG7pSwZOddNNaMFG16N+MgIy9u5IJ
	 T00Aj8XqCwokirfkgBcu8hDvYITkHpAbLWmZE6nEOeSrduykETWYFt/jwXo6Hxs3cSCH7LSL1Jf+
	 +P+8HGY9UwENYlthI0PO2TyIbqcA4FTwjobTVqJFOL11wYe3EKgK76EQDgwzoRj31KIbrWrnqs/P
	 sYUIcLKbSLYlqEYvUuUcWNts/a4mBLc4skouug/NhY54mra3tI1f4CEnEfVfxZQtNpZdCd93Bmup
	 0IEwsU2hKcEFTpm0zsdqm8PMY2uJaInFc8kmazQlK27ONIGCZqLP9FQ7sTlcIt+AW6qf76g0PPL7
	 82ibwJsDQxYD6XdP4P7UZDHFR/6W1ffmsO5cvui8Tnpeh2XyYqoNMPQd0fIkFDdICLs40HRWxyHQ
	 4Cwcr6tcVyzLNX6r0ZIPZRcU2znCKyp55O+sr6ouck9ueSQhbPnpV71bZuky9TWAJBOWfc4p9VTQ
	 GT9bD8Kqe9jT5A5ud710D3+du0ltGpGbrZ9E/GnF0J8qpKwLc0XAzQiIXEJBDObny5yXefYEfvqY
	 keMCxQgA692vSMlCbA4AZuVMC32HvIeBisGA0NLkfe0npRC3c0OkXvEqOmE6ZOrrsdGibnVQ3uNe
	 xW0GCTeBBsDZX9N48GE6IC2PxAD88uz05K1N+JXZVz503Z9O+fYw4rNWxbToWINNiCjY7sGKNMF7
	 bYsO/Ht5eQJwjYukG7f76M3Zzdq6S0OJ6H0qJhKK57LUTwwC6FFcW1DdQdDhpUeHTjOB+rv/zdoU
	 9VWx8vjr/d+sN0iv2yZ5uMnckBqw/wXplZWgveBY99fRYBt96QQ6q4yt3f5x8HWIfAE/Ke3vltf3
	 THBVmp0TVem/xWY9GJN3kZF44mmtGAp2LQt9MCGxxzrhcv16c4GkiqU+xGPSB9zxxQYl3jMh2DAQ
	 3jQno3ZbQbGE6fBky3Nxokqpl0hPj/2Fq1VkIFtBALZLCCocpqR7g9+2Slvpb3RxM4iL9n6RGSEB
	 DrWSV5e2Ahxg4D0G+F25sF45qZPkR40Lpbk6QoJ7vXJZ+AAb2b6QTvESJus3YDorNcXp5QPw==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: alvalan9@foxmail.com
To: stable@vger.kernel.org
Cc: luoguangfei <15388634752@163.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.1.y] net: macb: fix unregister_netdev call order in macb_remove()
Date: Mon,  1 Dec 2025 13:08:19 +0000
X-OQ-MSGID: <20251201130819.4308-1-alvalan9@foxmail.com>
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
index 1ea7c86f7501..9da142efe9d4 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5068,11 +5068,11 @@ static int macb_remove(struct platform_device *pdev)
 
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


