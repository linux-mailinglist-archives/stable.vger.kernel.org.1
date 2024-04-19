Return-Path: <stable+bounces-40323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39188AB676
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 23:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8082B22164
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 21:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7F813D248;
	Fri, 19 Apr 2024 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U9AFzqMV"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D4513CF83;
	Fri, 19 Apr 2024 21:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713562245; cv=fail; b=PskvpwolIf9uWBdhzDkDZmsAbzPIhAc7NCEbhs3+eEe9OyKW+4HOvZX3bD41lzzj+2OljLa0LCFqBvn6n4r7Z49WE1Kza6T5g6iXzsZf0vheS+7f2AjPwVXypRTB74dwS1fRwv3LWNmzaUKWrNdWxtYIX4Kr+iGjdYRJQcIqUgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713562245; c=relaxed/simple;
	bh=PRreFg2b6JlM1eI2FTA9DBICxWENzZBEIAErLWH/8zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l1mwragkdK2LNSgC/5XDOdqCwnpx3tv+BOR8WHjk3xZkJkXc6Cvpkqhz4zxBoFDTs1ODF49mJ1TdyowGCgM4o+JICr9dHxf3M2QXlYYRSDmJz75yIyKwsv/OpCIIozZzMolJ04YgeuaYeudLOkCSPkwfIhEgPmOEby3mPxJyDM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U9AFzqMV; arc=fail smtp.client-ip=40.107.102.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJRyn2rP/TJCYhH6dHJ7THl0m+1I1uPnV31r0lkjXP7CP95SuxBElovGnMD5P5F0ZquECX0W2ZUi+jwL9HPaQavmvLFyfXpj4nl23IjutW5LnjLgdY1Sdg3NvG3rkNR+aSjNjygjkFuU1FWDz55cisbbnY5kWC4312yvNzxH0VRtLow+M6mppDDXnoERn9BGLMaKCsM/1sR7bXYZKD5CXRcCUSFdmbbfjn0w6f1+j+bAqlJknsbGvlp+2dGzUxJIpTFpEXjk/qhSL3K8Kt0vQKBXsQ23Z4QVkrJiO74XJAvtZcEI+EzwdSURXJJ7AjIJt2PleYlgAzgwkmLg1LK31w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+K9qTCgu+fLxD1AmLbEq9daN/nQO9+YR3G2/6HMAZQ=;
 b=b9x3HXub2GrOylBIrxaKEfxiI8amgySGnn8duJoKYv3q7MyWQwMKhqfJ8ep9bAJ+70rYSQHc/TvUZlWREe7uxcrbNi/LYoYpFxtnczuS31zAT9rusLVteuBhup1LYNnBH6NlDyXtn3D86jqPQTaLBPJRromnlYO6uiJUI9EJMcynqjk7+85i9bv8lSecAofFm2aRFoW7+H/KEmvMixq0gK/d9s3Z4VhXg4MRxvFmb95vRXsOmuOZrGYFu6NhOEEYSa2Gqfqm5xGwULGC2PGGhxtyTYTEa6auORCL6k9tq0ogfDMKcP2YOI4MeynaiTg74j0+acBJQN1LMluD9dWi0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+K9qTCgu+fLxD1AmLbEq9daN/nQO9+YR3G2/6HMAZQ=;
 b=U9AFzqMVjHZDED9bwiLlsi+RnxK37Dupiir1f9QbOa9aET8iO0PYQikzbDs4wj+CnzDS1U6x9pvw8hyTLyNWSkma4w0/hwOgBTquaK6rfoeAsV2LATnOhOmQfDsgeZKNZZJ3CcfXJvUXiKBf4i5rprNssyvBQEXo8ZyF1KlN4y45fVbHVRyGRHp97QgvlXh4Kx+e2bBNjKZ2kOzS/Ais2onsAHlm6iCXqOGcocYC2NLHHKzzpFbKbRjUEJ618oTbNPV09nYor5kMl0r5/9NxuEHZQC9YzNie5iZ1TLM//QLlZeape9MORapo3LNY0hCos1DNTs13pGJf6kTbysiRXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SA1PR12MB5670.namprd12.prod.outlook.com (2603:10b6:806:239::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 21:30:39 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7472.044; Fri, 19 Apr 2024
 21:30:39 +0000
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
Subject: [PATCH net v2 2/4] ethernet: Add helper for assigning packet type when dest address does not match device address
Date: Fri, 19 Apr 2024 14:30:17 -0700
Message-ID: <20240419213033.400467-3-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240419213033.400467-1-rrameshbabu@nvidia.com>
References: <20240419213033.400467-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0228.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::23) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SA1PR12MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: 92a91a68-cd06-499b-90f1-08dc60b7f531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mFFASv8gk4w+efJt066U34s3JOyOcCMkgjREhWChaTPR6c0AP/jGt4Wm+2va?=
 =?us-ascii?Q?fdLyWtwhHgh+Je+2+zbv2WYUlNvXpTUGRwoQACnA7khuAX1ZnyAY74LStZnP?=
 =?us-ascii?Q?wEvCiKUQilYqlgt0VkkaUCKWQmBIlYXyNz0+/avSNtI2ixKEV+LkPmKEHWiw?=
 =?us-ascii?Q?UU/rJDzuiHxNqVn7GU6aLRunYMo2T96Ph/rZ+beD53NpAugCu8ZH1H+Fj2Vx?=
 =?us-ascii?Q?OqW7xXxJ16SepOU7Y7oKHgReoOVTdEcDrf1XUyZohV97vm9WnbIMdD7W2NoQ?=
 =?us-ascii?Q?XoD7XuFosqtbp2BKqnhSmsObiGT/n3ISWk+GHGykUpgTDHRMOszJycpQ6F+n?=
 =?us-ascii?Q?g/LLUNfNPA6O5A1XfBTC9zaAwIoiYgCioj5e+qNXDnbQuZzm8KuXfpdXaj0O?=
 =?us-ascii?Q?ZHbWNl5DYXRQvj3jxbQZRI+31Y8HgzCw9RZ0IbQsBBvuS0lRU0ZeT6SlzL6y?=
 =?us-ascii?Q?McVLnimeqa8V8PLEQNtSGW1EQNkjsQO4Mh6kilvpwm+t27tDm8xspUt6bevk?=
 =?us-ascii?Q?HLHeQr2UQc5QoB1Ezvzp+F65a4q21gto7rjrcBGCukN0lktMt644M1QNnSEc?=
 =?us-ascii?Q?Q3zl4KkCCT7Gh1CqCytYsNP6eC2EeZr2ccBz4mrA07d2kkG+ujnT5PYnC4gX?=
 =?us-ascii?Q?kk2H0vpYG+hUkU41eJ9Nyl3Q8QaeoUyPUKCNthhp7x8vGpm9QyVtAKH9RocC?=
 =?us-ascii?Q?7p+2q8oCIsJor7KdlKqQHS5mFSCe8mpadZCQznbEBbD3K7SYSfvsI8g3GCSv?=
 =?us-ascii?Q?v7Ky06D0p29hQgv3NBzbpM/iCFTLhT9qlA0iI70FiwVVdpmZPHYOlJjI7Ri1?=
 =?us-ascii?Q?bWIzf4HaR/OjwQFfGk3V54pCD63LOsmQbywRHFXP9NBbymeVqiGz5VRC5rjT?=
 =?us-ascii?Q?cZylBRevQFo6FVKdTFIJ2XuYzwVgtf6Sy0PssG8lAjIgFbomyWNH9Aj4AuvQ?=
 =?us-ascii?Q?7NBYPMIpSn+UY4Am4GeRn6mI72DK7Lo7X2Lyx4hxLc7Hh6HO+Lm7JsAcTkQW?=
 =?us-ascii?Q?M6vYc3sYm30HzMgsB7jcWeBVFktaDtDLRCv/Fp5zJZZAulG4JYvQFAinIQPU?=
 =?us-ascii?Q?profaep/8o4ql8qIULAfbIljxvGULaJ7XkUb2bq1Q7nIabz4MeyHIYO/PIM4?=
 =?us-ascii?Q?9MgzxsqyU4hLOhMme0ZA1NPXiGY45OOzbiDMF1GtSgf62IlWcCgaN8HWo2mQ?=
 =?us-ascii?Q?mYzl9adIwYsDXaNVBcQr2nPrUETqb7crQwMU6ALX2pGWwfmf72kTfRXnTopz?=
 =?us-ascii?Q?iV7hAlLZ3AKesuwtZLysnYdKERl0A8s0JGzyiXntbQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/wrKUOtkiXOOL8xxyavraBq3T0ztHOkjlsmVYcnrdngabM9Qt84KxFHHLjGp?=
 =?us-ascii?Q?Z5OpTy0LJZTwseBtT537WnWLclKGNotwK3wK9pGYoHDm6BzoTneoOcw2r7Mk?=
 =?us-ascii?Q?c7bxtwzSA8l/1PxZcnAYrw9t9QIJbhojpMgxeeS7QG1o0o4aQMiAQvhAGHmb?=
 =?us-ascii?Q?957C442IMWp3LtwG6kdVbdcQ2r8CQOusF7SqEDEa4LkcG7a2JEzahMiKEJb/?=
 =?us-ascii?Q?gISD6FuTS1c9PeNr6AyIL/iQbmKVvWaAmJfEIAgNJGIbrSdKm83MRnKXi/Ud?=
 =?us-ascii?Q?/IfXbDoZeYOTvDPE0su3/gPWsGylkWIBjMXt/YB2fLoGEFDthJCIUDuCxO/8?=
 =?us-ascii?Q?/2CvDIDg4GsUvYIQ35fuxPogxZ02ItaxdOlokkvSooJZ5/ncbQkL4/uU+eXL?=
 =?us-ascii?Q?HYaeou+PiRhqC0cZ7+OU+eypLnUg5a9IkfUeLYYUrOldg5SiXeVQw+gih7nc?=
 =?us-ascii?Q?X1YIOtX0zeJmGBqgUy37CDMRa/hKlAgQdIhLhgkU1yg7JXTZZgJC/gMSZDjz?=
 =?us-ascii?Q?tJbkageukgPHTrMJbiBTRXoVPUQR+IYMQDfirbSqs8/eoWROiV6ye07WVr2C?=
 =?us-ascii?Q?hkWEDEyf5Vzuo9HDAYt31626aq/KUDvDc8I7z+JZ4CAbAYNXyRxZo6M4WUic?=
 =?us-ascii?Q?YOqCLejO+GaNoEVxeQFrnQScMG2wJJ1Tu70y5/L6oNPG21mhqA/E3wULhF91?=
 =?us-ascii?Q?jlliWlRzRmGo5sxdShkQm2T08W0stw5PwCbFOZxzQqZsW2IfHvYKDqiaqRNZ?=
 =?us-ascii?Q?Y3GJgVS5ZnefJT3Bqf/PxUrRq6iAXZpo4G3YtxfF48ZdPvqoVWIoPuW/wYxa?=
 =?us-ascii?Q?wuZjZcwJl5/CRdt4avKUp7ntL2+i0o3KhJW3lDSn9+1XgUJ9UeeDp87CJgwP?=
 =?us-ascii?Q?ht5fc/p8nB49x6KYGNMGMhiHZBo8KggDHjO0ySbvVR6SH4VUvZtEy/s4bXKh?=
 =?us-ascii?Q?I43aCAjeqXlbFqo6oX/+7y1U8qxftcvOdjtHAaH4b+kaubMM2QbeXV4ziH2N?=
 =?us-ascii?Q?3VvN+MrF0/5nguROFL0RaKQpgwKSHXLVlg4meOpJ1mfJzohgejI68VsdY5m6?=
 =?us-ascii?Q?DXk0hVnIvASx2uy1wCcvi1l5nbQpE9QPz6JEEBGyE7cW5i5rxp7GXgFuv0+m?=
 =?us-ascii?Q?dWuU3PoSuCqQxrH2wGvQDWTv5G9TPbSgwDyX7vHFrrXzTcw3qF5C746/9KvU?=
 =?us-ascii?Q?yFTBlfDIR6Cz6aq1Ku8OlLyyigLYn0zhzGh7lRi7OjhzEWbrQdPTL57NO/Vw?=
 =?us-ascii?Q?O2BPhwcdYQjemv1LO6mbAAm7tHBJFVnGssmxPIw0yBBKOI+OoNghooVhZ87k?=
 =?us-ascii?Q?RLm2Yps+kYo1zzT+VeWty6wANE1IZpkPWe+6k1ydV53QXgt7Xm72oem5/N9/?=
 =?us-ascii?Q?hDOj+qwSSHWiDqTlHuyqknDTeaY7ZcC1ddlO+mQ2GJD4pB05TfR5w1oO0KTU?=
 =?us-ascii?Q?/vzaxcSyitOeqrw4Y1OrD4mvh6ik8CcTczCop2B3zJcxpPCjN+MF50YyMEbl?=
 =?us-ascii?Q?42GWXqtsERZd7cNOnUa0USevV6X6jOxP2ynItqJCwxrrHEueRIg8eqXQAFbL?=
 =?us-ascii?Q?F24bn+rle9x8f0lHLlyIHySstLMBe4IdF1I1IbtLgW/QjVoPJ0GS0vCMhaJK?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a91a68-cd06-499b-90f1-08dc60b7f531
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 21:30:38.9992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fgg+MY/sOuZM/HWjDnhbbR45xTu/I8ORdgNeFvmdN8UT2QJU0Klbqg/BJQVvbdu9oF/S/3CghSNltuxje3qWzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5670

Enable reuse of logic in eth_type_trans for determining packet type.

Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Cc: stable@vger.kernel.org
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---
 include/linux/etherdevice.h | 24 ++++++++++++++++++++++++
 net/ethernet/eth.c          | 12 +-----------
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index 224645f17c33..f5868ac69dec 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -607,6 +607,30 @@ static inline void eth_hw_addr_gen(struct net_device *dev, const u8 *base_addr,
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
+static inline void eth_skb_pkt_type(struct sk_buff *skb, struct net_device *dev)
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


