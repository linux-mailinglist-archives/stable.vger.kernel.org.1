Return-Path: <stable+bounces-207877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8EFD0ADE7
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 16:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEF97301C0AF
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 15:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91EC320A1F;
	Fri,  9 Jan 2026 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="p8ahy+0+"
X-Original-To: stable@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013034.outbound.protection.outlook.com [52.101.83.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEAB305048
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972213; cv=fail; b=kjHUuciJeM9IPfE9FHmJp/FwWc0n8r5Vh2x2j/xfPsK4B1ghx91NucpmkLPX/NKLFcJvWX3WtiBJ80WaB6G5Qo5xh9mvR9CoBFE1j50tu0pL3Q7vcqTBirVjgMsbQulbKWIUc69taoWaSVjaUxnms6iNFuXEAZOCBQ7S3zERj6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972213; c=relaxed/simple;
	bh=dMULo/C4TEpG5xM1KQNctxQrBT6344sbWtnXtKasnMw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eEEXtfLJtv+FCkDkUHZa/vavoq6Y987XcEnfczLK4MOD8dS1PpPvUF8IWoq1DM2VFB1RIC/w3qFqyVBLBGWnkpGLPm4bSJmMq1DnCJWeTsNr59kwNj1SA5O4mRhiYWXRL5kzpNZ2nnzkea50YQKVxUUSqAtGQ4pVDwMYf+0618w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=p8ahy+0+; arc=fail smtp.client-ip=52.101.83.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/vvuNeOdR8qOzcVfoAEnI6dWxsfeYuSyl/0sgcQT9DH9XREIk9nVXZWKO0NoTweoAjmJRPf7n9S+nlweTsLZqzqz9xAFx5eSMcjpcNMApdOVC86oje6dyFCLm7PX3cl/j22orwwL0CYcZzX8Fkw8J8USNgaYKm0OeqlwzYrlWTrnXOFckvGv7h+BrX1b1LoAofxIh0J2q0Q6eUvtcFwYNMGW/Skzp0640mi7s0BqC/uqjSeeK2//bDuaLWqokQdfNwRPSaIUkkscKvp6vq3LH6Rehxgq9pUk+P6C8zHbA3uo0mLe4ZXlPADe/fMHiv1wlbZp7FeLAE/xUVveM1fQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7pvP74O1h5MaqCch+dRlAIRFTFFvlFJNfysJCLlWmI=;
 b=o0yU2mEjibgrNCva3Qt0SiHuHuGq2xkM1jjhKRauc5bEjxJDJb7t93mKZbBjzMS1gZZG3PmxYWJRFt1OAQ9NEYsYBFJX3Cw/feksjGUY4JBeMlZ/t6u5+uhkJ/NX4cgyTl7+sKuFpEpNEgdRXclH+RV+dROu548zliAAp1+UtPKLRm7/cswIKZynAXzWiTCt8MiBTcVuOc2jiV0emDJ9flNa3ivOVaA/72mKqit8KEw1lOAYXOq2NMKLjg3RKyZXfFjRE/RoycLiAlTm6+nPyBOH0jWcx+n8l9MfvSRkBrSRlL0/ygvN77uDIg3k2hz8pvw8RYGG3DKGoZNpE7KiOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7pvP74O1h5MaqCch+dRlAIRFTFFvlFJNfysJCLlWmI=;
 b=p8ahy+0+KGUe5myQnanRLY6/Ktw0itYcJvNJJXAmM20XmqUj1Igpy0UHPUz1Bm8Oo/jYhI0z7pUBDZhxkPeYjKlRBLjIyURZ2Z6p7XK1ARY6HkU5spa6l33+461vzGWszFWhiGd1l7s5TM1RWWC4WeKuPjEYw3mSD/VctBVCVZWnPXaJmvfiJ6FXPRDsX188S3Jg1eaSLeMUipaJe0lNVmHffpRDZfMNjKSUjkZ+7atKQwebvTY7a54DaqJx060wGclAot4b1u/Sc4Xw8e+DFuXDPwrCHxcOcqkD0MleGzj6KUZfOEZTsQFqEUDHqu4XVag/i9uqEH+8RvZdxz9Ntw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:f3::19)
 by AM7P189MB0916.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:170::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 15:23:28 +0000
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::bc3e:2aee:25eb:1a0b]) by BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::bc3e:2aee:25eb:1a0b%3]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 15:23:28 +0000
From: =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>
Date: Fri, 09 Jan 2026 16:23:14 +0100
Subject: [PATCH 6.2-5.10 v3 2/2] ext4: fix out-of-bound read in
 ext4_xattr_inode_dec_ref_all()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260109-ext4_splat-v3-2-bb8dfefb8f38@est.tech>
