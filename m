Return-Path: <stable+bounces-26814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F5E872454
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 17:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 017AAB2693C
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 16:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABA812D1E9;
	Tue,  5 Mar 2024 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TKROE2CZ"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DAE128374
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709656004; cv=fail; b=gUgyleBbVYLAW7lJbTsktRfZrB2kaYizZ66H4yX3npj6FKQgtVud7fILWAg7d5fIDSVwvEVPJqZ/cUulxcUEF8vWLlFBzdmvPJOYiL1ibLxqgO+73ebcKOz3D6IiU+y05wlXAeANaiYcZsNC5YkUbgS19CreR6q5SNcWEZ3I4Cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709656004; c=relaxed/simple;
	bh=nf33AbGb94KEg7CtB7wlN9UibsrzsNsepY/Y8LzmXdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qObVfHCTm9eKcBrDjOeTh0U9TjmfcbWp9z8INCOwn6fZj79s3ZZISny6socAWe+V1MEsv8DR643lj8KrHFezuB9LLvcelosepcxQrY5YJbudli6t90U+9FtKbRVZ3+4kChPkMc5qThb3v8CL9fxbqR8Ce/zWKzAPigE7+mzg+eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TKROE2CZ; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmZjl9YELCkBytup4bQec/y9Zb+2ChuuasBVycsDFGNP7S+pGqPoeIFViP7JHsxaWHkfzzZKTdQO5OX1aMSra9Gp2wxFxgHG+FufII52/VoR+TyEzjZRZN1Q+X5Q8v31VWizxINha1U1Ksr6nEK82fjn0MGeSBah2JRoySAq+/QTd50t5p3bZt3fgRVkvMh1pHjqFd+ZMXL5KEeGjPO1CXslNLQ5wpRSIBYPA1ouFLUgXsovjxQje68CWm5FfpwW1ZuGaHTflDbRHDYMhRGnVaGXlL2E6Yt7Ldg+aDbwPzZYAO24cWrf6I6BHKI2JBvy2qtDbCASK8qdC83bvbhXJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2raunQM8GbMBqVNikI0K/pJeh/wpu/uVybK63vdhyg=;
 b=e1oL4ScqRpD30/ndBo5xMYsMSXdp4qqQ7c0M+r0RGO/jD0i7HjJZPBctK0OVLNeHrxtAuchZf5xAbAVyh//q6UTU6sSL+JQy34tEgz7koYfvBsuPPJY+YTppFu+tKjPbAWzuU7GZs1qEJbQmSuRGA8HvdzPvSPK2ZEMJqojso8tb7zsTcxgaRAr5Jd0MDZqvupKb+5mYDP1GCjUVN2XPu3YmKEz5CkPQPM8zQ5quYDj1zoFnW2JyCpkq791AZhVVwCAEEjkhKDUQ3Za16CgIF37Ph4FUYh86Fraf2bXFPJsfY82oxcmQ5qVSjCjWDiOTkMSTC8HtxmuYyIXATy/DpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2raunQM8GbMBqVNikI0K/pJeh/wpu/uVybK63vdhyg=;
 b=TKROE2CZRLjaoLjktfxksKQsF1zjhGkY7HYRxfbFavvO0I04zQsdJBGy+xd7XQQrDw9I5u4ZMCpffUZ6/l882L+NEYYuMMslgjuPP5cXrU2MUrGAOX2cx+5MLQi64O4kEykaJa9U/9CXJLxXyTjYBjeBxVDhjqd6aYnk6Lui2ADSrzMpieIQlkD3Ff5RZJu0aD/5AuC8fUBw2ki6N6se7XZLTcZe+9sRUusWoEFFqaw0jQv1fgjM6J6hBuoX50JyGz4VTvmV+p4bxsfwr1N+DwcnlU8+UC76TmMKK7+u610XV4ZOJqhQv6Xkw43JmyNYGWLuT2BETtDYc/1b9L96NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SN7PR12MB7105.namprd12.prod.outlook.com (2603:10b6:806:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 16:26:25 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 16:26:25 +0000
From: Zi Yan <ziy@nvidia.com>
To: Charan Teja Kalla <quic_charante@quicinc.com>, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, linux-mm@kvack.org,
 "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Huang Ying <ying.huang@intel.com>,
 Naoya Horiguchi <naoya.horiguchi@linux.dev>
Subject: Re: [PATCH STABLE v6.1.y] mm/migrate: set swap entry values of THP
 tail pages properly.
Date: Tue, 05 Mar 2024 11:26:22 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <DD82D819-FCCE-4554-86BB-89C969441240@nvidia.com>
In-Reply-To: <ce7f78bd-68ef-952e-ae6e-8cb2429d04a1@quicinc.com>
References: <20240305161313.90954-1-zi.yan@sent.com>
 <F242A2B9-8791-4446-A35D-110A77919115@nvidia.com>
 <ce7f78bd-68ef-952e-ae6e-8cb2429d04a1@quicinc.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_18C66C75-4FE9-42AF-A23A-570079170B2A_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR20CA0002.namprd20.prod.outlook.com
 (2603:10b6:208:e8::15) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SN7PR12MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: ee4df47a-185f-4586-9776-08dc3d310074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gSkrCZhGadli6IQjNbp4ISXO4hWZBJBNT3WV2LOXQAkKxpR8gTlA9ZQa8WJqjndd+HkWZVIzK6wUYJAcPQOW9RLDWWMAsxDvC8QUpIqD32trS4NT58LaEgoSSiE4OrVyRWCLWxKPo1UfUQRVmkuO1r67QrNM9zL3m7yCMt/qP2tB+68lsBlyuXfG+fLnQiqjWKONKKFkqYY7rZthwRR+CDRS4wfDe5kN1KJ4lf2z4mSKQCOWlJEpzmG/hps+QmGd5/UTCEgJmns5dS90JmCXntp3VzhC99P2NlQ/rVUgfLjjD6+NdWDh2o6VP72jlp3hjjlfk4FKOqbYXkWn1HBEZiU/gXxDlokjaEKX23ZhomsrTrbepo9ZyqhI5KnGqdZeiDNu7+0TwHJXe0ulh9QHOoUAHyyuNesqbmkU/QsGlKK6GH0Z13zQgJEBvvjs/VivuI01QxeXkASxu0/AlICzk2p7UIlVJetoiNvbMvVBl4GKBbSG0qmQscRzlHXOEfwwMH6aBgKhLn+pNwGG/EFhMPomHV4p/pTBgoriDLNYdozalxkIreMsdSETXZqhatMGvHB1zX5nMWMzEZUnDcvV2wH8LgItacEpL8L/+sJ7mIYRo/UwQs9v2pXDyJpyt03YOaFOx9wfK7Ce/8j6SihmwvK6ogMkh2svhS498GuT+mk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0VDp9ZrnUBv9LbKtA83WHeeUao78znlDyA3MR4AKt2rXLahzMp8z1/tMmLp9?=
 =?us-ascii?Q?eTcRwIJm3KPoKshlpH/lrMQMeAi3fXiWDZo4OaXIIjGlJzBNnMOdmukBLQTX?=
 =?us-ascii?Q?C6yy0gijvlBYASDmJJF3DyE0F2cZwJOm2oaiheu5OiVrJbgvCperkpxV6wkR?=
 =?us-ascii?Q?I7APKBjm26oyeSldM5PagsvzlBHhg/Eszwn1RJ9IeZyo59Om7O90aUpNn1xj?=
 =?us-ascii?Q?RvnXH8PRl6V4vZscDgbYfiqVR2w2pMnUBLrkSvgFdqCkvJtYocQ2e8h7IoSK?=
 =?us-ascii?Q?L3LZJKbAO8OwQR/19MTeZUR3/s031VOTBh2Xh6Yv+m87YhGvxsopymphwd+Q?=
 =?us-ascii?Q?IxDtMC1ACFPQtJgX60TsP3VNp57Vet3Elqs+29sg4vLj0wElL+u69VkdwogY?=
 =?us-ascii?Q?rXRR/KhpIjz09RnHXS2Q9lkZ7eCyquoOQLhm3aEhJz+ZgEn58BgpfIPwhAPB?=
 =?us-ascii?Q?v26enlhwv3tNWce2s7F1kTCMhXPgovjVIt5D3Gd5VLKZok5idG5E4m7RX4kb?=
 =?us-ascii?Q?6vNfJJ/QRNct3vo/mjPyaDvxE4AW8rxTZ9vpBBl17BRb4X2SdTzzaPxlHqMt?=
 =?us-ascii?Q?hzPGht6ZslMf/z96Phq/2W/PPx8A7gj5q9RzKt65sUhMemt/L7lsmID0+F+r?=
 =?us-ascii?Q?E8Fa1R/SZrffS1K/0qSKp3CAXJItQMXbU6FkmiIlpCkvKgF1FPHfeYKtqUDU?=
 =?us-ascii?Q?v8dGIpSMD6lDKZBoTe3wwj70OqyfJdZwzLSK03+5fnwqa+Ib1CPxApRdCE0D?=
 =?us-ascii?Q?++ySSW2haJrT9E6UbHPpHXn+52uLGhrM5+pVzI4Am2Ni6zY/IPbggIdJkEBJ?=
 =?us-ascii?Q?pmk5NOwAZ00RwcPI7a0ej1tJoHtRlFzNN6J0Y0O8Sy6zlYiQeIrFUILHWwew?=
 =?us-ascii?Q?p5e1HuEgj3i6MmpsMMtLI5yskMDIvtZLBuCMkpEzQD0gyc+loBhHwMbRjJOd?=
 =?us-ascii?Q?bGdK9OK2ryJ8ZER3xCIfXNgyawAjCKoQcJB5BJDDJEFE1WWSfoQpMaQwgb0H?=
 =?us-ascii?Q?mqRk5al8gOpc63OkWZMblYW3mPoOdacEf/4vfimD25jM0nTr7ckOeJgCLvuO?=
 =?us-ascii?Q?Dzl8O+drGYlKd3kGWWEVg3qeaKbrg8NZwEQPHUg+cCidMavw6XDjYSrNg9G2?=
 =?us-ascii?Q?gSXTffg2lreCRnxAiazMz2vze+f1vBwWXr2PHp94keL/uCq/UlYj+8gE90nn?=
 =?us-ascii?Q?cVVxmmMWI27+dDXDIQPwjPbp3tD41DJTZ/dIZ8zNzPbV7N05yOeoUJsChTPJ?=
 =?us-ascii?Q?cU/ecIDJ8FOWfsN+MN29bNk47Cfy93/XAi/pTZStz8MnFtH7fm1bauR6fzb+?=
 =?us-ascii?Q?jPcwJyZMJZ5SFwq27BVxE6wxXEUdMwYn+GgPTPQIQSUHxeWo6YLpLqo9wkTO?=
 =?us-ascii?Q?O9a54biBSyiMJ+Tf6LLjwxaqFlYjaROT7KxQm1+Eucxv9MsuFlsKfMCEo5du?=
 =?us-ascii?Q?qMvIFosF9SUIc1B7LCUZgYyrBFIeqZiQyXPVeRWbt0DfHYHU/P3qnQ4yv4Q7?=
 =?us-ascii?Q?MpkE3ERxZkXdD5rs3rgrF80SGpeCgYNSDEsRmXTrNRLXxzPExy7MJf8Y4ufj?=
 =?us-ascii?Q?PJyyKR4qnigeptfeb7hCHLMDdtvYrellfmfdzNSR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4df47a-185f-4586-9776-08dc3d310074
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 16:26:25.3998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jV+ywf2Ws5W1hnhTU0QbDALhRwhpcwHhti9zec2E/WDCA6tj2sGeKkSK3o+B9CB/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7105

--=_MailMate_18C66C75-4FE9-42AF-A23A-570079170B2A_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 5 Mar 2024, at 11:22, Charan Teja Kalla wrote:

> Thanks David for various inputs on this patch!!.
>
> On 3/5/2024 9:47 PM, Zi Yan wrote:
>> On 5 Mar 2024, at 11:13, Zi Yan wrote:
>>
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> The tail pages in a THP can have swap entry information stored in the=
ir
>>> private field. When migrating to a new page, all tail pages of the ne=
w
>>> page need to update ->private to avoid future data corruption.
>>
>> Corresponding swapcache entries need to be updated as well.
>> e71769ae5260 ("mm: enable thp migration for shmem thp") fixed it alrea=
dy.
>>
>> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
>>
>
> Thanks Zi Yan, for posting this patch. I think below tag too applicable=
?
>
> Closes:
> https://lore.kernel.org/linux-mm/1707814102-22682-1-git-send-email-quic=
_charante@quicinc.com/

Right. Let me add it to other stable fixes I am going to send.


Hi Greg,

Could you add the information above (text, Fixes, and Closes) to this pat=
ch?
Or do you want me to resend?

Thanks.

>
>>
>>>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>>  mm/migrate.c | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index c93dd6a31c31..c5968021fde0 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -423,8 +423,12 @@ int folio_migrate_mapping(struct address_space *=
mapping,
>>>  	if (folio_test_swapbacked(folio)) {
>>>  		__folio_set_swapbacked(newfolio);
>>>  		if (folio_test_swapcache(folio)) {
>>> +			int i;
>>> +
>>>  			folio_set_swapcache(newfolio);
>>> -			newfolio->private =3D folio_get_private(folio);
>>> +			for (i =3D 0; i < nr; i++)
>>> +				set_page_private(folio_page(newfolio, i),
>>> +					page_private(folio_page(folio, i)));
>>>  		}
>>>  		entries =3D nr;
>>>  	} else {
>>> -- =

>>> 2.43.0
>>
>>
>> --
>> Best Regards,
>> Yan, Zi


--
Best Regards,
Yan, Zi

--=_MailMate_18C66C75-4FE9-42AF-A23A-570079170B2A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXnR68PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU7IsQAIBKPMVuo0vVMdeDfa2YYcJ+P4RAhR6BocdF
jjrwbWC5YhMnBDbQmFcKANlXW8YK3NQk5cjBauVM5zmVLibfia2jyZW6tc2K1/pJ
6YUaYNUhOI8n6k+hUTowLzAcu06zkdJ11wHVxF0NypjaUccY9/DVhMQflbMtzHLR
Q8QghHZkL3dpMBmgUlV1cL9+++v1gg4ONEjIsCz9et29/mHsZnTi0E+97BQswbJ2
9pSsnEtH7bawi43t2sxyfl7Tb1gyatZAXmSmptpFN4sF1lCuvmN+h36iM95wuIBr
WxE8HXelxcUCjOQJvMXUcbXnG45nsfVazrhW6JJpm+9q+4nF6gy/6PjgkgSOpoqB
xX4Zg48EfaS9uj8DhJ34BO3exD/JItPEHFPblz0/9vQYwdjd5TJb+AeIIZVYyVtn
a6bNxkE7aqjfqEB1E1PHT/UMxcFiuZ/Om82lSjrTJAqXuLrj+Bu+butvaayc5x06
9rhYkScs9A1HZZZmJe3kptQmsgfE8jkoGDYoVWB9x+nz7T3b1njx20TrFlgZPS4w
Muk9Y3dBDfbP1OdueackpqmQ56In6Hu/KaxZTeg5ZhKDP5/EWUipmQ0MgqOMxBvz
ydkd1PJSlwzKGmbG2U5JMMNBnD73se5V2NIGHZyhAP2mefKhNdSGoQ1AZMMXbNQ9
lGOWRWcs
=4nUj
-----END PGP SIGNATURE-----

--=_MailMate_18C66C75-4FE9-42AF-A23A-570079170B2A_=--

