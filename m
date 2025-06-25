Return-Path: <stable+bounces-158483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90370AE7638
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 06:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328DD189E2AD
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 04:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CCC1DDC1E;
	Wed, 25 Jun 2025 04:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CthiFN/t"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240E335280;
	Wed, 25 Jun 2025 04:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750827326; cv=fail; b=ZLb6rKNVipPkM54cxmuWQUyQ8MTZEvkpYdB6uiGHFyhKK/PwgLfZQY32RgywqgIoOsJgiJA7p0XhpGHchBgXycFbsaDe5DKtuE9AqB0y+gukxfCMGzmMJw67hUn3cb7dh9Q2l3dAcRio1oCDdSLSWoliFMO6HCrtgwqFv4JBsOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750827326; c=relaxed/simple;
	bh=ZOE2zCOlr0B+bJ7cbXSoFXAJOVDw+J71AAHj5vbcjsU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NY/24NB1u4Tbt5ZVq1VMnhZsSPbQQzYDWcFF4QgQmNIlh516wpQayEZL01zq9q+RozO4j+0iV/gJCbWYUMp4HvRl0/TQnvU5E8XvhcO0zTavsTIP2fjzZSdbAqw5BqK9fR5p+MwfvGWuUi66PTT1NhWXivUIrK+uLrmoXdss/7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CthiFN/t; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aAiBqZaLEJfheYgdbULIDnPPWEmFqjXZ6sV5TqvGVCBHCRWQdE9QT6bTPPxpEP0PN/FbVfVR0fWyWegmJ8bBVKrMe6PcLdt703ivtuW6Ev03cQcl7kNYdch0TWVX6EeylwLsBy9KzHbtOZ1QwxyIcM8OgFKRMLB1WAA6YMY4tNky+CYQEKVzx6QZtmqxzef5yx/RKtsp5cR9S/miMWJnXIEp+MVz+XgZ7+4xsEu+k77I7fci2uHExtcpHLIfI2MyNSlwGQuW93C23mAq/ngBZTS21J3CLn+dUI0nYwrjkaJBaMP2j6IibEmJERKQgCH8ehpEw7oZEZzoywySzFJYSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UT+Pvi73wekEYoY19t8Fr+m9BtCPARMLOXmiUgR7ucU=;
 b=YQCSGO2DiwQbieAyFU+XsVNWZXnMIm1JglttnnELFRCVFr/5DI/C5VO7tUh4WakD6geiezrbJ60yLqTO/8YQCF1+VDOVB7bUA7jQg4S7Dx66gCTMCrf02o153H4AhY9dr29sZmzHDrQ72E6d31hUM1lju13bEkyCOBzaoM5vi0uZuIY3PAB2F2WIgIzj6fI77k9oUjWFf4u6DglSfOJePyKRkh3wUNl7yae4yvsPdTTQ2HFTxe1dkNDWw32AVGea54st6BYBdMstelKEuG8vYGzdxQ62PFEGfujy8mhYJ/olmxwUsiZLwf6PsFsKAKfKTitb71lF4l14vQT0ox7Rkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UT+Pvi73wekEYoY19t8Fr+m9BtCPARMLOXmiUgR7ucU=;
 b=CthiFN/tDsCgThk9/zTNqoJ3ArOHI1fz70ST6gVLs0/uUP+3kD59Z7B5wxoR659G8X8jbNWmE3umVDJFXz3xZuVt3vmKSNbB3kZxDdea8tNYEtLJibVB49yJHMikUmIdAeoHQG4xHx4aocGr6F7V2iYSSHE1s/4VYWE2jeK7kSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6317.namprd12.prod.outlook.com (2603:10b6:208:3c2::12)
 by SN7PR12MB7297.namprd12.prod.outlook.com (2603:10b6:806:2ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 04:55:20 +0000
Received: from MN0PR12MB6317.namprd12.prod.outlook.com
 ([fe80::6946:6aa5:d057:ff4]) by MN0PR12MB6317.namprd12.prod.outlook.com
 ([fe80::6946:6aa5:d057:ff4%6]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 04:55:20 +0000
Message-ID: <8e0807b2-eef5-4172-8c9f-3e374a818344@amd.com>
Date: Wed, 25 Jun 2025 10:25:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/sev: Use TSC_FACTOR for Secure TSC frequency
 calculation
To: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: linux-kernel@vger.kernel.org, bp@alien8.de, x86@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 thomas.lendacky@amd.com, aik@amd.com, stable@vger.kernel.org
References: <20250609080841.1394941-1-nikunj@amd.com> <858qlhhj4c.fsf@amd.com>
 <CAAH4kHZPrDRF3sZ2GxFxMeue3o9PsEL7p-j8bKL2mxgBjR0ATg@mail.gmail.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <CAAH4kHZPrDRF3sZ2GxFxMeue3o9PsEL7p-j8bKL2mxgBjR0ATg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::17) To MN0PR12MB6317.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6317:EE_|SN7PR12MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 942e3544-0c94-4950-ec96-08ddb3a47c59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjRqbSt1TjFINEloY0k3SE1HQ3Bjcm5pNlQ5aE0zL2NLQ1pob242RzFtZXFa?=
 =?utf-8?B?TXp3enVwTGd3UjEvZHFaeElHMEw0ZkpNQVd3dmNHbHdSUjN4Tzd0NFlxYlU2?=
 =?utf-8?B?ZzZ3K0t5anBSamVBTE5tMnJCTFJJT3ZCcE5ORjJsMVhCYVdDQWdTMU9COUNj?=
 =?utf-8?B?VXQ4Z0dIcDB1VS9RcHNkaGRxQjRiWUw0WlRpcTExa2UrTUFheEM1NzBZcWtG?=
 =?utf-8?B?K0c4NStUZkYxOW82SUdNMXA1ZGoyNDdMdVNLc3JBM1VGdkdSZjdMWkUvVTZl?=
 =?utf-8?B?MVRvdHU0YlEwTlhqV1BJMGlvOEVJMFJEdURKNHhtbGd3MG1WRU5Yb1JUNlBB?=
 =?utf-8?B?TW4rUERwZkRvL2lrZEJzNjZzdWRTLy9hb3RtMVAyM0gwcU5OUG8zOCtQUU9U?=
 =?utf-8?B?d3FqZXZrWGxBYmdWaUd5ZWRvclVsK2prcjB5V1FPUmZFVklYSko5NnNHMzVw?=
 =?utf-8?B?bktQSlFEMEpPajI1U1RNcTFham9Qa2ZyTDJBbDlvU2lNa0R1Z1JlbzA2Tk14?=
 =?utf-8?B?bEFvS2ZZV3Vsdkpkb25QZFZDZTY1NVo4eWdNZXZmQ1ZGMDJOTlFCMmt3UHJn?=
 =?utf-8?B?bzc5RmtRUitGVXJQNU5oZDZKOHhyaU4xN0VobmgrWEJDL01DcFZtc0Frd21m?=
 =?utf-8?B?YmFSZFBwVnh2TzJ4aU1uTkNvSlVobFF3U1FZUG1ITllvRE5aMitPbGRSeE9X?=
 =?utf-8?B?UkJBYzZ6dlRpamtpbXF4cGdGVGtaNkJpVjNkUjQwSFdVTHhMN3NJSG5LQ1g0?=
 =?utf-8?B?bkRjNnJ2RHFZcDBVcmlKY1A0Rmd3d3oxUHQ0NFo4RUZyczN2YmZtc3JVaFhi?=
 =?utf-8?B?N2ZaVTBxYXdKYmNIV1MzNzJMMm1RKzQxV3UwWEpzc1FmWnkwcnU3S1Q4amNU?=
 =?utf-8?B?bmVkVDRMZkNEd3JHMmpEeDJTQU8xYjdSNXFVbTdaYzF6elNmZ0h2dUVTcDU1?=
 =?utf-8?B?NW94QjlYYlBQWklaZmRCSkIyYW8vaWx5SlZnVjV0dGJzRWdNY0t5anJrN3lu?=
 =?utf-8?B?WE9mSVFXRWNGRC9RWG5ZMzBHREhLZUY5QUl3NnhpZnZhalVHUEFPeUp6dldz?=
 =?utf-8?B?b00xVlArOXJPZ2cxd3pUeW82aVVycm03LzM5ajkxSGNuY1NyQzNhbnZVdFFh?=
 =?utf-8?B?YXhrMGlzbDhvRWlQeCt2WU5lMEEvNjdYUGR1cXF3Z3NCanc5TzYxa1BiQmp3?=
 =?utf-8?B?bURUNk1UU25UNzBxNnNFYzcxcW5GQ0tkTjFTTkZ0aWl4NmJqUHEzbkVOeEN2?=
 =?utf-8?B?OEZSTHNSZ0hqaVFiVEhSTDRTMFVLdFk4WEJuM1FQaDM3K29nV1lBdEJMUFBq?=
 =?utf-8?B?Y2RpOVhJVEJpMWlmZzJEMU45TkFrUHpVTW5FQW1IcWF2dkxQbWorNzFGNUdQ?=
 =?utf-8?B?a3owMUUyZzFDd0t1K3k1Q1EyejlwajlwZUQ3MFkyb1ZYMU5CMDhhNTJWV3Js?=
 =?utf-8?B?clVMM3lJM0MxT0lkNUlCNGxEUElRYlc5QUN5aDl1VHg4K1B3QWJPc2sxR05I?=
 =?utf-8?B?YWVycWVSLzcyVkVicm9DU2ZJenh6MVgyQTE5Z1dyditEL0psTEVmaG1POFlh?=
 =?utf-8?B?czhpR3BZUndvWmYxQmRFcmx3eDFTNjR1Y25mcGEyVjlUTjFmeFJjRTZYd1pq?=
 =?utf-8?B?UHM5VXhYRWhad1pkaTU5elpZR2wzaTlEQ2t0bUZMa3VrTUNPK2Y0QXVnbmxX?=
 =?utf-8?B?N2ZseVZFcUY4VlBCdDJ4OUNObHF4M0puaVRldUlTMXhyZWNReDBmNzFPSnVN?=
 =?utf-8?B?SnRvSTNzbjA5TEg2Zk9XTGlZRi9yMStSU20rVmNhYm1XQ3RrTm9VRTV3NEl6?=
 =?utf-8?B?MTRSSjlobzZxZFl3eFNYaG1OM3pBb1hVZlI5cGd2UGRuQktTTXV6WDNSakwv?=
 =?utf-8?B?WFJ3UWRWSVllVUZnRDBMQk05RzNoL0cwdGVqSnhVQno2M254ZnVnZCsrQlR0?=
 =?utf-8?Q?S5ZxvFt4hRs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6317.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2ZEZWFWNC9vZExtNUo3SWJTNXFiUHVYVXdZeSs3ZU1NMUhlUGIvSzV3UEpy?=
 =?utf-8?B?eGpuUVVzbDNMSEFvMTlsUmtKUEVZV2R6alAvK281RExTd1ZXYkVuTklVaG52?=
 =?utf-8?B?M0RKazVQQnNXRUh3c2RZbG9YYVdIRkEvUThkcmtGUlQ4b1B2YlJWWnNIZjAy?=
 =?utf-8?B?bEhQMDNoVGVScmYrcEtlZGFUaDhyRm5sZitNNm03ZGU4bXUremdiYjlaMGlC?=
 =?utf-8?B?RndvMWZRMk1XRVhRcUdBeVlHaE9HUy9yOUZXeURsQU9WODNiNlZSQlV1YzFi?=
 =?utf-8?B?Q1hZNGEybXZZUGovdFpSVUNTUkYxT2pBM3VLdnkwOUFJeForWnFBNHRraHJ4?=
 =?utf-8?B?VmozTGRjRWd4Z3dnSmtlb2xXK2NKZ3pYZ3BJMjc3NW5VWmorMWdmdUVGMlpq?=
 =?utf-8?B?THNpSFBHRGdzRVRUYUpLRFkrT3lCWHBKSWJjbSttKzliWjFPM0NCbU5CTmZR?=
 =?utf-8?B?VzliMlh3dmcyVjFTU3RnWE8vOTgvUmlmU056WVpsM1dLYjFucmt4V2ZoZW51?=
 =?utf-8?B?UVZRYk5oWEsvUVQ5SGRtTjJBbGlydmZZejRIZXpsOUljdmg1OGZ4ZWxmRTFX?=
 =?utf-8?B?WVVtaW9FZkZaS1B6WC9nWUZ1anlSbjZXRTJuMHdaYjFVbmdxV0xSS0xsVFFO?=
 =?utf-8?B?bWQ0MVF3dXlJRnNWVkZWclk5TW5NeHZGUlpadXlmckd5U1JrN2QyVnVoUUZW?=
 =?utf-8?B?SlVpRGtNT3A5dnVEU3ByMTFyamtHaU5CUlZzbVkxNVZQYk1SaktlSDZWUlNa?=
 =?utf-8?B?Y1JJbDVER1IyVVowV1ptZmxYZ0J2VUNHSjFydmVwV2pRbFR0c1JIY1M4d28r?=
 =?utf-8?B?eHFSUHhjVnpJZHh4ZHBFUGFpVkQvTFhCeVI3ZjlVUkxWdGdIbXNSQXNTS1Jy?=
 =?utf-8?B?Tm1YOWhuVjZHaG82ZE1OZnhkSHFVOGhNSkp0Q2NNVWdnQUdXa1BpYmNzT3Vh?=
 =?utf-8?B?VngwZ0wvdGx5SlJJc1dkelNjSWxxTVBGWnBoT1B1MjNLZWdWUFZ4L1loV0Jr?=
 =?utf-8?B?R0hJUDFUZ3pwenlHTmpRT3R2RUVRVTFFSEt6TXYyZmFHcmNpVmIzbWY0WVhZ?=
 =?utf-8?B?Q3VtbWFOd3JqTVRIajVROVowdU1mVE5jMjU1d0IySHBPUjBsb1FRVG56Y056?=
 =?utf-8?B?VGVRL1k0dCtYSVlmcEVyZWZJMVJRZ3lGNkVQbUo4VjFLWXY3emJFSTJmWVVn?=
 =?utf-8?B?U2RpWjBzaUZBSHAySkM4cDRKbjhXZUs0R0JrZ0tTUzVpN0JiMTRMRk5CT2cr?=
 =?utf-8?B?Mmp1Y2FvRkFhZ1BRVHBNRGNUTzZ3OUhJMGtCZmVKbGNpR2RKK2tlTXdGMFVo?=
 =?utf-8?B?RmQ1c1lwcXdiK2hPTjBEZTdtcUNLdnJYWGlzdVBvU3Jwa1RLTVlidzRKOXJM?=
 =?utf-8?B?ODJ5N29sVENQbkk5NmdXSWdHcGsva3NPckFWMmpreE1lTXpXN0dycW9qZ2k1?=
 =?utf-8?B?dzdSUmxlK25SOEVHZXgvV3RpUDc4TDZUdEtIYURmeUp0OUtjQTBqNTNVOEMz?=
 =?utf-8?B?dnV5Z1NmZUU3bXBveUtsNUZWRk1YSllCZHR1YzJzM1BKRFBUOHArT3RxSXJq?=
 =?utf-8?B?SmllUTY1cHBObjJ4UHhIK2lOSldTNUlwcE4yRXZVWXhnUmZ0eE95SVlhV2NC?=
 =?utf-8?B?bk5qQTdOWUI0NTM5WmpscTlnZVJYVk82VUJMQXd6dTQ1d3o4WExiVm9ncVJs?=
 =?utf-8?B?eWdtL09DV3hWS2YxVDJXSzNLRDIvUGpDd1N6U0dkUG9oWFIyMEE4QWhuMTFx?=
 =?utf-8?B?aHA2ckZFZUYwYUFZNWZCem1URGd1UkNhYXVHQmZiZStkYVRIM0x1eEFwNXEr?=
 =?utf-8?B?OTh5ZnJCang1ZWZUR2tCazZwRmIycURuSG01ai9rNlJmZ1hRSnN6NFhDTEZO?=
 =?utf-8?B?MW1Jd2lTV005djJzVmhuNUNERFZ4azFKZklTaHJ5V0lZaGd1ZGJKaU1JcHZS?=
 =?utf-8?B?OVVKZkIrQzJGWU9ZUlA1czhpcEdEd1duUzBOa3ZVbjNrNC9WYlBVYVp6ZVF4?=
 =?utf-8?B?dHg5SnRMZ0kzZmw1Qk11OU0yZGZraDRoMXI0UFVzYVEwaW9CaFJmVnRFZjZw?=
 =?utf-8?B?TkVTbHBQWFhwWDJRTlcxS3IySG5meHk1UitlQVpiNmNHK0ZDOUdna2lFMlFD?=
 =?utf-8?Q?bH+lCURM2JnO333F0pNp5dqeW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942e3544-0c94-4950-ec96-08ddb3a47c59
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 04:55:20.2774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ovb3CaaXMXnRqWpnKS6SfaKUCfwnsvTdqQFbw2Wj3ZD9yfH2GEfwe0hQuen9Mq+Dnyn5xXPSTklIDWsV8vQfpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7297


Thanks for the review.

On 6/25/2025 12:34 AM, Dionna Amalie Glaze wrote:
> On Mon, Jun 23, 2025 at 9:17 PM Nikunj A Dadhania <nikunj@amd.com> wrote:
>>
>>> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
>>> index b6db4e0b936b..ffd44712cec0 100644
>>> --- a/arch/x86/coco/sev/core.c
>>> +++ b/arch/x86/coco/sev/core.c
>>> @@ -2167,15 +2167,39 @@ static unsigned long securetsc_get_tsc_khz(void)
>>>
>>>  void __init snp_secure_tsc_init(void)
>>>  {
>>> +     struct snp_secrets_page *secrets;
>>>       unsigned long long tsc_freq_mhz;
>>> +     void *mem;
>>>
>>>       if (!cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
>>>               return;
>>>
>>> +     mem = early_memremap_encrypted(sev_secrets_pa, PAGE_SIZE);
>>> +     if (!mem) {
>>> +             pr_err("Unable to get TSC_FACTOR: failed to map the SNP secrets page.\n");
>>> +             sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SECURE_TSC);
>>> +     }
>>> +
>>> +     secrets = (__force struct snp_secrets_page *)mem;
>>> +
>>>       setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
>>>       rdmsrq(MSR_AMD64_GUEST_TSC_FREQ, tsc_freq_mhz);
>>>       snp_tsc_freq_khz = (unsigned long)(tsc_freq_mhz * 1000);
>>>
>>> +     /*
>>> +      * Obtain the mean TSC frequency by decreasing the nominal TSC frequency with
>>> +      * TSC_FACTOR as documented in the SNP Firmware ABI specification:
>>> +      *
>>> +      * GUEST_TSC_FREQ * (1 - (TSC_FACTOR * 0.00001))
>>> +      *
>>> +      * which is equivalent to:
>>> +      *
>>> +      * GUEST_TSC_FREQ -= (GUEST_TSC_FREQ * TSC_FACTOR) / 100000;
>>> +      */
>>> +     snp_tsc_freq_khz -= (snp_tsc_freq_khz * secrets->tsc_factor) / 100000;
>>> +
> 
> To better match the documentation and to not store an intermediate
> result in a global, it'd be
> good to add local variables. 

As there is no branches, IMHO having intermediate result should be fine and not sure
if that will improve the readability as there will be three variables now in the function
(tsc_freq_mhz, guest_tsc_freq_khz and snp_tsc_freq_khz) adding to confusion.

> I'm also not a big fan of ABI constants
> in the implementation.

Sure, and we will need to move the comment above to the header as well.

> 
> guest_tsc_freq_khz = (unsigned long)(tsc_freq_mhz * 1000);
> snp_tsc_freq_khz = guest_tsc_freq_khz -
> SNP_SCALE_TSC_FACTOR(guest_tsc_freq_khz * secrets->tsc_factor);
> 
> ...in a header somewhere...
> /**
>  * The SEV-SNP secrets page contains an encoding of the percentage decrease
>  * from nominal TSC frequency to mean TSC frequency due to clocking parameters.
>  * The encoding is in parts per 100,000, so the following is an
> integer-based scaling macro.
>  */
> #define SNP_SCALE_TSC_FACTOR(x) ((x) / 100000)

How about something below:

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 655d7e37bbcc..d4151f0aa03c 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -223,6 +223,18 @@ struct snp_tsc_info_resp {
 	u8 rsvd2[100];
 } __packed;
 
+
+/* Obtain the mean TSC frequency by decreasing the nominal TSC frequency with
+ * TSC_FACTOR as documented in the SNP Firmware ABI specification:
+ *
+ * GUEST_TSC_FREQ * (1 - (TSC_FACTOR * 0.00001))
+ *
+ * which is equivalent to:
+ *
+ * GUEST_TSC_FREQ -= (GUEST_TSC_FREQ * TSC_FACTOR) / 100000;
+ */
+#define SNP_SCALE_TSC_FREQ(freq, factor) ((freq) - ((freq) * (factor)) / 100000)
+
 struct snp_guest_req {
 	void *req_buf;
 	size_t req_sz;
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index ffd44712cec0..9e1e8affb5a8 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2184,19 +2184,8 @@ void __init snp_secure_tsc_init(void)
 
 	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	rdmsrq(MSR_AMD64_GUEST_TSC_FREQ, tsc_freq_mhz);
-	snp_tsc_freq_khz = (unsigned long)(tsc_freq_mhz * 1000);
-
-	/*
-	 * Obtain the mean TSC frequency by decreasing the nominal TSC frequency with
-	 * TSC_FACTOR as documented in the SNP Firmware ABI specification:
-	 *
-	 * GUEST_TSC_FREQ * (1 - (TSC_FACTOR * 0.00001))
-	 *
-	 * which is equivalent to:
-	 *
-	 * GUEST_TSC_FREQ -= (GUEST_TSC_FREQ * TSC_FACTOR) / 100000;
-	 */
-	snp_tsc_freq_khz -= (snp_tsc_freq_khz * secrets->tsc_factor) / 100000;
+	snp_tsc_freq_khz = (unsigned long) SNP_SCALE_TSC_FREQ(tsc_freq_mhz * 1000,
+							      secrets->tsc_factor);
 
 	x86_platform.calibrate_cpu = securetsc_get_tsc_khz;
 	x86_platform.calibrate_tsc = securetsc_get_tsc_khz;

Regards,
Nikunj

