Return-Path: <stable+bounces-143057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBEAAB1839
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 17:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A6F3AE6CD
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 15:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E55F136672;
	Fri,  9 May 2025 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AnTyr/Sh"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A374BC2D1;
	Fri,  9 May 2025 15:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803959; cv=fail; b=MG+sarEjtxXbHHWdvGTUxmEkXY2w6cFvWKRH2O7feShK4fGtNfhiaERsk6BSXZzwOUIgQu2KyTZzfphDOQ4s1fkxhq+G3saAB4ieWHeX2paGu/BZ29L4+Ti81RlRKdoYt42bWP+aGlRPC53qmPi+eEqPDm8zZKqSxRs3jrQbq3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803959; c=relaxed/simple;
	bh=ehCpp435tiTtu91ejRO20+AZyys7f4rlMeNOQuHTh9w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CeXIb8QwzBQUtMVvpeqR6G2PTR9FaMTUy7N30ZKRU1pnPdMC/aB0WdMOhO5H7KGa/JhPRwVc1td4mWUQFjrISDwOR2mF/83Leac+VGy9+R6aZ/d4TpOyx/XDR+ks2rcIXiT3+KmyDiwp/kMXLeB4xeptm8rFy/53yydGEYVxkWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AnTyr/Sh; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HeMVESf9i3dC9L7qGzkJiv+7cSRJON+270DUZ7unC297vFXOlfroodrUqvDYawY7ioIBLPk9dQ5LBmtR3DrLkBwXDskID0RCkoxj8D/VD+r5yIzCVmuT7kKrdKfa/lw5OwHEJf0uT7uF4oam3S66d6j9ax9uiQY4S9UyEt2fn5/0Vl0bJgF4rqcak/6zNU0rv5sIH1RWa2cxWyhQnzjtaGERPl/94MhLMgNl74XEp1y3oRq+AEH0M1FlkrrLfsOSRu2E5bgekwopAEY+M19D3av+FwklblLWpcTrCpeSBYuMCGF/Z41hbQ8TF+HpfU5cUN6FXspBq6/Cyv0QCwDFfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehCpp435tiTtu91ejRO20+AZyys7f4rlMeNOQuHTh9w=;
 b=K4F8DwnN/VwzD96duZypkSpO5PQFDp/fsWNnSmQV7WQ91NYiYKXe53Ma1PeFYK+vwYpjtqLzMP14kCwdbzO1ad5SXwazvSGULIoxIGNb36G1NrkQojD9TFcHq0Yb2OKSqZn2KmZRBDMDEv4P/rWzEw5QZccsvdvWAT413JSUWzmlkrqiBNYXB4DXLHP5t2dCZAZAKreO8Y9dVRYdBOGnDM4UwV4FKBnzKZmmFPKf8H5nJ7g/Rkwdh6hh7BKdsVeBdOaMsJXM4DI13AslZ9jopecXXANXu63JhWJpS/Ux9Tr/Gu1a6Vu10eN/Co68J+IamASeehjMXcX8ebfpwzqA6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehCpp435tiTtu91ejRO20+AZyys7f4rlMeNOQuHTh9w=;
 b=AnTyr/ShOIh4gcfC7t7+IZlHZ3gGvUayom32YTg3lnB/VD8Ewa2xHFCFW7G6lLDQkW/m/8tglVKVZZYQ6Sd54yOa8jY/8/6h8nvC3W8S64uKMl0ZdwwlNyY19uJfDcNkdP3D3XwY812duBh9CbX5Jp0e21WiQJHk0w7YxQKtJBKJbxBqzdZbopLh5xcKLfD2hoLtryVYGqsAhcy2xqTDaYWR+gSHaLrhMu0cicXhg82X8eAxxcRikhXmCvoUL3Wh67OYwXw0f4kOZfz1E8k9qtSK8YJpA2LRPdBhMvhzC3e2m3BrrrNH69c2yk1omvzBcVnygZ39KSbeBsLUg5e6kQ==
