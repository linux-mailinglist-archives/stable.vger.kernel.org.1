Return-Path: <stable+bounces-188146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF4DBF22A6
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 69504342E10
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF99230BCC;
	Mon, 20 Oct 2025 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SVfTmjhv"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F53B26CE06
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 15:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974983; cv=fail; b=PWt8RZXx/z3zOh1BWgK+pofazdcIXSGACYuQUKwdWBqUQdwE0iKhPAm0LC1xUFR3Rh/yQqts4pQgtIHlWY1Pqtq7wKqSNkBRni5LZsRldoIfBr2G0wrjle0p7zpqHrE87G9vzlL2kYX81I5CkmWz0vzPaclySXRIgIrE/tK3Nfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974983; c=relaxed/simple;
	bh=3XuRdnv9aEvtiZQcpHaoy8HrY48jbANHzjhv3Nlz9LE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rxbdl8iP4Qyh8uiXPjchWE185q6kKy8rcA3lBLylFvvT7kiDKf5H3j07uczHOaVRlRCCcPEOQuIA1fnmQ1cmAdza3PV305wHC3EV7AZpa7Y/hi08VUY2Z5FKjCubcFWVZPq7RXyWUvxkT5dV88n76jI/swpEK/+JfhhO+r+9S4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SVfTmjhv; arc=fail smtp.client-ip=52.101.62.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFjFTUPU/Hyu+5Bxg0QcSS3vgqP5vhbCV5CeIM4MN5dbxFsYm4W1pRDqZxx+Js8y3kgDnK9nGdIg53dmm5oGSz1+izOPjAgO2lC/uThuAiBDx+PDhLkXOUQZpVz1bloU6WiEUaQic6k6OHHh7BgeoYyNz3ghTc5fjYbVxQZoooBa0aa9S7b6YDJt8nb7+t6Q3dwuYlGrVN5UpC3WZ+rPy0J2mF6iu9Ll1mEGKtU6R3Ipt6DQjJcW/N95On1xW04LwatFMMGY02YPadzB9QJSedurYEFn8W1m5u1Ps2Y2Q97mjK6tCYe60S8/fUx8J0xsSDvPOqAhmvD9m0hvqDeeZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uj9EdFA0J+VYIZ/RZE0kSD62YVMZjpdw7KZ/MZc7ME=;
 b=S4HpMaEXIOgtO58B2LmzE0nJICWz7qkmxURXUhcxBpLgM4ht3Ro1oezXtyextCSQAYQSyhhAKZyPAkNO/7kD5RJ6sCFk7UfgdNyYb2Hg/NFQbkZ0illaRNOPwPPyojAKTCUzaZyAqZ+XuyE7DQzSZftjhz8DCd0Qr1lrpOP4LuUa1m9QZ73+Q8G0izV8BytsprB6gB4U3haNoFqVcgKzHSjHUTrtCJ0U/NKrEkVuiRfbj2PyxynrH5gQ10atD3PCysbY9ltB8ngkVOQx4HA/nacETpNykRB9pX/BtxThvEOxcDrZYA87fTmQZiAF4H7ST7OfGK/XNtPpX9TC4k8Y8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uj9EdFA0J+VYIZ/RZE0kSD62YVMZjpdw7KZ/MZc7ME=;
 b=SVfTmjhvNSWW1mD0aF8f9UcfmzdMLE1IZm9DeVc75EFmigA6XjfZtEOrF/s3bvn+uTbAYcfjiM+JOtBuAU/1kpkPfc2a2H/gqlH5UDg5FGYiuwIKf6rafND7ublHIizrnLSK3dMECTtwZTJrphz9ugewxSH7ubdEuxrs72p//MU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by BY5PR12MB4193.namprd12.prod.outlook.com
 (2603:10b6:a03:20c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 15:42:58 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb%8]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 15:42:58 +0000
Message-ID: <563a969c-6aa9-43b6-a2ab-543ef0f64b42@amd.com>
Date: Mon, 20 Oct 2025 10:42:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17.y] x86/resctrl: Fix miscount of bandwidth event when
 reactivating previously unavailable RMID
To: Greg KH <gregkh@linuxfoundation.org>, Babu Moger <babu.moger@amd.com>
Cc: stable@vger.kernel.org
References: <2025102047-tissue-surplus-ff35@gregkh>
 <20251020150405.24259-1-babu.moger@amd.com>
 <2025102051-flying-despise-6a9b@gregkh>
