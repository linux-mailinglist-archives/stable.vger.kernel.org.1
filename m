Return-Path: <stable+bounces-196897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E022C85059
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 13:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D3D49350167
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 12:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141C431C56A;
	Tue, 25 Nov 2025 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="bqvyOfJN";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="mtfwrj5b"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9A0320A3E
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764075016; cv=fail; b=RFGEq0weGrmRaBSdjS6MD4h+Yp02N9zOJyimRPmwP1BNj9zJgbq3sAq1xV3+vxe6IaMeMvBK2XtBUqzTzfvKQGBHjuN90p8J9g+eFeYXEaJZFghTGMDo7lIm3O9gbDKmcSKDQMEhW1t8pwnVKdXq08OwmnSzBl5A8r/g3uhME+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764075016; c=relaxed/simple;
	bh=mPd6Q8w9BUYYRXmyDlWbt/1pfAhNaZ6Buq8apu6cw6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHcqe5/2sqlokrmcomkQxswMHhLi54oP9U1013VrskjZOrBM1ju7hN7NMJu3j2v9vQNx++9woY8AxQTtft/YsL7eSEfbBIAZ4UMwAAIrobR7BeO485oikzrEeThSM25LXm/w8HjmB1waQMQkik+0PSxuQJ+vKPjbOI8VK/EwTJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=bqvyOfJN; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=mtfwrj5b; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP7n7Hw3968388;
	Tue, 25 Nov 2025 06:50:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=ysULdfjesrqXHJwO+G75lF8ljIYQGTf873APHlBTqRI=; b=
	bqvyOfJNTn7VBv2EpCs+mrxA3wqhyQjJ9rC6zsnDHVr01lVq08e+8ok+BV4ytahn
	v2CN7DG5wNiOSuVWdgR0hRipIaWvtqK4WAXAtUcv07QiMXmXOzxvT2Wd25je2uA+
	XX6GFC6nSTdBISkplau1jlDMtL9nNfj87yHVtyOS9b3f+W4aHINf4Vg+bRBozL2p
	FdswthbA+LheSKC52OIvEKuqhqZjbeqZmXKkqbOyfpwD6dsupnXShL+hqY5LEVMk
	PctLqcsFsWB+eABL8HTyOtdobR3VLgAj+cpSu6LfChglWwJkqmSRtQ+tHerP1dg5
	yZXLTJVyIcvmOhNO8EwQjg==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020132.outbound.protection.outlook.com [52.101.201.132])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4akafkb030-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 06:50:11 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ShBQAhg2jhJdzfm5xFbN6acFam8HEi+bz2jD2w6FbJX/3qxWsIfYiwH0Tr+3np4K93Vzo8TiPgFZPbau6WBn+7EU57pgG7xvCx6VGcMFrFVNuQNlr6+Bw1/iBVVsfxnYND3Y176eqPCDUDdG85F8k8924p74shZ2t8nEl4rvG5WspLOlOpm6OESt+YGYOBM0O/mGu5N16QkP9vMa24xMn+AuS6iyuB4VWJjW54aZBrzcm6Y/2qVX4wz0ymBqR4fHfoFwnDL9m9F+fmhF+5jp0ZXtpRy1MMcJxxyBYWKYbKbKeMd++Dj50L17zU3HstJ0iEyikdYWvolO0fJDznd+DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysULdfjesrqXHJwO+G75lF8ljIYQGTf873APHlBTqRI=;
 b=ylhGWVQnLevxWpIVfgo16yWxYllOx3DvWl1n0UwD8m4zWrMgJB60JODBDvr7g7CMpHdEPTjodV7/VUAKyhAeqKASBlDL28xybQ9hOEpEV63DuoP+bjmKQaJSo2BqvQ5pTmMAmbexu5pmf27H9d432j6i//MwQbFRcC9jgI5QJm4eTHQcuDZBY3lPm15M09YMPnKHh4mliOyO5CfCBKAflyPyG0NY0Yfy+f5FzCHKfaRY+QOnhfV22ou6F0+AVJHwLuRMQBziM4V6cdtrJTEz642utzpFzof0GDDcJGFgP5M3nKkZ1BDNje20cWxCu7wbJciOGOmC9lq7St7A2ekjZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysULdfjesrqXHJwO+G75lF8ljIYQGTf873APHlBTqRI=;
 b=mtfwrj5bHM9uDpLJZH40GyFbiTYNm7Mhus1q2UGWtwex0xvDn2g7D5Q9RO4GhJ0fm4KY95r8vXStc/87LbvIr6089RsfsHFuG8lJMA2YfqMfF1fZZk73GqQLlYvsjF+2VHkPQHRW28cSgFXvC41CU88kj5ejJMZFWR2FRfEL7yw=
