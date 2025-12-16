Return-Path: <stable+bounces-201150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D83CC18AF
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 09:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 571123030C95
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 08:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAD633C51B;
	Tue, 16 Dec 2025 08:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="EP7L/ilO"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010049.outbound.protection.outlook.com [52.101.69.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD22133ADB4
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765873239; cv=fail; b=nptDtk9ZbRfQjMpR8Cp4Aj7LuWs9hSYGj2HuqcIEqRe9TR4qPIfFuJnU/2jfVVV3nf8UXKnxk/qElpicz+1P0BTjiFkL0c1LhsixpAUyk1h8XAgAanqKzT0aI/RsjsGG7MGGMxwzn8/Ha6d3BW6TQMFH0Sfzv+2CfnN644Kdu10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765873239; c=relaxed/simple;
	bh=5nKlaxfXg28DC+545Ked/npAWc9sO6d6us4vKwjtDX4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VX5bCSmyB44ZqeLepZHVWObr71EsXVQLxjaJXmUzCmlC0Ww44wlezZa3b7vymz//+TYKD8rTVRKXbHZGu18kqUJE2017Yxl0z9sbjNU9YccYnbBo7yorWw+1ywXEyzADKHT43W/0HgxNp8KoHTjqBU+AqU7XAOkTFNfE9BmDGmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=EP7L/ilO; arc=fail smtp.client-ip=52.101.69.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKeIl10ClGM5C3FzcBAoGX/kZETqx9p+6B9l+IZEqg+FTAjKFXJTipdTk/n3RGsw8OOuR4UtiXrBM1PkzesytEPOce9fTZjQW37cyr5k/lAjGRe1lImzWjcbrE8F4IkKj+StMCncNVRxwB1IDAyaRTFdsKshO1ro0F9sc62IajHGN9fhq4hTsWS4to5crmoioFEr9SR4ivuZeCqYC4V6wZUGFxWjqfe6KOnZIUW90WFU712CnQiavoMGLHaEnQUcrLP1ftLajtceUbKuI8Gk7srKKRY6yOxb5ARa6YR0ww9VdvQhxWz0itydS99l4eG762Jv//sCtN8eSXAAFLrpjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9hhOoEzRA8U+BG9uKXwg5shmdUIQBGVHrsd7XWr07c=;
 b=hejsCw6gOfWlaTG+WuShWxcuBnAkMZMySJs9yiV1vPp62kQW54xsQmhOmSmTpXg8qlAF0gyhO8EXhQEI6JQNv+cB5u/dDcC4cDLHUAEYa8JN4i+28atYMDK/EUXKItFC7V9LnN8zJRsVddm1a2hpdZlvcHW1Y+ym+c4InDQMNeaeyjCbN1pAsHn+vLfMyULfPaFgPbTSaETlrUnKFo8BBaduXtluIGsOKVkJtLRquOdbrUuyYbefCc9MHi8wOFHlln2QfDPdOjX7ujP+qYKzX1jZ9bSwjcvCo+T7wHBovqFxMYsMxSSIT+ZxA+K2ZS8K6LN5num5PRmdrCjmhO42MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9hhOoEzRA8U+BG9uKXwg5shmdUIQBGVHrsd7XWr07c=;
 b=EP7L/ilOKxWNKpVajFItD0/5M15imnG18bd5TTLxbW01larYBEwZb/pctZNAAKEslN101egSgU3wBsBSVZWNcQOdFezIFSUR4Gg4/aCQT4O4zI7bRWT2Ly8upWPOg4Ig2fvnb1bQhlOcXnFM4ADsbZPnAs0O1aO/oQ6Zw/wk/nrSwRBUHsYCOnt+AP8Bsksds21fKLTNdaGnIVXhb4fprM84It2iC8skhgV9x/RO7f5YYfjtCtx5o8Yj4WegeAtqhXdKr57lfHDNh1HYoz6AFRnITk5EBrw0cmHPFSeo+LwtED3BxX270Tn0LNWgb/1b9d9huxqGWjACDPQ39VDk1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:f3::19)
 by GV1P189MB2836.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:1ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 08:20:28 +0000
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::bc3e:2aee:25eb:1a0b]) by BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::bc3e:2aee:25eb:1a0b%3]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 08:20:28 +0000
From: =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>
Date: Tue, 16 Dec 2025 09:19:35 +0100
Subject: [PATCH 5.10.y 1/2] ext4: introduce ITAIL helper
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251216-ext4_splat-v1-1-b76fd8748f44@est.tech>
References: <20251216-ext4_splat-v1-0-b76fd8748f44@est.tech>
In-Reply-To: <20251216-ext4_splat-v1-0-b76fd8748f44@est.tech>
To: stable@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Ye Bin <yebin10@huawei.com>, 
 Sasha Levin <sashal@kernel.org>, 
 =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>, 
 Jan Kara <jack@suse.cz>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765873218; l=2986;
 i=david.nystrom@est.tech; s=20251215; h=from:subject:message-id;
 bh=RB7UYZIIXk+8NYJbHdJ3kWSixtH07svJZ37uEo5Edg0=;
 b=grXBG9EmR+3EwNAMWWzDZWKEsyITyXXcAik/RAEDBN6VmF5MCtRsxZdd72InaBAYtl7XYskQC
 EsMhUA5sNIKC4LqyGodXBZPQrfrG6QkpMUXEN7xDtPkLDKExFmkAknn
