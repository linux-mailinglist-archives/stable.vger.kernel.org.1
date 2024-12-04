Return-Path: <stable+bounces-98198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4509E3120
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 03:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C170167E08
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 02:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C303422338;
	Wed,  4 Dec 2024 02:08:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B5251C4A
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 02:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733278087; cv=fail; b=W2kyYqcDuucGdA2z/DTI5LvGmG6bZPQrWU3Ui3rft7mOQYEtuC/w1wYipSZVWCBk3hkbPB7ryDOLmUM37e9XreWz8pICL1pYDgtf6WqLqbj9+oPrtolY6F8lSMkyI1ibI4bXd3OtmLHKC5IBy9JV1oqBvR2jgr1V6r/gATbZYZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733278087; c=relaxed/simple;
	bh=xtXaMw8kOlxIMImnEwLAiWtbPDdepEaOWRdZF1B0BsY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CqLPir839PxTZR2U8ELZEXDdgkkVVHwSD5cO6/ukYrZzQUVtTEu6KjWJ7q/ZCSVgyHmD5zD8WG+E/pYs5XhT96PlvIPou3lFVxL1sKdubJb/vS9JJQlMMIWrDMci9U0wNu6NkvRPsSOuz30tNypBCQsNcPcNHM5XTP/E1IIo84s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B410ToL032754;
	Tue, 3 Dec 2024 18:07:58 -0800
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43833q3up4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 18:07:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ayf4PXckWr+CtXj8WYQs2LrIF12F9WSSIUnsxUQEWFI9/qUDr7BLPK8jbYQrRrrVQicP9LHzCv5BO+yPn7h6kRXfWkpXxIXJ6ci5QGnXu7TNUy4QW/IfS1KJEj81BQd/xwatlOC/5vkjHCUjoziVbw65kU3z5ysyVEQioNv6pA7y+6ewJZmgVBCPhtgOPjomnpyBBXKOPeoB+Mhf9xLw/vghuk7E+xbVdBUfvEYk2jqPb1dVjSpFqir94vBg0LQSuPbYfFjooQt38txlosXCswjolynqOxhJq21rv9xIZChpw/m0uJH+j3XYPva8b3r00Wb41NfkxHod2cMwbOatRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8/CyutovMX8GvT7vd+MR/F/CDnZUZ42nctRo9dOOpw=;
 b=F/RDhk/zPwGSfVs7L4P1gSnUTlhhf2OLl/bhog8rUE07t+mvGC1GRx+PA4mg8rdzdV08vcSEzmqyv/wdHlTh4cD0jEro631fxLZ12tFeOffVIXCwGBkb8KgA+ykn4mBLJaSx8brCSRAdVbPzHIfjx1lKO6W8QLj3kdvY9P18Fq52nFjZYcVhLz6/HxzMO1SaAchXcOdjj4wmfdOpSYTU43dWq2SXdLlcP+oifqIy1Fj0hoHvMZ691BGn/mRXHOlA18SDPLgt6m39SYigBO26wYwFWR9yhTs1koNNmPy1FIy0tMsCHW8FN2YnPQa864twdcqkA9EhfHj7qzBqG3fL1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO1PR11MB5009.namprd11.prod.outlook.com (2603:10b6:303:9e::11)
 by PH8PR11MB7021.namprd11.prod.outlook.com (2603:10b6:510:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 02:07:52 +0000
Received: from CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::b03a:b02:c24e:b976]) by CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::b03a:b02:c24e:b976%6]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 02:07:52 +0000
Message-ID: <09b31a23-62df-4448-ba2a-fd09ebdd916f@windriver.com>
Date: Wed, 4 Dec 2024 10:07:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5.15] tty: n_gsm: Fix use-after-free in gsm_cleanup_mux
To: Greg KH <gregkh@linuxfoundation.org>, mingli.yu@eng.windriver.com
Cc: stable@vger.kernel.org, xialonglong@kylinos.cn
References: <20241128084730.430060-1-mingli.yu@eng.windriver.com>
 <2024120226-motion-dole-53a4@gregkh>
