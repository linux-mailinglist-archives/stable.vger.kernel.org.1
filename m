Return-Path: <stable+bounces-189024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE5CBFD939
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 19:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 21D4A345F50
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 17:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855D629C33F;
	Wed, 22 Oct 2025 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RmJTsfXP"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013025.outbound.protection.outlook.com [40.93.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771332989BF
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154102; cv=fail; b=A8b0CKxMnotMJBJ+wRfrPYxGba1ycpbnOSMLZdE3QwrniJjlUQOqJo41qthA6E2GQ3GcPnkU9N1KfL/+d0Wvlu598oh8FFP43YMNyGcYAET8nTWp67AfPg5HWXZ7rwcHo8y1GFSeQk5ny1N8wT4La4l1RKzG0a1lWEKrpmfLi54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154102; c=relaxed/simple;
	bh=Q3meSI/Q2o0Fv7iQZLO4Rhn+kcZ+b7DbMsnLIWzftMA=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rFwFDoc948KoYxzPYDY9ocfOBamkwaS7bRY6wBk8V9xoKi/DkuvLIC50HDtU7m2R1CQAWOI8Jpmrx/biwderJkGm3JCRI0XGRvHrHbpqSR3U80XJTZMOByqGPhTM6jtxfuCdr6fSOYX8Iv7otpuDxRq/R2uBpf8UydKmfz9LI8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RmJTsfXP; arc=fail smtp.client-ip=40.93.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rmeh/u4zcxGRLu5si4EGpJouaOplkNmPBdCERTEXppXqTMpoVEIV4G037Xpwbbi8rnSGenlynEtKwfgqqtAyLV0+k7SujHTISkR9QvAeF8rwhz7WM6FkBntPuKc/paB3GaJo3UJe5vAWfqnNvKKMkdTniHVbU/8CmajXnItPOWakTX0zocg04g+rAWhVutVyZn1HtDP8ZyWlh5zaa3eVHsZly4yVMnLYOyNqv4lw6MFNZzsIqIYsz0Gurk0MCnImOb8KOj39NMwciHspvLMk4HHOH4Fp4z4E6jS2xSpFIttheXjWhDXwB4pQb/nIjBG2YVkeODIK64QZ/AgWt7lnVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75vCdIqHAJnf7YKGyNiraltOX2ywgQLAuupNDzXGlHA=;
 b=EFKiqe1kds3zkTkjohAK+IOGdPhjiuyE4yAJy1fRxPLTMUZTRQQqXY4nREUuB7E6dr4PchNRQAlzu3Fw2wPi86+CKahCkXEfzrMrZn0r3M224nPYvNz+K/jq9d1X7OBOcQO6lIkFjxQ1dObEsgvy7b8WQvaGqWO4HVmFPS5QO1FNY4JNFCcCHxALzumO18uCZ4FSdKA3LyfFJgZj73rxKMA0C2HpZGiKV1CpwizBi7QYHP8VjdSIpUgoU4EKuyAd+2P1UT8Ldn1JNFdfvzoKjNOZ0lmvw0ZLv4u6qLpVIxQ5RIsdHQgYS1vHKkkSrIjhH4ImIRH3r7OxJELYkn4XDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75vCdIqHAJnf7YKGyNiraltOX2ywgQLAuupNDzXGlHA=;
 b=RmJTsfXPuXaWApvgj7+vatIG8CJhcPmV0Uw0PGRQbyzUftsGceKM40dKzEB07ya4GH0+xd8AJyR1Ee4bJjHGuTe+eSGA6eXp+KLNV2I7Zw9H84rJuADjpD7ew+wwXoJhmNj5jdthcjXE4RB1gPNP/5bfzGOYhtv8rQnAm1D6QKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by DS0PR12MB6630.namprd12.prod.outlook.com
 (2603:10b6:8:d2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Wed, 22 Oct
 2025 17:28:09 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb%8]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 17:28:08 +0000
