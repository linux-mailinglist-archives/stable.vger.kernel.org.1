Return-Path: <stable+bounces-146194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22770AC2258
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 14:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56BF4E2EF9
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 12:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401F2229B32;
	Fri, 23 May 2025 12:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="L0VC0c+4";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="DwijxNcK"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188302F3E;
	Fri, 23 May 2025 12:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748002143; cv=fail; b=ue0fo+okSDzipxH47YStZCsmfPoA3qknf+vW+PMcz98XMYRrDRtt/jkrKyPNezjYlTlixhD9m1miaBl0nXyfJFT2b6i643I+Gvoj2DthZ0VnM7MGYt7czIiWPXj0DKfTA2UEp7davW9tpvoBksCNf0kNqnnydFRm+ocvGnUU9sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748002143; c=relaxed/simple;
	bh=hkMjvkQWrn+gYaXte3phe1cCnGYl5JjBuKMk4T53QWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j06MUfRnc0DiY2wmBqs90VtPX7X8mtI1//c3W0q/c5kreMRqRpGPnNNAZncB26sxKLT3g9+Cb9NLShgflfRDLSen7cK07rUmO0+7T9ilfya0hjPbaHnQILjOEIIyvfB77r9wb7MQoc085SrdRvKK1TdLbnVcOo852az+DRqY62g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=L0VC0c+4; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=DwijxNcK; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N684Kb009422;
	Fri, 23 May 2025 07:08:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Lq2XMZv/D46E0/wD2mM2UH9+Gim/sa5yfLowCEU7OmY=; b=
	L0VC0c+4JHdguyE7oMmTf8SPE/M19uirqer6MWz3SAesfMYPrWxjDSod/x2nb5+q
	mmb+tvEqiR6DAJNQx4imR4c41g3vM2j7yIQPDp8SdsVmyMtCjEpJPcqL+odas/Yj
	4BL18pgAFSvNy/8Cx00mjmcZ3cwooPy2Sewy8OuBhnfiew5sfgt5WVdCsdTbi0c/
	A4Kn4bCJdugkwROzHbt65ZG5m41EFMlr2FFPoRb3nL977eWzIalqcJIwGxkn03GS
	II+oAmzn1w2xS3FWeH4FN+zYt4OiHiTqu5iy80bXVPBULYAWW9170cSFmfHMLGua
	+ZpPrpERcBhj+RaUm8/Hng==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2043.outbound.protection.outlook.com [104.47.57.43])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 46t2ty1m0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 07:08:39 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWlWbicUntIw1HuHJHSFB1AMXDgC1jU2M568+DktrZywZHFtRSQYLZo7UX0qANxqilvCb3/ovH3cEZumYrtG3i9EEHe3SEwPMoxPAw3Ztm7QTHj0w6X+rzdPTf4OIhx76U48PfTa8uEptp0jqENIyAVYFnI4V9a4lA61X38e+rdrzSVPlW7GGI+oc0/Qqp7I1MiXn7GsIVILWIqNKgz1t/m5QK6RMHxXBdlrQ46ouZ5WrkKlxa0a1mThULx9HIlWIZGMYS7pFtXN8UyBE6SHRYW70LpHaUZiMP9jtAMe9i4BolHy0ZjpyFNu3wRt2OCLE6/7dM8EQw1ty/qLPtZzvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lq2XMZv/D46E0/wD2mM2UH9+Gim/sa5yfLowCEU7OmY=;
 b=fr0vKvjIoCkfNygkdyfV2/NIqvNGNsrHWisA6b0cLBeTqpN2kLnZwbHN+voLo8DNWfLEsltgsX7ZEXslSrEjAltSlmDRD05RmnMAM68xu1weo1JZMiRE/UqkBigRMkobrtMyisABBsqWg6Qa9KnrMn0Zw+mhpW9108/GTJaFUSlgTzeS3OEwv2EvMAmdk7SO2Ss+MWWTtwfMcyzvEK6AlzadAIQe6th1KvMG7DkZwLjRx8xkxfELsnu4CjVYlHO1LBFA3id0G8MzPgop2r+3futlnEwi7HaHcFkj/yYJrNIXEVCzfs97Qg6qliJH3+q5MInVhekYcjNG4xq/DAuTtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lq2XMZv/D46E0/wD2mM2UH9+Gim/sa5yfLowCEU7OmY=;
 b=DwijxNcKOGjtpsrtja5ILYDAmUSnDwnnU2YNVy9qh0pHkC0E/yZqz/PExYzh58alRnJ3vvKGaeAubhE7+tGM4lJ4vhSbFNCh1hUcONeiLNnl2EpdPtnkphO5V91rNflKJgfnJoyYVBFiSScPz6jt1SLCf8f+iuWM6U4BvuvYTlw=
