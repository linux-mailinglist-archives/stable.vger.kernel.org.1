Return-Path: <stable+bounces-144020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A04AB44D0
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 21:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A48703A4E61
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3B81F0E26;
	Mon, 12 May 2025 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XfDLGJ3T"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAA323C4E5
	for <stable@vger.kernel.org>; Mon, 12 May 2025 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077655; cv=fail; b=VvlQ3jMbAiLd462sLJvVzt/NhglhLaRUwP9cktoabmBQ1dg0iqIkrsA4iBy0NzvHlmN8LCfoXoV4OX7lHZ4q9w5EvwpB1pmNhYBRaryHzkzVK9ltiuXB8Ug82BjurLVoApB1ivENtQY3K+Zw9tncDlri8Tz7Y/8RBI8jSrUMZMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077655; c=relaxed/simple;
	bh=fCoP7n4b+PZV8q5cuNu6bhnSG4bMWltoLxKf7/1zwIM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fA9TcLAcxvpjF7yGBbOfHkjftdGEzpSMhZaPJJRdiFvQHZ6fQ3UTM60Jk/4MqoJqOhT83s/1Esx7x9oqz0YEFNdQGyF8GOhfpjtZ75mxdeUtlb4u7DbbThULH3qySOJOD0O5PNwLAsmlq/Fz/6oYbKZLQdR40cMvkbCBwHXpyzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XfDLGJ3T; arc=fail smtp.client-ip=40.107.96.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMOuvaAkQimeOU7AkFpDd39jHfVE96qespUQ5zkdrQrFxy82YS88nT/JLjOtQpmPX64tp7zvmtgbGaUPO7Qxhjp9tCZxKXqmoTlrRLAkwHsEmYRXa/l6WY3ZzA4aKADSAnKRpLlbG+/IpSrZVrttJnvvN50t54mfDW6HJPdJwtMGyyz5HHFTB7YxhA0Sfe3ZZgHum/jF3jbewmlzpV4VsYEUZHFnVlzo5gqRoSBdlODIgHVK/kQ31KADRO/z/Ju/dS40o4XeVWA6wnvETsbEDXLyBwejTJYpqMxaz5FVi5vWFzNIh4pjSIgBN7KV6ZBtgfWCAucakGltDJY/yuqFFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwZ/Cc28JsRSVfp9zri6+xsoTcyY2gQ7N3C9HCza6U0=;
 b=JCa/5ALWoTOp5HxwRl4Ry0J65f76sYLBrxBS2JOTYLsvhfq3IaNXpuvgobPMQjtSXhizePJEJqu1f9I2mDn+tMy4zlRWmlZPKKIsp9j/rgAqs45EXpycH+i1qPXC6Q7uJHnRydyr5CcAAxt7dEXJTiitMSs5tqV04iYBH8u6uSU878iaJNi5izZT1CK6JHGjLEo3u2EMfmh0DLXc49+hVipZ/MQfBr/zsaHKrdClwpcYXF1ApNDghVsnPBMy/Jwqqh+xWkN4akjLnoqmHYoZYAYlDf2SUH9r6Ida4HYXiCzDghM0tfgUnll7lUjpWXVjsYXrLfjKL9Th/o+OVAxT0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwZ/Cc28JsRSVfp9zri6+xsoTcyY2gQ7N3C9HCza6U0=;
 b=XfDLGJ3TpsjHWUCrnMbeTdmdd9/lm+BVfmRf5qf1qufSAMFkbUp5Ar3yJbDq2+GUnqgoTjFFljtfSg9pzrS2eLojARfP1E9MC2k/AcSKi4xD52GFOoIJ/m9eeo3qtwHyjB22kJbFT2Vwgoqxq5slO+MpjhnmJJB/CGmydu1V0/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 12 May
 2025 19:20:51 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 19:20:51 +0000