X-Developer-Key: i=david.nystrom@est.tech; a=ed25519;
 pk=4E3iRjA+3w+a4ykfCHDoL5z4ONs9OcY4IN3pTwIG7Bs=
X-ClientProxiedBy: GV3PEPF00002BBB.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:15) To BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:b10:f3::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP189MB3241:EE_|GV1P189MB2836:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc2c296-4be5-4edb-9f57-08de3c7bf872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b052VmFPQmJHcUoyclF2VmZwZVRLK3Nhamg2T1VrMzUvcVgzZFZUS2Fsc20x?=
 =?utf-8?B?N3hWejZJNFljSUxZaHVMcGhmT0RreDBxdUJQVjF3a0lYdzFaeVpFcXcvNXJk?=
 =?utf-8?B?ZzFvaUVDME0yZW1UcHgzcHdaVmtYSGVLSk96OGhZTnN6OVJPMFVMUXd4VytM?=
 =?utf-8?B?V3pGeHdoQUQ1MWpJUE9nQUwrcEpsU2o1SFpvWCtIYWdTZ3NTNmlTbU96Wkdl?=
 =?utf-8?B?UXJaNmhid1M3dGJsblg5bG9haTFlT3FRb1MvT0dOM1ZlYkRvc3hpaHQ5eTlq?=
 =?utf-8?B?QVQ5TGlmOHpOV2l0aFlDbWVkei9MVHBHbkpPQzZJS3NUNkpPbGxVbEl1WWUx?=
 =?utf-8?B?YUtVeWo2aHpRWC9QQWZ4TUxuVWFrTzF3TmNSQlMzMjhZRm12eHRNTytpWStN?=
 =?utf-8?B?RkNTYlUrcHFLcjZPaVFGZG1NdlVnd252bWlxSkxIM0E1ZnVhazdsRVVNWmtR?=
 =?utf-8?B?aGRmUkYwZFBuVFU2YW1BRFVWR0x4Y2MzM0EwTzVDWEUxVFNSaGdYU3h5UytX?=
 =?utf-8?B?ZW1yUXc3Y1ZxRlE2UlBRMXpBMGhJa3BBelpWK0lMZ2ZGODJsOUpKZFVtdU52?=
 =?utf-8?B?L3ZhakhBSU1kczVkcjZ4QXJXVXBuUjgvblBaeTBNdXYzemRtdUp6R0hBWHJm?=
 =?utf-8?B?bHJoTXhzMkdFTGdHY3BmQzB6b2xJd3o2amFMQkVKWGRvN3Y4bGFKaWt2Sjdn?=
 =?utf-8?B?V25pc1daWFZsVUJQZURJNzVHU2JJODJkTThVTGJLUTlhWldtRW1GYUdTTGtG?=
 =?utf-8?B?YXVESnEveDlOSGFNZi9xbEFSUXhiQUNZczFkVlhuTHpoZ2lQTWtObGlTRFVS?=
 =?utf-8?B?OXYrVllxRWMyRnlDbzUvaEZDUzkyT05FYXNyWmRONGZYbkdBSG8rS09pTkFD?=
 =?utf-8?B?d09lN0dETTJsQjd0UmVGRDh5d1ByaFRSdFJuU3JHL1lvYXhvL3RqWXZBMXlU?=
 =?utf-8?B?UWhxZW5zcDBaWVIwY3N0Z2s2bDBySksyTmorbnozTjZXMkViaXB3eFR0VGpX?=
 =?utf-8?B?dC83VTF0ZStueHQxWXN2UFNvU2xIYkRGYjl2M1BvZVo5QVZGakh4eFdxTmhO?=
 =?utf-8?B?NEFvR0JUU21sdkZQNWNxK2d4aFZSWnBGT1A3a2tMcXNld1Nla2JQdjUvaUVn?=
 =?utf-8?B?NzJZazkxUkVyTTREQ3JBRkoxUEFrUitPazRERGZ6Z2VNMTNWQnlhOU5KWnc0?=
 =?utf-8?B?eEJiODlteUtxZmJjSHRFTnFCRXBrVEFvQjRKQVE3dzVBU0dIbDUybk04MUxI?=
 =?utf-8?B?QWtiV2lhTlZRNjJoL2Z3NFE1N0xyVkJYWEV2RGNiN1RKeWZYZ0hHcFE2RHZR?=
 =?utf-8?B?bGpQTnhrTmc1SDM4bVJVb2hRL3JRNTJtemN3eUg3VVV5VVg4dDVyQlRUMlda?=
 =?utf-8?B?MzRyWlNTWnRCZWNFc2R0dDhZa1JSSFovNFhBMmcvWkJMdFJhcldKL0IrbHNT?=
 =?utf-8?B?UWFzdkhqeUNOMUtjNnlzR01ROHFaVmJ6bFl6SGRMS3BESzlyWmZpUUdodXNh?=
 =?utf-8?B?V0dVZzBMeXFFMXRkU3JDSHVjemhxRXpzOUwzbGw1bFk4aGtvclhPVm5ndmFH?=
 =?utf-8?B?ajF2cmNWeFozQThuVCt1c0hFRnFQbU9aRDNSR3hha0dRTWVvN2RITmpmQS9R?=
 =?utf-8?B?ZGVIQVNUWmZWUnpSSEgrcDlPSjk2cDVmZys1VTZvV0loOTVGOFBWbEpCYkNG?=
 =?utf-8?B?eDBIaVU5d1E0Y3ZjRVZMYzZCWTRmbHRpcndlZDk2a0Q1UFFqZ04xNGRVdTJT?=
 =?utf-8?B?SXpoL0tMK1JVc0lld3V3MlAvWStSV3JFTnNDVjVNNEdpZFRBTExRSU9NZVlr?=
 =?utf-8?B?QjlWYzk5Yko3T09INHJwSTF1ODhtemxSMVo3UTdxaDBEdmFqbXU4VUxZeFFQ?=
 =?utf-8?B?NkFyNjJmeTk1UStJdTlRTFRLOEZoSXl2VkprOStxTWgzS2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESP189MB3241.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2pTSWRXYktqWDJwcUZISG1Id0Z4SEplYThmZXY3L3lxMVF3OFVLaU9OSE55?=
 =?utf-8?B?MGM3aUJjTmNTOWFTQTlLTDhpNDYrTFFTaXpQT1dnT3QwaS9JY2pDeVFKUG1F?=
 =?utf-8?B?RGlNbURxN0o3SnUyaGMzSzFlNE1EVWt2WkZmUjdKVXZsZUdmaWZLaXVTMmgr?=
 =?utf-8?B?aTFhQm9rdDg1QWQzd3ZpY3VkZlZtUTVMeGp6Rm4rQkpIVVVhYXN5eXJNRit1?=
 =?utf-8?B?TFZZbk1XdlBHNnVidnhTeThWRy8yZWRpZ2YwMnpkTkNnblIwOUp1VHdhem1o?=
 =?utf-8?B?NGMxenNOZWpGM3IvSk82Zkw1d0JoMDcrSVFUUG1uYU9ObUgxR2dUTlY3dXF6?=
 =?utf-8?B?cEwwUzdwL0k1bDI2VjNML3BuVVQ4eDBCRmNjZmo1L3lZSXpMVzRmVEVOUEJz?=
 =?utf-8?B?Y2VOWlhxaXYwNUVENDJZTDRLQTMyNk9IbmQ1UmNYYWFYY1FFQ1gzcnJ4UmxL?=
 =?utf-8?B?UkFDRGViZTZ2b3o3S0psQ2dSdW0vQlMwM1p6NVhrWUFTMjdnb3J2NlYyUzRo?=
 =?utf-8?B?Rkh0cUtJc2dwUC9vS0I0VyttQjJFK081RlR0S1IwR293akhFcVU3aFlEQUNI?=
 =?utf-8?B?VG9LZ0RDSEovS3EvTUpaaWx3QzRkZE9ta3JkRTFOOG90RVorSWFFbWNiUVgw?=
 =?utf-8?B?ajJpcEd0OHM5SnJSVEJYTkk3QWRiblcyQ2xObGxlbU9zOXZKNy9QNjhuWGVu?=
 =?utf-8?B?VTc2THJ2MENOZGZWNkNjb1ZZQXE5Sy9vVFZxNGhjdHMyZGFzQjYvOHQ1WWp4?=
 =?utf-8?B?bkxHRk52cWxmeXhDTDJ5VEp4UXBpZmN5bEFlYUkrUjhUQ3Zpcm9FakJRUWdo?=
 =?utf-8?B?SjBXeGYxVXlqbVhFOWUzSGFxcHlJemU1Vmd2enppVHliYlNlUWtnaXVnUXo5?=
 =?utf-8?B?NHZTcTFwQkl0VzBYOWxVeVJsVldpSGI3QlpNM0R1QkxhNUw4RVMyQ0I1dEt0?=
 =?utf-8?B?L3NXbk1SRWFZbngrRkNqS2t1K0hxS0hUSmdCblVBeEdwUUNrMmd2QVBkdVdo?=
 =?utf-8?B?d3hSRXFQc1NzRzlyVmxwVnJoZnNHNzR0SU1hNGJuLzZ6UDlWS0xLb2RjeGpX?=
 =?utf-8?B?RFhoUktDMUxRaG9MMkdvSkF3MWRmejViZ2hwWk1aZ3Q5OVpqVWZUejVUdmxi?=
 =?utf-8?B?MitQelNVM2RlQ1FaNmoyQVUxVjZ4SmNqelAvU3pkZnBYT1Q0NzRubURsLzlh?=
 =?utf-8?B?QnJKam9mSVlLZ29DQ2JaWXowL1BzdzFMc2JuVmdmVmNnTmRzTis1bEFmTm1P?=
 =?utf-8?B?NTlEcDM2NEpFc0xMQjBVYXJvMmpScjl0Y3lKSU9LNForNUlPWnBSZzJxWXlM?=
 =?utf-8?B?NDZBTjk2ZWY1WE95eFdqMEpvTzlwb1NyaFEvUGlOMElaUHdrbHQ3RDNVbHJJ?=
 =?utf-8?B?Z2FnZVREaVlCT2M3T0FhbGR6dVh1VFhzbldzd0FRZ1p1THNsTFFWRE9sS1Aw?=
 =?utf-8?B?RmM2ZXZ3K0JTajZiaVVzSEZDb0RSendKdlFUVmxTTmRKK09ySTBpa2FnMXU2?=
 =?utf-8?B?bHdQL2E4dis2THZGelhmSjJHcWlwamMyQ2dxcksxNU9VdWNMSWc1eTlDOHNY?=
 =?utf-8?B?YmhBaVdpdWtCRE52QWNDVkVIRHdCcjJhakFjWmY0YnFxTzZGMThoblAzZVY2?=
 =?utf-8?B?L01IbmVyQmRKZ3hLNEJ0b0U2c0VrZDM2Z0JRWm9paXR3QWJSaDRFT1NJWEV6?=
 =?utf-8?B?V3RGRGVSS2REOWMyby9SWUp1VXRKbjg1aTNRVU52TlJGODVnTHFpMUMxaU4v?=
 =?utf-8?B?NDI0M0ZTQ1VGQXJ4RGR5eW9XQzhLSkFnU2x6ZjBOclpzM09VTEVjOGtuaHZ4?=
 =?utf-8?B?eStwNmdaRUk3aGl0VE5KdmJ6TTlVMFFUS1hnUkk5cVNWalE0QklhdlpCQ1dT?=
 =?utf-8?B?b00wWTNHOXZueTZoakV1ZkdrWW9aRWxSM2IxUGhVcEdsTExYNWZCa21CSHd1?=
 =?utf-8?B?YVo3cWVIZzIvMFJvOE5nYzErYUpQb3RtRlA0eWV1bDlhZXpOVFdiWjlreHF3?=
 =?utf-8?B?dlp4V0FPTTVXZnZKeU9kVHRCUlVOd3VpNzlBUVY3YlJPUzh6dVM3Z1VHbXBT?=
 =?utf-8?B?Q2tZMGIzenVVNUN5am9udjFRRElEWENQMU1scmJrOVc0cDVhMGxSMWdqVUs1?=
 =?utf-8?B?RENUN3NLZy91R2xJeGc4bmg5elA2VlpFV1dWSGw2VzZNek4wR2IzT1ZWenF1?=
 =?utf-8?B?Y1E9PQ==?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc2c296-4be5-4edb-9f57-08de3c7bf872
