Return-Path: <stable+bounces-120264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA57A4E5F1
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83B4716A493
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 16:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A78527816E;
	Tue,  4 Mar 2025 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HVpcYY1n"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E686278142;
	Tue,  4 Mar 2025 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104406; cv=fail; b=d85eWVN/3lasEDptm6vWTCEQ1iKCaRgws2bpekot+5Xk1I8x9aGj2RQJf1eZVoxwbDbklLRxzHFvS9UpfO2FR+QIFs/oJgDF3l3k8BtWUJyBcKRbTHOZqCQymE2Pc5/t1DB03MYnpLCxJB2TcJ33qryBaTSSeRkexyoRZ6DLmhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104406; c=relaxed/simple;
	bh=Gq/jzah0vEn5AaoYxztVD+4nJo6Uk6ZUtzD3te8b5wI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WIJPr4ZYnQ4xcJuQIpFYE9iCiRb+2shywtHgg1jHns4xoOt5Ei1oOS6U1teXf/VpE/xY8W5ITvc9Eq1fuSKZd+QP1wUqRTwPjpOv6jTpVadCfOH6dboFIO9dc/l9xSu5d0JRlFvEj4RhkB/xdARv5C1m6Ax2bzCp+4qfDmz7M5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HVpcYY1n; arc=fail smtp.client-ip=40.107.21.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ph5439gCsPGGULDDJOZtguRpeygrJR9xO33wq6AkWIMoNtjFtP7QauKzoJqBTxqen6bm7ALktRNWQDAuT7PdVqKgANWLn5ajkwiSvLsUozATGoN0ZtQ4ki/YI2v/np7b0Awy6gcZFkskC7YAcnKw6Ushgbt9mC4qqWfZdCvqWUa6DbkwRsgkLPUTttc6Q0JNHOdPnxt4IXDIXl4b7CqVIbYQ+3OY04K37fgvy3GSRSWEs1tbnwGMI/t5g7yvVVFS8qN81tHs+54Rg66wSC6+paU6eLeqzcab9scZJuGbZIMEAxBCky4OvRhK1Q2US7kvilUTShbrR9FlLsEHfSztDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JSG1Gr7hJBuQyCMBRcFjJXiEuLP8ilp1foJQdLgOas=;
 b=eg+8tL8r9F09rv92n/SW1bQfqXyrJjHJtPTzHJywPdh8g0cpUZ47S+aZDi4D/uGCcUn56pz87GA9aJE7tb7xYMDLD/o8EymFPhMjtWuG3lSWhtte1C1clyo2MqWHGt6MqTAYXECPCUWfqlpBq1FTZNzAXqSY0Lf8woF/Dna5RPOZUmt2Y6irUM1yx5Pzfrj6eGfBI7wLvNFTySAZH4OeEoXEcWIdIC7yfcO/VeTipblSxr6BSd95aOoTH1kTBwDOJiVS6fcjEtDXOoW5LY1Gb3i3SDQm9tlXfECsKTcviu5hjlOiBFRbpJRwC2KInTBZKEPjqouYILNfxnVxIWK+tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JSG1Gr7hJBuQyCMBRcFjJXiEuLP8ilp1foJQdLgOas=;
 b=HVpcYY1nkOwojjpeDDfnJrovynldtM+E4J1+rJZqpUDSL5px91ZOnNLRvyiUBlburS1GN7hVo9gcw9yUoigY/nhoqBNWkags0gtzNlCBwqCmzmP6V38CtPxnj+n8Nuk8qIqox+GDwtdYcjSlw/L03gGJhhYOlxGxl32VSwLFJTbXnJVqxVXgoXjW98YtXonSlfhFvX3vxDkHD0Vru78hE2qYb4LvSGbdiMhO1T4okyCVbxD73J0sxjsHIsyVAh7bBG+NOYMsLFS/yeMkcUq1PIPsEddIeK26YJKnC94GH6P0laazWXa79ryyJyu0RHOXHtFx9MX4NR+r3A/BNA9rGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::22)
 by GVXPR04MB10304.eurprd04.prod.outlook.com (2603:10a6:150:1e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 16:06:41 +0000
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a]) by AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 16:06:40 +0000
From: Andrei Botila <andrei.botila@oss.nxp.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] net: phy: nxp-c45-tja11xx: add TJA112X PHY configuration errata
Date: Tue,  4 Mar 2025 18:06:13 +0200
Message-ID: <20250304160619.181046-2-andrei.botila@oss.nxp.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304160619.181046-1-andrei.botila@oss.nxp.com>
References: <20250304160619.181046-1-andrei.botila@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0151.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::18) To AS8PR04MB8216.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8216:EE_|GVXPR04MB10304:EE_
X-MS-Office365-Filtering-Correlation-Id: a83dfdbd-eacc-40ab-9b78-08dd5b368cfa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGNCeDFPZjd6ZVZHYWJHdjVzNWRHVDl0YXlwOVNBTVB2NjhpTDJDRU9xZXFq?=
 =?utf-8?B?UDViTVBHeW81eUsyaC95blZNYTlabWFBUFRmOGo4VHYxclhvQjEwMUxJZEV6?=
 =?utf-8?B?TjFYZm9mdk1Sb1o0TkhBV3VzMUpvdnZ6SzlKbXhsdE11MlkwV2tRZ090aGRM?=
 =?utf-8?B?VWU2azlmMmJudERNT3dZUW5OSGlDMlVoaXVDczFOZHpnOEtSSDZ0VHRhY25v?=
 =?utf-8?B?Ty9LUnlZK2RuSy9PTGJBZzVmYmZRcWpNNlQ2OUljRlkzOWVqWGpLemNPNm9k?=
 =?utf-8?B?R3l0UnRtSEM2SThTOE91UlU2QXU0aHNvVk9aL1dZdDN1RGcvWjFnR0tEZGFp?=
 =?utf-8?B?TWxBRXV5cVVDcWlDZ2JNemxKUWpWRzhsbXM3STk1WEVNZVZKWE5DejBhYllR?=
 =?utf-8?B?bWVMVW9XTHlDMndvd2wwUWlkVEtOMklEQkgvWDNnZk1zcWFMRlY0RFQ1L3lK?=
 =?utf-8?B?Vkt6aDhINkI1QS9IbVZPeDdMUlJQLzRXMGZ6SEl2M1pOcjB5Ti9jYm1KdkVI?=
 =?utf-8?B?S2RORmlRbkVLc0I2bTE4dUF4NFZqRkZmL0UxTUdCRTFNT1MwQ1JaeXI5YmNo?=
 =?utf-8?B?NE5QUWtaNHJvMGJGL05jdDR0N3FvcmpZYVBFSlBscW14NTZ0eWthQk1uRTF3?=
 =?utf-8?B?dWNSUm5XSXdHaGNnY004VnBERVROTXh1aTlVeEE4bGNIdm16bTN6NEYwTUlz?=
 =?utf-8?B?WWpBVDU3ZEpvNW51aDI5ZHczcThhL0hOZUhKdENKblBMMTA5TEtDNGtPbzNC?=
 =?utf-8?B?cW1PaVJiMlZ2TE5laWhlVmxJa0w1aENHeUtZTUxqUE1oVmpIM1h6RnpybjdG?=
 =?utf-8?B?Q0VKRytjeCs1c2UrcVd4WGNEdUNEckZPU2xINERzUUNSZXpucFpQSjFhRzhq?=
 =?utf-8?B?RWt0bElCVzFQRjg5YjRyK0xTQ3pMek9XZm5GU0tqV054YXJPYjhIM1FqeXhi?=
 =?utf-8?B?OUc2Y2xWazVsalIxYUkrWFJmRDhmUENycW1BTzRnMVJ5cHY5RWxPYXNVT213?=
 =?utf-8?B?dk82UjEwNkZ3ekFEVlBCcjd0dVdlTUpYUnFWOW1HSUo4MmRvc3hMWHBrN3Za?=
 =?utf-8?B?bmU1bkoyaHpYUnZ1WWtHWGZmTnBwemFXNWVkOVpqZ3E3Y3Vjc3NzRTBTbXdS?=
 =?utf-8?B?eFZ3M1U4a3RUZXlKNHhEaGRVWE1vcE1BWTE1QXNlQmF4Y2FNNm9uUm40NWJw?=
 =?utf-8?B?RTFIb2h4cHo3Z1B3OW8wdVNRK2t1eVJuK2RranZLUmxxRnVyekRXYmV3SlJq?=
 =?utf-8?B?Q3NHYUdoK0NmdkV2dmRxZnl4aTg2TVdMTE9pUE13bkVybFk4Y29help3S3B3?=
 =?utf-8?B?Z1JSeUc0MDdqVlE5VFpRNktEajBFWUFUK0NtQi93akFGZGY0WmpqUUE5cXhj?=
 =?utf-8?B?YjJ2TFdkSkNiL2NNVUJkbnM1VFdCcUUxMFdSVjNaMkJ2NDhmY3FyYkpHaUZx?=
 =?utf-8?B?ZUxvczVzMlR1dVRobzRwNXZMT2N4RVF6MDlTN1BaVUVwTVpwbTAzdDRnR1di?=
 =?utf-8?B?QU5MVnpZd1JmbUFGVnZOTXpNZUVZOXBDTm5wNUV5YUZuWXZTd2hVc2xrQ2Jj?=
 =?utf-8?B?Z3Q4Qm5OTnk2azBkcytqcGNSUHIvcjErbmk0RlRnMk91WDZpdDJSR1B5RlND?=
 =?utf-8?B?bC9hZ1ViUENzeEUzWEl6TmI5RSt0bmJBVC9EbFhldERKZi9QbU9SU3JieWxh?=
 =?utf-8?B?aUtXRHB3TlViTlQ5SXllcUo1RldnTEZVTHRPd2pFSG1YRitYUk9mRWFObzFz?=
 =?utf-8?B?R2YwbW5OTG1lWmhzYWl3Tk9CNjNrWmhSbyt1bFluc3pLQlhMRFFTb0srV0Nt?=
 =?utf-8?B?MWJIRk5LS3REdkFvY2dOa0hqSE1BMk1YemhEUUUrbWtTbFFFWVdKWHBJRjBx?=
 =?utf-8?Q?TQnRu4SerD5z+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rm42RjJ5QUVEeUtYdXFLSHp2bEpYRDVQU0dWQkgrbThWSHNndEc2dTk3WXBt?=
 =?utf-8?B?Rm5CRlkwY2hYNks5T1p6cHBXMWNVNllrZlM1MFBGWlRJWE05UmppZzFCSEts?=
 =?utf-8?B?VGs3NUVIaWNrZG9LK0RsRko5Tk10S0NGaVhCZ2k3eDgwckJJdU9OUUNXaGsv?=
 =?utf-8?B?QUlVRmxxbUxSVWJlN2JidFF3N2xMQ08yRzVLM09KKzFzR1hlQTJYSDQvQTN2?=
 =?utf-8?B?blZuMTJaOFhwaEZqODlsY3hkM2VOMzcvbTVja0xxemhwQTVBWmFaTExHM1Iz?=
 =?utf-8?B?NXZDWitUZXJ6SjArU1d3NlV4NFJQUkc0MnlHSDlEMVQ4Z3lHdnhvNzJxYWhv?=
 =?utf-8?B?akt3bllnaFhOVmRxeFg1YkVISC9ZaEd5a1Avei90MGozV200WDFtUWpWcWJk?=
 =?utf-8?B?cTE4ODBVSlRTTU8zemtUb2xmRDd4NDlKQW1jclhyTVRyUStpOG9mdGp5bHA4?=
 =?utf-8?B?bmQ1UGlaalZxVmFFVHBBek9pa3pzSWNNMGFrMEYvajlLaXZOclVQM1ViNTVz?=
 =?utf-8?B?Ylh1MWp2QU44THdQUG1YL21wamZFenhUaWlWYTk1d1k3SklPZ3lJRERacDNt?=
 =?utf-8?B?akFab2xXQ2xyQzJ6b3g4N0JCbDJkdUtYT3dUaDB3OE5XTFd1cE1ML1RwUVQ4?=
 =?utf-8?B?Q293SjNQWmdjbFJ1Z3UyMEZDbzVZN25lQkVVN3hlNnNCbmNuQ0sxdlJVRjFV?=
 =?utf-8?B?bUdXVC8rRGEyRDg5QmdtWGY5RmpUb090eGdWaS9BenQ1TmQ4aWsrMUxnYkVo?=
 =?utf-8?B?WHRUSi81V2dnaFJ0c0VzMldLY0JwRVNDK1llQUtVZkhIUjFBSFU1UGJpRDBa?=
 =?utf-8?B?WWZxT1MzeUk3UmhlazJTUGdRdC9hL2tQMjdUazFvOGNGZEp4S3RBZjB1U0pO?=
 =?utf-8?B?NkVNNWlCSFBNcFpyOEQxRE1wVWpHZkdwVVB4b1phdTk2RFpxVUdSY2pXZklh?=
 =?utf-8?B?eVNhMzR1Q25ncTlScnhHZWhSRkl0elVRaTRUNk5RR0ZUbjVTdjAwWmljTUFO?=
 =?utf-8?B?NWVINWhGVTFjQllFM1Z0K3RZWEhSUnZhUmc4aVVXQ251RnYrUHA1SFhWMW1y?=
 =?utf-8?B?NzFndTVTSVcwSitKbzEwUnlkZ1dpNzRRclFwU0tFZXdwZGNTdlRGNExpdHZh?=
 =?utf-8?B?YWRHNlRTM2ZPaEJIVFNDUVVvYmN6eWFUazhpQ085Tlh6UWRQU0FKem8rd0pu?=
 =?utf-8?B?WjhYaEIxR2ZSbmdib0huRDN1T3hYcVVPSktaVUV4dlNBbmlvT29YMzFLYWpl?=
 =?utf-8?B?b0p4eUErVnBVLzBYVXQzbHBwOGsyQ252bnBIUE9rb1pLZzhEZTBsOHhyamU4?=
 =?utf-8?B?WDkzaG5HNFdwSmdCS3hxUGpIbldrZlpXQzlFTWVVK0t2ZThVTjVtQUpzemgw?=
 =?utf-8?B?MnBuNWF2NFdMdnJOL2g5VzJoQnFMRlNWK2xab1NEL25QdzNlb1YwUjdqMW1h?=
 =?utf-8?B?R1RkODg4VWJBR0dzdkp1TTIvVE1tV2JDK1p4NlRUV1UxQUNqdnVYdHROZEps?=
 =?utf-8?B?b2FreDdnQlJBSFpobXJ6NEhRdlhwWlhmdTU2YWovay9HK1o3REhoMzRmUnBL?=
 =?utf-8?B?NE1aUG5QRFlpQUtsSWFwUUtpbS9rTnlwSTNiY0Zwb3NnWFNuSlNrWE1lYnM0?=
 =?utf-8?B?QVJnTi9EeWM2ZWh4SFFFYzJYby84Rjh5aWpjdTJNckYwaThkVHluZlk5ZFds?=
 =?utf-8?B?VERPaWppbHlxQ1FxZVRHYnpxenFQYU4za2N6U0xDSG9UeE95c3J6OUhwQlMz?=
 =?utf-8?B?VHlJT01zeW0yZWdsVk5ZcHpVb1IzNjlIUHpQdERtTng3bzZmL0RSdndqdjho?=
 =?utf-8?B?cnBUOUlWdXgrY05Ld1gremRTQmhDVGlrSzBDSDV6dWx0ZlJvemwrNEk1TjY5?=
 =?utf-8?B?T2V1N3FKcFNjTlZITmdUU2VUS0Y3VDBReTcvalJhYlB5RXNnQkNOSk5EWU96?=
 =?utf-8?B?T2lrYWJvRnZSalVmVjY0ZzAyT1BxR2VNRDVNN0o2ckZ2bWM3aE5RcmN5djdW?=
 =?utf-8?B?ZUtpMmxKUTNBNlBIOVNFZXFTWjcvSnpGeGV0N2pqbUNaa3Ura1pUbnBrK01a?=
 =?utf-8?B?NzhaNmdoYkxBU05PZC9QYjF1SThnMVJ3VlFpL3BlT3YzSEtuNDQvcXQ2Q3JE?=
 =?utf-8?Q?iTdNbOEqAGHRX/DxY2FQOiJ0Z?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a83dfdbd-eacc-40ab-9b78-08dd5b368cfa
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:06:40.9422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nn2H38Qupykv80YBezpnmofwTHSvRyecqsnRqMOJVui89CEr9Y+If6R6BBBZyav95GxV7vUCsXfBdq87YTgdjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10304

