Return-Path: <stable+bounces-240332-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLC0FC3Y6Gl7QwIAu9opvQ
	(envelope-from <stable+bounces-240332-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 16:16:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C8C44727C
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 16:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A218A306D28B
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 14:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043283EAC71;
	Wed, 22 Apr 2026 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="smSfH+C3"
X-Original-To: stable@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDB8221F0C;
	Wed, 22 Apr 2026 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776867090; cv=fail; b=m5YWNVD3o8ax+vpMAMa+dtk8JgV5JMyeq52CBLYaelA88DCNI3UIQJbyd+Yz3dYm/9WEAT28VvplLVhxv3cYdhL/rnXIr90EL4nzfa6xoKYIEdz33qc4iWf+UvCa3t2cRhvv0msltkN+jGCFmWtS4zgcY+T4aWficSAotY6wt+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776867090; c=relaxed/simple;
	bh=XrGkye2swADos2z/Ywvov9gJ2jcs+7XnRlTu7zUxTqk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bDydIeGWUS3updKY2SFGwIbKBK0CZv7lryxD0dzMcbz2ydKBDwJFi3409VxzuvwsEuzdh3MY0Wigtmj2VaubWF1UMPaAcmJJabn4/c3zZ3s6vyx0Baaw1K2Y5zhZ7Moy7s1rszvT4F9FKYvR+4lahvKrm/PSmUZnHNgdkvvYVdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=smSfH+C3; arc=fail smtp.client-ip=52.101.85.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7YG1d8ZWtYpPNlNZGx+6VfTerp0mZaUUVSNMUbhSO/XTPMpvANft3Lj+6aFgJ7BvGWyE7QIMbPZvzy+98XZ/mtxXIFDmWsfzu6wEV1vSX9XvVwfRjOtYYaHlisdmpq90Y5NtaMPYxT5lBLZgIJDI7WMqDOI31lv05eZ6WK6eWjL7Wq1+/3//j9NMfCXV8dIdWUpco+Cwx5jGgnvtNr0nzTTtg61bGtwRxq6ZuBeIndLkWc+tzUVctcP2OiSc05hDSgDVGIC2wtVg6IPG7HuL9FTwu8k/4Gkr5OYrBlur33WptdnnmwUTdrEibasxivaWylS976bnRqHLvXYtK09hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJnYUs2XfWQDO40943XI3bCqmE8mYFFR+XA5DVwt//I=;
 b=KB4YCh4vTrjy+wuwI/0wkeA1iuTioAis5uK+KuP/oVXj0qaDKxJ3C0ch5xhyay7cxtO8gBHwTqh8Mi6QZH/5ycsbOBV0fqmIYj8Jtfm7yyG3X1+hwx48Au8+MVApNjT4tDIwt0BkM9iz+S4UtrfY+gWgqkNqKFxd+nkyNf0xduMxUGVaLpC+0Hj7lHsVkgjXx/KwZFgz1CHvZVWnoPddwsxK2m+ao38Bqi9n0uQrPS+YW2n/izlIPFjgdvHjtLTNOp0BS9WmbupxizMlbySc5i3seAw2kx4NRVBNKCKqtqKg8ytg2W3SS7ltbZs9xJHN92D6T+U0cSoWtzW6S+9i7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJnYUs2XfWQDO40943XI3bCqmE8mYFFR+XA5DVwt//I=;
 b=smSfH+C3+RyM9IagCt49MaDiFvSTzaL54mq+B34xK5XhdxBUVjzUOPRK5KbUWxCQPRLiI3/1nW/ktJf8u2dlXhZn1JCf/yB0vgnHNxhTW4kVC0b53uR8MBuK9Xvrmz1UDVbSeXTg95cIEOBDK5N2OFJQhdiwmRSe+mFt5hBD+l4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB6126.namprd12.prod.outlook.com (2603:10b6:208:3c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.19; Wed, 22 Apr
 2026 14:11:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 14:11:24 +0000
Message-ID: <6064b45a-b8de-4848-856f-383d2d06680d@amd.com>
Date: Wed, 22 Apr 2026 16:11:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y] drm/amdgpu: remove two invalid BUG_ON()s
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 stable@vger.kernel.org, Robert Garcia <rob_garcia@163.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Pan Xinhui
 <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yifan Zha <Yifan.Zha@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260417074010.1607496-1-rob_garcia@163.com>
 <7260936.9J7NaK4W3v@timur-hyperion>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <7260936.9J7NaK4W3v@timur-hyperion>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:208:530::33) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: f6f4d65f-21d2-450e-a803-08dea079091d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AFR3YVjdD6hsd6oPgfU1VocHiFpIqpyTT4XpXYeTx71qL/kyJCHRUOkGI0zJB9dbA7R2MvQYhfqwFGk04ZYhlHPo0trt2LQQMJiJT7dSmWRBptY+A7urUFx3A4ozbIhlK6mjDA3kwXultx8FUPp5MggN/n3havieg7GcZB+ZMCrAq293VUCiY1UjfJB0ZqTUWTJGPs9jjGeHMn37HmXRqK4UGZEU3M1IBDq9RmdcwUhYYwogJWxeSazpmhcc55ilEA+r3b7NTXr9GtyNaWLL/K+cLKy4NcKx2XFCP/9ag1iS82JdVR84mfrjAVKVWX5EcOOX8lAJbTPHgWAKm5dvW9c4aijZNjLJl3AleLULNCYm/dmzKbpWi32OrmNc5qmCnBgv/9B0mKUKuzuDocIlpYMaGsLsM1sXseKAL3hFPWCP/yRDr3npYXwHfUN7hC+Y7sT7+yX+zllOpw5FZCLBeuTmu7p0F3c3hmZVRpg9VxL20F8iX5Glb4yC5fwHVUSJv7NHNqcmtturEVYRCO9gtN7Lu1A4T4mQBWK2PTdNBGkygZtQ+dFbnsCBWIUz1zm2dYbjR5iB810+yGVgCMcbNdE2iQ0XGMXji+wagTy1hIRdW9VfG1nsEVeAWJda9g35/qNavA5V02ShIuklDdJIFU9iyAQK7g8L2EoTr6IDwHkgH4T7K8tinDuMyWzat5lo24Te9b1GITo6Py9jxPuUO0H/S1oSCxrHi4fuuC4HUDw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1pFS1UrOWlyTHVLZHdRUkRBNmRvenV4RDNPVGhEVzJaMTBXMDNaaDZ5VXQ1?=
 =?utf-8?B?QlVPN0w1WDVYbFBoM1I4YWI4QjgvMFlsazNSbnNGNlNja3BRNFJxYkF1aDN3?=
 =?utf-8?B?NGtVT2pSb2tmOE84MzdsbWVHZzR1RU9pcC9xK1NoWi9SRlVmQ2NuUUVxK2E4?=
 =?utf-8?B?NW8xQk1hd0laZzZwK1htUnlxWCtyaTQyVmMzZENOQkFLUjA3REcvTCtvbFVw?=
 =?utf-8?B?MnVMOW1LS3RxSXh2K1lRdk9FNWgrUnhZNHlOR1ZweXhYK3B3K20yOHZQVUZZ?=
 =?utf-8?B?cnBzd2ZFZFJXR3Y4QTBNckFDeUhvWDh5eFVqODcyZEIxaDB4aWhaSjNCREhj?=
 =?utf-8?B?N0JaWXU1VFhaNjd6M2M2ajBmNjhSNmFneEV4Y2xwOVhjMENCbG5jTHE0M1hJ?=
 =?utf-8?B?NEVSTURiWHlCQVFSNk1KUXM2aGV0S0poY1BwZUhjME1ZNUludGhoMDc1SUda?=
 =?utf-8?B?UHBCYUwvRjg5VFI1M3FGdU9qS2xuU2N3Y3oxMzU5aTAwM3dxb0dXVElEaUQ2?=
 =?utf-8?B?V1ErMnhRcVBNWXk1cG0zYmhLOTN2UHVqRkN3NXh3STdkYy95NXBhOXJST1JS?=
 =?utf-8?B?L0YrN3pxZlVwS3hiWnpLZk9zU21Vdmw0WkxKeDF5MFVMMWFna1orZEhYU3pB?=
 =?utf-8?B?dXVGRldRdHMzWWZQNjNrOW5ORmNHOFdaeU1xOUpibmhuQk1kazlqMUZUditV?=
 =?utf-8?B?T0VIWkpVRmZUMkxta2hOQi9EaytpWTFBMFBxVEpsYm1DcHV6RDBqajFwYUdU?=
 =?utf-8?B?aGpmYi8vcitDWExkcjE1Ymczd2VkcHZOS0NyM2hQYnFpTEwya2hRRDRJbUFS?=
 =?utf-8?B?dHIrTkg0b2EzWXRPSTdWRHFoU1FPdnV4ckl2L0JMd3paRnpubUpJVXg2VjBW?=
 =?utf-8?B?c3hkTEF5WGtMUkwyelZOckplMENNek5vSkxEQ0Z2SFJUd3BjY1RjTFpKSU1o?=
 =?utf-8?B?MEh0UmFXREllSzhzSEsyUmJ6WVovRTZETDJhT2dDa01LZWMvRG5jTVcySTJZ?=
 =?utf-8?B?eWVSTmVJZUVwMHI3ZWU2UmdpVW8rcEJuSFV2WmRjazBYMmpkWkh6YTVaaUs0?=
 =?utf-8?B?KytvblNTUGNpMDVmTm54RmVLNXl1MU4zRmgzZHR5OHN1SGtJYUpQcy9lUElC?=
 =?utf-8?B?ODhwVXNWSzlzTW5kdUUxOTZvV3YraGZNWUJmdkpMU0p2M0tHam1tbkRrNVpI?=
 =?utf-8?B?MTQwZlRPcjhpVHNhN3g0MDRGUlN0M3h5M1BMVVdaUHh0Y2tLLzFvYWhvLytQ?=
 =?utf-8?B?c3AyWVRNa2FXeXdHbXhYSzhNTjlMS3R0am5jalNCbFBXeGRuaUIrZkJLa0Nn?=
 =?utf-8?B?RUpreUpjVTF6SXE3bkMwMERUZisrQzVCaVVpZFZZdHpGeStCUVdPaVVFRFlz?=
 =?utf-8?B?eEhZTDNFS0JEZVhjbnF2azFNT2c1NEtzbWhvd2xwM29Wdk5wRTlkeFNubXFw?=
 =?utf-8?B?Y3pMVU1GR2QwU2VYUk9vK0FNRW1rN3NvYzJZRG1nRjYyN3R1TTYwekhWeWlP?=
 =?utf-8?B?S09zQm8wSDRyMStqV0RCRHVvZkpVcnFrcTNwNE5SZGNtblArTi9mQWlRek04?=
 =?utf-8?B?ZCtzT3MyZDNkaFJ0RDRBR3d4djREaGk0ZnoyTWlkV0lCN25MVmpoaWtJcDNE?=
 =?utf-8?B?UEltUDFUc25YQzV6eU5CQ3cwSDdQalJ2UkR3VXdnZTdlOS9ib0VCYy9GOGtQ?=
 =?utf-8?B?cFUvWHFpaW5PTUUyODhJcGYrM0g3L21DRVQrTlZGTk5iU0pPVFBQR2V5VzBR?=
 =?utf-8?B?dXdBMlViY0dwVHg5YUl5REc2a3ppaEZkRkhzM1JOU2hDdEhWRjJ4Mmo5azJK?=
 =?utf-8?B?bVQvTUJEeW5kZXZOdjd0MzdmVlZkcXhqb3VRdnlDckNqVGtUei9wWlNYN0pM?=
 =?utf-8?B?UkdiVE1xYmxpS3RxMGFjc3kvbUlhcFNneDBUNExZQ3NqSXVVMVR0SWdwVE5i?=
 =?utf-8?B?eEFIZXFib091Q2xmeVhjL2NKbDA3QnIwblRMYmxYT3pjN0JQQitxN2hNcHA4?=
 =?utf-8?B?elduaDFFWmZOWnZBZnlQZlF0enlWY3U4RzdZS2tUcSt0ZVdZTjhoRTM0UHNQ?=
 =?utf-8?B?aHdpL1kwRnFYWW9FNVpFSkRQUDRib1hkS0JlaTd3ajRtNlBtOENFbFNucENv?=
 =?utf-8?B?VnNmMWdnWlhZMmdkdUpRazBQeUo5T1ExWnI5dEo5Z0VEQ0tqRmlzeW1PUURI?=
 =?utf-8?B?bXo4L3JydmxUMmJwRWUreXo1Ry9LN2UzczhiUVlkcGM0NGFQazZhclMrYkFD?=
 =?utf-8?B?YWo3UGRpNnVnaDlQczliVzA1L0h6a0EvbDkzcHJ3djJvb28xYkZBNWJlb3Z6?=
 =?utf-8?Q?sfaq4e3QjYksroAU+H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f4d65f-21d2-450e-a803-08dea079091d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 14:11:24.0680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rq/IC7LngjBJsZh2Ok4ZzWvMpKlRYxezhNTfVFJiUcbq33LbCHouu9UpEIpuXoEL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6126
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240332-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,163.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,linuxfoundation.org,lists.freedesktop.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.234.253.10:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C8C8C44727C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Those points are certainly valid.

