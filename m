Return-Path: <stable+bounces-202819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CA7CC7BD9
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 14:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5593B3099BD5
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 12:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9E334E273;
	Wed, 17 Dec 2025 12:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="NwkoEnfN";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="CgnkO23z"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E6134DCC2;
	Wed, 17 Dec 2025 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975683; cv=fail; b=LJlzhjddX7GrLq4zgtV5LpTRsT59FfHPinHc3GkmPtd5wKoaRM2DopD+xZiBxgD1HLGAVyjl5XbKJA3/dgF1/GGzko2hB/ZQN36NqXZ1NRt4Khu2mrTss5XewSXbDsXZ6mx0Yxk82lYSVrMA7MzYBZZl+TkFPP0PMLRQv1NhpC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975683; c=relaxed/simple;
	bh=kAIjHse01HsM/RnZdEDGZtdgtpyGx6Grak2MZAbIxb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRHazUxHrsUJNCZ1zDAZLowHvHZgBuFev4lniIBFPC1KVYQjcD72EqL/JUGTRehk5zd7uTF8TUWtNwOrUASSi7nbw9I/UCyUyVapkxV/RuifzIHcIA81y1tT2OHtVm6idNaQphy4oQk+u6af/20lyvrAfaWab5c10ucCN1uQ+YA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=NwkoEnfN; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=CgnkO23z; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BH4cF8a940280;
	Wed, 17 Dec 2025 06:47:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=lNumYMbt1T8IQCG7/6
	Irhk2ivifZ6Nbeh31RmUg4BYM=; b=NwkoEnfNxyK2z5hjmjLiTWexdHrtWoroW2
	dcw2UY2CWp0ICpYDn5aZMTdr4A/0krJBTWWRd3q4dvtFnsVztEUORRVEcpBQNXxW
	w/FbEvqAp9K+CM0BaK6XlpoHgtQERRGL+VXWC5VEW2EVR0qUNjtq/zdTXTIvd2et
	jklQGNf0xsRDdY/bG2t3RXIYvvib52y6SaGJPxkqRLwt+GuvEeNYLW2TrHTEPpPj
	/zl3PqiLOe4Sx7BjOn0qbPyZFboQFOfoIGhhqr56OU8S5kS1LzNjBXLF4ZSGPMVk
	QXfflhTYBtZCpWxEuAjjuUdp8hmzg+kar9+ggUMXS171i9PU6G3w==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11020129.outbound.protection.outlook.com [52.101.61.129])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4b16e1vq3s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 06:47:55 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6ZN4d1qtIAIbJt5/BHHd+5AzQaPJDDV93cQ8I781SQx2gZRna+/eOQ6EE43pjURQUeeQCgs3WUIgPM9pxPM5i3T5s2IaIFyz/taObjNnROwPuKxO+Wg1ytJk/wdek8Um2TN73bveMCl8zrPPjCEu4o7gjJnh9+z1SWd87XYZIKUeaJLxcvHLJGo0tjiwI7sngawK78yIsBbiFchp/snU44iA1Z+pEEEp1gh4EoTS2YDAVGOZRyVGRcU7/1J+FPrCgnmi2BG26ILv4ao1G1szeNL3+iTMBwMFyTZXzjW3XzeptNllDLtI+mCx6gmBC5mUh/Hvct/pLiIFLXUpiwtfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNumYMbt1T8IQCG7/6Irhk2ivifZ6Nbeh31RmUg4BYM=;
 b=nngDlIwPdzC9uWdNgqLLKmJmBkayb9z7675/DJEfl292DhmP0HUPZwLW5D7kI25LCwdUo8nj5Fij1VLzY931XRPAemYtB3m8byXd+YITl4TVaXkpLPbSBYc3H2FAniSfBa36cHLHc5MtMnB9jeH2QJu+RASUWAkOrXa4qbJLXSXXfk8XmljtaMlft43+rlSv3RVxel9jMJKsUlsJY9EB5l38XtYuck5Eb+btKyckmTB+CiGaX6istfG/WgiMwNDPLG0RwX5ExD76V/IxefHjsVl939AEgakI4c6kOlUs36rKIHAOEN43IzMuxuMjwiX4Vjb5a+maDdHL2TxwhZ0qJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNumYMbt1T8IQCG7/6Irhk2ivifZ6Nbeh31RmUg4BYM=;
 b=CgnkO23zv/w0Kc5fEsFQFrvRhFDg2rmbuNZIVrxi1ThEha6d+3kMphViG9wvOYqhO1P9xdIKQnKvoTTFSIy7wolVLtzhdLO6WqI1E2mx9YPuqal0eTn1TWZNEbXUPvtMsuTrEo3ulTk1XPj1tIc47u4CxeDMVvsVmoj0wRNBIWw=