Received: from SJ2PR11MB8369.namprd11.prod.outlook.com (2603:10b6:a03:53d::16)
 by SA3PR11MB7486.namprd11.prod.outlook.com (2603:10b6:806:314::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Fri, 9 May
 2025 15:19:12 +0000
Received: from SJ2PR11MB8369.namprd11.prod.outlook.com
 ([fe80::4db1:768a:9a46:3628]) by SJ2PR11MB8369.namprd11.prod.outlook.com
 ([fe80::4db1:768a:9a46:3628%7]) with mapi id 15.20.8722.020; Fri, 9 May 2025
 15:19:12 +0000
From: <Don.Brace@microchip.com>
To: <zhuwei@sangfor.com.cn>
CC: <dinghui@sangfor.com.cn>, <zengzhicong@sangfor.com.cn>,
	<James.Bottomley@hansenpartnership.com>, <martin.petersen@oracle.com>,
	<storagedev@microchip.com>, <linux-scsi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<zhuwei@sangfor.com.cn>
Subject: Re: [PATCH] scsi: smartpqi: Fix the race condition between
 pqi_tmf_worker and pqi_sdev_destroy
Thread-Topic: [PATCH] scsi: smartpqi: Fix the race condition between
 pqi_tmf_worker and pqi_sdev_destroy
Thread-Index: AQHbwBfZPlM1zE0Lekqm6elVeHxO9rPKZbiAgAAE3/c=
Date: Fri, 9 May 2025 15:19:12 +0000
Message-ID:
 <SJ2PR11MB8369E480AEB019041B756254E18AA@SJ2PR11MB8369.namprd11.prod.outlook.com>
References: <20250508125011.3455696-1-zhuwei@sangfor.com.cn>
 <CAF=wSYo0=US5Rj8Qbo7tbPLTtEVR-E=q4w07jCvU3nMroZBKmA@mail.gmail.com>
In-Reply-To:
 <CAF=wSYo0=US5Rj8Qbo7tbPLTtEVR-E=q4w07jCvU3nMroZBKmA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8369:EE_|SA3PR11MB7486:EE_
x-ms-office365-filtering-correlation-id: 15eea8f7-4ea0-49b4-1e3c-08dd8f0cda40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dzJMNWV0K3NTYXdydmVsVVhVa3lBVHVodmdQVmNKWkZlTlphZDExc3Zlbyt5?=
 =?utf-8?B?RHIvTzRKY1VyeW1SUVVsZnl5TmhIQnlQWGZabUxWMFNZOGttalB2RmtXSkhK?=
 =?utf-8?B?MjFlQ2cxamNmaldNbHBCVHdQYy9RTUdDcFFLZXIzdklYYUkyeWk2eVEvV0pR?=
 =?utf-8?B?TDJFdVp5K3Z3OE1RaGh1V0V0QUJjRW9uSlBzUjBLcTFoMnpQL29kNXh0cFBI?=
 =?utf-8?B?bDVZdTk5OXNIbWhTMlU5UEI4Mno0a0xxbjd2KzBHd0pOQ2F4RFdQWWU0OHhF?=
 =?utf-8?B?UGl1OC9mWDhFRERXUVR1NXpWNlZIVlpWSTNON1J3NUxobk9lcFEwOE50dG55?=
 =?utf-8?B?VjNWZ3hJaGRMdFZDSTZSK3pxQUJsSjY4aERsakZWWXF2VVJOTTFyVVBrR0lH?=
 =?utf-8?B?RXd4ZUNiM2gzMWVuUmRCbjJhYm5qWGk5a2RTVmRwM2c5WXdMNEZiU29kYkMw?=
 =?utf-8?B?RGpiT0VLWTlKdVRNWDBJVWVpT25nRmx1V2lqSDVSTGF1V01WSnkrUlo1M0ZU?=
 =?utf-8?B?NlorSmpGdnRSNU1MSm5sbmRoMVVEQVkycGg5bjYwSmpLT01aNHhCSTN5bEhR?=
 =?utf-8?B?WUsxdDFpNGJXTkc4OFFaakN0bTJ0RnpSL0JrNHdFQm52T0VhU2w4SkNmKzZP?=
 =?utf-8?B?NFdNc1hiVDlaalZlcGg4aUliYXpORUIwY1hoSGkvRHQ1NGhOdXBNbzExS3FE?=
 =?utf-8?B?T2tHbmFHVm5WMDJBMWd4UnNleWF3WHBwcnhHNGw0Ky9EcHZQRUhrOTduQXZy?=
 =?utf-8?B?RWplbnc5SEhHNVAwd243R0t0OC91SDM2aGRzUTFzTjFPUEdWZjkvZ2g1Qktt?=
 =?utf-8?B?YmZaNzZMSXZRWmpOOU5HMm1nMmc0cVZ3eWFtVzJtcVY2T1RkV2JVd1ltOEtw?=
 =?utf-8?B?clhES012SXh6UWJrc0FtMmp2d3RIY3IvenFUMTlXU0ZoSnlIalNYMno5OWRq?=
 =?utf-8?B?ZjVJM3BuUmtlUHdtNkNPTGcwODgzR2JNOFBKMnZienRCMWNwWlk4VjM1YUdp?=
 =?utf-8?B?K21uemxUYkIwczRMV29vK0pLeGVTNS8zTzFkajhuV3dQYmFQLzcycmJ6VFZo?=
 =?utf-8?B?RGdYc3UySXFRUjVnb1k1OGVLeEM4THh6QXFSZ0N1Z0xNZmlKcmVTTlFrcXRl?=
 =?utf-8?B?TS9aWThqY0Rnb0lPQ1NNc0VYZlBIVlVsM0t4RFAzTnYzb3E4TXNPTjNMSzBp?=
 =?utf-8?B?b0dRcFZ3UVQxZFR6SVhqRnN2QnlLV2FHeGpNLzl3Qk1Mc3czQVFOZEFsYXRQ?=
 =?utf-8?B?dmRUQk9hTjdYblQxK3hOZVU4OWtXWUpZZk5NZ0kvci9HYmpaLzY1Q1pXeFB4?=
 =?utf-8?B?OWRlN2luVzhiQlNMVzYzSVBhL0FHeEprekh3eWhxM2YyQkRKdmNrUEhJL3li?=
 =?utf-8?B?YUtYNTFNdHlDRVAwQ2x1bUtvNjZLQWVtZjdsT25aeFhwT2R5S2M3em40ZDZM?=
 =?utf-8?B?a1BiaW9Bb0txbmNOcEFiTlBLNnl5YkovR2J6a2FkbWNWbzlHbzA1d04rSWJF?=
 =?utf-8?B?c1VjNDlSdlRFcGQ1LzdKc01sbWpHcWcrUkRmTDkrUkovWmFxWTQrZGVOdHN0?=
 =?utf-8?B?TW4zeXd5QWNuZGxITG00U3k0L2dWTk5RZWwyUHhyci9HQ1F3eTFuZ0NUVVhy?=
 =?utf-8?B?RUxBb0ZYNXByZWtjV28zV0w0SURwTmRKNGJORnNNUHFXLzVXL0xHenVNUWFo?=
 =?utf-8?B?SHlBeFM3Z2pobW1vUGNkUWtwS2NBL1ErWTl4MXRMRkRXMktZbXNZemtTNnBN?=
 =?utf-8?B?RVdQWVl4elRGN2RQUGk3d3VLZldFZVB3NWRPMGFHOE5VV2x1ZDE3NGRnSGps?=
 =?utf-8?B?a3NXMzVRVlBtNXM1ZVpGODVYRlFqKzlxUlZEYkd0UFAxU2d4Vyt6NkdJWEtQ?=
 =?utf-8?B?b0U0VXpJbFNoSjVXRkd6bjRNN0JaaGZGWkRBTEtFVWlleUx4VFNjV05oUUlD?=
 =?utf-8?B?QVVHR2VFRjZnblROUGFrdnh2cmswSmZFY1Y2K1RhVkZKMzRxamc3VitpZTRs?=
 =?utf-8?Q?rHmli1FSFbxjZ5NYjLNr94YHMorYk8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8369.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aWdDTUhOK1o4UVRvY05MaXgzelhOa08raDM0M1ByVVlNc243cm1kRnlnMjM2?=
 =?utf-8?B?cnVwOTZ2NnlIZWh1ZVBDb1R3RHhpSEpLaURrY01lZGFxZk5Yd25IRVJ0NHpY?=
 =?utf-8?B?RmJtdE4vbzB4am1YaEF5ZmliME1UKzI1MVRldWFzb1RHL1Q5ZGlNNW5xdUVp?=
 =?utf-8?B?R3ZkVXEzV0x4YmU4Sy8wdjdDaGN5cHM0YnVZRGt1SFJ4d0ZMR05GcSs2NlZh?=
 =?utf-8?B?ekVkRVFQdCswY2lWd2hTZ1JWdWlLMlFjUGJDQ1p3ZmtwTDFVMnFGOFVOK21z?=
 =?utf-8?B?R0NZdzc2RkdhdU5BempKZ3VqYy8yYlJiZkZtUVFZZit6bjRpQ0tqU0FEaG1y?=
 =?utf-8?B?RklYZDBmd2g2R29xc1JmMXBiNnRxR3NDd1V0RVlUSzY0cVFiWnUvN1ZHd0lH?=
 =?utf-8?B?WVlEYk1zSzhVemhHeVcyVHJ0N0k2SHZwTFJhOCtNZHk3L3VQaVh1R2xGU1F4?=
 =?utf-8?B?MTZoNlNFbGp1cCtpanJqbnZWRytHUFpuV2RvekhOK1lPbTN0emQxUEdFYXBr?=
 =?utf-8?B?Wlc4aDlza1JPRlRUL0c4Wmp4WEdQNzlXMW1kdFhJS3ZmLzVpdndIWXBkMzNJ?=
 =?utf-8?B?QzlYeTBET1ZpSnFETzg4QmxFQkhZS0EwbzNsWFkzZ1gzZkZYd0dOcThyT3Vh?=
 =?utf-8?B?ek9WRDdLMjJxNDNpbDdYREdCWmRVeVU5Zk0zK21CNlh6bFNzSk9QTjNZR0VX?=
 =?utf-8?B?clBIVXZEZ0hpcGFPRm1SV0hqUVdidFozVDYrdFJCYzBqZHlFSVplYjVZc1Y5?=
 =?utf-8?B?WGhmV3VKK3c2aW5RRFhFM1RHbGhXdHFPZ2Y3dHNrZzZxYWpXRU1wMFhvMG1h?=
 =?utf-8?B?RTRmZnhlL01yeEJzejJjUCtLaDVJNlNyVWNVZERRUnZ2d0tTZ3o4NzRhRjM1?=
 =?utf-8?B?TUtQSVpjclV2Tmx3MnJXN1RobEMzNkpWa2VIQTdrQ1lYU3E2aUtJVnJsd2hQ?=
 =?utf-8?B?cTM0SmNKS2NwSnN4R2wzcHd3NUdWSjdiWURaQ0QzN0hIdUl2cVZNYmJCN20z?=
 =?utf-8?B?UjMzaXRMWS9KeDVIeVZLUUdaV0ltUXR5d3VpQ1FtanVBTHlDTHFxU0V4QjBD?=
 =?utf-8?B?OUViYjRQc3lQSGx6L2RmSFpMd3pZa0E4YXRHVlhoeVBsSFg5a0tKY01BNGd5?=
 =?utf-8?B?VGRLUGdIZHJBSlBLZ0krdnJORlFwRDhvMWtDWU05WGg3c2lLM2E3eC9tMlN4?=
 =?utf-8?B?N21RZkNoZWdYSFBOZ1N5aVNnVmhFdzRDanVFRWhIeXVmdDF5ajVZVEs5dk5r?=
 =?utf-8?B?WFdsbHlTNjBWdXRTUlEwZ1MzV016VUxudXZYV1NKczRCa0RERWUvUGQrU2Ru?=
 =?utf-8?B?bldGOFc4RTBpMzBrZm9BV2VkQmEwM2kyVEpuTW40MW5PNzlXKzQrNFFJUFlR?=
 =?utf-8?B?bks0cVh6aFZyM3kxakFLYVFRS285SHhYcytKUGFTZUIvU3NSamx4Ny9NLzlx?=
 =?utf-8?B?ZkZwZXhXZVNGRlVPU0RFOEdjNFY3VVB1OVJXdjUzaUtPNk14K0xaODlPZHVk?=
 =?utf-8?B?bEdqbUgyN2tlekZXYk4rYlhRdGVlVXlnZi9NT05rUS84VXVITjZvQVpmbGNl?=
 =?utf-8?B?cWFXdDRsRzhZY3F3TTNBeU8wWmE4UHRjSnhpRFpWRWZJeXVwQWRWRm51VDFF?=
 =?utf-8?B?M3BjWDNhY0ozTHhvVXlHV1g5QXJleVVTZnUvS0wwdDRUK0ZONHNyamJpTUxm?=
 =?utf-8?B?ZGFUa1NqR2w4RDBOU2YrUnpRWFMyVkQyK0dCaEV3YUZiUHRyeHphWTE1Ly9U?=
 =?utf-8?B?N2hndXQ4UHMzUEIwVGtHMFVPbWc1UnJETXVmYUlWSll1SlJLb2ZPSzEraERs?=
 =?utf-8?B?bzhjL3RDbk9GalhKUVdod0ZWbUlnNFovNERRM2U2UTVJVkcvbklCbnV5ZmFh?=
 =?utf-8?B?M1FHT09JczhsVTRLRitWQzUwc1FYK21XSVBVRmRDUjZGWnFBdENTR2RzclJh?=
 =?utf-8?B?TU00bU8xaU1GZWtlZ3RDQThaUnFQdjE3TEYyYkhoS0xaZk1kQmpRWVZaL1Va?=
 =?utf-8?B?VHorVHJIZ1hzZlZhLzFzbFJ6RE1JY2hTY3dmcU8xbmF6NDh0bWRkMlJza1hZ?=
 =?utf-8?B?U2g1NEtDWDNGeWpudzVoT2kvMkJ0ZzFMWnJ3SFc5eEFnUS82SW1wZy9lTlBZ?=
 =?utf-8?Q?OKHxWBEChdoYYtDJwlDYK6yfi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8369.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15eea8f7-4ea0-49b4-1e3c-08dd8f0cda40
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 15:19:12.0269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oZuAAcOm1F8SWZKa5vGhSJ4obHaxlkRZfasIMMSgkqRlKJKENi6i2XYUCcV1cdJWvslCbUkgYwVFqR/ksfX9Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7486

Ci0tLS0tLS0tLS0gRm9yd2FyZGVkIG1lc3NhZ2UgLS0tLS0tLS0tCkZyb206IFpodSBXZWnCoDx6
aHV3ZWlAc2FuZ2Zvci5jb20uY24+CkRhdGU6IFRodSwgTWF5IDgsIDIwMjUgYXQgNzo1N+KAr0FN
ClN1YmplY3Q6IFtQQVRDSF0gc2NzaTogc21hcnRwcWk6IEZpeCB0aGUgcmFjZSBjb25kaXRpb24g
YmV0d2VlbiBwcWlfdG1mX3dvcmtlciBhbmQgcHFpX3NkZXZfZGVzdHJveQpUbzogPGRvbi5icmFj
ZUBtaWNyb2NoaXAuY29tPiwgPGtldmluLmJhcm5ldHRAbWljcm9jaGlwLmNvbT4KQ2M6IDxkaW5n
aHVpQHNhbmdmb3IuY29tLmNuPiwgPHplbmd6aGljb25nQHNhbmdmb3IuY29tLmNuPiwgPEphbWVz
LkJvdHRvbWxleUBoYW5zZW5wYXJ0bmVyc2hpcC5jb20+LCA8bWFydGluLnBldGVyc2VuQG9yYWNs
ZS5jb20+LCA8c3RvcmFnZWRldkBtaWNyb2NoaXAuY29tPiwgPGxpbnV4LXNjc2lAdmdlci5rZXJu
ZWwub3JnPiwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+LCA8c3RhYmxlQHZnZXIua2Vy
bmVsLm9yZz4sIFpodSBXZWkgPHpodXdlaUBzYW5nZm9yLmNvbS5jbj4KCgpUaGVyZSBpcyBhIHJh
Y2UgY29uZGl0aW9uIGJldHdlZW4gcHFpX3NkZXZfZGVzdHJveSBhbmQgcHFpX3RtZl93b3JrZXIu
CkFmdGVyIHBxaV9mcmVlX2RldmljZSBpcyByZWxlYXNlZCwgcHFpX3RtZl93b3JrZXIgd2lsbCBz
dGlsbCB1c2UgZGV2aWNlLgoKRG9uOiBUaGFuay15b3UgZm9yIHlvdXIgcGF0Y2gsIGhvd2V2ZXIg
d2UgcmVjZW50bHkgYXBwbGllZCBhIHNpbWlsYXIgcGF0Y2ggdG8gb3VyIGludGVybmFsIHJlcG8u
CkRvbjogQnV0IG1vcmUgY2hlY2tpbmcgaXMgZG9uZSBmb3IgcmVtb3ZlZCBkZXZpY2VzLgpEb246
IFdoZW4gdGhpcyBwYXRjaCBoYXMgYmVlbiB0ZXN0ZWQgaW50ZXJuYWxseSwgd2Ugd2lsbCBwb3N0
IGl0IHVwIGZvciByZXZpZXcuCkRvbjogSSB3aWxsIGFkZCBhIFJlcG9ydGVkLUJ5IHRhZyB3aXRo
IHlvdXIgbmFtZS4KRG9uOiBTbyBOYWsuCgoKCmthc2FuIHJlcG9ydDoKWyAxOTMzLjc2NTgxMF0g
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09ClsgMTkzMy43NzE4NjJdIHNjc2kgMTU6MDoyMDowOiBEaXJlY3QtQWNjZXNzwqAg
wqAgwqBBVEHCoCDCoCDCoCBXREPCoCBXVUg3MjIyMjJBTCBXVFMyIFBROiAwIEFOU0k6IDYKWyAx
OTMzLjc3OTE5MF0gQlVHOiBLQVNBTjogdXNlLWFmdGVyLWZyZWUgaW4gcHFpX2RldmljZV93YWl0
X2Zvcl9wZW5kaW5nX2lvKzB4OWUvMHg2MDAgW3NtYXJ0cHFpXQpbIDE5MzMuNzc5MTk0XSBSZWFk
IG9mIHNpemUgNCBhdCBhZGRyIGZmZmY4ODk1NGM0OTA0ODAgYnkgdGFzayBrd29ya2VyLzI6Mi81
MTgxODYKWyAxOTMzLjc3OTIwMV0gQ1BVOiAyIFBJRDogNTE4MTg2IENvbW06IGt3b3JrZXIvMjoy
IEtkdW1wOiBsb2FkZWQgVGFpbnRlZDogR8KgIMKgIMKgVcKgIMKgIMKgT0UKwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgNC4xOS45MC04OS4xNi52MjQwMS5vc2Muc2ZjLjYuMTEu
MS4wMTA4Lmt5MTAueDg2XzY0K2RlYnVnICMxClsgMTkzMy43NzkyMDNdIFNvdXJjZSBWZXJzaW9u
OiB2Ni4xMS4xLjAxMDgrMH42NTMyMzIwMS4yMDI1MDMyOApbIDE5MzMuNzc5MjA1XSBIYXJkd2Fy
ZSBuYW1lOiBTQU5HRk9SIFMyMTIyLVMxMkwvQVNFUlZFUi1QLTIwMDAsIEJJT1MgVFlSLjIuMDAu
MDEwMCAwNS8xOC8yMDE5ClsgMTkzMy43NzkyMTNdIFdvcmtxdWV1ZTogZXZlbnRzIHBxaV90bWZf
d29ya2VyIFtzbWFydHBxaV0KWyAxOTMzLjc3OTIxNl0gQ2FsbCBUcmFjZToKWyAxOTMzLjc3OTIy
NV3CoCBkdW1wX3N0YWNrKzB4OGIvMHhiOQpbIDE5MzMuNzc5MjM5XcKgIHByaW50X2FkZHJlc3Nf
ZGVzY3JpcHRpb24rMHg2NS8weDJiMApbIDE5MzMuNzc5MjQ5XcKgIGthc2FuX3JlcG9ydCsweDE0
Yi8weDI5MApbIDE5MzMuNzc5MjU1XcKgIHBxaV9kZXZpY2Vfd2FpdF9mb3JfcGVuZGluZ19pbysw
eDllLzB4NjAwIFtzbWFydHBxaV0KWyAxOTMzLjc3OTI2NF3CoCBwcWlfZGV2aWNlX3Jlc2V0X2hh
bmRsZXIrMHgxNzRmLzB4MWYzMCBbc21hcnRwcWldClsgMTkzMy43NzkyODRdwqAgcHJvY2Vzc19v
bmVfd29yaysweDY1Zi8weDEyZDAKWyAxOTMzLjgwNjMwNl3CoCB3b3JrZXJfdGhyZWFkKzB4ODcv
MHhiNTAKWyAxOTMzLjgwNjMxNV3CoCBrdGhyZWFkKzB4MmU5LzB4M2EwClsgMTkzMy44MDYzMjNd
wqAgcmV0X2Zyb21fZm9yaysweDFmLzB4NDAKWyAxOTMzLjg0Mzk5NF0gQWxsb2NhdGVkIGJ5IHRh
c2sgNTc5MDk0OgpbIDE5MzMuODc1MzYxXcKgIHNhdmVfc3RhY2srMHgxOS8weDgwClsgMTkzMy44
OTIzNjZdwqAga2FzYW5fa21hbGxvYysweGEwLzB4ZDAKWyAxOTMzLjg5MjM3M13CoCBrbWVtX2Nh
Y2hlX2FsbG9jKzB4YmIvMHgxYzAKWyAxOTMzLjg5MjM3OF3CoCBnZXRuYW1lX2ZsYWdzKzB4YmEv
MHg1MDAKWyAxOTMzLjg5MjM4NF3CoCB1c2VyX3BhdGhfYXRfZW1wdHkrMHgxZC8weDQwClsgMTkz
My44OTIzODldwqAgdmZzX3N0YXR4KzB4YjkvMHgxNDAKWyAxOTMzLjg5MjM5N13CoCBfX2RvX3N5
c19uZXdzdGF0KzB4NzcvMHhkMApbIDE5MzMuOTEzMTc5XcKgIGRvX3N5c2NhbGxfNjQrMHhhNC8w
eDQzMApbIDE5MzMuOTEzMTg3XcKgIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDVj
LzB4YzEKWyAxOTMzLjkzMzM4MV0gRnJlZWQgYnkgdGFzayA1NzkwOTQ6ClsgMTkzMy45MzMzODld
wqAgc2F2ZV9zdGFjaysweDE5LzB4ODAKWyAxOTMzLjkzMzM5Ml3CoCBfX2thc2FuX3NsYWJfZnJl
ZSsweDEzMC8weDE4MApbIDE5MzMuOTMzMzk2XcKgIGttZW1fY2FjaGVfZnJlZSsweDc4LzB4MWUw
ClsgMTkzMy45MzM0MDFdwqAgZmlsZW5hbWVfbG9va3VwKzB4MjE2LzB4NDAwClsgMTkzMy45MzM0
MDVdwqAgdmZzX3N0YXR4KzB4YjkvMHgxNDAKWyAxOTMzLjkzMzQwN13CoCBfX2RvX3N5c19uZXdz
dGF0KzB4NzcvMHhkMApbIDE5MzMuOTMzNDE3XcKgIGRvX3N5c2NhbGxfNjQrMHhhNC8weDQzMApb
IDE5MzMuOTMzNDMyXcKgIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDVjLzB4YzEK
WyAxOTMzLjk1NjgzN10KWyAxOTMzLjk1Njg0Ml0gVGhlIGJ1Z2d5IGFkZHJlc3MgYmVsb25ncyB0
byB0aGUgb2JqZWN0IGF0IGZmZmY4ODk1NGM0OTAwMDAKwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
d2hpY2ggYmVsb25ncyB0byB0aGUgY2FjaGUgbmFtZXNfY2FjaGUgb2Ygc2l6ZSA0MDk2ClsgMTkz
My45NTY4NDVdIFRoZSBidWdneSBhZGRyZXNzIGlzIGxvY2F0ZWQgMTE1MiBieXRlcyBpbnNpZGUg
b2YKwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgNDA5Ni1ieXRlIHJlZ2lvbiBbZmZmZjg4OTU0YzQ5
MDAwMCwgZmZmZjg4OTU0YzQ5MTAwMCkKWyAxOTMzLjk1Njg1MV0gVGhlIGJ1Z2d5IGFkZHJlc3Mg
YmVsb25ncyB0byB0aGUgcGFnZToKWyAxOTM0LjI5NzM1Ml0gcGFnZTpmZmZmZWEwMDU1MzEyNDAw
IGNvdW50OjEgbWFwY291bnQ6MCBtYXBwaW5nOmZmZmY4ODgxMDA1ODBmMDAKwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgaW5kZXg6MHgwIGNvbXBvdW5kX21hcGNvdW50OiAwClsgMTkzNC4zMDk1NjZd
IGZsYWdzOiAweDU3ZmZmZmMwMDA4MTAwKHNsYWJ8aGVhZCkKWyAxOTM0LjMxNjM3MF0gcmF3OiAw
MDU3ZmZmZmMwMDA4MTAwIDAwMDAwMDAwMDAwMDAwMDAgZGVhZDAwMDAwMDAwMDIwMCBmZmZmODg4
MTAwNTgwZjAwClsgMTkzNC4zMjY1MThdIHJhdzogMDAwMDAwMDAwMDAwMDAwMCAwMDAwMDAwMDAw
MDcwMDA3IDAwMDAwMDAxZmZmZmZmZmYgMDAwMDAwMDAwMDAwMDAwMApbIDE5MzQuMzM4MTkxXSBw
YWdlIGR1bXBlZCBiZWNhdXNlOiBrYXNhbjogYmFkIGFjY2VzcyBkZXRlY3RlZApbIDE5MzQuMzQ2
MTc3XQpbIDE5MzQuMzUwMDMxXSBNZW1vcnkgc3RhdGUgYXJvdW5kIHRoZSBidWdneSBhZGRyZXNz
OgpbIDE5MzQuMzU3MjIwXcKgIGZmZmY4ODk1NGM0OTAzODA6IGZiIGZiIGZiIGZiIGZiIGZiIGZi
IGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiClsgMTkzNC4zNjY4NTRdwqAgZmZmZjg4OTU0YzQ5
MDQwMDogZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIKWyAx
OTM0LjM3NjQ3NF0gPmZmZmY4ODk1NGM0OTA0ODA6IGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZi
IGZiIGZiIGZiIGZiIGZiIGZiIGZiClsgMTkzNC4zODYwOTRdwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgXgpbIDE5MzQuMzkxNjg0XcKgIGZmZmY4ODk1NGM0OTA1MDA6IGZiIGZiIGZiIGZi
IGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiClsgMTkzNC40MDI2MDFdwqAgZmZm
Zjg4OTU0YzQ5MDU4MDogZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIg
ZmIgZmIKWyAxOTM0LjQxMjIyOF0gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CgpCZWZvcmUgcHFpX3NkZXZfZGVzdHJveSBl
eGVjdXRlcyBwcWlfZnJlZV9kZXZpY2UsIGNhbmNlbCB0aGUgcHFpX3RtZl93b3JrZXIKb2YgdGhl
IGNvcnJlc3BvbmRpbmcgZGV2aWNlLgoKRml4ZXM6IDJkODBmNDA1NGY3ZiAoInNjc2k6IHNtYXJ0
cHFpOiBVcGRhdGUgZGVsZXRpbmcgYSBMVU4gdmlhIHN5c2ZzIikKU2lnbmVkLW9mZi1ieTogWmh1
IFdlaSA8emh1d2VpQHNhbmdmb3IuY29tLmNuPgotLS0KwqBkcml2ZXJzL3Njc2kvc21hcnRwcWkv
c21hcnRwcWlfaW5pdC5jIHwgNCArKysrCsKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9zbWFydHBxaS9zbWFydHBxaV9pbml0LmMgYi9k
cml2ZXJzL3Njc2kvc21hcnRwcWkvc21hcnRwcWlfaW5pdC5jCmluZGV4IDhhMjZlY2E0ZmRjOS4u
MTAyZWQ3NTAxZjA4IDEwMDY0NAotLS0gYS9kcml2ZXJzL3Njc2kvc21hcnRwcWkvc21hcnRwcWlf
aW5pdC5jCisrKyBiL2RyaXZlcnMvc2NzaS9zbWFydHBxaS9zbWFydHBxaV9pbml0LmMKQEAgLTY1
ODEsNiArNjU4MSw4IEBAIHN0YXRpYyB2b2lkIHBxaV9zZGV2X2Rlc3Ryb3koc3RydWN0IHNjc2lf
ZGV2aWNlICpzZGV2KQrCoCDCoCDCoCDCoCBzdHJ1Y3QgcHFpX3Njc2lfZGV2ICpkZXZpY2U7CsKg
IMKgIMKgIMKgIGludCBtdXRleF9hY3F1aXJlZDsKwqAgwqAgwqAgwqAgdW5zaWduZWQgbG9uZyBm
bGFnczsKK8KgIMKgIMKgIMKgdW5zaWduZWQgaW50IGx1bjsKK8KgIMKgIMKgIMKgc3RydWN0IHBx
aV90bWZfd29yayAqdG1mX3dvcms7CgrCoCDCoCDCoCDCoCBjdHJsX2luZm8gPSBzaG9zdF90b19o
YmEoc2Rldi0+aG9zdCk7CgpAQCAtNjYwNyw2ICs2NjA5LDggQEAgc3RhdGljIHZvaWQgcHFpX3Nk
ZXZfZGVzdHJveShzdHJ1Y3Qgc2NzaV9kZXZpY2UgKnNkZXYpCsKgIMKgIMKgIMKgIG11dGV4X3Vu
bG9jaygmY3RybF9pbmZvLT5zY2FuX211dGV4KTsKCsKgIMKgIMKgIMKgIHBxaV9kZXZfaW5mbyhj
dHJsX2luZm8sICJyZW1vdmVkIiwgZGV2aWNlKTsKK8KgIMKgIMKgIMKgZm9yIChsdW4gPSAwLCB0
bWZfd29yayA9IGRldmljZS0+dG1mX3dvcms7IGx1biA8IFBRSV9NQVhfTFVOU19QRVJfREVWSUNF
OyBsdW4rKywgdG1mX3dvcmsrKykKK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FuY2VsX3dvcmtf
c3luYygmdG1mX3dvcmstPndvcmtfc3RydWN0KTsKwqAgwqAgwqAgwqAgcHFpX2ZyZWVfZGV2aWNl
KGRldmljZSk7CsKgfQoKLS0KMi40My4wCgo=