References: <20260109-ext4_splat-v3-0-bb8dfefb8f38@est.tech>
In-Reply-To: <20260109-ext4_splat-v3-0-bb8dfefb8f38@est.tech>
To: stable@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Ye Bin <yebin10@huawei.com>, 
 Sasha Levin <sashal@kernel.org>, 
 =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>, 
 Jan Kara <jack@suse.cz>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767972197; l=7464;
 i=david.nystrom@est.tech; s=20251215; h=from:subject:message-id;
 bh=xO+38IRvRj0jTFV18MDLd7C7ySeXfktG/lzDkdGeuwA=;
 b=havyF1St7c+I071WjDbKJhnh0g1VxFwm+C1nwNg9CPHIw5D93plo2CkmHHwqhwYcF4ZN+2+GH
 R6zkn2rM1+FBIPUPYjjBateMPghCpD+d/YKo6AOdD+LroJBAeSWHY6D
X-Developer-Key: i=david.nystrom@est.tech; a=ed25519;
 pk=4E3iRjA+3w+a4ykfCHDoL5z4ONs9OcY4IN3pTwIG7Bs=
X-ClientProxiedBy: LO2P265CA0434.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::14) To BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:b10:f3::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP189MB3241:EE_|AM7P189MB0916:EE_
X-MS-Office365-Filtering-Correlation-Id: 30847054-7454-498c-7892-08de4f930a61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnRNL2ZNVG9ocWRGSTM0OFkvV2t2NFp3UVpMSnFYS0dOa2h4WXRJWUh5T2F4?=
 =?utf-8?B?ejV5SU1XZVQ1TEtBTXlCVWN1RnYwSEIvbldFblNEZmpNNFFyZG5jZXhZMUU1?=
 =?utf-8?B?VzcrZDBldDZxZW5QVnl5V1FSUGl4L3AxRUdhVXlVSXRUMFBUcmxCQXNoRmFH?=
 =?utf-8?B?bGFCR2JqSUhISlpUSnJobSs1NmVEcFZGdEs5TytjUzB3YkwyWFFhSHNSZCtn?=
 =?utf-8?B?OEdPUjlKNXhUVWFlcnM1NzMyUXlFVGhFKzB5ZE1XYmowNURnQWgrNitaVGZH?=
 =?utf-8?B?QmNUdTJDdWc3R3d2Mlhzc3JYeDJaaTdibzA1a2RzM3RSY0VObkhNRjBLUVdp?=
 =?utf-8?B?RXd2TnpVMGxhODZCNTVLeTRmKzc2Um96cVU5SFp2ejFJaHFaa1hoVzZuSFND?=
 =?utf-8?B?V095aitVTElpNVB4NHJRVWZGL29XcmZjTjYwYkFPbHVZUDczMG1IdVBJMXUv?=
 =?utf-8?B?Tlc5d1lyR3E1ZUcwcUV1c3A2cFFCQnVtVlFHNEJuYkZGdkthZ3dFVWJpT3FP?=
 =?utf-8?B?YWJ0dnk0YUpQbTBDelgyLzZHNUg4dW1xV3JqcFdVTkMyT3BMdTNaRCs3aFVV?=
 =?utf-8?B?RjI5UG5uZ2RDTCthcC9haUhDclVMYWpOQUo5cHlQV2M3OThKZG9FSVBQUks3?=
 =?utf-8?B?Zkx3MWRlQVBYN0dGb2JFQ0o4UFg2WXZOOU9QWTNiU0FoR1VERmN6Sm93YnMx?=
 =?utf-8?B?ci9ZeXJzWCtQdkJkaUtGS1k1OGxpMFcxWFBrQjRrYW8zaFZrZDBXL2xMK1pM?=
 =?utf-8?B?eU1Pck1neXZpQWlOOVNjL3BlWlBBcE5mYTBYRWcwUXRFUmJpWjZuR0ptemEy?=
 =?utf-8?B?WVR5Wk52TW5ZYnhLRXJLT3k5UDhiQnNjYWV0VnJSNWtmU0kveGxuRGdYZG1l?=
 =?utf-8?B?MGpDVkpNZWZnUkNMTUpOYVZBWGhxYU5wVzBXYnVQa0FnOXhzYlN1RVcrdkgy?=
 =?utf-8?B?OHo3WUxiWFV2cVRlSldwK3BtMEtwc2VmckVnV3Jrcm1sQlJXVmFJQ1hPK2VQ?=
 =?utf-8?B?MjhjY001a1NtcXkreWNwU0plZlNCRFJMUUpJM05DTGhzWkt4UlN5V1lmNjEy?=
 =?utf-8?B?Ry9SVHBVTWR1VFJna1FkQWtWNGp4bkNzOFl2MlZjcGtyNjkxK1ZiQUx2WU9p?=
 =?utf-8?B?NnFoOWxETkw1QzJqM3owZWpaczdOVWtnaUVCZXlTMjBjbHhvaGlyY2dmY3Y4?=
 =?utf-8?B?cFo4aG0zMXd2bllJdHZtclNabUlkbzN0N1g3SHhwQTBXdzBnZFNOMndFenZQ?=
 =?utf-8?B?THg3MkdFanFWQnR3NEc0MEdZSzhHL3VqNys0aTF0RGRXUExhZ0hEcnJDQzl5?=
 =?utf-8?B?Z0Nqd1BpUGtVMWE4d1RxZG4yUkIxWG1XaFhHN3RoR1RVNTVEZjlFSVhmZytv?=
 =?utf-8?B?dVhjamFOSVlrTTNuWFRZdjRiMC9ZMVNXNUxPQ2haMG9hR2ZUTlpUT1hXcFMy?=
 =?utf-8?B?NFlNTGgxMDhUQkFoWnYyVTBJTnphcVdXV3VobE5yd1NYdFQ4Nk11a1RybDJs?=
 =?utf-8?B?aHJXc1lNNGtieWtIc3d1bCt4QUJONC9qSHhHMlowMTJUVWVYMTRJSkJ3cGhE?=
 =?utf-8?B?MVErVmNLdVdDZ1hRbHNOT1h3cHRyMzhIUStRdWNBQXBZQ2ZMTFhDNjc5ODBZ?=
 =?utf-8?B?eDdWS24xZy9lLzhnNmtVSmRjYWs3SjBvSnJTK05MZDVCZ25xUHNmNTk3Zk5z?=
 =?utf-8?B?QWcrczUrRWJyZ2VNUEVJaFNKNGpMNGIzSkYvT2lUZXpEQVk2aEFSckJkUmlB?=
 =?utf-8?B?M0pWUTM2WTZXdm01bWVuMkh6NndaeWpzeUlDeHArZ00vNFBJNWJTOXlLTE5R?=
 =?utf-8?B?bjkvcWhhNzRXZlp0TzhDVzdyQzJJYitBSnVMMVpUdGNpTmZyVjZvUzcySE0r?=
 =?utf-8?B?VFJyRmlpKzVsRmFqTi9IbkdnR285YzB5KzVSZjJVZkFGQlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESP189MB3241.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkhRZkVVeGZQSm1GdDV3dG0yQ1lPcWUxL25BV3NHajBZOG5XUW5XbEZCaTZl?=
 =?utf-8?B?dGFUcDlNaXlZSmgrOFE5RDJ5cU9xQUhmdTZIYjFWNWpUclY4Qks5SVA3cXFS?=
 =?utf-8?B?QUdMMFBqTGxjK2xYUEgrQXNQMWpJYk0ydW9XQ0RsZDFIU1VWbStqa0R3QXc4?=
 =?utf-8?B?Z2xERDd0VmMzWmg0TjBJdzZzcWtvOHpSNmhYSlNzQURnZ244b014Mk5tZkZz?=
 =?utf-8?B?NWpLQlJHMHkrNk1KdC9vNWp3K2dnL3BGYk9hZGs3VkV3Q2JmTjhlU1drV2hs?=
 =?utf-8?B?bWRwUURsQ09hMTJaeHJyMFFRZ2lOM29qYncxK1FaTzZQZk5nUmVGV1R6VzZ0?=
 =?utf-8?B?aGlvUDVmUVFoZHBPeFJLNU1iMWw2aldsUHIvak4rVWcrR0hWLzJPbkFJRGgr?=
 =?utf-8?B?VzlpM2l2ckhsT1RyMnIzdlIyY1ozRlNuWmN6Ylc2bFFhMjk5bjUrdmxLZnVv?=
 =?utf-8?B?L0x5TmZiQ2pSVllYU2FOaHMvT3JncUVEeGFxcUR4Qzk1Z0F1VjZyVXIzOVh5?=
 =?utf-8?B?ekdNTUZqRmFRTjE1K1p6T1hSYWczeFRCN3cwRHMwVzNxbStIK001dkFTRkU0?=
 =?utf-8?B?N3BRblFLWEpwa3V1WVhrcEU3a1A5cDMyR1VoclR4RC9rSWRmRVRESEd2NktZ?=
 =?utf-8?B?YktEVmxnVm9HL3kwZGpzOXNmeldwb0w0SzNJSldSRWEzVWFlb0lwQWJMWE5q?=
 =?utf-8?B?R3pDakRNZUpqZTJ6Nm9hMWNXTjl4TDBOOW9TNEVZSStSZElsSndHeGdPQTNh?=
 =?utf-8?B?QTdyVUpibTRleFRLdWw0M0hqN0NOempTTmVrRG14V0JNQ1ErQmdwVDY3RlVn?=
 =?utf-8?B?QUhBM0hONzNlcXUwRVlWWFQ4cG80REFxQUdQTkxySDNhV1VZa0tFaDdmRHBZ?=
 =?utf-8?B?d2V6bGxzUCs5Y0VlM0hSZ0k2U29iUE1hOFBkVzQzcGx5aFhSSnJQcms5MGVs?=
 =?utf-8?B?WEo2eG5QSGQ3MmJLdjVyOU9TRTlBTnR4Tm9YY1JPUEM3SnVOanBMOGpOQWI3?=
 =?utf-8?B?YXdTS0E0S1hMTDR4THo5QzR5TUgvUlRXRGVXZE9kM3VvdWNnR3IxR05MRU1w?=
 =?utf-8?B?RHdHeDBPUktlYktqUUlqeWNqaEJzVG1TY09rNE5HcTBqTUU4b1hOM0x6NGdN?=
 =?utf-8?B?WGdrRzNpUHN6UHZQQi9tNkFOMExOWGRnWXZaWGdpV2puNE5KdFdYWVhXR2to?=
 =?utf-8?B?L0dkWEVzUXRaSlFNMEkrekhGZmw2L09vQWJQaHRTTVFVOFVwYUVJR1RNQmk3?=
 =?utf-8?B?N2xYZUZySEcwWTRFdmE1VDlocEF0eWgxRkJycktYOHhwNlpDU1VYUlQwN1gy?=
 =?utf-8?B?NFRaT1ArM2w5K0NXSUhpbnJ3MkJFM2NtWkhPRHMyVDM3NWx3SkQzNzdkaGVC?=
 =?utf-8?B?V25oL0FPZllRbXVsYzRvMlMyUXhLTXRYT0NWTVlaU2dxaVNnZElPUjBxZ1hy?=
 =?utf-8?B?NXcwUGUrRzZ1eXZLbWxRZmZDeU43cDNlRVZBYVYyK3NEcUY2S0ZORzBQek54?=
 =?utf-8?B?ZWhMN3R2Z0QzdDlVdUxtclRhKzNDRVFINlFLWGVudnFkUjMxWk5pMDRGUzFV?=
 =?utf-8?B?U0pzaDFZdUZoRmtFNzRIY01CaGhlTWMxZnBnR25TV2UraUgxZzc3NENabTV6?=
 =?utf-8?B?Y3kzNHYrdy9CWkJHdXMyKytxc09vQVhHeTlnNFRmckRoK29POS8rM1R0VHNa?=
 =?utf-8?B?eWNnbUxuTlpUMyszRzU0dGg2MlRuUjVHSmZ1M2w1WkMyR09WOWVDNXEwNUZY?=
 =?utf-8?B?RFNzUHRZQmo1TGx3dHpwaUFEeGk1cmV3YjBaUTlISTUzY25uRHlSSmdDYTdS?=
 =?utf-8?B?TzFXN2hwWWRkR21JdGI3RlpkNUorMXpqNXlRVWIyMmVoYzE0a2JLbUgwQWQr?=
 =?utf-8?B?ZzNmTE5mWEFIek1PNUtJTHdkcWVlKzl0ekxWKzRNZmliQmU1N2IwRnhSdDhh?=
 =?utf-8?B?WE1rQTNBeHhNRkxsVzhqQ3dkL20ycDZNWFdRVzRtdndDcG44T3FmWVR5Z1Zp?=
 =?utf-8?B?QmdXaUZoeHovS2QrUk5zcnB3Rm93UTA0VEVxTlU3NUZTdXFwZElmVTB5MzBU?=
 =?utf-8?B?M0V4dTZEVUdnRkVWV1R4eXlWK1BrMVpTdE1sVExIOVBlRUpRbE9OMENZZUky?=
 =?utf-8?B?WTFRTzZQUlBwY2IvN1dVYkdTQThnSHhnZTVRcHU3T0R3YlVRT0xISzFGaWFZ?=
 =?utf-8?B?WmlCN2xvT25KRHNOZ2pvY2hacEN2bjFpZmJQcDBJVTU0QWFkS3JnR0JoRld5?=
 =?utf-8?B?OFUwQWFDdjN1Y2taM0tLWkRBOHMrbnVraVNRWXh5ZGU4WVdJbEw2QmhSNmEv?=
 =?utf-8?B?RjNSQ1VDN08zVG5xdzdzMzVlM3RvcnMyMEgrMTByYzJ1bnJxRzFLZz09?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 30847054-7454-498c-7892-08de4f930a61
