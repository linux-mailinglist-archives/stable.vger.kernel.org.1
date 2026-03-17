Return-Path: <stable+bounces-225745-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LJCGzHyuGmTmAEAu9opvQ
	(envelope-from <stable+bounces-225745-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 07:18:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C282A440B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 07:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6344030210F3
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 06:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF37833E36A;
	Tue, 17 Mar 2026 06:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fm5lJhzg"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010049.outbound.protection.outlook.com [52.101.84.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6776C33DEE1;
	Tue, 17 Mar 2026 06:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773728295; cv=fail; b=l1fvjGNq9F3F1v6JeTVf7bPJ1JfexRaHRErsAlJKUVMMe/A5E+ZyoM8fkl6F66oc/jUaGvyUyzsVmQ85xuhS7eMq3yzAvRcP7YfXe9rUXgog4PEW3ZoT14izvnHD6n6KadF7yEeAau68KVlQUj2d5xhM1i8MHTGHIo5tmm/swQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773728295; c=relaxed/simple;
	bh=lJ3qgZaRAUQ1/ReU6Nlx7gG4g4rv7GX90WmqsgXS7tQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=I8fSyQz9mnpVv/FQTMQSYfIh6156A/YqRs+srfF9/+ABZ/qf7dv5SNQ6bX2ZgnlWemD688CTy+kNj2QvmJiYYIHt8II9tYNrb+oVecwButP3PDfaa/jS0HonfgRmntPishMeD3+DOBZX/R94mredtWdkt3+bysuA28rCprg2Q9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fm5lJhzg; arc=fail smtp.client-ip=52.101.84.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFmibGahQ09+o43kjPO6hDpX5Bgr9A2bGINmM2VezFwMjrQIte7pRlhP8vx3l0xDRtOzoSJ3nNKo7KSHHMsNCuk8objPxssjgQVoWoTI/rc3NW9wNP16GkJLBKaJlvviAtS/vyrE3kG+owSofKi6P0ANdtEdG9y9GPJ8QPktvggKt24Ou6qgizfx+aKY7bSO1mJRSo4O5fm4BDQdsKwJPZf+gBf4u7LM3pxP+dDpEpQCbdjtg6ISCmtxp8bMnK7E/2k9mHiSwCu+wsf9/lHoSZ/NAV9XTGsdLG2+52u+6yYGJV5bqf1Lokohx4qBGdIFdAuyq7f7tXxtqDeUiXmWBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaHhvbgo9Z11Kl07CwQF8IrqScu9wSu0DkzGKLFcYfA=;
 b=Q8n3vqIX4eqngmBUHH3UOTQRKJCBv2j0/Z/SQOmDB4k2bNnrblc4oLsigWMNYAPa0J29X8+pGWikqPZ2JNIA5L5Q3Zh4NhKDOKOAq6BxhAN+COeuxVdLJhbcPdmwyygR7vq43v7fZneJZ/qoQeRTh6f+hoCSsHpaRpwqa7z2abjQX3m59zub2ZajqqcXpGQNraN6fhoLxO6CXRT8ajYD1vsbTPDqjzyo//s5PhaT8jCvevx5Hv81EQGcRR9GZFmBKnaQJ5a2RfsHjEgr4hreqn0NciJLqldsaAd+vz947P3Bm9Dkm+xdQ396Jdhk2mi2jQBMqDFan+qmbK22XGti7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaHhvbgo9Z11Kl07CwQF8IrqScu9wSu0DkzGKLFcYfA=;
 b=Fm5lJhzgv3ETv0XIk84NYPC9P4hQ+nXZc4a+S9GrD63lPxx9V0CPjmuVJN2DcvCygvJ1cFglVA3W1y+11vZRF6g/pO8rnOIESg+zhjEPfdGuzjgBFJa4ik3DBmDKtvyi31O+ebpbyp2pSowxtfFPSJouFFaRX+tib24g8U1s88ysX7rx6m/7Ixn5nIov4Qrtv/gIryA2Y4qEREkloLHaI2NJzHU8cMJg0r2WKCM2xuQ4q8qq5h+3EDH+jcu/O4MWt+/H/N6+uYCDs55teN0vQaXly3ZfpyMnZrOH4S8Z84a54P0q5mgetdRUrCTU7GoUHHT9aTSFw2raSy3NFtMSSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PA1PR04MB10205.eurprd04.prod.outlook.com (2603:10a6:102:465::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 06:17:45 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 06:18:06 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	jingoohan1@gmail.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] PCI: imx6: Add force_suspend flag to override L1SS suspend skip
Date: Tue, 17 Mar 2026 14:12:56 +0800
Message-Id: <20260317061256.591362-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0261.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::17) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|PA1PR04MB10205:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cd993d2-2c4d-4405-b92a-08de83ecf3c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|19092799006|366016|56012099003|18002099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	g6Soj6gvgqbIf1Msqc8XMWF0UrDdfmyQ0kJPs6ekTbmL8RweqbFAgZROBH03afeLk+K0m5p1IySDcg5sJtKAoGN4AN/bpBXDQmFRmcf6P+vKgWGYWIiA7Stv0QJx07tEzQQKMVKNOZAlSp3DKHGHErRTXVuk/j+Q8dwTr7D9q8eldX7+uNuYHa9Izg+HQBFlG9gTkVpZ4B0mpHsGxWh8Luwn1Og9M+Md2dhb6g1CjP9h2DIA7gytD69YTcttwSGASOnQFdtqMOu3bxOKvQecVws35KOh2WPlDnqszoZYH2NEvUthdJ2eeaA6NKGR/jYqsaAU8oURscpL8+DuV1mTuoLvI2LXLtn7XGD3k3Ip9KXPDyeF0WDTXCC6LQtQXJUyjKvMswVKlIu8dKO+ztwYkpr17mj9hgGNrnmqQEQB941jnAYTbjk6fpQTqe3Pq9qHnUJaOUzd48cebjCz3hkUKYHVolxYiPJyVhzcuNzqwqUFYc5n4kSTOycvWcoWlFgUWxlBKCOZxwzYgH3gy48Th/uO3udHyd2N9kd7w4I+/canFo4p8uauzEkesv7ZbEWeR4Pz+9u1LQzsGxNBaB+aUzOuVorE3lwJePfSBIGFfSjPSQS0z3wzpsjJ5WR0WBN9ajEQajq3w88FcNwLKAEt9rr2vrgEZHfiSQ3LJE0TU6Qnw4nyHFtn7uL6v1nXwLamQIHhgMYNFYxq5pdYfDmIkmb7S84jRqz8Xqqk1+F/7aJA1m9gqBqyq1Dy4hcNnbAfa9uDeNANxrhWpcOmkVprVdcqNdF++VR/pIh6jlpmdCzd+AhZb1h/W6bHqYQ3mFUt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(19092799006)(366016)(56012099003)(18002099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t04EYxI98J/hEUily/pZsbuoYx8aKpu5+Edel77NnvkxIMhjHz3VAO/YvJp8?=
 =?us-ascii?Q?MNiMQx0bqF/Pg+G9UQsJ15ntxxs7aPwBOS6cBwWuqc1j7SJL8LVu4aON6zd7?=
 =?us-ascii?Q?NcnapeHgueugh6WYPGBbwqcSYa3qryWA9Q1lyn9tpiInI6Or4XRBbOnX2b7s?=
 =?us-ascii?Q?HnxAWSsiDw9adJwtp4r9186DuItziOFxi5g/PN5ox1DAYb3WDfCtyFMSwIwU?=
 =?us-ascii?Q?csECaUsCB5lipECRd19G7vqJcBw2sAmVJ0t8Z+Nobzw73jTMTmllLxE6IkX5?=
 =?us-ascii?Q?GpoJXmaInBIU8PuDh3QFXsw7l39b4/GKgvtCxsUoSc/ilsTao6bDR2ifv8VG?=
 =?us-ascii?Q?98fiYuFH/Z9TEEobtO8yvm0vEww3TbRj3LCrR57fjOJM2gPOqqqLPEXJBL2S?=
 =?us-ascii?Q?ODaNYOBmJ3bOZNoJitoUha6xDNTj4qz4fSktV0Fg3h/DxtkF3b7pounjLpxc?=
 =?us-ascii?Q?8r6T/pOzVSVLFDLi8qpXi+AeyG0PpnfP24LMOj3A1kx6Bm/8eVeZzlVsJCqD?=
 =?us-ascii?Q?bopH3C/wcq/5VSqi6+NBrXn+QG+eQavyXHL4SI+1MmiBhdosFoxpbWAIip5V?=
 =?us-ascii?Q?Gb1o/a/GalTrRG5i+16vAMjuajphVxEVWgvGOj7GkP2IK3kl/S7dF8kxC2GM?=
 =?us-ascii?Q?gxXs0ny1EBGtTuh2Y7ASrFalabvNoOWnzwVDu+o6WwfsgKU0btLnL7F5o9hM?=
 =?us-ascii?Q?yLSWI+pCBWqWvc1pCLUsA7LBiDFsBAQ22YBS7meJ2sbqL4L+SqIyLmzejw3u?=
 =?us-ascii?Q?jHaL+wfUBxLb68LrF6KEyZmQuN6YUPH5copm6W+LfKpDNJNvGpeE+Im62Xwq?=
 =?us-ascii?Q?2FD5P3BhZazYcwtgExdIU5pPhSHvqrzzU2CvvjOLxkwNZsMnpd52fbD8lC+u?=
 =?us-ascii?Q?p1vXrLDs6b80DtpyGGVBoXdMSlVq8Kt78YkAInbF8bP3OK3UyuU2QrH0wSZi?=
 =?us-ascii?Q?E8KFikm54p+1W0Q3iqR7OvpK5v3TLk4CJv/dmwhXjDRPRomvvpSH2kJ3jBp+?=
 =?us-ascii?Q?FPBBmeb85ilYd7JbEAeAIOoj1NNCg8W479GY8FFrnYIWjJDv0pq9nTDF9Qrm?=
 =?us-ascii?Q?91MmwsZNx00NyKqTxLYFdzhyfwngBkiDQpLJ6Uh5KhIVXFKMqoyJg+8n2LzD?=
 =?us-ascii?Q?oRWgEfNh97bfd1GE3cIMEO0L9HO59Sa8a03UpUkW/cDdH2gAfdzx7Flv9db4?=
 =?us-ascii?Q?NtRGlLUk4runypM4bvGXHVfUJnipHz4Fa6U0IIJeQyGonzSDlfqm9anW9M9l?=
 =?us-ascii?Q?1Z3Dv64UXh44Ba2WZ34vT5gYCVeJMLhgiw3EMywHDItM+UqrpSNMfcOs+pRd?=
 =?us-ascii?Q?BiJLwDG7fHb0QeO/BwS88JMJ6973lm87Bg9eQQFxqB9FZweaezVACHMwCBvf?=
 =?us-ascii?Q?UYoO8dTTYD/dYdBth//jFit4PV5lZ6K/iLQgWdnUNEri+AeW0/U8KUuAgnQf?=
 =?us-ascii?Q?5MsbX4T2iy0ezq7lSjbiNV2c0WL+tJjhlBmyfwnt7fxtcToPbMDQwQ2BYbJR?=
 =?us-ascii?Q?o0fOlrNDIA+MQ4ppNerlHWWVVaYaPwcp8xceDL9eQeCr3Umi/wFUFOnv626O?=
 =?us-ascii?Q?Gvou8tMSkBQKVqvHntx8Sr6ccYdo3oZ6FAFCOTxT6lFm2wd3rnucel0iVT5u?=
 =?us-ascii?Q?ZDeOWZhyhRAL2eF+Shtt34YGAVG9u0kyTdZohqVTL5IWPFRGf1fnZeh5aUew?=
 =?us-ascii?Q?K8EedhHRx+qH15oZaeyOEnkhJ6/GSRjDqL+2B7zW8alGNgVeMYIB1GK4ICWU?=
 =?us-ascii?Q?V9JyrKVUaQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd993d2-2c4d-4405-b92a-08de83ecf3c1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 06:18:06.1350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pgmo1UJ4nqHsMErs1XQJFKJkSj13AfQu76ze8ML7wC9gqo4EuU7HFX+LkGNgdR2BM7VSasOHNwhqOxapFHIRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10205
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225745-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,gmail.com,pengutronix.de,kernel.org,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hongxing.zhu@nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 17C282A440B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a force_suspend flag to allow platform drivers to force the PCIe
link into L2 state during suspend, even when L1SS (ASPM L1 Sub-States)
is enabled.

By default, the DesignWare PCIe host controller skips L2 suspend when
L1SS is supported to meet low resume latency requirements for devices
like NVMe. However, some platforms like i.MX PCIe need to enter L2 state
for proper power management regardless of L1SS support.

Enable force_suspend for i.MX PCIe to ensure the link enters L2 during
system suspend.

Cc: stable@vger.kernel.org
Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c             | 1 +
 drivers/pci/controller/dwc/pcie-designware-host.c | 4 +++-
 drivers/pci/controller/dwc/pcie-designware.h      | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 81a7093494c8..7902d39185a5 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1831,6 +1831,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_SKIP_L23_READY))
 			pci->pp.skip_l23_ready = true;
 		pci->pp.use_atu_msg = true;
+		pci->pp.force_l2_suspend = true;
 		ret = dw_pcie_host_init(&pci->pp);
 		if (ret < 0)
 			return ret;
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index a74339982c24..720154fd4ff0 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1229,7 +1229,9 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	 * If L1SS is supported, then do not put the link into L2 as some
 	 * devices such as NVMe expect low resume latency.
 	 */
-	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
+	if (!pci->pp.force_l2_suspend &&
+	    (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) &
+	     PCI_EXP_LNKCTL_ASPM_L1))
 		return 0;
 
 	if (pci->pp.ops->pme_turn_off) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ae6389dd9caa..5261036bbe6e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -447,6 +447,7 @@ struct dw_pcie_rp {
 	bool			ecam_enabled;
 	bool			native_ecam;
 	bool                    skip_l23_ready;
+	bool                    force_l2_suspend;
 };
 
 struct dw_pcie_ep_ops {
-- 
2.37.1


