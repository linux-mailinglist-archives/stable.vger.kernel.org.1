Return-Path: <stable+bounces-136936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CC8A9F85E
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 20:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41BF3A61BC
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 18:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E667291166;
	Mon, 28 Apr 2025 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uUDXQcnq"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332287082F;
	Mon, 28 Apr 2025 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745864411; cv=fail; b=sHtku8Sq323knFGyTkXt85RmD+WXUKyNNJnElVJAL+VDFTa8xhnTG7mQBfqomIPvFvEmZx3v0NQmidBXzs3vJBLALDWMX+qQuzG2q9Ir7e51MD1Gic4IuUVnd4uw4smNK68kSNYAOnRgow5kWjeX1l1oTI4O0s6Vcfy0D5SUcBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745864411; c=relaxed/simple;
	bh=258OVIEqvBqdcg2q46RKPi5ruLCiENKvfUKAHEqVIaA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hvacefejx5CNDjG1LZED8iAe9kwtbnV3dQe2Xsxuze5L08rtJBiRB6Mw7hKJ7xDEon4vT/mqXbhmZn+eBB9sYIXT1sEDY0d5dSgJk2Mjbb9xHIXTdJp7ZNE1KIISyhDmBKbhaUqc2SDa+OeoHwEoXJ6urFnN1WHbqAQrvtRWnfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uUDXQcnq; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CiyPDSddkFnN3TCAQuVp5YMIg710ZY985/1Ar13z0FmccnifcVCV7/igkYb+ie12e3yzAJMP+CJcG8xjiJs9OMyj3o/A7KWXNBe1FDG2iRgJS+pQNaOVSJZmcMqLE8oLw5SlGg0rwrUzMmXysPq/0Szhu/lCIxDYdM0qS10yl8KZDMi5kmTA7pxwr6CvsKVhCGAs/afpi9zHg8UU0nbEp0H9h5kyI9HRvbXPFr/zRb0m/wGlQQas50Op/p7iv7R6vWmnLsDh3IHwJypE+5tG2GzQB+6CBuIoo+ptLvoASsM77Er/sawTO/Le/C8NoJB8otjyXKxZNHfU6D2aRT8zug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADIaIM7W9wnaEKZbplTJzD20fV62NQArQoaQ+AOPjlw=;
 b=tcAebZLtjLuS7vVRW2l4yWbXO68i84D4v0zgXBz8NLuV78xdzwwVk9BlMKO5SuFhWgpjHVbQTA7UTaiV9TeziP679TEj893ceWFk38fFET9eVtcUH4wz4Pf2PsOGqNfw3UJIlRMVDRG1SWiEGRWT2qx2OQqPgvdzE815rIsAXDzvmTYE/aH4ZJmyJs5YqgiS/71ynxXKCGrjucT8dGEg6ZzJXjKNG0HnmVenahaonOG/Coh22MTaqJVYHgnj53xzeJq6DThM0QFQ91sCeyoVr6HpNhsEljrPU6TTHW3UyyXkC8l4zC3CxRk56FK/HklcjJRy8rMYKFLcTty1jiWUig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADIaIM7W9wnaEKZbplTJzD20fV62NQArQoaQ+AOPjlw=;
 b=uUDXQcnqfzxq6ogu118ScwNRubqaBRKCiT2DmIE1faliMDSqOmxQozGRX9ew/bkHudYFLyfozO0uzLaitU/+c1o+Yz0TpSu+VBZQrsL1y/EGSHEmcnPMEkTxuwtakc4klyROpd+GXjmZmW+BVQSHqjml+R/R7QItmDbmBqRJnaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH1PPF351A22FF6.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 18:20:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 18:20:07 +0000
Message-ID: <d5b5c2c8-4c44-4500-a56b-12888abda85b@amd.com>
Date: Mon, 28 Apr 2025 20:20:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "drm/amdgpu: Remove amdgpu_device arg from free_sgt api
 (v2)" has been added to the 5.10-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 Ramesh.Errabolu@amd.com
