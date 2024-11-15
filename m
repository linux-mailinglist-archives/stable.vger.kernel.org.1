Return-Path: <stable+bounces-93598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6964C9CF588
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 21:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 607DAB2E3CF
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 20:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33991E1049;
	Fri, 15 Nov 2024 20:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lQ1UD8kY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o/229gys"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A519A524C;
	Fri, 15 Nov 2024 20:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701394; cv=fail; b=Ni5aTP4e5WBFHdHoI9mlOMq//2fm4NSC6jPsv466YZYLysuLSoaElIW+GfAf0EHsmAOjkryj+oMInaZWldpJ4xUeJ7PSFDFIooZKcuVmoHeHtXDiGTPKkq+fGFjmVczLlGRmONUPEAsZZR4pfAsizw5qX7JsN1I3Mn2frf0z1Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701394; c=relaxed/simple;
	bh=wM09WruMU6c//2oUyh19M8rHDhERIJgXQBDvPwWAQpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ab3bBGqVTFJ1z8TQ02shHrLELzFjJsDWXBPzzAse4DGmi6HFmRI+MfurtG3x19rGBUcsq/IYSrthJIqpWNtjDHtyGv/v810v4GzxHyCrc3kU/+CfL0LKYq9bFeq11qSrMMzKYlHaCjM5MIkAXTxwYPD+3TCeg6DlxMca0vrttJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lQ1UD8kY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o/229gys; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFGMcJb024044;
	Fri, 15 Nov 2024 20:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=S/XMldrdObuXOeHm1h
	bj3oY2CcielA0JoitDDLJ/Kcg=; b=lQ1UD8kYcZtUtHnuzvvaJjjv/1zbwF1G5U
	3k+0E8/SW8ztNJLtTQ2TvCBXyq2x0L23wFTFczegSAoYxfOxW1zEswVyF8Hp95Wi
	WHBfv9tQzcpX+UBAiopfBmwhmkegEZpl1Mbdcms2vQ7EE6gg5itPoNpxIu17A6yX
	+l+k2KCvl4PzbiHY/aCKyjK8bqPbYQjpXOf19DytSyK42Ac1q/DjiSbmWr6U/oOl
	QiwUQqoIwjlePk9o3CzMEyen07Z8FMGIvdDU+ch8JExWqRXSMpWUEaShRn4EejHL
	JMP/4qI3MqFRZWtVD3RVMZBsEhD8NjPXCuKlCTgjtq9gtIF1orQA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbm7xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 20:09:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFJolC3005774;
	Fri, 15 Nov 2024 20:09:19 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6d45x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 20:09:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTefIfDQ7XafgAm/HTiPxj+A0yLfsRA/W3fBPayxsrHljT8NJ8MqyiWrNIu+GNPMw7FdAzUDHhGfh7q9pvDq1gFxlfpG0Z65B/zyJGueAbXlmEAyLDTlDuYS1Re8QntfmF22RPm/Z2n6vwpICORjG7+0AnNozLyNkUOgbJO24ovF/sGT8eKzqVDLjc9y0auBgvwonMZHkFzp+dpNwDqmub0jfzZhdu7WJkURs0PM5Rc7IX8yOSA/7FSQipkmNZb1afA4vXuHr8jUFdQjLmkftJGZHvgiZVgde64H6gR+TntzCsvtrsdZeZMoe2cGy18/tL+eo+VStE+Bs5orTcsN9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/XMldrdObuXOeHm1hbj3oY2CcielA0JoitDDLJ/Kcg=;
 b=ekl2aPgHMLKrQtzn2i7xKQrTykhEYJtVELdpYi8F1stUJXLm23VdKxRyfh9zFHmc8mrebsyRVHeneJYZtWrsNC4NKrVtZXmnMKQc6sD68/yHqIxYmBr25lDdt95zDEetU42qaU/fNewdomHJdyqSS4k3mV3yek30bk3VPJcEQ6II6iIfFYCFe0t7nY1liIUQU9rsMhek3gGqjCQFmjRZUcGfxOLgDo/HR+TGZsT7xcAaJ8niUH/IMfUdZzYia4H2+15nFXUZfBbLsT0JH0mImkc4YE1FpNaKDkbLCaOgsKg4R/kH6Ab+5UvAWcjHpNv5uPxsVkz8ISgPfiGtDe5GUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/XMldrdObuXOeHm1hbj3oY2CcielA0JoitDDLJ/Kcg=;
 b=o/229gys38d22R483W1MZPmzqduTrsBqUR3P9VRVAvsVkdZCRChfJZ3xyfIM7UoE+maZqCbi7z3YoIjVpmu5mhcfgY4Ngv5p88Vr4SBayXKFc4t2lypNFCeSHUDjstuVNctK6V9bKe3Abg2LxDnBcdDUjonNfCQEjYQJ0FSrunk=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by BN0PR10MB4997.namprd10.prod.outlook.com (2603:10b6:408:12b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 20:09:16 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 20:09:16 +0000
Date: Fri, 15 Nov 2024 15:09:12 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 6.6.y 0/5] fix error handling in mmap_region() and
 refactor (hotfixes)
