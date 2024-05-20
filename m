Return-Path: <stable+bounces-45444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2EF8C9EED
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 16:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25DFC1F21C10
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 14:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95D8136669;
	Mon, 20 May 2024 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2z6eGyG5"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049C013666E;
	Mon, 20 May 2024 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716216111; cv=fail; b=lGv8+xhqvUlCRoYsIL7RcyosvoHpjDB0o+Kr1crTvIo3raGv3TDSq+lBzu3LgWet5d0InF7yG4i64Z2QmcAV7Ksj9zpb486D5GSed3SO7XztnrekTLvRyW2bchaW7dapEVYlC8Ov3IVrW/f61MEKA5rEFLiCci8CIUoKxQ6kt8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716216111; c=relaxed/simple;
	bh=xKfUtZRXvcJd2NdD2ZbbX7J+EPz1FiarnyNO5j4v3GQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qx+ylv2pZD+HdajFEcJfPqbvSkDH1/Qwh3cGLwqHs0qtK8HWVMNfo1FQQXtlGTINrPTTUv31YdCqHH5rxK4Jg4JcSZLTEN1MvLgtdIg9g2988oFYt69hVoqfZodDXM7hohv5WTi2s9+tO8jQ3Jtb+yeIs4mrQiACPRk94sABlE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2z6eGyG5; arc=fail smtp.client-ip=40.107.95.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpGKQf0x9aLamv1sNCjv5jlLeraUMW9fTo8xvQZYdbMopKkuahhIyzcWmSaj7wkSi+Rh+DFcrQfjCo5Yedgl0UqQdn0nMPWGKnoYKTtG9SW9IfjuEMaG5MHzNogM9ySFUucavhLm8zw2+nr9H7fwd99fUWf8PQQ/skkiMTLktmQH9Hvh8I7PSJjKrtKK/nOhROu+HgtvEptrQ1M7LO8D8aayQSXuRCucR19L4AHBYVIPKHfBfSADTECgn26X0Lq9Lj/7vLUWXgjLXD6HJOR9OgWbJR6QmZt0GT0GtMPrScrYl6JndwyOsSN/46bhr5UDvVfXPZbMVK0PkKmQdX+32g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7eu3DzVFGh99i1wY3ypYXdMNAVZvfmncPExyuO/CcQ=;
 b=HSRVmdPVCVkib4oDd+y9R2Mxsp0/xNqQnX1+Q1zexRDHdDFqmYoGtLIWJJxT3Ap0V8SZMpJq0g2QiESqfyha6x9pEWK3po7oF/TUHMWTCrXX1soSAE72QhNfCrrh3SIirzTy2B6Twjdy+o1wPZgsStQoI1/DaBWGBAsd0gFO7zMDBcPmQNvW6j0dsdq68YUK5IsPEaDsk10Vkshx2kmUqg9FfUP1oDVaHn5FHpDRUU7os83XFtVl5Ugqyy8QCNzklzVxhwm2SqyYzncc+V7WBo5T70eliRr/Oy2HNUocwGspleLsFcJkj8har4lYbOyUpDXyGusFwA31h3iVuCoDjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7eu3DzVFGh99i1wY3ypYXdMNAVZvfmncPExyuO/CcQ=;
 b=2z6eGyG5Q062QIrd+JSlQtzofB5K4w8Ej9eAKIQOBTQucFMnytakpazbEI4KWKUF1LytJVQoaBI55OdTCe1m3m0HAzJTjxfmRLp16Qd1ahVE98wLVSOXvrDLO7LSshy8WQfbqxGhQE/Trw4U7KcAlvHoX6r6ll6vzTKmMoFHPNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB6481.namprd12.prod.outlook.com (2603:10b6:208:3aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 14:41:45 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 14:41:45 +0000
Message-ID: <611f8200-8e0e-40e4-aff4-cc2c55dc6354@amd.com>
Date: Mon, 20 May 2024 09:41:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] "xHCI host controller not responding,
 assume dead" on stable kernel > 6.8.7
To: Christian Heusel <christian@heusel.eu>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Gia <giacomo.gio@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "kernel@micha.zone" <kernel@micha.zone>,
 Andreas Noever <andreas.noever@gmail.com>,
 Michael Jamet <michael.jamet@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 =?UTF-8?Q?Benjamin_B=C3=B6hmke?= <benjamin@boehmke.net>,
 "S, Sanath" <Sanath.S@amd.com>
