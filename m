Return-Path: <stable+bounces-249550-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDFRKahFDGrQcQUAu9opvQ
	(envelope-from <stable+bounces-249550-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:12:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CB557D480
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3C353162CEE
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 10:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE2D3C276E;
	Tue, 19 May 2026 10:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MbuB4iV9"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011019.outbound.protection.outlook.com [52.101.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80974CA298;
	Tue, 19 May 2026 10:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779187160; cv=fail; b=t6mClS2oH4sON7UO3FRn/CE+3kGtzoDQAMTX1gbAwqHJlrmdS3mhGqP9WJhTZDFiraHytYphYq0lRdYlM6/ZYRapbETsWhW7z6oTp+rITNpfo5L07vW+zwznemBXmsEXWCQbxKkz2brSCdfT54Wbv5YOfgt+eIYjME7i/NtalVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779187160; c=relaxed/simple;
	bh=QaGIwFYcU9l5mRO1kQLxzvOyJp0w6Pau6plMVNa3d/I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZEJ9oN5wBTCM48juHZoEWZrxwg+NM/Wq1QaOWusf0OXsyAJQ2Gs4mwCv5PXEIUdiv7TLGaQLGn37p/k0nMlFsgmr4oURzPL+HhSYgXiZIS9pkVs8c5NkLSdZy7xPrD63+TJvBJ+pUZIH7wRKu4bpMhaIpNgU9Xu7V8lNgnOeljA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MbuB4iV9; arc=fail smtp.client-ip=52.101.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jyanqfwM9uI+rohYDjoCAo4zv5nQUnfeiW3JXfaf0yhDBHO/r22f1Od8plA2/s8jbn9uyKVkaPFe3IqW/DZk5itnM5Ec17OkQ56BURKR9hP5R7aqQU0897FWK/Lwj3y+qzGiO9+GJpWHcB0Ii0jED+rkikIK1ZVXwjBzypmHwJlsTP2DgJMmPzypdP2DPHriGLVGeEDK+EK7TcGmbF+U0tkWUjciEe5fU7+LfmivU9gc+NKyA3a5y+NFPsZRDMcwMuT7DJoc7eoc/OFVqdZO+LzLLajRe8YBGCLYHwARzuNFcHWC5HOoX/2cmB7f5ytoVMAVocDL/EtVbEhJMRrlkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1IBx4keQFN9s/34L+0CKXHlf8MiVBJqaeJffu/liHo=;
 b=hlltD35XE8hUsClqYY9tFKElwjHeXsaqnoHWsQoxOrOfbDQR6gYG0ESVpVumc42uFNG0z5zE7qI/cHM7E8Fd0GbhTE1F5VN3gLMLruSCjfTm+RqTYKHED7tE6NiCPANjVEYeWagBg+wpki0l6BGgxQU0zvK0XZf5hx6y7FIhm7vLGbEwtWpmH6U8xoYgKdRM/SWhA3EQKvvOqx88qjZEyblTrhjcjdxuaXxXOfMZikOTvomscOZK6V/HPIqQfHIZH86IBcPuOk5/whH2NJGL75NomZ2wJwvETh7roa9hkoFawYoxsc0Rtb6dL0SR9QlK65/AliqfBD2f7PgR9DIGvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1IBx4keQFN9s/34L+0CKXHlf8MiVBJqaeJffu/liHo=;
 b=MbuB4iV9LqQk/4nIigXooSmHU4AK0jUVVIgWSO4P1lQmZmDyXXwqd3Bi81nyqv8yFpaDUKVwIEcLDJgpaMjNw3q/3xFpyPGiDXM2P/kz+NFrvVZ7wbPxNQIEk9bdzTnNRPpE1qgl44D5oVgqJ4EIs8iH6gy0CWqkTUmojZjPq8OBm42Fmpy31LH1wNLYynEHQc7esw5D/k03foK1aK//pijrlCX7PaWE1lcyapQVw/AnubP9jQIeBKYl3JqCUoAbGekJs5qbs9jCELXKxRevyKa7uW6nBiO7rDUjPSb64wPIqs26ibMcaIsHTB85z8lvvw7Bbz1OgXz7f2R2xFOIGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by AS4PR04MB9337.eurprd04.prod.outlook.com (2603:10a6:20b:4e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 10:39:14 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 10:39:14 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
To: aisheng.dong@nxp.com,
	andi.shyti@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: carlos.song@nxp.com,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] i2c: imx-lpi2c: mark I2C adapter when hardware is powered down
