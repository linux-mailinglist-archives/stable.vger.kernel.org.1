Return-Path: <stable+bounces-120354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA4BA4E8AF
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB9B188FC29
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538991F30BE;
	Tue,  4 Mar 2025 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LJtt/F6W"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F151DDC2A;
	Tue,  4 Mar 2025 17:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107621; cv=fail; b=UgARdnTZoy5NknNwMIuU1m7jH8rTTUxn4ZIdLhaRsfQ98x42oiehsq38gh4tTDoLKFDmAPqoYG9VhYoMI0f3SvFyaAHyxGWJQG5oBixkim6/NTX66esGfT79jU5N9iP0HjDbQhYGO7AC9NSH58F0v/X0vQKf9U7Lf/NziqZEnKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107621; c=relaxed/simple;
	bh=AeA1b/QP2PlM392ZgjJr+N1DeRvLwLOGp79w2/5cEOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FXu4UzB78fREB4w6t6396o4wGGQVlfzkPFvGDLXqvQSA8syZEL5bwPYSMrpzV+qQlMLlpQrYQ6QH5NZt9em+jS4rMIzfwlZ3CUUKyhNArIonMVZrFxGYgdy2EnbxOIt5wLM2zdf95GDFvpkLOKH0qMax/Km7XDPbdzZSyyt0bHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LJtt/F6W; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVCGS93hPIRgte94L3VjyAyS4YAUTDRaG758tDClu5QtILxwRKNEuR3VGknm9+9ZFSwrnVr3jYQz0pb5kMC4GjvG7N1xJgY0vN/Csklg/6ODniYQ8fanaMOvOV6oUOx6KG6oO8wNKlRYsnh50/33wDSF+IJc7oAu4Ps5OIBXAFoyfbPBfO191man+GzGJKUVxgO32snChI6xGMWLRVqZo0BBN0ABSxA2sLdEPMMDslMWXbSqaJW1UmBq9DTYH1OULqxIJ6T5PjDrGQzWtJGygADk6ZFE7B2biK6odzSas8HBqUzgzKKTOgVVbEmp4e6ohd1WFHxC5ba2qVmq+Qz/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzJPC2LZtT7r+NSIQwHHEMomDjzircoHkvmWud19RG4=;
 b=CvnTQ9xjlbyCx531oSEqZCI4zlm8qrFY5xiEYtVB2r9RO+8MhzeenWbeW1pkXoAsD8DfzpAQJdRWC13MWts7VGzBjuI1yGiufrEioEMQ6bfqgLa7yS0nCbBmz6i84w3nTyvfa0if+eqBy4hMT1IHzbeCiRtgqucB7teJcJ67AhzUjTAHsu1OVmnoXJZMy37a1kTFwwsKw/6fOd1t0qhUquTnpjnytMc488hqvQ1Qs8Jp8KM/zZmwdKpNB0F/wei0Hhb65DXLusj2X/kmqlDo49emp+TKwi2iDVBicNDct6qKVSF2UrBmBBqBf9C1xDAek7lvvs1Vjxk6Z2141/06ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzJPC2LZtT7r+NSIQwHHEMomDjzircoHkvmWud19RG4=;
 b=LJtt/F6Wbt7FG+2Le8TbrICAt33Yg/dPH7Ng8/cU4o+DsKfEObfZdfH1O6xKQCHPBV4ZfpulFZIo1N4wWae+ZQdH2wEtg3Z6fV030AzaizJGCIX/gR1BwcogSFg1N4TJGFtCGxGmZkG9C+uHcEFfk+sP1OQR+4hXgqEV8/yR+ljatk+SjrUTTXAgcmFZdNnovZtUF1cxjq5loMgweiLzoh6yW3tWAABEFDygQXGUN1Wi4FghTfe2+r1PjNx52XDVR1/3DWAanrOkic/T94ck7qi/DaGtnAGTtesqcZgFecM1dcylbb7eTLV2fl/nCh/d/Lv3GE0sdvYOsJsgzD75dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB7664.namprd12.prod.outlook.com (2603:10b6:208:423::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.25; Tue, 4 Mar 2025 17:00:13 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 17:00:13 +0000
From: Zi Yan <ziy@nvidia.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Liu Shixin <liushixin2@huawei.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>,
 David Hildenbrand <david@redhat.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Lance Yang <ioworker0@gmail.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Hugh Dickins <hughd@google.com>,
 Charan Teja Kalla <quic_charante@quicinc.com>, linux-kernel@vger.kernel.org,
 Shivank Garg <shivankg@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/migrate: fix shmem xarray update during migration
Date: Tue, 04 Mar 2025 12:00:05 -0500
X-Mailer: MailMate (2.0r6233)
Message-ID: <8EF27953-6973-41C8-A3FD-FC4DAEB3F2BB@nvidia.com>
In-Reply-To: <2025030437-posting-barbecue-94af@gregkh>
References: <20250228174953.2222831-1-ziy@nvidia.com>
 <16838F71-3E96-4EFE-BDA1-600C33F75D36@nvidia.com>
 <2025030437-posting-barbecue-94af@gregkh>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR11CA0081.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::22) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: 418234c5-c67a-460c-e433-08dd5b3e07f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YKj/yX3N7hFkDyxFz4h0q8y2GvCwKQl3eUQOUb4hgh95lPktLSYxUe8kRvRl?=
 =?us-ascii?Q?Avyo5cUt6IoFvUZZtJUoSfMSsX8J4ihg/Lv2FaebbaHkP/haXQ/8OO8Nzd8E?=
 =?us-ascii?Q?1OcUzE8HbqdcouU4yBFHMJd0gUSen7DA6wY8/ND39N4zWxrjuw77N7xyNMko?=
 =?us-ascii?Q?1CRCZzFCSfk3gr/wG8rjcOehkXI1HQsz/3ilaP1WoZ63S5PYw98pQaiVdCAR?=
 =?us-ascii?Q?KKdY74TpOe3BskNY5gDkNpKeCdbwoQ7o9bQ0tREh4j+XhQUPncYo+2axCGeE?=
 =?us-ascii?Q?kTfOS7QrQVULTU4NVr/Tv1IE66jS8l5Ao4gx76aPbidFQpAOwcgEDVAzMZjp?=
 =?us-ascii?Q?0zc42XegfasrNlwejPqi036y2Fch8+ZjMUDcTFmjAG2/rFQThEFm8vFc/2rj?=
 =?us-ascii?Q?tzw1blLqRzt4mpb4NiJHYR/wQq7q2SDZo9dDNz3zpOXUB1CcFaZ/p8oWqTEY?=
 =?us-ascii?Q?QieWrnR35UaaLOzJ0NUVinmjtk3jDKO1eSTqRcTEsVQ0TqpXpNhQ1k0mGu25?=
 =?us-ascii?Q?TXvU7xgALThBTRrcuDGM3olh4GJYywqFerh0nwlTIW1CfBIPeqlypcOMMGYK?=
 =?us-ascii?Q?0qrum8yCSPkUgY4/MLkEN9YPevnYvKPs+Vd+BBkBRZBnF+ortRFT+JKh5dMC?=
 =?us-ascii?Q?cL1rWT3LRtriIzOeAz8KEuElIVH08AWZELo7Rymg+xBWyNLUhenHC9m50wvw?=
 =?us-ascii?Q?fys0D3lSqTrkzFrpdSJPJ89n4oTHjtQB5FWenJWC4oRg/xbdCeFU9z8CDcKD?=
 =?us-ascii?Q?pwTOjHCTyGDrgNyjPQAdsR2yHBrxJ6Qze1RDf0MogDLP/GayMV2x7kCZXSeW?=
 =?us-ascii?Q?ze3ObaRg70GcfihDY8whiI90BkiRfYdkG3HOAVRMRgFnKVnXfudtxSMGLKbS?=
 =?us-ascii?Q?6IUvZm749igS/SWxY/F1HZfzJOBN2Mx286QgVS6cXA6nG/8p2hJ0cw2LAdBS?=
 =?us-ascii?Q?Bl5wYfhOXsIqrZAFfphubhQ9b2nhv+hiJ56e6zXbvOF4qkpDkCaW+eNaxI68?=
 =?us-ascii?Q?EY2zR0FES0g1TeQfFu73LzX5sDP4om6l6vLX6cRLrbHUB4WmjuuJ/dKorGjy?=
 =?us-ascii?Q?ThTvPFKNTyZDggGXNJkIUfX9b6pT7eIeftgiE5x/MBjsNX2Vz87EUSOHHICK?=
 =?us-ascii?Q?QNK+sTbYQ560i0FwdeGLSLY2yYPq9MOOgEOwgbt3/4adVaDE8nfor8o3fYBS?=
 =?us-ascii?Q?eTatNXK+szHyR9LHMurQCqpzlZA9rJUeGdaSKo1qXSOI5O+4/hAyw3g/O5mM?=
 =?us-ascii?Q?ntQz09zlJVplMXWQaquceVcS78Kxrk7EtFUO3Ay5ko39kqD+7M8bu8KbokAa?=
 =?us-ascii?Q?YC6e+BLmsjxX4iwcE29FxQm2GWaJ0O+Gu5B333+0JWXUOBr5viHDhQA97EM1?=
 =?us-ascii?Q?43CFT5pcRhaLsRAiQWhFiEFNWFsL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p1BExSTtZaCJ6bCr8a0ehZu15Ma83+DlqDQp17ecFg6Bif/FvH2J580wS39X?=
 =?us-ascii?Q?qtzAC3609BnybySlxRCGuMXoAmigIzJxJXUU7v8kWnQvHNjI7ehZgVWyHbjP?=
 =?us-ascii?Q?z9LSMqB/bG+KbL1Uzl435Qt1u5/7MfR7gUd+r5fSbv/pK+XSSAHcKTBqIRJ1?=
 =?us-ascii?Q?7sD6WwjBcrGJyGVW3vPMcY8y7dhqCTBbq6+q4ZPZXS7mNfDtOXS2xpOVEtZf?=
 =?us-ascii?Q?HafAgqdixW2X5GoZz7Zt213BS28X3aV4GyQ0rd6N+FEilcZaHVCeObCgZWHv?=
 =?us-ascii?Q?sXq0tBvdbTwgTHcd3YzjqC3xD08jdJDS9h9ciKGYcSuxbTxTb9bwynElmYmR?=
 =?us-ascii?Q?nSYp+zBOocWJsLbiccMJxzVXrETiVvw61z0vPyoDfeu9Tq+g9ZvDEx1KnPb2?=
 =?us-ascii?Q?GOHKmnx9FEzYn1l0w3qvSLr5gjRju+ndlvnYK7iDnTcpWeP2l+/v+hdb4hSg?=
 =?us-ascii?Q?KmDk29gvdS2XZWzcEhUzJgCJgYQU1ZkMeGOI0TNv8lEs/mAjT/bDwovFXKY5?=
 =?us-ascii?Q?ND3xjuRSq/aVtp3Up2mSXbD+b35NTVXrFtDYuEzkkquuSGKBZbP3pxT23tmk?=
 =?us-ascii?Q?J3oGZT8pT2Hu8tNGeMU8sVRDlKujGsqJUCEI1vgb3xn4lyg8AcBOJdqQo/Ir?=
 =?us-ascii?Q?K71QbLqqpOmwgu5l3Ko9ptE5uM6vsfJqCUBKtta3asL5R7FmMBR7q6t5+aFA?=
 =?us-ascii?Q?0oG54oN/H2LBCdYvyKT3K4GArNdflPAOa3n0EujUrOh3H76/yfRfoUp4yIh9?=
 =?us-ascii?Q?SuEvOVUfP7BwxA/m3f2YQeOufLbcZMJwLDj7c4rQsBsegigB7iK7FbZZ6RCI?=
 =?us-ascii?Q?eYlG3GdcVrZ0E/GDVneSG4Fko9252w9tLz+M1G0QGmp4jHKMIHF0VSAWUkdO?=
 =?us-ascii?Q?s2LBtmQlPNlBY+/Cb40kbBzKiaQRKgVv4Bw67qt9bh5aDkwO+lWFkv/qqUHy?=
 =?us-ascii?Q?88WuYg/I7JK6A4i1yOHAPLYzgdnsd0XgS9NV2r7urfUIoptjvQICOakCzVOV?=
 =?us-ascii?Q?t0IAus3IG3FsYSLFsUxkUBT5hPw6p8CPKOijQJDG9MLzu/eW3QF1TchnNF/H?=
 =?us-ascii?Q?IP3Ad0/BVahKlePh2G2g2XLonXzHLRi+fnrT2lgx+go0MEjU5KODQoskD+mZ?=
 =?us-ascii?Q?IgZteGXoxObkubtIBc0HVop4k4mIhcttkcOln8F2AVuoaGAoyh/34m1d2o2f?=
 =?us-ascii?Q?3wUdfzEaixmlsA5LkXrDaPvE3+ZDO8E1rO0oP2tc+2EjfMe9gZs26PXzjPon?=
 =?us-ascii?Q?lZA7dnszs0rCVHP3QIteFP6BV2WjRRKj5j5DCmcFyp471ObCs7P6hJAewkVC?=
 =?us-ascii?Q?GLZ62p9wpNQ8lFEJ+m2yHv9AThdCJowrt5WR0SZkyGIFK5+/wZBudXHYCP6W?=
 =?us-ascii?Q?gzjdw3CjfUTjEFg0OF2jrIDdZPU+jy4Pwx6FnDs2sQ7owLNLs8degZl6wENw?=
 =?us-ascii?Q?BdOG40M8W3nyUnHRtzFgAsPX9iRNHLzaHh/T6msxfL9YYN9NkVlew0piuFRn?=
 =?us-ascii?Q?48o8hUEg7yHyK7brqG3yCXt2B1fUQ4y8yyuBUjx6g0ZQUDyginussAvavQUR?=
 =?us-ascii?Q?WKiehgln30Q3Uff0/kw8hJgOm7sLKxpmMWFRkDMw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 418234c5-c67a-460c-e433-08dd5b3e07f0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 17:00:13.7210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DxBWLKnU+u5Ys4f4CvD8AUnocs6+Pwb2z3XCQ4nXYLLkxcMUwvfIN6N/YdTW3z3p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7664

