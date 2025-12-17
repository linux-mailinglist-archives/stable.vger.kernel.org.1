Return-Path: <stable+bounces-202869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ABDCC865C
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 16:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4ADE23066F39
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 15:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ECE23D7FC;
	Wed, 17 Dec 2025 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="N3Dq4nQ5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="zbb5br1V"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3EE259CAF;
	Wed, 17 Dec 2025 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765983649; cv=fail; b=naOn7EXLQqpmPTDI2+SEaekFdGqKDkbTJjfZHZFGhTn2S00MEUUzO9Pmnp28yMP3k0gSEUkkQ/0ZxYzBxSvXg62hplgGjRa/bRPwvPypxIQ0Mf00QFg3Gd+ib1TmU8T0HQlBPDI8/A44JGbDNtMLsqAWJ4yurBDpZY0GSsp+5a0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765983649; c=relaxed/simple;
	bh=XjLX80C/p7FrasaHeHZrkhkahVwZZbBn1E2ZyX4L440=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwauB5FcBmIi4bmH8zvKGx0DUoNFi5+7Ru9f6lzAoB3yas/nbDlbUUm2fjRgQ2Xsjxu0e5wJT45A3q/eOH/6QHkkhYeyWfAi4m94idmZc64yppKKDxl6axv6KG2iXlF48FStcO151EXpeJrW2aR+RvOiDBUG3iFVhVRuV+5DomA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=N3Dq4nQ5; dkim=fail (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=zbb5br1V reason="signature verification failed"; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHCCgsc3838393;
	Wed, 17 Dec 2025 09:00:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=G2ziUWCTXamGfvJNwI1/CCNC3xH9xc1+rzMTpB03ssQ=; b=
	N3Dq4nQ5RGM4RGA5cObz28qpOkbqNT2PzjMeQRBkVP4aDnfDUnBBZ939wLeKSJ0Z
	UtyxXEtKzg39FkLevxhaATjRMaJueKDhLiSGQ/jMiVkXe7PlIyymtzJ6ipk6yGGr
	SR8qVxhL/9lXPiRbwVqbMJbJ5kWHIIa94XguAEjsTxbkCkFcBUd+LZY+3tg1fSXq
	FSfTRGCsD47YFdCjTKOjLymCKcOBIVDbkOpOzm+RNI64509lprdHocIrf5iHtarX
	/LR7OfaulhFzI11bcrHVDVtklfZNJw/HLZmNeEX/VMqozKaQUh6j2c1MHHbT2he1
	FeEioj5TNrIaOYDvuyJ0+w==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11020081.outbound.protection.outlook.com [52.101.61.81])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4b15ejcy53-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 09:00:24 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/8ElZEV1iS72UYrTl+tFRl6hzIlO+cDbZNxrbS1T8hAx01bUmDEvca6qifBUaIHwA8l6F1JXN0HfkfqLOo6BEriE43Sl4TTGWfU4JCGv0V1Jv+35pew8QBoMGC9cktKZDQn/Gr5KHW27Dz6VypclhIqBGj2oLq1di3rOT6khVUY4UrcA+WODoHWl2Xt/RIZ8Azw1ZK/d6m/Cd72lPm+iqBx6fzAjTYT51TtOkbF/orKxh2IoaN4r9DYHurXyyUA5NHjAURhyklyQpY99Hh+TeoI9YLPjdwN1hBj+1LhIM+K1MZvo0RicSYD2eDB8exFD5/RzB/P7drMeHTJT6a/cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVYlm7+9nfr3ajvWFrW9foNjrOd92x8Xay2wcbpT1us=;
 b=DFm+YVEkaco1P9G/z0FQuko/bkrs4BE0TzX+Y7FhazFZ47KX922y9WuSYDv0wH9WhtAX13w4Sx//rZhqu6rbVawuzUzTm0xTNXfWMMHUl0BmaJGbX4LiUR81amv8t1tzDZaTcyBa15Fk6yherfbbQIGW/+q+/S7f1YJvCJe8YW6SK/aG0Fi6qSZLApM3F/ha9Fdk6+tfsxx+7Du/ZCx6hdbfgH9Ju/m5BWDn99m1jPNo7INFMaQBCxivzsxy5HP932H3N1SNvXs3h4nGuj4W3J14lfyslT7LaXcKCH7a3rajAkt+6GVM9/JpZYQrVgc8JUMQniujNVB5AgnGAEBR5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVYlm7+9nfr3ajvWFrW9foNjrOd92x8Xay2wcbpT1us=;
 b=zbb5br1VGkGUHmBPYiBv2m0Qs84x/2hOBbI2nSG3WagA4Add0/jdDjPdSf7860SaY0sdE4OwhExyKHckO/xxxfWRcUq8QBc/Hm+UrD7CBBk94dTXDotasqfTqAKrT6ioQMARwSnvFdnDKPUGS/Yc5cI5QDwRQzllDioVXNmlQP4=
