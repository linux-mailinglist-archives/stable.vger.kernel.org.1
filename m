Return-Path: <stable+bounces-88025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DF19AE221
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 12:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB5A284059
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 10:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BEB1BD4FD;
	Thu, 24 Oct 2024 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4LxdFEjE"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A10B1BD028
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729764509; cv=fail; b=YTTLJEbEmf9bbSmVREzi5zqhw+a+tsjz4L5P7md15HQu7xPGMz7OBPPe72tcAq6zOtJ7o9dKxeEB0Me2ATWNPcaFzOUn9wtujnflsKyfqmFnQY0mQNpXsVRqXxHhyviHHrSl1ws1OI2H5jGTiIp1OkLt/znK5NDjHj4scpGkYWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729764509; c=relaxed/simple;
	bh=2NYUyH/yV+Zvs/NoocCkcnCRo7HH+fI2VYIUA45RogU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=upXxaXAbpsfaZWVxsLUtoOhNyO6a7SnuXshd6suSmFc8uXM9Jm0iwtAW+WzzQzcGh63tzE7xOrM/4gYwM2JNjdrakg5CHyQRvZVsPOR652fkNL7hqbJETsx0qpN9gaE768+uXCXLOIOOZ6XAHlFwi1Tvd+NVYFl3d4vh1ANPdMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4LxdFEjE; arc=fail smtp.client-ip=40.107.101.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBjZSsX1UdydJUzG+Zvk6w/PkOmqOdEoen5B13uIM/WOxwJP+c+WlGoXOBYkaVy5/RS4out4b7EMK4qbVDGwBrOgvKU2N0an0Pd0ffVBIA3yYkM14XSVTFnWiESISv2Zf5aDboyyP+oDtJ/l8S4W/DUFamtIJTeIoceiSvMvffXZ0c/YSjX+4BBkv92HvenoCJSS2hF2v+Q4nElgSp3MBYZmGK9xFv5podoYlcL+pbVCKcL1ADlbgigevlfzZRguwfABeLkb0oA0FMk7/IG385gviD7K7aIILPvaty/WAYHgk+I+Yn9Olzfk4VkagzAiFAUYEXyoRcmrfVjQ1zWKOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uD3n8fLZyKuhiF1cnBHRKo+5tWEiEs2wdK76KR3DI0U=;
 b=PljCMZ5NqEbiV6CzthGVNWf2h9dl2jHsywPSkbhAcUanbIuYBVrl9CmB9YXZNqJGS40oSSI2ld9bSkcCg9SHqIvwwnFW1jbwjgSFicSZVOKz1jIpKt7jrSM80CGgtGbKNlzACjYfyiW0j/jfXU3KhRVZmX8DRo7fpr25P62hKFR7hWKj/QMxYVp1CVnurjNqgK7K2utVkC7Lx66y7KwtjUO6lkkQ8SEz+MmOLMWrTlwdXzBbQOgcZaY26RmoT1piKLYo++emjGxO78YebHb55k9lvte+e85h5F/eupL5N5JGnGYWk21i0MYAcFKwsh5epYhrlP3nm6mu5ipG0c+rFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uD3n8fLZyKuhiF1cnBHRKo+5tWEiEs2wdK76KR3DI0U=;
 b=4LxdFEjEk/zWuVnYBhNL0FzmOWA25nea1Z6WefOoRSB1pmd9jjxozN1VpS7Oz+j1C1hq1O5tLubjgv2kcGsMubgGediQfzWTA4tfBsEEaWTvYkThl1zBqi4cKEwvv9OYYdqwY92Kyz0zV25aiv0SsL//7IAIg70lxx1eCOpRbV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by PH8PR12MB6793.namprd12.prod.outlook.com (2603:10b6:510:1c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Thu, 24 Oct
 2024 10:08:23 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef%7]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 10:08:22 +0000
Message-ID: <ea1bb558-53f0-4528-9160-48a3ff178cb5@amd.com>
Date: Thu, 24 Oct 2024 05:08:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, Steve Wahl <steve.wahl@hpe.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>
Cc: Dave Young <dyoung@redhat.com>, "Eric W. Biederman"
 <ebiederm@xmission.com>, Pavin Joseph <me@pavinjoseph.com>,
 Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org,
 Eric Hagberg <ehagberg@gmail.com>, dave.hansen@linux.intel.com,
 regressions@lists.linux.dev, stable@vger.kernel.org
