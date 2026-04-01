Return-Path: <stable+bounces-232872-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJV6OfyizWl9fgYAu9opvQ
	(envelope-from <stable+bounces-232872-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 00:58:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E614538126E
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 00:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C7CB3012AB1
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 22:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B863F0760;
	Wed,  1 Apr 2026 22:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fVuUrIPe"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011065.outbound.protection.outlook.com [40.93.194.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586FE3F0755;
	Wed,  1 Apr 2026 22:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775084169; cv=fail; b=kCuObhilT7+bhZ2eAII55Bwr/m/R5i+i8eU4qha537ffEbKlpENl1qK+plIBJwpes8vUN9titZQ9XTv6wOxFuVFvMurcAvSd6wxeSg9zfQkwwebEXPFWVOwdenNlPdQUOLiz2V+/g6KGo4BrABc8R7+PNrJ84ljNQ+rBclLNqX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775084169; c=relaxed/simple;
	bh=QuodDQn5fyZtnJ/+253U0ghr6PxLukIg6YLby/dDGTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gh1QZtBkVoNOjPQII1M9TCAFvQLJnc/jR3mtuHHQwhDDTQ71O+Gu4XaiY0J7eJshheHF1cL6guOMIzJF9Ha9u+X1ypuc0hTCNMyX1GUz+uMHIxaNYhbz9/y2QOFlMqseEBa3E9M+he77LFeqhlAgcoyB00k6A0BtL86MZZ9GJt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fVuUrIPe; arc=fail smtp.client-ip=40.93.194.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Etw+jswkLgkRSEyE/W1W4mpXR5PjB0gUxE5DlY8TPvgR6binPJsGEr1tUE5oQpvsQADrdmErgVWIxVZq7BIBGkiQCQN9KtgkgkSQrk3juVfilWQrW3qKzmQgWzkCpbsBrLDvVTzTVWX4IOvnfL+9LjN+RoZHlIEYAkAc/oSECZsRIGtKyJfoXkqWhEUWKpow5KRFhhCY0yF2b3O1FzTToSWwsrXoezLXzHB1C3Q71zBE2P/2mWpb9V2VU6ACdiCvZnf+yoY2CyxU/reM/+xs1zWm4lzoVd5oSL24HOnLo5lyQSV5hjMZ3udADrjGV6JxEddB61ed9yBX+7N/8EHT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4sdG36mH8CLg9pv4R58NxzgI1o02gP91jknWf4NrbU=;
 b=AbIDoMU6AzHGK+1BuJr7zWwPzOYRn52RUfhKwp5lM7rB87a19zQ8H98Q4JxJpT5G8xmqDpWDpKhpapyYUCqGtbPe9XrFJpQocffkQIteg6lDVbNj3i95KbEXbMBtUPRQHpWnBWhL4nAB9+dTIqRbUFz0yBQ3LBSqUdbSb9ONVdQaEbyrK3qDxGxRgwByFozV+aHTve+isrG8hb4IRxID3pEH7bQFCVYeDcUbvEaHaPyGjgA8vhPyoN35G3TTaLiOVOY012WT51PvLmCV8Ux1qPKLGgQHNC3KCFzYoJgWCvgoP0/NWIRFmcrCX9jC4kq1NbJXs6RMyUjux+cmG/wCiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4sdG36mH8CLg9pv4R58NxzgI1o02gP91jknWf4NrbU=;
 b=fVuUrIPeA1HxuEKT8XlFq957C01Cce54o68C9s8ypR9x/cjW0HZQfBtiGt2Zh8WWwTX6okZEBww5/YmbNuCOjP28xH6kUciZtg/KvD1greudv6Ky8iS97BtPkl0keaHm0+0Qp7Sg7KB+Wa11WPEMqFVZdUFHHZkOhhDTq53HBWo7lPl56Z5ak8Ek1WDqbXSViP6Q0/9W21zk1cq9yI+mnqXd2FxHx5QPBP+cKnIdjXrv1OBpuF/cwr1WypCUBasihjo9BfGpLYnoIzS4u5N+SZXJTh1orfYzuk4tlLEIz/oE4Q3QjXLHknNpjYiMDr19MO+XE/zN2z2C+qjuOtbkzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Wed, 1 Apr 2026 22:55:53 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 22:55:53 +0000
From: Zi Yan <ziy@nvidia.com>
To: akpm@linux-foundation.org, Lance Yang <lance.yang@linux.dev>
Cc: david@kernel.org, ljs@kernel.org, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 richard.weiyang@gmail.com, usama.arif@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kartikey406@gmail.com,
 syzbot+a7067a757858ac8eb085@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: Re: [PATCH mm-unstable 1/1] mm: fix deferred split queue races during
 migration
Date: Wed, 01 Apr 2026 18:55:48 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <FB71A764-0F10-4E5A-B4A0-BA4C7F138408@nvidia.com>
In-Reply-To: <C4A8301D-C76B-430B-A6A6-8B642B80FE2E@nvidia.com>
References: <20260401131032.13011-1-lance.yang@linux.dev>
 <C4A8301D-C76B-430B-A6A6-8B642B80FE2E@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:208:fc::28) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM3PR12MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a8a39d-2a6d-4ebb-f207-08de9041d3a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	mPMyM4l8IMGOCGeRDaHzMooaHp5Q69IAgZ7iYYxzqXTMgxFe6TUOq1OfEOqgW+ECNn0iX/uKvA/x0ub0NySgaZoJjolh5Tslzsm0IpwZS+/x9SYCf6BXYozOIYaHsdRKT4IlrEfX/E735pkdgm/cRsVxZ4QH/FOaINQAg3ltP1V992eOqoXkYmvguqVVXNx3CpM74FYYimHYLUx8MzHjhv4AzG2y31bLb2Tv7L24GL8ZCj2zy6zmfvmz21bw3/lEogujWoXMBpjfeVS3jMk7VTA3ADzmJ6wIgTdwlmeXsoQqlU3rSTIvQHaYn7QX7nRwOYW5BgICP2f4pulYCgHVyYxb3UJyrD/ypBr2F2qYG4Geg36A2t38smLeOxYEKZ15PpiiqKzSvKU26cHCeLUr1P5OZykMx6HknjbHU1EUdTOaLJKtwupEm9Z4i7ENmHaGcxw4ArLsqqJoMKS67uT39vN4U/KmZ4NLnsg9/aDBelV8c0wxLyELOlocha8C+hPy8oHuOV3lxjVTQuafRhM4cH6IpL+WyZPQ5/4WFIw9fVYnGn0g2Ru8guGr7snFuza5gYUj/vnceDj94vqxekLK8vaCQo44vRYRZATtpubvcjPxzu0vXD1sPSBHAOHVIAHKvDp7yblXU3A+OdaTy3GnBt2UoLq3nDUcZIy6eu9u9wtgYwS2FkxhIyKmaZP6d4wpQiYfz8MHKWj6XxWPXXGMtalrF03xoZ10SWYGfnTPmpo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDNTeVhoQTZaL0pUSG5RTk15STdjbHVUM2FrVkZkNHZUbzc3dnVEVXg1TVYx?=
 =?utf-8?B?a09GcEZiUHgrV0dZSDYxdVVPY2JKNTJQNGdoeU1TVXVQY0FROGJvVnpmcTRH?=
 =?utf-8?B?M2RWTWdkZVRISDFwNFU1Y2pYOVJCdUV2OE04U1VrY3B3RVI4dTlNREtMcTM0?=
 =?utf-8?B?eDZyeHZYb3hvK1ZQNEdBd01zZndpNjFzT3Z0VXRWcFNuajBxVFNRaXlqMS9U?=
 =?utf-8?B?d2RtTi9CaWlFMW1IWHd6UVdKdW9OR0MwMm5JcU93NUxlbXhPVWxXekhSMXUy?=
 =?utf-8?B?Si83bldkWDhHTWhEL1ZVWXU3by9BRVFNT3Z2K1FNR3R4RTB0U25JZTd4MElZ?=
 =?utf-8?B?c3VPcE1ybFpnZk9lKzhUU0lsRG1mcUF1NUxlSWtxT0dRdUd3Y0pJQ21BZlpY?=
 =?utf-8?B?T2Q5emZwVGhKaHFnMDh5dWJMNS9nOExSZWhiR2tLbWpvbUEwK2JlNnI4bi9Z?=
 =?utf-8?B?a0N1KzJnalcrRGY3R0EyNnR3SVgrVXk2QVF5UGJ6UkdkZ2NoOFN2Ukc0UDE4?=
 =?utf-8?B?V29BWTY4elNhQ0hLbmZjVGdDZlk2L2hxZVFyZGNQQzZMQlFGK1MzM0ZaakY0?=
 =?utf-8?B?MDNQeWJ1MGRQMjB1Rk95TjJiTUNjcmNWYklsUUdIMGVDZ2N3dzVNbVNGT3ow?=
 =?utf-8?B?cjBUWFVyWSs2WElMbmljOTk5MmFVRTFnSXBraC9sVWE0M1IrMmtzdHF0UW5p?=
 =?utf-8?B?L0xBRmI2OG8raHlxd0xENFAxakwzS3RiaTY1cWJWRk5vZGpvcXJrME1JK25N?=
 =?utf-8?B?ajMxbzhSRXYwT0tSQVltdFBSOE4vblJKejFKdGV6Y1VJYUhpbHB4bWc0dWIy?=
 =?utf-8?B?YXN2Y0RBMzNLUlBnZUx5TS9xRldkdU9LUmJHalJTV0FwaksrWkFPNWxPb3NY?=
 =?utf-8?B?aFQrUjJQc1lOV2VlN3h4MnVNYTVRd0pwMnlPUEFiRko3Y1dLMTQ4MlRZNnJ0?=
 =?utf-8?B?dXA3bG5Ta1V2RExjdUg0RHhHNmxiM2s2L0hPZEVua1FXMDdGT2pZbzVWcS9N?=
 =?utf-8?B?THdHS2pvNE5jWHJBL1VndXMvemg3dDk2Qnhham95dHdYT3ZxVkRxRWRKUFdK?=
 =?utf-8?B?WTNhbm0xSmk5ZjBUSEg5aHZKZWExVVpjejhvQ1RRdkc3VFBRZmFrMGNQMmUz?=
 =?utf-8?B?cGMyT2NIZnhSNnM2MXVJcmwxSGx3azVtODBFb2YramMzd1BDVlpQQmtoNGR6?=
 =?utf-8?B?T0pKOHJmV01BeXZBeDZrSStKbWFHZlo5bnBBeXhxR1FnenhzTlF6WjllcEQ3?=
 =?utf-8?B?MXcrU1ZrcHR3MW5HZkxJNE5KeVkxcFlncjhOcWVldmV1UFR3ZUpJNHNONURS?=
 =?utf-8?B?eW1jZWMvRlBNMUk4ZzZiSGhldVJDbytFWWc4ODBVRUxTNktzTEliK2Y1OXhX?=
 =?utf-8?B?TTVHejBTR0VmU3VTL0Z0ZnZRZVhYUXlxUnJWMW1hNVloQk9sSmRaRXVTeFFw?=
 =?utf-8?B?OGJWTmx4WEFOQzVzUUpJa282SEJGVTFaNEN5Q0FzMDJSUjljbWlHNzhGajN5?=
 =?utf-8?B?azdsMW5CaW9NUkNNb05PT043b1lSZEJuRGhEdk13MUNSZmQ1NUF2Mnc5ci9t?=
 =?utf-8?B?ME1ITis2TmFjVDlId2lYWXBaejhoYnlocEZJanpISlVUU3psOGtyci9vRDRM?=
 =?utf-8?B?SUxPTy9BTGIxY2lCR3gxUFhKQmNwbXA4MitSY0R6dnd0bXloVDNGYmFZcXo0?=
 =?utf-8?B?bDNyblcyRVJBYW5DVmluWXlBZGhmL0FTMEdqL3NWRy9yZVU3ZU9IUXlENWps?=
 =?utf-8?B?TS9jaTNxWWE3cjNTaXo2Skp6YnU1RTB6L2lZYXA4TDBJeFVKUU9BYnVMcGtG?=
 =?utf-8?B?NDZaN2MxYTdHb3dMUUtvZTlpS2Z6NDZlWENWYUE4SDVlN2d2N2M1K1VGamtL?=
 =?utf-8?B?T0RPdm9reWFnOTFMSWdmNUZIMkUxR25zS1p3dGpYSkN5ams5L3VDY2VOdlEz?=
 =?utf-8?B?MnZndXhqZ1hhSlJiRTlEd0wxRld3b2JPdVFmUTFsYU1ZdjBsTVNhSDVaMzdE?=
 =?utf-8?B?NUtSV1pwSDU5YnBTWnhXSWJKMVBIenFxMHp6ZGhkTWNrY09YTjJJUktPZUx4?=
 =?utf-8?B?WnZIcTRhTThkS2xXS3ltRmpRTWNuVTNuZGtmVFhxMERaQzhYVitCdURzVW85?=
 =?utf-8?B?UG1aQ2FqaloyTExYaVZNV3JmZC9xM3dNVzMrRDByUVFvWUZhVzBBdTZWMWNV?=
 =?utf-8?B?eXVaaGpGd1JVdkVXSTBmbDlIWlV6Qm9VRUF6RkE4RFNpd0FPZFBndGJSd3ZQ?=
 =?utf-8?B?N3dzYk05ZUNaUVdrK2UwcE82aDV4SVo5SnU1S3VzNXVqdGNzYXVnNnlXc1hL?=
 =?utf-8?Q?hWYqmWdJX6WUBSOiGK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a8a39d-2a6d-4ebb-f207-08de9041d3a0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 22:55:53.2268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMvQ7xJfecuM2pauqSH519m3acwQFCW+EYzuDCK1cNldMCmRCeEyvJOoVytfDbB8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9416
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232872-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux.alibaba.com,oracle.com,redhat.com,arm.com,intel.com,gmail.com,sk.com,gourry.net,nvidia.com,linux.dev,kvack.org,vger.kernel.org,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable,a7067a757858ac8eb085];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,Nvidia.com:dkim,linux.dev:email,nvidia.com:email,nvidia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: E614538126E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1 Apr 2026, at 15:21, Zi Yan wrote:

