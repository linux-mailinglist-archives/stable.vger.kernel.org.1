Return-Path: <stable+bounces-253906-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDs3FD5FEWpfjQYAu9opvQ
	(envelope-from <stable+bounces-253906-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 08:12:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 961645BD66A
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 08:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24DFF3014BF9
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 06:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99462D781B;
	Sat, 23 May 2026 06:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dyxwaWkK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="siNOIL/Y"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3CB1A6815
	for <stable@vger.kernel.org>; Sat, 23 May 2026 06:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779516730; cv=fail; b=QthyH+LQ6JvGUZHfn+Fw7cDW7xhjBpFrduObMN/u5ghrlQ6e3Fmemv+Y30WYU22/OfneCDDg8BuI4C1Oo9aZP6ShTlCHoI0AiVv8W0fNTD6h+uFoe+AKmM2nYyUxKcYY/tksgrLKxazaE7MIuezA7QFQkQtN7YfRELQwRp8Dwho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779516730; c=relaxed/simple;
	bh=Xt5re4zT8zhj5OV1ZzECwUHxnUe+UpN89DWEZOXcqNE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CjCOQ0hJQDAzRKv6qTkPdcjXhUCtUbZ6WIlBOBDz4+S4diPU90e9ZOVvh35RlM6mt8NZYQhZUovau+oB2+C78EbXQ7TnUnDxc2BwaAqxS2ssKrRqwmnvbNTz/GjhTfK/nV341gHuXrXMb43YawvPsuoOPED9sNm0pAKboeTaxYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dyxwaWkK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=siNOIL/Y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64N3YrhS1978250;
	Sat, 23 May 2026 06:11:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JisRSHkwRELvWo0HhoEugIfDDZ7d+0mr4l6qBUlTqPs=; b=
	dyxwaWkK32a8fKoDJ8wqwe4Q3eX2p9+372z5NWrquvlXMhifL4pkBmYOb9XNONNJ
	KqvA55d8LtFMJvFt0ZxwNCAOEO80XJnzmvPo3TwUlePUn0QVYyLWvEIE1xCmwOk3
	J7k/+Rff+oL5hXOq2IUeTuWUQkQq2DsXBRDZP+H0oCJ+U6tqIuu2TERIe2bwlivW
	56VH/wdAR0tWBSsx2kcy0mau3ZCa7FIqDDPl1S+3lmLMe/XrP4eW6dgI/Oavt5GP
	y/lcwVUoTN+YH7K84yARZ3Zlo+KQeEb5ra1l5JULm/eNhgJyer3Cq9LCXKjVit5z
	pHq7h0MT9Z48eywXII2Qxg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eb4ebr288-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 May 2026 06:11:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64N64i1h020953;
	Sat, 23 May 2026 06:11:41 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012063.outbound.protection.outlook.com [40.93.195.63])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4eb2p5mp7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 May 2026 06:11:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnKnop76pND6igjTTMp7SE+2H3ErskMz57sAvhSZgKLgMvGj0Cat4TvyNaD/tQSJl4TD8J+CN2KhZEGsRn6VC7CmIfDRyANdUZQTUadAUWSWCUmRkSmvh13poAT1k5osOMjfXxwteKgTiqDwUMgx4zynAitfLVti7vitKb8i8JfR1crxKp6Imjp7FOsw1DpZ7fKaGQpDDsoAj9t2yGr4OzgychZjwRT/ODydbG23nVfFXJYRrcigwxCJsAmetKzE1OFlgz8iMsBh7+VELNUWauYbwLZ6dMlHJkeTn/cbd40t5IeekZkwSLWgN4FFH5t6w/za3fDIsEOYRswuorxGxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JisRSHkwRELvWo0HhoEugIfDDZ7d+0mr4l6qBUlTqPs=;
 b=nKWyvb74wE66cYnl2RSENHckc+M184DGqura5qdXFB7rwlvYDJmaZPG/r6DW/h9vH2rffa9MAyfhf1Ms8Xsd854BK6qd8QpfkxteJYvorif6d7zn8wrtqw/0SdVlELYlS8bNOGcn6GWG0zHeequzNkUXLuuQm0ByH8goThCVGtNB0N/Tw1n0y3emHpiqRWJrJOoObgnWuGcoZsi2kMgaR7C3vW6wi+h5dnQOU9aIHNnJ+3slAkbc8wTQ8SArK4mmX1KLoHpw/xKa79M42LcvNTx5E3xc70DpOq4wIPkwgCwwm7Pp9q7ZpGCk0RETi01tPCs+bahEkLNPyppAQfwOzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JisRSHkwRELvWo0HhoEugIfDDZ7d+0mr4l6qBUlTqPs=;
 b=siNOIL/Yx3CsteQSaYpLyMYTMRgLNl/YRkXdp93XAHW91cGmiP7frOs5YzczYOIafS0qGneUQoIGA5s9Zcne5NyYposkJSEEBOVVw2+D8j0yW1oviZWesSuXrp9NF5Z9ybhc2s+X9blaHBxaoi5YjweeEEvYeD8Gee/0I+QThNo=
