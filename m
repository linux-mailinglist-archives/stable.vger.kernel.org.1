Return-Path: <stable+bounces-227944-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCNXBhgSwWk7QQQAu9opvQ
	(envelope-from <stable+bounces-227944-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 11:12:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B2D2EFC8D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 11:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1314530065F3
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EA338A73C;
	Mon, 23 Mar 2026 10:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AM9DPV3H"
X-Original-To: stable@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0483563FA
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 10:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774260688; cv=fail; b=iN1NHXgra+gKvAvYA39NKJceKilFLA5l4F6xULh1bpNaFQuacMRmdoZjSwhTO1YduLH2vcMHXfX5W7BKO7KhGMcMxNr5ZfV+bw9RqjF303uCMxdcxBxrRXO1hh0laTJuw1F6R6IeM6qd07UC5Fx0y5lXrODzwQdbyhFP3NeTNFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774260688; c=relaxed/simple;
	bh=Oy0dC807Mk555+OyPL6j33PkA87DHdJK2426s5jAokY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ksgSNEkf2uQ6WVUlXtc5xpGHKIVx0OfwhVoC88bz8a5vc/9Myx3GQ49nHF/kXgvjL3R0Ra3u3F//R48iry8w4eiYqZGMFFcxz/5xHC+tprD6nw12eHyMLnoDQ5arVNf4oHR0pRugP/kl0kUXJTPTK9frlXaSef/TeLggwzhoD4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AM9DPV3H; arc=fail smtp.client-ip=52.101.61.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6dy/CwFrGOeesBEIMViHws0EX8BibVScphJtxGTD+439+5ApyYAyFkv5qFN9gfKwwNDN7gEM+hsGVBKJN9anMlvmeDMHcuKdSkjXAqMyNbnEVrIAQ6WuTcXbWxi21K9YiRcYU1enkVPOwyFNEcjBnw4te7IGSCJAxO6qAkCDe7rfmf4EE0jf61K4i/QDnQzwY1cEYdIlSDa3aWNb0aEIY+luBsvXtPuLXaffxUF3ZeKTEtz0Q2IRiDElNam70m9171yGUz0QVy8Ki09OZKm12ovGHYi0Auqcbo2pOw4/Z08OuEZTKhMl/xbh2ocr9vRdTk+HNfo9iDRgS4COUP/LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gaG0grzEJxalodJvD0jxXbIwXebjUCpl9Wyou4awP8=;
 b=eJB3aql5106U9dABB9yZSQjgVdo4xBwp+5M/aVr1+ZBNwKt1uhKhqjbTVKikHrdqGaD3uAKekcmCSo/yx9hPdE4O8ice7SZAuNJskvY2z0DWLjfzDiJToypGQtPm92ZnGXP37iLs3KfXx2rH5M/VHG9A6JgVikpVoQhYNv0Gcedcd0lDdxi6/f1f65nnV9ogLLKoeAOZqXDhzENWpCj+knCAjFoHAKHBpCL8ptmhWBCdRHpsZv6rhWX7i8VGPhrES7Q0dDaM0RzNW1aSCSu/sjdDh7jlCTLvB9NMimZVCNClURmFc3wNqLU4bw4WUm1Hii2T4WtqwhYXHVYVYBPFHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gaG0grzEJxalodJvD0jxXbIwXebjUCpl9Wyou4awP8=;
 b=AM9DPV3HgakIB0GX2iKlo2JnZfCJzDqnvQVxTXoBGybiNSULXgYdSOJHM2tw1B6b8r5X1yIO2NZb/LNQAKBaCAbdalXzFh/6fgNGHJW6nrNqdckwvXQJCEPJG8qqPPP3SaP4ZqGLjgur/2deQoe7K0rFo7WsnqwfWkMGS5NR2K0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB6240.namprd12.prod.outlook.com (2603:10b6:8:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.19; Mon, 23 Mar
 2026 10:11:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 10:11:23 +0000
Message-ID: <65a96159-1266-4b42-91ce-359fcd1a76ea@amd.com>
Date: Mon, 23 Mar 2026 11:11:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND RFC PATCH v3 1/6] drm/amdgpu: Change
 AMDGPU_VA_RESERVED_TRAP_SIZE to 2 PAGE_SIZE pages
To: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, stable@vger.kernel.org
References: <cover.1774239489.git.donettom@linux.ibm.com>
 <d3a5bd9b4bcff28c1c43c4c46479cd95d4dcf7f0.1774239489.git.donettom@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <d3a5bd9b4bcff28c1c43c4c46479cd95d4dcf7f0.1774239489.git.donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cdfdf6a-ee95-4f3a-eec8-08de88c48993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	9+BN2l9v/QqN2T+zcmJcSH4ul7cXLQbmGDJXjYobV/94B3PWTf5ndZ/VJcOyrtlChJuPzcaUCOXhYSZJxFwc+IsFZ0t6zKXOtaEmsHg9KQ+BQuCqM1DfB2ByF6Dlp2FTRVF+5tbiLCZ7muRFHgzdUcqbtYRjuxDRj06c62zMybaWL/Gtrew6uURYPK8sYXAu2qtMrfbJaqqE1w5LDmtzoNVkx5xLUgqF9JQ0Jf9eKp9/ZySOAiSxpUtriu0CRouIIhLcl+5fPLsTcwCnR4Z5b+Ol3VE3deeBKypwRTl0H6j9yOa3d0Qzcewc6OBplMp1g6p0kUVt0InMnDkeBO/8UxinTdslxBZZ2pVwsgwHFMh0F9nLU0thqJr5b0Sdj9cWZ/8C7mXlBA5PwZMm9zUKxokLFc7T8VVmpwXJrAKnaU0k0NdLa2UsAgcAPNAM/qq2ZNwjln81/7o+PQuhGmOwcJWs/vI6HjFQHaqn6YAFPg77rJW6TRWih9U6uhDOiSqMOB3GUWCe2B4dOGB0s2JDdCImtZ2Hrvmh+cAXMwXzk+UkyoombHlhSvTdLOjyQn8O/9gqQMMienq/5BXRnY1YHSh2e97T15L1LFO+vbk7myZ3xzJ9d4RQSFXPENYlXY9vGu5Tg7PUUqm6iAKmHeWFNhQMfaz/OU3aRLPtigkwMmboByDwFuvkTOXy8VR8JliGF9eQuXby1jxphw6CpRpxHl8MYD3irIfDx5NxmEPq7Ls=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHFqUTI3cHlFU3hWbm56RHFHY2ViUTRNemFEZDJTeDlvQTU0eXZoZ2dmeXgv?=
 =?utf-8?B?MS8zMDYrVTJnKzllY2FuMmFoTndCejlwaDJycWs3L052U2RJYVFaL1NYOHB5?=
 =?utf-8?B?VVZJUFBnOXlRVE9iT1ZuUHk1aTc0S2FCTzVJL0t6aENJN29FSUZEWm5WdWl1?=
 =?utf-8?B?ZG1kaVVHNk5VRlVUMFMvYkNXWUZ1eFJ4eitCOVZGbkE3bXBEWURJQ0FLM2sw?=
 =?utf-8?B?WFVNUVFDbWtTWWk2MkZEQzBmY0Z1SU5PY0RyQWRySVlYVE9GVFc0clJka0R4?=
 =?utf-8?B?cjFKM0VWaVpIdFFidE9rQkRGbmY3SHRjYnp5aThHS2s5Zmg1d1IydExpRnRk?=
 =?utf-8?B?RWdFZkZ4T054Ynl1ZXpoUnlwUGhnblUwajJncHF3WlF2NWhHd3AzRm8vVWN1?=
 =?utf-8?B?VERMVDBPYXZYbCtjOTMyTU9vM1kzM2NsWkROTDRRUWlHNlhsNDc0Z0pGejE0?=
 =?utf-8?B?MW1hTkVsMnhsQzJXalpTVGZFanh1SDNMbkVPOFEzdk1QQm83d3lRdEtYUHZw?=
 =?utf-8?B?V3BLYmRheXFQd3pyeDA1UzRRNUQ5OWJtSXpoRHJjaWdnbDlsTkZTaGhrVmFk?=
 =?utf-8?B?cEI3MUExdFFuQ0RjMWhYMWo4eERlUHE3VUlMRlE0RW91OVZyK3dNRkN0bENS?=
 =?utf-8?B?SEhXZzVRZnNvZXV3MEdHbG03YXpvd0VidFhFSUx4ZnhOVytVZHZNYzVRSFpp?=
 =?utf-8?B?VjZqZ3d3YzNCenVxb25yampvT2VMQlFqWUpLVEhNS2J4bC95TDNmMUZjR1pY?=
 =?utf-8?B?MWUyL0pLN1MyRkt1aEQrekVGeDl4RmpUOEwraTd4Y0lHNlYyaTdaek1vTXE5?=
 =?utf-8?B?VHkxS3A1dGVPdEhXOXhic0pFNDdRQUpPRmxHNGVrdUlWMVZnNXZoeUlSK054?=
 =?utf-8?B?SFEyNE04TU1pMllhKzFsb0lrVkloVVBOZHUvYkVIenhYaStHMXhOYS9MVC9h?=
 =?utf-8?B?RlhzWFV3RHhWOGZpUFNYVVBlOG0xbi93ZCtmajZPYjUzMnhTbEVscTBINWlI?=
 =?utf-8?B?a1A3M0xhbXJqanN3RWUzY29CeklYZkc5NlVLSzdUTERoOTAyUEVqaGJkV1hr?=
 =?utf-8?B?SXIrYnhQUkNIbVpYRnMzUkNrK280WEdXWDgzQzZ4ZC9YOHdVNzlvbmErOGwr?=
 =?utf-8?B?TUsvUlRpUFZUQzRjTnNOdG52N1pHUEh0SUp6bldZY0ZnYXpRY010MnFNUEtD?=
 =?utf-8?B?R1hGWDFHSXp5cFowc2JqR01JVDJRVGZNeG1wUHBNOWNEc0JhRzlYZk5sR2NC?=
 =?utf-8?B?UDA2cHFLcitDTGYxcWRxbWkrY1VCeXFEZkwybGNDN3E3Ky9XRlJvQjJQU1Q2?=
 =?utf-8?B?Wk44OU8ydWswdVcvNFFmVGVFYlpLSVEzMFdWdlBDM1Q3c2NPOHRWcG5Pb2Nv?=
 =?utf-8?B?UFBhWkFCY0hQakZidDRRMzBtbFIzenJyRzV4bFFpMUkrcmYzeCtDeEpaeG5i?=
 =?utf-8?B?N1dTOFVPckhtRkt1bGZwZkI5QzUycDRkaUs5Mm5ueVh1TmVmMzYvRnBCM2NX?=
 =?utf-8?B?SERuOHhGbm5PQUN5TnZaVUVqaGdxeFYyb3dPb3hYd3MySTJxZU43cWFuSGVh?=
 =?utf-8?B?Z1Y1Tzg4L2hqRC9LT3pFcXAwT3FQcm5aR0Z4eGhaRzV6L1R2MUVDb2hQQUZa?=
 =?utf-8?B?aHZRU0FrNzBPVm02S1ZObFVtOUVZVUhvc1NUbi81YkJCVTlqVExpVUFzWTho?=
 =?utf-8?B?ZmNjSzNpMWs4M1BvSTl0MzN5ZmlxVWl0d3VlR3BsU1BkSUFIYzJQQ3J5b3dq?=
 =?utf-8?B?eDNsSEpWdlNIK25kM3NLa3hmV0hPRW1zaTAva3h6S2dzZFhjdGxoQTZjMlJQ?=
 =?utf-8?B?c29ZVnB6R0VMeXN0UW9wRWt1ekt0MVN0U2Y1QzRFOVFZZGFSWEc1UVZ5SmY2?=
 =?utf-8?B?clhiZnBoVWZGK0o1VkNKOVVEalZHTHcrQmxPQ0ZQV1I0UXBTNG12cFF3RUFw?=
 =?utf-8?B?TXNtUFlVRHF1TGIyam9wZXNHYmxYbVNubks2VGtHN3VveEo2OGVrZDZETlh3?=
 =?utf-8?B?dE95enJxWmN4enJIR0JOM3BkSmtOaGlCL0pYSTdraWVqaVlzYzVKWUhEeVBh?=
 =?utf-8?B?U2FObTg1NG01Z1JaS3YybnZ0V285YzRmdUlxdEtienVUVW8vMWlGMnZlN29j?=
 =?utf-8?B?c0hqTFpnYWxKOTZ1RkE1aFRtbnZ5Z1hpOHY3Qm9LakZyazJ1MzBQWDVsUFhC?=
 =?utf-8?B?TzdZaEgveVVXS2UxV2FtTjZrTWo0YVBaQjNNSU5rZDFJL0JYeDNMMVcrN2JR?=
 =?utf-8?B?Skc0b21oaGR1c01oRUFyVWJwNDhGdm83YjlXaUFPcXlYTWVXVit0Zm1FajRJ?=
 =?utf-8?Q?fHPz686J5lKord1L8U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cdfdf6a-ee95-4f3a-eec8-08de88c48993
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 10:11:23.8015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IyER33H1V3ud+sW29zge6aXB2mm1ECUCk6WxgAe+k19BtqwIoL+od+THPesFeRgM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6240
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux.ibm.com,lists.freedesktop.org,amd.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-227944-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,linux.ibm.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:dkim,amd.com:mid]
X-Rspamd-Queue-Id: A9B2D2EFC8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 05:28, Donet Tom wrote:
> Currently, AMDGPU_VA_RESERVED_TRAP_SIZE is hardcoded to 8KB, while
> KFD_CWSR_TBA_TMA_SIZE is defined as 2 * PAGE_SIZE. On systems with
> 4K pages, both values match (8KB), so allocation and reserved space
> are consistent.
> 
> However, on 64K page-size systems, KFD_CWSR_TBA_TMA_SIZE becomes 128KB,
> while the reserved trap area remains 8KB. This mismatch causes the
> kernel to crash when running rocminfo or rccl unit tests.
> 
> Kernel attempted to read user page (2) - exploit attempt? (uid: 1001)
> BUG: Kernel NULL pointer dereference on read at 0x00000002
> Faulting instruction address: 0xc0000000002c8a64
> Oops: Kernel access of bad area, sig: 11 [#1]
> LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
> CPU: 34 UID: 1001 PID: 9379 Comm: rocminfo Tainted: G E
> 6.19.0-rc4-amdgpu-00320-gf23176405700 #56 VOLUNTARY
> Tainted: [E]=UNSIGNED_MODULE
> Hardware name: IBM,9105-42A POWER10 (architected) 0x800200 0xf000006
> of:IBM,FW1060.30 (ML1060_896) hv:phyp pSeries
> NIP:  c0000000002c8a64 LR: c00000000125dbc8 CTR: c00000000125e730
> REGS: c0000001e0957580 TRAP: 0300 Tainted: G E
> MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE> CR: 24008268
> XER: 00000036
> CFAR: c00000000125dbc4 DAR: 0000000000000002 DSISR: 40000000
> IRQMASK: 1
> GPR00: c00000000125d908 c0000001e0957820 c0000000016e8100
> c00000013d814540
> GPR04: 0000000000000002 c00000013d814550 0000000000000045
> 0000000000000000
> GPR08: c00000013444d000 c00000013d814538 c00000013d814538
> 0000000084002268
> GPR12: c00000000125e730 c000007e2ffd5f00 ffffffffffffffff
> 0000000000020000
> GPR16: 0000000000000000 0000000000000002 c00000015f653000
> 0000000000000000
> GPR20: c000000138662400 c00000013d814540 0000000000000000
> c00000013d814500
> GPR24: 0000000000000000 0000000000000002 c0000001e0957888
> c0000001e0957878
> GPR28: c00000013d814548 0000000000000000 c00000013d814540
> c0000001e0957888
> NIP [c0000000002c8a64] __mutex_add_waiter+0x24/0xc0
> LR [c00000000125dbc8] __mutex_lock.constprop.0+0x318/0xd00
> Call Trace:
> 0xc0000001e0957890 (unreliable)
> __mutex_lock.constprop.0+0x58/0xd00
> amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x6fc/0xb60 [amdgpu]
> kfd_process_alloc_gpuvm+0x54/0x1f0 [amdgpu]
> kfd_process_device_init_cwsr_dgpu+0xa4/0x1a0 [amdgpu]
> kfd_process_device_init_vm+0xd8/0x2e0 [amdgpu]
> kfd_ioctl_acquire_vm+0xd0/0x130 [amdgpu]
> kfd_ioctl+0x514/0x670 [amdgpu]
> sys_ioctl+0x134/0x180
> system_call_exception+0x114/0x300
> system_call_vectored_common+0x15c/0x2ec
> 
> This patch changes AMDGPU_VA_RESERVED_TRAP_SIZE to 2 * PAGE_SIZE,
> ensuring that the reserved trap area matches the allocation size
> across all page sizes.
> 
> cc: stable@vger.kernel.org
> Fixes: 34a1de0f7935 ("drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole")
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 139642eacdd0..a5eae49f9471 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -173,7 +173,7 @@ struct amdgpu_bo_vm;
>  #define AMDGPU_VA_RESERVED_SEQ64_SIZE		(2ULL << 20)
>  #define AMDGPU_VA_RESERVED_SEQ64_START(adev)	(AMDGPU_VA_RESERVED_CSA_START(adev) \
>  						 - AMDGPU_VA_RESERVED_SEQ64_SIZE)
> -#define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL << 12)
> +#define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL << PAGE_SHIFT)

Well using PAGE_SHIFT in amdgpu_vm.h looks quite broken to me.

That makes the GPU VA reservation depend on the CPU page size and that is clearly not something we want to have.

Where is KFD_CWSR_TBA_TMA_SIZE defined?

Regards,
Christian.

>  #define AMDGPU_VA_RESERVED_TRAP_START(adev)	(AMDGPU_VA_RESERVED_SEQ64_START(adev) \
>  						 - AMDGPU_VA_RESERVED_TRAP_SIZE)
>  #define AMDGPU_VA_RESERVED_BOTTOM		(1ULL << 16)