Received: from SJ0PR13CA0028.namprd13.prod.outlook.com (2603:10b6:a03:2c0::33)
 by SA1PR19MB8864.namprd19.prod.outlook.com (2603:10b6:806:469::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 12:50:06 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::88) by SJ0PR13CA0028.outlook.office365.com
 (2603:10b6:a03:2c0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.11 via Frontend Transport; Tue,
 25 Nov 2025 12:49:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.7
 via Frontend Transport; Tue, 25 Nov 2025 12:50:02 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id E9F7B406540;
	Tue, 25 Nov 2025 12:50:00 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id D247282024D;
	Tue, 25 Nov 2025 12:50:00 +0000 (UTC)
Date: Tue, 25 Nov 2025 12:49:59 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, stable@vger.kernel.org,
        linus.walleij@linaro.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] Revert "gpio: swnode: don't use the swnode's name as the
 key for GPIO lookup"
Message-ID: <aSWl95gPfnaaq1gR@opensource.cirrus.com>
References: <20251125102924.3612459-1-ckeepax@opensource.cirrus.com>
 <CAMRc=MfoycdnEFXU3yDUp4eJwDfkChNhXDQ-aoyoBcLxw_tmpQ@mail.gmail.com>
 <2025112531-glance-majorette-40b0@gregkh>
 <aSWXcml8rkX99MEy@opensource.cirrus.com>
 <2025112505-unlovable-crease-cfe2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025112505-unlovable-crease-cfe2@gregkh>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|SA1PR19MB8864:EE_