References: <CAJbxNHe3EJ88ABB1aZ8bYZq=a36F0TFST1Fqu4fkugvyU_fjhw@mail.gmail.com>
 <ZensTNC72DJeaYMo@swahl-home.5wahls.com>
 <CAJbxNHfPHpbzRwfuFw6j7SxR1OsgBH2VJFPnchBHTtRueJna4A@mail.gmail.com>
 <ZfBxIykq3LwPq34M@swahl-home.5wahls.com>
 <42e3e931-2883-4faf-8a15-2d7660120381@pavinjoseph.com>
 <ZfDQ3j6lOf9xgC04@swahl-home.5wahls.com>
 <87cyryxr6w.fsf@email.froward.int.ebiederm.org>
 <ZfHRsL4XYrBQctdu@swahl-home.5wahls.com>
 <CALu+AoSZhUm_JuHf-KuhoQp-S31XFE=GfKUe6jR8MuPy4oQiFw@mail.gmail.com>
 <af634055643bd814e2204f61132610778d5ef5e5.camel@infradead.org>
 <Zxgh-hBK2FfhHJ9R@swahl-home.5wahls.com>
 <e373dcbdd15d717898cfe8ebde74191b5f3acc4c.camel@infradead.org>
 <1f6feded-066d-4207-9645-f2bbed5ebfee@amd.com>
 <e4cc1e0cfca0d954ca22d850ac771c4bf7406902.camel@infradead.org>
 <229dd4f4-b556-41ef-bea9-9fafe07180c5@amd.com>
 <707cd3ee6ca042d67fb506ddc8a01ad801dc262a.camel@infradead.org>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <707cd3ee6ca042d67fb506ddc8a01ad801dc262a.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::17) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|PH8PR12MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: b21d2cc6-c2e0-408b-e859-08dcf413cab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWdaM09IS3JhNWV0L3RCNDhYT0lxc0R0bWVER29DZ1R1ZFJrdEtDRmF4YkZ2?=
 =?utf-8?B?OHdMTUg4citkNC9ET1NVNGFoTTY3TUVURHdEKzhlcVVJZHViRXEvS3dUMDYx?=
 =?utf-8?B?T3pVYU5rbmd5V0grVWR2SkZHeEtIZnhXVUpvSmlxZkFDMlRvZ2s5QjNRNkNw?=
 =?utf-8?B?eHVZWk8xeko4YjdGZVY5WU9MOUlaN3VFc3J5Vk5mUUdBNThJN2Y0NWdoZTZ2?=
 =?utf-8?B?MWpNa0VOQUNRR2ZzV3h2VTlMQk1ML1pESHJFcmp4ZXBxczRFTDM4Yzdkbnd1?=
 =?utf-8?B?Q3ltNG1VQW9HRHJXTGlJZU9aNWI4RUpQb2lRMm9tcENxRkdwMm0rcFNPQk5n?=
 =?utf-8?B?cnNRTXlENnA2MFpVclR6dm81MnpsaFcvSHNnZWVMbzR5MTFjZkUvMU5FcWo5?=
 =?utf-8?B?bGkrb2NKdHc5R255ZVcwV2c5amg5eWpXd250eXRmTG8xNm9VOWk3bFp0Um5q?=
 =?utf-8?B?RU9mUTdWQi9YTnc0dEIva2d5WGcxOGMxM1E3b0VpN1NOcVpVRW5TYVBocmph?=
 =?utf-8?B?akh2QnpPaVFPN0l2am5hUHRoVG5qQ1RYZjBERWM3NW42L29MVWxOZEUwRElt?=
 =?utf-8?B?ekpEdEdLMWF6aXFIb3ozWUdicFF4Tkd3ZmZ5eUJ1ZGFUYlc5VFdqelhXUWI0?=
 =?utf-8?B?UzE1N2N2ZUxOMHR5a0xmN1gwQzUyZ1NHcmhQdnM5SG5TZUZPK0o3OS9UdnpR?=
 =?utf-8?B?WFA4VVkvVEJjb3ZvVkd3enZReHFsQVpxZXFhaWhrdW5GZ0hpdGkrMkozc2Vu?=
 =?utf-8?B?OStkdlJ2MUJpTTRTcXJ6YUJSdGZydUtIbXptT3RibEh5TkVpdUZpVFVVU3dQ?=
 =?utf-8?B?Yzc4eHpMV0F5WDdXOXNwVnArUEo4ajBOR3BabWpnclNZNTNDZEhnZk9xcFB1?=
 =?utf-8?B?NTdBWkFpNmwrM3hKQThiSEhLVEd1TTBFT2dCMytiK1JpOXRSQVZSQ3laWEY4?=
 =?utf-8?B?bWtlMytodENsZjRrbTdjelhpenpTd1hYU010VTJPcDRPNTNRQ0hvV2RLbW1S?=
 =?utf-8?B?bFdWbWN5NzRTclFNVy92VGNOaU1TZEJzTGhMT3d5ME1ON3ZMbVJEUkZ2dXFR?=
 =?utf-8?B?S3JXeVhxNmJQdzFwODlzc1ZJR1A2L2Q5RnFja2lLU1ZhWHRwVUpyRnNTdkFR?=
 =?utf-8?B?YXg0RDJUaHg2Zk1zbTMyNU42M2lRZm9TbkM5cVBPTE43eENSQjdERVdwcjMw?=
 =?utf-8?B?RmNmQ2ZkRFZXeWdZOVVaZHJOblNkYWZKL29XSUljSkh3R0FBbU9BNlpVUnVX?=
 =?utf-8?B?U2VLT1VTODc2SFZETDBLY0ttdGNPM2U3eGtUb0pQM2c5QkhCQ2lnT3FFNU1N?=
 =?utf-8?B?WXYvekZkT3RQV2xybC9NSlhwd1Q0UWZmU2d0YXBUQW02UkloLzl2WUJ3Nndl?=
 =?utf-8?B?K2dHcnlqd1J1anNQK0dmbC9YQ3FGRjA5WURtSWYrMlZHc1J5YzU3NnlIUXFO?=
 =?utf-8?B?L1c1ZU5LYU5uM0JRdFh2SzUwM0Y4aXlEUnRIeW1lZXhsbHRIRjl4YW1WcFVx?=
 =?utf-8?B?NVYwZjl6eXdacWcxQ2VzV0RHVG5sWThZN2F5SVdKcHFucFljMDZsVVVQc3I3?=
 =?utf-8?B?bkxEM2VjeTZwK0Z3dnB1T3hUVHJFeGtLSUNmTU5Wek9FelZwY3Q2Zm5VTHhH?=
 =?utf-8?B?TXQ3REplY2FPSzBpNHpVcWdLbnFPTWNLVXMzMkhwQXhmcTVtQ3JObDlxSDJP?=
 =?utf-8?B?YWpOMWJpRVBldjg1VFA1QUxmQnVYQ2Z0TUQwSkhOZFJjeFg0M1dxM0ZKNVU4?=
 =?utf-8?Q?5zDY1b3fLsZ8KzpC9hUkswzOPZ6Z8Bvj8MozkCy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3VKNFpNT2owTzdjSGVOZVhpcTBQUTcyQjVjUkRYME5vZVZYdFBEZnNERkpE?=
 =?utf-8?B?aEQyaGJYL0lmMnkyQ0JyYjNsNGxreFRxM24vdkloYkpFZHowU0s1cE5GY3lz?=
 =?utf-8?B?OXJrVFlKWTdGc0NrZFhDV3p4TjBZRlY5QmZQOWF5b2tSUmk5eWxpNGtzSTgw?=
 =?utf-8?B?aytKdTJObkNwNjJZN0RVL05wMmxyOVFWYXNuR29xaFMyMG4xUC9HTEF0MDlY?=
 =?utf-8?B?dGJMclBWdFNQbUdqMVhJdkRYdU1OdE5vYjExRFZvazdOdDk5NXYxSThVWEV2?=
 =?utf-8?B?c3RkUUhUUEYyc3lVWXJsUy82TU5RWkdxdU1HME1IczAwNnIwTHdBZVZISndK?=
 =?utf-8?B?N1l2YXRWWE8rZGtTOUhNWXFCSGlsdkZ2OUZJVERCMWwrbFFTV1YwYlZoWkZk?=
 =?utf-8?B?K241UXZPK3RqZFRxUDZTZm0xVTl1bU9uZDlldTVreHJHZ2xvKzcwMUF2V0w2?=
 =?utf-8?B?cUI2YmJyWXo0MExBYUozZzF3Qk5vM0JzeVlUR1RWQUFVaVdxTnR5eS9jWUZP?=
 =?utf-8?B?amtxKzZvT2Z6MHBQVFBXQkxzTHdPOVFXTG03cEFLVGQ1cHpFOVc4RjE4T0dI?=
 =?utf-8?B?dUQ2OTl4SzZDd095cG1QdjJIRC9ZSG1EUEVldFRqUnJ1NUxFdWRpS1VKYTFT?=
 =?utf-8?B?bTlCakVpbEdUT1FuekNRY2hlL3h3TFZzWm96M1RYQURkSUdZam42TmlocHh5?=
 =?utf-8?B?VnZrMm1hUVppaTFuZGFaME1oZmR3ZC81dmhRVEZybGk4UExlalJPdW96dXR3?=
 =?utf-8?B?eGlxOU1pRXN4ajFuTFUxT0UySW83MUdPb1VhSlkvZ3hhNVlXUUpyc0hLVGZF?=
 =?utf-8?B?QUVCK1JBcFllZXpSbWF2WUcvdDQrczVpZWdZcXNheVdCMVBDZHh2QytBbGlI?=
 =?utf-8?B?SGJhRDBzRmRNU2dqZ2YwU3V3L3g2ZndCM1JqUklyWWx5R3NGRkxtSzJOOVZx?=
 =?utf-8?B?RG5nSGF0VlZIbzVjSXF5Q2lNRGJtTjVwMXhmazArN3VvUU9taTRUd2tyc2JQ?=
 =?utf-8?B?aG5zazRJNFV0Wi9HNXVFZVpOR1JOa0FoOTQ1Z3JqUkg4aTBOd3FYd3hzNWpE?=
 =?utf-8?B?algxZ1ltd2h4Y2Z4ZmV6UjVrNFphdU5lRVgrQ0dVWm9WTW0rSUpxdEpwakJ1?=
 =?utf-8?B?Z2V4WldmUkc5c0czS2g0Y3NkNGpBSC9WbkFZSXZpek9zU1psQ0hodWhNWG1l?=
 =?utf-8?B?YXl6YW4zTkJXU0l2UWhsT0FFeTEvSGQ1ekxsSmYrUytrK0ptbTdFK1h3WHh0?=
 =?utf-8?B?TUJIbVJQdTR2K2lEeHNJeTZGU2dxM1RaWUpxc0kvcFRsMGtrUE5FVVRYaml6?=
 =?utf-8?B?YS8zT3luZVBTcU1xV2IvK0wzNGd4RXR6aVZQQzYxS3BuVGF4REdmcldzbGdx?=
 =?utf-8?B?ektid2xrclQ2MHlQa2p6MnAyRlZRMllmMjgyc0JsKzVjT2Jtbk1hd0NiSCtM?=
 =?utf-8?B?Q3hnczVWVEJ1VkRSTFFHMjRZQjNFYTgzdkJneUNZL05Ka2U0bmY2SjltZEQy?=
 =?utf-8?B?UlNIZzExeU9oNGZNazVqVFh2ZjBCcVFmcm9WMTV6M1ZqZno5UWFCckpOaEFF?=
 =?utf-8?B?dmhSSTJpSXRIWDlQbzlweFlEeGhIakNVTUtzaDI0TUgwV2tTS0Yyekp6SU9y?=
 =?utf-8?B?M0FHUmF5TE8rNHUwd25tdVpyRDZESFRaaGdYbTRnWHEwMjZmOSs3ZW00SDUz?=
 =?utf-8?B?ZDZCYVBoQTBTVUk3Q2IwNkplZFlDbTZCMlY2ZjBwNSszM21rQWI3YTJOSnJD?=
 =?utf-8?B?R0Q5Zlpib01QOXFydU1zUmFjZXZoc1BqMVFtOHYyTkZPT08wUkdBbTB4UTlS?=
 =?utf-8?B?RHJaeUZTOFZWa2RWcHgrUlByL28wRWFSRVU5Y0VFTmlPK3J0Nzg1ZVVJK3NH?=
 =?utf-8?B?amVrUDhOWWJEYnpCdFQzcTN6eUJRMHdkcy84YXFFVGVadHBSWVZ5bk9LaHNJ?=
 =?utf-8?B?Y1N0RXdLdW9iZ3lNWHRkY1JQL0tma0JRT2M3NGxPcXRWZEVEaW9TaG85cUUv?=
 =?utf-8?B?SExYV3I2aGE3enBLN3gzMTFSQXM0Nm5JTHJUS2NsMVpubVZWOThQSWw4NXZO?=
 =?utf-8?B?QUFQbVhNaEFpdnNKSEh4MUE2OEt5TjBxY29rcDVEeXdDUDVETFlEN2tFcHNs?=
 =?utf-8?Q?vjQoosa3Q0sJLEAfTnFoZqE2Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b21d2cc6-c2e0-408b-e859-08dcf413cab2
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 10:08:22.4855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdBFC6Z6ZjQKEiibNYIMWIQQCHUuYpeJjfHvvlruKRW47cWYxTIyMRAowrGtJw2LC83LUGSQYOz3RNibxsWp1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6793

