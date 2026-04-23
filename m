Return-Path: <stable+bounces-240510-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mN0JNTEy6mkCwwIAu9opvQ
	(envelope-from <stable+bounces-240510-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 16:52:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA645453E81
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 16:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E6D1301AABD
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 14:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FA634887E;
	Thu, 23 Apr 2026 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="UNYSMOnJ"
X-Original-To: stable@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021075.outbound.protection.outlook.com [52.101.95.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A88D356A38;
	Thu, 23 Apr 2026 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776955927; cv=fail; b=WKHaG9HOs2bKGp79WziXzLtghY+wEI3J72HKaFPEXgER5WXysYXXWkKLtcxlTyHB591UiDpnJl7UaKDv0hz4xK4cECLoZtWwYJF52y14QfflOsqsbj7a+8kRj9v/TuRGrHkKzimD6VE3vrFEhkyGFGgCf7hmdl2NnsDqihp3lAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776955927; c=relaxed/simple;
	bh=YfCycK6pNw8Jb7DiPngKTAasenR5iAqZtvfVeEbrsa0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bvRlxNXGyCB+j53H6ZZINBs+jSJ2L1DbxvNQ/08PcYS+8hm74gViYX3wDVwYR4OFuAcGZ93tuMHw9cIsf9AUDy49qhHDG1ISwiVmaXzXD8as//AxC/iKt5Pw6pQHSwISZG4GSZ25hOXaBHrycKHUQRBg9kdw+X/zfKj5nbL4s9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=UNYSMOnJ; arc=fail smtp.client-ip=52.101.95.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOD/R3M3GmFR4avadHpGBSZosL5Vcn6EctKQKA6p+PrPG/rNm2KgV4SzsE/tiF7m+yDHe9mbQ9Fix/WDbKAppZlDpyq77hm9XFxcaYK4cFreqGcCupxWSxYt6PtBBoe/c88JicZDz5FoOQWZpRvh867xYj8RJWzYEutl1fnwd4Ql5H98gr+qsVyBSTD0ne9zFAz0+vQWWW9MkA2TOWI9AKHDlUXe/bc/T1bDrFUC4Mdvzf3JLkAyHM68hlRyGuY4iH57dnsTnhibCx0GiMJ2xjm3lVovvkmScBgsOLqpg5SY3LeTvTUuRO1S677vRy2xqIYZ/Cs7TfjYrN9a9smL3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBY2oEFvl5WwOTxrTpn3kaNAExssMVBMfaigIhTf1So=;
 b=K9e+I/jtx81OQAi52ZvdGeC+vxb1M62gv2TrtofVDkPjG2ZAIhqECh1s1ah5TKf0pJeb2XTlmYriipOu/D7BK9oTdW/14zYtZd7JtHhm0qqab0w1k0Jooy+twPFPfniDB4VYDA/TuyB6M4gOsCR3uZ+0hz/bNQeajJA21FFp2Ok/Vi5fb+BT2N5eBnLtclKM1/F+ObKsLjJHzu9pMw34toNL2KERdHNfEKYP/Zt7ioNgxCKug2n5uscoKS2EAsX3jlvFk2ZhJBwOA17har+NZzLYauJdSd6XxhjSEZfqO9C4mo/8JRKYE8qnT5GvIPkplJjhBrYCCIYQvq+c5cuoTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBY2oEFvl5WwOTxrTpn3kaNAExssMVBMfaigIhTf1So=;
 b=UNYSMOnJmneDAasoumaC9m0B0S1G/vRyBRctftZ1E8EfZZz2jdvE1ezGZg9yxQFOCE0J47qgqFQDAX2/Zxp0t6YfhN7f0nL/vHqSu45k2gLaiJua9y11f5MWsvlwYr2lNlK91P5QaLRhe697ahfkBlqJfS9sMrxQOAx/dTMfrY4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by CW1P265MB8468.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:26e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 14:51:59 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 14:51:59 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 23 Apr 2026 15:51:50 +0100
Subject: [PATCH v2 2/2] rust: pin-init: fix incorrect accessor reference
 lifetime
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-pin-init-fix-v2-2-ee3081093a0e@garyguo.net>
References: <20260423-pin-init-fix-v2-0-ee3081093a0e@garyguo.net>
In-Reply-To: <20260423-pin-init-fix-v2-0-ee3081093a0e@garyguo.net>
To: Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776955915; l=10178;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=YfCycK6pNw8Jb7DiPngKTAasenR5iAqZtvfVeEbrsa0=;
 b=o8hAyd785afU6Pva6OPSpeztVu/+DhwgQx3yqlRtf9NgkVSMTLIfjRrpsvzo5YQvvq3u56Lt/
 FPyXLwduaCABS7RwSJ7lAy8NdrJLDDmpCTignuxKxRa1S1cGkLgxAHr
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0115.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::19) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|CW1P265MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: b5568a75-2f74-4e0c-fd34-08dea147dda7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SS37+wDCJ5NxbdDfntsP1Tjuz1SMrkKMkormyfwylQPAzro5BWcEo6kei6EIP/tfotcMX9khFNke00VmIq5qjwFivuGKuW+EEWlZutC+OrpcL5zx9YqEtrbnjCnwGBksgUcSDE7L+tlh7feCmqtacmz1aaVVRMtDjmnr+7/97q/vdCfppVSVfo/si6xdLbRc+mOYSm6KF6oE9UHamK67FJRsi9qjnkhjN5fCAbQv4BuCQ6DKmkQwFliRM5vYRbJxYjekIW667J3XypnA1DxeuNG/SWkv6J7GfXFgbHKH1rg87JpfMxcwdXOpSVTrjE+1cmZ8X2Ouv0XMWvgoRQFN4CQceUpspGyaAMt9+6qJEsQhlDtQD9KbjptZfniue2MZuwmGM/NUnkufXMGedrQQPlzKKBcAsK4Cxibs1z3JOT+SIWqftSnG8oGhInZGpJC2K4pmE4ewIaSv3YX6B2EE9E9DWIzrN1fiIcMmw8fziEyC1Os1FcScPJcTZDrQnhaBCVoNYOki3W0PDxQngmxSpSOwA2OwRRE6GzGHMCbh1lgA8tB8GKzieXsh46PqPPdMAmHVX57yDZH9+3pRpMDJO9HhsFj3qXeumqNt80ijY9hOFPhzQ+1er5q9DCU4c/rR+S1WwtGxO4lKQwbDk4WYym0d0JNQymk+Td+7KVlxT/8gsz7PKORg0GW9ZgrcyOPqCAPQgvA/8PnryqixWImTqHeCQ1NAjGsW0jAD8D4po38=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVpnN2RSZ3dZWWhCV1RUQkxOK0t3aHlGOWl3bHJvS3lMeVZNdW41S0xnME1m?=
 =?utf-8?B?eHhLM3BGbjBjRS9qaDNOUG5uNkpKZkNqZHQ4ajN2aUVjcnpLUjcrVDJOZUhH?=
 =?utf-8?B?MTREVFBwZ3FkNStFYnc2d25IcG9ha2s4ZEVWMDdjUCtUR2lSMFRPZGd6akRO?=
 =?utf-8?B?VTNFV1ZpZGJ6dmRtaFB4OUtpQVgwZCsyQTg1Vms3T2tGaEpFRk1ldUlic05U?=
 =?utf-8?B?czgrYnNoaDZVb2IveTNKU24wOE5wKzFqRVpDTGd4clhOYVQ3Vld0REJlcWZI?=
 =?utf-8?B?YjJFYUMxQSthejBnTVdYbG1vWUdVNElXNXM3cXErYTFZcU5BZXF0Y2N5Z1k4?=
 =?utf-8?B?Nk55M2pnWEZPbjhyY2lzOStLdnBwalU0Y0s1MngyOWVxdUcydFpWR0loeGpj?=
 =?utf-8?B?b01KOFV1bVJoakVDL0FLMzBLUWY5a0hKWmNtUEM3RGlCb0NxQ1hXVVhvZ1Ax?=
 =?utf-8?B?RTJLZE1xemV4K09HaUd2YzVRNWxoZE95Syt0aXB1bFhxeGVUTGVHVUpqMi9k?=
 =?utf-8?B?OW9wQ2ZOb0wvR2p3N2dJOFhvRVRtU0pwMGZuN2NLUXNVbEF1UnNuWXVuT0pU?=
 =?utf-8?B?a0E2S0UrSjB1d0FhNlJhOVUxQVJ0dzJGZ3lBS09KUk1xb3ErZDBpalNOWmtz?=
 =?utf-8?B?RG9wZlRabllXTmtvVUUwUGJxaEw3WTdleEtPT0tRZk1JZTd2WmRhdW9KS09I?=
 =?utf-8?B?Q3F5OHhvU1pRTkJNMldIdDJ5enlSaVE1RndTQjF6dGZMUGtIUlNsMGNzbEt5?=
 =?utf-8?B?VjhOb1FORDJvL3dvYXM2dnFUcGprY0VDRVowdE05MVgwZUp3aGYwdHRtQjAz?=
 =?utf-8?B?M2toRG05aklneGJxSm5taW1kL0NTb3RmV25Xd0VlTFloZk1lUC9SdUkyS1BS?=
 =?utf-8?B?YTkwWkJkMFJNYVFtREwwSVlmZ0VML1g2MEJLeW1lcVFudjVQU2lJS1o2ZytI?=
 =?utf-8?B?UmozajBWMmwwQmhxT21qWWVrNE9EVjNhY1Awd0ZNbTA2a0ZFYXd4eVVzc3hX?=
 =?utf-8?B?YzdON3ZUbktwbVkySHpNd1Z6c04yVlhNTFRBY0tQb0hTYlBoQzkrRWhJOEVC?=
 =?utf-8?B?ek5sS0lIT0cwUE9mNFBQSUpQbHFGb0MyUUVHTjVzbWhZWUFLdE1OVkJKL3Y2?=
 =?utf-8?B?cENxbnVxSjZWSCtDY2F5ekRLRzhrTUhUZTc3U0cvd2hBZndvd2VTMlc0VHBE?=
 =?utf-8?B?djVHeTRNK2ExeEp1V2FWZ292c0I3YVZ1SmxBcjNhZ0RXTnVmZFBmaFBweTNU?=
 =?utf-8?B?VVZDaUlKd1o2Nmwvc2FacXgyWjJqZ0g3K1BtYUo1emdLdytjblJhc2R4U3Qz?=
 =?utf-8?B?UWNlRW9SMW04d25BTTNLaGFSR0pjWWNYMkZmVmlaaEFJQ041bDB5eStqa213?=
 =?utf-8?B?NTdNTS9zaW9KRkRpdUdVcEo1dEdGKy94VGd4M2ZKUzk0NFh3d2FoUWRkbEl3?=
 =?utf-8?B?YldPUzBGTjVhKzl4ZFhFSkxLOHF5Z3Q5YUswcTVycElaSko0U3pjekVNbHRG?=
 =?utf-8?B?a2U1ejBycmlLUG5ydnh2WmY1elFWY0tkTHZjWExyWEs5ODl0V010em5TbU1w?=
 =?utf-8?B?WVpoNW5DSExETHJZMDIxQ3FBc3UrZHVZTSszT0xjeVBxUmIvSTVwcytNVkhn?=
 =?utf-8?B?T3ptbTNzMHpVemIxNHBzOU96dWFteE9DM3RFOXRaMDU4RnV2eEl2TFN0SUpi?=
 =?utf-8?B?dnJwMElkWiswdS9WanBCbGRBdFFKbUtIRzJXNWIybjdJSFRpTkc3S1BRZFlY?=
 =?utf-8?B?ZzNoZzFOMkprODB4d1l1bXI0MGw4cDFxaEZhTEppTnJtVzQ4cVAwaWNvdkc0?=
 =?utf-8?B?MmwyV2JXWFc2cllyZ3JZNlJHS0dlUENRM001cTBBOWdvdmQ3RloyUi9kYno4?=
 =?utf-8?B?ellCNm1DNHdGUTYySDJacnBoWlZmd2pMek5SbGo5MVZ3MHMrbkI0MnpkWmhM?=
 =?utf-8?B?K0JUZzBXRUpRYStQREpicjJ2bmcxeTBoYWE0emlFQnpqZXZiUjRRelFvcXdq?=
 =?utf-8?B?bnl2VGxEWjVsaFZDMUJhRktVSmxIZzVQekhMeFAwdkZ3R25mWENOM0JFZGJZ?=
 =?utf-8?B?TjQxZkxUcXdCcWE3eWpUTFR3QUx2ZmZlVWZBckRNK0J2WjdYWTQ4Z1RzZnpI?=
 =?utf-8?B?QlA3ZENHSGZoNzk4cXhWRnd1OWdXVzI4Wmg1NGpyOTFRSjZoSEQzNXo5QjlF?=
 =?utf-8?B?elBsVzRNNDdZUm1lN0xxejRhR2dTKzQraE5udDAxNloxU1k0ejNhbFdEaXVu?=
 =?utf-8?B?a2o0cnVsa3U4R3UxdkNhMUo5Qk8zV21iUEROb2lFejRSSUVaK2dvaDRiajR3?=
 =?utf-8?B?UldvbDRralVNTUtiOGQvNEY0YUYwazJNS1htSi90UDhzajdsV2dtUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b5568a75-2f74-4e0c-fd34-08dea147dda7
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 14:51:56.7726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79TBXW4MXfnqkR7rkxWQWcU4wXg2DMZM21VZJLyN+B4IX2FpPU9QaMk3au5haMzf52R9psnWCjSc9A6n/kmtSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB8468
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-240510-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA645453E81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a field has been initialized, `init!`/`pin_init!` create a reference
or pinned reference to the field so it can be accessed later during the
initialization of other fields. However, the reference it created is
incorrectly `&'static` rather than just the scope of the initializer.

This means that you can do

    init!(Foo {
        a: 1,
        _: {
            let b: &'static u32 = a;
        }
    })

which is unsound.

This is caused by `&mut (*#slot).#ident`, which actually allows arbitrary
lifetime, so this is effectively `'static`. Somewhat ironically, the safety
justification of creating the accessor is.. "SAFETY: TODO".

Fix it by adding `let_binding` method on `DropGuard` to shorten lifetime.
This results exactly what we want for these accessors.

Fixes: 42415d163e5d ("rust: pin-init: add references to previously initialized fields")
Cc: stable@vger.kernel.org
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/pin-init/internal/src/init.rs | 104 ++++++++++++++++---------------------
 rust/pin-init/src/__internal.rs    |  31 ++++++-----
 2 files changed, 62 insertions(+), 73 deletions(-)

diff --git a/rust/pin-init/internal/src/init.rs b/rust/pin-init/internal/src/init.rs
index 0a6600e8156c..ad383023c21a 100644
--- a/rust/pin-init/internal/src/init.rs
+++ b/rust/pin-init/internal/src/init.rs
@@ -249,18 +249,6 @@ fn init_fields(
                 });
                 // Again span for better diagnostics
                 let write = quote_spanned!(ident.span()=> ::core::ptr::write);