Cc: Alex Deucher <alexander.deucher@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>
References: <20250426134009.817330-1-sashal@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250426134009.817330-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH1PPF351A22FF6:EE_
X-MS-Office365-Filtering-Correlation-Id: 119261f7-0e32-4020-64f0-08dd86814d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1o1Y0FwWWhxMWFoR3g3UVBEUDB4WWxVLzNJdEdJc0s0S3piNTYrc0ZRQ0hL?=
 =?utf-8?B?aWRxVURySlN0RXU1R1hkRlY3cnNUMFdVeTQzb09acXJ5SGo0ZVRCc0hVbXow?=
 =?utf-8?B?bXlRd2VZQ2hwZWltYTRES05SV3c5eWIrc0gwd3BiUElBd0lNdmJ2bkN0QWJz?=
 =?utf-8?B?dFlPYjdZZHBudmRSdUVhMkpZNzQrK1R6a0IrV0o2YzBHWDE2K1VNdVIxRWN0?=
 =?utf-8?B?KzFvMFg0Vk9HV2lxWWJZd0V5UzA5YjliUHZQVXc1V2JoNFJMaDRoWmVsdGFa?=
 =?utf-8?B?dmZmbFRsbU1zT3M1b3FwZ01PaE9pRGVQcS9MVlRIbTAwTGl6Z3psWnpqK3FY?=
 =?utf-8?B?Rms4YWVxaTc1b1FZNTFWZFgwWmh3WnFNQVdrcVNlYXdYaEpBdjNzcFRlMW41?=
 =?utf-8?B?a3dMTDR2d2Qva0RJeDJjTmp5MnNsazRYL3NBNmVhemdrL0N4aDZSVjZrNks3?=
 =?utf-8?B?MDJJZyt6c2ZFeTJzNWlvb0RWaExwaExBejllcEN6dWViSXVwNmlpT3JWdG54?=
 =?utf-8?B?NDluQU1YUGxVK3dzcmNLdm1FYy9peUU3cWZiNjVxNXBmQWdiOXVKZTJCTHZj?=
 =?utf-8?B?eG5HWm5SVlRTOW5JdG9WN3pTRlJFRVBYaVNYTm9CeWhFKy9RajJqN053bnl4?=
 =?utf-8?B?aXJpTXNTdHpUaGVPeW1pYmFvelU0MWxyTnBwcjgzSTBTMHFUbnRPb0ZPK3pa?=
 =?utf-8?B?aVBXVEUvbGJldmlNM1dkNTUxSVhubllxcEhrNGhuSktWN29wbEVONVpLekNZ?=
 =?utf-8?B?WERTbjRnalN1dzBrSnh3am9RN0ltVElDdXBpZTUxWkhSL2FGb0ZaTHFjbGpZ?=
 =?utf-8?B?R3R4MXZIalpUWm9iNzhVNWdTZE00eWpBSC9uOEtsWXVlTHo2Q3R1MTIybzFp?=
 =?utf-8?B?dUhoRlZVZ0Y3d3B2Z1dkYkloZ2VWdU1sazhJNWNwRm53eVNDWUh3RjlTRUt5?=
 =?utf-8?B?Y0o1YmdSUnBYVVZvYlcwSE8zdWZrNFIxY3IvK3FmdjRoaS9iakNCclExU0c2?=
 =?utf-8?B?NFROUmJsQS9NS01GaTluM2czdUlHY0ptN2NTQW5FNEtkeDJIMHhTK3BMYkVy?=
 =?utf-8?B?SWs2dGM1anBuNExpeFRNa0VpczdBbE9FU0pTQUsyZ1pYTWdXVVhodnVIazhD?=
 =?utf-8?B?RW1KNGdLVzc4UHFiSTFwbUZyTUpTU3p0QTNnSHU4ZlpmMmh3ckJiN2xpWVJ6?=
 =?utf-8?B?UVM3N1RDUmcxZEpWZS9vTEJtekZnZmlFaEZhenNaODY2MU9Bb1lScUtFTGpy?=
 =?utf-8?B?WUh4L082TGFRbnVtZ3dvci9MM0tkUTh3YWpnUFZrRUlid2Jud0lJNDJzZUN1?=
 =?utf-8?B?eHlIY2p5bXIrYTd6ZmE2Si9iUUhkcFN4cGJGUExCMDd2QTRPM1FrNXM4WHZt?=
 =?utf-8?B?NkREVGxqUDJ0UTBDRnNhbnVQdHNVQ1h0ek95QUx0U0N1ZXVtVmpDWUtEMU9W?=
 =?utf-8?B?Ris2Y2c1aG5sL3dUS1FkTC9ScWd4ckQ5bi8vYWdVcnMvTVgrUmd5WHZRanhh?=
 =?utf-8?B?ZHZuUVFSR1M2K2VKVy9Uekw5UWxsbVNObm81bHZ3RjRYb3lMR2k2cXd3M0tn?=
 =?utf-8?B?b3lJaG5zd3V3WWEyTDU3WWhtNHdqMmwvbmNjelQ3aVYrcUp4WGlPVkVrK1ho?=
 =?utf-8?B?RkIzTzFoOTFjWWoyaGxuTHpLZ2Y1bGJwYVVwRjh5ak1qTnA0YWV0WXdKR09X?=
 =?utf-8?B?ZGdwQW9YT0pzejBZREprMHlKaVQ5aWZuRzBBcTNJcnh0d25ieURkWGk5UGlE?=
 =?utf-8?B?clRPd0ViYzU1OEczVDliV25BT1FWWUtuTENGZnJoK29KK1JWcll1ZCs4UEJL?=
 =?utf-8?B?M2VlOWYxNnR6b1k5WXkyN3BQc3dBZEhLaHVscnVNNWxmMFhDb2tjRExoVEtL?=
 =?utf-8?B?RUIxQm01R3JrSjNmQmJ5ZVVRZzdaQ01KYTh3ekpxNjllRmZ1VHJ6S1BsZTZt?=
 =?utf-8?Q?8TjYVLESxtI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2xFWGkxTHE3bGRPcnVvQTJ1UFdYWENSSE1Qemc4ODQvT1RJeXd5b1NPL1Mr?=
 =?utf-8?B?OFE5cnRkSHYxY1dERTBSZUE2ckVzM21rVi9XbXVlWHdwUXdOZjBDbkRTd05h?=
 =?utf-8?B?NmNlbWM4UG5jWlo3SVBudlhxSUJwbjdaVVNyUVhWcFp2KzJEYm9CQlpGQjkz?=
 =?utf-8?B?T215b0tnNW5jQ2Vnc0dJS0tuY0t6UDhCaERhTlZZZjF3MDZGQmhaMzJVYlBr?=
 =?utf-8?B?NDhXVzU3ZVR6MGptdkV1dHFDbW9ET0tqbWxjUXJPOUhwVkhXU29hR3JCLyt6?=
 =?utf-8?B?ekVpYjU4aTMyMGk2dW4rM20yUUp5VGxQTTVoaUFkY1ZUa1h0NUJ4d2JKSzZa?=
 =?utf-8?B?UVp4dG04SWhDV2JCTVhqZHplVkxLbTZQWHlIMmdzaTJpcmtHcURkK1Q0YTBR?=
 =?utf-8?B?NDErKzluRkR3OTkxSytySEN6WEwzRUdSZGRjRHp1M1pja3FlaWFrYiswblFI?=
 =?utf-8?B?ZmlwVnpYQzNZZU03eG5jNFJnMmVXdDdSSklzY1JKQmsrbkdBOHUzKzFRc01X?=
 =?utf-8?B?dnNyRlhiOWV4U3llUllEdmdKTkQ1ZzV3UE9LaEtCWXdlQmQwT0ZGWnVxMEdw?=
 =?utf-8?B?ZFFLNzE5SkxlTnBDQStwb3JxQXJpd1NjT2I2R0JqWTFGZW1RTS9rR08xRUtp?=
 =?utf-8?B?N0hyUlpGTzFTaVFJL0hhUHlaWUpaZEgxMW1MUXZiRHhCSng0T1c4aDF1a1JB?=
 =?utf-8?B?MWFtZEx0V0x6NjVFT3YyRk5HSCs4d3VETDB1QXZKaHlsL2NMT08yNzE0SFJo?=
 =?utf-8?B?WlVxbXAvMmtQYXBlYTVCQ2w1SXk2ZlZiYXg1b25IekpPQWhXczF4VFJjOGNN?=
 =?utf-8?B?RU5hcGNoZ0NaQlM2M241R1FIWUV1bUcwZVMzMVRyUnlpTUh1QXNFbGhhdHZW?=
 =?utf-8?B?bFlpbXRPZ1c5Rkc5QWl5UVlXSG84am9sUWRLRTJoSlVKUXVLb1NwL3NDaFZF?=
 =?utf-8?B?cW0vMnl2ckkyS0VadWgySHkvNVhQekRZVGtCUlNlMVphMXVQbko5dG5hUTQw?=
 =?utf-8?B?SDZVUmFjRG9YSFZraEg5WGZ0M09CRk1OK3FwZjh3bm9KUFFKd082bmhDTTRj?=
 =?utf-8?B?aE1GeURZQ0Z5d2xRYVdsREdqdTl1MEhCMEkwaERLZ3kyd2VMWldQZ2dWRFlH?=
 =?utf-8?B?MG9rWHR3TS9TWHZvU0c4akk5Uk8wZFV5R1Rnb0JJQnNKYVp3NUY3dG1IK1RM?=
 =?utf-8?B?QkY1M0Nmb0UyeXZyV1Jra2dvc1diKzladXFyZG9SV3pwaStPeG1SUHpDZzlt?=
 =?utf-8?B?aTdLS1p2UkNCbTdqUE11blhxSXYyRHlVWlZydzlPam1wMDRSYVBjVFl4cHMv?=
 =?utf-8?B?OWV2V1NzQmJBSW9TRnBxRnNpNGMyTUNtNWpBWDVkMjdrYUlCWjBaVkhUaTJz?=
 =?utf-8?B?dEQzc2JJanE3THVWOGdIUFNFdWVzUjh4Tm4yajAwQVFtalBhRnZBMERURi84?=
 =?utf-8?B?RE1TeUJvVDdHdDl6T3JOWldaS1JlaWt4QWhpTEgyNkJPWm5OTytXWjlQM3lh?=
 =?utf-8?B?M29KTlRlWEpyMnFPSGhKbGtvTVA0UHdHMU5KbnlONkc3bVh4bjZiWFNueHZE?=
 =?utf-8?B?TDZPcXJFMVhvV205TWNYUGtRWlJPdW5OOXZFWGE1VUdjMklVeGxlTVEyMzJ5?=
 =?utf-8?B?ZS9oRjR5eit5QW1LaTI5aVVzMHJ5MWYwRGFLTWRIY2UxRDdzZDJWWTlNVGli?=
 =?utf-8?B?QnhtOW9Rbkx2dUtldjkxQkpjcTZUbS90RWtualEvalo2MHl3SkRxL1Biendt?=
 =?utf-8?B?bVo5Q2MxQWJ5K3ZMbmlkR3o1R0hzVzIxRnBJN0JmcWhkajZ3b0ZTeThjdjlo?=
 =?utf-8?B?Ullsd3BJejFJdVBES2F1KzJZZHlHUXhpMm1mdmtUZEc5ZGN0U3FFdHRkZVQ0?=
 =?utf-8?B?eEFvWTZQcGFqL2E5Z2p0eUs0WjRrZ0Z1N3didVJWcU1RU1lVY0dab3hQdUx5?=
 =?utf-8?B?SzNCVHdtQTF6eG5SSnlxaUF5WVF2cjc1OGViNEsxNEc2QUZ3ZUlGSXFOSTNC?=
 =?utf-8?B?NEpGdU1PMTAzV1lXQTZsdVRZLzNteitmNjBtV2RJVUxxejkrQnZQemtsR1Bs?=
 =?utf-8?B?emNZRC93NmV2SUp1ZlpiaS9zdXNJSng4dFFINXIzOUpLQWdIeE1WOHhzWXhl?=
 =?utf-8?Q?cZwDwGyNakHMwsMADzMv4+BMH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 119261f7-0e32-4020-64f0-08dd86814d8f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 18:20:06.9325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDdUC1TEMZ2Tn/kKy11Os7fUhQBiHGWVY/fEUk53ct5c7O3MLFRIe/JvfGv8v+D3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF351A22FF6

