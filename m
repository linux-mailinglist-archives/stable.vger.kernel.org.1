Return-Path: <stable+bounces-206093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED8CCFC119
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 06:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23C13303C20C
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 05:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A255D264A97;
	Wed,  7 Jan 2026 05:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="Yd1zOm7v"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011057.outbound.protection.outlook.com [52.101.70.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A232025BEE5;
	Wed,  7 Jan 2026 05:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767763901; cv=fail; b=lks+W1QCVX/qWRUomp6YuytP7B9Vu6FpVziYNLaJXUucO/cp7/OIagCgi1BouaytfwPVYSM3oWTsdru3eL3wPK0X9cZo97NtGQFRCLwQ/I1pI+y9jnBLiwymFXokRDuEJmbj01bO0zpbMHWfNkuQL7eqdGx9krZcdzc6PsFwLuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767763901; c=relaxed/simple;
	bh=RD3aBrKZlz1bMdre4iuoH22Md0N/9DlqVOezeurZZn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Pfg7HppfCbF7skVadKT3NV9JXdR3+qUEppDCdZsz7WARfn1fsYkB2VPjwnZAaOdY0YuUgJZKtrJ7RQqW3+U6NlT9DAUCVXhVO0OY4ZjLQVuE/ko6ie9fNBLGRcWlkwomS3Q6EHfH6UZVUpwWLlwulVqfJSNVrpQ0gBmSKmXcnUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=Yd1zOm7v; arc=fail smtp.client-ip=52.101.70.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfGxCDFcZHxlnEqMXW6ibITIsT8vJlADk+ilDkMk9wjicGb9uAOrwoK7tTICDDdOiYlp6DOfTTnc4j2+3Ps6e2nnLDEwkdLKZhNlw+InFzzUfWACEaKLdAfbOBDmUFn0WWSmGe89PADsx7XFQk3KOIzFH2toHyPA7CaerxJfiJI5W4YM74bo2B+gFs1OqXCg+rt6YAaj4qbiy7tNr0oybWy/tdFZ8i1uPiW2XPU/ESNIGDFjte59IEfCChmk/KnIaOmZAv759mlqEPoYCWnlOb1jP/rTBb7oj1JfzD2BwOmJgX7KFo6GQ6Fzvn4Tluctk00Ga4pUvamcysY8M5BQBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4x0NAZ3LAIRtYewhv05dlP5SCyvR+ANSLDILw4MeEM=;
 b=HO3dl1+fd8v47l1kax4zmDvv40Nrs1NxZQYXPwU38IDwpHq5iDXDoiggpXF6Osk5ujtNRvk9jSQBLJcuFYQmgEXLHlErvJCp8dywrO6HoUQjVADrtnEhf/Q/1I++OCuswDlQORBrHcvIhc0Z13aEeQ1nc7/QFBt7IPA21FwFsaka622IALiglgSddp+ysCuZBF3tz/w6aTnsWtf8Lq+weYX1iDSrBnGAOswaulw6XYXfD7qHZvhQ8lHjRsSbjIgx//ky1kPQ46LIu46BUyX0Jf7hNU3LW9g+RqFokjgcNi09cnLSMl9nT8EqS/LkGMR9O5lAJC4hkMV/8cr6KPJMEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=gmail.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4x0NAZ3LAIRtYewhv05dlP5SCyvR+ANSLDILw4MeEM=;
 b=Yd1zOm7vrp+LdXNudRAh5JrZbIZIVYg/PPI3OSdflswXb0vtCYuC89XyOf4uMf71lv/577Ed6ct3U9AJsHhBFAhRBrL5Qn5kb3/GTNmhX5iEimXviyZInitWGgBAZ8css1FiIBX3Gd6XR1rSjdeNBXwbGD1T0FnWiAK8YOVkfRTzsQDdHy1zQ4LOqvQNJCI/lI+HkR1DlMPvqDZvz2h01nbxRK2zio1UF8f8+2v8Eld32Ub6zF4q5UKJwv/S9moC4vbMbXPQi8KLuhFOQyEbni+jBuRZ3a+55LFXEf/83hu/mktkN00PM2tj9ksXMnI3IYKqEh/G9PFpwWIZIin7Xw==
Received: from DUZP191CA0045.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::12)
 by PR3PR10MB4047.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 05:31:33 +0000
