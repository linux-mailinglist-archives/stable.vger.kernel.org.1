Return-Path: <stable+bounces-116968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7E8A3B14B
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 07:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481613B1C69
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 06:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7621C5F2D;
	Wed, 19 Feb 2025 06:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mP4I0k2V"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012006.outbound.protection.outlook.com [52.101.66.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6EE1C5D7B;
	Wed, 19 Feb 2025 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739944818; cv=fail; b=WqfYWzYlBD2hK6iMn6vbLif1qNtK0roy8vl77S6foJdg4RamlWk5D+T8uXdGwEJ82THceASusemWhJhpi5jRBFGnvTwqhHV2QuGDbn8CR8SokIVIfceFRorSfovDvnz2YHYqxFbCr+ze+FQCDiXT4uwunlkTfNhcmSRNCXBMmV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739944818; c=relaxed/simple;
	bh=DMiOOiAtmShOkFZj8EkZvDqHtnacJDvRRcqJ5XMGTZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C+awfcByX0JKprWSeZfyHIPO5LMI1p5E6LH0S8C/6YbEvUWHXbvzn55iKsRU1vPayRjhzL0Sm9EjkUSggwyXKz/qGbMGsSCw74Bf5cormsJBMZzT0SZQTWL/9I9hMaWE2uua1s3g9jKOuqZbzHxSeXWlt6QoDAKgZTpKNB3wNJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mP4I0k2V; arc=fail smtp.client-ip=52.101.66.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQ6xaM21gVBvJh8OePlCpMszE+l8WBkbY9HWMgUbV0LWPfi2Ww+1WhLXAuH+ctav+mFQu3kcnMiNrEZtN77WKLZaPgk/zquXJFdelB32NdQoZm6meL/sRoytmswe2Ui0dCdISQdQDte32d0BQNJ20QIHI1ItvqQHLzs0nbVi1c1+sxciimkIcJiubS82LXd+xkn/spMiO1627rYic2uIaIyhAXrLhCwXgBRr1Gti+S9PVXDl2ECkkkVFkr+isw0HGAB08I3Z1SKNCwyktdqBMYUXKpmP1pjRkt/IN7j8izzKSNeM3CNjtoMdymLBsCV2mDx7z1eyevfgXU3VNN1DBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Md4iT8uDmV1FgPKEe2IVNAh9iF53foUzVdVmDoC0GMg=;
 b=I2MRcFM9ry8lBrDow2MGMwKef371irjBhD76uES702+J+L+nLgQFFD0O4zxF1y+sqsS1e7B0h76G/cEI0kwdbTr44+EM8dXFdx+/gIzyW3Z+t1k7GVT/PGL8c6nkV2z2zuT/aFDjp8sKPlo7pDdraJT40MeFhpHNUj+kj0rSQdJo9mDImwq4iC4BN88G6gOTHfDHCPl3p5Aq4INuDpot5eAkF1z9Gt+ouM+CCDYf3PRWG2b9a54Tt7OfAFooQ/2PUOpe+8nsIG6QDY3z0/EeJ7o8kP+fLMJF7NDYAx/ngWtYZKErEKoWCKsYg4TftyYRJC7gHboP4bEqgoTToZFh0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Md4iT8uDmV1FgPKEe2IVNAh9iF53foUzVdVmDoC0GMg=;
 b=mP4I0k2VOKUikHzt8qnXiZyOEpKg6o3zFaEC8u2zRBnCRq+8SyRxF5WsQC4TULHoXutN4kPzDU0ZZo3GSonrPHscgRBldPoywBuImrQhfvbb5qm4WGn1nsjHnpHbwOKsCjWpIhz8TWHNAMuiqPhBlZRUsGBiGqDSTjmFMnJ18r1QH3eS1TYggNKGlwr8+mfHxFpDwXPMCTl90If0xEKODs0ILddD2zhI9XpUeoveVr3BnziATW9SxP57w4SCSJ/ZY6gh7tuqziVODvM6+lmYeFSIcqK4zR1iKofzJjTJsmYw0jevChtO8HompHuAS/Sa1gt9cEB4L1p1ocNjocQNuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS4PR04MB9409.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 06:00:13 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8445.011; Wed, 19 Feb 2025
 06:00:13 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: ioana.ciornei@nxp.com,
	yangbo.lu@nxp.com,
	michal.swiatkowski@linux.intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v2 net 6/9] net: enetc: add missing enetc4_link_deinit()
