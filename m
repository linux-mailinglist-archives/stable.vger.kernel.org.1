Return-Path: <stable+bounces-26888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33907872ADF
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 00:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5680D1C238A8
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 23:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C219612D216;
	Tue,  5 Mar 2024 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aIpKhSV1"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B3512D218
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 23:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709680426; cv=fail; b=POJxMLHTraTx3rrUkWpD6QpKOpctI+OgjavaAVbF7l6qU1ibOuzWYFquwxiAm+y7c7BTRIoB+E60fAEeAdfSoDPzLud0AkwcopkKpYktIYxHWgz1q+RspJimFqBBbXgigsv9OeYVObPXh1EJqbAGM62WdYBKIAEaSEGiXnvxC6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709680426; c=relaxed/simple;
	bh=KNlSZyHGhScWJoKbUkftXihr4eSWhkyqHCj0Uhm17zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KgKEfG4E1uzp41cw586Ut5tyzvGtT0rPTAYPdg7kBwCWrrmfauQumZmyMMy1QzV1eMaOZK4+P2ItMcnpWgWN7uL44eweQP0I9Y3MYKeREpX9w49bQTvi6+j3zCpxxTCROf6aNSCkAp/iUi9GiPaGyAPic8LQVr/waM42v/BrWsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aIpKhSV1; arc=fail smtp.client-ip=40.107.212.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e38KODjH7OXVTIzNA1DvUeUlHebhf6sn7OprNdomTrsAMhPefDYjugctCucIwxQRAdPgq6Klw2tu/BstKPlkSGFx9PT4la9SDKtlqcrUd8GGsmudTx7JRi3vvDaSkVrr0fe8mVBCkeGkamXSJo4dJ0wYrT6CzqXvor2JT8sRQAT5Tst8UxWgVzyTU6mRQ4KGOqTYDCMX0fBRLesFjbPSGsNC7NRIou2FlF5PKqvJ06UvpIOPdpYjL9L5dCgd5+Owt/oqCOMjA7DokPzlOAN6NclpuCuvuUpTk6rDYSlGgN/XIgo9gvtVqpvc6TnIPTaae/CcYQ/Ia8d2yVK5Y1TF+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxVAosUKv8aiTm2iJyD8i07o/Bz18ildQ/XM3OGmtMQ=;
 b=eI7hthqQgjvCmRgaq9yN4L6avkVhoP6uzeyvNPS0uI+VWogYI0b594zxx4PiG6TQGtWSv2LALNFd930Aez5vL3ZWRJezAQc2SJrLZI2sjeP0lnpCWC8j16L0QbQTHhQuNcu1DEiO+AhXM/IVP31IPzmQHm5MNmuRN4wNIgB8rD/BzjMqZ2LzV2I/fAlKUiocR5VnpxS3m6YTTl2GxkUqPxI7ATyFw3qfwUXJVnSEpeFgIj+LfKPv4IUd44sFzpmd8f6HqgX1TRlpywF8MeBf57HaSm0Ym5Om6tyVpEdNW/mLFM5h7sV+I1gVvzZbrZqNkStUU/mAIJeJRJ3jP7g7fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxVAosUKv8aiTm2iJyD8i07o/Bz18ildQ/XM3OGmtMQ=;
 b=aIpKhSV1kjdnjoAU+qLp+vnt2bO9UXrrwhdhLJtaAA1t22BGgnj6WcQJBSh5Fnyv6ZaSD5OKeLZjOXOtBmwp8mihyt//J0L/jXm2n6vqVujIa5gGZ4eqBqreynHtAcluPVVeCLzYTiATfK4i8pX3FxmwiEjafeG6xFrHofm0Uk19R4JoBKy1P0vKrHwLnYBQn5eMzXUBeWFbhUvq6ccQ7pPKJCZ09AgYyF41vp8ruHKrh2jn1T5iVPT8SyXBPokw8E0/LY+J/bwRMvu/ufrfCIzb264qRIMmz3IadqpJRz3zUFq6wS+2H3/rUKYLL/uBfJcJGK5IWw3mHub0BZJV8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DS0PR12MB8528.namprd12.prod.outlook.com (2603:10b6:8:160::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.39; Tue, 5 Mar 2024 23:13:42 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 23:13:41 +0000
