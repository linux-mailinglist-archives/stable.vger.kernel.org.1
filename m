Return-Path: <stable+bounces-163253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E92B08BF5
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 13:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E68A473A6
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 11:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481E029B76B;
	Thu, 17 Jul 2025 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OmaYts2J"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8205029AB02;
	Thu, 17 Jul 2025 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753024; cv=fail; b=FHIEYJIJMP8jdIwNfNiabM1geBDWNB92CJnaD5rDzAjH9SmDd+Jh2pnjbSMH8s2I7gdxPAcdb64188aQFGLrchCe47SVhhngtDRDVMnnqaeb+JhO4YHatwljSEiA09l/VI4mCauWEjvpPPDOYwAkjQIWzGYtYalmNNNjf6I3ky0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753024; c=relaxed/simple;
	bh=M7J/tA88cnjxHcFqWMzK/TJtlF4A5PQLzmJqdA/c46U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=stHgwhlg7cfXfWfGQUKcSPi8FkGonLvq0Oals1qXLUAGvN9GBagvxoIgePSX7wVNAAGJfffSz6STGpmDDRnzv69kBzbbuPoaqUvH+SBIOAjpDmyCYAG4EK3c9qMrfUzl2rR9bueMjWOIjqgbsQDeRmq5rc+BUUzsL5ELznaKqVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OmaYts2J; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcsNjqnUkVHkcAgObOvZ3CYnsb12j/Xs4IQztpTiLoIdrz1zRV72RxNP0Wh+7O9KWaKP2Alnh8A04c/gpnx0STFb/zhsFa3d+55/rn8Ht/gSrdn/lbjYOlEoeC7oD8tM/2ZndCSj4VrXLZcou5oASZVxMS2G0jJACF1T49NMlDGUhIbCth7PH0JUKemQxGtwerA+55TPJtx5+UGSSM2nUDNPudbhpQIMmjwPmIlzDqrb1+VdfHxIxS9/3Unv3G+U1TBMtSK3cwrK/l4mZn24C/dq9zShK0AarEjPDXutVczRNKUgWIAsuAQ/rv6zFsYhjdqhlnt5qyoBRTfeXXD+Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9tv9jg8of23GGUolMzE3jU28jXuB9blsBSvTSLb39s=;
 b=jQqnaabD/FDfBT7fqr2TpTN0zZT/AeGo0wKpoi1laOAiPM2n3DrvynF2Fq0GzDBrcAvlJNHDZ8ic2r9OxLK1Ls1vnzJ34CILh6RB2dSKKd+XUXWyYWx/Df+Hu5wQJ8eD8fNDk/+P1GYOkOEQ1a/Y0+OQVzBYjeH4HqTEC9QtVC1enrFqb5wWycVdxj3xOqFJBLI4zcV0eiA1rR3gNP1S7W9W+jRCNgM87S7RmOXOWgyQeNGMyCAjCqorAh1fweSLUYulhXSWz35YljNFSnY+/88apKXSunlRLwuQ3xmQnxMvR4ES1MtW9Jmvj2Vza9T5YpkvDfKEsiixNNMwB3RvbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9tv9jg8of23GGUolMzE3jU28jXuB9blsBSvTSLb39s=;
 b=OmaYts2Jyk0S3c7mcA/CbaRe04fbGcnl7k043Mfa9CSwDJ8qaJ13Utb4B/B0ARb41S8qVQxE1q8FC/gWJ0AS2VP+ogXOhjlLxby2oyTEqHmZVX9FNyqcdFz2nbjpNkBsRukmxW2y68oZ0CaFdzmeA6ZeVXkG43M49NJZCYIgMq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ0PR12MB6711.namprd12.prod.outlook.com (2603:10b6:a03:44d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 11:50:17 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 11:50:16 +0000
Message-ID: <2cd924f0-ad19-4b29-b637-c1ff2dd68cbc@amd.com>
Date: Thu, 17 Jul 2025 17:20:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
 Dave Hansen <dave.hansen@intel.com>, Alistair Popple <apopple@nvidia.com>,
 Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, "Tested-by : Yi Lai" <yi1.lai@intel.com>,
 iommu@lists.linux.dev, security@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
 <20250710135432.GO1613376@noisy.programming.kicks-ass.net>
 <094fdad4-297b-44e9-a81c-0fe4da07e63f@linux.intel.com>
 <20250711083252.GE1099709@noisy.programming.kicks-ass.net>
 <e049c100-2e54-4fd7-aadd-c181f9626f14@linux.intel.com>
 <20250715122504.GK2067380@nvidia.com>
 <f58a6825-e53a-4751-97cc-0891052936f1@linux.intel.com>
 <20250716120817.GY2067380@nvidia.com>
 <df5353e2-1d54-476b-90ab-e673686dcc41@linux.intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <df5353e2-1d54-476b-90ab-e673686dcc41@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26e::15) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ0PR12MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: e1c0907e-11ee-429f-318d-08ddc52818fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzNnODgzWDFBaFRNMzMzcEhYNk5YcmtDdHAwMHFSUTJhLytaVlRmUnpxaDFp?=
 =?utf-8?B?SVp3dmtiVkJ0c3VhVk9ySzQzSnZYcFpvR01kdmVydkF4VlJad1NuK0pGeDAr?=
 =?utf-8?B?RThIRVQ3L292QUVrQ0tEaXlodklCdzR1OXQ4N3BEczA0dDA1ajczL0xjV1JE?=
 =?utf-8?B?RFN0N3lpYldlZE5qZUtBaHVmbWl1c3JhdkNpc3RnYmxBOW50ckRyLy96QUFI?=
 =?utf-8?B?RlNhdXI2aCs5dTQ5aHA3T2lhT0tINDZYV2Z0STFsSW9WSWpydkt5K2hYSFho?=
 =?utf-8?B?VUlvQ2F4NUQ3bUVmRC81Y1VwU1RsekVjNXlSVnJJSWhNY084VnY4aTUrTnNB?=
 =?utf-8?B?bEJoWm4vTzQ0cmxqcXpIV3M0NWdldFVpUi9idGtiN3BCajNlNEh5TVNwT2Rz?=
 =?utf-8?B?U2NSS0JqenV1ZXZBckhkZU5QQWxtdHdHLzFXcVZ3WjErUnI1NCtpQmJ0c0hz?=
 =?utf-8?B?VGpFT2M4Q29vd0svT1M0VFlqeGRDTE9nWXZKV0I2eGhxNkUrVmlYbHY1TTJ2?=
 =?utf-8?B?QUNBM045TWk5NS9FMk03UWJLaXcwSCtaTjltRkhzY0daMEhOUkVsb08xZTJZ?=
 =?utf-8?B?YU9zVUZCSzJ4MmpQbGpuR3R1TmgvZW0yMGFtZVZkS1JJUERNMW01a0VzUzFt?=
 =?utf-8?B?ZzZiUjV3aTl5RnAvZzVLZ0Q2cnp4dmJ4Vm5HbEI3Z3laMmtJK3BSdlNuNWhq?=
 =?utf-8?B?V2VLQ2RIZmpPUVd6YkhCUjFkTXZUUjI5citTaXpOTzVWOGZ0VE9Cc2cvRzRy?=
 =?utf-8?B?WGN1WlBSSG9zdWV5TUR0OFdNVGs0MFV2aG9qTjdSWUlueit5SnErS3ZRRWx3?=
 =?utf-8?B?OHNtZHpMU1V1ZXJ6Z0NyZmNFSSt6eHFTYmxOUVhGdi9aMEhDQ2FieENsai9Z?=
 =?utf-8?B?UlZRdjdtZHRWN2pTOElCNWdQV3VoVC9BY0tJOEVPd0tpeEFWL0RqR3czb3NC?=
 =?utf-8?B?MWl3UTQwdVdhTHFubzI5aEZLMUp3VXVFNXBYYXp5eEFqbnVuWlZPbkwrRVp1?=
 =?utf-8?B?aGo1YldwWHVyNklTQTVvTHVOTGN2VnhubjYwUkZ1VmxLVjVjZmw1ZjRJZnBK?=
 =?utf-8?B?OGlZdTE4ZTVMdHpxcEJDZjRSd20vYnM1Q1hVVkYxVFhqL3pJdjZUaDE0aHdI?=
 =?utf-8?B?NDhpS2lJNHhNL2lLN0NDRnNPZnRQMnprMUZVVkJqeUxHK3lDcnBuTCttUTJU?=
 =?utf-8?B?YTVrS2ZXM2RDcitFUUVNZG5mTjh1SjR3N2dYbWhET0sxLzYvNmNraHNFVmVZ?=
 =?utf-8?B?aDhQczFXNkJvc0x0WThaZVhXWUpXdDVLcTVlVHFTbDArWDUzU0ZmaklpZ0t1?=
 =?utf-8?B?bnk1MFFPdE1tc3ZGQTAxQmt1cjd6UzFxdWd4RERhY3ZjS3hFZVNOQU1iRHlp?=
 =?utf-8?B?V3dsN2lrWEN1VkNlOXppY0x3L0paU01FTlpXckRxTDlnQ3RCVDBhVm1JVjky?=
 =?utf-8?B?QXJwK0JiMXVQVTdtQ0U2L3g2emx6cUI0ZzdOOTI3VitnM2R6eEVCalFlVG14?=
 =?utf-8?B?am11L3RtZ3ZEelNpVkhpYytXdnh3R2NzOUM0dFljMlR4ekU3elMvNm9sc0Nm?=
 =?utf-8?B?Wnl6WG5TVzBtdFMraXB2RExtbHU1VnozNHZ2UXVselQ5dkJqRGE2WXdlM3dG?=
 =?utf-8?B?N3c4QlQyeFNQVmN3R2l3MkxOaGpqeGNzaExYbzNadHQ2V0FOYjJDR3R3c21C?=
 =?utf-8?B?ZmxROFNIa2JGVC8zSU1MYlV0M0xjT2l3TldoWnNKVFdtdTA0WllPRDAvandZ?=
 =?utf-8?B?ZnlCcTAwSUdXeFVvVHk3NERVZTlXSkpxYmZ0VW8zYm5BYTk0cWhlb2xYampo?=
 =?utf-8?B?dHVQaUFOVDEyOUd6ZzhGVllQOEIrZmpVcktXMHdvcTNZQjlscHQveTRKVDJF?=
 =?utf-8?B?QThwQlN0V0xRc041SkY3bFJJTEdYekQ4MTIyd3E0QzBrZjhDbW1ka1MzdTdK?=
 =?utf-8?Q?qPWLbyffv5M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzFZYjdRZGpvM3lnem1BZHZBZERVWVV0cWFyMCthL3FCbS92RXJYTUx3emRB?=
 =?utf-8?B?TUk4ZER5cWo1K21DUy9wVnhUNkU2aUtHS2NWcUplMVp1U0R0L0lCVnVocXdY?=
 =?utf-8?B?aEtmZHU1ZWhVRVVYM2xieUJUT2NSZm92QWVYRmtxdUF4dGM1Nmd2ZXp5bnVS?=
 =?utf-8?B?Y1l4M0hnbC9Sc2gzL2lzdTJzcElReWd0RkxNaERWYlc1dE1ZYk5HK1JSSzVu?=
 =?utf-8?B?bUlKVFdkMkdEVzM4Tkp5ajJqSFVoZ2paY1Zrdzl6NmlVelpaQ2Mxc09JYklV?=
 =?utf-8?B?YWkzK3ZmK0xTYnhHdkZQUXNnNGNqQWNRU2ZjbXpMMjcwMmRmS0hERWVpRGJi?=
 =?utf-8?B?MFRXbVhwMFBubDBvYmVWQzltTk5tcUhmQkFYSmVweEdoOStHVDR6bHNEUGli?=
 =?utf-8?B?UHVGV0ZIMGRCNVpodGQ4cGxSYzVlTGJ6Nm1xV2N0ck91MFZkL0xRT052MDEr?=
 =?utf-8?B?TDdBYjBBM01WR2lORmxWbFlSK0FydDFJbzRBc1l4M0Q5ME5pNCtKRmx3cXVy?=
 =?utf-8?B?Y1hUb1dVNjcrcVN6ZjRrS3M2TXd6d1ZZQTBsU3o3UFZXYXZHL0p0V3dIeVQ1?=
 =?utf-8?B?SHQ1TmJIcjE0dVE4dVorUlhaRGNRS0htc3F5dmszQStMSGhHd0xFY3hSTVlS?=
 =?utf-8?B?b2JZbkNFNXB5a09naWxRTDB3R01xakNIMWNhUktobEhFalZ2bUx0NFJEODdn?=
 =?utf-8?B?NVVsd2JMNENtdmtYZzVGOVRFR2E0ZGhLb1d6dXY2bVJPalZUam5QNkpYV2ZH?=
 =?utf-8?B?ZGQwUVg4dSsxLzU3OU5QL1BWNCtTbGZydzZKcTZEMithVUxMMmx4T0ZpTmpB?=
 =?utf-8?B?V2p2WUVMQWMxSUh3aGgyVVBMVUNENHVHK0VyVDcyMHIwRTZ1bjNxTG1sakRD?=
 =?utf-8?B?TXdTS1BFWUZKczZMVHNtMkdLZFlkVUloR0lTWVlxR0gwcUdDNGJicVpWSnBu?=
 =?utf-8?B?akZyK3I0ZDVBYmxoeDFQTnZ2eTlwcm4wWEl4anUwOW91VWN4M3Y3Sy9EYlJ3?=
 =?utf-8?B?ckVBcTI4cjFxZXFGTXE1YTRFT25GTW9UQ0ZiZllBM0VFZ1VtWS85UTVmcU85?=
 =?utf-8?B?VjFoSDBPMkFpb0pCeDhnWGJYOFk2WklrSzFaayszMzBxTU1oQWZBNXY0emRQ?=
 =?utf-8?B?eDJyYmgwWVdHNlFxYlZtNDNzdUF0OXh3ZWdtR1dFOTJBeitrN21Xd3Ava1Ev?=
 =?utf-8?B?ZVdNd21KUUxuR2hwdTl0VFl2Smx4REkvaWVVbmVzTzByNEJZVWdXaGtDU2xM?=
 =?utf-8?B?ajBoaFBlWG9hNllVM1MzL2ZqbHJ1SmUrK0RjbTZlZFQ2Q2t5OW1MaXcyd3ov?=
 =?utf-8?B?TjBVWFFEL0lFTXNEaElWU05sWFRIRFZxQXZPMUxwSWUyTmdFMG43RndwTktW?=
 =?utf-8?B?VUVjTGFVdTJFL1dXYlR0blhBUll5RXU4c016aDhTbUFjdGM5VmRaMjVWODJq?=
 =?utf-8?B?TkphMVZrWDQySTdBMXdGRGZ5MmJOenBzYjQzOUV3NDF4M3ZBS2V3QXlqTWJX?=
 =?utf-8?B?U0dIcThjUDBoSGZVdEFxcWM4T1dTd2NxVWRtdjFESDRmYS8yS3R1QTI4cUJt?=
 =?utf-8?B?ZEZXcHBzTkNzbnlINUJOUGFKQ2IzSmxncm5ndzNVeHVrRjVzL0RJS2ZvaUE4?=
 =?utf-8?B?OUlLblZlMlN4d3V5ZWxWWUZRcU1qRFdpMWFYS2VKc3k0WTUzVHRPcENmeFdx?=
 =?utf-8?B?MTN4dURMWEEvVkk0ams1YWR2SE01VktDRExtVDFIenhIMmJ5VXVRMTNOQmZF?=
 =?utf-8?B?RjV1NEw3RTl3NnZHRHZqMEdTaDliMlBhVGhYdUFjc0h5ZHZIWEpZMlgxcFJX?=
 =?utf-8?B?ZFNWZUMreW5IOTZhTXEwZGpBSFUzcWRQMiswQUpWaXpkaU0vVUVWTWN0bG96?=
 =?utf-8?B?a25vS2dibEVwdlU0MGxpVkFnTEV0MkthQ1haLy9WcE5JYTRQSE1WRmhobnRY?=
 =?utf-8?B?KzJPUnhQUjRZaGxyRGt2WlRqT0tQRzBYRkJ5blFTT2lhWlVoalRhTFdNVEV5?=
 =?utf-8?B?RklHa2psSVdXb0xXYmt0SllkaFR6KzNleUFLTFk2ZlRLMk01a1Z0NVpYc01m?=
 =?utf-8?B?R0lveXI3aWkvU0lRK3pPc09yS2hORlk3K3d3Y2phL1pQaW9PYWI2NSt1OEpj?=
 =?utf-8?Q?8q2z4pv89cjDy0QyUyV92adFL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c0907e-11ee-429f-318d-08ddc52818fd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 11:50:16.9105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pEp3reOuz5iP5gibR3tjxUp3Wje5SoZgxYw6uVXm+lNTUqhQVloTq+a1wMDkIJtIuoB4/6ugHV9flp/8LZtQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6711

