Return-Path: <stable+bounces-217921-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEHVKoO/nWnzRgQAu9opvQ
	(envelope-from <stable+bounces-217921-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 16:10:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA70188D72
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 16:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D28773018D46
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 15:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B3C3A1A5E;
	Tue, 24 Feb 2026 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L5nU8dYF"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013028.outbound.protection.outlook.com [40.93.196.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BC53A1A4C;
	Tue, 24 Feb 2026 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771945625; cv=fail; b=QXQGZavVXukaU89V8UyGo+pEtU5LyD7j//mqIHqvLeX2e5ATtpQrw2XNfkzYEa1HvIcXPUpik4bbU6ecDtwY6unEDKHUbCmGS4um98gANVqYxDi26uwPQ34u032EEaKRn3NbcMxzyzwCnuh/X5KSy42f+DMSBo94ewTnfCngjqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771945625; c=relaxed/simple;
	bh=KiGVdB8I4VZHXGNWnq1sohU41rUG4vhxlp4BGMURYSk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GfQNmdvUiJuQN7IVgdQB1FPjHdYQhxl6bD7UOF03xZ5B6vLcNonDL53Y8gXzzHQ+bBAVCzxoUkPmP3xPHiirjl2UE+ILAwMBGuNNo9OnJiDa4rKQOF3arEcSgTwO2fOejbaNgz4dgV8ceCTuTd+ewIRc/E8BA5kdom78R1WHpkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L5nU8dYF; arc=fail smtp.client-ip=40.93.196.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKNYrGzNQisOEx/AUzPHLui+pYTspzI1vYrk/I9YET6Cvbcpu80R42uxXcSiDGcLDfF7Qr0Mnmnuw22kLBWbVsS1763jlPQ4miJdh2ETMvXKZJ6LwwqgnkNQzOpCb7DNl4j+IGhpUyfT57rivEXpML8kft9RHV6JmY66UCP7+hLLm0g+11SS+hevbJhoH/5mc9XN6k3ftmIv+ZAyfCKUCvObxKwwc6d83nNYadGmesGBcT2xUkfXzQBZamj3t7E7T19M8UrKcLF4RfznHX6dKo2pSlo0iJV5a72eaVTOBFDKLhRLzaL5ro99AVcROjCvnAmSzTsEd9VJRzE1NcBw2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihWts0/DhecDG9KpZnBggv8hohmIxcokxiKYGjJyr4o=;
 b=VYq69m48/fFS6Ous6+SqO7/ECgsQ9PEJTx0rkdWwzsJE0jY0HU8THR9aIcGqcZ2rzZh9Vyyv2jqN5O+MizyaLWj5yg0cBbCO6u/G0BnZ1xHfBTqak8hG2TrjZt4p9EcoBOJghC+No0XuamjDf1d7Lu+xd9SHiUxqrDI3XWI9EbO6lzqBGvrRv6yVIUGus58eXnBpQjjmv6a1xKYTz5bPHTSL6SbQSux/kofkU5DiSQM41ZgyAloJDQTiOR/p8hLpdOl8nze8g9PQvtazDrGMeTc4SUUoXAOdCByjHqf+LvNwf4goE8r1wKRYxHeszzYvybCLaAbDWXhCwlRs8PyS+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihWts0/DhecDG9KpZnBggv8hohmIxcokxiKYGjJyr4o=;
 b=L5nU8dYFyWADuCLBmpb052xNgV4qpAMCVAY6ulb9v/tXSC9BT9wLfp+dS19TR+r9q3dsVaoFjszOqy5BqQ8sTfwT92g99Yaw+fsTgHQDVtyd1cYnLUiT0/slPxeTFMSkOs7F/O1YlYpLF6OV19X+NVWjaME/JcSm7NQ5Qa7VDdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by PH7PR12MB7163.namprd12.prod.outlook.com (2603:10b6:510:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 15:07:00 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 15:07:00 +0000
Message-ID: <b419d9c6-e153-47a7-bdec-ff7d3dd7b90e@amd.com>
Date: Tue, 24 Feb 2026 09:06:57 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: hp-bioscfg: Support allocations of larger
 data
To: jorge.lopez2@hp.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
 linux@weissschuh.net
Cc: stable@vger.kernel.org, Paul Kerry <p.kerry@sheffield.ac.uk>,
 platform-driver-x86@vger.kernel.org
References: <20260223163245.3294630-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260223163245.3294630-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::8) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|PH7PR12MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: bd3caee3-2e12-4ce2-0e1a-08de73b65c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTV2TXNPUExwa2xKS1JXYjhpNEllRmJYL2YwWjlNenVNdzQ4eGc1MW4weXBo?=
 =?utf-8?B?SFArTkNwK1ZiQktabk14L1RaQm0rLzloZWNocmp5bytzTVNvQ09leENHMDA3?=
 =?utf-8?B?aE5IT2RyaHlXQUpCTzVobzZpRkVBZHY2MkpSNDM0Um0zSG54VXhDUUd2Zi9G?=
 =?utf-8?B?YkRvUXh1WEZGakN3U1FRRlNpaFl5WkNmSVI5OXpBaGFQRHJaNkVzRGF6d0pM?=
 =?utf-8?B?eTJnSTRGU0twUDhMaUEyOGFpVkEvTmYwMHpLZVhaaGsyZnR3MFpqVkpFNExz?=
 =?utf-8?B?M0lnMEs1ZFlJUFdid2NvZmV2QUsyUVBYRHM2QkZjVERyYlZEdk1QLzU0SHBQ?=
 =?utf-8?B?RWluRXRvOHo0b1BzMEZYamRxcW5BYW8zSStOY3V1djVXTm1qZFdwMExkOVBM?=
 =?utf-8?B?WnJaVnVQNmZvNzZHK3JSMlNNRFNVSzduRk9vT3FIcG5RMWQ0N2JoazlMMXpi?=
 =?utf-8?B?YVF5bDhSRWV1Nm1USlNxbmsvQXhTSldpQ0F3alBGTlR2djFjZkZ3K2VjTTl3?=
 =?utf-8?B?dkJXNkkxWGk0eDVPL3VzVVRJRGpZT2pieWhPTVdLeFk3bG43M3RtbEFnZGlh?=
 =?utf-8?B?b2ZHRmEweFhvbU5XU1J4S0NocXFQdHdqT3RXZlFyTUJ5WUNheGJZMys5YXRZ?=
 =?utf-8?B?dVU2cTlOZVh4L2tnTkJLYkZTQ1RQQ2tsK2ZRVytXalpRNk1KYXJqZzBzSUhU?=
 =?utf-8?B?SVJGVS9VYnQzWE5VMnE0T1BUVlRBYU52ZFNLUCtsTHcvcUYrb01nTUF0N3Nh?=
 =?utf-8?B?aDdrOURxYmZQd1NzSWJBOXpSOUV0czZ5NWNLUXhwYmhXMEM0azJKNmNCa1di?=
 =?utf-8?B?RC96UXNKS1U5UHZ6NGljRVZyQytIY2NOR09lM1hvT2FYS1dSMkt0MStMR0pP?=
 =?utf-8?B?R1F4QWZwVmI3QWpFRmRRM2dma0xsMTFiWEpVczNiWnkyUXhGYkUxdVZuLzIw?=
 =?utf-8?B?L0VVUGM3V2J1U0ErTVV3QURHWExIc29ueHVGNDVuQ3RDVElXaVRoZ0lCM3VN?=
 =?utf-8?B?SnRhbWpRRmdVUEZva1BhS29EYnVtMHlDc2dJOVZvaEQ1b216K2xnQUFwMHAx?=
 =?utf-8?B?bGVmcFN3YXVvT2oxbzZGTHJXcThMQVM5ZTVYOUM5cmtPTlhDTXg0UzFPSjZ6?=
 =?utf-8?B?aC9xWGM4TTlMNVZadTVHSzMzVjhlUURVbWFxS3NYQ2RkaWVwelNQVm42N05Y?=
 =?utf-8?B?cWdpT2NEVEdtbitEanlWeWNzZ3FZc0FuSDNSL011UXNsM2p6WTBkOHBlSit5?=
 =?utf-8?B?bFMwSGFvKzB6cFRMb3ZWM2dHNkZ5dnU0WHhITm8wRzdXU2psb2lLRDJiT1d3?=
 =?utf-8?B?TnozNXRLTjh2a3BIQjlNWjlwN1J3RUhHRUN6WjlqU3FHRG1wZmlhamZSeGNZ?=
 =?utf-8?B?clFLRDQrMy9iTzVPSEtiTERHWGVXbCtvL3hoam85aWEra2tkZGhOeC9kd0l6?=
 =?utf-8?B?djNLYk1jUXIwcHcxMmV2WW4yZ2dQM1BiSldPQjZuTGdjUkx6QlNiak0wYnNI?=
 =?utf-8?B?RmJXdmIwN291NHROMjNGQ1FCZTMyZTZrRzNxQnVxYmhhZjQ1Rm00TDE2aUNJ?=
 =?utf-8?B?U0kwRWJ5eDBsSXUrcnFhY0UwN1lrK0dvRWZ5RWoxeG5UNWZGSEpEa1NtODZ2?=
 =?utf-8?B?cHlaNDlOa01VMkxzb2V3RkErU2hHYitGdkp2eUluMFJaSURPLzVBMGY4MWhZ?=
 =?utf-8?B?MGpZZHdFdGxKSXdvWmNidFBibVYrRmlSc1Q4UzNjUDN1QTQrL0tMZTZxT0hv?=
 =?utf-8?B?bnYzVXhnZndSVHMvYnZuY1p5OEFxeGVHUXdKOXpoUUE4cDZFLytJNUQya1E1?=
 =?utf-8?B?ejhyazlnRDFsMXRlQWpoTzhTaUx5VmVCK2szN1F5UldldEh5SXlTR0xoUTZC?=
 =?utf-8?B?NE1PdnVNRXZjSmV5dGlDVVpHUW9wMER4YlNKZDB0WFJ2c0JTaUhzV2hCWldt?=
 =?utf-8?B?dGFVMkgrWjlLYmtwbkoya1pXOThwWk9GNEtaYkU4REFPRk9JYmt1ck94RjZ3?=
 =?utf-8?B?cENxZFBaejdILzJQdFQ1STdVTnFEWi9Pb0VqSy9hQUV4QVcralMzTlJvOEtU?=
 =?utf-8?Q?XxuAnQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXN0emZ3b3drenhrck9PUUpCYjRYc2ZNbHJVbVVIaTVlVlloSUM1N1V2ZVUz?=
 =?utf-8?B?MmJPYUFReHphMXk4U1NzVEErbzFkaU9MT3lvZHdMZCtLSkdpMWdobmVleGQx?=
 =?utf-8?B?c1VVSTlqaDFHaHYvaU1YNTdZUnR2N0E0SEdMSHFwL1JKQi93QjFyY2RtaXN4?=
 =?utf-8?B?Q1dhV3pZL1o3Ukd6NHBab3dqSC8ydXU1YThZVzJxZ1dLdWE2YVZtck0zaXNQ?=
 =?utf-8?B?NzM2cldqeDkzU3JQdHhBdXFncCtyT3JTM2VpcXVsZVBDWitBNXdwVWtTb1d1?=
 =?utf-8?B?eTBuOXFKSVpyRkJNNUY4Nk9RdnEzMXBiZmh6K04yVzVqZjRjWjdYc0pTUm11?=
 =?utf-8?B?VXBnNkdCNHBuTlhEdUp0UFgvMmozbm9MOTFuejNVOGllbzVCd2NSZGZCaHdH?=
 =?utf-8?B?RFMxV2ZmUEJWZUdqd2Z5VDZxWGc4eUt0SWJ3ZGZHTGFmdml3QlBrOVZjaVc2?=
 =?utf-8?B?ZmJ0bHlPSDh1N2NLTFJ1YkpwNm5mVk5vNjZ2R3hScDBLNTh3cERsRkRDTW1t?=
 =?utf-8?B?VmlaYXA0N0VLSWg0S3k3WXllREZEK1Z3Mi80V2cwRXRXQlZHRFFxQldhQk9x?=
 =?utf-8?B?eFRMeXRuVWxZSktvN2VTanFMc29udGY1NXNKbXZkQ2d4Q0tzNUZYUnMxaXM2?=
 =?utf-8?B?Tms5NDUrc3dPTXpvUERSM2pFRHVuWmRYWXYrNlNuVEQvbUpRb3RQNkdHMk1I?=
 =?utf-8?B?Z0xnbm9jLzBsMzF2ZXRmVzQvTFNZYnhGUGZhWG1GSFhoWitTVlhkS0k0TGtX?=
 =?utf-8?B?OExsY0tMMU9OM1BNQWdkaS9oczgvZnlxUWFDM3BHb0xPTkdELy9JMDcyQS9k?=
 =?utf-8?B?QWZ0T0JKTjNHZW0zUmlpT2Vydm9SajViVkhQY3JjVGt5SGg5R1hPNE9jWlRD?=
 =?utf-8?B?WEZZS2ZhNWZnMHdsUXlkN0IvcFh6R2F1NnZWMGVqa3B0KzMyUWYzYkdpMXk2?=
 =?utf-8?B?ajRWWXlxUFhIem8wcnRHVHF2bnhGbUVGc1o1UVUvTGFqRHNlQ0xRRnpqUzdO?=
 =?utf-8?B?cEdXTUFHYTc5aEdPU1A5d2hpS0dxN3FBSXVlK2IzME1TNmdXbXh2Nm1JMFJ5?=
 =?utf-8?B?aXRHaDJFYm5aU21DUjQwL01BZmdUNXJCSU9HUFZxbDcyRi92eGM1L005WFMx?=
 =?utf-8?B?dC8ySjhYQ2hJaDNqLyt4MERLVnl1bW50cWhTZEJReFJHYTlyNEd1K2V3b2wy?=
 =?utf-8?B?aEtoNnY1ZnQ2cXZ2RDA2ZEdXQUxXV0JjcFgrMGJQSUZEQjdjWlVvRGN6WCtv?=
 =?utf-8?B?dW9LU1lIOTY3NDVWOUUrSlVPd1NJTXhid2tHa041OHF4OFJzM1hrOUJLc05U?=
 =?utf-8?B?SmRMN3dKVjdlTVZKQjB4eHN1OEY1cGVrcjVLUGNEUk5QOXZORUZmWWpXQUww?=
 =?utf-8?B?RlJRWkdSWGcvMWxoblJORU5PSTl0OUxGQjUwQmdmQkhncnpFak9sTVgwTkJs?=
 =?utf-8?B?cGJsMmpnV2plOFVaRXF2Q0FTWlNqUFBWV1Nlb0F1WjJjSHRjaWhsNWNUNVVi?=
 =?utf-8?B?RVgvMEkvU3BoeVNvcis2ckE5RDBxYzQ2Nno0YkFTZ0RDUzNHSFNjT3Z1TGxw?=
 =?utf-8?B?SnpoOUZlbmN6Y3ZRaEQxOC9tWlRqdmFuS3I1U3BmMzlvTURNemRHcDFSMi9a?=
 =?utf-8?B?RXdiU3gyT3BzRDkyNUs5dFpCMmdqRXFmWGRlMUQyZEptZ0F1djBoK0V0UzVq?=
 =?utf-8?B?dTBrVzEwT2d5Y2hyQi9zcnBmRGE3S1pYa2M3T3hCTkN6b2FnVnZkelcwMkNl?=
 =?utf-8?B?UktsdGo5QXRtcFJDRTY0ZXIveXlMa2tPdUU1TzR3RDJ5MEI3MFBCWVQxY0dl?=
 =?utf-8?B?bFkwZzJjQ3NoYVhrSzJIUzhOOUNhSzFLVzhncDNIQ3l5eDVwYnFMNmZET1ZW?=
 =?utf-8?B?OEVTbVdDQXl4NXpnbE1DVksxUmJCeW1COTgwWWRGUGFqTjBNRHZxeGoxUGt4?=
 =?utf-8?B?SGl2WDBQYkJQQmljSytYVnV5Z2dZZXc0bmVhVzhLeC9CYzZKLy95eE1tdWxz?=
 =?utf-8?B?bnBTaUxEUnlQODB1YjZoV0RqTXd2TkRPU3psZGhkYjBZM1Y0ZzJUMlNuOWlh?=
 =?utf-8?B?bEJBaFNWRkhhYk5qYWMvcFVPSHdUc1E0VmlJZWhCVlpRbWhGUDBjUnFWWUpH?=
 =?utf-8?B?TWR4Y25JeVdYQTEyYk9TZ0RoNFJSSElINVpnVWxUR25nV0lxZDdWai9aUEFi?=
 =?utf-8?B?a2dIUE9mb0tMVjVQdU1jM2FIWGxaeGtmTUJ6NlVkcFdYWDJOWnJSbVlzc1da?=
 =?utf-8?B?NVhvdHNYU2tUUUdFRk00WDJ3Wk9xcnN2TitZR0JidWdsWUxMVSsrTHZYdTl1?=
 =?utf-8?B?QXY1Rmd5Wlc0MjVPTmRJNE5mRG5yWHhvaVpjNjBjT3NRSXZlVFMxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3caee3-2e12-4ce2-0e1a-08de73b65c5f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 15:07:00.6765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w60kcrRAf6Hx5hfp0ff6hMdkh+erElmFRahLuGYCaG/B8AEVTRDwN8KDoPyyPjekOrGVv6ZpoVPd9pwZ2Ko34A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7163
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-217921-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario.limonciello@amd.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sheffield.ac.uk:email,amd.com:mid,amd.com:dkim,amd.com:email]
X-Rspamd-Queue-Id: 5AA70188D72
X-Rspamd-Action: no action



