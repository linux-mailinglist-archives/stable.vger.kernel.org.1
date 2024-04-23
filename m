Return-Path: <stable+bounces-40749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 057B18AF65D
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 20:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295DC1C21F1C
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 18:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E5E13E8AA;
	Tue, 23 Apr 2024 18:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t4B9pgPG"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734C113E3FA;
	Tue, 23 Apr 2024 18:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713896010; cv=fail; b=CXeXSQuFsAnkfd0eT/xtJLmCgfOu6RDrVxTRD+cswkF1vMnajch1syvCzyb8hhbvKP3VTGBP1NloA6/5z41UjNmpa2jKiVkllTOFAmHTuicC0Vs5gPi8DVMcTXm/1vUZAwHXSXt8XHOu+YlMSdC2RvgfLZrh0e3fBKpDWfiB/tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713896010; c=relaxed/simple;
	bh=Efdz8G45dJgRkSatbSl4NcrFXQdgKcLgNq966ZXGMyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LLU+5zGHPbdJgeyIPJ19Iy1YQbRSMW0TdVHgAH2c+8JmVEauQIH2yrDLE6QhJjPezR8Rxf1ZcWlrpwOZevdC+aonxfXzLNHG73DOOkye+zFXBoiTB3unVFhdFZCoh8sl8tvkVZSwPfwR+UY5rnD/eE5a4NaKeCTOkyGdoLpCXU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t4B9pgPG; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/MiJy/mBbar9wKLFZ7g2ClhMvOF/ICVFaK4szDpp+iCzK43i348bkVs2O+jW055XIQCRP1SsyEPuO8HdEY1yLGfBL0oKAxDBl1VgxiFTcCgMPjL2pQ4zlWwPLxzpsIbRPhIskY1mkGtMX72SqOMMLoJuREKklYJtFMPuKfzU/zql3pWd9tq/nTnWwgmRMOvnBeL7Jk7aKC/iwtviagfJejmvRwWzN0yGR38XOrksR5PxXmFUbBb/zOWwS9Lz/+cXPHWv5A6cuMykohk7PmLVFliF6A0ojBgdXrcNnQPobu1zQCBk5weo3UibDvAP/MYjXc8I8KYkiYi4tuGY6tKNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiX/fqj6suKE8LTmyQVM+wxzuokRp/GIE0XrRv5+qfA=;
 b=jH8zzY06SgsxncpXRTyDASplmbJHu0IicJzATSvfXqloRE+IhnJ3769A5dZDUkRGvtBUYeveh3Xh5DIbvNLKKiVvc+ibtiHveigLPwQygbZ5V7xBZ+REXza1fTU0M0qV0bet5vpfJHPUlw+6j7QmEJKlDoDQcLh7UqS0bEK8TLa1ZbApDhVGqGWeoJsfp6rPajYcu2lkX54zPyMWeuLtsB215vMMxhFhA5Jnmkb7HDiwuZwS+r8oW0qmyDzX51OTf+T9FU9ldH9pe7U+yQrr0W5VxOpNVvxnlcon8dvWJCH/hksTUEnkaiyyTW6gJaEdv4gYfuVkzG4N9HmYVJkqAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiX/fqj6suKE8LTmyQVM+wxzuokRp/GIE0XrRv5+qfA=;
 b=t4B9pgPGz8TxmbcrMLBW6cs+H7qvDGs96nvTJmdZThxSG0glIuU7q0SEBRNgi6mARDw0Pu1iPwP+LBb5W++Ch2SDlphnkhGIiQetnN69I0V/5/9uOaIIlWZD7Bxuf5NC60/9MQq4CzCAE4szS5nOly0kd5PBjxbhQMzNW4/SjEWanS1SGbunVgDsyrqaS1jD98xFxKYirv30o7tlHxoMJJYDZIb/I+y6X7XptEqv5aURSuWaqazPDOWpaNgnKRvQ06qC+IspMngwd5uK8ero4U2+PswyUL464OLlMnKpwOcxVS+x9tVILM1LEwpQagX/N4zAT+sphZMWwafrYNhUkQ==
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
Subject: [PATCH net v3 1/4] macsec: Enable devices to advertise whether they update sk_buff md_dst during offloads
Date: Tue, 23 Apr 2024 11:13:02 -0700
Message-ID: <20240423181319.115860-2-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240423181319.115860-1-rrameshbabu@nvidia.com>
References: <20240423181319.115860-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0293.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::28) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SA1PR12MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: ad5943fd-9133-418c-ac5a-08dc63c11163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a5MejA9Bw85+1++SHdxL03ITnAxbWMwGOszRdhfPT1H2r/QnnCThhJvfnoVe?=
 =?us-ascii?Q?pGwN7GqUDXQknTfQzSSl95838RtZWedo81swB2kfC5TauYsvGQqzSK2mYcSK?=
 =?us-ascii?Q?zH90PzF53SDjiyvPeK+sDnzNugz5GZ8QOjQEzHFzjscErbq4dZ53gQYf2rDC?=
 =?us-ascii?Q?SEU5di7ztKO/9Br1E+JIhfsBThRUONs84qvHXlEIyNPSOfL6Nfi2UpOXYjj+?=
 =?us-ascii?Q?pHMTKTWaTp+jdLP4PM/lthj9gUUzaX9e9WU6mLY5tr+uHKR+xTHSqn6cdCjj?=
 =?us-ascii?Q?DA0atiCAIOEaxFif80R/D6ixrhvh7J1D9uFgls28u0nDuZQ9FZD21pPeH0yj?=
 =?us-ascii?Q?DrPoBSV9jBb3ZIpbhqowIVq7U5syi+ql50gDddTOahWmESU3PQcSjpaTIXuj?=
 =?us-ascii?Q?GkMNF0Dl4SvZYat7gRmi5WLooc6wNzkfeZoGumeZsJf/WWhgy17qXWnm5h4O?=
 =?us-ascii?Q?8nvRiIWIwoH3NGaRR4zBlTT9XSJIkbS6xUFKRmPSpcibzLn6peVGPqlO1nQd?=
 =?us-ascii?Q?Hhyoqkkt7tNq/H9qgspCpXrINwZEcl1kx8UVRpDrdRaUBpRVofSOhlTaSEof?=
 =?us-ascii?Q?HcfP994KgEOufaUT+x/ChhSyHNPs+xWpFzfcC7WLptOSBjQLAAQ5cUbdezR+?=
 =?us-ascii?Q?lwegaLb/mfoHaH6FeR/jmP1r0/26c6skTsjnAp9L6zHJdKcUvepqC/3Ou1My?=
 =?us-ascii?Q?5KaFh1CUb72p/JoPAjSP4oAV5x10vGg/nxcBa1pUYpCpnAMQ/FaEzwtF8Yka?=
 =?us-ascii?Q?VjnobCnUKrQejSKE1qLOONFOj/4T7LnKlEkhHtX0Npin1EFmbYsMYFtVtPPw?=
 =?us-ascii?Q?2JKWg1OkD7IK7Ew2mhFr9Zh5Tu550AwCPk8dkpBnAkzteEaiON52rDfbgf67?=
 =?us-ascii?Q?z75er5nseeeVwx3JDmRaDg1XNwJCgXO9YNyqMfa0VyctdpLbdzaDlmHMdtSu?=
 =?us-ascii?Q?fKOEmBdeOHXQMePrriEqQeZJbtqgoWCHlD2r3lkkil5It1LdvwmpkNtY7/qu?=
 =?us-ascii?Q?6o4bMOHIZpm1ajP9p7GrY8UmM+g4nWcDH5MqK6zEEI5kwhE6cxwKThz8SolC?=
 =?us-ascii?Q?zxWWhXB5nwuVkfwNLjwxa+t1CZNz03sPtkKPhCl/c0mNWpI2ZrENlAKS014n?=
 =?us-ascii?Q?fxaK1JAbMneq6gBpoCCpB8fJC533oaOzU7djurtgdi4dr7sE+c6aSEq8v6uF?=
 =?us-ascii?Q?fPUm4fZRMxz7+phdYxuzvihYtnT36Fd4ThAr0NdenoMr1Uf8xtbW4p3gnvtp?=
 =?us-ascii?Q?XJB4Sa/u4wPKn9IvWdbRiwzjmraYZQ7eyUjoNm/Y3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4/vudT2ozIzRqlLYJ53bSz6CTNYyglArSYNWYv5lNin30e4CS3UoZa7kFJzU?=
 =?us-ascii?Q?km+ORg9WqGqP85KU95XG8csed/CSZgKxMOvQ12/PMVh8oZ7nucU5syfy4Ojk?=
 =?us-ascii?Q?yldMFsYTxltmDbZQI1vZnhCR+zUjeervPSX0Mu4QQxJkfwTDFardL7ZuNXa4?=
 =?us-ascii?Q?X0paByX4ARXrP0Sd82P1BcbZifUDZn1rfpsWKoRCQA9Iyxxuy6/3Tt12/rq7?=
 =?us-ascii?Q?4N73SKkdkpNZSGXROurjLCmQBPVf2Csmsnv/kG4APP1P1Aq81wdB9wu4Eo4H?=
 =?us-ascii?Q?NjIk/ZD/R11+LahogoiXZcwo9NU8faLeaJVA/YwqnzrsoDCEoMwDULDsq632?=
 =?us-ascii?Q?xaGpBZPREg81iR5uI5T9mSSSZAuKWNeUfPxnzRHVXOgYpVAeLrvOMJA0yo6C?=
 =?us-ascii?Q?HVpDlQcORkg0CEfxoVVa8y95hDm04WxrJIPoyr7K+b7FLTST5/JWdZ1ajjn2?=
 =?us-ascii?Q?TglAjzCWisNW5nD2rb9Wb9SdH7Son2uXWBMOKHxBDLErB45OJBwwnXuTR+wB?=
 =?us-ascii?Q?TmMTZON8MhkpRZRdF4GpCRgYEc5XxSecdTm4yr2ELFs1n+9n5PbKOPmHAnKJ?=
 =?us-ascii?Q?xil0W5ptXremU0+OoFh0kbOdkv5BgwUFGzqg6SIw1nTSUxHjuP0JSAg9lV8D?=
 =?us-ascii?Q?ddCnysBWrMdsNvo9k5dj6Bcl7Y6srQVBoMxLCHXYjDNGAw1WEonDNsQXQkmk?=
 =?us-ascii?Q?dJTJk7qPoSchl8UHBuBjxLPguXy0I3qj13u9tYniJXazFLQi2F9VN1LbrvlJ?=
 =?us-ascii?Q?7w3CR/n9RXNwvKV1EQ4pSgoRz1ZR5cSJjUlBidUgdUAVhNOUyQTKe/8KsMPE?=
 =?us-ascii?Q?xlyxIGNw+DmgyYc6cgzj3zIedkjUr5a4kJS0BJThc6VwPUcKfVpr2ZGjgRUm?=
 =?us-ascii?Q?tpCMs96hk3HUEmo6RpDtG/1zBhsXLoVmiuaaLTQItf8U5qrGSwQR3JSt3m2e?=
 =?us-ascii?Q?HCn8WSj6izmKdf6TV2xJ9DwkA5k0td8PyG2d2NiXDt4cfAw7hZ5xA1qiLeaF?=
 =?us-ascii?Q?74bBLnEb3zsXVCqGe7AkGncMTfbRapFy10Tu9sHHIAG3o5yl+sZnEX158pI8?=
 =?us-ascii?Q?kxGoFdMQx/yvYuuEyjg7QR+HlzwZucrQ//tuAxbq8VEHu+8bS0ycV+7e/aEV?=
 =?us-ascii?Q?KCsNXnSc4m0kTPoelupcKe9XMESYyiN/DpFjB8NqLFiEDqpS2EcgZA5jU+LC?=
 =?us-ascii?Q?kkZQ4xobZbbFMIj6Sdncnehee5wt4mRK6NUovkNmyMvVYSUCLUIwhOopf4i8?=
 =?us-ascii?Q?VhDwJvhrScnrpQuPhvEEVIjGQJ/5cpjZ+HdewYJbzjQ7MfoIObJb2a2cMtGV?=
 =?us-ascii?Q?ToBAOqlxLA/UDWP1wS1dioAR9c/+bSUrHrpJSkAntwGK09MMipJ8OL9DUw/y?=
 =?us-ascii?Q?9Evl7hHeuKFv6EHgGNTeTnx/B//GZdd0lL4JG8lglkOmKhCTwMqwleL+M548?=
 =?us-ascii?Q?wLL8f4e8Fbf9Nv/hr31Cfgj5VeNZYReqxzEgQao642jGCkjKVA0LBKHX6s6j?=
 =?us-ascii?Q?1Fxr6dHHSuskcE9QarpYm9NTsNQwKQ86FM5GdYtDp/zdnd/2ZPclTFUn3bjb?=
 =?us-ascii?Q?HqHF+X+8WOGq7A3W1X71ZPy9BvxpWbj2KTSJTLX7kwM91dFBEYPcV3/4f6Od?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5943fd-9133-418c-ac5a-08dc63c11163
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 18:13:25.2643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: auWpxboKmGlLRDmatnlO8kP+lFlpyyx9EMf+YKAKd4jgmnmyXxntTsNH+Iwv61mAhbvOwu8MyaU9c8YccowQmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6799

Cannot know whether a Rx skb missing md_dst is intended for MACsec or not
without knowing whether the device is able to update this field during an
offload. Assume that an offload to a MACsec device cannot support updating
md_dst by default. Capable devices can advertise that they do indicate that
an skb is related to a MACsec offloaded packet using the md_dst.

Cc: Sabrina Dubroca <sd@queasysnail.net>
Cc: stable@vger.kernel.org
Fixes: 860ead89b851 ("net/macsec: Add MACsec skb_metadata_dst Rx Data path support")
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