> On 1 Apr 2026, at 9:10, Lance Yang wrote:
>
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> migrate_folio_move() records the deferred split queue state from src and
>> replays it on dst. Replaying it after remove_migration_ptes(src, dst, 0)
>> makes dst visible before it is requeued, so a concurrent rmap-removal pa=
th
>> can mark dst partially mapped and trip the WARN in deferred_split_folio(=
).
>>
>> Move the requeue before remove_migration_ptes() so dst is back on the
>> deferred split queue before it becomes visible again.
>>
>> Because migration still holds dst locked at that point, teach
>> deferred_split_scan() to requeue a folio when folio_trylock() fails.
>> Otherwise a fully mapped underused folio can be dequeued by the shrinker
>> and silently lost from split_queue.
>>
>> Link: https://syzkaller.appspot.com/bug?extid=3Da7067a757858ac8eb085
>> Fixes: 8a8ca142a488 ("mm: migrate: requeue destination folio on deferred=
 split queue")
>> Reported-by: syzbot+a7067a757858ac8eb085@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/linux-mm/69ccb65b.050a0220.183828.003a.G=
AE@google.com/
>> Cc: <stable@vger.kernel.org>
>> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>>
>> [ Backport note ]
>> This patch is a follow-up fix for 8a8ca142a488 ("mm: migrate: requeue
>> destination folio on deferred split queue"), which is currently only in
>> mm-stable, and should be backported together with it.
>>
>> Credit for this fix goes to David, thanks!
>>
>>  mm/huge_memory.c | 12 +++++++-----
>>  mm/migrate.c     | 18 +++++++++---------
>>  2 files changed, 16 insertions(+), 14 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index ff9a42abd1b6..ac6d823e351f 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -4558,7 +4558,7 @@ static unsigned long deferred_split_scan(struct sh=
rinker *shrink,
>>  				goto next;
>>  		}
>>  		if (!folio_trylock(folio))
>> -			goto next;
>> +			goto requeue;
>>  		if (!split_folio(folio)) {
>>  			did_split =3D true;
>>  			if (underused)
>> @@ -4569,11 +4569,13 @@ static unsigned long deferred_split_scan(struct =
shrinker *shrink,
>>  next:
>>  		if (did_split || !folio_test_partially_mapped(folio))
>>  			continue;
>> +requeue:
>>  		/*
>> -		 * Only add back to the queue if folio is partially mapped.
>> -		 * If thp_underused returns false, or if split_folio fails
>> -		 * in the case it was underused, then consider it used and
>> -		 * don't add it back to split_queue.
>> +		 * Add back partially mapped folios, or underused folios
>> +		 * that we could not lock this round.  If thp_underused()
>> +		 * returns false, or if split_folio() succeeds, or if
>> +		 * split_folio() fails in the case it was underused, then
>> +		 * consider it used and don't add it back to split_queue.
>>  		 */
>
> Should the sentence
> =E2=80=9CIf thp_underused() returns false, or if split_folio() succeeds, =
or if
> split_folio() fails in the case it was underused, then
> consider it used and don't add it back to split_queue.=E2=80=9D
> be moved to below label next?
>
> Since =E2=80=9Cthp_underused() returns false=E2=80=9D is describing =E2=
=80=9Cif (!underused) goto next=E2=80=9D,
> =E2=80=9Csplit_folio() succeeds=E2=80=9D is describing =E2=80=9Cdid_split=
 =3D=3D true in the if=E2=80=9D,
> =E2=80=9Csplit_folio() fails in the case it was underused=E2=80=9D is des=
cribing
> =E2=80=9Cdid_split =3D=3D false and !folio_test_partially_mapped(folio) i=
n the if=E2=80=9D.
>
> The first sentence matches the goto requeue for folio_trylock().

Hi Andrew,

Can you apply the fixup below to move the comment? Lance told me he
would be away for a while, so he could not send a fixup to move
the comment.

Thanks.


From 6ebeca9f7215cb91905d3f49385dbbafce5a80c2 Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Wed, 1 Apr 2026 18:52:43 -0400
Subject: [PATCH] move the comment.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ac6d823e351ff..970e077019b75 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4567,15 +4567,18 @@ static unsigned long deferred_split_scan(struct shr=
inker *shrink,
 		}
 		folio_unlock(folio);
 next:
+		/*
+		 * If thp_underused() returns false, or if split_folio()
+		 * succeeds, or if split_folio() fails in the case it was
+		 * underused, then consider it used and don't add it back to
+		 * split_queue.
+		 */
 		if (did_split || !folio_test_partially_mapped(folio))
 			continue;
 requeue:
 		/*
-		 * Add back partially mapped folios, or underused folios
-		 * that we could not lock this round.  If thp_underused()
-		 * returns false, or if split_folio() succeeds, or if
-		 * split_folio() fails in the case it was underused, then
-		 * consider it used and don't add it back to split_queue.
+		 * Add back partially mapped folios, or underused folios that
+		 * we could not lock this round.
 		 */
 		fqueue =3D folio_split_queue_lock_irqsave(folio, &flags);
 		if (list_empty(&folio->_deferred_list)) {
--=20
2.53.0



>
> Otherwise, LGTM.
>
> Acked-by: Zi Yan <ziy@nvidia.com>
>
>>  		fqueue =3D folio_split_queue_lock_irqsave(folio, &flags);
>>  		if (list_empty(&folio->_deferred_list)) {
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 05cb408846f2..8a64291ab5b4 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1385,6 +1385,15 @@ static int migrate_folio_move(free_folio_t put_ne=
w_folio, unsigned long private,
>>  	if (rc)
>>  		goto out;
>>
>> +	/*
>> +	 * Requeue the destination folio on the deferred split queue if
>> +	 * the source was on the queue.  The source is unqueued in
>> +	 * __folio_migrate_mapping(), so we recorded the state from
>> +	 * before move_to_new_folio().
>> +	 */
>> +	if (src_deferred_split)
>> +		deferred_split_folio(dst, src_partially_mapped);
>> +
>>  	/*
>>  	 * When successful, push dst to LRU immediately: so that if it
>>  	 * turns out to be an mlocked page, remove_migration_ptes() will
>> @@ -1401,15 +1410,6 @@ static int migrate_folio_move(free_folio_t put_ne=
w_folio, unsigned long private,
>>  	if (old_page_state & PAGE_WAS_MAPPED)
>>  		remove_migration_ptes(src, dst, 0);
>>
>> -	/*
>> -	 * Requeue the destination folio on the deferred split queue if
>> -	 * the source was on the queue.  The source is unqueued in
>> -	 * __folio_migrate_mapping(), so we recorded the state from
>> -	 * before move_to_new_folio().
>> -	 */
>> -	if (src_deferred_split)
>> -		deferred_split_folio(dst, src_partially_mapped);
>> -
>>  out_unlock_both:
>>  	folio_unlock(dst);
>>  	folio_set_owner_migrate_reason(dst, reason);
>> --=20
>> 2.49.0
>
>
> Best Regards,
> Yan, Zi


Best Regards,
Yan, Zi