X-MS-Exchange-CrossTenant-AuthSource: BESP189MB3241.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 15:23:28.6849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxHwQON7Z5PcSS/UytAcc9cQtfGEUhKsGveOoXqQ7IIL4FCch6ROIQvyBzOemIEnsaCu0VevK8K21c9hCI/rbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB0916

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit 5701875f9609b000d91351eaa6bfd97fe2f157f4 ]

There's issue as follows:
BUG: KASAN: use-after-free in ext4_xattr_inode_dec_ref_all+0x6ff/0x790
Read of size 4 at addr ffff88807b003000 by task syz-executor.0/15172

CPU: 3 PID: 15172 Comm: syz-executor.0
Call Trace:
 __dump_stack lib/dump_stack.c:82 [inline]
 dump_stack+0xbe/0xfd lib/dump_stack.c:123
 print_address_description.constprop.0+0x1e/0x280 mm/kasan/report.c:400
 __kasan_report.cold+0x6c/0x84 mm/kasan/report.c:560
 kasan_report+0x3a/0x50 mm/kasan/report.c:585
 ext4_xattr_inode_dec_ref_all+0x6ff/0x790 fs/ext4/xattr.c:1137
 ext4_xattr_delete_inode+0x4c7/0xda0 fs/ext4/xattr.c:2896
 ext4_evict_inode+0xb3b/0x1670 fs/ext4/inode.c:323
 evict+0x39f/0x880 fs/inode.c:622
 iput_final fs/inode.c:1746 [inline]
 iput fs/inode.c:1772 [inline]
 iput+0x525/0x6c0 fs/inode.c:1758
 ext4_orphan_cleanup fs/ext4/super.c:3298 [inline]
 ext4_fill_super+0x8c57/0xba40 fs/ext4/super.c:5300
 mount_bdev+0x355/0x410 fs/super.c:1446
 legacy_get_tree+0xfe/0x220 fs/fs_context.c:611
 vfs_get_tree+0x8d/0x2f0 fs/super.c:1576
 do_new_mount fs/namespace.c:2983 [inline]
 path_mount+0x119a/0x1ad0 fs/namespace.c:3316
 do_mount+0xfc/0x110 fs/namespace.c:3329
 __do_sys_mount fs/namespace.c:3540 [inline]
 __se_sys_mount+0x219/0x2e0 fs/namespace.c:3514
 do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x67/0xd1