Hello David,

On 10/23/2024 8:50 AM, David Woodhouse wrote:
> On Wed, 2024-10-23 at 08:29 -0500, Kalra, Ashish wrote:
>>
>> On 10/23/2024 6:39 AM, David Woodhouse wrote:
>>> On Wed, 2024-10-23 at 06:07 -0500, Kalra, Ashish wrote:
>>>>
>>>> As mentioned above, about the same 2MB page containing the end portion of the RMP table and a page allocated for kexec and 
>>>> looking at the e820 memory map dump here: 
>>>>
>>>>>>> [    0.000000] BIOS-e820: [mem 0x000000bfbe000000-0x000000c1420fffff] reserved
>>>>>>> [    0.000000] BIOS-e820: [mem 0x000000c142100000-0x000000fc7fffffff] usable
>>>>
>>>> As seen here in the e820 memory map, the end range of the RMP table is not
>>>> aligned to 2MB and not reserved but it is usable as RAM.
>>>>
>>>> Subsequently, kexec-ed kernel could try to allocate from within that chunk
>>>> which then causes a fatal RMP fault.
>>>
>>> Well, allocating within that chunk would be just fine. It *is* usable
>>> as RAM, as the e820 table says. It works fine most of the time.
>>>
>>> You've missed a step out of the story. The problem is that for kexec we
>>> map it with an "overreaching" 2MiB PTE which also covers the reserved
>>> regions, and *that* is what causes the RMP violation fault.
>>>
>>
>> Actually, the RMP entry covering the end range of the RMP table will be a 2MB/large entry 
>> which means that the whole 2MB including the usable 1MB memory range here will also be marked
>> as reserved in the RMP table and hence any host writes into this memory range will trigger
>> the RMP violation.
> 
> Hm, that does not match our testing. We tried writing to the
> "offending" area from the main kernel (which I assume was using 4KiB
> pages for it, but didn't verify), and that was fine. 
> 
> It also doesn't match what Tom says in the email you linked to:
> 
> "There's no requirement from a hardware/RMP usage perspective that 
> requires a 2MB alignment, so BIOS is not doing anything wrong.  The 
> problem occurs because kexec is initially using 2MB mappings that 
> overlap the start and/or end of the RMP which then results in an RMP 
> fault when memory within one of those 2MB mappings, that is not part of
> the RMP, is referenced."
> 
> Tom's words precisely match my understanding of the situation (with the
> exception that he keeps saying 2MB when he means 2MiB).
> 
> I believe we *can* use that extra 1MiB which is marked as 'usable RAM'
> as usable RAM if we want to, as *long* as we don't use a 2MiB (or
> larger) PTE for it which would overlap the RMP table.
> 
> And the only case where the kernel uses an "overreaching" 2MiB mapping
> is the kexec identmap code, so we should just fix that.

