Return-Path: <stable+bounces-213236-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFpSCWz0gWkMNAMAu9opvQ
	(envelope-from <stable+bounces-213236-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 14:13:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39394D9C08
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 14:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5CAA53008CA7
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 13:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFBB2C21ED;
	Tue,  3 Feb 2026 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kQM3wqiA"
X-Original-To: stable@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012000.outbound.protection.outlook.com [40.107.200.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB2534C9A3
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770124089; cv=fail; b=pi4lLGwF6TLBL+vV73WLtpfZ4O2b2p44Hc9AZrukRKaZc1EfCeBdsUHU43dTQ5S+JiWZAZQB+Pq7n8pQqw7SprG2ifJAR5bEwNE3TD6/sVJIkIiTf4zZmINBS6/VLYHO4yPojE1K+yqyxypcHJaXrry0b1NfNFvmHgjBDH4aUgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770124089; c=relaxed/simple;
	bh=QWs4EE+ayzBq1dFo3Yfy+UCiJzuc8hkzK041xh6AkY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hMrFP0kjtZIgVgj/YHl+amlUP82ZFlbsz7bUqwhRIYq5yGCxF77qaDFavA2sSsoYYCKiGuvNsOEwudtybxyOyz/at/fdkxpcZlOB+XjV8wv+8J8VNh/yEFbfgHnrM+y64yHxO8Szv7iXOe2cr8/x+wbTRq9NfZaT6+q9M0BIHdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kQM3wqiA; arc=fail smtp.client-ip=40.107.200.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOc5QUsQUAgCI7YW6Y7ilOeoj9n6z/XvvthCp9B5ymXQezwzZbU54j9Nlh7RZCKVhZVAWi3OzOyzu8NGAcaXpgsJ3bNa7bVYnBGSgyXL1Y6IAf71LZxJg786uUp1E+rmW1tdK1V5Qc4fbtPK248uWpw3l0I0xYYZ+vyMYWAgJdcdXR8ANkIgxLIRl+3XzJqOs/WmFLtQdAo4dmt3S06+mSQp/WgXCO9FL+Yj6bi5KHWMjpLJcm2TgGzMvwGP3089q08R5pj1wvjpn3oG70CHpwPpsx4cmkrcfRGxbL8yfE5rvSLAGiiF7/c7C0R0riUHyJg1SyFx9wuBXeptriHLQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHaSaUQa8jBA1zCP/UbVW3JoEwphWiYQ25e52J6ldk8=;
 b=ZbuDKofct8OHS9Q/XXSvEjy1X837w4afe46JVlbsTuqZb1bjsXXXFe/N2jVGgT6ZYgYbZr7Q1u2Oh+VgF5fjZaniGVGntZmjZHyAWVd2QKNfc4FCxv5TnLKetGVd+EEXuaI2NyRRgxsTtamV/iVVXo/YJzX4fAbSCloGV8PbNoKKqwBzfDR+g6Xa+SS57Zxr64JXHNpUXZJLY1vBja70dD9zSU9qiRD0cpv0iTRKNzhH+cinj7zhJFNscokgUB+IAHwTjLemUfToqa1g9KWF/ZHrUizr9DDYvGCK5XOSlWZJS+QX7y7SZcXZTR1sld08Rx/CMGs8io1esALx+sQyqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHaSaUQa8jBA1zCP/UbVW3JoEwphWiYQ25e52J6ldk8=;
 b=kQM3wqiABKCk9RHy+QuIS21Hd20zhq1wh75T2Umz/VeARZ8vaxsYE2MeFnBxYjFFbZdHlHFtm2+fxq1/PPP71hhWKnv6wYqSVGS2S2xjYt5LQjovvhUHZU7GzQ6tZe1s/gtgX0JEc2+o+GNRZysyKYsiDewyASJU6AHOZQQhW3pQY+xJ8Qs5U66cJfSQ3LEHQohPfUoZ0CIgj5LmwWBXz5t1Xr6NLCIEhVNNXLRQY3fkiBc7K7e0WF/CPHw7Xx5I17H3TaMWd0DCgmq9caywk1b7mzSNhhOeusyuILcRhS+KISHzSdvbAv31su4eoYEgTLO6vpFYQ1i38+E6e0so/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB9323.namprd12.prod.outlook.com (2603:10b6:8:1b3::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.12; Tue, 3 Feb 2026 13:07:54 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 13:07:54 +0000
From: Zi Yan <ziy@nvidia.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Gavin Guo <gavinguo@igalia.com>, david@kernel.org,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, riel@surriel.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
 jannh@google.com, baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
 stable@vger.kernel.org, Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] mm/huge_memory: fix early failure try_to_migrate() when
 split huge pmd for shared thp
Date: Tue, 03 Feb 2026 08:07:49 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <3172E2A7-EA3E-4F68-8067-96D72AE5D2C7@nvidia.com>
In-Reply-To: <20260203130427.n2td43cb275ybi7j@master>
References: <20260130230058.11471-1-richard.weiyang@gmail.com>
 <178ADAB8-50AB-452F-B25F-6E145DEAA44C@nvidia.com>
 <20260201020950.p6aygkkiy4hxbi5r@master>
 <C620202F-685A-4B9E-B51B-078EBE5BF0C4@nvidia.com>
 <08f0f26b-8a53-4903-a9dc-16f571b5cfee@igalia.com>
 <4D8CC775-A86C-4D80-ADB3-6F5CD0FF9330@nvidia.com>
 <20260203000035.opgq74myrja54zir@master>
 <EF19148C-5365-4D00-AF21-B0D71E799740@nvidia.com>
 <20260203130427.n2td43cb275ybi7j@master>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR16CA0018.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::31) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB9323:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d5baecc-3208-4e73-1a06-08de63253e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OaCuI8leLoQV05FoQIigoQx5MPFo4xt6yzSc+xLwyLgaIN/KbXrJs5fjValC?=
 =?us-ascii?Q?Am47C+Km/l+UHdQqU04wkyKO697DCNIRrgC9jhfrLxfYUgPrOBqnE7LhfF16?=
 =?us-ascii?Q?T1CD/lLrfXq4ETcs9fStmwjyYSWKTWW+E8F3be+K+nT/XlgJvuJJy+TI4bXf?=
 =?us-ascii?Q?belglcHcc2MZyAD/32TDLyjbAuhQkfPWPliH+JnOoXFGq1FsPrKjrATz2CaF?=
 =?us-ascii?Q?JEnX4QaUwyoyW3clM9EfRGD9uSk3Cg90eUbneB52nIUdHL6Pq92X+MUjUQ0W?=
 =?us-ascii?Q?8zzMjz+ew5R6Ss3qqs5dlSQ7XKISIbL4Y+uGXZfRBWxEaNZPTDmwwVkrgyif?=
 =?us-ascii?Q?2bQVWmgNoglPRpgdS7rWM8mZPwXN5O0ZTGOMFNPNYNR+eMw+wC3Dug2FrRql?=
 =?us-ascii?Q?HqZ5GBX70Yrs7PkGQ6QBgJ5f0sn6AOG5j6+NrbwjrUb5ViUxXf7PUBF6ZLSA?=
 =?us-ascii?Q?Rs/jYMyJsIiARU/1YP+LLZ5tjf/D+FAo0PUKxPRvAFqRJDbiDaWjZGXWPuto?=
 =?us-ascii?Q?5fkmWNJrI0i6+TwrOpDubnJd5nD4lAOUATJ6mYfeP7c7MI8q+mKIZsST99Jm?=
 =?us-ascii?Q?89Kygx/OXjq7imEnJTu8J6A9Qby+FDmV/nDDbgEmQN4RJaaIT0OrIqzVv2pf?=
 =?us-ascii?Q?5v4fSa03ZIB/kotGhNkV9yEuXwjNt8LFFjDF2x3OjLBd36Ni9fcIIgaEJLHg?=
 =?us-ascii?Q?9aH5tcVby4PdgRLYFZrCfZq9smygB1pKTyZ+IUj0dLhAh8YHR2AhEDyouoqk?=
 =?us-ascii?Q?tyU6sIsOamoaFEXZ+n4Oqjwo0+gIwIPyU7RRluCrQrzzO6Q/TUVEwEnbVVh0?=
 =?us-ascii?Q?wd7ej+vyh77YXABBQoxoZeN8fkzA/80UJlU7E1X1UAUZZt3gyrbHIFGrIB4h?=
 =?us-ascii?Q?XgaCBalvVMwOpfyqDN7SDmE6wI+vFxSiz2VmFbDO6HakM4wwcS4NJiOzbMw6?=
 =?us-ascii?Q?2fUXSJJfq34eN9ZIjPobOE216CiiEsqmYe6ncGjBzngye+VuEEhOSbCMF+c/?=
 =?us-ascii?Q?4q/8RiI3ysMhOJ8VoLyI0jlltVexE6JHVrjq3DqhLe0+lYnmB231kCdX+UBd?=
 =?us-ascii?Q?vDZQfSAh6/CD/xZ6JjcMKHCmViYJVC+UDY74OxuOHJ9y7//0L2kDegUTxTRJ?=
 =?us-ascii?Q?DvKylcbw5KxD0FNKOmQRc1msTRki7OeJLL2B3WV7JXxmckiKm+H3T5nCJPIf?=
 =?us-ascii?Q?lA1r6lJ+/p9MGziijq3H2MapGIo9pl7XtQzU446TcDvKPtCHamiTqoIdZSuw?=
 =?us-ascii?Q?g1PR9A748hr/cexV6VhtRLTxdiesiWitNaoI6XwR8CBTzdqMwGWBl52GwkSO?=
 =?us-ascii?Q?eym75QpMQ6U49+Li4eRiVuUDflEvXWgAXqtpnWkSejcB0es333dSZ4YVE7aC?=
 =?us-ascii?Q?Zy1LHo45Q6YLtFZyZwdbPDT5Zl2/wRjey+8Nyudmj0BDZ2Ya9L2VUeYaZM3A?=
 =?us-ascii?Q?qIqlDTtbyIkYrJazXhHgQN5EC6bt/heejKzTZ1WUKXSON7ezTCq0d+zGUQf1?=
 =?us-ascii?Q?TnsCifRmU+z/BkF6eEcRG8xpEYwU3aILNnZzAzg6iDC8Si03CPyASYyQDPVl?=
 =?us-ascii?Q?mbWnzU1t5LLKock11Gw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CmCuLR13DL/wVepZt9BxHE6Caj1aBheitjXhCALsyFax+ROxFpXLDYOEth+s?=
 =?us-ascii?Q?arNpf5xOFlJ7AmbfmTQdFxoniM1zkjCzP4BU/W0rsOIxy5zoV32Il/oot9KS?=
 =?us-ascii?Q?G+GFoV1fxumQt6hv5c4MRjHMl1BALIv3K3XIx1BvK+/eCJA0S7rm/uR5SSvz?=
 =?us-ascii?Q?X/JiiVH8imTeARLIxsHW4HLkHdTkeO9Zhl7enj2RN65k7EhJ380uggj3lLfP?=
 =?us-ascii?Q?vDg4EOzFDCg6AwhmI4VNkFyDTu/1Nf/h8yket53o4L1X/BsD0AyZ/10B0Pt3?=
 =?us-ascii?Q?DEMX7Aelj/cgcjwtHVxDa5kRVXYVCFTPndV1jcVHrnf9FRSp4UzpbC/6G72n?=
 =?us-ascii?Q?rLFwAzMWDk78lvZI7oPPDMDVTeDijT2hpjEhVAor936nRzp8WcEslYV1YnUA?=
 =?us-ascii?Q?D+FbQ4SJCvQG1QJBCLvZuGfk/7y9poFDLm7Pdc8M9bfm0mxEX1Q6ei9vIoyV?=
 =?us-ascii?Q?JEyeLtMxLhiMT2wb37gd5rw4l8a9fyDqUBrN0KXJ3WXWovAQVa+7KYhvJlyO?=
 =?us-ascii?Q?NENjxqjdWpj2OBJJMGvmdpM1X2RfARNcpOUe/nrBqrdVxzAbIZR6JtvtFS2H?=
 =?us-ascii?Q?cU9tyggsQPo8KIBOuuwe81MR1LJU8U99XrkoFmvoez1hlZ/XFKhdvIcEzGLn?=
 =?us-ascii?Q?axGp0lOECAaogpy7mjUZCRjZonp4jma27jfxx+npJIxMgnifCIPvxodhYFFr?=
 =?us-ascii?Q?TBOt+lBuqCMjxXEfT5asBcmYrNYnl8BR0K64P03GEY8x+3RGfHOCibWFaz06?=
 =?us-ascii?Q?75Xl729nbugjViU88FJZu4XP4JCvqqktTNj7OThNJViOLu0IvVnWThH7JVxB?=
 =?us-ascii?Q?jvtpWAR9cz7OUPOBYvNFaVi8wwc9btjo6YDXkABqQjXAs4x+tgVpUgeO8/UC?=
 =?us-ascii?Q?mzfHufas2R6odXm1mAStOPCVE6Z6hG665lq3OSUYkNis/5yt289GP/iH7jJK?=
 =?us-ascii?Q?lVBEPI5EMGye6TRxUtoZVtynJiCFvubimbXHSjbgnmIxaeXO0/iWYVbGMluC?=
 =?us-ascii?Q?RUidpxvrl87r22od99ZNWRxmwS3YL3Qbe7TNzllWoH+huqwAe3Bu3qA4FcMk?=
 =?us-ascii?Q?Ls91lUkngDnCF/L/T12byXxkgPyJSDUK+2XPSwUkbhT4hkUNY9D1RAYrSKcg?=
 =?us-ascii?Q?XBiP9y81Rf7+ft1ABbBIVebBI6XbS/qg7iFPyt4T1323Sr1fjjag0Mo//BK3?=
 =?us-ascii?Q?QwSbTRZ3ivLDLZ65aHZ0558L0KnnjohXRjfDpaQhdd9iT2cAXaHHbWAI/SO8?=
 =?us-ascii?Q?+nAUcyUYqehMY2W9yH5YWbdT8mlotjpkNlNhT/obGW79um9qNOAXxR69Nxj4?=
 =?us-ascii?Q?9BnrShPLewvhyNPzsgT/1o7Uiz2lIoJotCb3rjMJpAlSiPCO9ETUZr0EXR0A?=
 =?us-ascii?Q?28VTPqwLlzMuAL/sQYLjmcTKqe78QwJg90bAU3zQKtzIY/MGbM7W+A7JVrNE?=
 =?us-ascii?Q?ebQoHXmpUaS2dl0NFeAw+kAzbqwjycIDSrHeYPc13GTolJb+OfMpoQclijND?=
 =?us-ascii?Q?GUuaa9NKoLNawt+g3n4tSAdy9RCBsYkGl4SNUk6L7c2KUIlzkqt7PBg82J8K?=
 =?us-ascii?Q?TOHWn5Fl+jU0q/pIbL+EZEX1LgTbJl5B3j/G3KdOedjsrm+If0VIBbsiNJTz?=
 =?us-ascii?Q?vZhRuXVXMLhnM3iirLwnud23UCvFo2UlenOYWY5JPxLp2LayiUNgj/uNfNUT?=
 =?us-ascii?Q?M48zGdE0+stV8Mvf6rzhnXiAjmrZ2+smOxQRufAhSwLDnxLc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5baecc-3208-4e73-1a06-08de63253e40
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 13:07:54.3963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5KK/azDZbBnfdDQDBqcQJVeZtLLaz1Rd+86o4j1umsyksOlXN7TtdqAN2kENS7lD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9323
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-213236-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,igalia.com:email,alibaba.com:email]
X-Rspamd-Queue-Id: 39394D9C08
X-Rspamd-Action: no action