Date: Tue, 19 May 2026 18:41:06 +0800
Message-ID: <20260519104106.2794103-1-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0028.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::20) To AM0PR04MB6802.eurprd04.prod.outlook.com
 (2603:10a6:208:184::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6802:EE_|AS4PR04MB9337:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d9d6177-1e87-4188-4f3d-08deb592de82
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|19092799006|56012099003|18002099003|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	w+UvYlGW1zgULEJ6ExPcPFSBUm2KVaOSJ56hWSJUahmL0HGeCHVISsVKQ1h8yOQpuJ6ynaqkOESFMhJ1vEVsAEg6vLi7ndpVBRxu1xeyL7yZQhqiDbfQsQkjwhMWhQofHXHA41zDmtgL9IiOzJiMvgUtfvtjxeY+sD6iK6njDBiXqh11X6Y6NHhmrcM8I6pOq9PhhSn56FZGWNVkGe3EpQKoUNh3vv0ttpogZzMPP2nB0L3lRJhCRmEU2paYqrCWu3ipo7f9daKr+afxM3GcQVHEkpHhE6kk6I+v6+6O/9X03MPDmhoFlgWqVbksUF2KfrW6mjpXsLyDIb9Q+FQQTdV0mYUCOtGEn0vPt8CCyOJsDr7oMEHAhJc3ALVORX0PDMiURaRJ0NXDh5MuZlSXHhj8R1pM85/w2mI6WiCCSeSlxc2Ik+iXaget/YBMT4T3JCt4PPLPFeovvEcxiUkguF9a9pL0W+Bw0f3jVKMsmVf98r9fVV63n+rRO5O8kD6QSo0mgnBnKr3GQt8RzNW1KxAMwjS+Owy8nl+x9+CKl7hoOe4psrJvGepXf5O7NMGEGa1H1trO5n4g0RlBeoesQbOSrQ6DnI5133BVtbUak5xmcRbkiHsrDElK/xPXGUpIMmPCLb/2nNjf8ANOjQzUMsd3SiXufLNlg71JxNo8Yt3Oup0u4M411x3fW2EkIaaR3fnC7xNWTBZA7Iwuy1Zx7DunIEUqq8wq4DEgjiTGufW7qFAlnKhnMhQ9NL5SyTYx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(56012099003)(18002099003)(11063799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L/9vlTxqHMHATj4Z/lBdHAprrB5mZttxZVosQTriwlomdVhbsJgLuJ1EcC4j?=
 =?us-ascii?Q?z4gPXkvLt3GTrJ6fqR/K+JCtDa/VwyAbN46/EA1SwgUF6oJZH21Ci29/IQ/h?=
 =?us-ascii?Q?c4jOBEOnetMRvHJUCS9mdN/L1tJeGLBMZPbTMG35EpVdeg6PvB8sq6m7Uyek?=
 =?us-ascii?Q?nRuArkwy68AuBrIDtrebD2XIovZg2Szn+6GrNEyvFD3/14Z627hlbaR35IkT?=
 =?us-ascii?Q?34t4cuTSCGlqB3NnIxI+dEwdeaoHyIHviGBsb+krbxPEzGOYby4El/IzdACy?=
 =?us-ascii?Q?zE78EKtNzm7X/IqwTYsrVptrZMJHaUX/m9UHf8BZwaxPPUWPIAdXSXCA9iQV?=
 =?us-ascii?Q?qlOY71sDghNFVlSMyQrgK4mRyE1AErS4zDOvHepuvaViqADQK5B/rapXqDmd?=
 =?us-ascii?Q?OW9ZrFfoVCpQzsHe+/Aq/og1iiCw6dQgaNvyYrEVZ0HHfrXW6mGTXTB9jECq?=
 =?us-ascii?Q?ThkU1a9v9NjDfjim93WyomOhpfNBA62YxGb/2H4MNDEX+XvRvwbcfVRzSFzv?=
 =?us-ascii?Q?KUt739rMPW9Mp46pyTyzumum7gNvil/cqieZt0YBW+0zyoZAPNluDKB5SyZX?=
 =?us-ascii?Q?hLpfWJYWSnXrGILGGSbPOi87iTdA73bYRqNFGex25CzJstmXgcFQ1tSdnuQd?=
 =?us-ascii?Q?22VFbPCVyq5rUQuJ/DOTxDeSuYd2aaQJDq/Ms9k2Y5cBkKKIAowG7zAgoX+k?=
 =?us-ascii?Q?TQjDnVjzplf3J1sr6r/bE1r2b4jRSe0TnUl2ZD6x32j3LeGZ6XxTH2dGdnE7?=
 =?us-ascii?Q?/q5+q2/DDXKf3kOrZO2p2rQ+KddSGbkRHfrr6RkmI6w/KZIRLOTLJNnQpoq1?=
 =?us-ascii?Q?n/h3DEAbMQ4Ps2RuVJKpywHVJTllqDqzB0hMX2H5d1Z0Q7Bacnp+Z2nNAZ0a?=
 =?us-ascii?Q?C87cNFNdIcybaaSBJR7BkiQoh7Zvli/7tvrI9ZEfy7mg2T1gDKDuijn9ORwk?=
 =?us-ascii?Q?3baGtlvF0AZBm/YsgFCz9jCRapWIGHNTZv1TwkLNeJW+YOf2XyMnBPnVMhgO?=
 =?us-ascii?Q?wJa6hh38uDsv62WA7Jh6eqByx3aGbU5F4OCO5o5S3xP1sGrIOaYSL311swQy?=
 =?us-ascii?Q?4UOJBnyYaYXsY+KxWXBhcOZE6rG7RcKLnRW7M/XGi4j7ve35i3FFPOpVwozQ?=
 =?us-ascii?Q?G95SjNZAq8lcPftol/b5POxnjGFbwfIfCh69qvHLnBAdwZlMXwe8d++5IW/c?=
 =?us-ascii?Q?ILyGA3OJJql+IYYlMqevO6mFhhvjaoye7gv2O/bYRzNzgCg+Ics3MQH3o4Eb?=
 =?us-ascii?Q?mrPdN1ittvdkLSTL3EJstHhOL8ADb+g1P7e+PZ9+8vnZhLLH35LmxwqD5QVM?=
 =?us-ascii?Q?ZkZHRv7Cxj0ThQOF01fRNZzoFeW3WzdFt+g0hUG3SPHLo38b0OOeAE0Ig2nH?=
 =?us-ascii?Q?ft8VmZkX5oEiXraNRLP9s70ymgBKkBqngBd2SC2TQ72dtlwL7AQqJrnCG/9s?=
 =?us-ascii?Q?R+wKZjrLYArYCz2/gkdDBor5kUwPkyFFukkcuoIojToRtjutx5BJyL2aWmgn?=
 =?us-ascii?Q?e/nczDFB0nuvx57Zl25M1nrGaL64lCcxgngtPekUiHjy5V7gqpPoPdLIoPkP?=
 =?us-ascii?Q?giu7yupUeQ77dzd+VKf+e4xVyy751XllNkN8o0TDB5RaP2bnxEXQzT6qg7YA?=
 =?us-ascii?Q?rLQJ9sDfSGj1RR2eyCKLv0ePfxVi89ci3BDZUSHXJz9bPyVvpbkYOZ/nuYFT?=
 =?us-ascii?Q?32NlTEIweRb50n6DRSoJ7xt21m8BTE20GvQOKHf5TqX5NmNyn9HQOux0F4SC?=
 =?us-ascii?Q?nqkXBw/cRg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9d6177-1e87-4188-4f3d-08deb592de82
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:39:14.0055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cOPrzjpglN2cvQcA8O7kZtcSHpXN/lJ44cG41WbIavmHVAok7d2hbZsJSQeIq3Xq6zdf9CRc+Ss6CLYg3u+BUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9337
X-Spamd-Result: default: False [1.94 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249550-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,kernel.org,pengutronix.de,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos.song@oss.nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,oss.nxp.com:mid,NXP1.onmicrosoft.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 39CB557D480
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Carlos Song <carlos.song@nxp.com>

Mark the I2C adapter as suspended during system suspend to block further
transfers, and resume it on system resume. This prevents potential hangs
when the hardware is powered down but clients still attempt I2C transfers.

Fixes: 1ee867e465c1 ("i2c: imx-lpi2c: add target mode support")
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index a01c23696481..bf8c1ce1c7ff 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -1635,7 +1635,16 @@ static int __maybe_unused lpi2c_runtime_resume(struct device *dev)
 
 static int __maybe_unused lpi2c_suspend_noirq(struct device *dev)
 {
-	return pm_runtime_force_suspend(dev);
+	struct lpi2c_imx_struct *lpi2c_imx = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret)
+		return ret;
+
+	i2c_mark_adapter_suspended(&lpi2c_imx->adapter);
+
+	return 0;
 }
 
 static int __maybe_unused lpi2c_resume_noirq(struct device *dev)
@@ -1655,6 +1664,8 @@ static int __maybe_unused lpi2c_resume_noirq(struct device *dev)
 	if (lpi2c_imx->target)
 		lpi2c_imx_target_init(lpi2c_imx);
 
+	i2c_mark_adapter_resumed(&lpi2c_imx->adapter);
+
 	return 0;
 }
 
-- 
2.43.0


