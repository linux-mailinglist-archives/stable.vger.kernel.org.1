Return-Path: <stable+bounces-158677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F89DAE9AA6
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 12:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3091C4221C
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 10:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46B321ABC8;
	Thu, 26 Jun 2025 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="baINqKT/"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0575C21ABA4;
	Thu, 26 Jun 2025 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750932116; cv=fail; b=IzEjylT/cnhrRzu48mYmEsnp3gY3B7Ib1IsugQydCqE+tPynO3g5cpYST7yhHHI0AfEsLEjzR2V/v+03tufLdaCJnggXMGNFpbxXn4qS/FS6lOihg1tbD+aUwj5NWjhw1FsW1ek/xER2XauIzqxTZKiQEfXY19L6+DHsYTmNMf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750932116; c=relaxed/simple;
	bh=Eu2/hknUmUQd08Qsl3Wv5NgX0Jaq3SepijI7fcc+mJs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WkEl2EQ5hrFZddYuhB9LaX4XmCdiwC/szmBwrFovbBn+IC2XEGEy0C0QErUkFjjvRZYBZ5QCyWseRxRwBqcv5qhqyyX+GEf2/FNPF9bD+RdRxTt4J+T8dHcCtNyNCHCXj8WWv2dhBWl4UKQmVNPakUQ48EF9rbpZLGtfsqz/F48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=baINqKT/; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyrscysripVg0ACWCKy/xSNxs27DoB9i09mRf0kqg/fnsteipLbHNuOuKXi3ATipj7GeMfrnZAJPmJPbmXtrZfEnal6MCRR8Mri0DszlCauqbhSxS/Sf/de/3t5O6FdJXJM5n+l2Hl+nO29DxdYBcMsN2qbtYANjMfuYNgOQDF88uqcBnEhYgMhZqG/zkBcwrq8jpvbogV+yHayup/FK0ov/1Tk4TYlDAIY9D/ma3Fegr8IFJe9ezhIbyB+O7ZwnAr7Amzk16yvTF3VoBHNVGEi/yu64HjYSu1XMjOgn3bYkQPfIgpynQjT+BgdlXBPwnaKRYqo3sWxLM9NGtXXP0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1WkWlbAZwkvN6xPX7gQmGEOzwwOdGK69iqbBhebvZA=;
 b=v+mr5E/WolrzcFvnXKjEIkBOuSlNqmZ9pG6hymQoXyMFgqjsFQMZz4JjQUPyKyAKW/8Lzh+HfaEA4gHP5sEbCsZjERi3zJ5/gFxN/jCmfivEBwFwnkiKmvzba00UyON21Pek1kKftNJ7yldR9pcHq064bv2nIaZIE7BglhC6nO4sN89WjKWDN0HuXM+D9ad8W/b4R441rC+mijuo0YpY11GlxgPmUzWjhb132rkcsYLUYLM+k0t0sE+/SHJfkWtp+CkcHbg3dFS0t0D3h1hg+QDfLP2ttcBabOZd3kuMBXuC4PRBrQFJW7HSfBwpBN74EsY5HBo4xXCV8tkpV3t6wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1WkWlbAZwkvN6xPX7gQmGEOzwwOdGK69iqbBhebvZA=;
 b=baINqKT/wk4tEF8QZRnLGdZAaOfl02VmhjPPY5Way3vn+r9pRfQtcarEw54kpHKmt4jMGcJm9AQEMn7jnVCcZcAW+81SeNOLsK3YY8taXdHhfEy6yyd0l9rXyhJ2MXyDW0GwYw5MGIHKq/iSg5b1fVUlOaAzX9rP5RVB3xM1Jx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4SPRMB0045.namprd12.prod.outlook.com (2603:10b6:8:6e::21) by
 CY5PR12MB6549.namprd12.prod.outlook.com (2603:10b6:930:43::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.21; Thu, 26 Jun 2025 10:01:51 +0000
Received: from DM4SPRMB0045.namprd12.prod.outlook.com
 ([fe80::3a05:d1fd:969c:4a78]) by DM4SPRMB0045.namprd12.prod.outlook.com
 ([fe80::3a05:d1fd:969c:4a78%4]) with mapi id 15.20.8857.019; Thu, 26 Jun 2025
 10:01:49 +0000
Message-ID: <f2292bcb-ccc5-4121-98ce-bf65c0590131@amd.com>
Date: Thu, 26 Jun 2025 15:31:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/sev: Use TSC_FACTOR for Secure TSC frequency
 calculation
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, bp@alien8.de, x86@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 thomas.lendacky@amd.com, aik@amd.com, dionnaglaze@google.com,
 stable@vger.kernel.org
References: <20250626060142.2443408-1-nikunj@amd.com>
 <aF0ESlmxi1uOHkrc@gmail.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <aF0ESlmxi1uOHkrc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0030.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:273::8) To DM4SPRMB0045.namprd12.prod.outlook.com
 (2603:10b6:8:6e::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4SPRMB0045:EE_|CY5PR12MB6549:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b694493-1841-4b37-e904-08ddb49877b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vmxiek42ZkFZVERuRUlmKzM0RjZMcGQwM3NYd0FneUR3OUZtNWdzNzI3U3E1?=
 =?utf-8?B?cGh2MU1HYlZ0RTZEU0NJZmlPQ2VlQmpDK1hZWWsrbTkyNVl2Y0swMlBvMWxL?=
 =?utf-8?B?aVI4UXlOUElPcUdQcHFFYWQ3OWVQTjdJbUFpM3hXY0NIeXpYdWxRYVlWMVhw?=
 =?utf-8?B?MWppQ2hkMElkcU5YRm1ZQkxlWE1zczQzMUZRWGxCSzlxMGxQVTBiUmE5bWZn?=
 =?utf-8?B?QVRJWE1LZ3pRdDNTUXh5UVBEZGl3cld2TWRvT1pUeWwwZHpnQmxraHRKSWM0?=
 =?utf-8?B?TjVNZGVIK2YzRjNvdG9yd3lGV3VBU1djaFpPNkJnZDN1U1R5S2ExWk1CeFhv?=
 =?utf-8?B?NWl2cUM1Y1RsMDdzUFNKZXFnRFRWUjc5dFNRbk10bG94aFpLeDJOOE9LTGsr?=
 =?utf-8?B?dFhtRmtESWYzTTZweUIybkwvZGtBWS9xcUZoU1N3YXpCcDBMcmt3eGxEYmlr?=
 =?utf-8?B?dlhhWG54RXJEUUlSYlR0K05rcEpRN25ZdmVMTVVjc2g5Y3JwY2QwTGxuMVNQ?=
 =?utf-8?B?TUtRTFVwUEg0eit2Zk9xM1V6Y0JsU28xYlZFMUpKQThqV3AzcEZyR3MxbHFR?=
 =?utf-8?B?WG5TYTdoYjZTM2JLeUl0b3I1Wnc4LzV3Y1NBTm5vVmhURzlGRDh3UFl1SzFr?=
 =?utf-8?B?UXE4bzdsZDVGMldDYnorWHQ3cmJVNGpOeWNiWWFzcXRjQVRyNlRCNlpieFA3?=
 =?utf-8?B?OGlPdzgxYlpuaVZUcllVeDUrOGNWQUlFdlNtaTEvWjJNcFd1VEg2QUx3ZWR1?=
 =?utf-8?B?eVF5Ym1CbEdNSXk0Z0FUMTRTN3V0OHRsVmVia0k0N01KQVM5WEVndEhYSnNJ?=
 =?utf-8?B?aWd3UEVZT0RRdEVBeldnZFpDMkpKbyt5WWxMKzVhbFlWcXFnRkZyWC9aV1JW?=
 =?utf-8?B?QkxoRXpPeWYzZndoaEYvUWRhT0thOFJNeFpldTgySDlvK1dNRm9tWVZpVjVZ?=
 =?utf-8?B?d3JHcS9YaitnaHNpaXQyYnNlZTlaLytJTkc2Y09kc1lOOTQyUkt6NG5JT3R1?=
 =?utf-8?B?UE43NEo5Z0d0V0d5NTk4YUx0ZWNKT3VDRGw2V1FjbmlaNG1IMDA3NHBibW1W?=
 =?utf-8?B?Q3ZGeW5FREozK2dtekI4K0VZRWRnRDB2Qi85SVM1eGtzajBhazNRZmsrcDRZ?=
 =?utf-8?B?Qys4dW9JcTZHcXhwQktQSlJEWXBtNGM1S2dhell4eDZTQ2NJbEtVaHNNb2VV?=
 =?utf-8?B?b2s4RU9XanJ1UFFlcFZDTWExTTZJLzR6enovRkhJRll3ZGc4bFdvWTBZK2ZB?=
 =?utf-8?B?RmpzbXFPSXhPN2YwR3l3dHNFWXVBSnlxT1hSZUZrWnZXREtXMmlxa1QxQWUr?=
 =?utf-8?B?NUQ3RGxhMVlSS1ZXcWd5Njd0aEkyM0VLNE1oVGJweHlZVENhNnpCQWZlWEZ3?=
 =?utf-8?B?UGxKSFVCdTZMalNVeXV0RS9nTEFYbTJYazNNZ2w0Q0JZYVBneTRJYXd2MGE3?=
 =?utf-8?B?dGw4NFBSOFlmVEhlT01FaldncnprTTZEKzVMb3I4Vk5oTWM0a1ZQL05JUzhO?=
 =?utf-8?B?dy9RaTh5b2RFRjd5c0lXSkxQWjFVL3d4MHRXVzVuUnE3WThYSW9XaU9DbC8z?=
 =?utf-8?B?Y2w1ZlBTa1l3NjRDaGFDcVlYSHhNdWVHVEN0NGkvUTZYVERtUnFqRnBmUDZG?=
 =?utf-8?B?T29hdXlxbTlMSWRmeVZnOTQrRFBCak8vRmlwbTRPcjJQWlk5dmlBL2FvMzAv?=
 =?utf-8?B?MzVTbSsvY05HQWZoT2FzL2JhZzdVSWwxaURWeW5BeTRVRTN6R0RHZ0hJanN6?=
 =?utf-8?B?TkpJdCtJbWRYYno0bTIyWGVTTUVKNnpaRWRGVjBqVmYrWFZaVkJMNE5naVRQ?=
 =?utf-8?B?eXJmRmNzYzN2MzM5ZmswaGFpT0JKSG1mYXIrZ1BCQ1g4RGFMbCtiZGR1cjJJ?=
 =?utf-8?B?YUpVdkJ0OHdNMXNTS3cwODhIWWtWM0FMY2xtQXd1ZHVPakZONEEyeHdKbDFr?=
 =?utf-8?Q?O8gAcV3i/eg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4SPRMB0045.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWRHV2dVakNHbXZmK1NVVDFmamc4ZDlFTENLb0lRV3JjSU9QWmZvMTdjVE5z?=
 =?utf-8?B?ZDcxOU9SWGt3eldQSU5hZnJRQXIxR2l1d3RSVERQYlJKeHZvc0o4amJCS3ky?=
 =?utf-8?B?a2cvcWQ0V0UwWWQyVXlQMjdObG5ub0dNQlVtZXovWmR3amdwU1RyTmIrR3lX?=
 =?utf-8?B?RzVhdThyQVJUVU10R21mYVFjTXFtNkVFa1BoSWdPblJpS2VnOXNNRm9hcXli?=
 =?utf-8?B?YVdZbkxKTG5YeGowY0pFSEdyUXFXaFMvWHpPQWxRUzViUVZUbzY2SStKdEds?=
 =?utf-8?B?M3dYOE41RFNKbDVmY05IVWFvNUwwTEs5ZUlUb1MwT0I2clZCTElHSXVzMm83?=
 =?utf-8?B?UGF0VmNua2duREZ1Uy9tbEMvZGdsQzVpcWxFa2lvNjU4TjlJWmxGM1BQZ3dN?=
 =?utf-8?B?S25nK21GMm9kK3N1RXJIWGE3TThHZ3E2alBVZndFY1FSOHA2Y2J2VDJtRm13?=
 =?utf-8?B?eUJ0MUo4VCtNRzdDc3N5am5mQTBuWDNSTHVIOVpvUGV4LzZrSzZxaDJoaDFY?=
 =?utf-8?B?MWJxbldCNjdRMzAwVE53dFBXSU5CZEc2NmtYU2h1VVo2TVVXYjhnUThUS3Z4?=
 =?utf-8?B?QU1rL0VYLzdRVnpoNXdCbmw3QUVMSXlaVXFDRTFzdFRMbnNxSzE1OTB6dmdM?=
 =?utf-8?B?cmVlK0RSb0RNQlNEUUdhbm9FMzNVZmpYZENGb2JlYm91U3hoNGhDejZsbGZz?=
 =?utf-8?B?NmcrYXNBSHlHQmdsWHpZK2F4eU5uZ05odE4vMkdiTHVrZnE0aGdJa3dSNlhI?=
 =?utf-8?B?cmdPZXg0S1VhWHNCcUFzNHJ6WEUzYnVjbFVhUThpTmFVQ2pleU9aZlZqSUhT?=
 =?utf-8?B?THpCNHh4aWxDMFo0cFpjdXlYaThuMFM0bUlyS1JTVFc5Z3pMNUVGektWK2ky?=
 =?utf-8?B?UFh4WlhJMTdhWUhsd1c2bVRVREZiSFl2VklxTEJMcm52S05qYU15MDQ3WThG?=
 =?utf-8?B?d3h4UXU3cXJrS3VRWEdSRTFXNWdST0d0T0FuZ3NzaFJGUjE5eXdCRE5vVk54?=
 =?utf-8?B?b2xENU9OQmpnakxDR2ZnSGVWeUJiYWhoQ25xNHUvZERNSnFZWUhkVW43V0tC?=
 =?utf-8?B?Z2QyOE8zb01hQmZNRThQYkNFYjRDVHE2RE5qYVVPak5EUzJMWWFyZStFd0JS?=
 =?utf-8?B?dG54NmFYWEFtakFpYjJZZVRJa0wxTFNGSXJyb1h6WlRaMzRraERjUlBHOXNp?=
 =?utf-8?B?T3FxY1ZIUjViK0hpYlYrL0tWaDR1Q0pkdndhTE1QVklQL1kxTHBBRGVvY1dC?=
 =?utf-8?B?Tnd5bkZ6a1JMdmwwVjNSUDNjVlJqWUU5Qmo5cGlUV2QrdHE2TkJPR3N6Y2ZL?=
 =?utf-8?B?THQ0ZVJLS1VybVJGQUluN0ZGQ1F0SmpwZWtaSVZkMTB2L0VjZmU2V2d5VXVl?=
 =?utf-8?B?alZDZjU1WU4xSUE0TGFrZEQ1K21kVWVvdEJvR25nK1FRUUcxcGRoL2VpZ1du?=
 =?utf-8?B?a01SckhvMWhhWlYydnlQcmZxOG1CYVFEUGxTcEpaT3J0emVlU2didkxwWmxF?=
 =?utf-8?B?cE1VZGliRmJja1oxK0NHelg0QlFRYXl0TjlPTVYwMWNoUE5XcnYxQlQvZUxu?=
 =?utf-8?B?Qi9mTDNvc3pJbjZvdkdkTytDUGVYc2p6cXd2MmM4YmIwcDk5bmlFbEtkaVdP?=
 =?utf-8?B?WTE1Z0FZR092NzFEdWhCdjRCNDd1MjdHbUc1M0drYTdBSXY2VnhIRWpzQ2F1?=
 =?utf-8?B?U1hlVUFobnFEYUpRTUtLV0wvWFRjVFpKcEE4dmFzc3JvZ1QxRDNTSk1YenA4?=
 =?utf-8?B?VTV3dnZQYnREek9JQnZJWldxNWpmem9EQmlKazlVdEhBM25KU0ZrZzlFdVdw?=
 =?utf-8?B?WEhyMUlINUZubm1iV0xNZ0JzWVFBa0hBMmNqbmdmRGdKREw4V0xyYzJQT1FJ?=
 =?utf-8?B?bDQzRk11QUw5VVJlVlRJcG0zTjYvREtldWZxN2M5ZmdiYVN0RHgwR3BzRVZM?=
 =?utf-8?B?eVpRb25Mb3AxSG15biswUzNidysrV29jaUFQNkk3aVNxY0lHemVBNVVWNWtF?=
 =?utf-8?B?UDcrSVY5NUpYVmJjbmR5NUdqdmhsbFhVVG5ZOCtjVGZqNUplNURyMDc3Ty9y?=
 =?utf-8?B?K1AwYWNjSUlGTjhscUJvN242bWw1WUZVS2VGd0p3UWljSTIzYWtvOEo2Ky9O?=
 =?utf-8?Q?6YuFFrwRFodvpQaPZPAfFuTtf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b694493-1841-4b37-e904-08ddb49877b5
X-MS-Exchange-CrossTenant-AuthSource: DM4SPRMB0045.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 10:01:49.4380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oAbSvlbiB9mUGcxTeX+Rx1Arh0DSCifYpxFGIsNMiM3FKyYUQ60TmpDte86NwIUOImlJnn92l4tI9agM0t2KGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6549



On 6/26/2025 1:56 PM, Ingo Molnar wrote:
> 
> * Nikunj A Dadhania <nikunj@amd.com> wrote:
> 
>> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
>> index fbb616fcbfb8..869355367210 100644
>> --- a/arch/x86/include/asm/sev.h
>> +++ b/arch/x86/include/asm/sev.h
>> @@ -223,6 +223,19 @@ struct snp_tsc_info_resp {
>>  	u8 rsvd2[100];
>>  } __packed;
>>  
>> +
>> +/*
>> + * Obtain the mean TSC frequency by decreasing the nominal TSC frequency with
>> + * TSC_FACTOR as documented in the SNP Firmware ABI specification:
>> + *
>> + * GUEST_TSC_FREQ * (1 - (TSC_FACTOR * 0.00001))
>> + *
>> + * which is equivalent to:
>> + *
>> + * GUEST_TSC_FREQ -= (GUEST_TSC_FREQ * TSC_FACTOR) / 100000;
>> + */
>> +#define SNP_SCALE_TSC_FREQ(freq, factor) ((freq) - ((freq) * (factor)) / 100000)
> 
> Nit: there's really no need to use parentheses in this expression,
> 'x * y / z' is equivalent and fine.

It will give wrong scale if I call with freq as "tsc + 1000000" 
without the parentheses?

SNP_SCALE_TSC_FREQ(tsc + 1000000, factor)

>> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
>> index 8375ca7fbd8a..36f419ff25d4 100644
>> --- a/arch/x86/coco/sev/core.c
>> +++ b/arch/x86/coco/sev/core.c
>> @@ -2156,20 +2156,32 @@ void __init snp_secure_tsc_prepare(void)
>>  
>>  static unsigned long securetsc_get_tsc_khz(void)
>>  {
>> -	return snp_tsc_freq_khz;
>> +	return (unsigned long)snp_tsc_freq_khz;
> 
> This forced type cast is a signature of poor type choices. Please 
> harmonize the types of snp_tsc_freq_khz and securetsc_get_tsc_khz() to 
> avoid the type cast altogether. 

Sure, I can attempt that and send an updated patch.

> Does this code even get built and run on 32-bit kernels?

This code should not build for 32-bit kernels.

Thanks
Nikunj

