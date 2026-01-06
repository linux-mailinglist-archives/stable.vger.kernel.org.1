Return-Path: <stable+bounces-205047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E27CF757D
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 09:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D871301A19D
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 08:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59E12BD597;
	Tue,  6 Jan 2026 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="Vrhj2GoN"
X-Original-To: stable@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013032.outbound.protection.outlook.com [52.101.83.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A810D277C96;
	Tue,  6 Jan 2026 08:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767689337; cv=fail; b=QXtRhBoPy+K3yysIILe24xzBiNDCkzohYv08XHCSS8DDsalQ5WRdtorxj3ldj/F8NigcionJMpw8Zq1+9UmlzDFu7V8yXoo0RCjwbiFvkY7GDTj+2wz9b3DgDmffc7KpTkMtrEroSdaGUZeuF5ByGVIH20Ik7c4Ki77S6o7dL+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767689337; c=relaxed/simple;
	bh=bPXdw5NEBH+jadp3rJUVufa6rnvUTzi0GSCWoSapPWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=djQABVW50US4k2xfniepc/K1eS5F7OcuiP9w2twixH4fIsSMxbIGMPXj7Gi1ocU2/ANSyOroek4kKxYgzhLn9p36INLgC4hCmROpdVPPzNoaAU0VDNBc2eFjn043ODswkV3tU3LizeyUdNdnI8LOTxA4HdKhqwKZJozwgmACtVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=Vrhj2GoN; arc=fail smtp.client-ip=52.101.83.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RV7nDIPNlKcHYlbOBPN9qdldDwP8C0nagUvsugm99ysmHEes9Lt2x7sf0u2LZyth0xAb6lkNdsMRYavhn7ROfV0yd0LBQeIC8doPZlM9qMEI09XsRgsD7UX+nP2D5K3+uLLOTtVXd3OcltE1iizOk1se55cAF95WEM/sW+CLVC3HkNK4nq8G9FZNSMcLL0SUu2XhgXTRN5bVA/Bja4ZTIoRyEZxlYoxV4+OckcK3bGLbV/MfWbW+1X7GgwykhtLFEZs9ZJ9T1r2datHl3N3o+y7KpOahCyPOBMbsd043ZV1CrKg5ftYm8dJqAsKu/sjKGHZTPs6i7oVb7TbHlE8cDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cVx83CiqR6uLx2NiAYQmE/psbX07IM0FEyMC1VlDHs=;
 b=vLCAXPC9mXJdXpkwBaeSOm7SaAtwEoCzRz6UK28xDsBOdrjEVDOTF01602RllOB1HmPczAx558pxKMI8FDlt4ECg9waL0gHCRQCVRoyQUZ6X3/hbtGCLB6YmmrzgftJkldMZORco2bFzxOIjQO2f1syP8if9Qt8nhCAcCk/GV+sr+eAnXDzhMlUBgfrmaMcM6ew+/FwPHPapocbLnkPwcxI/LhZegUs7oH5gG3BfKZLyyr5i9emlKZ9+D3JUTWcrcUftXWiSTjGk+FWwGK3euFa8X5GZS60L1WypfuKjikbU4EXkwCcHKtyMh+5XW5I4yEON2wGj4ayIcnYFadDUxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=google.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cVx83CiqR6uLx2NiAYQmE/psbX07IM0FEyMC1VlDHs=;
 b=Vrhj2GoNn9lzivntACtwK4EaXb+6fKp0a07o+sU5NZgnv5IEiWQMHn/C4qNEBe04plxPXpilElmA0htGuQnlu4pB8JXzoVeHTLg4YOWJun5ik8RFgG8ZP+Y6SCapKYiAoMxZWY2Q6Smi5a02NiNdjPX5qygSHA+8VpStEohtFSno/M+vyezAMdyxF++9bmOsTLU9/w/7WtFVEEq45gAYJVIeG//HFwQsvnBTnH7j/nJDOUGQuGmfMoG3Kh+Xp7xXD50BfAIpW8V2luDrCg0Clc6+aqHvnbO2gpbNBLiA62+cWaiyaoNe/CGBmyxwj5vUCKw+pqcMSWcw3BI88w+wkA==
Received: from AM6P191CA0101.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8a::42)
 by AM0PR10MB3714.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:154::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 08:48:48 +0000
