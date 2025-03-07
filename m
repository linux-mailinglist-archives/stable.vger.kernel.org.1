Return-Path: <stable+bounces-121428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD400A56F9C
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 18:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D78C189AC78
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 17:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C0423E227;
	Fri,  7 Mar 2025 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DGUaqclC"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA40217718;
	Fri,  7 Mar 2025 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369864; cv=fail; b=Qw7Ae7piGP3ickADbswICF3tbDd/15VFmkfq7ZDqXXRNLfiB9GXeALSw2vnS4OB/uGhV374W2glgScX7mhNbX+MtPiCaQ28U8dgfm9Xx3sO2uGG48XGfD05Y/DBUooQsYZpgByTWooOugC6kjgYc2WkAnRPdUWZV00ke9cBc6QM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369864; c=relaxed/simple;
	bh=w8cdozYyIUAin9jMX2AwG7oYX/VzjeeTMv0dUjlLV5A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PMEYBX9/NHsh1rrCopSYxd8bGYzipifGkNcswEW7CRlPiIgch/mD4EfH7bit0D6BAezuTquN1f5pUpLhCfpNh6Qi15VWERL6eaF/rvSWeQ01dk2EtIE9Bw0x/aj5/2nLkAZfrICe5wH5c0dJ7WZ5N3wwyL0A6ZaC2GUl42IFoXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DGUaqclC; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfK42hnm3+PQsU6vbvvkUoy/jB34Q2dnT3kBt8QhyZk5agZc0diO0Kiw3rbuA5DFAJFNfTxvHeVWmD6QQviv388/4AYMrwIat6X4xE60nyjMs74O7/ntJlcbKkv/FPDWk+juw/Z1iw+gxr1DCHKkgELfiVTK3/uNMp4qEQVClzNqn4nkrHhUQ4vROyjT22rom+7Ff/PJB+5+quRxSdcsUQ5MbHNvysDFMHTkn076RHumGnryYtOeH0JfyAN5ZT5kRNsBAzOU23w2VmEwJfydceuBG3AYSXc4hByqjkL9iOY5KljBwONcSLGyiggnx+3EAqHLQHcHyrz7CXfTdHHmbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCOj0GCQFs1HLzYjM3JCfemnLCRNbSipdYCJeYSh99U=;
 b=QyeOgkGWAGCcY74v56GpT1giJbarLV8ARYYAfra3ENVJmn7iFq+uSp/7QBsBV2Gyogqi9gMmafM7CctgkYZcqlqfaL7aXfxd1VZZoY3EXoe4i7FiEXgqr8ZGYGWxtuG1XkNaNdlUMf18xk21OyZ2H3suucb/wOJk5D2aNhb62RDBSjsFcZUXu3PvFk45cW0U3GLXZBXYAX+7B9b+nm9nLcHQHw9Rg22pIVlZGr5wTS3ybmfHTUhbrcvMo5qneMws4J8/8hTj7gaYam1szb2QW+uM3sdrEoaK1rI4mTffJEfUWHRRuPUrPFXNVELC7yLRgaAsLFIeTtA3k3AoFjPleg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCOj0GCQFs1HLzYjM3JCfemnLCRNbSipdYCJeYSh99U=;
 b=DGUaqclCCAxMuC+61Q+5qK6vHCaMsQmtbwtgIhTEWqFq6BLRWycDs76EP03E/llyLcHY76tGFVMg+SPjosSXhgMcQISZHNovaxSlLqHKb3hNiBGC7/ncQ+vo5EvzrOlr5NLdfn3gjQx/vCyIZPrBngiVORItrYWDbcFuFr+6u8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DM4PR12MB6496.namprd12.prod.outlook.com (2603:10b6:8:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 17:50:59 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 17:50:58 +0000
Message-ID: <96221e03-adfd-cc59-ce45-7933220999a7@amd.com>
Date: Fri, 7 Mar 2025 11:50:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] virt: sev-guest: Move SNP Guest Request data pages
 handling under snp_cmd_mutex
To: Alexey Kardashevskiy <aik@amd.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Ard Biesheuvel <ardb@kernel.org>,
 Pavan Kumar Paluri <papaluri@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Kevin Loughlin <kevinloughlin@google.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Brijesh Singh <brijesh.singh@amd.com>, Liam Merwick
 <liam.merwick@oracle.com>, stable@vger.kernel.org
