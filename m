Return-Path: <stable+bounces-186235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A23F5BE62B6
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 04:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43B954F1256
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 02:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1965724E4C4;
	Fri, 17 Oct 2025 02:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oEqgy0Ul"
X-Original-To: stable@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C912475CB;
	Fri, 17 Oct 2025 02:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760669714; cv=fail; b=hEU6HEyiyvqFp/j3culDHcDEL+lj6HL8FUqbMCc9ndPRD9RxPm7Hg0T5dovKD/PO7BWXx9ZILvVZXd60hG26lNVmOoRncrYBYUl1mTlweHm5anmFhenSz7bgRcOck8gzr7GphGH+CfXnannQ9MXk/ZNylvnFDlYX1CsyG8DbY80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760669714; c=relaxed/simple;
	bh=6pa8zTLSip30RmHol0NPC1dcgsp3Dop+7YYguCQSDgI=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=XsDy/SNkG6bPgS2i39JkbKGZVu2s9gLRGn/riYggsjVIiuSo5fyRfMbKOO94jb5iqMpga/CKTydddt5RtW2QNH/RAaZVbJD24Q/fK8Y+IARsoX/dDeL+xdLkV5FvrGTo5NcHqtepbLtzvYcHgxLWpABTIBirAhko9UJ4N1HoZ9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oEqgy0Ul; arc=fail smtp.client-ip=52.101.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCg3mtUrpGJjJjL0kBXLHc6cUUEMkrJDGQ8e+50aMBbithj/APMy7YMbM2PR3Np1jW5kXeOR/LdHg+OZX4MHhZQt9bT2q+lDtlPDY22+zexChh12kwXILvi8IO0dTGJ14xSb4EW5utpjr3uH9hWtskbw6wYGK33x0GsCdRPxrsVeRTJ4S7MHaidtmujaFuAkvPt1MMkTekabpDMQGrcIxUWDJS6vxcOywKM8VfkbUf4BFhh91LfYU7rxAUyZdYMcsSt6KtgrIujmY9qfc56Vf1tlsyrKbVYtLjxZK4NTwi5F/DWpBk+gtXeYWl8bguX34RgercRR7GXnkfle5Uik7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoRUccZSkwxxYlljr2re2n1JC7BvQOokD+u4y2bsxfE=;
 b=Bwe7GlSS0xcDSSDxzP52l9vQ4u8TBphHX4YnKRuIZ6vqlXBjabL7oA8ZnM0RPHI6BmLCEDxG/rONYw9gOjrdW80hWkon3k9aM+K2ZBIT1IRrvSDzu7Bk58n3Z4kNTrinSkNqLTPT4RIzufA3L5VIAX5B7ddzp9iooz9OXf2y8louuqmUx9t5EbKRRLMkqXK0eNE9IuGvoe6DeE31ffeEqqwtk3arVfMwaWtWTq6AVN8seh+cDqSSIHjYj8p31IFJqNRUc+ZOquVdcoe3Nqac3Ts0sOKuuqLavHc5aEhhdCjtOjhDsI1BCQv8RXcEoODQE+md4ZuHcDl6mVL0I1tmyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoRUccZSkwxxYlljr2re2n1JC7BvQOokD+u4y2bsxfE=;
 b=oEqgy0UlS1hHWqEGXRc+wNPfM0ej/uf3D9HUSMJUbE5JDr7mzyCgFnBg6hmnPr8sEFsqgCol8tYSgVG1blpS1abuTnS7i3/MTLa9CKyfKVEBTBjrslVjjSIzo2D67lxrHG6PtWPVhENG1HhGx2Y1QN1SgH1/sQXJTowhYlISQWDrF/qJRqZt5OzAGONbMnqVDIArF2jf95KLMV3nKxvtxvVAkqkswK5aO5CLHMf7HyBDGWAfRqnw3VlG546Fgd0XPJ8WNfthMBMZl/gZkbMV1BwGt7XhIhqysmWZes4DI/S/2B2eiAghuuotTNOoWy4/XwDNsqZHB8lwOx9I/UNJ4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS7PR12MB5814.namprd12.prod.outlook.com (2603:10b6:8:76::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.12; Fri, 17 Oct 2025 02:55:10 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 02:55:10 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Oct 2025 11:55:07 +0900
Message-Id: <DDK9BL9MOTUI.359BJBMHFTFXU@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] rust: device: fix device context of Device::parent()
From: "Alexandre Courbot" <acourbot@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251016133251.31018-1-dakr@kernel.org>
In-Reply-To: <20251016133251.31018-1-dakr@kernel.org>
X-ClientProxiedBy: OS3P286CA0057.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:200::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS7PR12MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bb85fe8-3986-42af-8b93-08de0d289633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzVJcEZwQmYzWlBNRkI4ZVB6WlhtbDZPYU9Da2ZhbitiOUV5UElNazBvK3pa?=
 =?utf-8?B?N3BLMTdYTFV1RHBwTVBqOVQ1TkdVY1RzTiswbnhFb00zY0RCTU5aRERoenJO?=
 =?utf-8?B?bzltdzBmRzl6ckI4ckY2cHhhUmFVUkk5UW1Lb0ZEWkZVVU85bXpIU3VJUm11?=
 =?utf-8?B?ZmVkemJkUTZDQ3VyTUhvQ0liVVRyS3B0QzVKVDdmcGtoNmh3V1pnNkFXZGE1?=
 =?utf-8?B?RW9tVjhJUGJ3U0tvVzgyd2JocHA3dmJyd1o1b2tCeWdrUTJtL1EwNWZ5Yjk4?=
 =?utf-8?B?M0Q1dkR3Q1FmVlViOTFlN3R0bTBXZ3BmTitkUXZiNmxLOXJhaDI2Nks0SDlw?=
 =?utf-8?B?MVVYeWMrUFJLWkRMZzRmSUFKVXJtcTk1VXJqU3k3c05sZ0VxbXBwaEdna2JW?=
 =?utf-8?B?b2FFekhHRFpKbVV1dTZvQTR2S016TmRqNmN1a2FXUHV1cGlYOGpCei9iRlRi?=
 =?utf-8?B?OTVkbmI5U3llNjV6MTl4a3VrZkJTSEh4bytjeDFuREIzdE9IRzlyOXp0L1Zn?=
 =?utf-8?B?aUZtd0VYTnJsUVdYdHhoTUp4VkZyS3MrcVpya29kWHVxUE5oVUgrZE14RXBx?=
 =?utf-8?B?TG5lanNEcDU0WmpMR01LRlptM0NPT3RXZkFWYU5KeEY3ZExFblFaT2dwMGdI?=
 =?utf-8?B?Vm42N2VoeTZSUEU3UW5LTnlrUk00Y0FxeTJCcHJFTFBoM0lHY21DQ29ualdZ?=
 =?utf-8?B?ZS9BaUhHOVZxeG5Uc0RrZGg4N05Jd2pPM1Jic2t1c2w0MGxzYVRlQmQvYjk0?=
 =?utf-8?B?bDdjVkJWTDJoMnA2ZjNBcktuS1V0YVVDcDhsbktVVUo0dW9mclpWRzdiZk1i?=
 =?utf-8?B?ZWtZRUgrVnR1YVMwQmtYVE1KZFIySEhPWGN4d2hQZ2s3czhSSmliaHovR1lz?=
 =?utf-8?B?NjlZRTVyRDd1SEpiNmxETkFYZzdnV3VxYzUwZzJHd2ZYdVhxMFE1QktPc25i?=
 =?utf-8?B?c1ZFWXRCMGM3OTJvVDNRMlR5VzBzV0xYK1BvZmNDZ0MyUkxTVjIzbFV1ZlNT?=
 =?utf-8?B?QksvSmVyaGloaXRDdGRiU3dzbjlYeS9YRVJ3QnpDb0xIU3g2SHIwNTdsSXYv?=
 =?utf-8?B?OW9pL0N0Y0xlak0wN1ZZTjIwWkFBK29wSnZCQzNLeDVGRFFGaFNmS1ZjbUVF?=
 =?utf-8?B?bWZOZ21VZXl0MUpmVnkvOEtmZFJuUlVuRkFjMHJ3a2YrUWxMVDN6bjVaanlJ?=
 =?utf-8?B?QlhEbXFrTDI0K2x6SHRYeG1ybThURnlYNVdjWnViQ1NxV1pEMmxScWk5RUUv?=
 =?utf-8?B?ZkNzVmxGSlZBQjJhNlhvYUFpeXhBc3ExaGVRY2p1cjhoUDZJOVl0M1lUcFhT?=
 =?utf-8?B?UE04Y1pIT2J2UkhpbkVXR3lDNGNJYm9rYjRLVlFJWHB3QU9saElISVNhdURp?=
 =?utf-8?B?UThwSDZaRXZOQXhtS2FlZlFPVUtTaUdpUnFtUThoLzNRWHUyOUoyS3JvV2M5?=
 =?utf-8?B?cnRiTzMyMWZ6YytWcmhqWTlwNWJGVFNDWDVVZlIyL05WOHo0ZGQreDZsOEtE?=
 =?utf-8?B?S0lQbU1IQkRscjZWWlF3czVmTmVGT3lMZ25LcXlWaDFna3BnSW4vVXVJT0hB?=
 =?utf-8?B?NUFqVDBGTWU4NSs5dVY3cGVKS3RpbjRJT0xKN2dCTlVmNXNwUHFWb1M1NkNW?=
 =?utf-8?B?NWhqaUVOTFFZN296SlJkRWF0eks2NEZrU1VuMmpqbG1uZnV2OHBzaXZBZXUy?=
 =?utf-8?B?bnRpRGMvcURyMWVoUEYzenZ0Skg3TUZ6TEFmQzRNY2FwbGsvbGRSeDhQbTJZ?=
 =?utf-8?B?MkFHOWc3WWVhQjFmaDRublIvRlViR2hPQXRtRkdkV1RxWHdZKzdJbmJuODJ5?=
 =?utf-8?B?b0hrMlVQSTBLaXNnSWxPeHR1WXgyNmJNS2hGSlVtZWhyNCt4ckdaeWtrMjF2?=
 =?utf-8?B?THlROHNiMnNQYzBXYWJWOXJzT2hiNW0rSzBZSndab3NnSk03V28zZHVmMHZF?=
 =?utf-8?B?K3o0UkZzYVhHcGp2bW9tb3QxREE0bEdPZ3kxTGNwcWZ2amtaWUc4enEzT1dY?=
 =?utf-8?Q?i/0Y6E1D4IOvTL8QP9hGNUXUQkyDOI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWRMTlJPTkZtQk0yeXduanFTYnJFb2trdlNsTlI2a0V1NlpBKzNkUEVJeDZ5?=
 =?utf-8?B?NHIxZ0F6aldlaUdZUjlIclVCYjRmSmQyejVtZnhtVGhwaXUzeFZpSnhKWjE2?=
 =?utf-8?B?UTFLeUtSNllFckREZTUxcWduNncvMlpXeVpTK1VEQlM1cEtyT1ZHWmtmem81?=
 =?utf-8?B?QVY0ZEFQTXp3dUNobmdMbURCSi9pTm1YMVltT3Q4dFF4WGo3azVXN2ZYQlU5?=
 =?utf-8?B?V29WTEVoUSs0TUIyd2d0eFR4NTBzdzUrQTJwMVV5eGtBdGdEUjJ1NnNybWdH?=
 =?utf-8?B?YjlBVU9MYVhROElWUWZYRmNBVFRqQktyR0hDZXIxelVBMnJLY3BhcllLWEhL?=
 =?utf-8?B?UE5GZE5EVjRCOGJ1Y0ZWbFlsak0wdlA5ck1zUjNNRlQ5RWtwK0hSS2dwenJN?=
 =?utf-8?B?bEw0YXFFc2lTMjJqT2Q5cjY0V2dZTExqMFJ5elVSMm0rdHN4TU92YkFFN3lr?=
 =?utf-8?B?L0JDT2VkWFFNdlEzd3QwNm1Ga2VadE5MUzVJQ2dlcDk5TC85K0NyTmpkOVkz?=
 =?utf-8?B?Smt4TVBOWDA4MlZMUVltVEIvbzJQQ2U4V3pnVWZRMnJIYy9KQjhVcDlDdWl1?=
 =?utf-8?B?SFVLb2VTY1BuWm1IN2lYZXpQMnZ5YVNhWU8zOVUzWXpvWDVVOURralRaMUdT?=
 =?utf-8?B?cEJEZmN0UG1OWmhPaWtJTzROZWwyRFF1RUUvYmc0SllQd0RxT3pLelZSbkpU?=
 =?utf-8?B?eldnM1BHNWxwZEdTRWQzNysxZm1zZkJGZFpob0hualI3WnBtUWRZMHdtb0Fx?=
 =?utf-8?B?YS9qRG81RHNOR2F2RGk4ZGlZRDB1VHRvTEF1cVFlT0tBS2FNYkViVlhJL1BQ?=
 =?utf-8?B?VHJiQllhU2Y3Wi9xRTZUOFZvcWFvQ2RJUklKZXZUd2x5ck1VVlhqNnhuVksy?=
 =?utf-8?B?N2dqWm5oSHJhaHJiL1VJOTk0OG9aV2xkdW1PQnRtQ0xuYzRNZ3dpTi9nZDM5?=
 =?utf-8?B?UXlUMHF2cUxaR0VBNmRrRDhoNUEydFNreXF3cjRic2JWY2o5TEs2K2gwSDhz?=
 =?utf-8?B?WWd1TGZlQkZkMlBqeTZ4aFkrRXJKaWd2WXYyN2dRRU1qeGZMcjA3aDdwam5r?=
 =?utf-8?B?NFZyT250US9rcHQ5ckxZYmpqT0IwZkJCc3o4MmRuenRVaVY1VGhIS2YrZXF3?=
 =?utf-8?B?MDlFZENsZHJqdElxTVo0aTlXbkVxKy9ydGNuRTBRUjlzSXZlT09DMEFZNW5h?=
 =?utf-8?B?cVVkRldTem5BT3loejBNMTFsRURpWmNVYVFQVVMyMndQSHdTandPL0dMa2w4?=
 =?utf-8?B?TC83T3EvdGNscVk0SGM2UVZ1WnpEaURkbDhPWDZodUhsdXFRYzBQNm5yY0p3?=
 =?utf-8?B?YjJyVFp6VUNoemp0RnZLQlN5aUVxbWFXemxVcU1hMWZreWMxZFhRdnZ0THcr?=
 =?utf-8?B?SFRMeC9QSUhUUjZ6eHN1ZVovSzc0WG5SU0hnM0VqTnplMEMycTQvS2duMU9U?=
 =?utf-8?B?d05OYmx2Z3hDVU95akUyZmRmRzJmK0V5aTZxRmRpaGpHWWlRdmd4dG9vNTRk?=
 =?utf-8?B?cG5vd3NmRytZUkM2VytQSXE3QmkrM0ZTRFVRU3A2UFlzMGJNTnJqK3JJdk5H?=
 =?utf-8?B?RWo3Y0haTGxWc0hiV0VBUEtOcEJ2a1Q5YjZpVFJFMm9iZS9KMFRCUnAwUHMx?=
 =?utf-8?B?QXk3dUY1S2JBVCtheDlXc0QvRmhmaVdoWUwwQ1BhSjZtRTRMYWk0MnExZ0Z4?=
 =?utf-8?B?d1pPUTlhWWJJQlYwTFkxbnNFWVdvcG5XMjJJSmRvOXMvTFhUNUZnUUNud0Vq?=
 =?utf-8?B?UTVIdlEwMDFieE9XaDgyM3lPUTRKd2h2MEU4YjVOM1Rzb2Y2R2dPN0dMR3Vw?=
 =?utf-8?B?Zkc4S29IVXNWd2M3QU9jSUZjczNwVGVYY3hXWlV0ZWtSb0U2bndRMnJIVTBU?=
 =?utf-8?B?M0Q1eVlPakhEbUJnNko5T29kU3FwZlJBRHJjcVZTSzVWemo5OVF2eXhEUlVQ?=
 =?utf-8?B?Z0JFQ1V4eVV5alVyT3BtMC93NmdHaDg3TjlGc0RlT1Y3WXhPcktybVpxUE1k?=
 =?utf-8?B?VUp4dGorajl5OWZ2blBoTG5MRjR1SkpCaXc0Q3k3Z01vSGtTRUc4OWE1WHp0?=
 =?utf-8?B?Q3B0b3Foa2w2MVZlZDZpNVRUenE5OWhHb2ZGVmZBTUVXOFdvYzhTdFJGN1Qx?=
 =?utf-8?B?ZENwdzZUQVhlRVdWcUIrRXIzY0IrVUJzSXZrS092RFB5b2VyMHZYYk5jQncr?=
 =?utf-8?Q?wOBXvxG/a+qJotHXWWTUNDG7wlXlHh+XbtvpGRFEXZg8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb85fe8-3986-42af-8b93-08de0d289633
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 02:55:10.6189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rohG/ery3bAr+W4frVppEu6ERNv+FttaZyZ6YJ2sVcoq5FxATwSK5J8/Cbc98TMZUrR4SENfw+u/vG7IfPJf/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5814

On Thu Oct 16, 2025 at 10:31 PM JST, Danilo Krummrich wrote:
> Regardless of the DeviceContext of a device, we can't give any
> guarantees about the DeviceContext of its parent device.
>
> This is very subtle, since it's only caused by a simple typo, i.e.
>
> 	 Self::from_raw(parent)
>
> which preserves the DeviceContext in this case, vs.
>
> 	 Device::from_raw(parent)
>
> which discards the DeviceContext.
>
> (I should have noticed it doing the correct thing in auxiliary::Device
> subsequently, but somehow missed it.)
>
> Hence, fix both Device::parent() and auxiliary::Device::parent().
>
> Cc: stable@vger.kernel.org
> Fixes: a4c9f71e3440 ("rust: device: implement Device::parent()")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Ouch, that will make me think twice the next time I consider using
`Self` for convenience... :)

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>