On 4/26/25 15:40, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     drm/amdgpu: Remove amdgpu_device arg from free_sgt api (v2)
> 
> to the 5.10-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      drm-amdgpu-remove-amdgpu_device-arg-from-free_sgt-ap.patch
> and it can be found in the queue-5.10 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Mhm, why has that patch been picked up for backporting? It's a cleanup and not a bug fix.

When some other fix depends on it it's probably ok to backport it as well, but stand alone it would probably rather hurt than help,

Regards,
Christian.


> 
> 
> 
> commit 09a1b6ca7c7d9c07c702479646a0a8cfa2329e11
> Author: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> Date:   Wed Feb 24 20:48:06 2021 -0600
> 
>     drm/amdgpu: Remove amdgpu_device arg from free_sgt api (v2)
>     
>     [ Upstream commit 5392b2af97dc5802991f953eb2687e538da4688c ]
>     
>     Currently callers have to provide handle of amdgpu_device,
>     which is not used by the implementation. It is unlikely this
>     parameter will become useful in future, thus removing it
>     
>     v2: squash in unused variable fix
>     
>     Reviewed-by: Christian König <christian.koenig@amd.com>
>     Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>     Stable-dep-of: c0dd8a9253fa ("drm/amdgpu/dma_buf: fix page_link check")
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index e93ccdc5faf4e..bbbacc7b6c463 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -357,17 +357,12 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
>  				 struct sg_table *sgt,
>  				 enum dma_data_direction dir)
>  {
> -	struct dma_buf *dma_buf = attach->dmabuf;
> -	struct drm_gem_object *obj = dma_buf->priv;
> -	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
> -	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> -
>  	if (sgt->sgl->page_link) {
>  		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
>  		sg_free_table(sgt);
>  		kfree(sgt);
>  	} else {
> -		amdgpu_vram_mgr_free_sgt(adev, attach->dev, dir, sgt);
> +		amdgpu_vram_mgr_free_sgt(attach->dev, dir, sgt);
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index a87951b2f06dd..bd873b1b760cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -113,8 +113,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
>  			      struct device *dev,
>  			      enum dma_data_direction dir,
>  			      struct sg_table **sgt);
> -void amdgpu_vram_mgr_free_sgt(struct amdgpu_device *adev,
> -			      struct device *dev,
> +void amdgpu_vram_mgr_free_sgt(struct device *dev,
>  			      enum dma_data_direction dir,
>  			      struct sg_table *sgt);
>  uint64_t amdgpu_vram_mgr_usage(struct ttm_resource_manager *man);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 2c3a94e939bab..ad72db21b8d62 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -530,15 +530,13 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
>  /**
>   * amdgpu_vram_mgr_alloc_sgt - allocate and fill a sg table
>   *
> - * @adev: amdgpu device pointer
>   * @dev: device pointer
>   * @dir: data direction of resource to unmap
>   * @sgt: sg table to free
>   *
>   * Free a previously allocate sg table.
>   */
> -void amdgpu_vram_mgr_free_sgt(struct amdgpu_device *adev,
> -			      struct device *dev,
> +void amdgpu_vram_mgr_free_sgt(struct device *dev,
>  			      enum dma_data_direction dir,
>  			      struct sg_table *sgt)
>  {


