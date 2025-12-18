Return-Path: <stable+bounces-202940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD879CCAC07
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 08:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 108123011765
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 07:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCED2E336F;
	Thu, 18 Dec 2025 07:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="L1UG4y3w"
X-Original-To: stable@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010014.outbound.protection.outlook.com [52.103.73.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B40C2E6CC5;
	Thu, 18 Dec 2025 07:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766044637; cv=fail; b=EqQScIKXcr/Cqg6LyAvhVBHolraLV0TTF0hUJs/AmJgoKFxE+slAiVQXiUBuqEmRPAitDHI0HknU3UkEfYSr/1WjCU7j+nm+zXYw9PPwSmq7xVKOOTSGFu4W9bP6nQ1l0K1/UIR9gXhLfrQp1vVtZ4ElavsZCU03xYzEelsxiJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766044637; c=relaxed/simple;
	bh=EjoXFMxGMQBZOSkwjr2WUKecczdBqSM5qyzJa0B0i9k=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=m6V2yb4mb3J7JtbGOUOf8KGjIn6GBjxLOmI5+yqh5d5ESR7bb/cSEEMWh3hKMD3iS1GWqlqPAWKbr7XiTgA+wbf4gPO+UziYhXCOFP1JFf+4gM0LcPLhg071VloLLyuP4+x4boSXoJqD26laCHYmieQwptZjzYszVFrUXHsYfII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=L1UG4y3w; arc=fail smtp.client-ip=52.103.73.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eo/d+NrHAQj3Ar6JzfFAXZsR+zGGMvqYQJk+fm2C4XSTsx78LvFdqVg1k8ycHFp7bYBN3PB1YGni/UmLvsbp7S4f5nPtLxVNuliWJIv0ZW8zZ5n6mZ43uLphLdI/DE7mBBzNWmzv1HK6hwZ3NCmj5diAXMj2h5hk48NzSxjLwREaqgOSkor0mw4kL22gvNiFxNf2gTcx1E7pjH8OL++6vFckDKGToOS2GWWHgHqJ1OaubBv+N4DAgcPQTFwpc43kqTG4JmAkc/wAmBFTiJDhw/ReOnERHekRh/n0yLB7rJn5eRCZZXEvt2YQ+6e+Y7TJ1DnCj/EXP4mW0eVU9J/bvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmqQRxQ+j61kFlLg2F5qL5XjS3iuh9zMf+3voxeZJvY=;
 b=nIz58FEIMcCYs0NlM5Tph0dpLfei4xHGcDKws0oYbCfSX+HSfvhkoVmDRe9Ah6sqA3vjjfun/R2PGqKvngAKJvsLdTxNpA3d8kAvSUelbzNsA6BvK6Mb7+nkQuxqvCIsSBca4SR2BvEjbVlGR1VIUGtogtHGCTEangA9Qxb5fyw6v7fWmW1rSwHoDEg50qECc1nxGsTxJX5NDfq5URqam3aEo+idlqznmSeONhwo9po1LCaSkS7IVrOa188wlUqwWIfXWUXXw45heoFRL0KTNJX9R+9TZZWAC1FtBpIaijoGM6yIORmXIPCrKHMIhwWQxRdp+JFpYT8y1xv7REzd4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmqQRxQ+j61kFlLg2F5qL5XjS3iuh9zMf+3voxeZJvY=;
 b=L1UG4y3wBzSse+9AgH9jiDt/P0yoxwZS7MB97GcQJQBTBc4eNGGV2DUOkTOQMvJqfSoV7hM1lkDbAf4KaVAha+/H56zUVkpRKPj173g6otE99V+/frge+/Z9PO1PulG9YwypgYYcratY4gs7UDU/AC+YxbrEVNvNPBJROg9sNeTnYcPI4r2Vhhwbw7N8byOODfBvmLMohMSwR+6yx+OaFbkftfMTBdz1OOyS15PNcofXJUfQrtAZS9QTJe8jCarHI+AtDBZZR5FWFyY5rcKpGJ+1MUI2H8rpqbcf1CtizS3iP4SRdGjP7d1ACdsQwNzMY4sS7gqOfuHnu5mAvT/FgQ==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY8PR01MB9174.ausprd01.prod.outlook.com (2603:10c6:10:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 07:57:10 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 07:57:10 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Thu, 18 Dec 2025 15:56:47 +0800
Subject: [PATCH] hwmon: (ibmpex) Fix use-after-free in sysfs removal
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB7881BB1354955C1608A16502AFA8A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAL6zQ2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDI0ML3bTMitRiXSPTNANzizRL40TDZCWg2oKiVLAEUGl0bG0tAEDw5ft
 XAAAA
X-Change-ID: 20251218-fixes-25f078f93a1c
To: Guenter Roeck <linux@roeck-us.net>, 
 "Darrick J. Wong" <djwong@us.ibm.com>, 
 "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, Junrui Luo <moonafterrain@outlook.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1479;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=EjoXFMxGMQBZOSkwjr2WUKecczdBqSM5qyzJa0B0i9k=;
 b=owGbwMvMwCVW+MIioLvvgwPjabUkhkznzWd2J/6Q+hiqGOQl0/mv0uO8q/b1Vwl7rt7cHH/p2
 uqfpw42dpSyMIhxMciKKbIcL7j0zcJ3i+4Wny3JMHNYmUCGMHBxCsBEFnEwMuyy3zlNse/8rmJ3
 hTf/WXgrdi3uXrXVbUVKwKIlpl3zP9cx/FMwutDAlFDFdrqJda3dHIY/srez/nzf92f79tfnPG0
 b7jICAA==
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: BYAPR06CA0031.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::44) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20251218-fixes-v1-1-2ee6b12b49b2@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY8PR01MB9174:EE_
X-MS-Office365-Filtering-Correlation-Id: ed757df1-254e-4499-f596-08de3e0b0a3f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|5072599009|8022599003|6090799003|19110799012|23021999003|15080799012|461199028|8060799015|3412199025|440099028|12091999003|11031999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajdRQWtVVlRmOFRzTTRnaXZkY1NrZG1YbklxdnpiV0tiOXdpUTNOVXZkQzBr?=
 =?utf-8?B?NktmM3Jld0hkTnUrV0c0VnNWTmJzY3NUT3l5US9pbHMwL0srck00ejByWitP?=
 =?utf-8?B?TTVmMkZEVmtBZWwydENOaTNmaTY0Mko3NC9hN1pWVE8rMmFic1ZLK0Z1SEpi?=
 =?utf-8?B?SUE3VXZFOGx6OWZtWkRPQm1ESzU4WGF1VXZiKzJxZ1d0bTk3dE1keXNmY2hO?=
 =?utf-8?B?WWFYUVRGN1paUk92aklmMkVSaXBhWVpFRmIrZHBuU3J4Vi9nL2hJb0dXV1NF?=
 =?utf-8?B?WXc1c0tnOERpY1BpWjh2ekorcWxZUXkxYVBxS0daYXhGMUlsQkVsODFFeGRU?=
 =?utf-8?B?dGtmSk1XL3RCZkIzL3JnM2xZNU9VYzlvRDUzT3RTcFRVRjQ0SkV3d3hKNG5E?=
 =?utf-8?B?LzB2SEF4elAzS0JpMG9MTi8zdHlOQ04vSENyMm1SdTZVbkYrNFRycDdveEx6?=
 =?utf-8?B?MG1ReEpkOTNXZGd2MkVNQzlQaUpXYXFWZ0xlYUIvZTlyMG9Halh0Q3FtZlJx?=
 =?utf-8?B?MVc2djhOYVJpcjg3TlR2anNSQmZCNXVpUjZTVlZmNVJ1WFNEL1haMmh1em5O?=
 =?utf-8?B?MXRqNGx3N3o1bFJua3o2OVBDZ2FwWmpxRE85SzRiL3dOODZnWFBNUzFOLzRF?=
 =?utf-8?B?SGwyWkM3TE5lOGVpL0plK2RJb3FweVN5RjBYOFdTVnFYWjdOdm5KUXpmUnBB?=
 =?utf-8?B?blF0VWdwY1FsVVNtZkdESFVDMmtIekIvYnJmblRQUlc4OSs4QkFjRDV2SElq?=
 =?utf-8?B?Z3MvWGMzVjlBNEIxMzZxRHZYaUZhVDN5YXFlVHBhMU9tOWMxZFhmUitvQXhU?=
 =?utf-8?B?YjJTWFZWWkVVeFc4QllPRFgvMVBkdFZleTEvZFphbXFHQ1BHNGpWTlBqMFlC?=
 =?utf-8?B?ZjV1S1M3YmtHWWQ0YW9URjlneGtPTDVVRmpCcGYzMUEwanEzL0pTU0w0cDNN?=
 =?utf-8?B?cXRaUzJDUXBqZkpkMm1XQUgwZmhud0xIbFY4OEUxRjRPN1pPejFCUXljVmRo?=
 =?utf-8?B?azg5bk4zSXNSb0c5RkNlR0tPMStkUk8yd2x5N0pDNHJrK1Exdk9tS2Z3TnI1?=
 =?utf-8?B?dEUyQTlrRVVNMFl2L2lQaHFPRlVtRjVia3RTdVo3TFp3Q1VDMk1QTXlZTlM4?=
 =?utf-8?B?N0Y1dWxVRHJNRE9IV3RLUGZ3QmlYM3VFWUhpYzBCK0pRbGpEUkFzUVFLVTNY?=
 =?utf-8?B?VDA4SFFRZ1lJMjR2aFplcjZSOGJ2R01VWHgvV3FwR2oxMk5pWmFzb1lTSW1F?=
 =?utf-8?B?YkI0WFFVY3J4OWtOY2MreHlxV2FtaFhqSVhLRGRGeW1RNjgvZFYwb2NDNWZi?=
 =?utf-8?B?NlBBZnZlMUYwWTJtcDZXTjlPaHpVekxqWS9CaXNjWEpuS040WjJvcURXUXVP?=
 =?utf-8?B?aU5kQUgwUnhwSmZRTWJkRTFjT1RmTkJUL3NMUVlsOW5NeTI2bGpPS2JUaUJC?=
 =?utf-8?B?Y2FQNkF1QTlpdkRnUklmdWNmeEd6cGU1SDhGVE5HY0VWM0Y4SzBVUzJUVGk0?=
 =?utf-8?B?OFkwTFBsbGozY1lZK1AwTGhEb0RJeWtaWFdWbXZ1c2F2RWxFRTQzSVlWdzhP?=
 =?utf-8?B?bVozdGQ5dHJsaDh5and3dzEwYnlCbHU2U0xjc01qZWVKdno4cXhnUyt5T1BV?=
 =?utf-8?B?RkJMSnBYSE5ua1FyRys3V0lEL1A4SU0xMERHMHBmZllXWXN0YUJVMUVhZ1dW?=
 =?utf-8?B?ZmtaWTF5Zmk2UUo3Qk9Nck5STjFwcUNLYk1samtHM3B0ZnlMUk1NaU80cXdy?=
 =?utf-8?Q?A0L+gXv5wJ73Epik10=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHNkalZUY3pBV3kxeUdOb0lmK0NuT2lvV0NRM2xSNjNrLzI3eEU4dzEvT3Np?=
 =?utf-8?B?NzRvTDZ2VVVhK0N1VU1TOEM5ZXZPWGpDRlduS1h4TGpZT1BvZ29CUndkUFRQ?=
 =?utf-8?B?azNhUnJycnp5aGZuYmF2QjVvNmhieFFEUlQ0VEorcE5hTUZKM0xWNTVQTkk1?=
 =?utf-8?B?MTRZMHRZcFBNZ0RkaGxGL3JLWjRaM3J0UVA1UHdlVGMzQk5GNTg3bmdxWEhz?=
 =?utf-8?B?RlppVlZ5WnZub3dJTmh1WGYwYXFZM2xuZmlRZmV0bWZiWU9BVTBQZFFjMmtG?=
 =?utf-8?B?Z1prZkp3U3QzM0l6NlE2RkxnU25nMUhkUHBvS0FtYTN3THB3ODJ2WTFnZy9k?=
 =?utf-8?B?bzJEZ1lxbDM0MUVxSHNxbTFhdHJMa0p6ZHlaUkhJTlN2bkpJaDNVS0Qzd0FN?=
 =?utf-8?B?R04xWHFjSlViQjJSam8ySCtGMlRpRFpJRGRySi8waE5aMlZhWEJhdzlwZE5p?=
 =?utf-8?B?SGtPbkNGQ2sxb2V2MG15RDJXbjdFV3pGZ2FJZkhiSGpyeldUeWlENUNrYnNu?=
 =?utf-8?B?aFJ6ZXBzZUZxekVCWEQ3dnlrakE1S3lIOFM4dEJPYyt0ekJubi9lVm9OM205?=
 =?utf-8?B?ZU9YeHlxZ21tSDg4VmZ3Z0VYaUpWeGhEblhON0hQSWxSZng2TDBETW5mWnFC?=
 =?utf-8?B?Zmh3V0hTbG94KzArUXZOUWtPSWsxS05oZndhVVBDaVJwekNEZldsTGpTNzFl?=
 =?utf-8?B?eGhvQ0dZVXpYbElpMGllZzFvWWpSL3BsOUFGR0lPQWg0YmxCdEhORFhsTmtO?=
 =?utf-8?B?WUFDQnBrOVk5ZUZsWmVDN2NlLzQra3A1SkV6bkV5dldCK2p1SkpCYWNINGdx?=
 =?utf-8?B?TkNVS04rdHNKNXJGb1hNZTdZVG1FOXloOWpUbVN1VzR4VmRLbG12R0NsU3ZC?=
 =?utf-8?B?K1dwSlQvTVM4cGhza2JqUTNGN1E1dlFOUGZvQjduSVc4Y0l1RktiSnFuaGE3?=
 =?utf-8?B?S2hCbjJvTjV0YkpQY29KbFZCMGNYeXE3TUlWVEkvS0M1S1VIWHFrS1p5Y3E4?=
 =?utf-8?B?S0lCVWJ1aytEODkxNTVKNmoxT1ZwelNsbFl6MjQyMzAzNERIcWFvWXlHTHBI?=
 =?utf-8?B?QUpySlpiMVVXRUlvYmp4alhSSUNSenZDUXlHYmk4amd2YTJIbTYrUXhiL09p?=
 =?utf-8?B?T0VqUmg0aWRDSTM0L29mSGNFd21XWGx6SlJzbWliNWxndXJpOUtmUUF5ZVBX?=
 =?utf-8?B?S1YvMW1BSG9RREdRSUZmdXlxMjhwbzZ0RlJWRkxhVHdLUCtLQnl5c2RyNTRJ?=
 =?utf-8?B?VXFGaHNGYkwvUGFrenpJNXVySHJpcjVJd2EwSzZSL1dEOS8rTWtKNWpITDI2?=
 =?utf-8?B?K1RWZzRpQU1GR25LeVF3UDdPMUx3ZlkwdURRRlBIMVkzWHhpN0k3WXVMNWV6?=
 =?utf-8?B?NnNmOUl2YnRrWlU3VWNDdmplOWR6Uk8xdmVvV1REdXF6aEhjZU1nSHhYa210?=
 =?utf-8?B?TVRyN0lISkphNzRKMzFWQnZYNExPTktpRHlad1NPeSt0a1pLUGxDM3pZZXRL?=
 =?utf-8?B?dDlmRjNkU0JtaXliMXdhNE5DblQweUNWZWk1eGlZc0dERWFVT3FJKzNkYU1Q?=
 =?utf-8?B?OTg0bHhxbGFDOTYwMy8ydUkzU0dJU1RMNGJFbmJUa0Zta3FNUldiK3RTWmx4?=
 =?utf-8?B?WSs5d3Fxb0JnaDFJYnRScWU0bzdJWU55NFhJNlFzTVBvbUYrR3ZJdTI5VWVJ?=
 =?utf-8?Q?+HI7vh1Om1Af/mFDZbYd?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed757df1-254e-4499-f596-08de3e0b0a3f
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 07:57:10.6745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8PR01MB9174

There is a use-after-free vulnerability in the ibmpex driver where
the driver frees the sensors array while sysfs read operations
via ibmpex_show_sensor() are still in progress.

Fix this by reordering cleanup operations in ibmpex_bmc_delete().

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Reported-by: Junrui Luo <moonafterrain@outlook.com>
Fixes: 57c7c3a0fdea ("hwmon: IBM power meter driver")
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/hwmon/ibmpex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ibmpex.c b/drivers/hwmon/ibmpex.c
index 228c5f6c6f38..578549f44154 100644
--- a/drivers/hwmon/ibmpex.c
+++ b/drivers/hwmon/ibmpex.c
@@ -508,6 +508,7 @@ static void ibmpex_bmc_delete(struct ibmpex_bmc_data *data)
 {
 	int i, j;
 
+	hwmon_device_unregister(data->hwmon_dev);
 	device_remove_file(data->bmc_device,
 			   &sensor_dev_attr_reset_high_low.dev_attr);
 	device_remove_file(data->bmc_device, &dev_attr_name.attr);
@@ -522,7 +523,6 @@ static void ibmpex_bmc_delete(struct ibmpex_bmc_data *data)
 
 	list_del(&data->list);
 	dev_set_drvdata(data->bmc_device, NULL);
-	hwmon_device_unregister(data->hwmon_dev);
 	ipmi_destroy_user(data->user);
 	kfree(data->sensors);
 	kfree(data);

---
base-commit: cfd4039213e7b5a828c5b78e1b5235cac91af53d
change-id: 20251218-fixes-25f078f93a1c

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


