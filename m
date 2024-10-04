Return-Path: <stable+bounces-80734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A0A9902A3
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 14:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D56D21C21327
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 12:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8810B15958A;
	Fri,  4 Oct 2024 12:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="HSqcVO0p"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42841FAA;
	Fri,  4 Oct 2024 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728043638; cv=fail; b=MeNmVj2JlI4079yosmKaYp1yxz/G1wfuwmLNZQSmu8fI8nCo1Ag3Y+kVzkoz3/o19wslh4jJ1rj3pjXoBV42h8HgVW9yt/0AdZ2LggpsnUaqo2t2513+N4SPBaFkdr2otXCZzvqMkwqjkpDGZ/84J7OdP9EG9H0t9CGp6McpzVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728043638; c=relaxed/simple;
	bh=17LpPCN8ynp+2AwGkFh5Pby2vTJJUsZRCbGUQPXHQpU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p2TBeSce1xHpGQ26ZFjYQEOHue++hq7YfQdg+miMf+HHUKuf2tEXlkaWCF+2wAfhc6rBMaS7SWal3MAQvR5CZtVZzwjDk5KxVP6KYMHsdhURuoVyPhakd0499ckrfxKzJ4WxwEgPV9/BpyrYkKrYMtjA2Zcp4hY8XVhGjZqL0oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=HSqcVO0p; arc=fail smtp.client-ip=40.107.22.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwOMoYP4+Yx4hc9VCX7JHYaOAjzI6MXI7572m5qt3uWXhjefPuOOuOPvR9TrpUki1VbqDS3Js+/08/QiPyWUsy3B817TJ6n2AW1upCWac3H/ddMfDZvmEgwsPBsG0ngdJAI4GJhpjAFx3fFnkg+ouB4vEgpyMnQ/AN7Xr3HC8H7gHdVe5XJyBK0nxCB4GkKKgAwnvuWQLfMWANzI+2u55OZoKeEF7c8HThosr0xddPWDY9sHWr/QelKcsBKWutDkd2UFh+SblVws7uxLumONGbm/784tGNZyTzcLihD0XvWxa2tLMzJPgdiXpfqESJ9zN+T5vySZ3TxLqmtV5iKIlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17LpPCN8ynp+2AwGkFh5Pby2vTJJUsZRCbGUQPXHQpU=;
 b=Yxpg8c5f20KFR459PUo5ju4OINGdV6iT8DQHNMKLBkUgTXFxo58pK4x67wseQjwV0Swl3L2C9cyyNhU2l9EeyNYvp484fYjkOYtesAgucqND+25wKODEgTJkD+zbsTbhhrqnp79eqXqEGqQQTFn3u+H922WSdGZ0lTKkmK+1yA6LRRa6gg0C+JQJ18xbIkGrs2GhCLXMjMfb3vU6wYiNlvV+/bXt8wFZbqbzCsfPW1ABtVE65O332oWZ1gvOErjzetIREjCGD3UWRNP3+ZcS/DxbtpPVmeT/3w17HSs4D+30agS1YxkzbQrf/0TN0y87yl+lEnrTe+d0Ot3QboXn9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17LpPCN8ynp+2AwGkFh5Pby2vTJJUsZRCbGUQPXHQpU=;
 b=HSqcVO0pbarRnRrBW4gPcL2YQeesaN2s86E3/NT6DburqbUdT4ummBIK1E3ni+4vh1N3C0BpN0YT00SKERWaZGFua2k+u3ALZBE8S1VQev/5ynYxKailD+skrgXHrFXU3yRBBbxDA2YHozYWieaaJnSeCryuUCL9EUWufx80eR0jelQXh/8GSol0cjJeDD1pE9xyssCGQKIuNlrY2MUxVFofGGhRLDGrg7nt5+OJKpyNW0ZJs3yMIwY/wEDHDrILuU/R2cp51VflQjt2AxSmdZWDDNhRk/+TMy+/DkeRZ3kLO7niNw5TE8H7BfIwPU9SSneO96PaVrMXuSE87s7tkA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU0PR10MB7120.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Fri, 4 Oct
 2024 12:07:12 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.8048.007; Fri, 4 Oct 2024
 12:07:12 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "olteanv@gmail.com" <olteanv@gmail.com>
