Return-Path: <stable+bounces-53654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FA790D7C2
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 17:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF271C24AAB
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236E040851;
	Tue, 18 Jun 2024 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZRdoZNeN"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D9913A864;
	Tue, 18 Jun 2024 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725749; cv=fail; b=jtg/MALZrtrtcHeOT2wXazAfqYe5OznDEy25GHznHv55NOgiAWRfHxA5OUXzROii57Dk8+0F9YjjZAjoenEu9MGn7iPCD/U2g7k5+pbA4Av51kyJIyjZXYSzGgaJXU5xj1fXZpyrVqSKS58h8ntTbk80IrOpvv4UbOByo+3atnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725749; c=relaxed/simple;
	bh=5UlR128cz6yxZu27Op+++QDbJr+wZfYME0KAcTKANmQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hmEdzmSyMVTE/+R5AgmSggM6tV8ZaEYz7kanKLa8EyutqoQ3qwhE5Xi4AZdrvV/IKkDA336/TozBdD/bUcNUuduz3uShuqx6VqnLH6JWt4VOsLprKwhpYWE8AT04X2vCkZz1wfApiKpGThZHQrCWiHuRF8E96Ejk/2EbHuL5m4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZRdoZNeN; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fa1LeLOo7DggQdQrFalzubKGBvS7SLEYJW5luUjiN5ajYKs6VMIuxyHto0TQ+33eNcJT4RMVPJ8ShBaOTC6j6RtFToAO0GF5p301gHTJslFi0J+WDSgzvUsohAuOkFj8Sw6hFcGHxZ41PPjAFYDZDGls9HjTpydZ5DlBvqBJjin1RcfVVfJryGxwLRaBHwhRhiodUfN1h1Q3J/pkOfVSoH/22ShNn+b4cHd7WjxrIVejUTuHadxbGEjBxeqVkEsFCTVhO/bP4Ld2HUEQ4lh7+MSlQ2PfLnpnUKGWMDoOZ01gsVjHGdXFS3Xe/w36K/WEF9puOijiKD+04MHnnLPvMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLXM3VHq3ftiVeMXLoSVHg1EUF96DCy+GoRr2j4et8o=;
 b=b6cjRwG9Q+horTSzdgJ/vb+nkitFDeAV7dxrxgIdeFGK9spqJO9jdyk8PhegCTnZm4kuL254j7l2sYHSFKKj8YXY8s29pZTkYuNic+iZHN4q2TWzDGdfAVEAM6Oh9Pzph4F/4Vz3tJL4yINI+tEcXhHseV0lnjeJVm5yTEsX8NU9AaA9WcsxNZvcroHfHIb70Sn4Wkhf09qjGkZgwMBJWgJmQVRvJ5Z+1qu05KMfkzaInoWGU40d5W9qSQ+BVsNQIPkC2tSqW35HcJyb+BRcXMphDe/ZbUjG1CF2uzcs0Keij50EMmKf0lWMGVWgcC3FJusCcQHRAWdx04zDnXTI9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLXM3VHq3ftiVeMXLoSVHg1EUF96DCy+GoRr2j4et8o=;
 b=ZRdoZNeN9/l4Nr7ONVbEOHqlPSEI0mT0mGoUg/zUcza020ObB0irK2Zd2xMBRcb3M9H7OYFRQfN9/2ei2dbmcWh3tSKypOIT4i+e1+0/gxS+rguelXjg5GNmHWRzk39g4dGSfZBWW32wbPp2ILlQ+CDwwU6xAVI6jH82DCwMx1k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB7342.namprd12.prod.outlook.com (2603:10b6:806:2b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 15:49:04 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 15:49:04 +0000
Message-ID: <147622bc-66a8-4213-a416-2d6ed469d839@amd.com>
Date: Tue, 18 Jun 2024 10:49:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: ahci: Do not enable LPM if no LPM states are
 supported by the HBA
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jian-Hong Pan <jhp@endlessos.org>
Cc: stable@vger.kernel.org, linux-ide@vger.kernel.org
References: <20240618152828.2686771-2-cassel@kernel.org>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240618152828.2686771-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0097.namprd04.prod.outlook.com
 (2603:10b6:805:f2::38) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: fc52e326-c378-4c1f-14de-08dc8fae2dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVVaQVdlbU40bjBOQXFLa01YZmdoUW0wS2JoM0trSHhhcEhsbHJtTEVaTm5Z?=
 =?utf-8?B?L3grbi9sSXpDam5LM2xyWHdoR3poMUYrN3pjaVpMNnBITFhiSDBmMy8rdjFj?=
 =?utf-8?B?a0E4N3RDMzE0eFdSdTN4TE1Tdk8wd0dwcGw4ZSsydFRvRlUxVHhTbnBHQngx?=
 =?utf-8?B?djZjK21QT0JqK0xtRWNOL1JlNElLZkNoTnpXU2JXV3NPcVpyazVHTHFBVVB2?=
 =?utf-8?B?SHBXQ1ZZZm9NN0ZyRCtGdGF3Vlkrblg4QmpVL3Z5U3MxR2FEMUpWUWZ6UStC?=
 =?utf-8?B?YldUOFEzM2gvbE9ab1hRYWlqaStRSGFVenpYTEJXN2RlT3dsekNiY01HcHR3?=
 =?utf-8?B?NHk5bFBUZmxBcml0dVcwclBaaUNoelRvNS8zQ2NiVzIzS3JnbFQxTmJYdXJW?=
 =?utf-8?B?clhZQVc1SGRsVWh4NFFscjdBSSswazl0c1Q2UG8xRDA3dkNOK3Q0a1Bzdk5Y?=
 =?utf-8?B?d3RIT2lOZFBUY3Jjd2EwNFVZcXlVY0RKaUhZZitSb1plU2xvOVVuZk9odkFI?=
 =?utf-8?B?amxqbjd1Sjc0UkFhNUkvT1RacG02OElwSGlEUFdxb1o3WENMSDF0SzdCLzNv?=
 =?utf-8?B?VzZjK2d3UmdwbTZVbnpYNDFZZVRyUjUvK3djRUZZclBJZkNZcjBvbGREanlu?=
 =?utf-8?B?VXNNaU0zd0R2S0l5NkREb3dFQUNza0Qybkd4bVdZUjFuck9JOU9SSmF1OFhU?=
 =?utf-8?B?ZEZhNmlyRCtOcTJvcExOUkh2YmNxYlAvLytqT1JKZnNScW4xUWhGR2pIbUVq?=
 =?utf-8?B?cE1iY0YwN012alVJcFhXZmZySStzYU1sWDU1Q1ZVOW5Gd0doMUU0S0JWUzc1?=
 =?utf-8?B?UFUzU3J6ZEhWblg5dVRXSzVKSHRXOUZ5NVVzOCs5NDVSVTBaODJldGRDc0pR?=
 =?utf-8?B?U083Vlc1OWFBTXNFWTFNdlNwOCsrcEUvQjYxMFFvcnkyUE0zSEdtbTR4WEZ1?=
 =?utf-8?B?RUg3ZVBkVmFPZWMrR3Y4cG5BdVdCTXdSM3lKelFKWFQzcm1pN25kVnh2YnBq?=
 =?utf-8?B?ekRrWWF2U0Y0b1BoWmVRVzJNTjNkWTc4aHk3SWpVVE1sUUtBUkl3Rmx4MlJz?=
 =?utf-8?B?Q2RsSS95Z3pDdDNod1IxTGN1NDA1ZHpGZjh2K1ZvNmF3VnpFeTdBbXp1dnRV?=
 =?utf-8?B?YTltd3FIbnQ4TTJrU2M5alBYdGVlTWttMEpjOS94T0Yxa3ZMcERyWktFcytt?=
 =?utf-8?B?amd1a0IrekUxcmd1QStkYWhMQkgzR3QvOWNHUExGVXVrMVkxbnEvT2dZRHNp?=
 =?utf-8?B?TU9hV1B1Um03SXNtZ05Pa1k1RnJUQk9lWlVJZjNDejBsMlIxYUJlRW10RHFp?=
 =?utf-8?B?Nk1TdFc4elozcEo1ODlCd2xPRFpacUd3VHpTc0hyVFd5aGJUdW5VT3YycUY3?=
 =?utf-8?B?SU5XWmI4TEpSZWdGQmF5QUhmbk9mV3dSeHVyK3VZTEtkZXc0WEhPa2xoZVh0?=
 =?utf-8?B?TCs0eEtyL1JRckUvcjAxb3RPUVg2K3Zmb0tCSjRMZlc5U0RnOElKdk1GU25V?=
 =?utf-8?B?ZzlmV3VQcVJ5a1hrNEY0OVlobndSVjM2NkZaZzhjV0g0NUVMc2dqSUcrUVlN?=
 =?utf-8?B?NDFEbXZUVVl4VStNOW5JWDZnN1AxNERlVE9lS1dySFAzSjNHd1V6VEJ0eGgv?=
 =?utf-8?B?TG9oNFVrc24rSXlPUS9ZdkQ2aXRRdzNwZDg3TkU2UytVMW1QMlVrQUR5TzlR?=
 =?utf-8?B?UVdaeFZjaTg1QTRhZkdhSlJUQm40VXdDbXdVR1JCQmhJUVh3TXZPd1NaVmdY?=
 =?utf-8?Q?/xZMz1/RYyOGFwNpt86d1I2wKECexOQN/RikfN9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGQ4QS84WGI3T2ZGTkpYaWdra0dnZGJndUFvNjVXdkk0VXRFdGR6Sm43U3Zv?=
 =?utf-8?B?dnpxQjFxajl0RGo4R21Wbjh4Yi94QnpNZURCaERUeW9MTTRZRFVVOCtRRkVa?=
 =?utf-8?B?RmpoU0l5bDRvQjFsRTJtZXUzTkpQaXJsTzV6b24vNkcxT2ttUTBaK0lqVEM5?=
 =?utf-8?B?emRoeFRnQUkyOU52a01kaTZzOTZTSzR3UHl5eUNyL3VvbmdTR3k1V2FNRDQr?=
 =?utf-8?B?RHo5V2ZLc3hDQVBKV3U1NjRPcVp4ejA1V1U3bWFGdFcyZ1laaUt5VTRDcGt3?=
 =?utf-8?B?VERHd1d2czJSeW40VTNnM1lkSnBWZUpQQzZWUnd6S0d1SXVxanJYYUVTVFd1?=
 =?utf-8?B?UWkybmhMWkR6M3pHUkhwUC9WSU1DSDV6bkdkeTRTQlU1OEtma0MxK285OVNF?=
 =?utf-8?B?ak1FVXN5dU1DTGNlWVlpa3RNSFNoZ3hMaHl4SWJUd2tUaFJkRW5tbHJxd3pt?=
 =?utf-8?B?akt3dzcrbGIycDc4ZGlLaGhlMVF3OTlxTXF6Q21xZWJPUDIxZVN0NjBFdEpj?=
 =?utf-8?B?TVdrT2pBeVpPWEVVRUxCc05BRlg5dnRCSFNCbGN4cUxuSFpLWDBOcmgxaURZ?=
 =?utf-8?B?RiszU213S0daUkNhQVllUW9FZTRtdHF5K1ZpL0p2MHRXQnNtZlcrejM4eUFs?=
 =?utf-8?B?WVlGakljOE5zMEVRVEtrNW4xQTZQOXArbFlaZEs1RElnU1lPbmFnVGZDYitu?=
 =?utf-8?B?QXA3aURCZjlWWW1wZERiNWVmYnBrK1pWTjErWEs4bzM2WEMvMDQ0NmtLc0Y0?=
 =?utf-8?B?ODN5UDkvOXMza0xYSmhCTlErQWlDVjNscWozdHgvd3VZYzNqVEcwb2s1V1ha?=
 =?utf-8?B?Z0t3YzA2c2dNTDhXN0oyOUNyUjJzVTBVWU84eDFtR3VxZ0xZWm5DTXV2UHZY?=
 =?utf-8?B?b2dqcXZzdGNIUndrY3VqQzBVdVBjMHNuZXFBR2cvdUlKRGZnZG9KTnVnWVdJ?=
 =?utf-8?B?WDUzQzA2Z2NtTTBFQmVqSlh6a3VnY1RpSnRqSnBUSU8yd0k1d1BiU0t3UXM5?=
 =?utf-8?B?MkhRWEhWTlNrcVUxSVdKdDZwMW9jZWhSWEcwL1F4cUx6cGRNdzBvbTYrZjNu?=
 =?utf-8?B?NDdZbDlVU24vdnVTUTJqS2o1OXhlSEJsczN6K2tDU2x6RXA1UzZTdFpqNDhY?=
 =?utf-8?B?a3hXUVNEMlN1VW5XK204cGIrbzFwRjQrVzhxR3RRdTRTajNqMHMyVW9kL05F?=
 =?utf-8?B?cFBKL3lWVGZJOFRCdHMxSzFiSUdKQWlXZDRDQ2ZkeVpPa1UrdzFuU0JwOXU0?=
 =?utf-8?B?NENsRWtVVDhPczRkbEZoY2huZzJhU3VUMmNhci9YSmJYc2Z3VlEyUUUwbHB2?=
 =?utf-8?B?RGVETXQzUWpaTmhCbWt1VnpkeTF0ZHR0OEdmeFQ4Q0FLVHFxUnl6ZnVzZitx?=
 =?utf-8?B?SnhwQXJCb0tHNDFZWFRUeEJoWW9uQnlHUi9NMDIzVEhCN2QxeUZPbXVkMjRj?=
 =?utf-8?B?WFJkTkV4Q3R5SmZNSEQ1UnltRURLeGx5LzhUMUNSNFM2NFhTY05GVEdxRDlW?=
 =?utf-8?B?Q1VuR1I4VURGRitIbHdDVU1Ua0o1QnRzbHpQcTdBM1A5NlFXNlh2TUEraDls?=
 =?utf-8?B?eWNmdWhadnZZLzFpdXhuemU3NUZ4Q2prMVJpUE1vclpOZ3YxUlRvUkJyV0pr?=
 =?utf-8?B?K2QwR2VSWG8wTFFwSlRTVkhHbUc2clcrWXdqMExDVXI0Zlg2QVo3bUs5ZWlp?=
 =?utf-8?B?S2JXVE52SXYra2ROTjVGQlVLYmRyaGhNL0lNYnpMbE0reHM3bXg2U3ZzWVRS?=
 =?utf-8?B?RDNhVnN6Sm9lMzZ1OGtMaWpWL3JMWDBlNndxK3VRWDJsVVF1dTNSNHZraFZU?=
 =?utf-8?B?dlh4RDdiZEwrR3ZJSnVPYXh1YXFWVHRkRlU2WlpBYUxOM1A5b3hMRHpkWElh?=
 =?utf-8?B?VzBpdzluM3ZHbVludkhmRC9XbEY0Wk1RVHA1OVc1T2xJK0JqQXN3TVQrU0FE?=
 =?utf-8?B?YnNjSmZ2aHVyUTJXc0FUSUpSbnFJT3dTenNlNUFyWmowUnVuTnhiY2x3Nndm?=
 =?utf-8?B?cG5US1dmaGJHU1ZuRjBZY3IzUExvQXVXZTZ6ZHZYN1lpK0lzaVRhOTRaaDVU?=
 =?utf-8?B?MW5jQUJYSjM5cUNEMXpKR0xVMHU3b3Y2ZmFrc0lPTVRoS2MzYS9tby8rL2FP?=
 =?utf-8?Q?hPr555U3jw0vt+yEAmUD3wzpi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc52e326-c378-4c1f-14de-08dc8fae2dfd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 15:49:03.9928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNimHzUQcjYOMSe9LOzi/aai1L6mA5bb3QLh1KHY68CsWJQL7ECndVBp+489eUTulpg4w3rOMhisyuasprh0Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7342

On 6/18/2024 10:28, Niklas Cassel wrote:
> LPM consists of HIPM (host initiated power management) and DIPM
> (device initiated power management).
> 
> ata_eh_set_lpm() will only enable HIPM if both the HBA and the device
> supports it.
> 
> However, DIPM will be enabled as long as the device supports it.
> The HBA will later reject the device's request to enter a power state
> that it does not support (Slumber/Partial/DevSleep) (DevSleep is never
> initiated by the device).
> 
> For a HBA that doesn't support any LPM states, simply don't set a LPM
> policy such that all the HIPM/DIPM probing/enabling will be skipped.
> 
> Not enabling HIPM or DIPM in the first place is safer than relying on
> the device following the AHCI specification and respecting the NAK.
> (There are comments in the code that some devices misbehave when
> receiving a NAK.)
> 
> Performing this check in ahci_update_initial_lpm_policy() also has the
> advantage that a HBA that doesn't support any LPM states will take the
> exact same code paths as a port that is external/hot plug capable.
> 
> Side note: the port in ata_port_dbg() has not been given a unique id yet,
> but this is not overly important as the debug print is disabled unless
> explicitly enabled using dynamic debug. A follow-up series will make sure
> that the unique id assignment will be done earlier. For now, the important
> thing is that the function returns before setting the LPM policy.
> 
> Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> Cc: stable@vger.kernel.org
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Changes since v1: Add debug print as suggested by Mika.
> 

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

>   drivers/ata/ahci.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 07d66d2c5f0d..5eb38fbbbecd 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1735,6 +1735,14 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap)
>   	if (ap->pflags & ATA_PFLAG_EXTERNAL)
>   		return;
>   
> +	/* If no LPM states are supported by the HBA, do not bother with LPM */
> +	if ((ap->host->flags & ATA_HOST_NO_PART) &&
> +	    (ap->host->flags & ATA_HOST_NO_SSC) &&
> +	    (ap->host->flags & ATA_HOST_NO_DEVSLP)) {
> +		ata_port_dbg(ap, "no LPM states supported, not enabling LPM\n");
> +		return;
> +	}
> +
>   	/* user modified policy via module param */
>   	if (mobile_lpm_policy != -1) {
>   		policy = mobile_lpm_policy;


