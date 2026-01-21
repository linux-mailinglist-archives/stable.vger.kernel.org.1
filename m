Return-Path: <stable+bounces-210645-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDDDM1c1cGl9XAAAu9opvQ
	(envelope-from <stable+bounces-210645-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:09:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 453894F892
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43E4E50FD3B
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C69331A5F;
	Wed, 21 Jan 2026 02:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zlo5++Du"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EF62E54B6
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 02:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768961321; cv=fail; b=YJ5BsUUKbepuUPrwXxlZYYUP/WKcc/1D9L3w/BPS0ZpCtW1UNaI+Y42l8R4h698yyIpVbNg68kJfQZOHAXEi4GFS1t5dvf2EozjJMyaFgrevqCSbynQV1PVs6q6zKOCgatDGWiLMHigUAN0Wmjv+iIZLU2i7yElUedl34pzxUrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768961321; c=relaxed/simple;
	bh=jddJwwzEaBDDpawtdYHHgyiKiWts92bHcf98HQPLDOc=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=Ku5UcNs4SdpWAvvKHwSrT6gwdRcEa1f+kggN9JloIsY3V8fQ2ABBXZXb/d5C94aAx/GaZppvKeLSGw5kko0OkN73fTHsyNs+wEmm5vHCZ+2pWSCYxzIE0OcJUv+MCT/k+GDHhRzz7OCdrZFL6OZ9c8lRS4bA+s5fLIQDjkzZbTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zlo5++Du; arc=fail smtp.client-ip=52.101.43.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvMKUpPuOXtZWgMXnLUY8ZF4+afbo2Dgon/OW2FVK3B5qdS+MLtqWsPmvBRx0I4u2sivkN72skQjAKQLhysba3wRUFTTXp/bN3N2ulj2zKBoJF67915NNVEkl7NKoMFHO7OvjPtJqWmtWI5fyapSMWlq5LPaoI73LeGN/ojKIfG+M1/kiEcOHzTkasINt2r+iZcqwK5Zp+AX5YBR7Pw4VFeATy+GJKCb9iFA3kfwRXR6GLrHMuE00vkUbS9JmP9FKtpGQjxfisKBuH0RJ/1rQs/Ru4XLrupeCabjOqjeScYjVQmuxJlbreO05lQMafkzM2mGqolfOvinnt4mois4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqVc7rhZkS2Nh/tJjJIQcoXmOJtVLftiqLNOMlgFud4=;
 b=sDHjwhDskJtpcHQyZFmT2kzREzk2CwslYy3BPtGB0oyje8U4iFMYlNBgu47kUMB04lk5nKSm9S+bHfmsxBa+6LlMlrXGxZhhmDQ12BPrOdoGSQTkvsD7drrz0fNh2Q+x7BrWMytKnLgiq+bavdQCWF2O1WmL/8f3teR2Nl1/8QLgPXLeb20/Jrbw+SC3Qw/qUu96Ea7XZ7Y5K9VElQuXndBnfILALPsDxPhvIJU+Ryh09K87oiHq2xLeLezb3wP++qzoVd2f5W+8LwvdDqT5tzHrjTN9AgY7XrqZWnyw4LHXrZy9PDaBhqIhdOUZ4P/EZNaEJK0JW+H6g4P3j276Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqVc7rhZkS2Nh/tJjJIQcoXmOJtVLftiqLNOMlgFud4=;
 b=zlo5++Du9+gLqF2Y3KKfy5o1bAMvW3ER05prHaViwvFJdxbLG1ZrOJdtWfrYZ2vuuxE5RFnMsKzomljTaZ1RQjhpNqgzX5zliPaxr+axvucQmCp4MZ2fhLkQGQQy/o+oVqBrV7UGRAAq8z5o7DVuuhpImETNH/JvFcM0jn3re4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB7691.namprd12.prod.outlook.com (2603:10b6:610:151::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Wed, 21 Jan
 2026 02:08:35 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::94eb:4bdb:4466:27ce]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::94eb:4bdb:4466:27ce%4]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 02:08:35 +0000