X-MS-Office365-Filtering-Correlation-Id: b63ffca1-3585-4792-92ee-08de2c2126df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|61400799027|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUJLRitGanNpRnNRRUJ2MUdHMHY0UUJHdjBVWm5Nam1oeEZFMGY4SlBsc0lo?=
 =?utf-8?B?OWJRaVZKNkt0aFNlN1EyS2dFWFZKUkxHS0FRM2NoV21vZit0OWRsT2VuNCtW?=
 =?utf-8?B?NUJEa28yTFFYZ3pITEtvSERnTHRvWE9iMDNjMUtVTkdZckdYaEg4dktaU1V6?=
 =?utf-8?B?QXExRFhBeEEvRGR6dStIR29JOWdoNnZWdE5KOGg2NDRiNkhuR3d5RE9OTWZr?=
 =?utf-8?B?RSttWnNTdWlXb05sLzlaWG9lMVBiMTJhQnQ0NjVJbGxLSDUvMGFJN2FUZjNx?=
 =?utf-8?B?UnZ0RjF2QjRZNkNKUXpkcE4rYkxlUTM1a0FqKzNSbXpScG9helJtWjN6dDd6?=
 =?utf-8?B?M2U4eTg5MkZlWHplSW5RUjdGdXI3STBtcVlnL3gzY3VPTk1oVmlrRDlrNlNj?=
 =?utf-8?B?MUtLTlNsdyt1dzhGT0pXTmw3YWZqNlNUTlhwUUtPZk91RGtMUXc4YldzMmhJ?=
 =?utf-8?B?amZrQjJQWE5HY3lsL1R3NlU5UTVJbFZSZTh1OTJrTmRLem5EQ2Jha1FmTE5N?=
 =?utf-8?B?SFFPTHJMWmNYVDY3UDBhQ1l3cEZVbmJMSFV0RzZiaVRrYWVIZTZpWUszc3Fp?=
 =?utf-8?B?TS9ZcCtWTUhXZThwS2hTVFQ4c0I1U1BqaWJ4WnVhNGpjTWk3bHJhbG1GUWNz?=
 =?utf-8?B?Y3pBbmtxbkVJTHFBVGtIUUN2c1dRMkhOWll5cDJOYnI3TUF6SUNVbGp3cTcv?=
 =?utf-8?B?WVhuMlYwU3hTK3g5R0RONGMxV1FrQlByRFRPck1mUS9LMkE5b2pxVkVvMVZG?=
 =?utf-8?B?RXpSeElUb25tcisvUjQ4S2ZFWHVrOEprcUp4MVU4b3JhTFFuMFBxQUk2ZW83?=
 =?utf-8?B?R3gyWFdhRGtBcG9RNkhZT3E5Q1dzUGN2OTlZK1B0U0JiTUNLYzhneFlyR2dS?=
 =?utf-8?B?WGZEcmMxQ3M0Qmo2M0VET1hLRy9KTUIwTm9oQU14WG9tbE93Mm4wZi9jOWt6?=
 =?utf-8?B?ckZBZjQ2amY2c21kc3lHZWRQZnhycVRHT2VYZXQyWElrdmNLUWp0WlZ3U3FS?=
 =?utf-8?B?N0RpMTIvb0djaUxSS3NIMnlES3BNN05CLzluY01iUUVObEdKWDBoS0orbFRh?=
 =?utf-8?B?SUozSStpNnQ5aVFHOTA1NW1SVTVXWVdrRUVwV0xNV3k3SVAxdDMrb0F6VXha?=
 =?utf-8?B?L3RuYXA5KzF5Mk5WT1lneFJsanBjSnV2Mkx6Rlpja0trZmJSVnFVOWs3TUtj?=
 =?utf-8?B?L0ZSVFVDZ3o4MlhTZjh4aWNyQWVVeGxVdXptSG56a0lGSkpUUzdML2FhSTl1?=
 =?utf-8?B?TFBZT3g3M1dpTGtlZzhZZWxDWGUxWGUrUVprSTNxSTd0Y1ZLaEo4Wllnb1hy?=
 =?utf-8?B?Mk9WRXJsTjduUnVEQXgwRytYZFBrRzNMT1hlMkRoOXFZM2lPeUZsYlpjWDR0?=
 =?utf-8?B?YXVHbGkrMDJHNWk1a3pjeFJrSG8zN0puMm1QVlA2andVb0NPVWt4eWhycVdy?=
 =?utf-8?B?Q3hPVjdJRm5tSk5UN01WTU95NmZZRTFwUEU0dDFTMEJrTSs1MDAralgxWVNY?=
 =?utf-8?B?VzlpcWMwUU45MTd3eENPenl0Y1R0emtqSXMxdUYrcjZRVVUyakZoWmhpcklF?=
 =?utf-8?B?ajFUU0NhTm9VUmxJbHViQ2d6ZHNkeElsamtlMzlpOXlhMytPZ0lhWXdlb0NQ?=
 =?utf-8?B?aG1tTVZnNkpwblNRZTZvMkhRUUFWU0JPcitXKzd3ajcybXc0NUJPUXUzNFZP?=
 =?utf-8?B?ai96WWpOZlJTZVBucCtlZVplNitBU2Y1eFVhZEtac0t0S2dMeUlMVElZWnNX?=
 =?utf-8?B?UVFQMXdsTFFLTHpCMU5oS3JSdkxwWjYyaFU4RVNiYXZkOUVpajkxODI4VFRy?=
 =?utf-8?B?K1BITEZYbU1yNUh4cnAyQjZyc2VaeWZ4a2E1ay9qSEtqV09CNzd5RnlyZkhK?=
 =?utf-8?B?NTVjRHlCbzZtWVJFWkZ6Qm1NUkk4TytwSzdtODBBOWVFUDZ0Umg3WldmSGNz?=
 =?utf-8?B?SVhzK2VPUlZ4NUJ0OUxiZDJIVXpNS0IxSGF3M0xEd0Y5dTJFL2loUUx1aEc3?=
 =?utf-8?B?YUJJaDk1RUpWZkpOZFlBRlFidFFmZERDOUV1YnhOckUzVU1CR1FySWFva1NQ?=
 =?utf-8?B?QzRUbkNsMDg3R3gzbVV0QWdYS0VmZHdmbmVIUnRRd1VOV2gzTTh1ZlZsQUNZ?=
 =?utf-8?Q?eWOM=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(61400799027)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 12:50:02.7599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b63ffca1-3585-4792-92ee-08de2c2126df
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB8864
X-Proofpoint-ORIG-GUID: 7oBdCfXRsM6WPhuHPOgod-kioUWD-zUb
X-Proofpoint-GUID: 7oBdCfXRsM6WPhuHPOgod-kioUWD-zUb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDEwNiBTYWx0ZWRfX9Q/BBjMy8erc
 ZoUIG8vEbGej6xjX+hTrwc009U8HolwuazFj2LlpDR0Wn3nssQtsdvrU0E/Va8BTs2sLM6vmrYw
 t7P6OLjylLxHJeN6Rvp9GTdvYpfmlwsd595HJznO4Ybgw7tqpVFG1lbEuNK3u3aITN8waR0AllC
 laIwFf50aIcAFRHSNU1iiGgIhbSkzLh6ali+rr6371k54p5IPgageSY01N7GKDnW5pHcYjZXT/B
 d318QlUg+H6tICaQcqtBr3AEE3YyFmVSoRT645hyK4iVheYVwQ2eMyunZ94Nf+wflVNZYhq9/v/
 40TFo38GNejyDSDav8ymsZzSvzUYAfEuw1wIf1LdvhGdbwwxfJMptBKV7Zxd5zlbBeZB6M+ZVw0
 2BLZlmlAD5DhfAWBcKvwkyyf6vrVhg==