Memory state around the buggy address:
 ffff88807b002f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88807b002f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88807b003000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88807b003080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88807b003100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Above issue happens as ext4_xattr_delete_inode() isn't check xattr
is valid if xattr is in inode.
To solve above issue call xattr_check_inode() check if xattr if valid
in inode. In fact, we can directly verify in ext4_iget_extra_inode(),
so that there is no divergent verification.

Fixes: e50e5129f384 ("ext4: xattr-in-inode support")
Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250208063141.1539283-3-yebin@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: David Nyström <david.nystrom@est.tech>
---
 fs/ext4/inode.c |  5 +++++
 fs/ext4/xattr.c | 26 +-------------------------
 fs/ext4/xattr.h |  7 +++++++
 3 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 97f7cac0d349..719d9a2bc5a7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4650,6 +4650,11 @@ static inline int ext4_iget_extra_inode(struct inode *inode,
 	    *magic == cpu_to_le32(EXT4_XATTR_MAGIC)) {
 		int err;
 
+		err = xattr_check_inode(inode, IHDR(inode, raw_inode),
+					ITAIL(inode, raw_inode));
+		if (err)
+			return err;
+
 		ext4_set_inode_state(inode, EXT4_STATE_XATTR);
 		err = ext4_find_inline_data_nolock(inode);
 		if (!err && ext4_has_inline_data(inode))
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 73a9b2934865..16b9c87fd3d8 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -263,7 +263,7 @@ __ext4_xattr_check_block(struct inode *inode, struct buffer_head *bh,
 	__ext4_xattr_check_block((inode), (bh),  __func__, __LINE__)
 
 
-static int
+int
 __xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
 			 void *end, const char *function, unsigned int line)
 {
@@ -280,9 +280,6 @@ __xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
 	return error;
 }
 
-#define xattr_check_inode(inode, header, end) \
-	__xattr_check_inode((inode), (header), (end), __func__, __LINE__)
-
 static int
 xattr_find_entry(struct inode *inode, struct ext4_xattr_entry **pentry,
 		 void *end, int name_index, const char *name, int sorted)
@@ -600,9 +597,6 @@ ext4_xattr_ibody_get(struct inode *inode, int name_index, const char *name,
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
 	end = ITAIL(inode, raw_inode);
-	error = xattr_check_inode(inode, header, end);
-	if (error)
-		goto cleanup;
 	entry = IFIRST(header);
 	error = xattr_find_entry(inode, &entry, end, name_index, name, 0);
 	if (error)
@@ -734,7 +728,6 @@ ext4_xattr_ibody_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 	struct ext4_xattr_ibody_header *header;
 	struct ext4_inode *raw_inode;
 	struct ext4_iloc iloc;
-	void *end;
 	int error;
 
 	if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR))