Message-ID: <955c4924-2df3-421c-91d0-f43f919590e3@amd.com>
Date: Wed, 22 Oct 2025 12:28:06 -0500
User-Agent: Mozilla Thunderbird
From: Babu Moger <bmoger@amd.com>
Subject: Re: FAILED: patch "[PATCH] x86/resctrl: Fix miscount of bandwidth
 event when" failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org, babu.moger@amd.com, bp@alien8.de,
 reinette.chatre@intel.com
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
References: <2025102051-foe-trunks-268f@gregkh>
Content-Language: en-US
In-Reply-To: <2025102051-foe-trunks-268f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:805:de::31) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|DS0PR12MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: 64382629-9621-4e4a-78db-08de11905e23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0tHKzhpSTdNVlRhaHJ4cHV6czFyOXYwaWsrelFqbUZPRXRMeFhKaWNsdU1k?=
 =?utf-8?B?emRCSTNuZnh5R2xvV2dQL2gwQkdYOVRscDd5OUYyVkRsZ1NPVTR6Q3p4bmZy?=
 =?utf-8?B?c3djcCtzT2hVMlRFMTM4b2FrdkMvbkVOS3pDZWhucmdDWWpKdWlUay9TNDlo?=
 =?utf-8?B?UmZ1bXgyRElQRnY3Qm1makNWRDRxZENkckNOaHNOR3k4MitTTXZDeERtUHNy?=
 =?utf-8?B?SW42V1dvSTlDRWVORTVJUEVwNUNTRE9acngzWEFjTVI1U0tScjN0YjA1K29m?=
 =?utf-8?B?RXVGTXU3MzRMQzRnTm1GNVl4Z1NaTG1FNTgyNk9oUlNhSFJ4ZVlOVkN0VXM5?=
 =?utf-8?B?d3BSUHpMcW0xeFIxSnFHTUx6YUZ2YmdrRHJtOWFuSlRoY2lQeHlmUmdvaGpT?=
 =?utf-8?B?VjVuSWVTUmQzVHRxN0p1azgxZXpSRytJY2t1MFRmWTh0SUUwKzN1a3BXbFlV?=
 =?utf-8?B?NEU5L0w4VGhLNHlWdERtOUx5b2hQRTdGTCtLWk1Xd1JxYjV1RTdnZVEyYnJH?=
 =?utf-8?B?WWZnUDk2eE9IdWFiMHozUXR2Yld3U25IKzNYdmlRcWd0VHhuMFNTbS80NEV3?=
 =?utf-8?B?QWpwZ3BjQlltZXhJUEhsMlBFKzRacnJHVmdQejM1bnl3ZkFmdkQ3ZnVKL3JI?=
 =?utf-8?B?UkZ5YWJhdzBTRnJUcmZRbDBQUHhTN3Jhb3RKbGxod2ZBRXdxVWtVekowRW5P?=
 =?utf-8?B?QmZRb0IyY05JV3JnZkx6aXBnWkczMHhlNGtWRWZRZUR2MU43OEE1UTdQQTlY?=
 =?utf-8?B?c2lheFc0SVE0aHRWS1BKVU43WUlTZHBUOUtXSTR5ZGdGMUtNc1VxaUNZdm5E?=
 =?utf-8?B?d3AxeHJJQ3M1QVloSU52YVFrTzVLaWcydVcvdFU1MU95bGdGVU5kV1N5c0pD?=
 =?utf-8?B?SVZob2k5T2dsTWxTR0xHd2ViRDUyK0V6QmF3UXFRV3pYVjdORWJEK25jMElw?=
 =?utf-8?B?c0Jyc3VyS3QzellhbDZsbHplQXpDYVFJb1Ivd2VZYVZ1NVlLMlJLcDZaK0pW?=
 =?utf-8?B?bm9VdmVZWDRTdnluY0NxQ2NpdWIxQ3hlZjBPajRqTHovdmZRcjJUVFBsUks1?=
 =?utf-8?B?TFlaNHZNZFZ2TWxKbVhpVzJjU0tqUi94TkpPSTRTYUE0cnVDaklDdU9ubFla?=
 =?utf-8?B?bVlDM25jMmRlSm43Q2YwNEx5TUJmV2V1NzhhTXN6YXBUci94THNEWVB3S200?=
 =?utf-8?B?clFYNGxBNDRkL0JWeW1iNjAwUHp0MjM1SERjd29QNzg1Y090aEtvYUlvdGNs?=
 =?utf-8?B?N1Z2TVVZZTlWbVZYNmxuYzhHbHZaYzJXQzBDSG9tUUpaUWV3eWVibXYvYVFh?=
 =?utf-8?B?Y3NvbGFKMjFVRUdZTDNQSjY0NmhWWE1JQlNRUnlCL1ZGUVdMY0cvdll6YWpo?=
 =?utf-8?B?c05jZDZMWnFhQURHRW9oZWMwNXZYR1QxdTBBOHJvWVhrTjBJS0hwZC9NNENX?=
 =?utf-8?B?cElvd3FkRFlyUlZaNmpscE82NmEwZ2k1QkNycjIzY0gyeWIxR1RFS1JVLzJk?=
 =?utf-8?B?OEIybzZ4VFNjSDA5WVE0ZmZyWUxEVmtOQWpMeWpzNi8xNXFKUkNVV3RySnlm?=
 =?utf-8?B?VUVHMER5cGpBVWJSYjdLdDJ0Z0RVVkVnWU9ST2dJcU1vVG9BNVI2R3cySUtD?=
 =?utf-8?B?Yk1VMkd0b0U0aTVLWnVCdkp1bExKYUlaQ2NLa0JQbnJMdzd2YkgwNVlQNUlm?=
 =?utf-8?B?Y0dmNTZqWEpnZlg4dmlVaHpzSWF5UTQwblk0b0RhcmpwN25CK3cvYVVnRG8v?=
 =?utf-8?B?RlNSSXdRdzQ3SXpJZm9xUGk5MFZGaDZzTjV4RGZkYXhJVWkyRFJmUzlWMkw4?=
 =?utf-8?B?UWZrdm5WajR6eVZYWEppcitlK2RiV0Q4ZnBjS3hwWUlwZk1MQXF2UjJsQ1Na?=
 =?utf-8?B?cTFqRDYwVVRmeU9jSnpqcW94ejROMG4rV29YOEZpK0sxL1h0eTFEVFpUZTRD?=
 =?utf-8?B?SC9rRHhiS2U4Z0x2N0FrbzdnQ3J1cTROUDZxa1NZTndLYURiVE0rNTZrb2dm?=
 =?utf-8?B?Ukt4K2xJR2xBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UisxelhGb1BocnNqSVA0UzNWUkFCZ0E2NTlLanlEMmxaTUZEYXFyRk95OGFR?=
 =?utf-8?B?Y3lSZDNvdUpFckxIeWZQUk9ieVBjTTAwRVh0YkM3QTA5L3BKTS8xMWtqNitS?=
 =?utf-8?B?SEZUTUJPK3A5NzIzam95dFYwWkwxb2hDR3M3UVhFdHZGVTQ0YTJlaVN1K1VO?=
 =?utf-8?B?eVI2a3E0VFlrRjFDR080ZkpkY0VqNUFYV0NvcDJLRG41UUI3bTRSUFZsZU5Z?=
 =?utf-8?B?QWRkUzFmdWdkMGJIZHRHbVUzS21RN3ZEb3Y0QU8vTFFUd0hsVXptM2hmeVpQ?=
 =?utf-8?B?VFlvSzVjb0dBNFhjVG5zbVk5THVoV3dtQ3d1OWMwVkQvUVh1M2dBaDJSSDY2?=
 =?utf-8?B?YzhQcmdVTnpTQUxXdE9yMm9ULzlRRDRBOTQ0OVZNL2hRTE00cGVWTHI0ella?=
 =?utf-8?B?bDNMbHo0aVA2MzRERWhkSU4vRC93a3NsNUxKeWY5TXY0c2NqWElqMjV6MGJ1?=
 =?utf-8?B?a1hHOVFaZk1wTUdRVzhXUFJJMFA4MXBIK0NTQktPaDdlVWdsY2kxUEhxY1d5?=
 =?utf-8?B?R3VDUWNNZGowNnppUVJzWmcvZXp2TEY1bUtlVnA2Mno0RUNOdlVERGVPM0x3?=
 =?utf-8?B?d2YrU1dWSFA2U096QjVvSXdnWXN5YkVOV1ZWbldPcEUvSmg2bVdQNGwvUnY1?=
 =?utf-8?B?bWRJVE95ZXpyN0loZTh5MEFpQXVHZEhMMEU4cVJqS1hoNjFZS0VwRHNjdytW?=
 =?utf-8?B?c2xxVklWVzBtYWJ5L3N0K0E5WXVBdkdpeVNMVWFkeUZOZlNnbk5SeU5iWndM?=
 =?utf-8?B?M0JoSVc2eU81RnMxZGNJZXl2OUI0RVhVTE1uSkFkNmlNVlNJVmxDazREZEFX?=
 =?utf-8?B?cTY2K0hydy8wekYrdlNyV0phWkZyN0Uza3N1VjV3ZGlteklXY1pUcTBMNi9E?=
 =?utf-8?B?anVCbmpVK2NKeDYza0RzNEF2enBWQzhpdEFjamRFaWlXMW9MU0pkVXNWVklx?=
 =?utf-8?B?Tnc3dnp3SXlqWjU3OUZHelBML0FPaG45L3VPVDZ5ekVRaEZOZzgxNzFmb1Ro?=
 =?utf-8?B?bDU4alRmNTVSUUFPWWJWc1pjWjNmMC9qZmxqdVlHbjFIellwRGJUQUVaV0Zt?=
 =?utf-8?B?R09ndDRMQ2pncDNVKzVNVHJMV2hrZDR0TjRJeFUzRittekpUV2JQUThMMEdJ?=
 =?utf-8?B?a2R4Tng3aEVzYloyMkxkSVlHa2RxQW5MZ0x2TDB1Uzdhd2NlU0pJOXAvdzZ4?=
 =?utf-8?B?NHBzNXR5VXVHODB4THZqK3k3MTgyb3dmUjZBeUF3L3ZUQWlhSU81T0ppd216?=
 =?utf-8?B?cVZPWnp4ckp6blFCcUFiR2NMbEJtTUp0OFU0RzJ0SHFNeExVT0g4T2hzbHVM?=
 =?utf-8?B?dXkySmpoeVdFeFVnOGtQL2xsWjc0RzRlSUUyRE8reFllVEVGeklTMEZzeVBS?=
 =?utf-8?B?VzR6a3A1bzBuTHUyT3M3Y0JSSkl1L2VDb1lROFV0Vkl3L2ZwQk41ZllaWnp2?=
 =?utf-8?B?aTdHTWpWNVRSZi9JTmpob0JqM2JMSzdKWGJYZEU0NlloRDBLcjZLWEIzb0cw?=
 =?utf-8?B?TVpBaFpnTWU1bUpVeWF5WWpwZzFyVWdsQjdvVGVsbGJsaDJCcnkvbTdyeFo3?=
 =?utf-8?B?aXZpbkZnZTRsZFdBck8wekJKTTdCbVk5dW1VSVp6ZXJyeWZ4eS9Pb0VOTW9O?=
 =?utf-8?B?QUFuT1U3bmVRWUlvRjZsNVJYakMzbHoyMHU2eGE3Uy9KWFlnbmRvUXI2R2ty?=
 =?utf-8?B?LzIzM1lxQk0wbXhEVHRXbXVMR0ZvK0Q2OExCT1lNY242VlJhNis4MDFYekVK?=
 =?utf-8?B?dCtYZEFnZjNrbDVYeXh3Z1N5QUNQZzArVXNsdEFWUU5pRWI2bnlMRmd2YVpp?=
 =?utf-8?B?d290WFNsZVI2TWw0bXdkdmdFZ3hOZXBRTWdDNFNsNjhUa0ZEcjZHM0FaUEdO?=
 =?utf-8?B?Wm9jRTQzZTRJZ0ZtUlBZcW5nRUo4V2xDT3FJV2FRRkxYRWk3dnFBY3N5amht?=
 =?utf-8?B?MmdLRGNqME4vT1pCbFVoTkFXRDNPMmQxaDBIeWdsZEtjMjEzT2sydHFZeXY1?=
 =?utf-8?B?T3F3cDFFa00vRnVQMDllV1RPenBYNk1aRi9UekdNemIwM1FoSlh0dEpUYnov?=
 =?utf-8?B?ZjNaK2wrZGx6cXBKSk9XZFBkb0Y2WkdnZFdxQVdCbURCN01qR2lPcDY0WXFO?=
 =?utf-8?Q?Hm2E=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64382629-9621-4e4a-78db-08de11905e23
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 17:28:08.8066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0BQIRQ9gi15lgga4ZdZ5O4uI8ylOGis7fkxR95bwaP8z4NiAFknChMwgTzWbXnM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630

