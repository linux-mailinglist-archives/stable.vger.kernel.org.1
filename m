Return-Path: <stable+bounces-208257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC84CD17CF5
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 10:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D7B8303A002
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 09:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208863876C1;
	Tue, 13 Jan 2026 09:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VJ4BWwye"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013029.outbound.protection.outlook.com [52.101.72.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2990138734F;
	Tue, 13 Jan 2026 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298027; cv=fail; b=IewvVqwtimPqDGv97fvTROl/ZPfC027dUPSS+7xR7BzVKkI8bHCkkV9w4BALs5n8hNFgGb7xYfSxQe04EYGuE660l3jKFbH9RKLjmPqFNay9wbqwpIkaIiimCGOcyKWEnbWssjlZoYTTdSY+CmdmxUzS9TPxg+R2/lCvmKoa1wM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298027; c=relaxed/simple;
	bh=sRTfQ63pQ3+0ubDFeQBHordauSXpGCvslSf0VeMEoGU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tHP6wrJDi0NE1fRAGVLu8stlgVjxFEVapeOc7XByxtOaZyzJS6XO1/Mo0HNlTN8S29c9sJg1WKXXUvHsLYGDWVfeZcFH9Q+GJs6Jv/+Mr4CFKGs8HYtlSlmChvE+izb7fqDxo9vLhVyMJOfvPAZEJHSNyk6nCIN1Z3+FvYHIigQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VJ4BWwye; arc=fail smtp.client-ip=52.101.72.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/ltmioU+ZO1wf71G8ED5dsGCZNz5Pb7Z394ERMLL+Qdn668Ob2uqFpBnIwA7bpDXk7HpQ/FRbSE4C35bSzXuvFIjNImQDDFXiS8td4o/EkHgyobuxLdFhZfeOinKDjDxjp14Z7a54YUH/cmiAFehCpd9aPDe6E9Fta0fuYqGSxEm43Tt6Vq2h2F0AFR2iLKDu2qwhRnSTehakrL0FbWuNxfa8BWUixw6RF356xzEcQ+3KnmaTtqeLIKBW/ESz4dl708EphEeh3xLAWEZ95zv8m+UstSvrNMCszPS2jUPtBxJ9iODyYZwS4eVfmPhxo0TASJRxon4vXKK3fNJmlLAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybR1OZei7XXHQJnp7CbZLKHP14IgoAKTgiCpORcffXc=;
 b=j6WzD5ECYwS9LtpLHa3O6r2GAIaO2q9XuMpvPbNIua97WnxyVbqiaynEOwSfkAAOZDAz0RZVTn/dbDpfgYl8qeHUuf8ltlE3IgPRMIVSd9eh8twsS3oa5wdNW4bx2yLBdcp0uFM2XFJ1f/MctNkVsSj+v+9yLsB4s6MKOjK89MIaV+lwljcMz3lIyXBGFNr3YU0eZymUXZJY7eytFzkL0XkfXEiDsnvuE73tLfq3RDb8SUkTfjme/bOcbfaZt1X++sdwwpxXyCiWwGRmd007Ki1SdhFOGElUn+HgEYou0GeuxdrxqAqAXxChH4mg1Oj3rMglxPiEpk221vS8ZIgPHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybR1OZei7XXHQJnp7CbZLKHP14IgoAKTgiCpORcffXc=;
 b=VJ4BWwyeauT3B7gSFKxEI/Nlo3Te78W1nBlsCWTEbtPE5U8Uk9XcfxmPRpe7wlMMrpZlPOXdq1oh84SECnhUVT4SxHCfPwHhHZH18bhI/YI1iHNvThV9MsFWW1FkNuk/P2CjI1hCsL6qGpfBrMb/Y9+6/7368cSR2yN0SU3jx9+F9/kQBredB03vGn9NpA5K9g1JBFO7jNqoKNl8FAIn0O8FurY+388TRyEua1DgzZwcB4iO9EQrF9j3BX3aXimP27/zsFigDYpqfysmewuSSJOkEecjkyoLWDRtSSddEkG0X4MxISQn0nFekxsMYgSzGY3Po60PGtP5U2wSTCNZvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB7798.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 09:53:41 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%5]) with mapi id 15.20.9478.004; Tue, 13 Jan 2026
 09:53:41 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Date: Tue, 13 Jan 2026 17:53:07 +0800
