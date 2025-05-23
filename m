Return-Path: <stable+bounces-146208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B114FAC2744
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 18:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6363A17313C
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 16:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58769296157;
	Fri, 23 May 2025 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="StKUKkxv";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="k/6x4A6J"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E60B1A0BF3;
	Fri, 23 May 2025 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748016856; cv=fail; b=bYZ5NBM2Iy+wTxeOwF0a6kbUzUWaOrAYa9wtnAjy9uRMQGhSkadVKWMxO36uWMGXQ69x0ztZkMMKZcZ3mOeK8sqLYqi5L182znywndVDgEbILvlJVudhl+vlwXTmyURqU1+2HAWOr+vcC+sOUBNwV8zD0VWwOEmxhsZtLT4sXf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748016856; c=relaxed/simple;
	bh=jmnlHyOe+UC04bH6wSNAQ94M1BWpJiEhdBabE9ZHLhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZUZhtUUZEfvpZpFaFoXY40N9g6vlL6kBl6MRZ5NSv4GJG9tBbaKIjT58H4htj2WXH3c0bC8pHkJffGrj+iZNuLjqsxoDekI6PyDdW8wCTKshgBkCS7q+Vj00e4NFlOZ72C0GJToeYiD3bHdr47jlzMH45YqVDepUU2USX/c0R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=StKUKkxv; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=k/6x4A6J; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N5L6wK021949;
	Fri, 23 May 2025 11:13:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=IIR860i3GuMGwpQ8FZvD6fF/H0rkCYqPG1zMI2Z0FGs=; b=
	StKUKkxvGz5sZYCNKBGwCZZRbLqAxaLVc0M3oS0zZuh5sxbEmYxXUg9DJfomfD9a
	3vr+yiNNVcd8ABHHgnL+XptfxYAEP6crFtH0luP64lJZ7P1ipfZoD23WZfadXY/m
	BLfYHeaFXMU/0Jow+0rTkAfX0UAMrZIsIGWSnnT1o9mQlpoK+Wr92PZTE/dWxno2
	+uoxcPHWruxtplRWYHzitnwQp3hO8ANpmN68lk+HhTdAtokR40rlCOhZBMtLcBk0
	fUxeQaecTtBkzGJLG+dA4FcOOr/BiJIF+y7QVjG/XrooKMhtoNRm+12+f2LovRGJ
	O5CULEKsnFHYmzD7OYhYPQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 46rwfact2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 11:13:57 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXp3XVvwtAeNvuALYTw7qTkmE8/fQ7uZ08LE/2kf1uKMYIOQszbK03vD196NmlPSsBSy9JHvndh2Hl7uJHNxh/CXJTrAvOHaHdWGsiazD5f7OUE8ta18VgyWxShU4AZU+mIELxT8h1w6HTacXUDuMvTGMzdMSOEe/7RuukmlsFlyi3jyqL4UMhSLHEqLCuH/8kUb7RhsPNjPNBWSoihHnzrGtX6o2Yo65HFmyEUljW5JClqBwnHpK0vR45/ERAGZjvjHsco4X0WeZqoOGHIpTzeazxmvC7NEFTzPngDqwKPCZPmCHJFfpuSx2s4tyGqdaQwQVqZEg+kTOxZydaO/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIR860i3GuMGwpQ8FZvD6fF/H0rkCYqPG1zMI2Z0FGs=;
 b=pmFIm6zDgknchKqWZvx3ZJzYK2xed/oIPkqdZuY/8Vzx9VzJ1cLQvb3xK/MsI01H/bd4FEH1LFs99Zf7vm4ZUESDUb0K6WL3IirpKbyVz633IWRuB1kv/0ATtGKkIs+6e0Tlzjiiw9/9ZYZC50pl93x/meUMdHc8dsXzvJiEFvKjDfLeQ+++gBs5Fhe+zzVGOqSmi5Z9kf9/C+Hc7bHKQkmbhgjKVXg3ibWRmbv2ChZUauC3DDtvwNIKmVQ7byzTFh6/fcfoclDOJoiPAdNEwGz/AiYL8NwL3YDnIk74e+WpLGCNValu139ezrVRozL5cU9mGLGNvu+djI7sP9s46g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIR860i3GuMGwpQ8FZvD6fF/H0rkCYqPG1zMI2Z0FGs=;
 b=k/6x4A6JDJaBrK0lEklF6icVL33xtpjXSyYczY3lr7fZPJz8ABughHyvNjk9bWHtTpT+te4+ijUw8EYMwWeng1IKZ7/BREp6zh9/w0cwnbdSJ4DJCFuwtkPaN4m6NNKtDc3izPIfriprcyx6JnQZNf19ROotnnxOfqQeraWJ4sY=
