Return-Path: <stable+bounces-40751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3210A8AF661
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 20:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC071287CBC
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 18:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978EE13FD96;
	Tue, 23 Apr 2024 18:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rfgfNiWJ"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E881B13FD65;
	Tue, 23 Apr 2024 18:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713896013; cv=fail; b=m1Z5HCod8Rd6PX3L6hLyRwsuY8TeQfILSXLg+G9kKhaypvksKhV2aDWk5MMwWgYJOeAwGDJDmxBLNq4R3JincD6lZvmCVjtZYLbtF0QjIJq96i/l3FrJuMT0Ik8xzn0iTaMKHPPCwsL8XWQzgSL8Dgg0gJIAL9OGDpL5ipmM86c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713896013; c=relaxed/simple;
	bh=TdrdWdKMx67sfvF5513h9oXuSpfKDHRVkYPxFmUO7WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C/Ih+1hqzm0wocZhR3ghN72+7g5ltF/kyWippe47w8XSSO8VMbt2R53jd/yZGjIA8KI6FruKpnU+ksszPpBySH6y9AwDr3/WXmGr9KaP3htw4zPKDuWjrm77vUpDFFw47QE9i6Wuyi9R65Pc1nkL1oXLiov/WUJA2vDgXZJu93w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rfgfNiWJ; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgHoTS+hgRvaxTx91YNUiORJmEleVASjai+yAVXyka3GVJImRZFmHHoQkVY/mMPndBlUA/vLkcdt0AIsdqmT6MLnkgHuOlv+mQinAD5Kltnlb4n1MkOXXXYpP4R2uyX8e7cjzLrNmYfV5fT8+HCZmJ6pwRnwV1VEBvl4TNLCfBL+AZGl0OMgZsuwRSAsH/GDOZ3a56qYrLGyNUvPm1gw1CQ2yvswGrQUprmYx0gdDAuGVCp/z1lV2Kk0hvxEpt6S1xOo0bl9w2N5Xu+pJ7bh5xTRfkHmCmFKnLgyT9odpVdVgGq7bOBDZOnCdeCkfI5unaxOtbJw8hQO17ZhbH67Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGYfnk3oVJn78NX8j1P/C26Dl5Nx0pbC5GF6KWVdV1w=;
 b=Nt+P8AC5aFcCmVeOARUXccsyFc2e+SKGe/X3wP5tdqgbaegLgXG0M1D1NUZuz8efZiFXFZ3Ll1tzoppTnwqDpAPuVjAh4e6dYJT3Sg1ZxXxpNzZxzIJQW4moLB8CVeFw3uGDMpCAjs6i62oaipwgQxOcGEkkCM1wFaLNJsVTfioXuMryfP2tEUjHHAs5Yp2tCvi/RCViVYu+WIb25XJXqoevrWb+USiCkz5qxEcWB3Uv7tYH+UwtKbnA0wefc5LgVE216bCPUcXT9NmysgOWAJIlPQqlJkHvA6qKlTAjipOYDJGSROMkAxUVUvGZoM+Vss+whKcEd8wdimdi2/hkhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGYfnk3oVJn78NX8j1P/C26Dl5Nx0pbC5GF6KWVdV1w=;
 b=rfgfNiWJtKYVjmSyG9pTtblaviHD+M5rEglAsNi00m8besqzNIZyG5j61PdD5yv3Q11cREIlRh9JXE8HG6VZZoEjt+4CPzMvVcjshdHR7sYlugiLJuM8aSN9hYq39WidbX+h5PRk0Cd8RuM1FG9hDIj7R4uMPcmROscJr0hoXZltUVsiJ7QMnpsSFaaZIMvQKwJiQPSyDAeL+hZ873Fp1efDPYcKMDdymT7UxBWMQRnHmlIxyA1MXX+CvDAirMYxuWu5cmKAHaVPLQXiUZyQzRa7TXuNzkHZr37IbN0ndDiW3IC3kQztAXxEAE5IqsqaA3rGxulcq020NQf6nz3xKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SA1PR12MB6799.namprd12.prod.outlook.com (2603:10b6:806:25b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 18:13:25 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 18:13:25 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Yossi Kuperman <yossiku@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH net v3 2/4] ethernet: Add helper for assigning packet type when dest address does not match device address