Subject: [PATCH v2 1/4] usb: gadget: uvc: fix req_payload_size calculation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-uvc-gadget-fix-patch-v2-1-62950ef5bcb5@nxp.com>
References: <20260113-uvc-gadget-fix-patch-v2-0-62950ef5bcb5@nxp.com>
In-Reply-To: <20260113-uvc-gadget-fix-patch-v2-0-62950ef5bcb5@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: jun.li@nxp.com, imx@lists.linux.dev, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Xu Yang <xu.yang_2@nxp.com>, 
 stable@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768298011; l=4599;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=sRTfQ63pQ3+0ubDFeQBHordauSXpGCvslSf0VeMEoGU=;
 b=8EOr17v6vT3vM+aNjgVwblz6DhOPhPCNnDiueXWfYERpW74fUjQVv53cmU4+/K734Tmq/5Mjk
 fS7QniD8JZFDhx2tncm7Xczh+PoSdG72zpSNhxSnbwrmyOrF0w7xZr1
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: ace396ae-f549-4d9c-aaeb-08de5289a1ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wm1JY2s2RHdxMEl5SGZpY2VFRmczYVV2TjZ4T2dleDZyYnpLS0I1TVlUejEv?=
 =?utf-8?B?NFk1emVndGJBTGRjN0tFNjdrOFRDRzBTdStKK0w4elJJMVpTNXUwRnpsam5G?=
 =?utf-8?B?Z1Q1Z3U2aXh2NjJpTGZ6SVRkNFpFRjM4c1RYdk8rc09Sb2VxOGpxZWdLNDZN?=
 =?utf-8?B?Q0Z1cmtUaG9ZN2w0dlBYRW9DMXJYMlZSY3hEbzNHb0VKNDh4UTBFeE1tMnNQ?=
 =?utf-8?B?ZzhRaXNyTC9LYUpENTZsaXpKL2dHc3AvMklXUjhYRUhNNm5MVDRXMi82dEIv?=
 =?utf-8?B?azhTNUhDaFU1M1F1eHl1ck1ZNkhBRDd1a0YzL0dUbU9zSzJkUHV1WkNtQ3dF?=
 =?utf-8?B?dTFwVXU5bEJGWTQ1VHpmdUhMeHdVaTNQWGhWakdOL2VtUUh1OUdzeUdGS3Vs?=
 =?utf-8?B?YkN1ejJVVHNnUldZUjVhamdyaWI0Zk5zcHBnVmRueFp0Y3JhYnlWVzhpcnJR?=
 =?utf-8?B?S2hlaXZ5b3JEK3RhK0NQV1V1NWJ4YUpFelZXaDdxY1pBa3F2VzZLODM0ZmYz?=
 =?utf-8?B?dXdnZlp2VUE2REFKdnZMZCtsV1VGeERra0htNWFkTEp1QmJISmZIbWNJSGxF?=
 =?utf-8?B?RWdKQTZ3anNOSE5RZTlJSGR3a1p0S20walc0b3RJbVB4TTlSVGxyMG5QV2NL?=
 =?utf-8?B?SVIyWk1IOGk2dU8yeXFCUndYL2tWOHNDRXlxYjk5TUEvc3VrVS9UOEZrL0Zy?=
 =?utf-8?B?cTVMZ1NrT0ROdGk4N0h6SThHeTdyZTJEZTlqMkJ6VGdVam94RmxoZkg2QXMx?=
 =?utf-8?B?a1ZQMzRrMC8yQzZLVmE0Z3RiaU9hV2JXbkRNcTFsRlR2ei9tTytBbjBiSUVm?=
 =?utf-8?B?aWkzK1RkeGVxSWttMDhDY1pkZCswOFM4dDEwZUNMYmFWTUNUWk5DOTZhSDZT?=
 =?utf-8?B?bTJDekFDc1d2MUJGUy9FdWJXaXpLOUNQZUo4ajJkNUdpR1VwVEUxa3REQmw4?=
 =?utf-8?B?MjNFT2syYS9OMUhvdTFLTkxwOU9nbVg3M3FsRndLZW1BSENpTFBjNFVyM0xy?=
 =?utf-8?B?WXBYc0VFZXpWS3JCdUZueWlWRGNDcUU5VmoyQi9rT244MjJaWHlOUWdabGlh?=
 =?utf-8?B?MS9aQXZXdzZ4R0tpT0YwdzY5MVdFcmEycjQ0TkZrZXc1SmhRVWgxcXFwT0Ji?=
 =?utf-8?B?a2dRMDFCQkVMWlMvSmtUMW1QVEV1Ky9FVGtPR3c2MVZpSWhyYzkyZzVpaWxq?=
 =?utf-8?B?UUNuM0ZsdzBvVlNDZ0tLRnBaVkJQUGJQMk9sVHBDTzNpaUgrZGdNQXE0SUNI?=
 =?utf-8?B?ajYvZUIrWk1pNFBIb3ZxYnlsOTdLK0ZNK2F5dGtYMW5WZFI0TDNxdGZQQ3lZ?=
 =?utf-8?B?TEQ4RXk1UGV6RDRNcm5GYlBaYnkxWXhjNzloSFVidlBhdUE5aDZpdnRHYTBI?=
 =?utf-8?B?TDMxRzZ6QW5TQlFoWVRkYThmM0RzdmVia1FXUlA1eUp4RWNWZU5Pd3RiWWZP?=
 =?utf-8?B?MVhDRzg1MjNtYkxNYkNjaS9IcG53WVY5UEhLMG5HNUtJZEF5TFlHSlJQZjY4?=
 =?utf-8?B?M3BNZEQ2eTNybjNWRjhjUFdwTU1kaEt4L041VWN5UzdaWFVSWGExSHBNMy91?=
 =?utf-8?B?aVVUVUFkOERNVzd2RnVwSzgxbDNvMElpRkdHZ3dTdHE0YUVpTGVpWUpCR2Zx?=
 =?utf-8?B?VzBIaWxXcUtoZkVTUmYrWGNrTi9tZTNBRnh2MTVKWHdxVDZnN28yZFdwTWov?=
 =?utf-8?B?b0YyNHFWNHM0cmdCelF1ZGNQM0ZZQlZJSzFwc2VxbzJNR0FRcHRBRWlEd1dS?=
 =?utf-8?B?VEh6Q1BhWjRzbTlVWW5rZnRUVnhiWnhsb2VGanR4VzVGZzlVcWV4VXFlR20y?=
 =?utf-8?B?VUYzc0UxTi95NDVJQkdNNXhhaXhTSVlPT1FOMTFDRUxTU3VaS01kc1lJYldB?=
 =?utf-8?B?R2tDdUR6RHpkV3QzU2pRWDBtZGFWeTMwTWFDQVhYc3BRZUdOMDZFRFNGYWJE?=
 =?utf-8?B?eHJwcmpReXA4dS9lRnd3Rk1yNzMwZ2VQUHRDcDlSRVhIc0lHQXNjekJGYUhY?=
 =?utf-8?B?UU10OGpseUNQNXE1dlpjczBrRmFBYTd6UnMvK0hDdDArSXcrNEVQVWRZZnRr?=
 =?utf-8?Q?F8amzx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHNxM1MrZXhobW43cTg0WEhCdUUzOUZ1cGlQZ2o2MUlob2JUVm5VWjdKdXJL?=
 =?utf-8?B?VTZuNTVOL0p1WklGSCtzcWV3SGRTKy93OEM3YzRTa3AvVU5DUVVFVHpGaHZp?=
 =?utf-8?B?Z1Jvb0xJd3M1dU1uNTFMRWhWM1l1a2xBd1o0U2RrUFdoQWF2Ly9XNE40RUhv?=
 =?utf-8?B?a1pTaHJySFhpWVdXMGF2bzVGL0FCc20rbjU5Yk5TMC9vYUh6RHlSRTl2c0Qz?=
 =?utf-8?B?c1RINmJ0TncrRGRHdGlkY2tyd21UeXQ5Z0VZMXdOSWREeGNOWHRGbkVtd2sw?=
 =?utf-8?B?UWNpbUtBMkhlcnZIMGRzVE1YUk44RTJTSXNhZEJ0eVdnTkRMdER0aWUwcFdx?=
 =?utf-8?B?RWlZMWpOUkhheWxWMnlqazJvUmRldDVxTFlJWmR5Q2tuTnhaTlBqblpodTVs?=
 =?utf-8?B?YWlyM1lya0lEY2JUWVN2MTdEaStiUGpmbngzRGtLd2tpWmJ2Y0d3QkFpNDhn?=
 =?utf-8?B?bFdBMUJhODFBNHlFd2JGcmdSdGVEUVdXT1Y1TXNsU1U0Szg0di96SVBObjNz?=
 =?utf-8?B?ME8zc0ZmMVZMZFhFWUhHRi83cTBzVEpmRVZ3T3F0L3dpSktUZFZPMWdBaWlO?=
 =?utf-8?B?MVlEQWYzTmdBQldXamNWR0RxejFycmhiWG1neCt5Z0dnSGg0RWxuOVJMenBr?=
 =?utf-8?B?ZlF5VDJwRGJUVE8yekV6WlZ0bUdWQXRKOE40MnNIL054WDMra2xoY0p0ajlr?=
 =?utf-8?B?SkpNMEN4ZGVwZ2hURFlMTGQvZDRqaFdJZVpTbmJhcTFvRWhVSzlPaWMwYlBa?=
 =?utf-8?B?Q0RCOHFjaFl6NDNtVTk2RmQ1RTNzd2tmMERNcWRBV3Fsek5vL0h1MUIxd0sw?=
 =?utf-8?B?Y3g4UG84V2xjUWFaR085b1FSM0JtUkJXNXYvK2MzT21zMGRSSHZaYmVjZkNy?=
 =?utf-8?B?MTFkbE5aVUcvRHZTd0JQSzZ2QklieGYzbUQyeWFNbU1aUFhocVdxdS9GQWxG?=
 =?utf-8?B?YjBkR0I1dTB1K1hPQ3NIdDlGVHdYZWpDUnFjVTdrZStwbXlKai9lUzk4SGVX?=
 =?utf-8?B?eFZicm9zTmw3bW5MMFY4bHVCNFQxUVVqa1pBS2t5QmtMMWkycEgxSGpRL3FV?=
 =?utf-8?B?YlNrdWcvRG1ra3lSdDBVWmJoR2JnVitRSi9zb2JwL2lzWjgxOHNQallEZlE1?=
 =?utf-8?B?NE1ualpncjgyNmdqdU9NRnJWTFhUS2svbVdmWmZScU9Pb1I3Q0pmUGh1TEN6?=
 =?utf-8?B?RFg5ZFc5Q3JmS20rQ0gxaS9TZHlzYjZ0SzZHUVRXeUpDakJIeFVCUE0vTmJi?=
 =?utf-8?B?SzJtNktZaE9vNGQvd1VMS0krQVpuOWJlRERVTTRMdWZGSlpyMnF0cjh6N3lp?=
 =?utf-8?B?eHdGZ2Zsc3BpQWdMSlVUVjhXdHQvWm4zdC81bTQzQ2lIU3YyVGIzWWVXYXRI?=
 =?utf-8?B?ejdKRThrZzBqbWduc1VXalp3YjVpOEJ0OXBJY0IyTTJIT1BGNnpmcEwxY2pr?=
 =?utf-8?B?a0FKMi9VN2NXT1E5VWUrRHZLbkVyNlVxN3pZb29TZHA3TWNKcEp3c3B4Q3Za?=
 =?utf-8?B?Y1FidDE3TzV4Skc1V2VqN3ZoRXlsdlNyR1M2SS8rUThCbHdxWEpkMVJqWk1M?=
 =?utf-8?B?YzJMRXk3S0dBZEFKT1hvck0yRDJMWTBYNGFSV3JXamdBSDUvMFFacDM4c2t3?=
 =?utf-8?B?dkp4N0ZnY2NoZzRmbGJieDNOVGZncGZHaFZQbUlraDVlMmNVbGFtdUMvQWJG?=
 =?utf-8?B?aTdDT3N0djRnZDErZjRKRWUwZUMvT1ZodXlaVjExd09QZmhCM1drOEZBQllK?=
 =?utf-8?B?d0FwZmtyRTJSVTBENmV2TkZPMDdnRmFvTWx3UGxJM2t4S3ViOVhSK3o5MS9v?=
 =?utf-8?B?ZkhSVEdXd2szRzBtZ0FXY0RLUE4yOEJBRnplNGhnWFdEajBHN01mQmlkUmcw?=
 =?utf-8?B?akJNSkRvOUZmZGg3Q3F5Q2k1d0hvVmtFRmN1NjMrQm5DLzVQSW5XbmFhUVdG?=
 =?utf-8?B?M2ZmMHVIRTJwZUVJcWlJWGxjSElqR1JsQkIvYnpoSy8xWC9DNlZZNVRhT3FK?=
 =?utf-8?B?aE5aenRNRk0rMXc2TlJWWitSU3pnL3kvU0x2M1BoMVRZUFJVcWY2SWV4VDAy?=
 =?utf-8?B?endQbFRrcjczajFVTDcxZnNwYU5ycUtGY1c1UDdEdDBqYzgxVkZnUWtQd0Vk?=
 =?utf-8?B?a2syVW0rN2hUaEU2ZFlUaEVySVQyZnRDVVhUSmZIZ25pc1ZwazJIMlVibTRs?=
 =?utf-8?B?QWtHeHBlL2svV3RCRC91elVUU1BSM2k0Y0NHZmFGeS84UkJHS0JvRmNvVU82?=
 =?utf-8?B?WkpzTU5KV3pBUlFPNkFIc1pZR1JDOGMySWRiQWxGeDNHNVQ0cStKQk9BZklv?=
 =?utf-8?B?anYxRFpjemo2VEt6Myt5Ui9jNVhWZXM0TWhpSUJmTVpVZm1NZmNndz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace396ae-f549-4d9c-aaeb-08de5289a1ac
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 09:53:41.0466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: so6iuO29JeUxgmBOAI+3aMW1AtPT+Yd8s9R+RCvrtLdjS5wWXDB3Njcwc5OIBwPR1mShJdJAykqPdC413CP22A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7798

