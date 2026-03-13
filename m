Return-Path: <stable+bounces-225293-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oF5BLtX1s2nYdgAAu9opvQ
	(envelope-from <stable+bounces-225293-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 12:32:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59524282439
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 12:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EFA1305D48C
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 11:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF3A336EE7;
	Fri, 13 Mar 2026 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JHhGlzHX"
X-Original-To: stable@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010018.outbound.protection.outlook.com [52.103.72.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E6731D759;
	Fri, 13 Mar 2026 11:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773401527; cv=fail; b=hZF1tmGo2idm1g3kNGV3oaekNwbEEj0sqEbDEGoblLFcGsYn9PEjTsqr7dW4fQpZvEr+oY1Ixp4n2QXle1hYvp54dmfLtKHRUfloU0oyyqW13mdy7sasuVQ+XPoAokB+gUdswOkWNsA47o+IRgsqAr2YVM2+C3bsdLx6IcnV4kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773401527; c=relaxed/simple;
	bh=S5kZc7UnE7DxpJ6Ydanj+qb02okItoyIbq46l7nmHRc=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=BlHB/9Ejh4EwaQPPDOwCks1H7WCXnZ0PqJ24ixs5gRuYMzavYQhZ0c0Ti5ycnHvUfI1L7tOkLrkJGEBORTeNKgpIIYrsI5wdw9HcfXVs6fjOzCvlys4dzGca+898yGtSk23Dfcjij984eunbr0sImudn3DjSKMDiLqlvkRMAr4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JHhGlzHX; arc=fail smtp.client-ip=52.103.72.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=meIoDdpW54BmHjUWAb21ZimfGQTjc0wcK7KFftmo9CbPhgJN5fTSk2FXpdtTsL0ZZzjw/R0ThPXH8vuSm8bk847Tzk/V1izCByBe+FBdfH39h2YmacAmASJs6uxRFtVlCq+8TxtkaAiUnM8XNrIc9Oo0zWHute42psMjemqqu2Rh2jgP2w+rpowW3LBNBeJof54zJtgrOU8bLxgdlgrE9i4q7NTnMyRmvv0AHQTr1tTKExKh1endJecW4RZOzBBnpsgeq1+Ivo0sBxwt85G+2VRJc0XTolvdwaIg4ZoX2J5pg4StVrXz42dXXl7/5eZ3epIlrB4uF85qwdxhsWU0HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+b897d0T8h7azRdLegnTbxcuThxW3NMIHPluBhSw+10=;
 b=ryuP07JBa3kng7kpniKVaVuX3udCvXn/iOYHwPqwnZnOC1cSZsJtO3Q+T+ejcR+AjHoQqqHbeuo6RpD6sEj5pC2N8WWghMlDohSrM6vMZsV2Ma/o6OPQxo0qrADfB06lA5kxk7OLR7Tf67PKmEu3CYpP9rhbdeFem8P84jLp1oMuPIjeqke9PP7h98vxJOcNUe/OrAvQiwkoYXv/WK9ReAuLiv7wqsp5VnFu+pM0yyxkJrrr+akVC3A5wMZ4+rOqFmvfR0dAzUWNrnJ5eJ6ItoTGUDmEPoaqXOWsKV9KSAXk0ya5DOjz6WfQOFA2llWF4lUkkiTaQFLVtGWyrLy0IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+b897d0T8h7azRdLegnTbxcuThxW3NMIHPluBhSw+10=;
 b=JHhGlzHXHbbgMBWeesKQDsqdprw9VFI8je2Iq5YE3nBgG0g70m0YoxnKjrFr5/h0PnWwYhLIlxQ4TJzTFnV/D+moRxzZJrCKflgVrdqz9EU7le764vFfxGdbQtk+pWB5koh2iRMvAlrrAMlBqxWeNCEX+Etnbuv5KYNkDNaYCbSKBMdosw0ZlPC39hU5OK10EC9wUq/JoMyu3QlVXi63iv30O9OhpED1fLMNRmi2UKk9pZUfCSKOtKYINCQLUiRp6K2cdJabrj+5Vvn0IlfisQLYIbgk+p3WOw43KnqhodEDHyNZGP4q+Uo8XdMzzckhyeKzU6ty9WPdUmHk85PuYg==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY9PR01MB11058.ausprd01.prod.outlook.com (2603:10c6:10:322::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Fri, 13 Mar
 2026 11:31:59 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9700.015; Fri, 13 Mar 2026
 11:31:59 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Fri, 13 Mar 2026 19:31:38 +0800
Subject: [PATCH net] bnxt_en: fix OOB access in DBG_BUF_PRODUCER async
 event handler
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB7881338BC956C39A9848EE86AF45A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3KQQqAIBBG4avErBMcjRZdJVpY/tZsLDQiEO+et
 Px4r1BGEmSaukIJj2Q5YwP3HW2HizuU+GYy2ozaslVBXmQFDoNn58LKoPZeCX9o60wRNy21foc
 OILlcAAAA
X-Change-ID: 20260313-fixes-e1f4d1aafb1e
To: Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shruti Parab <shruti.parab@broadcom.com>, 
 Hongguang Gao <hongguang.gao@broadcom.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2350;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=S5kZc7UnE7DxpJ6Ydanj+qb02okItoyIbq46l7nmHRc=;
 b=owGbwMvMwCVW+MIioLvvgwPjabUkhszNX1dWRzuUpnnKn4q+Hx/p/yWZheecyoTlH8Lkz+hEt
 wbEXgvsKGVhEONikBVTZDlecOmbhe8W3S0+W5Jh5rAygQxh4OIUgIlcsmFkmG0xS+r0gq/ru+Ye
 vrxmNmPaz1cvTThWnU+MEz+XYOH8LYuR4fKWSH9rwXOfeEwjVFZqaYgxpW+fGr7i0YSp9of/J5c
 lsAAA
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: SE2P216CA0151.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c1::10) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260313-fixes-v1-1-381d517c2eb8@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY9PR01MB11058:EE_
X-MS-Office365-Filtering-Correlation-Id: 08c18018-dfd3-47bb-85b7-08de80f423d9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|12121999013|19110799012|8060799015|51005399006|23021999003|24121999003|22091999003|6090799003|15080799012|5062599005|13031999003|461199028|40105399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVpYczlicGtHVGpwUnRZU1FkRVd5bDZxR211NTNsR2dyUjh3SHhYRm5XK1Yr?=
 =?utf-8?B?azFBbkhkOURheXJoZ2NSTHQycUFCUDF4QkUxbU9MYVc2MkY3RHpodmFTRGFJ?=
 =?utf-8?B?NHU1RGs0cGtzMjhydWJtYkFkSkJROTk1L016UXJabGZvRytuZERXdHFrWnlm?=
 =?utf-8?B?b0Q3WUgyQ3R3ajNhUlFIZ282UDB5b0g1QzBIQ1BhdjN6SEkzcmZiWXBMQ25p?=
 =?utf-8?B?ZGRYT1U0aVFFdkExdE1GR3VuRENBN2w4ZktremQ3MkhRQmdjRmtvdUdLajMv?=
 =?utf-8?B?d0phdDhyZTEyV2MwNzlad0tFdWlNNmVEVUVDRjhmWkJCZHhreVdFYnFlclBC?=
 =?utf-8?B?alVoWmE3L0haU3dkdzVMdmZsR0RTeSs4TC9qdTRqcERxUFhxOFUwUDJBK0tC?=
 =?utf-8?B?OUlqVW41M0pENzl0TjhrKy94aGlidG5DUDdkaVR5VDRjZDAyaWMrNHdkU3kw?=
 =?utf-8?B?UHA3ODBub3VPUjZmWWNEaG44RENIU0NVMExneFZrdnNZOGhWU29zam9ldHJZ?=
 =?utf-8?B?WW9vY01pTFVXWm9GaHpKZGpVR1F6RlVqMDFNbkNjS0NaZU11VmxlSmdScGFF?=
 =?utf-8?B?YTB5TEdvQVc1eFJhN21yYi9HbTljaFAwWFlOa0ZibDNpR2ljQmNPOEUxWVI0?=
 =?utf-8?B?QnZBM01LaC8wRm1YTUo1alhXTG5lOHgvaG5VK25Od1VRZ0NxazZsRXAvM3gw?=
 =?utf-8?B?UzV1MWRUbnRJeDFGdWYyK0hCZXQwUzN1WmZTdnk1bXEzQ3d1OTZyNzAwT2py?=
 =?utf-8?B?cS80WnUvRVJJS254KzJMRldJY3J3OXdCY3o0bExRRWF0Nm9FY2YzRTQ0cW1N?=
 =?utf-8?B?eFhxVkw3dlY0bThqRlNUSUhPelI0YjRYekRuWFdLamZaSktwOEhVQzNjcVBh?=
 =?utf-8?B?QjB1UHFLeHhaenB5MFFxbHVwdjY5Ymt4UXJFTHlySDhXcnZLNkM5c2xFcHYy?=
 =?utf-8?B?VDJEYnZURmlHSTlxM2QxYysxMWhId3VTWG5xdlRZTUtNWFpxU2F0VFNueC91?=
 =?utf-8?B?b0ZHRFJFcWNhTWtnREhLZWdqM2xhdUxkbHpvNDJCN21nblNNOGxSd1FhNFdx?=
 =?utf-8?B?aEZES0lHNjUzK0xtTmxRbGc4K2lMMXdFS252TTRPdHZZRmZuM1JTWldCZ3Z3?=
 =?utf-8?B?aE5yOEpwM1k5bGNSUDhBbjFFTlZoRUhoNUVNZnZnT09oNTdlZWIyam8vWjJJ?=
 =?utf-8?B?MkpVWCs0M1A4bEE3aUZiazc2bkVoanR4aUFoK2FZSHhzdEdQbG5NYXRnV2E5?=
 =?utf-8?B?Ti91dGZVeEJ4RGdSbmRyR1dTR1g2R1dPbmo0ZXNic0kwcXJvY0R6V25xVjQy?=
 =?utf-8?B?SklTb3kwK3B0Ti9pZlVLU3FVMldXMjFmMkJiZDR4MWZOdFJKV0p4MTg0Q0Fr?=
 =?utf-8?B?UC8wMHFTbUE0cWREcllaWmFDTVJESlJCMjBabnpDTXNXRXQzc25WbXVEZVJW?=
 =?utf-8?B?eGZjeUJWUFJKR2hDK003cnZyZnJ0Y09CazBNZllaTWtvNEVwUUgwRkFoU2xH?=
 =?utf-8?Q?latRj7iVPzefjCoyPbHl+ZQeN6P?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTdKQmtka1lTSFZ6Vkd2WE9BWEd3bFZtZFh5YnBmb0Z5Z0h3ZmR0QXhRM0Vy?=
 =?utf-8?B?VGJObGhkd05KenMxUWVDUGkxdGZCZkNaZE1lcmhGYlV5VVBrTzNTcy9DZWxG?=
 =?utf-8?B?VFNMQXNvN1NWQzFvOThCWm1veGJsOElDT3h2TnpYb0lvL2ltVmhUMk5SMG40?=
 =?utf-8?B?N1h3OGNiTkptR1FDcUprZFRudGJNSm01YlZKQ2xXdHE3Nk5sbkJTM1o3ZmtV?=
 =?utf-8?B?d2hia0NEZlFWdlJ6UW5ZQnhnaGxzUEtoSENYY2pkYUhwbSthaXBQNnhkV0ZB?=
 =?utf-8?B?SE1ZWDN3Q1JBZ1lMeDFtRkdnZm5BZFZWS1lYdHdIMFRiSTF2NmFLa0w5UHlx?=
 =?utf-8?B?QVk0TFhnZGR3K1h3NEg4WlRWQ1lTUGVVa0R3djRVcXBFOTVudUp6cGt1TWE3?=
 =?utf-8?B?ellnUWlGNW51bkpxREpUeGQ5UEJ2UG5ydndnSjNNcnpqK1B0alpLSzhlcExj?=
 =?utf-8?B?eHBxYXBWcVZhc2RSSE96dXRPTjBIaHhyZjJSQ3M0bitLZzBzOGszTnRMdjQy?=
 =?utf-8?B?YjR5Z3krSm1BYUxCeEgxcUlLNjFPM1JGd2JvczJyNE5QdC93anVtRFhQSWdt?=
 =?utf-8?B?T0wrQjd2N0N2SWRTZ2dES2hPbHNyK0RDaUd2UFpjOUF4WDM3bjlzUmtGU2Fy?=
 =?utf-8?B?ak9OS2twMk9mcnJWZmFIUnl6S2xBVWJqQXdzNEVJT05uN1VRbnpuRzN4QWxs?=
 =?utf-8?B?RVdTT2FDUzBlaG0zRmlhalRaL1dRRTBqMElSc3k3N1RJK2dxRFNOQkM2Vkti?=
 =?utf-8?B?Rm5tL0VhZW5TRmRwSDBZN0t5SDRSYlhoVVYwMFFTREJka2ZkWnBOdk9WNHFk?=
 =?utf-8?B?ZFhqQ3pQYm9VcGZlNVVhcnNibDlTYW1FVzlaUElrYTkweDkrMmV3SlBiZVN4?=
 =?utf-8?B?UllFVURSYzYwQUhuUXVoZWtldEltU003UjRoK3cxY0MwTENxVTAzWjVJSzdB?=
 =?utf-8?B?cU5QTE5hVjBPazUrUWFTVmIvR1dSdXdwOHh5alJQZ1ZWTEhNQWsyMU4yV0NH?=
 =?utf-8?B?ckNRbXdON1dzcjNKZWJOSm9FZlRFWkhzNnZVMG9peFErdkN1dVpVL2tQaFN6?=
 =?utf-8?B?Q3crdlVYWmJiN3d1MmF0ZUh1T1FUa0ZhVGxIU1pVN2szbTBKK2NKSE8vbWk3?=
 =?utf-8?B?TFZYZmNQYW14bUNERURrYkcrVzBiSkt3K2xrQ2FucHBpSEExcHR1Z1VFVTNs?=
 =?utf-8?B?NzNyRG9hUWNaWm1mQVdVSHl2MVNIMC9IcWpwYVJPTW10blNYQ0lBYU1LbFJO?=
 =?utf-8?B?WFJmb2xkWW85V3krWFQ3QVdteHdxRkhUODNwd1VCekNaVkc4NklEVGJQSW5j?=
 =?utf-8?B?emltNFJKMDNRZUpKN2luZTJYbDdxTEg2TTBZQ24yNVNvNWJ3UEkreHdPeEpV?=
 =?utf-8?B?SjVGRTIybUdvNVBubXdsMFNUZmdoOEwyRVVnNk4vVExJRy8yUmtzamdDVEVw?=
 =?utf-8?B?NkF3TEZKdUpFR3RxRDN4T1llYnZBTzRFc1BnTzBWQmNGMDJNd29aNkYvVG92?=
 =?utf-8?B?TEU0ZFRZOFZWbmtPSzNCQlZhRDdFckdlUDJ3R1pIY1NzYzJGWTE2RUQ1MC9r?=
 =?utf-8?B?aGVxTmFDM2V3dEJJNmZpQTdEdDlJRWNpNmtZVnU2eGg2YWxDcDQySmRwWnpR?=
 =?utf-8?B?T0puc2FneS9FWENxdkZvdGZGU2x6bDIwUEpRelViNTRUZEJ1Q29lSlQwSXRW?=
 =?utf-8?B?QVBXa01IOW1Sa1NLUFFZdzhiT2ZBRTdWM3hnbDdqWmt2NG5rZGRIZmFqNnox?=
 =?utf-8?B?WWxBMDAzTzZnN3I2WmVkWTJmZmxWVm9lbHJxYlRBVjJCdHFWTTgrdGVqdDJE?=
 =?utf-8?B?NkhHbFI4NlhScWxYS1VZc1JYRlpJUU1nZlljdFZBcWVsbG5qNTZZSkFmWlNu?=
 =?utf-8?B?T3ZnaFVNMndPd0RsRHJTT2VyeTNQL2ZXZXJLdEJLN3BOM1E9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c18018-dfd3-47bb-85b7-08de80f423d9
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 11:31:59.8692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY9PR01MB11058
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225293-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,outlook.com];
	DKIM_TRACE(0.00)[outlook.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:email,SYBPR01MB7881.ausprd01.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 59524282439
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ASYNC_EVENT_CMPL_EVENT_ID_DBG_BUF_PRODUCER handler in
bnxt_async_event_process() uses a firmware-supplied 'type' field
directly as an index into bp->bs_trace[] without bounds validation.

The 'type' field is a 16-bit value extracted from DMA-mapped completion
ring memory that the NIC writes directly to host RAM. A malicious or
compromised NIC can supply any value from 0 to 65535, causing an
out-of-bounds access into kernel heap memory.
The bnxt_bs_trace_check_wrap() call then dereferences bs_trace->magic_byte
and writes to bs_trace->last_offset and bs_trace->wrapped, leading to
kernel memory corruption or a crash.

Fix by adding a bounds check and updating BNXT_TRACE_MAX from 11 to 13
to cover all currently defined firmware trace types (0x0 through 0xc).

Fixes: 84fcd9449fd7 ("bnxt_en: Manage the FW trace context memory")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c426a41c3663..ffc7073a596d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2929,6 +2929,8 @@ static int bnxt_async_event_process(struct bnxt *bp,
 		u16 type = (u16)BNXT_EVENT_BUF_PRODUCER_TYPE(data1);
 		u32 offset =  BNXT_EVENT_BUF_PRODUCER_OFFSET(data2);
 
+		if (type >= BNXT_TRACE_MAX)
+			goto async_event_process_exit;
 		bnxt_bs_trace_check_wrap(&bp->bs_trace[type], offset);
 		goto async_event_process_exit;
 	}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 9a41b9e0423c..597932cdea09 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2146,7 +2146,7 @@ enum board_idx {
 };
 
 #define BNXT_TRACE_BUF_MAGIC_BYTE ((u8)0xbc)
-#define BNXT_TRACE_MAX 11
+#define BNXT_TRACE_MAX 13
 
 struct bnxt_bs_trace_info {
 	u8 *magic_byte;

---
base-commit: 0257f64bdac7fdca30fa3cae0df8b9ecbec7733a
change-id: 20260313-fixes-e1f4d1aafb1e

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


