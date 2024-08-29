Return-Path: <stable+bounces-71516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AD89649BC
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 17:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41779280E1C
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 15:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5BA197A6B;
	Thu, 29 Aug 2024 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="r0uItXuO"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2135.outbound.protection.outlook.com [40.107.20.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E781B14FA
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944688; cv=fail; b=FeYoRkteVKAyyU5iNz5ALaq5gnPsPfx5A4KoAmL2xG9S9N3IpdmXi9FEStHpOJPotWgiLs7KNQ+AXmGrkBRWe9Sq+B7gALJvFrcFZOdhPR4NuADQyWKwpiX3GS1dXldm9/whLbYYaaq+AMg7m5l5YYBgecmf36+sPXXyaXs1qn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944688; c=relaxed/simple;
	bh=Wk5oi9ZpKnn78RSyuhD9qttsxMuzvk+scNGhdpKw6B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YXIFXWx8nh40F/bf81AaLo5hVlyPe5+lNudjH8TeV+Jdr3hTWSVtuKjRiZ7R9LWyWv/E8p++PYTjiBR23KMleNMCTqqW+VXg/8tyO3IjU+QH/hnEiaN4MxgLu6tpu9Rrq04/onIxWKGwWoobtt0Jq59XlyV/JEoqdCFH1RmrI+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=r0uItXuO; arc=fail smtp.client-ip=40.107.20.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvYqxTpMlgV7tkiv3jSPPpkTHLvTbb1/61QdtHrbN1Zl8MSpzS4fapnXjX04x9fHDWHwLEPeEOnO0sv/FtFnFRUWOBHqNQlO4ClicJVdywjqgE+Y5fxGEtqNcY/Cc6qX2gdNArKzSGoNcm3ugbjUe3WsySSVTXrubvrsO7umgYN9QDSYcv7v/5V3F9T0kZH1LHfWlAzKQiE1C5fLOEUinGXHPMOH6kvuTa0b/xunWE7ISEbSHEJC18/PlWpE0haaNfclC5PTveuPS64JpoYP16wyrb9V3OnP8zPY+8oTcFttttWOvFFPZFa+lOGjrinkv73QriANov5zHOqZ4BJ+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkjGahXIrnR3T0eWmHWnpZfcsCzoz/E3zlJ082d1uQM=;
 b=xQs2KOMFnV6qR09lWKPdrhyxGZ/Pda9bMWMavCSZfatbunyVUFqdypULnE2Hsi6qTy4BUohUmFRLD53tRjLv1L9UMEbLZfsvPki9z+vZ0MHZ+7aehI24fkH75hhbZqN/Hm/mwfMcWMfMKRWvfkxBVYiYC75N8ewE0CICTPbbSW27wYl+IrYxn8HWf74jzMJaUmE/yp/NRQjI/Xr76UvRGRTnsKJ6nNo7wgBIEHYFGHhLVprjfEbcj3BR1j8GhzBCzrmt4zxqWzY8PBnJ/0gbXwbeSrFznJnkPq58t3qiksBAN/znwi+BOxM347a8LAC08uGWowdcRJh1ANvVB4rp+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkjGahXIrnR3T0eWmHWnpZfcsCzoz/E3zlJ082d1uQM=;
 b=r0uItXuOGbqg0Nz3kku7EpOikKOH9RpYe9u1Qxd/MoqGs6qq7XKK3Fs1ksuaMwYRGBf0ysuN0eKDzCk7fjf/mhrtB+2PZ2vhj+ugXlB4ThDG+hGqdihlcbd0Fgw4r4X6if2ARTjjMRgcziSMhbtJzb62jaZ1KaEyaieiVlc69/TD/wQX9F3CaSigwGNcEG0QSZ9lxJz9D5uMamXDhEoRFlPdOZ8odoeXcfUMziSkyJFf5YnO0tU6NPe1+OvADnc1HfcBEgor4glUXaHKsO/toe5abjY+BzvuEqr6Q9XLC3LID9tSJB9Grr9YemIRLVUTRcj2MkJZqBNZKFfXXu2wiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by AS2P192MB2266.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:64c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 15:17:55 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 15:17:55 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH 4.19 6/6] ovl: call secutiry hook in ovl_real_ioctl()
