Return-Path: <stable+bounces-230294-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGE+IPKsw2nAtAQAu9opvQ
	(envelope-from <stable+bounces-230294-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 10:37:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A030F322538
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 10:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B1E6306AE25
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 09:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2219533DED9;
	Wed, 25 Mar 2026 09:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pR4HB70+"
X-Original-To: stable@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010036.outbound.protection.outlook.com [40.93.198.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAE030CD92
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 09:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774431256; cv=fail; b=cEg9Z7gCO7a3nXhGugKIHiWj8ws9QDnZHIfIsU9WJNAA9nTm6kdQ7wSeDqzplc7yNIncVo+xXwDAc5MlE+RlRFojvBf4TOc3yEzJIZg7HHizD03RGfpdWHl/t6YgPvQ65mjICHpu/qILScLRO4MjGbpioJCwUrbD1jvCDQNVsFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774431256; c=relaxed/simple;
	bh=HEya1M/l5qEMRy0XUN1EBTx1uZcWFQ2vTUJwUROwQEI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K+KlLzmQ2MFDq6CVDiIpvIFN8GrNI2hKsZBbfhbK1y7Z5+PXiNlBoPP+lZRTqXDO/Gs6/GPFt+mNBoxM3m368A2m2pCiYdKaZSrKwxEuMMHfc+FVxcmycBaILkA0mWFzsU98T6Jf60gQ8sZ2KUa+6WwWTM140ZFPAL3QBHKZpXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pR4HB70+; arc=fail smtp.client-ip=40.93.198.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuhiELh7B0FiiKEQaAlm1FlK2+HDEt5scA498LoIZNYrUuyejGkRA2nbaKEZ141qbrdZdScDZCbjXE3zhXpBYqTzx+zV6HMB8V7jEqOolvnE90FqR/EUfsCvx6TL2/nflB5IdH5pctlINZvT5x/95QOyrC+gH3UqU0bcPXp91uFoDueXrbmawiMbH5bn6xQfxAT0lGs29yiZ76F43gimspYbzAEATZeaxoA0TezcgK0PBPp3MJMlUAguBJvlSo1kFa5GCJTyGIFkkGuuHok7SMBjbrb5oOZhU1he2SbUlzugD+mXP6zwxDcmYu7XueCLbneInkk/PdRa+HV0jsN7oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/51blL65All73/FHBwM/fwyg3VPQfZ2jMSXn1ZzfY8=;
 b=mrdYiDVly5zZDT9Rel4m4fLjzRFany/lyrX+CWvx5oXaHMJF7yRzQx5FiBhsPHpndlDhceKof6aihmJRtOIExfPCgPy6YfjfUnAgprim6Lo7q5t1pdpSmPpXuY4Yp/kHxngfjEZEuDxBU+ZRpuyAapXxmaYFRCF57SvO50lVL4+sS8WFm7CfuDupX9eqAWRZSgiRHUnaX02HSAPbmiXB/3qpmrsgB/Th1dL6ECBfuYeVqgXhqrryVmFYWUIPdWlXab37fHNs/ygPuceNyCCEUeonHp6WK24XtEIId7ebSRDezp4ek/MOqGsTV0oLjTcEEUd4mlIZClTLYCrk77Tz0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/51blL65All73/FHBwM/fwyg3VPQfZ2jMSXn1ZzfY8=;
 b=pR4HB70+EEh9HImPKW3wmG222hr6NAtGw1HV8zYPaLeOVkdEvT0Zd06nBO76ra22MpE1aaXxi39J7650VMTBb43bBrO28uq2chaw1Su8NKEZ7TAJNHYkWiRXG9getk0y39XW7svr0SPMTAnI4zqjeKm9VnbXpLdw5rADwHBE92A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB8315.namprd12.prod.outlook.com (2603:10b6:930:7e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Wed, 25 Mar
 2026 09:34:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 09:34:12 +0000
Message-ID: <cbbc63ba-0c21-4fd9-b701-d79356b75d12@amd.com>
Date: Wed, 25 Mar 2026 10:34:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND RFC PATCH v3 1/6] drm/amdgpu: Change
 AMDGPU_VA_RESERVED_TRAP_SIZE to 2 PAGE_SIZE pages
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
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
 <6b2d502d-08ef-4008-8399-f5630de2385c@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <6b2d502d-08ef-4008-8399-f5630de2385c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB8315:EE_
X-MS-Office365-Filtering-Correlation-Id: 572dbc0a-3e9c-407d-3211-08de8a51ac78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	e1jXo1x3D8lDV75yb3/qesDTGhoc/WhnjQ6nP12CWo1VVFY0OhNmtna9KpF1RBsj6U0AsOp+28t7ZQeWdlaolWsRj03NUIPIPt6BSrRS8OlDdpnTAgMNRayvU06o7qDRZPv87Uf8XfJITNlt9Z2Yq1WiKXHLjVttk0RTuzYLowBAqcHy7eOrtCLDP9XCHmrEKqF7+3QKYc+XnjWp5aOjib3THo9TzRIW23UAzC8+phpKJ3VisDUW+knc88YGnAc1+Vh9/2atIE4zFaodqAS0+5+G7+8tuvTwyjG0FkKBaGaYuzNcI077T2Ece71N62k3C4W8yj8sJ5F9MQXfkIdHFWWCZihLaO9YOtAAwUQrurJjwUVhdaeCAaRnc9CD90zH+H3lL7LSVR6WwRMMvPyC+mDAtgfQZSYhAInw2RrW7rKyMw8CngiiuUyb8iKxAadrxtUcGTBl8sMF/m7Ij8/VFv/dGbkYUEo0PILKx+zA9SIw4eg6FaYlYwQP+AWUryzq+0QNtPEoa02gYb0q7nRQ4mGkbtewy62+KYI/T2sJvWVstz+6neM1TlCsP3sApGj2e7AKqUxWSQwG9rq8JnXRYyoYx0pbgwV8ZPCCTn+mUSFrqHtRY1POJof6w44vyInF1XVjVZt+AzTnWSJxHa/I3IhV24S/BEdL3H+rSBY9ckhlIqlWB/bGGDeGSTwnvRx8oDedVUM1VJyCWvL80cCEF1Ku8mlak2/3jzIY/sF2pic=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXlUd0tSZDYyZ1FYNzZGM25GaCtuY1BaT21WNHBtOWRTR3B3eE90U05iRG9x?=
 =?utf-8?B?KzFFL1pkRit6eDI5TXZWTXpZYW1vRDQvY3lWeGgwNldscEtFbEVSd2x0Vjcz?=
 =?utf-8?B?L1FENDFUQUJXRXNMY1hEM0lKTTZsVHZ2dWlVdkorWmxxU2VPOWVjenAwSDNp?=
 =?utf-8?B?UmUxOVV3TnZYMWNEaUZQb1I0dWtDVTNleHdvbjVGcGJxUzhEUHdBOGt6ajRQ?=
 =?utf-8?B?TlFaRUVkZ3lEdndKNWdydE9NWnF1V1pVZWZ3dklWQWt2OThaZGI4ZWhocVNQ?=
 =?utf-8?B?ZmpLd21qVy9IcjhIR3BESkVMN2R0MTM1MStBN05RT3YzL2U0dUtUNThhS09W?=
 =?utf-8?B?QnhueXl1WXhpR201aS9MWnc4NGUvbDE4ODVsWUgxb0ZlZmEzcHBIMWU5aERt?=
 =?utf-8?B?MUhhSGlUSmk2MzRHVzhobEU2T2pwcW5DRE94T1BXSEdXU0VkMFkxdlpLZGN3?=
 =?utf-8?B?K0QwWTh6WE1wRnBNcG1MSzdoZk5zVVJXemt2Sk0zK3F3Y3FjV3c3ZmpHQWFi?=
 =?utf-8?B?RmVGejcwRWNJOU55RVpiRFVTS050OUgrUUJZUVBHbW4walRMSCs4dTRPd090?=
 =?utf-8?B?MVRnbkVHY0pEN1o3dElXV0dVSVRTVVcvNDZpeWdOZjNiSWovTGNJeFlmQzdK?=
 =?utf-8?B?WnF1MXE1RUcxakRLT21wZkNhekY3Y2RvUFd2NDhjRTJYTXVIeUpoVisydDds?=
 =?utf-8?B?RFIzNHlETGw4Y2luNDVGYjBYczFtMW1xc2h5M2ptQVYvVVRNME5LRGt6bzJW?=
 =?utf-8?B?Y3MrczNZZkI2S1dyYUlaK2o3TCsxSFdHRi9JRXM4TFM2cXBaeDFHWi9JT0hz?=
 =?utf-8?B?MlV4ZUtUNUMxZkYwZ3ZEWVFIeTdPNUZPWkxmeTQ4Wk4yUithMVM0MVRZMlRx?=
 =?utf-8?B?ektGV0NvWnZ3Y1FLWWlDQURESFlxTkFLR3dkSU1SY3lGSGZHL0RFME54ck5r?=
 =?utf-8?B?dkVjVmNkZy9CakNtbmxpb2ZxT2xRS1ZjRkhUbkx6UTdrbDcrUzRMMGZ2cHg5?=
 =?utf-8?B?NFg0eUJoc1N2TXFGbUVGNnVjNW1UU2p4MWlNSzNRUGk0bTBSS01Qb3dyeVZM?=
 =?utf-8?B?NHNRLzdkaVVnK3dHWW01Q3lHTktlOVNaOGlVN2dEWld5eXJOVVZCcGs4TFZj?=
 =?utf-8?B?UGxWV3lhZzJwN1kvY3I3UjJDbjRxWVJnR0U2MVJEQWQ4aXdUYjJucmphRXha?=
 =?utf-8?B?ZHk3ck9jeW5VbE9yOCtRUWp2Vk9HWHFNbWtMQ3VESGZKejZFQXJtaW94ZWQw?=
 =?utf-8?B?MUVLWUhxbzJ5QmQzTDdVVWp0RURBK1FJZjJSWVpjamxMcTN1MVFnVy9XZ2ZM?=
 =?utf-8?B?RGFHbEFUQkNtYmw1d2RaVjFnNW1yblI2Q0JtUXE0L2oreDc0U2hOZGZyTUxq?=
 =?utf-8?B?U3VENkltQ1MwOUFsK2VGd0pGblVvSG0rNVdHWktTODdFaGlYWXN6dkxSck91?=
 =?utf-8?B?QnVEdVFLQXBFZkNDZDl6YXppWkR4Z2Q2Wk51bjdES3ZiWlgyVFc4c2NaemNZ?=
 =?utf-8?B?ckx4TUtQRVNXbThhYStiOVNvY092b0hZY3ZodFRvU2t5Wm9OWjl5RERBcko1?=
 =?utf-8?B?aHQ5Q0x0NThxUk5XRFhHK2pOVEI5THRLVi9NME14OGZGNEtqQ2xaUmFXekpE?=
 =?utf-8?B?OFJaVlJCZ3lyYjArcjRKT05WM0Fya3ZadXd1V0ZFTEJEWTJ0OUNVOHNiQ2VQ?=
 =?utf-8?B?RXNmdVVLWXNCNkkyVU1qOTBZcGNVVkdIWVFQbDJjL2dwWGErak9CQXI4SXI3?=
 =?utf-8?B?WUVmNHI5NWtrT2NzdFY4dy9uR0orOGhCcmc2eEJvOTQzbkdLTysxWnlmNjRU?=
 =?utf-8?B?UHNlSk1mQm5nSjNxaVdHZ3FIMVg4TFllL3IxREJZNVcrclNnU2JpM0lWTFps?=
 =?utf-8?B?UFJpb2FJbVV6M1pZYWpKRTJhT0FZM1BoRldKR0VTTElHbzF1MGdNYjJhWGFx?=
 =?utf-8?B?V2ZGNzhnY3JGWEVvYktqa2U3NnJPekQxeWljQlFFakcrRDlHWGEvcCtCYVZ0?=
 =?utf-8?B?MExyQlkzdWRiRVlyekZyVXJhNUlxRGlwSGNnaElkTUo5aVNYYWZyeXd1bWtU?=
 =?utf-8?B?c0Z4VDZEM1YweU4yc0RGZGh3RHZJL3EyVDJjeFN4WjNuaGxDa2pIUDhDREdk?=
 =?utf-8?B?Rnk0dVFySFN5aHQxbHJpN2NNR2d5SWZLMmdINnY1MEl2cmpXTlhtUWxicnNv?=
 =?utf-8?B?SG9GQnRFMVlCM0FRRTJ4ZVREOWhUbTc0RkdJZ1hMSHo5OTJaNk5odExWSTk5?=
 =?utf-8?B?NHNZWmU0OWdRREpMem5JZkRwVUVzYTljSTZxcStZUFRPRnp0MGRZNm11Tmk5?=
 =?utf-8?Q?TohC9AgrW7jw3cbzgB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 572dbc0a-3e9c-407d-3211-08de8a51ac78
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 09:34:12.5305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HBFABuV7DJdZplHF+nzeG2aiH1qBwnh3UeCApLhwlhTko3iF1/8yEEEP3LGWfslR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8315
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[amd.com,linux.ibm.com,lists.freedesktop.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-230294-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:dkim,amd.com:mid]
X-Rspamd-Queue-Id: A030F322538
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/25/26 03:26, Kuehling, Felix wrote:
> 
> On 2026-03-24 14:19, Donet Tom wrote:
>>
>> On 3/23/26 6:42 PM, Christian König wrote:
>>> On 3/23/26 12:50, Donet Tom wrote:
>>>> On 3/23/26 3:41 PM, Christian König wrote:
>>>>
>>>> Hi Christian
>>>>
>>>>> On 3/23/26 05:28, Donet Tom wrote:
>>>>>> Currently, AMDGPU_VA_RESERVED_TRAP_SIZE is hardcoded to 8KB, while
>>>>>> KFD_CWSR_TBA_TMA_SIZE is defined as 2 * PAGE_SIZE. On systems with
>>>>>> 4K pages, both values match (8KB), so allocation and reserved space
>>>>>> are consistent.
>>>>>>
>>>>>> However, on 64K page-size systems, KFD_CWSR_TBA_TMA_SIZE becomes 128KB,
>>>>>> while the reserved trap area remains 8KB. This mismatch causes the
>>>>>> kernel to crash when running rocminfo or rccl unit tests.
>>>>>>
>>>>>> Kernel attempted to read user page (2) - exploit attempt? (uid: 1001)
>>>>>> BUG: Kernel NULL pointer dereference on read at 0x00000002
>>>>>> Faulting instruction address: 0xc0000000002c8a64
>>>>>> Oops: Kernel access of bad area, sig: 11 [#1]
>>>>>> LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
>>>>>> CPU: 34 UID: 1001 PID: 9379 Comm: rocminfo Tainted: G E
>>>>>> 6.19.0-rc4-amdgpu-00320-gf23176405700 #56 VOLUNTARY
>>>>>> Tainted: [E]=UNSIGNED_MODULE
>>>>>> Hardware name: IBM,9105-42A POWER10 (architected) 0x800200 0xf000006
>>>>>> of:IBM,FW1060.30 (ML1060_896) hv:phyp pSeries
>>>>>> NIP:  c0000000002c8a64 LR: c00000000125dbc8 CTR: c00000000125e730
>>>>>> REGS: c0000001e0957580 TRAP: 0300 Tainted: G E
>>>>>> MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE> CR: 24008268
>>>>>> XER: 00000036
>>>>>> CFAR: c00000000125dbc4 DAR: 0000000000000002 DSISR: 40000000
>>>>>> IRQMASK: 1
>>>>>> GPR00: c00000000125d908 c0000001e0957820 c0000000016e8100
>>>>>> c00000013d814540
>>>>>> GPR04: 0000000000000002 c00000013d814550 0000000000000045
>>>>>> 0000000000000000
>>>>>> GPR08: c00000013444d000 c00000013d814538 c00000013d814538
>>>>>> 0000000084002268
>>>>>> GPR12: c00000000125e730 c000007e2ffd5f00 ffffffffffffffff
>>>>>> 0000000000020000
>>>>>> GPR16: 0000000000000000 0000000000000002 c00000015f653000
>>>>>> 0000000000000000
>>>>>> GPR20: c000000138662400 c00000013d814540 0000000000000000
>>>>>> c00000013d814500
>>>>>> GPR24: 0000000000000000 0000000000000002 c0000001e0957888
>>>>>> c0000001e0957878
>>>>>> GPR28: c00000013d814548 0000000000000000 c00000013d814540
>>>>>> c0000001e0957888
>>>>>> NIP [c0000000002c8a64] __mutex_add_waiter+0x24/0xc0
>>>>>> LR [c00000000125dbc8] __mutex_lock.constprop.0+0x318/0xd00
>>>>>> Call Trace:
>>>>>> 0xc0000001e0957890 (unreliable)
>>>>>> __mutex_lock.constprop.0+0x58/0xd00
>>>>>> amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x6fc/0xb60 [amdgpu]
>>>>>> kfd_process_alloc_gpuvm+0x54/0x1f0 [amdgpu]
>>>>>> kfd_process_device_init_cwsr_dgpu+0xa4/0x1a0 [amdgpu]
>>>>>> kfd_process_device_init_vm+0xd8/0x2e0 [amdgpu]
>>>>>> kfd_ioctl_acquire_vm+0xd0/0x130 [amdgpu]
>>>>>> kfd_ioctl+0x514/0x670 [amdgpu]
>>>>>> sys_ioctl+0x134/0x180
>>>>>> system_call_exception+0x114/0x300
>>>>>> system_call_vectored_common+0x15c/0x2ec
>>>>>>
>>>>>> This patch changes AMDGPU_VA_RESERVED_TRAP_SIZE to 2 * PAGE_SIZE,
>>>>>> ensuring that the reserved trap area matches the allocation size
>>>>>> across all page sizes.
>>>>>>
>>>>>> cc: stable@vger.kernel.org
>>>>>> Fixes: 34a1de0f7935 ("drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole")
>>>>>> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>>>>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
>>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>> index 139642eacdd0..a5eae49f9471 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>> @@ -173,7 +173,7 @@ struct amdgpu_bo_vm;
>>>>>>   #define AMDGPU_VA_RESERVED_SEQ64_SIZE        (2ULL << 20)
>>>>>>   #define AMDGPU_VA_RESERVED_SEQ64_START(adev) (AMDGPU_VA_RESERVED_CSA_START(adev) \
>>>>>>                            - AMDGPU_VA_RESERVED_SEQ64_SIZE)
>>>>>> -#define AMDGPU_VA_RESERVED_TRAP_SIZE        (2ULL << 12)
>>>>>> +#define AMDGPU_VA_RESERVED_TRAP_SIZE        (2ULL << PAGE_SHIFT)
>>>>> Well using PAGE_SHIFT in amdgpu_vm.h looks quite broken to me.
>>>>>
>>>>> That makes the GPU VA reservation depend on the CPU page size and that is clearly not something we want to have.
>>>>>
>>>>> Where is KFD_CWSR_TBA_TMA_SIZE defined?
>>>>>
>>>> Thanks Christian for reviewing this patch.
>>>>
>>>> It is defined in kfd_priv.h.
>>>>
>>>> /*
>>>>   * Size of the per-process TBA+TMA buffer: 2 pages
>>>>   *
>>>>   * The first chunk is the TBA used for the CWSR ISA code. The second
>>>>   * chunk is used as TMA for user-mode trap handler setup in daisy-chain mode.
>>>>   */
>>>> #define KFD_CWSR_TBA_TMA_SIZE (PAGE_SIZE * 2)
>>>>
>>>>
>>>>
>>>> Could you please suggest the correct way to fix this issue?
>>> I'm only looking from the POV of the VM code on this, but my educated guess is that KFD_CWSR_TBA_TMA_SIZE should be 8k independent of the CPU page size.
>>>
>>> Background is that this is written by the shader trap handler and that byte code doesn't care what CPU architecture you have.
>>>
>>> But I think only the engineers working on that trap handler can really answer this. @Felix / @Philip?
>>
>>
>> Hi @christian @Felix @Philip
>>
>> To remove the dependency on CPU page size, can we use
>>
>> +#define AMDGPU_VA_RESERVED_TRAP_SIZE    (2ULL << 16)
>>
>> During reservation, we reserve 128 bytes, but during
>> allocation, we use 2 * PAGE_SIZE.
> 
> We only need two GPU pages here. I think what Christian is objecting to is, that the GPU VM layout should not depend on the CPU page size.

Yes, exactly that was my concern.

> @Christian, it sounds like the BO allocations happen with 64KB granularity, but the mapping is still using 4KB granularity. Is the right solution to GPU-map only the first 8KB of the trap handler BO to keep the layout the same across CPU architectures?

Well that would work technically, but I agree that it also sounds a bit questionable as well.

> I guess then the "correct" solution would be to change amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu and amdgpu_amdkfd_gpuvm_map_memory_to_gpu to support mapping of the requested size with GPU page size granularity regardless of the CPU page size. But that would increase complexity for a very niche uses case.
> 
> An easier solution would be to PAGE_ALIGN 8KB to the system page size. But that results in the virtual address space layout to depend on the system page size.

Yeah, that dependency is certainly undesirable. We could easily end up with issues which can only be reproduced on systems with 64k page size.

> If that's objectionable, then the next best solution is to round up the trap handler size to 64KB byte unconditionally, so its the same with 4KB or 64KB system page size. But that would mean unnecessarily wasting a little memory per process/GPU on x86.

How about we always reserve 64KiB address space (or maybe even more, if you reserve 2MiB or 64KiB doesn't matter), but only map as large as the allocated buffer actually is?

I think that this would be my preferred solution.

Regards,
Christian.

> 
> Regards,
>   Felix
> 
> 
>>
>>
>> -Donet
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>> -Donet
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>   #define AMDGPU_VA_RESERVED_TRAP_START(adev) (AMDGPU_VA_RESERVED_SEQ64_START(adev) \
>>>>>>                            - AMDGPU_VA_RESERVED_TRAP_SIZE)
>>>>>>   #define AMDGPU_VA_RESERVED_BOTTOM        (1ULL << 16)


