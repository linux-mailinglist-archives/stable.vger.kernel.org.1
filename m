Return-Path: <stable+bounces-240982-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKjqLGp+62lLNgAAu9opvQ
	(envelope-from <stable+bounces-240982-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:30:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 321F44603BC
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 957563046EA0
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 14:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2923DC4CA;
	Fri, 24 Apr 2026 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bKlP9Foo"
X-Original-To: stable@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010003.outbound.protection.outlook.com [52.103.73.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858AF3C1416;
	Fri, 24 Apr 2026 14:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777040701; cv=fail; b=Zf0MDu1RO5TIy7mcI49ZrZdroX8sDIBzlwpJqoN5In5isUF/wiB6qDsJaZFpRBhvBT68skJs9nsigWtEXmf4gjxgrppP8Jg1wECt3y5JFKiyG9NU8UJJinqf9eIjarGqXD5XwD5GIbkGA6ncaH8TLnQRYRCn6tpUapnxD0t3VyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777040701; c=relaxed/simple;
	bh=eUittQ2eA8+2FysFeEgIRvOZyGftD+vxvpKdMLQQk3w=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=JGZMPFlJGYs5jObzmBPgECXHSEgaF9lnC/pCJEVHm/bB/bWeEjj6KRAzWr2cGsMBnvQ4L4hi/Sun3LQgYQNBFckVa1T4gmkDXpgOIf1ohHvKtLjsSD2pEekl8Yt7c0tF3GnWx5P36ByYDSKqu7mEBQZQrJwH4rzc2q2R3/5asZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bKlP9Foo; arc=fail smtp.client-ip=52.103.73.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSBbVl06j4qbwQRbQa8icy1foTkEMGxKoPfATpiNh7fcxeZbYUuXnJthgvONAIp3Y43d5+thCFvm+ZZvVW570+d/OaDzQ4csz3XSSU7A+wjfQKl3HjHfxpdI9uHQ7yEQrPzEBytMu9hnfnET06DuVU0tiq6Nden1X6u44Bqowk8ZV+iWnNGccs0n+aLLFbdUFvzgvhFVNsJUVgn9i8f4ZM9l24bogeb1m48bSRs62F9d7h5wYd1aACH1++1GdbCOndLrad8jEXUlS2Bk1IcY3Ui23ukcpOXT588JjBbBBcK3S+ZhZ+tYoyCpakkRHhTxKgQU1shlR1Moou5WFEUBiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIflENiXuBCfoDjTSvZMqvm3xcwzLRQ8DUU7/Vx/YCQ=;
 b=qu5mOe2sD6tFJtTZYPkqsPFplUWSi2Kq3zGqsw4dqOwexw76tfuC8q6dO/kDeWGPq4gNUCfSDIvLoypVmVgIcCWlfhLdRyaILtJLG8pwD/sv082H0p13fTbmTZXgHCBwLl226zvXOWETu3HOhpP9q9ocwvBqwVGOfiq95YPKG4ImvTjvPk3yMqrW8gv+Lt3qsSC4X5aVdWnPkS+mODQzbiNW3GFH7Qsp6rdJK6Kj+i5UH0iHcoSAw6kAnfgLmiuXR4o9Phzi8nybIkgVmjSdAdSV+VLRlzv0TJ6oPboR1piLZAzF3Jlej63HWrgVB6s7g494BQ0YqEOhsjvprp93sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIflENiXuBCfoDjTSvZMqvm3xcwzLRQ8DUU7/Vx/YCQ=;
 b=bKlP9FooACs7iXQeIYcdJpsozbv2OIAn71eFHwvEAvjH66F+9r6J7MVm/glPi/kbu+Oy/FBGvKdsxTf+NQ32FL7BJ1SRRSqBD/BgpWj8xQfJj0cU8ACXO9k+KONVpwQyMNgUFZ44yKfrhT4SEJZlrcYMjUi9J5ZsvLmQWEhzdBK5l9O7ajv+gJ6+wM9+vxAHyURiv3T8zp5RRgwBkRdDwInCdQkhnEcIWGjdHYdLKbeTn1XDkiyCXHseZXZboy2UfpD57OwN+EH3YUBEyfpF/c21bP524p2o9m9CPns8X/Et+Umpiv9N6EP2LE6eTOAAxv0ViP5xDkk3QW+TzKo/wQ==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY0PR01MB8651.ausprd01.prod.outlook.com (2603:10c6:10:220::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 14:24:53 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9846.023; Fri, 24 Apr 2026
 14:24:53 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Fri, 24 Apr 2026 22:24:23 +0800
Subject: [PATCH] nvmet: pci-epf: fix heap overflow for invalid I/O
 SQES/CQES from the host
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB7881878B234CD11D13DCAFCCAF2B2@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIABZ962kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyMT3bTMitRiXdPUZGOD5MQUA6PkZCWg2oKiVLAEUGl0bG0tAAqCGut
 XAAAA
X-Change-ID: 20260424-fixes-5ec30cad02cc
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1968;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=eUittQ2eA8+2FysFeEgIRvOZyGftD+vxvpKdMLQQk3w=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGzNe1YiebTicyqCXNZuyKnnmjmN8xb9XiF/FOM8QOb
 HXxFfC8cLajlIVBjItBVkyR5XjBpW8Wvlt0t/hsSYaZw8oEMoSBi1MAJhJ5n5HhuTfb66bXdacj
 FY1vBJiIzfL/y1grlPLv/kqNpX9uiRd6MDLcPvtpzUpZyQsCvuwe/T+c/RfvmDRx98bapz+FWNW
 vtC3jAQAbGUpw
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: TY4PR01CA0030.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::12) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260424-fixes-v1-1-95202645890b@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY0PR01MB8651:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca494e8-ed89-420e-23ca-08dea20d4009
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999013|461199028|22091999003|24121999003|24021099003|55001999006|23021999003|8060799015|19110799012|6090799003|5062599005|5072599009|15080799012|53005399003|40105399003|3412199025|440099028|10035399007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWMxcHF1Y1lXdnZlNDUwK0JEd2hqZVZKajVXUU9Ec3lYWkU0TGFYNU1IQWQw?=
 =?utf-8?B?UkxNWHZodi9qS1RTTEJOOW13VUI3WjFvSENGQUhHYnJMbzFSY2pvSTB4QTFY?=
 =?utf-8?B?RXRBUnFGWU1HeUE2T0drZXFST01hMUtUczJiYVpNeEZJY0tLakI2VVZQUi9i?=
 =?utf-8?B?VTVpMzVmTEV6TWdkNGhBTmF3LzUvVVNORUlyVURzOC9CYitwTzVkeVpHNVd0?=
 =?utf-8?B?TlQwRjEyZnQwMzFpdGg0VlBXQUxydS9rcEtxd2t5aHpHUDh0aHBXT2xUQmxD?=
 =?utf-8?B?MDVxTlNLWlFLaWQrYWtoWitYYzU5ZmNsM212a0l2MU5lZUtSQ05hdWhiVkZN?=
 =?utf-8?B?Y1dEc1k1UmxMWlR6Y25lVGZsZEZKY2VwSVdtYkQwa3JPSGNycUR3dGJZY2dy?=
 =?utf-8?B?czZpTW1Bc2s2U0pYVWJNeXlPSWFYalNHL1cwUXBjY3ZGNElMOUgxSDd4OUF6?=
 =?utf-8?B?b1V1TEkvY0dmeGlTZE9wbmN2WHZTN2tPT0l0Vld5VHRNbGdFTHJHdmhZcFAz?=
 =?utf-8?B?REg2dUF0RS8xNU1OYzRRZ3BYcmwrUjRnQ0N0alNqMjNYS015ZklDRXFKK1FD?=
 =?utf-8?B?QXB6MWxmUU5xMCtZeTlNUFV6blNuWDRrTFpiN2lGTy95K0RVRllHY2g1OVQ2?=
 =?utf-8?B?bElsWENqdXVzcVhtMVdKWTZINDM0MmtaM3NBeERDWmlTNG9HdUpyZWRCVG02?=
 =?utf-8?B?QTNaM0xFZk5pT3FJbnRTUktKd09kOFJIbGUrV2RCMmo4MmNYaTdvRWdyQ29z?=
 =?utf-8?B?L3ZZNURVcWc0UCsyY1NwaHJ3RUEzZzZrZ05RTlNXNjY4eEM3cUNzSkVlYy9P?=
 =?utf-8?B?bWVzQUN0NDVHZUt0RERDem43cmJOVzRLOUUxWFhhSUwvOVhrbUtXRHpLWWpi?=
 =?utf-8?B?YlIwd2NRNSt4UkExNnlqWnJuWHA3RzJCRkVKSWltSksrWjQ0UWk4WS9rclI1?=
 =?utf-8?B?MGd6THpodGJLUW11TURxMEJqRStlOE5oRXNFMmw2dFpJNTI1WUZnWHozdVZj?=
 =?utf-8?B?cHVKdFMxK0QxVUVyMVdhdGgrSEc2cWt0UUswK3d0QTVmbXVsL01weHdiamJ6?=
 =?utf-8?B?a0pxQWJoTjdKUVFGK1VTdGl0WXdsNXpDS2JZN0lQWU5PaC93VzhnS25MNWtM?=
 =?utf-8?B?cjVRMFhqeTF2L0w1S2hJbWtLNk9Vb0ZHTXdTT3BPNUp5OTVtL3h5VTVBNFZN?=
 =?utf-8?B?bDArOGY1NFFESUJmZWdaRFZHd0ErVmZ4VGY1VUo2bWVlRTVZNUxKT3orUDY3?=
 =?utf-8?B?MUQ1WU1sMDFEMVpySGNkR29LY291SGpDelBzU0hEOWsyZzNjQW9STHB2ZDE2?=
 =?utf-8?B?eUtZb1c0aTQ5SVVialM4Vk9pTWJ4a0Znd08rVG5kNmZQZ0U3V2hjbytKZmtM?=
 =?utf-8?B?OGR1cGRGUG1EOWVpK3FvZzhzb2ROVU00MXZlTko0WG1QSTVZSU9WR0wrM0ZW?=
 =?utf-8?B?cXNva1ZkOUVOTW5zZDhWQ3U1UWhwWHlqVFdab0lKUEVRZVdnbFV5cEJhcjlx?=
 =?utf-8?Q?ul7uUGxIYlvXjMgbl4ycJ9MAhey?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzJxazFlWVhQQ1Y5Z2F0WjM1WHpzbDE2Wi9TVFJkajRrb0wyY0dKUFZKcmRC?=
 =?utf-8?B?ODRUZ2VVYUJUK091UmFyejRNa3RaZ1dkb2lNblRKdmR6cEtsd2UyT1RVUzVq?=
 =?utf-8?B?Mi9HK2h3TUxNTnRIUy9HRFd2UnVjMWJzMHUrMHBxTEVGMUN5cEoyaCtnSnhH?=
 =?utf-8?B?Zkh1MzRGaDNlTWlJdWxkRitmbWhVTXNQTkd1SENsbE5GZ1czT01YSzRHbFo5?=
 =?utf-8?B?UEwwZEJoM3JaeUdFKzJTOHd5U1dJWElNTEZYaEMxUFE0WmdsYktoL1FJS2s1?=
 =?utf-8?B?ajFnaThkR0VXaW1xak85QnRpRmtQakF0VUlNdWxvU2xWQjdkajhnMUFBV3U3?=
 =?utf-8?B?QW4venc3ay9JQVVyWm9wZjBSY0tpMEtBbXBBVzlvb0R2bmYwS1JkVjZNMUJa?=
 =?utf-8?B?NFJQZXJKb2hvU25GQ0xrRWNGRnhSaDNMSFJuaHhKNjRxOGh6UVliZGQrVCtS?=
 =?utf-8?B?a3BIY1FFdlUvVkVmNklzTVhJZWdsVU01MUxhUWx0UFNzQXduWTBOcGNmUHRr?=
 =?utf-8?B?WHJJc2Mya0JRdjBWVmJ1cmtwZU9sbFA3cmFsTDkzTDdFRGcyRjEyUnNlQmQx?=
 =?utf-8?B?aHZzMmczUkN5YUZFTmhQSzVFczFBSEhJekJHV2Q3UkwwMGhpSUFRdDIrdTlP?=
 =?utf-8?B?UUsxeE1xSGd0bGxkZFFycXU5OEVNM1N2ajliamR3emJ3aGZHYmJaUEkrNm13?=
 =?utf-8?B?Yk1xTmF2clJHSkhVQ2ZTbFNXcXZGYWFzbmFoR0lSSmduRHp2a0grcFJQUmU3?=
 =?utf-8?B?NjJ1ODNoVVRxTWZ2RWVtU2huNmYwV1NmVVNOL0xwUG1NTmdZbDE0ckJYajdh?=
 =?utf-8?B?ai9FdTBYdjd2ZkJCbTNhOVRDU2llTEVpVW8wZWdOQWFPVzZDOGlIU2RIaXE3?=
 =?utf-8?B?QVoxbjBGZzMrUytleDhNdndmeWc2RzNObE5iczhMZnVHQUJtNWNxcmczODlJ?=
 =?utf-8?B?QUh3bDV6RE1SVE9oL1phVGxsUC9ISlFHVVVhdVltY3ltOGJqelZFQlpLSHVX?=
 =?utf-8?B?OXJCdnUzckJlY1dSQ3VEa0tYTmlxdHlkYWFKSFB0UDQ0NzJuREV3R2NyalB3?=
 =?utf-8?B?TGpDTm0rTHJmY1phYU11RWxUYlhNTW1SUXNiL0dobFVIaHNjTTVxcGsxT0Ex?=
 =?utf-8?B?TUVRaG9vc1FGQ3lTQ3hBb2oydXZJditMVXR6a1B4NzN6d1ZHT2pnYUh3Q2Ew?=
 =?utf-8?B?TXkyaGRlUnFMa0RwdFdjeFBEdkQwc2Jua1lGUWNhcVBBYXB4cVhNQUxhZXR2?=
 =?utf-8?B?WDdjOVlaUmZ6NnhFbHJIUytxQ3pCS3UzRzNBMExDbmxWY1JVS2Qrb2JFRUJx?=
 =?utf-8?B?QUlHbjV6TStRNmZacndLM1ArZGhpckJlOTZKRjdCNmsxVU5KUkd3QlYraitR?=
 =?utf-8?B?YUdUWmo0ZGxsck9OZjhleUpxcEFpakUwaEY0MmYvNmZQdlNTeUZuZFVNOGxZ?=
 =?utf-8?B?MDlmUEs0Sm1QcVJ5d0RVR2pDVE9tL1VTdGVHUDVtRkNNdDJDREI3aTZHR1VU?=
 =?utf-8?B?UFVJUndrQXZuQVp3ZThaMkdKVS9YOWtOUmJCaVdhd3JyUnVQTkJYbGRmN2FG?=
 =?utf-8?B?RHlSMlNUbnlWUThML0dIeS95NDlIUDNUaDlRWEtINUphZnIyWnBUS0RzRVBv?=
 =?utf-8?B?OUhLTUZkdmFBVVNXNmlKdG9NaVB5d3dwWFRDbG9HY0x3T21GQ3I1RGhHbitm?=
 =?utf-8?B?cHVualhBQmZmLzBkQjNYUXRmUEdRMnVJY0g2OWJnMHg3L0ExelB3QXpoY0ZK?=
 =?utf-8?B?L1ZiUlBEYjJYVjZDQjJQUENvZHQzR0FLNmExNDN2a1k4OFA4cVpTK3pjd044?=
 =?utf-8?B?LzV0ZGR3RjdnSmFaNHhGYjJ0YjZiWUlyd0VKcDFLSkg4N2JaeFZnMDFTSXgx?=
 =?utf-8?B?UzM3anpGcGJhc0lSK09KMG1rZHVNNks0L21TOXkza0RGVnc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca494e8-ed89-420e-23ca-08dea20d4009
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 14:24:53.0557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0PR01MB8651
X-Rspamd-Queue-Id: 321F44603BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240982-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com,outlook.com];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:email,SYBPR01MB7881.ausprd01.prod.outlook.com:mid]

