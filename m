Return-Path: <stable+bounces-196886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E971C848FD
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 11:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB45A4E22EC
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 10:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A122E540C;
	Tue, 25 Nov 2025 10:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="kLv7Mx0Z";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="GWcl/eYK"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BED226E702
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 10:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764067776; cv=fail; b=JnL03ryCPV2KsOBf4BnpOMJQkxwLKBPuic7/PjSKnlRreTWIMpNd3mSb8vRfAqghmsaLtHe0PtrA4zgx4BN8KwDHZAvFCX0+U7+AMfmNF8fSDnfLJQDIbYZba0ZUyDPxd6kFfQbSk1vtpRjIwwGUJnW/snoqKOFxqnKTnEKl9Kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764067776; c=relaxed/simple;
	bh=sEjmuGhZ0AULix8YJE1BJdcH5NtpJj5N10YLukc1CXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjV3LIuzcWgwDq9OMs+hs8pBZp8SjWufza5UghTqE+/XqTaMoRq4WaaEi+HeaNh3dI3HFaULlQjsUqROrXWbG2LK9y4bggTvlYtoj7QfIVWCoGf6pQO8hhptaNbyYzIPFF/FSRs3TZfLm5oHnVR0q1MziBI4ZJi/IybIVaZwatI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=kLv7Mx0Z; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=GWcl/eYK; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP5jJFu3446921;
	Tue, 25 Nov 2025 04:49:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=O6VL9cXXBziLHvgxVTddr9yN5B0luUTWsAebFnACAgA=; b=
	kLv7Mx0Zc87bi+1y658BcDYnlPzzkcvmPVlaC8ZzTEWDf+inryNqT31cem3VPM8F
	5amkpvSpLqj1FOgWlfZCIjRDRzT6w3Y/qDsUCFL+gnw1Z/72YpX5MrCrM047XnoJ
	vErkU3k6gy3lw+ozGyOyPvs0DaNvLy2zcZcGow4+v6ON9cvhUQv5y96B6vX+0+bM
	O7kciwJUZiXiQHSVpeQ4p6Q59K7lWcEBH+7q+5c+jAQi//WAoyrlcCnOqvyBAtwm
	YzphZraBfIjwlVwv6AZOqEjit5+Uw/ckssiuzkb++wV8dvzjnbeS6ykKd9VxYmd9
	4T+QqWmMDFpM0ctXeKBynQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020075.outbound.protection.outlook.com [52.101.201.75])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4akbf1aupy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 04:49:30 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UD4vBBZc7j1bRyqwKmyMjtoVU/SW9XwLKrk7FEVNgVAqpyi2ta39RjjtS/xAbAGSazKkdteSxKQFTuDt9f/14rE3NSfdAJ4J/Hb1SXm+PsVtReb3SFDP01hmksCArydDdFej6Yb7eBcEU0Z2JBZYQWkkXyZHzBqcgFFOBWkI/lYiUqJ+blEIoUoJlhzweZy70Krjl6F0Xr4M3/e5JZ7ojZ71vhZCJatvvOd9uKHkS694ntiaMFCSyTFKiBvZuaq0pkmiZcA/UPfg+pWiHGkjJrr6Ir6jeR3kvt364UBSTIjb3Y3AvVz6SP5uW7IgUiDX8Gg03p+qIqg/WdJE7bPtnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6VL9cXXBziLHvgxVTddr9yN5B0luUTWsAebFnACAgA=;
 b=yr2HC5zTbpHDLEcQJJr880HP0kZLz6gDTDPjwvX91eC0Xd9Fk/vClWI8N8IcwK8JCbwcRo/u2mgaEJG0cr+s3qmCntNAzD3BUqEEmSgQgX3A6cxBKW6LnZPDcUayFFXYwxW4nyWCVwDQMh5BirUYHCABHEETM+RXeeZOL617/wrfFbtaWVz6ukCwndFouYaKRR/8FnYSwmtAfPIOsRtYMmBphMj//9g/TonXRoJpxQOPCcmDujqtYu7MIlOj8ns4LKpSd30qqQw/t9/o869Lm/xN9zx0x2JvBo2aQhL4BaPgkcCvLj2QvGb+9xQ17FuwTJSZAnZ0q+38WerjVCKJOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6VL9cXXBziLHvgxVTddr9yN5B0luUTWsAebFnACAgA=;
 b=GWcl/eYKWBsuSUl1rHHaz98SwdB8fXhMuNzGplXuobdzOABi/bFMGlirt0Keitb3PEQe94xXCTry4yBFYs/avCx44bSr9vIIKOg1Mro5CMWIM/dSQa86GGhoABdwg19XiyPPLpLkwN+++qhgRiWqPInVQMm+UBKhZeBkteU58kY=