Received: from MN2PR16CA0046.namprd16.prod.outlook.com (2603:10b6:208:234::15)
 by MN2PR19MB3968.namprd19.prod.outlook.com (2603:10b6:208:1ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:00:21 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:234:cafe::7) by MN2PR16CA0046.outlook.office365.com
 (2603:10b6:208:234::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 15:00:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6
 via Frontend Transport; Wed, 17 Dec 2025 15:00:19 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id DC14D406542;
	Wed, 17 Dec 2025 15:00:18 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id C8823820247;
	Wed, 17 Dec 2025 15:00:18 +0000 (UTC)
Date: Wed, 17 Dec 2025 15:00:17 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, linux-sound@vger.kernel.org,
        kai.vehmanen@linux.intel.com, seppo.ingalsuo@linux.intel.com,
        stable@vger.kernel.org, niranjan.hy@ti.com
Subject: Re: [PATCH] ASoC: soc-ops: Correct the max value for clamp in
 soc_mixer_reg_to_ctl()
Message-ID: <aULFgS9sV0uy4wNN@opensource.cirrus.com>
References: <20251217120623.16620-1-peter.ujfalusi@linux.intel.com>
 <aUKmcpUzUac5Dmfq@opensource.cirrus.com>
 <a7038077-2dfd-4a14-b38f-09a5ed3713be@linux.intel.com>
 <aUKzQCIF6DvVRRUJ@opensource.cirrus.com>
 <a367ee5f-c46f-470f-976c-011ac9cfc55b@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a367ee5f-c46f-470f-976c-011ac9cfc55b@linux.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|MN2PR19MB3968:EE_
X-MS-Office365-Filtering-Correlation-Id: 191431e3-41ca-47c7-3261-08de3d7cff2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?E+T1IB+7eSlYY5URt88q1q8degFZkW7XCPpyzPZ19qjMf0HkwV+JaRm3IN?=
 =?iso-8859-1?Q?U+qTAM1iWBaMhatx3TwfnUXomtvWYMjscuc8/Yj0inY+5YUT4kbgHqrDnf?=
 =?iso-8859-1?Q?YuOFBE9zrPCsTNx4EU/Yt57cN5KPcSOpuYlaVPOYv7Xj9uUl1qMYukG0ou?=
 =?iso-8859-1?Q?QYCGCsy/jQ11hp0jmVuEQGMzg3RLUaBuhPB6K1L1P2JOHYtrjFuY55Vje3?=
 =?iso-8859-1?Q?zBTgSmxfhfsHVijgkFV3SAm4CLQav27j0D9lrGvDzezpoZaamhn3BmLeqa?=
 =?iso-8859-1?Q?BtbVMw/izfL3DCoFjBssSiwHaGmTGgy1hYqLO2eYdCZrIF4PSYxY5lXzwf?=
 =?iso-8859-1?Q?hqLGTB7Z0mCOOefmexYiX+GqHLDUQuBToDyKE0wXE2cAitt8XneIH9Ou4o?=
 =?iso-8859-1?Q?Msa5QMBr9UNYJTzGLYpB7ftfPIbEQDc/acbJ4txRkN+BtYFvde4n6KnN8R?=
 =?iso-8859-1?Q?eyZd11mVqUBwHhsp0GOKdUfIdl2aEP3Q6KRyLSo945zlyRentjSsMZIx8r?=
 =?iso-8859-1?Q?IwE4ghdacjOsXFuFA4mKRlb9q4/WkRZ/cUiQ3Idowtsdk0Q+VpGKrCrl+V?=
 =?iso-8859-1?Q?u43rimlPmlUoK0bx0FW9hAJ+cR4sFHaYN+U/Z/+vPAzAEWaOtHZrPWXIIE?=
 =?iso-8859-1?Q?UvTMa31wOM96vWnJo4Tk726B1qKwhPTCO6E8vCUIiLn7yW4xLF0xUrFgxK?=
 =?iso-8859-1?Q?quB9NYweCKm3ZZw+3i9pKb/5sce7D606lqHZkfmTLJpRKNL/aebdtiJDQN?=
 =?iso-8859-1?Q?GA6KFeWwcT8QKOCGAgiu9c84NLl63MNvPqMBrev34nd5GkIohWuNqBjBEZ?=
 =?iso-8859-1?Q?P3xXK8E/5WdQZhQd5rlNrk4QUDnR+6Rp0JEsRaMipAqSr0kziGNWxkhtOo?=
 =?iso-8859-1?Q?2PGCvI89+taiO4VHMH+ElcksZr5BSwhyZQfHKk2KD5FgOSN7TEuIvoe4Rw?=
 =?iso-8859-1?Q?Ew30cq2sbXE4svOzErlpPTWW4iY4iFmqmY1KT1rrjOrn8ubgHC22Q0wdH5?=
 =?iso-8859-1?Q?/EM51CfuqpvJc2zTc1SAs6om/DjuIgi6ljLBxBMIs+eo9aOmKXOh/ymx2T?=
 =?iso-8859-1?Q?dQ8UE/0yNV0iJNOxfPCGBt2jrDSVuDzjHhVG545IrO/VdrbKOa4bkwb9wv?=
 =?iso-8859-1?Q?yDr1TGLi2SH9xHjO7qG9BpwTLY3MiRr+Xr/HwL0CyFTn9hcTmP7gv7AHFL?=
 =?iso-8859-1?Q?fUyLNuqqfWPldU1VbaV0/czbzM9D25ne8vK1dhnW7kpqAXGhiMM0+7AltJ?=
 =?iso-8859-1?Q?L5BiZAkcoi/rmXanFceYa5peSM2uhtKd0BK9OH80jG0gjB0sU3nD1w+ofr?=
 =?iso-8859-1?Q?8SMoioclBN8UHtxM2YY4+rhsZWE3u2L7UJjL6kYwgjW0LS7Rj8D8TywmNj?=
 =?iso-8859-1?Q?oIUjk8owTBEAofejh/4GwFYrh4dUw9RBQhM5Ub+hcUtSgVNVn0/zQ85Tm4?=
 =?iso-8859-1?Q?1tebWL89++xGtUnUKrtVHAUXkqTqpNtVyQCwB3B2LvHlMesHPPPu9wWMJ9?=
 =?iso-8859-1?Q?WSyR3F3ODhw4PHEyiwhxR/eLKgSY5CgkySJPPfOtlRYmPm3IX760hjXnb3?=
 =?iso-8859-1?Q?z0WHB+v5pKFhkbw9cHJ6qA4KnqJyPsoAw0+kDVsi7jVtF3YyYl8tsHcmdC?=
 =?iso-8859-1?Q?YMkQXbu4zeg9U=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:00:19.6438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 191431e3-41ca-47c7-3261-08de3d7cff2b
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3968
X-Authority-Analysis: v=2.4 cv=ZZUQ98VA c=1 sm=1 tr=0 ts=6942c588 cx=c_pps
 a=fWcyablzXG6Yy0r0xgFQKw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=8nJEP1OIZ-IA:10 a=wP3pNCr1ah4A:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=qwWj-4Ai7q47lDGeBiwA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDExOCBTYWx0ZWRfX15JymKU1ZW4o
 XQKEEqkjWkAh/ckhb033SXbeXeFW/3Wo0cVdTdCgnQBwebEgh+/yXv6uAxsohYNQQfzpJubCq6g
 bAMniCLf5Req7fBDAUWSw8EtG1D+p8oqyqLVYFslROts6OTLY8ukcFBaIz70UvYF6kMZU6HBW15
 Ue//RrJDVxg18PD/2/BkDhL5ELXMSxWx938+CFADWjyxF2GBDQpW5cBkfcArB2ISXn2n9X9KBsI
 XxNlFNXedoIsG89ao4No0531mlJArag98vaj38mwzvzG0/PrfvTepTiMX/CxGsIZ3PDlyTFMROS
 GilYR1Dn7a1uW+aPObeN743x9GTw7ED6TCEYwA76VCmKfudOJhgcVLhB1hUT1QLTxhCWCT5fG2n
 JclVw0KEEGACm6isJ4H5SZ+98ibm3g==
X-Proofpoint-ORIG-GUID: iM_-vsqjLR5OrONnSInIC1L-kw3tBJWB
X-Proofpoint-GUID: iM_-vsqjLR5OrONnSInIC1L-kw3tBJWB
X-Proofpoint-Spam-Reason: safe

On Wed, Dec 17, 2025 at 04:31:37PM +0200, Péter Ujfalusi wrote:
> On 17/12/2025 15:42, Charles Keepax wrote:
> > On Wed, Dec 17, 2025 at 03:13:45PM +0200, Péter Ujfalusi wrote:
> >> On 17/12/2025 14:47, Charles Keepax wrote:
> >>> On Wed, Dec 17, 2025 at 02:06:23PM +0200, Peter Ujfalusi wrote:
> > you drop the sign bit giving you:
> > 
> > 0x6 -> -2dB
> > 0x7 -> -1dB
> > 0x0 -> 0dB
> > 0x1 -> 1dB
> > 0x2 -> 2dB
> 
> I must say, wow.
> Being a SW guy I would probably done this differently:
> 0x0 -> -2dB
> 0x1 -> -1dB
> 0x2 -> 0dB
> 0x3 -> 1dB
> 0x4 -> 2dB

Yes that is exactly what I would have done too :-) but then
that is probably why we arn't hardware guys, would make life too
easy for the software guys.

> > This then results in an SX control with a minimum of 0x6 and a
> > mask of 0x7.
> 
> then the comment at info() is hard to match still.

Yeah I think the wording "min is the minimum register value" is
perhaps slightly misleading. It is the register value that equates to the
lowest volume, but that isn't necessarily the minimum value that
can be written into the register.

If I can find a spare minute I will ping up a patch to tweak
that.

> static const DECLARE_TLV_DB_RANGE(sx_thing,
> 	6, 7, TLV_DB_SCALE_ITEM(-2000, -1000, 0),
> 	0, 2, TLV_DB_SCALE_ITEM(0, 1000, 0)
> };
> 
> is sort of the same, no?

Similar but some issues, I think it would let you write values
that arn't valid. The control would be fairly confusing to a
manual user, as the values are not strictly increasing. And I
would imagine it blows up most user-space stuff, which likely
also assumes all values are valid and strictly increasing.

> Thanks for the explanation, fascinating!

No problem, I would be a rich man if I had a pound for each
minute I have spent chasing SX control gremlins.

Thanks,
Charles

