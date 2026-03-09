Return-Path: <stable+bounces-223516-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLleKgucrmk7GwIAu9opvQ
	(envelope-from <stable+bounces-223516-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:08:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F025236C5C
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A68AC300E3A1
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 10:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D728937F8BF;
	Mon,  9 Mar 2026 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cddt83x9"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013054.outbound.protection.outlook.com [40.93.196.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8423803C9;
	Mon,  9 Mar 2026 10:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773050887; cv=fail; b=IdG6GVtxv+3jNsAu1t00K2+Jwv3FbV9QeHDGsuIX0HHvukM1ghZFDhrcZC75fNA1g55pm0TCmb2/wODPyDlcBO+MIBbUeodqama3mKOblTdFVkU/jJt/HddNMObwSdjQEVhi4AlnbTvKk26nfxFxfCyX0C8qcDqljEHcgQW/F1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773050887; c=relaxed/simple;
	bh=FK2+J/WuBpp++c7HDtvVJ2UJLxV1P8V+KAaxf/9hEVA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AFURGkTI68XtSWyshl/8+2SejmX2lO9c7MJtmMhH0rC+pt/5gkiL78mjOTMGbyaqU4uQL7DMRLPrLO2KNcxjpLULcuj0ShiktAJUxVfUaq9vzaRuOlOGprttSGrbJLPg8cdnnrQiePVyTXNhtorI1WFCM4pNyyZI7jkpborDqr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cddt83x9; arc=fail smtp.client-ip=40.93.196.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhoHus5ekrGZITzoN+uehsCOhxqQyBnnZUh1tLYFf5BNNZZWEbQVYu11tcjMVIsGaDtVYATmXE1F/smu5VkCd5vTo0FaB3n7qOl5DfDSfLwVuXNg29cBdgIaLpb5rnXXDBZx5bnlY4I+N6L+MmpeyF4RUz/21Acs5xGapjxtRDm1FZbuU+Vj2JtUCpgCezQkks097RNKrLT/hZct15jny32bdr1NTwze9GdNzSM2sUhN4bW6TWG0SLQWhhuMwjUijvmT9Ycn/+izV1EpvFp+Sup5bmpBkX+9TAEHrfRP7ULzN9ZI71ZMEfYM8z0aEMdBBP7knhehGn4odnCtcsHPMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEswMBIVqEkdnzcorJ+ozS5WeTOlzOZ5SPDwQd0cr9s=;
 b=eFF3lrLjj5Eh5pOsmDVfVg7KJgOSaQHkrLyGHTWxsT3GQxnXNPapRBm5Kmg4HPoiL4SscI1yQQLohTo/WkPObzbTKx7xcmk9kZDvI2hGgcujY9eWxDaFOi9RK0UEKXney9/A1/qQEvC3JViG3yWim8zVNDzBMBmIDB3ZspjFIBigPkFsmhY5uOcjf8fBJ0AHyx8Y/n+AcVQ77fVAetG+dQyMgX9Uw0oSpA1Sa1WEHSOjRK0LJyVLw/wB1KdR+0YxUE5SdjYY0pvQo6mOPbNZ7HFk1NimAtScKO6XAtN6R/39NOkhGUPOgoTJlLI0zugTVUSwzQ1ffZAzoEBUmYdmyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEswMBIVqEkdnzcorJ+ozS5WeTOlzOZ5SPDwQd0cr9s=;
 b=cddt83x9pDpCWC20Qj9k/sUAhyoMgNEcyXPMhYC4PbqRiYGjOqhSjX8y+vtqbLDWibs/4ZvlByd24WpGt8CdpkUhysfpQUxFCeGejLZY7jC0+1cGu3hGoEzenlSmQgZQgR4Xl+wTCJGW8aNsZDZefjYNq2hPOCbVthMZeWZmNnA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7939.namprd12.prod.outlook.com (2603:10b6:510:278::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Mon, 9 Mar
 2026 10:08:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 10:08:03 +0000
Message-ID: <91221541-6d21-44a2-a9b2-f1a30c27327a@amd.com>
Date: Mon, 9 Mar 2026 11:07:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: protect waitq access with userq_mutex in
 wait IOCTL
To: Chenyuan Mi <chenyuan_mi@163.com>, alexander.deucher@amd.com
Cc: Arunpravin.PaneerSelvam@amd.com, airlied@gmail.com, simona@ffwll.ch,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260309022229.63071-1-chenyuan_mi@163.com>
 <20260309022229.63071-2-chenyuan_mi@163.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260309022229.63071-2-chenyuan_mi@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: c05140ce-ae28-44f9-80a3-08de7dc3c007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	tC3dKxL9tf9TGeP2gkYhfRSsgW42kBcQrSL5I6Y7NjjkOkmujbzu++IGZKZDecNccXfMaxKoOgySFIStDTSO2ARpVdXSv1LjlIcSNecTAIzA1Hte3OR9Ul59KpiYZsoCA8EipbDEliBl4XB8vk67KUx14AWJa1JicahEt1wcA9r1MQu7mVKnMcGSOVtqmNzgk5eu0jP6HZHgQKjq3wUM4DbgEUP+fK3pdlKIeijI+L4OMNUlYx10faEct+Mv8wTjAd9+GlC3VWFYRLXymmfr3lo3mvykyK/KLc4zLZu9FDJ7NpclhtyQeui1bZAJMiuzXqXOSi3SEwypBPem6QP11h8FfxyImGnDBt6L+tm1ttygw9yzxJNParlNkuTsBb3YHHOuRYMqdIwYTMTyMDBwdfGSPuTqZCAMZFHiLbBMwXt1xh7yQqhBcCFy+qKB7IfxLU/74gWalEZMtjXlfL54avgutbVUaxDj2123pXRHFwNF6KCC+SKnRPPjTpfCojfjwHbyXcYp/ItvMKOTgB50jJS4rHK0MUmGakPfjlffJFHO7E1VE9Ltm6GUWjzAZ3VOJe67pjx0GcGkLq2XB91Fzpzz5KE7k8n147V47QpFrbAXsFxsqEu8zckvrzr219WuC4jCo0Qj049MwFWhOt7prN9VNeN+f6Tm681HWuXzyiF6gxJ3X8zMwBgGLCJGX6cr2YIP1ceq6JFYEDBWyuLl9Xy/+YFSIW9JW1szz9nhtio=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHBYeXhGZW9vbWFMR3JHcmk2dmM1bXlMMnlQVTVnUnltWTNlblpkMTk0TzA1?=
 =?utf-8?B?MDVKN0hwM1V6cFRSald6SkdmaGFYY2RmYitkOFQrZVdDUUl6dXpEdlMwVk9n?=
 =?utf-8?B?ZnEwSUJNWkZCcTUrWTMvZ2pRSXl6bnB3cm9xcXYrZDQrWm1lT1dEMlhsaVNU?=
 =?utf-8?B?ZlRKTDZoWVBnRktJQ2Vwd0tibEVZalFuUFNsZHdXUUFEMitQRGJvOGRaZ0NI?=
 =?utf-8?B?N2FSTllaaERRV1FIQkxZUEdCbUZhb1BscW5DcEsveWh1c2FPclBLVFdaOWZD?=
 =?utf-8?B?cnhlbjZ0T2YreStPbkxDWmN1Y1I0V2ptR0ZpTGZkNk0veEZJM3BwU0FqMmwy?=
 =?utf-8?B?Qk1NUVdNc25kS3lkbWN6ZkQvdlZXUEVkd0FkN0pzd29tck1ERlJUVzRNUW5h?=
 =?utf-8?B?NXVWWFZxSDJ5M3pZeXh5Yk53NGhjbU92UjB1Vy8wZFlpdHNjZ29QdWFvK2lL?=
 =?utf-8?B?VU91YWVYb3Z6WWhidkp2bXZpc1ZjWlZFRldGMk5QR3NzczlPTmgwU3hMek1v?=
 =?utf-8?B?SnBDaEF2YmhWRHAvR0gxV3Fmc2FPelZKRXdUZzB0b2pEQlVWSHdNc0xISGdj?=
 =?utf-8?B?V1c3aGhXUFk3MWlvYjhUa0xscEp6WGxNOWlXRE5nWFBjbjNyc3BBN3RuRkhz?=
 =?utf-8?B?eXNwYmxpaGxGNDBSajV0bEtRMmJaTXFLSENBcU1wVWd2ZFR2NXFwdnFneFZv?=
 =?utf-8?B?Yk9yVDhVNE9Wbm1zcmtFZUdOR0ZGQVV1MTgramV0ZnRHUTBIcTNrUmpNZkZy?=
 =?utf-8?B?VlgvL0RzOXpkSkVkaHlPUlBkRktFUmNlbk5tUkk0Q2dpU0ZvNDdld2tpaU9G?=
 =?utf-8?B?bk1NYkVFMGk0UUd6NlgyU1RabC82MHVpa01GeHJYcG1hN1RRTGpyc095MGpQ?=
 =?utf-8?B?ZThtNzVwc1k2WW1tdXNRajc1Y1hWYk1nNjZ6NG1meUJuaGp2cFFwMmwyL3pG?=
 =?utf-8?B?SVowam9yb0JoQ1RDZkFBZ3BxV1QxRUhiTmZ5Z1dvNUtrV0V2ZEF5a1RKQ1Ry?=
 =?utf-8?B?T2lKTkxXZXBYZTdoQjZGRk1JaXE4UFl2OU1DUzdnblZpdlM4a1p4Yll2dHhN?=
 =?utf-8?B?bUxYbDBNRHlNaUsvYmxzN1YvU0hvYzNmTGFBaUZWWUxRMXVNNzdQMmlGQnly?=
 =?utf-8?B?aGplK1l5dUw2eUFnR0J2K1FvTlJueUpKM2dFRkc4ck00L205MVI1Ny9wZk5V?=
 =?utf-8?B?N3pWT3AySTFOS3ErOHUxZWUwcDg0MldJQU9NL254a3ZSeEFWKzYxUjgrSHU0?=
 =?utf-8?B?TGVhTnRjdTlyREU4OWNoTUozY0VVcEVuQjQxUXZCYi9sajRxVDdJdCtKaHBC?=
 =?utf-8?B?Zlo3NW9aOTE1QVZEYTZtbVRZek5IQm51ak9VdXk4RTNidVEvc3F4anQxQUU4?=
 =?utf-8?B?c2xmYU45V3BzNzRDKzFmc3V5Z1pjRnJkMWNRVit2TDQ5WXlVcjh3UU9uOTB2?=
 =?utf-8?B?V2JLLzY4VXNkandhaGNxZ1pWN0FSVUhpL0lyTWQ1VjRGcUttUU1UM2dHNTZz?=
 =?utf-8?B?OTNFUEcvV1lSbnhmTDhBZksrRVM1ZjdsSUgxSjY5bjFSUEFIM1NSRkxOUmxM?=
 =?utf-8?B?TTdLemovSVl1N2RUeXRqa3c5dk5mL1R6ZkhDZUg4Uis2RkZmTWlrdUJJd0Z6?=
 =?utf-8?B?WW8rYi96OWwwM1hmTGZ2WlFCL0syVGZNOGNVVEhaSk9vU1dBWFczaWFUemVo?=
 =?utf-8?B?ZGJyemJqSlJmNWhUTHZYQ0hMK3dCK1E3V0F1T0d1aElyaE9ySXRPTG5Rc1Bx?=
 =?utf-8?B?ZG9uYVE2TTY2SE1ZWEkxOTBUVVl5amhzbDd5Nk5sUWR5VDJKcDJOUFV5M3BJ?=
 =?utf-8?B?YmVVRGZwK2UvTG93QjdNK2FLV1NvUXQ2aXNrT1JSZWZiczQ0WkJBdUg4bitv?=
 =?utf-8?B?ZnRJd3ZvZ25LTll3dXBvMHh5b3hVbCsyYy83QkhKL2kra21qSTIxNHRVa2Z0?=
 =?utf-8?B?dk03eXBTK082Qm1PQ1kvNzlMaU90alZ3WmpzTHcxNUJNNnZ4K21laXhGMm5B?=
 =?utf-8?B?NzJnWnMyd2c5N0dPRVZOakFHc3FYVCtUMFRwVFJTUnN1ZEtzeVF1d0hONjVx?=
 =?utf-8?B?VlBzck5ORkMwZ3AxL0VXd3BNWWtLRjgrWVJzSEo3b1pIdG85NUtBZE9BMGZi?=
 =?utf-8?B?bFJBWlViY1hjWDh2VlZ2VXZydFpReXdmNHFTVWdzRkNkenh5N0ljUm9pK0Za?=
 =?utf-8?B?OFljZDM3TG5yUHJVcXhMRHFyY0hrZjNxWVg2WnlUa1RRUVFnaHVwa1Vnb3Fx?=
 =?utf-8?B?VlZCV0pyUkM1R20yYlB3MlZXdlhpYzhhcE9ZTkRISlk3RFNaUVI2SUNBZC9Q?=
 =?utf-8?Q?OCGBDTnhZnma1Wa+Tk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c05140ce-ae28-44f9-80a3-08de7dc3c007
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 10:08:02.9262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkVdWjjsYa71pIA0DmJc7Gu75+8yuA2CUkqkyITQ4VdsHyKt0uJF8cspdcEx9wv3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7939
X-Rspamd-Queue-Id: 0F025236C5C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-223516-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[163.com,amd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:dkim,amd.com:mid]
X-Rspamd-Action: no action

On 3/9/26 03:22, Chenyuan Mi wrote:
> amdgpu_userq_wait_ioctl() accesses the wait queue object obtained
> from xa_load() without holding userq_mutex or taking a reference on
> the queue. A concurrent AMDGPU_USERQ_OP_FREE call can destroy and
> free the queue between the xa_load() and the subsequent
> xa_alloc(&waitq->fence_drv_xa, ...), resulting in a use-after-free.
> 
> This is a regression introduced by commit 4b27406380b0
> ("drm/amdgpu: Add queue id support to the user queue wait IOCTL"),
> which removed the indirect fence_drv_xa_ptr model and its NULL
> check safety net from commit ed5fdc1fc282 ("drm/amdgpu: Fix the
> use-after-free issue in wait IOCTL") and replaced it with a direct
> waitq->fence_drv_xa access, but did not add any lifetime protection
> around the new waitq pointer.
> 
> Fix this by holding userq_mutex across the xa_load() and the
> subsequent fence_drv_xa operations, matching the locking used by
> the destroy path.
> 
> Fixes: 4b27406380b0 ("drm/amdgpu: Add queue id support to the user queue wait IOCTL")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chenyuan Mi <chenyuan_mi@163.com>

Well this trivially causes a deadlock.

The correct fix has already been published by Sunil quite a while ago.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 8013260e29dc..1785ea7c18fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -912,8 +912,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>                  */
>                 num_fences = dma_fence_dedup_array(fences, num_fences);
> 
> +               mutex_lock(&userq_mgr->userq_mutex);
>                 waitq = xa_load(&userq_mgr->userq_xa, wait_info->waitq_id);
>                 if (!waitq) {
> +                       mutex_unlock(&userq_mgr->userq_mutex);
>                         r = -EINVAL;
>                         goto free_fences;
>                 }
> @@ -932,6 +934,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>                                 r = dma_fence_wait(fences[i], true);
>                                 if (r) {
>                                         dma_fence_put(fences[i]);
> +                                       mutex_unlock(&userq_mgr->userq_mutex);
>                                         goto free_fences;
>                                 }
> 
> @@ -948,8 +951,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>                          */
>                         r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
>                                      xa_limit_32b, GFP_KERNEL);
> -                       if (r)
> +                       if (r) {
> +                               mutex_unlock(&userq_mgr->userq_mutex);
>                                 goto free_fences;
> +                       }
> 
>                         amdgpu_userq_fence_driver_get(fence_drv);
> 
> @@ -961,6 +966,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>                         /* Increment the actual userq fence count */
>                         cnt++;
>                 }
> +               mutex_unlock(&userq_mgr->userq_mutex);
> 
>                 wait_info->num_fences = cnt;
>                 /* Copy userq fence info to user space */
> --
> 2.53.0
> 


