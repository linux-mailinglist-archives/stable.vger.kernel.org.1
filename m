Return-Path: <stable+bounces-202914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C64DCCA182
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 03:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45F423007EE0
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 02:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC69212F89;
	Thu, 18 Dec 2025 02:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="I1WjNNbu"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013061.outbound.protection.outlook.com [40.107.159.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9632E1519AC
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 02:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766025287; cv=fail; b=EuPS88LWH45nQKvQ7n4GA5V3qfQ49TJb0NM/R3zki/JvQsEtXxJTcHyBDwlUiMGPDkKLIsgCcVbUKkeAEwEKyb7JyGA4dlFCfe3S7tcFGcVhs9+MxAH2E0yJAFjBouZBIHw6p6SjtzgfyV6uc3AIz9MBZVJoHdmu9y4YUsZJ6Gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766025287; c=relaxed/simple;
	bh=7O7vTVGDkC1vx+OtT7tbX1ceN7+xnXfl+2IbuQ/v1Pg=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=s5bH+1v8K2J6njzvKNE8/YIQtVVZo5eHauxCelUPq5dj/1gum7p6i9s7N7rcSkA5VJvJdxUcqz9EkO2O4ROuEyH4616WX3r0UG+W2lk308EtH1CsLObw1ZXijedKne+1qYJyljMLwN2lUSiT9UzVfpRQemY91PGMz96V1Xs0hOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=I1WjNNbu; arc=fail smtp.client-ip=40.107.159.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Received: from GVXP189MB3428.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:2ac::14)
 by GV1P189MB2059.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:53::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 20:58:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSUzd0ldp46M8MBTydnJNKv3r3HkWL7av9Tdw316u3nJPcoBzQdpfOe2TASz26E09NxHjLWkxS/A0YOdesuohJJemvn1gr4GJ7f+rf+N3R51t9oCFpUWBJ2SQSf15Ux0qg/D/KAaJ+uOWopG1NufoCwXO/XHQdeqklMBDgN1DcGWEmv7ZkCsXl1zl+fCDevxxXL413yHsaW6XOHzGp3/qgbDvUCUX3rROuwGhh6ZEKmAxP8x3IZuwwZp1TFV91ntoOU1g55Gx9idFOXDsEuZ5+eULNJWb8ODKoscHgpRovQad/Zaje0O/djCp5P+nsL75rBYCZBRhFrobCcxJ7qlrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHCShSFL4D+I8PyuUzLy7x44IOqVAp/h1FbeAyUW72Y=;
 b=uy2A9OhvH0uGVN+OTb8NemI22sxAEXsiH/O537ZVt9yuXW2h7TBEl8xWZ8p0TLVn+AZzAcBV7M0kuBCeoi8u+j7XABb4qnmI1R+uiGeFt2mpwHXqcuCWIPXkH/BzE2XKkjx3fkqT5AW9X+myFDgkra+aw94t/AgCVfC3IbIJAjb4VMPCzLqoOCV7E75EF9bxyVepnLIqPGW7gtBilv6Yjb/5T3KuTOpzr5slOuviCm3y1cPEhkj2rv9M0QEym5qne1czDn+ERESJjVT3TA7vDUHiXA4ixV00rvakAhqYyHaTsDtSV4ZWUI3mAP6uWDJqMyffxiUdNKrYkrXi/hSp3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHCShSFL4D+I8PyuUzLy7x44IOqVAp/h1FbeAyUW72Y=;
 b=I1WjNNbuKt7r29IxQVdxRAEIXdJ5KzoQvPxEY1QIPIlbF/IN7b2L7itee9vjeFpRPSM799af0DBeehIqCFlomoYGeJpgfqw+7UEK/1kvD7qLMlF510/WNFbNolMJan0f+VaXeZG+rQqYiiRv5lX1ht11/PgxTaRX0tAvxSu09OMVotFBy4pUoXqFte+g2/yMom2e4ZFaefbV4wLICM3n4dsLJBMSD/IWdGVxLGWPFM7yMkJRTkD1r39zYAj4C3CIpI11tAgKI0ZWGAXjbliLAn1EFssFG7DehfgLvvZztlKHHJ44YN122ViZeCB2zirkY0oAjX5y/rySz6RVo0ASMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:f3::19)
 by GVXP189MB3428.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:2ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 09:56:17 +0000
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::bc3e:2aee:25eb:1a0b]) by BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::bc3e:2aee:25eb:1a0b%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 09:56:17 +0000
From: =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>
Subject: [PATCH 5.10.y v2 0/2] Backport 2 commits to fix a KASAN ext4 splat
Date: Wed, 17 Dec 2025 10:55:56 +0100
Message-Id: <20251217-ext4_splat-v2-0-3c84bb2c1cd0@est.tech>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACx+QmkC/02NQQqDMBREryJ/3UgSEo1deY8ixcafJlBU8kNQx
 Ls3SBddvhnmzQGEMSDBvTogYg4UlrmAvFVg/Ti/kYWpMEgutZBCM9ySetL6GRNzurNitFOHxkA
 ZrBFd2C7ZA3QteL3DUHIfKC1xvz6yuNqfrvnXZcE4e7WNm0yrjFOqR0p1QuthOM/zC26L91qrA
 AAA