CC: "agust@denx.de" <agust@denx.de>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>
Subject: Re: [PATCH net v4] net: dsa: lan9303: ensure chip reset and wait for
 READY status
Thread-Topic: [PATCH net v4] net: dsa: lan9303: ensure chip reset and wait for
 READY status
Thread-Index: AQHbFlHn5tP+qUF2Nku/pCZ2l1KfvLJ2fHQAgAACyoA=
Date: Fri, 4 Oct 2024 12:07:12 +0000
Message-ID: <6271d9229bd1f8d2cda09d9ebfafdfe5774617c5.camel@siemens.com>
References: <20241004113655.3436296-1-alexander.sverdlin@siemens.com>
	 <20241004115712.taqv5oolktcfhvak@skbuf>
In-Reply-To: <20241004115712.taqv5oolktcfhvak@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU0PR10MB7120:EE_
x-ms-office365-filtering-correlation-id: fbecb8e6-ed33-4a42-b001-08dce46d148c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b29RY051aDh4REx4OFMxRmo5anJnWGNUYmFIeE82eEs2WGlldTg0STlxcFRC?=
 =?utf-8?B?ZWlVSkRQV282d2drSzFnZnZuOW9uM1NKQURMb2xDbmRBUVgzcUNFYUpKZFBr?=
 =?utf-8?B?RkJMREpMdEk2NlFOYk5idlh4bTE0RkVmM1J3YTY5S25Mbk9aWkZRdkFiQktw?=
 =?utf-8?B?K05nemY1NGRzcStHck9UN3UwcXRFV1g4T09VK3U2QXJiOVA2YklybTJrVFZo?=
 =?utf-8?B?QzllTG1iV3pYMnIrSkprYUE3Rjh0aXVyUzI2SncyaDc4VmVpSE9NRUJtTjhq?=
 =?utf-8?B?NDE1T3Q2WnRiaXlDbm52bjFocGs3SkJzMkhyQVpCSk9wV2JKS21HTXVHb2xD?=
 =?utf-8?B?NDdKZlBXZlYzNFM5TEo0MnFZM1BzV2FwV3h3M0VxVVZJSXZGSVIrUkoxa3FM?=
 =?utf-8?B?N2gvajZsek5mWlZPb1ZzOTJ6dDl3dEQ3b3NrWE9Pa1dmK3hidHNBZzFiUklI?=
 =?utf-8?B?REZjWFB5cCtaaWlsTUVtRVNpQU5kdzhsbVIyQzBtTGFEcXJranZGUGlVVzc3?=
 =?utf-8?B?VTRQSlpQNjJVbjVOVDdRTms1RzFSK29NcGVtem9KQisrUERJSEgxaUxxcDRy?=
 =?utf-8?B?WkxEejk0ejQwWTVRdldtbzBjVThoQnpVeXpFVVA3QmRoYlRQcGFvcyszd3Yx?=
 =?utf-8?B?U2U4M3p1MjZwZ0k2WXhuRWxEc0t5S2Yra0RDQmNZYWRXeWNZVG9uNHk5QVBp?=
 =?utf-8?B?cTBtb3hBQnhWaTR4K1hIcW00UmlNRXRCUjRxY2pmQVBqV1JwT3h1REp2VWY2?=
 =?utf-8?B?MkJEQ0kycTdJbzNDUkk2TS9RWU5laXlBUjJtbll3KzVvdjhjQlJuZmFRa2xn?=
 =?utf-8?B?TDZsWXBuMkV0R0NWelFldlFaSCtSUEwvaUhnWXhMaGd4aWMxdHp1L1J0d3p6?=
 =?utf-8?B?SUdud0hPampGUHhzTWxZNFY5OFhiZEZ6a1pweHdjWTBoalBqRVZVdmo3bGJR?=
 =?utf-8?B?Vk8xbWhPa3k3ekZNSEJkRnh2Vk45Zkh4a1g2QzdkWkNpSDNSSUtwVTlFdC9n?=
 =?utf-8?B?NDlOOUZ6NVlXbzNSek1aY0lmTUM2Zytzb0tXNnl4N0YwTWdyejNSRkNEMmtQ?=
 =?utf-8?B?b1ZwOG9NL2FrN2FRU3dLcWJKTk5oUlBPaHNOM2lsRlBib2c1MDBFN3JRNUxa?=
 =?utf-8?B?eFNGbEYvVzBMNFc4VDAyK0QxVStIN28rR3JxUDdXNlNaL2x2OXZKMm84U1U2?=
 =?utf-8?B?NlROT3FlSW93SXl4dlVXTDZYb3Yzd2Uya0lxV0U5UHRsZGlVS1J5S2ZvdXRO?=
 =?utf-8?B?OUVNQkZFSDh2KzNoWSt1NE9nQ1J6V0s5VjlPUnFKS0dFZDRCZG9TNTNBa2Vz?=
 =?utf-8?B?cVZ1MnBid25ISklKdTI1akxkdUpuL2c2dW5NSk83emYwdGVKb1pCZXdZVVV6?=
 =?utf-8?B?eVIyMWF5UGtsNEw4b01jMUhVZldvQzV4diszTEhQaGhPRDBjOHNiMWlJVFdx?=
 =?utf-8?B?QVFnY09OMi9vU25oZHFnT09CbnRFeGl1VnlWWWxOdFBlNno1M3pBYTBmMDJQ?=
 =?utf-8?B?WnZZQ3NjMENyUFFXQ2laeWEzanNkaExlYktNeGFnclkwc3lKTW40YnJlYStX?=
 =?utf-8?B?eWRJZXJsYWY0MXBLb3pGZ0pvcStUVERTcm5PeUgrOE42Zk1lL0ZLZmxNenVn?=
 =?utf-8?B?ZEt4emFiUTVEWUpxTmRFVzlJSisweE9iblhidGtSSTN0Mlh0cngrZnhHWHpJ?=
 =?utf-8?B?U2VocE1ibkZoOWE3dDBYOU1KY2dBRHZaWXkzRzNZT0xoZkdSV05uM1l3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NW9vWXJvb1ZwQjFUcmVpZUFQM2J6RVNObXhFTDJnM2NyRUlXOHhwZGxoNkZQ?=
 =?utf-8?B?OFVVaUl0eVgweHNMRERwWVg4YlQ2OVpsOXBZNUdZT3kvaHhuWEM2NGhaTE55?=
 =?utf-8?B?SkswZGNZY0c2SW10OWVvYzlxbk5ObTZPZVhUdkp6c1liVVg3UVJ0TkdPNmc5?=
 =?utf-8?B?M0dPVTVlakxmQ0l0NG9wSkNVR2xyRnIwelBzV0oxUm5jLzUyK21aV0dUMnlB?=
 =?utf-8?B?Z25qYUFKZTd3YUhETWp5elNoaGRaQmExRmovcXFsYVk0MmV0dVJseU9tdzJz?=
 =?utf-8?B?RUxTSHJqZjVhZnYwZlRZcDZ4RDZSVC9yZkFjN1k5TnUwcXVaSS90RVNkZHpN?=
 =?utf-8?B?dENmNTR5K3JKalVUem5TeGpvdWx0cWoydkJKYTdIcWRrT1A2UEFkRnQ2UVlm?=
 =?utf-8?B?a0V2RU4yTGtTcStLY3dqc2lqbzB6VW5USjdyZWJST3BBRFVKSFd0WlJCbkJi?=
 =?utf-8?B?L2dnYUFZMXhjcEk1VUw1MVBsNEhiUmlCUFRxQWIyakN2OWZ0aHlWbUdReW9p?=
 =?utf-8?B?Z21pMWp6bGZMclE4N2tKS2x1MTl1T2k3ZENmcDlQeTJyL0VrRUhIcWlVaXFr?=
 =?utf-8?B?RmlwMExSQncxOXBpQlZGSGUrLzZiOFQyMUN2SXprdnNTV0dEeml5V2VDSE5x?=
 =?utf-8?B?OHBoZDlXRzNTejZXRlJsUE94cm9wNDFKZDZqTkwyM2NoaUgxTHBSbHhLTkJ5?=
 =?utf-8?B?cmFUR0ZwOXhaSlRTbWlvazVvUXM3Tk1DNjlyaEs0eUxzTkdDMDRXajgyaWF0?=
 =?utf-8?B?dW1uMTc2SHdMcU96NGNmUDFPQ0QwZWF4YXg3azMycThQZmt1UHorZmJDeFJN?=
 =?utf-8?B?SWZXU3pOR3BXWHordlNXTnkvcVdRKzNFbHlwaFF1Q1pHbDdGQitwWXBKUExs?=
 =?utf-8?B?UkswOVlOVU5JRGRKU3pVcTcvYjBKRVdycHJneFp6NXhodW1RMVhNT2RCYzlx?=
 =?utf-8?B?WnA3WjQ3TFNQQ1hQL1NibDRIR1BuOHRyMjNkM3FlMFppWVlSYVpqVFo1a0hz?=
 =?utf-8?B?OFhTZjlOb0VJUmpqWjlDOC85Z2hNMTRDK25DbXkyYkZVNDltM2tpamNOVk9E?=
 =?utf-8?B?ZGZ4ZXF0aTdXRzBwaVlsbU4vaWpFd1YzZmdrTlFMN24vYUVaWTR4NVliSFFj?=
 =?utf-8?B?d3lhY1JVaTdjazJZVFEwczVYaU1RMUJkWUZTWTNqWC9hODZETzhVaWtUSzdW?=
 =?utf-8?B?V2NPM0k0Y0RyL2tMdUFPMitXTkFjUWJ3dGZKNXYwTm1PS0xtSDhMSkFHVDBr?=
 =?utf-8?B?VHVBZWN1VDFob2ZYYURta2JSMTNPbTJmbTgwb2Q2SUVPYVlDT3BGSThtTlRy?=
 =?utf-8?B?bEdpSDJ2dG4xamxhR2hjajA3bDk1dUtyRTVqbExmZnpZVVg2YVhGTGlIODFL?=
 =?utf-8?B?Sk1zTDROREdIVTFQUDg4WTFnZnhDZTcrc1Rsc1YzTWNabVZLTWVlY282TXla?=
 =?utf-8?B?T25PQlg1c0JNVDdCamgyOG02Y0hVUWNCdWlyNlZaUVl6d1NBMjJWa1NUKzVo?=
 =?utf-8?B?UDRGYnRiNlVZUkhQZ1NBaTVzUzlva1dFalpqM2I2ZXY5WmpTakZhWHBORlJG?=
 =?utf-8?B?ZVNheFFLa205aVRTSEM4YXBIRVpzeXo3a1ovcm5iT0F2dGR1NnVFZzVRbmRJ?=
 =?utf-8?B?YzI5ZXdWci9TdTh6VVViN2lRZHJRb1dLVldFSThnUVRqQ0VHdDlpeEkvQlhB?=
 =?utf-8?B?OFFqUVdGbG5xMTV2QzFsTnNVT2RtRFcxRU5wdC83NytmL1p3YTVxcEcvRXJH?=
 =?utf-8?B?ZFl0TmszWGpGSUZjWm5wZHhtYjJwb3Y2ZVNEZlp1MUU3Nmd4M1VwTnZPN1pH?=
 =?utf-8?B?UVB1emVONkE0YnJqbnpxM0d1c2Y4YysvbTZDTjhLQk1uVUs3WGc3R1lZV3Jx?=
 =?utf-8?B?NkIvTDlob0VRREJUaUFOUWRZNjBUZnM1dkNjbnVwWkV3MndqOU1zVnR3N2FP?=
 =?utf-8?B?YzNGTm4vQTRwdjF4cXh1eE1OMmI1bURjd0Q5TFhTNWxHRFY0Q3FkU3M2YzFX?=
 =?utf-8?B?SUdNY1hLS28rbDkwcTl0eXlFdG50bFBxTnZ0TmhxQWExYWJYMjdZbnZmcXh6?=
 =?utf-8?B?WUVTYzVnYUNaQmFqWCtMNEFLN01ObVRYbHNEUlQ1d0c0UFNQZmtCRVdqb1FB?=
 =?utf-8?B?WGF5bjhkR1hUOXhic25vcFhwVVNYNkJjS3pVbmxoYUlQNDJJcTJxWlRzaXFJ?=
 =?utf-8?Q?Q1gNivJEaR6r8EkSBzUw8ac=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75BFB31A80DE2840A7904911B8ECAD5E@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fbecb8e6-ed33-4a42-b001-08dce46d148c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 12:07:12.6701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xDm3JYvBsCmhX0DOcfnz0qGaqgiSAh8FUnf8XSaXmm+AhNA9rgkKikcXvrp+VS1PsYqJDg7yZ+ztPLYCucAhkUvh+YwLqvmChjoIviuLAgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7120