Received: from AM3PEPF00009BA1.eurprd04.prod.outlook.com
 (2603:10a6:209:8a:cafe::25) by AM6P191CA0101.outlook.office365.com
 (2603:10a6:209:8a::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Tue, 6
 Jan 2026 08:48:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 AM3PEPF00009BA1.mail.protection.outlook.com (10.167.16.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 08:48:47 +0000
Received: from RNGMBX3003.de.bosch.com (10.124.11.208) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 6 Jan
 2026 09:48:35 +0100
Received: from [10.34.219.93] (10.34.219.93) by smtp.app.bosch.com
 (10.124.11.208) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 6 Jan
 2026 09:48:35 +0100
Message-ID: <d4fc5d93-d147-4263-a672-4b6016957327@de.bosch.com>
Date: Tue, 6 Jan 2026 09:48:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2] rust: bitops: fix missing _find_* functions on 32-bit
 ARM
To: Alice Ryhl <aliceryhl@google.com>, Yury Norov <yury.norov@gmail.com>,
	Burak Emir <bqe@google.com>, Andreas Hindborg <a.hindborg@kernel.org>
CC: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor Gross
	<tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
	<rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260105-bitops-find-helper-v2-1-ae70b4fc9ecc@google.com>
Content-Language: en-GB
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20260105-bitops-find-helper-v2-1-ae70b4fc9ecc@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA1:EE_|AM0PR10MB3714:EE_
X-MS-Office365-Filtering-Correlation-Id: 0571a298-e95d-4126-a96a-08de4d006857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTRyb0R5ektBREpueFMvbFhDTHpjNUpSYXFMQmpjWWlDd3BIY1ZEZmFxbUZs?=
 =?utf-8?B?aGNCTHhyZW81RitPeHcxNERiajgwRE1Jd2VBUkR6VVgyWlp6UGpWTUVkSGFL?=
 =?utf-8?B?NlgybXlvTmVaYm1GQlFMdXc2bHVGSWFidnJ3T1hSUnlQNEdDTnlFSEpyZ05m?=
 =?utf-8?B?WVN0UHArS1ZUUUtlZ1FwU0dHMmd3SVp2a01jMEVMS0RBODI1TVRXR1NKQytH?=
 =?utf-8?B?THhKNEpRejRYV000YmREQmpzNllSSkdFcVJjaGdyQlpINFQ4OVQxb3I3U2k4?=
 =?utf-8?B?Vm56VnUzM1dXOXBqVlgxK0wwMWc0TFlMemMxUnU4alNTUmdWTDhlWDY2VGI5?=
 =?utf-8?B?Y2Q0ZVRMYXQwWk1aQ2dEbk5QYVhaaDRGRFlXZW9INEUzZkRpUENtd0N4QStB?=
 =?utf-8?B?QWZFbE05TEp5RVg4d25UZ29mSEJYQzd1UmZSaFR3RjQ4TkpOZVdWNU54QXFK?=
 =?utf-8?B?WndtMzhIOWcvS0hDRHBTblFodWNPdXR1aHh5alJldktUSE5QTFZEME93eTlo?=
 =?utf-8?B?Qk1NbXRseGxxR2s0U1J6VDA5YTVTdFBZNDBneHZoSk1MbTFuRFVsekp4Vm4r?=
 =?utf-8?B?d1ltaVZwYWJZVDg0b1M3YThkRHl6dE16RjdnU1lhc2J2cUtOTXF6UUZKM1Qr?=
 =?utf-8?B?UVFZeCtPTDRINFQ4R0liK281aTIyY3B0Mmw3bVVzUHhNTzlJSU5SNmdNTjFh?=
 =?utf-8?B?UjV1d1pIbnFlKy9XQ1VqMGxhaEw4WllzWnNYRE5BcUwrWVY1aHlWU1V3bzhv?=
 =?utf-8?B?aWxBSk5NOWxwQ1JFSFFHdUQxTk54ZEpQSFVEQTBpYnpMYlMySEFiYlpWMnhw?=
 =?utf-8?B?aThHVnJtYzlZVVpMOWN5TzJ2ZXYreTNzc3UrZ1lYQnNzQzMrb1lxeWZEa2pG?=
 =?utf-8?B?ZURJbUs4dW5kRENwT2dqQjBkQy96U2hJczBIaUxQMEFrNERXSU9lblorU1A0?=
 =?utf-8?B?cVZQRlhkYncvbytlaWxvZWJDNDcwckJhOUNwZ2ZhNldqSkdSRkhLZTFyQlZ5?=
 =?utf-8?B?ci9hL2VEVmJLWmczVkNUYnorZ1hsMkJscmpCKzBkcGhUUzR1Zy9hTXVJL3Rt?=
 =?utf-8?B?SWI1cUZrUGlGUHNaMlhsT1UvTUQ1LzR6VjZKMU53c0hUUlVxTC9ucVlhVmJq?=
 =?utf-8?B?Z1oxZ3hJT2hQMlV4LzZ5ZGszckY4MnZiNDhKSmdRRlIyOExMUWZzbVlUUVpU?=
 =?utf-8?B?d09rYnlWWDJINlFxUU0vMzAvaFUrMXpVbmJEdGtTcElSaWFURy9Ob1ZZZENH?=
 =?utf-8?B?elZkdlVMeTI1NWJjMWtWQmxiTnRRL0krTHdpRDd3UEp4VGsxNGMvQk9hZDVk?=
 =?utf-8?B?Z2R6cUYwL1R0RGQ3QlhBWFZ4dDRIcCtRcjJOZkRtYUgzOEpmK2FRVFduS1U1?=
 =?utf-8?B?L3Vlb1A5S1NOZHJrL0V5cE5OUEt3ME9EQmtHQS9ldUN4cUd1UWd2QXV1NEhT?=
 =?utf-8?B?UmxaaDV5bkg1eGQ2VTdteHhjcG1YRHVOREJmckt2RWZLUlpYT3RPZ1k2Rndt?=
 =?utf-8?B?UzBPRk9oS0VzdERmNXdKekdZSGIrUHBNbUo2eTF0NG5Ub2gyYzZQZk9hNVVH?=
 =?utf-8?B?a2luREJ1ZVkzSzVyVHV5aC9rbHRUS2t1cWNqeUlWYS9vKzE4b3ZOajNIdGt6?=
 =?utf-8?B?MWNHMmpKdVZia1kvZE9QMmNCb2F0MnNwSmFkYldCdFpUNzBNVmcwN24zdDIr?=
 =?utf-8?B?NktTcjZ2QWZWMGNyQlV5ZTdEL0VnQzhPM1MzUEp0UmlQb0dZMDJPR2ZDc2po?=
 =?utf-8?B?cFphblJ4amh1QlJ2eFJCNWhZeUVuVm5SVks2TTlNNzN6S2dHQkNsMVJ1YmNY?=
 =?utf-8?B?bFJtSnFSdERhaUxsWVFUL1pHSWI0RnVxSW1KWTQ3QWtPbTlGRFRSOWV5TzlO?=
 =?utf-8?B?SThBQ3JYMHl4RCsydUVBRzNFVHZBN01XSVZCS2xCTW1icU4wSnZLaTNETVJF?=
 =?utf-8?B?M0d6MStodkhtUkhpQ3c1ZGlKc0ZhTDhsSkhPMEk0WU8zbjBxUGNzendRaENp?=
 =?utf-8?B?K2gyVFBwc3I2RzZscjdqTitEUlZXdWQ0eUErNkw5SW45T0dGQ0lPK3ZwUnlx?=
 =?utf-8?B?VDN5MDZMV1Y4ei9TSEl0OTUyY1lRNjN5R2VyY0tpVjVxemdUeHNlUTk3T2V5?=
 =?utf-8?Q?2zgc=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 08:48:47.8341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0571a298-e95d-4126-a96a-08de4d006857
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3714

Am 1/5/2026 um 11:44 AM schrieb Alice Ryhl:
> On 32-bit ARM, you may encounter linker errors such as this one:
> 
> 	ld.lld: error: undefined symbol: _find_next_zero_bit
> 	>>> referenced by rust_binder_main.43196037ba7bcee1-cgu.0
> 	>>>               drivers/android/binder/rust_binder_main.o:(<rust_binder_main::process::Process>::insert_or_update_handle) in archive vmlinux.a
> 	>>> referenced by rust_binder_main.43196037ba7bcee1-cgu.0
> 	>>>               drivers/android/binder/rust_binder_main.o:(<rust_binder_main::process::Process>::insert_or_update_handle) in archive vmlinux.a
> 
> This error occurs because even though the functions are declared by
> include/linux/find.h, the definition is #ifdef'd out on 32-bit ARM. This
> is because arch/arm/include/asm/bitops.h contains:
> 
> 	#define find_first_zero_bit(p,sz)	_find_first_zero_bit_le(p,sz)
> 	#define find_next_zero_bit(p,sz,off)	_find_next_zero_bit_le(p,sz,off)
> 	#define find_first_bit(p,sz)		_find_first_bit_le(p,sz)
> 	#define find_next_bit(p,sz,off)		_find_next_bit_le(p,sz,off)
> 
> And the underscore-prefixed function is conditional on #ifndef of the
> non-underscore-prefixed name, but the declaration in find.h is *not*
> conditional on that #ifndef.
> 
> To fix the linker error, we ensure that the symbols in question exist
> when compiling Rust code. We do this by definining them in rust/helpers/

Just a quite minor nit: typo: definining -> defining

Dirk

