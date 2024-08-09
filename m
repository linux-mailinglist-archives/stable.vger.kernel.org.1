Return-Path: <stable+bounces-66273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A94C494D1FB
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 16:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBCC1C2119D
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 14:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE101953AD;
	Fri,  9 Aug 2024 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tP03oXGk"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083E3193078;
	Fri,  9 Aug 2024 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723213040; cv=fail; b=M4J5UTpztV0r7wZwrDr9z3aREQv8g0K5as6sO5y3dwRWbJ/P7rcT9ODC85hIXbny6fxRD8m+gqljnpTkgFNFl7s8fJ44SJkP+8Wa0Kq42pydwKIM/MaxS2IhpPjmrxTFD74FabpQlKg8nXzYWh3qGZTfY9SEZE6M0KwMpaaDKxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723213040; c=relaxed/simple;
	bh=LxZVW0x9hj/+Kcr7kNPRpLK9Y/F5+vsYmy20dCEYjok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gOWju3v6+3e3U9QNZsE6phuV6IMrp4+NVvT/gH6ThNGJGaOehsWNiE/P19mSDpziRDZf3arnXRl4VU3dlF3wMDUjHhrlbVE2yf1yvIkNtTNTfCizdFsW8t120qV7YBjwXBlG/5pDwSYXo9/XsX9gziC0W9d1ha8Yiw+kNZxtoc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tP03oXGk; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKgZbEN4qnimHX2JFGrYyso8WCxy4b48h69R8R1nH/c9geHPEVy9sw1Q2rBxZruG1O6rQIZDI6igKHCXFDt85qPSlkCABMsxUh/GKiJkrB0VrEw+k4iXz4k5Fn+BeUvDFLOkBKdUFT8O74Jae0ZPe/4r27vNIf1dPgFzW2FQvcETDVFtL8lyQr7Cx9tIkBwWd6wvksTxt8M2p1hSJcKrNiD8HPushiQXCi2k2FdDLcLNnb2xUAufQcHur9jqPEzcnyd5/pU4z+A6LZHsExSOAATq7c8Ozl1ObkqH50K9O6lQStlkX2JthnKA2NW1tOwPhnHMtC6d8utuI/yWPs7nqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxZVW0x9hj/+Kcr7kNPRpLK9Y/F5+vsYmy20dCEYjok=;
 b=OJBDZ9hQH3cUZom97/kE4haHrttu2YZfoYnnhl8evtIHajYej3jvUCRrU/8TkiapI8BR78efnDNn02+U0Bv8TE3fCyvAytRpoUHP8KPG6hzO5QKARGsnOeyqq/FeXGn4nolQVMpDG5hIB7HjVC7vwEC1AOqI+Vv0UMYbTYbELQFxUkADF3+SYcfJDvttxhpTGgiNUNaBJ6vUPQEXGlj12HNtbAybAsemtb1+Y0XFALVEnQB1edAGD1Ux/kxzeXcBgSEKGge+7RYXoCDhBBZoOYwymtWB4Q7vJqbwFW2whZ5wdQBLspXa06fWSmwvksrGQiorfAYmVtNuGjsmrr3ShQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxZVW0x9hj/+Kcr7kNPRpLK9Y/F5+vsYmy20dCEYjok=;
 b=tP03oXGk6BJKXT3AmODcmvMcXO5GC3KzeaoBcccThVLoFOZabBRhSrdnXv4fufyq/PxdRzGW6RsUJpq7uZspjTjjbNB8EwnHZn25tgKnKGRdZPTG5WT9XLc3uJmpqGstoW8QG6ZGc4Do4t3KZx4fODOrtRFC6socDtQireTnllhZCtkfUIC//gdqjpyvLzYKMSqlAIEA8DzjOAosJBD9jezQy56RbXVsohsb41Xolu9vEte7v/gtJxgHoH5ytJzcNaV0xrjM73b31S5be7HP3H03rehMUXusUPvoUXTcQe/jOyUfs2SdfbjfUesXuC/U5iDAUkrhLAd2433CkbBsZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by DS7PR12MB8274.namprd12.prod.outlook.com (2603:10b6:8:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Fri, 9 Aug
 2024 14:17:16 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%3]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 14:17:15 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: "Huang, Ying" <ying.huang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/numa: no task_numa_fault() call if page table is
 changed