Message-ID: <2pavx2g7lzhghwifltcozgsealhdvrx6hnhtxkda35t4mu2ufb@g3pwu2c57gxu>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, stable@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>
References: <cover.1731672733.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731672733.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0288.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::16) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|BN0PR10MB4997:EE_
X-MS-Office365-Filtering-Correlation-Id: 61127651-86d1-49d7-6777-08dd05b1619e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BQ+bhZJ+drycHjq+7FuY6pSu2t1U7dH7LiDrbRTWTvY5QB6zFvuA7Jqyi4D7?=
 =?us-ascii?Q?ZRwfuso6uM0kGwYy58jMMNmpcggz9S+R/EZEm7Ock45JVPP4kS9+8kQAw70f?=
 =?us-ascii?Q?Q/XXHqFfUHXLzerPufboyIT6w6rbVFBgx4LH0ACnFU0j6lLSMFae2ciq1BGn?=
 =?us-ascii?Q?c4ujE5g9eY7peEziXhfePMJ/dnn4lcuvY8KgkpJ5uu9YFNG3tfBNmVYvmrBc?=
 =?us-ascii?Q?hb8zh28t7Ar4O0mPrY1nbEIgTbQtW2hmVouaU19XcHRcq7vpLtXF136H8XE0?=
 =?us-ascii?Q?uUpuKouSahq/WY/pfWGr9601QkrRNV0XCmUQ7z9eIw4+v71L596cX5SqiIXP?=
 =?us-ascii?Q?bsRPDsZDTz7htimh0hrwt+0hw54qrDJ+zLHMuYnS7XYcsMM86UtpUZXG9Mhd?=
 =?us-ascii?Q?PN9kVFsndCR3xHKisWKn6IUJtYB/d86Owc99syGmELgbz2IvBLVURkivtKqf?=
 =?us-ascii?Q?G6haJ+NV4RWwRza1UHRS57Rrgfs79KlKe7L12aNS1OTQpYn9LYdf5ticjHAc?=
 =?us-ascii?Q?VeIWE6E8NVL/QNQ9c8AlDjo1LBvSfBoai9RqXP9j0+BMDiNPCCwhLo7HzV+Q?=
 =?us-ascii?Q?w9kiu9KnWADTR+Oa2wRiJjiDLSSV6rSQOzxQDHB3SmGLV1UiCTUie6KXYrY2?=
 =?us-ascii?Q?OmgpHINyosy2qMJum1vPfH6/9JXlNeQy0oAUaI2FT1PzkT4/7bq3JOf620HW?=
 =?us-ascii?Q?ptOKEl0WBiRJlC8AfrhSyUQwhkbQ58ZnvNdRooIAKBe7yPnzEIuhstv4nmSz?=
 =?us-ascii?Q?CGBPRkQu3Gt1WCgoPKf0Y6+Pqxz7iylbHYTiiJ3xTQYqLMNP11ktRxdLQBnS?=
 =?us-ascii?Q?3UQued+PRiF80rFlTj1CRMJkHv62pPszqnHzOZoicyn/V3va0a5pPIeJ1tY8?=
 =?us-ascii?Q?ZG8HzRIpjGqLB2a7/SqLkj60GUvtlp415wrv35voUxwWzjrvyOJC54QwiR9b?=
 =?us-ascii?Q?UymkNK72RWCYQML2cjTFkpzLpcGH/30/8VlXE9K3YHFaz9LrFjiIDevDhZRd?=
 =?us-ascii?Q?P1dznA8MbSKDCHMeB2hCK0ZGHAqM7sA069T/MO2dktgbpNReer/e/rb81ihy?=
 =?us-ascii?Q?wAkQ4RbwCQ4ne8++l0ZMY9tc180K9KIu/xpEIAzvDGe0hJhGyEOTBcVI1I0M?=
 =?us-ascii?Q?Kd9FEZK9JOlUXwX9ni+DTiSKKh6Hrm7UEQhV14tDtrSYbXcQpdMeAsD5pSKx?=
 =?us-ascii?Q?k36FQJuSWMT81x/MN3q254tuNqgp9L7GhbKpsUWTzERFjnaHFIoL1Co/sHGx?=
 =?us-ascii?Q?N1+I6yzVgV8HFAyVVrTIhOGk79etCDoJZTS+RlTA0acEKu7ipKwgn8USX6vY?=
 =?us-ascii?Q?DvZmYBb0G2nBfXKkqQIn45II?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?39oMXNi2i/UDjUbHz3O0qZ1ZSyzshB6rnLLl7BULD44F9G2Gcci9rRkIFDu7?=
 =?us-ascii?Q?QEevoA737eXwW1QqG+cgFJQoSr4qRIoR/8FGFIW16pz1hwlLk9jEKBDUxBYy?=
 =?us-ascii?Q?yk6SD1ZFPYOhVaI0lLnETxVSLN1hUikZb6YBSl+o2BNwNBNtaBGm3vS65OLi?=
 =?us-ascii?Q?8FCz7U8jtEj3eD43PRL+Pq2eF2It0apGMZANupvBmaJRAoxp/Qw0FzXc5Jxi?=
 =?us-ascii?Q?0T+p9gE4AKSl1A31AymYQQBc3gms6jnt1pGOqZxU2sxTZBtpq2dWDJT8ATso?=
 =?us-ascii?Q?94OG4OZCgBhPB5Rrcpfvr1kLRMdWgCAsGmSgl/dLVVAf2N+yun3ep3EqsjlD?=
 =?us-ascii?Q?7fxOwFlN3ciqWtOh36pkGRodPoh3zrtorXtInOdQYsUfSWbgVEXJc5gfN+9H?=
 =?us-ascii?Q?Am/KTiEtRRcyOV5v92aA600aTTihAq/3ALuC/aJdv+QmM/niHGwcH+QX6jO5?=
 =?us-ascii?Q?f4ChI/wLPmBK8x6416ei9PpN8VHg8HLQfSNw/SeEv6Mn900JO8FMqiXTOsHx?=
 =?us-ascii?Q?RhJfKVutoc+M5/AYdDG7k+sP0YpLCdXikw5Rqs1d8+BPs/onjOz7sDZjXAVD?=
 =?us-ascii?Q?sv9Eqpi2ACOeCEZj25J2WSD5fW4PUAtGJOEs4vu1Y4r+yrDQTvRpzLzcK22D?=
 =?us-ascii?Q?BfIREUNFJlygFAqaPgArW9P1BTZUpUY4YOl2+Niq6NIG6n7S4b0Fmi8gKbHw?=
 =?us-ascii?Q?EjkXZnUa1gugK9RlElTsFPjXbVOw+Dkh3HFvFBMfiCOmqyXtTbKU9n4/WTZj?=
 =?us-ascii?Q?Zd4Nz1mGzkx5s9WfWxbSrCX69yqbB0pUvEWyJEYhawEz7Sa1engPikGvs23y?=
 =?us-ascii?Q?KIGNsLG70YybUDu1aQOctISPl1ozadzWpM+QlLi1p39zAo6HgMxt539kIIgZ?=
 =?us-ascii?Q?uuD5VlHfdOYVmuaIfoWVfWZ7yLJp94p16MVMMVq6JiPH3AkiP+n3BfoskNDH?=
 =?us-ascii?Q?Fc4m6+IcxLlSVGEoLq0JUvsB5jTwuQM+F0nhI6blweSMGoFa8t5wiMegLeaW?=
 =?us-ascii?Q?LBFGkFkQLBClx09FkrySKNBqK+JMxK237CdxW7OXhp0zRKwrTZgVVR8QEB6Y?=
 =?us-ascii?Q?Gxa54rNW+Y4Nl6NvS+FVXljs8MnpYjHfKjfBDmuf7uqJ9KqqL2xKO4Z+Zm1Y?=
 =?us-ascii?Q?Gov1YtQYYPjJCJoqRpORaWtVZ2JZSjTiGOZLMhCw4mEWHB6BNnktrkdoXH4/?=
 =?us-ascii?Q?l6nStF4iBze/kUDFNEQtQ9RaPD9B7OU0WbtbDQSItsZioRs6BJa8ZZBECqLM?=
 =?us-ascii?Q?CFm8PAx90JaIecllr3qnvf/lFelIeqNrvEBUHrbJ7qy2UD6dwMnE44ofNg2n?=
 =?us-ascii?Q?pMsjf3T9AS7G6vE7BvfjvqO/LvFulejFQrbhk8x4Dy8E2p73keDFi+GhZB+3?=
 =?us-ascii?Q?4uORqbVMYs5OY01WNiPkkEZ9wuzw9GaGfZ9zWIiL1vL8K3711039gW5Wvy+m?=
 =?us-ascii?Q?l9YTUyGy+TvXIrNB2eYakqkAF1oFw3ANxYKj7+nKDHTJwrZtK+CDjhmVRr0P?=
 =?us-ascii?Q?d2Xl9oNHtmZl1KoV5iJK7zQu/BNyG4zTTJdOjzs0vQEWQVZ53V1phNBYvkeT?=
 =?us-ascii?Q?OPlvYxWSKSkBydsu5AfAtReUaN3YkLMj0z9kS/FG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Upnbgj0odORsoSgQlfUrUwfwO0/a98bMI2WlRREKUTJnOkqfLZYl6lr681ec4lq3mYMmHCIrjJ2S64/vuxSKotiGplFUCI7drF3dWndUXQ0b+tdGjstk89Yq3/2fWOD/WV6Vccb8DUzQKP/aWHPzHgaW0aOlQk/RX6lsh9wTW4Pb5+Pk1TUIUfZdECIbO/GeLhWUL9jYYbPG83L4IzXjdInSndWAoCcoowI5KXSJynrITlhZZOEoAhqSThHOF+rm4i7aVCsG/9tbuOvG4Wpii6XSoc3p3kkWj5vi6VHr4/4rahxNrU/Er0gXTaDMKbV3V6yl2k1b/7grNSEy/PZJxPVwP8ZurZLNhMj3TmochDxY9wwihmUqamrOuPtNLz6zAIsXC/U1a/lVhCmHmJ8ocJjv3m7sLGlHw103b/7HldHZAdL/sYpx1AHJWn5WBeYiGNbEb51Jv9AR6mu8eVhlYoq3Sf3/Pmf4R8yYxiAITUN5fEdqygTU/orK2MYMmY0OxIHP/WBhrOGyhyF/xm9cTOa5nz9WCGv4WaA3AoXjdE/riB1SVyTY3msxzp3VZJbXbX2chBOCVf4+WYmsdAjtWjeDxmqEEc6vaOejQD+mM64=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61127651-86d1-49d7-6777-08dd05b1619e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 20:09:16.3409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wxfej4hGoh4KGGXuDwZpHPGMsjbvQnVG/ABKhlb/+BWkKkAbMaUsf9Rm1vCGE2xps2kax+eCZgtHOA78P8iNKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4997
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-15_07,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=876 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411150169
X-Proofpoint-GUID: xx9iGLPvqXSEVChrnJ7zjCTm7XwzmtWS
X-Proofpoint-ORIG-GUID: xx9iGLPvqXSEVChrnJ7zjCTm7XwzmtWS

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241115 07:42]:
> Critical fixes for mmap_region(), backported to 6.6.y.
> 
> Some notes on differences from upstream:
> 
> * In this kernel is_shared_maywrite() does not exist and the code uses
>   VM_SHARED to determine whether mapping_map_writable() /
>   mapping_unmap_writable() should be invoked. This backport therefore
>   follows suit.
> 
> * Each version of these series is confronted by a slightly different
>   mmap_region(), so we must adapt the change for each stable version. The
>   approach remains the same throughout, however, and we correctly avoid
>   closing the VMA part way through any __mmap_region() operation.
> 
> Lorenzo Stoakes (5):
>   mm: avoid unsafe VMA hook invocation when error arises on mmap hook
>   mm: unconditionally close VMAs on error
>   mm: refactor map_deny_write_exec()
>   mm: refactor arch_calc_vm_flag_bits() and arm64 MTE handling
>   mm: resolve faulty mmap_region() error path behaviour

These backports look good.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> 
>  arch/arm64/include/asm/mman.h  |  10 ++-
>  arch/parisc/include/asm/mman.h |   5 +-
>  include/linux/mman.h           |  28 ++++++--
>  mm/internal.h                  |  45 ++++++++++++
>  mm/mmap.c                      | 128 ++++++++++++++++++---------------
>  mm/mprotect.c                  |   2 +-
>  mm/nommu.c                     |   9 ++-
>  mm/shmem.c                     |   3 -
>  8 files changed, 153 insertions(+), 77 deletions(-)
> 
> --
> 2.47.0

