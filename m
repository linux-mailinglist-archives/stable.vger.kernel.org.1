Return-Path: <stable+bounces-214356-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8+x+Lsamg2mhrwMAu9opvQ
	(envelope-from <stable+bounces-214356-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 21:06:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19040EC5AA
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 21:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77C66300A8E7
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 20:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B9838B7B9;
	Wed,  4 Feb 2026 20:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LSoKmuA0"
X-Original-To: stable@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C9F2DB79D
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 20:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770235585; cv=fail; b=IpQpPD/ev1i4uWi6t9s8f+tKfjnHr1/knQeuuofVb20laFwfEfWxTrvVfU+7HTGgab3wRpXUqsFiIkNV8OHJqfpjTC44USi58itiRbxWBfi5Nis/ukpMnw5s2pq9YExTJfVstmSg/iaiVVRmi323uTBZTbSqUkhTFKFilhQ0ebA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770235585; c=relaxed/simple;
	bh=N8GCEyn5DPEcD+e0tqd4DVIVzw3drTN9UyZbqvTx4bo=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=F2yfWUYoQLP9UwDVkkxyx6S3d2V7ogeVuF5Z0paow01g2Ei4QdDAD0IB36lLTvky4v6qBbfuI+1ploCt/At07IG/qbDyIA9fmfZCbCsKjxubdhZxPi9raaTBS4gFwSmb4rzSyqS0wux1I+490W/uasS9uW58mk0ezPdTUiXLTYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LSoKmuA0; arc=fail smtp.client-ip=52.101.61.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZX8BAnxdozTfWsm0X3diHU3HSs7r0cAqJjQ8Pm2PP5RFvPWlp6HEZqYEwN4+J8iCkmtRrBVy00oASLKBBfntJ9TH4ajhe6GOJb6x+zAley6iMRDINaGA+TF+mfXpdB32myDrRKU//fK+CT7rME5Ui5TE9QAr9wm4WwjVV45nkInFlYLFeJF1DFBnCyhDpGCXEKxFjLgmwk7RqMhV8i0NOZV5eh85pVFOOQ22aLN3g+76U/BFSq/dKnuRiijdSKr/1abkstDJHGGwJp5zL07Iw6GcRJViA7TY+TomQyHrEnHbsvyPZDxUs/1gguD+aRhPTmTpFwEBUpFawo2SboTgBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEo5L2laNdk6ilUn/7X2silOGafd8neuu/HIAFsOVZM=;
 b=rxX9xv4bvlc7JNl0ssw60OIGm84hINyjbAp0eeOLxyx5rSZJI6s3RfM0Yc4UwC3hL/AC+Y6b4qUFsK1SmvcVVncu9OH3Uy0O2+f09jAlCJpW/wPl6ngOX2At4TUJnEC8V4xwE//Gscg+SZiLWvrI1oWdl6P9Myu7U4Fn94fm8DfJTwpjDRfmtCLhjvrEv0r4THd6OSlK9XrwebfOsu+QIL0enymr0xNvJg223kQgT21pmf62piFqxPHmszr7NkGG3gmfryHkfY3KAH5f8yyhrP7YJ+dmhS2jDIuK4A6+M7nUxMcFEkB7xp9xIoQQf1z5Fj4DmzBQKzqpjfba3kuXNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEo5L2laNdk6ilUn/7X2silOGafd8neuu/HIAFsOVZM=;
 b=LSoKmuA0AVIE7inL27sRA9jFO1L/YA159SWdxlR9lGTYlrp3uU3cqo3dhXDHZqe+OL7iotEMs2PyaoTP8+Lm4aHixUEWkQ2Mz9j2OAAZTbwYd2HGowpKrAGOAwM3TNrgA8yxInRqtUboEmACPQL6jv/c8ZsXPhnKnA/D9JWmJNI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 20:06:23 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::94eb:4bdb:4466:27ce]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::94eb:4bdb:4466:27ce%4]) with mapi id 15.20.9587.013; Wed, 4 Feb 2026
 20:06:22 +0000
