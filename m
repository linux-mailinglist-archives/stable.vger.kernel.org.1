Return-Path: <stable+bounces-41781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 384618B66FC
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 02:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C9F11C2232F
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 00:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F1F17F5;
	Tue, 30 Apr 2024 00:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TJUxBfwa"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0617810E4
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 00:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714437903; cv=fail; b=gbrng6cqfeM2WPxdsm+0am6fS8Z6XHYagPqb6Zt+N6+0eXcJtFdaav+Ll/9SkU6SmbOiqkURPaJmt9+u5z8y4L3K99Kj6W2sopR/3MzCv8apVlX+MFDOscu0GuQrNmXl5py+iZkvwvRsPhzHolOFzKBljCLIaqL05h/P+FmqM9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714437903; c=relaxed/simple;
	bh=wZ4qNDI0R59QvI8wGPZ2nQ5FzC5yPSH2lhV2I8Kmmd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ubGrHrY9Z1zBHkL5oxamyaH1a4RnFrg2ERb2q1oRuf7Nx5Be6AgPM4x+eezBLYibtx1mRPdbKIYOcIldmDsmcoAnDa6QoAswjBCIOYzTvEaS7y31pQ2ss1sqNb/8LiMmAxJnoeHBhP2XqOOgWgYExHK2hKp1jBnQJ4OkVs1mOOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TJUxBfwa; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGADSXVBU4XaCNfa+n0Ink2HWfiP+bHVY5OmITK88McrQMH49WG2FygSJWTOTLFTBulQaqq0Wqwo0OJMRruKVlYVME+rtOdnK2CCS8lGdqUchzYNw3GaGQMTZlmB9MLIxr08tcaVkq4yJZaLOgzlbD/9I/wByvL8nfd2SqCWETQP1TBtYtlbTeoxAtJxN97YysZCIck4DdyS+cSOzv1b9ifWo3+RoAIJ9UUsF2GC7UsCBinFgOylQHEiLMhbcF8GweJWh9n/s7SbkgPF0Gfm00NkkjI62lmw2mKh7brTdH8Hzv5bUUAs2HmSgFuILqzkH0cSUCTciu2gziw+P0pQiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFNELBthwRrEyPRFdXVe6mR5kG9bWLpyozQ6gAKo2pI=;
 b=gtl9+rjq3IzogGLbemlah3haQSFl8eNBOfi71IGpcaCaiNoPo0IrOLAA+WVoglkH69fGjhseNp+RH8JOhH2deGBBcVJDAMIaiJ+SDE4WToLs5FpcxgPFBGGSmsYdkGzvXfazgd4n8h6Cxje0t0T/JnndY7cpDUejMLL9hAnXH2r4UY224zRGaxZMHEuf4758TIPpcKAXdh43HltpoGRDO2M23zaJpezFYiQvzrxfa4TBHYVSPJng9bmKBRQegQJi4cfKETw/lwHRPLlGtqNaA20e6GWeIsDxaRT8wz5DOQ7cLCmAw+U6kGIS8qGKdj1CfaKVx1PBwiDPYNa/Pf/S3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFNELBthwRrEyPRFdXVe6mR5kG9bWLpyozQ6gAKo2pI=;
 b=TJUxBfwalQLcIrlQdhVKDCQXvoWlyrXPdIpIZ1rdXb5LQQPBp/eL6PolMgx5+teXNZXQQHrh3tMrCRyLXYpoDKemNW19cppDD9jAmechybwI1n0XjlzHBC4pMqCvx4WJXbpA5+D6tpTsoXDw3I4sBIafVkzcmZ1UY/eA+cWYQNWIWSujcF0TLA+rL0WquCVZ3nVuKeQFX4RPVEy89Ea/OmoUWOpaxn1EUgm0+4/5xcDpU/wufaIKWp9gVWhu7aGrLj4kUBJK+umvN9+LUAFIh+Rv46dgCKkTOz+ftEddznXw2KXJ44Vw2QKpelbFuBaxeqtMK1lTU3I9SupUWFnqjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 00:44:55 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 00:44:55 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	bpoirier@nvidia.com,
	cratiu@nvidia.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH 6.1.y 2/4] ethernet: Add helper for assigning packet type when dest address does not match device address