Date: Fri, 09 Aug 2024 10:17:13 -0400
X-Mailer: MailMate (1.14r6052)
Message-ID: <519440E3-D5F4-49BC-9173-1BA46C8DE021@nvidia.com>
In-Reply-To: <17712a89-58bb-4e1a-99bb-9571a6dbfbad@redhat.com>
References: <20240807184730.1266736-1-ziy@nvidia.com>
 <956553dc-587c-4a43-9877-7e8844f27f95@linux.alibaba.com>
 <1881267a-723d-4ba0-96d0-d863ae9345a4@redhat.com>
 <09AC6DFA-E50A-478D-A608-6EF08D8137E9@nvidia.com>
 <052552f4-5a8d-4799-8f02-177585a1c8dd@redhat.com>
 <8890DD6A-126A-406D-8AB9-97CF5A1F4DA4@nvidia.com>
 <b0b94a65-51f1-459e-879f-696baba85399@huawei.com>
 <87cymizdvc.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <03D403CE-5893-456D-AB4B-67C9E9F0F532@nvidia.com>
 <874j7uyvyh.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <6233DD66-9A2E-4885-875D-1E79179146D7@nvidia.com>
 <17712a89-58bb-4e1a-99bb-9571a6dbfbad@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_63E16314-329E-4AA9-80FD-67EB83E5CE42_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR06CA0022.namprd06.prod.outlook.com
 (2603:10b6:208:23d::27) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|DS7PR12MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a91669-f116-4fcd-7bf2-08dcb87df862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lQXVUtEiu4oQ0E0rqCXlxOFSLSePs04W5qdCGpz1llQ1i339d/xXOrjwxM3V?=
 =?us-ascii?Q?Qo2XknCorzoA1/mS5dus/pNxrU/sxMuifZdDQpm4ZYdyn4neZLwYt47m7pEY?=
 =?us-ascii?Q?eUZkH2+cabUhjFco7WOhf4DLAf0MST+Pas3YXeR4/NJIhkP+EMFTByQ0zNTy?=
 =?us-ascii?Q?d7W897ok2UxfzVk4IZLYIi3ofj5W3uQONa/L9pSretQb7qbpMwJ91UlBsHrq?=
 =?us-ascii?Q?M4vG1IMiILPTqxIXDtTPRdbJiAHoV26I7Yo08pM30YKiYT90xOCLCqCZ3/hO?=
 =?us-ascii?Q?TFFRaJ/ioOzYfB3qhmLRYt8YXP3Un5XqTFn0lST0qM2Qsc3Dzsg4KgoMF/1i?=
 =?us-ascii?Q?WO2N57trPUap99zfXyksZ2123qevnlqL3pIoyOqj4LttL31G+qekRifvpmf1?=
 =?us-ascii?Q?2gse1L+M0DXXKKuEQorts4WM79/p+zdshl+x8nsG7fHbLG7zdXMMS8abpUdQ?=
 =?us-ascii?Q?dp3T5LtU21/UqKbvXxrNZ6a+ShBp1ZVPmlgRWCygjBs+FDEMA4DX3BB07Clq?=
 =?us-ascii?Q?edDsSkYFZ7nOd5ic7yqZlQG10FUXD6d53iwZKrLQNMB4+mnuLMcRxvnVnZYZ?=
 =?us-ascii?Q?r3ja64hPnqgE7um67azxxVmrtQ6IwJGnPrx9KZ1tEKiq4vredpymDb6htCNh?=
 =?us-ascii?Q?5PfuFAtKEQ5cIWkR6i4/GmIbgZJpvzyssPEuuzprMvckxslf35P2h41uvsx7?=
 =?us-ascii?Q?RAw9hzsHGl0KkPQMtcx9VASDS+9aNR5ZuoWTBh1xBBYGptNYvzWeXZMUNoGU?=
 =?us-ascii?Q?8sjVe7BGB1ZfKWyXtPZweka4HfuBmHgWFgxm5JM0E+scj62DEBrE9CfeETjt?=
 =?us-ascii?Q?H3e0g+O7QnoRRRExjOSTQQe5wqBju4zMtKseN4zzKGB8cqT37ue9jeB7XKq7?=
 =?us-ascii?Q?Fd99+9e3NRVBiidwwMSqq2VziPMjLRja4sCWh+ilZovMnVVSKFdgZC2NvIj2?=
 =?us-ascii?Q?Kiqp1pSJ5TI6eCkEjOrtS6Wgovn+OL4CdOhd72kTxKuzsoOPvJSPZvP+qTKr?=
 =?us-ascii?Q?OtdubymSO7ULnqKAwixy5jpwOeThJgNZSZajRFycSc9gk/4e2KEV1790GepW?=
 =?us-ascii?Q?OQLiBsOCh1Dur4fWQNezTKuC7Gynbz6p1b2Za5o9YXIZ9N+LXSWOk4z9J9+J?=
 =?us-ascii?Q?jhhxGtML7AEvJHKfK2nO1Qg1mvCZ/nJERCXurgVag8fFrUNdI7gAEwOJN808?=
 =?us-ascii?Q?5cl6fL3S8OyFRxDtlq43W7m+FbzD1LokPxF1JpRE7ppUzv5CayOiOzn946be?=
 =?us-ascii?Q?zrKvM6C87ifGUOHwsj6OuL2ATeQaGV6EowcqPakJvifNsCRfWgFBoIaY5un+?=
 =?us-ascii?Q?lqUEDfPZrPDM3COzp6uEupTBsALjEl/ryljrsE0sOC+0aA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aUdMsiJC5zzGe9g0m42U6R+1/bYfKrFD0LsAseef5YTdTA/+EgBHpbBkW8gL?=
 =?us-ascii?Q?+52fyHQIN1Qvp3YrSNHyQYbAtkKjbixlbIs44ddiW4n6D5JA3fW+KN8Upphj?=
 =?us-ascii?Q?VfWegWKoCp2pse2UqCbhRh0+jq/Yount12lSuN6+nPlX0zQmD1zZq1VZ+7OD?=
 =?us-ascii?Q?LAreAKHZGmhaK1lHw9Ab9owLAtrAmB0rRa2bF2Owzb1a0meD24Uum8iuCiVX?=
 =?us-ascii?Q?qQxCTm/JFycDbvf095Wl8qgI2DCXvITg7K9cSikgzti+Px6VPkbYoID4ynMF?=
 =?us-ascii?Q?NpI9ldLs4GXjeM+nvikcP5Vd5ystxgnoKscc1AO2BoldHuHRFUQv4d7S0ASm?=
 =?us-ascii?Q?dkPBZaF+/bd9+N5/INktL+cM4l/oGo8Bqe1G+uw2yVoWxbLCk907azPsrbz5?=
 =?us-ascii?Q?XdvtwxdXbBcJNdj54aTjPEDmWMKnk11ayOB18r+N1IJIowLXfIFpvsBLHcdr?=
 =?us-ascii?Q?PSvJxfnYkKsqJsZ2uyH2sFG9CT9vNkRQMpWR/deHSiR6z3r1Z8Gcy1jGiVO1?=
 =?us-ascii?Q?UbaV9mQA3vwOGZKPdqAxhjDyyOSPQu/mExC9O8JEHsn1p0keg4FU9xu/ekVH?=
 =?us-ascii?Q?ccxVYC7q04ReC/MZHug6aiA0064LiWEyufX/9x96VkxhjEyvkFwOAeBcDMVk?=
 =?us-ascii?Q?lOlozoLAKbG2XvVrzbIJqKoDJweRh2VT+XsgkiUFcH9VzKU21b/bss6vcrKz?=
 =?us-ascii?Q?JGJuN9GDujkoN6N/HNAvkEwNKdxgCuDIe5XVl9aoAxOx0shJr2NFCA0iTI/T?=
 =?us-ascii?Q?s/R1z+I6b0ERJkuStbtr6+GRkPQxyrPxvG4oiohtVXVwDXLIaco9YiCNfFX0?=
 =?us-ascii?Q?FZwacaCOtICgdFx8Uc7hMhCNkPDAzmq1AylXn53Ife1B9trweDpWwlWBjoVV?=
 =?us-ascii?Q?REWMmx8iCTsZSA2jB2f8HT7cgATjrIA3ZGn3oec0Dd7D0dFFU5n+y4sllZSQ?=
 =?us-ascii?Q?qJ+EDh7HYGEOKhYfdSzs7FsRNs7WRdFwXRaCsuemrpQhnNcovAN6cWR2fvdB?=
 =?us-ascii?Q?4bhpAjuXK7ZHEQsSz3/72CGG6rIHCAo3RTrx68tVe6l1rZydm2y6BANzhVXC?=
 =?us-ascii?Q?r89/e5WB9cBgfobImPHMOit0dqzK0ZLoo6AyIW049eEVcz7/WciiTGOi1oiW?=
 =?us-ascii?Q?+SIiXOTSEkwQpjwy7qnkl+cEPFLnjWaYhIYjg/uFq3MHxRhua4xLNE3rxdyA?=
 =?us-ascii?Q?9gLinTtgJVr6hdE/rx+tqizsGg1p0q3nMhjBMtaD7jcy9uPvgiVMAWO0Bje4?=
 =?us-ascii?Q?oyjhYZLaflMJyDMJYNN7Z1fv8RNaEslDzhEkbusMnavXWWKbl6BYxgKACHt1?=
 =?us-ascii?Q?0j2AuRF0UJvGPt8wBu89XdCMRz4XfmxEHqLFt+MdBfnevtfDyfAgFGDQMXbF?=
 =?us-ascii?Q?AZf3G+n4FwSN3jUjC4yRuNyOF18LKmFUFlXMJLeGIkW9fLqdsmh7P5Ybh48F?=
 =?us-ascii?Q?tbpK71qyPJDmmTRGRVtm9akrK/xGnVD1zNTEEZs9EdpyxLA6DZxom+Vaa6QC?=
 =?us-ascii?Q?euKY1s9Q30P7Z1uRrDf85iG7xG3g09peyRtRl4cCZcPc5EC5W4lMkqLBUu4i?=
 =?us-ascii?Q?PE/v3h+YrSR5xeygI5I+VF1BLBG/b6uF5KD+L7o5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a91669-f116-4fcd-7bf2-08dcb87df862
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 14:17:15.8403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJDhUEMSrakBTPplAG3gJltROhfxOl9NqZSr7NyyBiRGkXKbboE4edgs0G4WklwR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8274

