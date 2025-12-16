Return-Path: <stable+bounces-201149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7BACC1945
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 09:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59A0E3061A97
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 08:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25E633B6FF;
	Tue, 16 Dec 2025 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="O0DahEbc"
X-Original-To: stable@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013042.outbound.protection.outlook.com [52.101.83.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC20C33B955
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765873232; cv=fail; b=VKWt9zD9w1aFIM3mWX21f0IEPz7+kCXioz7TEeerj4EDQRJYpimoyG4mBe6hNca59c9tK3HYuksAxjYZ1079uVhAFouOLj7AkLjbEdi3Yvh3dljzNPRHsjwHtKHsUrg+kxQDbS+EELDlJkU8nXKDNdZTKyxTnxITGY6RBBAY5S0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765873232; c=relaxed/simple;
	bh=CzBIC48VzwPoNYfbMw1Bn2hQp1cnJ5BjXHIAYUFQhdc=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=IYYVrSM3xPWeVLV1YeZTjmhsFjc3rGtb3aWhkmus7wBgfXa+m/Mmgouq/YDjpVq8SdGdMjhKBMaPa8UCfkjJxwYemphaC/4EHCvgB3bpGsbiwaclztuco7/j3LvXplF5/dEfEwhVd0waNQAseY+DBJIw6DcrwW1cz8i95oQ7Y6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=O0DahEbc; arc=fail smtp.client-ip=52.101.83.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XN3keXEb90EKAF9B124j0e4limusYcHcAScr+FVLz79hzMHccptSkV0a1MfBtyaGPkzp+IuQg0WPa4nDp898jCYQaSWwfjqNWmrhd1uCOrGTwLgHwYBcHRuwmCf+5g6u2/r1dCZ7SNwTi1693wkwAnMF7691FrKELBYjKxiyNk+ffVK1ocjvhz/VV8VN1HBq/giyRSa8JIaZzUyFdlqt0B9vriDrNvrQZSVIKLh4cH7VjDihddhFzyiWmimfQKmcWVp+hVjK9XPBEsrJ+bnSZwy9hyKjuoDP/fj8VU5WK413EBFJdC3I2ws1MFCzJCOjIwCbtP98uDnthykDjOWDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhvQG9mteRwsXR2xiO4aUOGq18W1uy5Pf365f4thMiA=;
 b=fWrKnVx41a0iLw6LN0ynZwvtxyG7dwjrAzIEkMFTI3wFsUyUC6rY4UZA+XD8CXoPf3iyulApCUhN8C6d7vAn8dYxRKpYlYqf71KVCfa2MySljfFi/rY00vslE4BT1oDmuLJzUvSnpHsh6MLonXTHKH5lJtPzTQFvAUmCXHbGQuvMUQwpQeE6KDBejQkYrVbwg+tR/MpYqwkrd/i4fmw6eMxDnMfj/Gn/rfjmdYda70uaIRoqsJYFyf4ZR7K1R1QSzgkimw9BmpfX4cP/rLIWwi8RZoVaooM4cwKrjy+toaONnNhpLlzWIUERiO3c4lTWR5RydqlwZ+MQObKZaFFDlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhvQG9mteRwsXR2xiO4aUOGq18W1uy5Pf365f4thMiA=;
 b=O0DahEbchUEHRLAM40GjXrkRMiiyXYXiOEW5MjA7hixfYAv/OXRO7utVbR+7BT4TLcuqwma9AvwaLFzH4ZNg9OZpWhZw9eqA7KJqysC/kfVkOoymb9L9rsRN/IBp1758eoLUpdf+I1CmTYhbLUEsQ9o7ChClftRySDK+SF/cG30WaW1/XAj3xU/87s1HN7WHZk5s2rw3vEHbe98mSXwkHxqC+442/p44T11+2dVrnbAZqkyQRHBmG9Ts2E1q74YONDIOGzy6RmCnH/wPnmXNcaOYJposHl9YW8ErTpWjfv5N4dAULg7X7XkRKn2mMmu1Fx0MkLpaWMYaCLP5HV/CAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:f3::19)
 by PR3P189MB1081.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:4b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 08:20:24 +0000
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::bc3e:2aee:25eb:1a0b]) by BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::bc3e:2aee:25eb:1a0b%3]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 08:20:24 +0000
From: =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>
Subject: [PATCH 5.10.y 0/2] Backport 2 commits to fix a KASAN ext4 splat
Date: Tue, 16 Dec 2025 09:19:34 +0100
Message-Id: <20251216-ext4_splat-v1-0-b76fd8748f44@est.tech>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABYWQWkC/x3MQQqAIBBA0avErFMaSdCuEhFiUw2EhUYY0d2Tl
 m/x/wOJIlOCrnog0sWJ91CAdQV+dWEhwVMxqEZpVKgF5bMd07G5U8zaenR+smQMlOCINHP+Zz1
 oiY28YXjfDwfOLpZkAAAA
