Return-Path: <stable+bounces-26806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A80E28723ED
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 17:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6E828729D
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 16:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE74127B7A;
	Tue,  5 Mar 2024 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FbrwlCk6"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E92E3FE37
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655462; cv=fail; b=Ei5g+hNeL+7/bFvlyvvhxz1/6nNeeofa5xnv6x4d6mFj8sBnnaD2nyC2zwbPz/yGPwB4T+Evg1v0V4aduI+/jhiZObJNiIQiJ51y2z4bVoKH+YhNsF9Kb8GE4blBof1S4WIUM2R1WsH+fRsMEWb35VLtbwzZyGksnfvLuUIb2Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655462; c=relaxed/simple;
	bh=KufxFEpROBQ8mBS+r2iOoR0toYrGnbCTB1Nu1AaZbKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ekIKMzlLxkKVCKl2sr0RnS9APAJ35H74542YT8M2+tSfFJD1P1tVMaBurAEbLAeB4S2SSazCRrhDOPT1fWWseuSAQos4pBvxr2kifGWy3u1o3XIfAS6xamdfILH+1lhESVnbYx7CnHpY9mwJiqY2vzaeQk+LunAU/RRNiEGFdVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FbrwlCk6; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYCRsEmx3jU/h4YIJ+3/VT9OuKKzfCkzl6waI0ucBG6Ph+s5Q3MChyffphUPXBh40WVEiIigasPI2GKoyfWL70lhLwWiU68aTdvA/7QWiMgJBl3CGXh2ykKPj1rbQd3UcGfyskNH6cEV80ZMvsPucOISDpitJgV595NPuhEg0ohcSD8qMS2Nt2sIdPMTiK1CwAOAaoshT3fquo82N3uB7V8l+0lfV6J7lwU9feOvvzUm9Nr9NWU4tKK8h3vu4Z91o3WmcQTGMKy8CoTkC9Y8yWGeu8qG3GhCSbPGM+3xlMSutJfmaPLKSeIU/YyVbPusI7uyhebEvMh43p9KBmcaHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1OvJ2W5yjqWNVI60KrhhaetQqfOh12JNnjqWrUGbPI=;
 b=mSnlDHJLiabfQiolTelypae8dTQRYbTElcj9H+94v4ggrSopP9Hk4QScgNeCxrjeyEFVv8/ozemssBUfsv1Nsv2LXsopplgmkoT2tGXRPJpfzMfjpslMstXpztwYhpWwWI4Ie6P8UGmmo+8yL/rm3td1ivN0DqNnXiSBSiW3z+VuzUOW/1d95dDjNvb7VP+C3oubl9yp8/ra4noVFxEaiXesp+wYU2UsFjhhqz+h+dfRhE5ChmJNgfJU/0PTiG3gXmCstDtCayM7Rt5NmNuRGEHZLaJrq6KfNUpkGaB/tu9PjvkjvzawZDLe4UF0UV4yd5aMHzxS3vQUL/p0WYV0WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1OvJ2W5yjqWNVI60KrhhaetQqfOh12JNnjqWrUGbPI=;
 b=FbrwlCk68stt7ek3USf1RnaZ7oo8VtJj0ccLERUEFsI+MVpBMMaWUKxxsop5uQkms0TC6o+cgYDwU5W1kNcCVItO/iAJ9QCE0JMj8a5rd/CYcJIfX/NCcRKAn0LqKHz3d9NsnbJ8g8FW8d86D9pFrW1GeVo4qnAdZLxCqFw8U90qFddVezk1WLSkXKPqlGruzUlHQeLNg8/LIPtUA7BKWCM9eSK8HYy3sk6QPEwZmjL5sbDEpxawoBYZ/ijbnn3ShqpBDiE1xu3DKDakqpsX8hTOGOIyPACDv1puXNvH1pea/TdEaAZyTREhzY3mtsUECWavAUc5SF4HCuO+e+7pZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.38; Tue, 5 Mar 2024 16:17:35 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 16:17:35 +0000
From: Zi Yan <ziy@nvidia.com>
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 Charan Teja Kalla <quic_charante@quicinc.com>,
 "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Huang Ying <ying.huang@intel.com>,
 Naoya Horiguchi <naoya.horiguchi@linux.dev>
Subject: Re: [PATCH STABLE v6.1.y] mm/migrate: set swap entry values of THP
 tail pages properly.
