Return-Path: <stable+bounces-54849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5566A9130EB
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 01:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D8F8B25136
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 23:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B1216EB76;
	Fri, 21 Jun 2024 23:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4c0VLx2U"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB9F16E88C
	for <stable@vger.kernel.org>; Fri, 21 Jun 2024 23:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719013769; cv=fail; b=ZgCMzuC0F6E7GKStpYqYyt4s8CvwOMgIKPZ1ur5rAxOrtUwFMwCfxQVZXCLTfHmUy86RzsalW9J8w2UOehYQPgwcoLjAvmBCEXqvDxI5hPnEqbPU7bHAgJOgf9Mwg2XnnEEaAWP8jaNiDUK3Eec//DmtwpWBHn/sODF8tr3xWfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719013769; c=relaxed/simple;
	bh=iP6mpFpLOG4v3X2MMQxpl58e3PthmnMtm048SQJm3As=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KIlAelH1KOBLm+bBMHdVBXIfPwJS0lff3dQnAm7SCKlvhfHeRfXUaQXBQ/ppbhEZx3UL+isTQDYLnJRBJUKZRJgZkuciGP8wJsIHXdVdamFYMSsWGTCahDE524dMsK9DDbTIYAp0WBwSs1A82U2Sguey3BqyArhakVQugID81r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4c0VLx2U; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NaKvvH1doPXtQHm6jwL/vRsWU2TS0D1uvRinPYEvouRBytqIzh8Bivj3Y3lkG/FeYpksVMCu0l5hjAWCHXotKWz5vQWA6ctdh2djcoXfdcIwux+6ofVIVW4ubw+lAZCaYdFC8Mdz5gP7ENdO582lhuCpjt0w6Kw/jDtbEincf2CLSE5oj9jrYygEekGB5dKzhrN+Hp77andNRDt/k7Y9R+vtLDHOHGDH+0714+vFT39H7rsNYB9DPmn+sKmqtvJTHkWeM+CjraaRsS7xUgesTo6O9QW7enH3+VxGyinsi9Z+9BilgSszb/cfO526BYdaGGvfYMZ3igaIBJKG7SDLFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToUYDTF+Yb8359vszqSc3BSWtjdRTqtKCquUTsyuBPM=;
 b=mOhrhPoCVTfevEiw7QIDC3CdQpUckhi7i8IO6LNfpT9EA5s8kkWYCntOeuIFxsk/FOU3phz9HVM8gAPrHS2Fr9cOTjr11TTLKW6JT4310G0c++06L6aCu/0nBcRMB+hqfpHZZj4VP8anIRH9iy4MpHqcuM/zu3TQnZ7mR/BIGYbhKWs6B2YiVAZZ/sCXxEexMadOJ4MFPIkjqjk2Y7J3et/Cs8n8aq9GDnlQyLYF+BoZvQ1emgokdb9TNjSftX+vf/BQ+LqWad+bkgv7yjQ0uQft5lG1MUz3qc5uujMz9AR5UYLy9rQQn62huijrxX79Q7ysBX6DlIoPAHHzSDdKUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToUYDTF+Yb8359vszqSc3BSWtjdRTqtKCquUTsyuBPM=;
 b=4c0VLx2UGQMuxSLrlq/VAptkLV2KA0CaKYNFzqs8DzXXKBfH8bn1kEej+3lCufBncskhHMwLSB9tZmpNFOZu3+GAQtJR8F1STMLlm4Q7oRzSBF1TfhTOyqQwj27s34nu/tcLRkzgBkn0tjUso3K+Vd+Tu3T6xINr2EZjKo2Ra94=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB6918.namprd12.prod.outlook.com (2603:10b6:806:24d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 23:49:21 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 23:49:21 +0000
Message-ID: <fe2a917e-754c-4990-9c3e-796412b47466@amd.com>
Date: Fri, 21 Jun 2024 18:49:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [regression] x86/amd_nb in 6.9.6/6.6.35/6.1.95
To: Yazen Ghannam <yazen.ghannam@amd.com>,
 Andreas Radke <andreas.radke@mailbox.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <2024062120-quilt-qualified-d0dd@gregkh>
 <20240621232911.01b144f3@workstation64.local>
 <20240621215656.GA20274@yaz-khff2.amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240621215656.GA20274@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0025.namprd11.prod.outlook.com
 (2603:10b6:806:d3::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: 64fea0bb-0fb0-4ffd-a1d1-08dc924cc5bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2YyemNCV2dLMFBRZGI3ZmRoZTh2aWlMM3N0YTJRVWhNdUZmYWdpU3l0cjVP?=
 =?utf-8?B?T3ZiZ3d0S3dVWVNOQmgxZUdENTNicGNQcWxtSmxhMEk5cTZCR0ZhbTYvNmFN?=
 =?utf-8?B?SkVmU0UwSGhldGdRTmYwRUVwdjlCNzkvRUVQd2lhMXFjaVJ1U3pkQmRwVjFl?=
 =?utf-8?B?Z0RCbW9iVG1ackdiandBRHh1TXV3UWszWTlMSXBJd1ljOHNEZm4yU0lqanFC?=
 =?utf-8?B?aTVnYkwyd1JPQlBDeGNHQktVdzl3akdsQlN1T3oyMjcxV3RxNTJ6TFNyNUV1?=
 =?utf-8?B?S1FrbU9JUC9QZWJHZkE0dHdaSk5xMjlCaUk4dmcwWUIxbCtRd05hcTVjMHJx?=
 =?utf-8?B?V0FQd0gzbUozVTAzT0RrM1NINE1wcE93dVNEd2l0OTl3VDdJSnZWNDNmdzFL?=
 =?utf-8?B?SXRxbWFNd00xMnQzMHlKb1ZYUVdsRlhLMytwUkpWTlFiZ2lCWnZEd0lid0U0?=
 =?utf-8?B?TmVZbG1veVdURjIvVmNmRWplc3VBQTdKaldldy9vbWdISndIYXJ2Zk5wYzln?=
 =?utf-8?B?UitKSHRuQ0FaV1ZLUXcxazNRMjFGVW1VQjRHMjRjRVM5USswZUJYQ3BMSlQ0?=
 =?utf-8?B?Q1B2NS9HUEh5QTVubnprSzJKaE9GQTN0L0ZzS041ejhjSWJLemg5Y3pNWUlX?=
 =?utf-8?B?YXN0MHpDOFRPS2hMUDExQ3pXQWJlQUlRSkkraDh5cGJXSWpWTStvOG5QM2R6?=
 =?utf-8?B?WnFZWlBZNU1ITmFBMGx2RlcwMHY0OWluYWZGV1RsRW51NnBKUU0xV0hsTE90?=
 =?utf-8?B?eUxXRHdMZVQ3UkZnazREZHdCSVFHUktJNFQwRnNKQTlQanRSVUcrNGFYQnFI?=
 =?utf-8?B?MjMyRjZmendSRGJVdHR4SFNha1NPcUdHOWF3ckE4SXh0ZWRSdm1zcUhGbGEy?=
 =?utf-8?B?S2d0M3BqVXpyY0RMVk9McXAvdytncmVJeFZrSFAxbmdBV3VCSTYzSFBmcUxE?=
 =?utf-8?B?cWYzb0Mwd04zYVNjS0hJODJ4LzFTYjF6eUsyM2RTejZBQXNFL3Fybmt0ZGN1?=
 =?utf-8?B?a2ZHa2l4MzN5UE1KNG53K1JLN05HbkpYUVdxSzEwTXZIbkt4SW1MQlFzalJt?=
 =?utf-8?B?cWZYMVRlOENxNHBmcERKS3hhc3dnSUs4S2ZlRXFGRSt3bGROcmdYRDdmekxr?=
 =?utf-8?B?WW5LdkZMNXNidXVXWkNpTjJxaGhncW8yM2EzWGcxOWZUT2FNM3Fjd0lPdGVK?=
 =?utf-8?B?NGdhQ1E1dGJCQktESW1Hc3J2Y3dJQlBDQkhadktPdTdaL2hTZGRFQWNPc0Y3?=
 =?utf-8?B?THhHYVVyemF5K1VWbFh5bHBUY2RxL0FjRC9TaVJhdTVuYjJ2OGJJdFVkeEVw?=
 =?utf-8?B?ZGNuSlU1ZXdNVGtUOHRLcU5aZ3pxMXlZOGQ4eFNjSUF0QnkyYWlGTjAxWm5B?=
 =?utf-8?B?TWVPeUNYeUpLZGkyd21ZZ0gvdWIrNVpQbXgzUDdwS0RTOWptNXg3bC9FOWVm?=
 =?utf-8?B?TUZsekVCYUhudHMzV3dKOXpSbnJRZXF3QWZSLytlR1JEb1hlQmxLc2VDbjU2?=
 =?utf-8?B?L2NZRjlEUGgxT0MveFlMVnR5WEpmWExLQ2E4ZFE2dzZnY21ZL3BLS0RERW42?=
 =?utf-8?B?c0N4MEpqdTJWeFFYN3hvUXJJVzVQRlp1WkV0NUZJaVBwa0NaQ0dkTXdmb3F6?=
 =?utf-8?B?bm5LUDUwTkx5Q1NxclNORnFOR3FmSXZZbE1pMXNzenE0K3lPU1RNNEJNcmgz?=
 =?utf-8?B?R1VET3l3MCtXTHhhNSs1NGFyNno5aENNc3V3Y0tsRXVOSVRKUzNFd2tBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Skg3VG9GWkE0NFdYeGFYbVlxZmQwQlRtRnpsdUVubEYvSFdQZTExLzlCdlRM?=
 =?utf-8?B?NlBhYW5GT3Y1Um0wSitrNXMvVmFQMkZQSERlSDJibHYweFVLb05STmNjdTZa?=
 =?utf-8?B?UWJDcTU4Wk9rNzZKZjc3L3MxdGR4OXFpYmZuaGx2Ung3SUFYL1BaZlRTcmhR?=
 =?utf-8?B?T0RXR2hMc2pEcSs5T2NNNWxrUVVYY1NuVUdmRzdEMGRGSGt0YVg1UzRoMnhF?=
 =?utf-8?B?TEt3ZTVoZzBxYzQxcTB4TVd6dFZva3NqMHVBMk5nWElwTzZWZC9FYjlITTdk?=
 =?utf-8?B?R2gyamxqVHcvSWYxVlJwMFhZMUNVaGxhQ1dLNE9ydVJ5ejJZYzFnbVVvVTY5?=
 =?utf-8?B?dzBvcEdXQVBwU0d4a1hpUkwrNTBLNUdUL29IOTBGbDFockxBQ0FZQkpUeGlp?=
 =?utf-8?B?Mmx1U1p5REpET0hWejJLU1duM282SU5uQzJ0L2VMY1BzOWQreThxSHEweVh6?=
 =?utf-8?B?d0lqSUk0cWNiRE9lSWowb0FjTVpITlQrb3lsdGlxZnFlOVV1cjg0Z1ZPeGZv?=
 =?utf-8?B?YjNISEZiY1IzNkpjYUFHdFF0cG8vN1NhSDRtMExlL0JiTVl2dmpGT251SlM5?=
 =?utf-8?B?VjhXUzVlSk55N0xOVHhvSWY5aDlBNDNrcnluemZZUEsxU2FZdEl3OTlnVFBP?=
 =?utf-8?B?L3RCdklSQnovb1ZCaTdrakJjNjF1ZVVjMXVPTkxOclA4WXp3NHNYUDV5WkRE?=
 =?utf-8?B?RnQ5RmdyQzNxSW1PbTZGb3RldnVPaURpbmpjd21BN3J4YWlOZUZka0dndEVK?=
 =?utf-8?B?VkdqeHEvcjI5RXBqRHl1eG1lODdvbmVDTzRyNEpvMk1VZ1JSR1cyRnl3VCs1?=
 =?utf-8?B?QVhoSyszQVZHdk1YRkhManBIWkcweFJEUHpTUDlMLzJiTFhwK3RBZFpVaEs3?=
 =?utf-8?B?V2I2dU9KdXdGRHp5WG5TcWUyTUd2MFJMWmpnbG1waFNJU2NpRkJOTEJlQXM0?=
 =?utf-8?B?dW50c0c4QmhYNk41WkpzRTkzbW0xdUpzSGtkb0hWTVptaHBucFh4WlFpaDIw?=
 =?utf-8?B?Z0kwMk9FNjF4WmFQeEtoakFIeGIwZ2xnN1djYS8xNDkvTjN1Y1dOUlVESVRv?=
 =?utf-8?B?N05CQm4xNVkvam9aTUg1TWREVHNFZFJPZHl4MFlUR0t6L2txb3pTSXFINFJH?=
 =?utf-8?B?VTVtK2JGVDlSVzVaQzFLU3BVaEJIZU9jWkRLZERTclluaGY4Q2RDS2hGK0la?=
 =?utf-8?B?WWZWeDRUVFJVSS9GMitMeC9IMTI1R0M4OTRkYkM0bzR0K3NNWjVNWDA2a3Fu?=
 =?utf-8?B?QzRtb1dqZTBSYlZKSFk2ZGx3c0JxUFRiN1ZvWldYR1o5Nm56SWwzQlVkUmp6?=
 =?utf-8?B?WWdBWWx2emdXY3hpc3RBdlFMVW4wNnVGZEVpSFEweHoxNHFEaVkzMUVRa2Vk?=
 =?utf-8?B?alYvbHlDWUI1QlJTZzI3YVU2N3MzbDJQMjN4QktGdDdvcGlJblpQUFFBVE1U?=
 =?utf-8?B?U0s2K0NvVGFJZEpmbldYT0hwRG1Yc0lCelJJRUt0eGtSVGZRcWtwaE5NbkpB?=
 =?utf-8?B?N0Fvb0l0U0JSSk10SWdSWVZ1WHhuUTJKcFB5OXVkNXY4YVlRalN4LyswVTFx?=
 =?utf-8?B?STloT2dIMzU1MEtZRjhXemtESWZuSTc3VE54cU9QQmdheVhSVlNDcHVGa2s4?=
 =?utf-8?B?cTNocEoxb2dXVnZxRzYrYzkyaVF3bUliZkd3Mk1xKzRvaVJTRjU0VFdRQ0dW?=
 =?utf-8?B?Y1E2MWxLbmdaR0RhSjVjSVRlVmRiZUEwRkx3aHlVOUwzaVFLY0Q1S1ZmU3RF?=
 =?utf-8?B?anBKN3poa3BRaUFyZUZYcGwxdjR3S1U3LzZNSEhISFZkVkNOcWYrSEYyNno1?=
 =?utf-8?B?Ykg2RjZyekxoQlJvWE5QVHMrVGdJSC9FTlhJa0t5U3BjWDQzNUFMMHQ2cjd6?=
 =?utf-8?B?UlBSL2FRbzUrdnlLZkloSGNQUS9DTWp2dFN2WUFacENGRC9RU1BMZzVHVWo0?=
 =?utf-8?B?ZmRYLy83aFVRQ3VXemZhSGhpNE5GKys2M3Z6dTlpcGVPSURVSjlka0F2NzZo?=
 =?utf-8?B?SGE3UVg0VlcydHBHMFJsM0VJZ2k3Q3VrS3ZhM2NSNzE3a0RicFRjS3N6VzZ0?=
 =?utf-8?B?Q1F0TU04ZVlDYmRkVVhCSkkrOTY3cnRqVEd4aS9oUURraG1LeUN2aEY4Mm1x?=
 =?utf-8?Q?JxCkIDlDmTunn+db9An6pdbb0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64fea0bb-0fb0-4ffd-a1d1-08dc924cc5bb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 23:49:21.3910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /++iR87NosONnMpvkoXwx2NtBC/DYAr0WsnxfbwmXeTinfpWqvuh3RnxMmkTaDGGfiC0SY/lWZga+s7WvbEJtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6918

On 6/21/2024 16:56, Yazen Ghannam wrote:
> On Fri, Jun 21, 2024 at 11:29:11PM +0200, Andreas Radke wrote:
>> Am Fri, 21 Jun 2024 14:59:20 +0200
>> schrieb Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
>>
>>> I'm announcing the release of the 6.9.6 kernel.
>>>
>>> All users of the 6.9 kernel series must upgrade.
>>>
>>> The updated 6.9.y git tree can be found at:
>>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
>>> linux-6.9.y and can be browsed at the normal kernel.org git web
>>> browser: https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> Subject: x86/amd_nb: Check for invalid SMN reads
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/patch/?id=348008f0043cd5ba915cfde44027c59bdb8a6791
>>
>> This commit is breaking lid close system suspend
>> and opening won't bring the laptop back and no input is possible anymore
>> here. I have to hard reboot the laptop. It's a Lenovo Thinkpad T14 Gen1.
>> There's nothing in the journal.
>>
>> Reverting this commit on top of 6.6.35 allows proper suspend/resume
>> again.
>>
> 
> Thanks Andy for the report.
> 
> Mario,
> Any ideas? Maybe something with the platform drivers?
> 
> Thanks,
> Yazen

Interesting; I've tested this patch in my own tree for a few weeks now 
and never hit this.

Can you please share a dmesg log from bootup?  Is there an "error 
reading" message from amd-pmc?

Separately can you please add a debug statement to amd-pmc around the 
two calls for:
	err = amd_smn_read(0, AMD_PMC_BASE_ADDR_LO, &val);
	err = amd_smn_read(0, AMD_PMC_BASE_ADDR_HI, &val);

Both with and without the patch?  I'm guessing one of them is (~0ULL) 
which is exactly what this patch is actually looking for now.


