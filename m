Return-Path: <stable+bounces-201007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D407CBD098
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 09:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A5EA93014AA7
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 08:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8540E313E19;
	Mon, 15 Dec 2025 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="iq9JQ5S8"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013049.outbound.protection.outlook.com [40.107.162.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637B72ECEBB
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765788792; cv=fail; b=INcroeuTlEruZoquK+qXCQcF1NrIQQc7yezEaGSdoYDFoA8dt2pRif3GT2/YY+f9dqR3E7Pp3b1m+HmoY5hFNZZL6ma3oZVkPI4uvHwT1s3oAymEnr+BcWbnxW4V93GqNwJ6/eSr0YulEfuAzq9dhHrTslVMZS8ZJH1zuiLBrMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765788792; c=relaxed/simple;
	bh=RbWCrDvI5YyZz76QpDFJsOw8NGFVaUYKwdc6fw110U4=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=MR1sGddgY1PLFB7erlA2/CLPtm9/o9twNDaY+TCltzn7K1HykAMty1YmbmbsiOVy0MlyvpFJ3D86CzmGYXOEqWV05Bvazy2jnlR7wE8CN5Xxrg2tMaKbN6xtCcFutFjDO5dqeZQcT1w/3c0glvn0buVvjxdWKw61ult9XrqRwpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=iq9JQ5S8; arc=fail smtp.client-ip=40.107.162.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEVm1RgKQUYZCbcDRMGGkNj/thc+N/gGzSU+YLgWol+ZDKbDZ/XL6YHQSXJJ9iC7/+8+FggnDSKXmwYCkeKnR3lS3YMWCsAGofQ/RmxUXndPg22GX09y3RVRa9UGPIclHiKsKSNRx09nXOMYZE+LPFTCtji4yp11UfzirypmFC7pibFnmXVoEGmdIw/dtY9aNIiSgvMDbcr4FWQUhOxUwyFJ8/gBoa7cmeukj/tqeHtoTdjKDlzK83OvE21OKrzkppeAM3jZhsD+gzCUDDL+vG8jGbrt0JO60y8xnAVJF/xGor/QzvLYbyiyTjzvbpKTdecQVzQUHuDdyWnYivW5nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkWLfMtwLusQjS52IxRa0kBVtGfuP/ErIAMpbpWnVlg=;
 b=L3SNlFvFRW9OBjpzEETFYP8Est1v4eIIiOhNRtf9K8gKHJVWY3F7Tm+E2xvP9/VwtXM70jGF1U06DvxB12DJDXnqgc4M8/kFmiOwY7vvPPsd8Gp/Ld58eIU0iw6ud1N2Dd5qoG8CRD1Y6bZ4E0T3d3hUCzFx6V8vHpqHOGl22aaU+snuQtlmwd8Bt9fDOrGrS6tCEQnfRkJAUraBv8myI3YaT6CGYbW4hxcydH4GnDfsCGMV71dIot80efWjoQ4kQ3wBkUANDF3V2BVisyprBthVvJPb3iaOA7gHXx8CDFiBhJQi1br1+0Iw3w1RpqXvR0Y7Q0ofFnJ6dC1qBeY+gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkWLfMtwLusQjS52IxRa0kBVtGfuP/ErIAMpbpWnVlg=;
 b=iq9JQ5S8hJv28v6NRejvAFGSLEgqgkDGdNSa6wClpfa19/hlI8zpY95n4ycgNocIsauKvkCk4KOztWd+f/t1h2A9DOyC+ZS7NPm50BVgaGltTkC7sPkxqXeN26VZhdvUPIWs45zdDPG4mQ43qQlUotWfPSJ/SyoPGI+iWJT/DVCTeVrJOA2sr4OdSX4dDbFSfKrAkjwfKFlsfo8vmcbaSnqM4CxlU5zOqS3Sq1T0gRrkFIV8yNYAxvKOiKtz6nWIMb59Zo3fc03kXCrAtXDD+wJTmUGd5F29iH1aD5i1Ae9v8+gWlwo69syfbiW8IXIlr3vpUFMJsEM2CnSq2kh9Kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:f3::19)
 by AS8P189MB1301.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:28a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 08:53:04 +0000
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::bc3e:2aee:25eb:1a0b]) by BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::bc3e:2aee:25eb:1a0b%3]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 08:53:04 +0000
From: =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>
Subject: [PATCH 6.6.y 0/2] Backport for CVE-2025-22121
Date: Mon, 15 Dec 2025 09:52:55 +0100
Message-Id: <20251215-cve-2025-22121-v1-0-283f77b33397@est.tech>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGfMP2kC/x3MQQ5AMBBA0avIrI10RkriKmKhNWU2SJsIEXdXl
 m/x/w1JokqCrrghyqFJtzWDygL8Mq6zoE7ZwIYtMTH6Q/ADchahr42xbSDnvIMc7VGCnv+wh6Z
 qqguG53kBgZdDxmcAAAA=