Here is a more *correct* explanation of the issue after discussing it with 
Tom: 

The RMP entries for the RMP table memory are marked as firmware pages
(meaning they are assigned and immutable - with the key point being
the assigned bit is set). If the start or end of the RMP table is not
2MB aligned, then the RMP entries are broken down into 4k entries.
Using a 2MB page table mapping (kexec identmap code using a 2MiB PTE),
if the kernel tries to access the portion of the memory that is within
the 2MB page but is not the RMP table, an RMP fault will be generated
because the mappings don't match.

This is documented in AMD64 Architecture Programmer's Manual Volume 2,
section 15.36.10 - RMP and VMPL Access Checks.

As this RMP entry here is covering the RMP table and usable memory range,
so it needs to be smashed to have 4k entries.

So, the RMP fault is being generated here because of the page size mapping
mismatch between the RMP entry and the page table entry.

> 
>>> We could take two possible viewpoints here. I was taking the viewpoint
>>> that this is a kernel bug, that it *shouldn't* be setting up 2MiB pages
>>> which include a reserved region, and should break those down to 4KiB
>>> pages.
>>>
>>> The alternative view would be to consider it a BIOS bug, and to say
>>> that the BIOS really *ought* to have reserved the whole 2MiB region to
>>> avoid the 'sharing'.  Since the hardware apparently already breaks down
>>> 1GiB pages to 2MiB TLB entries in order to avoid triggering the problem
>>> on 1GiB mappings.
>>>
>>>> This issue has been fixed with the following patch: 
>>>> https://lore.kernel.org/lkml/171438476623.10875.16783275868264913579.tip-bot2@tip-bot2/
>>>
>>> Thanks for pointing that patch out! Should it have been Cc:stable?
>>>
>>
>> This thing can happen after SNP host support got merged in 6.11 and SNP support is enabled, therefore
>> the patch does not mark it Cc:stable.
>>
>> I am trying to understand the scenario here: you have SNP enabled in the BIOS and you also
>> have SNP support added in the host kernel, which means that the following logs are seen:
>> ..
>> SEV-SNP: RMP table physical range [0x000000xxxxxxxxxx - 0x000000yyyyyyyyyy]
>> ..
> 
> Ah yes. SEV-SNP isn't actually being *used* on these Genoa platforms at
> the moment, but I do think it's enabled in the kernel.
> 
> If this problem only happens when the kernel actually *enables* SEV-
> SNP, then it seems this fix was missed in our backporting of SEV-SNP
> support to, ahem, a slightly older kernel.
> 

