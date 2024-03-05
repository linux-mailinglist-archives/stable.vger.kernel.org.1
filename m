Return-Path: <stable+bounces-26819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CB0872460
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 17:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2140D1C220C9
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 16:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA57D79EE;
	Tue,  5 Mar 2024 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qKjG+IDJ"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07129C2ED
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709656406; cv=fail; b=YnFfrt8ewbWFe3SQ+auwqb5QAetINLY3smk0lytOG1lmxJ6xC5IKw5gPIkbdmDXNTyopXVrP4LbfwWox3Isdk+ZKJLl0Qj36L66K//7dnTVByJveWvWlzR/PW61RFqBT9B95ly2c80bWfHPCGwUXZLpEcpwvcQYd/BT5W+rxqVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709656406; c=relaxed/simple;
	bh=93xvIeWH8yd1wTku//mN5kW1d/IaqpqrpY3t6gD1Cxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BA1TaaNwNMFRxUaRCVAaHhFKlKQMCE49xJjiW+Jw1PdV2fpfl7CZ4B/32BF/tFzz2EOylz2rwWkS7/CWXDi30miuAazUCw43OjevXuLlRkmpGucLO/PtmrvxmDF2qfYrzYEXFwDhDZESCCA0HNocTjgD6HWFOQQySMtUl0aVLRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qKjG+IDJ; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5XLbpJyeYzyPWwSKGgBOlLilORCU7XwgkvQDfXDw6oeK11PnCElwSJY3yHnerK3BRHJ6fFNDklu8SyGERky4k82Rk49yBATnyOeWUGjbvAMAdtpmvViRPoaHhLcSBLfc1v34+oRWC7KAHZg9w4zxZX38Fn6kufh/kZ0ltvqZ2yrMtccY3J8E3R50P7LcEwZ/IYF7xcPSIq7GSRoCu+yL+013c9i9MX9arHWTt4C96SdVOk9nnpkOf3Mn4pOANkf+ALxmZJ7Uj2bAyZl8Hinb4YoRVdOHGzcdDIiGp/RSn9NaEiOscO4RXXWbGK4J4Fw5GfZmr4koXXmAOE8+4sONw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXi1EWJkIafrgLC5rSHK7dbqR5pB14JOqcjQB4Jcdx4=;
 b=MSrsV6mYkMCFQVRj/2WaDJIqCZlt/1OtRc+5mdAmSDFZTxeE0dLPsLzlifSoKjeMgtF4UDTqi1WSNUPu4opd+cCz0YLDF6W/b8Vnc8VxhfShNh7y/qL5Jce2Ij2TL/MkSkAJL3hGnjT1fk0njlzJI1USiiJHChGbhq7M2OeO9wv7Pp1MDmwOZaYYsj5WcF4YQThBPtJ4U84/zXc+x0kq9Ddlnf/ZN0wJyko31udgVUa+TDsykwehipNjtIhJY5S6+4nW0jEq9sd/6kiYKdoxXCeBBH/ur6a9fsgqohyxywcZaufxDiY6YCdX9qi1UrbokendHg/gj7oYrNSB5NQZqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXi1EWJkIafrgLC5rSHK7dbqR5pB14JOqcjQB4Jcdx4=;
 b=qKjG+IDJ/I9qRV8zIYAf5D0ZmuEcwl+x3aa8DBtWdo1hdtUrKp956qFAL1MfqHAk5ENMBVFM1orIdmMQ9TMMBoxIDafIB1ujWlNq4QYDQi5BXhPhHEA+84VnsWVwvoIHJo9/AQ4ZRfLaESOKmgJYwPYpHe6av5iJPTYCwXLCAK+8T3FDVQwzTPlPlx8+BXNVaj/uPrHhl6e642MEJKuqqS/Yfrw3twq0N1i7QikuRr6Ms+rbf4B1Len3oZl9dJtKwAI4F1qXcO50bVQM5ZahIgPU65TsyCs11BBNUQZoS+OPWsjj9Ay1MgVhwW2+4MAN4CREuOohyUt4faI/LlPLEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM6PR12MB4282.namprd12.prod.outlook.com (2603:10b6:5:223::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.39; Tue, 5 Mar 2024 16:33:21 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 16:33:21 +0000
From: Zi Yan <ziy@nvidia.com>
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 Charan Teja Kalla <quic_charante@quicinc.com>,
 "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Huang Ying <ying.huang@intel.com>,
 Naoya Horiguchi <naoya.horiguchi@linux.dev>
Subject: Re: [PATCH STABLE v5.15.y] mm/migrate: set swap entry values of THP
 tail pages properly.
Date: Tue, 05 Mar 2024 11:33:17 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <F1B1B32F-24FD-4B1B-910E-7B36EE3D264B@nvidia.com>
In-Reply-To: <20240305161941.92021-1-zi.yan@sent.com>
References: <20240305161941.92021-1-zi.yan@sent.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_AFB2D049-548B-45C9-A489-AAE28F56BDE9_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR14CA0022.namprd14.prod.outlook.com
 (2603:10b6:208:23e::27) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM6PR12MB4282:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e8da0b7-e6dd-4b98-2a29-08dc3d31f8b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zfiZWjd7e/4/znlCw9/f2K2U0vxGeZ4qsNNq4XSmwHSTvm2/WkFA/yV8FZYDO/cayV0vVjKl/QlyWyZM65RSxXqpmX6yOVQZCfQMVNgYa6YYnGre4q3rtwqqnFsM3wQvggs+O6H0O6TWpiH8k21me682uJ2ptzwJ0C05URy+/kIdTP2pZEJkevtib9RBD3nDnjLyl5U91ORokA+dPfmavTGhL8Oj404FysafsonL1vjysSayCDMNyqW73GyjiOUX2YGOrB6Q7zqN8x7S2nN0WIGw7vGBczY1Ei3S6UrIibLx1daSEUkLRdUAEx2UmSTAte5dBACgJnT7gmRBfoLDdB0fa4pWUJaViBQMxRNNupgaNsKhjsuxUkZzIYxjE54MNv5Ml2IxZzoWRFFTkD+S8j1OwinNQRoEv6ANHUeHB0JzhF0+2zOjkMfubLWZnORly6oifAKp0EK0M7u6JlsJeMOX8OMeg3f3jlRMKAwCYDm5eKGzmRUBB8nB3k/afMNWUl5v8njDngUheywT5BWyM9uSJvjWjdN6r42++xe50rYVFU9fZhdm3BGKxCCFM76cyl3EeF/B841cD8JP68M89SSCaYg2qswf+Or9EwhTW/pYalb+a6YFUv/4/V/rxbCYyG7YsTlfMaD3ZjJMBbZCEaFGdGJB2yk7RAoZRAgjQak=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Frss6M3dJ66+pY4P/bUVmU2GmnSGxG8JrA0t3odkk5A1l9VeSO/JTctMXK9d?=
 =?us-ascii?Q?KIk7yzBkzXuJiRSQp8Kv8yAEvhgpadgy/RcGLchmzUVOquZPKjnL8Bpx15yT?=
 =?us-ascii?Q?AlaqpdQjA4w4SoMdkLZlBxN7bs627Edubls1ZHdN8PhuD+jXQXYTykdMgtt7?=
 =?us-ascii?Q?zOSLeZQhsaiZXo7gicNuoiAKzWiLR4T8kr32A4p4aaiJTMrJVXD2Tnzri6EJ?=
 =?us-ascii?Q?B9Gma5/LbGAhBlmhcBtmy8Qe5uqJDRD2uK6ZRx3RX0KCDatSqcMMQwnPgBRC?=
 =?us-ascii?Q?NZjdicZq3UPAYqJ8UBw6IJcpH9lLZaAU1ugTxkTbnShSPygGFiaxKxFcIeWC?=
 =?us-ascii?Q?/HFDXisb5eptKY6nh06PRMPqMRW25e9ODbT/6go6cuQ3EnjoS1AdYAjeUTVj?=
 =?us-ascii?Q?3F6CBoNwiSuIcb1noVp7oPoOXac+cxnYBufZD20eTLm1nUy8bZbfuTQzdOBB?=
 =?us-ascii?Q?HWIWAIie6tRuh/k7RZ8SeDHgAmHj6tTczKKNaB10Xf6wLmTK+ytW5NfVo+nZ?=
 =?us-ascii?Q?Qpifvn+1CmNucTgalAYPo3E1xLWv46HcUm4+kBntooMXQi9prM/0T3t3vJPR?=
 =?us-ascii?Q?DGUFOrjKe1jhuyhs4Jy60g+K/JjzDL9UVHVxjfk5zfKBveHux485WNz0Pvpx?=
 =?us-ascii?Q?o0YKtcCye20LaDXmDyIV2cAbyAXuZOX1A5JXXy9F/TE8QL+qJTqwYVgVJnnQ?=
 =?us-ascii?Q?fclO/6l7qPwr0XoFCbnwxhoVBV97uleED9EWYnAUPaZKe75MwMJeLlRxUwNA?=
 =?us-ascii?Q?bkdCQHE9oztK5936qco9DcXpZeVuloUvJeg4rjjIJ9kp3KuJ11J9O7nP/E+W?=
 =?us-ascii?Q?7454z3hCZjkPPwsUwq01MxGsBp0K4JiXnvUjChhce0GESLYnkAP+fKNg1mX9?=
 =?us-ascii?Q?srqfd7lPg8+b+qP3FSp2JThI092GX3YoPSgfWqXzxg0FsZjfFk4PeIukMS2p?=
 =?us-ascii?Q?VOlFDQ1N+SUbSVvL9EIeFv1mFT0zHJ9ys8MAs+jfEwbWyu0SRjYP4bsuzUyI?=
 =?us-ascii?Q?8mcoSMk6F1wbUTjr7I0wqyPbPIHU5K5A7xQw9+SmqndOL1UqSfWT67QzGTUk?=
 =?us-ascii?Q?cTdTmm6Xo+HJ8ewd0zGMPVhqLHRacIM4dEOGMRLb6QBHNE3Ojg8wbf3e5wZ/?=
 =?us-ascii?Q?QdXEUzVaTVy9H6b18ksUxm3A/0jUztFQIW8PSrmfqJQLug+aUz/TOsiNYhVk?=
 =?us-ascii?Q?NMJhcK7YmlmbHm+XMGQ6l42HM07ckDlzkGio4NbIJiqs3jwxHjm8+7yTsNxl?=
 =?us-ascii?Q?IcITbaUNFTKmhYKvgPAxuk/jQvoD5kXdaRyQ+yJSeTwezV5Abhe+juHscmZb?=
 =?us-ascii?Q?sWmwarrSFTYocgeoBWCGfp2nTholDTdJwTuXprpOPzuCnAE0fGYDwJOciWP0?=
 =?us-ascii?Q?J+J/rW1rUFlAxgeElQIA/ZsSNSiPmdYzLmnm6qdCWLIEVeGStfGd6v2uh6od?=
 =?us-ascii?Q?80sLMOq9jH4yJjiz/2aYQI85eslGqVcTnFO/SFFQeh81FFbVs3GwPAiIw+m8?=
 =?us-ascii?Q?Uk0sQYGGCOL9bDzuo9sfCholIcqz2mrrbwXRybloP6UIAWaE7Qopa4Tn6xWv?=
 =?us-ascii?Q?DtgBrMdfAbkQ+dT295womBU11oJRaRGf/Uzv0UIS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8da0b7-e6dd-4b98-2a29-08dc3d31f8b9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 16:33:21.7255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CzJ+wcvuBFbkMT0IdrSqlqGy8M0qeQs+RFcB3NcD4F32f50NquiWAOSkpuXC4g7o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4282

--=_MailMate_AFB2D049-548B-45C9-A489-AAE28F56BDE9_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 5 Mar 2024, at 11:19, Zi Yan wrote:

> From: Zi Yan <ziy@nvidia.com>
>
> The tail pages in a THP can have swap entry information stored in their=

> private field. When migrating to a new page, all tail pages of the new
> page need to update ->private to avoid future data corruption.
>
> Corresponding swapcache entries need to be updated as well.
> e71769ae5260 ("mm: enable thp migration for shmem thp") fixed it alread=
y.
>

Closes: https://lore.kernel.org/linux-mm/1707814102-22682-1-git-send-emai=
l-quic_charante@quicinc.com/

> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/migrate.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index c7d5566623ad..c37af50f312d 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -424,8 +424,12 @@ int migrate_page_move_mapping(struct address_space=
 *mapping,
>  	if (PageSwapBacked(page)) {
>  		__SetPageSwapBacked(newpage);
>  		if (PageSwapCache(page)) {
> +			int i;
> +
>  			SetPageSwapCache(newpage);
> -			set_page_private(newpage, page_private(page));
> +			for (i =3D 0; i < (1 << compound_order(page)); i++)
> +				set_page_private(newpage + i,
> +						 page_private(page + i));
>  		}
>  	} else {
>  		VM_BUG_ON_PAGE(PageSwapCache(page), page);
> -- =

> 2.43.0


--
Best Regards,
Yan, Zi

--=_MailMate_AFB2D049-548B-45C9-A489-AAE28F56BDE9_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXnSU4PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU4qoP+QHH5Ioa9y/kyrkkwAcDmaTAGMKvRoVg3jBA
5fGgrFh4uXWj4G2ay1mMH2iciveO8nnEJLfg+x5A6WfwDuv89hBPKC8qYWn4nvAQ
ZrgYTmhqK5eJr5o6TEHRz2cdf/hRO1GVJTdZ/6NkDhX/SXdaoH9RjQSyeBKd90AA
khB/1yvveYCN2J5vKmOV4mJ+ClVOZIhK5GWgFLakSkmNtvFSZzZ21ovGi6CFSWoV
utbZ4oOmNVBumnBoS+dK8Q0JuQAWuQhhxtc5dBvOqWxNPoPTmNmXzRrLGMHECMC+
4s7VKIqNJ6qUR34nFSc4d9EcyxDZxjze95u0o6Tx082KOzraE5r9NeBcLPpLtFfI
f50n+Gf1/e19jMSpqIjI3r4UUy87KC7UvotHWcPB7B9iim4r0fgK3C3LAJGKNs9B
F+BFHBPZbq1p1Yg6SO8PbVliTTSEV8pKbUGnOm3Qhut5eTY9wFBq1TmkWtBayq00
XMkN2U+h6axQBgPURyX6bg6v10j1wdJFaDW4zjIuwjw4NEBH/ue02MFe0vffe9ax
bBBfAbcMmfXnuwJgv/NsGFQHC5YZmUhxaWTY6ElV2C5BL4cShnbjgunux7Bi+zB0
BQrXdA7o9e0dEwnDjhRabfAcyugxX/YSU2aNh3SIa/mVZd3lFHuzqUMmoNJGSf27
eHFWLVnV
=fUft
-----END PGP SIGNATURE-----

--=_MailMate_AFB2D049-548B-45C9-A489-AAE28F56BDE9_=--

