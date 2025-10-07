Return-Path: <stable+bounces-183535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DB0BC13B0
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 13:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F70B189A072
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 11:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA51C2D8789;
	Tue,  7 Oct 2025 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="B3x3JF33";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="DRzq3DzE"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089EB7483;
	Tue,  7 Oct 2025 11:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759836944; cv=fail; b=YCnWMWURWMdSBbG+8HQVh8bYdpJmgf91riUu95DmeZ7c0SvvdmzdidQy6atwoUvcqiXL/qTccdAXrOjBYHKVffCyeAToM63SwvI6lQN8cZE0nh7NrMkcohdFvP9Hwg3UreFnqI5YtyUpslgsSHMZOjveeDErylHw9RO21VtcOIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759836944; c=relaxed/simple;
	bh=JLKy4D2nXoOa6rgVharBHCQXsDXIuHAYeV3qQWoY8DY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p4IzzvOf1EOCDRwHWFNz98rDqu/DTs9Okz3KuAyw5nOxWOKKk7yeNkvWaF7elB0KUhbL3SXjLuZ1pGM8YOtdRg//cw8PtTpig7zURIvFm92GNxj7lrYc9fU9AvSF337YCRC02ZpZaUVq09onci/acNWzoO8JlSXs1kVEPzMec3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=B3x3JF33; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=DRzq3DzE; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5973QVhu1250188;
	Tue, 7 Oct 2025 05:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=45YaG9EK1iljEbH/KjllyIgPZ4QQuiIk6hA3Ug+4tf8=; b=
	B3x3JF330xg3D1/K2o1yqPUt69bxOz77MoWCVx2RzoZH+nHw/0pk0kB7HNlQU9ni
	fu8KHjYOpN1cesxA7GRhEgCkJFMqZcF6VjVPMboSAsT3Bql5yMmQ56pwY9zu91h1
	/ujgB8x6CI6fzW2+7boDcOb+uQKE2HPxP6Y8PkuWzRrvDwQNdZwfQgKeTvxbWDU4
	ExyUphTGWuzaKcnxHG0LMyL2I6MMQzXYvFjJnC6Ix2S4/vVF5reIfGLxfi/w3GEM
	rE9am4Gdgo+qNmblkpzU541Jt1XfS8aRnxapUHbOxEG+euyn+fAjSuQYkicZ8zdG
	Z0/GmItzwWDT2CHhqXB/hA==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11022082.outbound.protection.outlook.com [40.107.200.82])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49ktb79xht-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 05:57:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igBGDNvHGSyUfa1NNmo8n+Q/ll2UG85PVFlKOLCeMSu8jBzX88QtO6fpiNmTp2H+lGAxA5UhrcKojT7o1VSEGOyfKrxmiPOA5WGZa6jcDT6WJ5SyMlDZvsaCvMtkv+y1bAX+eDG2LolAWT7oUeD+LRdHVF1iC+Jab+ji39Fy74XJol3gb4F9TFQjzDMqI1I8FIWYFM3TEfqj13kJSatggX71qmnWcjQM7YMgR/ytFBeOlNuNPHjkdbBvdVbasDwQ2lTbSCg2tWka6NyGGdhi/1DwknWfEAVhipTsdPuLAqjp3tszWV38wXi/rUpeHx0X85sYHaAaArl1mDoKNgUG0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45YaG9EK1iljEbH/KjllyIgPZ4QQuiIk6hA3Ug+4tf8=;
 b=CBxKC8d55aERoIqI+VJSMZCMkXzxFOZReyO1tOxvnjxrsUdIm+SKq9fsZ6jAWKEPxfov2WOMdw+1afUV6JhdUOuyh5oA2pOVcCvPNDlWSA1ZiPFtT0uvR/5DdwHG7S16uOyoOmjT35u6a4IOYUejwMpG6z5fp+HZs72vT800xHtJdLbCTi4Vo+ELBMh+cwRUWTPnbqVlZODQM9ohqF5ql5HjvJ1LUCrX0Gzk5tjgLPsMAy/5KsbAHzCz6ZTotfHdpAcXQUjHUU6oB+nWXCztm/SdMhA9JWKBvIRQvBrjXJkrqHkcnQC3GWEBD8De791s40DCxUluTeNjPyvEViL73A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45YaG9EK1iljEbH/KjllyIgPZ4QQuiIk6hA3Ug+4tf8=;
 b=DRzq3DzEyOIKhUoboJzdf77f+FgMphyIiGqzepq6bfbfI2OeowHYXnY1O/2VlNgPG3/4wCCW9r3p4vGfNcfntg4pEtP/bv6ZD/OJc+pcWigFHEoZAuH7qiDwwcalADDf0AXTdBGm2vIikB8ykxgpRlowsw4MoEwVk7Xg/hC0krI=