Yes, this problem only happens when kernel enables SEV-SNP support 
and SNP_INIT_EX has been done by the CCP driver to initialize SEV-SNP support.

> But I still don't like it :)
> 
>>> It seems to be taking the latter of the above two viewpoints, that this
>>> is a BIOS bug and that the BIOS *should* have reserved the whole 2MiB.
>>>
>>> In that case are fixed BIOSes available already? 
>>
>> We have been of the view that it is easier to get it fixed in kernel, by fixing/aligning the e820 range
>> mapping the start and end of RMP table to 2MB boundaries, rather than trusting a BIOS to do it
>> correctly. 
>>
>> Here is a link to a discussion on the same:
>> https://lore.kernel.org/all/2ab14f6f-2690-056b-cf9e-38a12dafd728@amd.com/
> 
> As noted above, that message clearly states that the BIOS isn't doing
> anything wrong, and the problem is the kernel using large page mappings
> that overlap reserved ranges.
> 
> In that case, shouldn't we fix the kernel *not* to do that?
> 
> I suppose we can be OK with "let's just avoid using that memory to
> workaround the kexec/identmap bug", but in that case let's not claim
> that we're working around a BIOS bug?
> 

Yes, this is the approach we are taking currently to workaround the kexec/identmap bug with the above patch.

Do note, we *need* to do the e820 memory map fixups and additionally do memblock_reserve() to ensure that this
usable part of memory adjacent to the RMP table does not get allocated to guests, otherwise it causes 
RMPUPDATE on this range of memory to fail, fixed with the following patch: 

https://lore.kernel.org/lkml/172968164814.1442.8035313578482871705.tip-bot2@tip-bot2/

Thanks,
Ashish

