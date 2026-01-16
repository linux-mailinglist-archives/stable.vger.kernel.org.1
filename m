Return-Path: <stable+bounces-210019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DB8D2F740
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 11:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF8723118FF8
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 10:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE97435F8BF;
	Fri, 16 Jan 2026 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="ahO0CJ2k"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013061.outbound.protection.outlook.com [52.101.72.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21AA35C1BE;
	Fri, 16 Jan 2026 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768558587; cv=fail; b=JJviqE1hPGSThX+2MfeBRJtgOi0W0iV9mCEVLlRSBALY5IcnuoIxxaLNoDxjrvahKBgpBBDqgrlUZcoCIIQBRsOM5QGuvm7btuVndVqsZPBGwLj45WoEkpiGi40qmUBD+QSo3pwBwJKaaEVpThOv4nnEBlmo8bUX+Pkh106Sk4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768558587; c=relaxed/simple;
	bh=eHaXiSaa6BZo3JjErF0x6A2Uy4Iv08Ps8TazRfsZO9M=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=ZJqDdjjBuQ569frODo6rDkCB1kf2mbHJl6BdzObDHm+TPIQfaWBGrV/C7KQHG3cd6bYorFjxtGcCgMmauqxhM5sj/isgmwYd4zQpqOcMZbylG7KV5RLR74BOlG0R87wE72/yZAg5hUMtLOf7rYEMYqHSqUnROtYOX0x4fb+SmXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=ahO0CJ2k; arc=fail smtp.client-ip=52.101.72.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ig0SX22CoWPQu2zBTjKI4hyoF4dgf0PoJTxZ4uaZY3k7um3yPMPZCmgFOhs+vGHLvKGIMl+NSTYOmp46WeD968aoI95qml/uE8p3utU0c48L0DCL8XjbsJPQ6zRoQY68yIbkq1gl/BN5gL8dvYcEOgXXBjFvlxqfcfh1WpFYiwbiGdULn2AoHkvXf2R/RpvhMDDF28hrCTrqlByg7LlgU5CiGW1XL3bVi8BxTmam6BnVsVwpP1xf8eF6IfayLN+Vkk4t48EIfblmiXLCYkAPwKmsw+UF8q955g7ygnA3XyF6o4U/ouP5QiXwMlL/iu3J/9fOw97dst7CHoE0/g4NJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NHswKUy6QoJ04L0aUMHdOoH7m1C/w/7npYG2EI+/Mo=;
 b=NyABmWwBVxjAMwwc9OcLnKlWBvj/nyEbmgavf4edpbjwUKp6OEeJ1XnGp6YXySN9yF9O08QXs+JovP43cQWUEd13x/OcZIXMGZ5x1k0uZ4cm37iIo+veknAUnnfQ3pIfWbcPXF7YY/6LqZtqOy8a40c7RxfPv7fMfquRnP273X0pbeLoUM6D528ZL/q3A2Ajf2DAoXrrAElQbYZj6Sbrpb0eLa4TB26PtQtXh+HaaX40SVCYwg5BM58jiCY9/x8cT4qBcn2Hwdi0lDw5+7VN/df5GHZ5skmz34YFELuCK+RT6TplfTvCTVB4+3xxkRBFH1ApBeWv9CrHS0/XNpXztA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NHswKUy6QoJ04L0aUMHdOoH7m1C/w/7npYG2EI+/Mo=;
 b=ahO0CJ2k7a2bPKpJzUiwmVZh8iaJcX5zO06dVRLADTAc7dd1qxIbXFxZbaRYFP3pKsrzX/FPuR4b1WgedbeHgpgQEk8boZQALKveEGR6eDZYjxO3qEwemrShj4Mmxk/klqQnPciJ8yB9TX/C8OPdgUS5LSmNtLgIAv5wHCjXj7SSf/jvADptSMm7CAWtWY1J/gNLp6UQ/pw45ypyM7u8v3ifTU7ln9zUL76sr0kF4z+ICreoLol1QHbB3YEmYs3ZdKa+PIbTJHKbM+fxhNOKPKOpLZpVvJ+SHHKazPcKU0wL6IAzaVeQv8HZk+C3N+d7+F1h0C8i9M4tTIEY2nHr9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:f3::19)
 by AM7PPFF7BA57FDB.EURP189.PROD.OUTLOOK.COM (2603:10a6:20f:fff1::6ae) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 10:15:09 +0000
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::49f:4bc1:672f:45c8]) by BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::49f:4bc1:672f:45c8%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 10:15:08 +0000
From: =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>
Date: Fri, 16 Jan 2026 11:14:45 +0100
Subject: [PATCH 5.10] net: mdio: fix unbalanced fwnode reference count in
 mdio_device_release()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260116-backport_cb37617687f2_20260115100804-v1-1-9796615d93ab@est.tech>
