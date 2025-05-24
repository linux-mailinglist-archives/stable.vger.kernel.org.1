Return-Path: <stable+bounces-146234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5041AC2E98
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 11:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9DF2A218CA
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 09:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F732150997;
	Sat, 24 May 2025 09:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="BavrSbXp";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="UeUPjcfW"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABD01388;
	Sat, 24 May 2025 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748079180; cv=fail; b=qVmGx9h4/r+dMMZB1/uFSqHzqwoxmx0CM0wRkvGOJsF2sRpSnu8RuSub767UysDHIaCuwSU7X8jyhid9xUblTlBjiP3lUMRXhpnne51sIl5WecZqwdiuQuXIEJoYRQJNYMiFlQpuDYdFAUl3Zj5/neh31tcMJ4tRoyIa9gBpwJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748079180; c=relaxed/simple;
	bh=+AvtbK77rrBTix6ZlKbp/tTk3fBqrD+V8LU0MUWavVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AcNnhJfZop0m4gXfMD8xzqzkQQNGp0swcOF9/MXDJ5ognLjOBRs+hooHpSRwUrUf9AP8Mhjj47x+t2T3fmOv5sFfduMLe3XarvgVErzAUtzQe+3pSmG20UP5DeMb23ndCeWIhismZ/TpWIuh4XrADnVk7nNbzAfmjMbnckXViBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=BavrSbXp; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=UeUPjcfW; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54O8hxAx004213;
	Sat, 24 May 2025 04:32:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=JXx2ecszHE6Px7MYTFLBeK5jHVn/MkxTH/UU600/d20=; b=
	BavrSbXpvCOz/bBS7a/xej89dskLwPWKO1Q0llDHB9hozo7L0pHRvn2NA2m3Cucr
	0JBrIIwx+HTkhButi3/xDJoaK25TPsBtjjlT5ZcdD7JSuoEQadSnCVLABIDWdonK
	N7ieRfO+RgLgPthIu/VuANZlinCpvfECfkP+sypBbQmFgc79fnbIbv4Dc7SPXdlR
	dklk/JAj2dY9a7X2b1d8PYS41OlRm+tmxvkrCWirFnL++KunG3dUuPwbuj01KBP6
	DQVHOuOnZ8yWJZEqYUYmoEsTcUDQgpsheYZmG4V6QepMgF+KjjSUrs4HuAl3k2RJ
	U1aIi4ADQeC+weHPE9kd2Q==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 46uahgr1tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 May 2025 04:32:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HP8mp1/9T/iMEW/cZLPxRnWXYkw5/H+Bmy1a6v85QT5bdKPXqMwdbrqWPGa4S+awHz6BzT2ZTT+l2tbe6w6ErJlfYy7xy/HiUhGMSgK77EsDB1iFfAH20lG6sRGlBmGOP5Vt1OYKsZFmSjhnwbF8gl+o5cJxotgpAJvxQOz+0zg3P/4Z3fLHb5Eg4hnoRV1heYXYq4/9NTLnwFmbOwZMXawCzvHlJbdNqlMLKjyxIIOSIqKMCMj4laiyrT5LWxN6mIcfJ3JGXArMCdsF2xQNuQ/UdY8qws13VfSSvaCi1E1+TowyIjlUoCGOMix+JLoodkUEvPrLklPCxHlmjMe1KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXx2ecszHE6Px7MYTFLBeK5jHVn/MkxTH/UU600/d20=;
 b=AC3I6P4VL5vv5S3ndAIJgftvzy+H4Dj1GQ05G/Yg/qZ6m6IiIG9dLlD8I1e7vgp4jA2TRJA58wRfEQHm6hqtlAcsfwsGC6AteSnZ7rHup/Y/W6Urr0QIVmYomKsl8KBkMuKNZKRBo4iMhcAYiBWz3uKpt5ak3H9GGPXYcDIJiZ9vpd4lgMPmJXLBcYE1N299I9RUviPB2Ob8Z+X8Y8IamhbaDjyOQau5d583mNvNUl35qnkZ+8IicLxOzTtWLOxYHlV9EhAsQL1PGic6GqxtgWG7vlbuQZ7SIMfrfDcXKR+o3Mgc0T/QcB6kSrWPpZ+fj6ujLnWjSwXabtZ3MZ4Ndw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXx2ecszHE6Px7MYTFLBeK5jHVn/MkxTH/UU600/d20=;
 b=UeUPjcfW0k4ZJgWPk+yBcsJbaXyfq7Rlw02V+lAZKGLcTjdKVqKk7jbHL0OBnETe8z+QuAQDgo8gS4uvEh10/h44m3Jrs0aNayb5LWXwfKvqKST0+94Rs+PgJtX+SjhfS/h+RXPk91i+7we+jXVSfjUzx/gi4RX7a6jGyaNSm6g=