Received: from PH5PR10MB997710.namprd10.prod.outlook.com
 (2603:10b6:510:39d::10) by PH7PR10MB6081.namprd10.prod.outlook.com
 (2603:10b6:510:1fb::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sat, 23 May
 2026 06:11:35 +0000
Received: from PH5PR10MB997710.namprd10.prod.outlook.com
 ([fe80::2edc:9811:1c7a:5a8a]) by PH5PR10MB997710.namprd10.prod.outlook.com
 ([fe80::2edc:9811:1c7a:5a8a%4]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 06:11:35 +0000
Message-ID: <8b97fef3-c244-48c5-9039-573239d24d92@oracle.com>
Date: Sat, 23 May 2026 11:41:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
To: Ben Hutchings <benh@debian.org>, gregkh@linuxfoundation.org
Cc: imv4bel@gmail.com, aaron1esau@gmail.com, ben@decadent.org.uk,
        malin89@huawei.com, pabeni@redhat.com, rajat.gupta@oss.qualcomm.com,
        sd@queasysnail.net, sultan@kerneltoast.com, tanjingguo@huawei.com,
        stable@vger.kernel.org
References: <ahC4qNfoeifA-enJ@decadent.org.uk>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <ahC4qNfoeifA-enJ@decadent.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0363.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::19) To PH5PR10MB997710.namprd10.prod.outlook.com
 (2603:10b6:510:39d::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH5PR10MB997710:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 13dd1a87-b81a-4640-d2d4-08deb89224af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lEcVFc34pSdVyDZyyZePFwOtIQcTqHDu1B1Qyo9Gr9sqzTvNHQIGhfmiqrN9GM6gm67tIfdB1f0ukxAxdnyQ9Ch+3xVnj94taEpQIlTBnBN77Hc2wKQBaQlk7WgNKKdulgXwZOh/x6Lt7mzm2PZ64BC9Uaf7B19kFg9Fo5wtZaVYeymRuFxRWYsjnC7dhVYN2SaKtw6ZP00mLaKBwREj8XZrS7XomrRqTds7G9U2ZSXZid/XzW/EYNVDVEd7E1vjmiPzrbKz1s8Se2f1p4zr+X4IsMg18HIew+/JhG5VAR/9IIXUzkgMxhlqBDn/juGYyVHsJ1CbbdfIbfFAwoP6CQWsYZhdjD/pC6Qj0OiVAAV18YPLEEguHOxYrBeoUIGXxKMF23q6OgL7bPlLpw85WL/WKHxgEZIVe34ms7c6Fm8F5Ch1ng45pwh34wPJUBULOxJPbJK4JOzv9WjRSzseNFdfwd9KlMCW/9MFXwaAXhgWsUixjN0YdtbwMyOg+O53NrPEUUwWhp72tg9ftQH1IB7bP83n+zkujukkaPRBdUD81FstlM/KVlPu8Qb76f+yXmwR+RXZbNUelhx4O2qst+8PPlxEg4yx4qTOpmrBtaEb/09b2WPu8f7PBWScvByYs5nUV2dp3KwuCd7KwZ8kKA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH5PR10MB997710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1dZeVFsUExCT3l5dVZjSHVZT1hVNzJ1N1ZpYlovdVZQWWNSWmdscWpBaElt?=
 =?utf-8?B?Y29PLzd4ZjIreTRWRW0wdGdvM3ZVK3dXZmYxRHRkVVY2RTNqRDNEOWJxQWFY?=
 =?utf-8?B?QnpDbXpHeExIZlZxbWF6Tmt0T1ZRZFhERnRJVzlPZzF1aU0xYWlzZCtVTGtG?=
 =?utf-8?B?UGNoRlRCL1ZndVJhd3cyRUxMTzVleEI1cUlGSWp4Y2ozTlNxSEhIQVg0ZWdp?=
 =?utf-8?B?bTN1MncweGozM2xjdmFPUHhZWXJkOEpkQUN6dDJCWnYydC9JRkI0eGk5ZWVB?=
 =?utf-8?B?SU5VbXZKd25KaTNGOSt4NFV4bkxxcjJZTTl3MzErVGsyczJzV2RoQjRnZHNJ?=
 =?utf-8?B?SkREYjZvdDBzY3NpaXo0cUlaN0w5MmtOUVZZTGo5YkdWQml0eW1TcjVWcVBB?=
 =?utf-8?B?NFNpdVhDUklJSGkycG83NksxLzcvcjZuY0pJTzd0ZWRYdW5VTGprdGt6R3Bt?=
 =?utf-8?B?ZTRNVlNOcGIrSzhhVFQ3S29FWDFoUW9BTUcyL3U5Tkd2TFd6ZUkrbzBlUkty?=
 =?utf-8?B?TGFEZWNZRkRPUkxLQjQxM2pxTEIvTHhXT2FtM3NGM0RWOUZFN1pvdGowZGgv?=
 =?utf-8?B?VEloT29oTldDVDNRQ1FURHpqa3AyekhyUThPT01hVWcwVHBzUlp5eVRvYTZY?=
 =?utf-8?B?dnVyMVNGL25RQk5GZTFTUTd0M0wrV1dLdXByeEIzTTZCMytzUFgyd1c5alcw?=
 =?utf-8?B?MmhkZVF3dXV6MStqWmhZczFEdzNJRXJXQmNLY2ZQYzBLNTlHUTNPQlZUcnQr?=
 =?utf-8?B?UkxMREZTUDFlaEVmYzhLQys0TkZoYVZCSmpGN05FUVRxc2szejdYeVJ0NVIw?=
 =?utf-8?B?MDRrbzIxN28zZGNyZzlkUXFJR1NqSm5kQm9VTml0ZVJJMlBMRWlHMVJiOTZi?=
 =?utf-8?B?VVlaUXhrbkI1SXBEQTFHUFJIdldKUlJhYlBnbDRSbkg1N0kweGZRYmpLNE8r?=
 =?utf-8?B?NkdyemZSRzIxOGJhQ1kzZjd2aFNDM2JaQ0FoNEJpaTBzZ1djekpPSkpRWkJO?=
 =?utf-8?B?ajdxbVNpdSs5eTg3dmo4R0tHNCtJUXZoMWxPdEF4Q2dGandYRUtGcERZc08w?=
 =?utf-8?B?MnZ2QVBxRlhid0ZscjNOa1NzVmZVTmMvRHFtV2lGTjNaZlZ1NXZzalFtcUJo?=
 =?utf-8?B?azZmR1NnWkNSdUVrYTE0L1lkY3dYL0JzTFMzVFdYWDk3enNjNFpCQ0t1RUp1?=
 =?utf-8?B?RURVK1hxZHNRVzFYM0h3U2l4RGZ6Rytad3NNb1owNjJpTzJRSi9GSFcyR25W?=
 =?utf-8?B?U2xlcEQ1eGNWbHFyTFczcjB0Tk52NUVOMW81ZFhCK3J6VUVMVEpoSmM1WkdC?=
 =?utf-8?B?QkRHWDhCY0pSR3Q2NnJVbEVueWlFeXhxdFc3VzFOZ1RiU3IyYTBGb1gxZFl4?=
 =?utf-8?B?d2FCd3R3QjF0OGtCd2NEVmczWUZWcHBTL21RbTR3emVnOHp2SVRlTzYvTGZL?=
 =?utf-8?B?T2FMU0xPcitibzFwWmV1Ry9ydkRLdGdqS1dIOWpIUkJWaVdXVXNqTVdsQXBw?=
 =?utf-8?B?SnRpWUJYSGhzTEluSWR4SzBoNVROZnF2T09KZ2IyWjRiR2dKSUk3MmxGaTlE?=
 =?utf-8?B?VU5HK2syT0RaZmVtbGF5KzlvdTdvUXR6clVzWW9FVHZZMzFsaWZkUTFLZk1F?=
 =?utf-8?B?NkRYMWNuU1VvdFhyNURMOHRkTXM1Ujd6d0t3NEljZjNibDd2NDR1bEhzbytr?=
 =?utf-8?B?UlVTZGRsSGdRd3FiOE1rcW9QNXlpVWgxOUEydXRONy9nMXNDa2EwZVpLODhF?=
 =?utf-8?B?Mjh0WWhmS3pZT0x2bmttK3BJdlpIM0N3Wmd2dlJZNWV6WEQzT0tIcHZ5dVNw?=
 =?utf-8?B?d2srM3NCeFM0YnZ4UnAvdHhoVklDNE9MWElFYWpIcTc3RFBDZGZtNzRlT05j?=
 =?utf-8?B?STVCU2dXdC9ld2FHYWJCQnhVQVdhTERLS1hwdXlYYllHQ2wyTkNFcVhHY2JX?=
 =?utf-8?B?dU1QSzY1M3hJSWIyTzV0KzBzZmtQTE54OHZUWlUwUkhQQmFqWVdiQ2c0UTFk?=
 =?utf-8?B?d1NnQ3VvS2c2N05YNktiSjE2WFQ2U01vUEJQOTQyYjkyTUc2L2NvNG1DaTlB?=
 =?utf-8?B?LzRCVC9Mcis2Mmx6YVlOZVlxQ3VudnFseS9MYVpGcEdOVHZJbDU0eDRZQzJE?=
 =?utf-8?B?K0lLZ0xuNkpQSGNHVGk2S3ZZbUxrOWJnVzdvcUl1d25IZjBtbzdFME5oM2dv?=
 =?utf-8?B?MjZBTjl6U2EydUpMOXRiZXd5elF6Vk8vdFpRWWRxY3VmdXJQK0M4MDdBSmxt?=
 =?utf-8?B?LzhEZmM2YkhSd3BEUnlEUWoyTWQvdzRBMk8rWmN5WnRrMmc2U3RWMEQrLys4?=
 =?utf-8?B?ZmlvSXFOTEVJMlFLNDJhdlVybTd1V0FDdkRMays5cndZNSs4RWhHcjBUZW1E?=
 =?utf-8?Q?p6eW+KYNO1hPXgzSe5ErCgRdIj0/IDwntiNDo?=
X-Exchange-RoutingPolicyChecked:
	Jp7EcA+87u7kA/daozcTnk8jnY8p+QsikA1KX+uSegpcKDEHm9bps3/Aq6R6XogJiXy3X2udSVpJglKgIw7RA1AdnsdvNyycjwlKUQ9SQ+XbSwZJ/CzNErezoiwB5NfX3qqbNVKW8gEnYx8FoKZBnZdTVksI3xDQRx4ORBQ8I3Hs8ETvzMGXRwccd71Pse6b1L0wRwXDQ8Zclt6VdyUQrfwjCze7Vkn5ccTbUWhbzaTazCYtvMZ/eLAdyNC1a5mIK3P38EPjU0ux16K5o1f9uSIm5L5iABN1KKSJzb6GYJ41DvY3JifdPoJnCYgwlBhqVUWOcx2gVQO3AIy91IsIfA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WCnmba8diUQJVH4jNNdxsdgPonNkLA6P5sD4V6motsIB0eG99ZecQG6z/bKq6kLka75Zq7j0oN7ckTlRJcF6/N5ggEZ+H+7YmOopjvaTrU4PKoBVLFxl40JPGzEv0GUpWijYx3741vg3aPVgVMsZB/DbEKIICf6sLgRYSH/GYht9wwqByjRDK/fs3fezKXo5pCPAipHc67z5JIJ13pVgeFS+1Gl9q0vySyIhRU8li0F2zJH5IqAexn3xL/1QTWGsokdm2GMqvSIUki8kQosg3sOi9ncKxpffVdtUWEahz7MrYrUq2Hr2qug4XrcLEFnc/XICXbikVP33TF4pwdUluyHAdRhh8eGt9Nr5HNuK29omVcM4YHDisBJfPO9RzJTronHn9lR7e571Y8geBnt3138i8zPHolK1D0WVt2la2RWxqDt0/TKH9mz1X5rGhxbLoJdKvb+ZnQJW0gjHPSp3QFculC4t5oIvmHmujOg2F+sITVbF0Q0Cf1eFuhV06XcqjBN/n1DXP2NiGf9CSY4HT+uySgMNQKWiiqL/Bm+9xnO2dsKYBVp26Duwe1UUuaBqGeSH/Tn+Cx8tb5WJT6oGuY+S6AXzFhGvJ/KWYI7ekog=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13dd1a87-b81a-4640-d2d4-08deb89224af
X-MS-Exchange-CrossTenant-AuthSource: PH5PR10MB997710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 06:11:35.4544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LP0v684HkQVsXVMPUaE7q+OZfTcUyOdXNpDFZlRC1RW4X9sBzMe0QT4j6AdEImYWu7hksgfJZiXDIN0wQ4w3ELjzaYXnswWKTFGUcYiaxYc2cRyFPy+CJvfv7CS4gE36
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-23_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605230058
X-Proofpoint-ORIG-GUID: J6gOxT9JZq5XH9bNOm3AwS4zhZKq1qyh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDA1OCBTYWx0ZWRfX5YX1wJrlFGaj
 DsZPmiSQibChu/4txkRNiK1YGuQEzV1B6Oc+1u8Oy7wvwjAHSnI1QImfQYF2nof6ibHr185RR/7
 og5G13fJ+wnHzOQgVPJFbGq9S8Y7SYPiOrDTeQgDjGbh9uhDxqkIcNmSPz4yORKPunc/cC18OoX
 1YgkyGs2fAHgzF+UfHmfSBM0myfP6dXlCY/oOQscjgm623wkAeTBY06KV2r1A6h8kiVZFGQu8gn
 eUMww7XTcB9KRsoJj1QA8kT/egUwMui0R0BQkg/wJA1Zssej49GGjSPbyEyd/UV3Cmyqy7G5w9Y
 BrgPryGeJgHakgvCxrATJuLrAe4o2tEUp4AxO/LhqqeVKh9RQbLK2Ws6U9xfTzLDkvUgttfWDHS
 CDB7ARbCFRuQJKqQgoBrsJbI+dhaFeopH1Ns8ClZoazsqzq8hGTcNbmh0XfRN33Cvz4aiE6VSCx
 j07zHgsrujQ0vnsmILAcNToL4R5McQ+ovOXCeABs=
X-Authority-Analysis: v=2.4 cv=QJpYgALL c=1 sm=1 tr=0 ts=6a11451e b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=bC-a23v3AAAA:8
 a=pGLkceISAAAA:8 a=AeCkNC4mAAAA:8 a=Ia0HVi91AAAA:8 a=8T59DR07AAAA:8
 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=xNf9USuDAAAA:8 a=ONza0irlawQ2XfZdcIYA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=3H0rhiSm_XezoJcgKFaR:22 a=dzohbJX8CEHOwgtOZ_jj:22
 a=nH4QB3FtVBqZfhiODIJV:22 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13835
X-Proofpoint-GUID: J6gOxT9JZq5XH9bNOm3AwS4zhZKq1qyh
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-253906-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,decadent.org.uk,huawei.com,redhat.com,oss.qualcomm.com,queasysnail.net,kerneltoast.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 961645BD66A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ben,

On 23/05/26 01:42, Ben Hutchings wrote:
> From: Hyunwoo Kim <imv4bel@gmail.com>
> 
> commit 48f6a5356a33dd78e7144ae1faef95ffc990aae0 upstream.
> 
> Two frag-transfer helpers (__pskb_copy_fclone() and skb_shift()) fail
> to propagate the SKBFL_SHARED_FRAG bit in skb_shinfo()->flags when
> moving frags from source to destination.  __pskb_copy_fclone() defers
> the rest of the shinfo metadata to skb_copy_header() after copying
> frag descriptors, but that helper only carries over gso_{size,segs,
> type} and never touches skb_shinfo()->flags; skb_shift() moves frag
> descriptors directly and leaves flags untouched.  As a result, the
> destination skb keeps a reference to the same externally-owned or
> page-cache-backed pages while reporting skb_has_shared_frag() as
> false.
> 
> The mismatch is harmful in any in-place writer that uses
> skb_has_shared_frag() to decide whether shared pages must be detoured
> through skb_cow_data().  ESP input is one such writer (esp4.c,
> esp6.c), and a single nft 'dup to <local>' rule -- or any other
> nf_dup_ipv4() / xt_TEE caller -- is enough to land a pskb_copy()'d
> skb in esp_input() with the marker stripped, letting an unprivileged
> user write into the page cache of a root-owned read-only file via
> authencesn-ESN stray writes.
> 
> Set SKBFL_SHARED_FRAG on the destination whenever frag descriptors
> were actually moved from the source.  skb_copy() and skb_copy_expand()
> share skb_copy_header() too but linearize all paged data into freshly
> allocated head storage and emerge with nr_frags == 0, so
> skb_has_shared_frag() returns false on its own; they need no change.
> 
> The same omission exists in skb_gro_receive() and skb_gro_receive_list().
> The former moves the incoming skb's frag descriptors into the
> accumulator's last sub-skb via two paths (a direct frag-move loop and
> the head_frag + memcpy path); the latter chains the incoming skb whole
> onto p's frag_list.  Downstream skb_segment() reads only
> skb_shinfo(p)->flags, and skb_segment_list() reuses each sub-skb's
> shinfo as the nskb -- both p and lp must carry the marker.
> 
> The same omission also exists in tcp_clone_payload(), which builds an
> MTU probe skb by moving frag descriptors from skbs on sk_write_queue
> into a freshly allocated nskb.  The helper falls into the same family
> and warrants the same fix for consistency; no TCP TX-side in-place
> writer is currently known to reach a user page through this gap, but
> a future consumer depending on the marker would regress silently.
> 
> The same omission exists in skb_segment(): the per-iteration flag
> merge takes only head_skb's flag, and the inner switch that rebinds
> frag_skb to list_skb on head_skb-frags exhaustion does not fold the
> new frag_skb's flag into nskb.  Fold frag_skb's flag at both sites
> so segments drawing frags from frag_list members carry the marker.
> 
> Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")
> Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags")
> Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
> Suggested-by: Sultan Alsawaf <sultan@kerneltoast.com>
> Suggested-by: Ben Hutchings <ben@decadent.org.uk>
> Suggested-by: Lin Ma <malin89@huawei.com>
> Suggested-by: Jingguo Tan <tanjingguo@huawei.com>
> Suggested-by: Aaron Esau <aaron1esau@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> Tested-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> Link: https://patch.msgid.link/ageeJfJHwgzmKXbh@v4bel
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> [bwh: Backported to 5.10:
>   - Set the SKBTX_SHARED_FRAG flag in skb_shared_info::tx_flags,
>     instead of SKBFL_SHARED_FRAG in skb_shared_info::flags
>   - skb_gro_receive() and skb_gro_receive_list() are in skbuff.c here
>   - Drop change to tcp_clone_payload(), which does not exist here
>   - Adjust context in skb_shift()
> ]

LGTM from a backport point of view.

I have the exact same for all hunks: So:

Reviewed-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

> Signed-off-by: Ben Hutchings <benh@debian.org>
> ---
>   net/core/skbuff.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index c195107434b8..f7100f5af37c 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1596,6 +1596,7 @@ struct sk_buff *__pskb_copy_fclone(struct sk_buff *skb, int headroom,
>   			skb_frag_ref(skb, i);
>   		}
>   		skb_shinfo(n)->nr_frags = i;
> +		skb_shinfo(n)->tx_flags |= skb_shinfo(skb)->tx_flags & SKBTX_SHARED_FRAG;
>   	}
>   
>   	if (skb_has_frag_list(skb)) {
> @@ -3502,6 +3503,8 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
>   	tgt->ip_summed = CHECKSUM_PARTIAL;
>   	skb->ip_summed = CHECKSUM_PARTIAL;
>   
> +	skb_shinfo(tgt)->tx_flags |= skb_shinfo(skb)->tx_flags & SKBTX_SHARED_FRAG;
> +
>   	/* Yak, is it really working this way? Some helper please? */
>   	skb->len -= shiftlen;
>   	skb->data_len -= shiftlen;
> @@ -3843,6 +3846,8 @@ int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
>   	p->truesize += skb->truesize;
>   	p->len += skb->len;
>   
> +	skb_shinfo(p)->tx_flags |= skb_shinfo(skb)->tx_flags & SKBTX_SHARED_FRAG;
> +
>   	NAPI_GRO_CB(skb)->same_flow = 1;
>   
>   	return 0;
> @@ -4076,7 +4081,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>   		skb_copy_from_linear_data_offset(head_skb, offset,
>   						 skb_put(nskb, hsize), hsize);
>   
> -		skb_shinfo(nskb)->tx_flags |= skb_shinfo(head_skb)->tx_flags &
> +		skb_shinfo(nskb)->tx_flags |= (skb_shinfo(head_skb)->tx_flags |
> +					       skb_shinfo(frag_skb)->tx_flags) &
>   					      SKBTX_SHARED_FRAG;
>   
>   		if (skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
> @@ -4093,6 +4099,9 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>   				nfrags = skb_shinfo(list_skb)->nr_frags;
>   				frag = skb_shinfo(list_skb)->frags;
>   				frag_skb = list_skb;
> +
> +				skb_shinfo(nskb)->tx_flags |= skb_shinfo(frag_skb)->tx_flags & SKBTX_SHARED_FRAG;
> +
 >   				if (!skb_headlen(list_skb)) {>   					BUG_ON(!nfrags);
>   				} else {
> @@ -4309,10 +4318,12 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
>   	p->data_len += len;
>   	p->truesize += delta_truesize;
>   	p->len += len;
> +	skb_shinfo(p)->tx_flags |= skbinfo->tx_flags & SKBTX_SHARED_FRAG;
>   	if (lp != p) {
>   		lp->data_len += len;
>   		lp->truesize += delta_truesize;
>   		lp->len += len;
> +		skb_shinfo(lp)->tx_flags |= skbinfo->tx_flags & SKBTX_SHARED_FRAG;
>   	}
>   	NAPI_GRO_CB(skb)->same_flow = 1;
>   	return 0;