X-B4-Tracking: v=1; b=H4sIAJQPamkC/zWNUQrCMBAFr1L228humibVq4iUJt3oKrQlqSKU3
 t2o+DnvwcwKmZNwhmO1QuKnZJnGArSrIFz78cJKhsKgUVskapTvw32e0tIFXztLzrYu6u5/E2K
 LRnlvA0euD4MxUFRz4iivb+YEzZ4Qzr81P/yNw/IpwLa9AXUhbUyOAAAA
X-Change-ID: 20260115-backport_cb37617687f2_20260115100804-bb6cefe39d44
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sasha Levin <sashal@kernel.org>, 
 =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>, 
 netdev@vger.kernel.org, Zeng Heng <zengheng4@huawei.com>, 
 Paolo Abeni <pabeni@redhat.com>, Yang Yingliang <yangyingliang@huawei.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768558504; l=2771;
 i=david.nystrom@est.tech; s=20251215; h=from:subject:message-id;
 bh=eHaXiSaa6BZo3JjErF0x6A2Uy4Iv08Ps8TazRfsZO9M=;
 b=BoI23BM8YRN/8GD18gU/LKCM4N+37L8lZGdr774FtDbKhA6rCVIy3IMsYwgxWaUD4m3P+5KjS
 +/fpF85/jpQCxV0/EKZwND8k/LsGvJVznsI7kQrAW9uQB48Adoo+u5r
X-Developer-Key: i=david.nystrom@est.tech; a=ed25519;
 pk=4E3iRjA+3w+a4ykfCHDoL5z4ONs9OcY4IN3pTwIG7Bs=
