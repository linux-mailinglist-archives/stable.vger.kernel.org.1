Return-Path: <stable+bounces-120196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 296A8A4D15C
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 03:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D6571734E7
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 02:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FD213B58B;
	Tue,  4 Mar 2025 02:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oYFVzGFm"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF752AE8C;
	Tue,  4 Mar 2025 02:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741053792; cv=fail; b=oP+QlYg542LtzPT/rzg5fvcvnvWTFrJmig1FEA/84Cc/dSSbjZqbQIzMZhD3jQxd6Rlq2E7pr82XflSIQpzVhIkoHU8XsUg+KN7d3Er38c7zcmUpNimuxqP8XErI2PU2Xd39EaPNKbouKDHLef0V2nKpaJa/WCu8+zlbzPLAh8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741053792; c=relaxed/simple;
	bh=82UcLPea+I5QbeDX0UBothjLkmD8swydFieyEnR2duc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cjX8fg8hFXvAilm2+bUPCm1px/owusc83infro7byPu4NYaNTkm1YvtOhPCYTSGK+isS9DZB2VOIZFmZF838jl9zg6qnj9DB/I59IvQkXWum1lyLAqei1bEf8XAzdYx7DWDUNW8W+CZ4S3IMDhQck9m/wfDgFWdsuwPm4UDDEl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oYFVzGFm; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QaqbhuwQuoKKJh42tsPN5L6ueyIOQa76ATJUZkAj9oXg3BZPSFAPZEXoN3vPRLwMSiRdjxWqm8e6EU7cD2w74RD0okcyWbV+QbzP6/xg96/IClDstTCRfGjA0S6u7aeCwJfTU+1TnR12tGLjgRP5Ve0ebGxRksjGq/dnyvSXszAQCYUjdDHD1huLM9x9sjiUcUWh3ZWqBPS38wcUyle4uI+45YCkOQ1CEHgTjEvhEGZ/DG+N6v71ancDPwuMDUrjYILADuehWJK0tiwOIM2Y7SGlFedFvvVuq8wkKsk3nEvR9Cr1udepvLvO6TN/z64P1zE1g3c98Jr29prrW0Qf1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htWVU+IRhiSM36MNZsJu/0a20zGqr1i0v6v6HU74BHQ=;
 b=tdsRR/DQ5NrMPP2dfRVLHOayMpjPO07BrN8z+8er5dTCvatawDLqA6WrdzHVIsgzYEQ/Bcmv9jgNiFEGcuTW1R53q7PvNGPiLYVjS3Ax7dvjZb3igtiX9dOJHhLVoH3QL/s2+V1pHMEl/mRmLzAHGro6MvraEkkSjm8WgNR2GMvQyIFGQKb/LNmgpZ8J6ZJBpHGExpg+3H/AlPsoTnzC+WZkDDTvBesMInzHS/tRvFvqqDK16d9axecC8bTWS75oMCemsQOoo93YEfxOo2hPjkW3eOuopBeGiTyzMThBhO5UgvjY1vgm1VENTYLoAkr9VxYS9u2vaWTYjsWS1tAdAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htWVU+IRhiSM36MNZsJu/0a20zGqr1i0v6v6HU74BHQ=;
 b=oYFVzGFmn+cO9BmrwKWD/7YZS/DlZriOIgPn24/++bBwy1IwqfhaEU6gM59oKEP0c4XvUn4914Fx7qA1FKAiS46W4X/Xvzrn8/KR+j3L9oNzn1ZLPmBKlAU4uFJv3TY0GEzYyxvLQag4NInO7Uxvg5sfMwR0o/ekYpJIyr8BgU/MbPsfhn3yU/xKzmNxgJH5jq0zmVfMpgzVLYvXNXPt8UwZHRKr6YI/v3+4FC3apAjqZCtGDmY9t8upfHZ0uXFuiyprqYEnKVZOXZvXeNO3JRWz0xzGsQB3IkneS6DvkgdYyZkbP2fCSQA173WOl6BFH/OBN9dv1nnCu3h7q/iuKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN2PR12MB4176.namprd12.prod.outlook.com (2603:10b6:208:1d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.24; Tue, 4 Mar
 2025 02:03:06 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 02:03:06 +0000
From: Zi Yan <ziy@nvidia.com>
To: Liu Shixin <liushixin2@huawei.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>,
 David Hildenbrand <david@redhat.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Lance Yang <ioworker0@gmail.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Hugh Dickins <hughd@google.com>,
 Charan Teja Kalla <quic_charante@quicinc.com>, linux-kernel@vger.kernel.org,
 Zi Yan <ziy@nvidia.com>, Shivank Garg <shivankg@amd.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/migrate: fix shmem xarray update during migration
Date: Mon, 03 Mar 2025 21:03:04 -0500
X-Mailer: MailMate (2.0r6233)
Message-ID: <16838F71-3E96-4EFE-BDA1-600C33F75D36@nvidia.com>
In-Reply-To: <20250228174953.2222831-1-ziy@nvidia.com>
References: <20250228174953.2222831-1-ziy@nvidia.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::16) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN2PR12MB4176:EE_
X-MS-Office365-Filtering-Correlation-Id: 335a3670-eb30-4bab-1e36-08dd5ac0b46e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uJX/pUGktxjifr41GWsc1uD7v8oAnsY62bQE/L5zfv19hW8yYvXXs+cM+FiK?=
 =?us-ascii?Q?Rl++ebXAD6RgkuUg1zzKsL9x35x8WNwm/GX21cYA0igB3YVenlqvp570KaTU?=
 =?us-ascii?Q?PAY7vTSHXwFhpqs3kPj7XnTTPyXJseVpdQcL+yuhukF6dvwuccfjRpKmnX+3?=
 =?us-ascii?Q?oXH2OCmKaqcFDUSeSOL3URPkxS0f5r10tkupayODdoJKyc1fZQgdGjA52S0j?=
 =?us-ascii?Q?PpS71OGqZWpRpLEQtoHgUzYNWTnFanQJ76OApHXhyAxTAP9LXKmSo3ZyqkEz?=
 =?us-ascii?Q?Q5T1FpugvMTP5qc2+bO+wAQggJtnYJA95mTKYk7AVAB93vx+ijeFZbEMuzuH?=
 =?us-ascii?Q?xd8SbDPw6KWBr/4jWC+Glox6RhFb+5JB5rVGJve/7X2GISGSBiCp10oSh6Fk?=
 =?us-ascii?Q?uInZ9deMH/FAuhqFcKfjcnTuS2vxlC1Kij1LAJqEbsSmjlfWatqkaUHEVl03?=
 =?us-ascii?Q?Ijv6ssZ5731doW8RtcjxSlGOYpDVpMUsry6KeABPsmcAVpi4zB6bUtkxI3Ck?=
 =?us-ascii?Q?jhFww1OPUHVF9kMLxeArwLKaaLruTBMXIkZ84sCQVnNN7Q9TFA9GitHEfgXC?=
 =?us-ascii?Q?BsUIwH/XpgImshjNnuq4Sm1/JpAkLvBAIyoV5/C3fgG5ty+aOpUBnxlQd6i8?=
 =?us-ascii?Q?rDA7ya9HlaO2l0eT4IDxGefMBUzUDq3Y+JSZFGX2+CYfxRhKATG4aykTy/re?=
 =?us-ascii?Q?TR7VFuKMuKepLuYFWxIxVOf7jo/iPVVksKyd0OzqaiWclixP26vmU6/mprfx?=
 =?us-ascii?Q?5UCWrUtzdEP8lslxK94TWEym0NufII/vNU0/eRC4uYqsO/W9bQBQXTyOo/GL?=
 =?us-ascii?Q?jlMSwWhC+0ZofoHDhwby/TtLwK6MW6lhRd19XDPNc8ZbBrcGVa0QmXeK+gku?=
 =?us-ascii?Q?rbHEpvhgFrnjilFsuaIuW8nt8g2v906z1nc3ug6wjDTybHJBLfohqV7iSrhx?=
 =?us-ascii?Q?o9Vq2JP7aB5s/F19E5FmNvKCaTiM07AjS+Z/Gs0whw71ZW4vtFwCGdBjOalS?=
 =?us-ascii?Q?7Bc1N1o4YUrD1YFgpdZ1V+Mn4899gMjaMQP58jMyXc6MypEdAKcMfejhsAjQ?=
 =?us-ascii?Q?xg/QU7DQYye5ZrFaakyJYZITbJH/QA4Lf5DCTtnC0AK8/K/BolqQSizO+0Uk?=
 =?us-ascii?Q?7XMK2+wIld4h54F5sS5ZPCWY/gaxZV/p/nEDjBUEi3iisxBi3i5BfTZUmBH5?=
 =?us-ascii?Q?YA8wSnngd1wCI/MSb2L9q5nDeJ475sLsgX7Li+IIKu/6ISaULsC5XBQAZvzS?=
 =?us-ascii?Q?n7PdLm1evWdxbKnjpwrDx2wUdc+qyWY/H2FPuFxc0lpFVB5cRtxR/P3huSi/?=
 =?us-ascii?Q?NVjbJl5O3IIY2DkmDMO7LyM0+9IzoBX1+11Gj8DTSJl4A9hHnO4kOkwAnYti?=
 =?us-ascii?Q?+PYMZ4pYyVIMHaMWdo4n9bPHcdEo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mNtLe/p2OdyRX2DZJtxGLxJQrCWb0gRpE3FVfhzoIOtoeQKtJAtcaEvyfNEa?=
 =?us-ascii?Q?cTQDp/54J9oQ0Xw4gLVd7i9rxTLYXPczYJjn+H3YDUvpjNbvQROnfOto47Sk?=
 =?us-ascii?Q?/lYg7mi4VHInn8d67aBCFUBi1zH9TPVnk92Iz4nlU9+MG5n//iN1l1gcKIGR?=
 =?us-ascii?Q?WsR3OAhORqZaspX/obuHK0CoWlVTYKXXx76Y3+SthuPNm2hggekGOQbKUQw7?=
 =?us-ascii?Q?df0LAno06PQ+3DRqX5SxgZyEoBEPObwemcGTIPCxnn4pWqRwkx4+8WJh1U+W?=
 =?us-ascii?Q?a9PdbTkU/ds/o8+VvDcdE3+CMHNBnRI7XzktoytZoJ6pcsf+nSZbk8+BiF/t?=
 =?us-ascii?Q?IztVInbmlsuQ3zlXEeyknJ2/ISx6z7Cb20wz3tB+3uhWVAPemX3NsjLdTg5C?=
 =?us-ascii?Q?wibWODtDygpxkdqS5uBWmNWwefgtxBsYCZpjsdXV9bX74oTyxkOUngyZUR13?=
 =?us-ascii?Q?8KnVMovLY6yL6fnJ9edCKDe6L0jr+0jOwEGUJVym7jwIFBpK+m69DtUcEhad?=
 =?us-ascii?Q?BTzn5XNLJrMNmrzkoMmfph4Q6IwHFQ0xyzl/QxcJGdR99aN5qyzQ2t1DqlLk?=
 =?us-ascii?Q?l3HNgEt2lOoTXPCnjsVhB/V57AmR5XiLBc1nJtoK4XiO6UqCnrMBISvhtQH3?=
 =?us-ascii?Q?P2dMWh1b6so5QBd0LtjinF+xoI7LBojVj42sXNFvPf6rsz4vp3IhSB9hIHx3?=
 =?us-ascii?Q?uZHUblOWaNHFwVu9DWGHqZY1SKoqDKZpqK+VO7gdwRBLsPIBgKfldkQJwFVj?=
 =?us-ascii?Q?Sds+Rcbk4b9ybCsAJQrJGIYRQJ1Y5omJrAjmCpSWNe4wcyeImSHTNXN988eK?=
 =?us-ascii?Q?XIu0iW6BzxR/pknFDWy3rr2/eNUPxOU3ACCXhrfZPHWNBnpxwT3PO6bS7kiv?=
 =?us-ascii?Q?o8q/UdeN7Z/E5QIbHHc4AJLuft8wliKJtQiWNsSMOAnhCsdf1ZT+puLJ/yTM?=
 =?us-ascii?Q?sAWkBqLdG/Js4y4/Vfc4gzGjCqOzwjZWEV6uRdEfTE2Iz7EvoA5T05/vCuSU?=
 =?us-ascii?Q?QDjccrHOKSZbuyXMFz5Nz55qDekEOgXSCJN73MTAO+X68rw8+0t8eMvNWDzh?=
 =?us-ascii?Q?yZt3S/hIzWLb7OK6wWp/vyju08pRpbLUGEnvH76BAUZpVZyKKqs+NXiyt5Np?=
 =?us-ascii?Q?wr38C39YgjLnF/wYiua/HU3/tYeeyex89fb8D/R+HuGHgajmcjOCisKxrw2y?=
 =?us-ascii?Q?rfEpFDH8FTKA6mlhvrieg+Mq9dWd27la7Fauv4/scBUNLWihyoX7mYfdPuAN?=
 =?us-ascii?Q?TSDcvzTFG+bj3+NdOsEDxUOMnMCLXAshT1l5Of7Up/MWKze3f3414ssmxRl8?=
 =?us-ascii?Q?qiq0SR90rKvPlFHGE5dPMV9j1lC7ugaosZfKznKy/cTMsqbBqkAt9aCcSneJ?=
 =?us-ascii?Q?09Wv2y+2HYUtZXXVzB3Fg+LII5t4uyCviQsBjwW+hUKNszqPf5/QCZj4zoOK?=
 =?us-ascii?Q?SFS7g7Lg7fMgixf5I3JIIv4ZNglwZsplk2BBCjRAj1rZYJ5y2z7l3k1Nw8t3?=
 =?us-ascii?Q?3/dp6LTF05srTAfgN5vwspXFgqQVhvJcv7iCdg1ZlWYO2jyt2aOgXK522IvL?=
 =?us-ascii?Q?OthsOGXhsBvnIM8QB9iEQYooySBUECEh4qSWx4AS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 335a3670-eb30-4bab-1e36-08dd5ac0b46e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 02:03:06.5027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2Mib+Z/GtMjCxctolDH5UNgHueUgWvrHo9hmuozFKaLF2i8V6QuNWJzirwryABi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4176