Date: Wed, 19 Feb 2025 13:42:44 +0800
Message-Id: <20250219054247.733243-7-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219054247.733243-1-wei.fang@nxp.com>
References: <20250219054247.733243-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::35)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS4PR04MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: 1480f572-891d-423e-bc3a-08dd50aaad16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nWFfuqVY0ScC9sCwJJK6jPAscmEC6vqcRScvdH40B95kSE8Ak8WRzolecSti?=
 =?us-ascii?Q?FWaEZwhaWUFpfb5m6W0hAE22HgnvrkFEv72Qbeca2eWh37RtIRwq50swr7kG?=
 =?us-ascii?Q?21rO9fGbX0WWumtrxZ9JHsLyvWz9X9uUv75mSo1ugh14MHJN0DI0iNLqgxVu?=
 =?us-ascii?Q?VJpciByfV014CCq377ZcrnFTVbUk34mna8cK8IOfsQpIwJAlkpE+tDUMutIi?=
 =?us-ascii?Q?1LZW03djC7jdhRiLRjTaaxzQ5Uc3S85qNYtk0/agQOYjlF7DnZMReHRZgAvJ?=
 =?us-ascii?Q?9batLXDaVuLwkwbL8aHfdOiRc0OgH0y73HdXVfykazKCHnpwWcBbmHrTPjHb?=
 =?us-ascii?Q?ei2Yae/iItIKbdBg4oOznzIIYvl90fJo4zSNKPGPrtkzQEUB1cyRjWmKcOor?=
 =?us-ascii?Q?vHiBD8M1YNJ3f8PzK/mRHCvLmZk+uHCCwnlfhgpTVgUi3PGLkBw/f3ke94UE?=
 =?us-ascii?Q?ZiNa3T1MSgHv2AM4RDiwuszVrephdrT1ixlxTq4GhEnS5pTqWzsoHOP963Zl?=
 =?us-ascii?Q?6a+fUNcT7R3MVzs0H6bL15snFy4LVHDdmV1gtFj+eyy2dmu9onWS5/3WMa2s?=
 =?us-ascii?Q?dtqNwiIzU8dbxgKpDRASS6pn9v84LXDYq+1Q0H33RaOG4mp6/z0EelUGuKv3?=
 =?us-ascii?Q?4rYgLKyA/TAyBCSGzzMOMFjWm19zUWlzcPTGf9+xH2Atchxd93GlXmBWOgmd?=
 =?us-ascii?Q?txkuIEk8Wh/VVrawRwEX0MmkXmnv6Ylc4aTAMm9MNpZII5inp/MivxoobBe5?=
 =?us-ascii?Q?r0f+Q0n8Bto7ZdjZuHKdmvOuWBwgNjejEORrmO4z0L5i7mN+2AMSMwryRF1i?=
 =?us-ascii?Q?dOQmqEVOfBUFe4NsLMCpkfC4gcZVfrLxYyda2GxTn/xCYI9+7FHQnYR3Fl75?=
 =?us-ascii?Q?4Nrdu5OXlbIJxw0amFQjgGP7Mx0GlXUJAH6nOf9u2XB3vLCr2OwJXR3q5D7g?=
 =?us-ascii?Q?h4tKWof5RQIMHmyQDfrq4ls6llIYItxq6kZR36fhVUaFaMU812CvL3fvf7zx?=
 =?us-ascii?Q?zshFJIR95tSoJG3VLNZOqL56csfQakyDg70LvUKYYRCV6TpPJKbaQLyc2uSM?=
 =?us-ascii?Q?3pVuJpTn0qV3lES/o3y/6z4DHlPJi6odFr3Xvn+XXJe2+sO0iftfq7T0YZBP?=
 =?us-ascii?Q?rKnjNPl8p7i1D7lEvjdp1WSOS5oetNd4PuR+oqFSMlkKfTLzYsJKlfSQmmeu?=
 =?us-ascii?Q?mVr4dsfL211oCMK8+c3yaVs64ow0bR0tHXbWoXWN3D7+dZarmHOF7hBu3cbh?=
 =?us-ascii?Q?K16HxNne7DXWRv/4vOANF+gurwM1XSJqxQhD5iZ0e5nL6KeemxU1G+ol9WpB?=
 =?us-ascii?Q?QBPHPd3pY+79mU7AqTK+b16L2SGE82kFk/MVKCZWCJh+YbXVLwoOCm1YmhcQ?=
 =?us-ascii?Q?TWILWvsn8JmclmABL3dHFPNXV04yNAscK4gScsHPdEWKYzZtrkcMvDuakKET?=
 =?us-ascii?Q?pLjDtn0jAtvq8Pp74XiBnn2bCFvO5s/h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j2Vzlw4DBM7sQXXhszddyQLJ1wAlwGF899k2UVE8FgzhzGHiyBEzn+LGNQzE?=
 =?us-ascii?Q?ah9y7kRrkht+JSW3Y4SjnVhn+swb0+/8QtJXVBrp2F7loGYM4xcI6+DJ57w3?=
 =?us-ascii?Q?yvkKbfqGalyX3J9Btb09Bj+ELuDbuzVlIAp+9HD52Ym8w3MBn7Fq2gwYe1ED?=
 =?us-ascii?Q?ZJ2pyawL5NDrscdt1V8LTqWgHT/zG5x0eDUNoBYezil4aVSOigJ9gdIHf261?=
 =?us-ascii?Q?AwQ1bjoTcH4J5VXmvj5SjGLhR9hvofG9OJUJzVUOpuHJkCb8Z9wK05RJS2CP?=
 =?us-ascii?Q?817zNJX5cuN5+97JdvBKG1irs4Li9kW7yPYKhFzdWK0E14PZjaLJiFvo7lYE?=
 =?us-ascii?Q?5yGu0szXfJEm1YrfwB1oej6yK9lAGDtwrxY4QzL3OECbpjTmayK1GYIlbOss?=
 =?us-ascii?Q?r6XlkwkyveD1UoaptvyuyMkNbPeP4SxcH1/YIXbvo+miR/RrGG5XoxbFUF5r?=
 =?us-ascii?Q?fNdCqXYDXyJdMUSo3kZ00KDxCCQyjGCntI+DUyJlzHRdrlKoFscjXri/mRGL?=
 =?us-ascii?Q?9joF4n694WKsmJQ4j2XwZqEtGpWpehS1WOhliszeizgYBm2J0fCAEccy318Q?=
 =?us-ascii?Q?1qg1EoUQlBJPipFOX2EXoGinuxAKmauPVR62ndS5KUFchnlFX3YkR+vnXwJT?=
 =?us-ascii?Q?wTIEWIt59ejxePaMnx8PdvUb+PxBz7XQJ+SApnlsOyxMlRdtULa7vvufpxs5?=
 =?us-ascii?Q?aLxGNKSzJT7hhHWnn7y74QQCrTf7QvDB/MrOFMrw4+soRtmV1gQzIJ8qVK4I?=
 =?us-ascii?Q?rZRFa0hptPr1nHQBCV340Pcq0woikG6Qqdcp/JxZ+Kt40NsuAnFYld2GtElY?=
 =?us-ascii?Q?dAnxFLcXmZ0+9udJzMoTU3L2qxi04KGzOsgY2KDJ8WLT8OWO3pBxooH+Wc74?=
 =?us-ascii?Q?MAa4NfMa1twbNq7qYF/WtrUo/jYaOgbGABr2x9YqVAjrjjxXRDuKR27a3XoG?=
 =?us-ascii?Q?tTIEI7vaFfyD8fENvzG0wMJvbPXx6VXT9SlAWjZ2GvRv75TupxleUQMDb031?=
 =?us-ascii?Q?nJEYIJLhSWh3GYB59uimF6OFHvLrQC/vqjEVrKHnrWKALMhkzDjwHptkn4z/?=
 =?us-ascii?Q?L/XsuFS0tT0J7HwcdK2JVrzMo00jVlA+GuSaK+t+hqiIjfLJEifi0IM1DhLe?=
 =?us-ascii?Q?HZFtU+aBNsxULJ7v/eNfzSsHAca9LX6ZkXTT7GET4iYPyrXj21kEN1l9bl2G?=
 =?us-ascii?Q?H8RVCaZ4zjlNBBytZbqPquLcZXlUEnpt1xFRijDe3ikPeI898b7x75bqc2Hv?=
 =?us-ascii?Q?GGYQ6VsRordCD6jPA+l9e1nK/dp+YVXgxZQZ0K8JbBjZBckV1GdqaOJIzaA5?=
 =?us-ascii?Q?9mIgFuI2/oLyfEBAk0iXmwD3htQQVmgLZZp8Zx/rRihxhr7oRLYt6NF07AEV?=
 =?us-ascii?Q?Ca3/IA2wXtdPSLlMlR7YD/fGn179Aa2qogEdpryuu50D9+Tp7Mo6kKECKO0r?=
 =?us-ascii?Q?RNL0G3xDAYAzEYyWsa0DXDBvm4fjYSI50ZGP7AnHaqRIKGKPmM3lIb1+rZ4b?=
 =?us-ascii?Q?PsBPBsXAX6D88AhXECNDNRzcwPiePUblnpLX3aMStV+EuTewiIjpQhrf9Jmz?=
 =?us-ascii?Q?YF3wyTru3P4GeNF6G2opjkh0nsvPVQ2vFvx9jaPR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1480f572-891d-423e-bc3a-08dd50aaad16
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 06:00:13.8516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsgSFdqElQSVTDZ3TMWibUfJCZAUU4RdzCk5qYMzsO9Cp9sBQELU9GgqBmjG2X0zh7hn51PQynlholhvwbihkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9409

The enetc4_link_init() is called when the PF driver probes to create
phylink and MDIO bus, but we forgot to call enetc4_link_deinit() to
free the phylink and MDIO bus when the driver was unbound. so add
missing enetc4_link_deinit() to enetc4_pf_netdev_destroy().

Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index fc41078c4f5d..48861c8b499a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -684,6 +684,7 @@ static void enetc4_pf_netdev_destroy(struct enetc_si *si)
 	struct net_device *ndev = si->ndev;
 
 	unregister_netdev(ndev);
+	enetc4_link_deinit(priv);
 	enetc_free_msix(priv);
 	free_netdev(ndev);
 }
-- 
2.34.1