Received: from DS7PR03CA0134.namprd03.prod.outlook.com (2603:10b6:5:3b4::19)
 by IA3PR19MB8708.namprd19.prod.outlook.com (2603:10b6:208:516::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.32; Fri, 23 May
 2025 16:13:53 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3b4:cafe::4b) by DS7PR03CA0134.outlook.office365.com
 (2603:10b6:5:3b4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Fri,
 23 May 2025 16:13:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18
 via Frontend Transport; Fri, 23 May 2025 16:13:52 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 15425406545;
	Fri, 23 May 2025 16:13:51 +0000 (UTC)
Received: from [198.61.68.186] (EDIN4L06LR3.ad.cirrus.com [198.61.68.186])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id B222B820249;
	Fri, 23 May 2025 16:13:50 +0000 (UTC)
Message-ID: <35b86ee4-036b-4996-86a5-1cc70645ab9c@opensource.cirrus.com>
Date: Fri, 23 May 2025 17:13:50 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: cs_dsp: Fix OOB memory read access in KUnit
 test (wmfw info)
To: Jaroslav Kysela <perex@perex.cz>,
        Linux Sound ML <linux-sound@vger.kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com, stable@vger.kernel.org
References: <20250523155814.1256762-1-perex@perex.cz>
Content-Language: en-US
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20250523155814.1256762-1-perex@perex.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|IA3PR19MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc9ce8b-bad4-41c6-e9d9-08dd9a14cf8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXUzVUdtZDErWDJrNFNzcU5rZGNLUk12VmFuRlpkLzhqSTdESEsyZUZpUmhs?=
 =?utf-8?B?R0ZlUUlSYVdrVSt4UjBsTTlpMkZrQTU1Y0FScHpXUGpDRjFKcVUrYTVlZytF?=
 =?utf-8?B?L2MvTXBBcm0yM3VmOFZMNmsvcE5Ia3NsMC9vRlhyd2wyUWcyVVdqUXJOS0Rl?=
 =?utf-8?B?NjJQOFBnOVh0U0wvZnRUM3djVk1SUzNiOVZGNjUyOE1UK2R4a1VWNkp0Rnp0?=
 =?utf-8?B?ancxcklUakxhWERSTGpqUXVTbE40ak5yWDc3RDRMaHdjTkdVRTVMc0x2OXFm?=
 =?utf-8?B?Tlh4YkJ1KzZpQk1nMU9JdHg3SE5ZaTRmVWxEakJjL2Z3clVUVXZYUGdaWWQx?=
 =?utf-8?B?K0t1VnhJd2drQlpMMmRnZ0VrU0NYMVVYeXp4OWtqZHdmc09sTzl3akN5V2ZH?=
 =?utf-8?B?b3JjdVRhekN5MVRaUU1QazdDampxdXpJbnJQa0NlZFUwQ24zWUlkdlBzbmcz?=
 =?utf-8?B?c1h4R0xITUpRVXc3QUt0eGprY0h2V2FWbU5wSHU2TUYveURXSFNNSDRpbVNk?=
 =?utf-8?B?TE43NzNxbUNOTUw4MEYyZ0FxQWN5WDlpMmhiRXVrdWdtbmZDbzJJb1FveCtL?=
 =?utf-8?B?WXNLL0t2NFp2UkxaRGVwTW9xeW5MejNjMEJNd1YrRGVZYmtJbmtKbDFqMUFj?=
 =?utf-8?B?Nmtkamh2NEhOSEFWNDh3bk52dWZ4elJibGtDNFp3ODBFbWdJWHp0bzUyYjB6?=
 =?utf-8?B?RGZwQWJVdVdoL3l3aDU1bzRjRVprWStqcDVqeTlTajF5bG0zdGJ4NDlqUnBI?=
 =?utf-8?B?bm5Ubm14ZzlrZ0NobER3VWV5SitWck9NZUx0V0J6R1Y0MG5Nb0lUNHFRRVZE?=
 =?utf-8?B?bXZLOWZEWDhIT2h4emxTUWVVKzhhRUtEWGM4TEQzQVNjMjhQRlpMdUVDd1Vq?=
 =?utf-8?B?ckNCc0YxbmlIUDc1dFJBWEVmY2Y2dXBsMmowUmhpZ2lnUVFtWkI2enEzS2NJ?=
 =?utf-8?B?dDRwSE0xOU1qM2wrWm5Vd1A0YjZrNkRNeTRER0IwUGp1MlZ1VVhXazd2UzVH?=
 =?utf-8?B?Y1IyVnl5R1FiVGlqMUNiQThBQkx6UFpLMXkrWDFaNWdtUDhYYXBPZEl6ME15?=
 =?utf-8?B?aTArc0JDcTZhWktsTXVJdDZoWG5rQ0NkS2N4NWZYVmk4eUxocU93TnhIa1R3?=
 =?utf-8?B?NUMrYklHR1lZUld0MlhsaDNXQ2lENTJpcFBZRHQ4dGZmVVhjZm42ajY0L3kv?=
 =?utf-8?B?dmcyWTR2dGM0OEZ6UzJrckJMaG9UR3llMFBibSs4Wm5sTGJPOUFWcStaRlJO?=
 =?utf-8?B?YVZoYXBHMXFyY0ZKS0NLK01DMC9IaGI4MXBoU0dzWlhrbHZZNnU3Tlo1eE5L?=
 =?utf-8?B?bk8yeXZUcGhmTkxvZUJGUFZsRGxjaFgxZ1h5Q3R0WFlUTVllOGZwZVpHRWdG?=
 =?utf-8?B?QUxYbU9XMENRTElYQzBWMEk1V0xOaDRZRTJZZ0xaYTIwVG1rcjEvMWFZQ3h2?=
 =?utf-8?B?YjBsUUpHYWR6OGZmRXdjU0ZvNzhjU0QvOXV1MEM5TDYyRDlGWnNJWHFpRHds?=
 =?utf-8?B?M09NQjl0M1Y1TWhxQllCekl6c0RlNk9hWiswMXdwbXhlMDhTMjdZdU9pbHZD?=
 =?utf-8?B?NU1GTE1PQkt3OGg3Ky9ZcGZKbWhkUmc2WWpGSVNZcU1nM1BoclVFNXl2SkVm?=
 =?utf-8?B?QzhkSnUwdllPbWd0UUV1U01mTktGOVVRcFBWUXFOMFgxeTNoS2R3MW5CMHpx?=
 =?utf-8?B?ZmpYa1BtYzZ2MEN0SzdQS1VFcjUyVGJKbHhNV0FaVmVidXFQM0hyUTlKL09U?=
 =?utf-8?B?eDdpcDNKWlQ0SjgvTm8vU0krcTkvNTF3OStLN0VwL0RmOCt4MVhvTzFNdkFT?=
 =?utf-8?B?dS9sR3BWY3g4RGRrUnVTTEsvU3lFMVNYNUlGbkUwMTgrWDZIMHIwc2F1TnBk?=
 =?utf-8?B?Qlc0dDRkMFdXMXlabGpIRVlGN1BoZ3cvTmNHMS81YWFXMnUzc0cyNmdFRUxY?=
 =?utf-8?B?dmIzM0kzYzNyNDgrU1lFTnVRT1c5d2JBeU9sN1pyT1hlY3JvRnJtTVFFL0lE?=
 =?utf-8?B?TDVFMUI0RXppZVFxa0pPZHlqYWwweGJDcE16L211bVBuWE1hNUZ0VVc5UVhV?=
 =?utf-8?Q?AM+Yc8?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 16:13:52.6019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc9ce8b-bad4-41c6-e9d9-08dd9a14cf8f
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR19MB8708
X-Proofpoint-GUID: a4usUBdMa_WTHWRZScXcQz6YxbIdrsls
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDE0NyBTYWx0ZWRfXwoBnrxfpahNz MSKefrwGCyPjGD+mCHfLUHOqb1JBlZlFowxW96llu25xrVJmf0qfSgVSCBuaydjrHbInmabKjuW t+msn0Q4PFdIn5UmkMG3BU0SX4dRCUOUc3DgnMipUcMocQyyYDtQhw2QGZQYP3kop5dPUhxX8TP
 +65QbX8upmqCTTugqP3RXPIYNAHZzqpx+0xkfG+g/BtccMGsldAWRKl6ZZTtgeCvZmgYfI8Kjqx +nW44gKeqHgBj+A/YGCXnoQUmwcBrKAnkm4OI8eXaIBYJjZe1nAbCRkmkfSrZ8tBW36MAShcanU krKzNxLuhzOYfouLs5SvTY3yO/RlIYHd9Hc1xYLVTASnw4Xlzx2iFRGDWhyj2y2H8hEQr2QRz/y
 7lK0Lkk0cmh4ZcaDbjv/XplXZ4hwAh5WwgIIK4n/iHq2XVj6KIfqaYcWilS/DCQ82Fyn6/o+
X-Proofpoint-ORIG-GUID: a4usUBdMa_WTHWRZScXcQz6YxbIdrsls
X-Authority-Analysis: v=2.4 cv=YsQPR5YX c=1 sm=1 tr=0 ts=68309ec5 cx=c_pps a=SXeWyiAXBtEG6vW+ku2Kqw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=VwQbUJbxAAAA:8 a=3nJZFv5X7GhaF3MQJIIA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Reason: safe

On 23/5/25 16:58, Jaroslav Kysela wrote:
> KASAN reported out of bounds access - cs_dsp_mock_wmfw_add_info(),
> because the source string length was rounded up to the allocation size.
> 
> Cc: Simon Trimmer <simont@opensource.cirrus.com>
> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
> Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
> Cc: patches@opensource.cirrus.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Jaroslav Kysela <perex@perex.cz>

Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>

