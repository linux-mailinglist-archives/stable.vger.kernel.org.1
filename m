Return-Path: <stable+bounces-207875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64140D0ADDE
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 16:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24FB5305A8C0
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 15:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F141350A1D;
	Fri,  9 Jan 2026 15:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="O3ChJvH9"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010019.outbound.protection.outlook.com [52.101.84.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7DE363C40
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972206; cv=fail; b=NmtPkOpe24ZRxD0bf40mFDNYv7w4UUJFQveL6qTxY9X8RxrA+gnTsAhny3YtQHSBeBk6udVkJed5I1sGFJQEDZ0gfzsMZ66B3QlHbqpDfWcwT+sVo3ckQ/D8DsIiEP39/QaZLfG2jeRuSMQZbtsnqO7H6xFGkoopuhYMKOL2vNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972206; c=relaxed/simple;
	bh=QEJa+XwXfXgZXTivlj3A8W0g4DfkftsYKiT4+uZJUeA=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Dm/dYvs1keJKCvZwz01gE3Pe39qMXUQG/Wp83BVC34lSEObZHpChfabR9hSEhvo8Z98pQ1fUDN51T/AAynM4sWsQs16TIu/psCyeWIfZg44v/zvHnyyGXzwyCe81YT17IRXCTWCodYM2ewSY90vMRBe8OPHdMjCMKp6kd6VEFyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=O3ChJvH9; arc=fail smtp.client-ip=52.101.84.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hi03SOwBUfiFI7dxHdxACI7dRbg4KGT+R+E/V7vMgCT77KX7XUTiq7fuwPDpuL1zrOdOV4SrhuDxwygOg7aDBZLlAjbSP8IcZfdUYT6ephfVmGLjTiGeGGzheJAXAc+cEVW1DPOsCYi+igDWrefvsn2DyWWCN4s3+yAe87DSeqX7lTo7Ch9o6Roe/JihymQOg1lXVGW+xihgx/jBBh7YkqO9k+3QdgNfKDQmVN1lUM0HUSA/XHL1mKUQ//hgZ4rj/8wgWo+Uhh+tvSJkbDWehx6DUJzyQ0fCie3tF276kAHBvSuV201UrJkLkkeWaAR5zXFhnpa+paFCdlLisxCpMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgBdgJvhDv27su5p/fKKQuM1kKZMP6zaVyH9t8IM1u0=;
 b=t7jOKab06obM8eBbC0n0H24hR6hzNFO1OSH136EtfznSjMW7Fqf1ParRcwNvyYy15CsuLb4Pjy7cO1YPrwj1OZr0wXaOBr5yLfuCpUjh4ewwVzvF1bHN3/KVdSJuJRxTXJPc1oVvXhsMkeCIVIcn5a+WZBMb9S7MW20WxYw2OBlnYy1bVrASoBqEEqaq4KujLyGXkQxi+4kfaT5rxezI4U4zkMgA/n21uaSn648CRgdyN3P/cEeUV7XiB/UyEGPENMef+4s3BdH0w1ZbqSdcpCHdn0NjbYHyzRrjTdSbfahY2CoHBOLKdSHPy+I2ZbsarBW6j2HfnPSZJiNGoeDkVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgBdgJvhDv27su5p/fKKQuM1kKZMP6zaVyH9t8IM1u0=;
 b=O3ChJvH97w7yO/XGGcLBh2ZXtrIUOabo2/D/4PhNIEj7gLoHUaPWZgJHHLng7jrxqSwZL9G5Q4NIG9TjT6byeEsi44DkbZUy0fYfIhfOeviEFmBRfjvRh//cdQRY7tDLaf6xK5NniXoX5XvhfVO45c0908oZ0Wfn6+XY1oTV8l0LRzm6oKyQSeDAdSYotRZa/G1OCrXjxgP+nhVem24uVn2Y9UlOASwAraUPt255vkIeBcceosrd4i9BvgitJ3uLtmci9ippqwvkYVk8hdx22RmCaJIrJ+Co7ZDqg6Qj55LqFeWBq4KChnW5b1pPP7185zHClgpPnsu55YIStbu51Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:f3::19)
 by AM7P189MB0916.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:170::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 15:23:21 +0000
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::bc3e:2aee:25eb:1a0b]) by BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::bc3e:2aee:25eb:1a0b%3]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 15:23:21 +0000
From: =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>
Subject: [PATCH 6.2-5.10 v3 0/2] Backport 2 commits to fix a KASAN ext4
 splat
