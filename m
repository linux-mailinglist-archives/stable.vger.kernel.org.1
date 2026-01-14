Return-Path: <stable+bounces-208310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 504F5D1BE8C
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 02:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E640304EDB2
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 01:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C971293B75;
	Wed, 14 Jan 2026 01:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="QNTdMk+3"
X-Original-To: stable@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020084.outbound.protection.outlook.com [52.101.189.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E58D287245;
	Wed, 14 Jan 2026 01:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768353745; cv=fail; b=OsiDDggsGi3DfTY1pSP21Xz2Q7eFGjjbI4jrKnE0XlMjOMoZmCsehNIRaB3O1LsRPUjp7piT4qdg/XzYdHq7lWAGEbzWZiySEgLPekv7xo9r79rM4/MiC88FeGl+7s/1Sqhg9m1X1Um8y4jD65z2G7u1675VC1kWbeZFseT6g/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768353745; c=relaxed/simple;
	bh=s2zXSwLfYl3QQ0TLQlCDauR5wiwZrph9rDYb9KgBcVE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ldr8Hq0hBStSz403gmI922yZROsnr44cLm3KvvP66t2g4MbhNG59vsguRmdqEMaNcW1ZuKzQdGHeGgO4wG+DUoAepzNWK/FXx3L+RF4tH5GbpRDuPt5sqD21jFmrmRBn6Qwi29vIdjQU+HDjZvI8Zn9w78fxqb9Wv9cBe8A01jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=QNTdMk+3; arc=fail smtp.client-ip=52.101.189.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRzpv/ALRlg/QUsD2Bb8s7OyH0MHQ8FQ5Y7j1eYVNb3JsLd/nPUTvajwM9QCExGwzObONoVx8YJ8TR3fbEaMcrLJ+xwXGQkEVgCE0hUZ9d84PJoGaCcbK+iJwIeLHqBxIIHReihLmviLWP0A3esltoJunt/aj/qWAgRljC5PQzEnSCo5bf6FJm/ZTm4c8jXRITlKJs5W4VEeGnlUWLyZkR6KOmMeemncLEOPzFBwOmoGPyF4oU39Wa5SwWZywK3PZybQ9GYt+qixCUMqg+xcz1KwhEAEclp33rInt6AY2aTm5hY/teVqJbh8IPUUis9gJpxgsAWL8Farz07NnjbqTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDUzEzvfpg/U9Jlhdg7Dq9u8gt4LzLODtj2D4cHboLU=;
 b=qyPNcURn5SkIWO3Ew51ombeJmeaL35NFVXpLbMP3ppbzkzYU9T4QUjl3W3V6CjihOhlPpAbzXmLwxJXKTPKQQ/MBjr7S1YmrZxHaI4tudCGhwSlkfqkrst4HM7vM1Pgc8OKqI4cHwFOHgFZW7AcTSo0m/hcHw63MKu2SuLBFEhWcyyL0iNizNeeeYR1FiRCONd5g1qyXzfBy5/c/3E9RfGQDLhr1FOb6KyCEIY4k4LS8akLlsDqt5XK4m5uVAv9pibxXWK3XO3EidIVsJ+6O3odztjCEJCtRtp1HFMC4vk4QloCUP06iKXeY1cLz4I95XmojJi3PocpXmAfSxkztRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDUzEzvfpg/U9Jlhdg7Dq9u8gt4LzLODtj2D4cHboLU=;
 b=QNTdMk+3Hikwih+IVaBawhLW4jHbpLnLI5mOTXMBYz7fzXMxZTRn2tWbHD+x1f2gcGJ7xvADpZAo4zpG9aPUTWOAEarz08ii7Y79DroR5qjLY+w7XVT9hJBLFLOIuxPLduJmO0btwmDxhc1EJh+VZieiGdCflB2coGESJtwd2owYF11ArGznGBUv2qC22G4eXiD9XwkTVrYpvryhLYtIYVzekb9LChQ4b/8llkUNojZL22ZIbwTOZayORHzkuMzymWgcCQej2WSCOJ0D+hrZLUKVmDchj1OtMPRaSaKaPeXy8mpH2QIgNevUwzoqtuQBJkHA9fF1jbxvgGn3HzV+Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB5229.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:61::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.8; Wed, 14 Jan
 2026 01:22:18 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9499.008; Wed, 14 Jan 2026
 01:22:18 +0000
Message-ID: <162c241c-8dd9-4700-a538-0a308de2de8d@efficios.com>
Date: Tue, 13 Jan 2026 20:22:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] mm: Fix OOM killer and proc stats inaccuracy on
 large many-core systems
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
 Martin Liu <liumartin@google.com>, David Rientjes <rientjes@google.com>,
 christian.koenig@amd.com, Shakeel Butt <shakeel.butt@linux.dev>,
 SeongJae Park <sj@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <liam.howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Christian Brauner <brauner@kernel.org>,
 Wei Yang <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-mm@kvack.org, stable@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Mateusz Guzik
 <mjguzik@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
