Return-Path: <stable+bounces-41775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BB58B66F6
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 02:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3511F21C32
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 00:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1D110F7;
	Tue, 30 Apr 2024 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EQnG5qdk"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1F31FA4
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 00:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714437837; cv=fail; b=J8t4K9IO3z5oKpy9ZFENOyRQH5QKjknTYqRYGOmAOYUtkeBrTgNFkDqMSHZGRRxArzAwOMgJXHO7X5HjDdimQLT1v5yLf+9z0aQL6jHXOJjZ/aTICSIUlT+9WFu2RFpnIIs9sijEeW9LlHVwjgbGdkwFrp7gbwhCvyM9McPkDvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714437837; c=relaxed/simple;
	bh=JU5lyqYptvn5iYj5LjjhRbwwgsjXJZxGHC1LcoI11KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EPTkElU5wASkOA455GOmdrTKlP4NBi2fbZ477q/PhlZrcQge5a92T9ZPO39ihrg/QejyeWS71DWq07Bu2O52og3szy7hpGJF2vLX7pBHNgbMbcffqjsd+Q2pBUlPGudu24/n/KuBpzlyQD1i23n07y/sCR9GiSmDvdOpdPChmo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EQnG5qdk; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHL5TlFgLiDdaq5o4xFRSXXOlcAUAaiAjviDXAsIYVpM27Yg/8GAz0ZzqwsY1kXvv8fVxQ1mMjxExqhc7AjrY/waeb4omBhzpKohuYPGG1+PeXNUJUCPwZBU7UlFM2cH10TukyNiAi0lxAdQYWNx0RD+hIvQTOvOoKJRNzF8KyLy44/GznYE3dDWA+9qjXIrUIdo10+X8uA02aYTCRYZfrO2fuGlZXSFEmxq+sn9QyvkWY+GIZ5OJuofrNRvzKp+kOEDhdFyErC5qfh8c+E9DPfVt1QA8YlK+DcLid/nlsb0ravOYF4nwLeLeR6lNc8FWgMFpXxbQ87W2mbJ86lN9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jw/tOxxNsn0knt91qrHh8kzcitTt1f+G6RVkj7LEpO0=;
 b=ca0nbf+4Je8Pw0JZS+XVbc975VvNKNQGm8Iw+ygmr3c0IwUjvRpqxyJGeb0s3WAoKC0PB8iH1TkFAGTxR09UVM7U3Zxuc0K8H2LQ0hTskukGSsC+kdjgl8UIolnG2jZKdfTvDqip0f45A+jcuZS1+k4rpIzuQw7v6Ozj3D8joq9MKLfD4qM6yLvovww+UMEtI1VqmfNoezVB6pirgj7U3rkxTlpgg32GSubIdGgibNI4AEDDvrJNonB8uQzyb6C4uroLODaEpklGRm1tKRmOaBF0AO1ycVwozX50F20kfO3xUhV2qNWTEpb4PWoolAkSb1n+oH941kZ0MmN8vD3MaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jw/tOxxNsn0knt91qrHh8kzcitTt1f+G6RVkj7LEpO0=;
 b=EQnG5qdkfYbF1WX5Usuab1mkh1OfpSbcKapqXtdXlJyHKJLCW0sIjGXg7AA0M1H9oLYNN9a/EOq6eArHPI5Rm+CpF213lhHVwyVPRgQej47e95h7oWf/QP5IPHhZ5z5fbvSlH65weTnWgn9YV97LzmSihaFxFn89Dp8bFglfg6SJedhm4aCJuQSlCKCCKWV2B9IzLjwZbSXffVLYeIqSQaiRbFAwe3GLoX0FL4/VslV6ZLsir+Spm7CIM7EIRkWjn6qkty7ml3D4hVbyCg9/xm4AYy97S61oybcPQpPeQf3znQE0muolxTRnu/ixJsgV1Mz9psIDbPiObEInaIhB5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 00:43:51 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 00:43:51 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	bpoirier@nvidia.com,
	cratiu@nvidia.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH 6.6.y 2/4] ethernet: Add helper for assigning packet type when dest address does not match device address
Date: Mon, 29 Apr 2024 17:43:03 -0700
Message-ID: <20240430004312.299070-3-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240430004312.299070-2-rrameshbabu@nvidia.com>
References: <20240430004312.299070-2-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0204.namprd05.prod.outlook.com
 (2603:10b6:a03:330::29) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DM6PR12MB4468:EE_
