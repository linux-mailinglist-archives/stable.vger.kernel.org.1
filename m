Return-Path: <stable+bounces-152293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD79DAD364D
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 14:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F98A162A36
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 12:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9230B293469;
	Tue, 10 Jun 2025 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="MSAh1bJF";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="ghWbpJNM"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9446229345E;
	Tue, 10 Jun 2025 12:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558798; cv=fail; b=fhI3LJDDdbMq5AarVA22AEfI0gMj7Wln9T8QUV7EijIiZ1SANxmaBcKgco2fpKRM5VlkJ6m7Ys6qegaYmYYt+HzzGkoN37tDwiiExTAUBWprmg37mV21shhMqn4r/+ltD3Ci7KwKLCLz0d3zt/m2X+Y8Qt73DJgYq5rW+hgT6k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558798; c=relaxed/simple;
	bh=TNl0EYhyaISCd39SxbeTAjDmdJUMIF7PxjfOTQNlyMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkMEsoiQCK3XBYQ5RLVAcER0Uz9MkrIrsfI5cCGMWiXfRfK50K5rrUlPNBt1eZX0cOobdv3JZpR36UyOUaDXaosx4PjCkW09DUHFvCqDjHNzpts8J+C3NIJ8Jcv36SS+OFDHodU2+15BVHYT0KXeg9I262v0yo/hBhgOuwd2eyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=MSAh1bJF; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=ghWbpJNM; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ABMrrY007484;
	Tue, 10 Jun 2025 07:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=CBXlLy7UMzVMJyM86/
	7+kNoqZNmor3JE3a3xq8kkIig=; b=MSAh1bJFFE0UqkpyAso/HhRN65bjUtlMNf
	Et0G7U7Lpm6k1QADIgAhPsS8lnQP0r2fDqroOOpnwpjq+FQXjC2/8qalHzxvX42U
	hz1bEdSViRksY2wavdAmKasRuDLLGaxPghAlO8CwXHnrhEbEQlgLbNCxrmBldgaP
	lIGT5Qeh7yqnlXVQtM1LtJfhjuDjQZMRHRTn2yI7vRwldPBwBi37RoMUnLAY0Y52
	SnmQ1wbvUtl2ZAN1DWQmEJW59m1PGBl7dpGjxBFfbSpMDtpJZYYjMjol2+vwV16z
	EjuAqSoPCd1oLUxtlsEX4vZx1OfGO8e13/IxleKUWYN1EtJQmYBQ==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11hn2200.outbound.protection.outlook.com [52.100.171.200])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 476ksd82wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 07:32:39 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9dKYA3DYfOUVXf8OCR99aqj9iqojo6vEUXTctFpOmTtY1aewn5bJZjjY/nausX9GAQOLG4Ko6j99/9VxIHLz8q0ktyhRtm/eJ72fomKhITAMYpW039kH7HKB/5yXtg3B8bz99LC5mtWHDErqAj21kpk7g0JAuZsqIkjGecj/kBdBefBbsiC2hcJzEF5Txe//25xmLQsFQhpZTvdkQOEgbA51765xIP474/Sy7+4KKsJtC+QA9Iv3o/YGzhNk72K2d6EGl8t9hjLgF9PRU3HIXiYvD0FRAwDHj0ZLMHHxOBcDB9ITNMZHBuR+23K/6CU6RFSHUNmu50AVucwTkjvyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBXlLy7UMzVMJyM86/7+kNoqZNmor3JE3a3xq8kkIig=;
 b=ROA2wriQ43OuCi40hfpXebMvj+U7ek4thpuW6cWcJfcV1gjVV9Y3C1es+BJMfEBcRZio08/DHvgKWa2u9bMIBD1kMbFoaAjLWHifdvMjg3H1F+BGkenJluD6n7F9FJXrqotqd/pwfgh6CF5bhaDWK2aqcaR3j9wd5JfL4skcB7pSFGw/RUJpbicBsqxmXr0nmVD9Uf3oRlEMR16OTZwud4OI6FP5sR+uWsAd+b4BIaFOCOZaz5DYk3m1b2dmksstu1Fa1HXukU+HxCqyXvu8Z6BKldhPhcv32DDOuBUHThJ0kbPQYIbGJRnYaPPd8Q4aiTvuOHzVXH3t5YhLbX1RAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=amd.com smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBXlLy7UMzVMJyM86/7+kNoqZNmor3JE3a3xq8kkIig=;
 b=ghWbpJNMDWlwe7i+0FAa6679pdQCDCHbcVMfqQunPdtOMJUa9TAVNPVWybpq1CEgG7ecgxgunu2C5E9GLvheSouFee8O68kygfxs1hXrc1Y1CsdZLTh88SXfufjb7ofxeQzp1inHy5t4CAIA+WQ5Zyzq8xvPB7uXuwcuJmMxKuA=
