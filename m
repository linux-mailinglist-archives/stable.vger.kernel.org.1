Return-Path: <stable+bounces-40231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E45788AA67D
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 03:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C716283AC5
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 01:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4435846B5;
	Fri, 19 Apr 2024 01:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GRq7KVTn"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC26138E;
	Fri, 19 Apr 2024 01:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713489482; cv=fail; b=ekQZyQwd73yOcAX3SyvuNizQLs4He5FGSc0XIfvzogi4LK+7PMVqI+aaD+TBc4QzTA6rixb/w3ZeN3rlNvC/zdgpODBtJjcc8SEXxiRcvYgPRE50ilVAEdAun4UroaKWjJPPNw5M5t4/NUg0HY1rqFQyAgEiZfDDrE4GSCmTOI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713489482; c=relaxed/simple;
	bh=Mg7FIGZLWCigxgji2ObwkLNGKIIzYe+C+30GMV+wBCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H1voftO+DtYVPwibSBsThSPE1PO9ApWsyXAXh8S4dXSztWF+fOSZD/GtlZGj7jMQtgx7LBZ0njpQvObeqIBm4b2fOcFrf8seaZUwr4OgBIc3a7KWAW9T1h8F2/zfPABHn3JLHgzLPdLOXlwTN+aG4rcc9o1bsrZD1qVS//bDjW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GRq7KVTn; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHwV/nn8riWT76pefpJVif6HC7wlXWouLJ89YUR/oNtFnj5w0VR69REtx77rZKeI57n3r6FUxfDgQ4kfqAwhbTSnuzhMUNcmJNtH0PX8mxzCJE1t/2DfTIUAVQQQWGHcmDVkPSipqA+HW5Jgf4BMbbxS0SkPq14Od1bCX9olYR3v8KxUyqgI1iplg58jjHmjlAjzcyC1ZyzEoaTLvfxaw+b/AAcuJOADl6HXc/RiZ/TXdq6b5XAnzgTKwMHNjBllLZxKJHNvQbd9upSfMBgks9NIoiG+pqhpGnmsQ6/ZL1LNBcMjRT39dPs/rjGzv001vPXnONjqU6dpyHZIFEUMVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BE4XveWR3UJ8PrXFToXTa5cByaafijAMMpdpwhc35B4=;
 b=Jk9frtL4mNy2pH2g9XGluLv5IZ6LVjROvbkGeqmmyFq+h8Qmys1lXQw6KrQOClfNHhHIaJuWATLP1LnhFRE7ydrWssHDjWVRaMn2pPnbNEkm/pWEll8DMZVr+8XDmURr0Qobiznk/hDApbvOAX4cWTAJcyrEUu0wIS3NTFGwPww2J95x1K/5e1g8fCU2w3GVKmqYzFtAb3UsAroFnJ2jz1wAxfHm5ZOQUsi8z5hdw5LrQA9SHcF9eXLGvQisVpTrkdRuQsyxcfnU/tHUoF9jgbBva4wLKAr1e7sUSmszZUDgvRHPJrZF3aLe++PxhgMJHpp/Qnb1bEsYYhlEXyNTqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BE4XveWR3UJ8PrXFToXTa5cByaafijAMMpdpwhc35B4=;
 b=GRq7KVTnmDVqqgNrt2GHO1FicGlA5T0imS7+0XCt8o1GjG1uVnTSKfbNxn/l2gh4mc+ur/eBb63oaSzwc7rQqWErl9VcPBJIgEij86joEre8QxcPgZfJMjPSe/H0XjPmv5AKqPbrOlzbOW77EtEWLs8D3MDmtUTz/xoR1vnvzpKrhePCiftG1miCtFVGhbv5QBw3UP2LFnt30V3G3RK1dpTu41l79ttX+1mmrIo/VxtQW0Gl10W+qr7qYeffPM4pG/b1JMUsePLaUDj/QNNyFcznOXyo49QUG0M3bv6hnQiWoE8yUkllDIMSMgvHG7I0uUGRC3HB/A/MWdUlU6mVGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Fri, 19 Apr
 2024 01:17:54 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7452.049; Fri, 19 Apr 2024
 01:17:54 +0000
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
Subject: [PATCH net-next 2/3] macsec: Detect if Rx skb is macsec-related for offloading devices that update md_dst
Date: Thu, 18 Apr 2024 18:17:16 -0700
Message-ID: <20240419011740.333714-3-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240419011740.333714-1-rrameshbabu@nvidia.com>
References: <20240419011740.333714-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::19) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: c80ee0ac-19ac-4925-07a7-08dc600e8a16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q4i6XPIZYq4CcCB70s6BUxMmoNJWv5hxAl/a7xv1DjbU8Zx6j1sLosD9OVx+?=
 =?us-ascii?Q?0MJv/7zUBdP8wM/tsx7GEPzcZZjuwlSjtFa14OpIKkFjw6kfPJ0wV5tpsBy4?=
 =?us-ascii?Q?sQaZOLSjNInalh77y6Pk33MTZVqsqsA8BD3vY9h1OYmOqTtuRJD+TvTaQAn2?=
 =?us-ascii?Q?2KxnNkdNItXU8c+i4sdLbvt+HkjGXnlIbp+4LTOAuSm51GqzAkBOW64M7ICe?=
 =?us-ascii?Q?XB9XSmZmciI+dz5i+pGcvCG2S0tZz6D4DoSCo8mjwejmX90/66u+TDmm2pGP?=
 =?us-ascii?Q?S7JxA2qrCLqn6yrZd37/kW6nFvABKNWNf3W15Dx0EOQy6JGZTOR7kynyzoxs?=
 =?us-ascii?Q?TyecX7vD4b6UMuGdtMDOsFoFkUsvq+tv6BZ/fKln3f65GlJ7g6QyZV2djcQ8?=
 =?us-ascii?Q?FeX4ykNps2QwgszjGYixvEbG7zMyilS0RPqxQhhG/FH36JOltluFC2nSY16v?=
 =?us-ascii?Q?c23g8KOt8JuMJ5m77hmhTaHjmUB18u8/mmCRTKh1OOqjeJXvluhssIyN4qhx?=
 =?us-ascii?Q?XlJdW1bIbKjWKl2rxAAAnbjNqZlKL158+PK49wwO19egoosTqiCgf1NTbg6t?=
 =?us-ascii?Q?oKx7T4Z1n/dfVLEPtJO8WJh21T6Hu7t/DOhYJ0OND5gjTloVYyRukK0Na75J?=
 =?us-ascii?Q?iT57kMBjngyG1g2AqUurQoWAHXht1trWHSDBOLo5ZiIpnSrbvMpPPgAlwDiT?=
 =?us-ascii?Q?0q2PAWhX4cw+45D2lTvA8uTNHYX+3/YMGv4Dsqa0GaoBqudDiE+CzAQoJMLq?=
 =?us-ascii?Q?Dv4maSijCsYFcxJVw827pCpxzfUJcP4y6DJviBI5aOKQnzGe6XEuU/dlgZpC?=
 =?us-ascii?Q?2pd7RRLKkvnRa+dKfAHHj2boEdLwvKykSS3p+xWiZWTjjT5YUOv4TWDky4WM?=
 =?us-ascii?Q?XiM1bbEyA+0SCZAZ9cbW9OYEds5SMMSv2PAXOI9vR6LKNAhIVKDlrYcE2cIa?=
 =?us-ascii?Q?T2vIEESWBOoFUAqThqCgSrJ+XHe2LgmLIjOubyAempS1Rkm0/h0T5OFer48W?=
 =?us-ascii?Q?eYBl2d4OX0N2WlW0lDT0qg1pxNp3KhLnqRSKTH4M5oh7deDLClWSscYYbJqX?=
 =?us-ascii?Q?cnlbsyP6yyc5jeAup5V4nWjj0HzZpm/TrCVDLFOdQDFIuM4dv6F8FjSFqv3/?=
 =?us-ascii?Q?thX96q+90YD/Mc30glSrxtrOs/5fAqD//w6ib1bMkfe9qq4R9WW9mrEgnv81?=
 =?us-ascii?Q?/L8mZ7PLm+UePnuxoE/GT5bdpUo6y1trffv5ij3wch7QtSnobcAue9aU/JKn?=
 =?us-ascii?Q?YeqpnH6vcwvQ4zlafSJ4v2kHq6Nn/oVHW0MP+ym48w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xvwnJC9LoKfMKRAd+t/fxkvJu38fJQx5ptYKI+x9o2u9cBHMRRQgDhVc5cux?=
 =?us-ascii?Q?KmpHjrqks9FNTd7CMdIB6M0Qdq5wJboXnbxKIUu9UlKuHW1EuLgX54BBTZ0S?=
 =?us-ascii?Q?iZFS/IB8pf8hEy6gKAh/4MbX9txH5kQ6c7ibxVeivz4fnYIKDoLf4lFeogmv?=
 =?us-ascii?Q?AvurjgRmfLCihs4krP5C27Abrpwct827Yspb4vjdF5P774ewu6YiBYtrGUie?=
 =?us-ascii?Q?BzyyW+oUgWF48oPdBL745Sw76k+JxbgXI+UFDEWT7a+mOGaS89j2HNhEYn1J?=
 =?us-ascii?Q?sq6NH5RYSxZnK1C+i/b5d4JU3D19KDtlS96H0ewv774kEE+Et8qbIDNkDkda?=
 =?us-ascii?Q?4ZXwNUH1MatY1Eyj1xrYTz4q/ZKnE7tM66zU4BGWRewiefMw3unJ68XiPvgn?=
 =?us-ascii?Q?zpBW0bf8TFFoZeuk3vhFVUGLL/TOOTM+7Un/Fko4//RUCWM9lOTfuT1RPVaR?=
 =?us-ascii?Q?5641Ij6uSuRQ57sUGvasMWOpM39EcyyaKHi5on5hCGxJfo3QiG3tfs5Er6D+?=
 =?us-ascii?Q?/wXD+lHhXkQVs+8ioxjGKo+VJrmeCR6j6EeQ9eRR7FfOVPhio8cdCy6gwTm3?=
 =?us-ascii?Q?fvJ3+kyIcQ1O2JYT61l4n1DEmQbG+tG+wGha/MlquIRMX96eKzTdM1QB9SCq?=
 =?us-ascii?Q?aW9+WQjsWsJanY2BmMK9+teHXGDy3NIXN8nmrZoqhDrKGH+ILgUSETeZ3Xid?=
 =?us-ascii?Q?DlfE0Ppztf2U8HjhtjKWvxvs42kVb3F9STODazFLJ/gSEzTjUalYOqUvyC5g?=
 =?us-ascii?Q?xIstVYu8ge6qLsabZ1opQjm1MNsgWZn5dDcHZhda0aoPcBgduUrNRLIkXSk9?=
 =?us-ascii?Q?pkqAmmGzkiVROgUSdiL5OJf/DXXOkvE51epzTES8MCGQJ7xwF8Zf5Sq0yZ4O?=
 =?us-ascii?Q?izTMnyW0K0N+4nQaEokAIO3U0n+ktMMONZD2tB1KgLP0VvFOWQbuTgyDuKfF?=
 =?us-ascii?Q?xqs/UBRywXW1EGIz3YkqRuEkxfyHp9/7YECpIMdfxQPKZjRZi2969vXsMkO/?=
 =?us-ascii?Q?7esbowRNW4vOhgKl4V9x38ag9FcTZhYP9VPNz3HyLORajkCBHQLuMwNEHrGN?=
 =?us-ascii?Q?iUYViWzaYoxcI5yzvDYEZAUc11ug4BwGaa8D6ckSds7kOVno7gOyePPlac73?=
 =?us-ascii?Q?QnhUcUYQBS+OEJW84OIgGxK3grXQFz+DLj+FypCZBNrLIeVQEusY/ZFW16uw?=
 =?us-ascii?Q?f/I28fGFkp6eX9jjWZ8pQfK3VqBSG5ZdHg1fJs/HTYvZk7F8/NXrAS0+3Pcy?=
 =?us-ascii?Q?uPAcrel5ID9hEBnV2oDpdoIOTl9bNKpEqWxTQmiT++d9Q/NdXeAJ5EiHh/WX?=
 =?us-ascii?Q?xqT+OiiUqqYXq1QaBaEFafwPoWTBEGE+EuZz/8TtK58hurljB8O5DbQFtvkv?=
 =?us-ascii?Q?ef59wyE9GLQ+Le+gWhx/my7D3qMSF8TjBgDEGzSyVYq4UGItwQP8tJdoXIiT?=
 =?us-ascii?Q?U4sHC/LsCry7TWSGk8eiX3XyDGVN16z/9dGdta9aWsyvFyj8p+NmQBaX/tzE?=
 =?us-ascii?Q?hUJOW9kUM7CfrQCifGUEDlHkGkHbks5os49ZOluVPQox9W6b7kJopydBE561?=
 =?us-ascii?Q?x1ZMCLlNahfS7KlQk5yWcZ95Yf031Kzx1mzzvag0aC93PAsyKQ+83GIQrJML?=
 =?us-ascii?Q?uw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c80ee0ac-19ac-4925-07a7-08dc600e8a16
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 01:17:54.3902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELuBBHFz5MFDOc0M+I+iKaV49wOMVEPmEw6iZLBhdki8Ch9l1o6GMlxxVcjTLVvH+nupEhChLxQ4cL3rrENAEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656

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
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/net/macsec.c | 57 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 0206b84284ab..679302ef1cd9 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -991,6 +991,19 @@ static struct macsec_rx_sc *find_rx_sc_rtnl(struct macsec_secy *secy, sci_t sci)
 	return NULL;
 }
 
