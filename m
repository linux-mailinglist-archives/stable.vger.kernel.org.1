Return-Path: <stable+bounces-152644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52532AD9D38
	for <lists+stable@lfdr.de>; Sat, 14 Jun 2025 15:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BB977AA897
	for <lists+stable@lfdr.de>; Sat, 14 Jun 2025 13:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1532D1914;
	Sat, 14 Jun 2025 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="EXfgUNI6"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010037.outbound.protection.outlook.com [52.101.84.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665F1BA49;
	Sat, 14 Jun 2025 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749909309; cv=fail; b=ltEqu9kxsUfR8L+E8LgRM0fJMzjuqw2qQ4u7ViCQC7b636xiOhJNi2YlIGliw1NcwP95wJhTznf/AahSwe4rhN1fZdFpsPtX3xCl3fOSsxLD0sPBoyfW8TgoVnek5+kd0WWIzD4LUiGHEYeJZZyKy0oLm8M7EP+FJUDeY4R5zLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749909309; c=relaxed/simple;
	bh=ILmriNdvVcP/rDmvz9hM6JoGR74hURbDQ8E4HkdfOMs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mDY/rglpPmsu/PfdxphNQNJxZbI35CF7kFxnABwPS3t09u62ASfZKTbXLVf3O8gjVIxVmrGmUqB+XVA9K7xJH3Q8mHUXUCQcWHmTV2NZdVdgNHbro+ZHp98Ki3NWXVcvujTfyjes/CRToCSDf1JxVHRoW/hmLMxvcHo7qX4hVDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=EXfgUNI6; arc=fail smtp.client-ip=52.101.84.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ia7bpLFRU+JuiB6q33+oonFEvKByBT6QckkJuYDDJ+ASESpcp+SZhefvQYMz2PZdvrvuvRPgf704LOke/eyvWiVqD4QLMOGKF7aTRyM3rMNl+/KyKiaDyeY0zHf1Zhb16GS9EXOc2+NYskIFM2Pq+Qsxd1+uNsVIVOy0dZlqki6uRRERptq7ZWO302yjg00d4PyG2OfuWJP8I0ig2dFGjVIeZ5MFKQcZd/T5QNfQ+F/Qg3/Vs08xvcWVYyHSqsM7gVmieFhIZs1n22+pQDqyF7eRMy9Hd4YhEbv4QEqLD+OtpA7OWDyHyRLZY1/w19V7f0mZ/cD0tj3XLowbQF0JuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILmriNdvVcP/rDmvz9hM6JoGR74hURbDQ8E4HkdfOMs=;
 b=BZbfg4fdM8dqRTxd48D7gAEHS7Sqehru+KCkd0h8tH/KdlFPVLUapdGPvf0XBaMcKGBXGQjo5nsbNQu1tPC1ftspM6hU87pF0J7K7smabS5Bwa2KZT2i2/e/M7m/wTZuDX/xihMvFEf1JsT8B81/7MqrO+cOquLwv+9tfCIGiSJtPoqhIScVc/TnEKfWNk+/6k5g8D4/TMsZd8tE2ot5uqmYrGzWU/R7H9l/neBPtjtO0+rlz0+Hb4gseGOQzXPJai364SgPRmYdG8VhAvAZ+KeBX76L5D2e/8zaJzxTIjH5M6i/QTUbOsWb4/AtBLIziOHdI29aEjCfkDa6NZEchA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILmriNdvVcP/rDmvz9hM6JoGR74hURbDQ8E4HkdfOMs=;
 b=EXfgUNI6SD96hCM9zXibHlDyCR36KdyrTocdevytr9zptl6Ccpv0i1g9WJ7z2gN/vgPxedvHs6LhAbdv0Rr3mU6TMIpBPqbShUmLa5CKEg4y9Th7A7gaF/YE6MhaLk0hwcGQU5S7iLQR5x0s1nKnuM/VEENTi8+5XvBgLYu+eW2yvcHC0u60FY+Z6Eu8AE9zQpOihLdTQmoREfN/B2X5c7RDi3aPqZg+QusDmLGEOmPeGh8M/w9l5e8Maf0XCGdcb4eiUSFrg1aVhhEhtd0a1hL2IoBnKVkSwmtl0j3IhiegDccJwPZ3YBFqjH2yko25sLeCCxLtc9LioaKjOnIQpw==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DBAPR07MB6886.eurprd07.prod.outlook.com (2603:10a6:10:19a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Sat, 14 Jun
 2025 13:55:02 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%6]) with mapi id 15.20.8835.025; Sat, 14 Jun 2025
 13:55:02 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ij@kernel.org>, Sasha Levin
	<sashal@kernel.org>
