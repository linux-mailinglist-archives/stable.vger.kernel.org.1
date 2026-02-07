Return-Path: <stable+bounces-214764-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOd6NftMh2lMWAQAu9opvQ
	(envelope-from <stable+bounces-214764-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 15:32:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 323A210629F
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 15:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8280301703A
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 14:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34376224B0E;
	Sat,  7 Feb 2026 14:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sZErs/W+"
X-Original-To: stable@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB2D1DE3DB
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770474739; cv=fail; b=rw10uOcbYkDtAvz283vM1kWUbEmub3r6F3UnTFz14+UeYhKTnmgJxbsu8vvGMcWaDOhAeWOaGjEd6VCcp/NXGyCugRB41Z5ad28KJAJt3kSIDfPpbA5n4Yf+msrbvwcogqhrmNzqv797MiLTrqorczciinZZmgflhG8Ka4FCeX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770474739; c=relaxed/simple;
	bh=TIlSZriAqc41JWd2amssYi26B7TDTTgdMep3EopLPPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vm2/xIOTnEjevusMa6fwEaQLTkziLI7SyIG4uZe0ceDfQ0ArdQ9haoWnpIbuaWSTufGwPVGRA3oL2uvhM2S+BJ2SojI8/+W4pwe0OshXJo5XcqGzZulKu076Tc9y4lx6xuxVL2qxrqp5+Wzw1I0uZpvKhC1rM3nQHaoa4uEkPV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sZErs/W+; arc=fail smtp.client-ip=40.107.209.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhCKSEhBqMCWA9fXkJN3jNGGjtyxrxHXUVmoALFjUY7FVvVgAiAWMqh7FTQghPHg0kwVYS2ScbT5Ql73OWrVAV/D0H9bmL6MBXFKaVTXdAs9p/K4SRSy7eIBHxUyT2Z8vgIoDxGBUpMPB5Wj8YISh8oVTmh77HMdhz+MPto5FivbhbaTpM0ova8LCeH3MhKyEbtRxKh4s+jXxdDNMk9Tvd3tsitZ2yMIdN+ROAun3UyKmM4hZF/xpkQ1W77XHUan5njPf9MmML37UYysOPxcz4fcPBmsdkkN9qVOu5GE8pSXullYfTeZiM49CLu8OF53Ar6H4euCaUgDPFeai+WImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3ObfeBUpjtMlzr0SfJEpFMmSDcY5JrOjZO4ac/K5pM=;
 b=owoNJBUpEwcRNhzxtwdloI05VoaeRSAbD2vK9QT4hlS2LlldS7goCVbZOgeo7egy12Fbxb+v1/SwA46hddAVkyHTv4MyFd1Rt13nHsxd3IqcjlSWy/PjwX5aOZZOpY2dxI2CveIlrtWHsuKo1mu4y/SIt6APfgtxL99nfMjQogb64MothM2J2vUYW6190o3R+ZcnTcPHCdwcxArl9fuyJQ0f1h7AmQWAQvQFv6JJGN9y21+warxI+YJ7oKqFKoukXaeGY1lWQnVm+9l75BpzTU7FSUUTGarX9hopBDi72aKqI0PF4wgSD5zuTff9g7777aernLgH97Ay80xIIdYj+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3ObfeBUpjtMlzr0SfJEpFMmSDcY5JrOjZO4ac/K5pM=;
 b=sZErs/W+y9kOGk569fuBZ9kz8tO73OzWeD5ulwWJachlrwCortvaUH6Vl1Pp2BkBVqsCGHuIWrf3x9nyXQvnUkvHFHbEGGgo9NqBDA1ntqTr5wc63eFDBon+cCSgqQFpneW1TTKbj0uDqZ3SoTtY1j5eccNeJ7Nnak4Rrd/LLXtp3d0tLpfoi/DHEQ+LukXjAE8NhG7JnE3PzaXJP6QIb+6I4KI9V2SR8hdHSJK5kvi9r99Qcof7QssU/lzcLevXgT41GOARKHyhKLPhwkcw5MJkoekCT3Hk2frgddbnkPCVj4XuzVPcYX8YvSSCA85smDmwBr3JnBWwbMrJXi5o8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB8333.namprd12.prod.outlook.com (2603:10b6:208:3fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sat, 7 Feb
 2026 14:32:14 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9587.017; Sat, 7 Feb 2026
 14:32:14 +0000
From: Zi Yan <ziy@nvidia.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, chrisl@kernel.org,
 kasong@tencent.com, hughd@google.com, stable@vger.kernel.org,
 David Hildenbrand <david@kernel.org>, surenb@google.com,
 Matthew Wilcox <willy@infradead.org>, mhocko@suse.com, hannes@cmpxchg.org,
 jackmanb@google.com, vbabka@suse.cz, Kairui Song <ryncsn@gmail.com>
Subject: Re: [PATCH] mm/page_alloc: clear page->private in split_page() for
 tail pages
Date: Sat, 07 Feb 2026 09:32:12 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <247E7FE9-E089-43D1-882B-81C7134C2FFE@nvidia.com>
In-Reply-To: <CABXGCsNyt6DB=SX9JWD=-WK_BiHhbXaCPNV-GOM8GskKJVAn_A@mail.gmail.com>
References: <CABXGCs03XcXt5GDae7d74ynC6P6G2gLw3ZrwAYvSQ3PwP0mGXA@mail.gmail.com>
 <20260206174017.128673-1-mikhail.v.gavrilov@gmail.com>
 <3BB6BA1D-3756-4FC6-B00D-79DF49D75C51@nvidia.com>
 <CABXGCsOMzrQTsByYraNby_MXnTuYBNt2vbWu65KCGX6bmi11iQ@mail.gmail.com>
 <F36AF979-5BE3-4399-9420-F41A475EA87D@nvidia.com>
 <B6CDB0B7-CB9A-492E-90DA-F8D7E3B037E1@nvidia.com>
 <7C7CDFE7-914C-46CE-A127-B7D34304C166@nvidia.com>
 <4C3D8E3E-D9D6-4475-A122-FA0D930D7DAD@nvidia.com>
 <CABXGCsP2z6sbf_FYZjdxyLhfJZEaxz0_WrEeteS50GLyU=KQGA@mail.gmail.com>
 <CABXGCsNM8Oex-V3vFSUy3ftMw1fAweHZHQYzRHWU9M6gm7r-rw@mail.gmail.com>
 <FF3C3042-8265-40E8-8786-333A6F627405@nvidia.com>
 <AB3C1175-FF03-484E-AEB6-07BC93E49683@nvidia.com>
 <CABXGCsNyt6DB=SX9JWD=-WK_BiHhbXaCPNV-GOM8GskKJVAn_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAP220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::20) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: 4da6f9b4-ed13-475c-c60e-08de6655b002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDlFaWxvZW50Zk5oV0xic2N1ZW8zZnBMVlRYMXVxbUJUVnRyWmprSE9lNUx0?=
 =?utf-8?B?OUpjTUM5NHFFc09CUzlLWHNJOUdZaDB0cjFmc3ZtK3JqMHJJbnR6VkJnVlpz?=
 =?utf-8?B?RlBJZGJHczNSd0VrYUw0RG80RHk3Q3A1VUFMbUEzVXoxQXA4cHJYb3RCMmp1?=
 =?utf-8?B?b3RjQzg2VEMwbTZpMXNKY1JEMHJ5R3BMVFpGQ0ZBcDdkSC9rSzNkRDN2dk8v?=
 =?utf-8?B?L1pvZlBFUDRmdWlnZDIrdG9GdzlGQW1wQlpwU2dLUDZ6M2txUVMwT25KUEUz?=
 =?utf-8?B?Y2FHQytVUjc2YVJtbTM5RFl3b0c0WVZoNm5mMGZON3JkMU9OUGFBT1lzQ2RF?=
 =?utf-8?B?OTBYaEhFMEdRc01USXdBZVZIaGRPcmZRdFZTUW1FOG9jS2Z6OGhhK0p2bFBC?=
 =?utf-8?B?KzQ5UEsvOFZCcGN2OEc2QkowMVJqTEhZKzYrTHlvci8xM1VqMEFpelk2YkVD?=
 =?utf-8?B?VnNFOEQ0ek1qT0dydDBsK3gxNVpreHF3OEl1dSthbHR6cURqc1FGNG84V0Mw?=
 =?utf-8?B?MkszV01pTGVqK0NkTTlpN05YWXc2S0x2QkpLL0c3QUlKd01BSk8wN1ZPeDVk?=
 =?utf-8?B?aXJScEZ2VVFiMHl5eTRMQ3pTSi9TM2NOcXdtOU12NU9BNU9EL3BYaXhSOFRm?=
 =?utf-8?B?SVpPemdrenhOb1cxMWtpUWlFLzhHVzl4NW5qdHJqZlVWQnhoTFNkQlRETnds?=
 =?utf-8?B?bzlrcHRpUml6N1MwODYzSmVOWEIvbVNMZlUxQnl1WnkrblZ2RFRrYzFmM0sw?=
 =?utf-8?B?cU1VRU1RdkhVakhKcTh5UjZ0NjBFYUZkbmZvTmhld3c0dFNmQ1VnblNsTUEz?=
 =?utf-8?B?dzBNMXEwNWdPWWo4NFRtYVgwMDFFYTBRMlRMZDlGc0dka1hNVEV0bU1lMmt5?=
 =?utf-8?B?aFBPQ2tOaUxhbWhJWFpQV3dpTUtIblU2UDNBenFpK2syWmVIQnJZMWYrVytk?=
 =?utf-8?B?ZFZ1Q1NJUVBpS2s1VjVEa2Y3dWtIQjZUNzhLQ2dybDRRcWtGTzUyL3JOVVJk?=
 =?utf-8?B?R0xKZ2N6R3BmTG0wRmpzOFNLZnZFV0hGYjZHWHFJcmVQalNLREdKdTVreWh4?=
 =?utf-8?B?V21xY2o4WGgvdmZVellOOHJxWURhTzZoS0IxanB6Y1BDblZuZjNWK0k3ZHJ3?=
 =?utf-8?B?VHRxdnNRMm1QTzk3WmNjVWxwaGNZZkZnZFMxZjdSTlphWE1wYSt0eVpCWnBJ?=
 =?utf-8?B?cFpLK2ZuckNDZUQzSnFUeFFqaFYxTWl3eWo4a3RjZUJ0cDVRQk5UcDdZSWlq?=
 =?utf-8?B?bkVqWi9VNVBiYVIza1lOL01iSE9Kei9ON2w2TnoveTJaRkxJSi84MWdybi9m?=
 =?utf-8?B?YmhuNEN2THZsQ1FXV1Z2NnJ4aTZSMW12ckVTYkRFNDdDaTN2RWxDdHlFTEVa?=
 =?utf-8?B?OUZVRDFBQzMzd3d4WFAzWFNMeWFMcHNrVU1pbGdHeERyTGZZT09kVFBjRW9W?=
 =?utf-8?B?Y2thbElJZzNNQ1RnbjdDTnpvUnBXNEl5c2hGeXpNY2habjVDdk01bk1kbEFR?=
 =?utf-8?B?OXovRW5WVmg5ZlBFMUtrSTk3eVdDRmxIZmhhZGRyclpVT0l4dzlCRFI0ZVJw?=
 =?utf-8?B?UWhEcldwL0lGbGdpTGhEcm14VHd4aCs3ZTgrOVc3aVpyZThHNEtFN1VhWmpr?=
 =?utf-8?B?Rno5anUwNzFhbjUzT3EzZnZVR2VCUFpyQXRCNnhLYklWRnVOZjdCUFdHSzRT?=
 =?utf-8?B?WkVvcUR0UjFYVUdRU0xzZWdXY042Zys3aytOMVZmd0NkajVweFRsWVVDZGVN?=
 =?utf-8?B?NFlPcjJiQWJSQzRFNWFQL1JydlU1UmNKTHQvb3RzNU9NUlRYTy82TUV3S2RS?=
 =?utf-8?B?NGlOYmRGeSs3Nm1ZUVpjeWF1WDFvOW8vMlZnU2RIK08vTzRiUnJ0NWJONGJD?=
 =?utf-8?B?OWhJS2M5QTFhMCtvMnBhc0VvS2lobWM0U3M5emZ4TVpGZzlIT1pwcDdoMVho?=
 =?utf-8?B?RWkrYjNHUUVrK0FXb1BtcU1DU3M4Z2xpY0JMREgvQjVrWWwzSUNFRURGU3lZ?=
 =?utf-8?B?dGRtNFhWTnpjN0ZzZGFtU2JqSE1JTkVPWHdzSjJGS0NQME55b3MzeHZkQURR?=
 =?utf-8?B?cmtueExnNFBDa0djNEFrZENid2tzREwzdmY0ekdDRXNTSUc5VzJjdGdWVzZp?=
 =?utf-8?Q?Rb+I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkJ2ZlpJTE1KUTd2ZW4xaktKV0ZidUd6c1Ywd1VpNEhmZys4YmVha3JwTjA5?=
 =?utf-8?B?QkRVM3BzYXl2WDYzckVUR29IYlJIUE40a2xmbys1VVVGcUNlYUFYcVJMdXJv?=
 =?utf-8?B?bUIrQjdtTFIzdVpNRzBtMXppMHI1OEpxcXg3RlU4UmJ3MUgvU0VmYndEVkw0?=
 =?utf-8?B?aDFBdnNEVmtFNGsyVFoxdjZrSVVCb0t4SGhSTkV5S0M0dXFuZ0p3K2pZd3FS?=
 =?utf-8?B?eFdTelRMS0ZSNXZEeE1iN3lvTnR5aWRrUnRxbUxDTmlmaGRHemVBWUpBYVlP?=
 =?utf-8?B?V0ZOMmJrTFFVT2tJR0U3aklXRldkd3BPcndhd3BXK0F3NmlhRHY2MGJsZkJs?=
 =?utf-8?B?d0hEeDV1cVB2VWZYSzdTU3RtcjEvTUc1dEtvMGJnMktXNmVzUXIrZzRnQldG?=
 =?utf-8?B?blZlVjhDdWRtUFpxMStSOFBKZGt6ZUxYQkZlNVNoTCtaczZXbHVLYm0zU2g4?=
 =?utf-8?B?aC9oVEJBWHRrUVJBVUR1eTRLcytmSit4TU1hVjJqWlZ3cURlV1ZGT2EwVzR2?=
 =?utf-8?B?MFh1Qm43SWlZTjhuakNBbDN5L1JHWG5wVmFVajcwVDVCSE5nNmdCR2doM0pC?=
 =?utf-8?B?OUZCOHRSejVrMVBGM04vVGV2dSs0cWtFQnR5QkMweXBnakpLUlZXQXV1L0NN?=
 =?utf-8?B?djVjTTVKQ2NFTkJLM3lDZVBqMzNLRWxzcmhCbGUxOXBMN1paMGRqWWFaN0Ja?=
 =?utf-8?B?NnFCa08yU014Z1ZXdHJ0ZDRGY2VacnMreUlGSm1SMjIxdURNSlRYTVZSTXdZ?=
 =?utf-8?B?YzMwZDRjRElneVZ2dFFnR216L29oQWx0VXp3TmRKTzVPcDdyTFNhNCtwM0JZ?=
 =?utf-8?B?NlYxbG1QYlBkSHIxRS9SemV3Q1IvdlBuQllxa1RNa3lqQVRRdkxlZjZUVGxJ?=
 =?utf-8?B?REVVaEkyYUVNUlYxNXcweDMxekxmdnViRjJXd3krd2hRYmdHZzdSdkZmK3A3?=
 =?utf-8?B?K0dBZFVPUWxtZzd4VEc2d2hMVzJwa0hVSUZUOTVZdk5LeDZnUzZ2MmVXdmRn?=
 =?utf-8?B?ZnNNNzIwdWcrTVJZd29BK0F0STBlZDRYTndnRS83VldOV2RQQm5tZnNWVXhT?=
 =?utf-8?B?WDV0bE8zam5CK3J3dTc1QVFOOE53clMvb09tbEV6cHprcDV1a3BTMnhUUnY2?=
 =?utf-8?B?VlRnWEhaWDBFcEdybVlTVm9VbnhOZm5QeGVhSTd0VzVJRHNrTFpkYWU4N1JH?=
 =?utf-8?B?Y01IbW1oRG91RjAyYU5XTjgycXR4V0UxdUtOZ1BDdUprUFJWS0JpWmhlWTkr?=
 =?utf-8?B?MldMOVZwaHFWd2xVckh4NlBPMmlHYjB3cVI2L1U2bzlaemthN2t1UUE0SHJK?=
 =?utf-8?B?ejZPMlpTaTNTOXdUVnFPOTUySnNGVlZHQUUyVjFQbnM5czNMQkNYNGRBTGlx?=
 =?utf-8?B?eXp4ZGRyT2xubURxQnZNNkxPR0JWSzdXaTBaWENNR1Ric0RMWE02NU5uZDlO?=
 =?utf-8?B?eUFZc2tPVjlZbjFpY09DeUFMYk0xN3JUR3ZCa1V0OWxMcDgxeGtQblpkYjNR?=
 =?utf-8?B?cVNEM2pqQXlKNHlTbjZkT3Z4UzNrTkk2WnRJMjVSNVVSQlBVR1lEWkkzUVhF?=
 =?utf-8?B?OHpCVktzcmo5UXc0dGVMZmk5NmIrK2JZdW5GRm1DdUY3V2dpekFyN1U4b1Ba?=
 =?utf-8?B?SGFCdkowSDlrejV5bDc0WDhSSHh6SUNvUVVzc0x4bVlDeDRXNnJsRXlWS25B?=
 =?utf-8?B?NU9vRlAzZ0JseGFJT0cvMlY0K0loa3J6R2l0LzlqWkR5ek54azh0NEo3Yk5D?=
 =?utf-8?B?SmQwV2MrSWpwb0FVVzJoSDd1dTNncmhGeUFENTRzOTQrRFhKc0ZtTjN2THBQ?=
 =?utf-8?B?N2MySUJsZGY5QWVBNlRLdU41aXZuSGt6eGdYd2l3U1FZbzJ0SGRTKzFGSzBv?=
 =?utf-8?B?TFVrcUVpNWIzdXowZ1k2Y1lTRHJzUUk0Nk54T0V5cTZ3YXQ1Z3pPYVBIZjdF?=
 =?utf-8?B?bHlxRi9JRjh4azc1YUZ5T00rUVlxbm1vcWNOWXFHUzZyQVZpY2M3TXVEQlVs?=
 =?utf-8?B?Tmw3NWM4M0Fnb3Y1d3VmQ0E1dFZacXNpczRmaVZkQSsxeDlCLy9JeVVJMnNM?=
 =?utf-8?B?cXdXd29mNGhhL1hrQVcvTUFSVnZmQlBGNDNsRjI4bzY4TXErYlloZW8wUStm?=
 =?utf-8?B?Mlc0bGtDMTZFYVFOaENuV1YzYk9SMmI3b2RBSzRkTVZWNFYwNmNJazRjaTM3?=
 =?utf-8?B?a080aG5XWWVMMDMzVHd1bmFaQlFqM2FTTEVDTHBIMDJWNFV4Qk52RU1SbFNx?=
 =?utf-8?B?VWdpakYwaDJUY1lxbm9WY3B4R3B0Ym4rWFl0SzVUODY4N1FJeTJXOU1wOHhW?=
 =?utf-8?Q?13jQNGYlzMOvouJz2Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da6f9b4-ed13-475c-c60e-08de6655b002
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2026 14:32:14.6008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFvyeInqwySjEHVD22J4uq79noV3IbfMXOTF/CYoz7PzbznbS9L283RUc/o7ThUN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8333
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214764-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,tencent.com,google.com,vger.kernel.org,infradead.org,suse.com,cmpxchg.org,suse.cz,gmail.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 323A210629F
X-Rspamd-Action: no action

On 7 Feb 2026, at 9:25, Mikhail Gavrilov wrote:

> On Sat, Feb 7, 2026 at 8:28=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>>
>> OK, it seems that both slub and shmem do not reset ->private when freein=
g
>> pages/folios. And tail page's private is not zero, because when a page
>> with non zero private is freed and gets merged with a lower buddy, its
>> private is not set to 0 in the code path.
>>
>> The patch below seems to fix the issue, since I am at Iteration 104 and =
counting.
>> I also put a VM_BUG_ON(page->private) in free_pages_prepare() and it is =
not
>> triggered either.
>>
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index ec6c01378e9d..546e193ef993 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -2437,8 +2437,10 @@ static int shmem_swapin_folio(struct inode *inode=
, pgoff_t index,
>>  failed_nolock:
>>         if (skip_swapcache)
>>                 swapcache_clear(si, folio->swap, folio_nr_pages(folio));
>> -       if (folio)
>> +       if (folio) {
>> +               folio->swap.val =3D 0;
>>                 folio_put(folio);
>> +       }
>>         put_swap_device(si);
>>
>>         return error;
>> diff --git a/mm/slub.c b/mm/slub.c
>> index f77b7407c51b..2cdab6d66e1a 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -3311,6 +3311,7 @@ static void __free_slab(struct kmem_cache *s, stru=
ct slab *slab)
>>
>>         __slab_clear_pfmemalloc(slab);
>>         page->mapping =3D NULL;
>> +       page->private =3D 0;
>>         __ClearPageSlab(page);
>>         mm_account_reclaimed_pages(pages);
>>         unaccount_slab(slab, order, s);
>>
>>
>>
>> But I am not sure if that is all. Maybe the patch below on top is needed=
 to find all violators
>> and still keep the system running. I also would like to hear from others=
 on whether page->private
>> should be reset or not before free_pages_prepare().
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index cbf758e27aa2..9058f94b0667 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1430,6 +1430,8 @@ __always_inline bool free_pages_prepare(struct pag=
e *page,
>>
>>         page_cpupid_reset_last(page);
>>         page->flags.f &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
>> +       VM_WARN_ON_ONCE(page->private);
>> +       page->private =3D 0;
>>         reset_page_owner(page, order);
>>         page_table_check_free(page, order);
>>         pgalloc_tag_sub(page, 1 << order);
>>
>>
>> --
>> Best Regards,
>> Yan, Zi
>
> I tested your patch. The VM_WARN_ON_ONCE caught another violator - TTM
> (GPU memory manager):

Thanks. As a fix, I think we could combine the two patches above into one a=
nd remove
the VM_WARN_ON_ONCE() or just send the second one without VM_WARN_ON_ONCE()=
.
I can send a separate patch later to fix all users that do not reset ->priv=
ate
and include VM_WARN_ON_ONCE().

WDYT?

>  ------------[ cut here ]------------
>  WARNING: mm/page_alloc.c:1433 at __free_pages_ok+0xe1e/0x12c0,
> CPU#16: gnome-shell/5841
>  Modules linked in: overlay uinput rfcomm snd_seq_dummy snd_hrtimer
> xt_mark xt_cgroup xt_MASQUERADE ip6t_REJECT ipt_REJECT nft_compat
> nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet
> nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
> nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 nf_tables qrtr uhid bnep sunrpc amd_atl
> intel_rapl_msr intel_rapl_common mt7921e mt7921_common mt792x_lib
> mt76_connac_lib btusb mt76 btmtk btrtl btbcm btintel vfat edac_mce_amd
> spd5118 bluetooth fat snd_hda_codec_atihdmi asus_ec_sensors mac80211
> snd_hda_codec_hdmi kvm_amd snd_hda_intel uvcvideo snd_usb_audio
> snd_hda_codec uvc videobuf2_vmalloc kvm videobuf2_memops snd_hda_core
> joydev videobuf2_v4l2 snd_intel_dspcfg videobuf2_common
> snd_usbmidi_lib videodev snd_intel_sdw_acpi snd_ump irqbypass
> snd_hwdep asus_nb_wmi mc snd_rawmidi rapl snd_seq asus_wmi cfg80211
> sparse_keymap snd_seq_device platform_profile wmi_bmof pcspkr snd_pcm
> snd_timer rfkill igc snd
>   libarc4 i2c_piix4 soundcore k10temp i2c_smbus gpio_amdpt
> gpio_generic nfnetlink zram lz4hc_compress lz4_compress amdgpu amdxcp
> i2c_algo_bit drm_ttm_helper ttm drm_exec drm_panel_backlight_quirks
> gpu_sched drm_suballoc_helper nvme video nvme_core drm_buddy
> ghash_clmulni_intel drm_display_helper nvme_keyring nvme_auth cec
> sp5100_tco hkdf wmi uas usb_storage fuse ntsync i2c_dev
>  CPU: 16 UID: 1000 PID: 5841 Comm: gnome-shell Tainted: G        W
>       6.19.0-rc8-f14faaf3a1fb-with-fix-reset-private-when-freeing+ #82
> PREEMPT(lazy)
>  Tainted: [W]=3DWARN
>  Hardware name: ASUS System Product Name/ROG STRIX B650E-I GAMING
> WIFI, BIOS 3602 11/13/2025
>  RIP: 0010:__free_pages_ok+0xe1e/0x12c0
>  Code: ef 48 89 c6 e8 f3 59 ff ff 83 44 24 20 01 49 ba 00 00 00 00 00
> fc ff df e9 71 fe ff ff 41 c7 45 30 ff ff ff ff e9 f5 f4 ff ff <0f> 0b
> e9 73 f5 ff ff e8 86 4c 0e 00 e9 02 fb ff ff 48 c7 44 24 30
>  RSP: 0018:ffffc9000e0cf878 EFLAGS: 00010206
>  RAX: dffffc0000000000 RBX: 0000000000000f80 RCX: 1ffffd40028c6000
>  RDX: 1ffffd40028c6005 RSI: 0000000000000004 RDI: ffffea0014630038
>  RBP: ffffea0014630028 R08: ffffffff9e58e2de R09: 1ffffd40028c6006
>  R10: fffff940028c6007 R11: fffff940028c6007 R12: ffffffffa27376d8
>  R13: ffffea0014630000 R14: ffff889054e559c0 R15: 0000000000000000
>  FS:  00007f510f914000(0000) GS:ffff8890317a8000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00005607eaf70168 CR3: 00000001dfd6a000 CR4: 0000000000f50ef0
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   ttm_pool_unmap_and_free+0x30c/0x520 [ttm]
>   ? dma_resv_iter_first_unlocked+0x2f9/0x470
>   ttm_pool_free_range+0xef/0x160 [ttm]
>   ? __pfx_drm_gem_close_ioctl+0x10/0x10
>   ttm_pool_free+0x70/0xe0 [ttm]
>   ? rcu_is_watching+0x15/0xe0
>   ttm_tt_unpopulate+0xa2/0x2d0 [ttm]
>   ttm_bo_cleanup_memtype_use+0xec/0x200 [ttm]
>   ttm_bo_release+0x371/0xb00 [ttm]
>   ? __pfx_ttm_bo_release+0x10/0x10 [ttm]
>   ? drm_vma_node_revoke+0x1a/0x1e0
>   ? local_clock+0x15/0x30
>   ? __pfx_drm_gem_close_ioctl+0x10/0x10
>   drm_gem_object_release_handle+0xcd/0x1f0
>   drm_gem_handle_delete+0x6a/0xc0
>   ? drm_dev_exit+0x35/0x50
>   drm_ioctl_kernel+0x172/0x2e0
>   ? __lock_release.isra.0+0x1a2/0x370
>   ? __pfx_drm_ioctl_kernel+0x10/0x10
>   drm_ioctl+0x571/0xb50
>   ? __pfx_drm_gem_close_ioctl+0x10/0x10
>   ? __pfx_drm_ioctl+0x10/0x10
>   ? rcu_is_watching+0x15/0xe0
>   ? lockdep_hardirqs_on_prepare.part.0+0x92/0x170
>   ? trace_hardirqs_on+0x18/0x140
>   ? lockdep_hardirqs_on+0x90/0x130
>   ? __raw_spin_unlock_irqrestore+0x5d/0x80
>   ? __raw_spin_unlock_irqrestore+0x46/0x80
>   amdgpu_drm_ioctl+0xd3/0x190 [amdgpu]
>   __x64_sys_ioctl+0x13c/0x1d0
>   ? syscall_trace_enter+0x15c/0x2a0
>   do_syscall_64+0x9c/0x4e0
>   ? __lock_release.isra.0+0x1a2/0x370
>   ? do_user_addr_fault+0x87a/0xf60
>   ? fpregs_assert_state_consistent+0x8f/0x100
>   ? trace_hardirqs_on_prepare+0x101/0x140
>   ? lockdep_hardirqs_on_prepare.part.0+0x92/0x170
>   ? irqentry_exit+0x99/0x600
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  RIP: 0033:0x7f5113af889d
>  Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00
> 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2
> 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
>  RSP: 002b:00007fff83c100c0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>  RAX: ffffffffffffffda RBX: 00005607ed127c50 RCX: 00007f5113af889d
>  RDX: 00007fff83c10150 RSI: 0000000040086409 RDI: 000000000000000e
>  RBP: 00007fff83c10110 R08: 00005607ead46d50 R09: 0000000000000000
>  R10: 0000000000000031 R11: 0000000000000246 R12: 00007fff83c10150
>  R13: 0000000040086409 R14: 000000000000000e R15: 00005607ead46d50
>   </TASK>
>  irq event stamp: 5186663
>  hardirqs last  enabled at (5186669): [<ffffffff9dc9ce6e>]
> __up_console_sem+0x7e/0x90
>  hardirqs last disabled at (5186674): [<ffffffff9dc9ce53>]
> __up_console_sem+0x63/0x90
>  softirqs last  enabled at (5186538): [<ffffffff9da5325b>]
> handle_softirqs+0x54b/0x810
>  softirqs last disabled at (5186531): [<ffffffff9da53654>]
> __irq_exit_rcu+0x124/0x240
>  ---[ end trace 0000000000000000 ]---
>
> So there are more violators than just slub and shmem.
> I also tested the post_alloc_hook() fix (clearing page->private for
> all pages at allocation) - 1600+ iterations without crash.
> Given multiple violators, maybe a defensive fix (either in
> split_page() which is already in mm-unstable, or in post_alloc_hook())
> is the right approach, rather than hunting down each violator?
>
> --
> Best Regards,
> Mike Gavrilov.


--
Best Regards,
Yan, Zi

