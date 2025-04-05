Return-Path: <stable+bounces-128380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD29BA7C8CA
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 12:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22191896625
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 10:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C481CAA95;
	Sat,  5 Apr 2025 10:53:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0B21CD1F
	for <stable@vger.kernel.org>; Sat,  5 Apr 2025 10:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743850435; cv=fail; b=mWkNM5MinPqsoVdS260vxNCP+5qC3D//lmaFGgdfZWXL7Ra+lCA4aFkBvko9eHHNQTDgTJINgYfdLdopnf2WXQdKDFqeJ/X/inc+kU2uEeFk3ILgm0uCMviHfEBRXBTCBWxHDxw2ahwiyZlhOGiY5G5NkvBMHoGm1Qgqsz+EkJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743850435; c=relaxed/simple;
	bh=Fl/Ryl4MJEjGX7tS+MWIVXidU0ojsV8ocPvYIF6Cve8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mHJFOaHruQx+6Qhinbydb1R5N+9e0I2TA5kORhDDGre+EXGrsEkDe6Mcx9R2EzMsv0bnXnOs5JBard+1PtUmByOU7GCcEDY6fKThHtUS/wuQV3RnczR+EpUcRLHj/kJmZejF13m0mFahq1l+OvJv9iQJucCspKPmjxTg/E7eiZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 535Ao2xx029447;
	Sat, 5 Apr 2025 03:53:37 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45tyt484vm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Apr 2025 03:53:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ahy74L098k4ska0tkmoKhKv7TgIjT8Z5/GNWY69W+n+b3vP1piBS/rKCUSkBhptazG7ubNVl3oavUbORIaNH2fjU/Qc+q6jfjiFnxRR/ATrFyF8jI9nPtjlNsMhWDOYe84AtBU7m6q1If9nhZ+COVxL3vT43qRH7IUpJzbTqZum7lHhjODsKajn11vob+DwHwQp2foda2hHftXnHNR8QYdw8q6pkUZSgDJt8vGO46J0vF1LAejj8cttItgVZWq5BUGGT+HYoVG1aqx/YnidD5mj6g0veceJ4XYeUf47Y3iL7e7f+7rHlflMRNktxLWT4u1JKTagQdMsDOi6luZmbaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bl113L6tSLBqSQ1utQRZkkjVmMaGmQpHx0MXWbzhX9U=;
 b=yVVn5UoB7BowhOZ7kwc4Yo6GFd0kJCoSGjuEmm20qSoAyAFEim3g8HYYSuPgmlVckAXcXC5kQon6NRB27YEqbRfrgJ2DeAksbHZDRXQ2nm+mBSpee4u+6wDErOa2wXIt/2+Rt3ZZfyLlexUMCvB7zzi/yi7FGlNw70RIEo2CLuFpTaio1xX5f6PwPGCc/Gff8fJbLcZIz9zz0kpZFy1n6kcHCNNjcD117SRZsjsZDd+pF13X0h7OSahzoUn4+Kdln6m24+ProsU5uxOCNf4bdoTdylw0yXF1TRotu+6M2WqdhAu1tKUYey0wALM8lwFpXPCEiS8Ba9bSv8Px5Z9/8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 by PH7PR11MB7498.namprd11.prod.outlook.com (2603:10b6:510:276::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Sat, 5 Apr
 2025 10:53:32 +0000
Received: from SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538]) by SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538%5]) with mapi id 15.20.8606.028; Sat, 5 Apr 2025
 10:53:32 +0000
