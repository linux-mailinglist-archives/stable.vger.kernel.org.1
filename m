Return-Path: <stable+bounces-54835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B2E912C26
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 19:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6686B1C26148
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 17:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E69A13D521;
	Fri, 21 Jun 2024 17:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GTGMxUYn"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F87C161306
	for <stable@vger.kernel.org>; Fri, 21 Jun 2024 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718989257; cv=fail; b=gVZf7YDy5ioqED6fyzEQnQJNYE6HYk75IvI9smPGY/QtxdO6JsNtjxnt6DwNX4Zg8biBr07c0fgdyNbBKzvug9dJt/1kzhlwQzwlj7sWNAq2s4gv5S0CGlGl8vXLrzR57UyltbbFbSMrSLbxzDBAxzV8e1ZDxgA4XcQuanjaowg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718989257; c=relaxed/simple;
	bh=qaa4jcDdsICiRzJflciuSiGLevWym8sl6vXvzljHfbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=om7dxD9XiDa0DJfGk93lQ3MnY4bUb7Jng6pijVhnwozZzCWB9c8Ta2JBXEkNSGgxWo9S9/IlABx1cUhnOPOEB1pdw3/mUlp0v9qI6/F6GU2qpJhhZEU7OoL1iErU8Ok5RG+rJRi48kIluZ6gnhstfDwr12KVhc/tllRaJIDTwkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GTGMxUYn; arc=fail smtp.client-ip=40.107.212.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYMk8CPjUShAUW7fHx8JKFIB37H9ZTp6esxNgxoqGlaL7L3tN/mI62W0lll2ifuCqrVrXLUJkhco71JlRZtcJZt5/1gYjRsMvWmRn/rmaDu77GNBYMs8VU//K+onl5UYS7ZKR1ZMwRj+6ffihPiCwhuFLRjW7fE9ude7WUS/tZBgM0nYmO3xVW7k0YVxyzESt8XITlCdSKNkAzS/Nix9le8cdiAdx5zGLzje9P5ano/p59Eq/P5l8sxUQA7wXQ1HDIX1seqWfVAOk87FfSNGQuZtIi5U8RtK+WDm+ixNsLbLuundoY6moGObdOcB1W1WUNcPQ2SUqqC+24C1tQL3bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Va3ixJ9vrc3ubPfdk4VYCvq4c6rMg7WJhpGMFszhTXQ=;
 b=bRqXZJaOr+UWf4tORgpxJ21tElhBjvw5rpyRC/6xW8dgqrkeVN9mifrzlkvovgYaL0a9SWO0tGB+OSG+vTwByccEfwl6OoIrwHeIJ0fQx3t1/ILu80ZyA4ILApj4zb3rqU51NAKx/Hs3OM4RkrYiO8qFMPmPPyFwN1amADdfrVohqbyg2WHblAgfqv3fUjUNV/NMYjQIj1RVLszZeSV0RxDudgaKn7yu684QusZudQuM63zIJJm0QmzeVWw15KEPtUyp+Qn2eatxE3zBWPTX78a/V2JEZjT+xX7FMBRbTBfDlkb1aPGkIsV1Av73tyLgPoaUWk+S0exdghk90ja+cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Va3ixJ9vrc3ubPfdk4VYCvq4c6rMg7WJhpGMFszhTXQ=;
 b=GTGMxUYnSAzmgh7KH0NArC/1f5ubOR5VgnmYemGt2m/yHae/9RNWmhiDfCut9xUXsenmAIOo9fAn4hoV/fJaL1Tj2W+bDAMNMdd0eecrGSfoheeXpBKjHCTg9OV0CI97+O3SeVnOtrkhSSDIiuCghpU6H3LhPKjDITqmXVQwxuFbarnAyUIfgdHHcKBcV8jBcsahqcY82zTd75AgOjvcLbSuE39ZNvYNHLy42kbLBtYxrU02NekNLkQuRoFN2J8kNeSHRXsqbfgy8LffYyZ25JuU31YEi/MGvho5LBwfyhZ6Orq2T02ewHH9G1cG8ePv/7qmvSbP2jIh+uKIrHM3tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH7PR12MB8014.namprd12.prod.outlook.com (2603:10b6:510:27c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.24; Fri, 21 Jun
 2024 17:00:52 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 17:00:52 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: stable@vger.kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
 David Hildenbrand <david@redhat.com>, Andreas Larsson <andreas@gaisler.com>,
 Andy Lutomirski <luto@kernel.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>,
 "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5.15.y] mm: fix race between __split_huge_pmd_locked() and
 GUP-fast
Date: Fri, 21 Jun 2024 13:00:49 -0400
X-Mailer: MailMate (1.14r6038)
Message-ID: <5B126FD5-EBD7-44FD-A88D-4E94E53C9A5A@nvidia.com>
In-Reply-To: <d4cadbc3-05b7-4d65-8d67-79b62a09724c@arm.com>
References: <2024061316-brook-imaging-a202@gregkh>
 <20240621152243.131800-1-ryan.roberts@arm.com>
 <f6454225-dd2d-4e22-8d86-b41ec6fe48cd@arm.com>
 <d4cadbc3-05b7-4d65-8d67-79b62a09724c@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_910AD749-E33F-4C17-9748-FDD9967C2DDC_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0444.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::29) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH7PR12MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c2793d-426b-4a2c-4763-08dc9213b549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013|7416011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LqP9FVrQVVGTOuOFCrSIq9magSYsefjACBBohhcrXzExGhUpUsW9X+ulKMa1?=
 =?us-ascii?Q?GtyrAziKw7BfTcZyGd63scHk2w0p4m4Msuj1yn5lZLkoDmfOgEdBB+QQ6qmP?=
 =?us-ascii?Q?ljExVQPOHAtTA57FKVr6E6M344gw/+HO+i6KKO7DagBYbEwLSbTXWXj69TYN?=
 =?us-ascii?Q?ZMawFN78VBMN80QJ7A1/4mvli1DwXMm4EE7srAXtSLG33txM912d+/rCfBDg?=
 =?us-ascii?Q?ncRvziOVmq//GNTWFxnyWVC/tyfunAXED8iagEb3Bz7VdaDGQFkEnRTUv2QU?=
 =?us-ascii?Q?QWdPTCXs8eBnYK9B6+ws0aMV2EWMapg1FdyYy13QVtNct+o/N/JJF5je5lY2?=
 =?us-ascii?Q?iEQXzG3l707vP/tTgTvmUTjB9ySfTh6zXpWi9oqaIeu7Mr0Z1C+9B7z69WPS?=
 =?us-ascii?Q?OzTvA5wHa5S0BmuaZIkYLOVVEluIT0Xk+QJnCkOYfmwjKsEpOSBVEbYIxbkZ?=
 =?us-ascii?Q?nzzTJAZjwgEl/RlksV0NTPl+YXg6XwR+s+mfT0S9qOxd06+ntCHPOYgIEKmF?=
 =?us-ascii?Q?A9nQeGhuX6085eq8nkbE7RfLE1hPHVWMROzqBK+xMkPTcKq/E/hypiwakXaQ?=
 =?us-ascii?Q?VS8Cmzwt7XXlwERwS/MbT0UDF6BgQbHySxhD7XtRDLTfF5JOtPlq2gdBN2zi?=
 =?us-ascii?Q?JHpwHQhrmH5UEr4BWj3jmuHaU2Hb0VS2+QaDjtGXpniJEtSrqHO2qFuiDINk?=
 =?us-ascii?Q?W48z0azJCoasONvJKipbDW8TC0C7BP4K2WoyuQ/g4geXG/1LyRWI9GQSN9LS?=
 =?us-ascii?Q?V7f9cRSSnkPJGGHvHjD5w+b1r5lZR7Vh+TGLdM5d1LT+20upKhz2dbL4Az4o?=
 =?us-ascii?Q?pcNeGqrmpCXVKCXvomXukJTwnJRKfYDmzbhs6TsBLOah87BaSRjnTTS7iOh9?=
 =?us-ascii?Q?ZhcgW9GMrufJKNxtVL/f6k/d8h2UIQw74eLKSNI5WtS+kUyYa2fpQR1e1t9D?=
 =?us-ascii?Q?tqDNIUWTgsJHAhDX3J06ysgls0IKp1N3S35uJuED9k5yMn11nddE3MyTsgkU?=
 =?us-ascii?Q?PE136DCi7ePzmC6+4xH/3hrYhKqQysDQ2awsxDu6zNg7pUfouH6aUnb4ft4X?=
 =?us-ascii?Q?lNp3rIN6q9UPC4PgTOVbyurL6l9L2ycvaEGulLWtjZarR/1sbDPhoZbJnpAm?=
 =?us-ascii?Q?jm3zRu+JiQknTi2sFaczC6R1fhOubdreYa3E8jqj9Kzt04MIYVzCowqz87e+?=
 =?us-ascii?Q?k5L4vxmqm2XvyoNbPWpZt7WEZ3Jxe2s0O/UQDappnr0XWzCaI3+oTW3+L9Aq?=
 =?us-ascii?Q?Y6w3R3lEzSn4WFmX+JXwGkePr8LCaLSF022wExstmeBV8WvVmiCYNL1VBxo5?=
 =?us-ascii?Q?IOrGo+P+vhgPc24sTN2jKdD+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013)(7416011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2DTF9+7zZJbjPTNboBt3HPk42j6bshYtaJ+qcNHO0sX/Y+iieSkvP2OxOFIM?=
 =?us-ascii?Q?wRL4/x1P6daVxVDoCvMLdGNxf7nqg0dzw01bpYXRDVcLtqD8Uym35qdAGqSk?=
 =?us-ascii?Q?yU0OdwDunTy3Ecp2+nViVo+l0veuoFyt8YxINJu4XBGKJSWQ0iaTuBtwgdEw?=
 =?us-ascii?Q?qho3+tO0Y++jYXgPMSonKg+n97oha6+uSCahfBIBh3JWl4VTBMYuCuJ5vxcD?=
 =?us-ascii?Q?fFpMZOLBmBdy2BDVSrTxfvfIhklTc93CI3CP9UZIZFeMRLhsJmD+pYFOTU5j?=
 =?us-ascii?Q?157HBA9/dzeicLx5Oq+7ZjV0DWOjB+bFvd32XH/3FzHDTBn6Bzm3HazxhngV?=
 =?us-ascii?Q?E1XIPLJF0GTi8V7ZiDjmyW2rOD1oKLGEMUZnh7iyD7ZcyJmtq8M00pRj+ljZ?=
 =?us-ascii?Q?pY4K1dMFed+m2M+/6bw7C6BpdbwsPylkK//ybOpYZay2rIqv5iUdlSSZciZJ?=
 =?us-ascii?Q?c3jwamoPMIO/WVFo2f7/5FbiEE0duryinBPYWzt7dPn3TbDJxHMJ+PP7Cfrf?=
 =?us-ascii?Q?AEwakT7g9FoCMxdJbDsunnvPiV3tY3sRbYT1A3D6tO8RwvZ5bVDAVQVJx/QP?=
 =?us-ascii?Q?IfTuQWNPbXY7ZqKP3gKAI7v9PCujoLRK1toGdjV6wROEIAFeIm9ARxOtOHd9?=
 =?us-ascii?Q?tnj9LRrRfVPZtC7tpwIUI30C/vkPug0stHXV2ejfLEExgIYwjbReKPFeeJfL?=
 =?us-ascii?Q?GB08OH1vxwMYOI4tSRwv+CN7VGXpsVUXFWotuW5TceACB07uds0QFWj9DMLZ?=
 =?us-ascii?Q?lK4uEAXd+coXhAycT8fSsEZUMagCS2F15iGhIfgu2WHSxTQ3y4wwYRUNik9t?=
 =?us-ascii?Q?rSWt8utZwy1mNPRMZeBPjNut12hs7N1g2nv6lfHwEoBQLY1mlXs9f7sVe6oj?=
 =?us-ascii?Q?pMEu3fa7TSlPUSrytILqkuoX5DEvjjD/XfD44Se6GyBl+rKoKup+TDcTO4cx?=
 =?us-ascii?Q?dr7XqI+nDb2LqF7mQ9/oLdf+nM2O5UcVbgDSLlU6bhjwN1eEndK3KxYSTJc8?=
 =?us-ascii?Q?2Go4weBjwyHBLvUJpXkxzUb3R12fs6hgCL4qD9zpiLaRpdrMkkYRLw4o7wVP?=
 =?us-ascii?Q?A4IDen1MZ/ZOwcZjmy1U8kMHzQW2LG4vu/wtTTFtTQGHT3V9HXojrIw0iaO1?=
 =?us-ascii?Q?YJaqa+AUWeeTwCIlQUGiM+1Nf1ywjyS+KNzN5vKwzYieH3Vvkx+/k/ggdhBK?=
 =?us-ascii?Q?sJdbsRsDn0qCJEa8c1UcT2Od25l5gMRC24eTdneY4G9OjmpBTWSwe9AIj9Ba?=
 =?us-ascii?Q?1+uS+wIEU1MbDGqwPgIEaL+4aabC7OncE/NbTykzHEhOQKoRNfyNDH4E5K8h?=
 =?us-ascii?Q?L0uhm1/F5dthH1XNCB6JCevQko1H/4awYGsuQ+R6fK1fpyzRW98XDozNYYvv?=
 =?us-ascii?Q?pB3g4gFnQ2EB7B3Hwkt2yu7rS9NXV4ehRPB+EP/44PyDB2r20j4hnvFrz431?=
 =?us-ascii?Q?S6hA10K6Au0ZJhjJ0iYs+47lEYhhefemneKfBlt9MtfOegmdDk7tp0QCsCF2?=
 =?us-ascii?Q?XyDmNhxPE3Q4l4MMnshvc/Jp1SuhU/XDo/SB2b06y8BukKMWge2kPDeWwegM?=
 =?us-ascii?Q?UZ0IBVTvHluOjdm49kM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c2793d-426b-4a2c-4763-08dc9213b549
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 17:00:52.4733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/NHz1Bp7m6h1Zq5moGUgx8SaQMhL/BihIsXke5LA9IvGE4Cv6/3yDTzG7Ov1EX0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8014

--=_MailMate_910AD749-E33F-4C17-9748-FDD9967C2DDC_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 21 Jun 2024, at 12:34, Ryan Roberts wrote:

> On 21/06/2024 16:31, Ryan Roberts wrote:
>> Sorry, please ignore this patch (see below)...
>>
>>
>
> [...]
>
>>> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
>>> index 4e640baf9794..3bfc31a7cb38 100644
>>> --- a/mm/pgtable-generic.c
>>> +++ b/mm/pgtable-generic.c
>>> @@ -194,6 +194,7 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_s=
truct *mm, pmd_t *pmdp)
>>>  pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long addr=
ess,
>>>  		     pmd_t *pmdp)
>>>  {
>>> +	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
>>>  	pmd_t old =3D pmdp_establish(vma, address, pmdp, pmd_mkinvalid(*pmd=
p));
>>
>> old needs to be defined before the warning; I'm getting a compile warn=
ing on
>> 5.15. I fixed that up but failed to add it to this commit. But the rea=
l question
>> is why I'm not seeing the same warning on mainline? Let me investigate=
 and
>> resend appropriate patches.
>
> OK, it turns out that commit b5ec6fd286df ("kbuild: Drop
> -Wdeclaration-after-statement") (v6.5 timeframe) stopped emitting compi=
ler
> warnings for statements that appear before declarations, so when I did =
the
> original fix for mainline, there was no warning for this.
>
> Current status with backports for this patch is; you have applied to ke=
rnels
> back to 5.15, and from 5.15 backwards there are conflicts. Clearly when=
 applied
> to any kernel prior to v6.5 this will result in warning when DEBUG_VM i=
s enabled.
>
> What's the best way to proceed? Should we just fix up the backports, or=
 am I
> going to have to deliver a separate (technically uneccessary) patch to =
mainline
> that can then be backported?

Probably just fix the backports. IMHO you would want to follow the expect=
ation
(no statement before declaration before v6.5) of the kernel to which you =
are
backporting.

And thank you for taking time to fix all these.

--
Best Regards,
Yan, Zi

--=_MailMate_910AD749-E33F-4C17-9748-FDD9967C2DDC_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmZ1scEPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUiOIP/1Zm71HaSWhVZ+g5bpePBBy18O7wHvE2dBUp
ClVUCV86o6js10I7bfptyzo47L9EUZePv9u12byXibjBmnJr8JRlPTqkVfBHxaFX
/1KmjUol+9BsDk+efNuC4hPH2KNWOM+1cLSDcDuMMtdjel/O4MfYIEamPzpSM46n
o8xCvl7MdxaoYTcVo3oZIBkLUbWg6XYfK+ltH6VDWaghXBAMJca05aVz1S/+kriq
qY9cy+kEOT9YyEfmxh83RthBPqmvNEqoO7Yc+crtUoBcxPgzvDTkuk+pw80tmglj
ylCP+cYc6oj0K8X+H6YwOopziVclUHobzLmlTmWKjryUXAnfq+m41rlw1e/PPgSO
uyLeUyNgVw3cS8RL6ybgNQC7SEiBOXvB0obIHGRMmShKhc9AyjC1mJTxc2E77ajA
G7SL56pVzYZx6L1eggPD3deuLBk1IEXultf0tNglDR8at3TDy1H3kEnZfYIbYpgs
ZjiAw8e0UcwiHybxZ7HLPut8b8ABvORtXaZu5WRjpFRZNA7p6qqb1iQvxRidgLbJ
lDTRMwi0ZxUaGsHhVLUPSr1ZZmR+TFb+pBFJ8MQ57+XQWa267XFS0K6IG0vUNOe5
Gio/qO3K7Qm86VrwGFDCGun6xKNBCR7cAudvchIcKzqUGC22G4KVEN+/2Wdy1oWb
lFGELwj6
=L6Se
-----END PGP SIGNATURE-----

--=_MailMate_910AD749-E33F-4C17-9748-FDD9967C2DDC_=--