Received: from BY3PR05CA0026.namprd05.prod.outlook.com (2603:10b6:a03:254::31)
 by CO6PR19MB5339.namprd19.prod.outlook.com (2603:10b6:303:136::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 10:49:27 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::eb) by BY3PR05CA0026.outlook.office365.com
 (2603:10b6:a03:254::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.4 via Frontend Transport; Tue,
 25 Nov 2025 10:49:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.7
 via Frontend Transport; Tue, 25 Nov 2025 10:49:25 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 93A4D406540;
	Tue, 25 Nov 2025 10:49:24 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 7151682024D;
	Tue, 25 Nov 2025 10:49:24 +0000 (UTC)
Date: Tue, 25 Nov 2025 10:49:19 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: stable@vger.kernel.org, linus.walleij@linaro.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH] Revert "gpio: swnode: don't use the swnode's name as the
 key for GPIO lookup"
Message-ID: <aSWJr6yyOqo/TJ/D@opensource.cirrus.com>
References: <20251125102924.3612459-1-ckeepax@opensource.cirrus.com>
 <CAMRc=MfoycdnEFXU3yDUp4eJwDfkChNhXDQ-aoyoBcLxw_tmpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfoycdnEFXU3yDUp4eJwDfkChNhXDQ-aoyoBcLxw_tmpQ@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|CO6PR19MB5339:EE_
