Return-Path: <stable+bounces-118905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A1FA41DD8
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95E1016CF54
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B54E2673AB;
	Mon, 24 Feb 2025 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C2jhVj19"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35427267394;
	Mon, 24 Feb 2025 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396636; cv=fail; b=kneVSx0d/7HgMTX+omGS2ni+UXvVmYwqk09baAw/U3xZguxcJTkjNwo1jQqrnusLctiDgRFCyi8sb46S3gX3gOPkdz/YxPyJg4ZipXHKOXmm9C5hr+EKCkVlPImdSdph8U2NojDFGe1MSb+t1hpSKlqbDMA9RZLuqkquNxhu/IY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396636; c=relaxed/simple;
	bh=ppyi+Rg8YGW5kKJxsUK/X5x+gzoC+qeanrrTxHtWTrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=krRVWhfXd6qL8pspBPhyW5lzYwXwfi8+dC0rvJIyCbzmAjno6WTzXrkWJ2fgkEHuSKB96w5pK8F11p9LPpqkA10N1ESrWvOR28nkUGF3DVo1o8iO4xqoKN6M95AxotkLtV8/n1IIsdFJMy4E1gdeTYrE3bvTBeValMKIG3lHgoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C2jhVj19; arc=fail smtp.client-ip=52.101.66.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azyn6mVY7IyqdAacoGiVFYzyjcd/Yi8m7KOLWA2fdhTgHYF3G38ExOduEnhePtt/6CdEuwcZC0AVIzrRRcBE4ReLjtqlFKB2r6/bvWV0OGnJ+pfAREaJqBU/27kzIUyPL0w8s3Kx2FwEiJzX2eXnwCOageacWONYLGgxz1bP/Ef/ZECdWUuxJgVkxkEv4hpg17bgLUpQBTO4muJBAE2tfsjqwYxwpXTD0Cu8tmkCAwOAxv0zD1091GCfZSV4fSl85RVLXSkpOK91EUnYbKYBJ3zuOVyCowm0BwTpDRuCZKgoOnb0V1fy7SrJKhjOd9BSqj7ZQs0oMjtIVvvxmbMRXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIwMgLMMe9NpiZyUBgyHTL9O4AVX8KUHEVRjqz+yruk=;
 b=YU/orPtFU7VXuvLVEbXOj3YaxvKxLDzGNxSvRo/aZWbIc8fR8JFMxjNpy+j8yrStqlJ28U5wLbBodFbNXfmtOwItlM9w8RAkvtMnOZRY59A4u7Fdii5v9t3IAofcT8/bgQvm7NOXbVMfzItU5c4rDX3CFAkWF2h1h4wASkJOqrNqQQ1dUw3Fup8Btm3C4NryG82dY9kRdMtgJ1GAZvYOwEZNI7qo5j6ROH7LqHK2Wz0uxmAKzBtv+TAUGX4Jumf2G4NBnFVvR8Rv03vnPjbv4pZcVbT/8E2BNO4cm345xWCI9UPfj1SApVYu6Ah0NaQCYR7ulx+2qlttMBW/KC+aFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIwMgLMMe9NpiZyUBgyHTL9O4AVX8KUHEVRjqz+yruk=;
 b=C2jhVj19hVywhEGJzNFAGJ69WU3XPUWE7lv9VOpCaL7euoy7O1YxYLE0O0EcWWiyciVJ/Bg7s/CWqBLNh3zlhK5CMr/u5F4DkLZDGGY5qVEqDTTJoovTuqt5Jsj3Gnt+f9iOJtPN4Gh1suQvb1bI50qTRDMpWRNRP+Y0MaIh1FXGbVhpqsgndK5gA/MuCf+CNrGAFAl0j3J4TQHadSQiVafjqtp8PPM5gSAPCjMlEsqUMKD838/EG/yMIagWuXGFkNhF0vxbUY5yQM/izABw4ivccphzIfdRb/IC8+dzvtHbJimvoH2wIVPTvFkk/HiifSpuD4KFVzaYFHk7ERkz8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB8346.eurprd04.prod.outlook.com (2603:10a6:10:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 11:30:30 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8466.020; Mon, 24 Feb 2025
 11:30:30 +0000
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
Subject: [PATCH v3 net 8/8] net: enetc: fix the off-by-one issue in enetc_map_tx_tso_buffs()
Date: Mon, 24 Feb 2025 19:12:51 +0800
Message-Id: <20250224111251.1061098-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224111251.1061098-1-wei.fang@nxp.com>
References: <20250224111251.1061098-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cc80953-6044-469a-6079-08dd54c6a516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vPC/YvxYU3vo2MVcq5BGSGTtjvmJ9Mo0QQALpdcFdBZbvWCPLjmzj6snVjvG?=
 =?us-ascii?Q?r4jXV7wlhT+QzrX+mRaIHaLrbAv2DcW6pjTey32obCe1k3kkOSND4Y8x/5jV?=
 =?us-ascii?Q?nPH/QSBAFhM6tNC15g+GuwHvDWV4VtrSAlCvziTJDdeK0n9tSZZs8BfvHRXg?=
 =?us-ascii?Q?zsXzDzETQ1ds6qTpPu1ofWx/GSgVxPBmNdnlFVCvcgRcLYbb7vNKWmP+h+Kx?=
 =?us-ascii?Q?L+vvVr98k6bkshU8BMsdOBR7GZqCC8f7XOGASV2IWQ+5oUpTtEPaCvlfELRQ?=
 =?us-ascii?Q?NKKrqYsrtq/BqxYg531Nx+YlLJscKVv0tlu4SaQd6p3xsEGOv+FJQU+VAheA?=
 =?us-ascii?Q?TkJDK0W6cMOMnlZ+dkdmcyHkkl6bONUfLuhYFQ/B7sbKVBS8UuDn5nSMG5yi?=
 =?us-ascii?Q?MmME+M3NXiRJeNr+YWep94Og0ngVnIQ2MRPY23Q41ocdDk8XA2qtzMdWzbuI?=
 =?us-ascii?Q?ZD13R8nBM2lCnroXMltDHDgFmqpePpijUTjf0KUu/E88ozH30KFk/e8Dp8Aa?=
 =?us-ascii?Q?Zn0ErEyQSxQdEEasFac7rOibr/M8PJRPqoEyXRC56zJXJDI7H9J8hgMsG1yB?=
 =?us-ascii?Q?Wv3ydaypnkyfEiObEiludIkH33bVSnUGtSN0qH+1jt3v+sMSXpuGLQWj+Nz4?=
 =?us-ascii?Q?5//f0OqNKKtPRYGyZCN5JqMQppBmzkQy2fk3QUA7ws3FtstTwBscOpaR2Fhj?=
 =?us-ascii?Q?AtGkIBUJYCQKQy0TF+Dv5LJO0WojbE9d3Y7wEUKI3c2ciLbUREFOvdODlLtQ?=
 =?us-ascii?Q?kSSIk8mZKnYXft6i4v1CJsUgVjDF7wu3Z486YiZm7phiOyP7NnJ7MMSbGMWN?=
 =?us-ascii?Q?EB3XRYtDUZr0touLtuklMKLh8/KXD3xflhfjL35N0CTHUY/bQl4BXdhj++st?=
 =?us-ascii?Q?UHFfdxn6lOyOsVatPcxOawmGgzse21aR0rnAKWqFW3PKRaW1QHuHHQxweTp0?=
 =?us-ascii?Q?uVXtB62UqopGUm2pgMxzd9XGR8VLL5d3/lR0J9xQhzdw8Ly9vD00dL05k8ic?=
 =?us-ascii?Q?SGSaIb5Kjno9PPHqPj6PkfkwrPzmXrBZEniytxqHB/WL8UCdKEbYStqmlyq6?=
 =?us-ascii?Q?Z2mS1yyjI/MjJgZ1K1oPl1/a+H1NS5kOaVyfSm+go8kK37hIz8uCtun+etGo?=
 =?us-ascii?Q?H50mT6QnFkgYqHxvN2V7LXx4p8HkY9UoPwkBYJiRlbpNPQIb6WezBMX3VuMp?=
 =?us-ascii?Q?TZiIxaERYobMOtE8uz+KAsMavj3Mkx1HXDhRI55vkEL4I3ETk1tyyDZGguYX?=
 =?us-ascii?Q?3Hp5nkbKqw7bTd0u3lNLZyuC6i1aOTCKaApXNl4kfaSto60ex2y3wRZFgGUM?=
 =?us-ascii?Q?j97ljdnfk5KIOHDVnaqnzbHIpCdVBp6sP+9tsCXDQOYLSshuKmXiuamUpE5z?=
 =?us-ascii?Q?XlbCFMf0ro5HL5/GSB/s/bhRlCxW5qO+kE4klxQA93wWUj/XBMfj6V1Knfs3?=
 =?us-ascii?Q?SwvGxJDMJHDdUMyE0GxIikYKbj603CGH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MBqPLgWdBLaQnuo0lZXpjemJaQBn3o63agJ31i5IvVrS1ROFoqrCLrPB218d?=
 =?us-ascii?Q?06ZNmc6BYaqhOPzXZpz2UH1P27EO63boPBF7iko26FHD/AOHiYbR15NzB30O?=
 =?us-ascii?Q?IDsTWR0HQJBWAW5p7QBeUbhPz8rKitAhIescHj5HN4JLhyYfgBEEDpWf6pW/?=
 =?us-ascii?Q?yzAd3Sw7mlMSEFgYjyofs8OXYosxqvAek6Ba/WHZQeMh4ZTHIo04peSemIFH?=
 =?us-ascii?Q?OFWAkjfpKnRaqDBGYflII/bN+cUgs17vPPEy6xILgu+6va3gdRND0b9j+S+c?=
 =?us-ascii?Q?Rrw73oHq45U3tuU0W7opW5XaTYLxwXrHfyw5QslmvI9loEuUKtaMaibTGK12?=
 =?us-ascii?Q?ncMwYBvKly/ukaEp8A8+TmcFOh3yfb/gyKXVRjSDfhZYecUfO2UPFXeD6od3?=
 =?us-ascii?Q?zqsqeRfKgGzYB6XLMVWOwnMJ5CTMz2aCpVyQCh5IgK6aSID4LGLrEUajaDkb?=
 =?us-ascii?Q?VZmW2XeVscMWejnDfMrOTIqE99PKVDfsMxq6cuCCLKqObO9aYCA5695qJN8c?=
 =?us-ascii?Q?fJIuxMHnpWuL2wPcf2Rx8SU1DUdUl6+L15pdotlhsJA9OTlX6dtuMTY8cCdU?=
 =?us-ascii?Q?5uSw0rzW1gGF0ZPW6vN8yViM4o0RngTE7Yc3D6vFAUbfnexhWEnPjX0IgnTO?=
 =?us-ascii?Q?pziA2HinvjJFTR65NZcV1WfBI+zQM2W70ydC9J3/hkAY8Dfl55yyyoaE0DKU?=
 =?us-ascii?Q?LqZ++fe/odSiEbA06W9+DtJRGUCtCqYW5YZqdCCP7RgmAwAj3yqvRMntIYpu?=
 =?us-ascii?Q?X+a1l9lnaAuGgWk8YHt2ck10sICg8i6xMdewm/GGOzTe412vgqH0Ew9ySYV3?=
 =?us-ascii?Q?sqeer2EO5pFtz9YCTXzqn1O5WI8LcvYI+/6Zk928RsaCRczt77cbJj+8PnoB?=
 =?us-ascii?Q?nXlXpVHwxHZTK7TNFFgoK8NnrApJUgUdOQOUxl+bDxMNyuVVuMF1AB7HaULE?=
 =?us-ascii?Q?ZiurVObjLObDQ7IlCfErF25ZWMhwLnwHs1WSkCVFkaX4sX7NMfjHMYtiUZlG?=
 =?us-ascii?Q?k9g7E0cIhBSfMI/aII4nB1PhdcsC/iAZRlGUEEO4sqYDW/fiRqvOmgdG6xCG?=
 =?us-ascii?Q?5b5yCmrxPvtMviFza3EvKmwPFJj01hWfHVMxwWpOpvymysN37XQPg/L4tnEM?=
 =?us-ascii?Q?lp/8OlEIe0RzOmJ48t0il8mUvKxEpvIUkZsEaCW8VRwJbeibPikjI1z8ND9F?=
 =?us-ascii?Q?a3kEzTHw7RHkmYPF3Uir334rULzXIgNLL/jihVOkwEi+XiaF/3/u8jXIbdMr?=
 =?us-ascii?Q?RBNHyYoZzbe9lO5BYj7LjojDJPGvRx5gBhOW6mh7clB0sSc3td4lG6SuJrAY?=
 =?us-ascii?Q?adZpRHbHioFlisQI7IL+9GRU4ul013ZrYndk6fhD7d7CSjz/R9ULkDmQ82Bo?=
 =?us-ascii?Q?OJjf/EyLEUiVcR5rWbyJkeMJ6ExxgfQAMnE/9rCXysqhQXYF1F3oGw6nWVBk?=
 =?us-ascii?Q?7HHe2ADRF2cJeJtO5+KSpmZKIv3MhtDFByo1Ze1/WCEpNEmKWtvtIZPisDtV?=
 =?us-ascii?Q?AsnjafFycr43nDhVMn9BKUBZcN1QHwMRRrGntPT8tICv8+A7d6NDS+V4HB20?=
 =?us-ascii?Q?katudstPHfBRAk5E4BHaWbaDWTNYlIDJo98OItVn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc80953-6044-469a-6079-08dd54c6a516
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 11:30:30.8698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGU6wkn2n9dBILloNF6/XgYu1IQ3MGzetzrifGK3Cc4qp9SNilvzAA+0c38eyp6H1fFIyEyHSWvn6JcP1LQ9tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8346

There is an off-by-one issue for the err_chained_bd path, it will free
one more tx_swbd than expected. But there is no such issue for the
err_map_data path. To fix this off-by-one issue and make the two error
handling consistent, the increment of 'i' and 'count' remain in sync
and enetc_unwind_tx_frame() is called for error handling.

Fixes: fb8629e2cbfc ("net: enetc: add support for software TSO")
Cc: stable@vger.kernel.org
Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 9801c51b6a59..2106861463e4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -859,8 +859,13 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 			err = enetc_map_tx_tso_data(tx_ring, skb, tx_swbd, txbd,
 						    tso.data, size,
 						    size == data_len);
-			if (err)
+			if (err) {
+				if (i == 0)
+					i = tx_ring->bd_count;
+				i--;
+
 				goto err_map_data;
+			}
 
 			data_len -= size;
 			count++;
@@ -889,13 +894,7 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 	dev_err(tx_ring->dev, "DMA map error");
 
 err_chained_bd:
-	do {
-		tx_swbd = &tx_ring->tx_swbd[i];
-		enetc_free_tx_frame(tx_ring, tx_swbd);
-		if (i == 0)
-			i = tx_ring->bd_count;
-		i--;
-	} while (count--);
+	enetc_unwind_tx_frame(tx_ring, count, i);
 
 	return 0;
 }
-- 
2.34.1