Received: from DU6PEPF0000A7E0.eurprd02.prod.outlook.com
 (2603:10a6:10:4f8:cafe::3a) by DUZP191CA0045.outlook.office365.com
 (2603:10a6:10:4f8::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 05:31:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 DU6PEPF0000A7E0.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 05:31:33 +0000
Received: from RNGMBX3002.de.bosch.com (10.124.11.207) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 7 Jan
 2026 06:31:20 +0100
Received: from [10.34.219.93] (10.34.219.93) by smtp.app.bosch.com
 (10.124.11.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 7 Jan
 2026 06:31:19 +0100
Message-ID: <d943a735-742c-49ed-bac0-f5e186fc64b2@de.bosch.com>
Date: Wed, 7 Jan 2026 06:31:14 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2] rust: bitops: fix missing _find_* functions on 32-bit
 ARM
To: Yury Norov <yury.norov@gmail.com>, Alice Ryhl <aliceryhl@google.com>
CC: Burak Emir <bqe@google.com>, Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
	<gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor Gross
	<tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
	<rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260105-bitops-find-helper-v2-1-ae70b4fc9ecc@google.com>
 <aVvu3zF2rYKR3XC0@yury>
 <CAH5fLgjtXHH40Pcw=ZoOKPzvJzDA8fohNtC6W6DsfkcE-6vtrQ@mail.gmail.com>
 <aV1InE2bnTLYnMAC@yury>
Content-Language: en-GB
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <aV1InE2bnTLYnMAC@yury>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E0:EE_|PR3PR10MB4047:EE_
X-MS-Office365-Filtering-Correlation-Id: 40cbc58d-05a0-4c45-1cac-08de4dae04e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0ExS1RCdVFMSld0aUFoMEt3UmtNT1RXNVAySjI0WDc0MUJQRGVTYUluc1FU?=
 =?utf-8?B?SytObW1mZGpDcnlGYnk3RjlZOE44WGhJN3NyNEJ6d1hyMlRCTzNLM3kwcEVw?=
 =?utf-8?B?YlYrVHV5VkhiZE9WNnN0TjVTTkMySjZPUUdnYXA0WHpycTE2aWlvTnY3Nlhh?=
 =?utf-8?B?WC9UWDg2cG9VSmtrNSt1OHJ3RCt6YzBqUFdJWGtXMHlvSkNCa0F4SnJnMjYy?=
 =?utf-8?B?d1E4bzJrWjBva2xudWlkeWx1UmFJWHZYdWQwa0MxSXdOMit0SlJBZUhMTENh?=
 =?utf-8?B?VUpUbVZNK0RvQmdVMG5sNExmOVJWSStXOGxtMzNFYWg0cENRaXJaQzdNMGN0?=
 =?utf-8?B?bElXWEdTS0xIYlRUSkxUTzF6bmN2cWN2QkNmWGJiWjQ3OWNDY0x1VFhkSFBr?=
 =?utf-8?B?R1hkQVNVZ1VNQ1ExNERMd3kvY3llK2RYWXlzcHBLZSt6RFVtcTgzR1NuN2Z6?=
 =?utf-8?B?SldsTGZVbkNNWmZ3aXMzSnJ5UGhxeW1rQUdISkJZSEI4SC9lR0o1U1lMODVB?=
 =?utf-8?B?WGhpbFQ0WXY0Rk5veFF1eDFxalZwQkEvYlphelpUUktvd2E1QVRwSTZYUjRY?=
 =?utf-8?B?SVIvczd1dWo3RTZvb25UTTB6U3gvM2ZTekRrVG5xTHlmMytQTnFtVTFYd2x5?=
 =?utf-8?B?VG8xRzdDZmdlWmJUT0JsMFBHVUNxNys3eGpzODdYemZUcHp4SEJEL3pGMFB6?=
 =?utf-8?B?YWhSbmlaZ2JDSllja2RDaEtacDV6MmRTSmVRMkNKL3BiTzRSUmJoc1RFOVBR?=
 =?utf-8?B?SDc0ZmdWYmRXdG1Jd0NwMUZnYzc3SWZlakxmdHRMOC9vcXlRM1ZLV0ZZdXpu?=
 =?utf-8?B?enNwMFdicVc2eGxpQXprT1FMWjQwNzlmclVTQ1F1OTVsVDQ1UUJPelR5R05O?=
 =?utf-8?B?eDVCdHFIdWh5ek1DY1ZFbW9Da1JZSUdKeCtyMnJQRFgrSFZGWktxUGN5VDI0?=
 =?utf-8?B?NTR1aVEvTlFXcjVYOUcvbzRrYVp5M1ZmK1BnRnZwSmZwMGU0ZDVoam45a0x1?=
 =?utf-8?B?a1R1ZU5ZdHIvU1c0TzVUUU50aFRwYmR2WVpOTHpxdHBDTzZtSjVuM0RoM2Y1?=
 =?utf-8?B?a0hGY2JISEJIa0JZa0VNUFZSazV1MjIraXJqb2xlYUlvNllqeTd1dm9nZXFQ?=
 =?utf-8?B?cHBRYXBlOHZjd093NGZHSko1TCt1bTAyZnI1dlF4Y2gxQ3Ayc2lqNDROSHN5?=
 =?utf-8?B?RDJNTnpIeHg5aTk3V3JIb2R3NkJLN3RGTityOUw5WkNsNHhvcUhMVDFlUXpK?=
 =?utf-8?B?cktqZmJtR1JDZmtqbUlwcVhycVcxSmJUYkhaQlE4Y3RUU2c4c3N6N3dlaUdB?=
 =?utf-8?B?MHBSNDJBbERSMGlMYkNPaTlaMHBpQmluN2pZWHE5dU5MVExnYXZob1ZnM2Ux?=
 =?utf-8?B?WHo3Y2dzUXNXN2VNL0c2QnlnWmZRNWN0cCsvcXUzWHU4dW9TT2t1a0YxMGl0?=
 =?utf-8?B?b2xRVVdPTEVHdkRQWVAxdDh0WVFFVzJmdndmYUhSanVRbzFBTjhTYmYweWZ0?=
 =?utf-8?B?MytKOGQwM0xaNGRCd1dFNHlLYzJCelFKcmVaRDZmNnhjNFNhR0VhRVRDMm9r?=
 =?utf-8?B?MXZ6TDNjNEdPZ1A0azBPTlhrOG5tMWxwdUp6Q1pWNlgyNDF3ZHhYSHpoZE4y?=
 =?utf-8?B?OXRFdnlRRGZqengzOXpHYStPZG84UEZHd1BNUzJ2dXN3VTJsT3Y5MC9JUGJq?=
 =?utf-8?B?K2RORXk5WXh6Z3dUblVSTXU4Ym5wYkVWbGlxTFdVUy81RzBBN1BDaFhkUVRB?=
 =?utf-8?B?MHZzSjYyMERub1Rsd3k4RmxlNkx4KzhabG5XTTFyT0Y0N0ZJZzZRTmg2SHBP?=
 =?utf-8?B?eXNsbHRJcEhaZ25mVEMwREpUSEk4RWZEQ1ZKTDQvOGd6bTF0ZjVMbzhyRWRi?=
 =?utf-8?B?YTh2QXFFaUt6UVpqVlZBMmhITjNWT0l5NXBkalVqTGs2UWo0U1FnQUdlS2Ru?=
 =?utf-8?B?ZHFGNVpMalpTN0NwWG1lKytaQzNlSzdsL2hWM2I5TUk0dW1wY3lLT3BPQWds?=
 =?utf-8?Q?9y5NV7D1JVZ3++VvmJHpkZUTYqFWoE=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 05:31:33.3864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cbc58d-05a0-4c45-1cac-08de4dae04e4
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E0.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4047

On 06/01/2026 18:38, Yury Norov wrote:
> On Tue, Jan 06, 2026 at 10:03:10AM +0100, Alice Ryhl wrote:
>> On Mon, Jan 5, 2026 at 6:03 PM Yury Norov <yury.norov@gmail.com> wrote:
>>>
>>> On Mon, Jan 05, 2026 at 10:44:06AM +0000, Alice Ryhl wrote:
>>>> atus: O
>>>> Content-Length: 4697
>>>> Lines: 121
>>>>
>>>> On 32-bit ARM, you may encounter linker errors such as this one:
>>>>
>>>>        ld.lld: error: undefined symbol: _find_next_zero_bit
>>>>        >>> referenced by rust_binder_main.43196037ba7bcee1-cgu.0
>>>>        >>>               drivers/android/binder/rust_binder_main.o:(<rust_binder_main::process::Process>::insert_or_update_handle) in archive vmlinux.a
>>>>        >>> referenced by rust_binder_main.43196037ba7bcee1-cgu.0
>>>>        >>>               drivers/android/binder/rust_binder_main.o:(<rust_binder_main::process::Process>::insert_or_update_handle) in archive vmlinux.a
>>>>
>>>> This error occurs because even though the functions are declared by
>>>> include/linux/find.h, the definition is #ifdef'd out on 32-bit ARM. This
>>>> is because arch/arm/include/asm/bitops.h contains:
>>>>
>>>>        #define find_first_zero_bit(p,sz)       _find_first_zero_bit_le(p,sz)
>>>>        #define find_next_zero_bit(p,sz,off)    _find_next_zero_bit_le(p,sz,off)
>>>>        #define find_first_bit(p,sz)            _find_first_bit_le(p,sz)
>>>>        #define find_next_bit(p,sz,off)         _find_next_bit_le(p,sz,off)
>>>>
>>>> And the underscore-prefixed function is conditional on #ifndef of the
>>>> non-underscore-prefixed name, but the declaration in find.h is *not*
>>>> conditional on that #ifndef.
>>>>
>>>> To fix the linker error, we ensure that the symbols in question exist
>>>> when compiling Rust code. We do this by definining them in rust/helpers/
>>>> whenever the normal definition is #ifndef'd out.
>>>>
>>>> Note that these helpers are somewhat unusual in that they do not have
>>>> the rust_helper_ prefix that most helpers have. Adding the rust_helper_
>>>> prefix does not compile, as 'bindings::_find_next_zero_bit()' will
>>>> result in a call to a symbol called _find_next_zero_bit as defined by
>>>> include/linux/find.h rather than a symbol with the rust_helper_ prefix.
>>>> This is because when a symbol is present in both include/ and
>>>> rust/helpers/, the one from include/ wins under the assumption that the
>>>> current configuration is one where that helper is unnecessary. This
>>>> heuristic fails for _find_next_zero_bit() because the header file always
>>>> declares it even if the symbol does not exist.
>>>>
>>>> The functions still use the __rust_helper annotation. This lets the
>>>> wrapper function be inlined into Rust code even if full kernel LTO is
>>>> not used once the patch series for that feature lands.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: 6cf93a9ed39e ("rust: add bindings for bitops.h")
>>>> Reported-by: Andreas Hindborg <a.hindborg@kernel.org>
>>>> Closes: https://rust-for-linux.zulipchat.com/#narrow/channel/x/topic/x/near/561677301
>>>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>>>
>>> Which means, you're running active testing, which in turn means that
>>> Rust is in a good shape indeed. Thanks to you and Andreas for the work.
>>
>> I've put together this collection of GitHub actions jobs that build
>> and test a few common configurations, which I used to test this:
>> https://github.com/Darksonn/linux
>>
>>> Before I merge it, can you also test m68k build? Arm and m68k are the
>>> only arches implementing custom API there.
>>
>> I ran a gcc build for m68k with these patches applied and it built
>> successfully for me.
> 
> Thanks, Alice! Added in -next for testing. I'm going to send PR with the
> next -rc as it's a real build fix.
> 
> Dirk and everyone, please send your tags before the end of the week, if
> you want.

I see that in -next the mentioned typo is fixed. With that:

Reviewed-by: Dirk Behme <dirk.behme@de.bosch.com>

Thanks!

Dirk