SGkgVmxhZGltaXIhDQoNCk9uIEZyaSwgMjAyNC0xMC0wNCBhdCAxNDo1NyArMDMwMCwgVmxhZGlt
aXIgT2x0ZWFuIHdyb3RlOg0KPiBPbiBGcmksIE9jdCAwNCwgMjAyNCBhdCAwMTozNjo1NFBNICsw
MjAwLCBBLiBTdmVyZGxpbiB3cm90ZToNCj4gPiBGcm9tOiBBbmF0b2xpaiBHdXN0c2NoaW4gPGFn
dXN0QGRlbnguZGU+DQo+ID4gDQo+ID4gQWNjZXNzaW5nIGRldmljZSByZWdpc3RlcnMgc2VlbXMg
dG8gYmUgbm90IHJlbGlhYmxlLCB0aGUgY2hpcA0KPiA+IHJldmlzaW9uIGlzIHNvbWV0aW1lcyBk
ZXRlY3RlZCB3cm9uZ2x5ICgwIGluc3RlYWQgb2YgZXhwZWN0ZWQgMSkuDQo+ID4gDQo+ID4gRW5z
dXJlIHRoYXQgdGhlIGNoaXAgcmVzZXQgaXMgcGVyZm9ybWVkIHZpYSByZXNldCBHUElPIGFuZCB0
aGVuDQo+ID4gd2FpdCBmb3IgJ0RldmljZSBSZWFkeScgc3RhdHVzIGluIEhXX0NGRyByZWdpc3Rl
ciBiZWZvcmUgZG9pbmcNCj4gPiBhbnkgcmVnaXN0ZXIgaW5pdGlhbGl6YXRpb25zLg0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IEFuYXRvbGlqIEd1c3RzY2hpbiA8YWd1c3RAZGVueC5kZT4NCj4g
PiBbYWxleDogcmV3b3JrZWQgdXNpbmcgcmVhZF9wb2xsX3RpbWVvdXQoKV0NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNv
bT4NCj4gPiAtLS0NCj4gDQo+IFJldmlld2VkLWJ5OiBWbGFkaW1pciBPbHRlYW4gPG9sdGVhbnZA
Z21haWwuY29tPg0KPiANCj4gSSBzZWUgeW91J3JlIG1pc3NpbmcgYSBGaXhlczogdGFnIChtZWFu
aW5nIGluIHRoaXMgY2FzZTogYmFja3BvcnQgZG93bg0KPiB0byBhbGwgc3RhYmxlIHRyZWUgY29u
dGFpbmluZyB0aGlzIGNvbW1pdCkuIEkgdGhpbmsgeW91IGNhbiBqdXN0IHBvc3QgaXQNCj4gYXMg
YSByZXBseSB0byB0aGlzIGVtYWlsLCB3aXRob3V0IHJlc2VuZGluZywgYW5kIGl0IHNob3VsZCBn
ZXQgcGlja2VkIHVwDQo+IGJ5IG1haW50YWluZXJzIHRocm91Z2ggdGhlIHNhbWUgbWVjaGFuaXNt
IGFzIFJldmlld2VkLWJ5OiB0YWdzLg0KDQpXZWxsLCB0aGUgb25seSBtZWFuaW5nZnVsIHdvdWxk
IGJlIHRoZSB2ZXJ5IGZpcnN0IGNvbW1pdCBmb3IgbGFuOTMwMzoNCg0KRml4ZXM6IGExMjkyNTk1
ZTAwNiAoIm5ldDogZHNhOiBhZGQgbmV3IERTQSBzd2l0Y2ggZHJpdmVyIGZvciB0aGUgU01TQy1M
QU45MzAzIikNCkNjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4NCg0KLS0gDQpBbGV4YW5kZXIg
U3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

