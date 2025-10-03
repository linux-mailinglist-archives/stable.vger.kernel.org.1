Return-Path: <stable+bounces-183230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 229D1BB7147
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 15:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F720189A6ED
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 13:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA422B9B9;
	Fri,  3 Oct 2025 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pW7oUVoD"
X-Original-To: stable@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A0A34BA50
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759499629; cv=fail; b=PdtneIw9V/VNh0E0bpSya5LsjYN9WrtaazuWfdn+UyyqaND1ozRr7RrTw7Uk7tw0S+YmAFydOZv2AYHH1FLcwi7g39avqgP4WaxM919z4TJ+nSJr5gPFT9shcviTYqT+6D8Y8XMVI09JQOZtBKBDZ/XXvGy26jAoCmiBLwgcdKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759499629; c=relaxed/simple;
	bh=23Lcjcp79omIcjJiAiD0vlGy6mn9z6FGBTEdn58ZRuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jmNaeRvMNdMjvmrVinFcpDoo+SaB2U/LFBOm2NRu3+zoMOghm3ZgPGYOCJrthQSS5mqaTh2Jj6EdM8TnCcSj4XjGZiYrWWwL7Tlqd8EwICmH7eGs4sV0oMizzFgIbFWX8wOp4qhgN+4KUI8jf6yiYkULXmFpaAUt/ekebjpCBK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pW7oUVoD; arc=fail smtp.client-ip=52.101.48.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekk2OTs1lRvp0e/e5w9Noytdi393SGAf0bYh3Wk3h0tfLWo1wczSm4fjbp1bJ2vJP/2ri4F2vRvwDqJdy+Kvmp2OhBEqj/bVN0tsdf49IvbYpKW7xSHcGKjOXAEwn5JB8m3Vn+lLx1ZZAvrwPr+se4X06wKo8TjZWciubugCEY9gfJHBkBrCXdiLKBg7UJhxgPBZrHdM/T/VmuZplVitmrloucmSivcvalYTZR/LkbLSvCyewNfvKrJGjUMV9RXMSrOJFxqwHR/bFtUt4o99GfbI7hDN8EfrPjGvbI/XiV9XffaR/c1VShcJh+nirawyZHbRYDOMfZ5QIWFLXabZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37Fxp31Qg4Xw7xrBy/pYbBqd9F0HUtp6PN+s5xgymEg=;
 b=t71nmb04sBTCCP7PVsS4yCNChLlhdReAmHNPrXXa8r+sz1oDYK/WIMdyKInEZrd7vSsX5/OqwmdiZrqtd3WyVcmPkzeNNRskqjrqASPA9mN1B80oTj/R8hrsa35ILA8ou00HKZ/hDyVg8dUY8cIckuiuli+kZDItFczahaFlJjKXct8W4+R1AFx2AjwvICipH5c3U7QcDFc7dxCfSIU6RlL8AIMu5KJ3QFYex+0Yo0/7g8jplf4n8AgD7UBl45aw/RRS8zXEGhic2oyqS0UFOsbWzKMpZFfpon4aCfDSkjb+bRqYisyt996V2N03XhDK3VecEzyQTsIfzwYV3cTvdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37Fxp31Qg4Xw7xrBy/pYbBqd9F0HUtp6PN+s5xgymEg=;
 b=pW7oUVoDzLDzvzIT/6ezLibjCOknt1dYw9c6EH3kz8I6jV/68l2XZ95vfbUwvIHdAOZ6QDOoOBhnLaJFIia7e1DuArEjf5n+CFyat+cq3bIe5VfxP/gmqkvLDTIp9zL0BTMfcGPRJRKEsKSE3nONek1hK55IRE2H8+Z6WykAt2GiGSjGLiEobQG2qT37CcffckF42k1VSCCcCb0LNaGzyp2xaoiPHrd+wkM9OMQz4BnvjI9d17IKBVQlr80QTPkU8SKaonQ+EGTZXOHqade/QUbybk0qy1AEkLw7dq9vExuvLgSPTw/tT3nojtHaNhxYn6fNonqlAaUElRoB4BT1BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 BN5PR12MB9512.namprd12.prod.outlook.com (2603:10b6:408:2ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 13:53:40 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 13:53:38 +0000
From: Zi Yan <ziy@nvidia.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, wangkefeng.wang@huawei.com, linux-mm@kvack.org,
 stable@vger.kernel.org
Subject: Re: [Patch v2] mm/huge_memory: add pmd folio to ds_queue in
 do_huge_zero_wp_pmd()
Date: Fri, 03 Oct 2025 09:53:36 -0400
X-Mailer: MailMate (2.0r6283)
Message-ID: <FEFD7299-2715-4C0D-A2D1-C745FFEEA965@nvidia.com>
In-Reply-To: <20251002013825.20448-1-richard.weiyang@gmail.com>
References: <20251002013825.20448-1-richard.weiyang@gmail.com>
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::31) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|BN5PR12MB9512:EE_
X-MS-Office365-Filtering-Correlation-Id: 919a7cd0-b3fa-4fdd-b9f6-08de0284410a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E7hX76FiaDqZaBNUJ6ZL1e15s34hTNB2htIBHRF71R2gp4Rx8nLlMUTCl+Cv?=
 =?us-ascii?Q?waaCAGC93btUpjLsFAGtt1kU4d3C92mZC7R/Vq/RMx7PXhx3uOaphlEVlg4k?=
 =?us-ascii?Q?kN1WL7+AAr4Htu5i+XTyeVK+FVS7v4fb9wwAcuTVoZNDSbptD6tgFAj7nlAc?=
 =?us-ascii?Q?Me4xXgQysk5qax2OQc+YkLKRJVEWfXRo4UQjJOrSl+3J5aj3txNTyvYHcXyY?=
 =?us-ascii?Q?WNtY4xWnZpviEvGqBxR4vIhwConjzXOxaYB837BHhFAKfgwH42S5edJedzRd?=
 =?us-ascii?Q?RSVnLOuAUXFdS2WftbtDwPHM89KLk6x3TLQviW7FS4cGi5n1nt2h84woyC9f?=
 =?us-ascii?Q?hRa2z5qgCXPRUPgGEPeIKJyu0GLcntycXwekYP7Z59B4S34MiR0Npaa5QflH?=
 =?us-ascii?Q?8o9kV2FBsF06SD1vizfb5Fri3j2mV/Ye7ldltLvL5xJ1vlbCSDS77gI73pzu?=
 =?us-ascii?Q?Klfn0XYmUlfipRuM+/sZgekLxbdkILNNAmEGeGqhf5nIVJK7n0o61NaBqn5F?=
 =?us-ascii?Q?xh0RIXEiD5Vg9qYptY/eWxPgyVGHIo5mKZZycHiOWaYNdtviSfOUxIXBtCQE?=
 =?us-ascii?Q?66WsoTo/pN2oLsNyK6PCp1n9rh6H+kdYD6q4cegk5aSLXpdfCcrTkGg4HNFc?=
 =?us-ascii?Q?WMOSfrM/wfhFGoV/Iabx5MbRIfxrJz4RYBOzPjnCA7o1ZRBR0cUXrwMZwXBz?=
 =?us-ascii?Q?y7SWysdFhmQU/l1nJkG/r5LUsDxL9X/Hv9NuoTeNOE9CP+hq3SzxcY/SI2Rt?=
 =?us-ascii?Q?d8gmte82lGLe7jSXC/RyX4ebTy26KenLt90DpotkVbFs24NjpwZP28EDoQQp?=
 =?us-ascii?Q?C0l/u406W8OoskV4FRDHhbrwcRrQ3RyfJ8DnX4knQFL9lIwjDub3dIljmk3s?=
 =?us-ascii?Q?eupr/IWiSvVx2rF1ICUYVJEorPFINM+w8Twf/+JGUDwPHZ0yQHBJCCJkPpxP?=
 =?us-ascii?Q?Cdds2iNORK6Aj6+p45rx2HamKatapfKWbsL+gJl0TB/5ey/CoE86enBiJoKF?=
 =?us-ascii?Q?L3oq/MUdvcolMN3QvY+FaZamI5M2VbwwaetrRfZ3kyRyrLOTlSDiDlvpU+az?=
 =?us-ascii?Q?T7iPA5UzqeXb+qZGyqgoQ5xCyjGaYj9djNldT/VW56hoR19eKpy6nAkNHgG1?=
 =?us-ascii?Q?LpJ/r8HzrlTfGyhw+npXSCfPr3po7zfQegh1KXlP2uUT+yp3dwSVxXpqC7m1?=
 =?us-ascii?Q?VhtXNJNc4WuftQ9z7WVhmAKOVTI/BWBWM8ORVlFQj/chrAOc2sOL6v0t37ea?=
 =?us-ascii?Q?MHcOEKejWE3g7i+l83j/iI+Z5D2kBfKPqzF4+IZKznB16OGnWbo3f1OjHMFY?=
 =?us-ascii?Q?LEYdkYRuj1dZdfzD0r7zALDbCWIQLfl6UrLvrByknvwg1RCYruNjHNbYdcmz?=
 =?us-ascii?Q?gNI0IRw40vPBNRtnNcujfvaSQTnGWNA/nOb/q7QiHqXMGaDvDv+2xCL6dIit?=
 =?us-ascii?Q?1MPjV1Mg5QVuwXjCQ0TuQ1Bxt13BROXL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TeHE18NyAkcvyQosT7ok3E0pyDGsfanalC55yj1Q/IEnOoeZ3XT88sikPx5g?=
 =?us-ascii?Q?fc5wc7F11nh90v3olgWl1swtrgGE/gtVFEDfTfR3BACvfQlWMOWNtGHDemD7?=
 =?us-ascii?Q?rodlg6ionhtLPAlH5R2loBsPcARoMGFHCKzBvUYhHaQKoHbnG3fF0YXjlDM6?=
 =?us-ascii?Q?jUJdAx6MQxfK5rtT2TTgKjGPM5mDJdpcusYvqKzpSiUlPQdaA+6xR8eol9Ck?=
 =?us-ascii?Q?PdGz/KodnpdQ7OeJ/Ki+rmgNdV3BrumpqFsdi3PM733qKiFl/72jRV7bFK1s?=
 =?us-ascii?Q?4BoKmuMHPxzZCLQalxBFhlv1/4EHeP0EP8RblG7Icwz/ORht82wUAZISzvmt?=
 =?us-ascii?Q?gCkVYdU/+OQcGCxlT4ryUd4NSTsQ8nMOZrrM39eb9sIAp7X0sUXWjCeRsFN3?=
 =?us-ascii?Q?ucdW2d/eILsJWSDbJMkFUSsr837wuVCTKa4UxNCAktUCQmLlwtx2HzSIm/UG?=
 =?us-ascii?Q?qzgyUR4FJaVe8vDmdYBeTqFrVUwqMnB5RRu9t3QZYdDbZXfvOk4KsUMBr9CZ?=
 =?us-ascii?Q?9pu3ppspwoLZppQsT+2sqwxf4SKHudTG/kV05S54mspQGdC8wQBGTMNtAyr8?=
 =?us-ascii?Q?v5kSZxZ+XlIIAmNlHsueKm3gzhmwmeGTxSuuufu4xeD/Bzd9wA9fRNvhnn9N?=
 =?us-ascii?Q?Qjrjbm5To4awVC41zTaT8rQQZiWAH26wyq/95UwqS04yPBT23KMads9aFi6s?=
 =?us-ascii?Q?K8CYtzmofpFG32s8nQPhjO+VJoJAZIHACQK4IPXvQq4ZwvJzneFblC7VcjSe?=
 =?us-ascii?Q?PP/0Z/x+sUstP/RlaguICx1RYbGcF2ChU5JmnMLAyQuEGDe1wclM8FRnicon?=
 =?us-ascii?Q?KnB0WB8sN72Vpa/57b7/u8AJiU5/LjjCs132kkXw77MXD2/VTUHuQktBRaZ1?=
 =?us-ascii?Q?9kTVgm+PtusMaTJtAcvd+tRyRV8Ot9Bjz5pulRXMpX0vesxEBC1bwekEZ8Og?=
 =?us-ascii?Q?FgxBJliuiSva5yiGkKLaXiSp2gpIvXSyPxu9duKOuvEV2/56uwBFeJycTFYV?=
 =?us-ascii?Q?PyoFGVDJhWcVzDHZtnzWoKVYGYZLhagqnpylifKDrC//NYZacU4JlWG5k3Hm?=
 =?us-ascii?Q?OBwL489I8sfwly77b63Oaz7zo3+mFjcxKY8ZtItQHPE2LJgeWE3UXk9h6I61?=
 =?us-ascii?Q?Zeja0pwP24VE5TjBRwONT22mkLNcjNqisguatPJkQrGtsetIaWUiBgx7/kMy?=
 =?us-ascii?Q?PEsl0VCXwj2rBjDvXWrSiXGAuRzAS0XI8APXIu5T4YG0SWxWU5snhXE0h/FH?=
 =?us-ascii?Q?goKfpnFWa42LObZMFnuuHpvy/r/oN9XFG0e+Gyi4aMWUfLrj36f2PxnA284s?=
 =?us-ascii?Q?GVAiwjxLg7H6sEQSXBzODqeGbazyUxQJryg+7UF5Pd5hClm5H91IE0uPQ3nB?=
 =?us-ascii?Q?etmre84qAKMiwK9VPbdIA4kZdjqpEvWWCM2UGCHBBC7JGMuRSS52GB1yYZpG?=
 =?us-ascii?Q?JnvGB1KaBQLEGcU7ljSuiNhw8rgEOI0MP5KhWCA4OB077aRa6ueOeQYqXabw?=
 =?us-ascii?Q?GUEtsDRayLd+fWUz2HF8P9mBtB+z7uVNfZwCTXyqcHEvFqDf5nBOJ7P4Fm6o?=
 =?us-ascii?Q?dGCgbKDYfQuFEL2IxPoRmqd3Nc6k6cT2X2u5ESzx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919a7cd0-b3fa-4fdd-b9f6-08de0284410a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 13:53:38.5335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Msa5FVnlstFJsFTW1hOW2ag4Y1m6SQDKqhe0192nfyx1LT1yZ2JqtVASYmyQvec
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9512

On 1 Oct 2025, at 21:38, Wei Yang wrote:

> We add pmd folio into ds_queue on the first page fault in
> __do_huge_pmd_anonymous_page(), so that we can split it in case of
> memory pressure. This should be the same for a pmd folio during wp
> page fault.
>
> Commit 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault") miss
> to add it to ds_queue, which means system may not reclaim enough memory
> in case of memory pressure even the pmd folio is under used.
>
> Move deferred_split_folio() into map_anon_folio_pmd() to make the pmd
> folio installation consistent.
>
> Fixes: 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault")
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Lance Yang <lance.yang@linux.dev>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: <stable@vger.kernel.org>
>
> ---
> v2:
>   * add fix, cc stable and put description about the flow of current
>     code
>   * move deferred_split_folio() into map_anon_folio_pmd()
> ---
>  mm/huge_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

