Return-Path: <stable+bounces-213331-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LpjBUeegmlgWwMAu9opvQ
	(envelope-from <stable+bounces-213331-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 02:17:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCAEE0626
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 02:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2064B301F493
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 01:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC19A2459C6;
	Wed,  4 Feb 2026 01:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DmaNZyl2"
X-Original-To: stable@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011036.outbound.protection.outlook.com [52.101.52.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B832459DC
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 01:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770167657; cv=fail; b=ev4aaE/7N6jjWzmjS60ro9v/AJdK560mtTf9LPwA8V9IyVnfb+2Se60unY4VPTKR1SPvxed5cRQbyV37fP2VH/1wFOQKocNd20PrjMUvBS4JsPlMwbD1JV3/Awp78gnouQcyjWh5WZzRqIC4kE7lnuTDmcZZeO0EbTxCygBUmQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770167657; c=relaxed/simple;
	bh=cmVUIJ+Ote+0H3YkguUzg7frJWp3lJQNiQEhCniXkb4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R1Y1oFiv0UJUHZAl7v1/4GOVJ8n1qszrZhKwJhbJZDRjttx2cETuxQPpna+AtBpyd7cwSMhOMSoU6K2ofsCN4jy1RRoF2Lsj9lXb2mekHj7Jq+kYupplP5Evjib02JHeRxzcLHTD4H0gx99zx6IeUsV4S+zFBQmi1beN6FaKS0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DmaNZyl2; arc=fail smtp.client-ip=52.101.52.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCe4IADIqwyyAfLvRyWa5qjOGOuJ6M4JCwZh9mcJyxjrXwJa1cP6plI0of71YffWDiADREAkn5fPKjizdQHpHnBK1dPahb58SnG6csYw0j6xaN1kZB+8n3tKCjrijtKu6LkhEiwO67Ftw6OaoZVY2J66kXwTGzvSntOjNyKBLGvQcJ2I62Aqb9jmM2NM+O/NsqvtsgOViLQDQEWg3oX5Sa1vzoVYBEwTuIf0mkf6eDl1yv2/srgOw7PMqHWYHa7x+fzE6V3Eq4ACq3hAdCRTDY3aNxB5HpBpPpPF1uiq+uXms2Ls0wi6OEjc7ZexYixmp6BI8vLR+5o4vPdLJ0n9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irDjtoDfKOfBMgOBOQ9VwUZzle2oIvWGzAN4OuATBds=;
 b=SqP+uLk5jHgw63R42j18xKn4EnEFEhfImKC2Xkzm6LBIDEbUtoxqTLsxI6Y3OClgh9tlSQdd9wQIz3v5FgQND7CUu0IGk2j9iCKsktlzJtQ0V2GvHRlUx1/E3WFPdAYfCPeUj5wBCcCvoLEJTveByFsJt3wfJmDtXwZpKl7f4o8g3Ml7cKT7b10rffPpYu5D7/UpTiyr4OkWZFX2GJ8UhNtzU1PtWBk/DxzTApmYi0PIyfD+eMBbNhQAYP9B86Pf47qVmjLJBD11F5GkL6HR32cL0G3VCG8asWX9zpD9PAlDBfXz0qngTRWmGEFs3L9DLk4VzWmxrxff4PNJ2U9s3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irDjtoDfKOfBMgOBOQ9VwUZzle2oIvWGzAN4OuATBds=;
 b=DmaNZyl2BOzEE3iGQK+GK8FJzBxGbsJFUNXS/XlS8DJRWICclC4Mg09YZOppo0OGha7jGtK5c0a6fogiK/WtDO6sVmrvnIBBZwD9eNsBekMVAbNTiLAGNz3z/A3O0p/CPJdsuTql2hXopshtpiaFrsJM8eIhpKjpcnaw1PYseDFiNphGSUmlyYzxP9cTGB8XUGJYsyZvc3nj3vCIx1EFxRn4lQaka1CmPFpIeq+0sHYoZLkApR7qPLcq/IFV8iMBL158tNRX+PKRQ8wRKd4LdHBzz1q6rVxZ9X6XG8cpZ9kWKadOBq/VWON5R+0fIeYBcf6U6wcfMDPjU9P8/jncoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 MN2PR12MB4221.namprd12.prod.outlook.com (2603:10b6:208:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 01:14:11 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%7]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 01:14:11 +0000
Message-ID: <49e42d3c-85c5-4aee-8323-9361a9d6e66b@nvidia.com>
Date: Tue, 3 Feb 2026 17:13:42 -0800
User-Agent: Mozilla Thunderbird
Subject: pincount vs refcount: [PATCH] mm/hmm: Fix a hmm_range_fault()
 livelock / starvation problem
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 intel-xe@lists.freedesktop.org, Ralph Campbell <rcampbell@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@mellanox.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 linux-mm@kvack.org, stable@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260130144529.79909-1-thomas.hellstrom@linux.intel.com>
 <20260130100013.fb1ce1cd5bd7a440087c7b37@linux-foundation.org>
 <57fd7f99-fa21-41eb-b484-56778ded457a@nvidia.com>
 <2d96c9318f2a5fc594dc6b4772b6ce7017a45ad9.camel@linux.intel.com>
 <aX5RQBxYB029/dkt@lstrano-desk.jf.intel.com>
 <0025ee21-2a6c-4c6e-a49a-2df525d3faa1@nvidia.com>
 <a459f147b461c6e6e806282956b7931f74a0aa93.camel@linux.intel.com>
 <a5b71dbc-9e3a-4098-8821-21a9a02ec235@nvidia.com>
 <9a9853a320a30802ff35803a574aab037aa2fd92.camel@linux.intel.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <9a9853a320a30802ff35803a574aab037aa2fd92.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0059.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::34) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|MN2PR12MB4221:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d759f0-5d40-4f8e-be50-08de638ab42d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTV4QllsVEpyWFMwTFFvNDdMajNjQm55cXA0alI4SUMzenZuVTNzbk1LN1Z5?=
 =?utf-8?B?NExPaitVOWJPcDM0WWYxelZqRnk2YTNsUk5XTTdFSHkrK2FYRk5TNUsxNkVP?=
 =?utf-8?B?UDNXbklCZW9BTEkrVHdKYUZiZGhzcTk3Z1EzbTRQcDd0cDhYOXhZT3hGN2hY?=
 =?utf-8?B?ZkpYYmpOUk5ybDExUC9XbW80ZS8waFdGVHYrM3Y2WTBxQm0xKzRYR3JaTG9O?=
 =?utf-8?B?YjV6cUg2T0s2V3VxWnhwdDdaRW05K1pvbXkvQWVWdHVEeVNRMjZYMEp0NEpn?=
 =?utf-8?B?dnVvSUw2OE5xOWtKMVYrK2dXTnd5ZWtiYnRTZ2tMMytuemhpWTF0WDNxMjlJ?=
 =?utf-8?B?aUU5ZkJXbzdVQnU2bVpDR21waWVUV2NnQWhWY1dCdEMweFBqeE02V1Q3OC82?=
 =?utf-8?B?SDNkMDYraTBsSFV4YkRjU0M1MEZqZzFaQXJHdjFwUVZ5MktSdERtaWttQ3lD?=
 =?utf-8?B?alEwZXZOVVJZVXJQa3Focy9QOXdVRkxEYlhTSXJ5UmpEeEIvSDM4bVd4dzhr?=
 =?utf-8?B?aCt5ZlZ3bXZRdEpLQ0hVT3dmSHh1NjdWaFArTWdMdWUzY2ZCcFBvb2ZOMGJu?=
 =?utf-8?B?S0g1MzU1K1J6akpaZzNGQTBiSHFxQW9nZkN1ZFlPU1NMc2I5WXYycEt1MmVw?=
 =?utf-8?B?UTE2TVU5dG5WZkNGNjY1RkprWlpIejkrZDdicFVmdDc0Q1FjM3BBbkE5M3Vm?=
 =?utf-8?B?bnFlZEdBdUlua3BPckFzd3dJWUZFVEtFWlJBc3M1bXZ6ZFJ0T3hmbWkveVp2?=
 =?utf-8?B?U2hXUXpHUTFUTmlpUDcyWW80SjloQVBRclArMUp3UE1uNmVzSXNmTFNiVHp2?=
 =?utf-8?B?SVVzME9KQXpXZnlBbXh5Y0g0RnRtZXc4Ui90dlhDRFg2ak5LZkVFZGZ0STlw?=
 =?utf-8?B?cjJxREM3SXhGMWNUYjlBUlcwNDFmdWRuUUtYcFZOQjVuSFdYQmQvQTZ0cGNO?=
 =?utf-8?B?VWQ5VEpVMnp4MmtLOFg4N3ZSRVp2U1puc2haNW5JSVRvWW1KSzBmN0xHeUJ2?=
 =?utf-8?B?ejRoWStvMVZIbVV2azhyWUxpaGJKaEFOQXRxSk9NSTQ0MVlHcHQxRVp6TmZZ?=
 =?utf-8?B?V3BkSTV5aDVsTmJvSldrdHh5M2pIbXdpelY1aVcrSkNBbkJCQlJObGltQjVG?=
 =?utf-8?B?Tmh5ZkQ2Q240bzhjSFVtYlREUTh1QWpDenVRZm9IMXRNWlVPVFlseXZDdnpw?=
 =?utf-8?B?d1VtUlVVR0NxMEdFbGRhY2k2eWh5YWlVVkgrL1laYXkzYUEvOHV1cHBwRHE5?=
 =?utf-8?B?OTltMVYxcFRZeS8rL1hiekpjejlSVWdMcjJBL0k0TWIrdlQ1ZjJQTU81c3kx?=
 =?utf-8?B?emJReWNCUG9DUE5CY2dma2ZOSjNMbEZ6d0I3c2FBLzZxaE1HOEpyZ3IvcCtr?=
 =?utf-8?B?VStZUnUzcGZXdHdFeDFVSDlwbW1rTE1DcTZ6eHg4ZmErRzZCY1FtNituNnlD?=
 =?utf-8?B?WDZqK09naGd5NmpJbkxjOXV1MzZ5OUl0ZGpTQ3I2aFFVdUpIeVR2aStJaEZZ?=
 =?utf-8?B?VUxuY2d2d0Rmak9FbnRVaXppSlBWaVJyYnVGdStuUERaU3dhVXBnS0lEQ1VZ?=
 =?utf-8?B?QzU3TXV3RHByNkJwMDBqQi9BS0RwOVlQai9uZkRNZ3VFMmNKUXVVRkp3aGJP?=
 =?utf-8?B?ZzZCMzh5UjdaSFlPeGRTajgvU09HemVxYldlTkJnTHFWa2kybk43djNOUmVF?=
 =?utf-8?B?UVRUeFJ3MUxlWXF0a1prTFhOd25VcUh4Ynp4VTR0Um5CV0xRczBRSWNjMDhh?=
 =?utf-8?B?cnlCd1lmMU9OelRYQi9VaW9TekJiWkVDRGtWbjVUOGZ0SGdCMjdYbEY2MWcx?=
 =?utf-8?B?Y0xZS1VUNDFhd1FXZEVkZ3BHUzlQMzNzbzdjM2xJODdzWmFScmZmSVQxa3Z5?=
 =?utf-8?B?OHZwTEx0RnJueHNPWVdINEhsMkJwWW1YUXMwL256SVdnTng4bEExenVBOHpa?=
 =?utf-8?B?SDdqMnhvcHlXQU5RdGJTVzVTTTVMSVRFS0U4RjdkTHFqNlBkc0FOS25GSit2?=
 =?utf-8?B?MG44aDlBb0JjNjUzTjJ0WTFhcVBNVmZNRGJqUi8vTnM5b0JpL0RCZzBuUVl3?=
 =?utf-8?B?amxLcHA3VThjank2UVh6ZUJVRGc2MU5keFdiaDlPN25BaGpRcVYvYjM3ZDZJ?=
 =?utf-8?Q?V8lE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vzg1MGRCd1d0VGJxRDIrRUF0VEJxNmg1SDVrV0ZmT1ZwREtWYThGMGdjRzRB?=
 =?utf-8?B?Y2ZDVkJMM3pCTVZHTDEyaXp3YlV6bms4N3pMNXFOSzFFUEE3ajdWaGxFUFV3?=
 =?utf-8?B?c1Q5VDdDbWlhL3pYTDNiWStIdVhObTU5WEdNL0FPYnpyalNlRnFBMTRHcUhJ?=
 =?utf-8?B?Y3c5Tk9iR2dKVGlhb1JzRmJrbGdSMi9NSWJJaDZZVXRPUTRUbDdqaXFUL1lZ?=
 =?utf-8?B?cWZTNnMxLzZ1M1BGMHpWMys5b0Y2WFIySlZqS09wTWY4TnFsdm9GMnZ1ZENB?=
 =?utf-8?B?MjEzOWM2RGFLZmpUcUZncWY3U3J1dTFBQm9mQmhxUG5DZVQ0M1dzdVFXSGEw?=
 =?utf-8?B?M2VNRWRNajJvMllIZS9Ld0xZZXRPb1lPSmF2NW1BVGRRbXVXRzNGbUlmWThU?=
 =?utf-8?B?LzNnVjVBT3dJWnpHYWFjT2Z6dW1KY2t3ckRPT1VtbzZ0UlF6L0xVL1lQclBm?=
 =?utf-8?B?Q0NWK2FxZlV3blZaR0JDRzNRVEQrd3R6VkhIMThFQ3kxbzd0eTdGT1J2Vmlq?=
 =?utf-8?B?aUtLNDZPbFp2S3IyS2NSengrNFR4RU9mVHlSZXIvRmpRMEFCVkFISlV5UVlE?=
 =?utf-8?B?U1NJV0J4UjVPL0oxeE5hYzFUamszV1JQKzUrS1A0SmNjMzdXMnkxdDM1SlJu?=
 =?utf-8?B?S2N5ZWNSRmIrRTdadmR4UzBiVm5PZnBZUU1laExXRUI3d0ZaOEUzM3BaNnhX?=
 =?utf-8?B?RGh1Z0Qvb3FtbDgrUUhnc0lveE53Q3VYdHdLc3VDRVBaa21BSkFzUVVqcldH?=
 =?utf-8?B?V1VCUG1lSUlVVWIvOEszTktrVTBRclBpcEM5cmNzelFwVDFOM25ld3lrUStU?=
 =?utf-8?B?R1oyOTRQcER5WmtNbWJQeVp3bzJWNVFKOERMQUNGY0N6V3kyTUpxVjZWbXNn?=
 =?utf-8?B?UW41blVzSDY4bEdPdG8rVkVPVjVjYlpCRHIvbXlFSlZkWndWVlZZUU5xNkhM?=
 =?utf-8?B?dU1BRmpIZlNnREg4ME50SHdkQ3crZ2J6NmQwYkxWWGFhY2REaXdWTFJpa29I?=
 =?utf-8?B?YmVyWWUzUC9Za2M4dFpnWW9PaTMyOUl2RVV4ZDZPSWdQRG1mTzd0RTZUZ25q?=
 =?utf-8?B?aU1ua1g2MzRRdVRKNjl0Q0VqdGZLelZZU25CbGxJaENxaGdESDBuTnRxL0Ja?=
 =?utf-8?B?dHJ3dGNBMTQwNEdQU2szWTJlNXJrRkVTcWhsVFo5WlFwTlh5dVJZOTN2SEJJ?=
 =?utf-8?B?eXJybjhyS1BXOENnUzNVSWdDOGtFVzR0THRNK2dOQ2hieGUyWWRqSUs4cmZN?=
 =?utf-8?B?c2xKWFowb0gxOGNxK3ZvZE45Rll2ZW1sMjg3cmZvQlNtU0N2aUQ2Zk9INWph?=
 =?utf-8?B?VW1VVzlDSkZaZndwZXZmaXZGdmZvWmFBbXBKWXFaY2VneTk1UUNiQjZDSUJp?=
 =?utf-8?B?aFlUNW1WVzZyclBCaE1tZjZyS2tvbDl0bEZrWEFEWkEvYkpvZ2IwTThwa3hP?=
 =?utf-8?B?a0ZES2xWTlo4bXBUWkdWenNHMUxwYU1xOTlaYzhPWWw5WU1hQXp5RVU3VG9E?=
 =?utf-8?B?QzhIaGxRdEVhd3Z4azQxNUhlSGV5N1hoZHlJV1VFV09veHZVcmZ6UEhWM244?=
 =?utf-8?B?SXpGNFpONCtSaEt1aS9aaDR6YU9YVVlUOTlqS2hnVlJOeUxiT0Z6U01QS3N0?=
 =?utf-8?B?WGxIUFBRMzkxdzM3S1BKZ2lPVEp3NHhUcUUycytzeENQZEVJRkEzMHhTWWlF?=
 =?utf-8?B?NGw2NHIxV28wdnJMaWwrayt2ekdXbEs1U1czQ3pjcVQvZFhoMmlJV3JBdmY0?=
 =?utf-8?B?NjhyN1U3dVphVWdMV3pKVnEzb3hlcWVPT3ZZYU9QWEFvMzhQb2Fvd2RtRHlV?=
 =?utf-8?B?Z1NOdVk1Skc0aTFJV3hUTVZLbFZiQ2Z2TnZRRkZvZ2Zid1RWNkRMelR6eU9I?=
 =?utf-8?B?eEgvRkVvc3d0bU15NlMzdGFBSUNxR01sMEhJRkZENmE2d2dPYm40dC9CYUd1?=
 =?utf-8?B?QnMrYWdDOTB2VnFMVzVaVURZcTdxUTlCUTVrSFlaSWJXRktycUZjREJRZUo1?=
 =?utf-8?B?ZjY3ZE5HK2ZsL2ZCZDNNLzNTNWtKelpMUmFGd2twNWU2K0RsZmN2cTBBZ0Iy?=
 =?utf-8?B?eXpQZ0lLb0VHbCs5eWF2U2JwbGVZZ3pGU1FkVGM1RUVGeVU3d1N6amw2allz?=
 =?utf-8?B?NlVvK21MYXM0T2xGNm5meGx0bDVHUTJhRXFQbXdBOFNMMGdqakdvU0pPK3hR?=
 =?utf-8?B?Y2Z2dHFnbzRjeGlFeUxRSDJKS3ovWkdjL1p3amVxN0N0RGkyRmFTeTltaU96?=
 =?utf-8?B?bDlJZE5BSjRGTGF4MUt1NTM5SjJIQ1d3MzJDZzZrTE9LMkdBWGVlOUNmYnFt?=
 =?utf-8?B?YXFHNkorZmd0eTNRSFhLbGk5K3N0NmxhanJZWHVMaTRWK1hYQkNnUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d759f0-5d40-4f8e-be50-08de638ab42d
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 01:14:11.4423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqFT3b4ir7ClYREQYA1yu4uNvpVZWmC1hT5IM23a5TQQs8vq7OwdKxuhLmhEgSsn+z0LBS3KyTzSVDzfuLLs0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213331-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhubbard@nvidia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: 7CCAEE0626
X-Rspamd-Action: no action

On 2/3/26 1:31 AM, Thomas Hellström wrote:
...
> So this is what I had in mind:
> 
> I think certainly this would work regardless of whether pincount is
> implemented by means of refcount with a bias or not, and AFAICT it's
> also consistent with 
> 
> https://docs.kernel.org/core-api/pin_user_pages.html
> 
> But it would not work if some part of core mm grabs a page refcount and
> *expects* that to pin a page in the sense that it should not be
> migrated. But you're suggesting that's actually the case?

Yes. The migration code itself, in fact, uses folio_get() with the
expectation that this blocks migration:

migrate_vma_collect_pmd():

	/*
	 * By getting a reference on the folio we pin it and that blocks
	 * any kind of migration. Side effect is that it "freezes" the
	 * pte.
	 *
	 * We drop this reference after isolating the folio from the lru
	 * for non device folio (device folio are not on the lru and thus
	 * can't be dropped from it).
	 */
	folio = page_folio(page);
	folio_get(folio);


I'm experiencing a bit of local-mind-boggle at decoupling refcount
from pincount, but part of that is probably just bias towards "but
it's always been that way!". haha :)


thanks,
-- 
John Hubbard


