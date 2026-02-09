Return-Path: <stable+bounces-215520-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GO8A9oGimluFQAAu9opvQ
	(envelope-from <stable+bounces-215520-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 17:10:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF7E11257B
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 17:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEAB1302BA5D
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 16:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B993806B2;
	Mon,  9 Feb 2026 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ugs8EuYs"
X-Original-To: stable@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010006.outbound.protection.outlook.com [52.101.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FFA37BE81;
	Mon,  9 Feb 2026 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770653335; cv=fail; b=VnB5pIIaKmkNdre+fOYQyvMlhmdslMTOeW6K2a19d0HlZ0wyp0LdZk1fznvDWGl7Bi05bB67JOJ7dQl69jaJy17dGbnRYdyqQtv5PodnZy8TnsMB17ICaDvCLAZUv0JyorNXQEQWqzPdnqs9raMQ90ibvyqJLs7WnTYZrVl98yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770653335; c=relaxed/simple;
	bh=L3c2g6ThXvdAfXXVM0BySgkNh1Ws/55ZScmOvtX7nmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NR4xvpHlrTHvimmfgmWxsBcpcLwHJwwOUGtD55mNTDVgcFhYROTvgpfBOmIxjZz3Dv2bnxgaZQvrnmKUvQh57wQRY2NWpgMuJcfSqr49hA2D8cjYacguBQq4ELIwt2tKj3Biuc3FNgAohfKDmKDjDUdCcN1C46/sxSKVDQ6tyZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ugs8EuYs; arc=fail smtp.client-ip=52.101.201.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apeW0T9MHCY/ILLXWAGCK2HcWayszd/ta25Y8xDlUuvyZECi5MwmanRrE6pWLDZR0bBnrqC3IXuKdRfCQAP+24fb31Y6U6w4w+6qdgY5nxg5Tvato5Z+d1FBDvXNsCiaAgW29FjoK1BiMBoZ0m5/fBbm4KP6YxmHcPIkW31PRnpDucbcpMpwvWU3hwAZO75zWmYb3bwbp4xJaCNGnZeo87i7TEUH9Gn8I3XUYwFkhJOPEKCJP9kWZQY+tlw+hadc35gAkGkGnTF1p6aP5j2pUYSj8505MRivwh4/uSt7H4PFcqeU43D+yxONVbZddP7mq6UPkcu7D4o78bNMlQOPlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3c2g6ThXvdAfXXVM0BySgkNh1Ws/55ZScmOvtX7nmY=;
 b=E1cKGIc7EkkqVqScJvjRdqbfAfqVxmXXEcTJnop0n0gJK5bsJ+H8XlzaqQe8cHCEGo4OgXWGb9DXh3rHpSQabLG2c2MmFf+G7hkuUl1UclNieL3mrXO8k4n85smx7++Yj6/HsJiSM8f3Li56tG4Yswa939nA8YKZbxOfIAAOb/OBvd8L7ZT4op6474XmzP0b+z24VPrythoNoebI7hqVxTuaJEg1E5Zn8u6rHgUTkyOc7O5wtKWioeS0H/aLsaLUZdOA40JQRtnrcJllM4pkYj6cJN9dQDq9ehtiCSSImwQ77fa/xAqWgGxj1c+4WNhoQy6ePA7kBhT5lYy6I1OmMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3c2g6ThXvdAfXXVM0BySgkNh1Ws/55ZScmOvtX7nmY=;
 b=ugs8EuYssoUlxC9jR/dZBYmF5nWfWx4JEE9eWhYA882SQhUnhpMyxasfwFkrJ5MlQiJdqk2Tcg6t+20KpoJNyt/eRmqFdXXKV9+0VdwedKZYEXiy7TIviwJry5s7Aj23y6ExwNLKGGe2UifDxPcIsTncMwZECogQPyyb5Nr7WGPDqdwm6EWX3Xk8gUwWXoOH/IaZnuDgcQiO70ba9zejzSaDJzK9h4aHbxbyLUxMXUiC1Lvj+23NdTr9DAX2bUXQTL81IK4Twvb58QCF3B4KBOTNk+0aaDClpuJqGPS5iyR6fIv7Sl6yi6CYhNAxdx1Z3prEDoBHKNvKL4gqcPsBTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB9068.namprd12.prod.outlook.com (2603:10b6:510:1f4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.15; Mon, 9 Feb 2026 16:08:51 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 16:08:51 +0000
From: Zi Yan <ziy@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org, surenb@google.com, mhocko@suse.com,
 jackmanb@google.com, hannes@cmpxchg.org, npiggin@gmail.com,
 linux-kernel@vger.kernel.org, kasong@tencent.com, hughd@google.com,
 chrisl@kernel.org, ryncsn@gmail.com, stable@vger.kernel.org,
 willy@infradead.org
Subject: Re: [PATCH v3] mm/page_alloc: clear page->private in
 free_pages_prepare()
Date: Mon, 09 Feb 2026 11:08:47 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <3594E090-CA8C-4726-9738-5F445092DD61@nvidia.com>
In-Reply-To: <3b95bb12-5642-443b-b163-8b5f5f6400c4@kernel.org>
References: <209207FE-D3A9-4BE2-8DA7-9BE38A19F387@nvidia.com>
 <20260207173615.146159-1-mikhail.v.gavrilov@gmail.com>
 <cbc3b5b3-09b5-4e3c-99f0-a1f67582afff@kernel.org>
 <51f96b31-fb59-4cda-9d33-e3cebc45686b@kernel.org>
 <a38fb457-c0e8-4089-a31a-ac59d06a796f@suse.cz>
 <c0b93b3f-bc4f-42f6-8287-72d015a0a79b@kernel.org>
 <FD637A2F-909C-4039-BEE2-B60F85FEC7E8@nvidia.com>
 <42b977d1-4873-4b3e-9107-7055836cde11@kernel.org>
 <CD2D5EFD-53FC-4E0B-B7B8-023495867C65@nvidia.com>
 <3b95bb12-5642-443b-b163-8b5f5f6400c4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY1P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::14) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB9068:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f2fc87-3070-4c9e-3d6a-08de67f5843b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UCtzSXZGcVMvSFl1NXBoSnFwUG45QjJka2g0aWcvajVmWklBRHNKVS9Md1ZS?=
 =?utf-8?B?NlJpNUdiV25EWXNzazB3ZUpHQ24zTGFNdVMvZnlWWk1yY0Zkb2tLMmtzcFd5?=
 =?utf-8?B?c1VkZDVubTBPNStHamQ3VzIyYytSVE1EMDFvemJzWXJIeEprOEFYRGVWTVpK?=
 =?utf-8?B?U0xVVXF5aEVBSXRremhMR2V0d0UwOXlscG43L0V1ZXdJRHBvbVBSSTg0a1lH?=
 =?utf-8?B?OXRtSXI2ajdPUmxJK1UwS1VFSnlYT29kcmw4VlpobTNqSlQ5M24xVEJXRzVD?=
 =?utf-8?B?TWRFZytDa1BtTCthWnRxMzdOWDd2Z2hGcTA0eE1sQlYxY2d4WFgzZkJhVjZv?=
 =?utf-8?B?ZEhWc2JvYll4V3V4QlVtRTR3dGpVWW9odnptUEkwbFUzYW1hSTAwUGswbkFm?=
 =?utf-8?B?L1U0ZDRQQ1dZRHpUdU41cDdOVHE0U01BUkhjREh2ZmxRckpLRzhrZ2g2V00w?=
 =?utf-8?B?N1dsLzhGRjgyN1V2RG1FRFRJM2xVNXlOZ0FuaDNCTlZYZUdpSG9iMllYc0J2?=
 =?utf-8?B?UTlCRGxBa3YybFdpVnNYSFE5R243QjZ0Yi9IT1F0ZjRvZWRMcmJkWFZMSkw2?=
 =?utf-8?B?bGQ5SUV0NndQYjZuOXQwdE9DN2pldWdEeUxyOXdiSS8xdmxEZDYwV1BxQnVw?=
 =?utf-8?B?QjA0eDBRdFZRT3hZcEVGOWtYOFB2UDJ2UkNqNUx2NWYvLzVhWnJyUGoxSWFB?=
 =?utf-8?B?TUkrV0tqeEZ5UlhpQkNmYVJKdUgySjhJTHNWd0R3b0NZaENRQUpVOEk3cHBy?=
 =?utf-8?B?NTZnYnNQMmo5RmVCKzFjV2dVaW1IeGtjeVJwL214cUFQUkJ3djc0N1JsODJs?=
 =?utf-8?B?clFIMW9OdXFEc2ZudmFSSXZ6NnVmcU5MWlJCdE1QNmozZm92MVB1bktDZVFj?=
 =?utf-8?B?S1JPb3hCTHg3VnZweXdON05ub256SEt0YkZUNmRsRUlyUVpMalJnc2ZQaVRh?=
 =?utf-8?B?aHMvNEhEWVp6anVXb2ZWTWdYV21ibHdmK0RqaWsxdEU4Wmxkc2NnQmFWV0t6?=
 =?utf-8?B?M21oM1hkSDVvZVVubDZ2eHJ5dHA4bEpvOEtVQVZ3aDIzZmlqaGdoUHdtZzds?=
 =?utf-8?B?QU5MMFoydVlYTzlqdENqWFAvTWZhT2Z0TS9QYXowUFlrWkNVMUNhL3I2RjlE?=
 =?utf-8?B?bjdEZDdLeEUydXE5SlhwbzUxNVB0WUFidURLLytzb2JWSHBYR3dkaHZVYUZ3?=
 =?utf-8?B?TUhzNlp5dEc3eHR3Zkc1UlhUTitKektmRVAvbEFGWGEvMEoyV01vdEZYMFRW?=
 =?utf-8?B?Vmt6eXZ6R08zT2p5bVVQRm9PQ2ZRUjZ2YzFrYzNBWHFBTEk0NGpzbTYxZTl1?=
 =?utf-8?B?U29ab0NML0h1Ymt3S2MxU1JHYzl4SXR0Y250cENmblN0VStTOTlZSDVkNnVY?=
 =?utf-8?B?bFRGVjdqNDFhb1BhcWxwY0JXUnV6UjBPOHU5QnZ6d2NMM3grODd2Z1J5dWFl?=
 =?utf-8?B?amI1WWZCQjNRSzg1NVExaUo1aTBSN0VLZHE2YWtLZ3NXNXd1SG40bUtWc25R?=
 =?utf-8?B?RkJUOGdteXNVS1MvNUNTR3lndCs5M3NMQ05RYWVXRVRNQUVuVnQ4aE5sU2xj?=
 =?utf-8?B?RDlNSFR4bnY2WGRJZlhmS3JVeGp1NEhSbFJmbmxWU1ovY2pCRSs5TEp1aVNZ?=
 =?utf-8?B?M1pndFZUcG5XZU84NlB6R2lzM3FRMGJ3dFdSTUhLNTZKS214Z3ZjVTVkMWdr?=
 =?utf-8?B?NElrcCtqTzZHOTZLcm5sckJRYnB4NmZidVJhSjZ2TVZKeGxZck5hYm1pNkxC?=
 =?utf-8?B?MlZGK2xZb0RXQlB6RHlNR2hCempBS3dra040VnpQZmNmV3JGZ0xuclp6Rmh6?=
 =?utf-8?B?V3B3V04wNFhZOUo3L3VpbnA0UDlUWkNPQTBsZG45ZW5jSTlIVGZOeGpJUHRI?=
 =?utf-8?B?YW5aR1M1bzEzOTcvbWUyb296ZHhCWGV4eFhHSEl6dThFQ0ZiNGgwMllNdkNN?=
 =?utf-8?B?RGFUZlNDMEFHUVFxdzlRcTU2V1lQNEduSUM4dm14QVFoRHMrYmFSS2VGUGxS?=
 =?utf-8?B?cFlXYk5hemgxVk1Jemhwb2NZTWJFRlEwcWN2bzJ4dkVYY3VhY2w4cHlyMTBP?=
 =?utf-8?B?aVRrUzdtUVgxYTlrZHBNK1BuLyt5eGNPTW5YMjVxM2RKazFsdE8zQ1VzTW8w?=
 =?utf-8?Q?TDQI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0QwR1JNakRJbXhpWUMrT3AzclprM1BXY1pQQ0k2S2h5UmxrU2FkNUpVTVA4?=
 =?utf-8?B?Q3pEQ0FkZmZLcGhFUzVGNmdzZWRZSzR3ZjZENExueXJ1RUNUSHlMZGRKOStM?=
 =?utf-8?B?U3ZYSTNGRVByODgxZGtYc05NZ2tOeThJNWpwYW1Ga0dvWjJsSG9ORGxSNVRP?=
 =?utf-8?B?V1o3OXhVRjVnMzB0SVNDNFlVYVovOHdVajdtZHJZdFoyZTJpcUdGV2xVVmdt?=
 =?utf-8?B?UXZVZm5ZdHNZWnFsZnkrdmhrNlZXVk9DczU0YkZWZWlQazd4enZwQUJXRVUv?=
 =?utf-8?B?Uk5WVkd5Q3duNWhQTHUrV0I0bjhNTGtrRnlGTmtyUm9xNUNncURrOENncDUw?=
 =?utf-8?B?c1o2YW5lbFpSQ0xqN1gwQ3JjSUw4b2U1b2oxbk5DMWNVY3N6SVhMZkFCMm8x?=
 =?utf-8?B?eHRIdzBlUjNJQVRRK2I0ZHNQaTl5d2hQQk5BRHh2akdJVWJNMXo2MElZOGRE?=
 =?utf-8?B?U1lNWmZuaHlqdUZGWFU5TDZSSDNIMWwyeW5VMTdXaTExcStCRXJaVDVrRXd2?=
 =?utf-8?B?eWlIeStPWWRTN0laTjRzM2pjTEVUbzQ0NDN2QUF6YktrZlhGZDBrZVdaTzl0?=
 =?utf-8?B?eWNVaDdHNy9zeU1KVTl6TTdwRG9wM2FpeEtzS0U5QitKQVNST3Jtajk0RGFH?=
 =?utf-8?B?YXJ6ZGp0RmMxbDBHdktpZFRrMHBRcGlJeTNEcktRSjRheDcvYzdBWFdlSzRC?=
 =?utf-8?B?THpEUlY5NzBqRmRhUmkvVXNLT0JtaHArT010bVNNbDlsajVrcFpZQi9HU1Vy?=
 =?utf-8?B?NXY0Qm1rdlVlMzJDK3RPZ0x1VHhYOXpHWjdZK3hpdUVxVS8zdnJRUnNuMG0x?=
 =?utf-8?B?N2lkWjdTWDVkQVZYaFRuZ1RKRHk0dDQzZkpDRHNONiswa1duWnVmOXhkOSs3?=
 =?utf-8?B?MDRwMmtFNGpaTnROWlVaRXU2cFprVzBqNU00dW5DQkRLUmFLTndwODUxYXk1?=
 =?utf-8?B?Q3MvYURKNm9WT2lxaEQ5WWhEdU8vc1BpdTdsLytUekZMQUVzVjNhQlhuVERG?=
 =?utf-8?B?eWxqUnprcHRySjlvY1hOVnE0NFl3ekVuNFc3bkJvakU2SXNIQjJVSEt1WmIr?=
 =?utf-8?B?TjdsdTloZkJQcll2U3NmV3dFN1R4UGNsbmdUZEhCVnF3Y0pMMFJadG5zYmZF?=
 =?utf-8?B?eUEvcHpwSWhJb2lIdW92czNLL2VEVjBxUGRFa1h4Mmc0cnp1YWE4WkhzcWpM?=
 =?utf-8?B?UFp4K0dOQ295ejN6cTREOGhxak5taHpac2NWUmJzaVVIUURQUERZSktCRk45?=
 =?utf-8?B?d204SVU3YWxxMFA2ckUxam9kMnlKMWdmWXhaODkwMFFxbEpubTVNMzRlWEE1?=
 =?utf-8?B?WjVlTUpJSnppWFJqT3pxWE1YWXB4OXJMSSs5UWczU3BRZGJnZ0wxSjRVWktY?=
 =?utf-8?B?ejVHZWFXak5Kb1pvbmJOSHlvNG9FNXg3VFpGQmlpSWhRK2dlekpvYkVGbkUy?=
 =?utf-8?B?b3VLRENTMVd2NzNNUHV6ZjZLQW9ialFuVWcwcnhmeWphdEpsYnlpby9jdlFk?=
 =?utf-8?B?SUtFa0lHNm9iUDV2N0g3Y1Q1djNTbGpVQnF4QUkwN0pVZXMzVm5oMkgvWkJi?=
 =?utf-8?B?RGtZYXNJUG1mZDIvaG8yTXp4Qms0TmRrRkVldFh3bDkzR3kwMlNUSVdRRTVm?=
 =?utf-8?B?enkvRTZqNXAyelo0eWtsQWZJWjh1TzZtU0tMZzVmVVBJZXozUExYNEJtTlhl?=
 =?utf-8?B?aTBuMEJPLzlrck96Z3kvVDRGelJYWXJUWkFHeFRMSlZxMGNmaFdpSldTc3dr?=
 =?utf-8?B?b1l5N3VoaGMwNlQ2QnRzVENxaHZUWVVXbFJWRkU1U2hzVTQ0L25vWUFEbDhJ?=
 =?utf-8?B?c3AyaHJKZVdRSEhLOE5KcXNYeW5DeGFWM3lQdDZqTmJwcmpuTmNlWjJna2Iy?=
 =?utf-8?B?VTMvZExhalRCd1FjaDYzQjUyZWRsY1hBOHNFZ1RlQU5mL2JDZHZGbHJYaytS?=
 =?utf-8?B?VXZoYXh1c0dXTU02S2hXendPVit0THhEcy9SSjY0K1VqaEhLVEhaeU9JWEF1?=
 =?utf-8?B?enRHTHhyb0VSM1F4dGNxWitSc0ZDL3pJK2RQQWJFMC8rOWFaUHlUa21mUWZ5?=
 =?utf-8?B?U2FoeEMwMzkvc3JsYlhXYTBvbzFGZ3FGcFl2aUZBdUVQTEc2Q2wzTlBWMnQ2?=
 =?utf-8?B?TytYRysrZm5QUUtodmVFdHJINFBWUWcwQ0QvOG4rNWlvaFdpelZSU0RrWGRP?=
 =?utf-8?B?dVdCWHVoeFF2MHd4eGl6Vk9KTE84OVRjYmU3dzh1S3pGT0lwZHFIbXUrMnJK?=
 =?utf-8?B?dnRZdGVoWG82dVd3VjM4QXJIbm43dVhLK3JvbGdFUmozcWFUOGZaUlhlTHZs?=
 =?utf-8?B?TzBxNDh3VnphNkViQmtMNWxqeWdEZUV2ODJNVTB4NkJPbWJoTXlTQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f2fc87-3070-4c9e-3d6a-08de67f5843b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 16:08:51.7537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmPSb19ECJU3FnOxb/A9lsLb/Q9u9Wbk/jGfI7DbIANoyzguzaqNPFU5DFnMoH/N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9068
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
	TAGGED_FROM(0.00)[bounces-215520-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,kvack.org,linux-foundation.org,google.com,suse.com,cmpxchg.org,vger.kernel.org,tencent.com,kernel.org,infradead.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid]
X-Rspamd-Queue-Id: 5EF7E11257B
X-Rspamd-Action: no action

On 9 Feb 2026, at 11:06, David Hildenbrand (Arm) wrote:

> On 2/9/26 17:05, Zi Yan wrote:
>> On 9 Feb 2026, at 11:03, David Hildenbrand (Arm) wrote:
>>
>>> On 2/9/26 17:00, Zi Yan wrote:
>>>>
>>>>
>>>> Currently, _mm_id (_mm_ids) overlaps with page->private. At split time=
,
>>>> it should be MM_ID_DUMMY (0), so page->private should be 0 all time.
>>>
>>> Yes, it's designed like that; because that check here caught it during =
development :)
>>>
>>>>
>>>>
>>>> It is still better to have the check and fix in place. Why do we want =
to
>>>> skip device private folio?
>>>
>>> I don't understand the question, can you elaborate?
>>
>> You said,
>> =E2=80=9CBTW, I wonder whether we should bring that check back for non-d=
evice folios.=E2=80=9D
>>
>> I thought you know why device folio needs to keep ->private not cleared =
during
>> split.
>
> Oh, I thought there was some overlay of ->private with zone-device specia=
l stuff. But I checked the structs and didn't spot it immediately. So I end=
ed up asking Balbir as reply to his latest series that got merged.

Got it. We will bring it back once we hear back from Balbir. Thanks.

Best Regards,
Yan, Zi

