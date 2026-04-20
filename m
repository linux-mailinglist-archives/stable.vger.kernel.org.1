Return-Path: <stable+bounces-238698-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALSZIAC/5WnLngEAu9opvQ
	(envelope-from <stable+bounces-238698-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 07:52:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1236426F65
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 07:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A39BC300E617
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 05:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4C435A381;
	Mon, 20 Apr 2026 05:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F7tQaBIF"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7DC212D7C;
	Mon, 20 Apr 2026 05:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776664315; cv=fail; b=FSbP09Rz5va8nSXvywkPYrKiyoG+x1a5EjX1jhUpHV+nRw9R/8T8ZENXWln+Rs2uANPavqGFQRlCltgBUOqqIQ7l9FbeLSFaXBJpxtTybO5IPlvEm3P+iK2ZghBkmF5ZC5NVILQWSlox+fuXA2zuxIe6kX8043K0cSOTMn9Xr0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776664315; c=relaxed/simple;
	bh=7bxpEpxZap3SOL3i0lY81uBMrPBsY+aYu8Xl8PIcmW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z7Zxo6RGlxVlxWXc+THs5K18qCVtDySbrGhx7lnbIysKIpOqvPvhC/eRLJv0ORuotvxCGoXOpKGIMBzG3jnD70/I1K/e171rNEoMFVVIWQAkDpVtQErvxcNHBZFPCXYa2Aw4MwZbO4393k7iVLNDmycYoQDWVId67NIHUnzugnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F7tQaBIF; arc=fail smtp.client-ip=52.101.43.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q432No9jC1qR/wf5+Rb5LX8PS6art09Vks6C3gAgNb+VhKyPdRZxVuyUshUpSy+BYXaE69IjH8iCdVAUu757LGnJKh1jqKg9zuzm9a8YTJTDhQXT1N7zMpVPv3szgUgXBtolHCJ1f5QCdW6ry4+6EGmBOPUAAbWq585NHaR6K0jjxbz2MFt0mnWbx4yX+7v55X96Nub353PqvnolOwGwmF+gSDA+egIMcZeP8qAS9PoGLm6AV/+t6ddS2UDwTyeZAZ7YiLDXDmF0xXF0H0+QtO7IBcNgjYyb6isHpcEL9fK3DbAPKoTLXt6xLQCJmCt6JTSvic5loZQhZTvO3+OBag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Y/ADa8KsblnM7f3Ps5D/ZJiejn2227RCdtIvJlgYUI=;
 b=MntYWhxFaSDMQJmWpY7v1f9cOMXEGVvAKi69txyv8iDdT+BiJ2nGcazHP6Jr+kT4qSjtJiBBknArqOHhN/waa4SL1DfY6pCvVnBv/EBllYVgo1cucCWLA1hTwvsBH5eJzdzWKwFrW5ovneIXp0gy7F59WsvGLhqsi6SPi41ix5JoPld6+CCFQnymVpMholxUhQB7WfSxjMB3HYTNqdMn0Tmd27bM8Qeg620W9oQQU2qPMuOxI5oh0yJrpEAP2WnRttsskmq6hQ0Dhsgpwcp0Dmx5Pj+Rez/1tu/YK44rJX+4OB7gVpui35LhQxJD1bplWlimoPi8AQeRgBR93wls0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Y/ADa8KsblnM7f3Ps5D/ZJiejn2227RCdtIvJlgYUI=;
 b=F7tQaBIFU0T1NtiJS3Bvd6IGYTptOTdNSrSBEWniqDCkHYNaJ3N6+ErFHy7PBuDvbIukobYmWUe+os3S0d/65h+0+hAE0mRLv8jUkMoKwosOVFhq4CBK0vKvERbPZDY6++XUDSmU72khOiiWM9vT5KNFBXUrmybchdG5x5sXIFshkxPW78LUUcDC7gZ7oajQNqh9TBt++uJ5en2LRUVe86ojaLgO4JBvQHNioRA82a5miXlfJ2dhzHoo4JkzcnzjF0pY6/rMQL4KrRuNISC68o+H0B2a2M6ir/XH0kBfqK/CjxdGqlsLci9yalEfWKjZlFnGX+lN9kiQTMRssYXYUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.8; Mon, 20 Apr
 2026 05:51:48 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 05:51:48 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mark Zhang <markz@nvidia.com>, Sean Paul <seanpaul@chromium.org>,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Guangshuo Li <lgs201920130244@gmail.com>
Cc: Guangshuo Li <lgs201920130244@gmail.com>, stable@vger.kernel.org
Subject:
 Re: [PATCH v3] gpu: host1x: Fix device reference leak in
 host1x_device_parse_dt() error path
Date: Mon, 20 Apr 2026 14:51:44 +0900
Message-ID: <uZ6EdVtvS_esNOmqaTDDhg@nvidia.com>
In-Reply-To: <20260413141526.2961841-1-lgs201920130244@gmail.com>
References: <20260413141526.2961841-1-lgs201920130244@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP301CA0039.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::16) To LV3PR12MB9166.namprd12.prod.outlook.com
 (2603:10b6:408:19c::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: a3643925-8fc9-4aef-5b40-08de9ea0e8fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rWTFJMVKl7XSjocAOFb2KHhicLZot51TI3rjKANKLStx2oZTO+XG/ncpv1irFfzfpHefhemoYa8FRBwMB3Hve5AzQPN+2kEadxssf/+F2dYzjiH6O9YXt62PXNia+9kcZK7DtHPLrBbOxvWJ7+rdQFa8vRrtjTXv6X7N649+GabJpvhkTdZNh0BqrXuW66ErgHp5yRFFQ7y3dkLK57MWGK1dYZvki+4X8oaa40Vsi0XCHViRNrzgEfP+jfp2Y0g4hsL6vZRC6Oysiul6YfoxfUQtkAh1BqMTgQzQ9hnUVeHOGJxIJYTMNULW85WQSkoK1Wlw+HR3cU3eeZ9BY6ujNraMqQDARgO7O2pKNE8HJe7Mt8l8ksqEi6CwbQtJI4+rIlCDW9pBbVdAoNlAwylJv4yuUjHmbsuEXYqk6TxVXMIeCfJ+1TT20KpidFTaq8VNJWBwU4RyMkJtawYSMHMF1wmvQsU3xVhnS8eGtvOh6/o6as6eW498EiYAch3+o5qwqnGG6mJFeY8RCL4xLPanwkSW/py66ydysV1041cLLgme9eAefYBZtWDyVmZzo6Ki5fSqtNGcQ8FYXxZP7uRtQlaTi5fFzjxqACUui+LNI6NVwadt3Aw3SrzuL9xtNIQAmrNVKKlUHLvIuTBWmvXkIdaLUpYyaZKS6up4/fbZc5G8X2VbTv3c/gLDAm9d9X71WkQWb+/iXWZn+f9JgmLG+7TAMtSIK0FvGD32DhmvB0E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REZOMzdodmNodEowTkpucWtZQk1GUGk4dzFIVHFLZW1CQjh2NWt5ZFlQZUp5?=
 =?utf-8?B?SDdsTldRRStUVitqNEIrWjQyM3lkU0ljcENwZG5hYWd0VWg0M0d1RmtPZ1hr?=
 =?utf-8?B?RGd0eTY2YW9qRWlubTFZREVWamUyaEZPcElHUGd0MDlReHE1SUFIek5hYmNs?=
 =?utf-8?B?SGNuQ1RKejZKMTR4WmFHbDR0YVVjenNLTFBDdkVyMVhUeFRYS1JXL1ZUSHdF?=
 =?utf-8?B?NytzazQvSFpzVjBhOTFPY2M0NnRYbTN0TnRoOXhXR0dpc0JrNjdQMWYxUFdY?=
 =?utf-8?B?N2xuWjhOR1N6d1VZNXJJV1FJaFI3RVlTZG1Yb082dzVtUVFHelloMjJPbERC?=
 =?utf-8?B?ekVMRDduOHhzVkRFUW82aTJtbUJYWCtRWmpaM25IbmtITlROa0xDNzlzLzVw?=
 =?utf-8?B?Q0d3dlhMNEpJMmFKTXpsY2pqeGpEdTFseStJdnZ3R1BFUHlZZE05RTRlaXBM?=
 =?utf-8?B?aHRtRWM1VVU1RUFpVW9DZ3cxK1BmdkkwdGtxSTZ1MHo2RWVwUWR0aXUyS0RN?=
 =?utf-8?B?YWRydWZsNDNiblQ2QVpEWE1aWGtnV3p2TVdsTlErTllZbjVrbWI0RnRiWlhN?=
 =?utf-8?B?U1VlNnc2VkdLelZuUDk0Zlc1aWtORU8rSUNvVDJKS2dxaXpwUEs4b0JMSnZ1?=
 =?utf-8?B?aTVKWWNJVSt5bk5uU3BiNXNZNWViOUxZUGtIZDdGc3htbHBycW9VOHV0aTR2?=
 =?utf-8?B?cEwwd3VOM2pFSlNRWUhhcURnYlk4ZStxN0RhVDVYU3ZBeHVDQUlWVmhvTTEv?=
 =?utf-8?B?TERhT1N1VnZHOXJzcGsvYThYVXhhKzRaeFVaNXV0SXRxSmtoSUMzTFdvMXN4?=
 =?utf-8?B?aHRZZUpWQ3B4ek5STW1adi9pWGtvbDhlVEFycml0NEF2RWJadTZHZGgvdi9l?=
 =?utf-8?B?TmRkSXVNMEZDS1VOcXA4dXRScHZSOGhhNmdQNjUra0cvSVp4Z1BrbVU3N0cv?=
 =?utf-8?B?b3ViYlk0ODJySkxsVDN1TytZZmdac201QlhIZGgyZm1OK09UUk9udkRCT1py?=
 =?utf-8?B?SFZkcjg3MnB3SlBPRmw1SWhkKzVueFBVdEJ4N3ZpV0wwbEZBcmx1N0d4N2xw?=
 =?utf-8?B?a1F5TEp0eTdOZWxtNGxTaTR6SjhDei9KK0d3dzZ3NTkwVWwvbGlwUkliZE1x?=
 =?utf-8?B?a0NUVVh4bldNOThTd2xLMmt2U0VaODdCclkwM1lvckc2YW41eEZKa1B0VEhv?=
 =?utf-8?B?eWxVRWthdzNISDlsNXUya3VXTFUxTTB1L2twSkQ0VHIxYmwyUEpLSytuN1VU?=
 =?utf-8?B?U09YVG1uZU1Hc2tNemNEYStIemxIcnlhUjF2Z3VoMlA4M015S1BKUjVsTG1J?=
 =?utf-8?B?Nmtza282eUdYb253NGR1WDcwUkt1eDJVL05XdzJVSStCMzQzQzNUY3JHaDdl?=
 =?utf-8?B?ZUp1OGRweSs5SGlWamNnQVVEMS80WGZFWTAxaUJTOUlGRVpBZHBzWGtudU9l?=
 =?utf-8?B?cGZuczhHSXdqY3B5bFBmTTh5R2xpVG1VczdFaVdoSE9uV3VwL1pHRjE0Z3dh?=
 =?utf-8?B?cHRBMGRCalV6K1Y1ZzFoUFRVZUVkcHRLNm5hZnoxN3RJbXNxdjNPb0xXdVZr?=
 =?utf-8?B?dzNMTjdQWU43c0xuWTVkSndlY3c5Q29mODRRM0x1MnFZRkk1NnpQU1JpTTB6?=
 =?utf-8?B?U3NGRU5FWUVaUFBkUGFxdFN0cGZydThkMnlyNk9zeElwMEczZ0VDZVJTVnlJ?=
 =?utf-8?B?U0hOaFdDR3ZGSXJiUVVoSXRudytjZjFxL1QzUExhUHpVcVlrSzZ4dkVkWHg5?=
 =?utf-8?B?TzJBS2ZvRmljZkJ5Yk1GRGhpYjkvQTdGc3hrdEJGYm9MVVdZNXRkaHRNdU1U?=
 =?utf-8?B?TG14OGN4Z0NmS3V3TlpZMEVoMlpNUUdXWDhKQVdaOWIzaUtEeXNFSm5rNU8w?=
 =?utf-8?B?enhndkdpa2EzMTQ5Y0YrbTdQRnJ1S1E5cy9rTlpiMFhEbmhETE1TSFJYd0lB?=
 =?utf-8?B?eUpHb0Vqa085M3hwZ3UzZXZLby9JUWYyN3ZUUGJTaThnV1hyOTZ6TnV3OURz?=
 =?utf-8?B?ZjdBU0krRjVzRGwrMzVITHdWYWFVbWVRUWJNVVI2Q2hGMlpjeXNReU5WTEFG?=
 =?utf-8?B?MUY1eFVEVTh5ck5QUGlDcHYrcTErdU03UWxDS0FuMGZkZ3pwUmswWlYxUTFn?=
 =?utf-8?B?QVlvMTJ3V1I3aXlXMGlaUXZJRzBlWjlnZFI5d0l2cnMvL3g4c0JTclA1U0U5?=
 =?utf-8?B?djdzZTBhUE1DcmkrRzdjOUdjTS9XRHpzTjNQSjFoTFVIZ09TMVU1MWJUWmRM?=
 =?utf-8?B?U1V1RUN4SVk4aG9KTUIzUEJ3cG9uRTYrbjV6VytYem1kR3VqaEJNMVNScWcr?=
 =?utf-8?B?Rnl4TXRiTmZZUEh0MzFEeE4zYzM5OTNhM2NRaEViMTdpMFYvMFdkTTVxRHZW?=
 =?utf-8?Q?BHdsvklYLXOAGIfQpU3oVJoal2P9jRXvHIoYgZrBLocYk?=
X-MS-Exchange-AntiSpam-MessageData-1: avCA5Ehi/MMwgw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3643925-8fc9-4aef-5b40-08de9ea0e8fd
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9166.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 05:51:48.3985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4hH89JUVVi/fj1BHGyKUJj7eP/Q8OaUyyua0XEv57av9pDbEeHa6FHVa+pVCK0yV1FQz7Qz0c3M3YW+Q9D23XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238698-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ffwll.ch,nvidia.com,chromium.org,lists.freedesktop.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1236426F65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Monday, April 13, 2026 11:15=E2=80=AFPM Guangshuo Li wrote:
> After device_initialize(), the embedded struct device in struct
> host1x_device should be released through the device core with
> put_device().
>=20
> In host1x_device_add(), if host1x_device_parse_dt() fails, the current
> error path frees the object directly with kfree(device). That bypasses
> the normal device lifetime handling and leaks the reference held on the
> embedded struct device.
>=20
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>=20
> Fix this by using put_device() in the host1x_device_parse_dt() failure
> path.
>=20
> Fixes: f4c5cf88fbd50 ("gpu: host1x: Provide a proper struct bus_type")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v3:
>   - note that the issue was identified by my static analysis tool
>   - and confirmed by manual review
>=20
> v2:
>   - add Cc: stable@vger.kernel.org
>=20
>  drivers/gpu/host1x/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
> index 63fe037c3b65..e3ac85848aec 100644
> --- a/drivers/gpu/host1x/bus.c
> +++ b/drivers/gpu/host1x/bus.c
> @@ -452,7 +452,7 @@ static int host1x_device_add(struct host1x *host1x,
> =20
>  	err =3D host1x_device_parse_dt(device, driver);
>  	if (err < 0) {
> -		kfree(device);
> +		put_device(&device->dev);
>  		return err;
>  	}
> =20
> --=20
> 2.43.0
>=20
>=20

Thanks!

Acked-by: Mikko Perttunen <mperttunen@nvidia.com>




