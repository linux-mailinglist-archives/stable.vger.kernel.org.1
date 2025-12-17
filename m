Return-Path: <stable+bounces-202837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D43D4CC865F
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 16:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B74F030A422F
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 15:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEA634D907;
	Wed, 17 Dec 2025 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="NZZZMHpS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="XTmyhhjm"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F99134D38F;
	Wed, 17 Dec 2025 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765978960; cv=fail; b=en1AWdi6bysNjs1VKClYloR+pG4tTqr9NKQzwmLbCi1Eeb1TRrLBYde1F1uKlJQJSsxmbx7+TVPRmLegY3aEvdOtaPI4hJY2JWHjdDSKO2spcpRp+7/uj2yR0ps/7i/YZ5cffc/MgRq8PId3uQmmyuXxGXPUnw0MnxtexnOUi3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765978960; c=relaxed/simple;
	bh=DgXSxLPxhsTTj956wvkZOeoCoLT4pNiNJeI2+Ja6qWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTkGT+rTcxadd5LQvE3slQvYifUMyIB7v+bh0uLVOI4Z49HXlPGn8s8s4NW+12sgfxmOW9BgqoouGa/2QHSKONWrlXWCsmBlVqxXgCFdQFjq8WstQdo2oQdi+9NX+m+IDmgNhwTe+iDEfp8blfY95mniuZkxKS9CvP+w2KnuSvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=NZZZMHpS; dkim=fail (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=XTmyhhjm reason="signature verification failed"; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BH5vWcA1063423;
	Wed, 17 Dec 2025 07:42:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=bERwX77KOWuXh+EYdRG3uw7Kf4RuBd2+CTnAowm1xG0=; b=
	NZZZMHpSje8FrZDA1lAd6Ley2+CrWforB3N8YYjLeE0J93b68r+5GEdL3gFHptWD
	9S0KtUG4NeeIEqWQdn2zonoZk+ToN5wKddcdCopCMHjS4p2vPTP/DmO7fZt8i+zR
	2MWNC2ZgLWAGnQ5qBEpa0WnvzCvvkzp7vDmFsFDqFgW4bTXqEgANWLV3hldGu2XN
	BOi4WEhUnEnbUdnIiJEQyWDQof1rFVddNV5ipyl0cnwmPnkSxK1te4tyrcYBmrz6
	1UA4B69eWdByEbvJA2Bu/3H4KSQlo0UW7ZvkJD4pN4nXPk27BN0ejrUM4N3p8Drf
	dc7jbX0C8iy/CKgO8Gm2kg==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022131.outbound.protection.outlook.com [40.93.195.131])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4b16e1vrnj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 07:42:32 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZo9Xx86Kv2z3undyqmgA/EvG/yOAEcnoS1JFhVcyjczeNX4GnI+KPm0UKNizY2clcq8HWBB/xf+f4pGkErQiFDSPBcAuMq/cVFEbFvz6rjGukft7rAsvk3LPVyNVsT3W85ubDHYO5ePNgJBxNBaUL5C5X+RZruXxAPe0tgOUCXIPA8fbiGS6KfGXjwAwOFmZSDGsyACmKRfxO8AYWh+hE7Sd4Qh4Yww9zNFkC6frC7F9EGbNjG/soWXjuAsbJPvGRTFqnXFZux/4zZAJKzf5pzIuhYFeyGBK1O/zU9xssqLqH4eKm8T2uRIvaiyfX/aWuojFitKNFHfcAY4whIBDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lF+quLClrT7tBB8Uv0CgxiKCEFIxtoZxg4wsVnUBBYU=;
 b=JcHLhP3AEhvditNa0XqyolqaZPTVNuMeUCt0RDQ+iaQLZvuyqbDU/FzYAZ7/vg/mZ7tprpen0E+5P4cdkwISYXL0TanhskIngWp9sMNGVZ8gsP+dZZX1v8r0XjNsPw1BDbpWnz42xlRrIZI8evC+tnC5vcRA/2U2jQVLFDklwNW015HduPGikhj7FyY1oxpbfEiOavCV5rGi1q9rj/qJ/O18FAW/gzWmoNHhaWmUCyAGnvmnwXLgqw5eG882cfG7/Bg5T9TsnFUWoUfTdbVdwcWCzWQVht7OKx0T/LajIllcCemR67BUJpYF17+nIbTwy7h2Dap0Rx6Qamk7T5JTug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lF+quLClrT7tBB8Uv0CgxiKCEFIxtoZxg4wsVnUBBYU=;
 b=XTmyhhjmBf0oOk1f8a4De6IJf/9seX8Q33bJo0MlfuHtbZd3ZcWGyNSCQVA1N1xoZDKdn6+uXhofikTvSAYf//RNxvjrr7biTU1XhDOwhvHVCI70iNetP8VjIl+BcVvjalpH2BLZ7Fv8lJ1JY7fVmWqVdzBdpi4Lj4IG/1mIZRs=
