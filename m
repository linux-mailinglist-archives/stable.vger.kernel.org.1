Return-Path: <stable+bounces-40324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0144E8AB678
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 23:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7027E1F21454
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 21:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D8A13D26D;
	Fri, 19 Apr 2024 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dDA4IyNO"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D7913D247;
	Fri, 19 Apr 2024 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713562247; cv=fail; b=tzMG64/HTb3/CY6xC+WRNDPJ0PQbiAp6krJoME3N1kj44uN/ekGI054d0/znYSOMoVPzpMC3MiBPucG0vE1LYd0yO/0P9Mu/SuEijJ+cP4SSeG+z4oADKUoSRPwtd97tqr/b773vVzmSsG7J5f+PNDseJ0v3xTTP4AkcdnSq7mI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713562247; c=relaxed/simple;
	bh=ZSRDmpw+11K0lshwUvrp+IrNu5Ba0+vnhIYdjw+Llno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=otYMVkiCt9BsoS2XwKpRn/Va/AutYg5z8lCbf5/179rK5QwUok2a/v7S3VXqCrzwICZOn/Mo6vWLqaxQAuM9xDoh20LimIKIaU+iMb0/y939s9O8LqgV/vPPVID6fHExiuZUXiRm4A3oRNZqYBlIGs/UfuBKh+wBLMf5sfGcKZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dDA4IyNO; arc=fail smtp.client-ip=40.107.102.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Az6vCK3ebX0qzwZ+7a9kDAd9XjBQzcQcLoSNs3V2zY+UI12kGpJsu8pKyxz0DCf1042F+QBcZvr7Ba1RM4lEXBg2oaSPd/ekuV0/61fVkRAYEbcTmX+kRuIxOKxq3X3zbVWAtS8JwTX6wtEpj9DaidMxdF+SuYknJu3GhUZg0fCU+nQXdByKLxROHUWMtc0BWjQNzrDRymJghgyzmpqXBCAJ/5nsuJCvdy2ZnsHZLJ+NIJb0CXCpXi9u64Ly8AQ6kVzdgDUfXAdHpKqwLvjEySynGnIRXWOXjhhmYVO91B8L193j3s10SBJA44PIV9JMvjEnd/jXx3zufkEXxQW8Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVrGf85eSBj90MtLP/dwbEl7uBxndrW0yabcQrZUF9E=;
 b=i18A8GYzzLLXTEY+iBWT2CJrHi2AK0sUkCN/egtO8u43NBGrsmNeqDtK1kfPISYUfLM8ESk7DkThqSAdaDyifkR8EIcCqE6ipOa2qZKW9lqYPz7ZsDEIb4eDq2WdpyTXgXtQYDD5k8NLPbMb+HontEa7Ch4Jm+brAOpYA5rn18fpJkCXAffh11v/98Jx5O9ATzkhDUpnEjNtn5t5l6Xagn/pgPK8BTQDtlzOZJi/0cLDFJR0STJb1oH2vJx9OMFy/RvquCGK548mz6/8CsKhFNnLR8fSJ6GaWBEcRxBHpNaWnDU9x/+vDg/7IXlZYY2b2G7a/qp23mC/ZAyw56Aqbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVrGf85eSBj90MtLP/dwbEl7uBxndrW0yabcQrZUF9E=;
 b=dDA4IyNOoMKg5lM0MaVd1ROWGrfwGY7HaLwN+2tFw6uD0WwTMzKqGKTufP4+pl8fYTKFAcTBVgrrx6J9ptR0wuEFTjcJYNgJI1lj/2GXByKb4Vq2As0UFQwV1Jcv5+0fSh4M/hZHZNyiRF8rLcBK2qS68MTfm9wF5WiIByh5af98OzjNicabFRGtd1YePzNV4SP3k3HrKcdejhVtbrH6DTndq+iiX73MjbazZ4OdC2dhxitebgOC2Q4WlBXdnfqPS9uehkHThS7hpS9psUBhJJzLwuJ+R4LQdrG4kj1CdU6ka9+Zcy2EKRYsYlyHq9WchhWq5tMfbxhfdmv1CA8Amw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SA1PR12MB5670.namprd12.prod.outlook.com (2603:10b6:806:239::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 21:30:40 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7472.044; Fri, 19 Apr 2024
 21:30:40 +0000
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
Subject: [PATCH net v2 3/4] macsec: Detect if Rx skb is macsec-related for offloading devices that update md_dst
Date: Fri, 19 Apr 2024 14:30:18 -0700
Message-ID: <20240419213033.400467-4-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240419213033.400467-1-rrameshbabu@nvidia.com>
References: <20240419213033.400467-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0237.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::32) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SA1PR12MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b397b87-b00a-4201-0bb4-08dc60b7f5f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7S9RbOhcfkoId4BUD+OVXySAfThO9ahxqro7ECE0orAC7TlXUDCiUt3EZYT5?=
 =?us-ascii?Q?/KouOWg5/iiKUFsY8OXVDOyI5aZ6CH37RHLimMsdKN6l8KX+V70DSSRYxukv?=
 =?us-ascii?Q?qe2wyhvoL7b73UX+hKCiI4tdpBeqa8/CPd+ngnGgvrTaMuK/S2G4WxQO3z5w?=
 =?us-ascii?Q?2MnfNH9RTyDmgvnDMEOKjBEfabDr0wFur995y3159SIWFcTcCPu+TtAYgvJ7?=
 =?us-ascii?Q?vac2BVLpaRaIO68W+dAFcw5MJ+bBJhf1fL8xL6lx/a9qQdFkgdqSjoAQmmUG?=
 =?us-ascii?Q?Ad0JKjf+HJQOMrHSc8f+OBpHiFfBhJmizoJlARNxkPYHlT9B2Y4sRFIBBDPD?=
 =?us-ascii?Q?+W64NP9mLOD9KmjndTkPtHrYEHsrgaaFqgj8cXcq6UdVyrnG3aJn7rcYRf1S?=
 =?us-ascii?Q?Tsqg4xl+k5AAO9ginyRsx531PAwaDChzEviS+w22mpz6/Mzs8svCgZ7cEGR/?=
 =?us-ascii?Q?iBlMSQI6jhI58I1es6Zcx904QvY8REFuG5P6FXhw8/JVSyEKK2O4tCKHKz3A?=
 =?us-ascii?Q?7G+5/iEWSSVHsjQOx0s25kV6tz4iTGkeUBpnfvaQAsFm5eZBK3fsyyDTRwf8?=
 =?us-ascii?Q?561eR5ChBSX/5mjAo8X4hDkiaNrIeV9RCySxmh4UtxXqjRNBkdBguvVf2Lyo?=
 =?us-ascii?Q?4ZLIkx+1zHP55OCDrjvYndZU4aGGZt1Gwl1+LGI5VpkR70w6vrwboDtSzUCV?=
 =?us-ascii?Q?RoxUNPkrUgGpPpd3OkARhyd3no4Ai0QrxjVrkIcTe5cpS8B382ZUGRKAy3an?=
 =?us-ascii?Q?SgaASPgQ5eDkFGzenmi3Nw4nt5cq1NXY3edGXz5GLIrLmh5JRUnW3bUPv6Jh?=
 =?us-ascii?Q?GetjFnxBUHl04+jxnxsG1pF6UL3c44AMzfHZk9k8n0e0j9xYN1EEt14nHXUn?=
 =?us-ascii?Q?k4zuYYKiPkkhkB51stAfyfB8II9dWjMoIE5PZu6GSIL3zZJ/qBgV5Uyor7ZY?=
 =?us-ascii?Q?FOa7OMX2+nR5YxbonOoVX6l6H/twu/G3FsvhloOGmiLbOWLMJgCjNOLQ3Diw?=
 =?us-ascii?Q?P3UHytchB0jcN5USyqyf0zM8zcNdhwJ4UyPhtl5NKxfNXZUNvNcw+mrGXfpE?=
 =?us-ascii?Q?IFGdQjDq1FupC0btWGKlqA5SSZRV9kBYxDgc9LNplQr9GyyT+hBuh1k+m/yO?=
 =?us-ascii?Q?EPNYLTQ0iq5UWYDbo68uEFgp5XQjWfNPhRoJcy82Y5IZnTJsLkKQGEjioRu2?=
 =?us-ascii?Q?hmmXMKzrPGst1sJd5gSbMRn2lF7CM8OxlyiOKwruSV2JJy2J3i8tszxQ5NN2?=
 =?us-ascii?Q?68jmXThnDj/nWV0ylsOjJZsk+8Ar1dKv9PMbcR0opg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mPqGwiCMg/4D33vFunSIFlt47bXkCa2w/2PAeY9KGM5HVzVGaNW+twyRUqZT?=
 =?us-ascii?Q?FBlz/Y16zgJiLNBVq8wpvRHOWXC27ZUgD6LBleaEnj/Pe+Aq+3HZ8bRFceEN?=
 =?us-ascii?Q?bKQnFhJvovPWDBmExuaHvxPeKtjIroO34zZqCQDTdUeEDiI0HHD7ahwILp3q?=
 =?us-ascii?Q?hrsJyqdRHqJNTz0ReJZKetppdm5RUeCjRf57Rfp50dgkQbtyoYLxAFkSRY84?=
 =?us-ascii?Q?RZnsyrwjFltuMSMXEr9uHjF1OwPENTSWhKaCmIf3EeDvHxrKUBUD8gOGAboB?=
 =?us-ascii?Q?P9J2aYrhLfL3lGnwXGzE+zoYBVjxSgelBvKP7kXRMVuZWInjTh9pKbGReWms?=
 =?us-ascii?Q?rlmMGZf1IQoCEVd4aA+YOqJ9jVj08PCm06nRKlMB+ZpOFohrrrWGjsRPqEUK?=
 =?us-ascii?Q?MNS2EnrXjdHLiYsNQcYzNJZxfMIPc00rp/weoK2Yi/505JHsvqvtGwWK188T?=
 =?us-ascii?Q?KP0WTJ9poyjK4BFD9HgQOFKGO7yOSIYEFWoWvFo44zse5UvwmBiN6sJwsTlh?=
 =?us-ascii?Q?8eG7Hw6O0CkHw5NzwvA6wPlr+/3oVRosTIsSE6FzzQnGF6nC8SYuRkrfVULc?=
 =?us-ascii?Q?cHVZR8rVKgoH1VGrQ5LDNJJp4KI0fXChFYwNjfs/8CAGKZZdGfs02bgY7fwr?=
 =?us-ascii?Q?812VwqBtmidjA3PYpX0owD0NL5i+widxmgnvy/RXxPOnnEJLFsjdGZrBnkCz?=
 =?us-ascii?Q?Em2diMJa4UL5t45UxfyJ5fVROeVMr5M7elR8boK1iazgBJiqEkvYVFNQakYl?=
 =?us-ascii?Q?K5nsiRhbrb/QVDdYnCjifNEdoKVNpFRr4IhjnQtwT2pIhl9/79O5MRSW7wil?=
 =?us-ascii?Q?f4gaMrIM8MaPohtYNWoIh5Ko579y5XhBMj6t69bI/qJDup86pGKVNFsW/xNl?=
 =?us-ascii?Q?c6+bmzfCbrPfdAM40Au4l8uuzmdXMj911RRHJNFyBrx1vGy0dYKQd0KluzHl?=
 =?us-ascii?Q?pnxdkJDrcQkClFmk2ONetQcO2O2uao0AxE6Nub0jsRm3z1FX66BqL4fRRFx7?=
 =?us-ascii?Q?ZOj71eJXzR0LAwSM0q0ttHmNNcWJAT0VmvNUlxikcFwjO1q5b5LrDei7yJBL?=
 =?us-ascii?Q?cCLImrKY2mVaDkCt+uC0W0L2xvEWXtjZisP2t7TFTOq0hf3gwgl0AUcSfPAS?=
 =?us-ascii?Q?Yh5HaXMrhFH/WgPtEXMsv80BaRF33l9ft+G3jK6Jj52FhUFbQimtD5DnbE0b?=
 =?us-ascii?Q?AJZENHcpOIQEDQDyGCjjFmctKLjGXx3JDoPgVMNF1gkvfYpVxOlXHdDV5eeL?=
 =?us-ascii?Q?axAZwI9ONzVBno8Kly9b+uMkTzyCPs3fekzmideTZ0Pq0Q0Qazm77trc+zBd?=
 =?us-ascii?Q?xSKeJQyzQ7QK3zWi8HmZ7ECh3dOQvV+ObFj0PDDpj7P3h2NikK3co2xjTTd+?=
 =?us-ascii?Q?gzGHqjZrrlkd3HUX/Kn/pQQ2jaS09WTfSeBPfCR5TxieTRndUiY/QRULK4lf?=
 =?us-ascii?Q?O8dmhBkLAtA7PefOByxfMA+lr7VO1sTwq2hhuKTXFFJcRdrBPirId4IcXx/M?=
 =?us-ascii?Q?VDm9qBrv5Sz6TDEhFcyrusWaTn2RJBFCv7hiZRbCKSe4b/JvIve5PzKxQqtP?=
 =?us-ascii?Q?QsFhRe6OoO+bOZaF4BnDErsnq+cBlVe0IUFBekZLdFZUuUvYSVwVEF4+7WCJ?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b397b87-b00a-4201-0bb4-08dc60b7f5f0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 21:30:40.2438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvTKJN6lHikoFHU+qj4Dw0QOFkcSIlC/+/k5qtdmG9Fs2pEu+TrUm5PnLDuiED85UuMe143MtWNOD7JKDme5Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5670