Current req_payload_size calculation has 2 issue:

(1) When the first time calculate req_payload_size for all the buffers,
    reqs_per_frame = 0 will be the divisor of DIV_ROUND_UP(). So
    the result is undefined.
    This happens because VIDIOC_STREAMON is always executed after
    VIDIOC_QBUF. So video->reqs_per_frame will be 0 until VIDIOC_STREAMON
    is run.

(2) The buf->req_payload_size may be bigger than max_req_size.

    Take YUYV pixel format as example:
    If bInterval = 1, video->interval = 666666, high-speed:
    video->reqs_per_frame = 666666 / 1250 = 534
     720p: buf->req_payload_size = 1843200 / 534 = 3452
    1080p: buf->req_payload_size = 4147200 / 534 = 7766

    Based on such req_payload_size, the controller can't run normally.

To fix above issue, assign max_req_size to buf->req_payload_size when
video->reqs_per_frame = 0. And limit buf->req_payload_size to
video->req_size if it's large than video->req_size. Since max_req_size
is used at many place, add it to struct uvc_video and set the value once
endpoint is enabled.

Fixes: 98ad03291560 ("usb: gadget: uvc: set req_length based on payload by nreqs instead of req_size")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
Changes in v2:
 - add R-b tag
---
 drivers/usb/gadget/function/f_uvc.c     |  4 ++++
 drivers/usb/gadget/function/uvc.h       |  1 +
 drivers/usb/gadget/function/uvc_queue.c | 15 +++++++++++----
 drivers/usb/gadget/function/uvc_video.c |  4 +---
 4 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index aa6ab666741a9518690995ccdc04e742b4359a0e..a96476507d2fdf4eb0817f3aac09b7ee08df593a 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -362,6 +362,10 @@ uvc_function_set_alt(struct usb_function *f, unsigned interface, unsigned alt)
 			return ret;
 		usb_ep_enable(uvc->video.ep);
 