Received: from PH8PR02CA0021.namprd02.prod.outlook.com (2603:10b6:510:2d0::28)
 by MN0PR19MB6237.namprd19.prod.outlook.com (2603:10b6:208:3c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.36; Fri, 23 May
 2025 12:08:33 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:510:2d0:cafe::1f) by PH8PR02CA0021.outlook.office365.com
 (2603:10b6:510:2d0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Fri,
 23 May 2025 12:08:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.4
 via Frontend Transport; Fri, 23 May 2025 12:08:31 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id E150A406547;
	Fri, 23 May 2025 12:08:29 +0000 (UTC)
Received: from [198.61.68.186] (EDIN4L06LR3.ad.cirrus.com [198.61.68.186])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 878D6820249;
	Fri, 23 May 2025 12:08:29 +0000 (UTC)
Message-ID: <bded7d32-f1dc-47ce-9efe-5b1a0aa489a2@opensource.cirrus.com>
Date: Fri, 23 May 2025 13:08:19 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: cs_dsp: Fix OOB memory read access in KUnit
 test
To: Jaroslav Kysela <perex@perex.cz>,
        Linux Sound ML <linux-sound@vger.kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com, stable@vger.kernel.org
References: <20250523102102.1177151-1-perex@perex.cz>
Content-Language: en-US
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20250523102102.1177151-1-perex@perex.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|MN0PR19MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: d2567e34-1a8c-40c3-17b2-08dd99f28929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|61400799027|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1VuSXd4VSthOEhSeXZJcEpycXZMcTNTdm96MnR5b1haTFM2MUlqeWJhRHZX?=
 =?utf-8?B?ZDd0MFh3YkVudHFERkJDbVV4ay96eGdsclFHb1kwd2JrL09lQlQrQmtYdWNl?=
 =?utf-8?B?YlAzOXllSDdOV2R3ZVFSSWJjRWZZSkd5Vmg4WVp2MWhvUlZTV1RFMlE0STVX?=
 =?utf-8?B?KzQ3L2xFRjBRS2IxV0pNT1FVNjYxMlg5cWV5QW5nM1NGZDBmWlFraUhVTXZn?=
 =?utf-8?B?VnNjaWdSTGlvcDIzdHBDSEdScGxkS3pPR3JSWTQ3cllpbCs2N0lybUh2N0Vx?=
 =?utf-8?B?K2x1Qk9HMzZCUjh5VlRtV2tEVWhnRzBBK0o0c2lWdWJwMEcveE41bk9ITmI0?=
 =?utf-8?B?YWFBVUw1ciswb0xrcERDUlgwSnUyWFlWK3lINld0RW5Qa29VZ2xuK1VQdDlR?=
 =?utf-8?B?c3MyYllMVUpWWWVPVXRyclMzbWZaaFRwWUI0QkZNWWlYaTltTTEzTG81YmR4?=
 =?utf-8?B?WENrSXBxTnM1UW5zTmFhSE1KYXYrSHRmenNQUktiREtDSUtQZXBnVUhndlBO?=
 =?utf-8?B?ZC9RQzdUbGRNd1RjQitjN1hVRzAwOXovZXZxT3hNOEZOb21qUDVUYXlpekFz?=
 =?utf-8?B?R1dPY3I0dXVxVjB0T2VFUkpZaFNYcnRSbVErUDE4R3pxMEtPTXJNWSs1ZjJ4?=
 =?utf-8?B?aDZsOHJ1NkVNQnVReHlCT2psbHZ4bHVMNUtrY0RyUExSSWhoRnJvRVFTQmNx?=
 =?utf-8?B?U3BYV1c1UStURmJQMEZjQ1V0QkJBNkVlMkt3V2lxaVRqTFpjRndDdlV2UGE0?=
 =?utf-8?B?UVFJQ2JqN1AzUXVQSEVqSEZoL2hxNFdlKyt3bys0WlVNNlYzYkg5TmZrZVlL?=
 =?utf-8?B?TFhRMWtoc0dVT0tBby9qUTBlcTVhakh2Vm5uZ0kybG5tSmJmZ0huWjg0WUVt?=
 =?utf-8?B?ZHVBV1M2YXlqZVBZeVRFUlJyMlJGSmF3K1JQNC9IWVQvWktlaXZiaWlybkdH?=
 =?utf-8?B?ZFFrNmkyWXlvYXFzYnZmdVlTbGRMczNORHgzQjV5Z1FGOHY5MVpWM2pncnE2?=
 =?utf-8?B?N3ozdkovMGJjZ2Q1MGFySC9jS25NMlMwL0xadWhUelJwL2RBNVhranUzVktD?=
 =?utf-8?B?VjRmcmFNWkM5RTg1N2FFTnV2b3pzZWhtK0o3MG9IWkh2b0VrcGZqaGtRNWV2?=
 =?utf-8?B?WHRJUzRuNWVVMndZQ0R5NkttMGpmSU1QbnE5YkJlMUhheStQbkJUcXFlMUZq?=
 =?utf-8?B?dUZOcGdQZkVXc3crU281M3cvR3h6YWUybWp2SFRRRFkxazRtN3Vib3R2eFVN?=
 =?utf-8?B?YUJodGlyeDdoS3EzdmF6bWNLTyswTWczaE91by9NVVI4YnVHZWlNYXZsTnNa?=
 =?utf-8?B?NzN3Z0hwS2p6dm9oMmZYanhNSE1GT2F2M2UvcE14b2g0UWdQcTNMemVQY01O?=
 =?utf-8?B?MmN1OGo4Zmg0SlZIM2Z2cmx5S3RjYVB2QktIcThQaXRDZUFxbkRCYUpZcFNE?=
 =?utf-8?B?Ym9tMDAvaC9tUzNQK2Jlb0c2NVA3MSs4YlluQmEvOVBEZXRNQUJQd05Pck5o?=
 =?utf-8?B?UnA3RGlEdUE4YklDelV3amtoc3o4NU9NOENIS2NVelhZYkZLL09KcG5icWls?=
 =?utf-8?B?Qm9SRStpcGw2Q1ROQkQxQmRMY3JFNWxwYlRHWi9uMkR6RzhyUmNiV3ZzVzd3?=
 =?utf-8?B?TU5veUV2SCtwTVN1djNlN1M0a1dyRitlbndGNFQwcXNIWHE3eDF6SDdtVTRP?=
 =?utf-8?B?ZUZrRy9mVHgrVWFwOXZUOFVpa0R4MW5naU16c0lRZnpiUndHY2NoUEtxL1A0?=
 =?utf-8?B?L3ZEUERpS0lUZFJPekdpdnFIRmYxaWwzeHB2RHRTUU82V2Z3TkVLMGVHMXYr?=
 =?utf-8?B?RndsTjRpTUFuMjlwWFJZaGZGOXpHMGdFK0lNMTc4a1RKUFFRVzFBMDZpRDFI?=
 =?utf-8?B?SERUak9CUXhXL29tODJSZkRQc2hqb29JbnNCTmdjSDZnaWZYdEdoWTJYUVRH?=
 =?utf-8?B?RmRhUmFlQmZKN3pSbkNyRXRJVzRpcHU4VDBjNVkyMVh4dGlzZkZIRFpPTnRz?=
 =?utf-8?B?UXFya3ZMT3JxZVlyYzZWb3JjS3owQzE0Q3d2ZVpLT2RrdHR0ZjJEK2ZyVVFN?=
 =?utf-8?Q?WY3OF+?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(376014)(61400799027)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 12:08:31.5513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2567e34-1a8c-40c3-17b2-08dd99f28929
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB6237
X-Authority-Analysis: v=2.4 cv=as2yCTZV c=1 sm=1 tr=0 ts=68306547 cx=c_pps a=iNWIl9VYHPL0lOopq5qx6w==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=VwQbUJbxAAAA:8 a=rqJrtwmT8b95BHjAMj4A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: rsf2nV6iIyr5-kQLXbof18SevcGk2EP1
X-Proofpoint-ORIG-GUID: rsf2nV6iIyr5-kQLXbof18SevcGk2EP1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEwNiBTYWx0ZWRfX/VLTxPeW8544 rAlRkc3cno7sV+BjeIHZwC90hGgMCAYqIq2c9aTeYRyyWR7Im314dK1TryrdIUXh3hhao1BTPnn 6f2JZK0r8TmJri1iDawy3rppDrOIPnC86vwT6wYn3TNvd1kpsUGxtJtlZGveo/jz7VdBqbdlTaH
 Ppg24wtUexIox4hBXN5oXiyZNoudRXhLkJv5ciXRgPM6/H5U3QyJNtTgcJiuEomSvcLbotPTyAB lnYqkIGra0NE5os5vbGv3v79Pt/kMObZEilcRofkiVTUMNINyLacmNjBtndPeM9huF59T7lzwxr MIZ2BwWg4G+GO1giZYaNyT6P2D98ntSsDBBvhSr1z/MXqYE0JJxnSdPa7zHqRITRVHHbE3IZzR2
 z4tyIgHI6JSCYv8AfT9Z8QwSysJLYnUXg6pS4bTC490Y9xx+SgARqHj96jZy73P4hUi+LcYT
X-Proofpoint-Spam-Reason: safe

On 23/5/25 11:21, Jaroslav Kysela wrote:
> KASAN reported out of bounds access - cs_dsp_mock_bin_add_name_or_info(),
> because the source string length was rounded up to the allocation size.
> 
> Cc: Simon Trimmer <simont@opensource.cirrus.com>
> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
> Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
> Cc: patches@opensource.cirrus.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Jaroslav Kysela <perex@perex.cz>

Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>