--=_MailMate_63E16314-329E-4AA9-80FD-67EB83E5CE42_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 9 Aug 2024, at 9:49, David Hildenbrand wrote:

>> Hi Andrew,
>>
>> Can you fold the fixup below to this patch? Thanks.
>
> It might be reasonable to send out a new version. At least I am confuse=
d now what the latest state is :D

Sure. I will send v3 to include all patches I sent recently.


Best Regards,
Yan, Zi

--=_MailMate_63E16314-329E-4AA9-80FD-67EB83E5CE42_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAma2JOkPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKbTIP/iygVd/sY1EhFoHxKjwYJyUSuBtVIbzMceXy
C1mkw2kr5mSJRCBAE2gNZrsVEk8HzITGaT4Gm3EakocQi3lOjdN9aMhO8DpxaaBW
02wFriwkDjA7XKVLzTDSIweUkODPfBhCjzR7TwS/ag9GO1eo4DU6bBHWtP3Z4uum
eBWZzgRc581xxnIG4v5Hd7qiL8J1W7nNV7+Rw/c8bnNiRsqUfkrXqp0KOKYQsizw
E5fRAYJovnG1PSjeSEcIK4FQDEDWaBvFj8Orf6+OYnDqecjeI8vTJUYWf6nB9xl5
KqCAXqpED32gi+DcVbZzR9f41dltOQgQlALR7wezfnrh4rgjCBIyyBNRK2basf7z
c0MtgdeWJZ/gVrC12fFKVksuqR2Dbygm4Ww4SvWKct/cKg5qeyqq5UPU2h8DDgMr
WGI9gMPT4UbCqiMCiPhE5RXpE4mXFGjfEz7O+7NWNPB7sXh0VBf5HgDg5dVzLbTv
sbyXBW4gAkc/jHQ8iCN+nqcn9u/eFqicCXRbgZ7e82du8Mjqs+EBEp+6Yknywl0M
zibTdCdCTd/YeSNUmeifN/eqKaknmyln0SZ2zv6Gbf9nqWnvGD9Nwfsc2jNZ80l7
hj4fnMvCip1OPog/64XrIXq4Hwv6pdCpnMiQz0wXTTJinXGX5gQENzto6koNUqNp
4KKveMEt
=C72L
-----END PGP SIGNATURE-----

--=_MailMate_63E16314-329E-4AA9-80FD-67EB83E5CE42_=--