+		uvc->video.max_req_size = uvc->video.ep->maxpacket
+			* max_t(unsigned int, uvc->video.ep->maxburst, 1)
+			* (uvc->video.ep->mult);
+
 		memset(&v4l2_event, 0, sizeof(v4l2_event));
 		v4l2_event.type = UVC_EVENT_STREAMON;
 		v4l2_event_queue(&uvc->vdev, &v4l2_event);
diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index 9e79cbe50715791a7f7ddd3bc20e9a28d221db61..b3f88670bff801a43d084646974602e5995bb192 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -117,6 +117,7 @@ struct uvc_video {
 	/* Requests */
 	bool is_enabled; /* tracks whether video stream is enabled */
 	unsigned int req_size;
+	unsigned int max_req_size;
 	struct list_head ureqs; /* all uvc_requests allocated by uvc_video */
 
 	/* USB requests that the video pump thread can encode into */
diff --git a/drivers/usb/gadget/function/uvc_queue.c b/drivers/usb/gadget/function/uvc_queue.c
index 9a1bbd79ff5af945bdd5dcf0c1cb1b6dbdc12a9c..21d80322cb6148ed87eb77f453a1f1644e4923ae 100644
--- a/drivers/usb/gadget/function/uvc_queue.c
+++ b/drivers/usb/gadget/function/uvc_queue.c
@@ -86,10 +86,17 @@ static int uvc_buffer_prepare(struct vb2_buffer *vb)
 		buf->bytesused = 0;
 	} else {
 		buf->bytesused = vb2_get_plane_payload(vb, 0);
-		buf->req_payload_size =
-			  DIV_ROUND_UP(buf->bytesused +
-				       (video->reqs_per_frame * UVCG_REQUEST_HEADER_LEN),
-				       video->reqs_per_frame);
+
+		if (video->reqs_per_frame != 0)	{
+			buf->req_payload_size =
+				DIV_ROUND_UP(buf->bytesused +
+					(video->reqs_per_frame * UVCG_REQUEST_HEADER_LEN),
+					video->reqs_per_frame);
+			if (buf->req_payload_size > video->req_size)
+				buf->req_payload_size = video->req_size;
+		} else {
+			buf->req_payload_size = video->max_req_size;
+		}
 	}
 
 	return 0;
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index fb77b0b21790178751d36a23f07d5b1efff5c25f..1c0672f707e4e5f29c937a1868f0400aad62e5cb 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -503,9 +503,7 @@ uvc_video_prep_requests(struct uvc_video *video)
 	unsigned int max_req_size, req_size, header_size;
 	unsigned int nreq;
 
-	max_req_size = video->ep->maxpacket
-		 * max_t(unsigned int, video->ep->maxburst, 1)
-		 * (video->ep->mult);
+	max_req_size = video->max_req_size;
 
 	if (!usb_endpoint_xfer_isoc(video->ep->desc)) {
 		video->req_size = max_req_size;

-- 
2.34.1