X-MS-Office365-Filtering-Correlation-Id: 551453aa-e14d-4e5f-d098-08de2c104d63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzdEUnhsK3RySzVpVmViY21weUYwLzNGM2Fzc3BRc3g0YlNGaFFHc2hSZmgy?=
 =?utf-8?B?bzloUncwSThlOEo4bCtiU2FyTkhZTmcyVkZHQzNrNkdrY3dOWnlCNy9OWnd2?=
 =?utf-8?B?aTZZM1ExSXh4K0ZXaVpvT2tjYXE5UWEyVTMyN0doZXVGSzg1S2U2amw4Ukl1?=
 =?utf-8?B?aUd6N0l1TlRjQm0yVkZSSkNIZERNa0paV0grdW4rcUczdGwzZitmNWhMSEZU?=
 =?utf-8?B?Nmo1aXlWcE5yd2tVb0dNOWx5ZmtOem1SQjRwdy80c0h5eVRTMzFWWW5KVnpE?=
 =?utf-8?B?aVlCaHlRYmk0OUZCa0hhZkZabVdhR2JhY1V4WWRXLzdTWnhmTHdsODVBeHFk?=
 =?utf-8?B?MmpPK2E1MmV2YXVWQW1TWjltOTJMUldqUWhLa0RGMlF1Zy9FZzBnOUNFZGxh?=
 =?utf-8?B?WEFlMlhCY2NWUTFxYzc5eUVwY3NFNjRoS0cvWGVlaHB2SWd6UzM2YUdHRzE2?=
 =?utf-8?B?WVNFSEd0QWY1VDg0aEpEeUgyNmoxOXlMRTZNa2NCMUlXVnl6TjhEbkp6emlF?=
 =?utf-8?B?UjNtTUhPLy9IdXZZVFBtaUJYZUZtbkQ3Y3VPbUV2UzhRd3A0dE1EYURmc0Yw?=
 =?utf-8?B?Mmc3OXRHRTBJaTN0ZkEvbitSNkRLNTVqaFN1RXpiUEsrbVZOZktBT29pTi84?=
 =?utf-8?B?UEhvc0NneDJUcHAybFo5dEE3MVR2Ri8wNlo0NmJNamxRdkk3aksxZk1vUnMr?=
 =?utf-8?B?MENEaXpBRzVSUDA4Vy9mbEtQU3RJZGphL3pXckRUZEZjTkp6TGJrdThha1FC?=
 =?utf-8?B?d3FQWEdTUG1jcHJiQm9vM0xzTnFudkhscHRENk1HbjVaL1gzQzREOVp0Wi9j?=
 =?utf-8?B?cDNXMW9TaldjeDVNdHZXOUVnRVorVmpUeDFwTzRmUGUzcjVhUTVVaWVVZUNT?=
 =?utf-8?B?bE02QkNWZWVEUldiZ2IwWm80WTQ0bGJwN3UzWkgrbTBseTlRMUhuUVBvNC9z?=
 =?utf-8?B?VWVObUY3TEg1YjVBbzdTelhCbkdPSDJTSjByN09UZ0dNdzlDMEcySGhFRWNC?=
 =?utf-8?B?eTA3RnJTNzIwdGRNRmxZTjQvNzhFYWJBSi9nSlBYNkRGdjFlRUZ2eE1OL0lL?=
 =?utf-8?B?VkVSTTB3RUE1cm5jdGZQZmhNb21aZDF6TVNOektLS2MzWEdOczJIc2V3YVFC?=
 =?utf-8?B?d1EvZTRHelNsdjhMT01kdG1TQkdHWDRUY2NhbzVLQjNjaG42VHRyVjRDWEtT?=
 =?utf-8?B?UG1ieEUxWVJtTHAwZWk2Q252UUg4VG1LVDhadjltdnpHcGtjbzVBVXEvWi9x?=
 =?utf-8?B?TFYvUjFPVmxlNXJad2duc1VpbEc5Y3FZQ2k5MlBRQU1qTk9mSVdpbU9vRGVM?=
 =?utf-8?B?cCtzWjRiM1JENkNzQ0lPcmsxenh4Zm5MTWd5R1lWMExMNXJ3cmFENHY4OVY5?=
 =?utf-8?B?VDZQMHlFS3NkRGJCK1cwOHdUbkNJMnJRenVYVGpRanlLbFlhQmpDTnpIU016?=
 =?utf-8?B?dEl0VVJWU1ZIZnBtYjBQVENVVDFYMFVHN1NnaCtIK2x3MHNWaXhNUmRSSGNo?=
 =?utf-8?B?VDlLTncvZkNqQzFWMzRxWTY5NUJ4Zi9ha2huTkVuS2tCdDJhUW9EMThOS2dK?=
 =?utf-8?B?K2RGTmxvUCt2aFNxN3FVQWptc1A2dU5WTktVNmUycWRUcUhFNTAzcFQzNjZ3?=
 =?utf-8?B?andJUnV0b1ErODY0S05wRHpiTEsrZldOa0lVSUp4TWZKVWlVZDNCQjBhQzJv?=
 =?utf-8?B?am1xcDJ5Rm5FNm9FWlpUSlk5VFA1aVRqRkI4LzVZNC8wL1hwZm5nUkxOcllm?=
 =?utf-8?B?Z3JGNVBFSE12UktQZ2dKV2kvdm9ZU3RlODgwTlRHbTVEb0JZREpHMTlxZ1Rv?=
 =?utf-8?B?Sk00dFQ2UGZIWGxoTldCODBMTWdTM1M2dHlNb3UwbW9XaWRHVFNIaFNSRGRL?=
 =?utf-8?B?eXQzMnZUNk1WUmk0VEhXejRPSm5CbGpEVVQ3b0o3eFo4QWx0TzNmTG1mQnh2?=
 =?utf-8?B?NkZ5VDlrK1M1VWVzbG5KMDlqMTlVcG9tdmQ1cHlHNUFCRkIyS3ZNT0FNbFVy?=
 =?utf-8?B?TVA4Tld1clJvMWNaa2kvVVFNNVRydDdYak91UTg3Yko1aCtTdmg5Z2J3b2tD?=
 =?utf-8?B?M09GZVhBL09ySlU5S3RrWit4OE9PWW5Wb0VFSU1WdVFVcWRxbW5hOWFHR2ZM?=
 =?utf-8?Q?GLsg=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 10:49:25.9361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 551453aa-e14d-4e5f-d098-08de2c104d63
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR19MB5339
X-Authority-Analysis: v=2.4 cv=caHfb3DM c=1 sm=1 tr=0 ts=692589ba cx=c_pps
 a=/ctSrlGya8zL8n0rCWN75g==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=O_mYIUxG9PxvoMOS:21 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=NEAV23lmAAAA:8
 a=w1d2syhTAAAA:8 a=ZpcvAQtDhH_j2lcs398A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA4OSBTYWx0ZWRfX4n/onQDGQ5VO
 lm21tyDSJ5AAzrgiFXn3I0h0b2r04WyxDLOx3IhQ47f7LzJ5uXbZdqPzbcihbdOLe+TZoOrWOo/
 moFcdFEC/HXVeYFjZ88P4mLgbPk/HL/IYs9qNxfcjG9eOkJH4/wj6SXB9FHdyK/T/kU/if4v1tA
 MxSnPoV13Tt8P8NqCy2dkrEN1tKFFnsSJUCHywia6bPe85IruuZx29QfzgIJd6eTcTy3QEUrVqS
 4HCz3S2LgKmSpOzjtQpccqAVIOO7It+rrSL00RKSebCSevGHw6474IRGRqHgdd9Clwc2P4+Qxgc
 BUAiFxapobRRGXwHZHT8km7yF9mKLJM2Wg4WHAYkCvowFAjONBgs7i2PdMtk/B/4+BbZeFBVzcc
 q49zXnh5JnDReKZKCbylhwXlN19rSA==