X-ClientProxiedBy: LO4P123CA0336.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::17) To BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:b10:f3::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP189MB3241:EE_|AM7PPFF7BA57FDB:EE_
X-MS-Office365-Filtering-Correlation-Id: b58bde87-4416-47dc-9e87-08de54e8200b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHlvMmR2NXBSUUY1YzBwWFNLMUFxWm4rSVc1N3BpWWFYb1REQmkvMGo3N3FB?=
 =?utf-8?B?Q09oV0FodGhNMmRHMkFVU2RVdHN5STJ3RnhoczBZZXQyWEtoS3BXRlJTNnB6?=
 =?utf-8?B?WTU3OEU5cE9nM2hWTThzRnRPdmF6bU1SaXhSazlmUUs3b1ZhZVhteDV4ZFZv?=
 =?utf-8?B?YktpcWZrT2pjM3NKRGdVcDNSRHQ1eXFVTUNmQWZQSnlsSFR5N0Q0NDIxcGdw?=
 =?utf-8?B?VFh3VGhhWWdKWS9PbUM4NDkwVTF1b3FoczI5YXBzbVhrcG9yOHVOMHUrOEht?=
 =?utf-8?B?b3craDR6OTlvTktQMWpPL01RSEVPNmJxbzg1MVljVCtCb1RiRDFjU01Ed3Q1?=
 =?utf-8?B?RHJoeE1ZVnZEYTJ1ZzkzNHFUekVQSlpOYnUwZmdPTWJYNzMybm0vYW1mVm1V?=
 =?utf-8?B?SGdFSEwwMlFTREY4UE9uNTdJUXMwREpvZ1NBdjM4a0hOWXpLSXVHTFY1WTYx?=
 =?utf-8?B?UkxQT0ttS0tZS3pydHRoeXdscHhwcitSTnQ2SEI2OEw3SWY3TzRiMVUwNktM?=
 =?utf-8?B?S0JYeC9UVlliZXZPc29KMzRjVU8rdzduNDI3K09sSnhpQitwYzM5Z2xBeCtM?=
 =?utf-8?B?d09xTGZWQUdKZmhnV2lDenFKNXZlYUNnQUtEa2xVYjJEa0RZMkRtcCtZZzVG?=
 =?utf-8?B?aGNUbDdnTldnd3ZQdkJjQkloQ2lWWWZpUUVqNFVEWFZCRFRwTUN0bmlIamls?=
 =?utf-8?B?cmtjYXBuMlNtem9jQWZ3SmppQndUUnY4UlQ5S1NzNFRBQUVnRlE3Yk1XNTho?=
 =?utf-8?B?S0V4NGV0dnhKbEQxWTU4Y2h0Wm1sNVJjTU9OWjZWVWRscHJRb1lmR1F5dUVK?=
 =?utf-8?B?Z0xkMzBhMkRpOVlMa2U1cmdoV3BGQnRXTWxmdlNMSGZrWkV3UCtZTkVLSFlP?=
 =?utf-8?B?a29LRWNaZEVvbUtPcUxIUkxZWExWRjRmOWtnb2ZQS3pxK1kvS0V4MlJWcTJR?=
 =?utf-8?B?cFMycERFd1dEZGtwSVluVHlVZDFtdkIzRkZXeGtjL3B2eFhBWjY0Z3FMek5Y?=
 =?utf-8?B?Nzg2OWcvM3IvNWtKUFcrT1hvcnpMWW5HRDIyWnNuWlIxN1BjUW9KRFh3Mmls?=
 =?utf-8?B?Z3BxblJPU1h5amhsQmZ3SlhoTXhnYnZoUnJjTGl2Zzk0cDVwdHIzUElibFNE?=
 =?utf-8?B?VUZvVVVtR1JTMDFTU2pYcFpBT0tSSTU5NlNZUUNVbTYyRmRTd3MrSitSTUtl?=
 =?utf-8?B?TjVBMUkxRVdScm41dkM1WXZhSkp1UGM5cE5KSXRUUjNpZVhMTEtnTTMxRzVJ?=
 =?utf-8?B?N1Z5bEtDbCt5Q1g3N28vSmdVSzVrVitRSjRaMm9GUmMweVd4WHBWTm5WZlM2?=
 =?utf-8?B?VTFZeWJrMW5HaG9SSTlkMVBNTHR0TnNrVFRkTW96N0I3S25mNWJPTkhaUU9I?=
 =?utf-8?B?YVRraVRNK0ZrTktldGRrVTNkOFVGN2xQcWZydmxoRVJqNHRCbTlsSnQzczIw?=
 =?utf-8?B?WWR0TnU5MkZDN2pDTDVETHNGR2hzMGRiaXVLcU40VUZyKzNXMHE2M25JSUZ6?=
 =?utf-8?B?K2loODRERDdvN20rcEFhT1cyY2xVMHJSeHNzOE9LaVpERjFScm81UTlhSnhn?=
 =?utf-8?B?Z2JoR083MnFTUDNVKzJqdUpxb1BJQ3VEUlNUWVY2WEZiRkhTZU5DUFVuTzlL?=
 =?utf-8?B?bG5HTWlvdkI4TllqK3NjLzNaUnRMWmdKL1JNbHhqeVlZeG5DOWN4dEhRWCta?=
 =?utf-8?B?V2RlelhjdTBLYXg3UjNoajhJaHdZWE9YU283SFZrMktmOU5aa2JPVmp4OHN4?=
 =?utf-8?B?V3pzVVNmUEFnUVFBQlZKa0lJQzBDd0xwQ0p5MVZZRVNYb3ZYTUxUcHJxYnNC?=
 =?utf-8?B?RHBHakRrTmhuMVRGcGhzdm0xVi81S0xadmVsN09SNUZxZDYwT2JYTVpQb21t?=
 =?utf-8?B?di9GdEIxY1dIdldRNTd3SitPWWRLMHhwOWNDR3g3V3UyWE5XSWU1SDdwTWdS?=
 =?utf-8?B?c0RTeUVOVmowU0FCalpUSHBSVzVmMmlPSVNHb2Z5UUZRVzVhck1oWTQ4YVlu?=
 =?utf-8?B?NU96WHdGK0twQ1ZLL0ZaV2JicDNOdkdLVFpnV3FrcVcrNEZXL2pmZmwzc2FE?=
 =?utf-8?B?OUdBVzR3blJ5QWpuVURHdUt0ZllXQzA4aW1wT1YvUWRHK3N5OHYyeWs5ZHIw?=
 =?utf-8?Q?wcec=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESP189MB3241.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDgzcFMzVmNEQnlnVU1oZng4U3FkeWhXZGFSekdSUjVOVFhwTVRFNXlDMUwy?=
 =?utf-8?B?UXFLWjNXalVoQTU2dXR4VERsVlM4OUZkdjVKSGF6MUM3NWY2YkhUSlBVOUF2?=
 =?utf-8?B?Qm5lb0M2cWxBMjBycFQ3YWcvemNCdWxXY2l2UmxpSlVCcXJ0QTZLRmExNitX?=
 =?utf-8?B?bi9kbDk0SUQwUm9yUGhNR2FCdWIyVjNLcWtBSW81VVY5LzZKMG55b3NHeWd4?=
 =?utf-8?B?Z1dxelZ3QTJaSnBHZ0RRZncyTWVhQzBqQTY1YWxFSDJwYWhkL3F2eU13V2tU?=
 =?utf-8?B?bTdjYlhLYVdlWFdPU0srdXdvWDd1dVlqTTErR3ZjT01Kci9Cb0luWFBHUzl3?=
 =?utf-8?B?MTBubTI1eGtqQVFrQ2RVMjJaMUJOamdGR1EzWW4vZVc4MFZaRVVHR1R5cTh0?=
 =?utf-8?B?WXNZVUpsYXJFMEV5TnhDbzN4NzJ0Zng2NGdBNi9jeVNORndiWnZncmlRNnpw?=
 =?utf-8?B?SVFYQTZ0VGNQKzd5T3BLK1d3Q2MwN2YvUHN4bHc5UkVuUG96MjhJaXBacDlI?=
 =?utf-8?B?ZUhyd2R5OS9uRThnWTE4ajNGSnRFakFiMUdBeWlCSmZsQnU0aU45ZlYybEZt?=
 =?utf-8?B?Q1laN1hOUVBTRjBFd0ZjMUZUbFhHSUZ2OExVbXZEQ2x1RTErdDhlb3IwL2VT?=
 =?utf-8?B?cUpMS3JIVnBGQ0FZQTM1K2lrVmxNTitpcG95Q0plRzZ4dHJyb3l5bEh3UU9a?=
 =?utf-8?B?Y3dlclk1UldSYlkwcWRYVTdUSVVmVkFaNk5ObnpPbk5LaS9QZVpJZnlMcXpC?=
 =?utf-8?B?cmhaOTZRR3dmSFNnSjd3dUpXVUNHanBubzhNNlRGYjNKK2hGMkxjZmh2UXFF?=
 =?utf-8?B?Y3dZQmRSZUN3UFFnZXd6dy82TkJtQTIrblRxbWNyTTlkbXJZS1FiTzdWZUhw?=
 =?utf-8?B?NVNRVG00dU1ZbkJ3ejc5QzVOT0VUYmpkaVVKdmRleitra3dEN1F3WkxiNHQ1?=
 =?utf-8?B?RWxOSGNrR25tVFNabHZkbndrOGJGQ0xVTVppWTkzU0NxbUJLdzdBK3lxQkJO?=
 =?utf-8?B?bk9tZTlXd2VUT0FFTzM3Z3BmUkZTNTZkMXh4eGhLSkYwQkFIcGM3OWRRajRz?=
 =?utf-8?B?bStIZkg3VlkxRlpCRTFOdzh4bUVXN0RWeVdqUm1uWlAvVXJnaTZkQlhVM0Ev?=
 =?utf-8?B?TEtwbHBHMjA3NmV6RXZmTS9QU2FIaTFSTXNzZGhDeXoxdUJLQXR6M0RXVmho?=
 =?utf-8?B?QXBwc1duVlJUdVd0UDVoSzFsa2hRRGJ1RnFua0JMMXBoaTlqbXZTcURoc2pi?=
 =?utf-8?B?R1YwN1hPanBjR2w0M1Aya2EwNWRLOUlPMHg4MUVRQ3BnMWRSdGQ0ZzkzUmJr?=
 =?utf-8?B?V25rcFdWWFpQeGIwUFRlRlI1d3dWSysyeU85Nkc0aUNyK1FrTVdYZmYwRE51?=
 =?utf-8?B?L3BmVW1tNmNKVkZtK3R1bk5NYUZQdlRyVU5CNlBLczc3TUZLU21jSkQzdHlD?=
 =?utf-8?B?cWZ0Rm9rOWlnMWgrM0U5VmxMNm9SOU1adjhRRDlhQUkzQ3A5RDRKRzhyR0sz?=
 =?utf-8?B?akpxUFR2RDlFclhHZ0hXMmtsL0dYRW94ZzloNU5nNXBkRjhHUlhjV3h3b0xL?=
 =?utf-8?B?bXVESFFZcndzcUt0SmNFNlJsZFo4em1NL3g4dngzZXRiSHNYMGlWb0FCMys2?=
 =?utf-8?B?ZjUzZjVCai9zZHp3dU9BdWdxUFVrVVgvTWVJTFZYcmJhRXNQZVNGWEptRFd1?=
 =?utf-8?B?OVFySjVvazB5SzJFYXpMMWRlZkt6U0Y5Z1poSzNvbUJEck5uaEJ6ZmVuWFNT?=
 =?utf-8?B?c0hnT21ld2t2SzNUUmYyZmJrOGlkMnUvWnE1b25nVlNoZjZnSVFNWHg5TFY0?=
 =?utf-8?B?NGp2dG14UVN0SlNsR3VvZUJLWEUxV1pVeVI3N0w1WHM1V00wTmdCQjhSMjln?=
 =?utf-8?B?U0Vsb1JCNU9kT01jd1JOZm5KQzJ4cjRXWTJJVWNTWUZFMElybFR2SDc4Y1RZ?=
 =?utf-8?B?RWU4K1FSZW03Q0NNYnhwTHp4QVIwOEVOTDAxbk15eU05c0FPemtmUHNSaWI1?=
 =?utf-8?B?aW52dVZnUEhqaXJ4VjREdjFnaExCYTNaTVBscGNXV3pVUDhxbHhreHQ5WkZv?=
 =?utf-8?B?R3hiZHVKT3BMdEpYM2l3ZVRiKy85bjArRjloZ1lGTkNZdXdTZ2N2V0pKdzRy?=
 =?utf-8?B?SjVPWlp6ZW5LNUQ4b2k3N2p3VUl6MklkWHF3ZE12ZmVQQWI3Vk1IZ1BwRHM5?=
 =?utf-8?B?ZFNRaFVRZEt2ZG9MaTZwY2tkV2dEOUVoSGtubU1sT1lzcjA4ZlhtbkxWTU16?=
 =?utf-8?B?allCZVhzd3EvYjA0czJNb1BKZjRKSWI3WkxkeWl0ejJxNy9VaTgzdTAybzJC?=
 =?utf-8?B?bkRJL2k1bEZkSFdzT3ErejJpMXVFYUxhZDRyN0VVZFNwL29VRDUrQT09?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: b58bde87-4416-47dc-9e87-08de54e8200b