X-Change-ID: 20251212-cve-2025-22121-c30057f1bbcb
To: stable@vger.kernel.org
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, 
 James Simmons <uja.ornl@gmail.com>, Ye Bin <yebin10@huawei.com>, 
 =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>, 
 Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765788781; l=526;
 i=david.nystrom@est.tech; s=20251215; h=from:subject:message-id;
 bh=RbWCrDvI5YyZz76QpDFJsOw8NGFVaUYKwdc6fw110U4=;
 b=ykw+0fGGWkLeJ+TczYgEJkPS/0qMtNr6tGmU5mGvlA1BAmhA+/vQ2Kko9zjw7ISE8+dvMp/uD
 7UbD8DuebYlAiwvTBS3yxBE0/9dDvJ7O4GBsfLlHQlE4LTuS4/4u/Gh
X-Developer-Key: i=david.nystrom@est.tech; a=ed25519;
 pk=4E3iRjA+3w+a4ykfCHDoL5z4ONs9OcY4IN3pTwIG7Bs=
X-ClientProxiedBy: LO4P123CA0052.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::21) To BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:b10:f3::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP189MB3241:EE_|AS8P189MB1301:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a9cb55-5806-4a28-4d6f-08de3bb75c1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXdqK3lBdElpNFBESW9TanFqWGFpWFJINVVaQmVhc3V1OG92S2JuWVRiZ1Nz?=
 =?utf-8?B?YmNiazRGNFJ1NmdiVTlEeVU1bDlkUTNMSERkMmZ3aU04Mi8wQUpXdzlid1pR?=
 =?utf-8?B?bjRtNmQ2eTFldS9QZlBicHJKTC9FQSswMEhvWkx3TjN5RFZOSDcra2xIc2Q0?=
 =?utf-8?B?OCthaGJtQTRFaDA4cXZ3ME9EL01Gdm5lRVlZRi9NN0xWcGR2Tm1oRlhXSmMv?=
 =?utf-8?B?dUpJQUZrLzFNQWVrVzBPL29MS3pMb285WlZkZ2pEUjlkZExCN3pSNEh1bXJ5?=
 =?utf-8?B?Yzd5MnNGOHRGZGhIOUtndUJJTUZCZkN0OWpUQ014aHVhREQwc1YrZ3RhbG1q?=
 =?utf-8?B?eEVWOUZFbjltT1ZmVFkyTDlTWmZubG1FaGY4UnhscTBGU205Y1FrbEFBY1RW?=
 =?utf-8?B?NlVyc2lpUE1CK3I2QlhyMStYNWs0ZzhCT01VR0R4YlBDcDk3cjVpSVYybFE1?=
 =?utf-8?B?RW8yMW0xZ0ViZXZ3NE9wSFlkYXg5dG5hMVJ2T3hwRHdkRXFDMElwNFlIQlRo?=
 =?utf-8?B?Q0dGMTc4QzNvZW1hdzZxZlFqK1VFc3Vsd2ZrNkJWTFFmZVhpOVhRZTlrb2Zt?=
 =?utf-8?B?TTM2d0xabWpkY3g0ZERZc2JnV3dMR2xOd05OMHU2THFxL3hWSG1CdGFZcHNx?=
 =?utf-8?B?MGpYYzNmQVdpYnpuSEQrY1N3OWt5MzVmTFpWL1ZWYU9KVFN6TFNEbVpVT1dm?=
 =?utf-8?B?cXlnNlNwUW9uZ1pEYnRlUGR4Z3ZPNzJNRUd5WkJESEd6aWdqdmJNdkllVktO?=
 =?utf-8?B?b3NpNUdYVWdZUWVtbDVITmJVaHA0NzhlVENFQ05MazRhMGpYQUlHRUMydklx?=
 =?utf-8?B?VVZiMzJIV3d3alM0VEdOenpTQWNmMEY3VUwvU3BnU0ZnbE9NR1M2blVVYUlt?=
 =?utf-8?B?VXhPWjFVa2V2SU5hK003NFN2WUI2bCtEdEtCZkNzeXJLNVZKeG9zTVNjVHNs?=
 =?utf-8?B?WVpxMUJYZlFhdDAwREEzakFyVGdJQ0ZENk4rWVRjL1lST0ViaTBJYnAxYjh6?=
 =?utf-8?B?eTZGdTV5cGpoOFZsVVkwK01NVEZHaENXWklPdW42b256ME1HckptWUQzTDVE?=
 =?utf-8?B?Q0Z2dFdSWS8yeE1GOG1CcDlDMzZOL0xMUXRXQ2pTVW5qZnNwbm96RDRvc1VH?=
 =?utf-8?B?NFRtTEtVdkFJUjBmczhFNFBqTDlaTnVidFpnUlRFNjI0OStaM2pEWWIvQkNF?=
 =?utf-8?B?R1FXMDVaWUlLOGl0QXc4MEw5WlF2NGtncFV4NVYzSnJ1YVo3Snp1T2ltODhW?=
 =?utf-8?B?S2twSVRRWW42QlpXZmpOTElkUC8weCtQeEdCczF6R0ZVUUZyckljdTRnclRF?=
 =?utf-8?B?eUI4VnZwMUJVR1AyZ0Rkcld5bUFXT3BhT2ZNK015YTE2WC9laklrVTlGbkZO?=
 =?utf-8?B?VDR0ZFlRTkgybTdqTlkxY3FTRFZqZ0ppZ0tFSzRObkRnWFE4dFVyVjZDaXpJ?=
 =?utf-8?B?QlRCaUZPakkxQTZCOTZpby9HTEphSm42TjhNOXN6dDhJUTZPMVFjdUVVbUJF?=
 =?utf-8?B?dEdBM1lxaEhxbEVBZFJUVHZtTDhySXFGTkpDQzIrUk5FV2szRTJPZUNydDht?=
 =?utf-8?B?NU90RHYrTzRQdVpFUGY4R0FGOFhta3pwcFZqdDB3MVBKWnlGcEkxWXVnYVVo?=
 =?utf-8?B?eGhWTHNhcmlKTU1xRGoyL1dmaFFTdkhTYVNvRGZ2NjV4M0hUSUJYQzQxcnl4?=
 =?utf-8?B?L3dWSDBLRUdzUk1iUE5jVEZnVlgvK2Y1ZFNhdmlQbXV4M2NLWTMvb1YyMDFD?=
 =?utf-8?B?NEE0VStiVXh3VGFzcU9Wa0E2amZ5Tlh1WThYcVBhV055bFZoRFp1YTFxT2tx?=
 =?utf-8?B?bXpFYkFkQ0xKUGE1eWl3NEM4UzZFRVN1TDV2VldiNFl6SUdYN0F3SDZWa3VZ?=
 =?utf-8?B?L3V1VWZEdGVYUVZ1cXZUb2VGaUJETWl0akx1U3VKVXFJcUpCMnBneTUrdkli?=
 =?utf-8?Q?MrYpHZO7freiQewnvBQqwKF0qoSNajKF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESP189MB3241.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2JMNWpoU2YrWE41Z1BCZVNQcFUwNjU5dHBaMC9FcW9JOVpncmZLSnJCRVJL?=
 =?utf-8?B?bFUrMjlqTjFvQWJvclRiMkpZRnpWZDRyaG1YenRGN1ZzQmxwS0ZKTUdwNHdZ?=
 =?utf-8?B?Vm03QVFSeHFEbCtoRUhXUWYrWGJPTzc0ekVvWE1zMDhRTjBpWThOMm45Tm96?=
 =?utf-8?B?WCtTY0xwUWVnVDB5dFRaYmQxSEpGTjBSRE1SeWFIUGxRazBEQ0c3TDhkTXZr?=
 =?utf-8?B?UFdrUHpTaEpEbTg5bnBPWk53TkZlMU91ckxUbUdDU1gwOTU0Ylcxa2ZuVXRv?=
 =?utf-8?B?R2tvK1NYVmV3RkxzSXlYUGN1RFd4cm4vbWxtU1ZDb0RMM3I2bVordmNOWjNU?=
 =?utf-8?B?MWF1cHdDY1lNQmRlY0ZuWXdjOHpLV2pyQ0pvaVlYaGI5QlFXRWFhWjJ4RWtB?=
 =?utf-8?B?emlpTDQ1eHR0bDlLVDdvRjlsc3dSMVp1VVd3RXh2MUpYdW5Ybk1aQ212VHd6?=
 =?utf-8?B?ZVMwV3NYS0dmN3ZBQ1FwZXdCN0NJOEFHT01uMERwTGdsNUJOUHlSQUpwcXlo?=
 =?utf-8?B?dHVOc1VMUUNUSzZOaVdPN3ZoeWhyYlRrSkYrcVIydVV4dXE3WS9xanRjM0NI?=
 =?utf-8?B?dmZzbDYxZXhFckl6THZVSWE3TmZpMXdhcWFpR0Z5TnVKaHpRWjBrSUQ0aFZ4?=
 =?utf-8?B?SlFPaE1Ld0lxWXZqUkJiUTVIUnlCeHRWVU8wNStGejh1bHZjaGN2WG5QTEND?=
 =?utf-8?B?bkZlWlltMGRzRHQycmpvN08zdVB0MXQrT3BpdlVRS2FDQ2s1M3d0SXFZSWx1?=
 =?utf-8?B?ZEg2dUdmS3h3TzZibWVOZXdzQVRtQTI4SFp5MXhnemhtM0N3dWc5RWtKY3Ra?=
 =?utf-8?B?SGo4RXJBeGZYNkN3RVJCYjB1WUZqTlVIeUh5QitwTnBpMk80T1Q5ZnZ2TDFF?=
 =?utf-8?B?U1V6eGRIUk5MeWN6bXBYbTlwWGhNeTYrUXpHRE1zdE8xQi9mNmdBRW15THVX?=
 =?utf-8?B?MC9UQ25aY3lKK3dFNldmSFhPKzBIREd1d3Z4VEY1NmYralREaGtDYy9la2ZO?=
 =?utf-8?B?dmxTRWxsbEwyUUlFSld3Z2JyU1FCYTBHejUvS0twenNwTXJyYzE1MXpScVdO?=
 =?utf-8?B?TW0wR2VZTFhiS3JvOWI3QmdaUXpKdWF5TTJNT2huMFhKZEgyNHB1STljZllu?=
 =?utf-8?B?VFFScU5nQkR5S2IxVUhnSUw1VjJTUXBZdWo0elBhdlgxNmdocGR0aUtxY1dz?=
 =?utf-8?B?VmJmZ1ZuVFhFSWZYRzZBeXVaNFd3TkZQVGd4SFNTNEFJNlV5RmV2bVJENENn?=
 =?utf-8?B?bmR3Slo0K3MwU1M5RS8xdWlnODBlSUdxYVpRcW5RSHpjanNobFNIV0dnSlls?=
 =?utf-8?B?NEJmZ2xhV0NoTysySVlRMlZMQTZmK0VaNzBYWE1sZUZNWmtlZm5YRkYwbCtk?=
 =?utf-8?B?VGVYTitKVFlWUzgrK0R3TWdtYlp6NzB1NCtLUC9VYjFOZmY3UEVJSGNVdmw5?=
 =?utf-8?B?ZUxiK0haRktyaHdla3owS3FLNm1oUWVBa2UvRW1ZL3RXclF1VlBTNFpGbUNF?=
 =?utf-8?B?QVhYcktWMVU3L3A0R0RsVEpwdVFvejhJNVdLSitPamoyNkJieWtrcmlrUHJ6?=
 =?utf-8?B?OTlzTmFBbmFtemFibVRwRko3OHFoL0xTdjZlT2lzQjZnaEEzWFFYQUlYQUx5?=
 =?utf-8?B?M2lSd3ZxQTJ5OTFsZC9lOUtZQ1pYbEpSUjBUaDhCV3oxVFNYSUdic0dhYnlL?=
 =?utf-8?B?YS9DeWVnUC9PNXNpc3VwbEFDVSs2eEZBb0VMVE9nK3g0UEIwRUVnWElrcStx?=
 =?utf-8?B?WnRCRWpTTlYwckVSVExsVUwvUXEwNmtMcXNzNDRHZXdwM2RxZ3l5NllpZzdr?=
 =?utf-8?B?NFlPcTB1N29nblJkTHV0QzFnc2lxTUFTZGh6MVVMaXYrOWh3S3FvMm9IaDJL?=
 =?utf-8?B?V3kyaEx1SkEvUUJNVEJBdU5HK3RoSFcyOE56bXZPZGxRN0xyMGlhc2hpQWZk?=
 =?utf-8?B?eDFGU2lIMU1JZEtQN1Jid1g5UmlVRG9uY1E4cHFWdVhuMmpaYm03ZC96TlBx?=
 =?utf-8?B?bTNJbXBUa2thK2ovK2dvZithUTNOQndCQlFrdDlDeU1DSmVtdlNkeVlGd0ZZ?=
 =?utf-8?B?eHZVN3VlQWpXYU9PLzRjUTQxMWJaRGZVcVNTa3FNSExSTmIvMWs1WTVINnAv?=
 =?utf-8?B?aHEzSTFqL1ZsV0M2bTNKRTNaYjJUNHNiTlYySXFRejdBVEE5eFovODI4S295?=
 =?utf-8?B?blE9PQ==?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a9cb55-5806-4a28-4d6f-08de3bb75c1d
X-MS-Exchange-CrossTenant-AuthSource: BESP189MB3241.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 08:53:04.4087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pgx+cr3TtG96LMnGeSbdHkIsVlJJWTNOPnsr+wsfMUwhT4efhjiHUUymKVbvq0mxmbBYfDIAVhUWWFxYDIOTyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB1301

Signed-off-by: David Nyström <david.nystrom@est.tech>
---
Ye Bin (2):
      ext4: introduce ITAIL helper
      ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()

 fs/ext4/inode.c |  5 +++++
 fs/ext4/xattr.c | 32 ++++----------------------------
 fs/ext4/xattr.h | 10 ++++++++++
 3 files changed, 19 insertions(+), 28 deletions(-)
---
base-commit: 4791134e4aebe300af2b409dc550610ef69fae3e
change-id: 20251212-cve-2025-22121-c30057f1bbcb

Best regards,
--  
David Nyström <david.nystrom@est.tech>