Content-Language: en-US
From: Babu Moger <bmoger@amd.com>
In-Reply-To: <2025102051-flying-despise-6a9b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0043.namprd12.prod.outlook.com
 (2603:10b6:802:20::14) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: a9251a83-18e3-4e30-7c51-08de0fef57d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVl4V09jL0VweWJlWDFEY3dBQWJGb0dkUEN2MkRuT3JOY3l6UWRPZFl6NUkr?=
 =?utf-8?B?WVk4aEp6ZVdwa3FCSjVrVm1YZE5QZ3NrWGtsTnk5SUo4SkVOZlZOMHFkVXBr?=
 =?utf-8?B?MUkyMmcvZjR3Z0FIYXpva04zamlEWU1BNXZ0bW9vZUhxT0RBU21oQVNLTUJr?=
 =?utf-8?B?bW56dU5XSENOaFhaVGUycWFaNWhOd0ZVWjgxbWZocjVRUTBFUERoT1B5NkNV?=
 =?utf-8?B?S0IvYkQvK3BJeVlNbkxNdVFVdTNWaG9UL1ZYVVFHMXFBRlRxTk1hUXVnU1J6?=
 =?utf-8?B?bDVnck83V3YwZ08vVm9vUmloRHJFVERYRHlnblNmRnZqNVVra0dEYnR6MDdP?=
 =?utf-8?B?OTA0VGE4OVZRNHQrYUJEM3ZZSkh2OUdOd2FLQ2EwZ0NyTHVFU1pNQ0Eva1F0?=
 =?utf-8?B?MWUzZzFBZUVONWZ4UHVwWkJyck5LeGF1SXVWZnV1bVBMOVBlWDhUMnprTExa?=
 =?utf-8?B?bi9hdTRhdTZ2elRXbkRnYXZ0L0NYZ2ZaSWoxMEZvRmFmZERIRnBzaXZFNm5V?=
 =?utf-8?B?NlU5S3dwYTVrdFI3QkI5VkVKNUpYbGRNMDh2R2pUODB1NlRNczh0c1FEaVVy?=
 =?utf-8?B?bzd6bmh5R0Z2NG1RZWxVN3NCc3BHSjBhL29pdXo3cTF6bnFzdnhzRlNBK1Bm?=
 =?utf-8?B?aFEzWVVzeFNGVkFmeVczekxqRjEzR1VCWnF6aHdGbXA4bGVGckdRR0xZVXQ4?=
 =?utf-8?B?TGlHbFhKVHZaRklVNW43SUxJNmhieGVzd0x4UHdZRWhGdnZ1UW1rNXk1Kzd6?=
 =?utf-8?B?SDdlbk5PVHd4bUVCOFlnU01xbDJSSHRvR1JTa1JHenJCOHFXM094L2ZaQnY2?=
 =?utf-8?B?dy9TSjI2S3p1SlhIT0RKL0R6SW14b2p2RkhHUnpkZmJncEZHOXVkNERBYTVu?=
 =?utf-8?B?R2ozQnloNzlUYU1PMGhpekVWcGhBV29nZHVXU1Z1dnd0aERkZGd4Qis4eTlp?=
 =?utf-8?B?b1pJSDdxbUZuQWpSc2ExNFF0Mnl2VTliL2F5RWJBUGU2NFBBT3VWRVNVTFFU?=
 =?utf-8?B?NUpJTk9EK0diWnFZeURvTjJVOVZ2a1JHdkMvKzNHZkpiWFVpTE1yRGxxVEx0?=
 =?utf-8?B?QlRnTkdHR3dkSmpFanlsOHcrS0h0NTZGK3NvVnA0ZEZKdEUwKzM3V3ZvbjQ2?=
 =?utf-8?B?YmVVT0JwVUtvM1JkQmErNEtjVUU1ZEs0aDhoNlNhdUwrbHFuaGNxQnJlOVl5?=
 =?utf-8?B?bW94aHNDQmhwUzlVY3FBVTNaYWFFM2xnRURVaFdiYmZ2MTkxNkVHNGNMNlZ5?=
 =?utf-8?B?aFYzVTV5cFVkNG1TZDNFTHBla0I3S2djTzFqVXEyMnVyTGlSM3dROWo5bElP?=
 =?utf-8?B?NXUvUHYyS2J1STk5NXBKSEtCSmpxZUV1RGFrT1ZQWnpFMWV2dWE3YjhwRW9Y?=
 =?utf-8?B?N0pHaWIyVFpjdnpmM0xRZ2dEMXJPUndrTHVwa2xyTFZydTZTNnNWM2hCZUlq?=
 =?utf-8?B?Z2dwZjQxdnJUbGFvV2RheFVoVUkveml6UXVyK2JoWUJXMHpCdmxEYTFlZkpx?=
 =?utf-8?B?R2tKV1B1NFI3T0dGcEJINWlqZGxIdDcrUkthVEdHK1dQRjI0QjJWa2s3K0FN?=
 =?utf-8?B?Y3FLcjVWNzR2aWJzSmdqUmJXbDNuYWJjWWpMaVlQL2xkdHRIQytEaEpxU0Vu?=
 =?utf-8?B?YmEzUS8yT0t2Z0RBSVJMR0lmNjloTGlnTXlkRDR4bTFScWVLM3ZmVGQ5SzdG?=
 =?utf-8?B?YjB5Z2pzWHJPWTJWbUk3OVlYZGFxUEVockNldEpBZk0yMUdoRkFJbndObk1C?=
 =?utf-8?B?cEFGMUFpSDhHNVNhTm4xTkFxQW5QNGIvUHN1U3J4cTZ3UWYzRFlKbXJWTnpZ?=
 =?utf-8?B?Vm1Kb3Zma29TNG4zUVRpZ0R4MXN1K2pMeWx0NzE4dEJHeWUzYlpubFEyZkJs?=
 =?utf-8?B?K2FWQ1hndnkrS05JcmQ4dTZLNmJlajl4Z3VGVFVMZXl2eUhFWVAxeU1xZjNS?=
 =?utf-8?B?aFVGbnB5T1hoeTFtMjlISUlyZjljVTl1V0kvd2g1eHZQWXlkK3ZNeUJhb2Fp?=
 =?utf-8?B?ckNiWlEwbERRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmlIeGRpSmk1TVNDL1J0blNOc3QyZUVaK3hRbXlMSEdqQWRmWVFWVWNTQVd2?=
 =?utf-8?B?d0V4dlczOHR1UjllbTVtUk1iVkdtWERHUFdDZHFXUndUQWlqMkIwUGZEQ0xN?=
 =?utf-8?B?QUJMRHpyV1NYQ2JrSUhLdnIrdnNwbVBCb0JGS2ZwRFpFK2ZaT1VwczZTOXhD?=
 =?utf-8?B?aDROTHFIZm1KYWljS0lFRWppSUFMMjc5cjh5YWJ6Sy9OWEs2WVFkRUpjZEFB?=
 =?utf-8?B?YTJTWHAzMTJxMUMzWTkrTUxVL2E1b3JmME50MjNaUTZhdG91bnhBVWJoV3o0?=
 =?utf-8?B?VFlsakhlbVEwNjdIUHppVkprczZIWlM2WEN2SHVlZFkyQ25kMExERytQdWE4?=
 =?utf-8?B?Rk96ZlBYWDRjZncrbDM5dzV1QmZ0djZMVTlFZXJIUXBJSmQyREFZYlQ0UzA0?=
 =?utf-8?B?MGNwdGV6UDh3QmZaWm9pSmJaMm1rTEtjQzZwMVRvUFNCdkh6V1VuWURUck1n?=
 =?utf-8?B?aFZxZ216dk1XR05iZzVIcEdYeWZZN3g4dE9tYVBlN2lIMWYvRTlRb0I4L2Yw?=
 =?utf-8?B?enY0cmNJV3RoKzc2R0FOYWxOOXdOT0lZcU53Z2VQcEhYbVpnOE9kUHQ0eTdY?=
 =?utf-8?B?RFBYY0FhcjRvQ1IyMWtvaFpxMFR4OGIrMnVsMzRVZHJSOUYrekVhdW5pUHVs?=
 =?utf-8?B?cmpXeXN2UStEYkdRaWc5ZFZFSnEzVWxzVjluK0dMU1dsYXgwVCtNS0FzZ0Mv?=
 =?utf-8?B?aHc0WG5UMTNFU2RwRVVkMHUvcWY2MVdIZnJmV1dyWkw2NlpBSUJ5UXlnZzl2?=
 =?utf-8?B?cTJxTElKSmRjdGRGWmlJdlV2WnpRa2hjSkpHOW1majlEYnJtK00zbGw1U2dQ?=
 =?utf-8?B?bmxyaGFNdXY3NVoxUm9UNWdkVFYrVTVmYnpDc1NoZVNUbU1IQlUvc1lLcmFM?=
 =?utf-8?B?VllWWTZ5Y3RKUXoxMVpiVnZVVVFtdVRvZzJoM2owTEdmKzJwZllPbG9rclZX?=
 =?utf-8?B?Q0hIQjliZWxKOVdTd0pVUi9KTGlpMXkzNXdGNkZyYTl6ZTZMeERSWWV2Q3pG?=
 =?utf-8?B?bThxZjFTczYxN3Zxd0xtWUY5ZTE2VkkybGRZdVFzelhxV0NJQWsyK3dsMEpj?=
 =?utf-8?B?bU1KUi9hZy9ldzA0M3pLOU80bWQrWjVwVjNYbS83MXFzMGRxa2JHdTVMUkxB?=
 =?utf-8?B?NUtRdXRLVDZ0OW5qVGhLOFd3MUUxcm5MaUVHMDdjNjZlOFpvdmI0bjlQRktR?=
 =?utf-8?B?dmJrb3VxVVdoQWE3V3RiQTY4VmJnMU9RdFlWSHNqcGNYc0t3UWxKN2VFWXpv?=
 =?utf-8?B?R2JVTHl4OEpyUEorQ1V3ZWU1QzR3WnVLS0FIak9UekFGakVIUVFPZTVvNEp3?=
 =?utf-8?B?WURaZFcrdm5NS3FVaWNkU0tQVWYzQVI1Z3M1QWhKYmVaMnc5MWQrem9ZL2M1?=
 =?utf-8?B?a2RXaE9td0hIcWFCMzlXYnZ3YVM4SzJZeEEwbHhXQk5aQWo4S3l3QVpNcFlV?=
 =?utf-8?B?N0FlZlVmUjVXb0JvTEV3eExUVmJFNkw3WUh0S3YybHc1c3VXQ2IwS2pmNElZ?=
 =?utf-8?B?VkJNYndza1ZRTm9UczNxNVNWYU5mTDUyQWlRUlY5WndReU1tdDlUYkJCc0NX?=
 =?utf-8?B?WkVidXF5QmpFTjBVdlh5VXBPV0JMdVRqQW9YU1JCck16RmxVOVZ5aVpuTEht?=
 =?utf-8?B?ZnBhek0zTTFZNXU5dlg5L3RlNTdpYzNpSnE1UWI5Vmo0K0xxekZvSHMyRmc1?=
 =?utf-8?B?K00rMi9Qc21Hb2VOaTUrQzBmRDgyUW5maDZ0aENBQmVpeEo5czlFajJZM3ho?=
 =?utf-8?B?RDh3MzNEY0tEQTRVQlh0cFpuMSs0b1lReG9uaTloeUNNOEUycnJwd1dLeU9J?=
 =?utf-8?B?TG9ESkpXK3RXeGo4RmpzNDFsWmJqNzdMUzM5Q3JvZnNHOHBPTm9lNTlCWmZZ?=
 =?utf-8?B?M0ZBWVpycHZFQTYyaEN2cVNoTDdWQkpPcWZWaHhVbEtjUEZQc0w3VE1iTENJ?=
 =?utf-8?B?M043Q0Jvclo4UUh1WjJtZU1hV3BGbFdlUXJGemxsdURrUjhhdnlqVGdQTm5s?=
 =?utf-8?B?cEVDZVlVOFZXM0Z6VE9VS2VaTmxrTkVKRE91QTVjdVZ0UldZRjk2QURIbEhm?=
 =?utf-8?B?ZEZ0RFpYSHdjSFU4N1RYZEVpZEVLbjZQMDBmcmRmTVBFOWdOSGNSaDlacDlN?=
 =?utf-8?Q?o0Cs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9251a83-18e3-4e30-7c51-08de0fef57d8
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 15:42:58.0419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5ekTm+f9ydRU2DMy2zSmaacPcTs0ssE6BkOUXf3xgZrjeqGZfMC5XvtPfOk5T+0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193