On 4 Mar 2025, at 0:30, Greg KH wrote:

> On Mon, Mar 03, 2025 at 09:03:04PM -0500, Zi Yan wrote:
>> On 28 Feb 2025, at 12:49, Zi Yan wrote:
>>
>>> Pagecache uses multi-index entries for large folio, so does shmem. On=
ly
>>> swap cache still stores multiple entries for a single large folio.
>>> Commit fc346d0a70a1 ("mm: migrate high-order folios in swap cache cor=
rectly")
>>> fixed swap cache but got shmem wrong by storing multiple entries for
>>> a large shmem folio. Fix it by storing a single entry for a shmem
>>> folio.
>>>
>>> Fixes: fc346d0a70a1 ("mm: migrate high-order folios in swap cache cor=
rectly")
>>> Reported-by: Liu Shixin <liushixin2@huawei.com>
>>> Closes: https://lore.kernel.org/all/28546fb4-5210-bf75-16d6-43e1f8646=
080@huawei.com/
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> Reviewed-by: Shivank Garg <shivankg@amd.com>
>>
>> +Cc:stable
>>
>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>   https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.ht=
ml
> for how to do this properly.
>
> </formletter>

Sure. And this is not the right fix. I will resend a new one. Sorry
for the noise.


Best Regards,
Yan, Zi

