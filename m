Return-Path: <stable+bounces-181500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E69B95FD1
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 15:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3AA52E0AAD
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 13:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EEE322DDF;
	Tue, 23 Sep 2025 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bj/nPR4P"
X-Original-To: stable@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013057.outbound.protection.outlook.com [40.93.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E472311945
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758633520; cv=fail; b=Z2plfhLUprG1EfT14mpb8Ta3nNDOxWBxL82Tb9L9h9jTAo4CGkYSZZNAbH3ZgxQbdDb14zwczh2YRINPp5mEUyKr/dZBTfzeI56uR0BO4i5PGhH4m98w1ACEzHuT1RuxHx05txKMRhStwOYs3rEjp/j2+vl3bM+A/cegVXYoUM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758633520; c=relaxed/simple;
	bh=/IXcn3MR/Uy4lL+hfEMVxTbFGFZlwdOAVq6NKbQyfDI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F5TEggEVLNShRkZYtzQH5MPhZj4KHt+HomSePd6j7UgMomxshEw+vEgZATd3oypuqJ4/V8mNmoZ3RY9qX8L/MfEDJ3mxiZUubXJ8zBT9okQH8QExVYyctk+EvFeJ5VbwZ4d7lswOCidy+YwjTkhoT9fC6l2Y6NNmSVMrnH0UKRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bj/nPR4P; arc=fail smtp.client-ip=40.93.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aj6FXpWUJ/ZE5vbx0Ozd1tg9a9wzRGZ3rhr99OglXv3yiUaZXDGq8nXeaXeFR0Uoy7GT0Go+CeP9AIJ5YHvORWFj59aRU2NoUq4mzKeM6lcP6eDgOR6EFptHMLdnIcGQh1yPUXwC65+X4GFDpLPaPSRHzYLUjepIqtCTa7o4imchNesBPSbZn4bNn69TSIMjYn6HLOngSVTA1DhczwyswWEJhLLZl3OB7ypF8icq0SoztNNqDnQVPjUp3GIqSRGeBfUBAoh/sjyTP4wd8ENEjvNUlbIY0YJNRinpWFGyad9x4SEVXtdx+74u1DBmdc12pZad0SRMojhNmOCaFyG/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhLqfXDbJLuNIev95Fa03ig+MvbkLNc5gIA0nxJxWKE=;
 b=fSxw8BtLErS/cT8KnxP+/Q7IyAVlSmUcXJCRARfPf0RyMWKbdAnohAb64Px0gtpzzXtTWxzucuhM1Fxo692vOpAR94omIeS0wgno/wAQxOUcUgT95XRwKuxaS8OOZiMyebQv1ERmhVJiaZn4/QlzQgiAy4CCcskfZ5BWaGpv7Wy28lI12YsBzNpuiEp2Oi99qeAa4/AKCvWLVYepql9UQuz1SGpe4sUyrv5r/mqPKUejSEGfaM+/RTAYSjeLJYeSNuE8yj/Nc+tfcIU5Cq+BN3T3kIWL1cZrITVsp4iCzOVTkpNMfCufpXx9dhlW0xY7qKriUF1RMfHRV6ESK5RGkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhLqfXDbJLuNIev95Fa03ig+MvbkLNc5gIA0nxJxWKE=;
 b=Bj/nPR4PNIGONgQLfb3zHZadIOg4NpPjAPe/JSihVysL9j19bWPeHWhE0RwFpdgodhCRu/Yliebs9q42c2r0cug3PCTYJEttCKzEa/nfqm3mmZYTS/f/rRwR/rurwvD6kzceSgBEmUvFfJrPpFg1rCQCK8TJphzUlU3eI4ikdNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 13:18:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 13:18:34 +0000
Message-ID: <420e1863-01d5-40f7-ae39-4c0952eaab47@amd.com>
Date: Tue, 23 Sep 2025 15:18:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y 1/3] drm/sched: Optimise drm_sched_entity_push_job
To: Philipp Stanner <pstanner@redhat.com>, Jules Maselbas
 <jmaselbas@zdiv.net>, stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, Luben Tuikov
 <ltuikov89@gmail.com>, Matthew Brost <matthew.brost@intel.com>
References: <20250922130948.5549-1-jmaselbas@zdiv.net>
 <8661bce085eed921feb3e718b8dc4c46784dff4d.camel@redhat.com>
 <57b2275c-d18a-418d-956f-2ed054ec555f@amd.com>
 <DCZMJLU7W6M0.23UOORGDH2DIR@zdiv.net>
 <b49f45057de59f977d9e50a4aac12bac2e8d12a0.camel@redhat.com>
 <76c94ee6-ba28-4517-8b6c-35658ac95d3b@amd.com>
 <bda64a5003dacc9dde293b7e09904f1413d9d12f.camel@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <bda64a5003dacc9dde293b7e09904f1413d9d12f.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0163.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6435:EE_