X-Authority-Analysis: v=2.4 cv=Dacaa/tW c=1 sm=1 tr=0 ts=6925a603 cx=c_pps
 a=h0UhqkblQSf2I4YTj9MQng==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=O_mYIUxG9PxvoMOS:21 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10
 a=RWc_ulEos4gA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=NEAV23lmAAAA:8 a=w1d2syhTAAAA:8 a=MbKc_HIZFcpnzy5cQZYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Reason: safe

On Tue, Nov 25, 2025 at 12:58:30PM +0100, Greg KH wrote:
> On Tue, Nov 25, 2025 at 11:48:02AM +0000, Charles Keepax wrote:
> > On Tue, Nov 25, 2025 at 12:43:16PM +0100, Greg KH wrote:
> > > On Tue, Nov 25, 2025 at 11:31:56AM +0100, Bartosz Golaszewski wrote:
> > > > On Tue, Nov 25, 2025 at 11:29 AM Charles Keepax
> > > > <ckeepax@opensource.cirrus.com> wrote:
> > > > >
> > > > > This reverts commit 25decf0469d4c91d90aa2e28d996aed276bfc622.
> > > > >
> > > > > This software node change doesn't actually fix any current issues
> > > > > with the kernel, it is an improvement to the lookup process rather
> > > > > than fixing a live bug. It also causes a couple of regressions with
> > > > > shipping laptops, which relied on the label based lookup.
> > > > >
> > > > > There is a fix for the regressions in mainline, the first 5 patches
> > > > > of [1]. However, those patches are fairly substantial changes and
> > > > > given the patch causing the regression doesn't actually fix a bug
> > > > > it seems better to just revert it in stable.
> > > > >
> > > > > CC: stable@vger.kernel.org # 6.12, 6.17
> > > > > Link: https://lore.kernel.org/linux-sound/20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org/ [1]
> > > > > Closes: https://github.com/thesofproject/linux/issues/5599
> > > > > Closes: https://github.com/thesofproject/linux/issues/5603
> > > > > Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > > > ---
> > > > >
> > > > > I wasn't exactly sure of the proceedure for reverting a patch that was
> > > > > cherry-picked to stable, so apologies if I have made any mistakes here
> > > > > but happy to update if necessary.
> > > > >
> > > > 
> > > > Yes, I'd like to stress the fact that this MUST NOT be reverted in
> > > > mainline, only in v6.12 and v6.17 stable branches.
> > > 
> > > But why?  Why not take the upstream changes instead?  We would much
> > > rather do that as it reduces the divergance.  5 patches is trivial for
> > > us to take.
> > 
> > My thinking was that they are a bit invasive for backports, as
> > noted in the commit message. But if that is the preferred option
> > I can do a series with those instead?
> 
> I'd prefer to take what is upstream, it's simpler over the long term to
> do so.
> 

I really doubt this will end up simpler, as the comparison here
is a) not backporting a change that probably shouldn't have gone
to stable in the first place vs. b) backport a bunch of quite
invasive changes.

Do we have to wait for the fixes to hit Linus's tree before
pushing them to stable? As they are still in Philipp Zabel's
reset tree at the moment and I would quite like to stem the
rising tide of tickets I am getting about audio breaking on
peoples laptops as soon as possible.

Thanks,
Charles