Message-ID: <cafab90b-5ea6-49cc-a541-18424a8ebf29@windriver.com>
Date: Sat, 5 Apr 2025 18:51:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y] cifs: Fix UAF in cifs_demultiplex_thread()
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <20250404091209-7cbec81837c3adf2@stable.kernel.org>
From: He Zhe <zhe.he@windriver.com>
Content-Language: en-US
In-Reply-To: <20250404091209-7cbec81837c3adf2@stable.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0063.jpnprd01.prod.outlook.com
 (2603:1096:405:2::27) To SA3PR11MB7527.namprd11.prod.outlook.com
 (2603:10b6:806:314::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7527:EE_|PH7PR11MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: 97cf2c5d-bc2b-4e25-9d05-08dd74301b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTBFMTc5eGNkWWlJNkZFYllhQ3ZVbUdCWUdxNWVvREx0dDIvaVFKYjRQZHdk?=
 =?utf-8?B?ZjlITjdKQzZmU1hSS1JMQ0ZzcUhiNXpnUE5SQ0FreGcyZ3dvVm1xSzRWMVNS?=
 =?utf-8?B?NktWcGxmRE1jMW9zbWFyeEtLSHpHRklmUnBialg3OXdmQUd5SjFKWDNWakRu?=
 =?utf-8?B?S1pBT2ppa2FMQlZpRnFWeHhDaTRvQW10RTk4VHhZTzNKeGZLeE1sbysvT2lP?=
 =?utf-8?B?ODA3OFgxU21udEtwUVpXa1hWSlNYZ1lGL0F5VHg0Q0FSamZuVzdvSXRZcExw?=
 =?utf-8?B?OFhRU25DWXRKWTRldVNROEhBN1NIUS92VVoyQkFZWDBnU3BsOEFuL3ZxSk1P?=
 =?utf-8?B?RXl6YUFjS1VJWnRTYXJ1SlB3OStMRVlxVUtQVmcxK0lEb0pSM1kxVnR0bER2?=
 =?utf-8?B?b29VRnd1MHBtaHZBMzdwRlhlL3lVR3NuQllLVFgrLzZ1Uldva0RMcERVajlu?=
 =?utf-8?B?U2tYSnN2ZFA0TDd1YTV3eitwZGdydy9Cb3d2UTk2Qkh5Mm13UTVLTjBtdDN3?=
 =?utf-8?B?WlltalEwOVJ5QUpEN25WUTVXK1NhR2JSWDMzODVKRTBvdGJUOWIrOFlFRmo5?=
 =?utf-8?B?NzcxZUFLaU5aMk9KLzRJbkVVZXFqdnkyc0NzS2lRakM4TWlCK1dObVFhM0Nl?=
 =?utf-8?B?dW1haEFFWmhGRlJTMnNZb2VxUWNzSmMvSmFtRjhrYzA0aUhMRXF5RzBwNmFR?=
 =?utf-8?B?MTl4cm1laFFjSm5PZURjVkpkVEdOWDlYdlpiYWpBb3MxM1k0ZHZtNW5iaG9B?=
 =?utf-8?B?c1NWdVpBQmRZSVpTcHMyc2o1SHZPS2U5VExNK0EwZWJlbEVVYWdVeTNmS2d4?=
 =?utf-8?B?RDBlc2NYZGNFdnJ1NnQrRnlyVG9sWHpsbVpsK2JCazVaMjEzQnJTNEhWNzRk?=
 =?utf-8?B?Tjd6UmZ1Q2crZzlWdTNFR1BSSWdPblhSZnV3WHdWdVliTmZIdEZ3a3VMTG5Q?=
 =?utf-8?B?K0hWaWtYb01YbGt5TFU2azhTVkZ5Y0U4ZE05UjdUa2pqeG9ZY0ZCRDFZY0w0?=
 =?utf-8?B?cDVIZmk3eVBVUkVOcGJxWmh0UG1ibVgvdVQxMlZ0eCtpeU9ibjB2Ni9jS1Fh?=
 =?utf-8?B?VXY1VGQwV1JVSGhtcXQwZzM2YWt5NjNiMThxTXdnQyt2WlNxWGFPYTM1UFRV?=
 =?utf-8?B?NWZtaFhTY1Q5Z0Z4RGFwd3pVSlJnWmtGR2ZYN2d3cFE3L0oxMGZka2Q1ZUw4?=
 =?utf-8?B?UVAxdmZiSmkwb2NWUVY5ZCtia1JEK1VZL25JejhjbGh4RTBuV3dVUVhtQ1dU?=
 =?utf-8?B?NmpRN243a2xuK3BuMGM2WDh5blhMblEzYXcyZzlodGk5RGsrWTVzTEdEZDRZ?=
 =?utf-8?B?NTY5QmU2bisxTnJUdEgrQis4ajdBcXZWZ3l4QzB0b0c2Q1Y3d0I0Z1R0dVh6?=
 =?utf-8?B?YUZhay8xdVBtRG9EYTBZR2ErM1pMQWNmdDNjK2p2djd3dkNBZk5pYk5saG00?=
 =?utf-8?B?RnhDaVV1MitGTWJxTTBCazRwbHFqcVpKSC9NNm50dDhvNFdzYm1OU1prY3BV?=
 =?utf-8?B?ZjJ2RUdXRlFlY1NxK0t2d0RWRDRlRFVPNVpORkpoUnh4dUhSUDlnNWRta3E3?=
 =?utf-8?B?L1lGMStISzZMNkNLVi9tZnF0QU5PT2NVMnpMejJ1LzVNbitWNzdyRis1bzBP?=
 =?utf-8?B?N1d2aURYZW1kUUJKT1FteGtSU25pdXBKVy84V2drMTBITTNTUGxVNWFSVmJF?=
 =?utf-8?B?YjlYaUZyMTQ1bEcySEUyOHVmN1BsL2Z2eEZUY3o2TWVMK2dWZjBSZ20xTWw4?=
 =?utf-8?B?ejJhOHFzOU56QlVEZ1dzS0JYVUZWZUFTS2hiTFB6VnFjWVJacXB0cXBSSEdh?=
 =?utf-8?B?TERBYTVWaFFKSXpqS0tJbVJqakJMQ2ZCbEtsS1JPQ1BVZFdmamZhb0JQZnNo?=
 =?utf-8?Q?FPRfzJpaSf2Ks?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGVTaEwyWlZRbmp4d2Z5ZjdJem5lZEpxN2xlQ1IyckV6dlFzZXkyUGRLZWlV?=
 =?utf-8?B?VG1hRkNZSEE3SlBKMW9uNk1ZQUl3cEc2blFsWU9NQkFtdHZQdHVWU042MDkr?=
 =?utf-8?B?TW15QndsbkZzOGhGM3c3cDA0T0EreGN0blVTYitiZXV0bEpMa0JuZTlwNFVo?=
 =?utf-8?B?QklwRUxyVC9ZcWVCa2pZZmZNOUF6bHFKd0w0djQ1R2JNK3cyYmIzZnJsc29K?=
 =?utf-8?B?MFU4SWRQczFBNkZ5UzRKT1l4aGlGWTNpS1hKR3F5TkFidlIyKzdPT0V1N0J6?=
 =?utf-8?B?SEU5enBqSUhjOForU2MwNm92SnNQZlJtczRGTG5ycDV3Rnk3KzFka09mRE45?=
 =?utf-8?B?TmNySnpXbTk4QXNLTUdvV01vdWszRUZBRXFTbUVsZGM3SC9yWG5rWTRhazg4?=
 =?utf-8?B?a3VubElBV0hCSmtnSmNPNlBUVXZ5WHU3VFl3ZGcwWVhrOTVoY3N5WGJQRmJv?=
 =?utf-8?B?OVpHR1Z6WWRTVXZmTmNtS2FkUHlKTG5RcVJ6S0FKcCtIRGFheDQrVjFQWEJE?=
 =?utf-8?B?aWwrVFZGTW9oa05zV3BKY29rTGlaVDg4bThiTkM5K3Z6RUNuUTlNSzB0S1dT?=
 =?utf-8?B?VldTdmVwK2R1VXNPRncvSHh6TEFrUjAvQlBRWHRCaHpaUnQ4TFl3UklNZ3R0?=
 =?utf-8?B?VUVLNHg3cXRURmpqUm5rc2p0cDNsR1lLMEVlbTVOWEdWRHpmYkQ3QUowOThF?=
 =?utf-8?B?empHMXNtbzlHdUMrQzBGUnpQalBtaUNSbFZyaFVtbTY0anNuUytvMkcza3M2?=
 =?utf-8?B?MUZDeVVyaXdpbE9Iek1vblJoOVF0Q3V4SVYwUGxXTjdtSVNwblN5TGszYTJ0?=
 =?utf-8?B?YnBFMTZnQ0c1OTUyc1lBZzdsblRWNXZUL09oSUxJTW9hUUhYckpyT1pLTjl4?=
 =?utf-8?B?cTNkWVdISnNpSkdPUUtLeVB2WnZ2VE5sOStMWHhQTm82aUlsNTdZanF2eU5Z?=
 =?utf-8?B?d2cyTUZvMGhCNjhpWk5RWGdDWGpZcERUdjdzVm9mWE9oaXVJUE12QmZjMWhJ?=
 =?utf-8?B?MDV6THg3TnlDTU9ZYnVJc1cyNlhXV3hzaEN0NUNTcTdCbmwrclo2L0ZTMmhP?=
 =?utf-8?B?M0xWVlBmQjlFb1hJOTNWZks3R2NEaHUxVnprWEdNb0M3V0hnVjVic3IwdVRQ?=
 =?utf-8?B?YmhYTnNGSFRHOTJCNDQ3U3dtbkhhcnpobXRhbUtlbkhVajVRL05UWEtmZ3VJ?=
 =?utf-8?B?Mks1WlNreTUzSlpxUGM1dW51bUpnTW9qd084QURYVTc0OG5xWWRxcWJYcGwy?=
 =?utf-8?B?RzZWSUJyYXNBd2h2WlNaRTUrU282aDd0MmtJT2pZOWkwUzlkR3o0WTV3TnRM?=
 =?utf-8?B?cnRYTUxPeGEvc1lRZVpjdjZ5Sjh2QWlmUkl3aUIxeExsQkJLRGJvRy9QT0pW?=
 =?utf-8?B?Ti96VUtzb05KNXM2akJvS2FVZVNNUUdQRmtwN2VLRXdNbU1Ea2NoeVlPdFNH?=
 =?utf-8?B?dE1UT2ZMQzh4akphK3pOWWV1Tm9xckJuZSszTDlhbVdLdFNQVXUxczZJdy9R?=
 =?utf-8?B?VzFjd2lEd0RqZzl1ZjB2cGtpb2NGUENrU3dWWjVEd0ZuS3VoWk1kVlpibE1Y?=
 =?utf-8?B?ZFVnc25Tb2dQNncrQ1ZYWkV3TEdLK2FJcTZmcUltaXZkMDNNZ0t3cTRHMVRH?=
 =?utf-8?B?S0pyb25rU2dVb25aVVRHcEFsbWZuTDgzRHFyak1hQmtsRmV1WU9yT0xKL1NZ?=
 =?utf-8?B?eC96K2xpQmpUQW1taXo0Ukxvc2ZDUXlKNmNaaUJaWVE5ZjN2OGZsWUFSUjRN?=
 =?utf-8?B?R1JySWFTeEMrcXYrRjFONkpacWlPS3hpQVhJNTlRYnFSekNQTlZXM3JnZnNs?=
 =?utf-8?B?ZXRtWHVjMU5CM1pTWGNNUTlNUGdiaVZpSWp0NXJza3ZVLzU2dEpqNjdrSi80?=
 =?utf-8?B?SUIzK3pzQW8wdnExVXBLZFFUOStKOUtiNFN4R09SVytJVnFTZTRrd0FMQmg3?=
 =?utf-8?B?WlpaM3pFSkhuSFlJWkV1TlVEZmZOUm1MYU9qYmhuQjJNYXhBaWw4MWQ5Mi9K?=
 =?utf-8?B?RUZCaUhyYUJRaUFXemJQd2F1emhOVks0bEpqUmM5cm85b1NBelR5STFVUEg1?=
 =?utf-8?B?M3M2dzBGeUlzdHJ5ejBycFQ5MElzRTBPWjZDTWpLb0l6OGJCSkFrdVVqM3Bi?=
 =?utf-8?Q?74tnIZo6RgVaZaHYZ5XLiIBHc?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cf2c5d-bc2b-4e25-9d05-08dd74301b55
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2025 10:53:32.4830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aX/BlCPDhhKMNF2owTvLxDfppozQcB+0IOUpyjeBtIW2/n2mr62cdlZHH2m5tYJPSu/WAXrZ2CrTDhoYsOfwCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7498
X-Proofpoint-ORIG-GUID: BS85R-tI1c2q9SfxGXOcPKiCTNrPqOrk
X-Authority-Analysis: v=2.4 cv=RMSzH5i+ c=1 sm=1 tr=0 ts=67f10bb1 cx=c_pps a=ZuQraZtzrhlqXEa35WAx3g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=t7CeM3EgAAAA:8 a=i0EeH86SAAAA:8 a=Li1AiuEPAAAA:8 a=yMhMjlubAAAA:8 a=0M6rq6bXaxXcKWKOPtMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22 a=qGKPP_lnpMOaqR3bcYHU:22
X-Proofpoint-GUID: BS85R-tI1c2q9SfxGXOcPKiCTNrPqOrk
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-05_05,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1011
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504050065



On 2025/4/5 10:34, Sasha Levin wrote:
> [ Sasha's backport helper bot ]
>
> Hi,
>
> ✅ All tests passed successfully. No issues detected.
> No action required from the submitter.
>
> The upstream commit SHA1 provided is correct: d527f51331cace562393a8038d870b3e9916686f
>
> WARNING: Author mismatch between patch and upstream commit:
> Backport author: He Zhe<zhe.he@windriver.com>
> Commit author: Zhang Xiaoxu<zhangxiaoxu5@huawei.com>
>
> Status in newer kernel trees:
> 6.14.y | Present (exact SHA1)
> 6.13.y | Present (exact SHA1)
> 6.12.y | Present (exact SHA1)
> 6.6.y | Present (exact SHA1)
> 6.1.y | Present (different SHA1: 908b3b5e97d2)
> 5.15.y | Not found

Patch for 5.15.y sent.

Zhe

>
> Note: The patch differs from the upstream commit:
> ---
> 1:  d527f51331cac ! 1:  1ae677929ec5e cifs: Fix UAF in cifs_demultiplex_thread()
>     @@ Metadata
>       ## Commit message ##
>          cifs: Fix UAF in cifs_demultiplex_thread()
>      
>     +    commit d527f51331cace562393a8038d870b3e9916686f upstream.
>     +
>          There is a UAF when xfstests on cifs:
>      
>            BUG: KASAN: use-after-free in smb2_is_network_name_deleted+0x27/0x160
>     @@ Commit message
>          Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
>          Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
>          Signed-off-by: Steve French <stfrench@microsoft.com>
>     +    [fs/cifs was moved to fs/smb/client since
>     +    38c8a9a52082 ("smb: move client and server files to common directory fs/smb").
>     +    We apply the patch to fs/cifs with some minor context changes.]
>     +    Signed-off-by: He Zhe <zhe.he@windriver.com>
>     +    Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
>      
>     - ## fs/smb/client/cifsglob.h ##
>     -@@ fs/smb/client/cifsglob.h: static inline bool is_retryable_error(int error)
>     + ## fs/cifs/cifsglob.h ##
>     +@@ fs/cifs/cifsglob.h: static inline bool is_retryable_error(int error)
>       #define   MID_RETRY_NEEDED      8 /* session closed while this request out */
>       #define   MID_RESPONSE_MALFORMED 0x10
>       #define   MID_SHUTDOWN		 0x20
>     @@ fs/smb/client/cifsglob.h: static inline bool is_retryable_error(int error)
>       /* Flags */
>       #define   MID_WAIT_CANCELLED	 1 /* Cancelled while waiting for response */
>      
>     - ## fs/smb/client/transport.c ##
>     + ## fs/cifs/transport.c ##
>      @@
>       void
>       cifs_wake_up_task(struct mid_q_entry *mid)
>     @@ fs/smb/client/transport.c
>       	wake_up_process(mid->callback_data);
>       }
>       
>     -@@ fs/smb/client/transport.c: static void __release_mid(struct kref *refcount)
>     +@@ fs/cifs/transport.c: static void _cifs_mid_q_entry_release(struct kref *refcount)
>       	struct TCP_Server_Info *server = midEntry->server;
>       
>       	if (midEntry->resp_buf && (midEntry->mid_flags & MID_WAIT_CANCELLED) &&
>     @@ fs/smb/client/transport.c: static void __release_mid(struct kref *refcount)
>       	    server->ops->handle_cancelled_mid)
>       		server->ops->handle_cancelled_mid(midEntry, server);
>       
>     -@@ fs/smb/client/transport.c: wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *midQ)
>     +@@ fs/cifs/transport.c: wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *midQ)
>       	int error;
>       
>     - 	error = wait_event_state(server->response_q,
>     --				 midQ->mid_state != MID_REQUEST_SUBMITTED,
>     -+				 midQ->mid_state != MID_REQUEST_SUBMITTED &&
>     -+				 midQ->mid_state != MID_RESPONSE_RECEIVED,
>     - 				 (TASK_KILLABLE|TASK_FREEZABLE_UNSAFE));
>     + 	error = wait_event_freezekillable_unsafe(server->response_q,
>     +-				    midQ->mid_state != MID_REQUEST_SUBMITTED);
>     ++				    midQ->mid_state != MID_REQUEST_SUBMITTED &&
>     ++				    midQ->mid_state != MID_RESPONSE_RECEIVED);
>       	if (error < 0)
>       		return -ERESTARTSYS;
>     -@@ fs/smb/client/transport.c: cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info *server)
>       
>     - 	spin_lock(&server->mid_lock);
>     +@@ fs/cifs/transport.c: cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info *server)
>     + 
>     + 	spin_lock(&GlobalMid_Lock);
>       	switch (mid->mid_state) {
>      -	case MID_RESPONSE_RECEIVED:
>      +	case MID_RESPONSE_READY:
>     - 		spin_unlock(&server->mid_lock);
>     + 		spin_unlock(&GlobalMid_Lock);
>       		return rc;
>       	case MID_RETRY_NEEDED:
>     -@@ fs/smb/client/transport.c: cifs_compound_callback(struct mid_q_entry *mid)
>     +@@ fs/cifs/transport.c: cifs_compound_callback(struct mid_q_entry *mid)
>       	credits.instance = server->reconnect_instance;
>       
>       	add_credits(server, &credits, mid->optype);
>     @@ fs/smb/client/transport.c: cifs_compound_callback(struct mid_q_entry *mid)
>       }
>       
>       static void
>     -@@ fs/smb/client/transport.c: compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
>     +@@ fs/cifs/transport.c: compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
>       			send_cancel(server, &rqst[i], midQ[i]);
>     - 			spin_lock(&server->mid_lock);
>     + 			spin_lock(&GlobalMid_Lock);
>       			midQ[i]->mid_flags |= MID_WAIT_CANCELLED;
>      -			if (midQ[i]->mid_state == MID_REQUEST_SUBMITTED) {
>      +			if (midQ[i]->mid_state == MID_REQUEST_SUBMITTED ||
>     @@ fs/smb/client/transport.c: compound_send_recv(const unsigned int xid, struct cif
>       				midQ[i]->callback = cifs_cancelled_callback;
>       				cancelled_mid[i] = true;
>       				credits[i].value = 0;
>     -@@ fs/smb/client/transport.c: compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
>     +@@ fs/cifs/transport.c: compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
>       		}
>       
>       		if (!midQ[i]->resp_buf ||
>     @@ fs/smb/client/transport.c: compound_send_recv(const unsigned int xid, struct cif
>       			rc = -EIO;
>       			cifs_dbg(FYI, "Bad MID state?\n");
>       			goto out;
>     -@@ fs/smb/client/transport.c: SendReceive(const unsigned int xid, struct cifs_ses *ses,
>     +@@ fs/cifs/transport.c: SendReceive(const unsigned int xid, struct cifs_ses *ses,
>       	if (rc != 0) {
>       		send_cancel(server, &rqst, midQ);
>     - 		spin_lock(&server->mid_lock);
>     + 		spin_lock(&GlobalMid_Lock);
>      -		if (midQ->mid_state == MID_REQUEST_SUBMITTED) {
>      +		if (midQ->mid_state == MID_REQUEST_SUBMITTED ||
>      +		    midQ->mid_state == MID_RESPONSE_RECEIVED) {
>       			/* no longer considered to be "in-flight" */
>     - 			midQ->callback = release_mid;
>     - 			spin_unlock(&server->mid_lock);
>     -@@ fs/smb/client/transport.c: SendReceive(const unsigned int xid, struct cifs_ses *ses,
>     + 			midQ->callback = DeleteMidQEntry;
>     + 			spin_unlock(&GlobalMid_Lock);
>     +@@ fs/cifs/transport.c: SendReceive(const unsigned int xid, struct cifs_ses *ses,
>       	}
>       
>       	if (!midQ->resp_buf || !out_buf ||
>     @@ fs/smb/client/transport.c: SendReceive(const unsigned int xid, struct cifs_ses *
>       		rc = -EIO;
>       		cifs_server_dbg(VFS, "Bad MID state?\n");
>       		goto out;
>     -@@ fs/smb/client/transport.c: SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
>     +@@ fs/cifs/transport.c: SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
>       
>       	/* Wait for a reply - allow signals to interrupt. */
>       	rc = wait_event_interruptible(server->response_q,
>     @@ fs/smb/client/transport.c: SendReceiveBlockingLock(const unsigned int xid, struc
>       		 (server->tcpStatus != CifsNew)));
>       
>       	/* Were we interrupted by a signal ? */
>     - 	spin_lock(&server->srv_lock);
>       	if ((rc == -ERESTARTSYS) &&
>      -		(midQ->mid_state == MID_REQUEST_SUBMITTED) &&
>      +		(midQ->mid_state == MID_REQUEST_SUBMITTED ||
>      +		 midQ->mid_state == MID_RESPONSE_RECEIVED) &&
>       		((server->tcpStatus == CifsGood) ||
>       		 (server->tcpStatus == CifsNew))) {
>     - 		spin_unlock(&server->srv_lock);
>     -@@ fs/smb/client/transport.c: SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
>     + 
>     +@@ fs/cifs/transport.c: SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
>       		if (rc) {
>       			send_cancel(server, &rqst, midQ);
>     - 			spin_lock(&server->mid_lock);
>     + 			spin_lock(&GlobalMid_Lock);
>      -			if (midQ->mid_state == MID_REQUEST_SUBMITTED) {
>      +			if (midQ->mid_state == MID_REQUEST_SUBMITTED ||
>      +			    midQ->mid_state == MID_RESPONSE_RECEIVED) {
>       				/* no longer considered to be "in-flight" */
>     - 				midQ->callback = release_mid;
>     - 				spin_unlock(&server->mid_lock);
>     -@@ fs/smb/client/transport.c: SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
>     + 				midQ->callback = DeleteMidQEntry;
>     + 				spin_unlock(&GlobalMid_Lock);
>     +@@ fs/cifs/transport.c: SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
>       		return rc;
>       
>       	/* rcvd frame is ok */
> ---
>
> Results of testing on various branches:
>
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-5.10.y       |  Success    |  Success   |


