Return-Path: <stable+bounces-235699-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCPVFskT2mmAyQgAu9opvQ
	(envelope-from <stable+bounces-235699-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 11:26:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA813DF241
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 11:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 268A5300E19F
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 09:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA34E2E093A;
	Sat, 11 Apr 2026 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZGprVlp6"
X-Original-To: stable@vger.kernel.org
Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011029.outbound.protection.outlook.com [52.103.72.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323CA27FB3A;
	Sat, 11 Apr 2026 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775899584; cv=fail; b=ksyUh3i9CuMidyhdQxvHA+xEkTtfU3sLGSFD5TteL5rgThgiwuXEiQidGM8JBKWGr5WNfoVxdwG4Ky95Ccpc9bN8nux5/DXrN8gLADFO4DJquiSDhxrjlNOX7/6cZiQNsyQuWTKYx9thdbgT+OumboffvM87qMZkBh9s/qeW8B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775899584; c=relaxed/simple;
	bh=msninte1xfcT/AvkTwrAawtrryA5+kQNMzlRE93Bc48=;
	h=From:Subject:Date:Message-ID:Content-Type:To:Cc:MIME-Version; b=ZVex5n4kNoKDPNo1sLuZJbXUYKhiWRr3QVXINdL2NWZJ8iY7Pf4v5JyCUh3mobOOUG+G0jNKG/E9lbOnBy84E/TK6yM3fZihk1U1NKieELUYdd7j6jMcmK0j4KDsSWARvyQGTgDk4tYYP6pMgu3TNoExYPmq8ib7D5e8Jmjcr3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZGprVlp6; arc=fail smtp.client-ip=52.103.72.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1nrZaBxFTouMnXAoTwliAKesIfmLwB3e/RgMBOEPvhNbJDVMC3Wmu7g3ABg2Yx4/OssII42KwB7+kqoBWh6EegJaxlHRLVTFnaBJFGPM98wXHiMvSL3XMlhguAX0SkCXnGakW7wMpbS0pteeis+eDvdLZgZBXPUDwWiRbpfzEQZqqDs6+bz4vr0KPf/2tuHLxJAq4h1R+/8vOpvp9KHkGtJkaRfJLitzjcm387FiXqJGzhIyWRtEy0iUoc8dN1opAvkKYcQc15l+Gs1LNYN35ggaD6W8MfcV4eydhkUVhU15IA8IkupYMLPfqs0z8JEdE4sjdg/Jzkekhf++EEuSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTkR1IEdS/JJpU20DOhD0gJHQ0BBxJ5rT3ql5CrFvEU=;
 b=xAHUuFpB3vmWh/y63FidCl4Q1joo8U5zpaqKIHoeqjFsxRChq541XJf5nk8h3qDoFyNfVzgRbqvnuJE1hYvDgZHbbYwvYx4PL7bVoG5DL2jN4AW4ZRF68Xpn8o4TxlA+Ytrja7GjZS0pzjZulC6o57UrO2S24jsOtFLXxKk/JxOnt/rBpujP3YR5JrDh9yh4vj8dPNZKuH/0mxcNZ6A1A6oh33bqHrG51m2ZM1D0QKq8wPSelvw4bANwPgJY+hBPOaXMpi/OwVWP0ruSUu96dX1tdOXn6QHUeOcLfkqSDidJgUgALWCEG3ocm7Crt1tAtCnHa8VlbFE0G3RDahKTXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTkR1IEdS/JJpU20DOhD0gJHQ0BBxJ5rT3ql5CrFvEU=;
 b=ZGprVlp6BBKXybcwRUc/x9IK6bi0U//qHtCGzh7fcWu4cLZyuckfPesXillZzZMMej1UogxAHo11RaYqpM2CS/8RGHi5L12i+0eZyPqLtLRWL2ZdLgeoAcoq0Np0rRhdcyv9hPT2NX9NEWgU6mC/XrNE+/627jMthUqvWoN50CEh7TAT2t02o8G0zAOlxhqmDG9mzdvktw6fxUNlA035KgxJbFniqNjGaD3i/8+p/mA/TAH0C6tYV4OrV2zaWgCy+f36vM+HOXWqjwC6j8CEEbwTjiFU9WHXXy6L7wR2++FDEMDntTBdbmrLOF14RimIP9RvXlqQpO0cf++A1llCWA==
Received: from MEYPR01MB7886.ausprd01.prod.outlook.com (2603:10c6:220:17e::8)
 by SYBPR01MB6269.ausprd01.prod.outlook.com (2603:10c6:10:102::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Sat, 11 Apr
 2026 09:26:18 +0000
Received: from MEYPR01MB7886.ausprd01.prod.outlook.com
 ([fe80::19df:3891:d8aa:692d]) by MEYPR01MB7886.ausprd01.prod.outlook.com
 ([fe80::19df:3891:d8aa:692d%3]) with mapi id 15.20.9769.043; Sat, 11 Apr 2026
 09:26:18 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Subject: [PATCH 0/2] drm/amdgpu: fix error handling bugs in
 amdgpu_userq_create()
Date: Sat, 11 Apr 2026 17:24:48 +0800
Message-ID:
 <SYBPR01MB7881A5714C08FAF6A974EDA1AF262@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGAT2mkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0ND3bTMitRiXWMDC0vjNCPzZNPERCWg2oKiVLAEUGl0bG0tAJsdYIh
 XAAAA
X-Change-ID: 20260411-fixes-30893f27c5aa
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1214;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=msninte1xfcT/AvkTwrAawtrryA5+kQNMzlRE93Bc48=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGzFvCCXPunVlVx3JqQdbtPF8/9tLaLxahU2Lk7mzwj
 E6fEmrJ2N9RysIgxsUgK6bIcrzg0jcL3y26W3y2JMPMYWUCGcLAxSkAE3mpx8jQMn3V75ykjRV3
 tN+9P3F+UbHmXEGx8y7HFMTvfYjbtmTSVYb/2U76p14s/zdB4MbjycmTvk2899TX5e2LI/qOWd5
 5cyfFcQMA7VZPFg==
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: SJ0PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::8) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260411-fixes-v1-0-5f31973443e5@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYPR01MB7886:EE_|SYBPR01MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bfabea4-9745-4b55-5bd7-08de97ac60fa
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|15080799012|41001999006|461199028|19110799012|23021999003|5062599005|5072599009|51005399006|24121999003|22091999003|6090799003|440099028|3412199025|12091999003|26121999003|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TCtiRGJRTE45d0ZSUGV0RmVMcVl5aHNBSUNrMXNiN3RmNlhCQ3FtK3Y2UVdu?=
 =?utf-8?B?TmkyMktGNksrMWs0dEdnSlZ6SlZlMnpHd29QbFZ1bEc5bldqVE4rbE5BMWpy?=
 =?utf-8?B?U0RYZ0p1K1BiVDR1bmE3bjR5L0ZBL2RWMXJoeGhGa1h3R0w4WVFiek1CcVhV?=
 =?utf-8?B?WTR1R2pzbEErRHgydWM2ZTczNEdSVXQyMktlZFF4bHcvaEhFd0JLZnpNSHQy?=
 =?utf-8?B?Mlp0M0VhM1dNZ3l5Z0pZOFJMZ0Iyc1dTdGVNaXFJN2h2N21xYTNGMHhlUWUv?=
 =?utf-8?B?c3NjalIrMjBqamxHRFRRUDJKOElvUVh5bm9vT3ZiL0RFY281dXduazNLSjFU?=
 =?utf-8?B?bTlzWXVwVkJPdCtRcXRORllIQjVNSHBUWW02bHhPTngvUTh0b2o4ejRjWUZG?=
 =?utf-8?B?U1RZRGNSMGlKOWpHekdWaVQ2UlhlS2RKWDAxazYvV0U3K3Rmdzc1YXZ2dWQr?=
 =?utf-8?B?RjE5WjNHK1JQRXhrOVh2UWZBdXFINVlHMDdqa240QU9GR3MrK2tWb0Qvc2hK?=
 =?utf-8?B?dWtGMFBreXFZMWJyR3ZBOHI4NHF6Q0ZEUStGR1RRQzVWUVVMR0NPdDJCbFR2?=
 =?utf-8?B?MVI2RnRaTEJzMUxQODU2NFhwcjhGNHFrV2NCei9rcFR5dWJNN212K1gzTG4r?=
 =?utf-8?B?N080WDdJN2UrekJDQUZ5NU9oMWtYYkN0MG9SRlA0cTZaTTJ6Z3dFSXlMWEM3?=
 =?utf-8?B?MDEvU3lvZ0RKUXA0MG80OWtzcS9ybmh4aGpjWjhITVB4bUJPVk1UOXNRdjhZ?=
 =?utf-8?B?ZGhkMVc4L3RyM0FrdU1HZVpuVStKbXhBWnVQSFdwZDkzcVQzVExyNUg4UXY5?=
 =?utf-8?B?Z1FoSnZnelRxcVBCdEJEMW9VZThwL3k2djI4TzRCY1dUbWl0UFYvR3NGM3d0?=
 =?utf-8?B?NW1palBiMm00T0ZieHRBL21kRHBKbllyMXZXQ2lEdjVzVkpMc2pnL0Jvc2Fv?=
 =?utf-8?B?bEIvM0V1NSttNmF5ZUhGSEdjeXBYeVA1SUZ0R3oyWFZSRGRocm9ublRzK0Iy?=
 =?utf-8?B?b05kTEhBbTVIS2tDRytEZWhURmd2TGF2eFo0TCtrZ1REdUdsTEc4bjFuUE9T?=
 =?utf-8?B?dW90c0NhaFh6ZlU2TXVjVjNSY0JPRmo3NUN1TTV4YThpcWFOVXJYNHJ5OVo2?=
 =?utf-8?B?UDdYRU5PbURGd2llb2dEWHJ5SFhleHpPSytWaFl3Wk5FZmNRRHpvaUx5NTFS?=
 =?utf-8?B?ajMrdUpLNm4rblB5WlJBbTNScDBRakJWNTJOL3FIVnZoZm5NWXVDUVA3Mlcz?=
 =?utf-8?B?Y3E2UVRaZG5scU1TYnJDV04rRnJCdU93NDVCZDBxZkh1UmtTUlIxdXdkYnRG?=
 =?utf-8?B?VnNiMml0NGtQWDJYTGQ3MHhkeVdPUlVjdzhHbkN2OEovdXd0NFJ0SENFbkdG?=
 =?utf-8?B?T2psOW1aVXhBQnJNUWNxb2VCRnl0UXh4a1lUcmd1RTVTTTA1Q0w1LytlSDFv?=
 =?utf-8?B?REVwMVVSRzV5Q1Q5YUVYT0d2L2MycHhwbjVISHJQMzMxM1Y0VUdFZTNJSm14?=
 =?utf-8?B?b3ZnKzlLU3dwaUpEUldHZ20rbmVrZ3BMZEpBekhhZXNSNUlhMVJ4VDNKS0pN?=
 =?utf-8?B?UG5jZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVBEa1g1aVVEV0hzMWNnZzJISGpTU21odlZybmdvRXJ2SWN3SkkyZklrdWZE?=
 =?utf-8?B?MXBSMm1LaGNNSkF2RTV1WjluMDBCVjlOSDVTTGU0R2JYUWNZRDFEQm9XMFN2?=
 =?utf-8?B?aDZTdEV0WXROQnNsenQwV3BLNnFGRytIRm44dnIyc0NGVGVzeEU0UjNHR2Ew?=
 =?utf-8?B?cCtwWmVwc0FkMFhjVTZOVGlNVWdlVU9kTnUramM4YlZuRDNzd2hKR2MxZmdV?=
 =?utf-8?B?RDhNVnBpNVV5OEk5QTkrR3ExU2UwZklnVHAxM0dBQWp0Z2NoOFRJNmtoWnZK?=
 =?utf-8?B?NFRvYTBmRThwd3g4cHdwVmFjS25FWkVNMDlEZ3NhY0VpdEFROHdORWFpakNm?=
 =?utf-8?B?Z1ZyNkxuazkzWTl5dGxqK0lxTVRmcGF4TW85S0lQZG1IRExKOFZvLy9UZUh4?=
 =?utf-8?B?c2pJcndRR05JcmdSeStmaThSVHZ3NEluNnR4ZUpBb21DZFJsSTBQR1VobmZ6?=
 =?utf-8?B?RTRCVWlhT3BnVkpHcFpBcnRpZitQeDA1SDhseGVoN0hEVUU0aEVtZDZsYmVX?=
 =?utf-8?B?QWFlV01DQ0gxR0hSOXNaWlZLeUFacWxkczk2V2NyL1F4N0lOc2tMdVNvWFdK?=
 =?utf-8?B?bEdib1hkaHhsNlRGQ0hCako5S1JZQUNCTTB6Q3RBS1VxWmJ2UTkyTHVHUk9z?=
 =?utf-8?B?aDJMd3F2cjVxVG5SOUlScFAxQ0ZmQXJ1VXE0aDRqUEZXd3I2VXY1SUF5Wklu?=
 =?utf-8?B?RHBUby9xV1dEcktNOXBhQzAxaURNNDZLaVMyV2dHcE9sTHd1Vk12T0xKQVBv?=
 =?utf-8?B?RjM5dFdGMm5sc0d4Q2duUVVXYTBGQmtJY0FGc25seC93VnVTL3J4ekhhamt3?=
 =?utf-8?B?UkZDcjhxbzlONXo0aUlTQVpUWlI2RHVJemlvdDVuaTRpS2ZjQy9wc1drMFR2?=
 =?utf-8?B?WjBIREdJdnlZLzZyRVNYVW01bmhBbDlVNDVnczBSai9McWpGeEVPYVlJdU1X?=
 =?utf-8?B?MlYxeWFUKzVISDZ2Y2FMdDNDNysvQ05pZkFQMTY0aVAwdFNFWitXSjhaZ05y?=
 =?utf-8?B?a01BTWpPOHUrRTVGN2ZQR3E0WDJrYTdnVnVXaUlCVGxmVGlyV3Y5MEtOelNn?=
 =?utf-8?B?ak0zUTliZ0F1OEwyMVcxV2x6RHBwYkYvbkg2RkdyTjJFeDRTWjJLc1pHNEFj?=
 =?utf-8?B?TXBRWS9XS3VEQU13N1hmVWl1Z1hTL09XVVZ6bnI4RlVRNVlSTVRDTzB0QTJN?=
 =?utf-8?B?MVd5cElucTR5bjFpL2JsSzgyWlZlSVd6a1dGUmlLZEpLa3RpYnpWQVZRR3N2?=
 =?utf-8?B?Y2txQ3FJTGtZU2ZydjlwbFJNVHc4NldKRmNMYWFZRUg3YytBSnZaU01kNEdn?=
 =?utf-8?B?bHNYUWo3QUpEV2tCeE5HWHVnbUlGN0UxRDcvY3lnT2tSVVd2enpTTDlGdFRl?=
 =?utf-8?B?SVVESzFDdEVucjAvWUMvVXlLcURScTZDS3hJdVFJbUpLeGlWdldNUmJYeFNF?=
 =?utf-8?B?SGh3bS82WTBmUEhGZFlkZjZ2VkhTeDY2YW5VU2NONHNxYzF5Y0V0aGlEUXN0?=
 =?utf-8?B?QzBBYjdwRHBVRkUzZkVTZk1OQ2RJVHRGUXBVNGxINUdwRHE2eERHaUloa3ds?=
 =?utf-8?B?Y1NZUmZ2RERaR0ZMSlEwUXJmS3p0aXRnN3RWVzZzWG8vNFhJS0ZhWEtwc2Vr?=
 =?utf-8?B?eW1ETG9nTkprcXEwLzcwNEJZcDJNbzhTNWdHNTdmbVdnRytIZCtGbnl6RlZa?=
 =?utf-8?B?SmpOcGdYak13ODc4RWYvdWdROXVVZE5rQjhGRnZ1RDdkaVVMamtjcWZtZkFD?=
 =?utf-8?B?RWNKYWE0OGNWYkgxVVNSVUxpeFdtc1Y5NEhaVnp6TXJOOWw1RVJkSm52OUVm?=
 =?utf-8?B?R0dGckE0Umo0NitEMDBoTG5YTm4za1RHdFc4eXBWVCtwK3FZVUMwbjhaMFRM?=
 =?utf-8?Q?P6lQlmSq0/Pqo?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfabea4-9745-4b55-5bd7-08de97ac60fa
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2026 09:26:18.0778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB6269
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235699-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SYBPR01MB7881.ausprd01.prod.outlook.com:mid,outlook.com:dkim,outlook.com:email]
X-Rspamd-Queue-Id: 4CA813DF241
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit f18719ef4bb7 ("drm/amdgpu: Convert amdgpu userqueue management
from IDR to XArray") introduced a global XArray userq_doorbell_xa for
device-wide queue tracking, but the error paths in amdgpu_userq_create()
were not fully updated to clean up entries from it.

- Patch 1 fixes a use-after-free: when xa_alloc() or
amdgpu_userq_map_helper() fails, the queue is freed but its pointer
remains in userq_doorbell_xa. Any subsequent xa_for_each() iteration
(suspend, resume, GPU reset) dereferences the freed pointer.

- Patch 2 fixes a resource leak: when xa_store_irq() fails, the error
path calls kfree() without first releasing resources from the preceding
successful mqd_create() and fence_driver_alloc().

Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Junrui Luo (2):
      drm/amdgpu: fix use-after-free in amdgpu_userq_create() error paths
      drm/amdgpu: fix resource leak in amdgpu_userq_create() xa_store_irq error path

 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++++
 1 file changed, 4 insertions(+)
---
base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
change-id: 20260411-fixes-30893f27c5aa

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


