Return-Path: <stable+bounces-40753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD2A8AF664
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 20:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B29E1C229A7
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 18:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E417C1411DE;
	Tue, 23 Apr 2024 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TsvzfDtj"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A52413E41A;
	Tue, 23 Apr 2024 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713896017; cv=fail; b=PDeKwTxm53VD8AEZWoSXBeorhqqG1qC5Bl5mPnljOd6+YcfJPQEXxHRTCgl17UpBatWzdEYwG5T/qK0Phd9n7+4rbatMtyUXG/zGyorv+SGezfLQbcdkQerKAS7RpLJ11ybFhFxPLLy+EVXUGtXxcRozXo1WL0O625Gh7oStz+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713896017; c=relaxed/simple;
	bh=ZSRDmpw+11K0lshwUvrp+IrNu5Ba0+vnhIYdjw+Llno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cKKTxD6SUvqXZcQunLPLUNe8FPXwAmxY6mYr50bEsE4v4PliYBsj8kZGp9AdmTfHw/NmE9EuIljq06rls0jxG1keCq98XsdKqh+cApEBwslbaX+u63Ls7SSTV9dEY1kwOXDtBp56AvdfJqbICT/UBB1rg2LMM6VuaabPrg9VABY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TsvzfDtj; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fko1QbdlF51hn1V1ymk+cedDY0EgPPVzvdF1FfRP7WSzN6+y6+c6i9LsksGoPHKrZOuRlege5tFy5wP2GF4gB/FgxHLFjaLBmFAvoGwu0vPCP4J4r7f7mW4HTz7DvVQrZZhaxRhai0snirwOD1N1oK+PQKZKgij9ri0mWv9QowNuxZEQB4G7zXewtxVZ/bbxq3nPUOUf3ijo6/ErCkEQCTChzXPtIaWoBpCBl/uvp7+6pw4jBT4i8ZOna47p7coBcH11p622R4mvYJdTH+IYWmKqQZfy2NZhptlKK9pXVMVua44ip/q396/Osv57gY1xmLsI2z2kdyHdsnZfUsObdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVrGf85eSBj90MtLP/dwbEl7uBxndrW0yabcQrZUF9E=;
 b=GSK/TQBgFYEfGWybsX4C9VlgzaTojyrLyqbjggabjKY+cVUUyQaoLWnXG1hF91JGZ2D7u+PdAiH39+1K9CuPapIoT+TzDXVt07cA7zziqtB3wsb6wIJVAJ8qozJey4dnLvER6+Skhbasi4+TcYj/NRmNYAg43SOhhJHm8Puq+2QR3E3urZ4gKSzPJGaQot1lda0UEIUs7vdbnxNJxNKdho7WbXI90OooLl4tZFgA38XdwOe26DHa5bQD7EiUT+qso9Q+budod5ITq7jyLSgAb4ruJdBihBBCS6OG/OEx1wDyfHv7RqExkOutUye1mZOLALD7Lt7OejXAEmk6oxaYZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVrGf85eSBj90MtLP/dwbEl7uBxndrW0yabcQrZUF9E=;
 b=TsvzfDtjpzO/qtR8lGfZAJ6ckuuMG0DAd/lxaO0uf2zlyRl+sLJn8kbwU0khbb2Dpil3EAHmVh0G5ERRxRsNtQIR/bVKcHB9RsAs1CULRdV2f+AAQcmxZ5aehVMCuWs8ssqAGbFZmXjGQXygzTSbVreeSRhYTT8m6+dBr2lYEmlMhCotrR2njIaqm+IPvHcfDQV/xxqrOOVVcCZcezSXnX763vSA0It0mZaGpGpcS7H6Zkjx+1R20i8OvGRBhgwYoo/Z79g0V+7UUU4+wcg/O/SoeJBOWCP5sWqs1wadxwL6u5A10aF0yfjgwef52qdn+n4QYCFBemp3BDxmSy8VEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SA1PR12MB6799.namprd12.prod.outlook.com (2603:10b6:806:25b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 18:13:26 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 18:13:26 +0000
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
Subject: [PATCH net v3 3/4] macsec: Detect if Rx skb is macsec-related for offloading devices that update md_dst
Date: Tue, 23 Apr 2024 11:13:04 -0700
Message-ID: <20240423181319.115860-4-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240423181319.115860-1-rrameshbabu@nvidia.com>
References: <20240423181319.115860-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:217::11) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SA1PR12MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: de06bd56-25d8-499c-f302-08dc63c1121a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J90vi20e/NumQcRDEfomzpZwnyRAfip/G0TdkmxW+LPt/4M5ePuuo2stOyV1?=
 =?us-ascii?Q?5r0T36T6RfMEGfqB8NxrTzXHmyIK+ozmt1dN4bCfTi2oxF5/P0zzu25IQBwC?=
 =?us-ascii?Q?QsUzdM8JLOB7/OhYjUgxZ4dSjmZldA+drYCTqVjYTzFsltVCae/kqnpgzUOq?=
 =?us-ascii?Q?nwvqbeAbDRp9i3UQ4+0HEzfJLUMLVaWuuEBUV49ZZsxD9MBBzq9DFcLRfL8J?=
 =?us-ascii?Q?H2BGvw4qL1lDGI8q8tn3rxilyz62zcyqfX59tTeShCbiJR4iMHXYNHue+/tv?=
 =?us-ascii?Q?YdGkzjvNgO3R1o4fIdcOTGtVvZ8CJBryhKirr7K5ycrDgu/6bNTHrOB8/wgy?=
 =?us-ascii?Q?6ZbAhrZmXKyr6qr/JRMmZWgw6CuGyLbZKgPMr4GFkF9rK/JDxzByvHn2msp9?=
 =?us-ascii?Q?acd14XpgNrZzTXSL61H0QEi0u65T3FY5GZrv5t0ZbGapczpYVY25SvcPQbzy?=
 =?us-ascii?Q?5SPeTMptiJONi7C7qMGqY2W8pm+6XnJ52aOUn71+I6luf2mnyrLWCjtKA/1n?=
 =?us-ascii?Q?S8GBkCYyjp55ByiDcpOOsbcj9alWy8pN7FZ4hJh0HhYHzxfimsROFE2exhGj?=
 =?us-ascii?Q?Hd7070yUbKF36zDeToBFuUUsn6ccQ13k80jLShYyEkeOF7K4L1ts32nXZNtw?=
 =?us-ascii?Q?MPGyGuFF0eOILNu0yq+h5mdUWXeZxyvd8RSTdOmAcRSpNcO4wTop0qg0FAQJ?=
 =?us-ascii?Q?8v6OZpiyrBCUggCTIpE/snyrgk/twrH8Tzp2Xj0zBFnNfL1nKkx9WUZccW9m?=
 =?us-ascii?Q?kj1jyAUsDZfMunC1Kg+qB5cWSSo9i68jcxXpJNTe6kqXXWsB9II+kCBAMuKK?=
 =?us-ascii?Q?+LfwJbhlvXHBdgn6274GELSvbDS5qs6kpb1mnf2v1ufP53DO12GqXOFeTWFV?=
 =?us-ascii?Q?HU+SilLXhesGnkHiTBKi2iQI1fjl3DZ1eNkhq9YSxIDsDIYUwL9Q47hUxmCe?=
 =?us-ascii?Q?l95P/K9aRIAbX9Jr4jir/J7VE58rhi+YKuyAmPIkK+KoXqxM1zdf8zpq/FVM?=
 =?us-ascii?Q?Sc8gN+IGTnRv145fdaoxTSCBGI1/VnxZRymy3sGfoWJ+5lZjMiS8mLrYs2Qz?=
 =?us-ascii?Q?ZuUBWImtG4xtsFkJzC9/eesR/2jCDk8CbqVQTyRR6Yt0LucqUDHbS5k7SwwQ?=
 =?us-ascii?Q?7vdaLYOw9aR4vpjiHyiI7Gpiab8NyBLdaZgaxdHOLuP+r0vYSlB/c2bAd7q0?=
 =?us-ascii?Q?F6Mp89Y1nVY/TN9FdK+A7Dt+29zs8VYW1jUgIzO+fHuEPuCklF/ASUe7hoax?=
 =?us-ascii?Q?UOtKsCeoGJSqWzno7qbA9hm+c+YBOYiianZZFN7VnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P1o1lBEm4TukQluWr/FN7iy1kag3m3C5diqV0PxciE6azfFTvxqo6vFTYzyd?=
 =?us-ascii?Q?9/RiB3y41mvMowBtgLJmVnbZftdgTmVs5hOzbCXM+cgNip76jDon4zecZ+UW?=
 =?us-ascii?Q?YGR/bxZVTLbSeDahkgq3Vj3iDBdU6eBib56XjFCv3QwqG9PBwbhTqAFc5BDB?=
 =?us-ascii?Q?t3QPgG5D7JE8aER0dUMhE91vZ8PpRB9Q47mBxWm3xQ0ZNTWYTR4a/2XdC0KE?=
 =?us-ascii?Q?oqLUrfW3Zuv/XHHvY6DB1aaM/8S1wWoLSAE/QVNSywo5dh2VfMh6MSYAz1lj?=
 =?us-ascii?Q?nkvSVGHa2aes5XFA8FXe02fpB1y47u+E3YQaypeR/zUgl49MbVl0Ovd/yl1c?=
 =?us-ascii?Q?KtAur0E+IaOmsFCH7izE0aiW8hM7Zyk9dzP3km3L+JHWedvWaFLCGgfVahN6?=
 =?us-ascii?Q?2t+Cmp0fESksYX6BxcncXyMr4GoO6kB+7r5TsoQJw/IlNtAAbh04YO8dIFKr?=
 =?us-ascii?Q?HH//sIGphcQ6FUwf2NXkCYcbq8S6uFaux1Q3CpA/kQOdtFWY9XG9pU7v+jEo?=
 =?us-ascii?Q?vef+tllrvB7f6Fo6QKurCXD16kdNpXgHIElejsACjCze2BKRcLkcE79YAd4C?=
 =?us-ascii?Q?NWf4RDKP6uqW3PhKnQ9MaplOIDlg4msuiaap9JjrjlZIUlg6xQgsQk3fK3Wm?=
 =?us-ascii?Q?mB7pWhF2gnH9rlDWEySSWSRWOiKr3+UCnXVaNor77FB0o37Tl70wTdUPnTYT?=
 =?us-ascii?Q?lKGsHx71n0N3ocMCDMybeGlB31lt9nBmrnFMqmMSAHRQh8UnOUPgafV43ZXM?=
 =?us-ascii?Q?C9wlTT0MiZH1rPvgcmPwkad4mfVspijkRBNEWCxdUIlBc9OT7hV80odcYAVe?=
 =?us-ascii?Q?ld0yvyRfOQgqrwyZnEWApGpr/ZTGSIxDH6BUSBi50qn56tBPHqMXRTCN4Ggs?=
 =?us-ascii?Q?t+PQVEjEaYckvcR9wpXnsBQT2NOFlL9lIYlZCP+XyhlwkuK9dbaMiKYqaAla?=
 =?us-ascii?Q?OETdrveI2JocANxpBPQi6pPssng7Rh83JtIgxSTJhO+j6vcmzriwRWEMFdpf?=
 =?us-ascii?Q?xousd1RpoppykheaUauuHvoRdOtzovcCaHxvpli3yNdIt34K1rdss13yfkbk?=
 =?us-ascii?Q?dfqQU/C2g7cVFJjUeC8QPhG1pHtg0xqrtEWojEqX+84RrjFqRcX+A0WD1YBb?=
 =?us-ascii?Q?JxOnYZg3WVahEgUArmI/t7e6FAfZJHP7f7f9aI/i1iJUrNOZsxnG+vX904LT?=
 =?us-ascii?Q?luZaQOO5r86brkVcTPwbTKCYayI9hamybvYsaxJiLpDWpFGU6BR+cpEWsGS3?=
 =?us-ascii?Q?48nyTm/rX+KOjhJbfcdjOUY8TXOByaQixDS/f2JlQ4t53+DZ+5pccvDzbMTf?=
 =?us-ascii?Q?E/pt4nAfEiHCUrhdyN07vIg8Vp/MsHqwPxg6/nHp9RFeTYoAWOhL5QIP9DYe?=
 =?us-ascii?Q?MnUA62RIsSc6Yqql1gQo976KY30GccTDjoR0cECdSFs86POZo0zC5J79JHVg?=
 =?us-ascii?Q?EZjFWNSkeKFGdDY2yShwuWVOmDfT7nnjB52BOIKRA845Sy062EzMywvvyIWu?=
 =?us-ascii?Q?kF69vZ8JjUVXjHFibmjcDdcqaKAfvLFbzSODLLggxtcdu3xnsoEQCch2sXAP?=
 =?us-ascii?Q?TWXtoRLvsnd8qQpuBEhlFLEZcbzMZ/8V+XU2uxFy6E/uCzc8dUgf1MwhQikU?=
 =?us-ascii?Q?PQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de06bd56-25d8-499c-f302-08dc63c1121a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 18:13:26.4461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGWrGg+5CeO71vkMC3NqO+bKfNieIuPRcAEyY75HHbBQpyzqj0hezSpG5rotd1gz5hn/D7VfLNe+MH60CQfZ9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6799

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