X-MS-Office365-Filtering-Correlation-Id: b645aaeb-ba99-4676-fd23-08ddfaa3b287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjFjV2NkRDMzZ21yMkEzTUxFeksrb0RkRmE5bFowMUpGZnJpYlhuNmFRUXIw?=
 =?utf-8?B?aW1wais0SUpVMm1WbDhndW9YTjFWMVhMNlBjeGVKQnpFbklha1hSZjlOd0tZ?=
 =?utf-8?B?Q1gzT2syWWNPTmpwTTVFeG95MDViN3pKWThzUng0a3Zvc2cwckxJYkVVc3Z0?=
 =?utf-8?B?VUdvdE5hNlhIaWNrUStweDMzQWxadHlXbVcrZjlHVElicm02NTkrNHRXTTZJ?=
 =?utf-8?B?SC9OeVdiKzRxek9nZ2hBNFAwTHp5cjRjeFpQdVJHR0ZmZ3UyYmNFSkhPdDFn?=
 =?utf-8?B?bEhIS0k2WW1MdFlDek9WUEk2bzZ0NXF1M1N0RWJ5akFXWHVzU01rS0dpVW5X?=
 =?utf-8?B?emJ6OEVveGl0ZGxsTFZLVm4wRm5Rb0JRYUxqRUkyNFJrUHF3dHB0THhjMnI5?=
 =?utf-8?B?VGhQS2w1OFNRaHpidGY2MCtNU0lRbzVOU3FzYTd5eStyUDV6WFJGUzVDc3Vr?=
 =?utf-8?B?STFjdjdZcUI4dE1XQkQ5andjR2ZMU0w4alBuYWh3UTAvVEVPZ3RER2taRm1D?=
 =?utf-8?B?KytzOGhYbm9WTlhrVzFZL0pveGY4ZnB6MVI1Tld4NWdtU0ZKcnBsUWhGUEtY?=
 =?utf-8?B?RGkyd0tpUndhcVMxSkN4OVk0ZXNjcS9DWGhDcm8vS2s4Nmhob2NrY3Nqd1RI?=
 =?utf-8?B?ZnIzYkVLQjZEcUZydVRQYVFqNXc3eEJOalI1dy9odW95NUtPMGs0TC9mM1dH?=
 =?utf-8?B?SzNXcHJNWTByYWd4SkFNYVVDS3JmYkZWcHhoUThzenhmVUVURk5tSmNaRTgx?=
 =?utf-8?B?VVZQa2xoa2xSRnZCN3RFN21YY1R5anRlWmZuSmorbVpzcE5NTEtDYlhHV0Jw?=
 =?utf-8?B?QTJVeDNOeHE4OWxPR244enVIZkFDb25heWk2ZDNPQ3M3TzdpUUp1cUNKTUhw?=
 =?utf-8?B?NDZFSXlOTHlrMjE2V2VPWFVpbnNZNWI4cXl5Q0lIeFEzMk5iVXJUSzI0ZU5B?=
 =?utf-8?B?M1JwWlMwVU1rcEJaengyakYrWExYSHhCZjRDMWExaHBXVytnN1hoSS9kUklw?=
 =?utf-8?B?TVFVYklVQURiOUJTMVNHdXBaYnFiYmREZlFFaGcvWXJrU2tOdFNrQmh6SVZm?=
 =?utf-8?B?eXB1UTRDYTZSNHFNQ0FwZlQ1M05EM3c3ODYycUQ2RllwZy9hMEh5UUt0THk0?=
 =?utf-8?B?Nk53b3Fob1ZSdHZEdnozWlA1MTRNSFVNYWNiTzFMUjFTRVlhRDdsR1lmMHMz?=
 =?utf-8?B?MlN3RVkvWkg1SGg1dGYyakYrb3RxMWthWnp3aXkxcWZ3eG5FSVdZNUYxdS9t?=
 =?utf-8?B?ZmxkTEJZZVJES25nUmx4MnlnRkJ0OVlhZXd3UVg4K2xDR1M3Um1zRHFoSmZP?=
 =?utf-8?B?eGNVNTcvampmbDVHQzBDcDlBV01Xc25HVVRLTm5vcHNsQXozejNlek4zdHBw?=
 =?utf-8?B?V1dWMnd4WXpzd2wzUWV1d3ZJbEJHdHdtK3pqdFVTV0VCOFJBdXM2VHpLaG8r?=
 =?utf-8?B?RWVjcXBSMkZ3WnFVNTJtckp3UzVyaCtWQ1d3a0ZQdHpQV1Q4V0tjWS9rWlNC?=
 =?utf-8?B?NU56STFRaDFMUlBGeWpxUFBVUUxFanhET0hscXZSWWZhSDFud01nWUJsQ0Vq?=
 =?utf-8?B?RVVVam41dVFPTWRHNkNKZnBhbVExamk2Wmx3d0duVnRBVTZRaHE1dUh3a1NS?=
 =?utf-8?B?SzNCWjlTUyt0RVdmU1U3RG1TKytZTnVZNjFUbFUyZUc3Q2ozYVpnVTQ2T0Iy?=
 =?utf-8?B?ZG0yQi8vTGJDMEM0N3ZkSHNKeWNGU0d1ZXp6NlZtamw0VWxqUlFrdTIyMVln?=
 =?utf-8?B?MGZsa24rWXF6eGlJNExqbmxPM29pR2I5dGZManE5VzlYTFJaWmlIR1g2ZHdl?=
 =?utf-8?Q?NpPyINcpuB/XNZJtAoVLD4s4Cva6Od+0behK4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVU1WmtpUDJMdUNNbUNhWHlTWk1UR3c3bGlycHdRYUsvWE9aUDA4S2tBRVdO?=
 =?utf-8?B?eGpYcnQxU1V1K3NIRm1qM2VFUi9VTG5sc3dQVVdMdXd2UkF4Q3JQSXJmcWJ3?=
 =?utf-8?B?TDErRzFabmRuZ09pQWFsVFM0V0c5UjI1RkxUVFFGYkNCTStrNnhzRCtBbkkx?=
 =?utf-8?B?WnE4czRyY3o5SUFCb2ZvVUtQbUoyZWtRZjl6QWs2RzloWkxkemVMNTNxd2dY?=
 =?utf-8?B?TUloUTRwa243c0hlYTZSc29pMlE1dVRnZE5STytZOWFuZkhpTmVvUFU0aFc3?=
 =?utf-8?B?YkxXWWJjcEJRNmtwV2tZZDJrQld1OUMvUWE1TFZtdkhtaDhDQ21Oa1hzWU05?=
 =?utf-8?B?RzR3Q3FGRzM4Yzg4M1VnVVNuSTk3SUw0SzFFZW4xL211dE1uN0NLSmhqMTNH?=
 =?utf-8?B?NjMyN296KzNMQ1h2VWFEZmZ2VTJWNVZya25OV2MrdVNyTEN0LzBwcm9NTDZW?=
 =?utf-8?B?clJqbklCZE5ONmtGRjNScE1OYTJhNjUwRmdDWE53VkRQV1ZDL2g4OThnUyto?=
 =?utf-8?B?NFVaNkE3L0ROUUc2WTlQaFNRTVdaaTZFRWx4R2xjaUI3d0JMd0NOQkxsd2J2?=
 =?utf-8?B?R3dsTXF3bko4bEZOM1NieVVNam8zNi81bnlka21TK2VzT2pFc2FKaTdXdGZU?=
 =?utf-8?B?NjlHZHZHeHlOa2tNY1M1bmVaVkgrVVA1QzloQ2ZIN1F2SElrdW95L3JOc3Zj?=
 =?utf-8?B?bFdsQ0NsYUxjUkNRMUxUUXZhWEV1R2tqbFZybkQ2cGpybkhuejBqZVZyTzFm?=
 =?utf-8?B?bjZsK1JVZnczTTdHY0oxSlpETjhhZlBMN0xtemRuZXNpOVdudlR1RWE5Vy9z?=
 =?utf-8?B?ZllObU9vbTNQUXovYmd6OUZ3eGMyaFBsbG1ZbWxHZUFoUjlsU0JhRUFXTS9C?=
 =?utf-8?B?VC9zRlFOV0Frb1dwM24ydlBwU2VLeXM5WW9tYWN0bTBBVXFCS1ZaVUVWL2lE?=
 =?utf-8?B?UlE5bjFSU21IMHh5NlJrRS9PR2I4YkNVVUk2MEdWamVEMElpYXRrM0JSTkFI?=
 =?utf-8?B?YzhaaG55N0JBS2hNUWtRSHVZTzNJZ2tVanBwU0xHZmNYRzdKZGNocFVEeVMr?=
 =?utf-8?B?OHlwVzc3Q1Q5Zm1xSTA4ellsTm1yY0VhdG52NUhvWmg1bWlJZ1VMNlZscndT?=
 =?utf-8?B?Vlp5OXFqZkRMWEJwYktpMHVRTWVQdUNiY3NGc3B6OXdTRUZ0VFFFTjZ1amxn?=
 =?utf-8?B?OS9NVnh2TWxnWlR0WUVQK1E4ZVMxQ0cvSCtMenRrakl2YVJ6MWJ5SWtMUjJ5?=
 =?utf-8?B?bld1dkhUTy9iSURnRTVRTlZxdVplZ213cjV4djhTVkhQU3Vqb3p1ZW5ueFpQ?=
 =?utf-8?B?Zi9FZzZzZHY0ZXBaczZveUY3NGxsNGhkblFNNjBJMkg0OVpiUG95RFY1L1gw?=
 =?utf-8?B?anpiVWVWdGdHbnRxSlVyaDJPczRxOE5OTFFwbFVER3VVOEtkZVZnRjdlMXBR?=
 =?utf-8?B?WXREUDNpajdFcmc0SGdEclVvME1pSGpadUN3YnhDM1d3UGRXTFZsLzFJdWRk?=
 =?utf-8?B?bUplZFJGK3pHZEpmL1BabVNYd3lSRGRNYXJJSEFKbFlKZEJFNHdaL2E5WnA3?=
 =?utf-8?B?aFNXWkluR1VMNXhvL1h3NDZsSzAySFVxMVFhdE14Q3RYem14WUxGalZkVmNM?=
 =?utf-8?B?ZUdMNEVZdkVnZDNpSmJvdU1NVmtseVA2MW1KOE1JbzhCdklEZjZiWFFhOUUy?=
 =?utf-8?B?V0kvTnpKcDFvM2pCaCtMVE8wWGFaQnlENmJhRUJpNXB1NFoyVTViYm1TWjhW?=
 =?utf-8?B?QnZBcUQxcTBVV3FQeDZKVHAyMjYzTWRTb05PblN0bS9Rb1RMSFBkTDNOVTFI?=
 =?utf-8?B?b2djaDRVU29Tdk4xcjlNaDRIaUU0c2x2QmV1bS9FRlN5VWd3Y3BkZDVxWmVj?=
 =?utf-8?B?bXZxbVlRY0Y1d1lzNWVPN3VTVkxnd080bExJUUJLRXJob0o5N3ZaUmFWMzI0?=
 =?utf-8?B?ZnpEZEo1VmlONFhzTzhWVGgyT2hhZ0FQeU16ZnFYeUo4ZVVIN2tHNkdlMkt5?=
 =?utf-8?B?QnVka1psS0Z4Y3VQTFRTVHY3dmlHUldTNUV0cmVvMngzTmVvQVdqdFp5T3Rh?=
 =?utf-8?B?ZXJyZDhWWGNlVmphVHUra3oyb0RpZ1g0RnJoQkpJR015SlE1dVdEclJUK0hq?=
 =?utf-8?Q?ubFr5OWtWFQo4obrSp0LZ3Mdz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b645aaeb-ba99-4676-fd23-08ddfaa3b287
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:18:33.9893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvsnW4/CxiToI9okR+33Q8EqiPxXZX+xnfXabik4x4BGeSYwM4NypuMdU283ZeLJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6435