Date: Tue, 05 Mar 2024 11:17:30 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <F242A2B9-8791-4446-A35D-110A77919115@nvidia.com>
In-Reply-To: <20240305161313.90954-1-zi.yan@sent.com>
References: <20240305161313.90954-1-zi.yan@sent.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_DF2A2EA2-EECD-4595-B653-A26491A49895_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0293.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::28) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM4PR12MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: eb20eff0-5fc4-4859-2e58-08dc3d2fc48e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fXcjQfm7+TMnjGlZ4ewGtjClChXbeaKMFNN1fpkl2p/3i3HpQlCivEFEB18GP2yi5ReM8E3208PN3JL5Bz9y4yed4aTnNqpUapzAWGPYeyTUx5o6n34UjSbZpGnJQO/Dnknx6nZ2aj7UpQbSgcHhBObRAlMjk+EcIaBeXn/9fMTyq+H1r0lQXdwnH12zHZdjOJl39ybp+FVbv/m5VEmVmxIekVX5WMumGbood5upUt21iIqcf8aBUi8oU0HhCFb3H3//E57q1BzMMsABrBaOwKvU4WVg85O2MaaRDI/S57wtjIwPo8ziiIJ2Ll3h1EGpSWSlm/7QHdhNwFuats1eoYr5USxp2hz+mDsn7ti5ZoeaIFmHz2ou9csJj4EuL3cbgSP2f8eGyrH8emDInRszNJgjeDhJQnOPF9eVZLEnK6vBaWdnb1s3AqAJG1dA500wz3fvM1B4zRpbU4CHuZHNKnW5FIfntjmAD/Wt6BllgdAGqycjKU/xbS2LR202279+WmhOIAufeYPF7Q6TNxhsIdWGWvCDfe1zVeFDOSM1/gUT2r2pyPZRaJKvTruhhL5edlu4QmJE04UkkH4ETUAB/pWfKmxsHknqRs0w0p9rVj+f0xqyRieeqFR1tK28ciuaWdliIlRH2tWsrhKLUc8RCmZhPbNMt/nCUzf37BsnGE8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uC3IqrJnAbzAd62CxnJn9xcFpTo+jY56lrNkjjsbTw8tEUxdPEj0qRG9yg7n?=
 =?us-ascii?Q?AGupiQ9p2UtGSLxXBsz1X69RgaoLUEUqEwE3+doTfdlNTyWQhK2Tv0Fgmku9?=
 =?us-ascii?Q?seAGr/p/85wsSH8Fa7fgaI5faD7NNgG/2VsQTTgRhxb7o/FDHednxEHsDzYw?=
 =?us-ascii?Q?bxr8AgOisNRT2mWMLax+yk3isLDcTDnNCJpEXOb3UneWPikjy4ybXILAM1P7?=
 =?us-ascii?Q?+RHQBPRnF1ziJiy6SfMuangJF94Jh72/05yavqZFFJuP2NsuW9a7a/Jv8Ucc?=
 =?us-ascii?Q?yefZoWGAgTWxIbnZyqTo+4QZ2cGhyS7SQb+zmBVNdgLKjqbnAr3sntq5S/6e?=
 =?us-ascii?Q?oJwI74KNbiM+2ONRRhdQSE9ub2UlCpoH+8B587OAX900BgK3xeL5CnDrV8Yh?=
 =?us-ascii?Q?n2MKG8fE+B1xHZzA1nz6N4z/QJE6Z3GIH/1q2W2+gPX5IDyl5oaIr+OGzIOu?=
 =?us-ascii?Q?fHa5HF75aXeaFrAZT8PMPj5nIFyoiZmupJOecmhTjvDFQdMTavwVpgGdp4x7?=
 =?us-ascii?Q?QK9nNXc4VH37coCETuPavdMCdhjD83xDE254cz9PLXCG11duuc3Nn3QlNoab?=
 =?us-ascii?Q?mkirT7YG+M6wJmmUCV1HOrOSHm58/xCA9lubYBnGHKirQQlxS1SRMvyeFFZM?=
 =?us-ascii?Q?jFqJzHSC9f1vHZyzgg8J91BrrspPpmScksB0yl5VGonnv5vWmaCIXqpwRDqq?=
 =?us-ascii?Q?Mm1efssuYAwgl2KSiSoLFN/7gAwvHrgYhplpwd4gtKl4o0QNffwsLH9Kn3qG?=
 =?us-ascii?Q?oQzbnVl3nEvy90FlatokoYuHFyINIRHq7VwEilwX239+FeKsGAoyi6wyYAez?=
 =?us-ascii?Q?j+ce4RP+VsIXE7Ey0HesxUXbcARxAFWd3XJivMw+XmMgOXZgMw0p29D1e5l5?=
 =?us-ascii?Q?2jVF7MPzpihd87mh84dxMho0sg6zZN39UfSbcDc1Fu/EhGMeFH3p5KASzvox?=
 =?us-ascii?Q?qeL+LNFPPnlLjwnMwAHq+b2gwypkLu9tEvnFq+FnFBVZ5P8yVNT4DoQ6BE2L?=
 =?us-ascii?Q?xP/1rNZX9azqVkELPNcV1ow8u3fLGw9EgaMVCTxkx0GFZJUHx0PJ0h7Tqmga?=
 =?us-ascii?Q?bSvXiT8SoH7bvVjYmcTasisrvlM0xMxPWsgbFm1r2FORl8v9R2FNG8/wY0bg?=
 =?us-ascii?Q?RkcdSBQkR3Y2eoXC2s+yi+iajeHIq0lFA5qzsD3gLdNiuLQyZ6YXoUSpgs8s?=
 =?us-ascii?Q?GPlmHAdFyO9FvXzmiR/eFj5jcFyXsqlG1yYJ5oqxZbq/25qt4XeDQ/gSno55?=
 =?us-ascii?Q?+aVIWcdAS3aDa2dziEzDbGS6LZD28b4Z60RVogepEwZQYPi8Mt03Tp0ZYAqp?=
 =?us-ascii?Q?PgNYS9UYdnqt9a/WRgHUVKNpju1cZ7XLrwsUYFGo802OqilO82w3ScxXwcqT?=
 =?us-ascii?Q?4X5VJjlSK++2hQ2sarE57UZ/OQFsiazFx6BynO78iDrah7gYdmYHYQmnqP48?=
 =?us-ascii?Q?X+Dy7Lk0UlmHPRccnI0JzZOn9WdJfjStq7c1hlxmWM+sWlZMP9eWiv4AyEz+?=
 =?us-ascii?Q?szzbDmZIMq4+4ewKg3Akx4H+b35YvaTbnGnkI+rJMJT6ikb7WQCBZhUImTmv?=
 =?us-ascii?Q?e0Eg+cMX9nor4sobl3Y=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb20eff0-5fc4-4859-2e58-08dc3d2fc48e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 16:17:35.1652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4atGJ6ZYI8Im/fZuCbFsIwClitXAtdcJwrSpPYXCrH4FB5BzdqZQQ8D4CO2038/g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6253