Received: from BN0PR08CA0025.namprd08.prod.outlook.com (2603:10b6:408:142::10)
 by PH8PR19MB7047.namprd19.prod.outlook.com (2603:10b6:510:225::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 10:57:21 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::4d) by BN0PR08CA0025.outlook.office365.com
 (2603:10b6:408:142::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Tue, 7
 Oct 2025 10:57:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9
 via Frontend Transport; Tue, 7 Oct 2025 10:57:19 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 8F4ED406540;
	Tue,  7 Oct 2025 10:57:18 +0000 (UTC)
Received: from [198.90.188.46] (unknown [198.90.188.46])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 4B674820249;
	Tue,  7 Oct 2025 10:57:18 +0000 (UTC)
Message-ID: <4ff0b878-9146-4f49-816e-bfd53a91122e@opensource.cirrus.com>
Date: Tue, 7 Oct 2025 11:57:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda: Fix missing pointer check in
 hda_component_manager_init function
To: Denis Arefev <arefev@swemel.ru>, David Rhodes <david.rhodes@cirrus.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        stable@vger.kernel.org
References: <20251007083959.7893-1-arefev@swemel.ru>
Content-Language: en-US
From: Stefan Binding <sbinding@opensource.cirrus.com>
In-Reply-To: <20251007083959.7893-1-arefev@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|PH8PR19MB7047:EE_
X-MS-Office365-Filtering-Correlation-Id: 81878172-3ec3-4aaf-9d44-08de0590497b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|376014|82310400026|36860700013|4076005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUNTcVE4Y0NEUVVJMStNZnF4cUUxalI5aXhBM011MEE4eTNWR1RQRUZlTHBt?=
 =?utf-8?B?dWxCWU0vWlM2VEpORk1OYTl1VU1FYTFyeFY2NW84YVN5SEVWN1d4RmxudHBH?=
 =?utf-8?B?NkZKWXBEQlMwV0tnSVhBSmlSVXgzRUZaMFhXY1hDUFNhcjE5ZVB6bkY5SUpi?=
 =?utf-8?B?Ym5YcVB5b0Uza1pUYzJieVl1ME9ybU10MWZYVzVYL3E4NGhqLzNZREhleHNv?=
 =?utf-8?B?U0VTdUMyZERIOTdSZjhYK3ZyR3R6eWJBOXp5bWFPcGlzS0FUdFFuZDJKSGgx?=
 =?utf-8?B?a253OFh2UHdXeXNvbjV2WExhNUpqTWd0Zm5nbkJ3WVRlN0NDR09CRFg4VTVz?=
 =?utf-8?B?bkF3QmdnamR6NHZDUjFwK3RvdDF0OWJPUjdPRFBlaHFvUVVUQktzQzZQNlZh?=
 =?utf-8?B?SHgwUVN5ZmtKTDdXMHdpT1A5bmllV2xDa1RKUW5LUzNLUk5CdlJIalgyR2JL?=
 =?utf-8?B?TkJUdWQrOUpMNHdyblAzQmRwU2NOTnNIdHR2MnpkOEF2YlRIMkIzVm1YaHFB?=
 =?utf-8?B?VVBSZ0I3aExHWEtSRXVCdExDQmxNS3BIZmVEWERreTN0MURrN3FZdDM2N1h3?=
 =?utf-8?B?NmZBb1lDb1AyOG9lbTROZ1dDdmJ5TzNLY0NNS2Fnay9HcHhoYzRwSERRbzBp?=
 =?utf-8?B?aWxXZVlqcElJRUVLSzNPQ1lEdVpCUDBrU1lFekpXbm82bldPYVQyOGd5blFW?=
 =?utf-8?B?YXRFQklQVTF3YTl6MFcxK2hISGtMSVY5b295QnhsS3RkeFlSVmMyOVFpZTNI?=
 =?utf-8?B?TjYrM2crNllmTFFqNkp3V3F4d2R2YU9US3hYNmFrNy8xVnJiUU1SMUs1YkJW?=
 =?utf-8?B?NHhCY0srbytGa1VhL1JkZkdiNjdJWEI0Tlc0NG5mdVQwMk5rL2J5R0NzWmpk?=
 =?utf-8?B?Nlc2YzgySWF1bVljb2hFU3pjNjcwaURwakQreW5wbVN6MGhNazFLd29vRkZH?=
 =?utf-8?B?V08vUGo3VnExNElRcnp3ZE0rTTV1a2JwaDVvZU5xOGk1YVBmMTVjMURXUUg5?=
 =?utf-8?B?aW1KSEdYMm9saW9BOFlvbzlDUmNUanMvaEk1aFpoYktyWGNyUGZDVjZPeXhH?=
 =?utf-8?B?MFBTUVQzaElVZi9LVmVYUXlySkJZbzJwdXpqcEl5R0ZNVVorM0NRRWJnbE56?=
 =?utf-8?B?NE11UzE0cVdkQnBGTU1lbG4zVHVyNjRreDFmQlZCMXphYmNkMjEzM2R6TVlU?=
 =?utf-8?B?UzlBNm9LQmUxYVFnWE12Yld4cGh2eUQrTTZlb3NzQS8rQ01QUW1KQ29odVBU?=
 =?utf-8?B?bHJiamJGcWZVajRpUmxjZURpaGUwOEQwZnVLL3kydkNCVDFpL0ducVRhYTVj?=
 =?utf-8?B?Y3pwYkhtZkN3V2hiTEVkK2VBUTRIVFEzUTIvaWpLOVk0Q01oTXdWeTVRaTNC?=
 =?utf-8?B?UHk3Mll5a2RXSW1vc3JROXNKSDdBMWpoMzZBbkhuL0NJeXgrU0xhUVlvdWlV?=
 =?utf-8?B?MHpubW1hWHp4TGZWb1lobUl5UkJzOWVsYWFPVURoaXN1Tmwvd2thNVZWMTlB?=
 =?utf-8?B?WlVJQ2RiU29yaElGZmVScUtSZ29tZ3pYODJZcWxZNU5GS2FHZGM4YTdaZEsx?=
 =?utf-8?B?cWlxTHBHMTVyV1VPZkRKLzdMajNYeWdKbnVXVVNiVEFtbTMxL0N2TFlIS2kz?=
 =?utf-8?B?aExINlJvV2FOb2ZjT1hNaitQOG5INnBQYTRLTU1HbEJ4aVJ3anBsT0ZvRzFJ?=
 =?utf-8?B?QU5lWThzbHRhYWt0R1Z1Q3BlRXZ0Qkx0VWl4QjV5RzFpdUdOVHVzYUUvRlhj?=
 =?utf-8?B?MjdtRW5GS1R6Qm42Tk8xZjJ4ci9QcWVyM09iTTRnd1AwSXBXckNnVEhLc2ls?=
 =?utf-8?B?RmJTUktrTVNmQmhnaENvWUZUT3JjMlhOczhrL2RZMXNteGdNcEFObi9oOGFn?=
 =?utf-8?B?WUs4UnhEWU51b3YzVUVNN1QzM25vVnVIdWZIWXd5MGFIUVArNFMrR043cGp5?=
 =?utf-8?B?L1o3QkwyTWU3M2RPa0NSK2hMRHo3R08xdWJnYVVwbEc4U3Y4NEJTQmhyOWZm?=
 =?utf-8?B?YXBKVmVuWHJOQjZXZlRtT0t1NXRTT1UwTHQ5anRBRkVSQnBwZWxmZ1FnNjlF?=
 =?utf-8?B?UTFJYW0zdkN2a3drbDN2YWpIS3pEeDRXT1pSWUdyVVVPai9zTGViOXQ5aGhy?=
 =?utf-8?Q?qOURe1XlALbeeTQa3gTWTUAm0?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(61400799027)(376014)(82310400026)(36860700013)(4076005);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 10:57:19.7390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81878172-3ec3-4aaf-9d44-08de0590497b
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB7047
X-Proofpoint-ORIG-GUID: vCWg1D2pxwbyAPxpgGby6OGUON3XvMAN
X-Proofpoint-GUID: vCWg1D2pxwbyAPxpgGby6OGUON3XvMAN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDA4OCBTYWx0ZWRfXyivGjv+xqAFH
 Ekdww3iJieO+QAob5QBKgJewcEhrNRNstmb90oKn4EKhZU7P1/esb7XLEIV1SDkwMSn+bMut9tr
 K/Y4rlWMiM6ozSY/j89UsP83B3/bJV+nmdW0CSmDzO0TMvm+uRSDSHLbsEa3CHOyPrNYTxUnBWQ
 VzkwCWf4AyhK6HdoQ3shhAnzfgYRq36oLv0kY0kOZfiYDOBEz6aEu1a0GWYIgEDFEXIOsk7Kvbd
 WJDj4frYiEwPQBOJebPVTEP2z2t5k5B4aJSouMjmQRRfm5tgJbSt405v8g18OEYYIzIrEGmKfGD
 vSEdhe/pe3erFwVFhyP6w60Svq7rDZiwPxcNHmXB6ScW7bYmnZASLYzt2TFm/kMCFCp5qCa+Wi4
 7vy6ukFNzUnk9ugvzve2RdKE2yjy3A==
X-Authority-Analysis: v=2.4 cv=ePceTXp1 c=1 sm=1 tr=0 ts=68e4f21b cx=c_pps
 a=g/fcdA0ru3Q2I7SmDoHu6A==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=RWc_ulEos4gA:10 a=HH5vDtPzAAAA:8
 a=VwQbUJbxAAAA:8 a=EWWzKEDAAAAA:8 a=svB7xblkGpHZEmFDwr4A:9 a=QEXdDO2ut3YA:10
 a=QM_-zKB-Ew0MsOlNKMB5:22 a=8ZwbcxVZO41N_bDMix7v:22 a=poXaRoVlC6wW9_mwW8W4:22
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-Spam-Reason: safe

On 07/10/2025 09:39, Denis Arefev wrote:
> The __component_match_add function may assign the 'matchptr' pointer
> the value ERR_PTR(-ENOMEM), which will subsequently be dereferenced.
>
> The call stack leading to the error looks like this: 
>
> hda_component_manager_init
> |-> component_match_add
>     |-> component_match_add_release
>         |-> __component_match_add ( ... ,**matchptr, ... )
>             |-> *matchptr = ERR_PTR(-ENOMEM);       // assign 
> |-> component_master_add_with_match( ...  match)
>     |-> component_match_realloc(match, match->num); // dereference
>
> Add IS_ERR() check to prevent the crash.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.          
>
> Fixes: fd895a74dc1d ("ALSA: hda: realtek: Move hda_component implementation to module")
> Cc: stable@vger.kernel.org
> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> ---
>  sound/hda/codecs/side-codecs/hda_component.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/sound/hda/codecs/side-codecs/hda_component.c b/sound/hda/codecs/side-codecs/hda_component.c
> index 71860e2d6377..84ddbab660e3 100644
> --- a/sound/hda/codecs/side-codecs/hda_component.c
> +++ b/sound/hda/codecs/side-codecs/hda_component.c
> @@ -181,6 +181,8 @@ int hda_component_manager_init(struct hda_codec *cdc,
>  		sm->match_str = match_str;
>  		sm->index = i;
>  		component_match_add(dev, &match, hda_comp_match_dev_name, sm);
> +		if (IS_ERR(match))
> +			return PTR_ERR(match);

Would be good to print something to log an error, since otherwise this fails silently.

Thanks,

Stefan

>  	}
>  
>  	ret = component_master_add_with_match(dev, ops, match);