X-MS-Office365-Filtering-Correlation-Id: 353b0997-c4af-4076-d874-08dc68ae9afd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZjhtdBhcesCy1IySPKobMGvaA6y8isb0aNhhgCbAdWCTGakTWWHpdBY/7oWt?=
 =?us-ascii?Q?2jDPo29MI4tRpYfHQVdiwfsjdtm1dYTp2WuGPE4PAzqkUF80Agpf00wh8/Q1?=
 =?us-ascii?Q?kID7G0511QIFVwXvRwkimKhJyCt3uZAPEHLGLlXdEr3Nb9cYgGqta6hVh+UL?=
 =?us-ascii?Q?oh5gWIz+7sNBdCztPUM53ag7uscwBsMgsYu80nR+NJel9XKpBE3ny1io/7o1?=
 =?us-ascii?Q?sHzHbwpDFGYcHOUAFrTyL/gwQ7pPCPchiQeTin0Xq/jIKGVi+nBtZimO2Zyc?=
 =?us-ascii?Q?jfCnEG8ln7TpbC53mB6BkFspbnnyEm81GfecFn81g3pcVukcQUsMzDuYDL7e?=
 =?us-ascii?Q?PTTFQ13qOWJDwD356cqP0hFg3mBrnBkKMfvCpm2j2LnQwvmjU56x21CUgdzf?=
 =?us-ascii?Q?Dkolmx2tLORYptxpMr71rqxtU0hw0JzX8aOkKjY27/Au9c+6sTq1gu5iyMwk?=
 =?us-ascii?Q?psc6+8Rz+UlLrwzLb4FYVjd1arEPY1Sr+jknsx6maB0Wz3X/1rrKeIsWdJny?=
 =?us-ascii?Q?yEgT+AyjfrCPi2x1qYnfeLxVtGmGnQaMvGBhxplQQ+oskI34b6CSQSxsDDkQ?=
 =?us-ascii?Q?5Ywx2LJd4FpRN7FtqoCF+mp5lkeETYS0J7sAwsuMRxwqYDxu/frDTCgA6z2m?=
 =?us-ascii?Q?Glsofb+SB+qIjOQ+eTmHkbe4XVi38kMxkQSIZ+85jkYiqImxvQ3h1fOONc/y?=
 =?us-ascii?Q?5Qoyx7n8EMMeRw78aXoQg85vO8ok0HoowQKigbCVXZ9AHHdzPckHjJjfJ0gm?=
 =?us-ascii?Q?yEiXJeSwFXJ8Gt3XzhN8KikDouHMUDPqtuPao2gfG4Xwkge3jwAdrTf7AmMj?=
 =?us-ascii?Q?k3RHlzrm8GGJF5sdSyWSeY8VPV2b95hR4+VxKsFHp7UagH8mL1bjy7K9kd+h?=
 =?us-ascii?Q?LxcLR/yxjOkmionPl+6AW8kTyy4VFhpY94NybFIbHGGxYQeBw5wHKyeAIZO9?=
 =?us-ascii?Q?6bnYg1x5vf1pjJVHdFDOHp7azJ/iBRI/rQx6VTMm8tvWlfzr1w/m88Gd0oxn?=
 =?us-ascii?Q?nqESjGTnRZV0vM75Hq6EGjG1Sp6iv5ehN0gBDSLpaFXQUE2CJzCItrebqZ7G?=
 =?us-ascii?Q?WmFtQXQTTS3Tv/NsgJBi4BHn2vuQr99XDuvFIoXgM8Zk5M8XryWjJrUufZKG?=
 =?us-ascii?Q?H1CejSHFifZXBF8ZA2Cy/B1DtK5xlkoF5bAsLUwf7lR1hIj1tLMylpcprkZe?=
 =?us-ascii?Q?Oxoz2VOqt8ipRv6AneVKS1rLiopp9pAayQJfw44HWPtZ0gofrz/WIgPeWNek?=
 =?us-ascii?Q?Pdn65NbDNAYVAgtK+PrieOyqkzLx1N5RpyTN6IubhQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jjRnJDwVhesmCB8hL/HquqthlWqsBYmS8BfuWv+gtIKrMDD1Vl1hAVn6gbUp?=
 =?us-ascii?Q?z+PqVnbqv7v28P6pEWOPoJ9ZN1fwYvT6SBMwAjjQCox+VjjOD6yyvqYcQ6Rk?=
 =?us-ascii?Q?3Wah8C5uSES+VMxpf5xgulqMp8k6ykcNO2Cafu98QxLBqUmflazXjsmoS47s?=
 =?us-ascii?Q?w+3znx4JoNd2m5HUSfwSZyeKy2xN6Y5AhFXITdmnJ9lCVTYwnbG2MubhzZda?=
 =?us-ascii?Q?vAmHyGsWO8ilNKb6qMfW21RXqjtyRKWO9N1ApfOxr05/0GjJZZ1dV+CJaemz?=
 =?us-ascii?Q?t2mIyOA1+ULFn2K4OrtSs/mLToteIcvEAmqpivfLCU20Y90bde36sB5iWe+g?=
 =?us-ascii?Q?0EnO6HS558pYYSB41bPAX+9zRX4tOAvBpVV+tmKs46wvuZfgu9QJoX50ZVlU?=
 =?us-ascii?Q?o1J0Ice8Ol8eiPqHxlDst2kLgImNBtTT2N6mUc5ebgTS7F5LlF9Kj/88vdx1?=
 =?us-ascii?Q?MBSXGeLG0bFxbz3VkV1t+8tJ5CsAO4J5l/cYNBlTGRzKiz3XUgRZ2EBRz2Q6?=
 =?us-ascii?Q?93WiLVuui4R+nb19rlEQbnxUToceoqOlw3gPSxxT/hRzyHV5zPtJwJkhaqMm?=
 =?us-ascii?Q?PRN59utsLxjDV24AGJJgBHpQgs/qRdaGkOJmNK0uGl4hR9ct4KGNRofynm+5?=
 =?us-ascii?Q?QRQ2EwrvgaF6dEyFOE1hxutjEAOIoOcfRHlV6aswn1Q7C7E3FkF47tnmIbQw?=
 =?us-ascii?Q?ibx/nrQ6uA4hKoNu+5HbRGK7ATFp/aaKeaifkQ1QbQWxSY1zSHQR37WAlkhB?=
 =?us-ascii?Q?GnFX/prHLrucGxYxy55hgHgE/A6GsIqs6vPs1uvhyOa2pe+YHlvuQPmufqkV?=
 =?us-ascii?Q?S03ISA9/SOUX3sRQlEC2FwCNRDOh2ahh8kJyE8vgSvwkCIzNLdvhZVr1jxtr?=
 =?us-ascii?Q?+wZ4eQC5DVhVND/DitNovm+7J/WuUf0+wjmKgUPKg8GAcZNE1RQiPJ3SaSKr?=
 =?us-ascii?Q?t+i1iz543V8ucHChY6ziX76y8QaWV02dPKHLCdiFcINYM07vIgOCjpu7lQVy?=
 =?us-ascii?Q?sW5X4BvErrCoI52t1i+/EB2Al4o+3CdwnMIgINRBmLXeST/E4bny43pM5Kt5?=
 =?us-ascii?Q?/TzvTUmWnl1GBRTszctVH/OSJtm3LpXtmDeV89dTAPMflmgFTmhtRIPTibZh?=
 =?us-ascii?Q?Z0Fqug7O1kNiWUHvqL+qPkgvGph1dvyybMcqJsfe+lSAalAcI4s8wFAsH745?=
 =?us-ascii?Q?ziffgZeHxjDkPGkH6es18eT549FJhdVXFyltr4XIubCuGL/8JVYgJBL/7IO/?=
 =?us-ascii?Q?JvywUtUqarg7wMGS2C+9myftwDwFZvwo5rY1E3ozUtRv9Cq6ifrurGqaR8k6?=
 =?us-ascii?Q?DY9ocjGajLY+rrV/1fWjq6uDq/pPgUCRaTeG0OdNvi3Fzj224JLK9bE7GR4U?=
 =?us-ascii?Q?KH/+N8kp7m4C2iCWFKKMk74wY9Tt2fXZpUKdNvUps3Dw1fjQNPVkZSed2wWs?=
 =?us-ascii?Q?TQ53qW0wU8/Zk3w+JWtPFPAeqHHGSLJIdjhuLQo3M2UF0gbYimhnZKaN67Cu?=
 =?us-ascii?Q?nto8nY4FY1Ps/RfBThQFAWWPt9Aw34ngw1QZgmagBXSX/v6c1XUqraJXsmST?=
 =?us-ascii?Q?LsWRs/Yk0H7TlJNlFGXsd96SgD/tWZYyVjHAHCnPaNpX3CxF3mp/IEIOZe+A?=
 =?us-ascii?Q?lQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353b0997-c4af-4076-d874-08dc68ae9afd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 00:43:51.4747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SzF5sSF0pY9Dxy4e3z5U8Pr40Tx8yhCbyBd24Wh3i3SrlGi5g/6EQhiDVN5N0U/e/1Mc2En0ray6QohCs3ePVw==
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
index 224645f17c33..297231854ada 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -607,6 +607,31 @@ static inline void eth_hw_addr_gen(struct net_device *dev, const u8 *base_addr,
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
index 2edc8b796a4e..049c3adeb850 100644
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