CC: Eric Dumazet <edumazet@google.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "stable-commits@vger.kernel.org"
	<stable-commits@vger.kernel.org>, Neal Cardwell <ncardwell@google.com>,
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de
 Bruijn <willemb@google.com>
Subject: RE: Patch "tcp: reorganize tcp_in_ack_event() and
 tcp_count_delivered()" has been added to the 6.6-stable tree
Thread-Topic: Patch "tcp: reorganize tcp_in_ack_event() and
 tcp_count_delivered()" has been added to the 6.6-stable tree
Thread-Index: AQHb299qTa6TGeDl0ECSCl2ABscU27QCmqlA
Date: Sat, 14 Jun 2025 13:55:02 +0000
Message-ID:
 <PAXPR07MB7984096843D96583972BF35BA376A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250522224433.3219290-1-sashal@kernel.org>
 <CANn89i+jADLAqpg-gOyHFZiFEb0Pks46h=9d8-FiPa1_HEv3YA@mail.gmail.com>
 <aEspV8Ttk7uBM4Gx@lappy> <175e6075-a930-196d-37ce-7f2815141d07@kernel.org>
In-Reply-To: <175e6075-a930-196d-37ce-7f2815141d07@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DBAPR07MB6886:EE_
x-ms-office365-filtering-correlation-id: 64188875-f0f2-4eb8-4bf8-08ddab4b0f54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bjBvLzdyM1BFcStQdjB3TGdXZW9ZZDBlcmlGYmNTNzJzTW9ra3g1TUNKSlJL?=
 =?utf-8?B?WGt4SWFuSzhUSGE3ZE5WQTUvYy9keUdtRUxMRUFrVHNxVFhyTnA5eVdkZDBx?=
 =?utf-8?B?YnRsZjFsM3BzV3QzQjVPVXNEYnk3cG9HUzFwbXZxUURRSDhENzJURU9ubXNu?=
 =?utf-8?B?TXJWTVNWdEZrS05Lbm9Kck9kTWlzN1NMTkNWaGdhUGU3SXJYRlk3enJUVEc4?=
 =?utf-8?B?d2xTQWxMVENWaE4xZzNTa1plYzZLeWlMTlJKUmkwYmFhVUZnWEF1eVpFeVBF?=
 =?utf-8?B?NU5tM0QwVU5QM1NlT1ZMTjJMTC8zZXFkaUhjM1c4QklqUkFXRnh2SXI5ZTd4?=
 =?utf-8?B?Wnh3L0d0WEpHdVdNV0w2T2FESWtlZ2p4ZTcydXhvSnpRVlBBYmliRk11NnJx?=
 =?utf-8?B?VVRGV1liU2NqakNyeUh1cEpKMnpqbCswYjB6QnVtQ01QaVc3Q3BiUm5ZQXBR?=
 =?utf-8?B?VFlIS0RUR1gxeDRSUHY3WXQ4SWdGZDV5Vk5ETFVocEl0L3IwL2R2bHRxbklv?=
 =?utf-8?B?OVNkUHdMOEVQLyt3Q0NNUjJ1TGR5WlkwMFExKzJFWVVreVBtTDRWdXN3WkVi?=
 =?utf-8?B?SjNPZjMyN2FzNFhMVzQ2dmwxVlRRQzZqZ2ZNU2prYnhHRFkxcnhYamNYTVVU?=
 =?utf-8?B?M0JqS1l3RFhxWFl1RllnaFNxNnhDWGdFUlUzdnQwR1loMEFaSk50dTMvV0Qv?=
 =?utf-8?B?ckEzY01IMTBsUDVVM25RR0c3OXdjYWpsSmpQY0VlWW5vMUE1SFRsQ1BPT2lV?=
 =?utf-8?B?cm5wQlpoUXBVRXk0WFFRM3FzVER0WVVZeEljbnNvZ1phVFNHZ0VHTzlycVVT?=
 =?utf-8?B?SjNxZ1RPSUlqY3FlZWRWbWlkemZIelRnUEl5NjhpTkttL1l0MzAxYU1Cdjdp?=
 =?utf-8?B?YittL0ZqU0N2YWRrYXF0SU1MakVSalp0Mm5EVW1BMWw5ak9qZFhqZHVtTXl1?=
 =?utf-8?B?b2Jpd1F2VENQekY3MklpTS92MHAwNFRyOUxHUzN5Z04wWWFPQmdEQ1IrTVo1?=
 =?utf-8?B?Q0tFT0RvRkZUcS83R0xneExWK2pYRDBNaVRabVZCUVN4QWF4QTFBRFhWcFBk?=
 =?utf-8?B?QVpvU2kzUi85cjY3VWlKaXN6N09EUXBkODVKUHV1RlcxVmZheXNnek5lWERY?=
 =?utf-8?B?RTlkQ3dyVkpGRUswc2VSazlwb1dKaG5UOCs2ZVd0ajBORnFCMDVVc1pEd3da?=
 =?utf-8?B?NGl3QVQyYTl6UE5mSVVzdDBQUzZrSjdPYzY0UFdRUDl5L0xQL04wWDh1K2VC?=
 =?utf-8?B?YU5GMmRjeVJpdll2Y3YrUEU2SWZSZ05HM3dKTndWL013NXNoSFN6akJCbW0y?=
 =?utf-8?B?MlkvditjMFBTWFhRUThEOURVYW5idkVteFdZNFVsb05yZFM4S3Zhd3ZSaG9H?=
 =?utf-8?B?aXRHOG1KYUI2SlUxVGwxT1N0RkxSUnJSM2pMWVN0UHhHMzRHREdIamhDWTNN?=
 =?utf-8?B?aEFUUTR4YnlXNlFoVXp5NjhiTmoySWxHWjU3TDVxUEJrWmtLNk1DSXlQZVow?=
 =?utf-8?B?OVpMRnk0K3Q0OGcrb3dscTQ0RHc4S2orYzB3MDBhMTB4OHBwK2kzOUxzUCt0?=
 =?utf-8?B?ZXBNTk95eS96MHBHYy90czAvYVNqVVIvekpjZDFJSVZjOFpjN0F5VWdXSHVQ?=
 =?utf-8?B?RVRmSXMwWGJkdWJQYU5WQ0grQXlEWHVWNENWZHJiV2lSZmVacnVPaUtCRmVX?=
 =?utf-8?B?amY0cm5QT0l5Z2U3N2FSYmQ4OUtmODd5OGJaSjl5MHR1aTB4dEExZXBnTFVG?=
 =?utf-8?B?WVJZelY5SVFyR0Q0SGFLYU8xaGZiL0hkb2VwYzRsYXlWL2I1eVhNUzVXei9j?=
 =?utf-8?B?RTRVTGNrSjQycXQ0dEVJUXBnczFpZTNOcDRSWkxxN0V4OUVpUnFZRGNhc1dj?=
 =?utf-8?B?dWs4R1k5ODNKVFFldlAwODVTUEpkbDZQZXJKN1IvaEgyUUxWeS9nbUFxSW1R?=
 =?utf-8?B?SnBNUVZMSGVTVDdNM0FmSmNNczA1dTdYa3NVUCs5SnNNUXhGcVdjY3NZc1Ft?=
 =?utf-8?Q?414oGVaYRVfMxflbVKdzhPKrQYQ5TM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bGFTUU1BRDAvT3YyNTBvbW9NRWgrY2JnK3ZXZW0vQzFWT09IbmsvYjJBVjVY?=
 =?utf-8?B?V2p5K0FHQ09hOXZDNzV4RG0raVFMUjRsZWlFUWVVejdoU2ZucWp5VktWZmRM?=
 =?utf-8?B?NzlLeDlNUEt2V0tsK1I4eWtLa0M2eEJaRVpwOHBRZnZNSEhqZm1LRVBEVlRw?=
 =?utf-8?B?M1VCMzF1RDlsT3p0bU9VWEFVSEdxejdhYTBHcHQwQTR4a1VoUnBieUZsdXhk?=
 =?utf-8?B?Rm1PZDI4NjVZT0srQ3pJSEpaNDhjejRnem9IWTdpbHl3aGEwdXFhcFRDNHRk?=
 =?utf-8?B?bFY2MGVTRDY1MFlVQUVPRWFJV1JnVGp2RTBOVllQOUNxTUI5eXNmeE5CYldX?=
 =?utf-8?B?T1d4VmdaRHRYcmkxSWVYT3hqeEdqTG85YWI0TVM0b3dMTW53bEdXRVl2OTJy?=
 =?utf-8?B?NG1oQXYvSnZxUkl0cjd1UkpBeXZtaUJiWkxIdWZleVJkZWI3Zk9ualBZclNK?=
 =?utf-8?B?NkJXRXhYVXd0d2xVZ2dDRHVOOWxFMGZCT0hhc2FxazhsV2JjWlJuVzNVdlEr?=
 =?utf-8?B?M29TdnBadUtKNktha29NZWNtRlY0SGhIN2g1dWFSR21KV3FxWDRvcTZ2bDNw?=
 =?utf-8?B?MW10V21NY2hjWmg2L2pVWlk1ZWRPNTBwemJFOXFxS0JUWnQwQzJFY0Z6UUxi?=
 =?utf-8?B?T2RoWVpOTER4ZEVtejJsVFdFdmFCa0EyY2kxUjB2UE1kaVNWUTNocnFmeExL?=
 =?utf-8?B?M3QzMEFwUDQwYmxncmw0Z0VFcHQxRXN5YzFLODg4RGE1QU9IcHNXMDZKRC9B?=
 =?utf-8?B?N2t5a2xCM2VHU2daVDFmQ2xTaENCN2ZyajU0Wi9mTDJUTWNkS1pNWG54ZmRw?=
 =?utf-8?B?dTc0WERLUk8raThQSVNhVTFMQm9FdDlXeFl5OGZLZDJGZi9WTjZvWEt6ektS?=
 =?utf-8?B?cTNWSEZlMXd6TDJFT0lPR3RSZDh6ZS91S2RxU3BEYXprdXA3WUlXdlpQN0tD?=
 =?utf-8?B?cUVGOC9uVUdYVlVBM1B2U0FqMkNxZkFsbnVoMHBFQ1ZKWkJYcU1CRU8vS0Rr?=
 =?utf-8?B?d28yOFd0RjBYR0NMT045eDE5V21PeEErdS93bjhVcThxTmpFbzRkemdTcEkr?=
 =?utf-8?B?eWlIYTBZZTAzSU5qemJBUm5xUlFzS1FpaDNQcjIxemlEN052RWZXVk9HS1lD?=
 =?utf-8?B?cGdtU1ZLaWhGUUVaY1BaSEdEcWFhdWE3NmY4b2daa1l0WEVpWWxQRktuaGxz?=
 =?utf-8?B?NXJZeTBHdEx6QU1JSkdnTTFVOHZJUW5mUnRQaGlQa0h6ZUZ3Si9EZ05BMS9i?=
 =?utf-8?B?TDJNeUdFa2FpQk9ZM3ZDbUJMVlhRcGN3bTgzdzJsdU54T1BIdWIxZ1BBZi9E?=
 =?utf-8?B?RmsvQlFZVTN0YmVCcTAyK3dJaUxVRHRxUFFEeDJDdkdSbDNEK3c2dWthS1FJ?=
 =?utf-8?B?TzI1amVGYUlrUE1xMnIyWnl1aG9WZDNpSzBodEU0QlA5M1hXVUhqenFYSUR2?=
 =?utf-8?B?aTJmMU8vMkdJaVNJY3RxbEtOdXJieHFQZVpxeE55bHpOaUtuZ3ZiaXB4MCtw?=
 =?utf-8?B?Y252OEhxQ0daV2JPd3UyZXdjN1ZPTkhsZmo5VVhsRjdZZ0piMStDczFMbHNv?=
 =?utf-8?B?TUhxU1ZSZEd1eUlNUWVDTVFHVlVEbjBhalYxWnMrcGNKeGJOTC8vczBSWTAx?=
 =?utf-8?B?QzJxa2l3WUlCVTlIM2NnSktPT3pRalRnY1NwL3J4ZW4rMUtrVll0RE1BbjUz?=
 =?utf-8?B?UjArZUxHVzhJNkRXMmtBU2NFejNhYTZrS2E4V1hTRjkrdVRvOU9qVUNDQzV5?=
 =?utf-8?B?Z3M0VytuZ08yRENyRTBQMTBWUmtXUks1enRQaUhabS9EdU9YUUNkSnpPMC9X?=
 =?utf-8?B?NUhtc2szSmxsRTUwVWsxeitFaVpRa3hLNkU0cnptcDQ5TkFvbitFRUtibnc0?=
 =?utf-8?B?VjlFR2pPMGQ3TTh3SzhuOVI4cnQrQjFyRHBKRlNuUHZpWDFZNkpWYVYvWDZB?=
 =?utf-8?B?V2d3aXZyNnBZOTU2RkpQSDJFa1B5Z3QydVJ3YkNpOFlOL1pNd21HdDFFWkIr?=
 =?utf-8?B?b1h5akxiYk1jVXJlTkpMTitQNDlEOE1NREVhYkdRWVhPcjMra2tZTC9vOXNB?=
 =?utf-8?B?OU1jbGU2a1dOcGtWMmZnK09aNUovSDgrRDNrRUZGdGhGcDB3VkNFcUo4enRI?=
 =?utf-8?B?Wm1ESkRzNkdhcDJ4bHZXTWl3dm5GbEdQbzFkbTN5WmsrYWt5QkhkamZqWmtM?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64188875-f0f2-4eb8-4bf8-08ddab4b0f54
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2025 13:55:02.4221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bb2J5yElbQ+2dAFvLQ3Sa6PEqZ9pVACwwT7XC3VkhK2h1AL5RF3xaM5coPiTHIVZt62fTEpRb8UfdZJiZqnwnLLI4PDLNDbs6CG4rHOlQNgLsPUa218pfTLhGCEyzhop
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6886

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbHBvIErDpHJ2aW5lbiA8aWpA
a2VybmVsLm9yZz4gDQo+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDEyLCAyMDI1IDExOjE3IFBNDQo+
IFRvOiBTYXNoYSBMZXZpbiA8c2FzaGFsQGtlcm5lbC5vcmc+OyBDaGlhLVl1IENoYW5nIChOb2tp
YSkgPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNvbT4NCj4gQ2M6IEVyaWMgRHVtYXpl
dCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc7IHN0YWJsZS1j
b21taXRzQHZnZXIua2VybmVsLm9yZzsgTmVhbCBDYXJkd2VsbCA8bmNhcmR3ZWxsQGdvb2dsZS5j
b20+OyBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBEYXZpZCBBaGVybiA8
ZHNhaGVybkBrZXJuZWwub3JnPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBh
b2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVs
Lm9yZz47IEt1bml5dWtpIEl3YXNoaW1hIDxrdW5peXVAZ29vZ2xlLmNvbT47IFdpbGxlbSBkZSBC
cnVpam4gPHdpbGxlbWJAZ29vZ2xlLmNvbT4NCj4gU3ViamVjdDogUmU6IFBhdGNoICJ0Y3A6IHJl
b3JnYW5pemUgdGNwX2luX2Fja19ldmVudCgpIGFuZCB0Y3BfY291bnRfZGVsaXZlcmVkKCkiIGhh
cyBiZWVuIGFkZGVkIHRvIHRoZSA2LjYtc3RhYmxlIHRyZWUNCj4gDQo+IA0KPiBDQVVUSU9OOiBU
aGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgYmUgdmVyeSBjYXJlZnVsIHdoZW4gY2xp
Y2tpbmcgbGlua3Mgb3Igb3BlbmluZyBhdHRhY2htZW50cy4gU2VlIHRoZSBVUkwgbm9rLml0L2V4
dCBmb3IgYWRkaXRpb25hbCBpbmZvcm1hdGlvbi4NCj4gDQo+IA0KPiANCj4gKyBDaGlhLVl1DQo+
IA0KPiANCj4gT24gVGh1LCAxMiBKdW4gMjAyNSwgU2FzaGEgTGV2aW4gd3JvdGU6DQo+ID4gT24g
VGh1LCBKdW4gMTIsIDIwMjUgYXQgMDE6NDA6NTdBTSAtMDcwMCwgRXJpYyBEdW1hemV0IHdyb3Rl
Og0KPiA+ID4gT24gVGh1LCBNYXkgMjIsIDIwMjUgYXQgMzo0NOKAr1BNIFNhc2hhIExldmluIDxz
YXNoYWxAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IFRoaXMgaXMgYSBub3Rl
IHRvIGxldCB5b3Uga25vdyB0aGF0IEkndmUganVzdCBhZGRlZCB0aGUgcGF0Y2ggDQo+ID4gPiA+
IHRpdGxlZA0KPiA+ID4gPg0KPiA+ID4gPiAgICAgdGNwOiByZW9yZ2FuaXplIHRjcF9pbl9hY2tf
ZXZlbnQoKSBhbmQgdGNwX2NvdW50X2RlbGl2ZXJlZCgpDQo+ID4gPiA+DQo+ID4gPiA+IHRvIHRo
ZSA2LjYtc3RhYmxlIHRyZWUgd2hpY2ggY2FuIGJlIGZvdW5kIGF0Og0KPiA+ID4gPiAgICAgDQo+
ID4gPiA+IGh0dHBzOi8vZXVyMDMuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3Vy
bD1odHRwJTNBJTJGJTJGdw0KPiA+ID4gPiB3dy5rZXJuZWwub3JnJTJGZ2l0JTJGJTNGcCUzRGxp
bnV4JTJGa2VybmVsJTJGZ2l0JTJGc3RhYmxlJTJGc3RhYmwNCj4gPiA+ID4gZS1xdWV1ZS5naXQl
M0JhJTNEc3VtbWFyeSZkYXRhPTA1JTdDMDIlN0NjaGlhLXl1LmNoYW5nJTQwbm9raWEtYmVsDQo+
ID4gPiA+IGwtbGFicy5jb20lN0M0NDlkYjIyNzhjMDA0YWE4NGQ3YjA4ZGRhOWY2OGM4YyU3QzVk
NDcxNzUxOTY3NTQyOGQ5MQ0KPiA+ID4gPiA3YjcwZjQ0Zjk2MzBiMCU3QzAlN0MwJTdDNjM4ODUz
NTk4NTU3MzY4MzM1JTdDVW5rbm93biU3Q1RXRnBiR1pzYjMNCj4gPiA+ID4gZDhleUpGYlhCMGVV
MWhjR2tpT25SeWRXVXNJbFlpT2lJd0xqQXVNREF3TUNJc0lsQWlPaUpYYVc0ek1pSXNJa0ZPDQo+
ID4gPiA+IElqb2lUV0ZwYkNJc0lsZFVJam95ZlElM0QlM0QlN0MwJTdDJTdDJTdDJnNkYXRhPVo2
QWZJZDRyNllzMVY0c0dvdg0KPiA+ID4gPiA4YmRPY3Q3MkFBVWRmVmdGVG83Tk1PaWJVJTNEJnJl
c2VydmVkPTANCj4gPiA+ID4NCj4gPiA+ID4gVGhlIGZpbGVuYW1lIG9mIHRoZSBwYXRjaCBpczoN
Cj4gPiA+ID4gICAgICB0Y3AtcmVvcmdhbml6ZS10Y3BfaW5fYWNrX2V2ZW50LWFuZC10Y3BfY291
bnRfZGVsaXZlLnBhdGNoDQo+ID4gPiA+IGFuZCBpdCBjYW4gYmUgZm91bmQgaW4gdGhlIHF1ZXVl
LTYuNiBzdWJkaXJlY3RvcnkuDQo+ID4gPiA+DQo+ID4gPiA+IElmIHlvdSwgb3IgYW55b25lIGVs
c2UsIGZlZWxzIGl0IHNob3VsZCBub3QgYmUgYWRkZWQgdG8gdGhlIHN0YWJsZSANCj4gPiA+ID4g
dHJlZSwgcGxlYXNlIGxldCA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4ga25vdyBhYm91dCBpdC4N
Cj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBNYXkgSSBhc2sgd2h5IHRoaXMgcGF0Y2gg
d2FzIGJhY2twb3J0ZWQgdG8gc3RhYmxlIHZlcnNpb25zICA/DQo+IA0KPiBBcyB5b3Ugc2VlIEVy
aWMsIHlvdSBnb3Qgbm8gYW5zd2VyIHRvIGEgdmVyeSBkaXJlY3QgcXVlc3Rpb24uDQo+IA0KPiBJ
J3ZlIGxvbmcgc2luY2Ugc3RvcHBlZCBjYXJpbmcgdW5sZXNzIGEgY2hhbmdlIHJlYWxseSBsb29r
cyBkYW5nZXJvdXMgKHRoaXMgb25lIGRpZG4ndCkgd2hhdCB0aGV5IHRha2UgaW50byBzdGFibGUs
IGVzcGVjaWFsbHkgc2luY2UgdGhleSB0ZW5kIHRvIGlnbm9yZSBvbi13aGF0LWdyb3VuZHMgcXVl
c3Rpb25zLg0KPiANCj4gPiA+IFRoaXMgaXMgY2F1c2luZyBhIHBhY2tldGRyaWxsIHRlc3QgdG8g
ZmFpbC4NCj4gPg0KPiA+IElzIHRoaXMgYW4gaXNzdWUgdXBzdHJlYW0gYXMgd2VsbD8gU2hvdWxk
IHdlIGp1c3QgZHJvcCBpdCBmcm9tIHN0YWJsZT8NCj4gDQo+IEl0J3MgbG9uZyBzaW5jZSBJJ3Zl
IGRvbmUgYW55dGhpbmcgd2l0aCBwYWNrZXRkcmlsbCBzbyBpdCB3aWxsIHRha2Ugc29tZSB0aW1l
IGZvciBtZSB0byB0ZXN0LiBNYXliZSBDaGlhLVl1IGNhbiBjaGVjayB0aGlzIGZhc3RlciAoYnV0
IEkgYXNzdW1lIGl0J3MgYWxzbyBwcm9ibGVtIGluIG1haW5saW5lIGFzIHRoaXMgaXMgcmVwb3J0
ZWQgYnkgRXJpYykuDQo+IA0KPiAtLQ0KPiAgaS4NCg0KSGkgRXJpYywNCg0KSSd2ZSBjaGVja2Vk
IHRoZSBmYWlsdXJlIGNhc2UgYW5kIGNvdWxkIHJlcHJvZHVjZSBpdCB1c2luZyB0aGUgbGF0ZXN0
IHBhY2tldGRyaWxsLg0KDQpUaGUgcm9vdCBjYXVzZSBpcyBiZWNhdXNlIGRlbGF5aW5nIHRoZSB0
Y3BfaW5fYWNrX2V2ZW50KCkgY2FsbCBkb2VzIGhhdmUgYW4gaW1wYWN0IG9uIHVwZGF0ZV9hbHBo
YSgpLCB3aGljaCB1c2VzIHRoZSB2YWx1ZXMgb2YgdGhlIGxhdGVzdCBkZWxpdmVyZWQgYW5kIGRl
bGl2ZXJlZF9jZSB1cGRhdGVkIGJ5IHRjcF9jbGVhbl9ydHhfcXVldWUoKS4NClRoZXJlZm9yZSwg
dGNwX3BsYl91cGRhdGVfc3RhdGUoKSB3aWxsIHVzZSB0aGVzZSB2YWx1ZXMgdG8gdXBkYXRlIHRo
ZSBzdGF0ZSBmb3IgVENQIFBMQi4NCldoaWxlIGJlZm9yZSB0aGlzIHBhdGNoLCB1cGRhdGVfYWxw
aGEoKSBpcyBjYWxsZWQgYmVmb3JlIHRjcF9jbGVhbl9ydHhfcXVldWUoKSwgYW5kIHRodXMgZGVs
aXZlcmVkIGFuZCBkZWxpdmVyZWRfY2UgYXJlIG5vdCB1cGRhdGVkIHlldC4NCg0KVGhpcyBpcyBh
bHNvIGluIHVwc3RyZWFtIGFzIHdlbGwuDQpTbywgb25lIHF1ZXN0aW9uIGlzIHdoeSB0Y3BfcGxi
X3VwZGF0ZV9zdGF0ZSgpIHVzZXMgbm9uLWxhdGVzdCBkZWxpdmVyZWQgYW5kIGRlbGl2ZXJlZF9j
ZSBiZWZvcmU/DQoNCkJScywNCkNoaWEtWXUNCg0K