From: Zi Yan <ziy@nvidia.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: David Hildenbrand <david@redhat.com>, stable@vger.kernel.org,
 linux-mm@kvack.org, Charan Teja Kalla <quic_charante@quicinc.com>,
 "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Huang Ying <ying.huang@intel.com>,
 Naoya Horiguchi <naoya.horiguchi@linux.dev>
Subject: Re: [PATCH STABLE v6.1.y] mm/migrate: set swap entry values of THP
 tail pages properly.
Date: Tue, 05 Mar 2024 18:13:39 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <075777FD-8EA9-446F-A52C-96AF43170EA7@nvidia.com>
In-Reply-To: <2024030527-footrest-cathedral-5e15@gregkh>
References: <20240305161313.90954-1-zi.yan@sent.com>
 <2024030506-quotable-kerosene-6820@gregkh>
 <0910e8f0-5490-4d08-ac64-da4077a1e703@redhat.com>
 <2024030527-footrest-cathedral-5e15@gregkh>
Content-Type: multipart/signed;
 boundary="=_MailMate_7C973ED4-C073-4F2F-83FA-29F94B2437F9_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:208:32b::11) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DS0PR12MB8528:EE_
X-MS-Office365-Filtering-Correlation-Id: 281e259c-3f48-4e7d-4efe-08dc3d69e5e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y1JABVTH/sT6t/heg2XBexQPAirugympvVv5RYi3COxd0VhgQStRhcbWYPVQ8/wKr04qO5RxzF0sLEk9DsR8wtmku9gU2w+xV0k8ujVNdBQFnDBQ8lnpxMnGCSNTZlI9fnIIrYxbsLXaVu67UcjX3qXD/AipmOlB3fRqRX/jISIa/msY8Na5qU6cLddJV2SuM92V2I9rG5f/MnWLs9KZKzsQrGZgVeR1BSlPfhLHq0m9P1ihA4yj1l0RjyJfYUDegiD6MG+yZgQibKRVaA/fiszbuW69hig8laEe1wByHZIOFK5H0gaf1h8bET/cbBQXOzil/Ab/2vN5E0CY2yIaY6mMkccQY1Ij56ajMcdKBQKEfZtFSQL2dP5HVnlNzADZxOjS5ggBHUucPaz85Gj9KsmskO+Mr9aBHwFm9mOQx9dL/IC0adSeB+IHEgFDbA5Nzvg+Poltiz/RiTi8jiOlNhowOt1OptMMUDwmCp/kUight+A7iLdskx6vgkZbjopLhbk6+GUuJUop7gV3bR5ewZmNy0TAlO3o1gmGT62pjSkjNJbB7AHk1Z9WhLNMr/JvmcG/jyfYuXGEXDWN5ATvYPOOIO/YsvhT1o+VIwEnCufkQDOzDI+IM919eQ5m3LWTvZ/ou/vizmnx2ivTt6adFPT/cKKH4qSAf72qDhrpZ3E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ouPuj0OxZaVWsbs0At0PiVMLQ5EumxTcRpa2FB6Ah2HgKDRkmY36un8aMZch?=
 =?us-ascii?Q?2L3qQA0buExmWU4fxN7d6cgf750EMNKWip9qxkGYxNoJS1+wau7QNfoXLOV9?=
 =?us-ascii?Q?+6c2GZujICsMqgEOOvd1j+NFsut5lg8nx0muJDklMSTHB9qZiVRntYVe5Sgf?=
 =?us-ascii?Q?6kTjDPIEw8Cs1GES2kP1Dsmq21LEro7K9ajOcwzD3c1ZPxo9InKl3gfXwbTu?=
 =?us-ascii?Q?lk8Ccr5V+iRavZ6crLyKC3TGGyq1lXKXAcAfHhziyg2AwilbnBipdQGYVLZs?=
 =?us-ascii?Q?BeA6HKRXZOW+scMF/GdqhJ1U5PYvRZ9fmYL9MZoz41H3f/OB1vysWr/yTSam?=
 =?us-ascii?Q?HDVViflqhMTCDeswUQdBouEWTftX/dzkNBOQUeo76X+j5d+j/vaWF1bNQTDY?=
 =?us-ascii?Q?aQGed7EvNW9ikt9SbGDkLxCCZSEhAM2BZg04bhTlflQwvEdlBpm4FbwJ8QMJ?=
 =?us-ascii?Q?RVKt42rIkWRxaH7xWgLwS3djZ2p8GVWfUeFwZUGLEjJ9Wlmxi4/N1MUI9j0Q?=
 =?us-ascii?Q?AK4E+JuueyXQIAOimYsgBWFs4bi7cp+KClX/njcizeme5Wquxm5d0Z4/OCO7?=
 =?us-ascii?Q?GqgSOPfLbxTJxSdEzOV+rAdwOcNQflG3Xt+Xj1l2E8Qb3fSr3T2sw/Wf+fF8?=
 =?us-ascii?Q?GmF1wxL/ASBP8tfN3X2MoiOGckyo8njcLDarreF759Pa9ijFkpyT3VnWeXD5?=
 =?us-ascii?Q?pHAtcSZSD6f9Njumy6FTtpB9Ijl81EyTHFLwidvXYqddsIJ19EyQ8IYd95ty?=
 =?us-ascii?Q?QOMLHKF3tzhBer9gyLFPNloLjVvTMPTBAnL0Up2VZVwQ1N3Gwnj/Is318lPV?=
 =?us-ascii?Q?qoQZNnZvQPodIHCCo5KhgivExbqTJRefP+REsxZrHnlW/zDcPFPU48VGCYux?=
 =?us-ascii?Q?RW3QaaRHve1iGmeZGhUKbmV3ydMZIse3+js95+EyIVk6hnO2J60a4W8v0O6z?=
 =?us-ascii?Q?3dgGkY4V2LVgabkTSzHb+/cyoZHWInxHKzpYduccTsaQk5DgYhO8v/FomLuS?=
 =?us-ascii?Q?V+3Vud8H7ONUPM2mmPav/cZDu2jqTb36QimSUxAzCqKU4/EMq2KtM4anbAlx?=
 =?us-ascii?Q?omVZU08dtdFW1oxTmqZwIq1qIUgJNI2xDSqmSnZDm1Uz3Qn9yszwJq8I4F89?=
 =?us-ascii?Q?2hrOpifCH0J499LM+P9YwQtbPFMrHS90dykQLEDfHLpKf8c5+aAa4RSGT1aA?=
 =?us-ascii?Q?B+lcJS/FPhgenrz6YmcimCwTY4h9wSyCQlzGSzZDbOYy0LEq+Aaw6+dQADwL?=
 =?us-ascii?Q?1zO4512xouM0+xipOk19OxXf8Ywu+afZQrPVbUBzaI9Ewi+gCn1tUgvFQ7b0?=
 =?us-ascii?Q?YBHvZqWV2/Gci7lRUPXzi27smx7hcHbHmozPzJzFQzcxL3UkcjhcUeu6vC+P?=
 =?us-ascii?Q?zUwnJ80HT7CqtRHEc/ZK5dVduzg31qDbDSrj5oOAtA+9U/JguS+TxBVdLp0D?=
 =?us-ascii?Q?I1ezvHTTKozjg8BXRu+iANaBWv1BL/FwZc8V/qvNVebO4FftgP2Sva6ypQDP?=
 =?us-ascii?Q?Lp3JFKLKCa/wGCM2U/0W94KKOvZCyHX5HmnOkY0pNZs+xofnf5z1UTjkuzIM?=
 =?us-ascii?Q?aP15PEL9Nt9MxZX6Two=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281e259c-3f48-4e7d-4efe-08dc3d69e5e2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 23:13:41.8529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFJCqsm273tRKS8Sz6P/GPwumGeT6UjMA94mFcu8HQIrAkpIBQCXeC03RzltTKmi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8528

