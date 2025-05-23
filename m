Return-Path: <stable+bounces-146169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7668AC1D4A
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 08:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562689E5F3D
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 06:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CDE1A83E8;
	Fri, 23 May 2025 06:52:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF77510A3E;
	Fri, 23 May 2025 06:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747983164; cv=fail; b=k59xo0Z/14TSqJJ4+RyEZatRxbObA/a3UhxF1/yqATkwqNWqYziQT39tDYCKd/ZroAL+3Tu6mvKH9+MpmbJx7T3uCd7HuK5xHH+WS8yK3LaJxLxRNf2n/dcuNggidvbPvJiXE/g5FV3I3NmwfXrLDWFO89QZnenSWl6SVCi8lzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747983164; c=relaxed/simple;
	bh=MDiFc2HdGOPsa7IN45HZY1soHF3JcWH2IplNgt35g80=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n2EOxV3L6MnQ49LvG9gitk9mfTCPm5Wqk4GSjqY8uLJxBm3g4D4xXBWNt0DqnEtzIW2pTnPriutYEJnWKshaDY2P0XZjbt8ATjM9XxPb3/8Orjli4kZs+qnmC6/Ez8nysMeA18sOKxWlufsCw9NFmGzIOCRk42LSPFfXPKY6r1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N5AAK5007989;
	Thu, 22 May 2025 23:52:33 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46rwfsbheu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 23:52:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XtF+GOAJ4GwDmRBQzl/IL3GZcvBm+gqtzlVZlgoANl2gccHn5eanqj0ru7nza5+jDWTagj9PB2Nvd5TsoafAVyulIlS79ipmV4etm53qdim6ZdSEhgP0JLAnC7ZaD7DuUUyoW7DU6HGT/IE4ShegRFKveLWn/hs0GIHJcd606nqf8AXYAmu2u4sbLeg1TByj6lGugHNa3SMuwcELZ37cUKLKus4FQ3DHPV0zD97rmf5hIGwM/tdHT2xCfkh3Ei9ZSbNQeYQM15md8z31T/aCDnoBg33Xc/ZKgRHHsr8+2DIM2xZVuO5fe/iT8YyZxSMSfniuzEfszvJD5sC6UPIHGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BM8fM/BM1ZNFPQ3b8Z/9IcBlXBfLL86QFoq+AKpNew0=;
 b=NG/QGUt2UTRHbt3pTUw0rx/1prP/DEC6W2CmAbEHBlmkldUZbWOd6RUrMbNzRKs1mbZpfc65J8HO2+yqj4W/p0lWyYFzo4MvZIU5R9d7xQeiW2mPcd1L9wrakXIVW4i6xsof6dEO6Ib2E1R4sSUyuJeFXCvWspw7g3WSMzLUxmXNK/jCcbddsQrKhguv2W1iYDZLsSrNzfiDxhOR7Wx2HIyL7mwlK1IdIbZ7KyXTVQ5yFDLJ2iK3WTT8VlR07GNntGjp5sRLO2vX3YCHaC/Jl0T21rCI33Gnqgoq62CnqzETHhd5g7V3k5SH9SB8IvXaSeOIzlMpTQnpkDJisiG0DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB8200.namprd11.prod.outlook.com (2603:10b6:208:454::6)
 by DS0PR11MB8761.namprd11.prod.outlook.com (2603:10b6:8:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.36; Fri, 23 May
 2025 06:52:30 +0000
Received: from IA1PR11MB8200.namprd11.prod.outlook.com
 ([fe80::b6d:5228:91bf:469e]) by IA1PR11MB8200.namprd11.prod.outlook.com
 ([fe80::b6d:5228:91bf:469e%6]) with mapi id 15.20.8769.019; Fri, 23 May 2025
 06:52:29 +0000
Message-ID: <73509a8c-7141-49d7-b6d4-25a271fbad2c@windriver.com>
Date: Fri, 23 May 2025 14:52:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: nfs mount failed with ipv6 addr
To: NeilBrown <neil@brown.name>
Cc: chuck.lever@oracle.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <> <faf777ea-3667-45c7-b7f2-111b9f789e73@windriver.com>
 <174795607490.608730.5673295992775861610@noble.neil.brown.name>
Content-Language: en-US
From: "Yan, Haixiao (CN)" <haixiao.yan.cn@windriver.com>
In-Reply-To: <174795607490.608730.5673295992775861610@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To IA1PR11MB8200.namprd11.prod.outlook.com
 (2603:10b6:208:454::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB8200:EE_|DS0PR11MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: c1c5d6e4-90cc-4d84-3f93-08dd99c662c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUFZRituRmc5TFEzN0xwSG9La25Ncjc5KysrYk8welBqU2YyL25OdWNWSk01?=
 =?utf-8?B?aTlIUTVFNTBwWUZaM2JiUlhxVlViTDNUVElzS0RSNFoxUktKRkxlVzNIZTV1?=
 =?utf-8?B?a0FKTnhHOUpnc2NuSDNxMTV0RW0vdXA4d1VyUDVoaHoyMVdLUVg2ZjRNc1Jx?=
 =?utf-8?B?cjd1ZHREK0pDOGpaY2NCNXJYdjU3ektqd29iK2xoWHZUQXpRVHVhOFB1aUVS?=
 =?utf-8?B?QWRZY212N2pKa3ptYlpqQzk4cWVYajdsbjY3TFRNNUZobDBJRTlhRGV2c1lF?=
 =?utf-8?B?VWR6Zi82MzRjUTlTclh2YlhXMjBnVFNRd2pXQ1BkbUlFVkdqa2FSK1VVUjk0?=
 =?utf-8?B?SDZ3dVhZdlRsbWNWM000Wnl4ZU4vMTZwMURBMmdpZVIrcVZKUzNGV1Z2M3Ba?=
 =?utf-8?B?WjJOVXRiNDZiNjN3bDVGNnR0TU9HWC9ETVJOYTJRSW5DTkQxSUJxQUt6Q3Fu?=
 =?utf-8?B?a2J4cndINk9kRTFWQnVQN2NNYzc2MW40d0xOZjB0emp0MmhXaENYZDVReXM2?=
 =?utf-8?B?VWdxU3dVL1A4c0dtbHFOOWVKQm16NFhWUUU5cVdJcFBGZ09SN05XL0dRbjdJ?=
 =?utf-8?B?WXRVMytjUEFQbTBtZEpoR1pWM1F4ZkJFZzZJT0JkWDlpYVR4NzdwcElRaElp?=
 =?utf-8?B?STliU0VjRk84SkVkdEc4TjVXT3E5eFRkVVZySkg4Njg3QTVpS3lzKytna2tY?=
 =?utf-8?B?SEVhVzVnWFVaL2tETDd1Z09jWjFuOTU4R0JkSVdtNVRiYTZWZktKSm9RZmRv?=
 =?utf-8?B?L2E3TStYVW5MZlpIeXpBdEcrTS9Oc0NKOFN2eE52VkluYlVwekxtdWxFdWdO?=
 =?utf-8?B?RkRpSVloSHdsaHlqcEF1QTVadnhjd3NCaUtLTzE4ckRUZjNGN1lDWVUxNmV1?=
 =?utf-8?B?STBjTGY4eGNiR0txNXpWSi9hWmk3MWNucHVKTHNKOGZ2cXpBMGYxcDhWWllk?=
 =?utf-8?B?UmI2cmlKVytMUnlvMnNvVHBONWZrb3d2Rlp3OGcxQXhzdm1pT3VPRUZaa3RX?=
 =?utf-8?B?OXB3b0hod2s5eTdKVWltV3FvRTd5VkVmeXpST25YV0ZVb0d3Szl6bFJyRTBV?=
 =?utf-8?B?dFJoNFlUaW5DaU9oSW9vVE5hakpLaFdlMEVsUHJYWFdZWmVrcWVMb3lReEJL?=
 =?utf-8?B?NjR5QW5lWXdSMHQ0OVQ1bS9wbXo2c3MzVEZOVjVpRFVEbmc4RmlBSUo4UE5o?=
 =?utf-8?B?eDV3SURLa2hNTXlTbHJIeThHUE80eVFxdlltNCtYaVkwb3ZYTld1Zk1BeU5Q?=
 =?utf-8?B?b0svMkRrTkdUMHJINjFFMzNJTm9ZNjRUb3czMkdVVTBvN3hjbFBaT1Bxd3RZ?=
 =?utf-8?B?cFNCdzF6dEs2eU9tVDdRdUlNOFNiZW9KRERoWHdMVGlnOWxtVEc2TGgwV0FZ?=
 =?utf-8?B?b0RDVkVucW5HUkdGSWJ2Y25mWTlsUWNFUGFQeUtkMWZKRk1JVHdSZnFNQU8w?=
 =?utf-8?B?d3AzVmRaNEZJL2NOU1NVY1Z5YWh5Tnk1QmQzT1dzWllCbHQ0cnJnQ253d2Rw?=
 =?utf-8?B?dGcwejd5eU1ualZ1N3U2anAyNVcybTJwNmRGb2xqWEw0anJ0UURWOXE5dlpy?=
 =?utf-8?B?ajBvSUdsNTl6bDNIaTdyU3NXWFdHS3MyOERPSGtCKzNmWWFiWXJrRDkxQ21a?=
 =?utf-8?B?aXY5eHFsRGpKT2pYREtpWWVkQ1Rad1g5Z2tSbFZqU0Q4MUFIUkdWUmY5OE52?=
 =?utf-8?B?aC9KVExSUUR6K3pDR05ZOFJzdC9GSktzbTNoMTZJdVdxR1ZCM0tDSFFyeDZ0?=
 =?utf-8?B?Tm5ZU0xKRDdSU2FxdVNmanZVaUtuTnFwTS8xOFp3b0o1RTdqbHptT3lXdTRR?=
 =?utf-8?B?V1YxNUVSKzVtSkhZVHBiVTlVWGZEQ25iY0c2L3FwSG9ncWtxQkQ4aCs4eUcy?=
 =?utf-8?B?MGR2bVdONnViRjBYRGpGM3hDd1B2enUzeTFQdEFUeUt0eVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB8200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzJNRDVZMHlXY28yZjZsNFJXTy9NV3pEeUlRVTl2aitWaittanVqTmNWUnFM?=
 =?utf-8?B?UTF4TnJnRVlUSmpsRHI2S1hFRE1QS2pqbDNPMWVEbXhxV1RybTZnN2FUWkZS?=
 =?utf-8?B?WFB4aVpwU1o5VThDcEJOR3lRQU56OHFvajRtU2p3ZGUwT2orNTVJRTd5MXdx?=
 =?utf-8?B?N3dxRXU3eTZudXZmT1BRR1R5Qyt6SWxGOXRCVVhVOU16UUR6M1h2ZXgzVzhp?=
 =?utf-8?B?Vy8yRnhqV0dFMWdxb0pOWndTaHdEcFlLM0htQjdkbDl5TDNvcHZCdzRtZ2hZ?=
 =?utf-8?B?dDhKUmdMY29jdk9zYXdockx2a1kzTy9GTFVvMThsQ1JEVjZqTnRjSXhORnov?=
 =?utf-8?B?SlhOc0Z4ZTROZVVSeERPSlVGMjIvVCtOZ1hJUVRzMCt5Q25YaWlxdnBudzdU?=
 =?utf-8?B?d1gvM3ZWTTRHTkJEaVRPeld1RkFtSzJxOFdYeHc4UGo3aTdRRWxHYVlObyth?=
 =?utf-8?B?U3VmR1JxR01vVDdrd1BjM0tBZzJIU1VVQy9MRGQ0bzhYeVdWL2dabUFKYS93?=
 =?utf-8?B?cmdiQzZKNTgxbWNIZFRGMVlDWndlb2dodG1Rb2VTanA0QysxRm9ReHRBUW8y?=
 =?utf-8?B?MktmN2ErNWNKVStYZUlESkRIQ2ZWc1RVTXdSL2RwTXJES0wrVnE3enZBb2JT?=
 =?utf-8?B?bWorYXZhbUNFbUY3SnROWHk5bmY1ZkxpRnB4bFJ6MEhzQ3AvNlMxeUN4VGIv?=
 =?utf-8?B?bnhyRTIxQlpweEhHbWQ4NXNMRTBwTVBpK2hvOTExb3VXbE1YTjlCNTVOSmVH?=
 =?utf-8?B?R1ZYWVFzTk9FZFI0VFc2d0NXai8rMlIxazF3VXUvT1E2eWxKWGxNcERXclR1?=
 =?utf-8?B?cnFBRTV4bzZ3NWdvZG9ycklTK1JjV1NkR0NGREpKRWJ6SUFML2dxalJobFRk?=
 =?utf-8?B?bUJhTWpiS2lzNlFGMy9SZ0xRT0tCUWJwbXloOHU2MEovZVNQc240enNJekR2?=
 =?utf-8?B?L2FiejRIYXRtSXRaZEdFN3NOTFdQM0JsbkJtZmZUZ1ZieDlVT2gxQUl1dFVs?=
 =?utf-8?B?aUpoWSsra0kyVVV5QS9NNWt0alZKV1M5dTc2WkE1QW4vTFp4ZXJyckJYMElh?=
 =?utf-8?B?aTYwNmJVWGdRK21ROUVETHlJY1BsUVk4NHpGOCtQaUFkWXYwVVh2UUhub2pD?=
 =?utf-8?B?SFJaV0s1ZEV0U2JkNUl6bXhzY2FGcDEyZ3Nrb1h3ajBKcGlZS2lvYW1jRVpr?=
 =?utf-8?B?N2FYSHRMRHRzUmQrT1RFRjF5MlFRN0laQWRwS1REa1dQNG1wM2lZc09CWHJE?=
 =?utf-8?B?VWY2MWdRaFk3M2tKS2NoSmZOZnkvL2RHdU9zSmNpa2VRUVczSTczSmpLMFFv?=
 =?utf-8?B?QkZUbEFhbUFhNHA1Z1ZCd2dYWWxGLzdsS2ZENDd4TytWM3AwbnhUY1ZYRjFn?=
 =?utf-8?B?WG1FNWZ1WjB4QUpUSXBadDBpbU1hMzJNbDZxYlJHckxjbTY5cFp3Y3RSTXQ4?=
 =?utf-8?B?UlhYM05URmNJMEczM3kxM1pNYnAxU3NBYWg4NGVtSk02c0RPdGpTK2gySklF?=
 =?utf-8?B?WXc2end0UE5GZDBVR1cxejBrQndMd2dIR1pzY2lGclZ6ZWxMaG1hMDhSUHov?=
 =?utf-8?B?T0lDc3BzMlg0UkRyMDFxVjBLZDRkblI5RXRUL2tMVjJqWnJxWE9XSWtyM2FH?=
 =?utf-8?B?QUMzU1RrMUxXbHZpcDVGc3lSWGNUZkhyZjVUWlREdFd1azEzK0t6Nm83VHBT?=
 =?utf-8?B?Um03OUI4bHA5RnZlTnJtMW9TVFB1Q1JrUGZNMEx2U1hIdFo0eW12OTc4bjc1?=
 =?utf-8?B?d1NKTVJTS256OEJMUDVWVlF4djQ3UWRzdEl6bVByRW84dXhXeVptZmpLZU14?=
 =?utf-8?B?Um1KLy9qZWZnMjZzNHd2MXI1MHJNKzlvdlpUYkpnSm1qYTdwN2xkVkxVeDVu?=
 =?utf-8?B?d0JCd3pGejQyL05NaWZGQ0dWQ2dTbFlWYmJKSHdMTUszNjFENHo4NkdtUFF4?=
 =?utf-8?B?WXQvRFBXQ2FRVkJaZ1JOdUcvaGQvUUh0YXdYeDYvY2J4UjE3VG5ZQkwyMUlJ?=
 =?utf-8?B?STJKVHo2UVJ4b1gxNUdUYndsVXFaRlE1cmExSTQ4a0ZzbDYySjFrM0xjOS95?=
 =?utf-8?B?aUVQMzRqdXBNUXk3cTZ0RmRQV09VcjdTY0krdCtjVXNkU2ZRVXZFbExCYTZZ?=
 =?utf-8?B?N0d4OGZORXFiUDdDdG1jb0FmT3ZtaGdGMXprQlY4SGk4S2Zlb0QxTTV6MUJu?=
 =?utf-8?B?bEE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c5d6e4-90cc-4d84-3f93-08dd99c662c0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB8200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 06:52:29.7575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKbAeDBph+MnlU725onsz7kklwUsyuNSba+auoRe3UUFakcwHb983gQnbph8M3N2cydiUGyikehB6t+PYOYVOl71A1+7t8TOwidfyN8XNA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8761
X-Proofpoint-GUID: 7ij7X0NwfQXiajtTjRLx5LgDteJmK0hm
X-Proofpoint-ORIG-GUID: 7ij7X0NwfQXiajtTjRLx5LgDteJmK0hm
X-Authority-Analysis: v=2.4 cv=KJNaDEFo c=1 sm=1 tr=0 ts=68301b31 cx=c_pps a=6lib/t1tMPUsg/VFQO8C4g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=aArSsRRUTFfjJ_SIhjAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDA2MSBTYWx0ZWRfXxF7Nm715ZK0i 1WkXCClQYZT/mQ9OJf0rA61gKQUCF+sS1zJ8NwT9W3u5m/G7baeDiKFHn9mFpCeI1S8XZmk/Ejf 1jk1EeTI4jTNgfXsorVgTUIdFpEjPFg8IDgb78kGWN0TdPg/DXyDv0ASF6LrWK/kRjl9pDwNdT/
 /cy3uNrBtSM3GZqBcPDmK8q/GUHw/RAVgEtzXCcSqwxZeM6cLI6CNFFli+DWzsBBhVlP65xfBte oeB2jSAbUbgw8tReTyR8CVdyQ4/rNaOLpxTjHu2+YhQWsvbSnTvppoMM1ZkNggrlZLlL1GTihhT V6gfYiF1ZWGXcxBqqmJf0DXwLUb2vR0ZHtkU4G9oa4k+dMLXq0mLXmRP+wipJrxArYYTfvT/hK2
 qtF/01us+UZR97r42ew5n4VKTMyr4jNIyBP092tOMKdfbsFezlfDr6N2pPXLD5Q1FWBJ3XDE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_02,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505160000
 definitions=main-2505230061


On 5/23/2025 7:21 AM, NeilBrown wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Thu, 22 May 2025, Haixiao Yan wrote:
>> On 2025/5/22 07:32, NeilBrown wrote:
>>> CAUTION: This email comes from a non Wind River email account!
>>> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>> On Thu, 22 May 2025, Yan, Haixiao (CN) wrote:
>>>> On linux-5.10.y, my testcase run failed:
>>>>
>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mount -t nfs [::1]:/mnt/nfs_root /mnt/v6 -o nfsvers=3
>>>> mount.nfs: requested NFS version or transport protocol is not supported
>>>>
>>>> The first bad commit is:
>>>>
>>>> commit 7229200f68662660bb4d55f19247eaf3c79a4217
>>>> Author: Chuck Lever <chuck.lever@oracle.com>
>>>> Date:   Mon Jun 3 10:35:02 2024 -0400
>>>>
>>>>      nfsd: don't allow nfsd threads to be signalled.
>>>>
>>>>      [ Upstream commit 3903902401451b1cd9d797a8c79769eb26ac7fe5 ]
>>>>
>>>>
>>>> Here is the test log:
>>>>
>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# dd if=/dev/zero of=/tmp/nfs.img bs=1M count=100
>>>> 100+0 records in
>>>> 100+0 records out
>>>> 104857600 bytes (105 MB, 100 MiB) copied, 0.0386658 s, 2.7 GB/s
>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mkfs /tmp/nfs.img
>>>> mke2fs 1.46.1 (9-Feb-2021)
>>>> Discarding device blocks:   1024/102400             done
>>>> Creating filesystem with 102400 1k blocks and 25688 inodes
>>>> Filesystem UUID: 77e3bc56-46bb-4e5c-9619-d9a0c0999958
>>>> Superblock backups stored on blocks:
>>>>         8193, 24577, 40961, 57345, 73729
>>>>
>>>> Allocating group tables:  0/13     done
>>>> Writing inode tables:  0/13     done
>>>> Writing superblocks and filesystem accounting information:  0/13     done
>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mount /tmp/nfs.img /mnt
>>>>
>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mkdir /mnt/nfs_root
>>>>
>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# touch /etc/exports
>>>>
>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# echo '/mnt/nfs_root *(insecure,rw,async,no_root_squash)' >> /etc/exports
>>>>
>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# /opt/wr-test/bin/svcwp.sh nfsserver restart
>>>> stopping mountd: done
>>>> stopping nfsd: ..........failed
>>>>     using signal 9:
>>>> ..........failed
>>> What does your "nfsserver" script do to try to stop/restart the nfsd?
>>> For a very long time the approved way to stop nfsd has been to run
>>> "rpc.nfsd 0".  My guess is that whatever script you are using still
>>> trying to send a signal to nfsd.  That no longer works.
>>>
>>> Unfortunately the various sysv-init scripts for starting/stopping nfsd
>>> have never been part of nfs-utils so we were not able to update them.
>>> nfs-utils *does* contain systemd unit files for sites which use systemd.
>>>
>>> If you have a non-systemd way of starting/stopping nfsd, we would be
>>> happy to make the relevant scripts part of nfs-utils so that we can
>>> ensure they stay up to date.
>> Actually, we use  service nfsserver restart  =>
>> /etc/init.d/nfsserver =>
>>
>> stop_nfsd(){
>>       # WARNING: this kills any process with the executable
>>       # name 'nfsd'.
>>       echo -n 'stopping nfsd: '
>>       start-stop-daemon --stop --quiet --signal 1 --name nfsd
>>       if delay_nfsd || {
>>           echo failed
>>           echo ' using signal 9: '
>>           start-stop-daemon --stop --quiet --signal 9 --name nfsd
>>           delay_nfsd
>>       }
>>       then
>>           echo done
>>       else
>>           echo failed
>>       fi
> The above should all be changed to
>     echo -n 'stopping nfsd: '
>     rpc.nfsd 0
>     echo done
>
> or similar.  What distro are you using?
>
> I can't see how this would affect your problem with IPv6 but it would be
> nice if you could confirm that IPv6 still doesn't work even after
> changing the above.
> What version of nfs-utils are you using?
> Are you should that the kernel has IPv6 enabled?  Does "ping6 ::1" work?
>
> NeilBrown
>
It works as expected.

My distro is Yocto and nfs-utils 2.5.3.

Thanks,

Haixiao

>> }
>>
>> Thanks,
>>
>> Haixiao
>>
>>> Thanks,
>>> NeilBrown

