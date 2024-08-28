Return-Path: <stable+bounces-71447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A683096349D
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 00:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332731F24C2D
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 22:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D071ABEC4;
	Wed, 28 Aug 2024 22:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VSzQb8+U"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CEE1586CF;
	Wed, 28 Aug 2024 22:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724883717; cv=fail; b=pc9tp5isgSWt76V8mcWBwGyJ1uIa3q7pV99qIX0yILc9mFs3BLx2x6bzCXBAIzHDEEOX90tnKa8vv1rXP7gJ1d5lcmGAgTDjm8TngUYdp9hKKMYSLJ6OIFGMQCSviuhil/CIP1ykPfa1H+TnM07jrXCTr2AGLXUJ83hqY8HEAWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724883717; c=relaxed/simple;
	bh=0r0kNzfXEt76iwX7cTA4cUmtEx/iaJqb9KTRpZpVaTI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kumWmrFIX2hLsBfg2CrznyEIxNyuCORDWDJC6ydNlI/R3jqED7RLk8ftwgmt6XuPLrESUziz7jqXXjmvRHOaa8hOeqEo7qXoKVgix2Ncx5m1A3JDYcodVqipfoc4Icg7PC/zQ9rlOcjnAIFZDlif72y4fFADVkQdcGX3aOz9Raw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VSzQb8+U; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TO2DW4preXXAeSC9b3nKj1RPHJP25/TzGqgZY24/yjC1//r4tiIeQjck1G5lcoUoorl/6sflPGxTFr1ZumeNa7jHdYkkvoIgViaw/XM7zUy9BqB5s8M1l5EmD1xjVOA4f+4XDHg3a17iH/LAFpZYg1ye/cjtT7Wko2gLplt+nce9YAaiF+5e3dIg9Eb5VAGmyLym1pIBzr5Fr6bxL+1YpKRI3mcKmKEV+YGbKS22/uJxRZex9EsSmKRxKk6Ra+knIwNubfsN/MDhSibOdb5zIlDebOpVP02S+MWBiGsuoERX9WQO4DWbcaYtvaOmSc92h6q2AxqnTyeW0JEx6t88VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzYjdwrDNLQS/QL3XwcIvhba7OErZpYrWm8EsPbj8Is=;
 b=AlE8LuO5tvQc6ncEEHC8JSuuS6ou4n2J9w2lVPfj54jMtcRbn2AHIftoBgsscHn/3egDQeu2eei377GCcDFfquWOEQVR925bS70OwUz09ph8o/xT4GTmXIh9ZaY0lpDhgNAZnO7ApfGsiEWsmUdRw2aCmlY45mqOP4pqtkhpyvVTt/zEe8MAGJKGjyqbc/4IcFa/n3UwFxxqRDSp/5jal/3+w7egKA6PYsCXXNJB4uFkOlJxrVrmX/dQeFIB2KP3QXXiiYZ3FJl6gAzjfU22X7x2MAMPd5ZuuogaNzCtcsgx0BE6GdmXj/iiQmg30OOe6+dpd/8ua02fTG/GHdN1HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzYjdwrDNLQS/QL3XwcIvhba7OErZpYrWm8EsPbj8Is=;
 b=VSzQb8+U3GK37NTsmxApSHDFN4wDKhGX6cZV/slxxTdi/+FmVjPBPLGwIQlzW6tVUW43ti1QamKYK3XLtGWDHHV1dhpT4NsRNycCf9Mx25/uuLuc87Er/4iMBnG0qM/dAXbfXhvE1NV6MD4GBgI0Z7sRxdTyzQaG3VslILfkz9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB6949.namprd12.prod.outlook.com (2603:10b6:303:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Wed, 28 Aug
 2024 22:21:52 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 22:21:52 +0000
Message-ID: <995e7240-5440-479b-bc90-0b20d0ebf5ab@amd.com>
Date: Wed, 28 Aug 2024 18:21:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: Fix race between __split_huge_pmd_locked() and
 GUP-fast
To: Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand
 <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Zi Yan
 <zi.yan@cs.rutgers.edu>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240501143310.1381675-1-ryan.roberts@arm.com>
 <3d88297b-ce6f-4b97-8a25-75f0987af6fd@redhat.com>
 <60739cf6-42ff-44c7-8e33-6c42eed71a66@arm.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <60739cf6-42ff-44c7-8e33-6c42eed71a66@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0289.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: 339331fe-5482-44d3-d137-08dcc7afd14a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWcxUFl3NUhWT285dVNXMzRJLzE5YlVseTNxaXhJOERlMk1zTGc5cUVhL3N1?=
 =?utf-8?B?MnFHRWlzWXNXNmNTT1BRcWVXM1owbExWRTlmWmd0M2lOYkVIVWVPaFlXSldw?=
 =?utf-8?B?VDl4Z0piU2NyZmpuTUJoRVJ0L2h2RTdHTm5DNE1OMGdJclVFcEd2bzk1SVBu?=
 =?utf-8?B?NTZwMk5ER2hMbjl2ZlJPNHhRNnJUOVE5RU9JTHc2VkJvdXFlbS9rWUJTaGxC?=
 =?utf-8?B?UjBLc1BSUUp5MWZVTURpY3A4RGVOeUJnazMxOGVicHFPYUJXMFdHY2lycVo5?=
 =?utf-8?B?RHdXbWQ5YUtKdmpNODhTckh5S3UvYWpwbENJalBiZGNzMTNnaW1Sc29yUVh6?=
 =?utf-8?B?NFZVcFJNcjkwcng4ZWdGYjdRYzhEaldiZk1uY2tFNVk3NmtCYTZKLzcxMTBi?=
 =?utf-8?B?a0ltdUNFRS9IaGYzVkdsa3NJdWFVb25ETENJRFRZZ0pKbUFLQnpGczZrRERF?=
 =?utf-8?B?d3BHS0ZyTEI4NnFFQU82NHZDaVp1akhVRVNrdWFFTGFYWndWaS9zSDJpb0Y4?=
 =?utf-8?B?VmJkc0l2eHE0WDBkVk9jRXRUN1BPTHp4UFpKVjlVaGJ0WmdSenpoSHk1QlFY?=
 =?utf-8?B?SW94OVV6eHdiU21EVERna0EzdElLcmYxTEhWV3VYSFVPZWowNGc1elJjTnEy?=
 =?utf-8?B?NnJpak5zS2Z4clhrRnBNTVRyOHV5ZDE0cTA3R1U1aHpBbnQzTGplemFPdU1I?=
 =?utf-8?B?QjdDTHZNdThBVVlyQUdVc2J2SGtvTjhDUldVZ0l1ODBsOEQ4Ri9TSVJSRTVn?=
 =?utf-8?B?TVRHMHM5Ri9CNGZJeGJyeVI5Wit3aFRFMFR0T2c2TFhRQXN2bTJkTVF1QW1H?=
 =?utf-8?B?VnllVHhFaTZGRHRsWEJnYlBZdkdJWm92UzVkaEQvNEt6dHEzMjU0SmVwZFh6?=
 =?utf-8?B?a1l3MHZPK2lwQi9taDB5eGNweHhKblk2ZlBBYTFoMGl2L29hRzNhVS81YWFj?=
 =?utf-8?B?cFlZaGVJbE9ubmVBR2doTjduZUk0ckdWNjA4TDlMWWxHMytXNnFQNFNrRUNB?=
 =?utf-8?B?NFdzZWdxZXlLdGFRd0RXUlNGZWdDWkdIZ3FBRG40cGg1cVIzOTl2eEF3YWNG?=
 =?utf-8?B?aHMxMzFjTGJOS2pweXhVTG9TRmNEbE1LZ0Njb3gwSkJnZ29QZE9qZmN5a3VB?=
 =?utf-8?B?ZzJuNEdiTU9HdkFGUXFyUnIxbU02ckxlTGJCVnJ1SzAwMC9wZlZSeWkvcWJW?=
 =?utf-8?B?T1VPTDJjZ1M3MVFCaCtRdzBEZHdVczlLR1BmOSs5T2p3UkJWcTVhaXRYRTFh?=
 =?utf-8?B?VGlGYS91MXZOY0Z2WWpNeFNCTW1YaHB3UTNZeFhVNHlEYWp6SkhUUE1ZY1VE?=
 =?utf-8?B?TTJGR0R4NTlrM0hIcGdoVCtoRm1uZ083WDY2WkQ1cE53emhmODdDSnIwdTVV?=
 =?utf-8?B?RXJpWUw3b0FpcStvT2dzWlB1dDlZK0kxZjc0QUZlTjNhZVRibE1TbHZieVAv?=
 =?utf-8?B?RnhMOFdsUGVrS1pjUEdMbUhhSWtuS3gvbFU2M25DSEhoUkdQZzYvbml4a1Rt?=
 =?utf-8?B?RHd2RHpVNk80aHdEOVJHbWE1UEY4aFd0NnYxV2ZzNWxyaWkxME82SEVKNUE5?=
 =?utf-8?B?WUV2T0Zwa3I0eFZNZVJvS2o3TzlsR2RoZUNFRjdZekY1SHkzOHpuK3lWOFlt?=
 =?utf-8?B?ak14cG5YdGxVWkRlckcrKzFTOCthOHVaNG1UekNVTG12V05ZWFI1WXpES0cv?=
 =?utf-8?B?RTUySmFRejhUWFhNdmloQkpFVDVXN0JrcFN1QkZ1ZjVDMjNTMUZiZkVPL01v?=
 =?utf-8?B?QVhmTGxSSlYwS3pFYTFPcTFnb3lIWkRxQkhhT2pnWmZHQWFhUy9DZTFmcldo?=
 =?utf-8?B?Sk44Z2lvNlpsQUMrdFZWQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3dXcFZJMzlZZHBOcjQ4MUxzdWl5alRjSyt1OG1xbDNiS1hVaGxPckxyb3V6?=
 =?utf-8?B?Rk5nZTI1SUlJYkIxL1p6bDRseldWNzF6LytGOWVDVlVzYXRPb2tPU2pZb0xm?=
 =?utf-8?B?a1UyZmxrdlMxTnJVU0ZwMHBXNGJybG55cUxVWUJ6RkxXZGQxcjNZQ3FveW5R?=
 =?utf-8?B?czNLU3JrRHlVUUZ3YlhWZkJuZUUvWHpKYmNzRzIvZXdrTUZGV2tEaEFJWTRQ?=
 =?utf-8?B?RkVrSjVUNnFzUXphUy82VDZsdXVHRFdseHBBbGpPRHB6anVMekJWb3RIR08y?=
 =?utf-8?B?TEUrbndSOHYrWTFTK0pIRG14bGRXTmU2dlc2OGRvRWNWWE5JdUpmSFM5WXZm?=
 =?utf-8?B?bG1NQWU5b1Y0U0U1VzhYTHNwTk9lcG1BbkhMSXBFcWxKL1pub0FhNkljZy9Z?=
 =?utf-8?B?WDFNN0dRSlMwVXR0K2JLWHoxYVBQdmYxVlBoT1h3bXZNdThnMUZOWDk0a1R6?=
 =?utf-8?B?VW9tVmM3TDRBclB4bk04MHM3dzFxSWVLREF0enZvRFJXMzJkRmN5U2pXN2Mr?=
 =?utf-8?B?VXpYZzhRTHBlZ3d1OWJUVjFtR3dQUGVaVGIxZitMUFJUMmU5RERtZ1FTTUND?=
 =?utf-8?B?K2hoeTNxUjhrc3FUZjZSb3ErVTBXY0V4OEVpS29neTk3cTJKYS9waXZHUGlh?=
 =?utf-8?B?bXdOdE5YR2pydmZuZXpxNFlGV1VabGhnclFZY0IrV0s2SWpiK2tnSmhpVmZO?=
 =?utf-8?B?RnQ3cml3ZmZUZHhocWpiM2J0VnFka0JwSHVuY0FGQ2JzUWIzNWFIbkNsUDZU?=
 =?utf-8?B?TVlKdVZQNEp5RlMxOHJFTjVlT29NdDNxWG0rZENpL3B0cHNDYXRWS1oxZWM1?=
 =?utf-8?B?Rm1ML2tnQW1HMzZXdWIyN1kxWUN0bithWFo3WEZGWUhaWElQemh3bzBBYTZZ?=
 =?utf-8?B?OGNUMSttbHNQM3hOZGgyaFhxcnFuNDJoUzQrcWhvaHNseU9wNnNaZkFXTExj?=
 =?utf-8?B?ZkRwZ3J2TS9hZTFJMXQ0cUZkeXl4eTF4MGlDMDZEUUVmSCtBbFNRMXFFelZN?=
 =?utf-8?B?UXU4RExYK1d3WTFxUzBBMkJrVWw0MDZJU3hpVlViWndMWnNPTlFYOWR6a2dr?=
 =?utf-8?B?cmovWjlydzVNRFdWUWVzM2xXaHl5OWpRelN2cTEvZ2NjbWY0OWl1M2lZMXZF?=
 =?utf-8?B?M2YxVUFhTWxxcXdVNU01Wmp2NVZUdnVINDljemZmUGwzRmtmS0o2STRjRStN?=
 =?utf-8?B?QldIb3YxOWN6YXYxeGNseUtDK3lRVTNKU1NJT3c1Vk5YWi9HWXBqQlZuRzh2?=
 =?utf-8?B?b1BRVEJDOEsrWW5aQk5SSWpjcUFobnpSWm8xMkR0dmJKNjNCejNyQjVRV2h1?=
 =?utf-8?B?dXNKam45b0FiTDRPamtDclVyVzZjN2llZmlpTGN3TDVMdElaaE9YdWZGVHBl?=
 =?utf-8?B?Mk5PaXZYMUp3eUpHWDdtT3NnNFhnQmFlWkdGOENqNFkyRXJUT0VmRGVGdzl2?=
 =?utf-8?B?NURPTmk1YXVSMmpPb0pDVWpGcDBCM2xaZkJuWUNKTGkvUkkxWWc2Q1FUells?=
 =?utf-8?B?U1JPNGF2NDEzOC9lazJ3Nmw0M2o0REE2N05ianB0dllxQXpEb1ZDRHlZTFI2?=
 =?utf-8?B?TXVzVEZKeTk2RklpNUdPTE5mVVFZajBndWRvT2I1cXl3VkJvaXFza3RwSGww?=
 =?utf-8?B?eGdKRzNkNEpXT1Zqb2VkMDlOVU5vRFVaVWNhdlEyelBVL3NOUTAxU0RLTncx?=
 =?utf-8?B?TGNvclR1MDdzSTFpS0VobENCTEZpRHU5bUZPR2gxamtUOGV0OHFWcVRKQU9R?=
 =?utf-8?B?ajVJUVpYZzBlWHphblpLU0FORDc0eW5zMnZFVkFNRVNMbnJBdE1uT0lybThq?=
 =?utf-8?B?RkRUb21KVG11ZXpCL05rdllwZkY2M0hGQURub2hiSDFLaWpJVTN5b1BEOHRG?=
 =?utf-8?B?dkZBZHFjSlFMWEhVOUxDVlo2U1ZaalBKbmkzaEU3U1dWdENVeHE1MWhQN3A5?=
 =?utf-8?B?b3VDWjZyMjVQM1B2dlZkWklDMC84SmNHclh4ODJIbjlEbkVscWNEd2RYUmZo?=
 =?utf-8?B?VllRTnltcGxkQnl0QkE0TkZmRnBOSGlwWWFLbkkrcXoyNFI4V1UyL1oyS2lV?=
 =?utf-8?B?TkNNQzl1SlptSjdGSEtrVWFneERmN3dENDRBdXJGRzFqMHhKazZFMk1JMUhB?=
 =?utf-8?Q?oyhNkZB4lLGdjBBiHoWT8v4Xn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339331fe-5482-44d3-d137-08dcc7afd14a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 22:21:52.5609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JMXLhxwfQYMZzgAM1PPwQlsNvtfyxgEpmgQeBFvKXTHYCFknFbGJPc7ea0u4iJP0RfUqOwvrTsI6N+YBWejfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949


On 2024-05-02 09:47, Ryan Roberts wrote:
> On 02/05/2024 14:08, David Hildenbrand wrote:
>> On 01.05.24 16:33, Ryan Roberts wrote:
>>> __split_huge_pmd_locked() can be called for a present THP, devmap or
>>> (non-present) migration entry. It calls pmdp_invalidate()
>>> unconditionally on the pmdp and only determines if it is present or not
>>> based on the returned old pmd. This is a problem for the migration entry
>>> case because pmd_mkinvalid(), called by pmdp_invalidate() must only be
>>> called for a present pmd.
>>>
>>> On arm64 at least, pmd_mkinvalid() will mark the pmd such that any
>>> future call to pmd_present() will return true. And therefore any
>>> lockless pgtable walker could see the migration entry pmd in this state
>>> and start interpretting the fields as if it were present, leading to
>>> BadThings (TM). GUP-fast appears to be one such lockless pgtable walker.
>>>
>>> x86 does not suffer the above problem, but instead pmd_mkinvalid() will
>>> corrupt the offset field of the swap entry within the swap pte. See link
>>> below for discussion of that problem.
>> Could that explain:
>>
>> https://lore.kernel.org/all/YjoGbhreg8lGCGIJ@linutronix.de/
>>
>> Where the PFN of a migration entry might have been corrupted?
> Ahh interesting! Yes, it seems to fit...
>
>> Ccing Felix
> Are you able to reliably reproduce the bug, Felix? If so, would you mind trying
> with this patch to see if it goes away?

Sorry, this question got lost and I found it while cleaning my inbox. 
The team that ran into this problems reported that it was a one-off 
failure. They didn't see this problem again. So I can't help with 
verifying the fix.

Regards,
   Felix


>
>> Patch itself looks good to me
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
> Thanks!
>