The most recent sillicon versions of TJA1120 and TJA1121 can achieve
full silicon performance by putting the PHY in managed mode.

It is necessary to apply these PHY writes before link gets established.
Application of this fix is required after restart of device and wakeup
from sleep.

Cc: stable@vger.kernel.org
Fixes: f1fe5dff2b8a ("net: phy: nxp-c45-tja11xx: add TJA1120 support")
Signed-off-by: Andrei Botila <andrei.botila@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 52 +++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 34231b5b9175..709d6c9f7cba 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -22,6 +22,11 @@
 #define PHY_ID_TJA_1103			0x001BB010
 #define PHY_ID_TJA_1120			0x001BB031
 
+#define VEND1_DEVICE_ID3		0x0004
+#define TJA1120_DEV_ID3_SILICON_VERSION	GENMASK(15, 12)
+#define TJA1120_DEV_ID3_SAMPLE_TYPE	GENMASK(11, 8)
+#define DEVICE_ID3_SAMPLE_TYPE_R	0x9
+
 #define VEND1_DEVICE_CONTROL		0x0040
 #define DEVICE_CONTROL_RESET		BIT(15)
 #define DEVICE_CONTROL_CONFIG_GLOBAL_EN	BIT(14)
@@ -1593,6 +1598,50 @@ static int nxp_c45_set_phy_mode(struct phy_device *phydev)
 	return 0;
 }
 
