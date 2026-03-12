Return-Path: <stable+bounces-225216-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIyDLtAss2ksSwAAu9opvQ
	(envelope-from <stable+bounces-225216-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 22:14:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC43279D6E
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 22:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 26F893023A8F
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E7D38B131;
	Thu, 12 Mar 2026 21:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OhudFM3C"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011066.outbound.protection.outlook.com [52.101.62.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B0C3C3450
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 21:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773350074; cv=fail; b=BzbwaoS+48nSwvykYrsbNn31U3Bvre+8l6Eh/dcj0KAsWQvqNvaHVHvwHBP69ns60Pc5HKha3JgpnchXRPlcGeszr5Rkr37UldZzeDjIfD/tCzk35wMr+nm67NLqKHOvVU25AI70eyjCRK4dbQdA5L1bzf1MlkUFUDDUiLlR5pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773350074; c=relaxed/simple;
	bh=BCuekBzLh4fOtKxMuAkKSFDlky6o/qdlfFnKycisPAI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d8zzlDlN9hcKtWmP6dywODh46ryMwc5nlakyCmEF5dsNNS7vOtPxROK2OvoXozKqbXe0bPzucPPo9EBPnMXddHvgC07XWII6e5VkOp5T3JVbTSMPv2tz7X/lYJo6Ltmk11f3ewF9Oq0rkTdqECb1Y4m8P3A21FB7k+LcRWelDf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OhudFM3C; arc=fail smtp.client-ip=52.101.62.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7j2gXwFNYQCZhVuU8WyC9VEAjWUuGGSy0LKlCWc9QPXhFNC4wRQ7NUUwwiZKt6Ilng3Nvjo5Px3MWK4nhNfDlX5wkAi2G9LVpGana5tfnyxwslj+tfmX9ieekZqT4OC4yje5DjgvSwifGLSK8HHIsfBAptQeSDxhoAN3EdWbXH1KHaHpbJFHBQMwCpkZNkMMsp7VgUdrMtxN2EvCwwp3/KZ3fowU22yzxkA4kJzYzvdJTxgcp+LaLvlMl/z5RVSKpSqctmWt1WdMMpZ6gzw29UpHWo/ilbvO5/FCZU4bWf6RH4yh+BH/nKjfEd8tGpJN75o6artJ0mrcLaywBcfpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8Rio0BOEwIErcLOfMSEX1Y1QOfuaFsDpAhCViRqW+o=;
 b=hub/cHDM9Xm7Wj3v3tfSGWHM12Fk1wtxKnxr2gxZN4GEXAxqwZ4RGDORrKUjBRrvYu+o1t/iLMEwSoaJ7h7NHlhXLLxcVfZnTrqfPlR0cr5g5K5cUiXMXV3fE3tewLIn5m4jT9B/jcyXhc2+6d41Tnwu4O40ZpneLrC167Yv+dpfEj8+F/Xw+qSe8W9mGJ4+gL77hQRLGO2J59A9A9GXDOXhzmixIzmaz+nVvcPH5MjQwlVdlh8R3FMto2Ud60LxRVv63o2k0IUQZoHw9GudppgOJN3WR7DS9jVMgbkzA3vfdF2z8CY2RW0ocveOCs5n4eCJcsTZ53KJkCanNpeezw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8Rio0BOEwIErcLOfMSEX1Y1QOfuaFsDpAhCViRqW+o=;
 b=OhudFM3C99ybFsVyx+VmgenG3mT00PFQwXFGQNsJ7HSnQhvvTUFWLYxo2C1lUB6etUITK1zeb20rFz3UxA7mLk8WM/4YQDgdlWP7VQ1CJJ+F29DRi8G4+SKl62alJfHLL29fMmtamJ4+5mqGfGGXA4VWO2ldhN8yXJR+j5LUrbk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by PH0PR12MB7077.namprd12.prod.outlook.com (2603:10b6:510:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 21:14:27 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9723.004; Thu, 12 Mar 2026
 21:14:27 +0000
Message-ID: <ef24d3dc-28f8-4ca9-848a-c480337aac04@amd.com>
Date: Thu, 12 Mar 2026 15:14:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/colorop: Fix blob property reference tracking in
 state lifecycle
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: Simon Ser <contact@emersion.fr>, Daniel Stone <daniels@collabora.com>,
 Melissa Wen <mwen@igalia.com>, Sebastian Wick <sebastian.wick@redhat.com>,
 Uma Shankar <uma.shankar@intel.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Jani Nikula <jani.nikula@intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 stable@vger.kernel.org
References: <20260312204145.829714-1-harry.wentland@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260312204145.829714-1-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0117.namprd03.prod.outlook.com
 (2603:10b6:303:b7::32) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|PH0PR12MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: f8716470-f6fe-45e9-3a94-08de807c57d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	u6Dl/T0THSkQ8kyThYwdX3POncjAQMd5WzEagrEBAlntSMBWsBhdb/dlQ21IyS6MhHy5cGuuzfILZ5iHP0pofPbJVlVM0HM3XxKxE8XVJIxlGJsbj/whANQkwT0EF8Ye4wjUH/OoJBM1aDLaKUx91KxghTC935Is7bla7jqP/+XHlJBFcuiwzAkW7T2tT5jFfMfrU5HrjOApWmbXY4Swh4/+P4ogu7Wt7zHMNf0naXzfZEq+Cmdna/hsLcy6im/gFiMYCooJ7i5449tlOzaGRbpav98FXcTHuGXblYRbhidlLesGn6DvmdOZCfzi4Dc/2qI6KnGXcBicJodBfQrjIYOi6iCwEQSBOK1UYZ9InV58cDhGcbm16BicTyrUlYJnGbK+34T/9jupws1S9i4WFRldL4E15rH8S8pX8EvuSaRgbOG6nzans90K4lvEBjljjXAd7ckHcW30+lE0SW1Tv0tctbuSJIPQ6SMyaC3qdTcugnZaDzPZJ70uHcQvcD6fidSlcnlSl/+aAM+ebfXmw1wlDsh5A2kpv946B+WDHmuLFdSN1AZ1aRTyPg01aL0F41F9yZFjrIT+MpYBOhg+DPRtOH0FY3b/0Q95FON1EJ/SuXzQKcgWr1VeA9/bAOrOCaM7Ct4SiAzZAVkP7qZCJVDRKbzbgiW2QyYwGCtxTJYBiw7J+napOJw2Shn4kzAalDNtuEp3KyBEC1l2wgxQVrVI+nKgxIDFKAL6yUU+9m8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8476.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckRwaDUxVWQwa1lOWmluR2pDMnZIaGFhWndWeUUzb3FLc2hiMXhMc05iVUpP?=
 =?utf-8?B?RmlaeGJ0d1VtOWhPaDNFejVzY083Smh4bW4yODdqcVFTQjlWR21TTnIyRjFN?=
 =?utf-8?B?a2xCamp1ZU8wTWlLMGQ5cUszZUh0bGtsNjhEMnRYc1NhM08vRmtMRTNjSlVB?=
 =?utf-8?B?bkJwSmNQbDdLbVJqUTd6NmIvdEF5T2hyT3hyZ1ZXSTF4UnVBSEJsaWxIMmJ0?=
 =?utf-8?B?eFRkU0o4eXhJelVRbkcxY2FaeGNyMEMxVXUyZ1M4cXVab081Q2FhZjNybEVl?=
 =?utf-8?B?VGJQeWE4K3lqckVQNHpVdWFpN3ZaTnUvcnRWcllsZlpOamxadTJSN0cwY0Mw?=
 =?utf-8?B?NjNWbGNpVjc2VUI2b1lUR3poWGVBNEgvRWNCMXdQdjVyZmltOSt2bjJFTnZH?=
 =?utf-8?B?ZElwdi9nbVpidFVTdS82bW9ZTU9IeElXUHRuRG51TFU2NHBqa2hpTjE0RkFS?=
 =?utf-8?B?OTBWbEJ3elhWQlJpekhpWkk4UDN5RVpUTHA0TGliMUJsZldQcm8yY2ZCUm5O?=
 =?utf-8?B?OFlkbk1td2EyM1U3VlpZK0FSNlI1OUEydmhEWnlMNGZNSUNqRE5ER3YrUFhp?=
 =?utf-8?B?bGxSUncxTWpRVkh2UGVjYzNRTERLTXRzUU92TGNpVjdpd3ZYRG1NKzAzdllm?=
 =?utf-8?B?azRRbkZ6aGx4QXU5MzFPQ01idjRRbHBMN0ZjNVBxaGF0TDZmblFYOFFLd2FT?=
 =?utf-8?B?a3F5NGVvd1dqdWMxTTIwZWtkZEE0WWpKS091eit1SFZTemtuSXBsSW9rZHVS?=
 =?utf-8?B?QlE2Z1NnNkNuRXBlUWhMdEkzVnp0QVZVdGp4TUZ2R0JCSktsN2pPV3M2TnVT?=
 =?utf-8?B?Y2hHRW5SbEZNY0NaZ08wcnM2UjgxdWNqOFNSOS9sRjZyYWUwb0szNWdvczdl?=
 =?utf-8?B?aW1xUDZIN2h4UmdwZ0Jrd0xvNGszNXhxRFQySzhYVTZSL09FZzJZVmE4Ung2?=
 =?utf-8?B?dFdoQWl2WU1kRFdYdms2RCt5aDczejVaYkt4clpRcnJNRGhKeHh2dzVxTEdC?=
 =?utf-8?B?amEzQ1k0dGduSnlRMlliTGZzQjI0cEJhWnlCbndYazB2L2U0eUM0YVBtemti?=
 =?utf-8?B?WXZPSTh3RUdSUHdIeEtxK051S09pR1cvT2pHZ1U2Rko1azhBb2lqUnpTR1la?=
 =?utf-8?B?WVVtZjFDSUw4dDBDSWo3aUtCVTB3VWpQS0tjeUVlTEJSY3lEcmxxeUJPNVo3?=
 =?utf-8?B?ekF1MlhNMXF6SjBMQ1hDMzUvZVFreTYyem51LzdwUG1rS1ZQNWY0cURsa1Zi?=
 =?utf-8?B?VTRxQkp2Z2lySnZmQmxySjYwdjlpN1k4dk5BVWpRbjFxdVdSTENPSnB6M2U0?=
 =?utf-8?B?WjJ4ZWN6MklxZG5zblhrdDZiN1lKcFVCOWdiekR6UEdhZnd0aFRUMUFPbnpN?=
 =?utf-8?B?ZkFTWFJYN0pybnpRYTdjK2NJQ3JUOHpSNUlJL3ZkSndNci9tMEUwbUdwN1Nq?=
 =?utf-8?B?Q0RKWVVZTDJKMzgxajV2UEdlSnBDV2pGNnhQL3JpUDBuL05oOWdyWlpHT0ZV?=
 =?utf-8?B?bUh0OXJNd2kzcE1DOEE0Yk4weldnUGgzTHhiZW1wdFB5NmgydkRuUmlTbFEv?=
 =?utf-8?B?UzJlMDJ3WkZvd3U2V1dzNGxycXVySmp1SjE3dk1uWHRCZUFwcFFVK1NIL0g5?=
 =?utf-8?B?aHNuU3pMMktvWHFNRUxnemFJREFoVXdYOUVQeFhyTUErTHFSNkJwL1NqOFRu?=
 =?utf-8?B?eU1xY0JzSlkrNzd2RjRzWWoxVDlZb3BXVEtRcU5mZ3kxRjI0TXZMekNyVGNM?=
 =?utf-8?B?eG1lVjlpN24zblVpYm40QWtRWDkzT2FNTHgyMmRKOGduWnNkc2R6R1FkYmp2?=
 =?utf-8?B?cGpjaVBGUWxIcE9na05ld0RtWkYwZ1FqczlESjFnT0p2WVExYVJScFlRWTNz?=
 =?utf-8?B?d3F3NXdOMEg2N0hrL28yU05BbXp2VnFweGRDY3lOM3RaM3JKNGJTNEVZZmNx?=
 =?utf-8?B?K1RQUWFpUUtaNTQxSWo5SWI2bVYrMEcxUEMvSVFsV3YrK3hTTjhRQmFPQ2Vw?=
 =?utf-8?B?M0FQT3hRazlrNUpxdXN1cG9YcUxRa0I2dzlYcThDVHdNVWJYa2F4SkgwS1NO?=
 =?utf-8?B?RG1haFFoWnZiSkMyQnBwL2pLbEk3Zi9udmtCeUpLaElBYVNUNkhxWHp0RVk0?=
 =?utf-8?B?M041NWxzWm03SUhrTnRFaktYUUhuMVdZbTB6S3FxZmlFUlIzMnFnSzBZSytl?=
 =?utf-8?B?b2xkY2szNDNWa1BNNENobkVsWDZ4UngwVFR1UWdrdXVMNEppeFlnVi9qT3pU?=
 =?utf-8?B?dWZVb1dyMmV5UnFrSkhOUzhBbHo1RlMxekVLdDdrSWUzWnc4OHJzZGhmSUZq?=
 =?utf-8?B?bFhJNUxNNjQwak5sRzJsYm1jWWlROXhXdEhHNDAwUkZEUis3NzRkQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8716470-f6fe-45e9-3a94-08de807c57d2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 21:14:27.1888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naIiMOVjTF/G1fDP+nJ3a+y2hA1gASryZLcSM9SjIv33MF23snH4HHNFHTKM6UFbGor2UaLAZAe0opHdBMJRYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7077
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_FROM(0.00)[bounces-225216-lists,stable=lfdr.de];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex.hung@amd.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+]
X-Rspamd-Queue-Id: DCC43279D6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 3/12/26 14:41, Harry Wentland wrote:
> The colorop state blob property handling had memory leaks during state
> duplication, destruction, and reset operations. The implementation
> failed to follow the established pattern from drm_crtc's handling of
> DEGAMMA/GAMMA blob properties.
> 
> Issues fixed:
> - drm_colorop_atomic_destroy_state() was freeing state memory without
>    releasing the blob reference, causing a leak
> - drm_colorop_reset() was directly freeing old state with kfree()
>    instead of properly destroying it, leaking blob references
> - drm_colorop_cleanup() had duplicate blob cleanup code
> 
> Changes:
> - Add __drm_atomic_helper_colorop_destroy_state() helper to properly
>    release blob references before freeing state memory
> - Update drm_colorop_atomic_destroy_state() to call the helper
> - Fix drm_colorop_reset() to use drm_colorop_atomic_destroy_state()
>    for proper cleanup of old state
> - Simplify drm_colorop_cleanup() to use the common destruction path
> 
> This matches the well-tested pattern used by drm_crtc since 2016 and
> ensures proper reference counting throughout the state lifecycle.
> 
> Co-developed by Claude Sonnet 4.5.
> 
> Fixes: cfc27680ee20 ("drm/colorop: Introduce new drm_colorop mode object")
> Cc: Simon Ser <contact@emersion.fr>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Daniel Stone <daniels@collabora.com>
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: Sebastian Wick <sebastian.wick@redhat.com>
> Cc: Uma Shankar <uma.shankar@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Louis Chauvet <louis.chauvet@bootlin.com>
> Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> Cc: <stable@vger.kernel.org> #v6.19+
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   drivers/gpu/drm/drm_colorop.c | 26 +++++++++++++++++++-------
>   1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
> index f421c623b3f0..647cf881f413 100644
> --- a/drivers/gpu/drm/drm_colorop.c
> +++ b/drivers/gpu/drm/drm_colorop.c
> @@ -171,12 +171,8 @@ void drm_colorop_cleanup(struct drm_colorop *colorop)
>   	list_del(&colorop->head);
>   	config->num_colorop--;
>   
> -	if (colorop->state && colorop->state->data) {
> -		drm_property_blob_put(colorop->state->data);
> -		colorop->state->data = NULL;
> -	}
> -
> -	kfree(colorop->state);
> +	if (colorop->state)
> +		drm_colorop_atomic_destroy_state(colorop, colorop->state);
>   }
>   EXPORT_SYMBOL(drm_colorop_cleanup);
>   
> @@ -485,9 +481,23 @@ drm_atomic_helper_colorop_duplicate_state(struct drm_colorop *colorop)
>   	return state;
>   }
>   
> +/**
> + * __drm_atomic_helper_colorop_destroy_state - release colorop state
> + * @state: colorop state object to release
> + *
> + * Releases all resources stored in the colorop state without actually freeing
> + * the memory of the colorop state. This is useful for drivers that subclass the
> + * colorop state.
> + */
> +static void __drm_atomic_helper_colorop_destroy_state(struct drm_colorop_state *state)
> +{
> +	drm_property_blob_put(state->data);
> +}
> +
>   void drm_colorop_atomic_destroy_state(struct drm_colorop *colorop,
>   				      struct drm_colorop_state *state)
>   {
> +	__drm_atomic_helper_colorop_destroy_state(state);
>   	kfree(state);
>   }
>   
> @@ -538,7 +548,9 @@ static void __drm_colorop_reset(struct drm_colorop *colorop,
>   
>   void drm_colorop_reset(struct drm_colorop *colorop)
>   {
> -	kfree(colorop->state);
> +	if (colorop->state)
> +		drm_colorop_atomic_destroy_state(colorop, colorop->state);
> +
>   	colorop->state = kzalloc_obj(*colorop->state);
>   
>   	if (colorop->state)


