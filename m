Return-Path: <stable+bounces-235515-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iA02DHUx2GmqZggAu9opvQ
	(envelope-from <stable+bounces-235515-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 01:08:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC023D06F9
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 01:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8563730143F5
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 23:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5364539E194;
	Thu,  9 Apr 2026 23:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="De0bWVYV"
X-Original-To: stable@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022084.outbound.protection.outlook.com [40.107.209.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F8E349AF5;
	Thu,  9 Apr 2026 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775776114; cv=fail; b=GCogt8mhoj97IL/trQQml20Q2GVVn9ZhNQS26MdwqKuZCVqWdKQmCAqMWjYIyzDZ35q9/kd6gCeSlAbrJUw7zlsWCf2Kzhtjibk7HUlHYLGvrp4xUB+0HxU14m+0QQsA0igQ+yS0xGVoQpgyd1myEAwbCLYkKBLXbyy5FoeI3hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775776114; c=relaxed/simple;
	bh=xRaCSsjCMyvG4cHkmRROD6LGGcVs9cRZTWk3uq+lpm4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JlKQMpL/ZYdJESrGH9IS+WE7f4RwxHqLpHQpakwfAbW0taEQiNOcT0Pv5WZCjBaAQUI42h+IB6J9+bgqJAxPn9uJ8bYYWHd4bzUPTGw+QrRQgfd+7dnTf3wlOnm/rodJtYNtS0ao7TPSEAUWB4c9+IGFaWhprs+F/p+eTRwP7D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=De0bWVYV; arc=fail smtp.client-ip=40.107.209.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvOUB7XsaZ9ADYvGe56AgGNchRknuCC2XkzjkQ8nTrWwvLCBTy2vJsVx6JJXbr0nAETAQpZ7HVAR8Fa2GBg/YUPQU5431fIEVwBMxGx/LO6Q2ACrD9MSHoE6PP7kOdQr1MvToJKlReRpqsZzssXpgG8Qn5DRqRsfNKIePV2hbKxklxXLkjdn7NQvE3gm/AoS+dGsjZId1dPVpNqGhtA7eXqEpilORe/RFQP1BxNGEvWwq+N8IvaI3hvytMlom7NK45eGaXl7ZIoC8/nSYoGIfLM/rdDlDv2ZUpRpvVVBGEyfLJcTZBXj78g0WE4VUJdPkBLjJzpyWyrBmMvvnb4wAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9wgtMoc030JKunI5yH4mWKVDrUufTBqDqi1JQW7jBI=;
 b=X/l3BOs3KozGVZrt+Do2iIgofwniH7PB1K2Fvqngpf205wJVVlNkHLNsR5fi5arcsI1WX4OXXfWoPOlXQuYyewe9k6MuXI22RkZ0DQ2fFV6qCxpOpNPazV3u2F8FbAwpBFMHFw9j60nGQxNBQQxlwGkJb/I9aOfuF9nryyxP51sDalBsTBLx30VW/FM03MRbu8re2bekmBwx13y6aKLy8agkepsmy7vpy1M08jwwvJ89x/lVujQ/63ZM0He1Bsx3LmBMUc1msatuuVNRFOdjlvHdw7dlvPo2BjdHXkLDWP5cCZ/1KmDztcMxUqAo2arTkbVWRFH3zUIakUqSxA0r8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9wgtMoc030JKunI5yH4mWKVDrUufTBqDqi1JQW7jBI=;
 b=De0bWVYV868pE09uKfDh9VqlZc2/T98M/4m1CzG7lFSnXiFdOz6e04i2zvqYRd7DqIgwH67i19isYkvbMyD0x82BBNzOgxqo9iY81WxujUwVhpNxoO5rUZEeZo6MX4VakF8fgenxM07mZTKqNJmysvGK+F9x1S7vrt4WUASa83k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SJ2PR01MB8322.prod.exchangelabs.com (2603:10b6:a03:536::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.28; Thu, 9 Apr 2026 23:08:29 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0%4]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 23:08:28 +0000
Message-ID: <e4682b9a-9c18-44c5-a892-b12ce4745474@os.amperecomputing.com>
Date: Thu, 9 Apr 2026 16:08:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64: mm: Fix rodata=full block mapping support
 for realm guests
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Jinjiang Tu <tujinjiang@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260330161705.3349825-2-ryan.roberts@arm.com>
 <ac7VD4Z85nS30GCp@arm.com> <ac-W9oNM_O5RTtaf@arm.com>
 <beacee23-c177-47a1-b8b5-743844b617a8@arm.com> <adTPFrlVCEt-hioX@arm.com>
 <bc4a0246-33bb-443e-a885-a31b24d4a022@arm.com> <adTh8d9k3y5ybemL@arm.com>
 <567dff89-9f0f-40a0-ab10-22e061b4faaf@arm.com> <adfDoatH8hj6zN7_@arm.com>
 <07054475-6b07-4b19-a393-cbe037adef8b@os.amperecomputing.com>
 <adfw_hNDsIWwSAIv@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <adfw_hNDsIWwSAIv@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0155.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::10) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SJ2PR01MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 40db0541-49c8-4d93-0b8e-08de968ce933
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	S2d1meR7DHeXHzrBha8HOxOw/3O4eUyWS4+45kpkYtaOJ7xoDABQapm05ORMTyrhZQkDlpLuHb5nwVQJ0km+g6fG/yVlOUiTV8h3uBcFmoalPOxkgFZ5Ou+BhISTCnLH1n31tvzz8YiwdSXHVxQQhe/6TQQyfzBo2zUJ3JrxwzbTuABFCS9daGJ6e8b0ODfbZqy7cxSKObjWWjXi1mIe7tewZd5RMexmG7B3AeJOnwPXWsMqn/kcfZ1f5rr57k4TSq4p2tzwEEhEX2qRWPck+ICYmlOf05F/3YP1W8jEtHMXAH/gl9mAfxTAmhaCap2FEY7LXYJ+MxFFjRylQSLMNLYKnf6Sks3V9wGPzAKPfJV3lIcvJcg1qoZR/HT3QgYcesPM+XmAhkYnHFHClrIXjyYA1+yyAGMURwKcM9OnGf+dCCGdVnR1FRX3QWdC7EbY9LJq53iiqYcvVjpAZS9pUs4WMETl8OvgR6Y1ZvBjwR21Pt5i1Jw5s46ZR6uQoiPUP6EissWmluRJ1tjeKa0epK9zMXqWxe0qPw8I9eUrO6HBgBeCY1oUYpALAxXWXEreVWEQm2vFpjsNqh7Sqjv63QaI0yWrs59BoQzUBNmX463KBSDdjCzp6xNLKCpvPlvmC5GOMp0hz3oc53cxUpZv7NVC+RzIWP8fG7IGRtdyJZKkW+h9MNKeANHSkrAvq+mBq8W5BBTEJJ41pMAWdfHtKwyLyHMJYeOfO96dNofUkT8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1FoS2RKREE3TllzaDRxT1M3MXhLRUxGWi9lTTYwQVI0MzJqcW9sSllEOXQx?=
 =?utf-8?B?NVFkWVEvMzhqdzFWd1ZDS2xmYzlMK3BzWGdDbkl4QVBkeXJMbFRPZXVndmlU?=
 =?utf-8?B?bWkwSi9RZmZCMWF5WitybFcvOHdENGdLc1FJTGRqZGFmVFJ5enN6RFNKSmJr?=
 =?utf-8?B?RmE2Mnk1dHhlcmc3eGhXaGd4bmpmUW1wUi9pN0NVN1MyZ01vVDR5ZHB0T1cx?=
 =?utf-8?B?Wm1EVEZvZUFVZ040VlB2elVKMm9YME00eTc3TjhjUmVpN2Q3eUlOTUNtSGov?=
 =?utf-8?B?TE9JdFlrdTMxbnpBRnAvcGNMOC9QRHllOEdRQkQyUXJndkRPTVo4M3dsdVJ4?=
 =?utf-8?B?VTJNaUxGamduNU9ab2l6T2d2VjdUMUpsT050ekFVL0tBMFd0bmZmRmh1OVhq?=
 =?utf-8?B?NGdhSGFSMGRNSDhoRXNTZCtPdDRXU2ZOQU5PbEpOUkJRa3liekx5bU9JWlZv?=
 =?utf-8?B?L1ljOVd6Y3c3ejVodTQ5c0x0MjJzYUlVSWxVUEFHMmdqL3BBR2xkWksvTG1E?=
 =?utf-8?B?c0ZDYzRlRk9SamlZcEZQMlUvdmhFRy9LZUhWQ3RVeEhKc3pWMnR1SURHSVUv?=
 =?utf-8?B?YXVZMkh6QUdDZ1Z4Z21SY0NjWTFTR0krbzhYRHhSTXdoanNtWmZ2TWxjYkh2?=
 =?utf-8?B?ZkZQNEhJNU41YmJYZnFYc2djRGpHUW1leWVUOVk3MDFaRXNKWFpxdDRCMnlK?=
 =?utf-8?B?RG9kYmU1WEhaQ2MxTmRjb3F2dEZmU0RhSGNLMkI5Ry9NRmlicXBBekkwOFpD?=
 =?utf-8?B?TnhLb3dSWEpFcGptbGRIajl0aEgwMWwwck9EazhtT0wvdCthM1k5QkMyUkJP?=
 =?utf-8?B?bGVraFlMdXppQzJQaFk2L0NVUjN1blZUMlpuZzRLSy8zWjE2QXYrYXRlT2do?=
 =?utf-8?B?YytzaXBmTlpyZHN1bWNkVzZEWjkvb3hIT0ZDS3lWTzR2VTN0Q084MmFlNm5Q?=
 =?utf-8?B?T042SDlNV3JwZk1IODZyZThyVW5Qc1FRVHQvc2dINzV2L25wc3l3QlJjVlRD?=
 =?utf-8?B?bmxoYkh4enhYM21NeHNvcXgwQldocW8ybUYvczVJN0xIZHpMYlg1ZVVINnZj?=
 =?utf-8?B?QkRBMTl1c2s2Q0dwRzh4M3hpUEVpRE1kanNyVlZTQW5FTnorZnV1QXBtTjZn?=
 =?utf-8?B?Qmk0eTJIamVucUVjWTVHNDlOdEFxOTJLTnM4TVJ1bXZGQTJRS3F5elBnV2Vx?=
 =?utf-8?B?SzNGRUR1bnVOTTlwdDFZVFpjSzRzaGRQSzM0MmpjVDVlWDIzbEVraGM1WDF0?=
 =?utf-8?B?WHU2SnZERldwNGRKTGtKWnlJUFZ0QVlGazd1cTZ4c0NwUVhNY1RvcEdkNkR4?=
 =?utf-8?B?UGRBUGk5ekZOWFl2NlNocjRKNFNJOGtGTkFiczBON0RZSW5BYjIrSGZZN29j?=
 =?utf-8?B?elAvV1dUMkM3aUM5VmYvTW1JNTRzZ2hRdjIwdWdTSEF4eFVKQWxaTWNQcFRr?=
 =?utf-8?B?d3pCSWNJU3h3RzUxVEJBSmNVQ1Nxb0VkdnVKZVlDa1VzcFZsUFBMcFU2V1NI?=
 =?utf-8?B?Z24vR0YzUTZicWt6bG83Qy85SmNsQTJzanlmOVJtMWYzT3BUWVN0YytNWG5h?=
 =?utf-8?B?dzVpL2xxVWRkUld1WVZ6TjVlYVZvc0FsUnQrWEY2QXJaNENUWVIzZkpFMVY2?=
 =?utf-8?B?bEthQjIxUEFUVzEybllKRFJlSlMycnN5Y1VFbjYzV1FFNjFyWWdHaFZSQ1hO?=
 =?utf-8?B?bUQrSG8wRWZlRGlBcnNyRUxlWHpEaW5JN3Blbk80Ti9zeHlmNWx2QWlkSTlp?=
 =?utf-8?B?RXZQQTE5bmFmN1BGTm9mQmcxSGY0a1Z0VkVsMHB6ZDEwZGRackE3TGpSMktj?=
 =?utf-8?B?VVJudFJJazdQR0N0bUhiK1VIckQ2ZUJQSVUwbmtKaFViRUtXZ3FzVXFCRlQw?=
 =?utf-8?B?aWtKMUl0Y2ltVkF0bC9nNHI5RWx0WXFidjBGeUJtTHNHeGppMXNNM3JVSXl2?=
 =?utf-8?B?TE5BREc2eVJtV0JzamRSQlVTdlZPWmdLMzdaTGpmWlJMdkdpYXZFVkpud2Er?=
 =?utf-8?B?ZU9PbVBOMkQ0NEtmZklmZlRzd3F2QzBkcTVNNzhpbHREellUeTluM2ZqaUZY?=
 =?utf-8?B?MDZuT0tVekNUcFhCa1dIZzJtbWMyckpSRm5VcGQ1MnhIUWFSc09uaGROZVhE?=
 =?utf-8?B?NmtCeUxLMWNXemE1RUQ2TTNOMjJwZmpUVEU1bXBQSURaZk96RDQzb08vdWxt?=
 =?utf-8?B?anY5UDVGdWRyWEh3MHh5OGFwTUZxV2tmbzJ2NngxKy9hNEk2S3RMcVRCM2x2?=
 =?utf-8?B?S1hINXVwWUxpVHdOZUliaE4yWTFwRmZ0dFJFdFJtYk0yNlRNeHFpRE5BdmFX?=
 =?utf-8?B?aUJEdDdZRHZKbXRRK3NBQXBzWCtBYjlxWGxzQmROQmtVcks0VkVvZ1dDdWVx?=
 =?utf-8?Q?cc8qPZ50f0mZb2SY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40db0541-49c8-4d93-0b8e-08de968ce933
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 23:08:28.7539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SUaHav4RzUwWsMkXwwf5aWoE7rL5SBguTFxdgATp3RNbMLkD8yDB9HkvAL8zA311VufccrH+WvxbW27PhQMjdZaA22Rd2LGuI4OYoAgagA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8322
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amperecomputing.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[os.amperecomputing.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235515-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[os.amperecomputing.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yang@os.amperecomputing.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,os.amperecomputing.com:dkim,os.amperecomputing.com:mid]
X-Rspamd-Queue-Id: 9AC023D06F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/9/26 11:33 AM, Catalin Marinas wrote:
> On Thu, Apr 09, 2026 at 09:48:58AM -0700, Yang Shi wrote:
>> On 4/9/26 8:20 AM, Catalin Marinas wrote:
>>> On Thu, Apr 09, 2026 at 11:53:41AM +0200, Kevin Brodsky wrote:
>>>> What would make more sense to me is to enable the use of BBML2-noabort
>>>> unconditionally if !force_pte_mapping(). We can then have
>>>> can_set_direct_map() return true if we have BBML2-noabort, and we no
>>>> longer need to check it in map_mem().
>>> Indeed.
>> I'm trying to wrap up my head for this discussion. IIUC, if none of the
>> features is enabled, it means we don't need do anything because the direct
>> map is not changed. For example, if vmalloc doesn't change direct map
>> permission when rodata != full, there is no need to call
>> set_direct_map_*_noflush(). So unconditionally checking BBML2_NOABORT will
>> change the behavior unnecessarily. Did I miss something?
>>
>> I think the only exception is secretmem if I don't miss something.
>> Currently, secretmem is actually not supported if none of the features is
>> enabled. But BBML2_NOABORT allows to lift the restriction.
> Yes, it's secretmem only AFAICT. I think execmem will only change the
> linear map if rodata_full anyway.

Yes, execmem calls set_memory_rox(), which won't change linear map 
permission if rodata_full is not enabled.

Thanks,
Yang

>