X-Change-ID: 20251215-ext4_splat-f59c1acd9e88
To: stable@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Ye Bin <yebin10@huawei.com>, 
 Sasha Levin <sashal@kernel.org>, 
 =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>, 
 Jan Kara <jack@suse.cz>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765873218; l=1013;
 i=david.nystrom@est.tech; s=20251215; h=from:subject:message-id;
 bh=CzBIC48VzwPoNYfbMw1Bn2hQp1cnJ5BjXHIAYUFQhdc=;
 b=jPPURXWKex+lm8G+rE8tSHOJbwTgHTI0cMwzkmLGrciC2ykHIwbueqTMDGEDxEZnArulXkHsj
 DL6/tUm4h1SCjMom466CMk0IkGPlAz/LipkJAf8zYW1Oen3MgFwJakM
X-Developer-Key: i=david.nystrom@est.tech; a=ed25519;
 pk=4E3iRjA+3w+a4ykfCHDoL5z4ONs9OcY4IN3pTwIG7Bs=
X-ClientProxiedBy: GV3PEPF0000367C.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::398) To BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:b10:f3::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP189MB3241:EE_|PR3P189MB1081:EE_
X-MS-Office365-Filtering-Correlation-Id: e20d1e59-12f4-4d41-d187-08de3c7bf65f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RThBNkFsb3ZhM3crYUp0MFIvKzk2dGdlYmRWbUNGOXNPeWxlUWFxckNmZ1Bw?=
 =?utf-8?B?SnlEbnRqR21wQjQwWU1lUEtpT09rdk1MMXNlMjAzb0laeE5MQ3NGWlNVcjVB?=
 =?utf-8?B?ZzBrQjlCRTJ5WklmUlRNL2xKN0V1TVJVd1FXaDluS2svOHNFNmxwVVRKd1Fs?=
 =?utf-8?B?UUljdlpYdHEvWUNxbzY5WFNNT2RCUWVXREdWUExMaXZkU0gxNTVEUldpUDc4?=
 =?utf-8?B?UkR2NEwxeEJmS2pjYW5kOUlncFZ1M1R0SzR6ZHh4NUJ6UFd6amZaUkYrQi96?=
 =?utf-8?B?MzdQWnBIUnNuUWRpaC9uQVNOL2RlQlROYjBlZTZ2ZUs5dVNtY2tIZUlSRjB3?=
 =?utf-8?B?NmdNQmpjdWJZYS90TVU5WGRIN0dzZGtnZXNqQ0x0TzlDMUQrd2piTS91RFVo?=
 =?utf-8?B?aWk4alVhcFpUWXVGalpRY1g2YWR0dXdpSEg2QnpsS2kwTXR4Y2ZsOWxScEk1?=
 =?utf-8?B?YTUvVWs1UVlSQ0FsKzZZK1FDd3BpU1VrekhSMG1seFFReWZVbCtKMlk5SW0v?=
 =?utf-8?B?MkpJS0Z1UCt5cjJneVd5SksxTXVWQWtaU0ZLT0JPMTUzMndpdktjaUVGanc1?=
 =?utf-8?B?ZFM4WXNMRGNES1lvRjNDTjBadGx5T2l3UG5NYTN5NFZOWThSaTVFT2V3RGY5?=
 =?utf-8?B?M0VPMHQ2MTgzTGFidlE2eU1vVnRwL0JBT0QrcGptOHdlYmFYeW9BSGY3dVdp?=
 =?utf-8?B?Z0pYV0I0NmNZVXZ4U2NYS0Z6NVhnMmVPOW8yVE5jNWZibDdXZmpQMnJKaUU1?=
 =?utf-8?B?KzJzWDdIUnU0L0dyWkdxbmJkeXZZSjJYYk9uaDhFNXlqeFNZRzBEYytBSmlm?=
 =?utf-8?B?eG0xVnpBeEFyS1ljdEZKNDhOV0dDYnc0OVpYUTNxMTNQWmNJT3Q0UCtWaUJP?=
 =?utf-8?B?cWlBLy94aFkvTk8xSzRUU2t4UUxlbmRvUjIzTGVhY0xYV1Q5WGhzS0t1Z1dX?=
 =?utf-8?B?cEwyOXFqYTZQMDArQWxLaDFaMkg0QzhvS1QvQkFST2U3OVlQakVYcGVqY1Zj?=
 =?utf-8?B?TlhqS3hhRllCYTE1WlNNMEFkakJSS2hEUmFMQjg2RXZ5c0lFNXlaU2k1aHFZ?=
 =?utf-8?B?RFdPdCtKbjVUc1RlK0ZQbUZTRjMzQ1ZGU1V4Q1FkVG5JcCsxS09LY2Z1ZzRV?=
 =?utf-8?B?aDJ3azQrUnhQeWQvVnVUVkJKTWh0bmlkdkIxbVFVV0QzWXZSQXVoOW1DaGRm?=
 =?utf-8?B?WFRyZkxpL2VPaWJsR0xCaG9CSEpHRHgyd1lzQzJjdElRWTJsZGtja0VmQTRP?=
 =?utf-8?B?VVAzYS9XSzJaVHBkM1B6V2NhMzQydFNma200NVhwdTJNNmE1aW84S2RlWm5C?=
 =?utf-8?B?UTM3QXNkbkh5SXdlM3hrRi85VitXNWZKVjBncnJ6eStYSEpFMFRYMmdpNm92?=
 =?utf-8?B?YzR1MEsyVUMyTDR5b0M5S3d1NUdMeTViZG8xeDFQYWwydldtTGVUSklTNWVP?=
 =?utf-8?B?WVlxMDVjTWVmU1FPYnU3TUZ1UXVWbVVrNlA0ZWlXc2haZzh2NHFqTmJCU25V?=
 =?utf-8?B?elAzNDcrQmM0MjhpSEFMWXdvc3BJendMckVOVlpOQ0tCZVdENjd1SUZmS0NO?=
 =?utf-8?B?d1dUcnVndFVoMkFVWkIzR1lmbVBWSUpQZVp3WmRTY0xZeUtFV3pMMEpPdXFq?=
 =?utf-8?B?T0RGZDAvaW9hOFVxbFVoMExqUzBsK1VKNmhtMk5LeHJhRStndVlTWUxvdHpL?=
 =?utf-8?B?RUdNdDJVL0g5QVR4RnhuZU9jc2NZa1FoZGZOUjFoR2pTVDBMd0lYRXhIb3NR?=
 =?utf-8?B?ZmpXdFFRcmJOZlFGeFprQ3ZYcUdHZHZWNXEyRHQ2TGoxMHkxZUl1YUozR2ZI?=
 =?utf-8?B?MG50Yk9UUVRBWjM1SVVBM003NXBaZEc0Z3lXRElwYzRpY1FqWnhFaGJQc0p4?=
 =?utf-8?B?TWtUTEtpczVkZlAwcHdmeXBvWVROc2FCNWpZOWdiN05xaE9EZWU3NnR4QnVN?=
 =?utf-8?Q?ojXqkxRtls+3Cx/86+Nb//21sUg3Jytv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESP189MB3241.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTFVVTdiOCtUbEZWU3kwNmZST0hNQUxIV0VDQnBVcmFvblZpc3JoVE9xc2Zw?=
 =?utf-8?B?ZHFpYktkMm9wc0F4OWdrcE4zMDJrS3Q0L3VsU1FaRFpKSXFteEpJTldsZXMz?=
 =?utf-8?B?RG5CUFFqV3cxbjY4TWtscXk1UCtkQjQwVThEalo2bmMvdGxPUG1CRmNlN29O?=
 =?utf-8?B?Q2sxK05nT0VONGxlYS9EVWFpNmdIcGJRbVRib3lxOFBmcUlxemlHdm5OWEtq?=
 =?utf-8?B?cnlIU3FmOTlLUFVOYmZCVDkrZzhKcVViMkVsSWg4T25iRUR6cWNCNW1LWVZE?=
 =?utf-8?B?K3FGUXBwSzBlTEsxZ3JLSTV1Nko0Umg2bnpnWTlCMEY4NGJBNWE2WmZqRExR?=
 =?utf-8?B?ZTNLdHVCZXFWL1R5ZDVlZ016VEN3QkFYa000OHN0akFiMWxvV29EajBrTlF6?=
 =?utf-8?B?YWRoUGl5MzlxNmVWd1UrZUhkTDFaa0ZwQjJQMHZCRW85c1p4OExkSjErNC9p?=
 =?utf-8?B?MkxpK0RhMVZrS2hwTnNIaStsdjdISkR3Sk1NK3lDaHgvdjlJa0VDdmRPL3Bh?=
 =?utf-8?B?SE1WV1NYd1Jsd0l0M3JGa1VTWG4xYkJBUW9BdDE4NUhNM2R1VFhMUmdjbmhj?=
 =?utf-8?B?aU51cmhXNmhUQTdRY2lHcUpGOVYxZHdpVS9VY2JWWGJ2VHo5eDVwVGVRbVRy?=
 =?utf-8?B?eEZVRGJaaWFXTWU5VFA2TzF4M2tmS1Z3YWFsUUlFakI2VlhoQ0RvVlE0UFlm?=
 =?utf-8?B?WUIwSlBiOHBqOWxTZHJOZk00WktNa1lnRlRhd2NUM1dpV0tYaDJHc01haER3?=
 =?utf-8?B?SWdYY1JucStnbTAvcStYZHc5RjJKdS93dXFPZnEyODBEZ3RlcDhiWTYzeUtY?=
 =?utf-8?B?dk9NWnRmWWtYKzd3ZXVlYXBWNzB0YW81THpsVWpJVm00SDRUTnpVMDVJTkI5?=
 =?utf-8?B?VGwxVG56Yk51SEhvdVcydUlXVVZVMjJFMGR4dEdsZlc1cUtXeUpabmt0czI5?=
 =?utf-8?B?cDlsZ3c5S2VNQlBLTnlFbyswVFg4RGRQL2duTVUybkFBQmlXa0ZYRjdaeHZL?=
 =?utf-8?B?YlQ3Z0hHMEU3dUhpdjlxM2NmdDdUck80WnhzeHd6SFpVSDU5Yzd0TURBZFRl?=
 =?utf-8?B?OFRWd1FoM25SZlJ4QUJ2aWFzVFFyZ3NNS3ZzK1RadWxhdFA4dTVCNXp3ZStj?=
 =?utf-8?B?WkF6UEJMYkliaGtDelNSN0RmQTVWSkVIY2tvN3FWZklITmVVb2E0SzF0aXBS?=
 =?utf-8?B?NDE0aEs2NFpFYkgxWkNXMmt4aEpNNi9WSmRUNy9XZFpQL0h2K01jRHUvWjNV?=
 =?utf-8?B?NDVibkNyd2kwN0V6QXZpZ2VLWnllTGlOeFFFUTFISmZjbnZCWXNFTU56ZmI1?=
 =?utf-8?B?aWFlSG01RUZJQXZNamM1dXBrc3kza1FuRzQ1dXJvbTZtc3hFa2JVTHd4eE1C?=
 =?utf-8?B?M01IRzg4NjFTWVllczNZMWFGcG9jcjl4ZVZ3SjZUallWelVWWTFEckptWlBB?=
 =?utf-8?B?eWFKa2xqY3VkZzBSaWMzTW5GSGNIdEl4S3dCQTYvQmd1WFFQdldJbEpUTVJo?=
 =?utf-8?B?V2lrcGs2NFhYS2RXaU5tMzVUQWlJMkg2bjJZWHhsZ1p1R3o4TVpxSThRUkxX?=
 =?utf-8?B?SjY0QkVsOXJvcnEzTmd0MDlMOGlWazFUbjN3RlYzdUpNVGJRaXR3aWtBTEZW?=
 =?utf-8?B?L21VN01kME4wMzB2WHRhZ3I0OUhESGV4OXRHSmlEWU1RWnFJUk5TbHhRNVJV?=
 =?utf-8?B?S3ZlOGRoU3dtbHI1ekxTT1ZpRjM5U0UrZGdCN1FYcGJTUmdiZ1F1bjBDZlBk?=
 =?utf-8?B?Z1RDdHdPY095eGsrR1dTWVAyYnpKdERsWnZKcnpZV0N3Sjk0WExzanlOVjNJ?=
 =?utf-8?B?a2hNckRrNkxlNkduQlNtZ1BQVTB4TVVYRy93U0VIejB0MGM0bGF3QVh1dTYy?=
 =?utf-8?B?TVNRVlJDRmsvOFF6TWR5dTYxa1Z3dGVXWnBjNUw5ME16Q2NhbkpvM1RqZTkw?=
 =?utf-8?B?emphUjFWeEIyOEtZMVZ4TFhsOWxoR1Q5SmVHY0dXNElYQkttc0tzMXBlWjZn?=
 =?utf-8?B?RDFqNjhqeTIvV2ozRE44N1Z0RHNFVXZvdWVrVmdOT1V6aDgyQ2JwUjBUSjVi?=
 =?utf-8?B?WkxUYnRUWTl2TWVhWW9kcUVjUjY1OXFZajE4SklwZVZlOW9mSkxTcUl2a3hM?=
 =?utf-8?B?VERUeWU2bGJaY2pLNXgyNEJRT2Jub3Z2cTNtRUUrcy9YazVqcVRiSENrYUlK?=
 =?utf-8?B?eFE9PQ==?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: e20d1e59-12f4-4d41-d187-08de3c7bf65f
X-MS-Exchange-CrossTenant-AuthSource: BESP189MB3241.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 08:20:24.5965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MNV5EMnGLpZpiwGSowbp8ELxZ+9jltFvn8pF3lbmRr+VJOFg2C0lr6fs5d11F/t4S81jxLI1JClbI9hE/9YdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P189MB1081

Backport commit:5701875f9609 ("ext4: fix out-of-bound read in
ext4_xattr_inode_dec_ref_all()" to linux 5.10 branch.
The fix depends on commit:69f3a3039b0d ("ext4: introduce ITAIL helper")
In order to make a clean backport on stable kernel, backport 2 commits.

It has a single merge conflict where static inline int, which changed 
to static int.

To: stable@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Ye Bin <yebin10@huawei.com>
Cc: Sasha Levin <sashal@kernel.org>

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
base-commit: f964b940099f9982d723d4c77988d4b0dda9c165
change-id: 20251215-ext4_splat-f59c1acd9e88

Best regards,
--  
David Nyström <david.nystrom@est.tech>