Date: Fri, 09 Jan 2026 16:23:12 +0100
Message-Id: <20260109-ext4_splat-v3-0-bb8dfefb8f38@est.tech>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGAdYWkC/1WN0QqDIBhGXyX+6xlqWrarvccYo/R3CaNCRRrRu
 09kF+3y8HHOt0NA7zDAtdrBY3LBLXOG5lKBnob5hcSZzMApl4wzSXCL4hnW9xCJlb1mgzY9KgV
 ZWD1at5XYHdqaE1kzCo+8TC7ExX/KS2Jl/wXbczAxQsnYtdaoTigrxA1DrCPqqVQSP5vdn8mz2
 WglxpFrpg09mcdxfAH6DFID5wAAAA==
X-Change-ID: 20251215-ext4_splat-f59c1acd9e88
To: stable@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Ye Bin <yebin10@huawei.com>, 
 Sasha Levin <sashal@kernel.org>, 
 =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>, 
 Jan Kara <jack@suse.cz>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767972197; l=1279;
 i=david.nystrom@est.tech; s=20251215; h=from:subject:message-id;
 bh=QEJa+XwXfXgZXTivlj3A8W0g4DfkftsYKiT4+uZJUeA=;
 b=aM2EkXlVA7WSI1oCvBMJwyD0nuOvLCwQfI3rXwGUdhN2RG73hqU4Zt/DbBIgJdUn97gf6YJLW
 fTTWgJ7GoJEClKakcIxwV/wEcpcre64mMtXqNcvEvEOq6+xeBQ1mdFQ
X-Developer-Key: i=david.nystrom@est.tech; a=ed25519;
 pk=4E3iRjA+3w+a4ykfCHDoL5z4ONs9OcY4IN3pTwIG7Bs=
X-ClientProxiedBy: DB8PR06CA0049.eurprd06.prod.outlook.com
 (2603:10a6:10:120::23) To BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:b10:f3::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP189MB3241:EE_|AM7P189MB0916:EE_