Date: Mon, 29 Apr 2024 17:44:22 -0700
Message-ID: <20240430004439.299386-2-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240430004439.299386-1-rrameshbabu@nvidia.com>
References: <20240430004439.299386-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0249.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::14) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DM6PR12MB4468:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f16be88-febe-4a61-b640-08dc68aebcf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wom96v//baEYPpp4ww8fAg2CNp0iWySGrPYNfHBv7nceha7X2oyyiGdasdbI?=
 =?us-ascii?Q?YZPPBh7OjLWmtp0oaPKYIm4EAzF7QHSa0osHa34CxjoV9CBqyEow0pbmpoKq?=
 =?us-ascii?Q?YSEN4SfQtk3VnKWTPBOzmeRburXbduW/dMVkt+oZn7+sWT6/ll5fWSSmhwPI?=
 =?us-ascii?Q?Fvkt/th5S+q9hyWRhzCiGHHqqZcOqb7aiJac9d2v1RK4S0KZK4a5fojU4WT/?=
 =?us-ascii?Q?uGz2AfJq2rTuH04uHFKdotPEMcz5rlUHXzeKndmH9R+4oXNpaesC5LZnhq51?=
 =?us-ascii?Q?50kdA5BXty2SyNAA91lFBs3BhRCFF9OQm9Q8Dbn3+Dii70nHds+uHCSBhwT1?=
 =?us-ascii?Q?c3ccvxuUjcAZL9YMX7arDdLzLu2BNeCEYhEqNysWMaChL2+bLM5k3QemcmQu?=
 =?us-ascii?Q?yZXxk9IR7DR8DuorC8ZsBA85UDeIiEEXbmF0uOci8h0DBAuPxTNdi4dIi7Th?=
 =?us-ascii?Q?19fYqAvLI8zvzPUSBG2elGCy1aiv9L737UGXZLVd/JA5fqKzH8j2p9Cj+lOX?=
 =?us-ascii?Q?/9TuI+9ooT4StodXsVle4ANcbeKfzMwU4PYN78GLTiHi353tJ0X5hFSIqBFB?=
 =?us-ascii?Q?d9IUSnTHERpIpvjsJaAwgclvavVcopdmOleLlsXyOxr8a4ncgG+0MeWM2qRP?=
 =?us-ascii?Q?O8O8BPYz5aB2Sqv2w9dWcZGgCCrgqlWggm2W5n5zl+b9I6d4Jg4IsV86Gvr4?=
 =?us-ascii?Q?xEhi5v5RlmGDWqZPYuEpXQ8HCEJE/hFBICuc/n/yx6nmw5/nGzvUnIiP5dRZ?=
 =?us-ascii?Q?vqfq4DgC9Bp16Y2yzil1W2ooWVLooKNgVIhvwmjkJIdHcjhXBaJnbymQLlbn?=
 =?us-ascii?Q?rd1+v7VJCIfbcfiUKNKDT9OwVDktp5D9LXJNT+7JYpcZDLqhxnRCs8aBdV15?=
 =?us-ascii?Q?keb2nAaS6VIe0KUcAjNiL8tcyu+1pO2vA5rmWzmCU5pNGtHd5GCZpXNK99oe?=
 =?us-ascii?Q?ZlIOYhjXjmXHdcs5FZ1gCRAGra6g1sRTApx5WadvybCVpZrU208P/AzAoI7V?=
 =?us-ascii?Q?OUXN9Jvnt2V7kHrf0woPqx7z+JNlc7i325iHEZTxmQaKym5D1Q5qRzBhyr8V?=
 =?us-ascii?Q?+ggC1MBbjnrcOq1Ecp851FeU0CBDOETZxvf/eZvHHhbTgPlICzA6N8lxrlfu?=
 =?us-ascii?Q?1xwD4qCtm+RyzJVp7GrPLaS5VCuvTJW5ZCXD3x0LPd4uGhkQJ3T0xYsfCL9Q?=
 =?us-ascii?Q?plvTauUPTDBFEqYCSnfe89nDSy13QvNnhjf84/atNb2qyO4b1G+B/ne12age?=
 =?us-ascii?Q?qVOMKx8xxZGtcZlamQCH948SFktCwTwTYe825p2knQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zGzQR0HIQ+noWR2fWQTk4GrNcU5Lv+b9hSXvETVhPq1O7tNzljBppbYp0aQl?=
 =?us-ascii?Q?BAXcZaEQSLV54j21H6iDv6ulaBjUnWCSMjWPd6jkRHH9lWI2cpJV/jURuQbW?=
 =?us-ascii?Q?Dx4uV71aY/Hw/OoAT2pxjP6+gigauPqf0yjhRFMEliwePSjMLdIcFHiD6vrg?=
 =?us-ascii?Q?6lfgpRWmuB/MQEurCBUT9CQgW2h1zQAjozNOZ2WCs2PiqT/4jfvv8VUnxJq7?=
 =?us-ascii?Q?bRQrFl33OtZETVKj26e/P7rF09PCtambB4260WE6mMk1TL9jOe1BU92bYlc2?=
 =?us-ascii?Q?OeKankwuMlMufqj2Jt60Em/3Q7/otneZDfH3SFgixkmb1gmTSQpoKwkmXov/?=
 =?us-ascii?Q?uM4IGoDah7bdrJUsz+LNl8K2vVgdFBvK7Y04KtZ/gQFwzpaVaK9zvKPcVpAK?=
 =?us-ascii?Q?TVC3WP0M4LbS/pl2woQe6bLoZSwa9pdn307ronKTqMHWQfKa4G1cxPuNM4jA?=
 =?us-ascii?Q?dFx+JjahV0uj6ISVFUfcpk5NnwRIAv55obt9v9kaXHBol0xqBLEIRDPDpKGF?=
 =?us-ascii?Q?tebRccbXLqbiIbdklf2g/IXXNgDjZT4e8+XsjC88FSOvpOLFaBYD5yNhCieV?=
 =?us-ascii?Q?acCrRisl5nKBt3HYIMcfdX9CHjQVxB43YC31gQdEVQHHkDLY/UTrPqIgW8+k?=
 =?us-ascii?Q?okf4w0a1u5CardLjOUvHDMEwdbOCL2+/mu2jd21KWGcYZy+Q5skE9FfpJTwp?=
 =?us-ascii?Q?m9cZ+0D32Mhj0RdzpVgacIMmkYCV5wRHZl1As4JRK1CCkC+7H3yEZdVJDqUA?=
 =?us-ascii?Q?YbKf5FwPVzdYO5D/yUxW9Od27c4wxfU2hwK1tWSkp2OadqCC8dlE7GJnqssa?=
 =?us-ascii?Q?tDbWORDE0B8zhx2DHwh/EDKiXis0PS3HTvb4zZf4kIPrg9l2mm+MonFFxxul?=
 =?us-ascii?Q?ScBkX+hV9LtnCVly9zFNxR3+MWBsscwxYE/D9ub/xmqdA1dSq+TIewxZIzZ5?=
 =?us-ascii?Q?KfEfBoKgg+iIxgsTC8a5f1LV25f6PXnbwhwwI96c44cIlIJxvGLwiApFdnp2?=
 =?us-ascii?Q?N7xOuSQcXBg7SLOkddQQufXLzu+5nW+68ZPJ8x9GQT6VXWKMZDFl+lf8JvX5?=
 =?us-ascii?Q?ck7HaK6jFoeJ37mYdJSoBlaf8DjHPSkoP/DJ3NGv+rj8aw1xwBcOXBJ0Abml?=
 =?us-ascii?Q?omKArvim5T3nyVecgG7EQyvQ3/AHGsamJ79WytPABkcvvckhlJu54xkzec5G?=
 =?us-ascii?Q?E50etoD6+otTpXU7/BH9sSraKakRHXrUm/lVv1lw+HPoOiMqqk+g4vDSgdM2?=
 =?us-ascii?Q?5btcYQSN2rtMeyciO1iDcrxwC4fvcoTmbtSdltLrIZxM7QbPBM3ZPWgpMCWx?=
 =?us-ascii?Q?kfrsIB/0o0ivKpHLkIM1lXb4NfAbhdlSFLeJxRa5trnJIJ5NL1NC4HXM7QJ+?=
 =?us-ascii?Q?a95Xv3iFukV6lj2tdreHfNdTq9NaglyxaGBh5/XoTZG9HgCdrNLmd0qZYL9R?=
 =?us-ascii?Q?bX3NOMhf+BM2M3DahRnbKMZLkJJKx+XhIuMEnm20+9YuMnuMynQO1xQnXZUH?=
 =?us-ascii?Q?T99Uuvs7dLCHU8/nAxmNBmQUTm3afOZPLp/wuz930m9uxv/qFTZydW4j/mCc?=
 =?us-ascii?Q?NIAatf1v+qNLdOSgg8vM7fufenGbU6lS1dw1YlZRiOXVrl0TeQTq/pWelOtg?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f16be88-febe-4a61-b640-08dc68aebcf6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 00:44:48.4682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SdsQZ78OuJAsvfH3BF210AmOQHAc/8iv/c9MrSxierdiGuscmXsxOuUcTeLKCuMkbf3uQ5k7MDI9XzeOU4ArJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468

