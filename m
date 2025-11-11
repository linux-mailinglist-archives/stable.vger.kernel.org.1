Return-Path: <stable+bounces-194548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E72CC5015F
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 00:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4339434AF6D
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 23:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C96230264;
	Tue, 11 Nov 2025 23:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Gm7dN8x7"
X-Original-To: stable@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023141.outbound.protection.outlook.com [40.107.201.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85AB35CBC5;
	Tue, 11 Nov 2025 23:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762904727; cv=fail; b=an0XcUMYCwIEZWBSBwIAmc1/TuTfVJMOJNEENxr9StqRWxT+JYSCQSzXyXkH4b9cHC04hhatDOcWAmfwlnG4SI0pto+E9s3N8TyptRETHD8y68jNphyF0ry0RfAY+fPGfTu/ELzYQH2+YY1yx8WEw9EAcOuZnT68aYfTNRKRugk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762904727; c=relaxed/simple;
	bh=TaywlVwgilkgsLASpLPy2H0wy/ZdJCsQ9cL660UbuTk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FM94THolKI9F3C2lcf0zYdEIohPuXoNDhsO4K+THsQdGvWz9UtPeu0+uzKZU1ywHm+lZR+Z53BFIVp0E02SdvxPb4WvTuI4KQa28bPmVQMzLfMj0OT4vBa3Kw9U2BdsaqSHlOT6ATX3b3OQlAvC1Xt26loGitNXkdL2MSqnV4t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Gm7dN8x7; arc=fail smtp.client-ip=40.107.201.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naI5S0ZsAtfDD2KwqfqhojIz6DO5T0fJ8pxvBiDR6H716iorAR/Xrky+nIpgZDI5KASy9Gxtz0XlbuVLkFcIH8ok9hgUtySNebxIE6Ii8WDb20WAdRp53q4Phj6+Aurt+P9h0VUtpMAyAnb4sP5qHCnZniMTtZDADurioWHBa6eJj/uJeJv6J1yG5f1xO56QJrexQms4ybdzet4ZnHkJPQOARRNySuDqxVB8Emc0xtDntUAkBuw81q6KFhLyr1R+zijGduXOrGsykHeS+nF4KFT8Q9KlzM0mXlE9XGwiaae0aIevn/nMmDI1/dvUObucIhHLWKlph2cJ4rqomYcjMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHv0Ehr7JKWQiAMy2kDufRUEwhV6+9zQzgJoWkyvjUk=;
 b=JIZ/JsuEwgTEnIgoPStU39QBNrcKniaGEOyPpTbsFBDdpgZa91YSdR+ZSk2F97wmrQ8mrwvNrO5Qz6cVej3QL3FQ6zeo/iyArUSFNtLb77dzvVwx5ayRIg8LqOLm5qsVSPzXc6GjyuRUbXvbXVs5LDU2FueA511ZLReLuMi7QDGWPoQVJncr0lW5fc/cPrf8qs7jQhGdWIvBEqF26yPc888WD7bDRl6Dyn2siQ+HHnTqWMJL1dZUL101ziq91dExFX2yrsq7U7630tnZH3txuoizAJfFmY7VuPRqSbKShBKq9NuY9lnOnOARXQm5BBVUdSlXHkYNrXODRtNfZlx4RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHv0Ehr7JKWQiAMy2kDufRUEwhV6+9zQzgJoWkyvjUk=;
 b=Gm7dN8x7fnttIIRrJDZLKlfLKKf/j78SA4nMjjOKcaXxayUevKb8N9IB/5tXnpvtF87QMoTi2OxqBMRcQzLxG+2zikICEX8v3WPfTAc5qSNkGsrf2VsU7F1kROJU5agipdfUHi3OwOuBGZCsUgq1UUfkYUafszfuphfwXj/q9Vc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CH5PR01MB8936.prod.exchangelabs.com (2603:10b6:610:20e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.16; Tue, 11 Nov 2025 23:45:22 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 23:45:21 +0000
Message-ID: <5cd5fe49-42e9-41b4-8bf1-6b5136c88693@os.amperecomputing.com>
Date: Tue, 11 Nov 2025 15:45:17 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/pageattr: Propagate return value from
 __change_memory_common
To: Dev Jain <dev.jain@arm.com>, Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, ryan.roberts@arm.com, rppt@kernel.org,
 shijie@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251103061306.82034-1-dev.jain@arm.com>
 <aQjHQt2rYL6av4qw@willie-the-truck>
 <f594696b-ba33-4c04-9cf5-e88767221ae0@os.amperecomputing.com>
 <f8b899cf-d377-4dc7-a57c-82826ea5e1ea@arm.com>
 <aQn4EwKar66UZ7rz@willie-the-truck>
 <586b8d19-a5d2-4248-869b-98f39b792acb@arm.com>
 <17eed751-e1c5-4ea5-af1d-e96da16d5e26@arm.com>
 <c1701ce9-c8b7-4ac8-8dd4-930af3dad7d2@os.amperecomputing.com>
 <938fc839-b27a-484f-a49c-6dc05b3e9983@arm.com>
 <94c91f8f-cd8f-4f51-961f-eb2904420ee4@os.amperecomputing.com>
 <47f0fe70-5359-4b98-8a23-c09ab20bd6d9@arm.com>
 <ca628d43-502a-42f1-be57-bcb37103ddf8@os.amperecomputing.com>
 <19def538-3fb6-48a1-ae8b-a82139b8bbb9@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <19def538-3fb6-48a1-ae8b-a82139b8bbb9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR15CA0078.namprd15.prod.outlook.com
 (2603:10b6:930:18::14) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CH5PR01MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 10e380a9-d8d8-4dde-084e-08de217c6071
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTNnc1BPSXdPd0ZEd28xR1FlUWVtWGY2U3RGSUhOdXJldkFKU3V6bjYyak1a?=
 =?utf-8?B?dzJaVXZ1aUJNMy9YQXMyZGNzY3hOaGM2cS9zUllHUmJvSzJFMmJ1VExKNC9Z?=
 =?utf-8?B?YURnLzVVc25jSjVrYXd1dE1TN21LYjVuQzZtb2gyTGdLYkF1dlBpNlJVdFpv?=
 =?utf-8?B?alEzV3NlLzVEa2hHcXdvazZ2b3RhbVRNTjhMaDJ6aXZ4Rnl0enppT2s3VHMx?=
 =?utf-8?B?NXkzMVFGblZLRzBHcVpEZlp1RjBna0RkTXRNSmk3Mlg1aFZOWEJCa2xGbnBy?=
 =?utf-8?B?T1FGcEFxWGd3T0FRenFuVWN0ckhRMkpSZkxpMlZ4c1RYQnM4cHpKSkx5WnV5?=
 =?utf-8?B?Z0k4ME9XK1V2Q0ZGUENoRE9jSXRtMGpHTng0blF2L2o4NWk3ekIwNldIQ1M4?=
 =?utf-8?B?RWpYUGVKZzFucytDbjQzeEhOdVhkQjcxcklpTXFIQkE5RUZGcVdieEdnU1hy?=
 =?utf-8?B?alVOd2RGZWUrQ1Q4SDhObjRuaEJrMStUT3krdHFNWk1JemtxRmVFTk9maHRY?=
 =?utf-8?B?ZVFnbGlHQmVKTUlOT0JGUEp6UXhoS2hnbVk4eW9raWpOM2FHWUthOVoyaUdl?=
 =?utf-8?B?T3BIeXk3M3krSSt2UGZ3dlJJeUJ5d21Xdy9jQm4yRDFlekU5RWIyUG9wSzZU?=
 =?utf-8?B?Qi81UjhlYWErZ0EwWGN0Z29PRTZBT2pLOUNXUjY1aUtlK21GUnRieGZMZ2Yz?=
 =?utf-8?B?YTFieUk5WlRYTmhrcmVDSHk3WVp6YUJ2K2dzZm11MWtsZFFsOTV6L3ZjMHdl?=
 =?utf-8?B?ekJ1aFptaS9lYTI3NlRyKzZwN1V4ZG9NN2pqQTRiaDRGaHpUekVFSW9aSk1U?=
 =?utf-8?B?enVIZmVZa1hsSGNXSFRmWWxlN2FmNDR1cEN1YmhwV1JuV0xiWHlpeFphUE8w?=
 =?utf-8?B?K3pwZ3FsVkdrakNvbjNEeEZUY29tR1JsU3h1endiamM0L1BFS210bzhaYTBC?=
 =?utf-8?B?b2RlZ3dDWWdmM2xHOEhqSmNYK09kd3VRV295cU9jWExPbzlwbHVLL0IxZXVp?=
 =?utf-8?B?WEV5aW1uSjNYQ1dRclgycXdEMjM2NXhrMTdwWjdNY3VuMHoyWWloZGxzUFVR?=
 =?utf-8?B?UEx4ajMrd0dMQ3V1NzJ4dzU2QjQyYno1NlFxSVNKSkR5SnlBU0psWFpPOEF5?=
 =?utf-8?B?bDJVTWk3YUczYlpnM3duZ2JJa0lsbU1lUU1QcjNpRkRYOFRQVjd0WDdTWFVS?=
 =?utf-8?B?SUlNajFqM01JRWFiRDdlU2YwQUowdE1rMTlrUzh2U21vajRzeFArbWVsdjRx?=
 =?utf-8?B?azFmc1ZBdktIQVBwZ3NLeWN3aDFEMkZVZWNIRWs4dnNwTzFDNjV3clZQd3JQ?=
 =?utf-8?B?TElMNThiOVRXdTN3K1pvb2ZndzErMDMzcVFwYWZYL25mazNyVFN3elVyQjRM?=
 =?utf-8?B?S1R6M2ozSVptdE5GWGJaRkRBM2FjN0s1NXg4R3NhRjVMTmgxSG11MGZtNjZr?=
 =?utf-8?B?OWt0TklTakJOeEFKNWpKcnVlK29UYm1Sb2kvSm5TVUxBMHEwUWwremdueGpi?=
 =?utf-8?B?b3FsY2NXRTIvcndjTVBZRS83MnZQM1psdUg0QXVYNEdFZ3ozWm8rNzhtQ2hq?=
 =?utf-8?B?bGFMbUZEN0YyNlNpMmpzdXQvVU9wRW4yS3RLd0VIck1RS2ZPU0lJcDQ5cldB?=
 =?utf-8?B?Qlh5ZndaT3ZTb21GTmh2WkJSem5oVjVod3hTTmpwcnhMMHlPamwyMTZlRkFN?=
 =?utf-8?B?NXhoNW0yQnhaaUVzbHVuMmV6MXBHRE9qeEJlcXRDYk02dktFc2xHb3h6WGlt?=
 =?utf-8?B?cytxQ1ZRWXBLa1lmMmdpd2hkZ2ZLSENGZHhNVGdYUExtWGpkWU9hWmx3c1U5?=
 =?utf-8?B?MEhhTXpSN3czb3NndFFKbjRRY1EvT3ZyQzNyUVU2L21PZDduTzlVT1c5U2Zt?=
 =?utf-8?B?aXJwbEF1RzI2VlJYUVJPOUpXU2xwZjlVazhJUGlVVEM0R1hLb0RrcFhkYm9O?=
 =?utf-8?Q?CVm+FRHCmwTrX5t8iWQ0f+QWWLhv5YRr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkxzMDVoT1NvWjltYkdFNlZJbm5LL2NOQ2t1c1N2TVc4elZ5enRJOWRIU2tP?=
 =?utf-8?B?eGJBUkovbWc4b1pLTmt6dlZhU1pSL0tBSW1KanF0SS80RGRrd2Y0MXJyRmxi?=
 =?utf-8?B?UDJndFhKS2luamxqNXB4ZVVrN1RnRlRmZXh3dmxMTEpJSkk2RkFBOFRGTXVO?=
 =?utf-8?B?UGFaTzdEcXFCVktBZzlwYi91SHZ6YkF1OFNqOEloTW5VTHJhdWlibm95L1RN?=
 =?utf-8?B?WkFuRDhncjRuaEM1WWRWUEhacVNtMWhMSEp2UEU2cTg2RXd1UW9WQnZDUi9W?=
 =?utf-8?B?U2RyNlBzMU9oWDN2VTdnUXlwcGJ5RVJWNy9qWFBFWDR2bVh4T0MwK1pmckJk?=
 =?utf-8?B?d1lXNkwyY0psSDhrdHAvck12US9sNG1PbnRSOTBKa0xCOVFiNlQxdTVXQ29Z?=
 =?utf-8?B?N3pjR1ErMUFPd0x3cXFnMFZqVFFTdDZFb05YUktFVHNSZ0hGVTlCMGd1bWJL?=
 =?utf-8?B?WHdQZElsQk8zNmhqQVd1Q1NBNGFiMUNEdnUzR0Z4OVdqRWoyNFpKMHBRemRs?=
 =?utf-8?B?VStaNGVrV0dpbUwxSWJTZHVTRWhOZmtaYkdpQi9QampLUEFtMkNCdE40YVFh?=
 =?utf-8?B?NGxPVDhNYlljZ3JJVGJDQzBJaHQ3Umk0MGFHV1hQeFhWQ0hoNHpndVR2MjZT?=
 =?utf-8?B?NkdCcDQ5SGJ0WXQwKzlqT1ZnMkxqOEZWL2xISEl0RHVPY0crNGp1QlE3cEVs?=
 =?utf-8?B?V2Z2aUgrU2xOeTlWaDRYME82QWJyNG41NkFLQlVkVU80RUZ6OVQxOFVueVl3?=
 =?utf-8?B?a0J5VVVxRjducCs5SHBhMERUVnZNZGt4blZxZTJ5ZmJ6V1d3dEJMbExKejFk?=
 =?utf-8?B?clF1cTNNRC9qTW9rMEhNVkg3S3JoMHNMWFpyR2YyMXRzcm5oMHN0NysvQnE1?=
 =?utf-8?B?SU5jTDdudkhyYkFVWjFpVkdocUp4LzFVNEQ2VXhsTEwrVCtCM2F0ZzBGTWNX?=
 =?utf-8?B?L1MwS0xPVUFuQXBIZmV5UGRnQUJBejNDaUk4QTRuLzk0ZG5sNGNPYlVPeXVo?=
 =?utf-8?B?NXF2UXdCM2g0Mm1ES1Fya3Vzd1RDK1lYLzZ0S1lxMERiZ2NmZU5SdnF3eFAw?=
 =?utf-8?B?Z253RmdXSXVsSndQNkhPVE5DTFljREI1U2lWZDZYbWRuT0VxQnVBTVp5UVh6?=
 =?utf-8?B?QWFyYUY2SGRLWHR2c0tkdkFFcTd3REk4eUhBcE9ObWh0UVQvVkFBd1BCcEdO?=
 =?utf-8?B?SWpoV2pQaEtZVGhYU29LdVlLbVhCK0FoUGtjWmRFUGVXMjMrQkpuZG5hYlhU?=
 =?utf-8?B?Zmd2SnJoZHY4aHpjS2dXa3FZeDh6c3E5SlIvNm5xdG9zMWp5WGNGZTVQbGZ4?=
 =?utf-8?B?RFRianNvVVQrQ1luNmJWWUFCdmVKUlJJR2ZtdmdPODcrdzM0LzVnS1FaMjFT?=
 =?utf-8?B?MDJKZ1huMGFSVHY4SFU2d0prOFFCZGR4YWlBSGhVdTZxTWJZR25MdGx5N21l?=
 =?utf-8?B?TDBlV1BqM3J5TUZVTVY3WnNmZXVrMlBxMHBYY09mNmdSRnA5Q1A1Q2RFdEtK?=
 =?utf-8?B?S1hXZVovVEJ1YzNEUkdTWUlvQnhISytiR1BEK2o1MnBJaWZwSndjNmxjc05z?=
 =?utf-8?B?ZVRyRHRzSzViNnlZb1k1SVZqVGlNU1NUV01DOHNaNEVXdGJ1YXhUWEV3KzdN?=
 =?utf-8?B?SjEyZmd0UzBobEh6NS9wcUhjWGlkVFlhNjYySDRCQ1RFamFaN0p1YXNSWEtB?=
 =?utf-8?B?RHNSSUxYQ1dHdVlTRTNINkRMM3M3WWlkQ2hzWk1ieGpQVlZhbXRSWnJkNWdV?=
 =?utf-8?B?Y1Z1VWtCejV6L0R1WlRpOWZTdEQ3Z2s3T1EwUWhTVnQvMUdDTWtlbTRKRGRj?=
 =?utf-8?B?d0ZrZ2Vhelc0Zlo4QTM0YUI4VzUwTmJLWGpucWJVOWdLbmFkNmU4NXZLbnRO?=
 =?utf-8?B?eDlNNVZJTk9TREFlM1kyRjlDTlBKTFljQ05wSmo1cmt1YVVYUTJ0SytIRnpY?=
 =?utf-8?B?U2VxOXdNQmlROExVNk0rcFR3WXdtVjJ0cS94eEl4Wm1yRm0xM2RvQUV4UUNM?=
 =?utf-8?B?ZkFRV1llUFJsZGZRc0FacW9KK2MyNWpWUkhsS3ZvZ2szeko5QnkyTkNqbmdv?=
 =?utf-8?B?YXBuZU0rS2Vjanh3MGpjNmhyakhJUi9mVytWSU94SHNpdDFHbncxdUNNYnpO?=
 =?utf-8?B?YVAxQUxjMFJkNnVlMjRmY0Fkcm9xUUQ4NHJTSkJZdlVMSUs4K1BFK2VkSFJ1?=
 =?utf-8?Q?3MO+8Vu6kAltIIQXIg6oguM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e380a9-d8d8-4dde-084e-08de217c6071
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 23:45:21.2373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XsWNjb+hm/K8uAui1zI8QebE0tNzUA9/NtOBZhveh6t0yp9/csElv8gLsyxHlEhFWW3FsTUdSkyKXMDyjjKzF4km3XjqcGcjyGuT9iEnTNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR01MB8936



On 11/10/25 9:12 PM, Dev Jain wrote:
>
> On 11/11/25 10:38 am, Yang Shi wrote:
>>
>>
>> On 11/10/25 8:55 PM, Dev Jain wrote:
>>>
>>> On 11/11/25 10:14 am, Yang Shi wrote:
>>>>
>>>>
>>>> On 11/10/25 8:37 PM, Dev Jain wrote:
>>>>>
>>>>> On 11/11/25 9:47 am, Yang Shi wrote:
>>>>>>
>>>>>>
>>>>>> On 11/10/25 7:39 PM, Dev Jain wrote:
>>>>>>>
>>>>>>> On 05/11/25 9:27 am, Dev Jain wrote:
>>>>>>>>
>>>>>>>> On 04/11/25 6:26 pm, Will Deacon wrote:
>>>>>>>>> On Tue, Nov 04, 2025 at 09:06:12AM +0530, Dev Jain wrote:
>>>>>>>>>> On 04/11/25 12:15 am, Yang Shi wrote:
>>>>>>>>>>> On 11/3/25 7:16 AM, Will Deacon wrote:
>>>>>>>>>>>> On Mon, Nov 03, 2025 at 11:43:06AM +0530, Dev Jain wrote:
>>>>>>>>>>>>> Post a166563e7ec3 ("arm64: mm: support large block mapping 
>>>>>>>>>>>>> when
>>>>>>>>>>>>> rodata=full"),
>>>>>>>>>>>>> __change_memory_common has a real chance of failing due to 
>>>>>>>>>>>>> split
>>>>>>>>>>>>> failure.
>>>>>>>>>>>>> Before that commit, this line was introduced in c55191e96caa,
>>>>>>>>>>>>> still having
>>>>>>>>>>>>> a chance of failing if it needs to allocate pagetable 
>>>>>>>>>>>>> memory in
>>>>>>>>>>>>> apply_to_page_range, although that has never been observed 
>>>>>>>>>>>>> to be true.
>>>>>>>>>>>>> In general, we should always propagate the return value to 
>>>>>>>>>>>>> the caller.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Cc: stable@vger.kernel.org
>>>>>>>>>>>>> Fixes: c55191e96caa ("arm64: mm: apply r/o permissions of VM
>>>>>>>>>>>>> areas to its linear alias as well")
>>>>>>>>>>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>> Based on Linux 6.18-rc4.
>>>>>>>>>>>>>
>>>>>>>>>>>>>    arch/arm64/mm/pageattr.c | 5 ++++-
>>>>>>>>>>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>>>>>>>>
>>>>>>>>>>>>> diff --git a/arch/arm64/mm/pageattr.c 
>>>>>>>>>>>>> b/arch/arm64/mm/pageattr.c
>>>>>>>>>>>>> index 5135f2d66958..b4ea86cd3a71 100644
>>>>>>>>>>>>> --- a/arch/arm64/mm/pageattr.c
>>>>>>>>>>>>> +++ b/arch/arm64/mm/pageattr.c
>>>>>>>>>>>>> @@ -148,6 +148,7 @@ static int change_memory_common(unsigned
>>>>>>>>>>>>> long addr, int numpages,
>>>>>>>>>>>>>        unsigned long size = PAGE_SIZE * numpages;
>>>>>>>>>>>>>        unsigned long end = start + size;
>>>>>>>>>>>>>        struct vm_struct *area;
>>>>>>>>>>>>> +    int ret;
>>>>>>>>>>>>>        int i;
>>>>>>>>>>>>>          if (!PAGE_ALIGNED(addr)) {
>>>>>>>>>>>>> @@ -185,8 +186,10 @@ static int change_memory_common(unsigned
>>>>>>>>>>>>> long addr, int numpages,
>>>>>>>>>>>>>        if (rodata_full && (pgprot_val(set_mask) == 
>>>>>>>>>>>>> PTE_RDONLY ||
>>>>>>>>>>>>>                    pgprot_val(clear_mask) == PTE_RDONLY)) {
>>>>>>>>>>>>>            for (i = 0; i < area->nr_pages; i++) {
>>>>>>>>>>>>> - __change_memory_common((u64)page_address(area->pages[i]),
>>>>>>>>>>>>> +            ret =
>>>>>>>>>>>>> __change_memory_common((u64)page_address(area->pages[i]),
>>>>>>>>>>>>>                               PAGE_SIZE, set_mask, 
>>>>>>>>>>>>> clear_mask);
>>>>>>>>>>>>> +            if (ret)
>>>>>>>>>>>>> +                return ret;
>>>>>>>>>>>> Hmm, this means we can return failure half-way through the 
>>>>>>>>>>>> operation. Is
>>>>>>>>>>>> that something callers are expecting to handle? If so, how 
>>>>>>>>>>>> can they tell
>>>>>>>>>>>> how far we got?
>>>>>>>>>>> IIUC the callers don't have to know whether it is half-way 
>>>>>>>>>>> or not
>>>>>>>>>>> because the callers will change the permission back (e.g. to 
>>>>>>>>>>> RW) for the
>>>>>>>>>>> whole range when freeing memory.
>>>>>>>>>> Yes, it is the caller's responsibility to set 
>>>>>>>>>> VM_FLUSH_RESET_PERMS flag.
>>>>>>>>>> Upon vfree(), it will change the direct map permissions back 
>>>>>>>>>> to RW.
>>>>>>>>> Ok, but vfree() ends up using update_range_prot() to do that 
>>>>>>>>> and if we
>>>>>>>>> need to worry about that failing (as per your commit message), 
>>>>>>>>> then
>>>>>>>>> we're in trouble because the calls to set_area_direct_map() 
>>>>>>>>> are unchecked.
>>>>>>>>>
>>>>>>>>> In other words, this patch is either not necessary or it is 
>>>>>>>>> incomplete.
>>>>>>>>
>>>>>>>> Here is the relevant email, in the discussion between Ryan and 
>>>>>>>> Yang:
>>>>>>>>
>>>>>>>> https://lore.kernel.org/all/fe52a1d8-5211-4962-afc8-c3f9caf64119@os.amperecomputing.com/ 
>>>>>>>>
>>>>>>>>
>>>>>>>> We had concluded that all callers of set_memory_ro() or 
>>>>>>>> set_memory_rox() (which require the
>>>>>>>> linear map perm change back to default, upon vfree() ) will 
>>>>>>>> call it for the entire region (vm_struct).
>>>>>>>> So, when we do the set_direct_map_invalid_noflush, it is 
>>>>>>>> guaranteed that the region has already
>>>>>>>> been split. So this call cannot fail.
>>>>>>>>
>>>>>>>> https://lore.kernel.org/all/f8898c87-8f49-4ef2-86ae-b60bcf67658c@os.amperecomputing.com/ 
>>>>>>>>
>>>>>>>>
>>>>>>>> This email notes that there is some code doing set_memory_rw() 
>>>>>>>> and unnecessarily setting the VM_FLUSH_RESET_PERMS
>>>>>>>> flag, but in that case we don't care about the 
>>>>>>>> set_direct_map_invalid_noflush call failing because the 
>>>>>>>> protections
>>>>>>>> are already RW.
>>>>>>>>
>>>>>>>> Although we had also observed that all of this is fragile and 
>>>>>>>> depends on the caller doing the
>>>>>>>> correct thing. The real solution should be somehow getting rid 
>>>>>>>> of the BBM style invalidation.
>>>>>>>> Ryan had proposed some methods in that email thread.
>>>>>>>>
>>>>>>>> One solution which I had thought of, is that, observe that we 
>>>>>>>> are doing an overkill by
>>>>>>>> setting the linear map to invalid and then default, for the 
>>>>>>>> *entire* region. What we
>>>>>>>> can do is iterate over the linear map alias of the vm_struct 
>>>>>>>> *area and only change permission
>>>>>>>> back to RW for the pages which are *not* RW. And, those 
>>>>>>>> relevant mappings are guaranteed to
>>>>>>>> be split because they were changed from RW to not RW.
>>>>>>>
>>>>>>> @Yang and Ryan,
>>>>>>>
>>>>>>> I saw Yang's patch here:
>>>>>>> https://lore.kernel.org/all/20251023204428.477531-1-yang@os.amperecomputing.com/ 
>>>>>>>
>>>>>>> and realized that currently we are splitting away the linear map 
>>>>>>> alias of the *entire* region.
>>>>>>>
>>>>>>> Shouldn't this then imply that set_direct_map_invalid_noflush 
>>>>>>> will never fail, since even
>>>>>>>
>>>>>>> a set_memory_rox() call on a single page will split the linear 
>>>>>>> map for the entire region,
>>>>>>>
>>>>>>> and thus there is no fragility here which we were discussing 
>>>>>>> about? I may be forgetting
>>>>>>>
>>>>>>> something, this linear map stuff is confusing enough already.
>>>>>>
>>>>>> It still may fail due to page table allocation failure when doing 
>>>>>> split. But it is still fine. We may run into 3 cases:
>>>>>>
>>>>>> 1. set_memory_rox succeed to split the whole range, then 
>>>>>> set_direct_map_invalid_noflush() will succeed too
>>>>>> 2. set_memory_rox fails to split, for example, just change 
>>>>>> partial range permission due to page table allocation failure, 
>>>>>> then set_direct_map_invalid_noflush() may
>>>>>>    a. successfully change the permission back to default till 
>>>>>> where set_memory_rox fails at since that range has been 
>>>>>> successfully split. It is ok since the remaining range is 
>>>>>> actually not changed to ro by set_memory_rox at all
>>>>>>    b. successfully change the permission back to default for the 
>>>>>> whole range (for example, memory pressure is mitigated when 
>>>>>> set_direct_map_invalid_noflush() is called). It is definitely 
>>>>>> fine as well
>>>>>
>>>>> Correct, what I mean to imply here is that, your patch will break 
>>>>> this? If set_memory_* is applied on x till y, your patch changes 
>>>>> the linear map alias
>>>>>
>>>>> only from x till y - set_direct_map_invalid_noflush instead 
>>>>> operates on 0 till size - 1, where 0 <=x <=y <= size - 1. So, it 
>>>>> may encounter a -ENOMEM
>>>>>
>>>>> on [0, x) range while invalidating, and that is *not* okay because 
>>>>> we must reset back [0, x) to default?
>>>>
>>>> I see your point now. But I think the callers need to guarantee 
>>>> they call set_memory_rox and set_direct_map_invalid_noflush on the 
>>>> same range, right? Currently kernel just calls them on the whole area.
>>>
>>> Nope. The fact that the kernel changes protections, and undoes the 
>>> changed protections, on the *entire* alias of the vm_struct region, 
>>> protects us from the fragility we were talking about earlier.
>>
>> This is what I meant "kernel just calls them on the whole area".
>>
>>>
>>> Suppose you have a range from 0 till size - 1, and you call 
>>> set_memory_* on a random point (page) p. The argument we discussed 
>>> above is independent of p, which lets us drop our
>>>
>>> previous erroneous conclusion that all of this works because no 
>>> caller does a partial set_memory_*.
>>
>> Sorry I don't follow you. What "erroneous conclusion" do you mean? 
>> You can call set_memory_* on a random point, but 
>> set_direct_map_invalid_noflush() should be called on the random point 
>> too. The current code of set_area_direct_map() doesn't consider this 
>> case because there is no such call. Is this what you meant?
>
>
> I was referring to the discussion in the linear map work - I think we 
> had concluded that we don't need to worry about the BBM style 
> invalidation failing, *because* no one does a partial set_memory_*.

Yes, we don't have to worry about it.

>
> What I am saying - we don't care whether caller does a partial or a 
> full set_memory_*, we are still safe, because the linear map alias 
> change on both sides (set_memory_* -> __change_memory_common, and 
> vm_reset_perms -> set_area_direct_map() )
>
> operate on the entire region.

Yes, this is the current behavior. My patch changes 
change_memory_common() to just do permission update for the requested 
range from the callers instead of assuming change the entire region, 
although there is no one calls set_memory_* on a partial range. Shall 
set_area_direct_map() be aware of potential partial range change from 
set_memory_*()? Maybe. But it is just called from vfree() which just 
free the entire region.

What happened if someone does something crazy, for example, call 
set_memory_* on a partial range, then call vfree? IIUC, it is fine as 
well. It is still covered by the 3 cases that I mentioned in the 
previous email if I don't miss anything, right?

Thanks,
Yang

>
>
>>
>>>
>>>
>>> I would like to send a patch clearly documenting this behaviour, 
>>> assuming no one else finds a hole in this reasoning.
>>
>> Proper comment to explain the subtle behavior is definitely welcome.
>>
>> Thanks,
>> Yang
>>
>>>
>>>
>>>>
>>>> Thanks,
>>>> Yang
>>>>
>>>>>
>>>>>
>>>>>>
>>>>>> Hopefully I don't miss anything.
>>>>>>
>>>>>> Thanks,
>>>>>> Yang
>>>>>>
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Will
>>>>>>>>
>>>>>>
>>>>
>>