-                let accessor = if pinned {
-                    let project_ident = format_ident!("__project_{ident}");
-                    quote! {
-                        // SAFETY: TODO
-                        unsafe { #data.#project_ident(&mut (*#slot).#ident) }
-                    }
-                } else {
-                    quote! {
-                        // SAFETY: TODO
-                        unsafe { &mut (*#slot).#ident }
-                    }
-                };
                 quote! {
                     #(#attrs)*
                     {
@@ -268,51 +256,31 @@ fn init_fields(
                         // SAFETY: TODO
                         unsafe { #write(&raw mut (*#slot).#ident, #value_ident) };
                     }
-                    #(#cfgs)*
-                    #[allow(unused_variables)]
-                    let #ident = #accessor;
                 }
             }
             InitializerKind::Init { ident, value, .. } => {
                 // Again span for better diagnostics
                 let init = format_ident!("init", span = value.span());
-                // NOTE: the field accessor ensures that the initialized field is properly aligned.
-                // Unaligned fields will cause the compiler to emit E0793. We do not support
-                // unaligned fields since `Init::__init` requires an aligned pointer; the call to
-                // `ptr::write` below has the same requirement.
-                let (value_init, accessor) = if pinned {
-                    let project_ident = format_ident!("__project_{ident}");
-                    (
-                        quote! {
-                            // SAFETY:
-                            // - `slot` is valid, because we are inside of an initializer closure, we
-                            //   return when an error/panic occurs.
-                            // - We also use `#data` to require the correct trait (`Init` or `PinInit`)
-                            //   for `#ident`.
-                            unsafe { #data.#ident(&raw mut (*#slot).#ident, #init)? };
-                        },
-                        quote! {
-                            // SAFETY: TODO
-                            unsafe { #data.#project_ident(&mut (*#slot).#ident) }
-                        },
-                    )
+                let value_init = if pinned {
+                    quote! {
+                        // SAFETY:
+                        // - `slot` is valid, because we are inside of an initializer closure, we
+                        //   return when an error/panic occurs.
+                        // - We also use `#data` to require the correct trait (`Init` or `PinInit`)
+                        //   for `#ident`.
+                        unsafe { #data.#ident(&raw mut (*#slot).#ident, #init)? };
+                    }
                 } else {
-                    (
-                        quote! {
-                            // SAFETY: `slot` is valid, because we are inside of an initializer
-                            // closure, we return when an error/panic occurs.
-                            unsafe {
-                                ::pin_init::Init::__init(
-                                    #init,
-                                    &raw mut (*#slot).#ident,
-                                )?
-                            };
-                        },
-                        quote! {
-                            // SAFETY: TODO
-                            unsafe { &mut (*#slot).#ident }
-                        },
-                    )
+                    quote! {
+                        // SAFETY: `slot` is valid, because we are inside of an initializer
+                        // closure, we return when an error/panic occurs.
+                        unsafe {
+                            ::pin_init::Init::__init(
+                                #init,
+                                &raw mut (*#slot).#ident,
+                            )?
+                        };
+                    }
                 };
                 quote! {
                     #(#attrs)*
@@ -320,9 +288,6 @@ fn init_fields(
                         let #init = #value;
                         #value_init
                     }
-                    #(#cfgs)*
-                    #[allow(unused_variables)]
-                    let #ident = #accessor;
                 }
             }
             InitializerKind::Code { block: value, .. } => quote! {
@@ -335,18 +300,37 @@ fn init_fields(
         if let Some(ident) = kind.ident() {
             // `mixed_site` ensures that the guard is not accessible to the user-controlled code.
             let guard = format_ident!("__{ident}_guard", span = Span::mixed_site());
+
+            // NOTE: The reference is derived from the guard so that it only lives as long as the
+            // guard does and cannot escape the scope. If it's created via `&mut (*#slot).#ident`
+            // like the unaligned field guard, it will become effectively `'static`.
+            let accessor = if pinned {
+                let project_ident = format_ident!("__project_{ident}");
+                quote! {
+                    // SAFETY: the initialization is pinned.
+                    unsafe { #data.#project_ident(#guard.let_binding()) }
+                }
+            } else {
+                quote! {
+                    #guard.let_binding()
+                }
+            };
+
             res.extend(quote! {
                 #(#cfgs)*
-                // Create the drop guard:
+                // Create the drop guard.
                 //
-                // We rely on macro hygiene to make it impossible for users to access this local
-                // variable.
-                // SAFETY: We forget the guard later when initialization has succeeded.
-                let #guard = unsafe {
+                // SAFETY: We forget the guard later when initialization has succeeded. If we didn't
+                // forget it, they would not be further accessed again.
+                let mut #guard = unsafe {
                     ::pin_init::__internal::DropGuard::new(
-                        &raw mut (*slot).#ident
+                        &mut (*slot).#ident
                     )
                 };
+
+                #(#cfgs)*
+                #[allow(unused_variables)]
+                let #ident = #accessor;
             });
             guards.push(guard);
             guard_attrs.push(cfgs);
diff --git a/rust/pin-init/src/__internal.rs b/rust/pin-init/src/__internal.rs
index 90adbdc1893b..c3fd7589fd82 100644
--- a/rust/pin-init/src/__internal.rs
+++ b/rust/pin-init/src/__internal.rs
@@ -238,32 +238,37 @@ struct Foo {
 /// When a value of this type is dropped, it drops a `T`.
 ///
 /// Can be forgotten to prevent the drop.
-pub struct DropGuard<T: ?Sized> {
-    ptr: *mut T,
+///
+/// # Invariants
+///
+/// `ptr` will not be accessed or dropped after `DropGuard` is dropped.
+pub struct DropGuard<'a, T: ?Sized> {
+    ptr: &'a mut T,
 }
 
-impl<T: ?Sized> DropGuard<T> {
+impl<'a, T: ?Sized> DropGuard<'a, T> {
     /// Creates a new [`DropGuard<T>`]. It will [`ptr::drop_in_place`] `ptr` when it gets dropped.
     ///
     /// # Safety
     ///
-    /// `ptr` must be a valid pointer.
-    ///
-    /// It is the callers responsibility that `self` will only get dropped if the pointee of `ptr`:
-    /// - has not been dropped,
-    /// - is not accessible by any other means,
-    /// - will not be dropped by any other means.
+    /// `ptr` must not be accessed or dropped after `DropGuard` is dropped.
     #[inline]
-    pub unsafe fn new(ptr: *mut T) -> Self {
+    pub unsafe fn new(ptr: &'a mut T) -> Self {
+        // INVARIANT: By safety requirement.
         Self { ptr }
     }
+
+    /// Create a let binding for accessor use.
+    #[inline]
+    pub fn let_binding(&mut self) -> &mut T {
+        self.ptr
+    }
 }
 
-impl<T: ?Sized> Drop for DropGuard<T> {
+impl<T: ?Sized> Drop for DropGuard<'_, T> {
     #[inline]
     fn drop(&mut self) {
-        // SAFETY: A `DropGuard` can only be constructed using the unsafe `new` function
-        // ensuring that this operation is safe.
+        // SAFETY: `self.ptr` is not going to be accessed or dropped later.
         unsafe { ptr::drop_in_place(self.ptr) }
     }
 }

-- 
2.51.2


