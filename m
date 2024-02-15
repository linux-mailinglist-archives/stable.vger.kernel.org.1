Return-Path: <stable+bounces-20281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D36856707
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 16:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3879B25ED7
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 15:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4778E132C1A;
	Thu, 15 Feb 2024 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="FzPoi+aP"
X-Original-To: stable@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2131.outbound.protection.outlook.com [40.107.8.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1B4132C02
	for <stable@vger.kernel.org>; Thu, 15 Feb 2024 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708010183; cv=fail; b=LlzKrEq0b/cr/z8Db7hZi+VnOJA+mxURDLKQ51BKJulrtkjRWkKArjCaMF2+QFgNFOitZux79T3mt7yb8ooVWxSRClnR167G6a4SLVowMXRW+0xZwZujhP0AvBYev07DP/+qV2ODFzuTNKBYzrjzxkAbsv8W6vG9SAlLxgNRjq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708010183; c=relaxed/simple;
	bh=LzKa1DFdjLybaYw7BAOhUZBO0ZMaffDYxi/mbngvLuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qN0NW6SzYItmFr07vG+Qr9iEAid6D3jSXPe482oN/kjZxgIK1JMNKy1BssdIrtHqqsNfictHQweFZn3KCmf5lJ6yc+6LhYwoxjvvl+E2NKKIOsWTFWL8jCDNn3YJg3HOjOEPgxhcmV5zJp2wQ09Cy2FWSQhbnakNKCzC8P9u70c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=FzPoi+aP; arc=fail smtp.client-ip=40.107.8.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnI/xdacO8gK8LgettzHgvzy/VbBOl9izqH/3f0/zVqns4LaDQmTGT7LDZX2XB1l4CmWI0jQ3nZ5WdIHDS7JlCSn0QRzrYJkKYlTKd1Oohq/FWWw73ViOo2Msx/h8YFHrJOI8hxrX9HFKltN9l3Mc9DFgXZUbGqgDU+7sFcGcZyjrPehzi2bHniTV5kHGlEq1JtkVHDlL1umfxI94+KFsE3GyemOpXNAW3UPWgnmA54iUvAWYgCGQ0rjFppVnb5S++cgWdS/XuaOj3iOZZ/FiYRD1cHBp+Oj8y5PnnBOqUGEwm9gTR7t3xsCkdwbwVMURxr+Qp9a30ashSMRyEOQEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWoPNAxUrMlP0BhgP1bnqBsXZ7U8gP5AKL3Wc2rKjJo=;
 b=aA6zDSNfUAPei14ekLZ6wwkUxdC3StHuuKHEun8cUNazJLUOAF+/STeDcvmJyxZuoWhU6WQJ73iwtP3fUdDuvky1lYdctnogFSEQJ/ZxSA0Sm/AYiM2OlPkGuNZxaaHuTyvJiuIdnNJxWmYVcEhyCQFSF235RoDq6sAKAWEvWqQadU3bXgEC1eMEPhill7Q4Nou/YSyG4ibGC387P3Rq0783Js9dABpHTXVu5ibyfC7uibAx5tuGay57WdVjewvWn/En2mReuMlTFZtpoKLEUSC+fwKX5IMAMISGF+CZDZdaqVhe3AFH5875+A3ieSFtgZ7KnoYmItedif8FHhddpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWoPNAxUrMlP0BhgP1bnqBsXZ7U8gP5AKL3Wc2rKjJo=;
 b=FzPoi+aPyjOnlWfDn+e+Qgn74+CIb/Y8FKhkhJYgkX+oBEI4kHDq0LJ8I1gyI7HQ8tzclFEBVttuUnOPVPTmQcJn2UEO3NvYdAYWjb6SldBDTkb7Kq+Lt8KxjsgRMEl3p8oylLU8qhyEqqb4OHFm88+7HYfwXtlVDlqVHo3TIqYD6U9+76XMaoJbph7ivzRlOxiyBSTzLQfchlLMlBM4QgyjnR9FNjf7Nu5/g+1JCE9zFdZXh2cvjndqSEeupImvpbm8wUlcVuXvzvKw0uUou3HgOZqwZsaS46lYmNL3i/XkQAm14jpaQbPv7X0sxo0w5hcqQAriixV5/MioHE9Nvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by DB9P192MB1539.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:33b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 15:16:13 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::9a43:c1dc:91c3:186c]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::9a43:c1dc:91c3:186c%7]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 15:16:11 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH stmmac 4.19 2/2] net: stmmac: fix notifier registration