Received: from SN1PR12CA0100.namprd12.prod.outlook.com (2603:10b6:802:21::35)
 by MN0PR19MB5995.namprd19.prod.outlook.com (2603:10b6:208:382::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.16; Tue, 10 Jun
 2025 12:32:36 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:802:21:cafe::3d) by SN1PR12CA0100.outlook.office365.com
 (2603:10b6:802:21::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Tue,
 10 Jun 2025 12:32:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Tue, 10 Jun 2025 12:32:34 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 97D9C406541;
	Tue, 10 Jun 2025 12:32:33 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 77E0A822542;
	Tue, 10 Jun 2025 12:32:33 +0000 (UTC)
Date: Tue, 10 Jun 2025 13:32:32 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        stable@vger.kernel.org, Liam Girdwood <liam.r.girdwood@intel.com>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: sdw_utils: Fix potential NULL pointer deref in
 is_sdca_endpoint_present()
Message-ID: <aEgl4EcoG+MwaQoX@opensource.cirrus.com>
References: <20250610103225.1475-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610103225.1475-2-thorsten.blum@linux.dev>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|MN0PR19MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f3c8c22-4640-4daf-6636-08dda81ae0c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|34020700016|82310400026|7416014|376014|12100799063;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?inRPvu5KfpP+ZoWcKFheAX05Yl1KReUIVEraxZH3pW7yZbFERISyZka6k1+5?=
 =?us-ascii?Q?2P2sHMe22KgISYVvFjkvYRd3mHCN++uNh0qrZ9TDENMpgJOXY5jqB3fA2s5c?=
 =?us-ascii?Q?/RiR8ki8lEUkGxuMAXFr6txHOOR2ZZnM2l/G6H3w68L0P8LQJZOGmoACexit?=
 =?us-ascii?Q?4A1a3ZxBQmiAw8k0CYMrPJLIUKzVP3JrUJohb2exL5U+T5KIqjkES5UGxxxJ?=
 =?us-ascii?Q?1EkTTfRcN5c8jt5FgsTfyDRA2FgdQcHwxrMrJ43huMU0rYiJLU27K/snEj8A?=
 =?us-ascii?Q?EkwO9Jkorg6KoJCgA2Jf0cKi3LGwlX68cW7x8HYgIsqN+DF5PUr1de9VoWkj?=
 =?us-ascii?Q?e2RfKzTMkHhJHbg3yF4GVZ+RbBBR5bEuktEZMpHoXSLPkQCDK7+xkn0dKTxg?=
 =?us-ascii?Q?oSf+oSpb9AUstPCUvqwz9msb8bjhbw5FRRcLxfFGbfVYS6KVY9VsfX26V9/R?=
 =?us-ascii?Q?DVqug2ebwXqVUmd6GBdJP8dbxQlJlNBw50TUGQPSwS4bkPSAEhC801gaXcRR?=
 =?us-ascii?Q?NrwGzz62ZytnqTD7JU3uj+evOTeW/5v/CtDXyi2QjKjMc9hM6c9jC+18Mio4?=
 =?us-ascii?Q?uP6jPSVcSECO4kizExv7wWAPk7qRzkS6Bp8chQM5WQ29/1gerOuy5JCP4q9L?=
 =?us-ascii?Q?Rw1WASLW7QWqXCYjvVG0SBusowUGLoNm36sBiF/pyK7rB1BNVjRBMX4THXji?=
 =?us-ascii?Q?FHfNfp91qkjN+GQlt+9STTBnYrdOSVU/ewpgUt1bmmxwzsabQZ9/OsV9z/QX?=
 =?us-ascii?Q?KVha32TiplqGJmTh1KJ6kJaJ7bGOX2GU7FqH8gwDGV2kYL/+Ymlc9QiUoiSs?=
 =?us-ascii?Q?bbHqdKXDwO8fBrsX5eUBRoXhrl5s3MDnVWRo2sYbVjmFUnWumr8kf02nlcYU?=
 =?us-ascii?Q?13/6hHFCLj1U0IeJkT9D5vxrDVuv26epjNIDvrr57nVWLSUUXryFHcT/q23Z?=
 =?us-ascii?Q?s7G2vh2W/bMm1tPQuXtpX4vl3vw8gOPZmd0sIJjYVi4gH0a8noyUAN2ZHK8W?=
 =?us-ascii?Q?aWT74xpGZMtH7SC52I8seURLcZ7Lq7No466YG+UCc7FuS9giKuTT4e9r+txE?=
 =?us-ascii?Q?d+MlB99LXNqimBsFaRROgfgkYVvdr0IZni7FCTzAxRU7ODTUqfKs6xfGmpEW?=
 =?us-ascii?Q?r6Fs6rNId269ZlCjulfCZSB3OqDbRhffhd+lXUMLkgp9OgaQlX6hV9dJig0b?=
 =?us-ascii?Q?KpFr8nKx6k60X4y8IihcQcQiAy14Rpar9OcOCpY90/KHAqH985YQ8KnPw7bN?=
 =?us-ascii?Q?cUgk4N+QaIUG7LOJ2es61/jMLqoL+9zOcjwgoXZzZm/F01FBn9kpuuzAgEs0?=
 =?us-ascii?Q?XTIhkdnJdoJCROGbXgWumKi1XOqViSpaDK3aiP2dEoHKTe8SXXVocbVK7hjY?=
 =?us-ascii?Q?8egt8+zX9sdUYOPxMr3Q7gE0NA4ejvz2OTOz97NWgo5gDo5SdB8bGy6JRNDP?=
 =?us-ascii?Q?G/2neM5LZvMDjqOQ742f6MLMrGMRUOtG0qMm/Dnfbt7T7hGVG67gB7GHi60e?=
 =?us-ascii?Q?bK8keV2soNqAXKOMbDYH78OHDbuR+O0QXWuN?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(34020700016)(82310400026)(7416014)(376014)(12100799063);DIR:OUT;SFP:1501;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 12:32:34.7487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3c8c22-4640-4daf-6636-08dda81ae0c8
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB5995
X-Proofpoint-GUID: Ee0wwnwBI01v-xCTEbxnIHHOTHR2scSU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA5OCBTYWx0ZWRfX/NjZs5A69ImN sR/c4IUBM9iadBjHybb3Bu6yOpuzirlSv4V2rutBhhyEwItPeNZ390oMpNC/c0QvRcn7h/qcJHs h1JV+OMLTSpNUrpRYszmywHbL6GjblQRNjqv3CBuYHsZscPM1TCdQ17n/SIv/Z43y/3m0QoC8yY
 0S+4GFVgsmN1VWnNQ5DBFtDGi6PPQw1th/LRWna9kTK9Jfg+Z/fCNhBRQQHGeSkf41d3m8K2423 vyOOrpGffu8KLTRcKiFZLpv1mzexPATEn2XEBu1uPr2YqwVGpzYcyz1LCFCV3w8zX6B4the2hHU L0uUJl2K+BdyxY9y6DVz4zUn1b3v38zdNrBEUyo/SmcgZcLuR13EVq2JNRfCwOxtViKfiOLh3ed
 JgvL2OZaZ1EYeHCvzpMkJtGaNtT3+buFQjMVYQeOPipWbr2fV1oQxr8cPrKcFuTsqwfAzxQ4
X-Authority-Analysis: v=2.4 cv=c5OrQQ9l c=1 sm=1 tr=0 ts=684825e7 cx=c_pps a=YgK7Hnrd43RjXn8z8Cdn1w==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=VwQbUJbxAAAA:8 a=w1d2syhTAAAA:8 a=XYB6A2eQeqfmdjx3t9EA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10 a=jZz-an6Pvt0H8_Yc_ROU:22
X-Proofpoint-ORIG-GUID: Ee0wwnwBI01v-xCTEbxnIHHOTHR2scSU
X-Proofpoint-Spam-Reason: safe

On Tue, Jun 10, 2025 at 12:32:16PM +0200, Thorsten Blum wrote:
> Check the return value of kzalloc() and exit early to avoid a potential
> NULL pointer dereference.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4f8ef33dd44a ("ASoC: soc_sdw_utils: skip the endpoint that doesn't present")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