Content-Language: en-US
From: "Yu, Mingli" <mingli.yu@windriver.com>
In-Reply-To: <2024120226-motion-dole-53a4@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To CO1PR11MB5009.namprd11.prod.outlook.com
 (2603:10b6:303:9e::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5009:EE_|PH8PR11MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c814dc9-fd3e-459f-8ce1-08dd140875a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTd4ZVo2N2pUdUxJZGdKRHJ2TlpkbjlIcnZiMTVMbnM0U1p4YWxKNGlEL3lv?=
 =?utf-8?B?am5pSWxKcFF0SWtxVGpDaTZIRU5iYXVmZkt5N3JWSXFLTTZjR3NLYzRZRGtt?=
 =?utf-8?B?MG5yT1l1UC9DMjRJRjk3R29lZjA4YUVoNGpvMFdYRFpDaFo2U2dhU0hxcFk4?=
 =?utf-8?B?emZYZkFCdy9HQm9IeTBRcnlJVitxYmpnZ3V3OGZlMkhVcHgrWEI0YVpuMWh5?=
 =?utf-8?B?ak4wWG1RODh2RmlLWjE2VjVRQ0VDY0N2S3ZVRGNhenVwNGVrdllRbUM2UXQ3?=
 =?utf-8?B?ek9LeEg0b3VMdlZ6MGNYZHUyU1dVRmlCdW44bmRmQTIzN0ZQWk82QVBrTEds?=
 =?utf-8?B?T3Y3bks4Rk1DZk8zL0g0Sk4rd2d3M0ROeEpuSjhyS2pDMU9NTWkxNUg2bXF0?=
 =?utf-8?B?YkpqTXRpQ05uUWhCWmE2RHFvaUF5MzlsYy9mRmdoRCtVL296VitxME1hZVRL?=
 =?utf-8?B?WmFBdFB4TEk2VmRFZEJlZ3lHTTdrOXRnZTQ2enNSNlBzcndiRW5mUUUybndu?=
 =?utf-8?B?elh5bXZjSXR3aTJQb010V0g3QmtCT2JkVTFDY2lVckpyMGhBUUx6T3B0ZWtu?=
 =?utf-8?B?KzRiaHEreE1ZMVFFd216MTZoR1U3czVwNGFCQjh6UzhMR0JweGVEYmhaWGty?=
 =?utf-8?B?TWFaQ0czUFFDNEwvTU1TWUFnbS82V1M5WkNsdVJhTURUbjRuSVhnUlRSbHc2?=
 =?utf-8?B?ZEJWZjVFcVVubGh3ckRGVUhZRTZ4cm5mZStJbVA3bnl2cHZ6eEdoOXpzT0NX?=
 =?utf-8?B?UWxwbThldmxrTk1Ha2hvUEd5TmVFVU5lUkJlY2c5SEpOdlNHUFNvTkFOVC93?=
 =?utf-8?B?QW5tVEhpK1U2YmFkYUR6TnI1ZkxuUTVPV2IxQ2c2U2kxejg5N1JnNHV6LzJH?=
 =?utf-8?B?S3FMVWI0cHBBWmsyVWtxQkh0NGhoam51Y2hIdGk0V3Y3TFQxbmNXNW85TnI2?=
 =?utf-8?B?ZE45THplMEE1MmlJd2R4aEVwYjZaQUNnNlovaWtwMExQQ24rZVRFMk5aMWRz?=
 =?utf-8?B?bGJqRDA2eHBHZ3gzb3RsL2tJMDNhNHhjaXVhK2tHd0tzeHltMnErVEliQ1Vu?=
 =?utf-8?B?QjdLdkkwNnBFbmRMcXFEL1RFZUFISjdja1EwQmkvbUZWRWpEamlqc0kvQnJN?=
 =?utf-8?B?c0ZrNHNKSGo4T1ZEMUYyK3k0T00yN0FMRTR6VWpGMStOTitTdjFYditOeVB6?=
 =?utf-8?B?bU5maHgydld2dXdqa0EyUjZ6V3dNeXE4cGx6M2NibHhRUzFPZlJQU0RpUjFz?=
 =?utf-8?B?YW5qSENhYjZNWVdzVUx1RUlycWhua2FrWVhiOXk1OERVSm52eUxCK3pMSnl0?=
 =?utf-8?B?UVF1NjlmMG9xZlQ2bWZmMXdUdUZaVDhkWWJmcjBlMDR4SUl5bHFrNXhldjRw?=
 =?utf-8?B?aVI3VXZkKzdPdnhzTGwzR3Vsclkrc0RscUNyaW1GUkpvNzVuV3h0SUl3S3VJ?=
 =?utf-8?B?cHlYajlvSHl3NUJhSWhhRWRtektXWHAwQ1NGUERIZzNWR1VLRVd6YUhFRXJw?=
 =?utf-8?B?bk9oSTZCSmRPclhyVWFaRmZpc210OEp3UUlyOGpCeHdqcWd4YlpSaGd0OS8v?=
 =?utf-8?B?akRzM0hMa1p5SkFpVkpWUUNSRklPNmZUOFV3ZzQybkEyWHN5ZUwrZGJ2WTRY?=
 =?utf-8?B?cUlkQ3p4bWVTdDY2ZnlBOHBQcEZidGx0dlozYko2WkxOakdodzdpQUh6eHo3?=
 =?utf-8?B?aGIzV2NmNTE0OUZNd1haVWJPM1k2WWpwaEFiL2hRK2pmcVdrNit4VjZYTll2?=
 =?utf-8?B?UWZxTjVIQzJ6NGY4RHNMQVZhKzllVmpmQTVwcXJLby83a2g1L1pHMXFucy9K?=
 =?utf-8?Q?8XYBzPIWJSxWeoHnVhLsmQcxk0vf1Dqt/AKjk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5009.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MERrQ2ZYeVkrTW5aOWVHRDc5NlhYVEMxQjVzRHlrMDFFNlJwb1ptb2VLUnVO?=
 =?utf-8?B?QlQvOEZobnQ0bmVacHJYMStmUHp3Q2dlWUFabTZvbkVvZEJsNUpTZDRyZUxa?=
 =?utf-8?B?WmxldzRkNHhsQ2hLTTcrYkErRlhUaDJHVTRxS2dqbkdEemtKdFJlVXE4bGpr?=
 =?utf-8?B?NHdhUDZ4dGMvaUpLY1B5REZXRkZKdlRyOVptN2JGQVlGWDBqdzFpNlJacHVC?=
 =?utf-8?B?dVpWWlBvK2l0Y2lPYnh1RHhvN25TWFduV28rVkVLa2pTemtZS0pvZnNYMjVv?=
 =?utf-8?B?WWhFZGNuWGR4U1lMVFp1SlpCT0pzNUt3TFJ3bVZIQkN0U0JBMlRLV0wvQmt6?=
 =?utf-8?B?aUlQbU5TbUVzaWt0ZXBoUTAyZm5oUFpLKy94bWZMZ3dGZWJzYmFkSWlmMy9F?=
 =?utf-8?B?SDk2T2kwc1pMZkt6M1FOcnBNeFcwN3lEUE1HRXZIZHlTUmNIb29wejZlV1dG?=
 =?utf-8?B?NGRlTE5MZWFRQVpmcENnTStUakNKUm1ONE1hZFc2QXdHaGhqSHpwcC85bTQ4?=
 =?utf-8?B?MmhYam5abUVzcTEyaStmYzFGaUQyd1dhS1hzZkJzYlpKMXIrMk1kS0pWN2Zp?=
 =?utf-8?B?SXVreHZCSlgyRm9tWnN4dU01TmZ1bGQ5aXJQUEg0a2ljV3NWWTNSWCtTWHV0?=
 =?utf-8?B?YlpmaC9RQlZlUnJoZzFra2FOdGNTWWhkNFBIYmI3dmlPMGlQUVBMKzNNR0c5?=
 =?utf-8?B?am50QU9nODFJNHNJaWZpNGhkVFNRVXhVZ29VN3FuaDd4cUZjUHFLS1NZdENq?=
 =?utf-8?B?eGNvUDF1Z2lmUjlna3FyYmthWm5QeWVUZDR0NUZiZ29qREpxdkRON014bVoz?=
 =?utf-8?B?bWNQRFZSUDdoZDlTekoxUEtxK28xOXRoVEtZb0llRi9HM3VzNnZMYmlEelV4?=
 =?utf-8?B?UVh3c1hYUGpiK2Z0SFloeHZzbzZ6b3E3S0lvR3JINU54dGtENjJKYUtMbEtQ?=
 =?utf-8?B?NzJuRmJ0aXVUakpLbVk1SENvRXlkY3RYTUNPcU9XK2pqYjZNMU93ME1jUzFu?=
 =?utf-8?B?ZUFNYXJHSXU2eVlSK1VFaVFmbmsxMGpGbm1jRy83Q1V3eVZXZGl5ZGJiUktp?=
 =?utf-8?B?bVovS3NYYUdvMitkSE9uaFhEeURkS0R0bVc4c1ZVUUJ6SWl6cEpyMC8yb3RI?=
 =?utf-8?B?ZGVHeVFjdFJBOUdWbjM2V3E3UVRNaUNSUXVwK21aY0Rrc2hBZGFjQ1FCNy9M?=
 =?utf-8?B?engrai9xb2orelZocTJJYTdMMGNraXFwRkxwRWVjWGUvaGdRWHJQcEpZZDB4?=
 =?utf-8?B?Q05DL2k2cHdXQTZ2Z2I1V201MzVlN1V4U3FDemxwSE9sd2pTdW5pVGRZRWlv?=
 =?utf-8?B?MlJ0ZnlxaUlPbWgzeTRJdFdIS2RmTFlNWnQ2N3hNaFFUdGVBcnlqODN3VGE3?=
 =?utf-8?B?bWtxT0FabmJPcHhIcm1WK3pqY3VBem5LUzFRWFBDSC8yRHRsLzlpekh2RnpP?=
 =?utf-8?B?bU81NWplMEJBcG9wVitlSzZIRDZ1cE5ud2Rsall3M3RVVUpsbHEwYldoVUZv?=
 =?utf-8?B?OE91SmQxV1RvK3RjS3FHTHBKQnlkNGNJeG9PQjFjOEJXQ1lUZk95a3JaaDdy?=
 =?utf-8?B?T3BWWC9wcGM1SW9hMlFMaTRRelA5am80bFZDVHFBaTUrdEE0ZmxKZyt4aThP?=
 =?utf-8?B?b0tMSHFHa0FBa3Z3bG4yL09HSU1yQmsvUGltMjM3QUxWNGR4R3V4a2JsZE5J?=
 =?utf-8?B?YlJzRTBzUGo3K3ZjbnhWbi9iYUVSdnR0OFh3UkJVeWtUNk1FUGhhcUpOL1Bn?=
 =?utf-8?B?Y1JlUWhSRXhMYm4vUHBkUHpyTi9BTlFWUnhxYjRxa2RuMnRDbzdGeEpBZ3h0?=
 =?utf-8?B?K0V1YXJwaDJOTWUyZWNhdUd3RkRjdjFHL25Bdzg4S1ROSUo0RjRwNVNuYjdQ?=
 =?utf-8?B?aStlcnVzSWRmelA1SXRlc0ZUZmN5REVnRFZybEp1Mmh1TzNXVnRRcXJSMldI?=
 =?utf-8?B?c3pCR0FROGxrVFVVbDViL0NtSWpaUjk4NHI0ZGpjdStDZ3B1RGU3WWhkQlFs?=
 =?utf-8?B?SEpvV3BnSEk3T0c1Y0tEZHN1Z2RsZ0wwK2MydzlKcXREV0F2K0Y1REpLcGdw?=
 =?utf-8?B?eko1T3FhM1BjNE9XM2E4aW84NHFFcHNRMWF4UG56aTF0Ly9DRkVzMzdtN2NM?=
 =?utf-8?Q?OKqMZN/Y6Z/WW3q531ATXJUCl?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c814dc9-fd3e-459f-8ce1-08dd140875a3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5009.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 02:07:52.5202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ev2I3P6w159CsL8aCP10LfTMlK+f3Ym4Z6rGhYBFVn0zeBIFig3rpOHdweSsr6NQvzkTnM5SLuvUcaOHezOQJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7021
X-Proofpoint-ORIG-GUID: lw0HndAPIeQkMzblgxkOFqwDRmTFf8fh
X-Authority-Analysis: v=2.4 cv=bqq2BFai c=1 sm=1 tr=0 ts=674fb97d cx=c_pps a=IwUfk5KXFkOzJxXNjnChew==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10
 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=ag1SF4gXAAAA:8 a=2oQaogyIu41A3Kf1mX4A:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: lw0HndAPIeQkMzblgxkOFqwDRmTFf8fh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-03_13,2024-12-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 bulkscore=0 spamscore=0
 clxscore=1011 suspectscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.21.0-2411120000
 definitions=main-2412040017

Hi Greg,

Sorry for confusion!

Please use v2 instead as we correct the author in v2.

Thanks,
Mingli

On 12/2/24 17:36, Greg KH wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> On Thu, Nov 28, 2024 at 04:47:30PM +0800, mingli.yu@eng.windriver.com wrote:
>> From: Longlong Xia <xialonglong@kylinos.cn>
>>
>> commit 9462f4ca56e7d2430fdb6dcc8498244acbfc4489 upstream.
>>
>> BUG: KASAN: slab-use-after-free in gsm_cleanup_mux+0x77b/0x7b0
>> drivers/tty/n_gsm.c:3160 [n_gsm]
>> Read of size 8 at addr ffff88815fe99c00 by task poc/3379
>> CPU: 0 UID: 0 PID: 3379 Comm: poc Not tainted 6.11.0+ #56
>> Hardware name: VMware, Inc. VMware Virtual Platform/440BX
>> Desktop Reference Platform, BIOS 6.00 11/12/2020
>> Call Trace:
>>   <TASK>
>>   gsm_cleanup_mux+0x77b/0x7b0 drivers/tty/n_gsm.c:3160 [n_gsm]
>>   __pfx_gsm_cleanup_mux+0x10/0x10 drivers/tty/n_gsm.c:3124 [n_gsm]
>>   __pfx_sched_clock_cpu+0x10/0x10 kernel/sched/clock.c:389
>>   update_load_avg+0x1c1/0x27b0 kernel/sched/fair.c:4500
>>   __pfx_min_vruntime_cb_rotate+0x10/0x10 kernel/sched/fair.c:846
>>   __rb_insert_augmented+0x492/0xbf0 lib/rbtree.c:161
>>   gsmld_ioctl+0x395/0x1450 drivers/tty/n_gsm.c:3408 [n_gsm]
>>   _raw_spin_lock_irqsave+0x92/0xf0 arch/x86/include/asm/atomic.h:107
>>   __pfx_gsmld_ioctl+0x10/0x10 drivers/tty/n_gsm.c:3822 [n_gsm]
>>   ktime_get+0x5e/0x140 kernel/time/timekeeping.c:195
>>   ldsem_down_read+0x94/0x4e0 arch/x86/include/asm/atomic64_64.h:79
>>   __pfx_ldsem_down_read+0x10/0x10 drivers/tty/tty_ldsem.c:338
>>   __pfx_do_vfs_ioctl+0x10/0x10 fs/ioctl.c:805
>>   tty_ioctl+0x643/0x1100 drivers/tty/tty_io.c:2818
>>
>> Allocated by task 65:
>>   gsm_data_alloc.constprop.0+0x27/0x190 drivers/tty/n_gsm.c:926 [n_gsm]
>>   gsm_send+0x2c/0x580 drivers/tty/n_gsm.c:819 [n_gsm]
>>   gsm1_receive+0x547/0xad0 drivers/tty/n_gsm.c:3038 [n_gsm]
>>   gsmld_receive_buf+0x176/0x280 drivers/tty/n_gsm.c:3609 [n_gsm]
>>   tty_ldisc_receive_buf+0x101/0x1e0 drivers/tty/tty_buffer.c:391
>>   tty_port_default_receive_buf+0x61/0xa0 drivers/tty/tty_port.c:39
>>   flush_to_ldisc+0x1b0/0x750 drivers/tty/tty_buffer.c:445
>>   process_scheduled_works+0x2b0/0x10d0 kernel/workqueue.c:3229
>>   worker_thread+0x3dc/0x950 kernel/workqueue.c:3391
>>   kthread+0x2a3/0x370 kernel/kthread.c:389
>>   ret_from_fork+0x2d/0x70 arch/x86/kernel/process.c:147
>>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:257
>>
>> Freed by task 3367:
>>   kfree+0x126/0x420 mm/slub.c:4580
>>   gsm_cleanup_mux+0x36c/0x7b0 drivers/tty/n_gsm.c:3160 [n_gsm]
>>   gsmld_ioctl+0x395/0x1450 drivers/tty/n_gsm.c:3408 [n_gsm]
>>   tty_ioctl+0x643/0x1100 drivers/tty/tty_io.c:2818
>>
>> [Analysis]
>> gsm_msg on the tx_ctrl_list or tx_data_list of gsm_mux
>> can be freed by multi threads through ioctl,which leads
>> to the occurrence of uaf. Protect it by gsm tx lock.
>>
>> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
>> Cc: stable <stable@kernel.org>
>> Suggested-by: Jiri Slaby <jirislaby@kernel.org>
>> Link: https://lore.kernel.org/r/20240926130213.531959-1-xialonglong@kylinos.cn
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> [Mingli: Backport to fix CVE-2024-50073, no guard macro defined resolution]
>> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
>> ---
>>   drivers/tty/n_gsm.c | 4 ++++
>>   1 file changed, 4 insertions(+)
> 
> What differed from v1?
> 
> Please submit a v3 that says what has changed here.
> 
> thanks,
> 
> greg k-h