X-MS-Office365-Filtering-Correlation-Id: 34053972-eaec-4e5e-686d-08de4f930633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGRpY3d5L0Z1RDhwaE9aL1dDYXZ5MlcwRkFIVmJFL2kwdEFjN2ZBblV0RWFS?=
 =?utf-8?B?WHBKU3l1U3k3MU14WTBhbzFSa1hKbUIrcXpBaXZQTmt1WGJ1TkMrbDJSV09H?=
 =?utf-8?B?MHFhU3VzT2dTWUpBdDY5UXpWbE1WNGtnZWcvUmc0US9sRWxFbUYxQnN0SHox?=
 =?utf-8?B?cWhpZEc4UVVPRG5IME4zeEsvRWNVZ2dmd0UwdWM3cGRIT0xhTkZHUE0yaFYv?=
 =?utf-8?B?ek54SElsU3FOR0hXUWlYWVZPQmd0UlFwZnpmTFphZzJuMEZyQWpaaHNHVHRt?=
 =?utf-8?B?dkNoWVpBaUpwMVZLTFFCZEF4VEwrS0M3WG1PaFNGREhFUHpQQ2s5WUNDZ1h3?=
 =?utf-8?B?bjU2eTZPM25Xcy9tdGQ1R2duZCthSGtnN29JSlJmNG5zUjdHOHdTcHkxajJj?=
 =?utf-8?B?MENkRnMyRlozYVVBUHdnVHE2NEhLUXlwRHFaeXlaR0x2TjU1L1Q1cGdtZVFK?=
 =?utf-8?B?M1h2Z3VLVHdQcjhFZEtEZTZUMWN1S1BFZTBXS2QvbDljUTVWQnJ4K3pLTVI5?=
 =?utf-8?B?a2Rxck05ckxZdUxlYmNiaERFMHcyOWhZSXp0L0oxRU1NMk9wVGNoMkVJcnln?=
 =?utf-8?B?R0VTZUpQdk5WWTBxbnkwV2pjZFowQlhrZ3NoMzRtSUh1T2xPbzBrQkpLMTB1?=
 =?utf-8?B?em9KbjR4NHRrUlZTbzNmYnh0TzJ5SWtwWVNjM0k3ZTVIbk9sbm04NnJ0aUdq?=
 =?utf-8?B?V3VtVHk3YlJ2ZEVGNGhYNEk2K1pqdkl4Q04zRjNqVks4WE1qblBwNUdmNVlq?=
 =?utf-8?B?QjU5Z2VEWWt2NDQ3MHFtZ3NIazVPS3dGQStCeHlPRFc0TU1yOXgyTUFaODZN?=
 =?utf-8?B?b1J6R3FlSHRtRk1mbW1UZVBNSWJIbW9pcjZNMUU3RDRsSXZqc2RTVzNRcGQw?=
 =?utf-8?B?ZnlCRS9tMkJxcTBaeGQycTlPbFY1bll3bFhyOFBnc25qUmh2MXFpRUs0RVpj?=
 =?utf-8?B?ZmVwVkN2dTF6WTE5alhDV2ZTb2RFTjRLY1Y1NzFWZ1NqR2haOEJBOHpTMVNp?=
 =?utf-8?B?ZjUzcWttWjZDdDZMbUx5NFROUUphMzk4SjdXUlNUM2RWai9FUDhac1dwczF4?=
 =?utf-8?B?U09vTjRKc3l5dEllNkRKVWNReHpyRU9DRkNqcldCSEZLWDBJV0YrYjYwbGFY?=
 =?utf-8?B?MlZESzBvOU9wNWY3NnoralhlRGk5ZFVCTzVXZ0I1R0syR21sclJhTlVPMDNm?=
 =?utf-8?B?NmFzTU9NMC9DcjhLQUd2ZHgwVlhMNlk2TTlwVkxxWHdSMmJUR09Rdyt0SFVa?=
 =?utf-8?B?NFlpV3VpZU1wK1ZNT2t2NVp4TzVya2tNdEx5clAzekVYeGJwNkJWbjQwRExL?=
 =?utf-8?B?dkJONmZvTWtrK01zRFFFMUdnRnNmWXBxSjJlVncwajNiZm9DWmEwRnZldHFT?=
 =?utf-8?B?a2E5R1pzR3JYLzNXUVFTREJtS1h0TmFDRDBVcDBHV1ViUWhwTXdkbkI1ZXJT?=
 =?utf-8?B?OHdYN2tENXVNaldQNDdkam1LYnVnbUkrVGFNQ3E5M3o3bHNOQ0J6ejhBbTlD?=
 =?utf-8?B?eGp6dmkvT2xzRk51OXFmOEw3eVdzMldkT2RpMC9Hbk14UzBTVXpPV0JkRmVq?=
 =?utf-8?B?ajlCcCs4SGNxY242akhqMWgwWDBlamxIZ1VsQVdBYXdmNWg2RnJHRkZad3ln?=
 =?utf-8?B?M2FsTkc2VTdicTZZeG51bnZqUFZMN0ZDY1VRU0NyQlFLRXFLQ2UyQllualpC?=
 =?utf-8?B?ZS9kOG1hNS8yWmMyR2Fsckc5QnhGNkRhVFRBbVg0VFhtSW1wN3hvM0pON01U?=
 =?utf-8?B?RkdKRjBSUEt6WHNxQk00TnhiMzRGQ092ZjA1bWdhK0pGQWg4UmxEaFJ1WVBJ?=
 =?utf-8?B?QXczR3YxT0Rnbm45b2FyRythZCtPMlVHdlRsRGovUEpZWGxMTlhNTTRvNDJy?=
 =?utf-8?B?MkhvTS81N2oyT3hlM1RaZWlJMHFva1NCaGtrT3JtTXFEQmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESP189MB3241.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkcxVElsS0EzRnJsWFlSMEpNa2oyWitEOUNtT2tXZXlWc1NqWFlqQ1ErUU1R?=
 =?utf-8?B?L2FjeVRWeGFjWWJubGxnc3ZQTVJSdTl1bGMwK2tkQnRudnFPSG11bzBid1Q1?=
 =?utf-8?B?a2pnOFJvSTlKWkd1R0hvRTQ4SmlJVzFrWWJnVVRUNkp3RXJPU1R4TjBCeVNp?=
 =?utf-8?B?M3ZveGdwMHN4UE1vWThJTlY0dVNHZElkTXNEQmtFdFEzWGNsY3J5ZDYzdFh2?=
 =?utf-8?B?SnRtdEliYWlwYXZYK3oyTkVMR2lXYWdlaDRSNVVVbW9kVTRvQklkMHJ0VHhl?=
 =?utf-8?B?NHd3YUMwNWJUdDJjWDlwQXR1VUY5QXFUMFNRQkJ5QVVTYjRiMUZLb3RGb2tG?=
 =?utf-8?B?Y0h2dnR4SVRaTERIZzFFdko5Z0ZwOFptRVNFejk0bkIzUUtaMTF0K0sxOFE3?=
 =?utf-8?B?QlJIK0toYXYwQmFzN0ttOUtMeDZHZlR6OXVuaHNHUUEzWDQrTG80V1NkUUlU?=
 =?utf-8?B?ZlVRK2NZQkdzZHY0V01KaFlKWTdKdlJ3ZHM5RWI0Zy9yaWcvWVVQcndYZk1l?=
 =?utf-8?B?Y1A3NWYvVTNFSkFCWWEvRlNhYktMemFYQm45ZmdGS2tETEw1SEhDcEg4ZkVv?=
 =?utf-8?B?dFkxNjVGNTBHWFZVbjFEOXR0bkFPcVAxUkhFUmNsUXpRRUh6L1BOQUZVYU9W?=
 =?utf-8?B?UWs4WVZ5cHhjRGE3UXB5bXVtZy8xSURSVEE5SVpGaStzUzA2S0VRQkE5d1FM?=
 =?utf-8?B?eU16RXlaL0xOWHhpZSt0Y21nSDlHWERhY3lpczhGODRmamFreUdib2hEdHk2?=
 =?utf-8?B?WDNkYnMyRWdzb0puQU9kK2xyWGpzeEdpLzZtZjhOZEtEZlRtYy9VVzhGdUMy?=
 =?utf-8?B?TGw5UWhTVkd5VFM3T0VRWE1WUXJvM05vdmhialFvQUJFZk5Id2IvMXNGZ1BO?=
 =?utf-8?B?TExRSklDdzdiMlY2alFCOVkwa0VCR0FpZVR3YWcvWis5RUsvMlFqeER2Tjdv?=
 =?utf-8?B?VlVMaXFuOWJpWVFvZlhtQzErZko4QUZobVBuMjcxdzdkdHVUejRBd0hGTVR2?=
 =?utf-8?B?RENWV3pXelFmVDI4d3gzSWdMZnVUN042WElHb3l2V1ZjV01KRnIrdWVkUDlt?=
 =?utf-8?B?ZXI3blFqYTh0R3pQdHEvb2pUOUloY1F3c3Jwalc4am04WmM1ejB4emZaN1Jm?=
 =?utf-8?B?T3dqamY3Z0VzaTJlK1ZGUkFuL2dweit6TVNZcGh6K2Y1K1EwV2QvRGV4aSsr?=
 =?utf-8?B?RmYrSFdOcXRaVllmcEMxZFh6TTdHYi9vK1hNTkdJeTM1dnZZWUxsYzJMYUcz?=
 =?utf-8?B?SkZ1dWE1Y2lJNWFESGdQR0hXQ1lKWlFMMk9sdGtGbDRHRjJGVVNYSVVyQjhB?=
 =?utf-8?B?cGxqTDh0cWQvQWF5RzAxcnBGNklmSlhVcVliTGRtREdmZm5hYmdhR2ZrL3Bq?=
 =?utf-8?B?VFhybG8xSlMvYjloY0ZPQitGNXJLcTlXcFQ0SS9kbXVod2h5cFM3bE1XdCti?=
 =?utf-8?B?aWdxcUMyZnpzdFM2a29aK21BbmUzREcwR1dWQ0g0RUk0T3RLeDJoZjJDVDFV?=
 =?utf-8?B?aWx4b1N0SmRiZEkzbitIYnMvbnVsUHcyQkNza2UxZndnZGpBQ0JZaTJ4ZWRC?=
 =?utf-8?B?Nk42ZFNOb2k3aTN5bWlia2x3V2JIejVNWk9LQnJ1UFhFUEJXRm9QM0VTUEJ3?=
 =?utf-8?B?djFjL2ovcE03ZC9qb3M5VHBHMVFUVkt6Z0krYnQvN09HaHFOUGNDaWtqS0tD?=
 =?utf-8?B?VkpwZHMzdENVSHpLUGZzZ1ZjckFSWTVDSkowcmpIQzYzT3ljNzNJOXlSQmV5?=
 =?utf-8?B?aEJydCtIK2luL0pRK29IcFgrWXdWRGhITHFkTDFhOEJJRE5WR0U2M09zQlVM?=
 =?utf-8?B?aURXdmpxMWdyeEYvRTBpaEFIdDQvdVBJQzVmRmZwMXExWERWcmpoK3c4NlVn?=
 =?utf-8?B?RlJ4WDNna1h4c25mQ2tyTW4ybjd6MzhsTzZCMFI5NTdoZnAyMDcrVVhTai9y?=
 =?utf-8?B?T0l4S091aUdjMnNKbXQ3Z0JOajdVVFhNTHF1SjhMb2FjNVRpSVhjZ2RpRGY4?=
 =?utf-8?B?MzFDVE10UTBmWFovOGtEM0J0aktpTjlHZnBBQnNuK2xZMlh6MkVpOXQvZzUz?=
 =?utf-8?B?MEVVNmxzTTJjZkpvMWk1QlcvQ2U5NExHM1FRdTJCQzQ3QldETU9nWGJ5d2lw?=
 =?utf-8?B?dStKbkovNjM3WjRncnhBT1dGc2lwdW5pTEtaQ2Zoa3JSV1FzNFdKWjIxeVlw?=
 =?utf-8?B?czUvRXB4VHo5MnZDZ2lOZ0psaE14NDFYWjBBYkVPME5vQzJzbXBCUGlEekt0?=
 =?utf-8?B?MzBCMithVzRHcjJmVHZiZFhwd3pPYktjQVB6VzBNbmFydFJiRnRIOVFSUlFP?=
 =?utf-8?B?UnRFQW1uSDNFN0NOeUcyelNiWVczRWoxZ1p4UjZtRkVob2tueGtvdz09?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 34053972-eaec-4e5e-686d-08de4f930633
X-MS-Exchange-CrossTenant-AuthSource: BESP189MB3241.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 15:23:21.6564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KuzQBMF+HpdFyQiuxlCyMrKebyLiZ4DWsy1+FdJ8f50XI8bO9/j4T/MIJatVE1GJti8KDOqeaYTrb6FwlJ38Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB0916

Backport commit:5701875f9609 ("ext4: fix out-of-bound read in
ext4_xattr_inode_dec_ref_all()" to linux 5.10 branch.
The fix depends on commit:69f3a3039b0d ("ext4: introduce ITAIL helper")
In order to make a clean backport on stable kernel, backport 2 commits.

It has a single merge conflict where static inline int, which changed 
to static int.

Signed-off-by: David Nyström <david.nystrom@est.tech>
---
Changes in v3:
- Content identical to v2.
- Add correct subject metadata regarding which versions this is directed
  towards.
- Link to v2: https://patch.msgid.link/20251217-ext4_splat-v2-0-3c84bb2c1cd0@est.tech

Changes in v2:
- Resend identical patchset with correct "Upstream commit" denotation.
- Link to v1: https://patch.msgid.link/20251216-ext4_splat-v1-0-b76fd8748f44@est.tech

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


