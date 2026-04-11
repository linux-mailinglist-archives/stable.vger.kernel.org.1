Return-Path: <stable+bounces-235702-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOZ9LoMU2mmAyQgAu9opvQ
	(envelope-from <stable+bounces-235702-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 11:29:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E26D3DF280
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 11:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCF3A300D163
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 09:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E7A3346A0;
	Sat, 11 Apr 2026 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qyhQxQkD"
X-Original-To: stable@vger.kernel.org
Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012064.outbound.protection.outlook.com [52.103.72.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE654329C49;
	Sat, 11 Apr 2026 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775899721; cv=fail; b=VLfvZjE9KXr2UA15UyplIK8WzbeLi78cce7Ahq+Q2pGWoY58ntyNFymg9n/H6J8zbCAynR8juG8pCqDPwlRnvSoWJE4IDHwggpDzHqEhvoTTrmb4vxh4F3KTA1miN29XZ3ZrHny497tXg6038OFjseQSbCpFrKhwCSXnMeLBPpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775899721; c=relaxed/simple;
	bh=zRZkjXV3612LX9Di4UjXyDzBKOQKJaLigT/FrF5elFY=;
	h=From:Date:Subject:Content-Type:Message-ID:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TmJ/AsSisL7Hk7tMuKZZYnDn0owsDO9jjMpRAl3VqM35ixThYwPE5z4IOGgj/6ba2xYTt+hxNMOaE1Xq6Bt1gbIGbava3Es6ACYCHY0dDZyxV5VEolXfzwxRKLROoJkVb+uQ+s4r4RDNshXs0DmR0pvaPPKWrJcWFtOTJJnjJ34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qyhQxQkD; arc=fail smtp.client-ip=52.103.72.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMbnDoglKpiYripidcD4zjH7C051sM5k9noaDAHCLRFt1shHoDxh0v3C3PtCbDaue2evjeTz8OcooItTCQ59B7Y1Psl/s9nQGVlTxaDdHecL4ghBDjHPxNZdsLdzRD81B7mmwfP+jgYVOPCgDwxG9GensSSd1qk6LD20mWwKhiL8zB28eH2AOPpNZlAkNk7K33qiD7h/URrU/4vEDtMYB3ybSHNnSU+say189Sde0bkwctkD07f9ps00ebFrwJWDrweR6LY4kf1hkiqI627iWygs3NIDeT1v91r2ZW5tDSKjetga9ZSMTUryLsxY8Kr9SRmmnzOi22dHx6N4aMxg9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKAFu9cvwgTebL80bCrtFpkvRTy0Lwq9Sz81xkmbNxY=;
 b=n7FNbihy/dWUIJ+XTrgfaBfSSoxj2+ng8ecRHQ/hWcs5xhsD/jRTqBWm9s6cM78c3vlYWN0LzAJiSh4tCIbpaUplrDbsVk/kN1j0QZ8H0IIRFnHfJ35EfY9L/ER3P5iLZjiI/AIZlPI+x0+nKPdtLoi1YwcqDxUu1oWJWms46dR1hwr7ZCEC9duHZOYJK7vsEn56ks8VPehApqCvhhX5g65hPUeoUMM1qsPxICumvHwAbh1ejNMrThHkmLDf/dcUTcMoH36hdiq5KWIsOGvBaZdWhlFSNdjBls7fFawUO2Ishins1wOebeWS59fn26vPMj+mcQqBNyzqE9lh+k6D7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKAFu9cvwgTebL80bCrtFpkvRTy0Lwq9Sz81xkmbNxY=;
 b=qyhQxQkDEVcKcPThKTt0I02nkZKEUuKz2OSQPcMP5lKvE+mtY5AObD4ibX3/r/KxdE+JkuLPGPpdjStjTl9Yg+oVWP41K92l9H00gFdTvlOTW7VivA0yYTlI8nYK8lhDjeKVNZzSuvvXayACQ8hmi2PkD5iJHRNloPdnVLQ4lItIMyMm8upbYrqSYy24VhO2w7I7qW7bf3Sn5mInACZoeKiKP5AJn9bD0BXQ3wCtU+7EQLL0qvt7sKQmwsNIv1I+8ii/i/QAzkHJkN3La4Kgc0ZzbND1JU5kvGUQku84IKZyDH/++UhWy8f4So9oASO40dE1Pr4uPXTa2TXisHadDw==
Received: from MEYPR01MB7886.ausprd01.prod.outlook.com (2603:10c6:220:17e::8)
 by SY7PR01MB10897.ausprd01.prod.outlook.com (2603:10c6:10:336::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Sat, 11 Apr
 2026 09:28:34 +0000
Received: from MEYPR01MB7886.ausprd01.prod.outlook.com
 ([fe80::19df:3891:d8aa:692d]) by MEYPR01MB7886.ausprd01.prod.outlook.com
 ([fe80::19df:3891:d8aa:692d%3]) with mapi id 15.20.9769.043; Sat, 11 Apr 2026
 09:28:34 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Sat, 11 Apr 2026 17:24:50 +0800
Subject: [PATCH 2/2] drm/amdgpu: fix resource leak in amdgpu_userq_create()
 xa_store_irq error path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <MEYPR01MB78861FEE082D0292AE193D5CAF262@MEYPR01MB7886.ausprd01.prod.outlook.com>
References: <20260411-fixes-v1-0-5f31973443e5@outlook.com>
In-Reply-To: <20260411-fixes-v1-0-5f31973443e5@outlook.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1282;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=zRZkjXV3612LX9Di4UjXyDzBKOQKJaLigT/FrF5elFY=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGzFvCiQ97qh8oH1aJmbHDti0549Tze81LJd+rX1DlL
 yx0PhvyOrujlIVBjItBVkyR5XjBpW8Wvlt0t/hsSYaZw8oEMoSBi1MAJuK4l5Fh7gmW55siPu7b
 EzxpgoK3pfBG/pLj560uNn3m+9ZVcnQXPyPD2QdN0U59H7Y/eyPG/tDoeM+DyJPZf0omGzouD79
 zLTqRHQBFMk4o
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: SJ0PR05CA0135.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::20) To MEYPR01MB7886.ausprd01.prod.outlook.com
 (2603:10c6:220:17e::8)
X-Microsoft-Original-Message-ID:
 <20260411-fixes-v1-2-5f31973443e5@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYPR01MB7886:EE_|SY7PR01MB10897:EE_
X-MS-Office365-Filtering-Correlation-Id: 39890d07-658c-4fd1-a3a6-08de97acb406
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|51005399006|23021999003|19110799012|461199028|22091999003|24121999003|6090799003|5072599009|15080799012|40105399003|440099028|3412199025|26121999003|12091999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUNvbWtmU0c1Z0JUVlVNYzhCVndVenV6d0VLeDVvUEVBZGJUTW9YOUdpVk45?=
 =?utf-8?B?SDJ2NkhMYlFDbE9oOE9SMkRNU3NqejJqSHhDdHg5dFh3QWRFbTVORmV4N1BW?=
 =?utf-8?B?UUp6Umx0T25ScFgwNklZdFljczdMaERIL08yOExFSjJTTHFTdDAvZVhVVDg2?=
 =?utf-8?B?ZzZXaEkyb2JVSTdBeUttbGY4YXprZ2F5M2gwTDlDczE0RXNBVUhqb21jUEpJ?=
 =?utf-8?B?WWE0NEViQkVHcVc3TWlrWU1VajdnTmJ5R2lvU21JZnhJL281cnMvdzVLWk9j?=
 =?utf-8?B?UGZpUU15amFpNW1MaGE1MzM3SzdxOEkrbVR2aFgzTWFsaUxwMDdRbmk1dVla?=
 =?utf-8?B?dHFIMm5LREE0bzdRTWFielZYd3N0UEprY1QrMXAyOHcyck4rM1g0QmNDdUdQ?=
 =?utf-8?B?b2EveE9GbFJSVlRVdnBGSEVOb0VsNlFaTEd6YmxLdUsxd0xVeVpqaUNMSVpn?=
 =?utf-8?B?UVplMHFzTmhlMTBxNTk0VThJU2dIYmorUmhDaVBYNTlWSFpmVHJNSHkwelRi?=
 =?utf-8?B?NkIvYTN5ZzRxM1N3S2VaaVo3SGZsSWtJdlpEMnVlakdWQ1NSdnN1TmQwaFU4?=
 =?utf-8?B?Nit2SUJzaWs0M3JkNCtjNk56MlZEZFhsZ2xKKzlkLzZ2Wi9FV1Z4eExBVHhl?=
 =?utf-8?B?UFVWV2dxSGg5VXlCRVU3WDRucGllNjFnZi9XYS9ucXRhNkhMVXlOdjRCaXVV?=
 =?utf-8?B?c2lWbzNxTVlONTYvTEt6aXh4cmVEV1E1eXJ5QmtzRnViSVllY2ZwQThXKzlG?=
 =?utf-8?B?VGpKb2xuMEVHV2l0MEhJNDhiR1VESk0xaHZla2h6Y1lUeDViZEZZaGRNM1Iy?=
 =?utf-8?B?bXlNN0JLVUo0SkZBcG9yMm9FZngvQVNpWENaSE5wNHlHejB1cGVvMndGeXQ2?=
 =?utf-8?B?T2IrZWx3YWdXTGllMXJuRjd6bEZMeHIrNGRFc3VObUNQd1ZVeFNvRjRsUjVh?=
 =?utf-8?B?OEZ0NVg2VjluTXgyZjNtdldUekhIcUpPMW5pR1pLejBXdWhwc1RmZUQzOFpo?=
 =?utf-8?B?YzZkN2VVMjdiUFhRTEp6R0F2ejVkM2czRkVJOUdJcTNvNHo1NWRqWVNyQ2k0?=
 =?utf-8?B?UXNoZ2F4VHlsWC9JWml2SER3ajVlQXhxOUZaTVlUVTF0cDQ0VkJFU08zcURX?=
 =?utf-8?B?b2E5WVRNbXVibU5BQTlZSWRNbzBkNEU5ZVArWHg5RythOEpneENOUk1sQ0Fn?=
 =?utf-8?B?dG84b3ZvNmpJVWZpZ3gzV1FHOFRBVzN2MkdjcFpDWVRWQmVDWExFR3NFYkRv?=
 =?utf-8?B?ZEYxTlZVaVRBbldWNkpOa2krZXlVa3huMlFnL2tvODQ1aEFFWWhtVlFyVmIx?=
 =?utf-8?B?U21jTXdsdmNyMUFiajBQdGpFdFRyYkZBakFwK2psbWJYeXRNUUNwY3cxaGdP?=
 =?utf-8?B?S1A2c1JNYW5KU041NDJ3bnFvWkdZQWhBZ3NaVFkrUDlZeGRlY2JnRHRqSWZm?=
 =?utf-8?B?MlRXYTdISGN0WWhYRkFsTnFXelUxa3Q3WGFDQ1pnPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bytKelBkOTVxZ1FGSE9pUUdQTkpSQjRmTVRpak96YjhReHBYMHpZbi81YmJQ?=
 =?utf-8?B?RlhtNVFiYWs0TUNNQXpDOWJyQU54YkkwKzc4U0lpeklhbEdlQXlwM2lISlAr?=
 =?utf-8?B?cTVDSXFmK2g3a2REc2J3YkdZSU5HRFF6VkVOckl0V1lTcXFyaXpwdnd1SEFz?=
 =?utf-8?B?ZnpPaXlHcmY5eVl3SzQvVGR4UEU0L0tqQlUzcXEwN1dMSkdPWUUwUHVOUjgx?=
 =?utf-8?B?eTkzSnAvZTh2Z0F3SWYxeGN5OGpRQ3F3RjA4ZFM1b2wzS1FCRkdJMXRnemw5?=
 =?utf-8?B?ZlFFU3Vpc1lubHVmMll1TVdkWWlZZStONXZBZjRlYWpaaGgwNkxwaW5PYmtU?=
 =?utf-8?B?ZW1Nd2pzRnRvbmpNRjFIUk1OdWkyVitVS2ZxSENXN24yYkgyK0dqQ2lIOTlY?=
 =?utf-8?B?OUVJM2xaQ3MvTFVRLzBmRE42cEdsc3dNSnQ5OUxPb1o5YlJacG52QTlQY09n?=
 =?utf-8?B?VGRzWHJsVDJOczJ3dFhzdzE3d2ZDOVpwMVMzU1JXaEdnTSsrcmloVER5UHE0?=
 =?utf-8?B?aGJTN2UwZXlqWlIrMzN2ak1XRG5tRCsrNFltM3hmcWgyL1g2YTFGUmYzTEFN?=
 =?utf-8?B?RUQrZ05ZRXZXRHM2WlMyd29sd1dVbjFTTlZPdmlZNlZORTlBZ2FucmVCYU1i?=
 =?utf-8?B?aUQ2dHBhMGx1RjhtRW5mQi9WNWJ2cDVXYzNTMVhHQjVWeVRnNDViUkdzNm9B?=
 =?utf-8?B?RXU4c25VYlFtVktGdnpwb0crOEdXNXRCL1VBcWZvMkFBRmhXaFR5eEVjUEFu?=
 =?utf-8?B?NXFVVDBzakVqU05qRVBPU3ZMWlhDcUYwY2orN2pRc0RVSEpSZkdsamFkWlk5?=
 =?utf-8?B?bU1tbVJFbEdKd0wwWWxqWEp2YmZFeDgzZ0ZNRHZGVks1blQrSnFEaGJTOEFI?=
 =?utf-8?B?WFIwQTMxMnE4VEVRWjZqK1dZcUd1amtIdk5zZ3o1Nkg0Zmc0YUlqMENiekQ3?=
 =?utf-8?B?aU9xemNkL2MwaFF4MU8vZnBaaW8xVUFXNGhOaXlJeEFwN0xPQkg3dTUvR2gr?=
 =?utf-8?B?eVRteE9GeDZQbFhuTEVTeU1PZjV0cGROL2YydnhGL1d2dWtvOHVwL1ByK2l1?=
 =?utf-8?B?dmQwWFpJYW9qaU0zZUV2b0ZoNjU3UGVBSFc5R2htSFRENkZCQ0FDODJMNXgx?=
 =?utf-8?B?ZHBpQnhiOG42dnRMWGlDQVhoZXRRbTJDcGcwWnZXWmhaOWV2Q1Vpem5KOXdM?=
 =?utf-8?B?cnBiTEF5UTdWY2pIVFVKb2R6a05VWitSQ2sxUjRCM2xZS3A3U1pHTTJkK1Qw?=
 =?utf-8?B?dnFERjZEU3hqcmhHZHVLWnBzeWluUk1tNlhQZzAwTjZPRkp1STJZZGVHU0g3?=
 =?utf-8?B?czloaW1qa3lRdm5ickV2U1dGSUV2Q01NSEEyNTl5Yk0weFBLR3ZIYytUNnJa?=
 =?utf-8?B?YjdCVnZQVGNpSldHNUlNNlhhUlZNMGhuWlh2NDV5K2FCc0NkWU02YVhuUXIx?=
 =?utf-8?B?SHBCRDJ1UW92UnVOT1dJL3JTaDhoUnI0anhoLzU4ODRDZENhTjlhWG9WNFcw?=
 =?utf-8?B?YW5JUlE5bmNaUGNVc3NseE9BNmJDd25UMlA4MUpOY0tjZ2JmOWFrN0d0My8x?=
 =?utf-8?B?WlZJVklZYm43eDI3a2U0K2huRHdBZ2tWbk80VmJ5anBPVTlXUVFQSVVHOGNB?=
 =?utf-8?B?VXd4NzVYcG04eUJTdHRKRGJDZlk4RFpzanZlK2doRmtDNk9NdG1sVjNuUTV0?=
 =?utf-8?B?NGVJYnozeUozSTg4ZU5VS2NNdlZ3Nm9OMWNrRC9NbTJmelh2c3Ric1JRbFFi?=
 =?utf-8?B?Z2JBYW9MQkI2c3BRb3UzaDQrR1BOc1hWNnNPblYxbUN4N3l5WWFxdnVNOURZ?=
 =?utf-8?B?d2kyZUdIdERyNkZiVUtMb1V5VGxPM3pnN0pVZy9Sdk93dVgxNW0vUUpyWDFx?=
 =?utf-8?Q?etpun0xkAHnR3?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39890d07-658c-4fd1-a3a6-08de97acb406
X-MS-Exchange-CrossTenant-AuthSource: MEYPR01MB7886.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2026 09:28:34.7865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7PR01MB10897
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235702-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[amd.com,gmail.com,ffwll.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,outlook.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[MEYPR01MB7886.ausprd01.prod.outlook.com:mid,outlook.com:dkim,outlook.com:email]
X-Rspamd-Queue-Id: 1E26D3DF280
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When xa_store_irq() fails in amdgpu_userq_create(), the error path only
calls kfree(queue) but does not clean up resources from the preceding
successful mqd_create() and fence_driver_alloc() calls.

Add the missing mqd_destroy() and amdgpu_userq_fence_driver_free() calls
to match the cleanup order used in other error paths.

Fixes: f18719ef4bb7 ("drm/amdgpu: Convert amdgpu userqueue management from IDR to XArray")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 60e1f7541a64..716f9816e067 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -855,6 +855,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	down_read(&adev->reset_domain->sem);
 	r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
 	if (r) {
+		amdgpu_userq_fence_driver_free(queue);
+		uq_funcs->mqd_destroy(queue);
 		kfree(queue);
 		up_read(&adev->reset_domain->sem);
 		goto unlock;

-- 
2.51.2


