Return-Path: <stable+bounces-39224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DDF8A1FCF
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 21:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BBE028B1C0
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 19:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2C0F9DF;
	Thu, 11 Apr 2024 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qo3oPvse"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5FD17C6A
	for <stable@vger.kernel.org>; Thu, 11 Apr 2024 19:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712865480; cv=fail; b=TVImBbxxhm5Rg9VpYH/o8ToCI/ZYrxdtYVjQlYa7lD/uQhLPQi+OL3n5FN78GtvPiek1mwT896Wb2DQm6gTMT4dQy4P4CYGPmgyNYeGr9XEPu+e1Gh2lFqM9hGh8EbyNPFpRnPTvK3ygVAuQI9cU41AoM6Lm7Hw7UCSNzKU4gzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712865480; c=relaxed/simple;
	bh=Ux0d0Z7cGkGnzXhP/4MASThTnC1C2vQaxdlpHZRQXVI=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=UD3zDNujXxPw4OR5wCSXJHKvWHetHYpIuVICc7GWFCx7nWu40nFu0V7MNN8yiwFVYm6ODdkqqvPGCt4KP2jjyS75ossXqafu9emK1ZkYPIvO3WnBL4qgV+tllY3oIccTBxRd8+WrwpnuMPSWkpzcD0a2FfuPi/QcCEW2QfX3q+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qo3oPvse; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPr9YwVvUj6lKC2lcCK6KyE3IW/DJ/1tjrEkRyc12ZKuQ2azif+CPVzg4ZDycfKB5sRjNSDrWhQhx/6XE7u8SUDUF9ZOGqyZzzO7Xj1Mp81AJLk1fq+B7rLH+v77p/rxFp4EvW52CRGMugZPpyVTdNK6wIf4GJI1RUDVDWwHogcunWp87bsfOjxXDMoc02UGQPSavySHz1BG5sOeDt2aUPcoWLeHuVSTZwROUgpzluc3tIE9rF2U86UB5golPR3HOVooDP0EGmf8DNtrWTNUvZkN+nP03VKQPevfBj9YOnImcq6ECw/iiNn3iknJ8zj0gTcPpxEbJhI2z7w1UbwCJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Xl+rrlKHsXX4UGa+PJR7VxNGiP6KSTsUz3EHn/AFhY=;
 b=A4OtDMGFNCiHC6x5pea6wHqVcZq4TXeqLWuUKy9xm0YT4VfFTiRswycQemSC6dXRFtqZNnFNA4iaQbb1NwodINEu76RTLNiUc+SmA+aRqTKlagQXETDPfWBAHLedMqKGpLVfb9KVOAZvW+vH1jp9T3IclEzZ4KhT47t2mr+m7VXVwEPnwCFgKV93pcUqdtagqiQtxYV+AyJTMrEd4w7sZxxQAG1IzmbBU/TxuDIxL2952q1EqRwhc9KCBfmJSXKwN+H4UrsrBnSO4A9IMCxGAM8UcXzJB0NBYHRIsE6FWp5mtZbUYeawfSUyMNzto4WHzEV+5tXLfulIaRYFRblf9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Xl+rrlKHsXX4UGa+PJR7VxNGiP6KSTsUz3EHn/AFhY=;
 b=qo3oPvseEOkXlN7TMFARo/NSR3ptfCidmaJNb4WDwjCJ+0+bbWXwwBgYNHZLCq3dRsrOy1jEDbhkr1CROz1D4exmS4zW+omw3zcsOdF0VMR5Y2OIBu1Iq5Sv9AkCuhm8PwsGbotWbWVULN667VUJIzZGG/r5Ypx57EhdEHhLrGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) by
 IA1PR12MB8520.namprd12.prod.outlook.com (2603:10b6:208:44d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.55; Thu, 11 Apr 2024 19:57:54 +0000
Received: from DM4PR12MB6253.namprd12.prod.outlook.com
 ([fe80::36ae:90ed:1c31:6499]) by DM4PR12MB6253.namprd12.prod.outlook.com
 ([fe80::36ae:90ed:1c31:6499%4]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 19:57:54 +0000
Message-ID: <6be49d46-0448-4fd5-b605-b0274889e1b0@amd.com>
Date: Thu, 11 Apr 2024 14:57:52 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
From: "Gong, Richard" <richard.gong@amd.com>
Subject: Add commit "eed14eb48ee1 drm/amdgpu/vpe: power on vpe when hw_init"
 to kernel 6.8.y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0021.namprd11.prod.outlook.com
 (2603:10b6:806:6e::26) To DM4PR12MB6253.namprd12.prod.outlook.com
 (2603:10b6:8:a6::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6253:EE_|IA1PR12MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d79f3aa-738d-425a-ebc1-08dc5a61ad01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hoICfG6RYlpV18lsB3dwSv9dEoYz+TUJRqxzMAHXpV2g3srMyMTqGA6MyyAMbFGID2nigcW65yvIyHU65qLqrbufFnGAs8szx6cdMh9v/ZmFQ1VidA1YLetmO/Io53oPLExUckaRAfaajTUiXGKafmWkMCIiDaolLZWTAOvx1tfUxM8gYavUmdUhUF5I3obYX1qXUoGPbAt/VXhTFJrRuE1OLugHcU5bdTGSOySM34qnxYRp8WnZuxzwQs5LYaQfSn1uUJb32p0BPxkhI96HXm+QQB8WLhHhuqjEOOeAfWlMkEI/Se6fkG/jeudw5cjforRs2QqiLCsMUDeiW9ZqTmU0k8EVP0bfx/SMtycIO2ZQgD0xcqnD9vjqE4nD7XtS9dbQzRkeWsi/aVbKrtunHKVy8jCd6y8VzpNjE+8eHpcDcSz+VEmvv/+6lapswZtI/oSHiqr+zp88oO9dlTiJEUwaEeOxsKKUEBXd9FePnKP8xbbaduufYk0OqRcmRyvsuINgN+RtVmzhWarcmiPseVOJHmqaPlwvDFZfsOicTWTlC24atNeZpOyhdGJs93C0r3Dm59c0GKSEcuXLtT7F75KuSccfXy6uz3dIAdJC82Afa1ys9JohXfMetIPx4oJa5s5szcwLgFek3x0fx57zXebkUtLzKJtcvdIJqtWND0g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6253.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1UvcGJlU0FQazRMWVpGQ2pjYitxTlVlTG0ydFB3T0hzMlV1Q0t4bkVJa21m?=
 =?utf-8?B?aHFCZmJhQXFOY1V1bnZaTFVqQW5Pckd0Mkt4ajU2eVhSV0RZM2VNN3owY1FW?=
 =?utf-8?B?cmIreGdJaXJnb211VGRjOWoydWxnSGVXRC9BSERyYmh0SHowWGRtUHlYTkVB?=
 =?utf-8?B?eW9DWG90aXQ2OHJkYnF0LzgrbUhoc3hINEdmMWh4dTY1YzlNNTY5YzVDOW00?=
 =?utf-8?B?ZzhXZ1hWRHFpdkdvSTVRNTA3UVF4eGlzRnpUeFAvQ05FemxLOXVpdUt1K2l1?=
 =?utf-8?B?eE9LNzI5Q204ME16NWpYZm4reFRkT2FMY0x3aGRjV0hMa1UzYnhvc3pvbFFq?=
 =?utf-8?B?eWJ1Ui9zT3gxZ3Frc0ozSFo1MFRPU3JYcUZrSnZrNmFGeEZ3ZDlZaGxFenFZ?=
 =?utf-8?B?S2RaUzg0ZjRXNlRkOStrbllvQnRTdVNBT2dzdXZVNlV4eUtBVTRkUTFnd0Yw?=
 =?utf-8?B?cjVYMUo2ZXdkZ0dBV0JGUEoxZXg2Y2wwTVExSVI3Q3VoOFFUSFAwU3ErZmZp?=
 =?utf-8?B?d0JwRDlGUFZlSXBTTmdFeERUS3ZMZnlJeEgzMWJBb0pwV2VkRXcwb2hhT1kx?=
 =?utf-8?B?R3JYVHNZd1ZQTk5xOW44V01zdkVMcGQ2VmtRRzRJTGZqMkpPOGVHQXNQV1Zz?=
 =?utf-8?B?aG1VbFA2dk1HcHpoQm5RNzk5NGxjTDhkeHlUSE5oZGZTYm1uRzB3OGQrU0x5?=
 =?utf-8?B?K3pueFNRZ0dBc1lCKzVvYmdRR3JJUWxXR0grdmZvY1dNelBYekY3N3oyV3Qv?=
 =?utf-8?B?QUFQSTg4SjhCMWE2SVpoN3B3d2JnMmdIMFF6bmd2S1pZdEwycXphVlJoazAw?=
 =?utf-8?B?d082MDVOMTBDSmd5aGpqRXJ3YVYrWWFUcWZ1dklCc3B6S2hoRGc2UkZnN0pS?=
 =?utf-8?B?RzIxejlLbmhKRml3NFpNV25VYzd5NVUxMU9pbHUzQ0VpajhUZGRJdzZaWGZG?=
 =?utf-8?B?bStJVXBjUGxsaWZ1MExwMzVYU1I4Vm9SVW9ZRTYyMU1POGo2SlhLVTlBdXpS?=
 =?utf-8?B?KzhkYnYrdFhTSEgvY1A0ZXUyRmw4MS9BdHIvNmltdUF3em1rRE11ZDd2em9P?=
 =?utf-8?B?OFdCcW5oVm9pUGl0RnVUUEJyNFhsZUk5aFR6MENkeXFPSmNoTnRORkxZTzQy?=
 =?utf-8?B?NlpkOHVMT0F4dXRlRVRSTk1wS2RTczRSSDRwMHNMR0xzNFdiYkJvWDBNUGJh?=
 =?utf-8?B?dzJJc0ZGTGd3MU4xZDBxOGFzSVovaTVLck0xUWhLbDFvSVdMcmJHU0RKNFNz?=
 =?utf-8?B?bVcrRFFBT2hnNWxRSWo4QUJ3djJ3UlZoV3hUdTVXWWVLbEJHQ0lYSytseXd4?=
 =?utf-8?B?Q1BOVi8rQ2pyZUNnMGRMQ3dzcFc5QVpkOGtQYkdDUXJBMVdXNmlzMktlRTJF?=
 =?utf-8?B?MXVjWi8wZmhMejNWbkhEeGFGUkNVR0JLamRTM1VTR25SVzlqN0lCVHVhSnph?=
 =?utf-8?B?cDNhWjRSLy8rMC9Yd1p0clZlZjZ0eldXZGUvZzJOZjNRZmo5ODVLTk1KblhP?=
 =?utf-8?B?ajZzeXZWTmpYUTJsTWh1T2Z6dVZ6NmlSUlVZeU1oSUFpNVUxTlVhREl4N0pI?=
 =?utf-8?B?dTMwSHF5VzVaM3FGekJRbmJIOW0vYjVEcXkyeHE1bGxlOWRhV0hackxkS1N5?=
 =?utf-8?B?Znpxc2ZjVUh1a1NKZitUMFZkTWNxd1VmL2o2TXRIZHFHSk1xdm5NWDFYSXJ0?=
 =?utf-8?B?VFRoelVuc0JKV00rSHExaVRQc2RYaDcrY2JlK0hLeTJvK21jNWZVcm5Td2Mv?=
 =?utf-8?B?WjN1QVVEclNhWFJ2YktTdjFmUHFsOGw0LzFQZk5kaE81OUlZUldCQjY2NTRr?=
 =?utf-8?B?YjFncHFFeXZ6eHIralBqQ1U4Y3YrRE9US3hVamJFRDZtYjRLeDBLWjFzT2d3?=
 =?utf-8?B?TkZPYmFLZUFobWpWRUZrek9jZWxPc0tQTEhYd1BCSUYyNXhjY0daaHhXblUv?=
 =?utf-8?B?UStCZ2Z3RDdKeXgzOFBIYW9XVHNqSWJTaTZpUFZSK2k2OFhudm0vNXFJY2Jh?=
 =?utf-8?B?MklkOVoxNkRUZHZxc1FrYTg3bzE4bks4aGc2eU1ra2JmZFdjMkJEaWMrYXZK?=
 =?utf-8?B?dkJLajBGdGdpdUtuZkpTYm80eFFxQWNvckhmdTBHc3RMdStvcmNYTGtMUlQx?=
 =?utf-8?Q?+mqQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d79f3aa-738d-425a-ebc1-08dc5a61ad01
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6253.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 19:57:54.2393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4pD5esZFxnc6DGebRl7zUS4rUu0cdu/quzMRQ0NEeC1wJQRtnTpKzyo5/BAr6zhLCtCQywEtHL4w10pbJE9vZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8520


Hi,

The commit below resolves s2idle failure on processor for AMD Family 1Ah 
Model 20h,

	eed14eb48ee1 drm/amdgpu/vpe: power on vpe when hw_init

Please add this commit to stable kernel 6.8.y. Thanks!

Regards,
Richard

