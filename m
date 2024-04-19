Return-Path: <stable+bounces-40230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F45B8AA67B
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 03:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7891C20F3F
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 01:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341C115A4;
	Fri, 19 Apr 2024 01:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OsivvEaN"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7957CEC3;
	Fri, 19 Apr 2024 01:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713489480; cv=fail; b=X4l2+eEEH7XTDxJ8f05+CPxJk/5+9/9ceYy6qNJ7PC/TmC8rLRg6ZKgfYiPNnv6bctRRj8zWRYZs30SlQHB66oCPU+BTDcqN6kk4Wfjsy8dkXT5pkkHt1u5pxxjky7wZEM6fWnzMDZk7Pj6biHf++IeUEYg3Zfavr+lLNddhF0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713489480; c=relaxed/simple;
	bh=CL00HhW6V1SB2Ag5E8EbRgtJKAyZsDL0ENkfFkMnooc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UCzVraomdgQpPqXodD4cY3BT9aOE/8mmLAcR5mMW0Ah7IF10MumPb+PGJlmdCAxQjtyDSxsWM3bhbK23khmdgwqWbmHsGHWlkj1w/WMiaJDIV0z6La+g8TprsPeMlUyh1yYB8ufhxpUBSi/ZQea+sEFOhko7PJjWgkZWsjXR4yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OsivvEaN; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0Tp+sVZeje143xYdlpcRnvvs+4lcXFWhR3Sq87i4lnNNbH9lrAFK9x0y5SHfSzKBiN6F66okyUNqsI6g0dphYRRV/zgAfol074/oVsx0qbqGkjbKWXr5hKlQE+wht8l4F/ySlJUUhxf0TYi+orNV3EGKcjxwgxJC3O0IKgUBz2EfepI1Bh58/rfCWxNR5ZM1/uPaPzclzkt2jwXFxmWnWiM7UrV9aSPQr2AiCESQhw3/XMDvtBo6e19mAR05gpoXvbuDBwlOvJkDOAOFCOMKJbxNjpsoZ0aTReC3a/4T9XQ7XJMkIcU+V0IWiDLjjHfU7RykvHNCJAs7rTqgTWGxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dErcV3cvMN/wVBySyeKVEjtjSnWp3MSPybJmhmKdLxk=;
 b=TSlB8IuZQJ1mfc5v/WpSSLKqqTiWs6TGzUGT5F5lr36MkVliURWGXmB07on2JyRhT0Tqpz5bkMTj9c1PUPkuSO0MuKSbWgHzC2lY5cNlVU9e4UziyMWVIKVIjk6kjFeGvcwWCTelOwCypVkscS2u11HSCpmrmg5actSfvVh/ht0Vb9HC4niV+a+FiHTspcdjqxwJUZmTb2yYKaRh/V9BNZCLq/BfXOjJAqh8BsQFiWk4rAyi1QJv0eA6prIcbQqXxKsZcNjCAlLzEUnKnOasRNo+tYPw36pBOpve02crIBfKOfvQvR2X/FznmS5e6e7HnhxRnuh+Z1hcPSNIdrikLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dErcV3cvMN/wVBySyeKVEjtjSnWp3MSPybJmhmKdLxk=;
 b=OsivvEaNlkKKlcgdRRSVrlg6R4ouB9/BeeMKsBE76PqqPUawMRI8a7RqZSAta4+wprOdmI6NpknYZh9P8FJlQxrwXueH1dShX3ikSbCOzY8QwKXPz0/DjEMfq95fJSZb2okoV0y6za+gO/pwvqCbgWSnP/++aRWXGZ2LlcJJ7D5vQCB9iyhdTePZVOGtnvXeNlbnA3h2eQoAOqhDjysXmS4ZqJdi/LZuCu2Qjxofu7WYoeCjRqkQSc9e56nuEdFy5YT6td5UJlkek4CGH7pYPnmM67p/npV4p9pgfWAWgwGKVkoGREII3M+sMAUkc6eQzgyRvrdYwe3RzrWAb6GlwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Fri, 19 Apr
 2024 01:17:53 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7452.049; Fri, 19 Apr 2024
 01:17:53 +0000
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
Subject: [PATCH net-next 1/3] macsec: Enable devices to advertise whether they update sk_buff md_dst during offloads
Date: Thu, 18 Apr 2024 18:17:15 -0700
Message-ID: <20240419011740.333714-2-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240419011740.333714-1-rrameshbabu@nvidia.com>
References: <20240419011740.333714-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0067.namprd08.prod.outlook.com
 (2603:10b6:a03:117::44) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d09f7d-0fe0-4491-cdae-08dc600e89c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9rMIsFgp4fyDVI6DSjJdcN3dzSA7nVKmEJ238x8O1HPUn46sQwWKH6UzmAnd?=
 =?us-ascii?Q?L5zCYR9L7API7v/PugcVuW6H+VBMxt2DzopYwyds0zAc3UR6xR3ycqD9Di7s?=
 =?us-ascii?Q?BsDkcgBKSWIIfghOaU5cFLpkGngBgD1K/ZejNFNmUEmTYA/EFRpU0JUAyoif?=
 =?us-ascii?Q?GSBCp5SpwisiJdaC4xqzwAhZV6zHbKxnR59iDT3WGaBhegyyu6ZZW8X5uxlq?=
 =?us-ascii?Q?7OmSEzBI6YqXupsOHLS08JzbKwU/87hRbvEwfUFKuuy5ZYSgVfed+fqaHhTg?=
 =?us-ascii?Q?ckjpEMlMsW/jITsUv+PnTb58+1cM7IuqyubPwXVl3gn+f86cxms1pnml3w5q?=
 =?us-ascii?Q?LYgusN45p3g9cwOS+RIDrt8Ck3Q19iTp/wpBIQRe6WNkiqf4yBnCWdsV50Mf?=
 =?us-ascii?Q?KGutU1c7Kx56rZt5ReYOG+kM9poqjyLedWqqqgEbZpowX16s0HygOwkw7nLe?=
 =?us-ascii?Q?AF+GXY5kLiPRAc6THorZALF7kFxQ4IaOC7igxNj91jBeXQp+gBzWhmUbJANz?=
 =?us-ascii?Q?hJgUwtJujY21FNzD5KHFo4QvI2vXaPSmE2u5w099hNfzhLn7VGi/zgcw22XJ?=
 =?us-ascii?Q?p9/7enPo9Z0wQYfPVJ2UI/yccqGueaB7xEu8XkX3QYysJfrdy7jIrDIcwAn7?=
 =?us-ascii?Q?lB682lRVUDBzD+OIJRkk4FiDocUstqZA8DwpPuFrCju8IPh1eOiOTKmLukJe?=
 =?us-ascii?Q?4JSmSS+vWge5K+EfXC1E4loHIsWKGTmRQZZ447ZxEhZCSGgPbIl57GzdvO0s?=
 =?us-ascii?Q?bwlXybDkBqdj0wMpm/3yBFzTH30/+QNI2ZLYI4YFukVlq9xLpDqWiggFF6bW?=
 =?us-ascii?Q?gkQPewkJ731YMpKdO+AeHY4A8lJrtPuheHhA9PWZuP8tQlUhdFMIA9Z7TiNE?=
 =?us-ascii?Q?Twn1reHxOTK30EKItAZa57P9mfcmC1tCKWrcPMgzNUy23KFUcjrkoQW0VHHa?=
 =?us-ascii?Q?Fe0xMr5V316T0HGRLH5DAev2b5LEWiAuP0CeQO5Lpv5FADEBxn8uA/GmSlBJ?=
 =?us-ascii?Q?PvSar2JR3sISCM+mpy+RdubPH2mmEtOUu422R8xQt2iRktVT7nYCFhwKdCV7?=
 =?us-ascii?Q?mPRUqDOss6nA7mPkVCDnSfon1KO57Bm2UO7MxYwbt8+CojWFTZbS49Vg/LmK?=
 =?us-ascii?Q?4MPgHgy3oprItFK4VGnYDUJEmIkDIU6FZtUjCBfOWYtG3xgNcDQDNXvdDd7b?=
 =?us-ascii?Q?CMGBny+7/UxS+XvdUnqWA0a4QD7umLmHW1WWx9Zv0wro0ygzhgAXHJc5dtsH?=
 =?us-ascii?Q?Q+5OtOP6e6VlH70klpZycuQn/vn0gymUgjAp0HZBQg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3eLlAEdcATmPynlVnccC7AwsGOXKgcHmYG//JAaagapiwbFjzlHRRNCOvzlL?=
 =?us-ascii?Q?lD7FugcfqP54omrk0wwS4ynLvJPSBfSp0CmR7JLReTOKicT5Fm8NQfiWPR+E?=
 =?us-ascii?Q?VichhDVc1DBQJbrF8INeyXvl7StfU6+1bB9UyyL/52CkYtLgDxYJfoGAMW6t?=
 =?us-ascii?Q?MrZsxFrYJJyBHJmUiUhaIpm9RY1E9KAH+iYqjShFEOinDd2FYk/Fnq853lFV?=
 =?us-ascii?Q?yqYH9Mpkgz+uUe9+mjXMZmymzfs9+kWJfWRoJ2THVUgmuUDcrLPcyb75JUk7?=
 =?us-ascii?Q?6cICnArd2wlnemOpkVvBLyS1gSW8TaW0NlHmWGZEwFyo+O91m7xEgf2euAwB?=
 =?us-ascii?Q?uh2ThZGFQCTYpR4SCr7oQTCn2T89tdVtSGy+jqRF+IfKraBGj4LvLozPDUgX?=
 =?us-ascii?Q?hLMHDMPUbZ4F96/E8VIqYL/D1W0OvZIo1c+pbsjGsiPOk2UD9mhibmWbA6u2?=
 =?us-ascii?Q?akYjGNjhTwC2Q0IKcwTfKaymwzwWjxDF/assP7j7foWDLSJW5XYXN8CL/p2A?=
 =?us-ascii?Q?vLfZWoiV/ydZO57MMu8UReI34/TL7Fhp8bOpr1z006b9ZKNOEkjeFRQVV6Vo?=
 =?us-ascii?Q?4rNdEbXb0Pv7K1gpqxGFwymsk+Ar14/oFKZRwLtYFQJNE6DN2XO/qHhFr2cK?=
 =?us-ascii?Q?8VVhE346Vj5a6dCyDVTWrZyOiPtJZur9nzrairlFYDq37oJuZVoC5FpjEVzu?=
 =?us-ascii?Q?/NEZeWHSdX47uahHg+GTdQobG6p1dRlDxJNVyL1AH/j/XlcCTLWdLg4JG860?=
 =?us-ascii?Q?Zo9WDWJhABBk7/eM+Ucrv2ezkRV27ylWKlsJITAcosyJsw2fm2gmT55lolhX?=
 =?us-ascii?Q?QIUhSwMrJRt4ts2zEOc5ECCEePEHC/oyxqI2EAE6SMIXcDjrId5D93+/DZjj?=
 =?us-ascii?Q?CeChYD9u16ZK0iz49ZR5SaEgAz/fUrf5yNn1l3by7pgl2J48TkSkmT1ez9Pe?=
 =?us-ascii?Q?oYKaI/Wr72ixgEMTdwvnSmjZT9e6K+N07em3W/TML2JxLAZArUW9IXWpD3fl?=
 =?us-ascii?Q?IfimDij5wTsI/HfRTbEzM9X1TLNPkt5hNDHx5RysP2E9SxBHfLWqvbrYUCE+?=
 =?us-ascii?Q?xf2nTcqmmo57PnDMRuqW4Va+79SRZIq8ivF9L+w56ThyRPGwPEtFVfCsEPSS?=
 =?us-ascii?Q?yrjNsP9ZezwTM4wrVEBbqQB7wZrEWj4n/69YCRWGH8Fq5xVpiw5q54l7zoJq?=
 =?us-ascii?Q?8SZ8a2WEy863POGOfjRn/DGMTz2hYyFWLLtHSFnGdYepI11SCzmzpg8AULV+?=
 =?us-ascii?Q?+LC6p0PGyGI0wrqPXz/0GnsBH39rlojITWl99cOszIF8LM3Qs0V9bt7GP96P?=
 =?us-ascii?Q?ZYokXWy9WUsnqh5FIBabc1umStz6IqPlk5Pa/kXTZTYjaQvrO17BxTWCTIDy?=
 =?us-ascii?Q?40phAL438ZRrOo5kdmQtYnOddEsojPBk1VXtLHC0XHQsrDn4EPnian1hbAeE?=
 =?us-ascii?Q?gXkyHH8pNRetDxXAP2GhKcVBHIpVtZot50VFwn5ibU/7h8XUgk2YC5UTKdpU?=
 =?us-ascii?Q?BIfhGdfjEQHMkh3E4MvfIbuW3FfbAKi7WXcH3TCSffZLoAAHdkxHDT1hG7uQ?=
 =?us-ascii?Q?DtjgfiYoIIFNE9K8UJpDLC62bWDvrHKGXEwCzK4ZgguwK21VtyRxrl5F93Th?=
 =?us-ascii?Q?aA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d09f7d-0fe0-4491-cdae-08dc600e89c6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 01:17:53.8211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJf0kmyw7OeqCbXruCW4A/H/Iic1hck05uUqYjw9OctIBhQnZoiMnVIcdGBTcB+gpoEtCsEqgvtIvaw7iOD8Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656

Cannot know whether a Rx skb missing md_dst is intended for MACsec or not
without knowing whether the device is able to update this field during an
offload. Assume that an offload to a MACsec device cannot support updating
md_dst by default. Capable devices can advertise that they do indicate that
an skb is related to a MACsec offloaded packet using the md_dst.

Cc: Sabrina Dubroca <sd@queasysnail.net>
Cc: stable@vger.kernel.org
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 include/net/macsec.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/macsec.h b/include/net/macsec.h
index dbd22180cc5c..de216cbc6b05 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -321,6 +321,7 @@ struct macsec_context {
  *	for the TX tag
  * @needed_tailroom: number of bytes reserved at the end of the sk_buff for the
  *	TX tag
+ * @rx_uses_md_dst: whether MACsec device offload supports sk_buff md_dst
  */
 struct macsec_ops {
 	/* Device wide */
@@ -352,6 +353,7 @@ struct macsec_ops {
 				 struct sk_buff *skb);
 	unsigned int needed_headroom;
 	unsigned int needed_tailroom;
+	bool rx_uses_md_dst;
 };
 
 void macsec_pn_wrapped(struct macsec_secy *secy, struct macsec_tx_sa *tx_sa);
-- 
2.42.0


