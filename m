Return-Path: <stable+bounces-241422-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OVDNOam72mpDgEAu9opvQ
	(envelope-from <stable+bounces-241422-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 20:11:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F3F47846D
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 20:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FA4F3016519
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1F13E8C5E;
	Mon, 27 Apr 2026 18:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AYCn+nWN"
X-Original-To: stable@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C23F3CF042
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 18:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777313052; cv=fail; b=aSr64+FE21mCo0EVwSWWiAyt8VetA5LxKKh4XxK5RhZsDI/ep5Gn/biO8DYfg9UGP/LDyo7FvRbuZWoJGhF8parupP1WMQhfHrbDxnW2FOX869Cw8tDVm6JM2dulXaPYHf+WGK93E7Y3jntSm1SrdpaQ/j2U80Pnha9RcZaPq2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777313052; c=relaxed/simple;
	bh=GANMdN6krGnwpi4f6BK0/GanQCf7kTP+siBng4AUBgs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PBkCkZXoa5lwBneHEa9Q+duvAuUA11YFU0N8fR6IK16ZNL9SmSj3M+BQ0T51MoU+3t0aUBuoe5INmCtgajYx5VhSk75Zvsi+INFo9dLrNxdLerUMxItmPM+22HxuvUE4aenOpjLv3zHN29ONx43pu00+yELrmS/3YON5o58z2c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AYCn+nWN; arc=fail smtp.client-ip=52.101.53.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7Ve6cn5+0rLoRdQUsQ4bT0/7uwEHLYCPBCDz1Ww0gnFKA5R3r1Ujqeoj2l9OC27lgRFeTt+0WXGts/moTAzaDZhEydXLEFr4XKa21k1Si65N6KURPbsuBvPSOC79OQ2Lbok237MdXfD635jw0LAySXsly8NaDev468Pzux1dgAxTnRMzz5eG8DWmOQQq8eQShWRgF/Pj8H8W3vNvRQ6Vqj/Ol9lcw9ZixEI72xOEpE3UWg9buXOtOoSdvgqaeOmtEJH00qW/m5RmNfo1WPuwDeUjH5VjQbCQTPaFs7G2MddKFP7y0n5LPfwjd3WtSH65X7p4Tj1kX2FBuTWmk125Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrveIHoVOJCIXGA7h9x/cEDycbIEUgqeoM1R2VNSYK0=;
 b=SwuXNLI1EJZuqWtn5F2y8OJjYVdsEXb9ebatpxYet5XGU4I5uFhGUIoOPIOEElPyXWkuHVg3/5B5tuU8LD/nt73zpRRM97GKsr9s0Vu/6Sl4McHVrZ6W8TSSo6WJOEgxGvW2y4s6rIy0d+YPWSbaFco6n3uFN7bqJXb+Sb9W0C2qL/55UWUiEF6/AL0GNFO+xXKRUBomaHHsLHBRA1vjjL+ezELIuDHX/yNmW1dapIs+c2zCm+12Fty9vBNmFfye9NNAcXl88W0eVdJeDLzV8WrkzHHOaHh8PUHXUYPGvuZeIydR7nDu0gfyPzwViA2+0z/B+MB/P4kD6FbiRMiJaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrveIHoVOJCIXGA7h9x/cEDycbIEUgqeoM1R2VNSYK0=;
 b=AYCn+nWNMT+RkDwDpeAB4XQzoqZ6F1rWQFqkMt+o0C32VTuduCrOBWrZOzEEc2i8eEypLrBRHb0V0B7My9GMkPq3ECBgNA+tMiayPTrPFM4xinMfhHC7dn+OV8DN/RPPdNTKcIwbfxFpPL/2V+6T8Im+pfjiL0ezK/kSt4dnEd4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4094.namprd12.prod.outlook.com (2603:10b6:208:15f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 18:04:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 18:04:03 +0000
Message-ID: <1ef2ea5e-9da0-404e-8cec-16d75ef1daa9@amd.com>
Date: Mon, 27 Apr 2026 20:03:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] drm/amdgpu: do not pass AMDGPU_FENCE_FLAG_64BIT to
 media rings
To: jbmoore <jbmoore61@gmail.com>, alexander.deucher@amd.com
Cc: stable@vger.kernel.org
References: <20260427163024.13512-1-jbmoore@nooks.dev>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260427163024.13512-1-jbmoore@nooks.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4094:EE_
X-MS-Office365-Filtering-Correlation-Id: b65dc072-528e-4193-6bc8-08dea4875d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vHt96KtK4vv3U/NlX2vAHnpEUwvTHV2qUia5GnfTuLznwOm/rdjC9vfdvpx5h9DhuG1cgAdTd8akjk/IKPwj4CovZ8xAUS384YXY2QZdERIxDhYB1ez+9StBMh8BBILmwGDhreHxInTm5jgGoN8i+EKDTOTq1+9eOm/k+kX8OU1r16ha+4w7uGI7rReS4BvRKxsRmp9Z4ijOpzWbU44/NMk9cXwilILutzYjIdalqKtPjUvMZk5CA2jmI/CHxrHcZF9L/aJf4/qtgXUj4kFFEhs8XkKIE+sJwArLU4UuCeY3lSGfRnmdvzr1m9W2YVXPdraiwfFuzXMXnmcnj5oesUXBtJCnj/z9RIf2fNObbk9TIk1oTOPN2a9HW2sw+WqffgQVUoBmkOzG0Q/8va7VqiS4FpxCak0z383DPQnnLOkacb89DoEWB51SsGWPJmqJLYu/TcgU7jrojKeCY7/npzlY1+dKn8075Hr+qyPt+GwP4kKH1+FxB3iP/pTZFh+yJyW3apB2Bz8AaL2VMa7y/ToHjvNTO+JsE5CIsuJZEitOpEzJ9Xw33fHHd9WrzGVwn70mdPgFCVwaU7/MOe9fVEyxcrUA8hvelyDUt8yo+z8aDcI9kjF4YQX8WXLy8kEWG1oaBRiU6C3cLwWeJWmJTTozSn1HHC/rs6rToJIqIwGxPN3r+2LD5m8AbpCzwxDsepP9Q026PacjZiJ5xiPaA9JdwDLSTNDJyUFDSoBKf9U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGhVRWl2SUJHQzZvUHUwUDR6MlU5UGxTUWl6d1ExTjZDY2lIV0oxK3NQRVpz?=
 =?utf-8?B?aklHK3RmeHR6Ym5rWG1OLzIyR2ZjNlZoakM3TGNPMFhFRmVybkgzaDlpRkdZ?=
 =?utf-8?B?clZuTG5ZeWZ1bnVUSmQ4U2dxckFiK0lxM2JGLzIxeG15eVZ3R3A2UTUrMWxq?=
 =?utf-8?B?OWljaVAyTEc1NlJpSkJaR0NkNncrb25iWG1tUnBmVVVHY29BMWFPci9OekZX?=
 =?utf-8?B?WmpuSTB1dzV0azJ6aE5KU29udHM0ZmpWTUt6WGMxM255Q0VzYjg1RjRENThE?=
 =?utf-8?B?WU56aGg2c2w0KzdnbzlhZ2M0Si9GVmlhMUUyZGFWUG1DUVVWUDU0UXNNY29z?=
 =?utf-8?B?QmR4b3Y1NGMraXUyUEo3MzEvcE1ITlRBOCt5QlBPTHRtWWYybjA3VmRrYmU4?=
 =?utf-8?B?NEVMTXp0eXNydjFvbUJlU3I3VnI5S2NZaG5ScUNPOVdWN1dmZ1VZNVhIdFNH?=
 =?utf-8?B?UUw4bWRHYUZwVE1iQitSOHNQTWRMY2ZGL0RhbHJCTVJIVjFiWURNS21sQ0pC?=
 =?utf-8?B?M01lN2ZnbHZ4eUVTeXFtTnFyek9vK0ZBNVFOd0hOOTdnQ2xGWWRCTVFKUWdH?=
 =?utf-8?B?QzZQdGdTNlZHMDlTWFdjYVpWUXhUS0kwcE9zMDhGbFJrdk11M1VYWXo1WUZz?=
 =?utf-8?B?SjMwZXFYNmV1TU5FMkdMRnJRbThGeHoySWpTU0JwaC9YR29EaU5id1hlaS9O?=
 =?utf-8?B?N3VzclFxZTRmRk44R3dhVHFnSU8wd0s0bWNoYnJIWHkrVzgrdURUakFpVFRE?=
 =?utf-8?B?dXdBRXZ3VTc1NUVGTThkYUJ3UEc1OXZ3Z2JCYzJJdEtxT0p6TXBMVDh0UHFs?=
 =?utf-8?B?d1AxMDIxbTNMeUo4UG82R2VzM3pkQjBOVUhOVEpDMm9QL09vNG1XMERXK2RI?=
 =?utf-8?B?OWVNV20rdlFkY0tuZFRHR1F1REtyODhJWUtlQ0Z5bURiVnBQbE56Z21mb0p4?=
 =?utf-8?B?RXRNY2dYZTgvY1h3aDhNaGZzQXFMSWROZEJDZWU5ZmpudDd6dHdqUVBBb0Nm?=
 =?utf-8?B?TGdVNEJvWEUydkc2RStEY2xJejY4cjdiREhwSEJXZ1AyZ3dZOHFaUlREaEQ1?=
 =?utf-8?B?d2VDYk1DeWlMR1NPU0g0Wk5NTDFMMW0ydTUraWdNL1YwNHhBdFUvOThITXJa?=
 =?utf-8?B?eitUNGYrSlFCZjJiQjFiY1pVWGVXeCtkUW9lS0p6TUdGZ29ZMm5tVDE2Ynlz?=
 =?utf-8?B?cHVKMGFieldQc3hBdG9sTEk1ajR6Qkg0SE5LTUZ0M1dUUERDc1pRTE9wZnpK?=
 =?utf-8?B?dTZRc3R4Mkg3TVZqMVVLVVF1TE0ycGdaMTdxdjZuTUtDU1FieVpxQS9HQjhL?=
 =?utf-8?B?OURCY3VCTlJkbmlPcUhHR3o2R0EyaGhnWWUzcENEblFpSWN3LzczcVNaRUtm?=
 =?utf-8?B?Q3lRZjNEaXJhSHBLdzVuOVk2dFFhUjZFRnB1SWRBa0tCd21qbUxXVDFnWG8z?=
 =?utf-8?B?WURIYVZBc0JxQ3ZkUXYwM2lFVkk3d1ZVNkwyY0thc3A2UE5yd3o4QTd3cVN0?=
 =?utf-8?B?dzRBWGZjeVJCZ2VGLytxUlhlU2RST05KUkJRL3pqa0dXeGVsVHdQcUZ2enBL?=
 =?utf-8?B?d3lRazI4VEFvMGh0ZlBRRjlFZlNzaG51UmQvTDFGM0RlbDI5N3VHU0huR1ZJ?=
 =?utf-8?B?NjNyNVZ4WCtpS2xVQmFqRU1ac3VUaHc3YTRJTEd3bytKWS94UnVBczUyYjdw?=
 =?utf-8?B?TVorTU9OQTkrVzJUcjdUY0h5dGNVR3BWZlhSMld1b3VOSDZqOGV5L2VEb0lP?=
 =?utf-8?B?TGUxZlpSbkY0NmtpUW9LUHdFZDh0MjJabVRJUXc1TldMVW5LUjhhcjIzaXFS?=
 =?utf-8?B?NHFFREZ6Y1hmOTcxbXEycDNNeHY1cEZFMGs1KzRPVGt1VXFyTms5c0RMeklj?=
 =?utf-8?B?VjhwL0pMaDgwTCtxbkx1cWZrOWpKcE8wY2lydHcxdnVWUzFicHIwa1FwQ2Z3?=
 =?utf-8?B?Mkh1YXozQ0pNVUE2NEl4M0ovWFZJTjBGb0RHUlltb0VwMmtVYlR5Wm5na1NV?=
 =?utf-8?B?WlQ3czVyMlI1cUIvSnNVaHR2Mk1TdldCU1Nqd1E1T0twa1MrSGJpNVR6QnJn?=
 =?utf-8?B?M0tyMnJEUzRaV1YwLzNvVk80SjdvNkM1REJhVDM5YkVUMldla0xHaVNTSGh5?=
 =?utf-8?B?a3dpb25Dd0xiTllsYlFEeGF2WFExMkMrMUo4M2F1TTFQSWFyZHdEU2ZyL1Zz?=
 =?utf-8?B?NVkzVTRVN0g5a0xBQTFYTy9lMnQxYXBXR0ozYitQY1p0dWc4U0lPcytPcjJh?=
 =?utf-8?B?aUFRVWlRSmo0akhqek9hTUNjTGZlMUZqdXZmcjF4UDFDYjJFRU1IWE54UGoz?=
 =?utf-8?Q?9zfANI8KK1WqLMIZqL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b65dc072-528e-4193-6bc8-08dea4875d87
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 18:04:03.3883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNyk0c95Gek+VFrMISaYvysjEbql28ScvBuVsGrJdxT8ea5QpZbTltgox6rRVkUy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4094
X-Rspamd-Queue-Id: 33F3F47846D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241422-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,amd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 4/27/26 18:30, jbmoore wrote:
> From: "John B. Moore" <jbmoore61@gmail.com>
> 
> amdgpu_ib_schedule() unconditionally ORs AMDGPU_FENCE_FLAG_64BIT into
> the flags when emitting the user fence for every ring type:
> 
>   amdgpu_ring_emit_fence(ring, job->uf_addr, job->uf_sequence,
>                          fence_flags | AMDGPU_FENCE_FLAG_64BIT);
> 
> VCN, UVD, VCE, and JPEG encoder/decoder rings only support 32-bit
> fence values.  Their emit_fence callbacks contain bare WARN_ON()
> assertions for this flag, but the flag should never reach them in
> the first place.
> 
> The VCN_ENC_CMD_FENCE hardware packet writes a single 32-bit
> sequence value to a 64-bit GPU address.  There is no 64-bit fence
> variant in the VCN/UVD/VCE/JPEG command sets.
> 
> Filter AMDGPU_FENCE_FLAG_64BIT at the call site in
> amdgpu_ib_schedule(), only setting it for ring types whose hardware
> supports 64-bit fence writes: GFX, compute, SDMA, KIQ, MES, and VPE.
> 
> Also convert the bare WARN_ON() guards in the five affected VCN
> callbacks to WARN_ON_ONCE() to prevent kernel log flooding if
> the condition is somehow triggered via another path.
> 
> Found by a custom amdgpu DRM ioctl fuzzer.

Well again clear NAK.

First of all this shouldn't be handled by the IB scheduler code and second that is already fixed upstream.

Regards,
Christian.

> 
> Fixes: c660f40b1ef3 ("drm/amdgpu: fix user fence write race condition")
> Signed-off-by: John B. Moore <jbmoore61@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 18 +++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  4 ++--
>  4 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index f1ed4a436..3c32a6197 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -297,8 +297,24 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  
>  	/* wrap the last IB with fence */
>  	if (job && job->uf_addr) {
> +		unsigned int uf_flags = fence_flags;
> +
> +		/*
> +		 * Only request 64-bit fence writes on rings whose hardware
> +		 * supports them.  VCN/UVD/VCE/JPEG rings only support 32-bit
> +		 * fence values; passing AMDGPU_FENCE_FLAG_64BIT causes their
> +		 * emit_fence callbacks to WARN and emit a truncated fence.
> +		 */
> +		if (ring->funcs->type == AMDGPU_RING_TYPE_GFX ||
> +		    ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
> +		    ring->funcs->type == AMDGPU_RING_TYPE_SDMA ||
> +		    ring->funcs->type == AMDGPU_RING_TYPE_KIQ ||
> +		    ring->funcs->type == AMDGPU_RING_TYPE_MES ||
> +		    ring->funcs->type == AMDGPU_RING_TYPE_VPE)
> +			uf_flags |= AMDGPU_FENCE_FLAG_64BIT;
> +
>  		amdgpu_ring_emit_fence(ring, job->uf_addr, job->uf_sequence,
> -				       fence_flags | AMDGPU_FENCE_FLAG_64BIT);
> +				       uf_flags);
>  	}
>  
>  	if (ring->funcs->emit_gfx_shadow && ring->funcs->init_cond_exec &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
> index 2b9ddb3d2..9adc7607c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
> @@ -27,7 +27,7 @@
>  void vcn_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
>  	u64 seq, uint32_t flags)
>  {
> -	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
> +	WARN_ON_ONCE(flags & AMDGPU_FENCE_FLAG_64BIT);
>  
>  	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_FENCE);
>  	amdgpu_ring_write(ring, addr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index e9d790914..729c1c378 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -1548,7 +1548,7 @@ static void vcn_v1_0_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  
> -	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
> +	WARN_ON_ONCE(flags & AMDGPU_FENCE_FLAG_64BIT);
>  
>  	amdgpu_ring_write(ring,
>  		PACKET0(SOC15_REG_OFFSET(UVD, 0, mmUVD_CONTEXT_ID), 0));
> @@ -1724,7 +1724,7 @@ static void vcn_v1_0_enc_ring_set_wptr(struct amdgpu_ring *ring)
>  static void vcn_v1_0_enc_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
>  			u64 seq, unsigned flags)
>  {
> -	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
> +	WARN_ON_ONCE(flags & AMDGPU_FENCE_FLAG_64BIT);
>  
>  	amdgpu_ring_write(ring, VCN_ENC_CMD_FENCE);
>  	amdgpu_ring_write(ring, addr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index e35fae9cd..a020140fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -1537,7 +1537,7 @@ void vcn_v2_0_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  
> -	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
> +	WARN_ON_ONCE(flags & AMDGPU_FENCE_FLAG_64BIT);
>  	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.context_id, 0));
>  	amdgpu_ring_write(ring, seq);
>  
> @@ -1722,7 +1722,7 @@ static void vcn_v2_0_enc_ring_set_wptr(struct amdgpu_ring *ring)
>  void vcn_v2_0_enc_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
>  				u64 seq, unsigned flags)
>  {
> -	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
> +	WARN_ON_ONCE(flags & AMDGPU_FENCE_FLAG_64BIT);
>  
>  	amdgpu_ring_write(ring, VCN_ENC_CMD_FENCE);
>  	amdgpu_ring_write(ring, addr);