Received: from CH2PR05CA0056.namprd05.prod.outlook.com (2603:10b6:610:38::33)
 by SJ4PPFFAA20E6EB.namprd19.prod.outlook.com (2603:10b6:a0f:fc02::a62) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 12:47:50 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::fc) by CH2PR05CA0056.outlook.office365.com
 (2603:10b6:610:38::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 12:47:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6
 via Frontend Transport; Wed, 17 Dec 2025 12:47:49 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 0C68D406540;
	Wed, 17 Dec 2025 12:47:48 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id ED12C820247;
	Wed, 17 Dec 2025 12:47:47 +0000 (UTC)
Date: Wed, 17 Dec 2025 12:47:46 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, linux-sound@vger.kernel.org,
        kai.vehmanen@linux.intel.com, seppo.ingalsuo@linux.intel.com,
        stable@vger.kernel.org, niranjan.hy@ti.com
Subject: Re: [PATCH] ASoC: soc-ops: Correct the max value for clamp in
 soc_mixer_reg_to_ctl()
Message-ID: <aUKmcpUzUac5Dmfq@opensource.cirrus.com>
References: <20251217120623.16620-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217120623.16620-1-peter.ujfalusi@linux.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|SJ4PPFFAA20E6EB:EE_
X-MS-Office365-Filtering-Correlation-Id: ce907054-4825-4f48-4f71-08de3d6a7c31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hVyOLTFNi7+Yog0c0zSTedY0YGE2Dh0J0FMIvIA8ztM0fxOSOctxxLKgK9PZ?=
 =?us-ascii?Q?mMLgpjyEDBwA9xVqYFeaWggKbk0wp2QfFd/+dKmfxGUAaccn/Bl4TCZfo7wL?=
 =?us-ascii?Q?yjyEqIxyI+p+An6Ae/loRZz4qQoLm3GC1FeheKMBu3TQQ8Xaj+sYoXRFc+VP?=
 =?us-ascii?Q?wLJQZUxG6LPzlRPVB6FhbNVUWmNR7yLrNevSNjuCqS9vgK5bDD1/jyUMno8A?=
 =?us-ascii?Q?ccB0acJfg2c8un4/6zC8U+l63D46zHDNL1eaAAjRnB1Wb4ML03sQ8+YbIwq+?=
 =?us-ascii?Q?2rKOXZjuQvtyKGUrM/x+W66eQH0CfOOb/l2GhiqJIU8zys2mtPuHZWYipidH?=
 =?us-ascii?Q?WRCwFIdo8iHOQppf2ylScXZv4INq38sT++TxS9LFnS3wfADFVO9f/2JVGHbN?=
 =?us-ascii?Q?kfM2PRYXtRY7LCRh9BcKEHspuBLk2DksxnxSWZHNKBnUi+ywqNXrs3dWXMmX?=
 =?us-ascii?Q?PLmDjk5lJmrEfsQHB83rl0o1g2neTxekTPZXbgh2RQQbOKVV4selaAR2GBrH?=
 =?us-ascii?Q?UayXWl+4ae28kPapw6Dq4pz5Ps7SnexwKYjWNoOK0c+qM94ZwA05auJYCLRj?=
 =?us-ascii?Q?+2ftz3KjS9SCR0Kg8FXDPKMgG6Lk2M3fGO4eMltE2FfR/I0FRijylGPm5q38?=
 =?us-ascii?Q?kRr7qUx2PxjF3P5kQsR44fxPb9zHaLa9JbtzN/LqsfWUCNlVVyN/qidUj3rk?=
 =?us-ascii?Q?J7d0BXc24TYC2RDpS70W8nSSpsN1fNcvCi8zeB/uDWSMlFd1P/2ncTbJwbpC?=
 =?us-ascii?Q?H0neb70PRfLZGi4YVHeCLHSj6xxK6tI5YoXtzuX4TUrUM2+K2mwsyCGJtZCI?=
 =?us-ascii?Q?fHwfyllRGzPeBAFJeVcHNeqyxM8ckAk7x8xuZgIe6end0G1B7VRL6Pe6bJqg?=
 =?us-ascii?Q?iFAzCBVyZwbyrlAgJFRi9cXoITZR3BgvpvVMXQWTzCudXd68QdZgJOH/wRpv?=
 =?us-ascii?Q?VYoibPf5MDzhpPpqKCzn3nkgvqia1K+APCrHLSXpwjFgJen56fUjeYExEdoT?=
 =?us-ascii?Q?yjGAKtnxNUssI8VGGhFrHjDXUU1r/Ae2frFmDlfjsVarPRQyHRowiNuH6Zs5?=
 =?us-ascii?Q?4DZSE1QRDgntivFrmnFtCemfAubwKMdtkqBgcjsRdYvoTwME3ljKffrwTzms?=
 =?us-ascii?Q?9Y2uDw8vGNZmbElhUNRSQuuYsS7PxCwcAEm1i0vw2S1Oa1XcOA6SSrExqntW?=
 =?us-ascii?Q?WAiYKg02HJBETydGIvvWiuqpPrzh55xdYNTiOjtU7h9k2+ydwWElB6S3iscA?=
 =?us-ascii?Q?y4ukTzyNFddXJHRXGhPHx9ayUvdukK2ddmpEb/+USy5XWDdsanbOGPdofOc0?=
 =?us-ascii?Q?UluQRwSXct1tKzEofnIaWQbXvCy69vZ9z7wn1biUi3CkTdyTY4Rb0QYdIBBh?=
 =?us-ascii?Q?MM3R2G/O5sSqm0vI82SRtbUsw3k+oEQUXqbNx4I2ocHVQbTDsm+xxALhEjS+?=
 =?us-ascii?Q?MYM5dXJ+oFqoHckJJPYVgIlgA7jySOAEu1Oeh/DxGi4KUTX10z0KAAYvrSuD?=
 =?us-ascii?Q?LVsONmI0OyTTX/fpJdr3DQHm7aoARTT5pusKeY89OEoXcH4UdM5PF75/iKjo?=
 =?us-ascii?Q?tQ/rsrFS+UyZ7dXy3JE=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 12:47:49.0192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce907054-4825-4f48-4f71-08de3d6a7c31
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPFFAA20E6EB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA5OCBTYWx0ZWRfX2b+CHV6RjjJw
 yJ5jYt/BNpXc5r6w3n17+UaOoF97nsFK0q6D5+HCfDZx3hfZhr/CTtTU1tP9QgVNb1C1vcMVxuR
 3HDqxpmSMKhdhRsQgaHsJDofaw2TIgJ/Ft17uMnQqITZMZfLIbipjdX+FkJTbhz86Dlg74/w2Vs
 CZ9pw4yYsl1XHc8NiwpSMxsPurDB+x3hvE+MC+J0G4kQZUGtgTnH23iPLVeLj0q8h2KI4SYg28e
 YXLFvU1qrxy3BrmyOyRftj1ZRQeacNqVXd1EtWKk/xpwI1yaWI1lpb08PLllMCG4l19YzxDWMAp
 xTD0+ceUWXbNFcvd4sF2hU6jFHySPXS5n6F1JDSzXsxL6TVXyjzYknibG+w11rGdnndFKlk5a02
 Ndxsb/u2md+ZZeE6FV3AxCAV57aCpA==
X-Proofpoint-ORIG-GUID: yuxOtdKGzOnWS8bDWq2sfRO80RLKgtOk
X-Authority-Analysis: v=2.4 cv=Qdprf8bv c=1 sm=1 tr=0 ts=6942a67b cx=c_pps
 a=0nUMJEvSMa9qwDORHGuOcg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=vfe9vbAUHLBfZTdi-T4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: yuxOtdKGzOnWS8bDWq2sfRO80RLKgtOk
X-Proofpoint-Spam-Reason: safe

On Wed, Dec 17, 2025 at 02:06:23PM +0200, Peter Ujfalusi wrote:
>  sound/soc/soc-ops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
> index ce86978c158d..6a18c56a9746 100644
> --- a/sound/soc/soc-ops.c
> +++ b/sound/soc/soc-ops.c
> @@ -148,7 +148,7 @@ static int soc_mixer_reg_to_ctl(struct soc_mixer_control *mc, unsigned int reg_v
>  	if (mc->sign_bit)
>  		val = sign_extend32(val, mc->sign_bit);
>  
> -	val = clamp(val, mc->min, mc->max);
> +	val = clamp(val, mc->min, mc->min + max);

This won't work, for an SX control it is perfectly valid for
the value read from the register to be smaller than the minimum
value specified in the control.

The minimum value gives the register value that equates to the
smallest possible control value. From there the values increase
but the register field can overflow and end up lower than the
min. I often think of it in terms of a 2's compliement number
with an implicit sign bit.

Thanks,
Charles