X-MS-Exchange-CrossTenant-AuthSource: BESP189MB3241.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 10:15:08.1358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WJu7d0pZwE6jB+43agfSk2bYCE0J8dsIiRVkfPlP8MUEMX31FbuY8IDGc04LVkTvDw6JQP/XCP0/UzyxkirZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PPFF7BA57FDB

[ Upstream commit cb37617687f2bfa5b675df7779f869147c9002bd ]

There is warning report about of_node refcount leak
while probing mdio device:

OF: ERROR: memory leak, expected refcount 1 instead of 2,
of_node_get()/of_node_put() unbalanced - destroy cset entry:
attach overlay node /spi/soc@0/mdio@710700c0/ethernet@4

In of_mdiobus_register_device(), we increase fwnode refcount
by fwnode_handle_get() before associating the of_node with
mdio device, but it has never been decreased in normal path.
Since that, in mdio_device_release(), it needs to call
fwnode_handle_put() in addition instead of calling kfree()
directly.

After above, just calling mdio_device_free() in the error handle
path of of_mdiobus_register_device() is enough to keep the
refcount balanced.

(cherry picked from commit cb37617687f2bfa5b675df7779f869147c9002bd)

Fixes: a9049e0c513c ("mdio: Add support for mdio drivers.")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
Reviewed-by: Yang Yingliang <yangyingliang@huawei.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://lore.kernel.org/r/20221203073441.3885317-1-zengheng4@huawei.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David Nyström <david.nystrom@est.tech>
---
This series backports 1 commit(s) to the 5.10 stable tree.
---
 drivers/net/mdio/of_mdio.c    | 3 ++-
 drivers/net/phy/mdio_device.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