On 28 Feb 2025, at 12:49, Zi Yan wrote:

> Pagecache uses multi-index entries for large folio, so does shmem. Only=

> swap cache still stores multiple entries for a single large folio.
> Commit fc346d0a70a1 ("mm: migrate high-order folios in swap cache corre=
ctly")
> fixed swap cache but got shmem wrong by storing multiple entries for
> a large shmem folio. Fix it by storing a single entry for a shmem
> folio.
>
> Fixes: fc346d0a70a1 ("mm: migrate high-order folios in swap cache corre=
ctly")
> Reported-by: Liu Shixin <liushixin2@huawei.com>
> Closes: https://lore.kernel.org/all/28546fb4-5210-bf75-16d6-43e1f864608=
0@huawei.com/
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Shivank Garg <shivankg@amd.com>

+Cc:stable

> ---
>  mm/migrate.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 365c6daa8d1b..2c9669135a38 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -524,7 +524,11 @@ static int __folio_migrate_mapping(struct address_=
space *mapping,
>  			folio_set_swapcache(newfolio);
>  			newfolio->private =3D folio_get_private(folio);
>  		}
> -		entries =3D nr;
> +		/* shmem uses high-order entry */
> +		if (!folio_test_anon(folio))
> +			entries =3D 1;
> +		else
> +			entries =3D nr;
>  	} else {
>  		VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
>  		entries =3D 1;
> -- =

> 2.47.2


Best Regards,
Yan, Zi