On 23.09.25 15:10, Philipp Stanner wrote:
> On Tue, 2025-09-23 at 14:33 +0200, Christian König wrote:
>> On 23.09.25 14:08, Philipp Stanner wrote:
>>> On Mon, 2025-09-22 at 22:50 +0200, Jules Maselbas wrote:
>>>> On Mon Sep 22, 2025 at 7:39 PM CEST, Christian König wrote:
>>>>> On 22.09.25 17:30, Philipp Stanner wrote:
>>>>>> On Mon, 2025-09-22 at 15:09 +0200, Jules Maselbas wrote:
>>>>>>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>>>>
>>>>>>> commit d42a254633c773921884a19e8a1a0f53a31150c3 upstream.
>>>>>>>
>>>>>>> In FIFO mode (which is the default), both drm_sched_entity_push_job() and
>>>>>>> drm_sched_rq_update_fifo(), where the latter calls the former, are
>>>>>>> currently taking and releasing the same entity->rq_lock.
>>>>>>>
>>>>>>> We can avoid that design inelegance, and also have a miniscule
>>>>>>> efficiency improvement on the submit from idle path, by introducing a new
>>>>>>> drm_sched_rq_update_fifo_locked() helper and pulling up the lock taking to
>>>>>>> its callers.
>>>>>>>
>>>>>>> v2:
>>>>>>>  * Remove drm_sched_rq_update_fifo() altogether. (Christian)
>>>>>>>
>>>>>>> v3:
>>>>>>>  * Improved commit message. (Philipp)
>>>>>>>
>>>>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>>> Cc: Luben Tuikov <ltuikov89@gmail.com>
>>>>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>>>>> Cc: Philipp Stanner <pstanner@redhat.com>
>>>>>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>>>>>> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>>>>>>> Link: https://patchwork.freedesktop.org/patch/msgid/20241016122013.7857-2-tursulin@igalia.com
>>>>>>> (cherry picked from commit d42a254633c773921884a19e8a1a0f53a31150c3)
>>>>>>> Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
>>>>>>
>>>>>> Am I interpreting this mail correctly: you want to get this patch into
>>>>>> stable?
>>>>>>
>>>>>> Why? It doesn't fix a bug.
>>>>>
>>>>> Patch #3 in this series depends on the other two, but I agree that isn't a good idea.
>>>> Yes patch #3 fixes a freeze in amdgpu
>>>>
>>>>> We should just adjust patch #3 to apply on the older kernel as well instead of backporting patches #1 and #2.
>>>> I initially modified patch #3 to use .rq_lock instead of .lock, but i didn't felt very confident with this modification.
>>>> Should i sent a new version with a modified patch #3 ?
>>>> If so, how the change should be reflected in the commit message ?
>>>> (I initially ask #kernelnewbies but ended pulling the two other patches)
>>>
>>> You know folks, situations like that are why we want to strongly
>>> discourage accessing another API's struct members directly. There is no
>>> API contract for them.
>>>
>>> And a proper API function rarely changes its interface, and if it does,
>>> it's easy to find for the contributor where drivers need to be
>>> adjusted. If we were all following that rule, you wouldn't even have to
>>> bother with patches #1 and #2.
>>>
>>> That said, I see two proper solutions for your problem:
>>>
>>>    A. amdgpu is the one stopping the entities anyways, isn't it? It
>>>       knows which entities it has killed. So that information could be
>>>       stored in struct amdgpu_vm.
>>
>> No, it's the scheduler which decides when entities are stopped.
> 
> The scheduler sets the stopped-flag, but that effectively only happens
> when you either flush() or fini() the entity. OR if you run into that
> drm_sched_fini() race.
> 
>>
>> Otherwise we would need to re-invent the flush logic for every driver again.
> 
> Let's ask differently: Does amdgpu check here whether
> drm_sched_entity_fini() or drm_sched_entity_flush() have been called on
> those entities already?

No and it should not.

drm_entity_flush() can be called many times (and even concurrently) on the same entity.

Only when the scheduler sees that it is called by the last submitter of jobs *and* because this submitter was terminated by a SIGKILL then the entity is killed as well.

Background is that the file flush callback this is used with is basically called all the time. And as we now have found once more also because userspace forgotten to set CLOEXEC.

>>
>>>    B. Add an API: drm_sched_entity_is_stopped(). There's also
>>>       drm_sched_entity_is_idle(), but I guess that won't serve your
>>>       purpose?
>>
>> drm_sched_entity_is_stopped() should do it. drm_sched_entity_is_idle() is something different and should potentially even not be exported to drivers in the first place.
> 
> Fine by me.
> 
>>
>>> And btw, as we're at it:
>>> @Christian: Danilo and I recently asked about whether entities can
>>> still outlive their scheduler in amdgpu?
>>
>> That should have been fixed by now. This happened only on hot-unplug and that was re-designed quite a bit.
>>
>>> That seems to be the reason why that race-"fix" in drm_sched_fini() was
>>> added, which is the only other place that can mark an entity as
>>> stopped, except for the proper place: drm_sched_entity_kill().
>>
>> That is potentially still good to have.
> 
> That's why we left it for now and just added a FIXME, because there's
> not really any benefit in potentially blowing up drivers by removing it
> (well, technically blowing up drivers like that would reveal
> significant lifetime and, thus, design issues. But it wouldn't be
> "nice").
> 
> Still, it's a clear sign of (undocumented…) scheduler lifetimes being
> violated :(

Yeah, I know :(

Regards,
Christian.

> 
> 
> P.
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>>
>>> P.
>>>
>>>>
>>>> Best,
>>>> Jules
>>>>
>>>
>>
> 


