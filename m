Return-Path: <stable+bounces-235701-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAuRIhsU2mmAyQgAu9opvQ
	(envelope-from <stable+bounces-235701-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 11:27:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5D53DF266
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 11:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5803D301060D
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 09:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60491332629;
	Sat, 11 Apr 2026 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LU5x0Io5"
X-Original-To: stable@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010079.outbound.protection.outlook.com [52.103.72.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D084D28504D;
	Sat, 11 Apr 2026 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775899671; cv=fail; b=ntEiSLettSxVlbmjy26WZgIvCh8hut7VkRzGLvCRnNNjfut61Qhcm9zoIMxiMjPZHP8CawE2xQhYbSf/5zttjEgiLu6sjXUlVsD8q2UC5GdgyE92Ny6TkSboquOgg2RrsDQ7qa4qx6BZBksS3ECDIZm1tQAcIPkUwJZbwC62ZvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775899671; c=relaxed/simple;
	bh=CrlQ4Hd+nNGGCdiBB0MZBfnSfLAVnNBVESEL7Gsx5FU=;
	h=From:Date:Subject:Content-Type:Message-ID:References:In-Reply-To:
	 To:Cc:MIME-Version; b=glLs5/ah4XoSdd7HpFcecHdM2st/cIuzNgI25GLsI5XD4dV8Dv1pIVv0HYADgEbhCLfGba4Z56MMhySClnKQu53KVuAynXY69lYI/3yUjhCjd1JH3qdL1wr5NVa6VOJmh0HABV5znfPGLIRASGRnhkdIwY0/WwKdZK8NNeKUGjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LU5x0Io5; arc=fail smtp.client-ip=52.103.72.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cPa1r2wk/EKJSxfFmsi2WQ5s1fK1bIgM30if7ZlAqKHZz3rpEIvlYQ/WIJBFcufqmmQqoH6HXicqSWQizBbhSPv5EO4FHieXr7t1NHB5qzQ6iPANDrTDIB474I81R5P4z7RnvpQpjE7BTAaGIZ3Anx8KLFImevfF1uPEruqCrza5Vc24PalYC9m8tOgkPl8Mug7mYwO6oBJDIeNPFQUExYv1jVt+a2xdneKyj4PXvSLByudetoPqTl2JX9VG9ka/3sBEgGTxCGtFxrzvQolYTIjnm6RUcJh4Cq8nVDH1IwMzmUyFnUpT0frdVs495qvBLXXGs/SWVOb1wgYqevaCvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qv9plEdqbRQN9fx88cYEzWo/Or8hjF5QnM8SRiRctTw=;
 b=mR1x93wQJpqlIGPmfNAwU2ntxQgnHDJ1vyTIJRu7iO6TVwP1j7TQzFU5/Js/J7/tbCB5aXUh1OE6Iv5lmauJPSkOEGDNBO0f0wZRUYzzn2LYWzAU4H8PDCWDGD2eIPvQIovxdJiVf1bTL1tqzm6ZbdiJLL6po2DzpflZaUY2zfeKdbPIpO/7acC5ALQhmezuR7xKWxl+uXmnwWV1PNC4/zJ1LUI/XfTycxL32MsHk+A5v/taTzgricQOErokE+TJYVhyJvdhf+Kade9ejuZBYW6rrZt/7vbvYTdQWA2DoduVXUWs+llDL0epBUQInMEO/Hgtj8LwcTHQyBX0PKeScg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qv9plEdqbRQN9fx88cYEzWo/Or8hjF5QnM8SRiRctTw=;
 b=LU5x0Io5udOeds/jHtBY6rX5SXjvrQOLrdFnTGc2YLl2+olrm4HvWV/ARzrSwd+iR+gZsZpeiRMupaYW9CYXkFN60krd9WTNCPOOvHHgKz2wGe6lkElDcaZYvYj44fpCo3BnP5LHuIEliPSX8nyEBdL6YEvIWzboqbiNmMgzEVSCnxj8tIfaJCnxYx8y7IuyEsNa8vFteqfbu+prDeCJ/i8BWONXfzFV71oU9RG3GBq0Y7nHb94EbAIgPqolpbl3qrnAiG4xprmR+Ud4z1sBua5rb8mQEmPKUICjy3yK97n2yPRTg3bHmb6WTmRZS/uVzbLUS6aN06j3qPF3QcYPmw==
Received: from MEYPR01MB7886.ausprd01.prod.outlook.com (2603:10c6:220:17e::8)
 by SY7PR01MB10897.ausprd01.prod.outlook.com (2603:10c6:10:336::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Sat, 11 Apr
 2026 09:27:45 +0000
Received: from MEYPR01MB7886.ausprd01.prod.outlook.com
 ([fe80::19df:3891:d8aa:692d]) by MEYPR01MB7886.ausprd01.prod.outlook.com
 ([fe80::19df:3891:d8aa:692d%3]) with mapi id 15.20.9769.043; Sat, 11 Apr 2026
 09:27:44 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Sat, 11 Apr 2026 17:24:49 +0800
Subject: [PATCH 1/2] drm/amdgpu: fix use-after-free in
 amdgpu_userq_create() error paths
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <MEYPR01MB7886487D102D9FED36FFF878AF262@MEYPR01MB7886.ausprd01.prod.outlook.com>
References: <20260411-fixes-v1-0-5f31973443e5@outlook.com>
In-Reply-To: <20260411-fixes-v1-0-5f31973443e5@outlook.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1838;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=CrlQ4Hd+nNGGCdiBB0MZBfnSfLAVnNBVESEL7Gsx5FU=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGzFvCCRX1Lp8ud/jsaVhnsUtW5w87W1mjs9C9omOPP
 r+/u3XmM5mOUhYGMS4GWTFFluMFl75Z+G7R3eKzJRlmDisTyBAGLk4BmEh6NiPDV0cNXylPi53d
 R/aFfo76MenSsmf/dh2dan9ZJ+SA9DTdyQz/y6aEJFqX752pfTXWSKrj3qPpTfN56lz1Qqv36J0
 /zl/MDwB8rEz+
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: PH5P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::9) To MEYPR01MB7886.ausprd01.prod.outlook.com
 (2603:10c6:220:17e::8)
X-Microsoft-Original-Message-ID:
 <20260411-fixes-v1-1-5f31973443e5@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYPR01MB7886:EE_|SY7PR01MB10897:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a40701c-69ae-41ce-a2d3-08de97ac9673
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|51005399006|23021999003|19110799012|461199028|22091999003|24121999003|6090799003|5072599009|15080799012|40105399003|440099028|3412199025|26121999003|11031999003|12091999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTJ4Q0VZUFZZZGo5OVNTUVYrQzh3cVozdU4ybjZQRHFnMmIyZkJITDhObmxv?=
 =?utf-8?B?aFVoRDYvVjlZTTI5QU5LL0wrdXJkU0NlUWZ0bkpTaGJKWmdDeTNLYkFmYXht?=
 =?utf-8?B?SVlQN0dKNDhnc0hVK0g3N0huSnJ0SjJhRHdEQi9TVzVwTmxuVGxrcmNtSU9p?=
 =?utf-8?B?akgyUmgxQzdyQVNTSGJFbWhVMFhsbERTTS9TZkZwMS9nWkppbFhvK0FtcjlC?=
 =?utf-8?B?SFMwbUlSY3RPbzZWelZqeFdSbjZ0dGhWQWlEVkIyRzJMMldzWEpNUWU3cVFY?=
 =?utf-8?B?QlJWcGtRSmZYUEM1WXYvTURaMnlWQmhaY0FLNFQ1a29GOEpJZGpCcW81R2NG?=
 =?utf-8?B?QndvODBPODBhSWg2RFpnUVVBRU5PZWxUdmc0V2FMVUhsVW9SL0d4cWI2SWtu?=
 =?utf-8?B?NHA4cUNhODVPVHNacG93YnRLSWZuT2VHenZsQWlDblovK1RTdEo2MUVoWTFS?=
 =?utf-8?B?dWRxL1lwUEV0NlNRZXUyNkNVblN3Z3QvMWJCdnR0VXdVNEtORUROS2FXblV5?=
 =?utf-8?B?czlBS0Fwb1BJdDUzemhDbXBPTkROTWlySTBtZGQ4akU0eGYxQnE4NWtxcWtS?=
 =?utf-8?B?T3Z1RlI2aGJnNEVyUC9qSTZ6VzUvdi9nQ09aVzYvVEkwbXlDejhhT2pxc0VV?=
 =?utf-8?B?WG81ckFORWZOMHEzL2pvWkpWU0Z6TkZHWFdjYmNRZlNFaUJ6dmtERTVGVkJR?=
 =?utf-8?B?b0VFWm5pM1lVOUJvbXpqakdTdTFueG5qNWpRM2FOV3dOemRiTlUxVHBFQmRJ?=
 =?utf-8?B?QnlWRG4wQmxyeklxUmlHSDdZUEVyRGtNbGdNdkpJSVpSeTB3REluSTJINlFI?=
 =?utf-8?B?eS9MODJlUzdzaXJlZDlYeXpZbEdsMlRGbXB0VEMrWkdTT2J3MlFYQ3dFWXRU?=
 =?utf-8?B?SlJSZ2RUSGQvc0pjcmRDekxFaGhBSDM5TlUxZUZNN3Ewb0xNOGtuU3M3VTBE?=
 =?utf-8?B?ZlZiSnBkNHpEcjFybmVkWmRudjZlMGRWSnkvdk13VVN6UitzTSticTEzZGgv?=
 =?utf-8?B?Y3RKbmFtYVRPV2RxbTZQQjhIcWZDdlVyNFJoRXYvVng0U2JHdHRpT2VFYlRh?=
 =?utf-8?B?dWdEb3JvYU9xMk9GdmZIK0t5MW5PZGN3ZjlaMWRmUHYxMnF1MzNzaHN3S01l?=
 =?utf-8?B?Z2tueGdlQWRXTjBUMU5BQ2Nkei9qdnIrcU8yNkV1UG44cEk0RGVROUo1Uk1V?=
 =?utf-8?B?RFovK0NPYVRpYWhYVGNtWHhtKzY2OWdIcGxIb0M4YjEvTmdwckVBdHp0ZnFy?=
 =?utf-8?B?SlBKT0cxNFo5L3kvVDhWM3NrV21wWm5SaUh4dUJBbWNlbnRTVWRHU0xhRHBj?=
 =?utf-8?B?Q1F4MU4rRStKbDFyQndacWpoTURlMUFtZU1xR3llVS8ySjJPYW10MUordkFJ?=
 =?utf-8?B?ME1NSCt5L0c3cnpkQ2Jya0tCMUpXQ2RDS3lqNXFlcXFkelFhNXgrdXBTajds?=
 =?utf-8?B?dm52QkFPbFBHaEFzZCsvTG5FSG1wNm5RQ3FhWmV4MEs1MFc0SVJtaGVNOTNP?=
 =?utf-8?Q?FE1MAfw166+eVuINxm78+5MBnZK?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1E5aDVUUmdoQjIvM0xkM3NBV0hSMWxDV3JNUjFFMTRUU1RRd1l3VEFsQ2V3?=
 =?utf-8?B?b3FzVHd4RGI0R0t6ZFNoWnVnYmZBN29sUHBtNnFjbFgxK1lXNWw4K1NtYXZq?=
 =?utf-8?B?emlUMTdaVHZXMWFrMkRwMTBialF3dHFVMWRzbjV5cll0c0RrWVZlQVE0dUts?=
 =?utf-8?B?dVpRN0xkRUMxTUtWeDkrMExNRW1VeStKdGdJVnJTUVdCM3Q5TXFuaVp2QXFN?=
 =?utf-8?B?ZUE4UC9GNzRqZ3FHcTN0WHBwdUlpUE9pUTY4UkcwZU52UDFQVUtuMXBMK3Fq?=
 =?utf-8?B?aUVLS0VsUytTV0hiZ3NDYU9kRnM0TFhTdG5ya3ExSnpoUXY1VmhaRmZnR2tX?=
 =?utf-8?B?NFNwM3JRYzZXbmFBK3VaYkplT0hwL2hKazdtbHBld3Vka3Z6RXR4R1RWTU4w?=
 =?utf-8?B?MXc1TmNyUEk2d2YrdDIzeWxFYUpqNmw2OThoZFJQVUJoZmwvdFdpSkswUlp4?=
 =?utf-8?B?YVpHZFVXUWJXNXEyTHRGRDhRcWJtSngxdW9aZ1lEeWl2bEdiNWkyMWlyOTZI?=
 =?utf-8?B?b0EzNk5nNEl0NUlQQ2pROW05bUpTK3J3NmxJaUd0V3VGVUtaT3lTSnNFQmxM?=
 =?utf-8?B?OFJYbVp0YlFUTjBzcEVzODB1SU1sT3dhRDd6T1hocys5ekxqMHZYa2MzLzFv?=
 =?utf-8?B?UTdPZ1FjeGg5ekhJRnFIZ3Q3b2Jta0tuZ3RtWXNxNWRIL0ZydGdtU21BVDJG?=
 =?utf-8?B?cTlyOUdlcHF0Ykl4L3BhMTJHVFcwN1A1TTM1b1hMZDNadFczQ28xOUpjZkpW?=
 =?utf-8?B?S0pzZzU5R1BQOFNNWUQvK0dFVmhQOVZsVWJaSldxS09JdE5xdExRd2VHemwv?=
 =?utf-8?B?czRLU3lNdk9RcDllTnYvajJXdE1iNldzd2gxSmZOc0JPRFZWWWxhTWRsUC96?=
 =?utf-8?B?cU9YcHZ6L2laQ3pYZDgrc0VzTjVOY21PMkVnamVNVjJkMEtlTGlFME45NE10?=
 =?utf-8?B?Q25qdzA1dDlqaTF1am40SU1qUjRxaGM3eTUvcFBmOFNsbWxlZi9rOFVkWS94?=
 =?utf-8?B?MWtCd1Z6b1RzRHdPNzg4b2Z0MWVUbjdwWnVyT2lDZTJTT0tySHdzYUlPSE16?=
 =?utf-8?B?ZVp5c3NRaWpraVIwZVF3UHBEY2x5OUdLeDd5SmxPVUhVbVVObEFHZFJWTHZ4?=
 =?utf-8?B?SXAxQTJDK0QyMk9RN3ByVkE2RU9MM2dHczNmK0FseWVEcW1BY1g5SUNrQ0Q3?=
 =?utf-8?B?NmxIUVlIa2w4TFFkZm5HdDZaZEh6U2llSFFod0VUQXlsY09SQVY0ODQ5c3Yv?=
 =?utf-8?B?SjVscXN0QnN1TGE2YncxeTdxZndKcTgzZ2NTQzAwY3RnalhPVmxnZ0hJZFpr?=
 =?utf-8?B?NS9NZFFXM2Jyd1dqWkNKUnRMcDlqY0ova0U2MzdSRU9wckxYLytVZHI5NnFF?=
 =?utf-8?B?ZTB4QXg4Z0hjR2o5dlA2dE0rbW9pRU05N3NzR05JSng5TjR2MzQ4RitTZ09I?=
 =?utf-8?B?SkxJTmU0OUNYdGZKUEJKbU5jaENYU2NWUkw0TDdRbmlTMit3Y1phbUxhT2xD?=
 =?utf-8?B?SVhHMFdjS0V3ekdrVUZBSmc3UWRYN2J2MVppT0lsck4reDBYcU5kYWRSOHVJ?=
 =?utf-8?B?WHhFY3daUGQxajFvZ05GYjAzY2JJamdOa3pVVDJCclZoc243dmxTc3F6eitT?=
 =?utf-8?B?Sm9OMW9IbStKK3FNNHFRMFBwNCtsRFlOYm90ZWM2U2I1ZjRDSStSYXhuL0ph?=
 =?utf-8?B?RzFwRzJBc0RvRjY5YXZQZGhhbHVxT2FjaGhuMEE2QzhjMXlncjJ0MjJJUzJJ?=
 =?utf-8?B?K1V1UGhCbzFDZy84dTU5MUYwMGh3dHhQdjQvRExHMVp5SW1KbE1RTWFIVEF1?=
 =?utf-8?B?S1pqU3hMRHFjMGFrSW1lUzY4UHZ6bk9ONjA2TDd5cm8rcFJaM0Y0clFuTHBN?=
 =?utf-8?Q?16jYNrHzg8EaV?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a40701c-69ae-41ce-a2d3-08de97ac9673
X-MS-Exchange-CrossTenant-AuthSource: MEYPR01MB7886.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2026 09:27:44.9568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7PR01MB10897
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235701-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[amd.com,gmail.com,ffwll.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,outlook.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,MEYPR01MB7886.ausprd01.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 1C5D53DF266
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When xa_alloc() for the per-process userq_xa fails in
amdgpu_userq_create(), the queue is freed with kfree() but not removed
from the global userq_doorbell_xa. This leaves a dangling pointer that
gets dereferenced when the kernel iterates userq_doorbell_xa during
suspend, resume, or GPU reset via xa_for_each().

The same missing cleanup exists in the amdgpu_userq_map_helper() failure
path.

Fix both error paths by adding xa_erase_irq() to remove the queue from
userq_doorbell_xa before freeing it.

Fixes: f18719ef4bb7 ("drm/amdgpu: Convert amdgpu userqueue management from IDR to XArray")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 7c450350847d..60e1f7541a64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -864,6 +864,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
+		xa_erase_irq(&adev->userq_doorbell_xa, index);
 		amdgpu_userq_fence_driver_free(queue);
 		uq_funcs->mqd_destroy(queue);
 		kfree(queue);
@@ -884,6 +885,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		r = amdgpu_userq_map_helper(queue);
 		if (r) {
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
+			xa_erase_irq(&adev->userq_doorbell_xa, index);
 			xa_erase(&uq_mgr->userq_xa, qid);
 			amdgpu_userq_fence_driver_free(queue);
 			uq_funcs->mqd_destroy(queue);

-- 
2.51.2