--=_MailMate_7C973ED4-C073-4F2F-83FA-29F94B2437F9_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 5 Mar 2024, at 17:32, Greg KH wrote:

> On Tue, Mar 05, 2024 at 11:09:17PM +0100, David Hildenbrand wrote:
>> On 05.03.24 23:04, Greg KH wrote:
>>> On Tue, Mar 05, 2024 at 11:13:13AM -0500, Zi Yan wrote:
>>>> From: Zi Yan <ziy@nvidia.com>
>>>>
>>>> The tail pages in a THP can have swap entry information stored in th=
eir
>>>> private field. When migrating to a new page, all tail pages of the n=
ew
>>>> page need to update ->private to avoid future data corruption.
>>>>
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> ---
>>>>   mm/migrate.c | 6 +++++-
>>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> What is the git commit id of this change in Linus's tree?
>>
>> Unfortunately, we had to do stable-only versions, because the backport=

>> of the "accidental" fix that removes the per-subpage "private" informa=
tion
>> would be non-trivial, especially for pre-folio-converison times.
>>
>> The accidental fix is
>>
>> 07e09c483cbef2a252f75d95670755a0607288f5
>
> None of that is obvious at all here, we need loads of documentation in
> the changelog text that says all of that please.

How about?

Before 07e09c483cbe ("mm/huge_memory: work on folio->swap instead of
page->private when splitting folio"), when a THP is added into swapcache,=

each of its subpages has its own swapcache entry and need ->private point=
ing
to the right swapcache entry. THP added to swapcache function is added in=

38d8b4e6bdc87 ("mm, THP, swap: delay splitting THP during swap out").
When THP migration was added in 616b8371539a6 ("mm: thp: enable thp migra=
tion in generic path"), it did not take care of swapcached THP's subpages=
,
neither updated subpage's ->private nor replaced subpage pointer in
the swapcache. Later, e71769ae5260 ("mm: enable thp migration for shmem t=
hp")
fixed swapcache update part. Now this patch fixes the subpage ->private
update part.



--
Best Regards,
Yan, Zi

--=_MailMate_7C973ED4-C073-4F2F-83FA-29F94B2437F9_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXnpyMPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUdm8P/A0z/78hCFA91SM6qlZCTy79XIaD2p2Apip7
Y0wrlXo7HgZN85S1qzmLKJsOP894wHGkSt0tkeZvqiw4ufnCRqlj2Ir3SztjGAKH
ocvrc199up4Guk/WHsa3UV/JyswxKL+fCYxSrBjbaceF3RSgaPo8mb6jc1tCw/2u
b41HbMwi4HnjcgFoG5ZlahKxqFsCRzLhKh1gimKaO/tY06JgRFGS9thGzNIP5UG0
lA3OSvyXLDN7fa/B3yIJTJ7K1ZTi1O/DrKnjSOa01Mn50svDoYqv22i+uN9ptcPm
sKrgi/FvJDikGiusLqLsJJUtEcerUwdvLJxJQ8a9AnClk6gGySFxpqczLRtuh5DE
hyHiaFvmV0vZfAW8CVYsbxnbvw/pbrxhomDIXO+hlfKqwsdua0OuRI6pyxfstRbN
bD4A+rmPT1392tc1zhb94ow9nCbl8diXS3RcPzRYvjoauXZiUTF6F5kq/Y+vxW11
/gQ+agixi3/Od0x5qzd2VpJ2QPTgfK0X2yPXFzHbV7Fidno1eAT4QWMuOt4bRCr3
Jt7WD5ulYSfvKx9fkJs1vo1acWTsWNP8N76n5zWRLVCBMxH6vo4fDx4+el6W3gfj
xlahcyX+3VVkhf1KAR063omx92GGhosXnkm04N3OoUVe1QqeBpAuxco1QJ7SCIky
dudu1hBU
=XdDh
-----END PGP SIGNATURE-----

--=_MailMate_7C973ED4-C073-4F2F-83FA-29F94B2437F9_=--

