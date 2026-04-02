Return-Path: <stable+bounces-233054-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aN+ZMoSXzmkBowYAu9opvQ
	(envelope-from <stable+bounces-233054-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:21:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 276D538BC66
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A2B030221F0
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 16:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD02C3EC2EB;
	Thu,  2 Apr 2026 16:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="sxA3OnXc"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010047.outbound.protection.outlook.com [52.101.84.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7EF3E714F;
	Thu,  2 Apr 2026 16:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775146399; cv=fail; b=H4wKab1vHC7im801qlPIeJdEtxLrYe/TsJUaMVb/62t7gc6Xwmy/5h6Lm2GVVnMXdCvyzgw4LqTFCPWU1bYoSQef5abDteOV514CgoAiVQO8lIQSj0FsKYl/xyDcmG3j4I2xdk6nd5/LmhGEq9P4CBcmuJxo0Qrgxm+MJX9JrK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775146399; c=relaxed/simple;
	bh=28woUchwl2/OKHy0L/v81Jlk+FHBwkJgr5DSq4k+jQk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=H2cvljM8bVrGoQMb0lb8fyVv+nQbsfUcj+itoGILbh8A6hUiwanuKsnmij9DXR2oWI53JmBAdMecDQke1c4fz0wTOW1obN/X1RUQe29REkt6iOmdYSUDuDXtreaLsV58/lVQEX1cl7rVAjISGj+M6AGdW/4LoWK+UnVrFKWI6oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=sxA3OnXc; arc=fail smtp.client-ip=52.101.84.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHAGwnwq2/hpOQr2UnhJBj/TT9Iqli/cQtfn86AbMXO2mATVnih39QEWEduBbSugT+uaRsRw2Ta5DOV6Gv+1In+KEZLdF2hzlt9ToDq89CxfAwsr3k8BRyESWCeN5tgjRwuRPyBdKu8PUHnb8NMPv31r6t409FZ4INAoHFtSo5uwaVY93yM8ZoADYlEWLdpN+SabugmjZc0Zi+KgeYPi3nlIOTnbYWjTH0scJQJKk+nszcJFpwfGnKcY7K7rfJM07/c4OevS+PVzE8opyB/x0J/6G6Ww6UaEAzm/lzYtkwPjNFU8kyidgQYdREG6ZDK5q17KGTHIDgmo0WyEzf32vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4wG39pIzfHNV+Z+KnHtwd7xP7UYa+RK1NTDq8OTXWY=;
 b=f/JzLRZoG/mT9KV28MNxylwli9LP1ghU5RtnJXeHnPZcdXQmToZGc3z4xslUYVYwIvY8r6lil8MM9kXmCPMQheJQ7lWkbZQUiLLq79R44/vO0f4uAlAMMXfSR1Xgo1pKR3jy4EHttXXMdFdJ+4LFqWXsWB6rwfj+GgUU71TqlpVUBgzHUnvKZ9tG4lk4tzjzgB30AU0sk1Gr+xB4SBXFchYzQ0aQsa38R2+vgQGXVxiRlImUwRztgGQl0FUgzgvsqTFKpDJoQ6PSm/hoeN01r4AGMplBsO3aceKsC5A6gd2WA9AuhtA0H4BDgK4ZeYvbTgfMtwRNCBAfBJ2JUpKRew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4wG39pIzfHNV+Z+KnHtwd7xP7UYa+RK1NTDq8OTXWY=;
 b=sxA3OnXc35UoLqLKawSnogIsh2FKSYWEHhXvM8J36fgEdvOTL4ZGMvqiPuF+FY/nILzqSotLwPAg9TjTBbCvBdTwkySP8QFI7jDhqPxDbD0CwxmuJ55yG6mNn3hOIcYynWuphET/EHla0nnWFdJtvv/IddMwnftfQhWNwDLyEjNF1LFY51ip8cnMbq6+qawhjLI1wnYjbCEKfFSE9Lfz8gPExTNgApTpAwdpkXhglR7mIOyjdBMpI5whBfpajvshCLg0y4gXNcx+HdekJkvenp032rfyA4oCaFR0ohL2LMCItcjapU3R2qWlkvQjpFUJAgYXL+GGiLHd1WrVwQ5y1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB8P189MB0966.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:16b::8) by
 PAXP189MB1952.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:28c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.20; Thu, 2 Apr 2026 16:13:13 +0000
Received: from DB8P189MB0966.EURP189.PROD.OUTLOOK.COM
 ([fe80::48c:33b2:d870:d0ca]) by DB8P189MB0966.EURP189.PROD.OUTLOOK.COM
 ([fe80::48c:33b2:d870:d0ca%4]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 16:13:13 +0000
From: tugrul.kukul@est.tech
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: alex.williamson@redhat.com,
	kevin.tian@intel.com,
	jgg@ziepe.ca,
	lorenzo.stoakes@oracle.com,
	david@redhat.com,
	akpm@linux-foundation.org,
	mike.kravetz@oracle.com,
	linmiaohe@huawei.com,
	yi.l.liu@intel.com,
	axelrasmussen@google.com,
	leah.rumancik@gmail.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.nystrom@est.tech
Subject: [PATCH 6.6.y 0/4] Fix CVE-2024-27022: fork/hugetlb race with vfio prerequisites
Date: Thu,  2 Apr 2026 18:13:07 +0200
Message-Id: <20260402161311.63484-1-tugrul.kukul@est.tech>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0154.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::11) To DB8P189MB0966.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:16b::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8P189MB0966:EE_|PAXP189MB1952:EE_
X-MS-Office365-Filtering-Correlation-Id: 5134b722-8ab7-43af-c138-08de90d2bdd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OXfefJaJLS/FsCZvxKy7F0Ca6SatT8by7RmoFLKx69NhrNihNx9mvxrWp93/5u4XzmEZjeF+DGkx/Mo3IrHsvZqMr3JKxFLXu3bOWd8tkRqB1VsyW4bfa9BG1kRkFRWxhkFV4pFepX6uPYn/9MF9i+Hfs7Aj/PcMzgXG5jPRsJKsO/2DEUHtNgsQ0RPEU/nwCkoYcMvrU9o9dVgY41WTCafibq5ntjkzKq6owDqK9pKzdgtfYv7apIUluW6N0iCddmsIKJ8S66+D2Oiur2sk/2dq6gjdG45qUhVU/Txk9FPGpSa/N9nAIIWdgxBXqbRpf7QiJS2Kdtkif7r2KWWO5Isq3UxeRLSsZi6wu2qfI9gSEm+eFWzBR49Rz+pMnPGVpfDq+ejzEt7p32oEwIhjzZLadgfisU0Nlnt7HiEBkjafvaP4YUpcIJdSImY7oLg3Pu0HzvO3PpcW42xdUcXlmSxwS5XXD7AelnPVZDHDNO/PfeARviunTaInNAb8xDDw15FVVOcnmlnH6J/Sv/cTDugjDpryuvUhPeQ7IRosCPMP2IA1WmtXN3fgjLIzeuO8KA1gVHdaWBvyrkB/drf0uCJxThxfoKn1nvqPkD9hMSHZ2olmq3VMh/EKmIl3kfyTqR8gqxZLNus1vUWel30f3CAkAXcSk9F1ApEZs3WeFBF7qgNZ/KuKte+woxszWE24
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P189MB0966.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmMvdUJpNEVwa2dsQlFzYktsR0RxOEkxTHRaWEg3OTVEdzFMSnZKOEdKNzlh?=
 =?utf-8?B?S0pqdGQwbXNIdGNhY3FubVgxRzQvK0xoOVE5TlIzYkFaRE5LYVJPbFdHSkx4?=
 =?utf-8?B?eWREOW5tQkJaU1FZV0Q5aEFvTThUMTZKZlgzT2ZsblU2WDRRWURmeXoxaVQv?=
 =?utf-8?B?S01SNFVzLzVZSFpRMGRURTYzb0tKcGt0dldhaW1uQmRBc2dyWnpGQVNnR0Fy?=
 =?utf-8?B?dmxUUDQzUlZqYS9UVnZuSVRTenBsVVZLTndwelFPUVkzQkx5OGk3NGxUS1BC?=
 =?utf-8?B?MGdQV0ZScVJiaklXSkk4VWc3bkhhdXlxWFFqUkNYV2VsNW1YRUt4aHJIcVlx?=
 =?utf-8?B?NzNKZjRNWExjbExiMTAzdUhjVGljaWhBT1pEWUE0aEdoTW1URkw1MnhrcmNy?=
 =?utf-8?B?WkloTTlWRWlBckRNdDY4UC9TMEduTU9rTVh6SjhvSUtmbVAyb21XRXFQRUhx?=
 =?utf-8?B?WEhPcS9ydWUzSGNGWXAwOWVGa3hLWk9ldUk1dkhFTEoyeDlIVTRIc0pTZXc5?=
 =?utf-8?B?R0Z3eHQrM0V3QXVSajRUNU5FVmNnbFVuTXFGazl0N0dtZEVTbzdTM0JKSHNK?=
 =?utf-8?B?K3pwRnZtcVRJVzl3OE0wVWwzVnBqSGRRV2JzVlU1a3JoVzNhVzZXWVNRMWRQ?=
 =?utf-8?B?L2NiVFJJQmJyMUxmSEl1Uk9Wc3NYTFVhUEVmRWdpRyt4VmJNUlIyZXJqbXd2?=
 =?utf-8?B?RCtzbEtuUFNiUEtaNklKbVY0alN4SklSam9HcDlzS09kaVR2SGxLRmtkV1NQ?=
 =?utf-8?B?eE15OU0wWFNFaHNUZGpGUHlSODBxODNrWEZGUktSUlAzak1VcTVUcnloRmJZ?=
 =?utf-8?B?cC9hcUpVa3VFOGhlV3hZSGpBUlhmOGJxbXlxUzlBcVFtK2k3c1pXTjRhcjlZ?=
 =?utf-8?B?ajJTbzVrajFOYmMvV3E2aUF2UVRNWHNERVM3dU5OY1laL2diTnBGcStHUXJm?=
 =?utf-8?B?N2w2YXJ3Ykh2TkdEbzBNZVFIWXBUSVJSVGxOZzBTTUJMSEFoV2JNL29NRzMz?=
 =?utf-8?B?K2hha2JrelJFRnVxNGptT0lPVTdGMzZKejFvZEx1Rzk0V3lnTCtTSmRpVk9r?=
 =?utf-8?B?OEgxQVBaLy9HanplMWVKeDdhVDV3VGRZbzhOU0JmNjlyWVBQNGxhQ2ZleHhS?=
 =?utf-8?B?Sm5HdklaMU9oV0ZRUVRjdkhlekZ4OHV4ZUk3OURFOUFYcUlGWGZCTlBxSnBa?=
 =?utf-8?B?U1FkTm4xRzNzOHZmNFZ4QTFpK0pHQUgrcFY5MkZSamIvM25KcVpNQWJncFFL?=
 =?utf-8?B?cjlzQnRoVkhwZTV3cEdQUllEU2JFaE1uU1pkTjV0NFp2S1cxbUdwdS80WG4x?=
 =?utf-8?B?bDNjcDhHY0pmQ0t3RXg5N1lHSmZxaDdJejZnQ2FTcCs0QWNUakdPQlBEd2tL?=
 =?utf-8?B?UEViSjRCcWl5LzhPUm9jYTJOcHZnRWtWZnNlZzZzVFY1YVlOTHdiaWcydVFP?=
 =?utf-8?B?N3BKcDJLOTdMZ1FxMUFaajNjOStFbWVBTmhJUy92Nlc4WnFxT0tMVXh6dW9x?=
 =?utf-8?B?d1o0Qk4reTFjczRkbmRoa1NuYmJ2aEJnbUVveTlzU0w2MnpXbW1FMlg1N000?=
 =?utf-8?B?QUpmMGp1TnV0YUtwMURWTnU1MHAreTdHenAwS0cwSTZFcW05WHlQREtieFpO?=
 =?utf-8?B?aFQyVnoyWGkzeVlBOUtRbVMrL1d2WVVzK3VVL3ppN3NrbWVRZlFkdnp6T2NB?=
 =?utf-8?B?UHhpcW53WU1WYWVlQk1Yck1EN1lMZlpkVjR5WDBUMlJ5ZXBTSzBaT2Yzd3Zz?=
 =?utf-8?B?aXM5WFN5Vk5jVzBGNjkyd0tMNkgyNjVaR2E5Sm1xVjU2b2x6bHE5cDYwakE4?=
 =?utf-8?B?MDM4cWxhVlBlQlp0WEpBakZjb3FCZmFtN3BvS3pNRmRQelVPTFVVenpqdGw1?=
 =?utf-8?B?dHl0dGFCN2luVmZWK1Z4aGlMRTlFZDFkdVlLdWNldkFyY05VMEhnR0hCZmc1?=
 =?utf-8?B?MW5rTllMUTBQV25nV2JPL3J3blFFMGhnWTJzeFNJeHljS0RnNXROaWxGbFBN?=
 =?utf-8?B?YzlLc2wzUnBIblpkeU9KdTFqTXFtOEZ2QXh1QkJIcFg5VGtiVXc3Uyt4ZmM0?=
 =?utf-8?B?VDZkMCs1eE1HcUZRM0k4QmRkN1I3K29abUFGbUZwMCtiWnRFMEd1Z1JkcTlX?=
 =?utf-8?B?ZmxFYkkvVDcrQW9aWDBzZkUyZ1NJUWlhNjFvSFNORGFXWU5wSDRHdmNwdjAw?=
 =?utf-8?B?M1d3Q0R3R3hmc1NNK2tDR1BLQld0U2tHRjhJcnQvSWo4NGQyZ2JEajIwTEtQ?=
 =?utf-8?B?TFpwRGJSaUtHNTkzTTUvc3JmcW56VFo1eFZ4OFpnS3VVeWIyNnN0R1BpbzBB?=
 =?utf-8?B?ZTVSNlEwc1Q5Nng4VTIvVUdjbUxGbkVpWUJJWWtlclZObmhhWTdGdz09?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 5134b722-8ab7-43af-c138-08de90d2bdd8
X-MS-Exchange-CrossTenant-AuthSource: DB8P189MB0966.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 16:13:13.7192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FKU3EkBsXKbj4i+7ptbBfUhTDG2QlCrqKwime0KToI9oJZsFxhwJ/GEoTEYfOWYtdh41KNmQYLW6tpVwCzBNJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP189MB1952
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,intel.com,ziepe.ca,oracle.com,linux-foundation.org,huawei.com,google.com,gmail.com,vger.kernel.org,est.tech];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[est.tech];
	TAGGED_FROM(0.00)[bounces-233054-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[tugrul.kukul@est.tech,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[est.tech:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nist.gov:url,est.tech:dkim,est.tech:email,est.tech:mid]
X-Rspamd-Queue-Id: 276D538BC66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tugrul Kukul <tugrul.kukul@est.tech>

This series fixes CVE-2024-27022 on 6.6 stable by first backporting the
necessary vfio refactoring, then applying the fork fix.

== Background ==

CVE-2024-27022 is a race condition in dup_mmap() during fork() where a
file-backed VMA becomes visible through the i_mmap tree before it is
fully initialized. A concurrent hugetlbfs operation (fallocate/punch_hole)
can access the VMA with a NULL or inconsistent vma_lock, causing a kernel
deadlock or WARNING.

The mainline fix (35e351780fa9, v6.9-rc5) defers linking the file VMA
into the i_mmap tree until the VMA is fully initialized.

== Why this hasn't been fixed in 6.6 until now ==

This CVE has had a troubled backport history on 6.6 stable:

1. cec11fa2eb51 - Incomplete backport to 6.6, only moved
   hugetlb_dup_vma_private() and vm_ops->open() but left
   vma_iter_bulk_store() and mm->map_count++ in place.
   Caused xfstests failures.

2. dd782da47076 - Sam James reverted the incomplete backport. [1]

3. Leah Rumancik attempted a correct backport but discovered it
   introduced a vfio-pci ordering issue: vm_ops->open() being called
   before copy_page_range() breaks vfio-pci's zap-then-fault mechanism.
   Leah withdrew the patch. [2]

4. Axel Rasmussen backported Alex Williamson's 3 vfio refactor
   commits to both 6.9 and 6.6 stable [3][4]. The 6.9 backport was
   accepted [5], but for 6.6 Alex Williamson pointed out that the
   fork fix was still reverted — without it, the vfio patches alone
   are unnecessary. Axel withdrew the 6.6 series.

5. 6.6 stable has remained unfixed since July 2024.

== This series ==

This series picks up Axel's withdrawn 6.6 backport of the vfio
refactor patches [4] and adds the missing fork fix on top, completing
the work that was left unfinished. Patches 1-3 are Alex Williamson's
vfio refactor (backported by Axel Rasmussen), patch 4 is the CVE fix
adapted for 6.6 stable.

  1/4 vfio: Create vfio_fs_type with inode per device
  2/4 vfio/pci: Use unmap_mapping_range()
  3/4 vfio/pci: Insert full vma on mmap'd MMIO fault
  4/4 fork: defer linking file vma until vma is fully initialized

== 6.6 stable adaptations ==

Patch 4/4 (fork: defer linking file vma):
 - 6.6 uses vma_iter_bulk_store() which can fail, unlike mainline's
   __mt_dup(). Error handling via goto fail_nomem_vmi_store is preserved.

== Testing ==

CVE reproducer (custom fork/punch_hole stress test, 60s):
 - Unpatched: deadlock in hugetlb_fault within seconds
 - Patched: 2174 forks completed, zero warnings (KASAN+LOCKDEP enabled)

xfstests quick group (672 tests, ext4, virtme-ng):
 - 65 failures, all pre-existing or KASAN-overhead timeouts
 - Zero patch-attributable regressions
 - Leah's 4 specific tests that caused the original revert
   (ext4/303, generic/051, generic/054, generic/069) all pass

VFIO + fork stress test (CONFIG_VFIO=y, hugetlbfs):
 - CVE reproducer with vfio modules active: zero warnings

Yocto CI integration (~87,900 tests per build, LTP+ptest+runtime):
 - No known regressions

dmesg analysis (KASAN, LOCKDEP, PROVE_LOCKING, DEBUG_VM, DEBUG_LIST):
 - Zero memory safety, locking, or VMA state issues across ~38 hours
   of testing

== References ==

[1] Revert discussion:
    https://lore.kernel.org/stable/20240604004751.3883227-1-leah.rumancik@gmail.com/

[2] Leah's backport attempt and vfio discovery:
    https://lore.kernel.org/stable/CACzhbgRjDNkpaQOYsUN+v+jn3E2DVxX0Q4WuQWNjfwEx4Fps6g@mail.gmail.com/T/#u

[3] Axel's vfio series and Alex's feedback:
    https://lore.kernel.org/stable/20240716112530.2562c41b.alex.williamson@redhat.com/T/#u

[4] Axel's 6.6 vfio series (withdrawn):
    https://lore.kernel.org/stable/20240717222429.2011540-1-axelrasmussen@google.com/T/#u

[5] Axel's 6.9 vfio series (accepted):
    https://lore.kernel.org/stable/20240717213339.1921530-1-axelrasmussen@google.com/T/#u

[6] CVE details:
    https://nvd.nist.gov/vuln/detail/CVE-2024-27022

[7] Original report:
    https://lore.kernel.org/linux-mm/20240129161735.6gmjsswx62o4pbja@revolver/T/

[8] Mainline fix:
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=35e351780fa9d8240dd6f7e4f245f9ea37e96c19


Alex Williamson (3):
  vfio: Create vfio_fs_type with inode per device
  vfio/pci: Use unmap_mapping_range()
  vfio/pci: Insert full vma on mmap'd MMIO fault

Miaohe Lin (1):
  fork: defer linking file vma until vma is fully initialized

 drivers/vfio/device_cdev.c       |   7 +
 drivers/vfio/group.c             |   7 +
 drivers/vfio/pci/vfio_pci_core.c | 271 ++++++++-----------------------
 drivers/vfio/vfio_main.c         |  44 +++++
 include/linux/vfio.h             |   1 +
 include/linux/vfio_pci_core.h    |   2 -
 kernel/fork.c                    |  29 ++--
 7 files changed, 140 insertions(+), 221 deletions(-)

-- 
2.34.1