Received: from BN8PR03CA0027.namprd03.prod.outlook.com (2603:10b6:408:94::40)
 by SJ2PR19MB8066.namprd19.prod.outlook.com (2603:10b6:a03:545::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Sat, 24 May
 2025 09:32:42 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:94:cafe::ea) by BN8PR03CA0027.outlook.office365.com
 (2603:10b6:408:94::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Sat,
 24 May 2025 09:32:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18
 via Frontend Transport; Sat, 24 May 2025 09:32:40 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 30C2D406545;
	Sat, 24 May 2025 09:32:39 +0000 (UTC)
Received: from [198.90.194.24] (EDIN4L06LR3.ad.cirrus.com [198.90.194.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id AB294820258;
	Sat, 24 May 2025 09:32:37 +0000 (UTC)
Message-ID: <fc8a3209-6565-4b3d-81b4-238194f9a979@opensource.cirrus.com>
Date: Sat, 24 May 2025 10:32:37 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: cs_dsp: Fix OOB memory read access in KUnit
 test (ctl cache)
To: Jaroslav Kysela <perex@perex.cz>,
        Linux Sound ML <linux-sound@vger.kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com, stable@vger.kernel.org
References: <20250523154151.1252585-1-perex@perex.cz>
Content-Language: en-US
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20250523154151.1252585-1-perex@perex.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|SJ2PR19MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: ce2114cd-39a4-4d3c-8ecc-08dd9aa5ede2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dk55K29sN3M0Z043UVlqR0VwNURibnUvV2taK0hXRTdRblpKZDJ0MHUvcDJx?=
 =?utf-8?B?L2NRSkpvR012NDIyTjdUT01wMkw0bXFWbzNrK1ZrUXo3MU8waFBpVGFNY042?=
 =?utf-8?B?cFdmblQ2Y0hyTWZTb01TL0p2UmtsTCtnNnpDK2dzd1VTTzd6RVkwNGFJMU5B?=
 =?utf-8?B?Tkl2d1VCcWsxckJFeEcrM1lRTFhBUTJMejVpWTVWMkx2T2UwV3RVdlQrQVRy?=
 =?utf-8?B?MkNQc1NIZDFIblNCVlFWZzdlb2xxM2UzQnVDZ1h6dEZDK2pQMkJBTDdVZ3lF?=
 =?utf-8?B?NFVuR2RBdmNkcklOYk5POEc1dWYyUlZ2YjJGVnFHU2dyRmpXU1FtL0kzeGNG?=
 =?utf-8?B?N0U5VEdmNHBrWTlYc1Y4YzRMTmZqcFRnQmg0OHp1V0tRR0Z1aEZBdzZzZVVC?=
 =?utf-8?B?eEVVYUg0WmJVK0VQQXZ3WnpJMEtoY2RNUHdqZmZuenJjU3M5SjIrTmtOdEFy?=
 =?utf-8?B?S0VIL1E5R3IzMThrWTZMWUNONzh1dVF1c1JMVlVXME43dzBUaUtGVFJWQzlr?=
 =?utf-8?B?TXRubGZza3gwYkk4U1NWNENVNVZkdzJIR01scm1Xdy9aSmdzU0pwdHRSV2Rz?=
 =?utf-8?B?S29wNGtVbFp3L1F6M1VZZFYwVmMwOG5TOVNQaVUyd0hqYUx1ODlicytETG5l?=
 =?utf-8?B?TlhqNXRxY2x0dzhOZGE5U2hiMHhkOXFaV1JyMFNQck9oL1Z2eTVraGRBd3pF?=
 =?utf-8?B?QzFNdGlMQ2R2TTJPeG9PUTVBcXhlZUpyV3l4K253YXRXaGdvdmJ3OWlyQ1Fa?=
 =?utf-8?B?U0labUV2NCsxaG5rU05Ucm03blk1Ylc5c2ZtL3FCazh6QVVIT1lHWDJvWXhD?=
 =?utf-8?B?aVlVam5BM0VvQVI4R0tMbEFqUlF0dWtDa2tQTUxnZmR3UnBoSWE0RnlJVGEy?=
 =?utf-8?B?OHZhL1NlR2gzRlR0ZlhqM0p4TVowc3kwV3NYYmQ3ZHhUZGFCTUU5TmtyK1lU?=
 =?utf-8?B?Qkczdk02bnZQYXNYeEU4VEE3UnBxaXJvVlY0di9CWVg5c3pCc24vaHd4WkVj?=
 =?utf-8?B?TmMvNXhFVWt0MnRUbGl4cWNtWTNOdlJlSENkaEdYR0lsWWxiK2gycXBHZmlX?=
 =?utf-8?B?U3AvdEVyUHJVY1FsWFFrVEZheS92TWx6UVhLNWtqT3c4UnRCb3VieXVsNnFC?=
 =?utf-8?B?YUJRVm5seW41eVlrYjEvalA1U01vdXpTYVV0WDV3NkxRMlRtNTR1NXB2OC9q?=
 =?utf-8?B?R2hGZ2VJekRHNTJOZ3FIRGtsWWp3bm9xRkVTM3lQTUNCOFdwRmZWT0R3c2lX?=
 =?utf-8?B?Q1AzWC9HTnJxKzA2L2w4UWp3a29WWTNaVjNJZ2NDNkZWbHh4dDB3SDVueWY0?=
 =?utf-8?B?QlA1MjRoalRLK2ZDaFh5RkNuVm0yUXBFaXl6UXczdGdvK2RrTGdHKzRTWWs2?=
 =?utf-8?B?QnlHOTY0ZDNRaGFQWnUrcU8rSXBrSjB6dktpVS9udEpDb1l0U01Sd0VIZG1x?=
 =?utf-8?B?L3Z0K3YxNFhGMTQwUlEyb1FIUGFndGhHalB0b296azRDb0d2OHp6aHBiNGlp?=
 =?utf-8?B?c2szaWcyS3JrdHhkbWdEaDZmbnF0cUFYMm1UTC9mS01tSWZOc0lJem45Ymk2?=
 =?utf-8?B?eDZlUjVjWmVBWnoxYmJQQjI1ZXRBUkRrcWFqckxlTFVKdUtHbFVSWjJwK3do?=
 =?utf-8?B?bXYyQXB2QWc1elNBbHlFa25xVkdEblhvUXZUWS9uYmcxcVBTeUdJZkJ6QVlH?=
 =?utf-8?B?VjYyNFZkUGxUYjhsRkRia3FRZndSYTdqdkR0NEVUVTI3ckF0U29DaDRwb3Zp?=
 =?utf-8?B?OFAzSFdIYXgzVy9saU1NNm1mQzd3TzlpbHh6UHIxYnBHZ2xMU0xnbW5xZS95?=
 =?utf-8?B?aFVqNGtQNGc2d1BmUnhqRmZydzRtZmt5WUhNZjAzNXNDSVNRWnByTU9DcmM3?=
 =?utf-8?B?UmpaemRJZWp3MWJVQ0JyNlNER0xGVStUaUFMd1FBelZUVkxoeEE4RTlET2l1?=
 =?utf-8?B?Ulhnbm1EMW53WW1JeHJqQUEwSXRoNzlZN3U2UHNKZWRnSmhqT1RYaFZVSCsx?=
 =?utf-8?B?VVJsUmI4ZHN4UUdmR2prOHlRM01zK0VyWmF3NDE3Sjl6VUFabjlRWVkzTlpH?=
 =?utf-8?Q?9Q9ILz?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2025 09:32:40.5725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2114cd-39a4-4d3c-8ecc-08dd9aa5ede2
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR19MB8066
X-Authority-Analysis: v=2.4 cv=S6PZwJsP c=1 sm=1 tr=0 ts=6831923f cx=c_pps a=joO5rFOndlhnht97C4Lqsw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=VwQbUJbxAAAA:8 a=3nJZFv5X7GhaF3MQJIIA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: 06-_1Z6CGGTuTF7PMKJJIoXQqlxEGaog
X-Proofpoint-ORIG-GUID: 06-_1Z6CGGTuTF7PMKJJIoXQqlxEGaog
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI0MDA4NiBTYWx0ZWRfXys/qI7815cfn IZyAXaJg1d+Ug7xa3i/5oRApxtRbg7ZL5XWtgx+pVVWnSRNehE/GRa79QbqWKKuYQ6QLvko26mG SHZSYY4fu9jS6n9TfMCKJtNLZNBDBcvvrhRxiM8dU5j1BxobhSfnxjJf13iIHXPuYu0wd2vrZF6
 TM2iXkfw732b8hXr7S2EzmyygfwZKdX93a6TxjTBduhRdON792Kc7TFcmCp/nTBLL3eMW7pfJeP ecsBUWJAuAkD0gLkYFQ4VWgKVsKQuZnQa7OhGeeVmkDwSVJwl1S6AKQ3G/if2n8f5Uica9u3uPs SdVN5LEdkIKQ0F34j9lBj+FUeTS6ILTRMglw3p3J6M7yCbivqP/HzN1Ae/v1onLnxtp6XDOQnA3
 8FL1AGqMqDKFiMsNontQWxjWz/SUM9nFqMpgHJtw2L41rmbfn4dgzagw1TTp4821KCq0fYZf
X-Proofpoint-Spam-Reason: safe

On 23/5/25 16:41, Jaroslav Kysela wrote:
> KASAN reported out of bounds access - cs_dsp_ctl_cache_init_multiple_offsets().
> The code uses mock_coeff_template.length_bytes (4 bytes) for register value
> allocations. But later, this length is set to 8 bytes which causes
> test code failures.
> 
> As fix, just remove the lenght override, keeping the original value 4
> for all operations.
> 
> Cc: Simon Trimmer <simont@opensource.cirrus.com>
> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
> Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
> Cc: patches@opensource.cirrus.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Jaroslav Kysela <perex@perex.cz>

Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>