Hi Greg,

First time cherry pick to stable.

On 10/20/25 10:09, Greg KH wrote:
> On Mon, Oct 20, 2025 at 10:04:05AM -0500, Babu Moger wrote:
>> Users can create as many monitoring groups as the number of RMIDs supported
>> by the hardware. However, on AMD systems, only a limited number of RMIDs
>> are guaranteed to be actively tracked by the hardware. RMIDs that exceed
>> this limit are placed in an "Unavailable" state.
>>
>> When a bandwidth counter is read for such an RMID, the hardware sets
>> MSR_IA32_QM_CTR.Unavailable (bit 62). When such an RMID starts being tracked
>> again the hardware counter is reset to zero. MSR_IA32_QM_CTR.Unavailable
>> remains set on first read after tracking re-starts and is clear on all
>> subsequent reads as long as the RMID is tracked.
>>
>> resctrl miscounts the bandwidth events after an RMID transitions from the
>> "Unavailable" state back to being tracked. This happens because when the
>> hardware starts counting again after resetting the counter to zero, resctrl
>> in turn compares the new count against the counter value stored from the
>> previous time the RMID was tracked.
>>
>> This results in resctrl computing an event value that is either undercounting
>> (when new counter is more than stored counter) or a mistaken overflow (when
>> new counter is less than stored counter).
>>
>> Reset the stored value (arch_mbm_state::prev_msr) of MSR_IA32_QM_CTR to
>> zero whenever the RMID is in the "Unavailable" state to ensure accurate
>> counting after the RMID resets to zero when it starts to be tracked again.
>>
>> Example scenario that results in mistaken overflow
>> ==================================================
>> 1. The resctrl filesystem is mounted, and a task is assigned to a
>>     monitoring group.
>>
>>     $mount -t resctrl resctrl /sys/fs/resctrl
>>     $mkdir /sys/fs/resctrl/mon_groups/test1/
>>     $echo 1234 > /sys/fs/resctrl/mon_groups/test1/tasks
>>
>>     $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>>     21323            <- Total bytes on domain 0
>>     "Unavailable"    <- Total bytes on domain 1
>>
>>     Task is running on domain 0. Counter on domain 1 is "Unavailable".
>>
>> 2. The task runs on domain 0 for a while and then moves to domain 1. The
>>     counter starts incrementing on domain 1.
>>
>>     $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>>     7345357          <- Total bytes on domain 0
>>     4545             <- Total bytes on domain 1
>>
>> 3. At some point, the RMID in domain 0 transitions to the "Unavailable"
>>     state because the task is no longer executing in that domain.
>>
>>     $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>>     "Unavailable"    <- Total bytes on domain 0
>>     434341           <- Total bytes on domain 1
>>
>> 4.  Since the task continues to migrate between domains, it may eventually
>>      return to domain 0.
>>
>>      $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>>      17592178699059  <- Overflow on domain 0
>>      3232332         <- Total bytes on domain 1
>>
>> In this case, the RMID on domain 0 transitions from "Unavailable" state to
>> active state. The hardware sets MSR_IA32_QM_CTR.Unavailable (bit 62) when
>> the counter is read and begins tracking the RMID counting from 0.
>>
>> Subsequent reads succeed but return a value smaller than the previously
>> saved MSR value (7345357). Consequently, the resctrl's overflow logic is
>> triggered, it compares the previous value (7345357) with the new, smaller
>> value and incorrectly interprets this as a counter overflow, adding a large
>> delta.
>>
>> In reality, this is a false positive: the counter did not overflow but was
>> simply reset when the RMID transitioned from "Unavailable" back to active
>> state.
>>
>> Here is the text from APM [1] available from [2].
>>
>> "In PQOS Version 2.0 or higher, the MBM hardware will set the U bit on the
>> first QM_CTR read when it begins tracking an RMID that it was not
>> previously tracking. The U bit will be zero for all subsequent reads from
>> that RMID while it is still tracked by the hardware. Therefore, a QM_CTR
>> read with the U bit set when that RMID is in use by a processor can be
>> considered 0 when calculating the difference with a subsequent read."
>>
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>      Publication # 24593 Revision 3.41 section 19.3.3 Monitoring L3 Memory
>>      Bandwidth (MBM).
>>
>>    [ bp: Split commit message into smaller paragraph chunks for better
>>      consumption. ]
>>
>> Fixes: 4d05bf71f157d ("x86/resctrl: Introduce AMD QOS feature")
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>> Tested-by: Reinette Chatre <reinette.chatre@intel.com>
>> Cc: stable@vger.kernel.org # needs adjustments for <= v6.17
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
>> (cherry picked from commit 15292f1b4c55a3a7c940dbcb6cb8793871ed3d92)
Will add

[babu.moger@amd.com: Fix conflict for v6.17 stable]

Thanks

Babu Moger