+static __u8 macsec_offload_pkt_type(const u8 *h_dest, const u8 *ndev_broadcast)
+
+{
+	if (is_multicast_ether_addr_64bits(h_dest)) {
+		if (ether_addr_equal_64bits(h_dest, ndev_broadcast))
+			return PACKET_BROADCAST;
+		else
+			return PACKET_MULTICAST;
+	}
+
+	return PACKET_HOST;
+}
+
 static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
 {
 	/* Deliver to the uncontrolled port by default */
@@ -999,10 +1012,12 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
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
@@ -1014,13 +1029,40 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
 		 */
 		if (macsec_is_offloaded(macsec) && netif_running(ndev)) {
 			struct macsec_rx_sc *rx_sc = NULL;
+			const struct macsec_ops *ops;
 
-			if (md_dst && md_dst->type == METADATA_MACSEC)
-				rx_sc = find_rx_sc(&macsec->secy, md_dst->u.macsec_info.sci);
+			ops = macsec_get_ops(macsec, NULL);
 
-			if (md_dst && md_dst->type == METADATA_MACSEC && !rx_sc)
+			if (ops->rx_uses_md_dst && !is_macsec_md_dst)
 				continue;
 
+			if (is_macsec_md_dst) {
+				/* All drivers that implement MACsec offload
+				 * support using skb metadata destinations must
+				 * indicate that they do so.
+				 */
+				DEBUG_NET_WARN_ON_ONCE(!ops->rx_uses_md_dst);
+				rx_sc = find_rx_sc(&macsec->secy, md_dst->u.macsec_info.sci);
+				if (!rx_sc)
+					continue;
+				/* device indicated macsec offload occurred */
+				skb->dev = ndev;
+				skb->pkt_type = macsec_offload_pkt_type(
+					hdr->h_dest, ndev->broadcast);
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
+			DEBUG_NET_WARN_ON_ONCE(true);
 			if (ether_addr_equal_64bits(hdr->h_dest,
 						    ndev->dev_addr)) {
 				/* exact match, divert skb to this port */
@@ -1036,14 +1078,11 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
 					break;
 
 				nskb->dev = ndev;
-				if (ether_addr_equal_64bits(hdr->h_dest,
-							    ndev->broadcast))
-					nskb->pkt_type = PACKET_BROADCAST;
-				else
-					nskb->pkt_type = PACKET_MULTICAST;
+				nskb->pkt_type = macsec_offload_pkt_type(
+					hdr->h_dest, ndev->broadcast);
 
 				__netif_rx(nskb);
-			} else if (rx_sc || ndev->flags & IFF_PROMISC) {
+			} else if (ndev->flags & IFF_PROMISC) {
 				skb->dev = ndev;
 				skb->pkt_type = PACKET_HOST;
 				ret = RX_HANDLER_ANOTHER;
-- 
2.42.0


