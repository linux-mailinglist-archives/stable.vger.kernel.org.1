Return-Path: <stable+bounces-202813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 41113CC7DB9
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 14:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A303D3019DB9
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 13:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85394350299;
	Wed, 17 Dec 2025 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="hgiE3PXH";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="dC04aaPR"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B3C350286;
	Wed, 17 Dec 2025 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975256; cv=fail; b=BwjruDh9c9y9/RE1cF1grn/MstkKFYu/+dLBGoMTvJSEet4Km2h+Nkw9F/QLME9VVM1Kl+9mQRP+JUw+liYGoHspXXuYRygBDPpCDlZG6jq18GlSINMxwXKEMLtHrpy94ASuGRwE038B/uDHOf6uAA8DBNtJXoWEtn08ZQWClgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975256; c=relaxed/simple;
	bh=YsQoJHBscWkw+mcLFXUpzWbJOm3vJ8AywtSnjOYusyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aDSX0RceiMSiOHM3loWXGbVe3oSeELfM2rqhUqMuocvJKxFJohr4xv1NtxOTF6cNWHHu4FubkwJnQopk7DjOOgZw1PvpoqRswlcvO2PxgmvS0O0L+eWqrj/a85MYnjeu3Xdc2/toNc/NIE/PIkx/0/9pyvpXYh2mBqDuiwRStGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=hgiE3PXH; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=dC04aaPR; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BH4cF89940280;
	Wed, 17 Dec 2025 06:40:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=yNy7/JBkSZPLDqlvY0dmkYsI38zcJRKZEj4yVkeK5qk=; b=
	hgiE3PXHghYfmKxDcVlu02CQ0HANIwkWpE9BExcYKBR1MlWtAOkfzzR1sJiHKzPt
	43ebgsdOE1mQUhGctCx0oWDywkme3OAsRQzOH2DTF88z4LWwcHXRquR0ahTA9o8A
	ULMs8fCUZBxiw2uLuPjJ3VJjnTaUH06maLqtUZxI+02TVONEhPdtZ4Qb3sIKzQ6j
	K4WhALQUbxbdcFrxwDuSuvttzfzyGMyXrhFZ9oy7uyvBlZ4apq2EgVpj9H1w5U+b
	Y/Wagwofc4Vs0OsQvYj8/wZ2ORlgpUiUgIs7m8vtMxlrDmPfznJW51u627lQ3SHV
	AHj1WZe/qpx6tkH+TkGKkQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020086.outbound.protection.outlook.com [40.93.198.86])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4b16e1vpvu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 06:40:47 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8uL/pyDLM8/KuR6+hzl/srucAmP/i/lbgpXqsUDkMfa5a8fvyX93GYWl4V6GViveYwwWmMelzpx0zInypDvduvTE+vFnBjjTCS40HZrlbjuvreFXj8MpAo8OcYC3A4/efV6Q8BA4gpLOmqjoruuE6IIRBQa74NuEhctEvRxa7YqRWsmUvFt36PZNsIT7y5Pt2DBeMbQ1oi+LKYyclUIPs5ItA2fzWoJzvP3Yc62Fw/7ZfzMDAghQz7PqtMcRM2yTEABOQ9MdDddzM6D1qLT/NlWhXnTpHPzVyWMYHmU1TO5I0Bg5UQSy4LXrc2nXJj/ve9zMMZLY1gbfhhoKd2Jog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNy7/JBkSZPLDqlvY0dmkYsI38zcJRKZEj4yVkeK5qk=;
 b=CqfZIopbYgIGSJ8BkH9rSW8AVgPk5XfzI5tLJBdSsGCkf0eUGENeL/dB7oQwKDx/j52d3xuXYTLgyq3Yu80ruvTFRh386AW54Sn13uDxrKuPT1NGKUBrjUFoiqhQ1i2d+/v0L9/8RUaUz9RUFz1lrJPspJEeabMCGVGYKmwn5/+SfefA+jAHm+JMCFm0YvWOnYQI+mPi7xEyJ+0G+/nNuvWHZ49tmIqF/+MpsLfw/97gKeTQ0DtSPzgC7mRxB6+u0A4KYmzAUm6FYuj9yEA4lu+cXjc5WhX1gOu6vQ6AQzdgKSLlTmm37hgG/2pZP4zl9/53lp/wfCxlICIs6co2DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNy7/JBkSZPLDqlvY0dmkYsI38zcJRKZEj4yVkeK5qk=;
 b=dC04aaPRQAXWWTQZQq5WcBt3aoDyrZLlsVWF1IFK90Bqn6BSKm884bTYDYA1YO0Lv5ZDRojP5qVpUrzr6M9/E38YQ1QmeG4llmuuWlcfGOjM7u8NTCP2/HQUWvy9LwOKHh7XL7Ve61llzBBFLxvXVlZbci4sKC2SuTXvGyOT21g=
