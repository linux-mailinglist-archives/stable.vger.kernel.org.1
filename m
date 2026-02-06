Return-Path: <stable+bounces-214696-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEH9MS4uhmn4KAQAu9opvQ
	(envelope-from <stable+bounces-214696-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 19:08:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 282C6101A55
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 19:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD7BE300EFBB
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 18:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF33426D0C;
	Fri,  6 Feb 2026 18:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ipww/TbM"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013025.outbound.protection.outlook.com [40.93.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A335721A92F
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 18:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770401323; cv=fail; b=IIbBW8prbb91Kc2yJKErlxN42yFmTsnSSMyuIMgDvcS7JvzM1zuosvhzGSDiFCx7NpRwt7db9rUNQdBjPJHsggXvIGEVBOP9cd8HtE5R/vxadKkj23kYlAGBBfbYtECdysDFtzfM/l2oji29cZk9bExt0AZNluCf3VQqbsG4V0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770401323; c=relaxed/simple;
	bh=czQq07RKxroZeoHXJq4p5/vsQx+hPRexwMQfIZC8drM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sstml9KuwMdQEeEyGIhJJhkBN0lGYNI6ApoqwOLv2uYZyR3XbSwCP9uKFEfufItJapXwMkXZWJFZWZupSkVMQ173TK05Ep8ENp6UhEIVlJFHMG/AUWPOvsxuPrrwyGT7Iau8krUHcNWcaj/9ai5reAgbn3axKxblb/njip/GlSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ipww/TbM; arc=fail smtp.client-ip=40.93.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osYuA0lX9fmGU/l+T9S8FRvykJkAXmnDklln0AYt+z++8ZDXGIED7QKWR2glkE7heKuRHC0Cm/K3Y/IoPSepe4TW1dzZqunvHfOIshs2+P8+yQEuevGGsh+lFUvj4FcISae56RHlD+X6h44QyCn+hZ0Y18O3Lltjnc+r7KRZxTSM5jPmCoMkHMf5vyirJrz/WobmCQ2R+zNdKt0UTZrIL84BRpgulLXnax4/S+2+z0Y4h39iAsEYBL7NPW7mK0qt5/BYnih/ZfTU8/obtVj6UGJU7Xwb2xZp8cXUOkNv4eBA+lzFLo8RvWJTONYj5DxFKzofPrzl9wuT0inM9Zz+TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7riYsWGba2mVWlXppRYKpiuuG8Hi6hHEHD+hw1Z+F4=;
 b=bwTKYSt7Xq9zXiJzorgo6Zco3U1I8oeucj1qq1KffcX1IDgLWlVFbpbrI+azW/sKaZ9fiGP1YmNUKccQtCtvX02lgYQ4mW3AtRKjib83SX/n+pVi4Czi1MlcN0I5AriG+mzSCWoQFXELP2RUea9/p5l2K0TCmONhVDGvFIzkBt+rrp2O/xk9mFslS7fkwgCkPD2RGdZIEz5l3/a1TxZ30zcVJ+h8Wm2nTH4ZVjW0sDGD16HdIVM/HIJmH8Au6yACdFAHbsaDL8CV2ZB/2ijUknWOcxoyC3zLG8uukmTeqzmnmz0QqinCGTR77S2g6Gfh2ResTbTu8OM8fBFzASvkLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7riYsWGba2mVWlXppRYKpiuuG8Hi6hHEHD+hw1Z+F4=;
 b=ipww/TbMYIG53kIFEKWG3DIIWreuNu59QAlk4PRbzXYwZMUfn9/LeXbvbrPRWw1w+4nACI9W0naEzT9gwhigZSwMGEwNuQpzcWl/hFzk+y/egafGgT9xOurJYMj9QoPDJH18ddB3YfpeaWLoUobr0+BDZFj2IcAvUhc5D+h7MrKynsf6zu1yTEATVQ9rAY59jFmDi6YtAShyjGPdk8cCl677DbZCDpARAclZP5LzEHCrZsQDBL7NQxGiGD4WQc+jL9t+5TWb5JvePBSpu1dXpZT8rrXr2PrcvwqofSGExjRwIS8qvJNpI2BSV1xJNEfrsKI0pFi4LRJ43PU2Di0beA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 18:08:35 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 18:08:35 +0000
From: Zi Yan <ziy@nvidia.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
 chrisl@kernel.org, kasong@tencent.com, hughd@google.com, ryncsn@gmail.com,
 stable@vger.kernel.org, David Hildenbrand <david@kernel.org>,
 surenb@google.com, Matthew Wilcox <willy@infradead.org>, mhocko@suse.com,
 hannes@cmpxchg.org, jackmanb@google.com
Subject: Re: [PATCH] mm/page_alloc: clear page->private in split_page() for
 tail pages
Date: Fri, 06 Feb 2026 13:08:30 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <3BB6BA1D-3756-4FC6-B00D-79DF49D75C51@nvidia.com>
In-Reply-To: <20260206174017.128673-1-mikhail.v.gavrilov@gmail.com>
References: <CABXGCs03XcXt5GDae7d74ynC6P6G2gLw3ZrwAYvSQ3PwP0mGXA@mail.gmail.com>
 <20260206174017.128673-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR05CA0076.namprd05.prod.outlook.com
 (2603:10b6:a03:332::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: db8dd7ce-c8ba-446d-2cb8-08de65aabf02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTREMWZ2NDNrejNtWXdFOU5iVlp5RitVUUw3YWpqeWlqQkhWcGFBRUp2bE14?=
 =?utf-8?B?TFdEdnBab0txWXVnVHdIZXdpSXppNUZHcWlPVkZBMWRHQlhENGl5aXBFODBH?=
 =?utf-8?B?NWNhczVyL2tRaHdtZkFnaHlXck4wekZHZXdrN0M4WjhNL0FzcDZzVnE2Zi9J?=
 =?utf-8?B?ZGZDclVINzdBUlhOWWZPaE13K3k2Wkkxd1BDdDhaSSs5TVBDb1B6dFIzd09a?=
 =?utf-8?B?enJJUWV2T1dlN2psWkczaDB0MTdaZnJCSmdIR2xKbklXbEt6U3dDbzlnMkVw?=
 =?utf-8?B?YW82aVlhZEZWYk9SbEF4UEpPZ2JYVzdXK0FyTENKZ2JvN2hnTWJCYVg2ZklG?=
 =?utf-8?B?YS9SMDVrZ3NFWUJXSU4vQkRRZlVUNWtBOHUrTk1kVE43dldGRnkzTFN5eVlP?=
 =?utf-8?B?bXBEL2NPTmNOcGZEU3hWUkNvVWpHanc5d29UVFROa0s1amVuczJUcG0wbzk5?=
 =?utf-8?B?dUFCM01veWx0WXlpcFF4ZFhEZ1JPTkEvem45RVFkdU1lMWRlYW1pcGRMUUg5?=
 =?utf-8?B?TnRMZkd5cFJ0eEEyd3RBQU5zcElrYmY4d1RpN3ltOVRYYUEvcDR6UmJ2NjdO?=
 =?utf-8?B?Q0dQYzFrdXZzcDFpR0JYMis5L002U1V3d2x2Q0tyVEFwaE1KY2FZOG9hM1My?=
 =?utf-8?B?RzJydmlrN20zYkl6NVJqdTZSeklYU0xtRGZDQWpxSys0WDdjUm9lZE52Tk9k?=
 =?utf-8?B?bTBsSzZsRlNKZ3hLWWl0SWxmdXREMFBCVnBqNTJib3Z1Y1hHYXpTOGtneDZJ?=
 =?utf-8?B?bFlERzlEb2ZFS0ZMMHJhYndZdXBpU0ZxSkJkMGRCSlk5YzBDSnZUMWtLeXlE?=
 =?utf-8?B?Y3BiVHR6aTZzQ1lRZE9xZ2RCL3RESk1IMjgxSFcrZk1lYzRPTVFRUUN5L3BG?=
 =?utf-8?B?V2xhaXNMNlNFZEFpNWN1c2VGRUY3UzNCUjNaVzNNd3FTUGlRVE9BTERwVFVv?=
 =?utf-8?B?ajhBbEozK3N0aC9aVUVKaFdIWkxzeEtHSXFFendJVnBBTCsyNnlKR2JGMEF0?=
 =?utf-8?B?U2xoNTRJV01wcU5RZzN5NVVzK200MkxiWWZ3Y3RRNlFNNGhzd21XaEVEWEh4?=
 =?utf-8?B?WEhqZHd2bk9CdnhsdGhBcDBEeElNanpvUlpBN0hEYXNnWktiaVk5VUYzRnZO?=
 =?utf-8?B?OEpuRUI2czh3WlNsKzFQa3FxZUdYa01BVkM0b0pCV21lNTZIR2JaNjJvM0Q2?=
 =?utf-8?B?N2VxaVVPZnJNOWE4clZaODdaWHdUdXQ3VjI2YURBc3djRm1DTlVlR3I4anU0?=
 =?utf-8?B?dCtic2VlV1ZPdmhjemZ2RHV1bUlGdGxMNk5JT29rdW1SNG1ldld2ZldRTldx?=
 =?utf-8?B?UDFTcHBhbVQ2a2ltZDlLdXA4Vnl2UEppaEVwUkJHaUNydHREK1RWWDRvY241?=
 =?utf-8?B?bCtJYzVzRjJadERBdW9HQUwya0V6U1k1bDI3S21xeU5vYjhkZmxjNjZvUjNX?=
 =?utf-8?B?ZjhBZ0lRMk1va2grN2JBVWJ2YjNrdU5uZXhDZFhGSEtMdlNwRm50S2Z3VElK?=
 =?utf-8?B?cEhlcXRHazNjVmlVVHBNdUtUZ25NRGZTa0NlOGl6dlpDRlNCVnBsY2lDZ2ln?=
 =?utf-8?B?WjZ5QmZZUjJwWnZBaktkeWZ3bDhJR09EU2RFWXlSR1Z5eml1aUZzK2tRRHJM?=
 =?utf-8?B?TmtMMWFzeFVQbmNjendndTRiVS9SZGtOckhoRUI3NWM0QmdoYk5nWHVqZ1pH?=
 =?utf-8?B?VzlQTkh2dkpjR2VTN1M0M01PQ0w4cVh4ZEV0aUJzUGRPR3pNWEJBMW96ZmlK?=
 =?utf-8?B?UE9FWm82L3hhZWpNaGVkSWhzTU5GVlZXWTBkdmppYnp3MHIwTmQxY0ZYNWpC?=
 =?utf-8?B?eFI3Z09ZMnRVbHlJN1g4YnVFRkY3elBVb245YXlHdnVKcGszK3I0ZVh5N1RE?=
 =?utf-8?B?RitlYjlCNDBUbk9OOFI4QVNzVkd2cWtIUExDQTByQWxPSFdMU1ZGVGFIem9P?=
 =?utf-8?B?VUxWVGlLcEVRTVhIcytlVm5MWTN3ck92NGtuZWRmWURMcy9oTUhJN3ZpMFFY?=
 =?utf-8?B?V2JVbnU0WmVycVNZNkpOcnIrQlRwYnAyMVJGMU92YjVmZys5aENsRCsvSDNp?=
 =?utf-8?B?YWpZQUQ1dW9GdXN6QUt3OUVGWjdxRHFiV0lJUENyYzRSSzlzMUZwMmt0Uzd0?=
 =?utf-8?Q?u1Vw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UklyT0E2eU84MzFzVERjTHNZMkNiZGRxaXByTVdaYmpTQmFERFU1cmpjZ2RE?=
 =?utf-8?B?WXo1cUZacUlYQjFNYVhmc2Z5cGl4NXgySVVKUFNGS0VPa0oyWTFEQTl5ZXVT?=
 =?utf-8?B?cmNzVldwOWNoK0FnRXhIZnpydkkyVTFEMTJNenkvQ2ZpbDZDR1FlUjRJeVgr?=
 =?utf-8?B?ZEw3K0dibGE5ZDVqVEhVWk9IdmFGVzIvczB1WXVnSlhSQmhMMDhnak5kampx?=
 =?utf-8?B?bGFpMEhWemdHOFp4YVRic0NISDF2VmszWWxtTXB3eC9ETlpObHpINi9FSjFj?=
 =?utf-8?B?b083eFFZOERMQjdXM0xtQ2pQdTJnTEtkVW1EelMrcFpPblVZTG5leXRqSDFi?=
 =?utf-8?B?SFRkVjVOQlpUYU5BTTRaTnBpWDJWdVFWcFF6N2ZuK2lKUDZEc1NKalM2cEg4?=
 =?utf-8?B?N0JZYTE3b1BNWWpXSFpSWTJZb0hPdWw1NUozMjl6alZDR1RKOE1SM2lJWEE3?=
 =?utf-8?B?d3cxa2NZazFVVjdRdFI2VFlQbVNnYUV5dEdSU2hsQUx4WmZoNWpZOHRkVlNj?=
 =?utf-8?B?VkxTVmFVYzVUWkFKSFd0SlJkUkxCc3NhTE1KWWhwNTkxMS9mMDVGcnRJdk5s?=
 =?utf-8?B?QUNNNE5DVitYbVNqSjg0bVpqZzQrYmhob1FTdVpFME5XZGpOWEx3eUxPaVpt?=
 =?utf-8?B?KzhWNElCK2JjcllnanR3dHVaVGxSaVZPSHQ1WWhIc3JmODhDd1Y4SmpMaTB3?=
 =?utf-8?B?WVIraEFtV21vRXFXdXhMYmFMTjNhVWNjZUtEV2V5MHVUd2VqSEhOUUFyOHQ0?=
 =?utf-8?B?bDJ1Zm5DbnpNQkcwN2oweDZLci9FSms0amZRWTFRTzJmaHh4RVh2MXRja3VV?=
 =?utf-8?B?bTU0THVxYUx6VlVsYm9mV2g1ZVNXdmxTOXhxakhUSjZ4anhQbTlpVVlxblVP?=
 =?utf-8?B?bnlTUUlpbGk5ZmtnREtyUzA5QXRrS0d1WXdFeXgraG9LSUVqOHZwNHVpc0xY?=
 =?utf-8?B?VGs2dnJ5Z2dFaklkR2twNVpiKzNyb2haRHY5NWs0NTVHNE5aeGVmeURsZlVn?=
 =?utf-8?B?b04xVWVOeWNTekFCKy9WckdHbGJmczk4cytUTXNtUHl0NE96UjBXYkR6Z21z?=
 =?utf-8?B?bUErMkxNQ2E4QW4wc2QvRG9Zbk83cFk4UStiSUNreUZaNTlCT3haeEJQZ3Vk?=
 =?utf-8?B?SEc3ZE0vRjIxZ05qK1dLSTdrVER5dzBLamx2dUxxRXJwalc1MEdweG1iSFpn?=
 =?utf-8?B?ejhZNTMreWM1UlZRY1BTOXN4MC9nTmZveE5YaWxWRUVWdUs0dTlwUVBnVlRE?=
 =?utf-8?B?QTl3bVpzWHpWYmpEblQzeFFTa1huRW1UWUtOKzlYMEViZGpvbnpodzNmREY3?=
 =?utf-8?B?Q3FjbVEvbEJURy9rYjZTUVhaRXUzK2l6WURnQmNLeFVjMTNSYkFQb1FWZUVw?=
 =?utf-8?B?R0Y2bFNyL1BlMTZyRUc2aFZseHVmMU1MSG9YR1pFMzV5SE9oc3dhY0M3KzN6?=
 =?utf-8?B?UEx5S3lXa3YzcDk0VGRZbGRYdE1rdUdUZkFPWDA2N2V2akNqVUI4bDVnMXNn?=
 =?utf-8?B?MmZpWjFqNUdVN2NINm5paEhaSjZGUGFKbGVFRVlpdzZ1U280UEVaMjBrWmk3?=
 =?utf-8?B?YU9XY2E5bGFqajN4Q0dDUWtUTmQzSVEybE5NQUdibGkwSE9xVUgvOThnZWVG?=
 =?utf-8?B?d1IrWUNxL21HVlB4TjdjRlNxZWZSRWt4OEJsZFZSTkRYM2QzNW9vVXZINEEz?=
 =?utf-8?B?b3Z5d09qNkJxQm5OcDJLSnlmcDR3Ylh2QzdWWFFOSGc2ZHJqdTI4Z05PTldD?=
 =?utf-8?B?VGo5WU9QWWVML2ZOd3lOQ3JiTGtGdXI0MnZ3Zlg2RjY0aVJtMnhBNzFQZUtP?=
 =?utf-8?B?NXoyVGpxY2MwMkVZOEp3MkhFbzlsWml5ckk0QWNPZnE3RWtZVlZwcXQvZEFl?=
 =?utf-8?B?ZUZKbTZWOFc2N2dITm5yNFhkWVN0OUlYYmtpR2Q4ZzV4OVc1anZPWWxGWVVp?=
 =?utf-8?B?QjNQbGk4UjMxVzd1V1FvaUMyanVla05qam1KWC9hajVmSHo4YlY4SFovRVFV?=
 =?utf-8?B?ZHV3SXozanJtM0VWdHA4VVBkMjFwS2NwWG5RTDJpL21IYVVjRTJkY3dVeGhu?=
 =?utf-8?B?QmRRcXYvdWUzT0JxT1dSZytvZ0VVL1dqeUxpaHkvV0l1Qzl0WUQ0QjJNeHBI?=
 =?utf-8?B?eWc2WURMUWlWQXZsOGRwODBGMjBvWmZWN3BzNENVaitIbXZ1Wm9hVWQrSWtk?=
 =?utf-8?B?WVFvemdIbjBVRUZ3UmU5dlFNSlZvNjJtc29MVlU0QndsRTBXRWpVS0x3Z0FJ?=
 =?utf-8?B?OW4rczVGY3UrTGhkbWl0eW5UV3VDWXQ1ZFNHZmFqa2lEWlRwQ1piWHhvcmZS?=
 =?utf-8?Q?RrhIsQrus4Tkv0rkHV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8dd7ce-c8ba-446d-2cb8-08de65aabf02
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 18:08:35.8300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLSUfiXezz5rMqipMGLO1WGnK5zEwji0SVCnwZz+echvzNaW7uvHL+VWFKprvCTu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214696-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,suse.cz,kernel.org,tencent.com,google.com,gmail.com,vger.kernel.org,infradead.org,suse.com,cmpxchg.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 282C6101A55
X-Rspamd-Action: no action

+willy, david, and others included in Andrew=E2=80=99s mm-commit email.

On 6 Feb 2026, at 12:40, Mikhail Gavrilov wrote:

> When vmalloc allocates high-order pages and splits them via split_page(),
> tail pages may retain stale page->private values from previous use by the
> buddy allocator.

Do you have a reproducer for this issue? Last time I checked page->private
usage, I find users clears ->private before free a page. I wonder which one
I was missing. The comment above page_private() does say ->private can
be used on tail pages. If pages are freed with non-zero private in
tail pages, we need to either correct the violating user or clear
all pages ->private in post_alloc_hook() in addition to the head one.
Clearing ->private in split_page() looks like a hack instead of a fix.

>
> This causes a use-after-free in the swap subsystem. The swap code uses
> vmalloc_to_page() to get struct page pointers for swap_map, then uses
> page->private to track swap count continuations. In add_swap_count_
> continuation(), the condition "if (!page_private(head))" assumes fresh
> pages have page->private =3D=3D 0, but tail pages from split_page() may h=
ave
> non-zero stale values.
>
> When page->private accidentally contains a value like SWP_CONTINUED (32),
> swap_count_continued() incorrectly assumes the continuation list is valid
> and iterates over uninitialized page->lru, which may contain LIST_POISON
> values from a previous list_del(), causing a crash:
>
>   KASAN: maybe wild-memory-access in range [0xdead000000000100-0xdead0000=
00000107]
>   RIP: 0010:__do_sys_swapoff+0x1151/0x1860
>
> Fix this by clearing page->private for tail pages in split_page(). Note
> that we don't touch page->lru to avoid breaking split_free_page() which
> may have the head page on a list.
>
> Fixes: 3b8000ae185c ("mm/vmalloc: huge vmalloc backing pages should be sp=
lit rather than compound")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> ---
>  mm/page_alloc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index cbf758e27aa2..3604a00e2118 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3122,8 +3122,14 @@ void split_page(struct page *page, unsigned int or=
der)
>  	VM_BUG_ON_PAGE(PageCompound(page), page);
>  	VM_BUG_ON_PAGE(!page_count(page), page);
>
> -	for (i =3D 1; i < (1 << order); i++)
> +	for (i =3D 1; i < (1 << order); i++) {
>  		set_page_refcounted(page + i);
> +		/*
> +		 * Tail pages may have stale page->private from buddy
> +		 * allocator or previous use. Clear it.
> +		 */
> +		set_page_private(page + i, 0);
> +	}
>  	split_page_owner(page, order, 0);
>  	pgalloc_tag_split(page_folio(page), order, 0);
>  	split_page_memcg(page, order);
> --=20
> 2.53.0


Best Regards,
Yan, Zi