Date: Thu, 15 Feb 2024 16:15:27 +0100
Message-Id: <20240215151527.6098-3-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240215151527.6098-1-hsimeliere.opensource@witekio.com>
References: <20240215151527.6098-1-hsimeliere.opensource@witekio.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0059.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34a::19) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|DB9P192MB1539:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eed0ff6-67c3-4482-8a31-08dc2e390b5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d9KVvytknscNB+s/APR3EPRg22pE17tL8difhTzlhnL5Z7qxeTpYUuRW0MD0xQd+Yt4zjDSrqVpuY2abb175DKvzH7UZEBdFtdtCJKg81+3mJ9oZSBGZC44+KR8FwvvlxiO/WsHC7MCtkFg+CbixI1/hUP6IMIFn6ou7IKWvZ2D7ojjYGGndx51oxucbmG9AqWEF0/dO5F875YpmS8etPY+Y2K2rzycZQBfLHTxNJ6qb8CgJYrWYN98sZn/j9M9bGLwQzayHur9/b2M814YTV56JRGPA9QEx8YNCZNohILrWF0bfBjMfzU8lAm40GFnJYonRFejoO0wTnavp9gfBFYex0uQsVuyensZ2iIjQv0L5FAh+SQUkFkREpdnTo0LCRC/kUWLCmpOBhD5/YaBBUycjzDs3gP0azhafz0sYnXeAyvoi0inyTHcwgTuFwfAu1xoRVtRREOTUlcZi2T6pJvjlmrKKfW3rXihuQyYHTROZ9S/WdcJG8CYuXo978twUc3+CGzOo17nRFtLngku4GpIiqAa3IgAsJ1NpVDj9P5yQRaLPn88+mG+eSuQTR3pHidVKcIhGO+3dsipQ55nrCt8QJ85sREnsrv+Fzqjo0/RF2f9AGBrLBfnnBJ6h6QZf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(376002)(39840400004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(6666004)(316002)(54906003)(2906002)(66946007)(66476007)(6512007)(6916009)(5660300002)(36756003)(66556008)(8676002)(4326008)(41300700001)(478600001)(26005)(52116002)(9686003)(2616005)(107886003)(6506007)(38350700005)(6486002)(1076003)(38100700002)(83380400001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IQR+l/M04wouBnc+4jMbM770VBrBzGw3UQi81+t/KfPkokNEfkIpsrfJ0I20?=
 =?us-ascii?Q?TUX4TgjpDfhx3BJe0ldXqfqldOiH7yNd6CvBuVQLRj068FZ2l1XGo7obgxcH?=
 =?us-ascii?Q?pa2DRyVgnhUmo60ZT8P6cs/epmEHEz6ZHbwQQhFwbowJNDMrAuwOcEsgG7O1?=
 =?us-ascii?Q?7ne3eiP0EZNvR5goBx7SawHBYDfBnuFk3S22xk/Al0pTnmf5owi+CFTDCxW9?=
 =?us-ascii?Q?pcGjjx3bKpznkdpaFDJY9D6Sr+1+9D5rprgHUUDy9IdIDNrv+n2aLLtyWuO0?=
 =?us-ascii?Q?cPvwOMtpTLN825NF2lDxSsSO+PNczvXWnhLyY/k8VXd+Ux51GA8Nd56/Tc3G?=
 =?us-ascii?Q?ouVo6EiGl19S9BBBwcjexr+RV5BPhBuHSFcLmOAY1hj1DThahyVWKmjVWpC5?=
 =?us-ascii?Q?o71ggqeSVmPt3LqsLKNQIeU/x2q16YtH/9Rnkij8dUQYuWfti72ViwbYfkvB?=
 =?us-ascii?Q?yV5GZQtCP8wWcJOsICsMbaCzhKaUGRCrjpjF16+lUcmad+DJZf1zNZUmoKsW?=
 =?us-ascii?Q?ePEGfsAJndLie7AgzVU/iZD5yiCC7wKvvI1+nPyUDfjNnFY46pQipl6gzZbj?=
 =?us-ascii?Q?jYptnsvjP4aUQuOwZSxhI3LOiPF9/+K53+1NcKYStqoQuFIyBZltg86N1MqM?=
 =?us-ascii?Q?WjSWtovmwYdEyzMi07SFkXIQaMYgSIScBjgzMwfQRCGMb/VsQzomWLzM+YBg?=
 =?us-ascii?Q?E2m2VEsbBz8jYQN2docaxTKG6haknFlqugQhpQ55DunWFut90r46HrtNRRVf?=
 =?us-ascii?Q?q0xdwuMTB78zhQLR1Vac6NcZ2gzfY5MzNrRvIki1LVPMx74DBMLEej8k6Rlh?=
 =?us-ascii?Q?lToU8DdJ7X1jExbFSrxCtPA1Pls+vuTz0U3kbfJykV9+Kz2QezR7qJVPShDx?=
 =?us-ascii?Q?ITWVJT5bl5DgePLaG3ncTZlGMJ87S84KCq8II528nk870RvGRNfbjVHAydYn?=
 =?us-ascii?Q?LypQDHQjWW0RRTlv8MCwxB8GlqGCCbErI2QRmwq8sh5173XVRt1E1c87deM6?=
 =?us-ascii?Q?1ReaF+v5AGD8DwkW0BeyiSw1qjVqI5vv3N9WHXVFfzqp5cDxwH103LdIWkFb?=
 =?us-ascii?Q?14fw7CI1i6uDK2Or/+XjJAm0VMm2+5sER8DwvdjXrYbVTbrgkBqW9AYqEJSt?=
 =?us-ascii?Q?Xk8uOMekkWVY3iOpWSUtHDeisvxmVhKeUh7m8nWT7bxnOsIKvggP7jbQgvvd?=
 =?us-ascii?Q?+yPOZNS++G56m8xRHDPn/4tUwFzRL5ThaencG5+W7TalQ7WEZHNpo76M5XOm?=
 =?us-ascii?Q?/kimK6wpWaGELmV6vng4CQCrKi4k53QjvORDFQJG6OJp9FvndeUAlCSAj8cn?=
 =?us-ascii?Q?EH66lUZgLFOwfWlTXDNYljjhADVIAxsdDWUf9KZwBHYAnEdFy4i/YPWrdTeu?=
 =?us-ascii?Q?c1FP3QkWYKsuCPXheqJ9/ULAIDylIbqKPtbPdVpDEkF/Ho8w4f2V2OQIhdZq?=
 =?us-ascii?Q?DrDzpdex4Cj7IabazZDYg7SQUZwitTJCx0aXX5yko1+jkvV8rnlC8XmB2hvS?=
 =?us-ascii?Q?M6L4WUeLufIJnrCgfwpj1ySI8/qTc2GquTGoBtudvyOl19PpzMjlyIFVdQy4?=
 =?us-ascii?Q?Nv5pbF/FStt+EzcRm3MPCPNUI6VLb3Qg1gqCgwbZ+SfRSa728Xg6qw7eQglT?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eed0ff6-67c3-4482-8a31-08dc2e390b5b
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 15:16:11.9234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxrpQogG698fFrz1NDFJ2+XeikNZuOctSLrzvJSmLJ74iIR5wyzvUNjAqliC6UCTzGXQEtN2poMt5Ezgb2BJNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P192MB1539

From: Aaro Koskinen <aaro.koskinen@nokia.com>

[ Upstream commit 474a31e13a4e9749fb3ee55794d69d0f17ee0998 ]

We cannot register the same netdev notifier multiple times when probing
stmmac devices. Register the notifier only once in module init, and also
make debugfs creation/deletion safe against simultaneous notifier call.

Fixes: 481a7d154cbb ("stmmac: debugfs entry name is not be changed when udev rename device name.")
Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 6ee9c447ac43..f62622410355 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4067,6 +4067,8 @@ static void stmmac_init_fs(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	rtnl_lock();
+
 	/* Create per netdev entries */
 	priv->dbgfs_dir = debugfs_create_dir(dev->name, stmmac_fs_dir);
 
@@ -4078,14 +4080,13 @@ static void stmmac_init_fs(struct net_device *dev)
 	debugfs_create_file("dma_cap", 0444, priv->dbgfs_dir, dev,
 			    &stmmac_dma_cap_fops);
 
-	register_netdevice_notifier(&stmmac_notifier);
+	rtnl_unlock();
 }
 
 static void stmmac_exit_fs(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
-	unregister_netdevice_notifier(&stmmac_notifier);
 	debugfs_remove_recursive(priv->dbgfs_dir);
 }
 #endif /* CONFIG_DEBUG_FS */
@@ -4455,14 +4456,14 @@ int stmmac_dvr_remove(struct device *dev)
 
 	netdev_info(priv->dev, "%s: removing driver", __func__);
 
-#ifdef CONFIG_DEBUG_FS
-	stmmac_exit_fs(ndev);
-#endif
 	stmmac_stop_all_dma(priv);
 
 	stmmac_mac_set(priv, priv->ioaddr, false);
 	netif_carrier_off(ndev);
 	unregister_netdev(ndev);
+#ifdef CONFIG_DEBUG_FS
+	stmmac_exit_fs(ndev);
+#endif
 	if (priv->plat->stmmac_rst)
 		reset_control_assert(priv->plat->stmmac_rst);
 	clk_disable_unprepare(priv->plat->pclk);
@@ -4679,6 +4680,7 @@ static int __init stmmac_init(void)
 	/* Create debugfs main directory if it doesn't exist yet */
 	if (!stmmac_fs_dir)
 		stmmac_fs_dir = debugfs_create_dir(STMMAC_RESOURCE_NAME, NULL);
+	register_netdevice_notifier(&stmmac_notifier);
 #endif
 
 	return 0;
@@ -4687,6 +4689,7 @@ static int __init stmmac_init(void)
 static void __exit stmmac_exit(void)
 {
 #ifdef CONFIG_DEBUG_FS
+	unregister_netdevice_notifier(&stmmac_notifier);
 	debugfs_remove_recursive(stmmac_fs_dir);
 #endif
 }
-- 
2.25.1