Message-ID: <be14496e-95e7-fe02-1c31-a8c94f458134@amd.com>
Date: Mon, 12 May 2025 14:20:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] memblock: Accept allocated memory before use in
 memblock_double_array()
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <20250511202308-6e15ecc96ab8f446@stable.kernel.org>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250511202308-6e15ecc96ab8f446@stable.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0022.namprd21.prod.outlook.com
 (2603:10b6:805:106::32) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|MW6PR12MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ad34e7-218c-47f3-19c6-08dd918a1b6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUhvWDFNWm9zd211cDRiY21sOUhjTVFwS3ZPTk1aRnpRU3pYN09ROFFFMjV0?=
 =?utf-8?B?Vkc2bnRqcURjdGwvSDlzb2pIQnY0dXA2RkszbmZQd1plTDNPbTVVcEpHYzdj?=
 =?utf-8?B?am5zQldwVkM2M0NrSFUvdzBXdmpsYk9nVVcreGp4RE95aWVZSENoRkRYVXV6?=
 =?utf-8?B?NWJKQkxPVTdkV1Y2VzhyUUh6Sm9QaERiS1hsQmtvSDlOdXNHZWk3WUVFVnVs?=
 =?utf-8?B?em83NjFCSXd0LytmdFk5ZTExNEZTSU8vczcwdEN0dEIrMVgrekZWQ2RMQnRn?=
 =?utf-8?B?c0ExN0UvYkhlYjl3a2tXTW5UbzRlWFBCcitndHhEcWg1MkkzZHhCc0pPK3dn?=
 =?utf-8?B?S2g5bDZBdy9uVGY5ZldBTGhBT281K0w0M203aW5Qb0VvMEYxMHRkeS9WS2Vn?=
 =?utf-8?B?UTgxY2NLek9vQnExOEFWelJRMnFwOVg0UU1LOGdjcDZTRkY0bGtKT1pFczMv?=
 =?utf-8?B?QXplaGNianE4R0M1dnlKVmZ3dkJIK1VhRGpqREpmWXAzQzRKYk5WSjVQN1Y0?=
 =?utf-8?B?eEtuZ1NjSEtQaTArZGhGNWZlcWNOaU1memNUSU5WckFjQm5MdXFtTGFJQmhG?=
 =?utf-8?B?eVZXWVVhNzI0eUVxS1VPN1prc09UdlQ1amc5azdMd2NLdTVqc2txOE9EQ2Qv?=
 =?utf-8?B?d2V3ZVpsY2lTZHhEYlJGaTV4TTJmUHZ5YTBKOVdXcW1UaFVHVm1oZnZrMmpq?=
 =?utf-8?B?MjllWUhFZitZVVNDK1JXYVlWMy82QlFNZUJ0QVhlaHBjMUxkV0VQMFo5VHZa?=
 =?utf-8?B?UTdrRVl5ZEg3Qm1BNHVpekhzWktoZXNINEdPUjlpd2l3dFhKeTBBdTRsdGxn?=
 =?utf-8?B?RXFKNnRsbHZqTjRhUXdQYURYa29idS81QWVqYzRvbFZSRER2Sm5JQnBMYXFO?=
 =?utf-8?B?ckNLbGxzd293QUVBR21menlqYXZyQmZEYW1qZnZ4U241Y21pcng5VDV3Z093?=
 =?utf-8?B?YzlteUFKNWgwNGZCUVFBeGptU3d3ODczRGJNMFd0czkxcmpyT2szbDdsQzFO?=
 =?utf-8?B?OWk2QjAzWUN6b05VaDV1dHBYcHJOM3dETXRlUGhoUnZDNWRVM3I0aUxvTGRB?=
 =?utf-8?B?b1pRYUtTRnZBUk5JTTlOT3d5UzhBd3Axc0NKbllQKzBWelpDWHJZZFZMMkhm?=
 =?utf-8?B?dm1BL1h6ZFY1dGJMMDdHRHpBZnRQMjJNRzJ3RmdkM29teis2ekkxTVFMTjF5?=
 =?utf-8?B?WUlzNTZOQjAydGVvUXR1cm43SEdiMmtJTkhWZmZJVjBUSWNNcjNjZzNiTGVw?=
 =?utf-8?B?VDBkZTI2VnU1QUtCVEJUdnhQaGFMTHJMYUcyNzhsK1pTRmUwUjhObDBWSHEw?=
 =?utf-8?B?bFgvYVBTeHcrSFRmMEI3U1lNRkw2N3VnMVBsM1pFa09TNWk1ZDM1bHU0T0Ru?=
 =?utf-8?B?NDhuUFFPdDNDSGJqTlB0YVhudWNrUy80T0xZcUdNb3kwOUp6M01RYXMrTmND?=
 =?utf-8?B?UGErNVhDK0pNM3dUV2FUamxmV0VJeW4zQXpoTG52bVN0amJ2bFlreVFKc3Fw?=
 =?utf-8?B?TWlIb0dPTFYyNmtyMks4ZmZ2YmtmaGR1cXlLTUxOWWJQQTFXbStpVFI3T2hP?=
 =?utf-8?B?ZU95bHd5VlhEMXNSRkFiV0U1VXdDOThrUFQrTWpWZ3RNVjVJbTFtd3NuVS85?=
 =?utf-8?B?MGNkaDN5OUlTSGNzWVFWOTlWa2RkSWVUc3RoRU1tK2ZJd0RCVWJaWlVjWTFz?=
 =?utf-8?B?ZGpLTVJxZVpnSk5YWlc1NXNiVXRaYmd3MnVrQksxTXg1K0pnNDVSTCszd05t?=
 =?utf-8?B?bVR0QkU0cFVHdng0eStLb1hWRXdvcDY5NDhFZmRSbG55aUgvUUgvRUJha3l3?=
 =?utf-8?B?Y0tuKzYrL0FtbSt6RkpMek1CK3A5N1BxdzV3eGdGQU81VUJrUjhlNHZwaEtO?=
 =?utf-8?B?OTlPZHB5VU1hSDVTaUcxd3JZQ3NwMkNieUlKRlIzbHlEZmdUb2ZCN0FGYkFs?=
 =?utf-8?Q?rGrvj9mE4HE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1hZTkRsRjkxQkE0ZjhFbkdSN3BINThQNUpqMzA1Zy9XV2RQdnVXTUFVUUEx?=
 =?utf-8?B?ZjNDTk5rTklBeDc0NWtRVklNcnF4UFdRZm43S2IxcVJHdmRNbmZMbDdqYTY2?=
 =?utf-8?B?UzZhdnU0T2lsRmt1WGdacHRZM2lOazZSd0U5MC9sd1NETTZSSVgxSElPaHhr?=
 =?utf-8?B?OHVQTjNka2lrM20wK2VFWDBiM0ZPa3R1RDhXYXUzdkxpUXc1OUxwbWM3MG15?=
 =?utf-8?B?RlZMR3N2aFJqWm8zZUdMWHF4dnpGUmdnbko3b1JkajVtWURRaXdhNFl1OWRr?=
 =?utf-8?B?WVdXQlV6MVA5RG5OdHJRMjFmNXFmbWpkODFjY2d1N0tUbDhKU1RwZDdKYlVj?=
 =?utf-8?B?NWRUSDRpcjRHYk93bU1DSE1ZQ0tBK0V2WEJQRWpPQ1Iwa293b0pseWVseHZr?=
 =?utf-8?B?cGpHQjJUSVdlT01ZaFF5TjUzRHdaN1dUTlJvckJ5UU1UQ2RLTDZDVVRLM0pC?=
 =?utf-8?B?NEdJaTZ3YWw0dnhIbzFZTUlSMUt1T2NCU2VSVUlXMDVsZGVGUC9QNTVSeStJ?=
 =?utf-8?B?dlBYWG1BRW5hRHFBcDV5bWtwUnYwYmZ1VkJHangxMENxRU9Zdm53TVNVYVd5?=
 =?utf-8?B?emZYOUFuRTA0c1lGR0M3M3VZQysxN2FrUmEvemlKNjdaSjdVeGROUzN2cGdm?=
 =?utf-8?B?YmY5L0syc2VQSFdFaHVzVldKL0VOb2tyTWJwbnpLUC9uTUpvMndHQmV3TnpR?=
 =?utf-8?B?STIyWnBUQVExaytpaGdBZ3Q3aytmSHk4YzVuWTY3Q1ZPcVdpa0gvL0lWb1lL?=
 =?utf-8?B?TlVRR3U1Qk9ycjl3eTJ6SDdQdzY3NUFMUnZKaXhiR1VqWXZZNmI0VUtrVEVB?=
 =?utf-8?B?Z213V2dpQzFOS1l6eERVQVRRdFB1VlpCUXVzb3RTTlVyOVJGNWE3UWJuRWJr?=
 =?utf-8?B?bloyUFNsZE5SWUVtVXJrOThYY1YxOVl6akh5M1VCYzR1enIwUVZDL3llN2RD?=
 =?utf-8?B?S0JzRERqcW5HRGxCcGdEM3FIQ1RQOHZTRjJ6TVFXTU0rWDlWdEVqOE1ZWlg4?=
 =?utf-8?B?bko5YWx5YndCTGUvN3Y5MUMrcTBqZnNqYXk0OGZNV1c5Uy9FZFJPQU5RcVh2?=
 =?utf-8?B?MitCczFHbUtZRU5jVzZLcHk5SngxUkJ3dUhwUWNFd3FJMno3VTI5bEpzQ1Zr?=
 =?utf-8?B?SWc4bHNYdk45d2x5L1VtTTlFRGIxN29IdUV1Q0tqV0IzYWxQa1NSaTFXcXNB?=
 =?utf-8?B?eCtBaU9kR3VnSmVMbXV4ZWRJd1hOR1NWaFBMNHdVY3l5UU9sWlM1QVlSTndl?=
 =?utf-8?B?ekRPZUhEU3V5cWdPbXVsTlRnZVR1UjdyLyt1UlV5Q2crbDFMRjVuKzVvZVpz?=
 =?utf-8?B?UGFrd3lOUzM5SDExbkRkdjZVMEM1WElOM1dreVRSeUNZUEdZM0VIQTY3ZWxR?=
 =?utf-8?B?cm4xUGZVeXdneVRuUTg3aTF1MUM2aytic1VkbGxCbGJDNDUvZTV4TkdKT25x?=
 =?utf-8?B?ZzdzTm9jZzV2WTl0VDdhQXR0WmpHUUNaYndtZzJSMzhZa0I0aWNqQ0xKR1M0?=
 =?utf-8?B?ZExqa3MzRnN5d3ZsdUd4dnBMNGdTU1R1dHVMTFN5TjhvMlA5RHk2NTl0T3dN?=
 =?utf-8?B?VDBxbmRTNEpMajc0WHFIdDFFckp4ZGwxZjRBY0xWa29BNnZXdFNpZGJCNzVN?=
 =?utf-8?B?VWNETVVPQU53TnFvMm9jSXkxYTB0MmVpUlgwNXFxOURSRDBPczMrVlU2Wmo4?=
 =?utf-8?B?YzZOcFZXQy94UFY1Um83VVVGLzVTR2o3dmpMdVg2RkdNRnB1OHlmcVM4U3dI?=
 =?utf-8?B?V09SMlQ1SFNxWW1yV0s0TjE0Y1E4NmZDZGcvNU1xNm1yMVVuN1pZQWZIK0V4?=
 =?utf-8?B?cGRycUpTUVQzL2dmcXpLZHhZK09PZVkrcXJRMFQrU0dCcFhlQ1g2TWMwR2ZX?=
 =?utf-8?B?QkV6QzBBYWxLQnV4enZ5SXcxc2ltODNkTDZWUWl2UVoxOVhJUFNmYXcxaUN5?=
 =?utf-8?B?TFBtRGZ4dXJvRFhhYkl6QlBUUHc2NDIrOEZ6QzFlWDNHMkI2Nm1KbXkvZnBX?=
 =?utf-8?B?Mk5lcDZDTU5JTFQwM1ZVcTROVmVLLy8rem9EZUpIYm5vRjhmOU1uQWcvL0NH?=
 =?utf-8?B?cXB5UTcyVEoyZHFnbkJKNm5DZDREUml3S0lNMXJsd2Fpb1dPU0xKKzB2UVd1?=
 =?utf-8?Q?ChipbNqPNLGhJFZXo4bmb7jP7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ad34e7-218c-47f3-19c6-08dd918a1b6e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 19:20:50.9980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SqA5AvdoShAYG1dCeh20VBFLow27LTXSMNqidbMj7r/TCTZCcB9xF0Y4oaUsuZp4VmXRQjWaEk2QO3yNNi+rOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8663