X-Change-ID: 20251215-ext4_splat-f59c1acd9e88
To: stable@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Ye Bin <yebin10@huawei.com>, 
 Sasha Levin <sashal@kernel.org>, 
 =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>, 
 Jan Kara <jack@suse.cz>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765965371; l=1060;
 i=david.nystrom@est.tech; s=20251215; h=from:subject:message-id;
 bh=7O7vTVGDkC1vx+OtT7tbX1ceN7+xnXfl+2IbuQ/v1Pg=;
 b=YjSaGL4VHFUyaO81O4X+Tpl42Iwaw1rk7v+ipkUBKkGDBHOxd5pM/pcoeQJ3xd4IHZI6aWbRA
 xGrcxtxc+utB8irhSnQekritZuUUVunm866/HC+ZaHxQZQi8qxLlcx2
X-Developer-Key: i=david.nystrom@est.tech; a=ed25519;
 pk=4E3iRjA+3w+a4ykfCHDoL5z4ONs9OcY4IN3pTwIG7Bs=
X-ClientProxiedBy: LO4P123CA0255.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::8) To BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:b10:f3::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	BESP189MB3241:EE_|GVXP189MB3428:EE_|GV1P189MB2059:EE_
X-MS-Office365-Filtering-Correlation-Id: 65bcc2cc-2cef-4b48-f224-08de3d5285cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bUxVNjMwZXBCZVFrcU9ZejRrYStXc3pLQ0VYR1Zkc2NQeERsd1JGdS9xelVV?=
 =?utf-8?B?QnJYTzBMUU5LclVBQ1VDWjN2dkM2Si9RTUlkRHcvVkZoWWVFcjZxWmRWbzVL?=
 =?utf-8?B?ZTJSOWtZWlpBY3grWW1YWnZ3N1VRdThjTWtpMnkvdWp5aEVGYzh5QS9DK21G?=
 =?utf-8?B?V2dlZWxOU3NWWk5CM2N5bndyNFYxUm14R0NCQWptc0lUL01WT1U3L0Zpamw3?=
 =?utf-8?B?S2FVU0RPd2ZTZ3g0M0NXaUdLdlBJRkNjZGpSVHMydGZtTXREMGduSGlwNTBp?=
 =?utf-8?B?M1Z0RDFZcUZQSjBwL3krUFF3UlRrTFlSSXFJakc5dTFFU0NhMGZCSDhjYThS?=
 =?utf-8?B?ZWE0ak5peVlmaFlPdFZtYnl5Z1FpbHl6cVpOUGVTRytaZGgwUmtJZHY4V0lT?=
 =?utf-8?B?ZnR2RVV2RzJSa2JUUkU4NTVMRFRGR0tEQnBXL3dpWjdvZEUrK3o2WENCZEd6?=
 =?utf-8?B?SmQ1R3FqdU9PY2dLZEhQelVjVm0wU0JUTUpQdk1TczROam5xYkxCR20zUi80?=
 =?utf-8?B?UkZIN0RNZHRkY0VjN3NZRnNCU2tpazNIN1lNVzFyTjVVbDFFQXpKZG5tS3VQ?=
 =?utf-8?B?VkRuRlNncTBLNXMrQ0J1S0kwSytLZzloVlJrTmcyUzZmZTFtSXVWZWpvdmNP?=
 =?utf-8?B?WjU4aXNBTmoxSFZWNlVBZVFWNUJhZzYrL3hjVHVYUzZHVHdzMEk4aXlUcEIx?=
 =?utf-8?B?amZldmlWTlRDTmNUc0NvYzJlVFlld0VMcEtlaTVha3NLeXFhZWU3WGdyWFpl?=
 =?utf-8?B?VjVENG1naGZMWU40LzQ5c2dqNDdONkdETHhJS1g2eUptaUxPdmI1MXcyTjZQ?=
 =?utf-8?B?MXRRT0NvRnR6ZGdIbWVaeWNtbHBjSlIzSFVoMTlsWS9mdGd2Q0JDZFRwZTdl?=
 =?utf-8?B?YzZRRGRPS2lhU2RIVTkzQ292NmNod1hDNUV6bmpSQTJYL0h2N2lkUThDZW9z?=
 =?utf-8?B?Z3RsWTJCc0pkVXJ0SkM4clQ1VWYxcmlTQitQWG5yWnJaUmJJVkFMcmQvNHlU?=
 =?utf-8?B?d0UrVGRSb05rSkJZUldjQ1B4TDRGZUhyeWczbnVxaHFDQ2xpWkVLeTZFbEFO?=
 =?utf-8?B?UUl4Nk42WDRWL210d3pvMHBNYVk3ZmU3K2xSYThFZ2tkZ0J3Mk1PUzlHQUpW?=
 =?utf-8?B?S21MdzVmenJOcEpQd1ZqZWd3NjlkS2ZDTHNqc2ErWUZYOG5ZOTRaS0FHNW03?=
 =?utf-8?B?dmkzYWVaY2cyWS9SZHlJekY5cnUrdncvY0dlSmU1c2FYZU9kZm1jcFE0VEpV?=
 =?utf-8?B?Z3JuMEV5MkZZQzhJZ2w1UktRamMyV05ZcU8wWStSQXErTWp1ZTNrRXQ3RTN6?=
 =?utf-8?B?RkZNMFdKc2YraGM0UTgrSTFxN0hSUW9vdFNKQXoycUlwUStIVW5SMms4N3Ja?=
 =?utf-8?B?U09YZDAwQk9SMnR2bXR3RkVWUnZTb0tBZ0FwaWFoS3FyRWtpK1J6Y0pOREM4?=
 =?utf-8?B?Z0RQdkZBVU1KZml2VWZhVTdBTGhjQUxiZmFQN0JrZ1VrdTdiNTFWT2o1R2NW?=
 =?utf-8?B?b3hzQ0NtVEEvRDdaQUJDN21ZZ3M2c2M4NVJBWStMTGd5V0I5Yy9sOFlBQzBx?=
 =?utf-8?B?N3kwaUdkYi9wdFNoK3NKN0ttcWo3Zkk1RDFxN2NLQUlDZTM5bDJqcVd4WjJl?=
 =?utf-8?B?a2tiWDc3ZzltSXFHZ1JuUGRQZ1prUnpQakhGOUdTSSt0QlFLTkZNZkxTdEtD?=
 =?utf-8?B?Mm5mZU9GQzBMZmtQODhKWDBFcHloUlFuQ0tHU3VQN2xqajJzY3ZkRzhBRVNJ?=
 =?utf-8?B?L3ZUYXpEdjJ1U3hzQ1RjSFB3T2JBK1FNQ052OVVmeWtKeDdnNFN0bzBWSVZP?=
 =?utf-8?B?WXdPaGEzNm5tY29lOFlEOStSY3pOZldISzZzb0w3bUNkZkx0bklqRVB0Sytn?=
 =?utf-8?B?YWdXVlRLSnRvRmsvZVkzbkRyQnJPWkhvUEFvVnNsL051TXc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESP189MB3241.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?N3ByM25IL3dCaFZwZHFCeWhDVHdtODNTRkZYK1FsS2VBM05uMnhobHY1Y0da?=
 =?utf-8?B?bkpPR1hoaDQwZngyMHdNZlFhdWtQUUxVRHdZcHpBSkwvd281djFvZmx4MVVs?=
 =?utf-8?B?RWZqVm9TcEpLNjRsZmNwKzhaaDVtd2hkdHBndHFSbWRCajM0blUrTVFMczZE?=
 =?utf-8?B?UTFZNUF1bVhUemIrS1o3bXhnMXNsMWM5d05qWkJybytCcW0ybEF6a0lMb1pm?=
 =?utf-8?B?ci9IKy9zZFloZzJFNEQwS3hDaEtjMjlOT2MzYjd0WFl6bTdSdlBrRllFdFZh?=
 =?utf-8?B?c0pSaE10RXNlWjFHMHZhZlQ4OUtkTEduNTJic05DV0puL2NQRmJ2ZjlvTEtJ?=
 =?utf-8?B?SzhFZDV2OU5jcDI0MGVranJQN2hrWnlRbnljRm5oWitnT044eGRNNDRDVktz?=
 =?utf-8?B?d2ZQUGNOMDVvMWd5YnhoaFdhTlJSN0ROOWFJc3BZMWhFNlV5elZkMGdXcTQv?=
 =?utf-8?B?RGtGak1XS2NWZ3Y1MmdYWjFoQ3cvaVBhRGZZYm1zTlgyV1RtTU5TRVV5dXgr?=
 =?utf-8?B?ZlZ2djVMOFltV3BGaS9sS3BEWmxMMjFEalBZdEZJdGdzZ2ZrZVZDU1V6cEU4?=
 =?utf-8?B?emdvUkNnSmpzaXp2b01jaWcxV0U3d1ZIUE56TXlic1kwa1FRcDFKQ2VVbS85?=
 =?utf-8?B?RHB1d0ZkVWtmYlVTV2RlZ1UvYkRHbTJEczNDQjRRcnZjSjFVZEFlbmFrS1Nu?=
 =?utf-8?B?RUhzMEhKeUxHaVJST1B1MFRVckpZQ3lhd0k3OHEwS044b3NHL2ozN2Rtc05Y?=
 =?utf-8?B?ZVE3Uis5M0ZVcHZ4UjE2VnZWV25SUW02Ni9MRFFvOW9pb1FuUko1K29xNVRR?=
 =?utf-8?B?L1ZyWXU2bTROdXlTT0VDazNzZ3B6bDRRT2JPNkNIV21ic05iMENiUnUzUFZH?=
 =?utf-8?B?WHl6L0RQMjMxbWwybU9LZVpvTnhLRzFDaEhuL3FDV0dMc3BpcFpTWlJxYjhK?=
 =?utf-8?B?V25zalN1ZUIxVFV6VEkxWVo2amtHNWNlMnoxZFFRY3I1OEE1cGJXcUJObGJF?=
 =?utf-8?B?aUxjNUU4OE5sQ2F2aXVZNHpMMGlTVXRibU5BS0pFdW4vRDNCU0xKa2JScHlv?=
 =?utf-8?B?RGtUU3czUGpYdHExamg2Vk5wazhSa3VzYi9DL3VSQVBUb2hzTHlaWG4yeTFt?=
 =?utf-8?B?blJJZW9zc3cxV0o0Q2I5alpPb0t2dktCeGJvZDQwL0pCblJhVzUwcjFQTzlN?=
 =?utf-8?B?MlhkOFlqaTV4RytPZnNBUDY4QUdSakthQWN6RjJjeFBQenpPUlgrT2xaa0tL?=
 =?utf-8?B?eWcvd2dlYisvemRzUXFUalVaVmMvZFppU2xSaUFucE9VSlhmU2dGQitZeUdy?=
 =?utf-8?B?YkQ5Z25nMnAzc0hJUGNGbFVKNE45U3RpbGxXVkdmVG84dGlTMVRUSHU4MCty?=
 =?utf-8?B?M2pmYzNMaWw5L0xyWTMxRzBIbW5nQ0EranBySjgrTkJlbEovRVpzMlg3Vms0?=
 =?utf-8?B?QjdrY0I3d1QwMm45d3FaNktkUElvR1czMWw5YXJ6MDNxSXB2Ym9VcVlrZDdm?=
 =?utf-8?B?WHNCdW1YUGdvbUNSd21vaGJieHJ3RlZTelgvZGF3a0l2cEZHSEhPSTFLSzV2?=
 =?utf-8?B?SzUyYnFwZmJDVkxyQktGQ1F5RXM4c1FwdE8rZFdpMFNPeFZVUHNDTCtabHl4?=
 =?utf-8?B?TGl2d1FlTUFSdUpyclptc3UvSllXaUptTDRvRXhQWU1ZUFBieHVqU3ZTOUl0?=
 =?utf-8?B?RmR0Qk45R3pLV3dJNW9WTC9ESkxCdTdJRVZnbENmdndHbUZXeWprRlRNUU9t?=
 =?utf-8?B?QXFNbDIzUGVrTjZWR1dsWFJuRGFObHZWVXpFN3UxU3pDUHFqWWRhVkI5cHI0?=
 =?utf-8?B?ZWxyVTZHcytQSFZQNnBpTlMzdnVtWWNnQ3ZhNTF2WnREa3JBNXJqRHY0V2Rm?=
 =?utf-8?B?M1VSa1NCUm8zQldyd1ovRk50WFB5WGpQUENocWxXTnJFbDlNRXFqUi9JT0Rn?=
 =?utf-8?B?NjUyYlN5a3N1Y0NiNm9wbFVZczBycnZDM3B1ZXYrU2Z5ZXlpc1pUTU0xRTJH?=
 =?utf-8?B?ZXA4U1l3dzFkaldXYUdHWVVWUzhnNktOZU9UaTYvQUNtc1hueGQ3Y3VqaFVx?=
 =?utf-8?B?bWRyWTN3cjg2bHViWXV1MGJObVFPQ2NVREIwd0NXYnN3U1VBdWYzU242ZDBz?=
 =?utf-8?B?cGdHc1NRREhaSU5lN3dHUXZYU1ZTOWhpcHk2d2xLOTFyWWxHeGNVNE9oa2Ro?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65bcc2cc-2cef-4b48-f224-08de3d5285cc
X-MS-Exchange-CrossTenant-AuthSource: BESP189MB3241.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 09:56:17.5339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yds8l8q9D95l0Ai+RaR7tTaBdT1y+cRcCZf0xDy5iIn0XFo6HT9Ss6YA+SeCLTdzi6PPUSIgjOrFEovrSxpoLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP189MB3428
X-OriginatorOrg: est.tech

Backport commit:5701875f9609 ("ext4: fix out-of-bound read in
ext4_xattr_inode_dec_ref_all()" to linux 5.10 branch.
The fix depends on commit:69f3a3039b0d ("ext4: introduce ITAIL helper")
In order to make a clean backport on stable kernel, backport 2 commits.

It has a single merge conflict where static inline int, which changed 
to static int.

Signed-off-by: David Nyström <david.nystrom@est.tech>
---
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