Can now correctly identify where the packets should be delivered by using
md_dst or its absence on devices that provide it.

This detection is not possible without device drivers that update md_dst. A
fallback pattern should be used for supporting such device drivers. This
fallback mode causes multicast messages to be cloned to both the non-macsec
and macsec ports, independent of whether the multicast message received was
encrypted over MACsec or not. Other non-macsec traffic may also fail to be
handled correctly for devices in promiscuous mode.

Link: https://lore.kernel.org/netdev/ZULRxX9eIbFiVi7v@hog/
Cc: Sabrina Dubroca <sd@queasysnail.net>
Cc: stable@vger.kernel.org
Fixes: 860ead89b851 ("net/macsec: Add MACsec skb_metadata_dst Rx Data path support")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/net/macsec.c | 46 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 0206b84284ab..ff016c11b4a0 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -999,10 +999,12 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
 	struct metadata_dst *md_dst;
 	struct macsec_rxh_data *rxd;
 	struct macsec_dev *macsec;
+	bool is_macsec_md_dst;
 
 	rcu_read_lock();
 	rxd = macsec_data_rcu(skb->dev);
 	md_dst = skb_metadata_dst(skb);
+	is_macsec_md_dst = md_dst && md_dst->type == METADATA_MACSEC;
 
 	list_for_each_entry_rcu(macsec, &rxd->secys, secys) {
 		struct sk_buff *nskb;
@@ -1013,14 +1015,42 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
 		 * the SecTAG, so we have to deduce which port to deliver to.
 		 */
 		if (macsec_is_offloaded(macsec) && netif_running(ndev)) {
-			struct macsec_rx_sc *rx_sc = NULL;
+			const struct macsec_ops *ops;
 
-			if (md_dst && md_dst->type == METADATA_MACSEC)
-				rx_sc = find_rx_sc(&macsec->secy, md_dst->u.macsec_info.sci);
+			ops = macsec_get_ops(macsec, NULL);
 
-			if (md_dst && md_dst->type == METADATA_MACSEC && !rx_sc)
+			if (ops->rx_uses_md_dst && !is_macsec_md_dst)
 				continue;
 
+			if (is_macsec_md_dst) {
+				struct macsec_rx_sc *rx_sc;
+
+				/* All drivers that implement MACsec offload
+				 * support using skb metadata destinations must
+				 * indicate that they do so.
+				 */
+				DEBUG_NET_WARN_ON_ONCE(!ops->rx_uses_md_dst);
+				rx_sc = find_rx_sc(&macsec->secy,
+						   md_dst->u.macsec_info.sci);
+				if (!rx_sc)
+					continue;
+				/* device indicated macsec offload occurred */
+				skb->dev = ndev;
+				skb->pkt_type = PACKET_HOST;
+				eth_skb_pkt_type(skb, ndev);
+				ret = RX_HANDLER_ANOTHER;
+				goto out;
+			}
+
+			/* This datapath is insecure because it is unable to
+			 * enforce isolation of broadcast/multicast traffic and
+			 * unicast traffic with promiscuous mode on the macsec
+			 * netdev. Since the core stack has no mechanism to
+			 * check that the hardware did indeed receive MACsec
+			 * traffic, it is possible that the response handling
+			 * done by the MACsec port was to a plaintext packet.
+			 * This violates the MACsec protocol standard.
+			 */
 			if (ether_addr_equal_64bits(hdr->h_dest,
 						    ndev->dev_addr)) {
 				/* exact match, divert skb to this port */
@@ -1036,14 +1066,10 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
 					break;
 
 				nskb->dev = ndev;
-				if (ether_addr_equal_64bits(hdr->h_dest,
-							    ndev->broadcast))
-					nskb->pkt_type = PACKET_BROADCAST;
-				else
-					nskb->pkt_type = PACKET_MULTICAST;
+				eth_skb_pkt_type(nskb, ndev);
 
 				__netif_rx(nskb);
-			} else if (rx_sc || ndev->flags & IFF_PROMISC) {
+			} else if (ndev->flags & IFF_PROMISC) {
 				skb->dev = ndev;
 				skb->pkt_type = PACKET_HOST;
 				ret = RX_HANDLER_ANOTHER;
-- 
2.42.0