commit 6e159fd653d7ebf6290358e0330a0cb8a75cf73b upstream.

Enable reuse of logic in eth_type_trans for determining packet type.

Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Cc: stable@vger.kernel.org
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://lore.kernel.org/r/20240423181319.115860-3-rrameshbabu@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/etherdevice.h | 25 +++++++++++++++++++++++++
 net/ethernet/eth.c          | 12 +-----------
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index a541f0c4f146..d7eef2158667 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -593,6 +593,31 @@ static inline void eth_hw_addr_gen(struct net_device *dev, const u8 *base_addr,
 	eth_hw_addr_set(dev, addr);
 }
 
+/**
+ * eth_skb_pkt_type - Assign packet type if destination address does not match
+ * @skb: Assigned a packet type if address does not match @dev address
+ * @dev: Network device used to compare packet address against
+ *
+ * If the destination MAC address of the packet does not match the network
+ * device address, assign an appropriate packet type.
+ */
+static inline void eth_skb_pkt_type(struct sk_buff *skb,
+				    const struct net_device *dev)
+{
+	const struct ethhdr *eth = eth_hdr(skb);
+
+	if (unlikely(!ether_addr_equal_64bits(eth->h_dest, dev->dev_addr))) {
+		if (unlikely(is_multicast_ether_addr_64bits(eth->h_dest))) {
+			if (ether_addr_equal_64bits(eth->h_dest, dev->broadcast))
+				skb->pkt_type = PACKET_BROADCAST;
+			else
+				skb->pkt_type = PACKET_MULTICAST;
+		} else {
+			skb->pkt_type = PACKET_OTHERHOST;
+		}
+	}
+}
+
 /**
  * eth_skb_pad - Pad buffer to mininum number of octets for Ethernet frame
  * @skb: Buffer to pad
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index e02daa74e833..5ba7b460cbf7 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -164,17 +164,7 @@ __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev)
 	eth = (struct ethhdr *)skb->data;
 	skb_pull_inline(skb, ETH_HLEN);
 
-	if (unlikely(!ether_addr_equal_64bits(eth->h_dest,
-					      dev->dev_addr))) {
-		if (unlikely(is_multicast_ether_addr_64bits(eth->h_dest))) {
-			if (ether_addr_equal_64bits(eth->h_dest, dev->broadcast))
-				skb->pkt_type = PACKET_BROADCAST;
-			else
-				skb->pkt_type = PACKET_MULTICAST;
-		} else {
-			skb->pkt_type = PACKET_OTHERHOST;
-		}
-	}
+	eth_skb_pkt_type(skb, dev);
 
 	/*
 	 * Some variants of DSA tagging don't have an ethertype field
-- 
2.42.0