index b254127cea50..355c3ee21cd7 100644
--- a/drivers/net/mdio/of_mdio.c
+++ b/drivers/net/mdio/of_mdio.c
@@ -168,8 +168,9 @@ static int of_mdiobus_register_device(struct mii_bus *mdio,
 	/* All data is now stored in the mdiodev struct; register it. */
 	rc = mdio_device_register(mdiodev);
 	if (rc) {
+		device_set_node(&mdiodev->dev, NULL);
+		fwnode_handle_put(fwnode);
 		mdio_device_free(mdiodev);
-		of_node_put(child);
 		return rc;
 	}
 
diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index 797c41f5590e..f72d18ee2792 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/unistd.h>
+#include <linux/property.h>
 
 void mdio_device_free(struct mdio_device *mdiodev)
 {
@@ -30,6 +31,7 @@ EXPORT_SYMBOL(mdio_device_free);
 
 static void mdio_device_release(struct device *dev)
 {
+	fwnode_handle_put(dev->fwnode);
 	kfree(to_mdio_device(dev));
 }
 

---
base-commit: f964b940099f9982d723d4c77988d4b0dda9c165
change-id: 20260115-backport_cb37617687f2_20260115100804-bb6cefe39d44

Best regards,
--  
David Nyström <david.nystrom@est.tech>


