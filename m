Return-Path: <stable+bounces-224911-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMsCEnQTs2mDSAAAu9opvQ
	(envelope-from <stable+bounces-224911-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:26:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F2E277E06
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F9F23047616
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 19:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA918405AD6;
	Thu, 12 Mar 2026 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0uiaRnvE"
X-Original-To: stable@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011032.outbound.protection.outlook.com [40.107.208.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A49405ACC
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 19:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773343044; cv=fail; b=V8rxW7krgJ9TuF4mOv3rvpeQLB/2BnwECE5eYWHqEk4fMdZpkwsn+mkjTAm0PeluEYzW++HDqL/HAMUpYx6Vx03Rtvvz+A0YZ3eJJtUewyjB1cUoLEOIZNAJVR810CB2F17UQJObs21sUJxa3KaL7QXHbY5cG34sDqLf6L23HEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773343044; c=relaxed/simple;
	bh=HcphyDqcMWE0Dp5IWRXTrkmmZSyp71fVKoRVTNoEFXs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ViOu+8a6mMDgAOyjR9tEcsJVW7asrEtiHyldlcwCZ7ugcDfB2fOIpkgYopA6+27fq03t3S1tUnDaIWUYzcHJ6GbtsXcQ/5Q140NNBn5iDmrNUPXPxZxBSfdmBYzFbA5UqP61/1AFK+bDYbbt/4FqmSQyZIjkY3DmG0A/GuD8GSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0uiaRnvE; arc=fail smtp.client-ip=40.107.208.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ff9vlpvfwxDdU5cVPfSY14mkbab2SZ7EuhCGQrqF3lusc10Z+z/6EUvvM71A9HRJtl83HLZQDvQFhQjC04NRxnf9KrT6pSVXojL2xWf6K3sVdRvwF9tKtwXh/hBr3fQO90JeXBk6QdXIZZnF+z/Z7yPnA7KP6mQMeXCI1IPfikYfXzru3DhUR+rUudC9tfhGHM6KKLfotp64tkOcKTYFxVf0GrWOwnvn4bIizmY7locXTH1+c4FmV3kqxEU8k/BmkF8EX+akwQqgMz2xdQID5vtcfPuUFhuj1nfklI5tnJcPINp5YHYoqYQt2zKLljWIuj+lESvYIE+jcRYp2JlX8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPqbiaYN68WSKHSXnoaNTB/+8U8d8+DFCPgPdKjRVcA=;
 b=AKvwKu7Ug5vTMFnujfFdsjxVR1VTpAXfK0b2k0eOlPEuy6WASyRr1VVdWGRC3x6ySS8I8BK4gfnYkoRyYjB+SvgLlWN8c400GdB9RWZu8XVzelgjXL/2UelNTsws8XOdArdm9mP1QtenhQgvHkGjH3AHf14Ha4uGyE4SHMZWGBx3oDS31LE2eERDUXD8eoZl5GkzWZ9fW5aLYBNawFAH0cgrWNVhUp6VNuLSfD0qu46/0SHcsX8VGUsbSaNA4TRKrn5SdiQUU+gr+du52G9BD1oLgFS/Gr5fBZiwUHf+LQiMh9VdPeYmrUogfaOFp8kltQcvrlV2AkzFWYhETlAZIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPqbiaYN68WSKHSXnoaNTB/+8U8d8+DFCPgPdKjRVcA=;
 b=0uiaRnvEVPIBBuWT5mci0IBXWzRQRncb5HRdAsOtIyC24E9+aNuONSqvNzZdYZK5y4z2zK6+siqpk2reXbegMnwxZqi8/LIigcg5kDwMCBNc2tvJAPnEgxgMil1Ud8xu6XCB2Wyjp0/tlWtl4KmhZzQXzUeVlR+VtD8zLRoCEnM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5130.namprd12.prod.outlook.com (2603:10b6:408:137::9)
 by DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 19:17:20 +0000
Received: from BN9PR12MB5130.namprd12.prod.outlook.com
 ([fe80::e7a:4396:5bcb:2b5a]) by BN9PR12MB5130.namprd12.prod.outlook.com
 ([fe80::e7a:4396:5bcb:2b5a%6]) with mapi id 15.20.9723.006; Thu, 12 Mar 2026
 19:17:20 +0000
Message-ID: <148df44d-2456-40e3-8be6-f98b89b7ee4d@amd.com>
Date: Thu, 12 Mar 2026 15:17:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/atomic: Add affected colorops with affected
 planes
To: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: contact@emersion.fr, alex.hung@amd.com, daniels@collabora.com,
 mwen@igalia.com, sebastian.wick@redhat.com, uma.shankar@intel.com,
 ville.syrjala@linux.intel.com, maarten.lankhorst@linux.intel.com,
 jani.nikula@intel.com, louis.chauvet@bootlin.com, stable@vger.kernel.org
References: <20260310113238.3495981-1-chaitanya.kumar.borah@intel.com>
 <20260310113238.3495981-3-chaitanya.kumar.borah@intel.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260310113238.3495981-3-chaitanya.kumar.borah@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0137.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::37) To BN9PR12MB5130.namprd12.prod.outlook.com
 (2603:10b6:408:137::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5130:EE_|DM6PR12MB4332:EE_
X-MS-Office365-Filtering-Correlation-Id: e517aa02-6844-4677-0b89-08de806bfbab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PoHiZFdqzQtMFH/9V6wvOCK+ov7nQ+9r16nTmZvbOCrxQSJ2m/r/iKnibHLpMqXEaitFOce8spB8UXb3+HhkdMLd8MdmiAZZdrB54aaJLvat3ogDDPH/lCUnhl+PsAncPTRCQBCmvJjjRAEMsZua5ukUfT+LW7v7LXXWhKUx6iaVzOxH4CgZ0ktgM3UPECDSgN1/MriB41k+CstIc0VEufsYbjeLCoPThRmN4eyfGyJ/RifDU9jBuuIUQmteCmXCvt05qd1xiOx9wocd8Bc3ukNIXZbcVhcXILdVom0dfsT1ujbqAaAbWJTsbwVp0IqiaNxnkei/5skB6LEKFKUXqqgJ/HmmnkwVtrdBu82jwK8UhQv06DDjP1gJd39ttHFiDKIPXnGMuOrSEIUe9Jl/e7iAH2PPAy/i0WZgnH6S0h0lakN5TQXf2HseBKadQUZDTcDGQcxuzYgRUmXYUnl6KcnJ4Ym8eTH297KgjWdDsjSHn89YUV/t1fWPnDDSd0LjjKr9i/JqrUjF255X48GYJGWcl0IWeFSBecGFz6UqIagrNFkhAyyyAAt1H6tyuv7mZa2c1aUbYDMw8ftdSvUJ0qszPT6FNV7aV3yILdrsb2FggMvLYlTbMhIodYJVBgLOyf/B3cPsxO652bJWcEVZyqhSbX17bA2MBy4Pt8H8QlchLlx6c8rfB5wz2DePh2ck3vvxui1IsNWYdzs5udK39RI1kiYfDdC8utUIH/lH0XI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3lrNnQ1bFpRTWpuUmR5UjRscldWNzFPUHpJNjNhYmZOVFVUd0RpOUIzSmZL?=
 =?utf-8?B?QnhQZUtPL2Nyay80RmhPSmN6WWxvSng4UDFhalV2ZGRlN1ExY3g1N3M2d1h3?=
 =?utf-8?B?RTBlZCtSUHhDdThvVFhIeklaVmcvbGZVcXJCZlllZ1NJSEdLVnd0V1hTYTRO?=
 =?utf-8?B?b28wTnlqQW1uTGc4cFF5aURScVAvMTNrKythZ25nSVNmZTFLZkJTWGE2Ni9W?=
 =?utf-8?B?ZWxEeFdjTVVNMW1OYjdFWXpjUlpCV1dYM0NRMjZubE1pd1ExL0hlNnFTRElz?=
 =?utf-8?B?eDdXV1o0TEtrSlUxYWdROTNVRDZIWmc1cDZOK1pkbG8zK3VvWWFBd0hiaEtR?=
 =?utf-8?B?OUg2WHlxK2h3ZVpDS3NsVHZIblloM2w4dE56UG0rb1hOVzlweUcvMVJYM05Y?=
 =?utf-8?B?SEFhT1RUR0h4NnBlcHJNbTJZc09MQUQvdnk0M2lQQmhnMk11UGs4SklVZER5?=
 =?utf-8?B?dHlRRFJhUUphU0E1dXZoLzRWSERhRjkvaHYvZlViNXE0eXV2V09Fa2pQSWZW?=
 =?utf-8?B?RCttT09sQXJhQklIYVZVTGF3enpCdUdYN1RTSDN0aDVCS3BrazZxRk4vUEt3?=
 =?utf-8?B?R0pvWEFZQytJbzJlZDZteWZnVnNmZUZ3N25nZE1wdEI2SUwzSW91NGM5T3oz?=
 =?utf-8?B?U2tlVjJHRXY2VnhGTEJRQ2I3VWhxSGFFTjZielozY1A0MERUT2F6MUlodHd5?=
 =?utf-8?B?aDFabWlVL05lTTFhQ3kzUzVyRUZCQ1B2QWFPOWdIZ3daOXBWYnRadmJIUnVn?=
 =?utf-8?B?RTNQNGllTnpFbFdYTGdtYUFQSWdkMnhVa3F1UkJSN2hWY0NpWWFrZ1dPR0hi?=
 =?utf-8?B?cmY0Q3ZVdlBZcHdDRDMvS3ZMajNuYlJyNGUxREwyVUorTHEwVEpiRDRUYVNC?=
 =?utf-8?B?bC9qd3JDNHRocEQwSFNqMERJbXg0Tjgxd3VlUUZub3NIdThScUJVSEFyOUY3?=
 =?utf-8?B?aVVtY3ZjS3ZQZUhVWUdGRjM1bjVDaUZiWXlwODkyN3UzRDNCTlRxY2VBQVNY?=
 =?utf-8?B?R3FVYStIRXppZ0RnVHNXRkxheWFMUTh5R0lmOTJkM08rb2hsTWlpd1pBQVE2?=
 =?utf-8?B?ZlVFWkNlQk82QkRFOHg3Y1V1UDI4SElYNldUN3pWdE8yeVZlb3ZGYVlCUEFW?=
 =?utf-8?B?K3NiQU44czV6cGJINmtBeXFndTl1Z3VVcGZSdHp6RWM1UGliaGh3aXhNL0Vp?=
 =?utf-8?B?czVCcmlHdnpUWjhZalpOaFJFUUFZT2hmOWx0YWtwRGtZYmxhTWZPbnJ1OU5v?=
 =?utf-8?B?ZEk5Z0dacTg5UC9rMjJjL1FldVRTS2VVOVpIQzN3TlJNWEtqOS8xSCtFS1lN?=
 =?utf-8?B?cGczRzkyRjVuMFVQamdWRkRoN3YvTy84YzVjYnErQTNIKzBLc0NZTHFVdU4v?=
 =?utf-8?B?cjBKMHNLRDNGZndRQjFONXBUbkN2S1lJS0lOQ0wvN2IvaUIvWkRacStnaHZX?=
 =?utf-8?B?T1NFSDR4Sm9OUmV0Zy9Vd3cvNUxSTEYvWUU3d0cyL05QZ2QyVDJZMUFTU05v?=
 =?utf-8?B?Z1NGbnBCa0Z4ZFArNGVrRTc2NmFrMUxwNEk4TFRXZFpERjFFSnR1c1JQcHFi?=
 =?utf-8?B?THZqZC9ibjh1RUFOeS9zT2ZvMjBRWXhveWV1Mi93TEMwUW5sVXgyT1hKV3NR?=
 =?utf-8?B?WTJIT3BOSEM0N3NCYis2ZlphbUtWK0pyKy8xWm9JT2hzMlVLNGliYks2UmNE?=
 =?utf-8?B?T0NIMmhXOUZXSUpuVmNVQitGVCtqNUN2cHNncE1wYVNYc0JPRkZBdkZzd2NI?=
 =?utf-8?B?R1dCbFlBcjlHcTlLeFh3WDZnSEhNR01ET1o3TjVHR1ZjbDhZTnVYSnN0N1l2?=
 =?utf-8?B?cSt5YmpyL3h6STBmb0Y2MDkxOVBVVnUyTHM2azBHb0Urc212aEUxQkZoL0Mv?=
 =?utf-8?B?ZnlhSFFKeDByUzhIemQ0OFRHenhTRG94Um9QeE9LUEtBeURFamJZckR6VTAv?=
 =?utf-8?B?MUIzb3B6WGx3d2dWdXZUWDhzbk11cjNYRUU2UmlvdVlETmJMbFpaWlhkaWpi?=
 =?utf-8?B?UFpnUThWcmVIRW5GM0dEWjFhNENiTXRKUVMwWFpFMDAzc3l3aTVHRitaL3NQ?=
 =?utf-8?B?QkhKRTV2UElpSXNJSFJYdlo4UU9uZzdsS3VlTnd0TTJOSjEyazRaQnd0eTRw?=
 =?utf-8?B?bi9sUGhGWUE5UTVRYlpkU1RMeG1ZVlFQSTIrTHR6YlFFdFh3S284SWRTMkhi?=
 =?utf-8?B?eTYrYjRzQnRkRWNMc29oTGZrKzlsaUt0V2szYmN2VkV4YXhTTlEwRjBENEhn?=
 =?utf-8?B?NzNmaEc3SncwV1htWHRBay9UTU9TRWJIOFdhZUNtb1pKcnFHRTZVd1kzOFY5?=
 =?utf-8?B?QWJrV2RWM0owZmQySXZnVFNReW5jaHU0V3NvWFJKNHBwaVhTVzdJQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e517aa02-6844-4677-0b89-08de806bfbab
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 19:17:20.7019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OHyZZvAPuTrWrNfm89BWgyem+SfBVhazht5mF/3BJDrsNWi+ZKmcCjLbr9Wk9xQozmvmxloLdwC2zg79L3HKIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224911-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.wentland@amd.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,amd.com:dkim,amd.com:email,amd.com:mid]
X-Rspamd-Queue-Id: 43F2E277E06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026-03-10 07:32, Chaitanya Kumar Borah wrote:
> When drm_atomic_add_affected_planes() adds a plane to the atomic
> state, the associated colorops are not guaranteed to be included.
> This can leave colorop state out of the transaction when planes
> are pulled in implicitly (eg. during modeset or internal commits).
> 
> Also add affected colorops when adding affected planes to keep
> plane and color pipeline state consistent within the atomic
> transaction.
> 
> v2: Add affected colorops only when a pipeline is enabled
> 
> Fixes: 2afc3184f3b3 ("drm/plane: Add COLOR PIPELINE property")
> Cc: <stable@vger.kernel.org> #v6.19+
> Reviewed-by: Uma Shankar <uma.shankar@intel.com> #v1

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> ---
>  drivers/gpu/drm/drm_atomic.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 04925166df98..dd9f27cfe991 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -1587,6 +1587,7 @@ drm_atomic_add_affected_planes(struct drm_atomic_state *state,
>  	const struct drm_crtc_state *old_crtc_state =
>  		drm_atomic_get_old_crtc_state(state, crtc);
>  	struct drm_plane *plane;
> +	int ret;
>  
>  	WARN_ON(!drm_atomic_get_new_crtc_state(state, crtc));
>  
> @@ -1600,6 +1601,12 @@ drm_atomic_add_affected_planes(struct drm_atomic_state *state,
>  
>  		if (IS_ERR(plane_state))
>  			return PTR_ERR(plane_state);
> +
> +		if (plane_state->color_pipeline) {
> +			ret = drm_atomic_add_affected_colorops(state, plane);
> +			if (ret)
> +				return ret;
> +		}
>  	}
>  	return 0;
>  }