Received: from SJ0PR03CA0116.namprd03.prod.outlook.com (2603:10b6:a03:333::31)
 by BY3PR19MB5121.namprd19.prod.outlook.com (2603:10b6:a03:36a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 13:42:27 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::f4) by SJ0PR03CA0116.outlook.office365.com
 (2603:10b6:a03:333::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Wed,
 17 Dec 2025 13:42:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6
 via Frontend Transport; Wed, 17 Dec 2025 13:42:26 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 4B4F7406540;
	Wed, 17 Dec 2025 13:42:25 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 37776820247;
	Wed, 17 Dec 2025 13:42:25 +0000 (UTC)
Date: Wed, 17 Dec 2025 13:42:24 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, linux-sound@vger.kernel.org,
        kai.vehmanen@linux.intel.com, seppo.ingalsuo@linux.intel.com,
        stable@vger.kernel.org, niranjan.hy@ti.com
Subject: Re: [PATCH] ASoC: soc-ops: Correct the max value for clamp in
 soc_mixer_reg_to_ctl()
Message-ID: <aUKzQCIF6DvVRRUJ@opensource.cirrus.com>
References: <20251217120623.16620-1-peter.ujfalusi@linux.intel.com>
 <aUKmcpUzUac5Dmfq@opensource.cirrus.com>
 <a7038077-2dfd-4a14-b38f-09a5ed3713be@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7038077-2dfd-4a14-b38f-09a5ed3713be@linux.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|BY3PR19MB5121:EE_
X-MS-Office365-Filtering-Correlation-Id: 56009484-0576-49a2-2d8b-08de3d721dd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?9oDbpdFRpaaYUQU1rTeLTIn6rnb7Hbi4URN9zgqfgvlbotO7rMWkTNsTUc?=
 =?iso-8859-1?Q?bWy23JEa1VQEsIO/7tVP9/vyITomuGugAtE5pIP80AHXi3A5FQshXIH7EW?=
 =?iso-8859-1?Q?rPuxH5E5ICvWKlSeVjX7Us8gixyf/OlzarSXFNs2ddf5XIoj9rGVjY1Klk?=
 =?iso-8859-1?Q?fR8xbjOjFXRYAfWKpsW1Niw2NGnrxffHqHv1QVrVgpds4jgo5sxFN9d9hJ?=
 =?iso-8859-1?Q?2c0UJVJfBChiNj3wfyPNsfNYYEVelUm2yxb/Wlt3YT6MJP+RI3lxDXIVns?=
 =?iso-8859-1?Q?73UXa0M3oxSsTbveNHfC6hzHl2vDY1U2vvf2C/S7qY1+CRWmGkNa/obDci?=
 =?iso-8859-1?Q?ZSIdtpSMYKK02c230vj8s9wW/afyPR95rnRATJl2UFbZ7E3+67BdycuBj+?=
 =?iso-8859-1?Q?LZWEZ019pNSJfhUU7VHtGo6GZvpCZMIr3cuBTOUN3+qcf752TI2mfX1/2z?=
 =?iso-8859-1?Q?201q3jtl5oq35VhjDyFg2nErChJwv9FlE+HsIV6vMOz2PtqjEaqE1ppflu?=
 =?iso-8859-1?Q?j7sg0dLQnMQ/gzL07DJm9+bl0W0DSdM10su0NhqApjzuUnnVBuhbVMO+b6?=
 =?iso-8859-1?Q?7CaowFnKnxqOZWkE9WmHOJfuAK6Zw2QNAuJvB91h8JZSMYE4/S/L3A65SW?=
 =?iso-8859-1?Q?9nuPQpDkp/skxx1KfgJseL7iRCYClQQZRGWQOpGvBndSKcekfnPxkx45XI?=
 =?iso-8859-1?Q?5gDfcZ4+BvTijhg62HAdH/fskRBJXaW5dcotqxSnqkB2JodrKwl2/KLb92?=
 =?iso-8859-1?Q?mgKLBVPSEg9CxENToHv79HykT7svmM711iv0lwUw0+biiRtSF+ReDXcGyq?=
 =?iso-8859-1?Q?6WTtkJfbDL4DcfqY65E3fFaDd0P1SLa868grpmRVPfWpma1h2Avqxca9Te?=
 =?iso-8859-1?Q?QbYwjBb7Kp76R3Ru6pfsZPonftMdR9WsN+pYeHZrfjVtfPjJPFKml5trh5?=
 =?iso-8859-1?Q?7sRIppgvdmcjiqnEHJZBSRX2pn688Gnp8owxhBqITCu/pQOIB45xRs0XTg?=
 =?iso-8859-1?Q?fralqI9ngzrs/ofSjXADeCyct3UeZ+bT2onBOARb+URoXWBZEdMpErMseg?=
 =?iso-8859-1?Q?bpUQVpyMD59BT6o73S+cBf4QKh4qaooH7VJick4fzbej7lPImRrPjc6jYv?=
 =?iso-8859-1?Q?ZoI/LK7P1NlJNkRd+gzXinYb/EwB7QLDEt2UGvJh2phcG5//vW8XAfPc4V?=
 =?iso-8859-1?Q?ycl2zkBU9p1ivncFWBkW3OXlO8pB0xUvP+uuhjcZZ4AmqHErB4Ie6bGtk8?=
 =?iso-8859-1?Q?+3FcDVxoViss0U5eScoJ78gUGFtVPSiEunGl/Ak3gSHTbFBPeSZQ97USSr?=
 =?iso-8859-1?Q?ILUEtHw/ZXVtMPuMSXQiS7Qhw0BnZRE99tJntNUIhu4QNKZn/5AQ2sUzxb?=
 =?iso-8859-1?Q?10/q3zMTC265edKtM1Zmt0DHLYC65QO28H1O3//IJnirMGg6SQYaWF70EY?=
 =?iso-8859-1?Q?pJUX4q0TEfgkUdsW5KoqIgQA2IjzEhI86Z17VcqQgn01Zzj02rd5ossYQD?=
 =?iso-8859-1?Q?sIEjiqjvZSt73v1zwhzEIANotjV8bxDXaOnBdI0e3ueBs1VHItHcFjDT89?=
 =?iso-8859-1?Q?vuTHexm0fK87Pur22xNyyBhWP75zAkbcG9QW3BN17n6EAy54GKgs/vMMdO?=
 =?iso-8859-1?Q?FWaBNyKnljEBg=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 13:42:26.6009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56009484-0576-49a2-2d8b-08de3d721dd6
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB5121
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDEwNiBTYWx0ZWRfX0600xf7Fjdof
 79Ts0Pfi89GisWlupLbE35R0FjWdkwuo/uthA8IWBTV5V9Bkna2mwcioesD0gLLc2g1jmM5agIp
 wElCZhzyxcYs3AQNLwNVXEod1OOFZptlRIgNSfZUQe1gleM6hcaTJDtVfxj02sYrOkdD+poR9jS
 x+7vTeds1+Tm3hirw1YY958m/iAPLe+tNAMChl1wbmMVmrXRddg2wfvPF4UYdY4Wlhd8xR47iIA
 o3jZUBGEGNfcwhYJbCozXN+43gmZbi1a9k+IiTWquPjyNGOsmmycN5PVE0Z6DXPpkSh16TUVJga
 pUqm2Ru7laNc2MZXMWq1d87/KVJ7G4VjXV+gsCWBeGhi2LLQdxRlskCGoxGioGAt2ML5ykCuROm
 6kaJEwlkV+/3IwIbBLbiyebtmQUepw==
X-Proofpoint-ORIG-GUID: VRONndm5ZMX37YIxw0XKs-PC3c3oXSw5
X-Authority-Analysis: v=2.4 cv=Qdprf8bv c=1 sm=1 tr=0 ts=6942b348 cx=c_pps
 a=WkVbEPlz7sSPDy0d+2zJ8Q==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=8nJEP1OIZ-IA:10 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=wXEqAQi-kayxeRac8PEA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: VRONndm5ZMX37YIxw0XKs-PC3c3oXSw5
X-Proofpoint-Spam-Reason: safe

On Wed, Dec 17, 2025 at 03:13:45PM +0200, Péter Ujfalusi wrote:
> On 17/12/2025 14:47, Charles Keepax wrote:
> > On Wed, Dec 17, 2025 at 02:06:23PM +0200, Peter Ujfalusi wrote:
> >>  sound/soc/soc-ops.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
> >> index ce86978c158d..6a18c56a9746 100644
> >> --- a/sound/soc/soc-ops.c
> >> +++ b/sound/soc/soc-ops.c
> >> @@ -148,7 +148,7 @@ static int soc_mixer_reg_to_ctl(struct soc_mixer_control *mc, unsigned int reg_v
> >>  	if (mc->sign_bit)
> >>  		val = sign_extend32(val, mc->sign_bit);
> >>  
> >> -	val = clamp(val, mc->min, mc->max);
> >> +	val = clamp(val, mc->min, mc->min + max);
> > 
> > This won't work, for an SX control it is perfectly valid for
> > the value read from the register to be smaller than the minimum
> > value specified in the control.
> 
> Hrm, so an SX control returns sort of rand() and the value have no
> correlation to min or max?

lol, yes exactly :-) arn't they great

> The value can wrap at any random value to 0 and continue from 0 up to
> some value, which is the max?

Mostly correct, not any random value it wraps at the mask.

> How this is in practice for the cs42l43' Headphone Digital Volume?
> SOC_DOUBLE_SX_TLV("Headphone Digital Volume", CS42L43_HPPATHVOL,
> 	  CS42L43_AMP3_PATH_VOL_SHIFT, CS42L43_AMP4_PATH_VOL_SHIFT,
> 	  0x11B, 229, cs42l43_headphone_tlv),
> 
> min=283
> max=229
> shifts: 0 and 16
> masks are 0x1ff
> 
> if you step 229 from 283 then you reach 0x1ff, this is the max the mask
> can cover.

Not quite your maths is off by one, 229 + 283 = 512 = 0x200,
which is then &ed with the mask to get 0x0. Which on the cs42l43
headphones a value of 0x0->0dB. Stepping 1 back from that would
give you 0x1FF->-0.5dB.

> > I often think of it in terms of a 2's compliement number
> > with an implicit sign bit.
> 
> I see, but why???

Mostly because hardware people love to wind me up, I assume. But
more seriously, imagine an 4-bit signed number volume control
with 5 values:

0xE -> -2 -> -2dB
0xF -> -1 -> -1dB
0x0 ->  0 -> 0dB
0x1 ->  1 -> 1dB
0x2 ->  2 -> 2dB

Super, a very sensible control, but wait being a good hardware
engineer you realise you don't need 4 bits to represent 5 values
you can get away with 3 bits for that and save like 2 gates
resulting in an ice cream and a plaque from your manager. So
you drop the sign bit giving you:

0x6 -> -2dB
0x7 -> -1dB
0x0 -> 0dB
0x1 -> 1dB
0x2 -> 2dB

This then results in an SX control with a minimum of 0x6 and a
mask of 0x7.

Thanks,
Charles