+/* Errata: ES_TJA1120 and ES_TJA1121 Rev. 1.0 — 28 November 2024 Section 3.1 */
+static void nxp_c45_tja1120_errata(struct phy_device *phydev)
+{
+	int silicon_version, sample_type;
+	bool macsec_ability;
+	int phy_abilities;
+	int ret = 0;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_DEVICE_ID3);
+	if (ret < 0)
+		return;
+
+	sample_type = FIELD_GET(TJA1120_DEV_ID3_SAMPLE_TYPE, ret);
+	if (sample_type != DEVICE_ID3_SAMPLE_TYPE_R)
+		return;
+
+	silicon_version = FIELD_GET(TJA1120_DEV_ID3_SILICON_VERSION, ret);
+
+	phy_abilities = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+				     VEND1_PORT_ABILITIES);
+	macsec_ability = !!(phy_abilities & MACSEC_ABILITY);
+	if ((!macsec_ability && silicon_version == 2) ||
+	    (macsec_ability && silicon_version == 1)) {
+		/* TJA1120/TJA1121 PHY configuration errata workaround.
+		 * Apply PHY writes sequence before link up.
+		 */
+		if (!macsec_ability) {
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x4b95);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0xf3cd);
+		} else {
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x89c7);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0x0893);
+		}
+
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x0476, 0x58a0);
+
+		phy_write_mmd(phydev, MDIO_MMD_PMAPMD, 0x8921, 0xa3a);
+		phy_write_mmd(phydev, MDIO_MMD_PMAPMD, 0x89F1, 0x16c1);
+
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x0);
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0x0);
+	}
+}
+
 static int nxp_c45_config_init(struct phy_device *phydev)
 {
 	int ret;
@@ -1609,6 +1658,9 @@ static int nxp_c45_config_init(struct phy_device *phydev)
 	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 1);
 	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 2);
 
+	if (phy_id_compare(phydev->phy_id, PHY_ID_TJA_1120, GENMASK(31, 4)))
+		nxp_c45_tja1120_errata(phydev);
+
 	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PHY_CONFIG,
 			 PHY_CONFIG_AUTO);
 
-- 
2.48.1