Message-ID: <870872aa-28e9-412a-bac6-8020bf560e4f@amd.com>
Date: Tue, 20 Jan 2026 20:08:33 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: regressions <regressions@lists.linux.dev>, stable@vger.kernel.org
Cc: iommu@lists.linux.dev, "Hegde, Vasant" <Vasant.Hegde@amd.com>,
 "Hou, Lizhi" <lizhi.hou@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: IOMMU regression in linux-6.18.y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:806:21::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: 00c0cb2b-7361-45fc-5d02-08de5891fbb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akl5WVdTRUhwS2U1azdrb3Nya205aDlQY0xuNmdCSkM1M20rYTcxRlU2M2o3?=
 =?utf-8?B?WDlzM0NuKzh3UkFpZXp3SGp2WHRjbDFBbE1YYWhXd2FXTmNUL0dmTFNjNUdk?=
 =?utf-8?B?Mk0vRm1Dd09RMllkU01RWGdlaWF1b1RQbWlzM3hnc1pzM3RHUjJoa1gyS3hN?=
 =?utf-8?B?MlNkL0t2U2hRVEpTamhQdm5tbVZqa2E5bVNEUnA5cWpnNzZzeDRMdlVrNEVV?=
 =?utf-8?B?ODdGQlVSSGQ2TCtYUUhwNmZxYnkrYU96bXMrRHVHQ1dOZEJnbGI1a2tHV2NP?=
 =?utf-8?B?eitjTGlEMTc0N2NlSzBNUW82cTUvQjUwb2dkTTVsWVlNaU90UUF5N0xhbTZN?=
 =?utf-8?B?OEV5RW1wanZPNG11dFF6NVFRNzR5VGFidFVONC8ycXRlWTgxL04zZVQzazR2?=
 =?utf-8?B?Yk1JUTMxT2pVMHZ6aDNrNnBJaDVxQVFmY1gvQXdmQWp5d1dtZmEzWVV0SVIr?=
 =?utf-8?B?aFp1S1hDVVZRTmNhNys3MDNnZ2VadVNaeUJWWTlRWlpuZHpJT1R0VXBvbENm?=
 =?utf-8?B?RGtIQTVOYlA1NDUvaUNzdXpxeVhITTNISXR0RkQ3cHBDMTVDRnRBVDBCRjhr?=
 =?utf-8?B?WVN2QnpuNmd5SDlMZmJlbE9SVlJIYlZoTTJjSWlhR2lZeXBUSlRUUGVUOGZK?=
 =?utf-8?B?UElqN1VZbDQ2a3FVclNlR2tLZHl2OGVFUHBIc3VkUjQrRis5aUxXQ3l3SURH?=
 =?utf-8?B?UjhhTkEwS1FQVXI1Qm1wUlNGS1duZVBWMkFMMnlKOVBxanYvN2dUV1JNMGRw?=
 =?utf-8?B?WkpMYTFtWGllQlhBTHZSN0tpMUNDQjUrMUoybzdOblcwZUtwU05tWnZXZm5m?=
 =?utf-8?B?aHNCYjJCL3VtRmRlZHRmSnVHc1czcmpXRVBuSVZVcTFhSDJCV1NjZk1NRk1y?=
 =?utf-8?B?SGhsV3pnb3VlSHZwUEI4YTgvZFY4M2dFZUtTQjhaam5WdmFXb1lpaUxrdk1I?=
 =?utf-8?B?NjhVdFlyS2NYaUhpNGRLR1A3MThGVmNHbmhiRGUzRjVhcW5lWkN4UjVnb0xH?=
 =?utf-8?B?UlMwQkNVa3pEWW8vaEdZL090V0lXRXc3RkJkcm1DbUhKUUl1U2FBZ09rc3Z0?=
 =?utf-8?B?ZndJc09HdHBESlNYZjRLSlR3OTF0WWRhcHFwS2R6bVZSRFA2eFFFb2UyMlQ1?=
 =?utf-8?B?NDRIeFpkSzhTWm9Na3VhVjdHbXRGL29pSEpSRTVHNDVnZ0hZdXVHVnI1eXVi?=
 =?utf-8?B?MUs3V1Jjem9ZL2pyaVdSTndPVWk3enN2eDZ4cEN6dG1Vb0lQVlEyS0ZOVFR6?=
 =?utf-8?B?L042a3RHUW5sTHNZUU9saGVwbWI5L0p2ZjlCTElJU25laEhqM05xREFPcCtq?=
 =?utf-8?B?MDB2UUZXNGFmZXZNZElwQkJLMnV3a2kwNU1SL09wZjBGM1Rjd0RlV1FhZDBQ?=
 =?utf-8?B?SDFVVHZucDB2Qk96Q2NMdVdhclNLNCtnclBEUDEvZ2hMQnF0MEdsKzd0b3oy?=
 =?utf-8?B?OVlDWmh2S0ZpNkh3SHZzRFYwNDZxc28zbkkzbHhqNmJUbVBVY0kySmRjUUZp?=
 =?utf-8?B?OG5maVlMS3kwU2RGQU5QQ1JlWEQvdEt5MFlFcnRPcUovRnJ6U2lYWUl1ajdm?=
 =?utf-8?B?VXV5K1h3YUxlRWEyQ0pkK2U4WWxtdDlMRXlRdEsyUmNvZ2N0M1BFWU9aMm94?=
 =?utf-8?B?eFJPRGpUNHU4cjNTMjR0MWdhWWpxKzlnYzBvcGIweUF6aVJYWGc3S2lQbUJ1?=
 =?utf-8?B?dVUzVlMyTE1STVJkN091MVdZSFNLTjZhMytBRlI3U0pMczlBSEVnNFc2TkpK?=
 =?utf-8?B?QlRHTEwwcnkzck5BN3ovVm1POXc0dXR6NUlqWHBLMk54eU1PR2k3MTdaejJ3?=
 =?utf-8?B?UnRhM1p1d3B4ejd1YlBaYWxpVmN3eHp5MnNPampjVFUzWHMzL2d5S2pteWpW?=
 =?utf-8?B?YWJJRXRhYTVlQkp4KzZLQVVpWkVLOHI3eVZCSHVrQWhpQTJWVk5hMmxVOU1M?=
 =?utf-8?B?djJPZlBSOW5hTlQ3cFRleVRHbUJpbmFpZzNjdFNLd0VvN3RrdkdkUVBNdUI5?=
 =?utf-8?B?UWl6QTF6NElDRmQ2ZURBZHZaSDk2UlRtN0dtcll1TWpnVWdLSjd6SC9LSGw4?=
 =?utf-8?B?T0I0WUtsbzN4aUNIVDVQazhUMTVES2xXZWczNTkzOTh3QTF6dldYRHk2OEtH?=
 =?utf-8?Q?GFFUl+hXXSuo6xiqAbCrqqtjj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjlIM1BQYldCeU1PYXVOSk5iaVdDU0IydEdtd3N3a0kyamNKdUR2UXYxcDYz?=
 =?utf-8?B?bWZXN3JqdCtqckw3VWR1cy94U1JYQmlVc3RTRmNCcnlBR3M0aWlZNGR4MTVZ?=
 =?utf-8?B?eWFsQVRod2hMbHN1ZndyNjE1dTBTZUZ1UWVYbHBIdXd0b2Jqc3pHaGhiTW8x?=
 =?utf-8?B?NldaanFNcHFsL0FOT0FxR0djZHF4LzNCL2lqR0FXTGdMVGxONkg0YnFlWkt1?=
 =?utf-8?B?TThxNjdYQTN3SUFzR1VRVWg2aVZBMlRQODdYQXZrMDArRjZYU2orbkpPY1lj?=
 =?utf-8?B?MzJlVjgwSU1EeTFzOW5IejBRK0lpbTl5MklvVVIzWEc4R2pzQ1lEc1RUalFH?=
 =?utf-8?B?UVU2eUxueUg3bjQ3VEVIK2t5OHVid1ltbXppZE5nKzg0aS9Md3pkbG1jdmZx?=
 =?utf-8?B?cGJEQWI2S3Y3S3draFlYSW1DUGUzaDhUSGFRanNVWUFYelNCOXRIYUFnVHJ0?=
 =?utf-8?B?SC9JTUlRT2NXNTdFd0FUWkhkd3pUcnBoY0IyOW9rbDQyNGdjWEtTWWRJMUNl?=
 =?utf-8?B?M240Z1pVblhvUG05cUExZGhCNzR3OFU2SGdYcXJ0RGw0RTQ0NWF2TnJXR1E4?=
 =?utf-8?B?RmNmYVltQVVGbWd4amc3K1FmVmNueGdwVytzUmMzTmNZWmdGc2pRMURqQmJJ?=
 =?utf-8?B?OFVwNXkrR3lNL3dia2YxVGR2WGJhekhQMyt0K2xjYXl3MVU3VzdDZ2huNVNx?=
 =?utf-8?B?RGdWcGMzaUJsWFZtZGVzay95TWtvb2NLbEJ4R09VMmREc05nbVRMTEthUkcx?=
 =?utf-8?B?SExQY1VjaVg2SC9QK3lGVjBiRjE5b280N3Vmb0JvNGRLVmE2R1JyU0pQWGJn?=
 =?utf-8?B?NUVnQ1hKQW15NytBOVMxRzNvT0pNV2d4MjhuNk5wMVpSMjQxQ2ppWDRnZkdG?=
 =?utf-8?B?b3NxK2cvVmJPQjJ2aTd2RmlyNEczR3Vyd3p0bHNzWVZQVVlRamp1b0VVSE1t?=
 =?utf-8?B?MjNHbzBONkVJNmROS09MMktLb0VHSGVaTHhUNlhIUytXMnN1dmszc1hyNjNQ?=
 =?utf-8?B?YVZuMlV6bEZOT2g4Z0RDK0NXSDJOZldNVHZaQXZrejNYbUE3b0Zsc1ZEWTQ0?=
 =?utf-8?B?eGMwQytnODBsSmZDcUUxQ2JZRWRTazlOR1ZmNlVwaVp5ei9KY01EbUlHcS9X?=
 =?utf-8?B?K0xRV1gwNTQ2UXBXMkp6cEFXNjVLOXVGY05LUTVrVzZzc0NZQVJkSWlDSXhx?=
 =?utf-8?B?T2thc1B3OUE5d3VkeVh0djAydjcyTkVYVXRMK2g0SU5EMnJZa1gzZnR4Wmc4?=
 =?utf-8?B?SE03UTdCVFIwTnJuS3JqOXVETnkvOFlUUGJSN0trdjd6YkhJSmxQYWRVY1ZJ?=
 =?utf-8?B?M2IwRDdibk5BNm1pM0YvVDE4M2JoTkY5Ylc5eitBa3ZZZDJHMmorcDY1Y2xY?=
 =?utf-8?B?KzQ3RXFjUjU4bWliU1hudXdJWGhtaGxXcThLWVl0MnRzaXQvVFYvekZSUjVx?=
 =?utf-8?B?azF5azJLUkwveEQyRVJybFhQS1hwS1l1SXNuZTBLdmRqTDFpa0hKM0NBYjZS?=
 =?utf-8?B?aDlGRndBbUw0a0o0eEdxM0k1Zy9lQmppL0p1V0R0WmdyaEFCdTBZUkdsTGV6?=
 =?utf-8?B?UVVpSTR3cUd5UDZDSEJDZkZ3QVFxZHNkNEVyUG5JNzVuMHlUeXZkM1BidnJN?=
 =?utf-8?B?VHhzVWowbk16dDRNR2xORXNYTXdqVWtNVUZSYi9walVlNHVLcGdOR1JyT1ZX?=
 =?utf-8?B?TVh0aXhNVTFPOGdLdWRZdGEvMGFIR2ZNUFZ3SW9FSHFCaXcrL2UzWVBDSVkz?=
 =?utf-8?B?RG44YjNJY3FZRmFZMDJNSm5WNk9QZVNRbDRNNFpaWkJRekgzMTZTdmJLdXhK?=
 =?utf-8?B?UnNtRXZORG9ZSzJoNTg3MVdCQXJ4ZEV1YTVQbEtscklyd05DRWw0WXd4a1Bo?=
 =?utf-8?B?Vkx1QlRxYlczbUo1V25kTTd4YzltbE5QTkdNNkorOEhLNkM5NUkvZkhFWXJ5?=
 =?utf-8?B?NDdCUk5jSGtuSXBCMmdLdHozdisxV0duY0hyOUh4eEc4RHQ0ZGNLeXlTK29n?=
 =?utf-8?B?QlhNdkZUdzVzanNtKzllSnluSDVBbVJ1dUtLK0VTb0JDbzdESytoSkxyY1hH?=
 =?utf-8?B?cTY2UmhBWmNSbGgrcDRRU0VpcTUvWXBmY0RCelhhNnlRbnFicHdRYlkzOGhZ?=
 =?utf-8?B?eXlmT3ZaOGFKbzVFcDhUdkVrVytXSkhTdkRwMUZ1SlJzL05lRUtJL0dyNWhl?=
 =?utf-8?B?YUwrSlJaZCtSRHpuMXFqcTdEUGlIczlhQlB2dEF2ckNPb1FlYzVaaGFwVXdz?=
 =?utf-8?B?aWg3N2tXd2pKSmhNbExXRDNCRlgwS1RaSGZ5dmlzS3YyMTRBYlUrZ0o0M29S?=
 =?utf-8?B?NVZtUFBpRk5nVlFOSjdaUXpLVk14bEsydXhWOXI2d1ZsWFN4MlZxUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c0cb2b-7361-45fc-5d02-08de5891fbb0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 02:08:35.1445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7nS7o4/r28PKZhF+NDO5sozqD3+944kuui5Fe2Q1yuq93YSN7ol9JxokM5S51bZmQokaw4O4230no9jSPZckQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7691
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210645-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[amd.com,quarantine];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario.limonciello@amd.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,amd.com:mid,amd.com:dkim]
X-Rspamd-Queue-Id: 453894F892
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Recently I found out that amdxdna stopped working in linux-6.18.4.  This 
is because of this commit in linux-6.18.y:

commit c341dee80b5d ("iommu: disable SVA when CONFIG_X86 is set")

That was originally backported from upstream:

commit 72f98ef9a4be ("iommu: disable SVA when CONFIG_X86 is set")

---

SVA support is a requirement for amdxdna.

The series that this commit came from was part of a larger 8 patch 
series, but this was the only commit that was CC'ed to stable.

As a result this is not broken in 6.19-rc, but it is broken in 
linux-6.18.y (and presumably any older stable kernels still around that 
picked it up).

So there are two options I see:

1) Revert c341dee80b5d in linux-6.18.y (and any other stable kernel that 
picked it up but has amdxdna)

2) Bring the entire 8 patch series to linux-6.18.y.

This is the entire series (I didn't look up the hashes from mainline, 
but they should have all landed):
https://lore.kernel.org/linux-iommu/20251022082635.2462433-1-baolu.lu@linux.intel.com/

What should we do?