Received: from CH5P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::28)
 by SA1PR19MB8022.namprd19.prod.outlook.com (2603:10b6:806:388::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 12:40:42 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::aa) by CH5P222CA0010.outlook.office365.com
 (2603:10b6:610:1ee::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 12:40:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6
 via Frontend Transport; Wed, 17 Dec 2025 12:40:41 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id F1B75406540;
	Wed, 17 Dec 2025 12:40:39 +0000 (UTC)
Received: from [198.90.208.24] (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id E5CD1820247;
	Wed, 17 Dec 2025 12:40:39 +0000 (UTC)
Message-ID: <bc6f3e66-ca9b-4ba3-bbe1-5ef31c373e6d@opensource.cirrus.com>
Date: Wed, 17 Dec 2025 12:40:39 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: soc-ops: Correct the max value for clamp in
 soc_mixer_reg_to_ctl()
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
        kai.vehmanen@linux.intel.com, seppo.ingalsuo@linux.intel.com,
        stable@vger.kernel.org, niranjan.hy@ti.com,
        ckeepax@opensource.cirrus.com, sbinding@opensource.cirrus.com
References: <20251217120623.16620-1-peter.ujfalusi@linux.intel.com>
 <6e97293c-71c1-40a8-8eba-4e2feda1e6ea@sirena.org.uk>
 <27404fce-b371-4003-b44b-a468572cf76d@linux.intel.com>
 <af368a9e-16c0-4512-8103-2351a9163e2c@opensource.cirrus.com>
 <56411df9-3253-439a-b8eb-75c5b0175a7a@linux.intel.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <56411df9-3253-439a-b8eb-75c5b0175a7a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|SA1PR19MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e928555-e73f-4be1-3334-08de3d697d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|30052699003|82310400026|61400799027|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjYyT1R3eFhIejNoM3RCM0ZUSFduRDVWN3JES2V4MENZbUQvcGFISkNnQkJ3?=
 =?utf-8?B?VHpualYwWndsczZyUDFkMit0dkdwMlZHMjZnQTBaaHJSM2lSaGM1V3pjaEth?=
 =?utf-8?B?UGJ1N3FlUVFqSTFUaVJjWjZFK0ZhQ3M3L1Fmb0VZdFZJNndYNnNZMDhsMGlZ?=
 =?utf-8?B?RHhSQ1ZIcHpzL1c5MENic1RiTUVwUDNLOUNuZHhselZuM1RIZUhJSlQ0cldi?=
 =?utf-8?B?WUVKUElVZU1yRXpQN2c2MXR4bzJvYW56em51dU4raCtOcmtZRGNhemlzVUxQ?=
 =?utf-8?B?WDRHNUI2eHZTVVZ5dnJ5ZTh1enRZRUczTzhINGlsSlMxZ3NCRjhBeE5NcEcx?=
 =?utf-8?B?eDZXOEMzUHpkNFhOd0JCMFRTR1c1VW9PQU9iZVAvNDBFejZtWExNVHNZY0F5?=
 =?utf-8?B?SllMZy90enJUc1IvQmRMT2J3VG5TVmxaZCt6Q1hyc2t0WkJJalpVdHRFdmJS?=
 =?utf-8?B?RzBXSjVpM29hL0JtdFRrMzlVYmtrd1R3dFFnREYxcVhxQ2pyaUQwdnpYV0I0?=
 =?utf-8?B?SnRQbXhMb3JvSm51aHBoV1ZVOFllQzR6ZUc5aEFtanlEWmRYVDRXbGdiVHpp?=
 =?utf-8?B?Qkl5WkwvMGtCdUIwWEcveDk3MWRETS9MdUZtZGg0M1JLd1BjRDdYNmhLUndQ?=
 =?utf-8?B?RTlLMFNvZnJaSElHenNDSFYvY3hYT1BhMm85VVZOZVZSMTQ5Q0g3bUhNNFda?=
 =?utf-8?B?T1dZZjFtMDN5RVNEdE94S1BhaXBCRWhVc0VBcG9CLzcwMW8rQTdlTHVhWkdj?=
 =?utf-8?B?QVhHN3Vpcyt6L3hDNWxRY0NkMTd4S05paGtVcHdUb0JSTW5ZOFlnaDlNbWs0?=
 =?utf-8?B?cnFVN2VrdDhxUkFVdGFzendIc1l2TGtuaVlDbi90VSt4bVZZZTdTZzB4MXp3?=
 =?utf-8?B?L2w1bkxLMFlRcXpRZHUwMkZXbUFZdzltMDIremd0VmhTUmp6L2xtOEFDTGNF?=
 =?utf-8?B?Wjl6T0pneE44Y0JoYW00S2dnR29NUlJWQVU1UElTZzZZWTdHSXRsTVhZdGZ5?=
 =?utf-8?B?SU5KS1FuY3FTWWprcTJKOUZiMHpMMWRNd0VpSnlPUDJpUEp5M2U5TGM2YUU5?=
 =?utf-8?B?NGJnWmNxS2NvUEdFSXNlZFNFY2g4NTlrWVhzdnphS3o0ZDlvZmJOUU5EbUpB?=
 =?utf-8?B?UENsRjhuQTd0QXdpdmd4QjFpcXoxY21iZmc5azZ1R2FNaElyUzhmdW1xZ1Ba?=
 =?utf-8?B?dEZxOS9uN1RmRnV5Q09FczcyY29EaTFIdFRzTlBBZ0dnUzUzakRaSElVWEdr?=
 =?utf-8?B?MWdWTCtxOUUvUEgxNkdnTDhtb3FQb2g0MExCWlpvRXJ5Q2daSHAzSE5EUzE5?=
 =?utf-8?B?VXZqaWtUQXNXSlVqNTFtZUF5NXR0L0lFTjlLeFFEL0JEa1FxOGpIWmxZM1dF?=
 =?utf-8?B?Y085dlU0TDN1OFJHK0RGWGNnUlZMN0JEL1AwZDdDZWpUd0V0L3JjT1R1bGtM?=
 =?utf-8?B?cHhwanBYLzZQeGk0N0I1cCtIeXBJcUhaTVpYYjFDTEQ0aWIxV2ErVWUvVkNB?=
 =?utf-8?B?andkbXRDQk9Qb0d1MTZJcWEvSVcybnhrSVZacUd6M3VVSUtXTXBUQStGRTQv?=
 =?utf-8?B?aWlkbFZPKzdWeFFTcXBDOWFUL2lWVlhYM2NEN1BSOGZpRFRibHI0WjYxZ1Vi?=
 =?utf-8?B?S3dmOVNYQ2I5OVVqSGlJNEU2Z05acDVFZGh4UXl2WVl0R3I4Z0J4OERvRmRW?=
 =?utf-8?B?MkRUcFp5RHErTDVWeW9md0RDQ2liRUVnV0Raa2RaTjBkQlplTC90NHVnYUx0?=
 =?utf-8?B?UnR4N0ttejZpRkJTOEZDVUZON1EySThheWxUM2toR2s1NWVhcDFPdXRSdEV0?=
 =?utf-8?B?bkVZQU9KWldhSU1ISzBwWkoxRnJENFJQcXB2ZXVyU1FoUG5oa1dnWWhxa0V1?=
 =?utf-8?B?YmcvZ0l6NFlLTzVBNEtGVDFZYjdrMHpJUXdYUGQyT2M2U0Y4K0FQNWVZU0FX?=
 =?utf-8?B?OXQyL2Jwd1RlOXdTbHhZVzc1RXpTZTZqN2xac084OVZnbTR5T29wVmRTZE5X?=
 =?utf-8?B?OFArZTFQNWpZMXRRVzhzVk9MUFpSOGdRbXBObENQOFIvaHhmVk9PcHc0UVdF?=
 =?utf-8?B?NTlRQmlzUWZmTlNlRVlCNWtNVlNjNjdlTnVQY2hOeDF2N2o3K3lQSFpyZFpO?=
 =?utf-8?Q?QViI=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(30052699003)(82310400026)(61400799027)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 12:40:41.2429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e928555-e73f-4be1-3334-08de3d697d37
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB8022
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA5OCBTYWx0ZWRfX3VNc5Fc3bAlU
 84B9DcPmJ/S/xZtN/Kf4pYmYsxCtCyCTuHdSjog5o2mYSurUJlb+MdUArEPTGxNQruG+22lNurP
 DjyB6HHMD1wAtqxwOG9KlkCusrMBKKCL9pAhJCk9NZU/LeQoO1xV4DPTAlnRUD0SsKyrPT1yPvd
 bqcObTcWeV1sLnQJzvvYkDy2a+RHNG+HiGZklYHDrXPVNqeT/4EwyCkqX3zC4d4sA5b/Md5zKo/
 vdI5kioiW4mvO+vC5FsRBxRJcTmpuijY90MXut2aVHN9nZNVjrMyfz0qgTAQdTWRGIqU9IGB/gP
 E63wXaEtiSltgtEU5dJG1+TsUYnbMpARy2Kyqdcpma5KuZVrTHZFp0aYzVzjmZHkoEQYDtXLJzx
 FssqgrRZLIeAxB8OAerMymH0VKWf6w==
X-Proofpoint-ORIG-GUID: UQcpIfv1Lcug8qyNabSxj0_OArfvmXAZ
X-Authority-Analysis: v=2.4 cv=Qdprf8bv c=1 sm=1 tr=0 ts=6942a4cf cx=c_pps
 a=lEAsXE5stpqivpVhnk0CUA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=w1d2syhTAAAA:8
 a=hQlQifj8nDAVOjuXB0cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: UQcpIfv1Lcug8qyNabSxj0_OArfvmXAZ
X-Proofpoint-Spam-Reason: safe

On 17/12/2025 12:38 pm, Péter Ujfalusi wrote:
> 
> 
> On 17/12/2025 14:36, Richard Fitzgerald wrote:
>> On 17/12/2025 12:20 pm, Péter Ujfalusi wrote:
>>>
>>>
>>> On 17/12/2025 14:16, Mark Brown wrote:
>>>> On Wed, Dec 17, 2025 at 02:06:23PM +0200, Peter Ujfalusi wrote:
>>>>> In 'normal' controls the mc->min is the minimum value the register can
>>>>> have, the mc->max is the maximum (the steps between are max - min).
>>>>
>>>> Have you seen:
>>>>
>>>>     https://lore.kernel.org/r/20251216134938.788625-1-
>>>> sbinding@opensource.cirrus.com
>>>
>>> No, I tried to look for possible fixes for this, but have not found it.
>>>
>>> I think my one liner is a bit simpler with the same result, but I'll let
>>> people decide which is better (and test on Cirrus side)
>>>
>> Does it pass the kunit tests for SX controls?
>> The ASoC kunit tests have specific tests for SX controls.
>> The original patch failed those tests, but it was merged anyway.
> 
> It passes my manual tests on cs42l43, not sure how to run the unit-test
> for SX, can you by chance test this?
> 
The easiest option is to run them from your kernel build tree like this:

make mrproper
./tools/testing/kunit/kunit.py run 
--kunitconfig=tools/testing/kunit/configs/all_tests.config