References: <20260113194734.28983-1-mathieu.desnoyers@efficios.com>
 <20260113194734.28983-2-mathieu.desnoyers@efficios.com>
 <20260113134644.9030ba1504b8ea41ec91a3be@linux-foundation.org>
 <c5d48b86-6b8e-4695-bbfa-a308d59eba52@efficios.com>
 <20260113155541.1da4b93e2acbb2b4f2cda758@linux-foundation.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20260113155541.1da4b93e2acbb2b4f2cda758@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0287.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::13) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB5229:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ab02ab-e910-4fa8-d725-08de530b5bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVRXcUNiRy9JaStkVEJvZ1M3aFJERnVWSTdBVHV5cTBLS1pOUGUwM255V2JB?=
 =?utf-8?B?UW1QYnpxcWRBNmsxdGFxOExHdFNheVgzc1A5RVd2Ny93b3hrU3pwV2NGeVBE?=
 =?utf-8?B?RFJ1YUl2cFEwYjJOMHEvdUNhSXJNdm1FY05sWkFabk9Wb2lzeEdnMml2V2tr?=
 =?utf-8?B?T2I2VFpJK3p6RlRPWStxaFBWVHRMSlM1cEhqRVJjMzNWWEhRejFVM0dFYzly?=
 =?utf-8?B?MHEyT2lET2RuN2FZNHVYVzlVZVJnMTJ1bFRyWlNYbElDSW9wTy8zQXpOcGx5?=
 =?utf-8?B?Vms0UFlNSkkzWEpVazllSHZkMFZ2dXVidkFYdTZhemFrbXJwTFk2eGZCS0Fm?=
 =?utf-8?B?d0lvWDl1NURwVTRwWjRYaXBoNXdxYTNVS0ZNMzNQeDRTRlR6Tkg1SEZSZ2g1?=
 =?utf-8?B?ODlJSEw1Z3I1SzhRUUFJalhXRTl5b2c4ckJ3N2M1N3RJSXJlY2krcVVYbUt2?=
 =?utf-8?B?aW8yZE5YYVZldFhUYnkyYlpmazFPOUhCV3AvRmpyZ2tSVmtCK0ljcXlsZjMx?=
 =?utf-8?B?Yy93NzBnM0gwd1RqcFA0OG13MlRSNWplZ0pBTExCZktxVkZZV3NNK0dBZ25N?=
 =?utf-8?B?OUlaM2htUCszRmxmOHpyZWgrM0E0dlpNTnJ0VjBiMEM1Yml0MFp5VW80alhy?=
 =?utf-8?B?YjREeEJuWXpIbitlMEd1WkFBdFR4OVpUVC9wOGxkK3VpSEdQcjVhQjNFV0Nj?=
 =?utf-8?B?dEo3MU1LZGdseDd1U2ZQUXYvNHZRNUYzMm9qb3hyS1JDcmNRNFRKVTBsclAx?=
 =?utf-8?B?V3FZZkt2T2VqL1dDNDNXQmFCWWRMcktnQ0o0MHVCdHhxd056NkpMQzZHOTVt?=
 =?utf-8?B?TzBYSlc5am9nUzFXWnlMbWRIMmlYcjlrenFKREtRQzBsc1NwRVdKalUrMFBw?=
 =?utf-8?B?MS9SdTVSWGdxeE1TNFYzOW40YkZqYVNuUjRTRjZqdUVOODhScmVyak5ISmxH?=
 =?utf-8?B?T2VqazdWak9xVVY1UDZGQ2hxWEJHeUZWTTY1NkZ5S3E4TXdmOVltWWpMeDlo?=
 =?utf-8?B?N21lc1JId20vSDBTRU5tZTdxQTJwcytmUnFkZG5JMFRrUm9QVzF6WEZXcnE1?=
 =?utf-8?B?YUIyTWovWFBMRU56dlhOSk53VnRQU2h6RXcvRVBabjhGRHkra3BnZ04wM2xE?=
 =?utf-8?B?aWhXNUE0V0hOV1AxQWR1WnhhOG5FL0J3NmVDbXFPTVgxdkwzNTdnNHhHRjJm?=
 =?utf-8?B?Y2U2UEZlVHlyRDJwY0F0VWNRNW0yYXMxSDgyTkF3eVlCRnNLY2p4TEoxa0Rv?=
 =?utf-8?B?ancrVlVlQUhQcjcwdkRZUXh1dlE2bkRiVkdrWjdBblZ2MFVOZHU2d1N5MlJ6?=
 =?utf-8?B?OFVzdDZVdHp4aDM1bk5FNEo3M1ExbE9VNlBUMVNUcnZVZ3IzS3ZydGJyVlVr?=
 =?utf-8?B?M0YvcG1MSVFKUjVrOGpQN1pXZGJlS3RMYnl2Y2ZkTCtIMlFuSm83cmN3T0k2?=
 =?utf-8?B?YWw4STZRWVdHUnNKUEtadXZ0RGJIVEJOY01EcklCb1NPSHdxdDBJVzIrK1hm?=
 =?utf-8?B?K2pUa3p0RXprRDkwd0NUY0syb01DWGRSdHVwUFdFSnpYa0k3SUNFaGQ4UE9H?=
 =?utf-8?B?TS83Sm5sQXB3T3JseS9JdGxtaTRUaGNYOSs5cCs0Vnl6K2hFTExuTEVrZ1NF?=
 =?utf-8?B?QkJzVlNwZ3RuRjg2SXE4RmxrS3BPZkF1TWVwU2w3M2hpTmtSTTg0SC9HRWZz?=
 =?utf-8?B?S2pGMUdXTkhrcVdwckVEWHU0K0F6T29sUHIwdUt2dEdGbHRKSEErL3FJZ2Iv?=
 =?utf-8?B?enpqcEJKZFNQNkFWNDVTeFZGZ2MzV1Y5MFJjRVNNMGNwQ0x6Y2JSOUF6SXZO?=
 =?utf-8?B?dkUvbHc0Z29oOElJS3UxMVQ5RFhKcnVZYXJIT2VQTTU1bDI0VUM3djMzNmox?=
 =?utf-8?B?aEFQRGRRRk8wR0tjb2JndFhRSUhYWGs3d1ZYYnlkRW4rNGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3U5M1hXQU1GbW1ZZUxPcUFqT0p6Vzd1N0UxemJiQnZaRmU3YzdBaTE1cmpM?=
 =?utf-8?B?R0M2TnovYlo1Q1M1bGZEdGdXQit6ZHlqOCtBaXdiS1c0NVNXekpLdHVsRmxN?=
 =?utf-8?B?Vlc3K1cyT0VQaEVrcTN6dmxZcUhxSHJ4UDdoTlQ4RW5TSSswWVFOeHMvQldE?=
 =?utf-8?B?Q1BGZFBKd3hNNU9VcEVKVURFeXhVaklRbnplM1BuTFhYcE9nK0VGMFJQWm9Y?=
 =?utf-8?B?dm93bjBDdGdoSW5uUzlyazRJWkkxcmxIRmdBTGNHSWlGQk4xOWc2bXZXeUFI?=
 =?utf-8?B?VFlxUksxSnBzdVkxZjM5dENYZi94QlN0RFlURUx6a0hhZlo3ZTEzVi9wQ1lY?=
 =?utf-8?B?a25qcWpRRWYzVzcrNnlBMGkyUVNTS2R3T1pwVnYva09rTDhMOW9mVkVmY3U4?=
 =?utf-8?B?dGNvVkF3dXJYWktFZ0x6WWs1bWRpMHp5eDY1SlBXckhRM1lTcGt1RVRqcmNn?=
 =?utf-8?B?T1dSeXJoenJCd2FBb2o4WmVqWDZ3OE5IWUxkUkZjY0Q4RW5IL1I1aVdWOGVS?=
 =?utf-8?B?M3pqRzZCTW1xZXh4ODRWOWdkTW13SjVnWUNOcHZDc05hNHFMeXFSeUJzSHRO?=
 =?utf-8?B?ZEhHcUtpMS9jM0didFAyWGVnMnNYWG0rZGZRbkNxRTNwMEc2OHN2aWwvV2Rj?=
 =?utf-8?B?eHIzVzd4QmRNWXorYjczOE5LN3A4ZXBKUDJnL1RxYjIzVUFyeENjSzA3cUtR?=
 =?utf-8?B?aXdqTWQrRjdTT01McWROTnduZEJDRWVzUXFxM1FtdkJ4YXk0SnJ1UHFaNDFm?=
 =?utf-8?B?ckkwcTNCWVFZYndGU1F1Y3hnZGFuK2NwNDhtdHdNMXZVNWJablUwalliNlJG?=
 =?utf-8?B?RzZrRlJlNmltb0Vja1gvNjFDU3NDZm5xSEd3SHlJUFBabnFaSmxYeGREZHh2?=
 =?utf-8?B?cTVubUIwSEFhdkx5TDZTTmpCbFZYcXNucW1Oc0ZlU1U1WnJERy9rdUNoYkVS?=
 =?utf-8?B?cDBTRnhhUjdVSUlRcFRCMHJFQUlkWWpmMEp5TFM2QmNxTS9QWmlyUG5LQmh0?=
 =?utf-8?B?V0MrY3Q5cWgxNWpkcXV5dGdOZjZRbnhsNTI4RlFNOXJ6QXA3YTIxQ3BpT0Fp?=
 =?utf-8?B?bTJ5S1ZxSkxmT0ZoZWgyWlRBQUJSWkRFcHB2Z0FyWnNQUURsVk1WSFFUWHBt?=
 =?utf-8?B?RTZiVHBmdkx5dSt3SGtOem1MVGc0K1FacFRJbUR0UGI0bGthaHlxejJvd0U5?=
 =?utf-8?B?UHdUYUlaWnV1WHhDcWVLTFhKcGJVR3luU2pPT0xBa1lLdTRQM1NCS2dBVWR2?=
 =?utf-8?B?dVh1b3FVT1FMUWtiMC91ejJsUHZVNUR1R1orM1BpR2ZrOUJ0bGZHSU42a05F?=
 =?utf-8?B?K1FubkptS1ZmdkFlUWhKaFVpTWVNdng2aTRVakhtQ0lDMUJSTEduMWZyN01U?=
 =?utf-8?B?dDZHMlZTS29jVWZxUnhZT2F3eS90NEI0VkUyeDQ1K2hHUmtlRnowOExnd2tK?=
 =?utf-8?B?QUNrc1BGWEZldXpVWFlBZ0ZEWHZiaU5ydHhjYTJZSXYySERkVy85c3l2anRK?=
 =?utf-8?B?aFZDblFoVjkvWHczSHhOOU0vUlVPalFYUW9OMExjVTZTbXpyK0UzN0p4K0k2?=
 =?utf-8?B?U0RKT2ZqZEVWQVpyQldCZFdpeFcrcjFWUFVra0c1OGN3Mk5rc1A3VjFNTURn?=
 =?utf-8?B?SWlMY3l4Slh5d2hTUFh6aGNpK09pdW5mb0d6TG8vSFpxY05YWkxLTlhmMVh6?=
 =?utf-8?B?S1NUMmdnRE13eXBnblhRY3g4ZEtRTksvWGg5TndUT2Z6aWVRM0FHYm9VTHNx?=
 =?utf-8?B?YlFsTXZkaUVOTzlFY0ZRbmt5Qlk3U3NKSkNMS3lDWlJMazJ4dFF5UFRrZU1Z?=
 =?utf-8?B?YUp1OThCclB1WG1nSFM4TjFUMFg5QUZLRno1S2dSWDhjdU5iNmx6K1doY0xW?=
 =?utf-8?B?V2FMWldHdGI5d0pHS3FDWG4wUStiY2E2czU5L2RTWG1UNDg5NzdMYmlTVW0w?=
 =?utf-8?B?cmlhWlp0aUhORm02TXhqZ0dIa1VwdjllQVRhYWdhY3ptbTlxTklpVGdVbENS?=
 =?utf-8?B?WmVIMzV4REpuelR5b1puQXpkUFd4TUZRdXFVR2Mya2NQUWp1K1orMno5b1ZZ?=
 =?utf-8?B?ZWs2UENIMVpqUVNoV3Z2UU5LWmtRSTJPYXN6bjNxdDA2eDh2TnVhNFdWR0Jv?=
 =?utf-8?B?b3kwWkhqQkF3bm1JN25MRFVwLy9oeXFPLzJCUzZTeHQ2c2o0TjBrTndGdjE0?=
 =?utf-8?B?M1cwbkg0UTNkb0lWQms2L3ZDdTBscG1mUXFsMkhRT00weTlkZ1BodExNSGN1?=
 =?utf-8?B?TGc3TE81QVNjaC9pempKWE9qUHI3bDU5T0IvZ2szeGhyZWxQTW1vVzkwaFhv?=
 =?utf-8?B?dVFDMEJwanNNN0dxb2JacVk3NDd1ZUJrOU0rZXV2MXpXWXZaWVpvRkZjaU1j?=
 =?utf-8?Q?kP/5gYHOJLx2mGEJR9+PaC7X1Pjl6VR2B/0rWPIjfgxFR?=