On 3 Feb 2026, at 8:04, Wei Yang wrote:

> On Mon, Feb 02, 2026 at 07:07:12PM -0500, Zi Yan wrote:
>> On 2 Feb 2026, at 19:00, Wei Yang wrote:
>>
>>> On Sun, Feb 01, 2026 at 09:20:35AM -0500, Zi Yan wrote:
>>>> On 1 Feb 2026, at 8:04, Gavin Guo wrote:
>>>>
>>>>> On 2/1/26 11:39, Zi Yan wrote:
>>>>>> On 31 Jan 2026, at 21:09, Wei Yang wrote:
>>>>>>
>>>>>>> On Fri, Jan 30, 2026 at 09:44:10PM -0500, Zi Yan wrote:
>>>>>>>> On 30 Jan 2026, at 18:00, Wei Yang wrote:
>>>>>>>>
>>>>>>>>> Commit 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one=
() and
>>>>>>>>> split_huge_pmd_locked()") return false unconditionally after
>>>>>>>>> split_huge_pmd_locked() which may fail early during try_to_migr=
ate() for
>>>>>>>>> shared thp. This will lead to unexpected folio split failure.
>>>>>>>>>
>>>>>>>>> One way to reproduce:
>>>>>>>>>
>>>>>>>>>      Create an anonymous thp range and fork 512 children, so we=
 have a