On 2/23/2026 10:32 AM, Mario Limonciello wrote:
> Some systems have much larger amounts of enumeration attributes
> than have been previously encountered. This can lead to page allocation
> failures when using kcalloc().  Switch over to using kvcalloc() to
> allow larger allocations.
> 
> Fixes: 6b2770bfd6f92 ("platform/x86: hp-bioscfg: enum-attributes")
> Cc: stable@vger.kernel.org
> Reported-by: Paul Kerry <p.kerry@sheffield.ac.uk>
> Closes: https://bugs.debian.org/1127612
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Add a tag for Paul's test 
(https://lore.kernel.org/platform-driver-x86/b2535142-aaff-4eb0-87bd-34c9f8f16f07@sheffield.ac.uk/T/#m5ae303266e0685309c19c67d2e320a6d42579cd5)

Tested-by: Paul Kerry <p.kerry@sheffield.ac.uk>

> ---
>   drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
> index 470b9f44ed7aa..af24313d078db 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
> @@ -94,8 +94,11 @@ int hp_alloc_enumeration_data(void)
>   	bioscfg_drv.enumeration_instances_count =
>   		hp_get_instance_count(HP_WMI_BIOS_ENUMERATION_GUID);
>   
> -	bioscfg_drv.enumeration_data = kzalloc_objs(*bioscfg_drv.enumeration_data,
> -						    bioscfg_drv.enumeration_instances_count);
> +	if (!bioscfg_drv.enumeration_instances_count)
> +		return -EINVAL;
> +	bioscfg_drv.enumeration_data = kvcalloc(bioscfg_drv.enumeration_instances_count,
> +						sizeof(*bioscfg_drv.enumeration_data), GFP_KERNEL);
> +
>   	if (!bioscfg_drv.enumeration_data) {
>   		bioscfg_drv.enumeration_instances_count = 0;
>   		return -ENOMEM;