Hi Lu, Jason,


On 7/17/2025 7:13 AM, Baolu Lu wrote:
> On 7/16/25 20:08, Jason Gunthorpe wrote:
>> On Wed, Jul 16, 2025 at 02:34:04PM +0800, Baolu Lu wrote:
>>>>> @@ -654,6 +656,9 @@ struct iommu_ops {
>>>>>
>>>>>        int (*def_domain_type)(struct device *dev);
>>>>>
>>>>> +    void (*paging_cache_invalidate)(struct iommu_device *dev,
>>>>> +                    unsigned long start, unsigned long end);
>>>>
>>>> How would you even implement this in a driver?
>>>>
>>>> You either flush the whole iommu, in which case who needs a rage, or
>>>> the driver has to iterate over the PASID list, in which case it
>>>> doesn't really improve the situation.
>>>
>>> The Intel iommu driver supports flushing all SVA PASIDs with a single
>>> request in the invalidation queue.
>>
>> How? All PASID !=0 ? The HW has no notion about a SVA PASID vs no-SVA
>> else. This is just flushing almost everything.
> 
> The intel iommu driver allocates a dedicated domain id for all sva
> domains. It can flush all cache entries with that domain id tagged.

AMD IOMMU has INVALIDATE_IOMMU_ALL which flushes everything in IOMMU TLB. This
is heavy hammer. But should be OK for short term solution?

I don't think this command is supported inside the guest (I will double check).
But we don't have HW-vIOMMU support yet. So PASID inside guest is not yet supported.


-Vasant