X-Proofpoint-GUID: 1-1byN16AMlycWZbTuuwGBoNH9YdUSAg
X-Proofpoint-ORIG-GUID: 1-1byN16AMlycWZbTuuwGBoNH9YdUSAg
X-Proofpoint-Spam-Reason: safe

On Tue, Nov 25, 2025 at 11:31:56AM +0100, Bartosz Golaszewski wrote:
> On Tue, Nov 25, 2025 at 11:29 AM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> >
> > This reverts commit 25decf0469d4c91d90aa2e28d996aed276bfc622.
> >
> > This software node change doesn't actually fix any current issues
> > with the kernel, it is an improvement to the lookup process rather
> > than fixing a live bug. It also causes a couple of regressions with
> > shipping laptops, which relied on the label based lookup.
> >
> > There is a fix for the regressions in mainline, the first 5 patches
> > of [1]. However, those patches are fairly substantial changes and
> > given the patch causing the regression doesn't actually fix a bug
> > it seems better to just revert it in stable.
> >
> > CC: stable@vger.kernel.org # 6.12, 6.17
> > Link: https://lore.kernel.org/linux-sound/20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org/ [1]
> > Closes: https://github.com/thesofproject/linux/issues/5599
> > Closes: https://github.com/thesofproject/linux/issues/5603
> > Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> >
> > I wasn't exactly sure of the proceedure for reverting a patch that was
> > cherry-picked to stable, so apologies if I have made any mistakes here
> > but happy to update if necessary.
> >
> 
> Yes, I'd like to stress the fact that this MUST NOT be reverted in
> mainline, only in v6.12 and v6.17 stable branches.

Indeed yes, apologies if that wasn't clear.

Thanks,
Charles

