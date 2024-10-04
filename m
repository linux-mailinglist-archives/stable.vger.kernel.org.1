Return-Path: <stable+bounces-81130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDB19910DD
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 22:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DB46B22021
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD1E139579;
	Fri,  4 Oct 2024 20:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b31CHBv7"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B1F231CAE
	for <stable@vger.kernel.org>; Fri,  4 Oct 2024 20:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728074973; cv=fail; b=RJWHPYTLKU20jRvSR9n08vvrjNSnLkRnWtsqSgyrX9yBAs3UW1Oaxh6zFb3/f1btUZ9GvdcpbpyfXPMLwddkiJGKDRixF77FZuTNHhKiRvL0nspUKxP8W7PNqFm3vtQM2cG4ixZGMxB7i+ujYtfFxqzxQqLl3Wh4QsR4l9cdmpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728074973; c=relaxed/simple;
	bh=SWSGb9NLylMnzyQCEqG6nWuK1N5bvgf9IhNr9Fn1tas=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=apvs2w3+upYcGwiVXFt3QsZgws91AxopUKLD4EvVxQn5E7LRUcIWjv9cI0eSKqG8q73J5XbUOM+S02pBcSgJt43gDXNpi3fUi4hBkgJthed6EQMmXRR4IgEAzKeAvXb7Qw9bWLwcK5uNhhxYfUR3GFmD6HqYkLkN8bIhbIgX1MA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b31CHBv7; arc=fail smtp.client-ip=40.107.96.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySW8kbAnLNNRByGqHGTkYnQZMC33kS21HwvKAo17Liqww0TNf1ZwiEhaSZBzP2mKBO/tw0rRyXMDnteGVlbDNmSgM1+sKVTK7g98jBh1yXacfjHbOHJcta711XKuPnn1zAwydJbzBcYkXar7SPyn/WaYcbc3WBVVaEaZZPgPtBhw3RuurffkUEi8vlvkZiukAx5JiwFsLi40FDogGeZgsHeJd7lhXdMhww0CwIS5REdWxOzrwsx05O2QjlZ8AdpuLYsvQbjdz7fGirTC3Pocv0A4BXrHcmaFvPwxBYAPDWmm4AMpyAfxjsSZ0KAPBf2IPP85Jqpultmdqzgh2pNbfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oe85jlksfwzEZEkgeAK5GnY3xguBe/VcxuTkqIvnQFc=;
 b=Q21ZKEOiMyC6ZY+v2fY+dw7c5NnTEy4PQHl6ig1GBJzC1dha7DPR7XjSbIZRHOSMKB/pfqT2XNd9opdfg60tqOvrEodEfmIJ+aSI+Xx/Gk7pokJPui2Wcagkl4Qq3es5C5VbS0DgId+yIIPhcF33mcwCzkMUPfUBevE0PjElOc25G4ftfFJdGSrmVVuYv/eCXWU07fVwpby5JfqK8NITw9bNa8j6SVvS4zwVkS/wN4Bh7/qmvo2YAEEW350GSXY9UVbx5XKszOgSYxVRC6RX4L/efWjqL/ekw47zem762j2sRxNHFE7fNPus3AUiKdp6eRgkqn2WDNt/m+RW+qX6ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oe85jlksfwzEZEkgeAK5GnY3xguBe/VcxuTkqIvnQFc=;
 b=b31CHBv7pKIsEm+VaR1BJ6EJaDwLGuMj/v0qtOX+hCLb0fkEQVHuRAfPKTxWq6LQ0wBfZLmtLioQ2O/d8IpEw7W89FhLUfzdyuTK6Ai7fTX1p7pya+Jzmlw7YKw37cOF8GUENMBG4xkMJvF3dpYTKcIf/SP0VLioyM9LdfppTJM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21)
 by SJ2PR12MB8845.namprd12.prod.outlook.com (2603:10b6:a03:538::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 20:49:29 +0000
Received: from SN7PR12MB6839.namprd12.prod.outlook.com
 ([fe80::eaf3:6d41:3ac0:b5f4]) by SN7PR12MB6839.namprd12.prod.outlook.com
 ([fe80::eaf3:6d41:3ac0:b5f4%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 20:49:29 +0000
Message-ID: <7efda303-f813-4da8-988c-110a90f49964@amd.com>
Date: Fri, 4 Oct 2024 16:49:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: fix hibernate entry for DCN35+
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>,
 Roman Li <roman.li@amd.com>, stable@vger.kernel.org
References: <20241004203350.201294-1-hamza.mahfooz@amd.com>
 <CADnq5_M5ripf041=G2u+vkf-WS0_dFtLqtqwS16fOQTB3O6cBg@mail.gmail.com>
Content-Language: en-US
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <CADnq5_M5ripf041=G2u+vkf-WS0_dFtLqtqwS16fOQTB3O6cBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0215.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::24) To SN7PR12MB6839.namprd12.prod.outlook.com
 (2603:10b6:806:265::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6839:EE_|SJ2PR12MB8845:EE_
X-MS-Office365-Filtering-Correlation-Id: 53f1f346-a58b-4281-2853-08dce4b60a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODMxTldvRVlpMEpmOXZZS0FrMGF1dkRZbHJ6Y1A0VWtiVDhXa29sTXJoK1Zr?=
 =?utf-8?B?UUxUWEdRb1ZqV3p2YVN6cFJ0OEJYNGhPK0FqUGV3VGZHZ1N6T0JRVHg3anMz?=
 =?utf-8?B?cS94UGxWZDhVVERNZ0JaKzAyY2J4U3hDa2JyS3FtQzdHc3FTODNTamYySkVJ?=
 =?utf-8?B?aTdDREZLeHpxbTlpODBKbnFZcGh6TU1XM3BmZ09ad1B4K1htYSsza2hlM2pv?=
 =?utf-8?B?UHdpRjB3UW5kWER5ckxQSHZKMWd0cktIbTR5WHdYNEdBS2NqS0dEZmlXeWUz?=
 =?utf-8?B?clB0ZDc4UUoyK2U1V2xCaGEvTmNvTkJGOVh2aUZxV0tsV0pLdmhMWnhZeDVt?=
 =?utf-8?B?cUxuV3VQdWk1YW9XU0FEak9keUtQci82N3EwZEFNamEzQ2RSV3piYnVqbERF?=
 =?utf-8?B?R3FGVDBsUWpRYzU2b2F5MmV5R1R3Y1N5U3gxV3NSb2V3SEJZUjN2QkpmZXJP?=
 =?utf-8?B?YWVpWWdJeWtJNThoQzllbHoyTXhxZGxqek1aL3ZFeXo4VndXcllzUHNyT3VS?=
 =?utf-8?B?OGc5amMzVkc2Z2l6UWo5YmdaVVlKa3BvekJIblZtU2VIQWpCU05pN2NQcURw?=
 =?utf-8?B?Nm9DQy9qM1cvVzc4Z2FFQlBzS0FPMUEvd2NCS2JIOWNJekQ2ZWs0OHEycDdE?=
 =?utf-8?B?bkRDQnV6dERDVEJzU2FSQzh0OU52c0UrRWRVS2dJalQxTjZPUGphT3lhQWFx?=
 =?utf-8?B?UjhlMU12NE5BS1hBZHlJMzd3cGliRnVrMUl3b1hVM0JVSXJTc3VHSEwyTm1M?=
 =?utf-8?B?c0xCZ3hXVlFKY1VNa1R6MXJib2ZBZEJIN05iN3RuOTlob2NIdDZtQUh6am1P?=
 =?utf-8?B?RWsxUks3aXRHZGtwWnFxNWd3UEx0c2dGcW02ZnNWVlhTRElWYVErRkZTVFBU?=
 =?utf-8?B?clU1UURsS2tYWS9jWWRhdUh1c0xSTEVJUEpHRFhxRUNPbVdwQ1NKMzhvL1lR?=
 =?utf-8?B?OWczVjRMM3JISjlTbDNtS2ZrQUl4LzdOazRIRCtoYTE4UG52Z3BmTENuVkZr?=
 =?utf-8?B?dEZKQTRRN0luR2lxQzVlTU82SS9DWkZLWDFhUVkyTjJ0cnlPWlVhMnhBUFhr?=
 =?utf-8?B?MUZheHozWXh5c2wvbGNhWmRGWnBnMjJUUmhSQWJJNkJodGxVOFVoZG5sYXVi?=
 =?utf-8?B?VUkwalpxa3dYMnFCKzNkZGVMNy9icEVWTlhuS1JreU45S2JlYm1MMTAzY21Q?=
 =?utf-8?B?NnFuR3YxZ0lScTJQdDl2RWxyUnZ5RzdBa3FQamkrRTAvT3NSVUpMSVgxM1Jr?=
 =?utf-8?B?QlIvekpJY2wzL04xVGpOVUZISGpsZ2JRZUhLOS9iMm9VMGNOTHg0bEFxM01Q?=
 =?utf-8?B?aU5UWFl0Z2JpSnVYZHBjS0FKRkdLMERTZFAxemJkY1RWRlM4ejBuUDZyUGZr?=
 =?utf-8?B?MmxWVU1EcmlWb2JFU0dydm01RjQ0OFBpQmg3R1RQc2E1bTRPOGZ3SmFRQUtm?=
 =?utf-8?B?cXl5KzdnK0lEQ1lLc3FDWVNXNDNzRUdNK21RYkFRY1dtc2lkSHUwNlpGT2VV?=
 =?utf-8?B?S2pPWHB4SUtjWWpFLzkxNjhicXB5VTdHRUVXalNkNUVBb1hVNUtDTUtuaC96?=
 =?utf-8?B?VkdDaFlLcXFtdG9jV2tKeFI5K2J0dC9ibitSTkd6bVJwZEc0NGcyVTgvRnNt?=
 =?utf-8?B?NVU1bmlrTzBBYVRibjdaK3QrOGZuOWpKRXhoSzBsdHE4K0kvUFNhdk1DTjRu?=
 =?utf-8?B?d0c1VzIrWmJVRWZNaVRjVEdBVi9EeFhBMWEwQmhMNUFBNm5sT2IrNlVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6839.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THdBTitkQ1JMSC9maGMyNUFkMmgrWWVyUVRNU2taVUlSdm9RdmlDRXdscTZv?=
 =?utf-8?B?UVVQeDVvcjVhSU15eWF5UU8zV0J2TEQ0TlVDaDBoWXViZFMyVlBkVFlxanpn?=
 =?utf-8?B?cVBWbEFqY1lCM3cwdHFwQ1VBdzlONVVMcUtESDZsUW1xS0JZZlhzSnVWaXZ3?=
 =?utf-8?B?cGhuZXFlakZIOWFaVVBCTytnT2V3bnF6S1VwUVpyWnZnT0owdnVpU1NkRkxB?=
 =?utf-8?B?Qjd4NVF0QXlvRGYwa1diSEU1bzdFRFVheDlXcUtGRHl5Qk9sYU56TXR4YXVu?=
 =?utf-8?B?aHNKWXBJamI5N1N4VmlxME9Ub2FKN042Y2pPUVRMdUJ3eC96czY5WjlOZ05w?=
 =?utf-8?B?L3RhZll0NkM4bkYzZW81UTdyTEt3WlBJaXVFU0swT1I5clBmbzZPMUFUbWQ0?=
 =?utf-8?B?elduSXRiZFRrU1IzWUNrcExEVkdYY01peXZad3JHcHlGamhRRkw4L2pYN3pJ?=
 =?utf-8?B?dURQRXl2eG5mc1Zad1JBMGVqRXAyYUV4Uk5CSG1yNUdhZmFLd2c3ejBhdkpY?=
 =?utf-8?B?Q3JMcnpYdzdId0VCQ2MraTk4UldmdnNZalZiaDNjalcrdTZaSmtZeWxLM2k3?=
 =?utf-8?B?QjVNK2ZUbHNYK2s0RHoveTQ0WWVRREJQODRYZkZKcHBBTzZvVU1Xc2ZOc2tT?=
 =?utf-8?B?NlRLK3NjRWt2cHpRNjlZLzFGWGltOC80ZW1RSTFEMjgrSDN4TVlpRC81Y2VS?=
 =?utf-8?B?RW84emkrR0xlZE5DOUdMYnNwbVMvTy9YQWpYU0l6WWxmcWdqYU9mRkE3alZ5?=
 =?utf-8?B?NnJKZ1FJeVI2bU1ncFJLMkhRQy9HQ3dCNDUvbkFEbnFFL3JXekttZjNmQUFV?=
 =?utf-8?B?RWZhRW1WV2RoS0JPR0tWVkpHWEsrOFdoUm5XSG9ocUFSbktoL3VZR0RLMm9L?=
 =?utf-8?B?WFl5Um5mUnBlZXRwbnA5dGwwZDdzdzUvSnpXZXBwT2pScHB3MWY1VVpUVEZl?=
 =?utf-8?B?a1Q2R3NGYWl0N2grL3dRdUFuKzVSVzNEQ2EvQlAvOW4xT1U0Sy8vOHNXdDVX?=
 =?utf-8?B?NS9WNjdqMmVvL3dJRnBvVXdYU2NGNlJqc3BYNzVYcSt4dkhlMWdXeVFQSll3?=
 =?utf-8?B?VVBleW5BZmxwYmZJM3ZaaGQraFovcXJSa2lybDdWOThReFo4eXNuVnRnQ2Ir?=
 =?utf-8?B?VC9yVXVYUVBlY1JWdk5WNkkvSUp2djN4MnRrcGhHdTg0M2tWcUVFNkxUTnlC?=
 =?utf-8?B?cDNVdnBRUkFsVkp1Tm8rS3pHYVhnQ29QNHpSdGRQbzFma0dZb1A2b1ZzTXlz?=
 =?utf-8?B?eVJFd1dJdEFlVEEzS2M1N29RS0RjeTkzVFkzN0RBU2g5S05sVmVrdUJPdENo?=
 =?utf-8?B?VVJYbFNEdzBlWFFyREpEYjFIOGVCdGYvNE80dkxRL1VnNmRUSm02NFE5VWha?=
 =?utf-8?B?eThVbEVucXFmSVRwemxPRnpCbzhFN0xaY0lxVC9qTVdHSzcxL0JpbnFxNk9n?=
 =?utf-8?B?eWNTT1pjZm95KzgwV1YvRVFabEN0NUkwNkgvREVNM0tPM0tCWW1VVDFXRHcv?=
 =?utf-8?B?eVdoSCttNVphUWpvSkVoSDg3RGhWeFR5RjI5UnhIZy9ES1hpMUdlLzNvWlIy?=
 =?utf-8?B?NmJnS215RWdqaURIV1A2OWE5bEpTRDkyZHY0UWhXODJSNHROdXQwSjJDTVA3?=
 =?utf-8?B?VjBzaW1EM3dkOGhCTXVaTTlPQWhVOWEyanA5TzNzNWJjUzN5RHR2RnlSRUFI?=
 =?utf-8?B?YlBkRENXQnBPRU11TEk2TXlvK1YyK3MwRTFvYWxhRFZNaE1xNHM2NEFOelZu?=
 =?utf-8?B?dXRaWTVsZjE1Z0ZzYm5rMFdVWTFHSncvUUZvOE9BOGsxUFVlTG5wQ2tXaTRE?=
 =?utf-8?B?dnJBdG9ZVzIyU2ttNHlMbk1BanJDM1JKcG44MFlqSXBtNEpUcmp0NFhTbFhr?=
 =?utf-8?B?UDJMc3RxQWFzc2ZPVThqT2tEcG5ncE1wbXJvdGxHK3psQnQyUTU2OXFETEkz?=
 =?utf-8?B?aHhZaG5wMUpHSGEzdGRTWC8rc1JFNzN2eXkvTU1OWlMzVFZLR3ZQS0l1ekxh?=
 =?utf-8?B?OTFUSFFWOTB0WVU0dVlzMkZFMUR6WCtlWnVBZjZkWWR1UmlJZDl0cHpuS1Ji?=
 =?utf-8?B?R1plR2k0UGNNVnVYOGVuSjJCSlBkNmlMK3lzSTdLYkFCTnJlY3d1T2NuWXJi?=
 =?utf-8?Q?PLyveyrcPEtsgXalXRzP3xXbm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f1f346-a58b-4281-2853-08dce4b60a53
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6839.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 20:49:28.9521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7iqBogXdNU9sfFRlD5iAG0BDpnftmugAzOOzR2alIzV4cFsgfnmN42QPCKlIdlpJqA5HVT3F9xiufONtwiJeZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8845

On 10/4/24 16:44, Alex Deucher wrote:
> On Fri, Oct 4, 2024 at 4:43 PM Hamza Mahfooz <hamza.mahfooz@amd.com> wrote:
>>
>> Since, two suspend-resume cycles are required to enter hibernate and,
>> since we only need to enable idle optimizations in the first cycle
>> (which is pretty much equivalent to s2idle). We can check in_s0ix, to
>> prevent the system from entering idle optimizations before it actually
>> enters hibernate (from display's perspective).
>>
>> Cc: stable@vger.kernel.org # 6.10+
>> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 4651b884d8d9..546a168a2fbf 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -2996,10 +2996,11 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
>>
>>          hpd_rx_irq_work_suspend(dm);
>>
>> -       if (adev->dm.dc->caps.ips_support)
>> -               dc_allow_idle_optimizations(adev->dm.dc, true);
>> -
>>          dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
>> +
>> +       if (dm->dc->caps.ips_support && adev->in_s0ix)
>> +               dc_allow_idle_optimizations(dm->dc, true);
>> +
> 
> Is the ordering change with respect to dc_set_power_state() intended?

Yup, it's safer to set idle opts after dc_set_power_state(), since it
involves a write to DMUB.

> 
> Alex
> 
>>          dc_dmub_srv_set_power_state(dm->dc->ctx->dmub_srv, DC_ACPI_CM_POWER_STATE_D3);
>>
>>          return 0;
>> --
>> 2.46.0
>>
-- 
Hamza