Date: Thu, 29 Aug 2024 17:17:05 +0200
Message-ID: <20240829151732.14930-6-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240829151732.14930-1-hsimeliere.opensource@witekio.com>
References: <20240829151732.14930-1-hsimeliere.opensource@witekio.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0076.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:349::15) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|AS2P192MB2266:EE_
X-MS-Office365-Filtering-Correlation-Id: 45a9a86a-8a9f-4d4c-acbc-08dcc83dc1ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iIKDPMxDt2g/9PX6PodATFlifoRiqdPwkh/6KX1ECi2QSrBURYZbDEMPXCrs?=
 =?us-ascii?Q?LrfYQUPXjO6+z5Q+Y3VSpICX9aq6SHlo7JK2rjxK3bGHRxxOnncTmZ2FGMl4?=
 =?us-ascii?Q?gzxZOYNjvx733LCyN15oLn7QSiUkuyYKgJ5o+39uN2FTM0VXGrM8W/B6C2g3?=
 =?us-ascii?Q?f7GJqgA17uIo2Oejugu0t139IWFeiv3tidTmgp0MrnA8TRdaUNlwZvyvHP2P?=
 =?us-ascii?Q?4EYwbMgxI7KQnKhHjudAJFz4WrJHD7cSEVf0ubRQJ4V3QBpF4J1HlCB7Vv/5?=
 =?us-ascii?Q?emD9jscICL8deVpLjtXeJCABvNK6d2oziMX0xs7P2JtQ55UGw0ibgYXZu2GZ?=
 =?us-ascii?Q?Q9Dd3G02f3FaG/Eo6/RCpKogl/oF9ONYmqeXtXoWSgDHsliHKN5HMLhDQhlb?=
 =?us-ascii?Q?mGK5AX2/k4WzNRiyCfjU1OTzyfnQiB8b7ehR4PctOI2wrDD0KyiFYTObraNt?=
 =?us-ascii?Q?NZ3Roco8w3ofaKeD+A8MFvbOgWJod7H02XEF8e4kB+lIfBy3KU6+HaZM7L4W?=
 =?us-ascii?Q?em3GuYn7bAvgpANj48Hx2uMuyqlQ5hfAX0NBK0x5UCuDCAHXna/bss37yAid?=
 =?us-ascii?Q?NuzrmMcL9rjKEjgTjKBKu67SeXcrkFdl4/ZwE4j945r/62d8QMgNZHAVpcOv?=
 =?us-ascii?Q?DDp8Iobj7sWQn20WXGZCSgA4g4KC3E4XdUWo2wZmEO6he1Em+cUHJ0F8ANeR?=
 =?us-ascii?Q?P3krKWrfKdHg45aN52oFiuLEuVZmxqXlYS/FCC9n0drhYSGJEzBYVTWv3KFT?=
 =?us-ascii?Q?Ap+4ypYEGnRnQh1IOtu7WMkVFyWoqf29u5NX/Apl0P3btHPZXjMQmaXUavDj?=
 =?us-ascii?Q?dZJ5XBml7krQnEXYx2HKbiG6cVttWUyyesPd6Bb7vzR6PQJfKyRQP/6Z4//0?=
 =?us-ascii?Q?IM2ntZS4IbBQeRIhgokyVx+tSjXEfzCduxeiP+gVS1zrswxNqYUQQqJoSnAR?=
 =?us-ascii?Q?03sNgI8U2qwYF19IavMDFzVkpJ60AzYvdWwEM9PQKhwUnosDU7axdiemQWxV?=
 =?us-ascii?Q?tRhR1LJrz0yWqQ3x+LLabr6ri07O+FITSOO1BtKT4Jkytjdxn8tEa+ZU5Zej?=
 =?us-ascii?Q?6qPRK6d3wCRnObkQxn/TbaY2+LS8Rca9Dzi3QfcCjdMEqt+kSSoV5J3ykhZf?=
 =?us-ascii?Q?8/7g3a9VV7r/TZ7Blgl0tBXfjlvavFBrhhZCyzdC93WnadHD2iBPWIAS0MsK?=
 =?us-ascii?Q?JpL+FsDr94wfKzd5JjOQqbrtCFwqwQrq6HF0T1xZDBv9UWPbgquBQjsfsx/o?=
 =?us-ascii?Q?Ur5eo8+ZN82hwm+ebw3tC8D63GmDWBGdG10luGGAVlZ3nssdgxaqZ+/g32C+?=
 =?us-ascii?Q?yNV8PvVjSHNLq4yiwxJqNBPUGKoTBYP+EcGiwv3zAz1i3TbY1tBrAjng7evH?=
 =?us-ascii?Q?JMHNEql/aN7OAYH0kWFXUGLS12zBaD14ZXlIdCYd3BpVdUS7GQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UR06NSvr7jkguUIm2x1EJ2EfMeE9s3Is4kzzpNU8w3kVJi237qubWcMe0rIO?=
 =?us-ascii?Q?jXa5HL/2OLHH3wfPQxf++eTaer4QSoA/SmDf1LfYsp1rCN8Gw1i5dMOs/wAZ?=
 =?us-ascii?Q?vZiw6h5EZ4IoAkreoXzJorTm1zZ+LeKhNN03hMZ3L2w4iANQcoRKKhpCQo4G?=
 =?us-ascii?Q?9l9xOb2FyPf+JEb7FCoEIkPhiYfYCeGWRCzfkEppXXXL+BOSbAkl6/NZyqls?=
 =?us-ascii?Q?zuiondP3A1G7L5zGbdDhme+e1OD0HYedM2oUliUsKdLUiYiZd6ZYfSajq5Gu?=
 =?us-ascii?Q?dhccysBNesqNP6NjKwsHRiBog4Itj539ZKAh/mbKZb5+HZsqWBbDxLz+qxbD?=
 =?us-ascii?Q?NQB0+A+hnijJKPK7Z37purH3APiL7+SbLaEJnbobUzyrGnw+4rsoN7A6FKi5?=
 =?us-ascii?Q?DQ1rQ5eyWF4Xp68w4nLUJugnqHiaZ7oxqhYHD7lEYYvZ7Q4nmLrcXvnFohZN?=
 =?us-ascii?Q?fXlTjLAj8cQdbSEcQ4qcqgI8Wr459NT6DfQVEC5n0WHPKT1G6DZyyBNQkAin?=
 =?us-ascii?Q?S3jpLxl6AneXyPm4vCYcdOe97Sp74BvPzNtE3oVVjBudIIWONnc0RBJwgvpA?=
 =?us-ascii?Q?ckZsQHAqNrNSNx+UfDU9MZq+Vd+z9cC8bvXKswZ5t8Ixknd1sOnQhHMkzM/n?=
 =?us-ascii?Q?BEB8DThuQNxsCek3p5Ak5kQuNj2eAd1v/xuM6tWPV4GSl7nMdEUM84sMfv81?=
 =?us-ascii?Q?eawhl4SaydrQRURwpp6w9YVYbV50Fpl+cnM67tIARDFoiM2IH0YncPIcxjSG?=
 =?us-ascii?Q?OYVzJEMny54Iap5jZV/YokzpqsR/dnsST9REPGCd7lr4Bep/G8dVcvTJ3kxN?=
 =?us-ascii?Q?zL7mgDn0G3eSWGjZEcoNXI2Shr+47Frnxp8ccob6R7Whw2ncBF/2H7ny5pu3?=
 =?us-ascii?Q?D5kmLDOjQqajXSjP8RQUZMP7tnj1bkTvzrcyJU0zvwuKE/H8Mp9j82W6E8KO?=
 =?us-ascii?Q?BKdMuhhINz4gJg0V1Ji1AMGS3tGqoNH7ZrEZFgSMi8VdO8e9j4HJF9wLBGya?=
 =?us-ascii?Q?RGzONE7Yvh4biaSn1BEd3woMF9KXPpCn6yBNcfUE/4CohP43cHawn5m9DJ6K?=
 =?us-ascii?Q?QAwxE8/bh5XF7JpFb2qw0d9WiHi8/Q/et92IZD87d6quoQYDO3PpTVAOTj88?=
 =?us-ascii?Q?l9nCp2VCRWF5o/EoVSVj8lFVuRRsnkCc4iFMbCvDHDREUrbbM56ji0obC6bl?=
 =?us-ascii?Q?S7O4vdU8fX1Q8V28QEmWK0XFxWu5QpMkw6O+NQSdMaZrYZDjI34X/HF6C8Qx?=
 =?us-ascii?Q?rIGjwoAE62UMJET4BdwPOY++7OfYsDuFzcN0s9B+3UURoDljil2X4VoIBG+X?=
 =?us-ascii?Q?x1gL8h82+WwhP6YDJ/RPtK+SJqVN95sME9hrQFuhFIdwA+sSMzPkJT3Pba+B?=
 =?us-ascii?Q?Quuf//IYOqbSJvPhuKEkAoDTxPjy9xKh6pAI4uEADAVWA+I1ICpd+bjo7Ou8?=
 =?us-ascii?Q?pS6yiQMkkgdPbx2/OtB6pjYS8Nf42vBpsuFTmuI1zgTbFopFhs9OEhc5hbnA?=
 =?us-ascii?Q?RsXP7nlrhF9H1P0odT8wVomfffjmyUtFXccTOIzcM4+fbx03pQEeHotBAfdd?=
 =?us-ascii?Q?s4E/2MDOSqC8jN0CVA86O5d/9mPGmsmBCfFYHO4FyQbAWBvHOn2Rc4JnXMZb?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a9a86a-8a9f-4d4c-acbc-08dcc83dc1ed
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 15:17:55.2529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFwut1QyWkw50Lw43FNHuzNKk1WaQXeoPNqMgSqfmF9nWxWrgBbjTnGPY5qzU+nJ9L/RzCS7d0g/1UStJ/a44Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P192MB2266