@@ -744,14 +737,9 @@ ext4_xattr_ibody_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 		return error;
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
-	end = ITAIL(inode, raw_inode);
-	error = xattr_check_inode(inode, header, end);
-	if (error)
-		goto cleanup;
 	error = ext4_xattr_list_entries(dentry, IFIRST(header),
 					buffer, buffer_size);
 
-cleanup:
 	brelse(iloc.bh);
 	return error;
 }
@@ -815,7 +803,6 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
 	struct ext4_xattr_ibody_header *header;
 	struct ext4_xattr_entry *entry;
 	qsize_t ea_inode_refs = 0;
-	void *end;
 	int ret;
 
 	lockdep_assert_held_read(&EXT4_I(inode)->xattr_sem);
@@ -826,10 +813,6 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
 			goto out;
 		raw_inode = ext4_raw_inode(&iloc);
 		header = IHDR(inode, raw_inode);
-		end = ITAIL(inode, raw_inode);
-		ret = xattr_check_inode(inode, header, end);
-		if (ret)
-			goto out;
 
 		for (entry = IFIRST(header); !IS_LAST_ENTRY(entry);
 		     entry = EXT4_XATTR_NEXT(entry))
@@ -2217,9 +2200,6 @@ int ext4_xattr_ibody_find(struct inode *inode, struct ext4_xattr_info *i,
 	is->s.here = is->s.first;
 	is->s.end = ITAIL(inode, raw_inode);
 	if (ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
-		error = xattr_check_inode(inode, header, is->s.end);
-		if (error)
-			return error;
 		/* Find the named attribute. */
 		error = xattr_find_entry(inode, &is->s.here, is->s.end,
 					 i->name_index, i->name, 0);
@@ -2743,10 +2723,6 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
 	min_offs = end - base;
 	total_ino = sizeof(struct ext4_xattr_ibody_header) + sizeof(u32);
 
-	error = xattr_check_inode(inode, header, end);
-	if (error)
-		goto cleanup;
-
 	ifree = ext4_xattr_free_space(base, &min_offs, base, &total_ino);
 	if (ifree >= isize_diff)
 		goto shift;
diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index 9a596e19c2b1..cbf235422aec 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -210,6 +210,13 @@ extern int ext4_xattr_ibody_set(handle_t *handle, struct inode *inode,
 extern struct mb_cache *ext4_xattr_create_cache(void);
 extern void ext4_xattr_destroy_cache(struct mb_cache *);
 
+extern int
+__xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
+		    void *end, const char *function, unsigned int line);
+
+#define xattr_check_inode(inode, header, end) \
+	__xattr_check_inode((inode), (header), (end), __func__, __LINE__)
+
 #ifdef CONFIG_EXT4_FS_SECURITY
 extern int ext4_init_security(handle_t *handle, struct inode *inode,
 			      struct inode *dir, const struct qstr *qstr);

-- 
2.48.1


