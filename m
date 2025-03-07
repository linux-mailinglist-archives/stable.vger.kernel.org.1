Return-Path: <stable+bounces-121347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F96A5631F
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 10:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD0C1894E25
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 09:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D111A8F60;
	Fri,  7 Mar 2025 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DEk8DSwD"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C248168B1;
	Fri,  7 Mar 2025 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741338031; cv=fail; b=B/uj0PcUp6ci3y7HgXHIKSBZbKHFU5rul3vfT2c81Apk9upnVW744PyQx0CaaJJ094d3GWh5u1joeSGJUL/4UgwPNSCySnGBw3bBCjs2vEGfylCb09UheR0grS5rl+P7PqOoT4qMZcfArDnyZJkTjU2sE0oLuNiFvP2PzfLxPRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741338031; c=relaxed/simple;
	bh=Xfr/byLJiLlrnlRcZBuO24CRnOoirlKyEf5wusRnTeY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JLthyQ12KzpOv2zAaUgkBugUhdbB7Wg2DrRWDZvEJlVFBbzNr4in8eYZ7QomuwOxEQf42xet7F8ajlgglLawe/P8wE7qrzhjDWgJPN+nDUZtXMCdO3iJFivkQQGF6KShIyNxrabONXd2eSw0IEcFYmgbnBovjZ5oRh0cws0qBiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DEk8DSwD; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w089VUGUT9774hKRmHg6k3HlKqJ5xSLUFdXPjbRUBrPZ98IXbrE2BHqZWxDVrfUzj3YRRT6KcmA205jLZYSRi7N9CReWabhI9CPei79zuJGPyjAZVxZ6/5+ikgnxks/SeK7l+6zz4L+eyQzR5Xj3CJXJUDdqf5JZ3ef69f4zwPZKXxM1uDmHznBkmBIXy9PSqfAhKf7XMayB/VSR4u54/Sc0WQLesOsRMPA/O4VDImH12qMm7TupJ3bOg/2BTsnsoAluCH6IFoHAmYKX1IkLkqEC8YdxjVjrqBrfmPJnfxnuVZUTqSA8bYzHFOtnkLpSTd/6f7PgpqMuPAxmzPG4yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCZ7kYSqN3nZntRw7wwYJOAQt8RlySgogsVFg1FjLCc=;
 b=MzAwlpG1e0Q9OpmWGvBiSHSJBuKvTA+V5OZ3K8htt1zxtGL81Joh2TB1hozYGtk5iio7yF2tH2/mlhGEYMJiZ6SM+7+dWk2Lc0yhhFY4Ufe2//3LJBAqFS6dk/1X/+kwHf7dThVHtjE78ex6NwMdQLWEsv5NcfaWgfQhk4Ln5VWaMhR1I8pPEZ40Oa3LzhWPJi15IIV6s3abwH8QbBxHrEizhiLzg2YgXDdpucZKlclnyCCXgNK2xyzLCS1eo0k0Bi7GrhWf4YhoFG+IgX/c3u7yHFhg6CIdeUx56jt7yUh7d19PZCBsjMQuhd94MO7/k4orFH3zYW23hxhqvB0wdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCZ7kYSqN3nZntRw7wwYJOAQt8RlySgogsVFg1FjLCc=;
 b=DEk8DSwDfkBiiCfL7pr3Plwok+iiEHQKmB7e/Cli9gLx+swJ32L7UNVVnySpnQgilP1aKM2u31V37PVsrluWqRdkLCu2/p1LaJMDhy+WY3+qR77OyOt6hhpgyAuk4HBbF20Z4051j7RVlWYM9+/SgmmhPReLfeB6Bgytat9H43Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6317.namprd12.prod.outlook.com (2603:10b6:208:3c2::12)
 by CH3PR12MB7498.namprd12.prod.outlook.com (2603:10b6:610:143::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 09:00:26 +0000
Received: from MN0PR12MB6317.namprd12.prod.outlook.com
 ([fe80::6946:6aa5:d057:ff4]) by MN0PR12MB6317.namprd12.prod.outlook.com
 ([fe80::6946:6aa5:d057:ff4%5]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 09:00:26 +0000
Message-ID: <6d4f70f9-a696-49ad-90b9-08e1c30e7b3b@amd.com>
Date: Fri, 7 Mar 2025 14:30:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] virt: sev-guest: Move SNP Guest Request data pages
 handling under snp_cmd_mutex
To: Alexey Kardashevskiy <aik@amd.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Ard Biesheuvel <ardb@kernel.org>,
 Pavan Kumar Paluri <papaluri@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Kevin Loughlin <kevinloughlin@google.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Brijesh Singh <brijesh.singh@amd.com>, Liam Merwick
 <liam.merwick@oracle.com>, stable@vger.kernel.org
References: <20250307013700.437505-1-aik@amd.com>
 <20250307013700.437505-3-aik@amd.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20250307013700.437505-3-aik@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:3:17::19) To MN0PR12MB6317.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6317:EE_|CH3PR12MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: c5021044-1c6d-4d5c-a2a6-08dd5d568045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFpDb1BHTm5TNTdIdW9lNnBnclRjNFhXYTQ5ajBEU09aYzN0SkZWUnhLV2Vv?=
 =?utf-8?B?WWtHQVdObTk5TGRKZFhYZzlTU0hnaXlBTnlZNzduQnA3Y1dlSFltSys5SVVR?=
 =?utf-8?B?c1E5am50Tmt6S2I4TEhGRTlzOEYwOEdnQldXNUVzSWlrMzl6bzFzTWJkOEdP?=
 =?utf-8?B?RmpTZmwyYlplQ0l6YjdwaFlEUVBzNE1MY3pNa1dWNXBDUEJ1MXFjemF2STkw?=
 =?utf-8?B?eGd4cXdmeTJucHByYkNCMVphR2lyZmVCeWJ1SmpzdkN4UFpiMlROT3R3VUpQ?=
 =?utf-8?B?RHVTaEd2anVqUkIxMkFiblVkdDZ3cnBBUnFvT2ZmQjBMTGZPRGVlcE9ZUkpM?=
 =?utf-8?B?S25tVnRQZmp3TXozclpRU3VwYWRCVHVyU0JtaHFHV1cxTWd0MEhBRDdIamtr?=
 =?utf-8?B?OEg0T3hIV2tyeG5GOG93cTNVS3p0MWZCandCWTJZVWtIdlNDYnhvdnhhc1ZO?=
 =?utf-8?B?QjRoVHp3VzB4MFFLVXQ1Vk1DbzdMYWxuWWxsdTZIUXNkL0k4bk1pdllueVh4?=
 =?utf-8?B?L1lHem9RNko0SVdKYjNpTjRrai9ZWmljNjJLcjlpdUJHKzBQcTl1LzhBQ3ND?=
 =?utf-8?B?U0pLcExrOGY4TWduVDFCUjN6TldwdDg4a3plcHcwTDRpRjJ6V1o1TGJ2WkNJ?=
 =?utf-8?B?cURvRnA1SmV2akIwaENKT3YyNXZaNmtCWDA1R0RjMDZlM2pPMXF0UFdjcWEy?=
 =?utf-8?B?NGpqQ1BLQjlqUUVudTBYcUY5aVgvQkE3QlB6ZC9zeWpMQmpISXlpRmlyakxa?=
 =?utf-8?B?WmxTblY0UkVEdHdpeldwTkVJbW81RnZhcmRMYWJYeTA2ZHY5VlRSejE5WjY1?=
 =?utf-8?B?a3lXY0hGVjJqYXNOR20rdmZWcmdiTXhBVC9yUjNIY2dVdE9pZDRoZVlHWmxk?=
 =?utf-8?B?eUVFek92M3B3eFYvUVlQNmhrMXZBMGRCNkh5dTkyUVhLd3g4WWU4cGhJaVRu?=
 =?utf-8?B?WXZVRWhJdkxiQXk2ZFpVZDNCTytqbVQ1YU4wbnJwdklrayszVmk0TEtVTnFW?=
 =?utf-8?B?K3RpSmJ3WFNoN25yU2lBRUpMTzlSM1FWS013blBUZ0VYSERlL2VONWIzOUZD?=
 =?utf-8?B?bE5jWUZTQTBkOHA3dDltM05UcWtrbGZMMjVCc2tjSmtHVlVLNFBGM25yeU5u?=
 =?utf-8?B?U0xGaktjaGg1MnM3VkJ3czEyS1pwTWN1RHgxWVhWR2Q0azYwbUxyNWtXVS81?=
 =?utf-8?B?aW5saWN3ZDRsYm0xQlFwRFROQWtmNVhGcHVRbG81RXBXZ2RjbzJFb1I1cUw3?=
 =?utf-8?B?em0zWGFkMTRTTFJTYW0rTFVEZE8xNWN6ai9kTU8rNVcwWksrWGF5RlRwd0J3?=
 =?utf-8?B?Y3ZJcys0Vktxa2kydEFXZVN6Tk1paVgzNXZiVG1Qcm01a3pFY1RoVHBMT3du?=
 =?utf-8?B?MnhrMDIrQUtjUnU4SkI0ek1xYU1MdThzTER2aXpYc1BFNVE4VWU2aENDWjg4?=
 =?utf-8?B?RVNSa0Z3WkN6MDRmUUtHMkJ1VXJFNEp0SHMxRlFWN3VrUENVbUNuSndtMUs1?=
 =?utf-8?B?azEwYUZTVk9wb2Z1cjJRUDBBU3ZVTXA1MHRsUi9KT3hLU1prVWI4WElsamNO?=
 =?utf-8?B?T2szeEduaEYxMDNkcnk5T1laTStTNCtzRnZKbG9XQ1RKM2ZEdThKMWFYeExE?=
 =?utf-8?B?L0ZkSi8vWC9HeDlMS1RSbERnSjZJZDhIRW5FOHI3em12YUw0ZGFKU1FRYXRP?=
 =?utf-8?B?dG1ocEtBZU9oeGpLMnpwa2ZwWEo5UURYNTNDcUdNQXpJa3NKcDNKQlpyU3lD?=
 =?utf-8?B?cDNZcmtmU3gzOXZTQXFZREFDaFdtL0c1MjIzUFpBWEk2OFM2ZmkxWlVBVU1w?=
 =?utf-8?B?b0Y3ME11VjNxOHpZeXEyQllWRTBqbE1kNjNqWUNiQlVyZVNoYWQvYm9PZTNQ?=
 =?utf-8?Q?nHBK0Nr9JjDv/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6317.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlZrdlZMY1JZSVZHUEhES0hYUitEb0tiOXYvUW8xdE1sUEhOQkU5bk9vQkZa?=
 =?utf-8?B?NVBtSXlrbHdVNnhlcS9wVmJJbCtqdmNMNVJqdWhPb2ppVkN3L2IzblQyRUFC?=
 =?utf-8?B?V2dSaTdZK2w0RDR2Rm8zNGMxVENNRG1QYk5xVHhiWVVyQWJKRGEyaXR6c1dp?=
 =?utf-8?B?dkd3YmxUUThRa2o0VldpVHRwdmhjT3Bxa1VnaGpsN3BtZ2ZrMFNURVJub1N6?=
 =?utf-8?B?cFI3MWRLY3N0UVVJTUVwalFSVWFpdXRhMGEvRWVIN0M3ZmEwOEMrUEluSGdt?=
 =?utf-8?B?T2hNT2JSa0Y4SVQ1bnVRekhpcjFPMEd1emlJZmtMTUhGV0JTWFRXM1hTTmsr?=
 =?utf-8?B?L0xzcU8rMk1aYnZMMTdseFJHSWZDRUUzSE94b1hvZStKV0xpbXZXb3dTNXRU?=
 =?utf-8?B?MnhCbTNIbWZiU3NwcUlwWGY1ZzdSK1hHV25tU2kxbGlieTF4bzlqK2oybEVI?=
 =?utf-8?B?clpidVlxUGtOZUpXNWEwaU1KeUVDOEF2dDdQckMyZWRVWjhUSXZSMkZHdW9k?=
 =?utf-8?B?STQzeUFpLzhjWWdzRDg2RXRYU0ZFc1NFT3A0c1BjVUFjZTZpRUVxQ2ZyQ0dy?=
 =?utf-8?B?NDU1SzF1T3BVR0dUWGNoMnlYbHgvMG1DdEhKMFEzNFkyWU9Zc1BDdnpLMFhZ?=
 =?utf-8?B?OTR1S1RoM3JKeklsNU1oQ2kwdHlQRno3SDFpelpPQU51WFhhaUczWkY4Nmcw?=
 =?utf-8?B?SkNZZlNrRzhZOU9wbGlaeWYwSVd1UTNCMTh3MXN2aXVyMG5UbjNVZGxkQjZX?=
 =?utf-8?B?aVlEWnpwRTU2UHdUZ2JoSGxnWmxoT3NGVUJSclp4OG1xeENZVHl0ZFVlZFkw?=
 =?utf-8?B?N0xlbFl5dFlUWXZ1VWFLeXRYdHB4bHhXTXhVVE9wR1h5RVhzbW56cXZjcFJ1?=
 =?utf-8?B?WFVsaGtVVC9JSVFzUktRVFpmK0xCRXdUREJXcC9uK09vR2ZYYTV0d09jRHFs?=
 =?utf-8?B?V3NiazFEcEN2bVVGUEtrK0FpTzJRZUJsWHd2c0g5VnAwL2VYZDJhNlV3Zkwy?=
 =?utf-8?B?OE4ydTZ0aG1kbkg1Nlc4b1BnZm1xVG9lMHM1eW9kQ0xMa29wVUhRUUxRYXdO?=
 =?utf-8?B?WCtoV2FOVHBxdWpIM0FURzlVMW1LK1VOL3FNYVRCMHIvcXd1YkxWbm1LaEZl?=
 =?utf-8?B?Z2JuTEhaak9YcDJmRFNUVU40NU14NkxtRW1ZTDFsWTlLaDRiNHJPbTdLaENB?=
 =?utf-8?B?akZoU2hRcE9WRzQ1NGo3bURNeUc1d1VxdG8zWjVXeG9jWG5EZHhobE5za242?=
 =?utf-8?B?VjVUSjRwb0Q2SGhFeTBaV21xZ2FjWGRJeGVsL1M5TllKb21NTVVmN3g0WEY4?=
 =?utf-8?B?YkhmRUZONFVsTFFLOTdNTERVdzZRYkRNeEx0bFNzZzh5bElJMzNrMUh4M0hP?=
 =?utf-8?B?aDNwanB5cmJzOW9MVVVLcThiRiszcU9sd1dpQ1BXYWFoRHVFRnJQWmFMRWxC?=
 =?utf-8?B?Q3lWTEFPSk83UjRoZEJ1U1ZrclZWTi9wYXFIQ2lGQWdKek9LQ1F1bmZJQ291?=
 =?utf-8?B?cDlKdDBYcERjbU1OcG9KQ0JWUzg5OC83aWZtdFRZY1V3Mmt2U1doNGFBN2RK?=
 =?utf-8?B?MVlEUWFSL09Pd0tCZnZ5NzhkZU5IY1lick9CeFI5THFUMGZCMGt3bXBuRlZ0?=
 =?utf-8?B?Smx5NEpQTzU2TWF4YzY2djhYSmltemhaenBJZHdSSFV3MGl1d3ZlWXVEZ3Aw?=
 =?utf-8?B?ZVBKUGU5aEhEczJFZDM1QmtJUUFxbFBPYjNyRDZ0RWVqa2UrczhINTI5UnZj?=
 =?utf-8?B?K3BydmxKQ3JMNWh3QmVLSEY0aVFyOGhwTTdMMGZwTjBqYnBJdE90dnVWZEs5?=
 =?utf-8?B?QzBKR0dWYzcrdk1pOFltNDdwVG83a1h5blRVdDFTNFc3c0l2b2Y2cm8wbnFq?=
 =?utf-8?B?dUxBYTdUQ0RvMUhXcS92Zk54MktUVDR2V0M3MkhYUUVZUWNkdWREWEFFdjJP?=
 =?utf-8?B?TGN0RHNpY09aaUp4ZUVNTXl2TENLdjIrZ1FlektSc0tzK1VmbVBYZmUvWEVu?=
 =?utf-8?B?Qmc2VytSek1sd0d3SzhKL2l4TTBlQ0lpY01qcis1UkU4dUZxMUxack9xZDdF?=
 =?utf-8?B?L0duSWtVMEFuUEtkQ2g5THdBc0FjTjI2bHRYcFBxQTZ4TkZzMzVnNDZZUlVl?=
 =?utf-8?Q?0WNRuyY3mOmf++1uUpR5dkD2K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5021044-1c6d-4d5c-a2a6-08dd5d568045
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 09:00:26.0487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzkq0CC8U6ZJPKNAqdQdN1sAcxS4nEXLmjW2bbxbf02JVVayvoKbtwv/E0OSSZn1p6DqvGWvlpqeKOS71q/MfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7498



