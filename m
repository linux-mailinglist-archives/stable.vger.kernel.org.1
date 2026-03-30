Return-Path: <stable+bounces-231219-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAZ3LNV3ymnk9AUAu9opvQ
	(envelope-from <stable+bounces-231219-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 15:17:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3373F35BC85
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 15:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8A9B309D9EB
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A613CFF5C;
	Mon, 30 Mar 2026 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="daLfcu2J"
X-Original-To: stable@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012038.outbound.protection.outlook.com [40.107.200.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C8C3D3486
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876263; cv=fail; b=aErLJRmlWjRQDSDDstt42yHYNSNwkBYnRYhlmwEEyBfxeVZCuCwPIx0Hh0z+tllgIgndA7l4cMk7yla3SDP5nx/5hpLfXsnt2ZR9gDi05srrzuw0ksm3uSxVEPptUO4wGg2iJHfpGQb41R6e0tFHoaTmSJkIZ+d/K3uEs/y+EZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876263; c=relaxed/simple;
	bh=EksIQ4yf2rIbhVVj5K8T/iC/SIxXo9atlQ1XKdZEPqc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E67C3nIctTCHlV9ivx++ovf4D1GeStliDEL7k7VBqckugQ2WuwdNE+tuyrRgy4qTQdkXZqrQR4PdHO8c5/OvYth/0FPIU3c+jKV1/bPVvau2MP1oMD6UwpI8R0spyWT8M5VKcjoa3XAcWOpn7oCvTlF35JlfnXyGx0jFUUyfOL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=daLfcu2J; arc=fail smtp.client-ip=40.107.200.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMgPwN/ijbwEQfkjRVKme/ny6IEAWqw3jPugzM16nKcPAyp16sCJLfpVfoXiXVLSzTkemh7IShhPQAe3vXEx1ZTLX2piZJDpF6ozcGEoJFKZV8Ma/f5r85jhmQry/Pe21GzxdbvB3ZvmGRgPS0c/pazf3mnn8nes4hiVrpPTBqrT8eUNdKJfFPHgjiCilsNogdKmI2osmk8q0bX5h11+BPpwNZANNQvInjYoEwC5/f3fErMi/Fm2YfUFO+tEl1t+flFFfLnWN1QeJaq7d/aVdZfakH358SqE1iOLZCkywUtJy0jNMUEv9eMJ028YLCtrEIdjmB/rkzmrs8J/g+LQkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/ajkAHD1LhK+MgwVqdY+R3b3QTHxedvWVW6Utq3T+o=;
 b=cQHb2RrwLr9ylPbjZ2l/hjc/6QfH2JkfY+f2PRIyF7vNRza1FFePM2WXPua4IV7H2lOlp4ITyZwyMPMAS1IapQMd2yS2dZ3+ZRjJSoIPrfQnLSUHEnYdY14t9ppUFhoNv9BCHVA9N3TcYjFyNRX/KJCT1w02icbmdROdKaWS1OMQaeCAx75hUFFk2v8YF87Wd2siLATtbcj7cWOT2cSa9iDSjkSxQ0vLB02cZlHBxWfmE6vJnqeA8WHZqceDl3AGYEKL2gS5kCzbNDRDI71n4FHd36SHKm9j81IdC74XR9WGXHkKCeFE7Yz+sNU/wdFpWKe3vzRfHft/KwuU7zKQ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/ajkAHD1LhK+MgwVqdY+R3b3QTHxedvWVW6Utq3T+o=;
 b=daLfcu2JM1DHOsQA8jDaBjjGeM2FuXVtn9PAmClk3hxjiR/wckVJpykbYs02iCPHwmohc8LwXBoEX+ONYe7YZRjDjvyWlFVdZzQSATYYO8pG+AVvlkaIwrcR9f21lCE2k5O4tpVsf0z8eCKKBi2DM3M9wA2QKKSE7kBj/hYyqiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM3PR12MB9325.namprd12.prod.outlook.com (2603:10b6:0:46::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 13:10:54 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 13:10:54 +0000
Message-ID: <ae7d940e-3b80-4120-8b6d-375514406558@amd.com>
Date: Mon, 30 Mar 2026 18:40:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: replace PASID IDR with XArray
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Eric Huang <jinhuieric.huang@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
References: <20260330113501.25654-1-mikhail.v.gavrilov@gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260330113501.25654-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DM3PR12MB9325:EE_
X-MS-Office365-Filtering-Correlation-Id: b8723b32-20f8-48a8-b073-08de8e5dc648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|13003099007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OLdpgsAuqVuRJR4ayI01tLuAGfbAw+1Cwp9d31YIzL9mC5tvvnc+/ppBDyleaj6rbLtYu4In+YMuzL2zqy9SgfoxqIxOHqYxf5Vmkw47nC1W2RHgxW1FsogACTRTh8QHgMmquwNP274iFvnd+UsbLPM9CWCsVu1wplaqHSLsTesEELCKEZ01lgaJk9IgR1XwX3c0ZMxnabvVmiSuguTF/044MayGhT8sHjEqBAU6M7StDmwQYAqYxGOTuvLEW6mDmsf9GiBo8be/5sk6rkuulGwVXHGB5qReScCEUMXan6B4xMyKusK7MQnyAu668oWCPOplxYyUpCZDvYDfScWrG/Eq+bjmiWAzom65a8iOaucrfXWZoFwXaNvEvaLXpD4s/8vRS/SxzTMwqh0nthhR19N8XMRLwA1ODUDqBrdl6oS7+NgJqLeZULaUAj2UPZ/GaS4ym5FrH0IBZ749Edd29pASGY9pP9vYi1gHcIeUs2ZnWNhsuUEmXptHA47YMM3CpOvGlUt6mp35S6ho28SoJ9StS8dbbGXe3uHVloMaafoHS9oxh3/Oj/biNMPDiQLFhZrFYWiGDZ0zPfOwhFylLGm4AOU2XltsJzRAx+Vk5U9lkaRBitxnyqGnlIVuPzP5mhJmLSyaaRmCYK6FQExtHr6wns7Y7VouLO5MBbyfWW3jVRqCFM0e42PZOUL9F8t5Wy3OaGo6WSOK1Fbt44EVz+rLY//6mqqfFAE6YfJRbG0i3DsqV3LASVnCN9+Xgx8g
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB7091.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXZwUnZuVU5TTUdDQjlFTkJYWVkyVVNhbkVPL3BBK1pBRDJIcDlsMDJhNmIz?=
 =?utf-8?B?NXdwNjZVcnh3eWsyOUtyRm1xMzlGNDJQUENnRGlFZ3hsZGxDTHRqRXc4eC9t?=
 =?utf-8?B?Vk95VUNra0FEYmpNMXJpNk9kZFBRak1GS0JpZ3Z4UkdEVHdURDVCdlRadTJp?=
 =?utf-8?B?TUR4SXFzV3ZTbnByak5xV3czNjMyb1U1UXIrcUpzL0c1b0d5ZjJHVFFCek5j?=
 =?utf-8?B?VDNyQlRPcEF1aTBtS1p6Lzg5RS9rZi9SL3ltdVp3OTRERGlHaVh5N09rLyta?=
 =?utf-8?B?TXEvMG9CRHdzSGJ3ZFI1L0d1Q3lKV0xWVHR3TS9kNW5nb1d5amFUWlFOQTIx?=
 =?utf-8?B?V2YvMUJkMlhCVi9tVFQ3NjVUNE5YaEpvVlhjdmNJMUhrelFFaWNUaFh5citS?=
 =?utf-8?B?a3Vya3dNTHF0a2ttWmx5ek55Qk5ZMFlvSVNkeml3YnJvRHRSakFpbkxYd3hl?=
 =?utf-8?B?TG4vQTdVcFF5N2JKdVc1WktlS3BGakRJbnlYZnZ5YmZVMWtyZWRKdWdlYUVK?=
 =?utf-8?B?Z2VPVUwvR0l1R3BYbFVGZ1RVVEsyWHVGS3dCWmFhR0NhSGRmN0Y0Q240TWtL?=
 =?utf-8?B?OEpHaHVGNjBHZXpXeDZWSVI5c0FXQXZFczFuZFJiOW9hNW5hL2dNVjdEMU1J?=
 =?utf-8?B?MFBobE9OaWVxcFBKTERRVGZNT1NGM0xtVFMwMGRvc0UxUFg0QThUQ3hGUEI0?=
 =?utf-8?B?NWhXUUFBcWJZVW1ka29YQ1B6M0c2WFgwYVM5OXJUbGh2cCtSZTRoUlJxTkd2?=
 =?utf-8?B?SGsrRHdrNlB3VGh4NVZtc2lpbE5PQmxFSzZJZE9mOENwWDB6WW9zS1N4cDRO?=
 =?utf-8?B?N2tSbnNCSjNPcHkrNTZFeUZYZTJWdmtERk9URXFwVXE3VTM1eHdleC9WVlBz?=
 =?utf-8?B?UCtLNFBzVUgvb1dLa0xZWnVSZ0NxU1RoaTV0WDZTY3dYaDNqbWI2UFAyS0Uz?=
 =?utf-8?B?cjF0S3VtWHVodTFmVjlTaWh6cFpRVkxxUjJEZWVUWGRDUnNLVEprRm14NUs3?=
 =?utf-8?B?Mm5DMWxuM3BRTjdwT2dFYSsrQWw5SnNvaE93OWJtZG5MV3R4ejhqM05tMnZV?=
 =?utf-8?B?T1BvL21mQ3hzRFlmYnNTWWpTNHYwaHJGcGU4ZTBIbkxxRlRqOE9hSnNLcno1?=
 =?utf-8?B?ajdWTjlXeFV6c0hCemVtU3V0OTg1bk4wWFpBdmRCcld6SncrUXh3K3dHT1Ew?=
 =?utf-8?B?b1hOQ0JyYTUwdDV0a0R5SXJadWNCUTJtaGViZ05lbWVRTDJOYk5iaThxWUwr?=
 =?utf-8?B?VVFmbTltMmZBZDNzMldtQkJSSkxkczNYa01Nbk5KM2NUKzBoT0szSTBlUjA0?=
 =?utf-8?B?bENHekJUNThORSs5V2hlRm9tTWQ0WXRZVi94UnZjS253RzZrTTdvK0x0RnJX?=
 =?utf-8?B?aUs2eG5VZ3FCOG1QN2l3Q2QycGo1UEw5eDllK2Zzb0hiQ3JBRGtoK3YwWTdN?=
 =?utf-8?B?WWVrVmNkcmYwTWpMZU9HZDJJQlRjVnZZamd2bmd0L3dENUk3MFk1Z2JOZWpt?=
 =?utf-8?B?eHJ6bEZCRGJtYXBrR1V0bm1lNVBncy9FaS9iWVVSSlFFb1N4ODhDZjhNc2NG?=
 =?utf-8?B?Si9kdjgrQk9ocjZKYkxIZDNBUE9rb1kvMXhvY3VKdERmSkYwUlZhWkhwRXpk?=
 =?utf-8?B?MmpvUmJFN1gva3ZTRE1OUHNSY0k1SlFrSVgweWtvTkZlZkw2UDRLVlVneTh3?=
 =?utf-8?B?bzNJR2V2S3pVenJYbFR5emZIVlZtRWxpaTlrSHk1Y3FJbmNIcnpxbGhsTHM0?=
 =?utf-8?B?ZUJiN2lMeXdlTjN3cmxIdlF0eUdzaEZkcTVVeXVMNHJuZHhDNXNrSjNpc3FL?=
 =?utf-8?B?UzJscXl4UFhDS2xFc3lUSDF0M3d0cEVMS1RhdEpvS1dpeFUxUEZjTElvcmpK?=
 =?utf-8?B?NEhDdUZIOVdMTW1SbEZ2Z1Z1SjhWL2hzSkJOVkJUNm85OGo4Ym4vTGhjeWlW?=
 =?utf-8?B?dFYzLzVyN1dRSGthdnBFQXVxQU1KazgyS2FYaHJDVzNkTis4aG54MVRHQWNj?=
 =?utf-8?B?WTdBdjdOUElFcHMrQlVQTENZR1RXUEp0elIyRXNVWjlxVml2aVdBdTkrdk9q?=
 =?utf-8?B?cnNlcUE2a3FJdVIwbE1aVG1PTVBVZXZzY2VWWlFPM1F1UHp5YWI5cmxiOXNI?=
 =?utf-8?B?d2JCSGpUdXdZNjNqQXd3SWJYSFhpdU1PRkx4QlZzeWEzVTBNMnlwTEJZTHNX?=
 =?utf-8?B?MDNZb0M5S1ZGc0NqRTZEczhod2hHZVk4clNRditxc3liOTV4bFVjU3dvRWdO?=
 =?utf-8?B?dGY1bHJOM0ZyZjlmMFQrOFp1R0NsSDhXdHdsMml3blNyeEtZNm1RVmFsRVlO?=
 =?utf-8?B?Um1sYjFON1dLYytndFVaOUJMaTFDaXBCYXN5L0RieEZkSGRJK2hiZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8723b32-20f8-48a8-b073-08de8e5dc648
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 13:10:54.4600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWFBkEn4l75jxAMaRSmjlgNYgFQyMBUBIvwNFnLDNjA7W5ufgM2MFCA2QS8YlW4B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9325
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,amd.com];
	TAGGED_FROM(0.00)[bounces-231219-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lijo.lazar@amd.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3373F35BC85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 30-Mar-26 5:05 PM, Mikhail Gavrilov wrote:
> Commit 8f1de51f49be ("drm/amdgpu: prevent immediate PASID reuse case")
> converted the global PASID allocator from IDA to IDR with a spinlock
> for cyclic allocation, but introduced two locking bugs:
> 
> 1) idr_alloc_cyclic() is called with GFP_KERNEL under spin_lock(),
>     which can sleep.
> 
> 2) amdgpu_pasid_free() can be called from hardirq context via the
>     fence signal path (amdgpu_pasid_free_cb), but the lock is taken
>     with plain spin_lock() in process context, creating a potential
>     deadlock:
> 
>       CPU0
>       ----
>       spin_lock(&amdgpu_pasid_idr_lock)   // process context, IRQs on
>       <Interrupt>
>         spin_lock(&amdgpu_pasid_idr_lock) // deadlock
> 
>     The hardirq call chain is:
> 
>       sdma_v6_0_process_trap_irq
>        -> amdgpu_fence_process
>         -> dma_fence_signal
>          -> drm_sched_job_done
>           -> dma_fence_signal
>            -> amdgpu_pasid_free_cb
>             -> amdgpu_pasid_free
> 
>     This was observed on an RX 7900 XTX when exiting a Vulkan game
>     running under Proton/Wine, which triggers the fence callback path
>     during VM teardown.
> 
> Replace the IDR + spinlock with an XArray, which provides built-in
> cyclic allocation (__xa_alloc_cyclic) and fine-grained IRQ-safe
> locking (xa_lock_irqsave).  This fixes both bugs in a single,
> cleaner conversion.
> 
> Suggested-by: Lazar, Lijo <lijo.lazar@amd.com>
> Fixes: 8f1de51f49be ("drm/amdgpu: prevent immediate PASID reuse case")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> ---
> 
> v3: Replace IDR with XArray instead of fixing the spinlock, as
>      suggested by Lijo Lazar.
>      https://lore.kernel.org/all/20260330053025.19203-1-mikhail.v.gavrilov@gmail.com/
> v2: Added second patch fixing the {HARDIRQ-ON-W} -> {IN-HARDIRQ-W}
>      lock inconsistency (spin_lock -> spin_lock_irqsave).
>      https://lore.kernel.org/all/20260330053025.19203-1-mikhail.v.gavrilov@gmail.com/
> v1: Fixed sleeping-under-spinlock (idr_alloc_cyclic with GFP_KERNEL)
>      using idr_preload/GFP_NOWAIT.
>      https://lore.kernel.org/all/20260328213900.19255-1-mikhail.v.gavrilov@gmail.com/
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 50 +++++++++++++------------
>   1 file changed, 27 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index d88523568b62..1e660fbc42ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -22,7 +22,7 @@
>    */
>   #include "amdgpu_ids.h"
>   
> -#include <linux/idr.h>
> +#include <linux/xarray.h>
>   #include <linux/dma-fence-array.h>
>   
>   
> @@ -35,13 +35,13 @@
>    * PASIDs are global address space identifiers that can be shared
>    * between the GPU, an IOMMU and the driver. VMs on different devices
>    * may use the same PASID if they share the same address
> - * space. Therefore PASIDs are allocated using IDR cyclic allocator
> - * (similar to kernel PID allocation) which naturally delays reuse.
> - * VMs are looked up from the PASID per amdgpu_device.
> + * space. Therefore PASIDs are allocated using an XArray cyclic
> + * allocator (similar to kernel PID allocation) which naturally delays
> + * reuse. VMs are looked up from the PASID per amdgpu_device.
>    */
>   
> -static DEFINE_IDR(amdgpu_pasid_idr);
> -static DEFINE_SPINLOCK(amdgpu_pasid_idr_lock);
> +static DEFINE_XARRAY_ALLOC(amdgpu_pasid_xa);
> +static u32 amdgpu_pasid_xa_next;
>   
>   /* Helper to free pasid from a fence callback */
>   struct amdgpu_pasid_cb {
> @@ -53,8 +53,7 @@ struct amdgpu_pasid_cb {
>    * amdgpu_pasid_alloc - Allocate a PASID
>    * @bits: Maximum width of the PASID in bits, must be at least 1
>    *
> - * Uses kernel's IDR cyclic allocator (same as PID allocation).
> - * Allocates sequentially with automatic wrap-around.
> + * Uses XArray cyclic allocator for sequential allocation with wrap-around.
>    *
>    * Returns a positive integer on success. Returns %-EINVAL if bits==0.
>    * Returns %-ENOSPC if no PASID was available. Returns %-ENOMEM on
> @@ -62,20 +61,25 @@ struct amdgpu_pasid_cb {
>    */
>   int amdgpu_pasid_alloc(unsigned int bits)
>   {
> -	int pasid;
> +	unsigned long flags;
> +	u32 pasid;
> +	int r;
>   
>   	if (bits == 0)
>   		return -EINVAL;
>   
> -	spin_lock(&amdgpu_pasid_idr_lock);
> -	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
> -				 1U << bits, GFP_KERNEL);
> -	spin_unlock(&amdgpu_pasid_idr_lock);
> +	xa_lock_irqsave(&amdgpu_pasid_xa, flags);
> +	r = __xa_alloc_cyclic(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
> +			      XA_LIMIT(1, (1U << bits) - 1),
> +			      &amdgpu_pasid_xa_next, GFP_ATOMIC);
> +	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);

I think xarray takes care of GFP_KERNEL alloc (not to do it under 
spinlock). The regular xa_alloc_cyclic with GFP_KERNEL may be good 
enough. This may not be required.

Thanks,
Lijo

>   
> -	if (pasid >= 0)
> +	if (r >= 0) {
>   		trace_amdgpu_pasid_allocated(pasid);
> +		return pasid;
> +	}
>   
> -	return pasid;
> +	return r;
>   }
>   
>   /**
> @@ -84,11 +88,13 @@ int amdgpu_pasid_alloc(unsigned int bits)
>    */
>   void amdgpu_pasid_free(u32 pasid)
>   {
> +	unsigned long flags;
> +
>   	trace_amdgpu_pasid_freed(pasid);
>   
> -	spin_lock(&amdgpu_pasid_idr_lock);
> -	idr_remove(&amdgpu_pasid_idr, pasid);
> -	spin_unlock(&amdgpu_pasid_idr_lock);
> +	xa_lock_irqsave(&amdgpu_pasid_xa, flags);
> +	__xa_erase(&amdgpu_pasid_xa, pasid);
> +	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
>   }
>   
>   static void amdgpu_pasid_free_cb(struct dma_fence *fence,
> @@ -625,13 +631,11 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
>   }
>   
>   /**
> - * amdgpu_pasid_mgr_cleanup - cleanup PASID manager
> + * amdgpu_pasid_mgr_cleanup - Cleanup PASID manager
>    *
> - * Cleanup the IDR allocator.
> + * Free all internal data structures of the XArray allocator.
>    */
>   void amdgpu_pasid_mgr_cleanup(void)
>   {
> -	spin_lock(&amdgpu_pasid_idr_lock);
> -	idr_destroy(&amdgpu_pasid_idr);
> -	spin_unlock(&amdgpu_pasid_idr_lock);
> +	xa_destroy(&amdgpu_pasid_xa);
>   }