nvmet_pci_epf_enable_ctrl() computes ctrl->io_sqes and ctrl->io_cqes
from the host-controlled CC.IOSQES/CC.IOCQES fields and only rejects
values below sizeof(struct nvme_command) / sizeof(struct nvme_completion).
The resulting sizes are used as DMA transfer lengths against the
fixed-size iod->cmd (64B) and iod->cqe (16B) buffers.

An oversized IOSQES causes nvmet_pci_epf_transfer() to overflow
iod->cmd with host-controlled data, and an oversized IOCQES causes
memcpy_toio() to leak adjacent slab memory back to the host.

Change both checks from '<' to '!='.

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/nvme/target/pci-epf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 4e9db96ebfec..4fdd92508609 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1859,14 +1859,14 @@ static int nvmet_pci_epf_enable_ctrl(struct nvmet_pci_epf_ctrl *ctrl)
 	ctrl->mps_mask = ctrl->mps - 1;
 
 	ctrl->io_sqes = 1UL << nvmet_cc_iosqes(ctrl->cc);
-	if (ctrl->io_sqes < sizeof(struct nvme_command)) {
+	if (ctrl->io_sqes != sizeof(struct nvme_command)) {
 		dev_err(ctrl->dev, "Unsupported I/O SQES %zu (need %zu)\n",
 			ctrl->io_sqes, sizeof(struct nvme_command));
 		goto err;
 	}
 
 	ctrl->io_cqes = 1UL << nvmet_cc_iocqes(ctrl->cc);
-	if (ctrl->io_cqes < sizeof(struct nvme_completion)) {
+	if (ctrl->io_cqes != sizeof(struct nvme_completion)) {
 		dev_err(ctrl->dev, "Unsupported I/O CQES %zu (need %zu)\n",
 			ctrl->io_cqes, sizeof(struct nvme_completion));
 		goto err;

---
base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
change-id: 20260424-fixes-5ec30cad02cc

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


