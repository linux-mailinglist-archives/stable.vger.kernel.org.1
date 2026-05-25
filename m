Return-Path: <stable+bounces-254065-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id p9NVOD2+E2qyFQcAu9opvQ
	(envelope-from <stable+bounces-254065-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 05:13:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D61E15C5865
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 05:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA22F3001CC4
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 03:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359B22D6409;
	Mon, 25 May 2026 03:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TiQ35UkI"
X-Original-To: stable@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013042.outbound.protection.outlook.com [52.101.83.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A92C2C0F75;
	Mon, 25 May 2026 03:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779678775; cv=fail; b=tShTr7rER0sHkjaPS+8m1yWbehmA/D71yM1umw/BXN4HZaXicwZ1Mor/5p8BsFibYULHo4KIiGL187N1TgqYGpRJkRMm+cdfMhFHbX1R/+cYMMHVXi1qQuNtdoD8Pk9hZ7cFTllNnYQQnulT5/dQOFWpkaOWirZlggPmTiIzzrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779678775; c=relaxed/simple;
	bh=lhZ/5kfDrQUF4RQujLfiXtNZhSQhRlLwIH+sIomCzA0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NbVeRKJih1qe2FxMSxcsy4jtuJ9v4+yRgbKinpdQ4jtko+StlFinn6dW27DceA1rLE/w3CWvRE/wO2bO+3+QMtSWYJAz84VxR0upSZBifszJWCKKL69bm6dQNPIzTnkzRLFrne5wjg1lS5BAmjN6Fer6LWE7rkMehMEcsrKHqZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TiQ35UkI; arc=fail smtp.client-ip=52.101.83.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TixQZawT6q+ROlVTIktHW73M7s6waHHdSIn9DHLyGMObiOLeEQjefT6ttxdeoqRfr5vqhczCcMWmAYzUCI959QPBd6NCviWFi0rRf4+rcRtrgx1adJ3VooFCc9png8ILMOyOTmAGVcKnquPgt/Dlfe/tBafcyIi31q7mvUyNQF6SMSI5XA3E6Rc9dGI/ZZ8kZCpKosR01hAu74J5BvqiaG6Q0G3s9UE9nlqyV89MLls/MLepLbabQfIBPcpHtRNcGcf5uTrC8l0V3bKykmWdsiiYyGz7pKAKsZVst6Ws8fvMFEzx2LC8EH+yAAy3tN+kJvD4p1NO1YHHWL1nk2mNWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/cBsuCf4C4cQ2PzB5Ck8qtCVaHb6ny1NPQGb6Az3dk=;
 b=TGggwlJo6QkLhZNKKl9KhAB4cZ4JyMC+qqU8UQLc+j315/X3Affv8ZbDp4gvYy/Uy4QsnZzAvEiRpObSBbF1ogeWXqplm5jwlTytBECBjcHTel40dZUEfYkZwUQBXBg3wUH+VPChJS2x6Vn4JazXTJBH+ZHlEHWExL6ocA888nxHQF3UsGNp71/ZvWdim0PIoTiXeXr4VXMdVdJbd2T/LFtnp77+CePw9d11Thl9lrlmYPigS2KDakfzzOZNpBUmQG9cqdipZGPVN1Y4VSlze9XLX8uWDUoCFQTz+oOr9XmB3dnuyOyJwrJhgKwiRhe9QYflpvOG23FQVq/cLrjZ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/cBsuCf4C4cQ2PzB5Ck8qtCVaHb6ny1NPQGb6Az3dk=;
 b=TiQ35UkI64wh3rNnymW3ti5A6uLKDlRLRSR+qz8f0KQulRGfH2KR7ngMFLA7DAK1UhvL+Ezv7zOOyZzpM0E3WnKO0A4fdwRcOz0EQCuktDz+h49SNz0HdbRErTmOMcxNAEK7SKzzOAqPfAqHTRbKhfaAeOx8c096uaJ5ZZR/eA+wsLN/kCGRCzIOKQ6G4s2ilyfB7bV2MlvFMiytyzk31fcj5WEPuaQXIqrGUIuewcE82dyXFXL7hx2ULCQB9+czsI1OdNtM1wOxqRz1Zz34m0EpvCy0RUl/nRqJbNRYLQoPMA3I5oHnFIePhSs3ziJk/Iqf7eL6cVyP6pzcHFftsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by VI2PR04MB10690.eurprd04.prod.outlook.com (2603:10a6:800:279::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 03:12:48 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 03:12:47 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
To: aisheng.dong@nxp.com,
	andi.shyti@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	carlos.song@nxp.com
Cc: linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] i2c: imx-lpi2c: mark I2C adapter when hardware is powered down
Date: Mon, 25 May 2026 11:14:50 +0800
Message-ID: <20260525031450.3183421-1-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0110.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::10) To AM0PR04MB6802.eurprd04.prod.outlook.com
 (2603:10a6:208:184::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6802:EE_|VI2PR04MB10690:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a5e586-a154-4564-ba9a-08deba0b7f1a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|19092799006|38350700014|18002099003|56012099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	a32jd4Vm0j2rE1w/32RzKBZjawYJsV4VJAWHgA07eXkD7yZFOQ94qqjr0NZzLoyNfACEV/uXjQgqAoABljPamP6l0VMwZ71HQlh7ho+o8ggdzq7KPYgnD7gnA23kbveErbDW7AIfCZYQRUbe7ZVIwJ6sIYikFf+hFVoiYmYmisV/rXP1qt0ejPeFrXg+1HIOAykqH9w5WaJnZQaEspgGeq7CYSN4VIJ8moHP7hqBWkP+lgyT7C8Rnh09flV+tan52Eh4o2OBe7OVhpRgEmCRfBLS2Btd55MtFjsBH3hoR6mRTwwwWvo0gFEDUO8yaCzFYChVYQiDatCAJWL5t/sgN5VUhaD7F8n+e/3FfcD4BrGf+9m+h2SCx932uLXnbL4j4xXB5rSqij3AnpwgcZZ/S/gVAK551zv68FRZyk7UKIvwd3dOmJ8en8kqLIM5pneX2F4GW0xAWsE5eqvoSA5sbcx3KQubWMg/eG7uU43rhYtJaTNBcu7JOsr5OjT+xvCa8KnyrsPY2fnB46pUTjCIC4sBL/CYeKRq0AJuB8agTj7R0/0yN0bqDqWm/uNoqI6QPu7xb9VdLV9J4XBOShAF7bt8pdsp6mXvVE1kDYIZ3bfscFbL3BtqUVLP3tS3VHleIDWhUiAxneterZlfxUdVFktxDLiNYM+Sm7hcnw1bFu29XU9xhk9lxHJWCG4UY7X5UkOf5yW98VmyU+9Z1NI8j097z3L2Sqg2yD3yIgugYZINGHpgrbxOtlthvkgW7zk1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(38350700014)(18002099003)(56012099003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C7ToDk7mARkEnO14MXm3GTGodHEv4pbAs9K0dOyfPU6sdIx22FuyGRYZZhC5?=
 =?us-ascii?Q?evrUoQ4zDPwuBYQ+X9stNdsh8/7gOyNsdnLglbKP3evCqmBGzzNUiX6DqlFn?=
 =?us-ascii?Q?q4AqOqnxnxa0e5DXd61qAB2kgt9vEFRr13pOPQ56ZhRJe7x/KDw3gWAEmLfb?=
 =?us-ascii?Q?Bi6mtS6HAcipNdTjpLhJZPd3EXzjIYcXxfE46ZMlilXOj7x9sDUTCSO7IZsI?=
 =?us-ascii?Q?CrPAzLq4Pczo2aD04oUV9aALFuYPegOU81nhWg9RtK14ZGJaVcHo0vAGVaF2?=
 =?us-ascii?Q?grBmJZgRxuXK27GjEcScY1HqFN/dB+0/b+1ziZ+OX+boGiA1jz0FyMTIuJTn?=
 =?us-ascii?Q?roBIjSnFOQvWWF64yDVSRDil6riLBwpIVBjAr5YW4kTizfDNK4KHTFtYOYr+?=
 =?us-ascii?Q?t6h+9gjUeeHdhRoGLT+BZRr/QF+WQ529t+Rirgp7ec/9G6dAoIVWwk9wh3WN?=
 =?us-ascii?Q?KHXi7ZzjmT8SEUNZt/1WjEVpMsDY3HczbXWEVHHsXztNaNRIi5tk45/nPTSQ?=
 =?us-ascii?Q?9bJ/ORxhDaxtoKGJu8Is7wuT+xA4I15tbzdjCloo6IEQ/xQA10VhG6MKJW3c?=
 =?us-ascii?Q?eT9ZwRskzm9Rt7PnhcIIaR3y6LY4vYxxwr9d0E/8UeRTBfTyNfxRjKk3HaZe?=
 =?us-ascii?Q?HGk5dllxZFXmPlyZgKtpRuJvurBj/EsJbF4G0UrOPNHJxkW1N7BvpI2UvXDT?=
 =?us-ascii?Q?NdDmw2MuJZeldIli2eLUqEh4YEsKs8rw7a5mYxq4hJihuIKI7fSU4nVEy30K?=
 =?us-ascii?Q?1P4axZZl0E71ri4siNTfZgfqYxsidzeErEE+6vi1hlIJpAX5qZSa0rOZJ8Er?=
 =?us-ascii?Q?jM3xAP5Nv+OwcJaqx0+jH2QhZnt+1srN2zfgUjBIlHg2137YkHplCkm9MQ1e?=
 =?us-ascii?Q?4wiQPKxNgiNFMdYObjH6l8C5rCXXbQnybhhsLarxAfQvFXyf2iS1NCopF99U?=
 =?us-ascii?Q?D/txi4T+T0bddQdn7oIXHd4SY3jkjy/RWz+yf03BPVzUmckP36YdJaI4dL3r?=
 =?us-ascii?Q?oKf+10r2hwO42nCsVcVhK6U94Aasjoq0mwV0tjqDHuf7W883/vWLU7gYS9b6?=
 =?us-ascii?Q?Kflm31HmD2arBbMWSn9SeL+3h0litC/f/mVoftPd1fUne52z4k57ZPFLkVUc?=
 =?us-ascii?Q?W3uXdHMiipnWhJ2iMXzpNVN6UPtKvAZDD8+evbWFTiAwkG0JiZBBUV3Yy0Cl?=
 =?us-ascii?Q?NM45ksPHqmL+m0pUtjX8L5f7mdg0+SEg5kt1rD1saWyH/ERVQZMeQaOHh+jL?=
 =?us-ascii?Q?26fqydJ4C+o8cgzN4jVmjf2OZT5IwoPKrsFk9pDKzVcLGBX+obvFleKJjfJ8?=
 =?us-ascii?Q?med11MWTXCp17F5kjiD9apCNnzDiH01DM8mhDCRYg4MuHAKiMHt29JNuWf4R?=
 =?us-ascii?Q?r+Z64IPumObXh+yWrtpzq/jGR3wX067vhxsBOvo5fjL7c6aSTQEUcA6pOyuV?=
 =?us-ascii?Q?/wk0DniIcdoUD9MietP2kKCamorlidi7iqIP6I9UUcz+YfHB1F3/LGWalFPj?=
 =?us-ascii?Q?ZUCFlIqvw0TmpqxM5qd8r5jRy+Mv3rdh6Z5OyvbXlTZHnWQ+sct1p50l4MaS?=
 =?us-ascii?Q?WHEDCdet6aWizzbyw1sgt0clD4U0ndsuWSYwca881/0+uYVMxVoFmX/OpjuE?=
 =?us-ascii?Q?LGXUq0XkcO+asU9KrakUfckemQ3pCmOa5IGTGhLq3KtSlB3alujb5mCHEodE?=
 =?us-ascii?Q?vnzsamDtgoM7NDVGHFdhfcKwgaFUbJy7zYUYhOxRrMDfZBLL57ZkvjwgBAdD?=
 =?us-ascii?Q?s+vCh0Al7w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a5e586-a154-4564-ba9a-08deba0b7f1a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 03:12:47.8529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01kaEdu1N7tBE87T7N8DrrZbo2GOf0kAKM/UmkRC4ghPsVXcAI4StMdoJFYP3jHBSMJnOzru2tPSaj9vyMTvZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10690
X-Spamd-Result: default: False [1.94 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254065-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[nxp.com:server fail,i.mx:server fail,NXP1.onmicrosoft.com:server fail,oss.nxp.com:server fail,sin.lore.kernel.org:server fail];
	FREEMAIL_TO(0.00)[nxp.com,kernel.org,pengutronix.de,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos.song@oss.nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[i.mx:url,NXP1.onmicrosoft.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: D61E15C5865
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Carlos Song <carlos.song@nxp.com>

On some i.MX platforms, certain I2C client drivers keep a periodic
workqueue which continues to trigger I2C transfers.

During system suspend/resume, there exists a time window between:
  - suspend_noirq and the system entering suspend
  - the system starting to resume and resume_noirq

In this window, the I2C controller resources such as clock and pinctrl
may already be disabled or not yet restored.

If a workqueue triggers an I2C transfer in this period, the driver
attempts to access I2C registers while the hardware resources are
unavailable, which may lead to system hang.

Mark the I2C adapter as suspended during noirq suspend and block new
transfers until resume, ensuring that I2C transfers are only issued
when hardware resources are available.

Fixes: 1ee867e465c1 ("i2c: imx-lpi2c: add target mode support")
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
Change for v3:
  - Remake commit log including the issue detail.
Change for v2:
  - Call i2c_mark_adapter_suspended() before pm_runtime_force_suspend()
    to prevent potential deadlock if a transfer is active during suspend.
  - Roll back with i2c_mark_adapter_resumed() if pm_runtime_force_suspend()
    fails.
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index 7adbeae9cb35..4929f85ab485 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -1668,7 +1668,18 @@ static int __maybe_unused lpi2c_runtime_resume(struct device *dev)
 
 static int __maybe_unused lpi2c_suspend_noirq(struct device *dev)
 {
-	return pm_runtime_force_suspend(dev);
+	struct lpi2c_imx_struct *lpi2c_imx = dev_get_drvdata(dev);
+	int ret;
+
+	i2c_mark_adapter_suspended(&lpi2c_imx->adapter);
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret) {
+		i2c_mark_adapter_resumed(&lpi2c_imx->adapter);
+		return ret;
+	}
+
+	return 0;
 }
 
 static int __maybe_unused lpi2c_resume_noirq(struct device *dev)
@@ -1688,6 +1699,8 @@ static int __maybe_unused lpi2c_resume_noirq(struct device *dev)
 	if (lpi2c_imx->target)
 		lpi2c_imx_target_init(lpi2c_imx);
 
+	i2c_mark_adapter_resumed(&lpi2c_imx->adapter);
+
 	return 0;
 }
 
-- 
2.43.0


