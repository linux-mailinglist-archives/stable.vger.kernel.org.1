Return-Path: <stable+bounces-241243-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLfnCpcQ72mU5QAAu9opvQ
	(envelope-from <stable+bounces-241243-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:30:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 784EB46E5D8
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78F57301779C
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 07:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5F5391501;
	Mon, 27 Apr 2026 07:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3do/1F7T"
X-Original-To: stable@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013070.outbound.protection.outlook.com [40.107.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649E939183A
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 07:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777274804; cv=fail; b=VFnmnvYC1F+A1hYO04Q3UMV1dzobGqtJHquRmN5egtai8NrZgmggmffi6SCuNXuo+XJbVKTgaFxg+QKQAMG8XPETgQ1/LfBPOwBzVv2vlh0mx7OUw+CuuYl/MsYg79pIteSork2p4W/lMMMM3xpOg6vOC7SANmjfz5nz5+aZ8+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777274804; c=relaxed/simple;
	bh=EUTQSZ+6mmTCATxk5QFJHqZAdKbyjoGyuaytAv9Ffys=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Enq+w6UR2w66nYBZaR502AM1SdH8zOH9EnzSlP2W/vGDra/4L7V6C8nZmOGuwhtPID7oebG9W3ox4gOxsVe/lC5zY0+uKIP6a7syX3UYJJwkFRIjBHElXNLvXrVlvVPJKidPyg9Uw81oJ0Dx4O7MZA0Ah0DV45cJnVe2nU8kx0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3do/1F7T; arc=fail smtp.client-ip=40.107.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xo8tJBLD98zXwOayfdLOsQhTF9LOlHTLlT1d1vCGYfq72Zpga/9JFmsDyAkj4O6Aihuozs8DMzoT/c1WOBBXT2sWTh0U0Eu4ikK7CT1Z+1JDFRsk5CBP5V6N4IimdnOLbkEqvkgEbcEvLvD2hliw7EBLNN24XTJq38wIvEbif/vmZPyGXcUVVUzPG1tsBCzfaU002J9d9cs+6FCoZ61GevbE3RVAVdBzBQLrJM2zxAhZiExRWHmjbzppBRt86smHwjaDqtFZYWLUJqeSLAYF5O90ZgV6xJp3frzJ5/muJm773iaGURFcXFqFT1UipHyG7ryrxk8lDgJqGkWyrxO3oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igQnDkqTI3WwytrNGmWSUKPAwFn1vPkGawXSa2bZdmc=;
 b=IHYPieat8QIS5EWifPIJCe2QKQyR2NLFVgxva5o9oL5zzZDOCoIWTYvGBaJDQ7FF6bgIqHk0XjzmRT/Hsnx/DDV8Tk93vCvOHks4JPa4UkG3bwRA6oN1asorZfhax1zgDobVPGiTtgAglpFy075b3cOtyqd2uL8qabjkA0T8aYwgHS34maxUYS1nW2+ZQZS30Rq3hfoSWL0Xxa4IAsiQjXee5r2FY1C3NzRtDBzlwszxYPeJfoZpHVWzVKt+xoucZzkHdAidi/azli2UMS7A21hjhgkPPvPlh+9qyfAWmeXOs8kvhK0DMg9LIr8mZvqou/G8yPynWHWmIpF7TkrRTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igQnDkqTI3WwytrNGmWSUKPAwFn1vPkGawXSa2bZdmc=;
 b=3do/1F7TfYLAN/aZRM60k9pgiUt+ZC4I34/uKbAl3i2+KkMf7SikGUb/+VCQlKgdKGy9UWjd2LNkmg9TTjEh40mqKIzqWCTF3NhWdijT2c7lr01aALcvcpgx7mesJZokKFq+I2jY1k7cA/K2+71d4WOMOGBypamTFW/Vn+qsCpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW3PR12MB4410.namprd12.prod.outlook.com (2603:10b6:303:5b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 07:26:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 07:26:39 +0000
Message-ID: <3ee86d2f-ef80-40c6-a98d-a8f2b0a2bfd5@amd.com>
Date: Mon, 27 Apr 2026 09:26:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu/gfx9: replace BUG_ON with WARN_ON_ONCE for
 KIQ 64-bit fence flag
To: jbmoore <jbmoore61@gmail.com>, alexander.deucher@amd.com
Cc: stable@vger.kernel.org
References: <20260426215256.50722-1-jbmoore@nooks.dev>
 <20260426215256.50722-4-jbmoore@nooks.dev>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260426215256.50722-4-jbmoore@nooks.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::9) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW3PR12MB4410:EE_
X-MS-Office365-Filtering-Correlation-Id: 9092d11b-bc0f-427f-78dd-08dea42e5272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Xr7AjEvdHPqoAkOz8pGIKsN+DOCcBl49gwW/9fD0hBZl+CjIZS4klZd2EazuBMZplGmVzVR8eZWeiYek0QFRmyFYvqEXWKe/dmqgprUdMl7USxT2Qg+o6z+kdQ0Dz+J9JOIsmWT+7t0FwfHF/Oovl4QvsAMRK9/eA9Y2Ai61RWliqwUe8X4Uu+EpOyT5M0vZP9AjdKERAKkuoPLI1CE8/J4Lb6ivlpnuujOjAn6UzF5dlhqCiRkozQExqaAJ2d+mHK3nxn6Xwy/dmReYbNMvK9ndMIAk/zblS2N3w6V6KCibAS6y0q3Nu1VV6iUrVmiV9cZcHL0zezeYXv4xtm1FW2ec82XgmFygaxHhegyPTFEXjr4KfcW+rBIOsQdgiFOJv6SOvoj8JhqBZlT4K+xu/d/hxIakRXU0WpvwSeT0SdpZyFjsZONy0IuAfdnXZZ1vKPnwesJC+1w6euAqK9ovnjRsCKdwKar6REbW69ZVDxIcRX7lHPJMxk/qwkV6CWdYU7fVy0dRIoo8ULZueFmOW0oBBP2360fCPMRtdWKSVWEICEXMs3n6im1rqbT1THTy0U6WHpUAEkvPfnlRUdCP77tSVGyv8RxNyiHVhuFV6//8+bbzcFwxcXLT7ivoUAbMveeFpaCU30a7jfiB54tJ5wKNmIZwc8BOpWue3BgVBwhaTmsuGIg6LQtbNgISbpOibDhe5kpVhUgSck3Au4J0PHjuIl3nuuGJZawr3HBuuPM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uy93cU1GZ0pFbmE5ckVQdkcxRHJiUXdBTmo3VVFoNkVVRHUwajl1TUNNVjE3?=
 =?utf-8?B?VC9RQmdSYW1UK1Z4MFp5SlRsby9CU2doSzFsT1VTVE4vUkpuNUp2K1VHQ3Zh?=
 =?utf-8?B?ZitoOTJVb1N6VjBJMlZjNnluM1htUlBOTEoydHY5azlzUm1UYUZyWWF5bDY4?=
 =?utf-8?B?L2Z5RmRXaUJXZTgzZUtsWVYwR2ZuUkJEN3QvdktLcVdiMjBISC9HWFA5NXEv?=
 =?utf-8?B?bWQ4eWxyUzEzTnhjQ2EzRVBOdmpCWTFpeDRjQ2MwYkcyT0tSQkFXdit1RVc2?=
 =?utf-8?B?T1pDNFI2SGEwSmNYeTZ4SmVuc0F0cmVjMXd1MFE5YlRTN1BWMFVGQUF6bGYw?=
 =?utf-8?B?TnNnRWhtV09TL0VDYmJJSTRwQzZQaXdldVhsOTU3OTA1bVd1d2FWVnZraWo3?=
 =?utf-8?B?Z2k3d3VxeDVITnV4VVMvaTFHQTNPYk14SWJqdVYvejltRzVkYnhlWWxoUGty?=
 =?utf-8?B?dTR1UFREaFpUZjRYRjArT1lpRXZhd1ZNaC9CY2E4QkhNM0RIZXArL0JwU0R0?=
 =?utf-8?B?V3BaVTlvZmw3d1ZwcVpXZXZ3U0NKSTBhaDNLQTgzeUpDeWxDN0trWE5aUXNR?=
 =?utf-8?B?RDJ3azBaVFJJU043RWI1dEdHUGd5akpqVXdxMmlXdTdoZDA2ZmE3MjVDTE1v?=
 =?utf-8?B?enJsbklaTm9GV2ZjY0FBanlwNi9UTWNhL09SWTFjRjhvWTlZWXI2Q2VMNFJR?=
 =?utf-8?B?dEQ4MHZGRHNUZm9Sc2M4ZnpJYTYyQ1lhWXNnalhUYWo0KzFYUHRwbmExRFdt?=
 =?utf-8?B?dlIzay8rTnVKOHRvNTZhdE5SSEdZdktaRk9DV1F0SjVTZUJqZk5NZHJ0S28w?=
 =?utf-8?B?OFpCNit3ZUVib0ZEZWE2OVFYZG9CSGdlV0JsdGk2dEtXOUtDRHBiU2NoVmxY?=
 =?utf-8?B?NGlOSlJxaUpZTWRRVGZVNFdDWUNHb1JSYUYwYlc3c1dvblBBeHJvUlR3alU0?=
 =?utf-8?B?ZkppREpxUXA3aXBVK3VUNWpvWXhKeUVTMlNaZHpidnNoU0dTbWcvenBOK2l3?=
 =?utf-8?B?WCtCSGREdFNaMmNBWjhKL0w2MHR4eFRYdHduVWFTekU5ZkIxQ0ZuL2k2MVVE?=
 =?utf-8?B?RUN0MWJGMEhzM05XM3Z3UVJBcjMvKy9sTUdlNDh6WkoxWlBiVmtRT0NxQmtt?=
 =?utf-8?B?Q3dBdWtrNk1Rc2tYZW84UGRONk8vdHR5SDFBMDdqajlBaVZKbmExRHpmUmo3?=
 =?utf-8?B?OG1OSkdVSGVjem05SjY0NjFiLzVsejBhWmdKaTZFT3VuN3pZaVNMMVpieWVN?=
 =?utf-8?B?QkZDWjljL2wvdm40U2NnMlQrbjFWYXFLN01taTJpVFB0cTZydEtIK3JaaThP?=
 =?utf-8?B?c0dwY1JiSno4WDd6dUl1dnZaRnloWVR5ZXJqWFhHZkRRMitOTVdEbGw2dnZB?=
 =?utf-8?B?L205L3VVZUV3aVN3dWY4RWFQejNtNGRsWWgvYTNwNXJKdUJaL2MwSTZRN0Vk?=
 =?utf-8?B?bEN6UTVzbGpxY1o2QjhRUTJTbFNneWhXZnBTZWlubUc2bDAxeFlXNVlZelFo?=
 =?utf-8?B?VUNIN2dQRkRIOUtteFRVc0VMNG5PQjM3K0loelhTMzltZC9iVVJ6VHNFczda?=
 =?utf-8?B?T0x0VDVGR2l1ZGt1blZ0eVNxL1FHaEhOSmRta2k2OW5kTEc1OEZuYnQ3ZEcy?=
 =?utf-8?B?Nm1CVXp6ZEN4RG9xbTQ4STdyMC9OZHVuVTg4RHZiTEpQbTBUQS9BaVdEc1hE?=
 =?utf-8?B?QXI3VmVaR0ZWYWhsYXhzVkdjYWZzd3V2VHZydFdsSzRBcGc4ZmFlZGZkZWVj?=
 =?utf-8?B?WUl0dmJyVjJRY0Y2cEhwVldHak1hMERlVThxT0lnZ3lDbFlnTTFhRWVBazk3?=
 =?utf-8?B?UmZablpLWXV0WDBGSklWeEdOd3hxU3psa1lGT1owTldLV1hEWWVOWXNiYm9l?=
 =?utf-8?B?cmUyOHoyd01mam9aUEVUVFphR3JST0oxNjJGTUhBSUtNd3RYTmxZOHpKMnZv?=
 =?utf-8?B?bWNqNWVXU2FUMVBQOWM1aDJpbHhBODI2cHN2S0s1Q09TRExwaTYxSkUvNHVi?=
 =?utf-8?B?UlFzSG5NRWw1eXROaTdISWF5elpSVjFjeEl0MUFtQnJTSDJnOThJSFJVZTF0?=
 =?utf-8?B?LzVsN0hIcXU2NjZxWVdrQ3hPdkw2c3pZd1ZRUm16NEw2YzlDZXVtdmtORWdn?=
 =?utf-8?B?OW1oblp4UzY3ckNTbmplN0I1OWc1QzJnWmt5cjNNM0VMRjhaVXhKM0MzWEJp?=
 =?utf-8?B?RDIwLzY4VXRVSWl2RktkUHo1NktaV0lzR2pEVkt5YmV0Ry8xMFNobDlXUlI3?=
 =?utf-8?B?YkpBRXpVdTlabkVXdFQwSDEyRGMyaFBKUmdsQzBwYW04K2lBNmNxRG9tUUlI?=
 =?utf-8?Q?nbdaV+cNn8/gFTjTWK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9092d11b-bc0f-427f-78dd-08dea42e5272
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 07:26:39.7096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRt0ad5q8HoHWdxunHKGUhqMKi5bFJhGbWz6PQ8I1KZF2GlWmmloAjhUAjewANCc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410
X-Rspamd-Queue-Id: 784EB46E5D8
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
	TAGGED_FROM(0.00)[bounces-241243-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:dkim,amd.com:mid]

On 4/26/26 23:52, jbmoore wrote:
> From: "John B. Moore" <jbmoore61@gmail.com>
> 
> gfx_v9_0_ring_emit_fence_kiq() contains a BUG_ON() that fires when
> the AMDGPU_FENCE_FLAG_64BIT flag is passed.  The KIQ (Kernel
> Interface Queue) ring only allocates 32-bit writeback buffer
> addresses for fence sequence numbers.  A 64-bit fence write would
> overflow the allocated writeback slot, potentially corrupting
> adjacent kernel memory.
> 
> Replace BUG_ON() with WARN_ON_ONCE() and mask off the unsupported
> flag.  This prevents the kernel panic while still logging the
> unexpected condition and falling back to a safe 32-bit fence write.
> 
> This is separated from the main gfx9 BUG_ON conversion patch
> because it addresses a different security concern (potential buffer
> overflow in kernel-managed writeback memory) rather than the address
> alignment assertions in the ring emission paths.
> 
> Found by a custom amdgpu DRM ioctl fuzzer.
> 
> Fixes: b1023571479020e9 ("drm/amdgpu: implement GFX 9.0 support (v2)")
> Signed-off-by: John B. Moore <jbmoore61@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 47e81c33d..fb2a0f1af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5679,7 +5679,8 @@ static void gfx_v9_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
>  	struct amdgpu_device *adev = ring->adev;
>  
>  	/* we only allocate 32bit for each seq wb address */
> -	BUG_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
> +	if (WARN_ON_ONCE(flags & AMDGPU_FENCE_FLAG_64BIT))

Please use only WARN_ON() and not WARN_ON_ONCE().

> +		flags &= ~AMDGPU_FENCE_FLAG_64BIT;

I don't think we should mask the flag here.

Regards,
Christian.

>  
>  	/* write fence seq to the "addr" */
>  	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));