Hi,

On 10/20/25 02:59, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to<stable@vger.kernel.org>.

I’m planning to port this patch to the 6.6-stable tree. Please let me 
know if it’s already being handled by someone else.


> To reproduce the conflict and resubmit, you may use the following commands:
>
> git fetchhttps://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x 15292f1b4c55a3a7c940dbcb6cb8793871ed3d92
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102051-foe-trunks-268f@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
>
> Possible dependencies:
>
>
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
>  From 15292f1b4c55a3a7c940dbcb6cb8793871ed3d92 Mon Sep 17 00:00:00 2001
> From: Babu Moger<babu.moger@amd.com>
> Date: Fri, 10 Oct 2025 12:08:35 -0500
> Subject: [PATCH] x86/resctrl: Fix miscount of bandwidth event when
>   reactivating previously unavailable RMID
>
> Users can create as many monitoring groups as the number of RMIDs supported
> by the hardware. However, on AMD systems, only a limited number of RMIDs
> are guaranteed to be actively tracked by the hardware. RMIDs that exceed
> this limit are placed in an "Unavailable" state.
>
> When a bandwidth counter is read for such an RMID, the hardware sets
> MSR_IA32_QM_CTR.Unavailable (bit 62). When such an RMID starts being tracked
> again the hardware counter is reset to zero. MSR_IA32_QM_CTR.Unavailable
> remains set on first read after tracking re-starts and is clear on all
> subsequent reads as long as the RMID is tracked.
>
> resctrl miscounts the bandwidth events after an RMID transitions from the
> "Unavailable" state back to being tracked. This happens because when the
> hardware starts counting again after resetting the counter to zero, resctrl
> in turn compares the new count against the counter value stored from the
> previous time the RMID was tracked.
>
> This results in resctrl computing an event value that is either undercounting
> (when new counter is more than stored counter) or a mistaken overflow (when
> new counter is less than stored counter).
>
> Reset the stored value (arch_mbm_state::prev_msr) of MSR_IA32_QM_CTR to
> zero whenever the RMID is in the "Unavailable" state to ensure accurate
> counting after the RMID resets to zero when it starts to be tracked again.
>
> Example scenario that results in mistaken overflow
> ==================================================
> 1. The resctrl filesystem is mounted, and a task is assigned to a
>     monitoring group.
>
>     $mount -t resctrl resctrl /sys/fs/resctrl
>     $mkdir /sys/fs/resctrl/mon_groups/test1/
>     $echo 1234 > /sys/fs/resctrl/mon_groups/test1/tasks
>
>     $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>     21323            <- Total bytes on domain 0
>     "Unavailable"    <- Total bytes on domain 1
>
>     Task is running on domain 0. Counter on domain 1 is "Unavailable".
>
> 2. The task runs on domain 0 for a while and then moves to domain 1. The
>     counter starts incrementing on domain 1.
>
>     $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>     7345357          <- Total bytes on domain 0
>     4545             <- Total bytes on domain 1
>
> 3. At some point, the RMID in domain 0 transitions to the "Unavailable"
>     state because the task is no longer executing in that domain.
>
>     $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>     "Unavailable"    <- Total bytes on domain 0
>     434341           <- Total bytes on domain 1
>
> 4.  Since the task continues to migrate between domains, it may eventually
>      return to domain 0.
>
>      $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>      17592178699059  <- Overflow on domain 0
>      3232332         <- Total bytes on domain 1
>
> In this case, the RMID on domain 0 transitions from "Unavailable" state to
> active state. The hardware sets MSR_IA32_QM_CTR.Unavailable (bit 62) when
> the counter is read and begins tracking the RMID counting from 0.
>
> Subsequent reads succeed but return a value smaller than the previously
> saved MSR value (7345357). Consequently, the resctrl's overflow logic is
> triggered, it compares the previous value (7345357) with the new, smaller
> value and incorrectly interprets this as a counter overflow, adding a large
> delta.
>
> In reality, this is a false positive: the counter did not overflow but was
> simply reset when the RMID transitioned from "Unavailable" back to active
> state.
>
> Here is the text from APM [1] available from [2].
>
> "In PQOS Version 2.0 or higher, the MBM hardware will set the U bit on the
> first QM_CTR read when it begins tracking an RMID that it was not
> previously tracking. The U bit will be zero for all subsequent reads from
> that RMID while it is still tracked by the hardware. Therefore, a QM_CTR
> read with the U bit set when that RMID is in use by a processor can be
> considered 0 when calculating the difference with a subsequent read."
>
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>      Publication # 24593 Revision 3.41 section 19.3.3 Monitoring L3 Memory
>      Bandwidth (MBM).
>
>    [ bp: Split commit message into smaller paragraph chunks for better
>      consumption. ]
>
> Fixes: 4d05bf71f157d ("x86/resctrl: Introduce AMD QOS feature")
> Signed-off-by: Babu Moger<babu.moger@amd.com>
> Signed-off-by: Borislav Petkov (AMD)<bp@alien8.de>
> Reviewed-by: Reinette Chatre<reinette.chatre@intel.com>
> Tested-by: Reinette Chatre<reinette.chatre@intel.com>
> Cc:stable@vger.kernel.org # needs adjustments for <= v6.17
> Link:https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
>
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index c8945610d455..2cd25a0d4637 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -242,7 +242,9 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
>   			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
>   			   u64 *val, void *ignored)
>   {
> +	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
>   	int cpu = cpumask_any(&d->hdr.cpu_mask);
> +	struct arch_mbm_state *am;
>   	u64 msr_val;
>   	u32 prmid;
>   	int ret;
> @@ -251,12 +253,16 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
>   
>   	prmid = logical_rmid_to_physical_rmid(cpu, rmid);
>   	ret = __rmid_read_phys(prmid, eventid, &msr_val);
> -	if (ret)
> -		return ret;
>   
> -	*val = get_corrected_val(r, d, rmid, eventid, msr_val);
> +	if (!ret) {
> +		*val = get_corrected_val(r, d, rmid, eventid, msr_val);
> +	} else if (ret == -EINVAL) {
> +		am = get_arch_mbm_state(hw_dom, rmid, eventid);
> +		if (am)
> +			am->prev_msr = 0;
> +	}
>   
> -	return 0;
> +	return ret;
>   }
>   
>   static int __cntr_id_read(u32 cntr_id, u64 *val)
>