Message-ID: <48e48a86-f88a-49e3-a9a0-29f8f43175cf@amd.com>
Date: Wed, 4 Feb 2026 14:06:15 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: "Kovacs, Alexander" <Alexander.Kovacs@amd.com>,
 "Pananchikkal, Renjith" <Renjith.Pananchikkal@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: [6.18.y] Fixes for USB4/NVME hotplugging
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0109.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: f00c21ee-101d-4fd1-7605-08de6428de6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M05WZE9YMFQ0UFk5Z3cwNHNaVTdaNWFoM0YrSTh1Tk5tRE1xNmNNQWczV2VP?=
 =?utf-8?B?L2l4UlFtYTViMHRDTjVmZXNwcHdDVDRIdFJiTm1ZUHpnaHBPYnZOaFl4ZVRI?=
 =?utf-8?B?VS9BMnErdW8rN0E3UU1SeGRjOFg1aTRDbjdhVkMwei9vbGtWa0I0L1E1RndF?=
 =?utf-8?B?VHFtTUdaL2V4OHdsV2JWNUJqOG5JOG83Tm56M05tMldVVFRhOG5iRHdrV096?=
 =?utf-8?B?OElBMlM4dXpFdUFEV0dUS0lnUGgyY283dEMyS3h3bzdGZW04WTdyL0pDQmdZ?=
 =?utf-8?B?aEN0NXFOZUhpQW5YdHAxRFR3OFE1d1BWaHhvaUpMOVJFWEVRbnlDcmpEUllG?=
 =?utf-8?B?VVB5aUYzTGJNNHh6anIvMmpPU1RYUkt3cHgvN3UrbnJXdW1CaGlaTUZ6amFG?=
 =?utf-8?B?Zk9SQmNSZzZYZWhYU2ZqQUZMby9MOUs4MkJYeEwwSzU5MXc4MklmTThibFQw?=
 =?utf-8?B?cVJZMm5iWVlYcEJqNk9PUEI3bkVCOWRWY1hlWHdEdjVSKzI0NjVlUi9tUm1u?=
 =?utf-8?B?aTUzMFNnaXpDaG82NGt3Qlc3dnhKdk1DNDJJclVtdGN6Zk4vaTRoSG9QMUNJ?=
 =?utf-8?B?VmpOb05ES0hpNWs3TlBhMnViemhkVmVpSzFzMTZEeG9jOW1IVkxwSy9CZVdN?=
 =?utf-8?B?TFdjcEFpSURZdWZMeUgxcTdULzJpbkJKVmtWcm02ZlJrSjRPSzU2NU9Ib1NY?=
 =?utf-8?B?bW1abnNEYmpyMmFyenMraXZEclpzZ1cyU2tsUmpqbWJ2ejJQaDEyRkI1Z3pw?=
 =?utf-8?B?TlprTWdxMXNHOWJtMGpzT1o0VTdTTGM4ZzNtTzJ2Q05ZTzlsdWlJM1VBRGRL?=
 =?utf-8?B?bHVwekx6b3dxQ3NBcWV4aFJ2cHhtVHRkM2E5ZDN4WHQyUDg1Tk5UL25EbUpo?=
 =?utf-8?B?WE9LS2lnaldsY0s1YkpTWkdPUEdKbE9mSUNhdjZBQ1c4dlptYVhDYm5jWGxo?=
 =?utf-8?B?Mjd6RDRvNkFQM2pJbTlmaURlV3RheDFOczBkR09FdDh1RzJTLys2UVRjZW9M?=
 =?utf-8?B?ZXdjVnJRYzM2MVFMRHduT291Wnl1VGRhTFhONVNZQWlZZ01rbkI2S1hzZlFV?=
 =?utf-8?B?L05ibTVCSnV4S1RRejdvL3RxQ2FuV0JEUEdPZ1IyejlybUNTSzM2ZXFvcFJp?=
 =?utf-8?B?Y1NsRXBOMmhpc1paTWNSbndwOENPaFViS0dESDFpY3U1dG5tM3FCT2dZTGgx?=
 =?utf-8?B?RXRLaUZlc2lSKzExQ2p4bGVuTjNGc1NzNm1FVVlzU2ZtSERydWk1TjZQM1dw?=
 =?utf-8?B?d2c4TVNGTnA0MkRoeW1jNHd3Qkx2a1lvbEswdTJIakZwZ21lb0lBRjR6RjFz?=
 =?utf-8?B?Wld6NE1yOXVJVC9abVNqWjAwRExydVN6QjljeGdWazRsNzR6a3JOZTJTbWdv?=
 =?utf-8?B?ZlF6N0kvRHZIRng4UGtrRVBGZmc0cEZmWi9zNHBkcEF2b2pWM05VV1dLYlBM?=
 =?utf-8?B?ODR2a3BsUFUxdW1wUmxpUkhFb2RUV1hwaXBjVGkxT3NRbU95a2twNEFqSDVT?=
 =?utf-8?B?RzZtY2lyYzJWSEJobGNNcW5DTEVPN2JRRDJac1Aza3haUG1EL3dNSDlKdmps?=
 =?utf-8?B?M0l6d3lSb0lwdVhWbWhDdER5Z1I0dzhiMVpOcktuZStETG1zeE56Vk9FSXBF?=
 =?utf-8?B?OWg4M1FOL0k3OFRJcWQyUVhJczBKblhnd2xDT2RKK0hyUHk4Q1Y0R1ZNcDk4?=
 =?utf-8?B?RVdld2lkY254UXppSTFZcmJvdlpnVS9iU1VsMWRpV3U0YjBoNHh6VVNxc3cv?=
 =?utf-8?B?a1F4R3cwQUlNRnlsT1N0VitObUloVlF4L0tZVmVobld2enlaYlhuem9yeG9S?=
 =?utf-8?B?SVNIazl6MGFPU0hjL2xDK3NmMEJRcVlRRVNUKzJDVjBxZ285dVIvNjBFazVE?=
 =?utf-8?B?MFdzL0xXMEJTZW5IWUduSFZydDYzT2JSVzFwbUFzYUVPRHFWaUZQaHdTMnpq?=
 =?utf-8?B?d0FBMHh0ektSeVVWVkpXV1RkaW5yZmRHWWNYaXIyYmtuOEZTOXNENjREaWht?=
 =?utf-8?B?OUFEMU5OWXRWbDZHTFBDb1BLeUZydVRhUDZXcDdNeHlsRmpDSlhLZlhpZFhM?=
 =?utf-8?B?NnR2WThiQit4UGxtdmFaM1Fwc0VJenJkWEZkQjFPdzlHV2RyRGRERHd5NjA2?=
 =?utf-8?Q?imAE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aE1yVWNaOHl3Nm1VVGxyblZkVWZFY2tRYTJ5bkZBWTRZWFB2TTl4S2NhNS9Q?=
 =?utf-8?B?bFNudzUrS2dxallXclVYaXpEcGlVRjRQbG11RFI4QUdCYWJCZjdRdGxMY1d3?=
 =?utf-8?B?c0RWcVhIVmlLWVZTZzJOMFZOSDNRZVpJdUFleGJweUJVNWF4TTdVaXhuU1Vr?=
 =?utf-8?B?WUhLMmp4YWx6bk41ODdUOUhJUkxMNFVlQ1RtTVEyRUJVL3NRK2wyR0lZVC9p?=
 =?utf-8?B?eHp2RXYwUXZ0clNaTVFaczBmK1FxVUxXT2F3NmNCbFUzenNDZnd6QW91TkFW?=
 =?utf-8?B?dy9XclJIRXNEZ0hlYmpUUVo2T2ZYdFcwN2lCT2lFeFVtMmxteWsxaXBiTk9Y?=
 =?utf-8?B?anhNeERqV2plSm1mZ1crS3dIV0ZEcnBzaCtaVFFLR0JUZ0gzTmx1ODhWc3JB?=
 =?utf-8?B?aVNvdU5zdjVEV0VGZ0FsODg3SnJ2MzJmTnNoeVBjT1pvVndlUytzK0RtaFl5?=
 =?utf-8?B?SHhNejdwRmc3MDIvQnEyY0t5dHV2Ty9ETG9CQWJPVVpEM1JvcTBTa05Nazg0?=
 =?utf-8?B?V1VsU3JXNy9nVEQvWGZVb0lQY1V2ZDZhM3BzR3M0ZWF0SGRFLzBkSHZkN0xJ?=
 =?utf-8?B?ZnU3WFNyRTRaM1RuOHg3NlNuUmw1UzdnbjBtcFlYQ0Y3YkVpMERadzBURktH?=
 =?utf-8?B?WktBeE9YaGc4UUtyUzdCSU9NanI3RGp2OEZjMEQzdGhJQkdkY3J5UE1EVlR5?=
 =?utf-8?B?Q0s0NStHamJjRnR3V3JVZ1FMNy9UL0Q4TVFQMzVrWTRWK1p5M2w2MDRCSzJy?=
 =?utf-8?B?VlFKanppamV4YlQwM1czeGhTOVdzcm9hUmhVaDk1KzlMZS9kWlBtV1hUbmZC?=
 =?utf-8?B?Zy9ZMTBDYldmUjVmSHU0YnpnVWgrZnFsdGIrNzFSZ1NPTUhqdnNIZ0JKdUgx?=
 =?utf-8?B?KytjdGc0MFhZVE53dzhRalY2SUVNWlI5cWlQcGdhMWhBcXpaMWUxZ1hYZ05i?=
 =?utf-8?B?ek1uSlRHVEwwQVlrZkdJdmxkbVlWeHNvNTNzVjZ1STIxbDFBZnlmUE81dzRL?=
 =?utf-8?B?N3JTSGVmWVMyT201TGF5cFhBQXJ0SXBWUHpyZ1Erd2cxaEVnaEZlbzNqSlpO?=
 =?utf-8?B?eGRZdU5pMEErdzRjTEJMRjcwemJRc1c4MVY3OEFXK0ppYm04UGRoWk13Uks5?=
 =?utf-8?B?SklsV3FleDl2UmM2Z1RyQ3pqczgrUkdwMDFNeEVoSHFlVituNGtMbWJuQVQ3?=
 =?utf-8?B?alVtcjkwaGFLNUtDaTJFM05mS3l1dTVhTEp3VGhrUmZTS0ZIM3A4R3VVL1kv?=
 =?utf-8?B?Y0dtYXQxb1F6ZkkxRGo1MmRZUUxYdjdyTUpYaWNwMFh0aHBQRER4N3dBN24x?=
 =?utf-8?B?c1lNR2FEOXh6eGxpQVphU3RsclZtanB1RXZzRVlXYmdmOXpvVG1rY1RLNStQ?=
 =?utf-8?B?VlJCcnMvZFZXN1dvQ083T0dxODF1UFFyM3l6cUlDckVUTC9WenQ0WWxNSmln?=
 =?utf-8?B?RGZSU1p5ZUlTRGdDcnJFbm9PZm5pVUo2R1dwVXhFcnBrL1lJVk5HSFVqN09H?=
 =?utf-8?B?VTg0TXZ6ZFpRdDd0UXhzOEU3ejQrRGFWMG9mYzNzdi94WVh4TEN3Znp3SlpS?=
 =?utf-8?B?RkVwNDNpWlh0WmgrMUg0QmY1eTA3SGdUNDNrUXd6SU5xczBGMzk4Y2JNL3Qz?=
 =?utf-8?B?bVVRQnJva09TcGU2R213aUR0OUd2WDFFZ0w3L0k4dndjdlBpZmZ5NzBEZmdG?=
 =?utf-8?B?ZGxsNjNGUjBDbFhuYlptaEE5QStiYnNsN3p1bmJCYjIzOGlra3VoeUVLemJD?=
 =?utf-8?B?d0tkREd6WEhqOWl3V1hnRFpjcDVxcVhrUXowcjlhN0ZGMHpaWFNoeWxNbmhE?=
 =?utf-8?B?VmxBUGwwbUpLZVNLM2NaZDZZR0o1T2pRVEdYSnlESkRwM2V6emlLckVFMitE?=
 =?utf-8?B?dUU5aTB3dzY2Q2p1NWt2YUFsZjF4dFJaT2p2aTA2ajQzYkMzM25pRVdNS1FR?=
 =?utf-8?B?TVNCQVJRRG1vbW83QkE0bGRJb1g0WUlwQ1liWXdZVHl1U3JNQUlSU0I2RW84?=
 =?utf-8?B?cEJ0Mk8vcHFsNnpQNUpOMUVVWm9xeEp5dEFjZDUveTduUDZJZyttbVg0UEZB?=
 =?utf-8?B?TTlrUFBhbGh4OHJTam5jc29OdGxMdm03MDhCS0I0Z1FFeVpWVm1HM3VPTDVF?=
 =?utf-8?B?OFVrNFFNald4d25nd2RNdGVXUVhtcFhuTnhnYXdhSUJHeW5GcjVWdnJiOXhI?=
 =?utf-8?B?Ny9FYnRjK0RDQlkwTW96dTdvK0ppa3RhOUlZQmhMcURpODlvZFI3K3c4Q2tO?=
 =?utf-8?B?ZjV4ZlcyQys1dmJUdXM0VnVjL0dIdmJiblNoSkpyZEN2RHg5eEN3NHVTT0Rk?=
 =?utf-8?B?SFdJb1k3S3I3K1cxOFg0MW15V3dtdTljWWxYdkFZYjNyQlpkaUpzZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00c21ee-101d-4fd1-7605-08de6428de6b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 20:06:22.8109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBrVBYrwCk3n/nNRKwsuYYSBMm/pW4gF4yD0VFfKgE8wkg7V30z0fZ1fVq0MPfAdqZFvnYXjUYJe3BwwbwSp8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8615
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-214356-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario.limonciello@amd.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 19040EC5AA
X-Rspamd-Action: no action

Hi,

Some of my colleagues (on CC) have been chasing an issue where some 
percentage of the time USB4 NVME enclosures weren't working properly on 
hotplug.  They narrowed down the PCIe traces and found that it was 
caused by a race condition between multiple drivers shortly after link 
training.

This issue traces back a while, they reproduced it as far back as 6.14, 
but that's mostly because the hardware it was first reproduced on had 
graphics enabled in 6.14.  Given the root cause, I strongly hardware 
enabled with earlier kernels would also reproduce it.  Nonetheless the 
issue has actually already been fixed though by a series that went into 
6.19.

commit a2f1e22390ac ("PCI/ERR: Ensure error recoverability at all times")
commit 383d89699c50 ("treewide: Drop pci_save_state() after 
pci_restore_state()")

Can we bring this back to 6.18.y too?

If any questions about the methodology or details, they can add more.

Thanks,