References: <CAHe5sWavQcUTg2zTYaryRsMywSBgBgETG=R1jRexg4qDqwCfdw@mail.gmail.com>
 <38de0776-3adf-4223-b8e0-cedb5a5ebf4d@leemhuis.info>
 <lqdpk7lopqq4jn22mycxgg6ps4yfs7hcca33tqb2oy6jxc2y7p@rhjjbzs6wigu>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <lqdpk7lopqq4jn22mycxgg6ps4yfs7hcca33tqb2oy6jxc2y7p@rhjjbzs6wigu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0070.namprd11.prod.outlook.com
 (2603:10b6:806:d2::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dcea2cf-fe6a-40ba-e5b2-08dc78daf90b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVVlTzNsWEV6bnVabGJ6ZUpkelJpNkNYUDBveDBESHlkZzNlQnJhWGZHYlcv?=
 =?utf-8?B?RUE5N2FxMElDV1B4VFkxZ2lPTmNYcHNmZHJHb1I2cTJzVU9YTkYvOG5BZTJB?=
 =?utf-8?B?YVpvQVl4cjEvRndjYnpGVEV6dXQvMGdEblZta24zUlFwSHR3OUt3WmpuMmVt?=
 =?utf-8?B?MTZPd1lzZ3FWUDgwVHdFR3dLWXRZQ0ZYbzJzaDVEekEvb1lqRGlJdmw3L2hY?=
 =?utf-8?B?aU4vUVpXNG5PUWhHSVlkajhLdndmTmVEdHE3N1ZUczdUdVlMbVY3bnhNSkoz?=
 =?utf-8?B?N2pqM21vR3lHb1ZwT2Nxa0FiL1RTZ2pkU0VIdGNXNXZBUXAwVEhlUmtWQkZG?=
 =?utf-8?B?cFRHWU5hYWFySDZRalNWdlNsK2ZhYW0zZFpwQzFjdDJTcWhmQzdVTmhIem5q?=
 =?utf-8?B?K2lsMDZpeXhUQ0VGUUhnZU9YVU1KcUZUVEVwa2lMSi9RMm45YzI5SjYwZkR1?=
 =?utf-8?B?L2JXUnhTdFpsNjdDUmIwSXByZ3NZWHRDZHRVUjM3NExrdkwxMDE3T3g1MzRK?=
 =?utf-8?B?NG5YWnhQMCtadzFvdERQOHpCUFcyb003TlZMSWFQSFlPZzErdDFHWC9xWnk5?=
 =?utf-8?B?SjJMVmkvTDZBT3FHeVNsT011bE51Z3AyQXNCZVNHOWljYUw2dS9wbEo0QVdQ?=
 =?utf-8?B?dnRWL1hPODBPUjdZTmZrUVc1clVnakU1ZERmbGJmYzJFd2s0RE5TOFNLZ0xa?=
 =?utf-8?B?QTdOSmhEQXp2eUhMN1NxVXdlajR0V2RScy92eC93L2ZlNFpTbjFEYm1RWmVp?=
 =?utf-8?B?UVM5N2RWT3o0UE5JN3Vla2xhNDF1MVJKUzExaEhadHlpdXlaZnd6a3R2N1c4?=
 =?utf-8?B?cmI0ZERKdVVTOHVyUzZsVExKWnhLTEhCM01ReHRCODZPTGVmM21uTGRzSTVY?=
 =?utf-8?B?eDFyTUV3cUc0UWxnZUZIalNGYTdtQWZKK2dxSkpIMFFmMm5TdmpoOTM4UEIv?=
 =?utf-8?B?a0pIZW02MFdmZU9wQk5UMjEzMUZwS2Q2NjFIOFUzMmJFM0luUDdsNllhZlFk?=
 =?utf-8?B?Y3d6RzFlSVdJRmZJTkd1UXg4WVVYdjRLNi9VOUpFczRlS0haWWhrVmM0TnQw?=
 =?utf-8?B?YncyVkZrSjVBSXF0MHdaS21sajNXeUJobVVucjBnUFFIY2s1QnJ5VmVKd3k1?=
 =?utf-8?B?VFNMR2ROOVFMOCtnSnZkTHJSWVJFZUpneHBjajd4Q3IyM2hoVE96eUkvVVJh?=
 =?utf-8?B?ZzBUMi9ZNWcxZkwzcXVBaTRqVXBwWDZidk1GaDRaUm9VUHdoQTVBWEFZVStM?=
 =?utf-8?B?VWoxQWNJd0FWMVhFb2llbEozRUV6VkNOY1FKaGJUOUZwdjRGL0IvM1BTaTg5?=
 =?utf-8?B?VElNUGI2ZTNoeW1mcTlydHdZOHcvTGR6WnV1T24rMHB2V2wrNHFXYkYzL1RL?=
 =?utf-8?B?US9kV09uT2FQZTdJY0tUN3JrZjQxUE9IRkZ4UmZVZ1NWc2pnSldkVVFTelhI?=
 =?utf-8?B?OWprcFc4L0luc2xWZHkyU293Q3BLbHQrNjM1VnlBdWVJeTRaeGZHMWZEaG5H?=
 =?utf-8?B?cjhHOXo4aHZjdENmT2lnanBsNkNnVThMdmxBTnRrVm1WWnN0Ny9aYnYyWWJJ?=
 =?utf-8?B?QzVQRURIalJwQXhtVTc3WjdwTkRNMlFyZitwUjN2S2QyMU5RcmNTMkR1YnB2?=
 =?utf-8?Q?WKR8LRT55inT7Gkj/PD0EhRLnuC57S48a/Sf9CrQ/+4Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFlYRitWSHh1bUZtcGExclZxaE52eXNnUFRXTm1OL1pSdEU2cXY0VitLOG9B?=
 =?utf-8?B?dFBNb1FYeVFjQ1I4Q1dNbzMydVNoREtiUzlvNTdwRllFN282UkhiNDl5SVhX?=
 =?utf-8?B?NTF4ZkxzOTNVRkthZjNpUG1CUUlydGpqaklDN2djZ3NyS005Z3ZGS2d5MXJs?=
 =?utf-8?B?dHY4Zjg3WDA5OWE3WlB6Z3JGL1JtRUJlRjZkSVN2aEtranBSbG05N24ramY0?=
 =?utf-8?B?T3FpeVBvQTladnJ4WjBzMFM0eTZTOC9GLzlpc2lDc1kwSVA1MEpicjEwc0xu?=
 =?utf-8?B?Uk40RDBlRXJtV3dvMEhWUTN1bVRUUFFYYisrUG5RY3ZRejRyVXZ6ZGVnUFBO?=
 =?utf-8?B?ZTlUQzVGM2RmZE9mTTVsRDdBZ0JuMW9mbVh3dU9TYU90RG16dVg4MzJhOENY?=
 =?utf-8?B?dE5meVIzN09oTnlDbW1aVmMwZUFacnIyRXlEKzFmc3Zjc1BlUjVZcEh2YlFY?=
 =?utf-8?B?dE9yc0hsWDNUWjk3Qzh6M28vR28vWnVsVFFIbmVtakd2UGNtUDUwT0JXblEv?=
 =?utf-8?B?YkFGb0VlUHAvZ1p5VWRVYWptTGVUQVg1Vy9uRlBQUGc1VEROZ2ZjQVhWbGxr?=
 =?utf-8?B?TDZydDBsSWlxV1pJcEtFTmtUSmpVNHY0QWwvbnZ6TUMvSmlBa3YrMndlbGtw?=
 =?utf-8?B?UHpPZEQrL21sRzdmRTBiU1R6N3Z3QnhtTVhCNWQydmE1c0M5QnZNTXU1Nndx?=
 =?utf-8?B?OGFqQWpuTnhtTElGTHpMeCtvNmZpQ2toWkNMcmhwN09RaFZDMU1pUDgzcnpn?=
 =?utf-8?B?ejFuUjFQaktpeVBCQzNEN0dxbVovRnF6cXQyQWtyWGxZUUhBTmJvaEVkU1BY?=
 =?utf-8?B?bDdYOElNK3VSS2JtRHM0L3NVWS90bUNBdUlvT1ZybjVrMm5aQy8yaGFKZm5t?=
 =?utf-8?B?RHQ1dUU3bW9Ka2hXOWNBTlRYNTVLaVdEb2Nnd3JacmQ5Z3FPMjFGOGNlWmYw?=
 =?utf-8?B?QkRRVU5QeDNFbWlQQzFaZ0VRME8zd0hRSE15VzN5cjhPLzdRL3BjUEdURFF0?=
 =?utf-8?B?T3JydjRCNmxnd2tBekQrWUJDdVE0cnFjaE1IRW9SRi9YVjVEcitYOTlBUkxw?=
 =?utf-8?B?OEJVaDBEYysrQjhwa3FjNDdJNUNoNG1JOVVDeEF3TTAxK214Rko0alljUWw5?=
 =?utf-8?B?eUFTaEJxTmV0OEJLaTI1b3crREdMeUcwazh6TFpxUGMzR0N3eTNTZWtUVnUw?=
 =?utf-8?B?SElUQUpzK2tCb3BMUXhlQlFZWnV1ckNhNjR4ZlNJS2tIeVJBeVYzOXNvdUZx?=
 =?utf-8?B?WDduQi9FSWJkZ1o2aU9HTWhEMzNUMmR4R1NTMlIwRUFZZ2k1bXdXZ2RzalNF?=
 =?utf-8?B?SWszV05iUXNKbkIxd1ppREVCa0pVeFhVQUFyR0JJb1p1UVlRT0YvYmp1OEhr?=
 =?utf-8?B?WEM5TVpBb1RNeUZqd3JUek5KaG5jaDM2M2Q3SDZNK0E0SjY4aWRaZWxoTDk1?=
 =?utf-8?B?aHp4SFNEYlYrbitOdWwrQlVXUXhFTFByRUVnaXJKVkkxbm9uSjllMDJxWlFL?=
 =?utf-8?B?eTA1azR5bnRJSXQwc0E2K29La2N5b0hERzFxZzZZUGJjYWo2ZUVYVlNMdmpP?=
 =?utf-8?B?L2tsZXBzMU8wblBoV0dRU0p6MjJOeXdkSzJ5Z01xbzBiUHVhbTg2eFJUTVRU?=
 =?utf-8?B?LzQ2NjM3N0RKNVEzWHNXSjRvU3BPMGpMQUxqU3k0UlVLTTdlZ0NwcUI0cnRq?=
 =?utf-8?B?bzRGdmcrZU1kVE1DRTBIUTVqcWt2VWJPU3h1T00xRHY3eGJldXY2QUZoMDdO?=
 =?utf-8?B?aU9udEpmYzlCUUFpRXovUlVESUlFVHJ6QTZuYWRsc25QUlZCcEFhTTdtNFNU?=
 =?utf-8?B?cDJxNE54QnhId1l2UUtrWVdrT05KLzdVQlpCbkVHamcydnRURjdCNWswZVlS?=
 =?utf-8?B?cnArNkllZ2VkMjNTaGZmbGtNdHloaFlCNm1nckdMVVhUQ2NOdm5YekhTYk95?=
 =?utf-8?B?TmRWSXloZGkyRXc4WWwzMnBNK3ZETmR3QnBRVklmV2tCS0FQTno0V212OG1T?=
 =?utf-8?B?OXBKMmtjQXJ2RHNyc09HVjZGeTBRdnJOR2kwSWlDZEJYb0s5QlFiRUdZeVRu?=
 =?utf-8?B?cW40ZWVzYWN5cjZjdFVRZ1hSZXh4YmxmZkN2TEhFV1FySU5aeGhoN05DQnY0?=
 =?utf-8?Q?NfW3sPYdVNya5vdpg7B3sscM+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dcea2cf-fe6a-40ba-e5b2-08dc78daf90b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 14:41:45.7670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4qhVb974Sf+2KrdoidE4vNB+Pp7duPi2k/M+YXskcFh3ztl4iF2mfggOErThFqJC2O8Mr1Yr5bXJcxZhq7Me9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6481

On 5/20/2024 09:39, Christian Heusel wrote:
> On 24/05/06 02:53PM, Linux regression tracking (Thorsten Leemhuis) wrote:
>> [CCing Mario, who asked for the two suspected commits to be backported]
>>
>> On 06.05.24 14:24, Gia wrote:
>>> Hello, from 6.8.7=>6.8.8 I run into a similar problem with my Caldigit
>>> TS3 Plus Thunderbolt 3 dock.
>>>
>>> After the update I see this message on boot "xHCI host controller not
>>> responding, assume dead" and the dock is not working anymore. Kernel
>>> 6.8.7 works great.
> 
> We now have some further information on the matter as somebody was kind
> enough to bisect the issue in the [Arch Linux Forums][0]:
> 
>      cc4c94a5f6c4 ("thunderbolt: Reset topology created by the boot firmware")
> 
> This is a stable commit id, the relevant mainline commit is:
> 
>      59a54c5f3dbd ("thunderbolt: Reset topology created by the boot firmware")
> 
> The other reporter created [a issue][1] in our bugtracker, which I'll
> leave here just for completeness sake.
> 
> Reported-by: Benjamin Böhmke <benjamin@boehmke.net>
> Reported-by: Gia <giacomo.gio@gmail.com>
> Bisected-by: Benjamin Böhmke <benjamin@boehmke.net>
> 
> The person doing the bisection also offered to chime in here if further
> debugging is needed!
> 
> Also CC'ing the Commitauthors & Subsystem Maintainers for this report.
> 
> Cheers,
> Christian
> 
> [0]: https://bbs.archlinux.org/viewtopic.php?pid=2172526
> [1]: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/48
> 
> #regzbot introduced: 59a54c5f3dbd
> #regzbot link: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/48

As I mentioned in my other email I would like to collate logs onto a 
kernel Bugzilla.  With these two cases:

thunderbolt.dyndbg=+p
thunderbolt.dyndbg=+p thunderbolt.host_reset=false

Also what is the value for:

$ cat /sys/bus/thunderbolt/devices/domain0/iommu_dma_protection

