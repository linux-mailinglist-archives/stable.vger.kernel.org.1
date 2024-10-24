Return-Path: <stable+bounces-88003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9049ADB36
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 07:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088C41C21A67
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 05:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B07B157A72;
	Thu, 24 Oct 2024 05:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JZ1nisz7"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E7A1C01
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 05:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729746268; cv=fail; b=CTUCzeNQHZrrHmW+/7g9trwHD7yx7LguY1k5G2qMrYs3cTDsgyOKWdizmkeOUp69YWvFlNOhrxvbo3A4PJ6nFroxgTElyARyLh+alcPj9EN1Aml9WiKJkdI2EGnTgd3Ff/Y6C+l09lPllUx4mepyl4kIu8HMcrkaJtyPHD7wfwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729746268; c=relaxed/simple;
	bh=c1h1lORdaYd7RMOBopu0XsplO3j0dE+p2c7mgkTKFsI=;
	h=Message-ID:Date:To:From:Subject:Cc:Content-Type:MIME-Version; b=NX8L5CZ51pi984EDbmW5FpsG/KmCNWpKc48X0vK3FSPV/blbkWE3fqO1QEQwjiw9IUZcOLVYvZq3iktOZ+vQ+MzDOSjcyl6kp8ZlqNU6AAakr2/5Tss9WhoMQramkMBfE5h6psOMw8KQClPV5Hax1Eihn05kwxvm1Q9lM8IiOXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JZ1nisz7; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VEEgO0SWj+4Nsdt4AGoVOMqQhBr8ETdqMvTJxTBAfY8tiYpUgG5As4PbeQDTNOY1DDZWU+OkIThm65D19FGE3nLYWFMmJujMq3k0f1gcCbxVuoXXl87SJ9WGWv6H5qwXPjKi49NyiqN5Fm26vp2+yPg2S3vrNvTeuA4vFAQjQPdiW/bPsloq0aH0lXtnvXrKBVVHn64k0fcn5jqAQDdkwuHjePaQMEyI99JF6MB0aFGJRi6Xh65IvK1B5WKUSre1sO401K3kyM8O4Z3suz5Fdx4LtOgJWrUaWeTJRQ85ufmc93ysbKnqD2B0Pw4TX168xPJ9ToLGBtTd65vM6sDs6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qExd++29xoPTGq++GZVvR4hC+dgUJ21MridEicg4bfY=;
 b=Q9QbgCOVA4YNdyM5WEi+PWu+3YWVVmT75HI5XmtBOvLoSn17t0gtRYvx7kyqrh1wqMqBp6Fz2XBx1JaasOcMLoWrgTCP29B+qAllJ9k7jv5o8rdwaKb6SUxF32EwDDq/qg2UA6/8Nj/dwJegUaM/ePB7OgCQC2uWY0Dx9tkunA2vckmVWSx0xVKrpNgGA8KArcrcfEQFJ/b8jE45swp01a8ZD6IO9sM8ZjahSK0UOXEMwy270NMwJRih4t8sVB4WVDTODMgi+5pAdjGJFIcGK4P8+O1Dn0xEn3GAPz5T4Fer+EnbY/Bc5WEoyCYN26pSdv8oOwynSe+O2yj/FcRoVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qExd++29xoPTGq++GZVvR4hC+dgUJ21MridEicg4bfY=;
 b=JZ1nisz7LZ673sW/+3bKWXN4JeCQESr8RWD6Q5g8KL5HwtkaBcxhaUaVEiPoJDM+iQM5kMx5saYj1iZys9a5qoYSGjJbecNQumqT+D/G2hD3h+ImHemq2hFY+INlfZoKOI9zdMuUS/jzXap7z708dpfRxV+TUzbXi9aPkxFivIM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by MN6PR12MB8589.namprd12.prod.outlook.com (2603:10b6:208:47d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Thu, 24 Oct
 2024 05:04:24 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8048.017; Thu, 24 Oct 2024
 05:04:24 +0000
Message-ID: <fb8f9176-2cf8-4bdc-a8f9-a1b96e49c9b6@amd.com>
Date: Thu, 24 Oct 2024 10:34:15 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: Request to backport a fix to 6.10 and 6.11 stable kernels
Cc: peterz@infradead.org, mingo@redhat.com, irogers@google.com,
 kan.liang@linux.intel.com, tglx@linutronix.de, gautham.shenoy@amd.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|MN6PR12MB8589:EE_
X-MS-Office365-Filtering-Correlation-Id: 552929b4-4b36-4a25-0ef7-08dcf3e953bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDJ5QTkrUjBMcWwwK2xzNlg5MnpadCtLZFNnN3ZPTkVwdFN0bHFnc1NucnJ3?=
 =?utf-8?B?NEQyNjR1blFheEZoYjJPZkN2eWhXQk9wK2ZMOVQwVUM4Q0NKWFNIYUpubXpk?=
 =?utf-8?B?ZVNLUWlwaUdGcCtGWElqUStKSFlNck04Z3lqZm9vRHJ2bUhmdUEzWW9xTFd0?=
 =?utf-8?B?QVNqL2Q1bXdRR3IyT0ZORnRMMDJwZnBiZ01pM3dZRXNKWlNrUjJIcnMvMlRr?=
 =?utf-8?B?eUhFQnpYRm92cEtuY1lkc3dodEZYRXlLNkc3RFFFYklaekhSNGNsRWlPY05C?=
 =?utf-8?B?K1l4T20zVit2ZGg2NE94a0taN1Q5cml5dWpZOHJHNjdocHdzSHg4WmI4Mng3?=
 =?utf-8?B?K20rRFNLMmY4WWl2Um9yTDQzMnFYT0FFT2cwM1pRRy9jVGxscmZOc2xSaCs3?=
 =?utf-8?B?Sk9YaVpoa3F5U0g4bC9QUFo1ZW0vdXV5Y0lUSWUyRWZDRFBjZy9tcm9mT3RD?=
 =?utf-8?B?dG9vNGljMHhEL1dpeGx1MlpPYVVxenF1RE0zU2djaVF4b2Zac0VwNWptQmlB?=
 =?utf-8?B?NGZqRnBTZ3kwWUZHL3RiYUdKYjJiUDFRWU5lRCtFM3JmYjVDTmxydHZQZU1T?=
 =?utf-8?B?TDVkL1AzbHhVeEk4YUNMRER5QUtEYXY1T1BWcXFhYmlDRm9mVFYzVmp2Zyti?=
 =?utf-8?B?YXJmOGZkeWI0UTRPc0JxMUlkdER5T2lERXczN0Yza2FVb0ZIcTFBbUFVTHlr?=
 =?utf-8?B?akVDYVY0TzErSzRBQXMwMUZoODJYZkNFODIvMG9XVHdvZnU1UVZjTkZHZmkx?=
 =?utf-8?B?SUlKWTlsM0IwelNKTVJZZTRHaTVtcURheTJ2ckl2dnZaMm1TL1dUeTl1T1lz?=
 =?utf-8?B?VDRRY3dUT21XTS9odEFJdXlZRUowTlJ4VkVuaDJVUVEvM3A3RFJORHNIUlA4?=
 =?utf-8?B?RklPWVVtVy9Dc0JtMEJURWVveENVUVlydVpCU0NxOSsvY25pMzhGRFdLaVp1?=
 =?utf-8?B?am91RzdNdFJHclBtN0p4d3VPK2t6aWp5K1JkTEN2OVNXNFpldUdmbXlrWjNV?=
 =?utf-8?B?VUd2ZG1nM1pMNm5xeWJOZi9zQUp4V3hqUCtYTXlXc1hBTS84QlVPa21WUXhQ?=
 =?utf-8?B?RVg0WUpORkRtZ0NTS3NxYzdqdWNxTHhrQnNoRTlFMlcrRitPSDlBVFp3UDhx?=
 =?utf-8?B?YzA0UFNBbmlQaDcxSVJJbWJiUEVSL0dzYmtxRUQxZURMOWhBOWsxeExveUJZ?=
 =?utf-8?B?bEIzRWR2TzQ2TDdENlBoeklWQTd5Z2JYcmlHckN1Z3ZLTUpoMmZVbk1jNGx1?=
 =?utf-8?B?TTh0dXF6VXNFQTY3RlVqczhNNmVoR2VwUjN0Lys0blB3Qjl6anBZVXJLUzFi?=
 =?utf-8?B?MUFhVDR0bzE2cHJHU1RXUkVoT2NsN0JOM3RpbnQrOGcyRFc1ZkdmdGNyRnpX?=
 =?utf-8?B?NnM0YzhzSlhxQ2RmTklDVFQyMCsrNzVXZTZJcWh4MXEzc1I2amhmWXlNTkYx?=
 =?utf-8?B?SnB3cTl4V0VlUDVGR2hJbW5RQUZtYTgvOFBLWk54Vk4wclJyL2FLYjVaaEZY?=
 =?utf-8?B?Z1A4aTdGa1kvZFVSK0tMSnBFdUdHY1ZFc1d4ZFRhRVUxL0EzdUJ5dXFjNW9S?=
 =?utf-8?B?R2NzaU84amJlMVlIWmlIMlFuRVRQMDU4WHN4NGl2NTErSHZNdHVmV1Rpa2Qz?=
 =?utf-8?B?RDd3bWl6STk3WGpVcWtZaVJZeHpyWXg2b3M4aHFkZEVuTksvRWhxckdWM09l?=
 =?utf-8?B?TnBnbldSd1NDT0VzMGFXMG9rODRYRG9EU2k1OTljSjdMZUJIcU83bXNiSFdD?=
 =?utf-8?Q?NP703RcoHJIlApKinlm8YZyfyqIl3INjHD+Wd1P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHdIME1ib2NCUmM4VHY1cEN5WWVVaTBnNGJXUU1xdEVIYmtLNldveGRUMWVQ?=
 =?utf-8?B?a1orY2pRRDFXUjJwQ1ZUZjUxeUR1RGc4cExnTDRJeUVWWGxMcGptcEE0ZExC?=
 =?utf-8?B?eStOZ2lFYUpaMndWN09NdFk0VmlhTlRab1YzYW9aalkyTUxLVkI4MEpNbStI?=
 =?utf-8?B?aXlHSjRBcUtreFNFaS9yY09vcnRjSkxYdmdzVjV2RWQ3SmMzQmRxKzd4NDhn?=
 =?utf-8?B?V1VoL1VraHV2cWxrWDVlbnFXTERTN1NtTzY5eW9TRW91cFFSbFZCUEJQWFlj?=
 =?utf-8?B?eFpJaWVPbnhRWGlwdjJ1UCs4RXlmcS9tNU15RmhMc3ZkTmxoTGczYXJJTHZ1?=
 =?utf-8?B?SFI1c1BPM3RIUkRYQlJlcS9yTHI4TExSTEpHMDdIdVVCSmhkUDMyUWluT3VS?=
 =?utf-8?B?ejZ1STgvVEtVbWlnRy9oczhBbHRpeHBCeXN2TmFqWGRsWjZlRWF0cDlOc3lQ?=
 =?utf-8?B?YjJEWmVFYXJ0S0srajdxTzlVczNVSDVxZTg0OFEyMmNYbGJ1aFNXb2dVdTc4?=
 =?utf-8?B?OG1QTzZIRklMNzhGS3U3NjR6NmxaU0pDK3o1WmNCOUZ2NjdXWXR6UnZob2tK?=
 =?utf-8?B?MFhtSnFPUkN3L3Vpc24rdmJSY3Q2MW5wa0VFdWZJSGNKNHI2MXovUHJxSXlB?=
 =?utf-8?B?OEI5OFdHMVZkMmRHR1h5TTBsMnkweEdUVjBaZFBvY2M2OE5CZEVleGY5SUxk?=
 =?utf-8?B?R3lyb2ttNnBacEdVVHlXMVIzOGE3NWFOQWhPRkRKdkN5Y20xbTNsMTMvQ1VH?=
 =?utf-8?B?SjY1Y1Y0TmFqdlRzSk00QjVMUkh0UnREQ05BV3Eyamt6Z0dPaU1vZW5aUEhF?=
 =?utf-8?B?bHkvcU95dEhCOG4wSlZkR3hrRWh0bldVSHQ2SDhiNmVuQjA5cHVvR29VUFBM?=
 =?utf-8?B?R1g0OUl4Wk8zQXo5V01Wc1p3Z00vbVprOHZsa09pNXhjK1ExWDBLNzlKN2pk?=
 =?utf-8?B?ZFVjTmFjQ1R2eWtrWlh3blV1aXdRS3I5cEVVNG14RGpiQnJVbFh5TXV1V0Qz?=
 =?utf-8?B?L0U1Um5mR0Y2M2xkZE1qV3ptRFE5dTM3ODFRbHRGZkN2aXhRWnc1N1FpTXNj?=
 =?utf-8?B?N3hnVjVEUWQvdkpLbFdGM3lCZUd5VjRXbmtZZUFpaEVaN21icyszTzd6SXZO?=
 =?utf-8?B?ekVnUWpxL1RpOVhmb1UyYTFrZUJRZytHRzk1OUk1RFFnYyt4RWJtSEljV2VC?=
 =?utf-8?B?ZWp0NnVKS2crMFdFVGdmMDBsc05FQk1FTHBEU0Q1YUxQQ3dHdlVubXNMYW5E?=
 =?utf-8?B?RWNacXZBV2NyNlQzclBMVE55bkN0ZXQ5QkN2MEwvNVg1SnpZVHprbVNMMmI3?=
 =?utf-8?B?ZEtpWTNTelNHNHFsSHNFb1NiUms4OWV6TXU4Tit2bmFWYVJnbnY5VzlTTGdu?=
 =?utf-8?B?OXBRcWVvQ3dNb1hBNlhnRkZpdklKWVh2aDR1cVRQL1p3dnRhWlNCVTZVa3B2?=
 =?utf-8?B?MjJZNWZUOGFrN3UwS0tCVW1uVGM4QTArNTBTcUJGQ2RMUVhIa01aMCtnaTFI?=
 =?utf-8?B?Y0U4TEdaKzFpdkg2MmtxOE1nZXFrYnhlaFdYdXFVVXgxQ3ZlSFZXNmZ6MVN0?=
 =?utf-8?B?d2NxWnQrUWxxNzc4ZHhweFoxWHJoYXA1UzJHcGIrMEs0Sk03MmxRMFAzRk9M?=
 =?utf-8?B?cGcxZnpXZjdpbUNkNnIxVGVVaXdXdUkyVUFzQlRKdTJBTi9PbEg5QnR6ZEQ4?=
 =?utf-8?B?Uys2eVFrbHZlcU1YVHJpWHJzejN0ZElCMldsMDlPaHQyM3NtYWZIK2FvSEpS?=
 =?utf-8?B?MXJOS25haTgxZDRidmtxQ2VQSm9iUnhFWTZrQi8xcEwzN2ZCanh0R1dUcm9h?=
 =?utf-8?B?NVFyNnR3VkNVRHJMUm1JK3Zpd1B4TTE3dTFYSU8wQksrb3NvL0I5dUlDUTRv?=
 =?utf-8?B?bGRhZlFxZXBZMHdSQUprcUtabG12N2pJaGM1NmNSRk4zbDlEc3RRdjNWcmN5?=
 =?utf-8?B?K1ZYWSt0MitHZS9Tdk02NFBNQmIreG5zZENvTU1PRHl3QmNnakU3RzFtYlRk?=
 =?utf-8?B?Z0ovczZrMEVsNjErVy9ZTFY5WGpjVUloTnIvYmFZOStWZHVlUkEwZHVBd1lj?=
 =?utf-8?B?Tk5hMlVkMUYwTWxjZGdoVjUzV2JiR0oxTndCanZUN3M1cXdBRndObytxYkZZ?=
 =?utf-8?Q?weOj2RoDpHZ2/JGhE05JH92br?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552929b4-4b36-4a25-0ef7-08dcf3e953bb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 05:04:24.1255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjiyTY4yIX9gZ3ku8Yq8dwHA8jG95hqayaOq3RlVFaalBfU57ktQhOWavZmaUlpsane0zcxj6KARP3eLhTR4iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8589

Hello,

The patch "[PATCH v3] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs" fixes the RAPL energy-pkg event on AMD CPUs. It was broken by "commit 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf")", which got merged in v6.10-rc1. 

I missed the "Fixes" tag while posting the patch on LKML.

Please backport the fix to 6.10 (I see this is EOL so probably this wont be possible) and 6.11 stable kernels. Mainline commit ID for the fix is "8d72eba1cf8c".

Thanks,
Dhananjay