On 5/12/25 13:05, Sasha Levin wrote:
> [ Sasha's backport helper bot ]
> 
> Hi,

Hi Sasha,

This fix only applies to v6.5 or higher. I thought the Fixes: tag was
enough to determine what branches to apply it to. Sorry about that if it
is not the case.

The linux-6.6.y branch should have gotten my modified patch as described
in the patch description.

The linux-6.12.y and linux-6.14.y branches should have gotten the
original patch.

This patch should not be applied to anything before linux-6.6.y.

Sorry for any confusion.

Thanks,
Tom

> 
> Summary of potential issues:
> ❌ Build failures detected
> ⚠️ Found matching upstream commit but patch is missing proper reference to it
> 
> Found matching upstream commit: da8bf5daa5e55a6af2b285ecda460d6454712ff4
> 
> Note: The patch differs from the upstream commit:
> ---
> 1:  da8bf5daa5e55 ! 1:  9bdece442510c memblock: Accept allocated memory before use in memblock_double_array()
>     @@ Commit message
>          call must be adjusted to specify 'start + size' for 'end' when applying
>          to kernels prior to v6.12.
>      
>     -    Cc: stable@vger.kernel.org # see patch description, needs adjustments for <= 6.11
>     +    Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for <= 6.11
>          Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
>          Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>     -    Link: https://lore.kernel.org/r/da1ac73bf4ded761e21b4e4bb5178382a580cd73.1746725050.git.thomas.lendacky@amd.com
>     -    Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>      
>       ## mm/memblock.c ##
>      @@ mm/memblock.c: static int __init_memblock memblock_double_array(struct memblock_type *type,
> ---
> 
> Results of testing on various branches:
> 
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-6.14.y       |  Success    |  Success   |
> | stable/linux-6.12.y       |  Success    |  Success   |
> | stable/linux-6.6.y        |  Success    |  Success   |
> | stable/linux-6.1.y        |  Success    |  Failed    |
> | stable/linux-5.15.y       |  Success    |  Failed    |
> | stable/linux-5.10.y       |  Success    |  Failed    |
> | stable/linux-5.4.y        |  Success    |  Failed    |
> 
> Build Errors:
> Build error for stable/linux-6.1.y:
>     mm/memblock.c: In function 'memblock_double_array':
>     mm/memblock.c:460:25: error: implicit declaration of function 'accept_memory'; did you mean 'add_memory'? [-Wimplicit-function-declaration]
>       460 |                         accept_memory(addr, new_alloc_size);
>           |                         ^~~~~~~~~~~~~
>           |                         add_memory
>     make[2]: *** [scripts/Makefile.build:250: mm/memblock.o] Error 1
>     make[2]: Target 'mm/' not remade because of errors.
>     make[1]: *** [scripts/Makefile.build:503: mm] Error 2
>     make[1]: Target './' not remade because of errors.
>     make: *** [Makefile:2013: .] Error 2
>     make: Target '__all' not remade because of errors.
> 