X-MS-Exchange-CrossTenant-AuthSource: BESP189MB3241.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 08:20:28.0755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qgObB+WUJ3ysB58yWuKNiU8yxuLdH095dR5BvUM+dzqGAbJEYBY3qfIduQ9Isr4tOC064L+DprwXWiSSWFQYhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P189MB2836

From: Ye Bin <yebin10@huawei.com>

Introduce ITAIL helper to get the bound of xattr in inode.

Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250208063141.1539283-2-yebin@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
(cherry picked from commit 69f3a3039b0d0003de008659cafd5a1eaaa0a7a4)
Signed-off-by: David Nyström <david.nystrom@est.tech>
---
 fs/ext4/xattr.c | 10 +++++-----
 fs/ext4/xattr.h |  3 +++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index fa8ce1c66d12..73a9b2934865 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -599,7 +599,7 @@ ext4_xattr_ibody_get(struct inode *inode, int name_index, const char *name,
 		return error;
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
-	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+	end = ITAIL(inode, raw_inode);
 	error = xattr_check_inode(inode, header, end);
 	if (error)
 		goto cleanup;
@@ -744,7 +744,7 @@ ext4_xattr_ibody_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 		return error;
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
-	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+	end = ITAIL(inode, raw_inode);
 	error = xattr_check_inode(inode, header, end);
 	if (error)
 		goto cleanup;
@@ -826,7 +826,7 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
 			goto out;
 		raw_inode = ext4_raw_inode(&iloc);
 		header = IHDR(inode, raw_inode);
-		end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+		end = ITAIL(inode, raw_inode);
 		ret = xattr_check_inode(inode, header, end);
 		if (ret)
 			goto out;
@@ -2215,7 +2215,7 @@ int ext4_xattr_ibody_find(struct inode *inode, struct ext4_xattr_info *i,
 	header = IHDR(inode, raw_inode);
 	is->s.base = is->s.first = IFIRST(header);
 	is->s.here = is->s.first;
-	is->s.end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+	is->s.end = ITAIL(inode, raw_inode);
 	if (ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
 		error = xattr_check_inode(inode, header, is->s.end);
 		if (error)
@@ -2739,7 +2739,7 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
 	 */
 
 	base = IFIRST(header);
-	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+	end = ITAIL(inode, raw_inode);
 	min_offs = end - base;
 	total_ino = sizeof(struct ext4_xattr_ibody_header) + sizeof(u32);
 
diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index e5e36bd11f05..9a596e19c2b1 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -68,6 +68,9 @@ struct ext4_xattr_entry {
 		((void *)raw_inode + \
 		EXT4_GOOD_OLD_INODE_SIZE + \
 		EXT4_I(inode)->i_extra_isize))
+#define ITAIL(inode, raw_inode) \
+	((void *)(raw_inode) + \
+	 EXT4_SB((inode)->i_sb)->s_inode_size)
 #define IFIRST(hdr) ((struct ext4_xattr_entry *)((hdr)+1))
 
 /*

-- 
2.48.1


