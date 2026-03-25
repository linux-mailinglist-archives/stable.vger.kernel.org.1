Return-Path: <stable+bounces-230261-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDmxC+5Hw2lDpwQAu9opvQ
	(envelope-from <stable+bounces-230261-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 03:26:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C232931EA9D
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 03:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1804D30400A6
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 02:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420C32848B2;
	Wed, 25 Mar 2026 02:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uFRj8h6k"
X-Original-To: stable@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010057.outbound.protection.outlook.com [52.101.56.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C201531E8
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 02:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774405611; cv=fail; b=mESmnTyDbwx2vHvIk+A3wJGwoG+iFKAdHRxDFmgTHYwplclln6cgOgbfSwCgdj8+qebiSc+O0E92NMY90PGeMqMPQi8NpfMgENkP7hkN/DrTbM24n7hb1mEVm5E0qGodQy+2mLkS/DvOQwrU5wy+Ns/exITTY+28OEkGI6xwOsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774405611; c=relaxed/simple;
	bh=9ALNbd8hzzyZ7Pl/bQzg92eD4m6eUpqRy0d/4efsXgw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lX2XIQkCDh8PHP4e3WOGNnCnzlccZpfWZ5AmKx0jDp8gIHRrq9yyjSqubachOvXz36gPwCt0VeE7g7okZV5amPNl4MeY9mvSI4F0CmGdQcQypzeUzOqh3hW3OgfpUIqtn4D43IrPCYj1+1+99ijWKC2fATl710a+n7QyudlfBas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uFRj8h6k; arc=fail smtp.client-ip=52.101.56.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAooNKpoqnj73hafVYMPkfFXRpxBCzMGMS/laCj7+7oagx0vfsSZdCJddoVkfQgt8QDTyLHwKA+n+gvdK7Nmo1oSQkOFKGtA250y5Kizn8RN9a4qwmED555+fWWDaEuuUhpnSfMPdWZUvdMfqqFIQ8mn2lbwGIHopn6b44BdSqKTTEn9hZJbQqGtJsmP2DMUP89UGTw+KwB4mcDXaij+6UBDwu0RY7FBX9tfXcb+3xsyejQ9mWwiyaPA+lIlQA/sik6QpC7z05ihFMNyFAy2ckd2EcSavabgnbaO/PjgSXv1dF8tT+UZWKaZbHFg1AmN6/usKM7Q6tFzugpljziqRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxkaVVbrghgqtyUK8if+h2NWMyO8/qx0aUzcyx+rFd4=;
 b=r63VhHUCmTJSu070ol3Lh1C1uW0mZ5Id0zQAJyGWHqs8Fno8Tht+xJX/yQSsFbBFBDKUmpLZpx/igRQIstvAPdmpct3N+b2MKibJ/SWw4Qtjpjo+r01//+hHzC7of+F2l8yCCXUBa0pyNuCTod8VsaDZ/lhwV0L3fbKY9ybvOcWwJSUH6GniqnVPzsKLBJaw1rO6SeKtCTvmzPDv6+NCE+s+Tm/VWSvo591fahKhaq/cmJVBoUoEop59YCDze+2utvhFZm4UaME4QKJnjoPoVPkl1TfoPc8CfS8U07GR+mQPHtd4Zn13hQDaGWQwNSBLwtEWxjmbKg0HT9/y9Xv8qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxkaVVbrghgqtyUK8if+h2NWMyO8/qx0aUzcyx+rFd4=;
 b=uFRj8h6k+52xplLO4gS425PSKfjBL4pjR1sPwTeJcdu5afljDKaPOXoJWWUQIQK2mK5uNe1KpkVT8bpuT0OHubSoUeFddJczOGG9FaD58ULtcX5kfdBF/X6PecgOhpA6Jpi4zx13Iuvm51TijmRoMPN0saEScS7GsKpRJLEoBHM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB6922.namprd12.prod.outlook.com (2603:10b6:303:207::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 02:26:46 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977%6]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 02:26:46 +0000
Message-ID: <6b2d502d-08ef-4008-8399-f5630de2385c@amd.com>
Date: Tue, 24 Mar 2026 22:26:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND RFC PATCH v3 1/6] drm/amdgpu: Change
 AMDGPU_VA_RESERVED_TRAP_SIZE to 2 PAGE_SIZE pages
To: Donet Tom <donettom@linux.ibm.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, stable@vger.kernel.org
References: <cover.1774239489.git.donettom@linux.ibm.com>
 <d3a5bd9b4bcff28c1c43c4c46479cd95d4dcf7f0.1774239489.git.donettom@linux.ibm.com>
 <65a96159-1266-4b42-91ce-359fcd1a76ea@amd.com>
 <7beedf3b-99f7-4096-9a49-88f98b9b4eb5@linux.ibm.com>
 <bf255b34-0def-4a0b-a07d-30b9271b0166@amd.com>
 <6171f849-4164-4fd5-b31e-79c08df936c2@linux.ibm.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <6171f849-4164-4fd5-b31e-79c08df936c2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0125.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::34) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e16d6c2-2e3a-4927-e4e6-08de8a15f60b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	f/U5vbV4WKkDndyryGESdvA61rlzgmF2tcGsMl3CGNrhgfIe/5qtRVk92dqyvRVJKD6mLxoNB9+74UPA2nLZkHGlWS4PqGUkQPWdJNMOpmoDzNNmcwSyafszUqdF/hV7LUDRzYEihsM/LNP3EwHGz9hPsliCo5TWE6f05uAX0ZIUTR4kYwBFsO1TR9L9eJcrkTxKDUmXVt1VRWgWXN4MSf6FsOrHo0YHe50rGtJK0LmVH83aBfklE+3hHwsjvOKg4h9nGpKdfq8utUGMHO55ZkNkz6BJBp+Ru+m1GR24pSJ0G5Qr+vma3YWAMLbwTBr3M2kSpZyManuRcZxfRxWW+G91UeLJlRrPvDROQyJpAYF6B13GlSUmWaANeg/x089tWSASm3o14oenPZMM+ZhoT6jOjsJMRPPM/kf+eynrVc5ES+K16zQZ9+BCsk8k4IB4rUz4Lelde7yH0G4OfgFJVMextAatYiakznS2CBQZ2y6f/1Sd6fivfKN2L67P+hNKlaN0XJXx3bJp5pPv8JfH9nisA1ykqi94dLHlluWTY9Xj4N6tpkGmbDy0PW4n7gFzQSQk9GNHvHi2osRwgdEjAaFPBIqvXnwcC/jEqa0mMj5E6ZAUUa6KZkU+qOSY12SE6O7I8IFlK/3dHEVR+vuB1PvUdEPiJIUWMqhuEgK1yPcJ1ienC+F/HCjHCrZHJnj/quwlE/kWoFu7P2+iqm5mCqg6i+esTb6Jn9k213q85VI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm9MRHlpUXdpOGd2MTFXMlFoeE9nQVFaZTVEczRCWFhxTzFoQ3RjQ0tKdGE1?=
 =?utf-8?B?MGdHYVBEdjlrTUx3Z0RJNEgwUGxDdmVXdzg4cko5RnQyMGlBWklNbDZZY1R6?=
 =?utf-8?B?R1JiWktLQjU5VnVvNjU5VHIrc2J4UVlRM3YzZzVjSmdmOWo3VjhoZXRGbkFt?=
 =?utf-8?B?RzlZeE9Oa2JDMWl3b1JQajdQb3hSNithZWpvRTJzWkNHWWE1Q2RpMVNQTXhz?=
 =?utf-8?B?UGRGbXQyOGgzRUNoeTR0bnJvL3VRTDRZTFg2SHBITVlQZlRHbkJ2NTFNdnZF?=
 =?utf-8?B?MWRyVlk1Rit0bTNZZ2I5Yld5aHBQMmRYb0RyVE1MdnlxNkRvbStRalg4Wm5v?=
 =?utf-8?B?MEl1aDBIQkNkTXhNSXNsUkdBRTFvcmN6bCs5TG5xbndwZDlKQjJFY1hHcHZU?=
 =?utf-8?B?YzFXUStBdHR4SW5INE1wR3dCT202Y3ZRekt3TVFrbzYvcFluNVJ4UFlwdWdN?=
 =?utf-8?B?WkdMZFBtSS9ZYVptdjMrZ2ZyZjRRcElnUDlPT2JERVY3VzErekROZVZaUWJP?=
 =?utf-8?B?UnBNb3hOVEFiTDk5ZkZGamkrMFhwUndrbUM4M29URUNKeHd2TjU0eGhMQVpJ?=
 =?utf-8?B?MGVObFpOTXpCNVFRYmJkbWVtRlF6WHhWdjJBU1pwa1ZHTE9TRnFndjFEbTVP?=
 =?utf-8?B?cncvMExRTFFwQ2NFaWIxZlhtakdiNGNLZGZpZjVNV2lMWU5aaEZENFQvTWZz?=
 =?utf-8?B?SUZYaGJ3U2lNTHV1ZWpMeUJHZE5mZ2luS1dWS3FTY3lkK012dmNEdE84d1Bl?=
 =?utf-8?B?bER2L3ZwbDA4SGsyVXhuMHA4M3NNT0hCM0xHdk0rQ1lqVFZ1QUc0LzF3ZkdR?=
 =?utf-8?B?NHFIMzRJa0tRTU8rZkU0OHk4dXdoNXpOb2xGdHNuNkI5T01ORk82MmI4b2Zx?=
 =?utf-8?B?WCtkNDF0aEdnZTBZbTV6MkJhZ0JldUhxMjUrdlovdWpHNHhGMEdpV2UyYTBD?=
 =?utf-8?B?cG1OODBZUmVYUk44UTllRDZDdWZ1Q1ZDWlpBL0FLYzNwM01mOFNQamJ6SHY5?=
 =?utf-8?B?ek1zWXNMc2VlUm9sRXA3OVdrYkkzRkVyb0dpdHRVYnVwRDFnNjdQZGdydFNL?=
 =?utf-8?B?a05MM3dldDVNWWRpeUs3K0ZUa1oxcHVPTjN3NWNacEgwTjVaMHlDWHFQbUZ3?=
 =?utf-8?B?eFdocVFPV1pFRCtJelZGWHp6Q1ZPdS9JdDN3T1RvSWNQdUJ3aXFQTUs0bnVI?=
 =?utf-8?B?bExDenZwak12SE9vRDVZcytpNVlGVkg5MzNkNGVrSFZZcEx3ODF3RXhnV1dP?=
 =?utf-8?B?ZHRqd21WMEJUNEhiSHFnSnkzY0k0U3RHbExja2Z3VXFIMGlMU3lydFJ0YzZX?=
 =?utf-8?B?QVdSdGV5RVBZaFZLT1o4T0Z4RnFqY3k1KzNnb1lMMlpKMXNkNGlDVEFnMm9m?=
 =?utf-8?B?ejNjTU9oVEozNm95OHFVa1NNUWJYeTRtNVY1Nzh2Qnc5d1dpNmZIRkNDdUs5?=
 =?utf-8?B?b3ppMHVNcTVUdzNzSlJLSUkvNzJjRk8yanN0b012VnhpU29rL1BXR1VIaVBG?=
 =?utf-8?B?YmNlV1lnV1ZKMEdBTk5uazlOUEtKalFYWCtLak5TRDkyMlQ4dGJGVlZLSm0z?=
 =?utf-8?B?YVhmbjFqVG9VZk9ZKzA2aHRGZU9pZzl3NTlDbUJaRVZYZjFQcll3MTl5S0JL?=
 =?utf-8?B?azdQRTBqcGJ3Rms0U0g2aGpmQzVmQ2YwekF2dTlqcitBUmdjdGtLSmhQY3RJ?=
 =?utf-8?B?M0x3OHdXVUpWY3pVeTB3S1lhSXlHZ01ZL0xnbWdmK1llOG1LWGNvU1EzeWxD?=
 =?utf-8?B?YkluZUdrR0duNlFKRkVXZmZVVDR6QWtwMWl5bW40TjN4WWhVc0ZKRHhnV3VP?=
 =?utf-8?B?eXBsTVgxUDdZMzg4RzZRSUZkMzhVcEJwV3NrWE1hbVdxZ3RhbzI3dSt6VC96?=
 =?utf-8?B?cDR3SDNRTjNKODNzWGNmWXRHbXhtd2x5VmROT0lPVzRjMmxLYWxmU3pUUUhj?=
 =?utf-8?B?M21kZDlHVHlnT3EyY2FyRGk0bnJ3bll5dVJxVkZOUU5RMUMrU3pReWZVaDl0?=
 =?utf-8?B?VVVDQ2FNU2tvRXlhTS9EeUVWdjlEQ0NSMW1WVHNsVUh1V2JFRi92QzFueWs1?=
 =?utf-8?B?L0lXc0Q3dEFQR3FJMmlWRjhLMmZ4dlRoL2tad3RHaFIzL20zWWtmUXdsdytE?=
 =?utf-8?B?REJ2anhIdXVxRWVrQ3RoZm54SFZuWWxPdHBlV0dXU2dTNForQnJnSk5LeG1T?=
 =?utf-8?B?WmNYMi9UMjcwbURVMGdZTHpLcitNR0MwYmxWeTJOdWpkeUcwQWtBbVJCZmZR?=
 =?utf-8?B?aktETnN5MlAraTlKL1dkSFhRZDBTeG1objg5S2RyQWlUeUZvSjQrempXVzFO?=
 =?utf-8?B?ZUFjNGYwU0NNYzN3UWZFQXBkQjlXT2JPTEROTUhOcTQ0Q1FuNjhWUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e16d6c2-2e3a-4927-e4e6-08de8a15f60b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 02:26:46.2124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVC4+rB/H61D/PdL6d0yc4vm9SnIZb3W1jQg60fZuuc0CjDTyzthkBPIVd1wqabYFPi2sjPW7fA5yjCqj/yXKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6922
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux.ibm.com,amd.com,lists.freedesktop.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-230261-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,linux.ibm.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[felix.kuehling@amd.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C232931EA9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 2026-03-24 14:19, Donet Tom wrote:
>
> On 3/23/26 6:42 PM, Christian König wrote:
>> On 3/23/26 12:50, Donet Tom wrote:
>>> On 3/23/26 3:41 PM, Christian König wrote:
>>>
>>> Hi Christian
>>>
>>>> On 3/23/26 05:28, Donet Tom wrote:
>>>>> Currently, AMDGPU_VA_RESERVED_TRAP_SIZE is hardcoded to 8KB, while
>>>>> KFD_CWSR_TBA_TMA_SIZE is defined as 2 * PAGE_SIZE. On systems with
>>>>> 4K pages, both values match (8KB), so allocation and reserved space
>>>>> are consistent.
>>>>>
>>>>> However, on 64K page-size systems, KFD_CWSR_TBA_TMA_SIZE becomes 
>>>>> 128KB,
>>>>> while the reserved trap area remains 8KB. This mismatch causes the
>>>>> kernel to crash when running rocminfo or rccl unit tests.
>>>>>
>>>>> Kernel attempted to read user page (2) - exploit attempt? (uid: 1001)
>>>>> BUG: Kernel NULL pointer dereference on read at 0x00000002
>>>>> Faulting instruction address: 0xc0000000002c8a64
>>>>> Oops: Kernel access of bad area, sig: 11 [#1]
>>>>> LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
>>>>> CPU: 34 UID: 1001 PID: 9379 Comm: rocminfo Tainted: G E
>>>>> 6.19.0-rc4-amdgpu-00320-gf23176405700 #56 VOLUNTARY
>>>>> Tainted: [E]=UNSIGNED_MODULE
>>>>> Hardware name: IBM,9105-42A POWER10 (architected) 0x800200 0xf000006
>>>>> of:IBM,FW1060.30 (ML1060_896) hv:phyp pSeries
>>>>> NIP:  c0000000002c8a64 LR: c00000000125dbc8 CTR: c00000000125e730
>>>>> REGS: c0000001e0957580 TRAP: 0300 Tainted: G E
>>>>> MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE> CR: 24008268
>>>>> XER: 00000036
>>>>> CFAR: c00000000125dbc4 DAR: 0000000000000002 DSISR: 40000000
>>>>> IRQMASK: 1
>>>>> GPR00: c00000000125d908 c0000001e0957820 c0000000016e8100
>>>>> c00000013d814540
>>>>> GPR04: 0000000000000002 c00000013d814550 0000000000000045
>>>>> 0000000000000000
>>>>> GPR08: c00000013444d000 c00000013d814538 c00000013d814538
>>>>> 0000000084002268
>>>>> GPR12: c00000000125e730 c000007e2ffd5f00 ffffffffffffffff
>>>>> 0000000000020000
>>>>> GPR16: 0000000000000000 0000000000000002 c00000015f653000
>>>>> 0000000000000000
>>>>> GPR20: c000000138662400 c00000013d814540 0000000000000000
>>>>> c00000013d814500
>>>>> GPR24: 0000000000000000 0000000000000002 c0000001e0957888
>>>>> c0000001e0957878
>>>>> GPR28: c00000013d814548 0000000000000000 c00000013d814540
>>>>> c0000001e0957888
>>>>> NIP [c0000000002c8a64] __mutex_add_waiter+0x24/0xc0
>>>>> LR [c00000000125dbc8] __mutex_lock.constprop.0+0x318/0xd00
>>>>> Call Trace:
>>>>> 0xc0000001e0957890 (unreliable)
>>>>> __mutex_lock.constprop.0+0x58/0xd00
>>>>> amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x6fc/0xb60 [amdgpu]
>>>>> kfd_process_alloc_gpuvm+0x54/0x1f0 [amdgpu]
>>>>> kfd_process_device_init_cwsr_dgpu+0xa4/0x1a0 [amdgpu]
>>>>> kfd_process_device_init_vm+0xd8/0x2e0 [amdgpu]
>>>>> kfd_ioctl_acquire_vm+0xd0/0x130 [amdgpu]
>>>>> kfd_ioctl+0x514/0x670 [amdgpu]
>>>>> sys_ioctl+0x134/0x180
>>>>> system_call_exception+0x114/0x300
>>>>> system_call_vectored_common+0x15c/0x2ec
>>>>>
>>>>> This patch changes AMDGPU_VA_RESERVED_TRAP_SIZE to 2 * PAGE_SIZE,
>>>>> ensuring that the reserved trap area matches the allocation size
>>>>> across all page sizes.
>>>>>
>>>>> cc: stable@vger.kernel.org
>>>>> Fixes: 34a1de0f7935 ("drm/amdkfd: Relocate TBA/TMA to opposite 
>>>>> side of VM hole")
>>>>> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>>>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> index 139642eacdd0..a5eae49f9471 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> @@ -173,7 +173,7 @@ struct amdgpu_bo_vm;
>>>>>   #define AMDGPU_VA_RESERVED_SEQ64_SIZE        (2ULL << 20)
>>>>>   #define AMDGPU_VA_RESERVED_SEQ64_START(adev) 
>>>>> (AMDGPU_VA_RESERVED_CSA_START(adev) \
>>>>>                            - AMDGPU_VA_RESERVED_SEQ64_SIZE)
>>>>> -#define AMDGPU_VA_RESERVED_TRAP_SIZE        (2ULL << 12)
>>>>> +#define AMDGPU_VA_RESERVED_TRAP_SIZE        (2ULL << PAGE_SHIFT)
>>>> Well using PAGE_SHIFT in amdgpu_vm.h looks quite broken to me.
>>>>
>>>> That makes the GPU VA reservation depend on the CPU page size and 
>>>> that is clearly not something we want to have.
>>>>
>>>> Where is KFD_CWSR_TBA_TMA_SIZE defined?
>>>>
>>> Thanks Christian for reviewing this patch.
>>>
>>> It is defined in kfd_priv.h.
>>>
>>> /*
>>>   * Size of the per-process TBA+TMA buffer: 2 pages
>>>   *
>>>   * The first chunk is the TBA used for the CWSR ISA code. The second
>>>   * chunk is used as TMA for user-mode trap handler setup in 
>>> daisy-chain mode.
>>>   */
>>> #define KFD_CWSR_TBA_TMA_SIZE (PAGE_SIZE * 2)
>>>
>>>
>>>
>>> Could you please suggest the correct way to fix this issue?
>> I'm only looking from the POV of the VM code on this, but my educated 
>> guess is that KFD_CWSR_TBA_TMA_SIZE should be 8k independent of the 
>> CPU page size.
>>
>> Background is that this is written by the shader trap handler and 
>> that byte code doesn't care what CPU architecture you have.
>>
>> But I think only the engineers working on that trap handler can 
>> really answer this. @Felix / @Philip?
>
>
> Hi @christian @Felix @Philip
>
> To remove the dependency on CPU page size, can we use
>
> +#define AMDGPU_VA_RESERVED_TRAP_SIZE    (2ULL << 16)
>
> During reservation, we reserve 128 bytes, but during
> allocation, we use 2 * PAGE_SIZE.

We only need two GPU pages here. I think what Christian is objecting to 
is, that the GPU VM layout should not depend on the CPU page size. 
@Christian, it sounds like the BO allocations happen with 64KB 
granularity, but the mapping is still using 4KB granularity. Is the 
right solution to GPU-map only the first 8KB of the trap handler BO to 
keep the layout the same across CPU architectures?

I guess then the "correct" solution would be to change 
amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu and 
amdgpu_amdkfd_gpuvm_map_memory_to_gpu to support mapping of the 
requested size with GPU page size granularity regardless of the CPU page 
size. But that would increase complexity for a very niche uses case.

An easier solution would be to PAGE_ALIGN 8KB to the system page size. 
But that results in the virtual address space layout to depend on the 
system page size.

If that's objectionable, then the next best solution is to round up the 
trap handler size to 64KB byte unconditionally, so its the same with 4KB 
or 64KB system page size. But that would mean unnecessarily wasting a 
little memory per process/GPU on x86.

Regards,
   Felix


>
>
> -Donet
>
>>
>> Regards,
>> Christian.
>>
>>> -Donet
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>   #define AMDGPU_VA_RESERVED_TRAP_START(adev) 
>>>>> (AMDGPU_VA_RESERVED_SEQ64_START(adev) \
>>>>>                            - AMDGPU_VA_RESERVED_TRAP_SIZE)
>>>>>   #define AMDGPU_VA_RESERVED_BOTTOM        (1ULL << 16)