Date: Tue, 23 Apr 2024 11:13:03 -0700
Message-ID: <20240423181319.115860-3-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240423181319.115860-1-rrameshbabu@nvidia.com>
References: <20240423181319.115860-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:217::26) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SA1PR12MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a6932f-a35d-4eff-80da-08dc63c111b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g35PERTApWywNR+V7WO9ki4QRM+hoQApu9k7jtGkWBmQ8Y5kgS/h449ir/Kv?=
 =?us-ascii?Q?dRwJQlDpOPvaDk/Ne5lGT7qFcEmFAAzE8NuN8L7fuKPxFfNS9b+sACzNsCYY?=
 =?us-ascii?Q?SoJxCu2lFSgUMyQqLeH6D4USC52Hbxj9Sd/DIAP1iUXNQ5In/FaQR7Ca6zYz?=
 =?us-ascii?Q?Pt4gqPFiLlC1CNbNY3CeojuQHXSs2qThqPCQWLKXFCJn1b8HTnB4Nl7HCY7/?=
 =?us-ascii?Q?bdXcLFRWYS3el5D8DrKll5WeTDQvxvl34OASGYoaQ6Yfw4/FrsRLmGCPQHby?=
 =?us-ascii?Q?8VfkrwRtQpgt0TEB4TpT6iD3ra+pfSQi59I+jqC6qGaBLazqpgCV4dlMc0GN?=
 =?us-ascii?Q?ZCdbEWsuVPVua179DLk3lca580OZlx2yE5XyRJt+9MRcU+0RuJFV78F3POY9?=
 =?us-ascii?Q?9KdlzJ6wxa4jxQaEU5UR3ScHEdlTtSd9MJg7I3HhOeICK49Kjp5Z7gy25m63?=
 =?us-ascii?Q?3yfpctO0NzLf1xC24Xfa2OjOVaME6sXQiT96O4Q7vJb6EwRmosSI7rjGXCC7?=
 =?us-ascii?Q?WHIj2em3oKa+6c88RptdqgNVyvAEF0MvVOcnQ3ShVKSgrVop9GvFnY0qRNqj?=
 =?us-ascii?Q?OdVnhHvB4XP1TMCr+kXgKXX6d95VfF1R4kRORY55KS1ihxdDOTPP/i35AiHl?=
 =?us-ascii?Q?CpjAVuEJTCYVC0LbCkowdqmdvMg+Jk0irLlSbiJBkPDo4DgCi2MzdcEkmRzg?=
 =?us-ascii?Q?K2J7u7Lv/t8iG0ZeBWIwGaOeFwyvo/gRvGdBoQm3d6leUZXGIcP2F6JnXUjB?=
 =?us-ascii?Q?chMKUHSAPwd6qFdRl563hVk1mI7xK/lOGhfF7J2O8c9WeB/3l/c28+X/JiYe?=
 =?us-ascii?Q?n7vzHwRNGinaOeOt2pxRlIZypvFVv+sZZB+s/44rJqKsUWhWRp+pfWvzbsAN?=
 =?us-ascii?Q?evWZMIN6Z9ZCFZcv9YOHXimcINm3jCIBuVEx4ngioFvjN6cyC82D8MCxYWck?=
 =?us-ascii?Q?qQX8r3sokwigo/iMDlrUTH9hMPnIGTWAmgj5+M1PfkURpPa7Lf+CAjT104eO?=
 =?us-ascii?Q?mlMaODmlbd4zggBFxp2pZJ4nF0LXwt5ik53EoMUuI/CuZl8Qal3UFyrFR8Rs?=
 =?us-ascii?Q?zhwJeIkrjjKZQS+T9yv8+YJ6cfYECFbU/Aq9aSdNLOQ1Ttefqpwj6Zt+ArZs?=
 =?us-ascii?Q?0kQXAttylOvqd94G8pHVYoRPA3w/RHVw2LTOvHNL6oxKM+B0rodndNVsXUgT?=
 =?us-ascii?Q?NlkIk5Dh2rQwEBeZR5GvvH/na0cPa3HJSgfi8occt1NuI/HHiuK7g+0HzqKu?=
 =?us-ascii?Q?0oCMW5oKuSqeudJ/xo6V83aAn4bBIVnjJDtM5Mz3RA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YEED7Gkbn+Kp9FbRMc/FEBzl+atJjvcmQGtqPa8LlVhkm56KAyfXdZC23yib?=
 =?us-ascii?Q?Xe81+pWAGMSys4JnD3DRHHdmZxS5ATNLDIcfuJgxUx5nrpEkidOdk1RCS6zX?=
 =?us-ascii?Q?1Y9YwcfSbr3O6Im8b//WRym0d60fSL/G+mgxRBKWwVysVZZ3cuu6Cy7ZBsz8?=
 =?us-ascii?Q?QCigQLRMoCgzDa1mQDkOHkpDLPxoHw3leL2r8bXuFDo9aI7UyJDZ1rK6lcdm?=
 =?us-ascii?Q?TOaXhmQj+Dihj3bxT7NRBHN5vi/+hrMBcA7NSjYKUrnxI4wDlNZOUkQTwh/Q?=
 =?us-ascii?Q?TCKq0yE23gKhp2Hi4QUcM6uEjRGfvvAs69J6rOJuh4fu1KoGxVVkG1I7zxvM?=
 =?us-ascii?Q?xaRcNG3wMjI0oos10x7g9RzsPu5DQI13v2hrcjrBX63h5LM3WFWN7SxWcwXh?=
 =?us-ascii?Q?fqQcdVY2CgGRcjVB1PGK2m4rD1Pr3ARGhluDWPWTWwindg111dhhNNVx8zkV?=
 =?us-ascii?Q?PxVDcXODXz+OTqFZKWJSO+lv+SGO0kTkUQyanURC4h+VzyjECYgQOPoUmiSp?=
 =?us-ascii?Q?B2K1HNYr03aV8hL8qztNCU8vJeS1pqp9P+tWUlImhOFiMQ/ocAiOUV1KS6rJ?=
 =?us-ascii?Q?mR3tdaMgw08xJ1ZgU08cyIHKZpEI6/bQMTlFju3if3K00w20Gxs243GXy5vl?=
 =?us-ascii?Q?QzjsI4iPDEf8bWKRtSn8TLEulgiaPKhCldcAvFLqOXtFH64H8kG9MKVwUgsH?=
 =?us-ascii?Q?ujU6uKTRQ1gfogRH6qrTus2C7100I2jce/pqcqFryRh7jo9oSnFd55dNj66k?=
 =?us-ascii?Q?4WKX7sGJR44drWvXBR81leNVFIOnBZv0G4x8lWQMDFVxwW/+iz2JsrtQ0A7z?=
 =?us-ascii?Q?m23HZVwVJPhL7qzxmT3DYMXVuNHGaAet4u0WcAUcsEUIo1p7WX58NFG/hRrm?=
 =?us-ascii?Q?UBV5v1+okB5x6gJh6LxjcCEQxoPUDZKG1Ju+UwbVUai7LkJ6c+jv76GlJcN1?=
 =?us-ascii?Q?felR7pZ6m2H9mikUT4TTBEs1/jyLFzhy2VT2fE8qUdrkukrsVAWzmrz6o7g7?=
 =?us-ascii?Q?nHwLT+IUUQ1UBhOGaMqu8gtltexjKKFIVBsbpuctdCGKQKa3cME7Z/fqh2SL?=
 =?us-ascii?Q?3Y5aSeG8tDwR1/6Xsy9vdCn3tSNVX4YIJZImcFiHwUFzdiXGtNqBJBfmQuAn?=
 =?us-ascii?Q?/qohcUFpbG+CfMRsV2lnA4NS8hgOYqRdocVVddWMjFoZ+QzSMOxFlIWdI0N5?=
 =?us-ascii?Q?YiQZfrFu0MLbAVwS9Pq0+jFN4+nF9+iIFGt75+5LrtW+y3z5ZyIJRML/L+Om?=
 =?us-ascii?Q?JThpZWA3Ud11H8JwDHS92X4bpiH5h1GFt6zk0LJKK3OF5ZOEMDfYWfuRrU9g?=
 =?us-ascii?Q?0NL5DUZcxjvUYRHVezFOdbEL/zEZVg+07GnLPCF+LyrxJV35z5h9DkK6Yk3m?=
 =?us-ascii?Q?ayhXFvIqzs0LSvwWW0b8f42QpGQwNqmwSXQkH4q+elDBryPVtgFSJF0KYecm?=
 =?us-ascii?Q?X2QXtYsGbWjkpQqvIUzDCRfW2Sf2inVh7AyXjAp+V48mYRs1nn1ZIjP5Zyja?=
 =?us-ascii?Q?tY3sCi5VWOj+WSiOME1rbtJBc8yxw1fA1cktg3hPcTrfQ/KehWqlvEPCzqF1?=
 =?us-ascii?Q?WCoic1BYA4HpNeXs4OOSsBV6YRBrSjQ7XgDtzf8f21ZmT8F42QkUAZ1Ecddd?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a6932f-a35d-4eff-80da-08dc63c111b8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 18:13:25.8117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ou+2TgEf5qrbWhJr1oUy8gUzZ8095sXYGa+Fn4MNgCR1nIwOLs/QLA8AO35oJXddSAEoPbHuhDlayfx08LJlQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6799

Enable reuse of logic in eth_type_trans for determining packet type.

Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Cc: stable@vger.kernel.org
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
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