--=_MailMate_DF2A2EA2-EECD-4595-B653-A26491A49895_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 5 Mar 2024, at 11:13, Zi Yan wrote:

> From: Zi Yan <ziy@nvidia.com>
>
> The tail pages in a THP can have swap entry information stored in their=

> private field. When migrating to a new page, all tail pages of the new
> page need to update ->private to avoid future data corruption.

Corresponding swapcache entries need to be updated as well.
e71769ae5260 ("mm: enable thp migration for shmem thp") fixed it already.=


Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")


>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/migrate.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index c93dd6a31c31..c5968021fde0 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -423,8 +423,12 @@ int folio_migrate_mapping(struct address_space *ma=
pping,
>  	if (folio_test_swapbacked(folio)) {
>  		__folio_set_swapbacked(newfolio);
>  		if (folio_test_swapcache(folio)) {
> +			int i;
> +
>  			folio_set_swapcache(newfolio);
> -			newfolio->private =3D folio_get_private(folio);
> +			for (i =3D 0; i < nr; i++)
> +				set_page_private(folio_page(newfolio, i),
> +					page_private(folio_page(folio, i)));
>  		}
>  		entries =3D nr;
>  	} else {
> -- =

> 2.43.0


--
Best Regards,
Yan, Zi

--=_MailMate_DF2A2EA2-EECD-4595-B653-A26491A49895_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXnRZsPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUBjIP/AkHbaGRIFWAmlr+nDwiCmKNdDWE1WyindmI
lcFieGcv9ml6oAIFChABq76rptAfiNlQoFLYQVOURbaoIjBoo/m4qlIOArbkaTqF
RThFqkQRORSQORgK6WZeYN7M0Y1k7J1RiJYdgCnM4fF29J2Q3FOojKTtOMnoR1oL
MNbApPMgLciqOGKSY2fljDIP3rTMyg7Z9o/VuWu61n75cuN2jD8ed1ceJi1Jc6YE
qir+hQJ8AHa1HsRACDfaGXh44mMXk7kUUGhfgCikhLf3SPGaaeeUXY9hyw5m/rJH
xiQG0Vg3XvsZ4yH0DBfKo4mR1UEDdORe9J6evXGynaIcP5fMEIRyb+e7laKjoQrl
Cjtbn2G/96sGApkieysebbSwdblB52OCGwpW0/wm4NBWLGXCXJRKVN6xTKDt1/cA
Nxnvc2qo9QyU7+dZR2d5sCbvqSJYBTpvzkEMDll4asOWPGyqeWzjLCVIy8M4AxHw
9ZK1RsM8FBPi4zq5ZlTkNrPkEeYv0XB92IK6+HnXfV6aAtW//V/F4GXn4zL2Dx/n
2zdtOf3YzhRjWV3zTYhbEFCzTKWdw9gM94C885ul7trr6vM4/d5hKpMz0oCkL/ja
dxg2BUevguwHnnpYxgPhDVYUNKF+R8xuLhM/Y9YLlYW8kOLbo9z1gDVYyXA2Sei1
NN8pnVQk
=iHvB
-----END PGP SIGNATURE-----

--=_MailMate_DF2A2EA2-EECD-4595-B653-A26491A49895_=--