>>>>>>>>>      thp shared mapped in 513 processes. Then trigger folio spl=
it with
>>>>>>>>>      /sys/kernel/debug/split_huge_pages debugfs to split the th=
p folio to
>>>>>>>>>      order 0.
>>>>>>>>>
>>>>>>>>> Without the above commit, we can successfully split to order 0.=

>>>>>>>>> With the above commit, the folio is still a large folio.
>>>>>>>>>
>>>>>>>>> The reason is the above commit return false after split pmd
>>>>>>>>> unconditionally in the first process and break try_to_migrate()=
=2E
>>>>>>>>
>>>>>>>> The reasoning looks good to me.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> The tricky thing in above reproduce method is current debugfs i=
nterface
>>>>>>>>> leverage function split_huge_pages_pid(), which will iterate th=
e whole
>>>>>>>>> pmd range and do folio split on each base page address. This me=
ans it
>>>>>>>>> will try 512 times, and each time split one pmd from pmd mapped=
 to pte
>>>>>>>>> mapped thp. If there are less than 512 shared mapped process,
>>>>>>>>> the folio is still split successfully at last. But in real worl=
d, we
>>>>>>>>> usually try it for once.
>>>>>>>>>
>>>>>>>>> This patch fixes this by removing the unconditional false retur=
n after
>>>>>>>>> split_huge_pmd_locked(). Later, we may introduce a true fail ea=
rly if
>>>>>>>>> split_huge_pmd_locked() does fail.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>>>>>>>> Fixes: 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one=
() and split_huge_pmd_locked()")
>>>>>>>>> Cc: Gavin Guo <gavinguo@igalia.com>
>>>>>>>>> Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
>>>>>>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>>>>>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>>>>>> Cc: <stable@vger.kernel.org>
>>>>>>>>> ---
>>>>>>>>>   mm/rmap.c | 1 -
>>>>>>>>>   1 file changed, 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>>>>>> index 618df3385c8b..eed971568d65 100644
>>>>>>>>> --- a/mm/rmap.c
>>>>>>>>> +++ b/mm/rmap.c
>>>>>>>>> @@ -2448,7 +2448,6 @@ static bool try_to_migrate_one(struct fol=
io *folio, struct vm_area_struct *vma,
>>>>>>>>>   			if (flags & TTU_SPLIT_HUGE_PMD) {
>>>>>>>>>   				split_huge_pmd_locked(vma, pvmw.address,
>>>>>>>>>   						      pvmw.pmd, true);
>>>>>>>>> -				ret =3D false;
>>>>>>>>>   				page_vma_mapped_walk_done(&pvmw);
>>>>>>>>>   				break;
>>>>>>>>>   			}
>>>>>>>>
>>>>>>>> How about the patch below? It matches the pattern of set_pmd_mig=
ration_entry() below.
>>>>>>>> Basically, continue if the operation is successful, break otherw=
ise.
>>>>>>>>
>>>>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>>>>> index 618df3385c8b..83cc9d98533e 100644
>>>>>>>> --- a/mm/rmap.c
>>>>>>>> +++ b/mm/rmap.c
>>>>>>>> @@ -2448,9 +2448,7 @@ static bool try_to_migrate_one(struct foli=
o *folio, struct vm_area_struct *vma,
>>>>>>>> 			if (flags & TTU_SPLIT_HUGE_PMD) {
>>>>>>>> 				split_huge_pmd_locked(vma, pvmw.address,
>>>>>>>> 						      pvmw.pmd, true);
>>>>>>>> -				ret =3D false;
>>>>>>>> -				page_vma_mapped_walk_done(&pvmw);
>>>>>>>> -				break;
>>>>>>>> +				continue;
>>>>>>>> 			}
>>>>>>>
>>>>>>> Per my understanding if @freeze is trur, split_huge_pmd_locked() =
may "fail" as
>>>>>>> the comment says:
>>>>>>>
>>>>>>> 		 * Without "freeze", we'll simply split the PMD, propagating th=
e
>>>>>>> 		 * PageAnonExclusive() flag for each PTE by setting it for
>>>>>>> 		 * each subpage -- no need to (temporarily) clear.
>>>>>>> 		 *
>>>>>>> 		 * With "freeze" we want to replace mapped pages by
>>>>>>> 		 * migration entries right away. This is only possible if we
>>>>>>> 		 * managed to clear PageAnonExclusive() -- see
>>>>>>> 		 * set_pmd_migration_entry().
>>>>>>> 		 *
>>>>>>> 		 * In case we cannot clear PageAnonExclusive(), split the PMD
>>>>>>> 		 * only and let try_to_migrate_one() fail later.
>>>>>>>
>>>>>>> While currently we don't return the status of split_huge_pmd_lock=
ed() to
>>>>>>> indicate whether it does replaced PMD with migration entries succ=
essfully. So
>>>>>>> we are not sure this operation succeed.
>>>>>>
>>>>>> This is the right reasoning. This means to properly handle it, spl=
it_huge_pmd_locked()
>>>>>> needs to return whether it inserts migration entries or not when f=
reeze is true.
>>>>>>
>>>>>>>
>>>>>>> Another difference from set_pmd_migration_entry() is split_huge_p=
md_locked()
>>>>>>> would change the page table from PMD mapped to PTE mapped.
>>>>>>> page_vma_mapped_walk() can handle it now for (pvmw->pmd && !pvmw-=
>pte), but I
>>>>>>> am not sure this is what we expected. For example, in try_to_unma=
p_one(), we
>>>>>>> use page_vma_mapped_walk_restart() after pmd splitted.
>>>>>>>
>>>>>>> So I prefer just remove the "ret =3D false" for a fix. Not sure t=
his is
>>>>>>> reasonable to you.
>>>>>>>
>>>>>>> I am thinking two things after this fix:
>>>>>>>
>>>>>>>    * add one similar test in selftests
>>>>>>>    * let split_huge_pmd_locked() return value to indicate freeze =
is degrade to
>>>>>>>      !freeze, and fail early on try_to_migrate() like the thp mig=
ration branch
>>>>>>>
>>>>>>> Look forward your opinion on whether it worth to do it.
>>>>>>
>>>>>> This is not the right fix, neither was mine above. Because before =
commit 60fbb14396d5,
>>>>>> the code handles PAE properly. If PAE is cleared, PMD is split int=
o PTEs and each
>>>>>> PTE becomes a migration entry, page_vma_mapped_walk(&pvmw) returns=
 false,
>>>>>> and try_to_migrate_one() returns true. If PAE is not cleared, PMD =
is split into PTEs
>>>>>> and each PTE is not a migration entry, inside while (page_vma_mapp=
ed_walk(&pvmw)),
>>>>>> PAE will be attempted to get cleared again and it will fail again,=
 leading to
>>>>>> try_to_migrate_one() returns false. After commit 60fbb14396d5, no =
matter PAE is
>>>>>> cleared or not, try_to_migrate_one() always returns false. It caus=
es folio split
>>>>>> failures for shared PMD THPs.
>>>>>>
>>>>>> Now with your fix (and mine above), no matter PAE is cleared or no=
t, try_to_migrate_one()
>>>>>> always returns true. It just flips the code to a different issue. =
So the proper fix
>>>>>> is to let split_huge_pmd_locked() returns whether it inserts migra=
tion entries or not
>>>>>> and do the same pattern as THP migration code path.
>>>>>
>>>>> How about aligning with the try_to_unmap_one()? The behavior would =
be the same before applying the commit 60fbb14396d5:
>>>>>
>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>> index 7b9879ef442d..0c96f0883013 100644
>>>>> --- a/mm/rmap.c
>>>>> +++ b/mm/rmap.c
>>>>> @@ -2333,9 +2333,9 @@ static bool try_to_migrate_one(struct folio *=
folio, struct vm_area_struct *vma,
>>>>>                         if (flags & TTU_SPLIT_HUGE_PMD) {
>>>>>                                 split_huge_pmd_locked(vma, pvmw.add=
ress,
>>>>>                                                       pvmw.pmd, tru=
e);
>>>>> -                               ret =3D false;
>>>>> -                               page_vma_mapped_walk_done(&pvmw);
>>>>> -                               break;
>>>>> +                               flags &=3D ~TTU_SPLIT_HUGE_PMD;
>>>>> +                               page_vma_mapped_walk_restart(&pvmw)=
;
>>>>> +                               continue;
>>>>>                         }
>>>>>  #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>>>>>                         pmdval =3D pmdp_get(pvmw.pmd);
>>>>
>>>> Yes, it works and definitely needs a comment like "After split_huge_=
pmd_locked(), restart
>>>> the walk to detect PageAnonExclusive handling failure in __split_hug=
e_pmd_locked()".
>>>> The change is good for backporting, but an additional patch to fix i=
t properly by adding
>>>> a return value to split_huge_pmd_locked() is also necessary.
>>>>
>>>
>>> If my understanding is correct, this approach is good for backporting=
=2E
>>>
>>> And yes, we could further improve it by return a value to indicate wh=
ether
>>> split_huge_pmd_locked() do split to migration entry.
>>>
>>> Thanks both for your thoughtful inputs.
>>
>> Are you going to send two patches in a series, one is the above fix wi=
th a comment
>> and the other changes split_huge_pmd_locked() to return a value?
>>
>
> Hmm... as the above fix is supposed to be cc stable and backported, I t=
hink
> separate them is the correct process. And for the return value of

Right. Andrew prefer this way. You can send the fix first and send the re=
factor
patch after the fix is picked up by Andrew.

> split_huge_pmd_locked(), I will take another look at all the call place=
s. Are
> you ok with this?
>
> Well, do you think we need to wait for David's comment? If not, I will =
prepare
> the v2 fix with the above change.

You answered my question. There should be no issue with existing code.

Thanks.


Best Regards,
Yan, Zi