From: Miklos Szeredi <mszeredi@redhat.com>

commit 292f902a40c11f043a5ca1305a114da0e523eaa3 upstream.

Verify LSM permissions for underlying file, since vfs_ioctl() doesn't do
it.

[Stephen Rothwell] export security_file_ioctl

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 fs/overlayfs/file.c | 5 ++++-
 security/security.c | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 65a7c600f228..470ea215bebc 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -12,6 +12,7 @@
 #include <linux/xattr.h>
 #include <linux/uio.h>
 #include <linux/uaccess.h>
+#include <linux/security.h>
 #include "overlayfs.h"
 
 static char ovl_whatisit(struct inode *inode, struct inode *realinode)
@@ -410,7 +411,9 @@ static long ovl_real_ioctl(struct file *file, unsigned int cmd,
 		return ret;
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	ret = vfs_ioctl(real.file, cmd, arg);
+	ret = security_file_ioctl(real.file, cmd, arg);
+	if (!ret)
+		ret = vfs_ioctl(real.file, cmd, arg);
 	revert_creds(old_cred);
 
 	fdput(real);
diff --git a/security/security.c b/security/security.c
index e8a53164e6b5..035d8d87d07b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -889,6 +889,7 @@ int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	return call_int_hook(file_ioctl, 0, file, cmd, arg);
 }
+EXPORT_SYMBOL_GPL(security_file_ioctl);
 
 /**
  * security_file_ioctl_compat() - Check if an ioctl is allowed in compat mode
-- 
2.43.0