X-MS-Exchange-AntiSpam-MessageData-1: 4vCUSex1Djxug2tb2nRX57kkm0XTA9cGRTQ=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ab02ab-e910-4fa8-d725-08de530b5bdc
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 01:22:18.5281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qcbuy5bngaYvyj+hGb1p0XC63m4GbgveZyc6y5VWR7rx2JaJGom7cPPQ+x7If3nZQE1RGZQNJlLTnJGh4uNGpaQQERY6ln7SheAia2Yp1pM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5229

On 2026-01-13 18:55, Andrew Morton wrote:
> On Tue, 13 Jan 2026 17:16:16 -0500 Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> The hpcc series introduces an approximation which provides accuracy
>> limits on the approximation that make the result is still somewhat
>> meaninful on large many core systems.
> 
> Can we leave the non-oom related parts of procfs as-is for now, then
> migrate them over to hpcc when that is available?  Safer that way.

Of course.

So AFAIU the plan is:

1) update the oom accuracy fix to only use the precise sum for
    the oom killer, no changes to procfs ABIs. This targets mm-new.

2) update the hpcc series to base them on top of the new fix from (1).
    Update their commit messages to indicate that they bring accuracy
    improvements to the procfs ABI on large many-core systems, as well as
    latency improvements to the oom killer. This will target upstreaming
    after the next merge window, but I will still post it soon to gather
    feedback.

Does that plan look OK ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