I've also up-streamed a patch which completely rejects userspace submissions who try to use the CE.

The problem is that those BUG_ON() can lead to a deny of service because they crash the whole kernel.

A BUG_ON() is only justified if it prevents even worse things to happen, e.g. data corruption or it would crash later on anyway just not so obvious on what is wrong.

Otherwise we should use WARN_ON().

Regards,
Christian.

On 4/22/26 16:03, Timur Kristóf wrote:
> Hi,
> 
> In my opinion, this BUG_ON should NOT be removed.
> 
> Using the CE was never well-supported by amdgpu and can lead to serious 
> issues, so we are planning to remove it entirely. Userspace isn't using it, so 
> there is no loss of functionality here.
> 
> Mesa (the official userspace drivers) have never used CE and never will.
> 
> Best regards,
> Timur
> 
> On Friday, April 17, 2026 9:40:10 AM Central European Summer Time Robert 
> Garcia wrote:
>> From: Christian König <christian.koenig@amd.com>
>>
>> [ Upstream commit 5d55ed19d4190d2c210ac05ac7a53f800a8c6fe5 ]
>>
>> Those can be triggered trivially by userspace.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>> Acked-by: Timur Kristóf <timur.kristof@gmail.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> [ Modified to gfx_v11_0.c only. ]
>> Signed-off-by: Robert Garcia <rob_garcia@163.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c index 37f793f7d4d2..6e3a32779168
>> 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -5380,8 +5380,6 @@ static void gfx_v11_0_ring_emit_ib_gfx(struct
>> amdgpu_ring *ring, unsigned vmid = AMDGPU_JOB_GET_VMID(job);
>>  	u32 header, control = 0;
>>
>> -	BUG_ON(ib->flags & AMDGPU_IB_FLAG_CE);
>> -
>>  	header = PACKET3(PACKET3_INDIRECT_BUFFER, 2);
>>
>>  	control |= ib->length_dw | (vmid << 24);
> 
> 
> 
> 