On 3/7/2025 7:07 AM, Alexey Kardashevskiy wrote:
> Compared to the SNP Guest Request, the "Extended" version adds data pages
> for receiving certificates. If not enough pages provided, the HV can
> report to the VM how much is needed so the VM can reallocate and repeat.
> 
> Commit ae596615d93d ("virt: sev-guest: Reduce the scope of SNP command
> mutex") moved handling of the allocated/desired pages number out of scope
> of said mutex and create a possibility for a race (multiple instances
> trying to trigger Extended request in a VM) as there is just one instance
> of snp_msg_desc per /dev/sev-guest and no locking other than snp_cmd_mutex.
> 
> Fix the issue by moving the data blob/size and the GHCB input struct
> (snp_req_data) into snp_guest_req which is allocated on stack now
> and accessed by the GHCB caller under that mutex.
> 
> Stop allocating SEV_FW_BLOB_MAX_SIZE in snp_msg_alloc() as only one of
> four callers needs it. Free the received blob in get_ext_report() right
> after it is copied to the userspace. Possible future users of
> snp_send_guest_request() are likely to have different ideas about
> the buffer size anyways.
> 
> Fixes: ae596615d93d ("virt: sev-guest: Reduce the scope of SNP command mutex")
> Cc: stable@vger.kernel.org
> Cc: Nikunj A Dadhania <nikunj@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>

With a minor nit below:

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>

> ---
>  arch/x86/include/asm/sev.h              |  6 ++--
>  arch/x86/coco/sev/core.c                | 23 +++++--------
>  drivers/virt/coco/sev-guest/sev-guest.c | 34 ++++++++++++++++----
>  3 files changed, 39 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 1581246491b5..ba7999f66abe 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -203,6 +203,9 @@ struct snp_guest_req {
>  	unsigned int vmpck_id;
>  	u8 msg_version;
>  	u8 msg_type;
> +
> +	struct snp_req_data input;
> +	void *certs_data;
>  };
>  
>  /*
> @@ -263,9 +266,6 @@ struct snp_msg_desc {
>  	struct snp_guest_msg secret_request, secret_response;
>  
>  	struct snp_secrets_page *secrets;
> -	struct snp_req_data input;
> -
> -	void *certs_data;
>  
>  	struct aesgcm_ctx *ctx;
>  
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index 82492efc5d94..d02eea5e3d50 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -2853,19 +2853,8 @@ struct snp_msg_desc *snp_msg_alloc(void)
>  	if (!mdesc->response)
>  		goto e_free_request;
>  
> -	mdesc->certs_data = alloc_shared_pages(SEV_FW_BLOB_MAX_SIZE);
> -	if (!mdesc->certs_data)
> -		goto e_free_response;
> -
> -	/* initial the input address for guest request */
> -	mdesc->input.req_gpa = __pa(mdesc->request);
> -	mdesc->input.resp_gpa = __pa(mdesc->response);
> -	mdesc->input.data_gpa = __pa(mdesc->certs_data);
> -
>  	return mdesc;
>  
> -e_free_response:
> -	free_shared_pages(mdesc->response, sizeof(struct snp_guest_msg));
>  e_free_request:
>  	free_shared_pages(mdesc->request, sizeof(struct snp_guest_msg));
>  e_unmap:
> @@ -2885,7 +2874,6 @@ void snp_msg_free(struct snp_msg_desc *mdesc)
>  	kfree(mdesc->ctx);
>  	free_shared_pages(mdesc->response, sizeof(struct snp_guest_msg));
>  	free_shared_pages(mdesc->request, sizeof(struct snp_guest_msg));
> -	free_shared_pages(mdesc->certs_data, SEV_FW_BLOB_MAX_SIZE);
>  	iounmap((__force void __iomem *)mdesc->secrets);
>  
>  	memset(mdesc, 0, sizeof(*mdesc));
> @@ -3054,7 +3042,7 @@ static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
>  	 * sequence number must be incremented or the VMPCK must be deleted to
>  	 * prevent reuse of the IV.
>  	 */
> -	rc = snp_issue_guest_request(req, &mdesc->input, rio);
> +	rc = snp_issue_guest_request(req, &req->input, rio);
>  	switch (rc) {
>  	case -ENOSPC:
>  		/*
> @@ -3064,7 +3052,7 @@ static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
>  		 * order to increment the sequence number and thus avoid
>  		 * IV reuse.
>  		 */
> -		override_npages = mdesc->input.data_npages;
> +		override_npages = req->input.data_npages;
>  		req->exit_code	= SVM_VMGEXIT_GUEST_REQUEST;
>  
>  		/*
> @@ -3120,7 +3108,7 @@ static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
>  	}
>  
>  	if (override_npages)
> -		mdesc->input.data_npages = override_npages;
> +		req->input.data_npages = override_npages;
>  
>  	return rc;
>  }
> @@ -3158,6 +3146,11 @@ int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req
>  	 */
>  	memcpy(mdesc->request, &mdesc->secret_request, sizeof(mdesc->secret_request));
>  
> +	/* initial the input address for guest request */

s/initial/Initialize/

Regards
Nikunj

> +	req->input.req_gpa = __pa(mdesc->request);
> +	req->input.resp_gpa = __pa(mdesc->response);
> +	req->input.data_gpa = req->certs_data ? __pa(req->certs_data) : 0;
> +
>  	rc = __handle_guest_request(mdesc, req, rio);
>  	if (rc) {
>  		if (rc == -EIO &&
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index 4699fdc9ed44..cf3fb61f4d5b 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -177,6 +177,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>  	struct snp_guest_req req = {};
>  	int ret, npages = 0, resp_len;
>  	sockptr_t certs_address;
> +	struct page *page;
>  
>  	if (sockptr_is_null(io->req_data) || sockptr_is_null(io->resp_data))
>  		return -EINVAL;
> @@ -210,8 +211,20 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>  	 * the host. If host does not supply any certs in it, then copy
>  	 * zeros to indicate that certificate data was not provided.
>  	 */
> -	memset(mdesc->certs_data, 0, report_req->certs_len);
>  	npages = report_req->certs_len >> PAGE_SHIFT;
> +	page = alloc_pages(GFP_KERNEL_ACCOUNT | __GFP_ZERO,
> +			   get_order(report_req->certs_len));
> +	if (!page)
> +		return -ENOMEM;
> +
> +	req.certs_data = page_address(page);
> +	ret = set_memory_decrypted((unsigned long)req.certs_data, npages);
> +	if (ret) {
> +		pr_err("failed to mark page shared, ret=%d\n", ret);
> +		__free_pages(page, get_order(report_req->certs_len));
> +		return -EFAULT;
> +	}
> +
>  cmd:
>  	/*
>  	 * The intermediate response buffer is used while decrypting the
> @@ -220,10 +233,12 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>  	 */
>  	resp_len = sizeof(report_resp->data) + mdesc->ctx->authsize;
>  	report_resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
> -	if (!report_resp)
> -		return -ENOMEM;
> +	if (!report_resp) {
> +		ret = -ENOMEM;
> +		goto e_free_data;
> +	}
>  
> -	mdesc->input.data_npages = npages;
> +	req.input.data_npages = npages;
>  
>  	req.msg_version = arg->msg_version;
>  	req.msg_type = SNP_MSG_REPORT_REQ;
> @@ -238,7 +253,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>  
>  	/* If certs length is invalid then copy the returned length */
>  	if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
> -		report_req->certs_len = mdesc->input.data_npages << PAGE_SHIFT;
> +		report_req->certs_len = req.input.data_npages << PAGE_SHIFT;
>  
>  		if (copy_to_sockptr(io->req_data, report_req, sizeof(*report_req)))
>  			ret = -EFAULT;
> @@ -247,7 +262,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>  	if (ret)
>  		goto e_free;
>  
> -	if (npages && copy_to_sockptr(certs_address, mdesc->certs_data, report_req->certs_len)) {
> +	if (npages && copy_to_sockptr(certs_address, req.certs_data, report_req->certs_len)) {
>  		ret = -EFAULT;
>  		goto e_free;
>  	}
> @@ -257,6 +272,13 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>  
>  e_free:
>  	kfree(report_resp);
> +e_free_data:
> +	if (npages) {
> +		if (set_memory_encrypted((unsigned long)req.certs_data, npages))
> +			WARN_ONCE(ret, "failed to restore encryption mask (leak it)\n");
> +		else
> +			__free_pages(page, get_order(report_req->certs_len));
> +	}
>  	return ret;
>  }
>  


