Return-Path: <stable+bounces-224910-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPoKI3ERs2mDSAAAu9opvQ
	(envelope-from <stable+bounces-224910-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:18:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9F2277997
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC4BC3047F8A
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 19:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B1A401498;
	Thu, 12 Mar 2026 19:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0bPq7VJp"
X-Original-To: stable@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012061.outbound.protection.outlook.com [40.107.200.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0C13AC0FA
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773343018; cv=fail; b=MNZUwQMazR6irrmzHmnfOPTM5Q8+yHW6WZ7Qzz2CBD7mgTHR2wCWdxOcixDWo3g2hJtL9tV+USGWAfLQfaxgEVT/ZR1UkqCWd07y3M1oSEJrwHFOdLPGXe8GMMJNMpa6AMiGNqvj8Qr1Ouwq5/jkLKFuyPyJJVQVwSEjdiJti6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773343018; c=relaxed/simple;
	bh=6Qd+4scd7iVU1vvBkLyjTIGzyhA/XCEoNqMqp1QNyXc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qZMhd5YvwP08lc6bOwQPB4fGSQuUnaZVtU39jPjrEjbj8x/451oRXKXUmT2T6n6/F35UmgG/3q2jChNdZklAcOXtqQ+J9hMMfe1V9jWvSfxBxdl2yw+48LqXLzRaaUTAefx0kMZ4HVS3g1gZCkwFSbCs6muvwp7zmI9v/xOBbaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0bPq7VJp; arc=fail smtp.client-ip=40.107.200.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYIngAks5cZjY6DqTP4uBhsqt8h8c6jSmbU8hlAd3xzu84quWUWCaDOAvVwowefTpCSq7q5Wl4N4cNEvpkVHNXiFpAuzvTalRaypqGoZCH+OECZDyFyPB6+gwCiTebmKNvJpwPk7nIKLoZLCiktWTwwZ6Yw6eQ2kP7w4e7j8e5G66nvlDzAoqGRMhKND3cXvqLH7CERZumDjQnF8N1kJBWtS1bsfTRwXyBCI1I1mtuvM3+T1s5r7GOwhcq4k2szquWEQLEgPMWhUUasHQrjLbN475A/oFwA5gm624HncbJsIcgAMkw/bNhZNhuq35ucpz20Yrh0BG7YOzdOJm1iPWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WapQeDT+VJdwv83LckyxkvPsh45S0rmW+g9fEbeUo8=;
 b=DovNx+pTjLYSH/rW6MKgo74wZIe4t1QTpTO0922PEYZ9inV9b3KajSCO01/15msoR0tMqRRk+zfr472jEcN0og7UymVy3esyyXX1fODkpPgXOddD1m03YaQ0qJq3FNh1bivvqLrzW7hTGrq7ZBEzH+1llbe5/xe3VHnOE8If8S55DKo9POIcxlMMYZTNYo5FHVoNeyw4AwdfJt7bBtu12wgdyJhabvnuvQ4NRAiAiQfvB0PuzqMSMFWL64OCHWDNxfZt+YP9Xx81Anuvebqk+DdWpQzE4cu34xqw01yak2835683QNx4ls65F9JlewHRHyMYJIjbiiF6hMBMgQbykg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WapQeDT+VJdwv83LckyxkvPsh45S0rmW+g9fEbeUo8=;
 b=0bPq7VJpZBP2qDGh7nl1B24ICS1grocOgHZigj/iavGfFXjwNbT6VWhSMEEnWm0RhFyP+zSp6F5RNiulwpzlvLaSLzymq7sI90BZlZR94W+INye3OhlDy4RzdrLV4077k9KKFQsZ6e/5rd61cmH93I/4KUUtGqKAOYh0TK2QBlE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5130.namprd12.prod.outlook.com (2603:10b6:408:137::9)
 by DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 19:16:54 +0000
Received: from BN9PR12MB5130.namprd12.prod.outlook.com
 ([fe80::e7a:4396:5bcb:2b5a]) by BN9PR12MB5130.namprd12.prod.outlook.com
 ([fe80::e7a:4396:5bcb:2b5a%6]) with mapi id 15.20.9723.006; Thu, 12 Mar 2026
 19:16:53 +0000
Message-ID: <fd5266c3-bf80-4265-8dee-d8e227f54d45@amd.com>
Date: Thu, 12 Mar 2026 15:16:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/colorop: Preserve bypass value in
 duplicate_state()
To: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: contact@emersion.fr, alex.hung@amd.com, daniels@collabora.com,
 mwen@igalia.com, sebastian.wick@redhat.com, uma.shankar@intel.com,
 ville.syrjala@linux.intel.com, maarten.lankhorst@linux.intel.com,
 jani.nikula@intel.com, louis.chauvet@bootlin.com, stable@vger.kernel.org
References: <20260310113238.3495981-1-chaitanya.kumar.borah@intel.com>
 <20260310113238.3495981-2-chaitanya.kumar.borah@intel.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260310113238.3495981-2-chaitanya.kumar.borah@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::28) To BN9PR12MB5130.namprd12.prod.outlook.com
 (2603:10b6:408:137::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5130:EE_|DM6PR12MB4332:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d80c71-e6e0-4a98-069e-08de806beb9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3bLahES3g+h7mn8m4WKfImisgswVqBtTcm7/212RIfSy8Hy7q8ndoTUprWdOaZhyFovCowUAGQuv1m4m4v+tjUP6aLPk40AHGLlD/u1xk/d4fxR8Znrn8G34ZPCb4CajNzDsP7lp82UaeDnO33Q8uTj5ZLKFccgxbw2psP1XQ25aXvTOOJf8eXZb60fkUtDs4E4TjT0tbdVGR1L9MWJVgrq3m4vvqMw1OZhlY4ytU+2XlanlsszqyJ2vVCfoZjpOuXQqz6EF/nYlNalRbVBxvvBKoBtGwR/CnFXRQ/ZCJinQvcPCBDiXZT7ar/ilUrLiWTNfrF6i/rdfc1P8Oe1FsYD/vW/z4rj3IRTxfxgj/oScgp7Jk+zl2UfSg3v6CUUUT6bTMBo4iQRJreDu6chqWRHDgsVwn2wIRMKcjTZDEKt3PBInD30hINvAnoqwC0tMkeL9f3o+dpDnmqOPN275m/onMsI2j12Xj3mWUw2qcdEWiwVOxVWMwRhLVFhvHS5nnfkOSRSYrWx4dnMwex9wdrrNiuQKT877LeeJMulbsj3dgUSfXgg1kg2NEEjgMR7wecR2lSoXmMetFBut7TsSUULkLrPjwB+tuKCaavcKOP91y5HFTG9q0a4r2wKTAT2bKLKDinw1K5DhBbm89/JAaTU6U5eWYnXTmIksOOz28E665q3aMr82XjjLjZILfr81ZPC6rKVmNbf+GwUcR3+pKY+mOuZFZCbpeDx2XORNCOk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b29Vc3AyWmR6a3MzVEMrQUt6TDdBL3Z1ME93N05xRytkMVMvb2FBbG9yejZ3?=
 =?utf-8?B?NWZqcCtGYy9QYVM3bWtNbm95M3ZxODVWb3RRdEx0aDlpU2RBSE1BVFNaY1gr?=
 =?utf-8?B?Q2FXRXVsV01vNmdUT0NKRTZhdElWS0JpSjFZYldEdnA2ZW5sRWZUQkpXTDI1?=
 =?utf-8?B?c1dEMVlBam0zbjljNFZHVjVuS2Fwc2tsdHBOWFQycjNFQTJnZDAwemlVYTY5?=
 =?utf-8?B?WUZiL3ExT09HUzYzcTUrN0JXQ3JsU09yM1lkU2FmcWt1c3BPcjdSUkVLWUpE?=
 =?utf-8?B?QXBhcmdOMWdRSUdYSW93MGdzSVpHUmVHeE9sS0JWcURXMGRBNGZhQmVzcHV3?=
 =?utf-8?B?NXIvQXVXcmlSeDJsZWJBWWdrWDIxeXRhUlZUclVHdVBHMFlQMkx3b0FPajQ1?=
 =?utf-8?B?a3VXVmRUZXh1WGtMdFhwajNHL2tQdHQvY1dlT05CYmdjWFFGR1d3RWZZYTYr?=
 =?utf-8?B?V0VwV1ozQXVqektacjVZOVlxV2YzTHArcDBhRnJuN0dtRENNQmVXQ29mVTl2?=
 =?utf-8?B?V2R5Um1ZSWFsTkdieVZib2VpWXEzeXpJTXptTElaN1dMSjRUc1RCSTBlQXkr?=
 =?utf-8?B?SWtHMnZ2dGRlVHdwQndGSFZyOW1Za1hHUktlUEtKTVlPZFBSNi9kV1BjUDV2?=
 =?utf-8?B?aE1hSmJpZHBaQ2IyQmxweW9HVE1vZ3NhZ0h2ZHNwZng3L0tndzN0a1lBaURF?=
 =?utf-8?B?eHVwZksrWVFjb2xLM0Z4SEtRZVA3aHFXd3FCZ2xDY00yREVyVERrOXFWRkg2?=
 =?utf-8?B?NTcwUlpDVzhJUGI3TEIxV3pkUHNIaGpvMmN3LzN1WGxpMFpCRjh0OXJ3eDBL?=
 =?utf-8?B?L3dNTThib0VISDUvZi9UZXppRTEzVGRRYndELzN1U3VnQmJGSnp1QXFBRStD?=
 =?utf-8?B?VkFhNnRURDdCMlFFUjRSZWVvL05MSHVSdjRSbVc5NTBhVjh0bDhscmFiSUYy?=
 =?utf-8?B?K1J0eStOaWViNWFBdGN2bmtYREk3RTlteFNNak1WUmdjZ2lwTUJpMDI2c3dZ?=
 =?utf-8?B?dERjZENjQlpCbVBkT0JkYTlyMEZDUzgvMGphMEo0dGhvMm9MT3NnWVQrMnN4?=
 =?utf-8?B?VUsrT205N2VMWE1tV01lSm95SSs0YlN4U0p0Zlp3STA3ZmQwVDdSUW4rVEJr?=
 =?utf-8?B?cXQ3elo2Q3M5Q0cvN1JIM3pOdEtQY2Q5bHREVmJKRGhPTEZWa1NjTzdHb3Vq?=
 =?utf-8?B?M1BBc0l2TC9BNkVXdDBtdlFkTXFNbjVlWGhaK25uUzFTSDVDeG1qM2Ryc2xw?=
 =?utf-8?B?Zk9kbnJRa051Wjd3TDhDc2VXUk5VYUFhcUZvQWRzNCszYUNVZ0dkUWFsb3Av?=
 =?utf-8?B?T3g0NnRNWGt4ZVVVWlNjTVBwZ010QXJKTWJ5SlRqMlFMc0xEeXJGNFBBam1k?=
 =?utf-8?B?d0xGemdDbHRBcEozb3ViQ3U5MHpoNWY5dU51ZTQwdzJlNHFvOExpSWVVZ2dy?=
 =?utf-8?B?VEozY0phdkNTYm1IWTByaFNkTmZWY3JxUFA4T2Z3WjMzbEpNa0JvWmxPd0FD?=
 =?utf-8?B?NmR2ZTJPN1FlNjJ0bjE1UWo2SmE1ZmpzdDFRVGh5RllHemVWQUpHUlErK21I?=
 =?utf-8?B?Q3JGeXM2aUNqc09ZbkhxK0d5WXRnT2Vyam5kZzdPRUJqbVIrMnpPZjhwSkhz?=
 =?utf-8?B?aTI1UmIxdHNLcXppU3VXcmpmUlYyYk9XTHJrYXFNRkxSekxidyt3V1QzWWF6?=
 =?utf-8?B?N3FwaVhhcWRUQnlvQ2txSFlUUVJ3RUVvOGNIdW9UcmM3TjhIeHlsWGhBUjNt?=
 =?utf-8?B?VnBEd3BXMGd2TEZTRlEzK2pyYUxDTDJCcVNkVjVVVzRDUXVZK3RqWVdpSVNE?=
 =?utf-8?B?a1JaS3B0aWNJcThRT2hnZ091SXNmSmpBbDJVdk9ZRS9vNCtOTE5DU2Qwckwz?=
 =?utf-8?B?UHpaYXZwMWQyNnhSd0JNa2NKTHJGRHFVa3hnUXZvUTQ4ZXNRa2NCV2l2TW5P?=
 =?utf-8?B?S043cENhSEtGbFlndUZKREVhazY3QjRTOEhrS1JodHJsVmNyMnFNYmxPc1hC?=
 =?utf-8?B?Q0NuYWhyZnd1ZzdDbVlOc1o2TVBDSUNnRWFJQmNkVjJUcnc1OVdscDhJZG5P?=
 =?utf-8?B?OVFhNDh4U1Nqd1ROQXJadThtRzNaZXJBbUlMSFgrV3A5cThveVRsVzVXTDZw?=
 =?utf-8?B?a3ppbHBoRkRuRmR6NU12TDcwQkdZSnJ6MDFPV01pVWQwU1pHSlUwaDJycEY3?=
 =?utf-8?B?aldITk0zRVQwK25zNVliVWpod2pHR1hiaDVPaUhsQmdjYklQOU8rdG5aQ1Uz?=
 =?utf-8?B?eDd6RW92OFZLZ0JZd291QnhMMWUzY3R4cmwvbVE5ZTJaeWhHdkNVRFNUalRQ?=
 =?utf-8?B?cU5YK0VpRzdMdkdwcWlLcGJWa0dTSms3dlVMWEszbVNLWW5OcElHQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d80c71-e6e0-4a98-069e-08de806beb9d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 19:16:53.7490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJGir0RU4lSsa8SCcTnlQWqKrlm1JsmnkZySv6dtEAjZToWcMhyLo/rMcY5dLzNte6aqD4kYOLTJv5VLTXxi6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224910-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.wentland@amd.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:dkim,amd.com:email,amd.com:mid]
X-Rspamd-Queue-Id: 2E9F2277997
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-10 07:32, Chaitanya Kumar Borah wrote:
> __drm_atomic_helper_colorop_duplicate_state() unconditionally
> sets state->bypass = true after copying the existing state.
> 
> This override causes the new atomic state to no longer reflect
> the currently committed hardware state. Since the bypass property
> directly controls whether the colorop is active in hardware,
> resetting it to true can inadvertently disable an active colorop
> during a subsequent commit, particularly for internal driver commits
> where userspace does not touch the property.
> 
> Drop the unconditional assignment and preserve the duplicated
> bypass value.
> 
> Fixes: 8c5ea1745f4c ("drm/colorop: Add BYPASS property")
> Cc: <stable@vger.kernel.org> #v6.19+
> Reviewed-by: Uma Shankar <uma.shankar@intel.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> ---
>  drivers/gpu/drm/drm_colorop.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
> index f421c623b3f0..e44a738c4c14 100644
> --- a/drivers/gpu/drm/drm_colorop.c
> +++ b/drivers/gpu/drm/drm_colorop.c
> @@ -466,8 +466,6 @@ static void __drm_atomic_helper_colorop_duplicate_state(struct drm_colorop *colo
>  
>  	if (state->data)
>  		drm_property_blob_get(state->data);
> -
> -	state->bypass = true;
>  }
>  
>  struct drm_colorop_state *