References: <20250307013700.437505-1-aik@amd.com>
 <20250307013700.437505-3-aik@amd.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250307013700.437505-3-aik@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0025.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::35) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DM4PR12MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: 5449050c-4491-454e-7d27-08dd5da09def
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFVMMElCcGp2SGdwMU1ZRGQvWDF6eksxWG1ZMHZuY1dNaGhHK0JIZ241akZ3?=
 =?utf-8?B?WlhuUXNmc2c2bU9ZU3VoZTBRSVh5THFhK3h4UlVTVEVBY2pVYUtkMks1MUFu?=
 =?utf-8?B?VW5xZHJDdWkvekE4NzB2Q1hRblVUN3FRM01kZW1ZR2RqU3lkRmZ3RmljYTVN?=
 =?utf-8?B?Q0pnMCtDSk9tblBuTkFtZUQzdEUzTElUVnhtRU5SaUsxQm0yczMxYzJNWmRy?=
 =?utf-8?B?bHB4MHRERXNwMUtnUUwzaFZ1K2lJZ0RhdkVFN2d4cm1NNlRQUDF2L3pjbDJt?=
 =?utf-8?B?WTlyb3E4UWkwTzBmRmRoNFVFYjd4SmlhMVZnTmxmQXF5MjU1by9DZHR5MkFW?=
 =?utf-8?B?TVN2ZWJzcHllMmRRUk5ETzl3Z0NVUjU2WlFpWGxMaXZ5MlpSOTk5bjM2ZmZt?=
 =?utf-8?B?cWpFRkoxZUsxcUNlOWlnYWFjelZzNjR1WGpCcG1GT0p6Smp2Zkhjb25obzRy?=
 =?utf-8?B?VDgxL0VxUDErMHZJQnpWcitzbnRwdFBocDQwRy9ORXNUakdRS0NVWjVIZ3Vr?=
 =?utf-8?B?czVtdytCcHV3bXVjVmVwNmtYZlg4bEF6YnpyMkRoREhtVmh3dVh5cDVhWFZp?=
 =?utf-8?B?Z3liRHlPTDhHaHhtZ0svdXc1alQ1NVhhQWd1aGpPQS9qSG01ZzhBQkJBU3dC?=
 =?utf-8?B?cE1Zd0t1Q1FVdk9WdVlpQ0w4bXlXbDQ0NkJLYWxqeHQ4NnRFMUJINW1Ubkhq?=
 =?utf-8?B?SzJpT09kc2lNd0F6WDZDVE1NSDBHSitDZnRmald2clR0UXhEQ3JZTWFxdDhi?=
 =?utf-8?B?SGtRZWVhdWNreDZ6YWFzWW1vR0FlVUxCYUdldm16ZkE2WnJCRWYxUVhaWEoz?=
 =?utf-8?B?anVaQUVYaU9wMWk5c3dCekVTdXBFeUJJRHQ2bWxvbmM2T0M3SG5KNkZRYmhQ?=
 =?utf-8?B?R0E5VDJXbmw1UUlaOEM0c0ZNVFJUaUNNUW9hZWVUWC9ndG5SampCS3E0QTJI?=
 =?utf-8?B?UXBYRzdjZU5yZTVhL3VDc2R6cmZMVzNqbjBYaktycEF4Z2djVGxsL0pqVWFQ?=
 =?utf-8?B?cnMydUFJeDA3NXJBZG9YMTd1YUZZQUEzaVBwaVZnSThDNjF2QU1iVnkxUFd6?=
 =?utf-8?B?YkxHWkNBWVJVN2VaRnJ1ZWs2MzNBcmNXZ1NUWGo4eDZOYW1GMEUvNk45cW5L?=
 =?utf-8?B?dW0yV0ZFNU5xSHpDS0pGV3NEWFEwcWxxd1d6bWpoZWQxRDBncWJ0RVJlU2NN?=
 =?utf-8?B?SDBkTlFQZVBwcFROQVlUZWdIUUJWNUdMUmpGM1dyemw5QzJtSTk5enZicm9C?=
 =?utf-8?B?WnVscGMwZmJKUlAxZVNVTHBRVmJLR0VqQzc0S0d3UFMzRm5NM0lSOFhpUXpF?=
 =?utf-8?B?UnZOc1l1VnRFZllGL1lCclFFUzg5eGcwK3haRUtMRjc2a29PWXJkOUMwRll2?=
 =?utf-8?B?WmlqTTZNQ3VodTR3UENOK1doR3ZBNWQzY3ZsS041QkdTbVR2TVNrYnNsTWhX?=
 =?utf-8?B?NHdkNGdPdmRicit3L09ZZUZjUU9VNXBoZG95ZVN6WER4UnFwU1YrZnBZZ0hF?=
 =?utf-8?B?aUJMVy9GVzlVV3NueFdsdDZWU25qTENmUHY4dlIrbjdvNU9Da0tLeDR0Nm5l?=
 =?utf-8?B?SU9tdWIyVWVwMDBLL0hrWGlPN3d6dXYwTFd2TWNQeW53bDd6REZUVi9jVy8r?=
 =?utf-8?B?V3NMY2pXZVAxOVREY0VTMVF2ZTZadTYreUtJRDJEYnVKYllIRG9CODRBRWds?=
 =?utf-8?B?YW83NGlGWWNnUlYweFIxbnNleFU5Rng2NG8zQ24xQmlsY1lDSTNxSkJSWlJB?=
 =?utf-8?B?Y1VLS3FBYXB3ZjhMOFZUdUxxS0NseEJJMWRaTFFYckdVd0ZSbi9VQVpjZmlR?=
 =?utf-8?B?N2lDenBIT3JLWjRmOVZ3UlJUeXZnMnBuc0JWM05wZ0VKVTZwbkJkMHBsNkJi?=
 =?utf-8?Q?+SWeQvkE7ud9v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEI1dUQvOFcyN3ArakdzZGp5SU83NWo4QUM4aW54NjlweGJIYjBxY3o0Q3Jq?=
 =?utf-8?B?a0hmMlloVUpRcHNEa0thZzIwMkhPVFNRb1JrYm5oMHcvVnkwZm1Jb1RNa2hN?=
 =?utf-8?B?L0VkMTBnSkEyeXl3cUpmUjRib0o5TXFTeHBPdWh3VUFwVjYzQXpZZWhxMUVv?=
 =?utf-8?B?dHUrMnpNUGhpaWFCSWxkcTBaMWE0bUE5bzEyMUY4V0JZQWoveEFtdExhYm56?=
 =?utf-8?B?VlpNaHBGd1RHcHFEVnhHeU5UTnM0Z3RQUHNXcWF5NkNhSElTejkyQktRM0Rr?=
 =?utf-8?B?OXdDWC96a2thd2VDY2ZKajYrbzA0OVpyU2d3amhwSVFHTjY4M0RpNjd3M0Fw?=
 =?utf-8?B?VE5VT3Nodldkc01IclJNT0JLQWNXWHFVcVlEaXU1SkdZS0RDQmF0WlkzaTBQ?=
 =?utf-8?B?dkdSK3FEU2cySDlmZDU1eXYzQmtYaG5lLytRUGdzL3poRXJ2Z3ZZUmhtNi83?=
 =?utf-8?B?aTlzTzdSbXVCZ3haSG5JN1BEUFpCTXY1blk3eGwzT3NrOEtNMG9ndVFGNS90?=
 =?utf-8?B?WjhVVC9DQWwra2IzNHRIYjNoNGI4WGo3alljUjJSRG10OUJYQnZsMDdVc2U2?=
 =?utf-8?B?eW5JUEg2bzZjUmczWnZIMk5xYVdnL0VzWjl5bUJUSngrVTNlZFpuTVR0U1RJ?=
 =?utf-8?B?NVl4S3N0R05zRW1IUFRWODdMT0hMaGR0RGsycmJULzMrRUsrU2F1cEI1MGtP?=
 =?utf-8?B?S3BFdWFIRDlUQm1UUDdTS0RWQ1ZwYjVMOHRHL1htQXJKYmpBeDBpM3FLYTBX?=
 =?utf-8?B?RUJLa0tpUU45Ny80clNqd0QvRnZXdVNIbVBNMGV0LzQ1MHp5MjExTzdoall0?=
 =?utf-8?B?dzNCcm1YVkQzdWJ4MUQ0UmcvU01hN3d2ZGhzbU0vNzd0Zy95d3lmZGlPekJz?=
 =?utf-8?B?eDczWUZ5MkM3THk4UVc5TlRlR2thQW5EYnRxQnA0S2E2d0FqOEFNeHVRTHhZ?=
 =?utf-8?B?dCttVDNvVG9tclZOcUlsaytiOFRlbklFMzJ0Z0tGYWNENXNUNTJuU2FtU01x?=
 =?utf-8?B?dmx1czdidUhYU3plTGRkMXAvN0l2N05xS1RXcDlyQWF0cWQxbW90WU44djAy?=
 =?utf-8?B?dlVLU2VIREYwaWI0Q0gvV2ZvbFFJRkVEWEZaVHJ0M2RlZVo3cjJEYWtWQUls?=
 =?utf-8?B?OVdnTWl3Nm1rQkZlejhGTnFIc2FXMG13MzVZZVFzSm1rak1tQ1J0Nkh3Q2xj?=
 =?utf-8?B?OVYyRlErOHZKeHcvb3NMaEVvbTRhTUVSaTU3U1J4aURuWXgzZGZaSDlmaEVs?=
 =?utf-8?B?blg0MDljS20xcWVvWWI5ektXa3FIOFgwQXBwMmhEcmxUSjBUckJQUE9QeTlU?=
 =?utf-8?B?QWltUGJEdzJDWE5nbWhPaER2a2hFbXBWbk9Ddjg4K1Q1ZEhyUFpScTNCTEV6?=
 =?utf-8?B?WU83d2FvT2M0eGRZTXVuY0JseHJiZko4b3pTbVpRN29QSzh6b2hwZGlKMzVL?=
 =?utf-8?B?LzFkWkxOaXNRYlk0N01Lb282WlFKZnd0bS9EbzBpTzdud0FPSkk3NHV1N25u?=
 =?utf-8?B?ZEYzbmtIRDF4V244NDFSYmhNTjNaa3RkZ01meVhoaHdOYjlEbWRWWDFwK1Bi?=
 =?utf-8?B?TVhYS0FWTlg1aitob3VjUzZnRjdJcnBpcTl6bkN0ZENWcjlxeFV1UTN0R09Q?=
 =?utf-8?B?L3d4bEJDSVBQWENrWXdoMVErbzJmd3VBK0dZZ0puMFp5UXo4N0lRMTFkNHF5?=
 =?utf-8?B?YTRuOXN0aWdIMytRZ01LWk9qUWRyWVZKS1Q1RFFubWFadDNEeExkOCt5Tkd4?=
 =?utf-8?B?UXh5bDYrYzFzcGN5QUovbE5EUGU0eE1xdGF1bURMa2hxdWZiM0pMM2luNUhK?=
 =?utf-8?B?aEdwNGJMeDBhT2ltNEdRYXcrRlR1UlRPeVN4TlpKNHRjL1FmSC96RXJ6Rnlm?=
 =?utf-8?B?WThQUk1ma21WNDJ4SXM2Q3RPZXMyODNTdzY2dDY2L2xReGdqTmp6a0VUK3hs?=
 =?utf-8?B?VEdIb0pjQ0RFUUNQRlpjVDIrZGpIVkQyU0FIRGxkSjVDeG9QemQ4Q09INUxC?=
 =?utf-8?B?Y1JkbnFTS0VINVpic1RIVHZYR1dvdmFoUDZTOG1uVWlJUHZpRkRBUFd4R2R4?=
 =?utf-8?B?dHlFTElIMDBQRGRzRTBxeDFTQ2xrNndxTXZTeE5EVFIzV3JHc2pvMXluQkEz?=
 =?utf-8?Q?N4bNb9VfmM+qErcGiIoiA4bAg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5449050c-4491-454e-7d27-08dd5da09def
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 17:50:58.3735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yEdok64mRGZJAznLHkISksTd42jJu25qkuDMcM8IpKfBid5XVN6yAazNLPpFDc9hBJMUP7YJDinBQPlYltcJ0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6496

On 3/6/25 19:37, Alexey Kardashevskiy wrote:
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

Not sure if it is worth using alloc_pages_exact() (and free_pages_exact())
here instead, since you only end up performing set_memory_decrypted()
against npages vs the actual number allocated. It's not an issue, just
looks a bit odd to my eye.

> +	if (!page)
> +		return -ENOMEM;
> +
> +	req.certs_data = page_address(page);
> +	ret = set_memory_decrypted((unsigned long)req.certs_data, npages);
> +	if (ret) {
> +		pr_err("failed to mark page shared, ret=%d\n", ret);
> +		__free_pages(page, get_order(report_req->certs_len));

You can't be sure at what stage the failure occurred, so you need to leak
the pages, just like below where you call set_memory_encrypted().

And similar to below, maybe do a WARN_ONCE() instead of pr_err()?

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

Can't report_req->certs_len have been updated with a new value at this
point (from the "if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN)")
check and you'll attempt to possibly free more than you allocated?

This would be covered if you stick with npages and use alloc_pages_exact()
and free_pages_exact() using npages.

Thanks,
Tom

> +	}
>  	return ret;
>  }
>  

