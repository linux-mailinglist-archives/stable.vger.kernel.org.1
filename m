Return-Path: <stable+bounces-88092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 952699AEB0E
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 17:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B5D2834A6
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 15:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4F21E0B6F;
	Thu, 24 Oct 2024 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AM9DBchH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="APUyCV0F"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECDB1F5836;
	Thu, 24 Oct 2024 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729784966; cv=fail; b=h8zhnkFYRz2rcDu1tSX4SrjCuUPoKEZF9kPFt+dcQU3tsAHRbz58rFU8ZoKybIixw4fajBnXXE5kGAOsPUaS2dY9FL74DYez0QLyXy9HoA3cEWKnjkh9TYvhL6d3zUyuJ+XznC2+5IqHnIb48ldNVv690fN/a9BFgwFgMjJ06UA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729784966; c=relaxed/simple;
	bh=bfPu6XS2Fk0gE9a0cdcUkl0Z9P7AjRuIofRP4oYaTaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hK/bPY7iHYJZT92q0+lL33/OsbHKV0OESE4FmDZwBBGLMKzrzFsgTZ/zQw+OACJiijQ5aR+E0FlefLvP0U5mEPRt2IH+mJJ5y5ipWfA3ySxpNmkdZhU2Q6hvY5iIfZaMmOIrTNXzBYQT7g/LNbQqC9GuF8k0pzg8p0elOaSFLWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AM9DBchH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=APUyCV0F; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OC1n4h025830;
	Thu, 24 Oct 2024 15:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=hDiE1YwPOtWYbertz8
	+q4MeLYz4yhKhXvKGZzqTzdmQ=; b=AM9DBchHIPSKxhR4LrG2tDAaXHnFH+NSqj
	YtirPTymr6ueHxBrDGN37yuj56ll5XMAioTyIBUgRYRBC4A3sxr6NUJhXapx+wrP
	opjyQYQ+BrmYVGSM+2RtV7/cFMWhUlDS0V5VZ0oKMeJMvLROj+Y1HLGDt7RhBgf0
	8bKkCVe6faJG/5r0ib46z8Wbj5uym5rCgFrv+WQunqpa4i9z3gllz00AEcgH+9Aq
	5OcFjpXrYM7TMSUwBGDdZtukF9czgKn0jzOQLFPCViXS7Y7kwP+9okdL8QDMNysI
	8/FcgaNAkU8nDB4lg6ovys9V2uEhh+GTwMp4lpj18x9cO4d3ZqbQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55ejv6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 15:48:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49OFXiFp030872;
	Thu, 24 Oct 2024 15:48:54 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh34um3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 15:48:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcrJxNnN5IibITORCflJXmvLztOoanaw0GLiHlvBctxoL2rHMjgzJgsWIwQSQMpFXmcbobyo+SGIzxZX7zeWlloxj0nc8vr/s7Zipr2UF9LZQ1VY/DcoG5+EwlwCQpb61gBVuTp1ZzEqp5NdnFuUJKIzmPdwsueuYQDaVZ/+dff5EUzOlPQzjE1U0xT08v6VuAuv4ZJk8my2W7yeNmt4Enkmxa/24HBeUauV85aXiBC4DUqzxXPYs4v0djW91JKg4/+SgUoXkekcH4H+SrYHwIK3+PKU9HGgcVc/LoqJxZ1CzCD0IcYigxahfPoF5qJxpktArtgl9Rm/ep31TzGXOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDiE1YwPOtWYbertz8+q4MeLYz4yhKhXvKGZzqTzdmQ=;
 b=V56lFP8FCSJtS/L6ZWFD4EVkyP/3TCJEdvefJdvF/hORjxjidpmUERxh8qt1pJ99kd0W2z+tQ9hNEfIZVm6M4dQxPmiOWCnZVKkhhr6jfygHHAkq1BOdDuNHkj5yN578/5Vs66nj4sBf92UmiLKXwFJnuW4+AAi+r7ZNB1CnBDdzbU2RvMa0JhoQunV/AdkYYUGx1rpzq9OnHB7dztmdNfZ/o524xU0/4W5p3RtkY9uwTlc7LtVPwli59swWNBOG1PHdrXz5DPQnJotCPrHIQ0TCW4lnMz7VEXwvh4goHqmtS0WpsRifKVrouZzWLBYxUkD5U+wAT9Qxkdzzw4wg+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDiE1YwPOtWYbertz8+q4MeLYz4yhKhXvKGZzqTzdmQ=;
 b=APUyCV0F8gIvMBzQ0oFrGwHMe/nSMHyPkYbq3KldIiDalWAjfmCpxAFB/7KpMoKDrW4z0F5ADcO6nN0UJk9+jYpyzgavHveBLOtExhTb0oM4tpSR1PbpLVOnL1byqLT43EIRckgz62VO9AGy68WiahOgnjIfXVluKvsqBJ2mmaA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by LV3PR10MB8180.namprd10.prod.outlook.com (2603:10b6:408:286::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 15:47:58 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 15:47:58 +0000
Date: Thu, 24 Oct 2024 16:47:54 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Petr Tesarik <ptesarik@suse.com>,
        Michael Matz <matz@suse.de>,
        Gabriel Krisman Bertazi <gabriel@krisman.be>,
        Matthias Bodenbinder <matthias@bodenbinder.de>, stable@vger.kernel.org,
        Rik van Riel <riel@surriel.com>,
        Yang Shi <yang@os.amperecomputing.com>
Subject: Re: [PATCH hotfix 6.12] mm, mmap: limit THP aligment of anonymous
 mappings to PMD-aligned sizes
Message-ID: <2b89811b-5957-4fad-8979-86744678d296@lucifer.local>
References: <2050f0d4-57b0-481d-bab8-05e8d48fed0c@leemhuis.info>
 <20241024151228.101841-2-vbabka@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024151228.101841-2-vbabka@suse.cz>
X-ClientProxiedBy: LO6P123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::16) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|LV3PR10MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: 34f8bf06-c17b-49c4-4612-08dcf4433be5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?euHWgpVVbaos6M5iXvlA418et06Sn8E0kZz58zUIUTp0nFvc72pyjy1ybROQ?=
 =?us-ascii?Q?+O2nXZZwtQC/Ag7iEaB38LqzFSxfolTT4lSucF0UZuzruMpT+MnNEPcJj79F?=
 =?us-ascii?Q?CZUdIp0QprV2rFggdoaKpcHDnlhvyQNbhYF0XxjM/LNM+vQ9gs+76p/cPEEG?=
 =?us-ascii?Q?mh18asnTiTW7SuX9XHENASZ2cqtNKYiyzMsy2bWI3HAtHX7P6DjlfCoahY9M?=
 =?us-ascii?Q?NFakeJG5HpVgIJrVblbekYvQsJtGu+87TMcz2pBWbRgfV55MobUUDkeZ9iLP?=
 =?us-ascii?Q?QgOQvHwTvmj97CqNVNpAsm3Dtu7pnP48sv9U43uVOoxNYDN7L4vezJX/WeDA?=
 =?us-ascii?Q?L93S8Gaf/ubwuxOHmPdMlMQ8NTjtT6RxCbcqnp2h8Ty3Q6fqkGisW9doQ0oH?=
 =?us-ascii?Q?lDFz5g3WiHVIFvOcGqqs3022KGBT45vBgLPR1I8TsY164ik9oPNdTp0gEX2v?=
 =?us-ascii?Q?wMHnJlsy8+ZkiqVcWYKFoaZqHru1ZSl8dA0VT6MdGWx+tc7APBaHedMiSMnO?=
 =?us-ascii?Q?ML1ddlRzG/H7Czs1OtbJWFuePDs4VUIekNCdxbDnq5kdmF+cieHjmmFRl8An?=
 =?us-ascii?Q?mWYta6UFuui3XAkhmkKnQz92/5Si9f7l/V8IDzxZh46J9b16wzCpy1iLMnK2?=
 =?us-ascii?Q?Komsz6hDvmEv1aLPBeqlZy7SsNc1BAifIwqu5e47gqHhcklF7jR9FjLMinT9?=
 =?us-ascii?Q?p38hehGos1vrgGWwHeiZB/C0j/JDFwDLgRoUm50IpdZg1xYT/fFM19A8fjvj?=
 =?us-ascii?Q?BotxV8QLycQbLIyw7hFHkEfaLJSPEr+qKMxy9TfGfu9S1S1m+7CkxJC4kBNj?=
 =?us-ascii?Q?VahniwaVGqCNI4lu/bKsdeK8yoLlhu6zPAQ1wOI6qG8vrN1JPlSMuNL8Lxwi?=
 =?us-ascii?Q?s50erGzSDfpjh8vcYxnE1ihaEtP09NXrELAYg5kDv5vZWdYfUdrrDDpO01BJ?=
 =?us-ascii?Q?72n38d/Qr92O7v1oAHJFNEhM9ruIXp1XYxDSbKRTfjO4RbELeuIsZ9AqzLab?=
 =?us-ascii?Q?4e9RvsTjSG0FBoYeFavOJdLXcFK8V6h8Buh53h567MwYOEYULc+iWrziG8SC?=
 =?us-ascii?Q?YdaC/o7SoFZwWxM/S0PSk/w5rtAuKLwPofbn83Xt41XkdWxAs7FVuXq3Pi22?=
 =?us-ascii?Q?BWYyshOhAoe1ScfOU2UsErhI+ssBJI06f66PBfBosp25+aazekafie3hwz4e?=
 =?us-ascii?Q?XoROlkBKX1WscqrEH2HqjlFdfugb4lSRZWgxER6W4EHqWwHWpadDDjAxdkxy?=
 =?us-ascii?Q?Wib+CgRNMvFLqAmXPXr10bJY3Amb6axxyvyEjED3jE7aWd4QNA7lq/ARO8tQ?=
 =?us-ascii?Q?x5NdEyM1D5ChGx+bwzyChBn5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4m+rGqlsRqeSUjAo8ovntK25IO4XINm0dYUHDn7+L+HQq4uLdOcRhTimGSlQ?=
 =?us-ascii?Q?yKlolKxVlM3rpTuxFvz/HvIRb8fhcwZjy/0S8dztzB2145YMre1SieIlmqNX?=
 =?us-ascii?Q?KGg+bdmI+yUQ5qoxrSUkmZFxnTn1P8fV1XuX5kp8gXNgt0rydVl96hDL0O1Z?=
 =?us-ascii?Q?mm4A1hdOWkZ7mt1uCziUk7Tcz+Ef1ZhHZdya9RiE+v/fdYVklhsgGP9jhlqn?=
 =?us-ascii?Q?PMma3ZklvvAp6Xg3fe9hQXkSpP0TX79fgB11OLPS/pvPoDJL+r4Q9Btz4EI0?=
 =?us-ascii?Q?Hvj0yW4uaPjW/d83l7LY5Tsf8YcFVk2qOqbn6/zqb8nDBdBtEFDpRS6zYphg?=
 =?us-ascii?Q?9A6OSI37mJwwTlAP9pl/aZcZb1UYmTj+8T8wO6ZL5+77OUwD9pwW1giObIMu?=
 =?us-ascii?Q?5k+ydsrTTDJ35nd4nISKWCLkFq7cWzyRRwi8ALOXjSzQ64EwbZQ74KH+iuGp?=
 =?us-ascii?Q?DBE8PF1vDdQvKkOSFxZUqnwHynPu7534sHTFrCi77chHqPMRvXhDz6guqJ13?=
 =?us-ascii?Q?ZOZ5FzWXh/veM20nSDbHUZp2Su5KNwFy8W4V9FWQt8EdwzTOZWXXp0vO7P/3?=
 =?us-ascii?Q?FTIbIARLrN5MCK4eEm2EiV38ByK5/Vfqx11K9e53+YmiAOEJC0VLBob6XmZH?=
 =?us-ascii?Q?tW34zIEJ0W0jndmzKy1ApaGWiq/j7FyXSYkebfWLbrvnjSomPmzQJpWcd/41?=
 =?us-ascii?Q?5/Kotk3MIldKBJyBuw7zknqeuvtmjSwRN2SG+LLG9NvCAy94p7+TLiicBrcu?=
 =?us-ascii?Q?TuyyGP2rcjVpyI7YkLJK+UoUjQe+FKhC1cnX5kz8/BIQuWsob8C4ZT8xM0fU?=
 =?us-ascii?Q?1W3sMnWD9Mf/ZGaVpMDv99FlbiaDL6iVH3fNk5Qwn3fzoMHRN5Lox/Yn0ykJ?=
 =?us-ascii?Q?Ht+CHI+echTYxW/455lYKz0JqC80dI4FhPQ2oqRtegyCZ008Xthw4urt2Awe?=
 =?us-ascii?Q?Z6ll/JivsqdaO5oY06wMQ6CoQj/GGV4bi4H+fKg78fJgzJ+jZqzbKqXcyote?=
 =?us-ascii?Q?O/+iacc5d0xvF+0ePcXKLm1ZIOipey8BEc0ZAFut0bc7rLwAzl1gShdVKSOA?=
 =?us-ascii?Q?dB0xLhufEkkgMu6v18F//kSYbmrxSQXF22g9FkRfTsuSdu6uODsQ0RiU6Yw8?=
 =?us-ascii?Q?9yMPpsUk/FlpdaanEi8wPt9feIMMR8PFqBJnF32AwR2oov7z+vKiInShlmxP?=
 =?us-ascii?Q?p4EDvDrOdjlOiM5Rcb6klRYldldUT2EPVxFGFcQJi31OcRmCLjMdqjaPqIFr?=
 =?us-ascii?Q?tLhk3Yyo5RgOZa4XGff/OnzfKDc8a84/Z88jpz6K44k7paQ/AiI83Y+FzMT3?=
 =?us-ascii?Q?cTSoP9LGgbhOO4IjuDhaF6VimalGHOImp0qRcUk0ZDFYAEqU6wJJCj8MVS65?=
 =?us-ascii?Q?Zh3njqOzc1Z/x5nwZGZxLQxcdHjI7HbyFmS2Ix/yZgVpjXlm/FxPnVlGNzAV?=
 =?us-ascii?Q?FGahdPBKkS3DYSEyKbw1247+r3LYkWzoIodAiZedrh5BdgwPIgbEmWJdJ2Jk?=
 =?us-ascii?Q?msR9rV1jU3AkGXqvz1yZc1Ze3FDCSLeHTMOLo03V8FAb3TC7d6LNyaZgyKWy?=
 =?us-ascii?Q?Y/bX9hpvQoPD2sVcOI9y2hPpg2HrrB/dwSGOoulFxgim/kWZANWS2tAzZn5y?=
 =?us-ascii?Q?yZrfTsyn4SsoBaXrgf4Zq606D0OdVJVN0QKVnj7KBm6PgdSt3knqF3bH2Aiz?=
 =?us-ascii?Q?Gb5ROQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ul+P328ZWq3qGorF+wG8hxLp0Pnx1O6PVLc0UYFChn9L0j0+IxycLjZn0ldPL/XRxEIC0DM6LNREgM5cUYC4+HlEXokf4bY+W57EUOfcVA1Z2Xj663Fl4XmeVzHxcRxlFE9ruFLqUDtK0iOGqUbmroWKzAysqUMWE2Jlgs/0OdAxGx1zDbYESRF47XJRGoefeADdl9pZ7v90xFZvM7ZzBP4xiRuqd/4u41a6jcplfZc+M8nNN9mMpRRVQvu1wLGB2fdqCD3wPM/L635VNUnn0ZM7iNs1DhuHAyhzhLit2z4q1CrVEyfEDVLLrQx8eKHQncoTYsFVv1jj4JpCIqgz0mAbhOIVdCrg5AKqs/DlX73eQzxoLqc2hWdG4fybjzs8FktiKO/JnJBKz19cA0Tiya4qM4x0QrrAoIYViT/DuVShgmH8wVzn6CSopFHKQ9CwfWK5mpscx5GxqkpAWqtljq9zhlzEmcVBXCZd9mjK2N7mdy3lF3izyxfQchOr9oO9V3Xh7VNF/fiYXU6zDb3NGxsefYg5mr3Mx4rgbst4/6YU/DOldJ623C1sXbvZK6YpFWlDGLYvbFBQSF+Se8KjPEH1N+gKNgeDQQQKRs3LoCQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f8bf06-c17b-49c4-4612-08dcf4433be5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 15:47:58.7869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvWONWseiQiG6p+N43R4Qfbn3FUlb8wHM+7EsBdeDi0mAodkAuYt/mHINI75/+TUHXAWshZP62+uANvknnB+YPNsNg3LjT2/kONo3kIdG7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_15,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410240130
X-Proofpoint-ORIG-GUID: VfrchmZDHQ4JCHzMyH2cqQN3TmL9ViCM
X-Proofpoint-GUID: VfrchmZDHQ4JCHzMyH2cqQN3TmL9ViCM

On Thu, Oct 24, 2024 at 05:12:29PM +0200, Vlastimil Babka wrote:
> Since commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
> boundaries") a mmap() of anonymous memory without a specific address
> hint and of at least PMD_SIZE will be aligned to PMD so that it can
> benefit from a THP backing page.
>
> However this change has been shown to regress some workloads
> significantly. [1] reports regressions in various spec benchmarks, with
> up to 600% slowdown of the cactusBSSN benchmark on some platforms. The

Ugh god.

> benchmark seems to create many mappings of 4632kB, which would have
> merged to a large THP-backed area before commit efa7df3e3bb5 and now
> they are fragmented to multiple areas each aligned to PMD boundary with
> gaps between. The regression then seems to be caused mainly due to the
> benchmark's memory access pattern suffering from TLB or cache aliasing
> due to the aligned boundaries of the individual areas.

Any more details on precisely why?

>
> Another known regression bisected to commit efa7df3e3bb5 is darktable
> [2] [3] and early testing suggests this patch fixes the regression there
> as well.

Good!

>
> To fix the regression but still try to benefit from THP-friendly
> anonymous mapping alignment, add a condition that the size of the
> mapping must be a multiple of PMD size instead of at least PMD size. In
> case of many odd-sized mapping like the cactusBSSN creates, those will
> stop being aligned and with gaps between, and instead naturally merge
> again.
>

Seems like the original logic just padded the length by PMD size and checks
for overflow, assuming that [pgoff << PAGE_SHIFT, pgoff << PAGE_SHIFT +
len) contains at least one PMD-sized block.

Which I guess results in potentially getting mis-sized empty spaces that
now can't be PMD-merged at the bits that 'overhang' the PMD-sized/aligned
bit?

Which is yeah, not great and would explain this (correct me if my
understanding is wrong).

> Reported-by: Michael Matz <matz@suse.de>
> Debugged-by: Gabriel Krisman Bertazi <gabriel@krisman.be>
> Closes: https://bugzilla.suse.com/show_bug.cgi?id=1229012 [1]
> Reported-by: Matthias Bodenbinder <matthias@bodenbinder.de>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219366 [2]
> Closes: https://lore.kernel.org/all/2050f0d4-57b0-481d-bab8-05e8d48fed0c@leemhuis.info/ [3]
> Fixes: efa7df3e3bb5 ("mm: align larger anonymous mappings on THP boundaries")
> Cc: <stable@vger.kernel.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Yang Shi <yang@os.amperecomputing.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/mmap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 9c0fb43064b5..a5297cfb1dfc 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -900,7 +900,8 @@ __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
>
>  	if (get_area) {
>  		addr = get_area(file, addr, len, pgoff, flags);
> -	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> +	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)
> +		   && IS_ALIGNED(len, PMD_SIZE)) {

So doing this feels right but...

Hm this seems like it belongs in __thp_get_unmapped_area() which does a bunch of
checks up front returning 0 if they fail, which then results in it peforming the
normal get unmapped area logic.

That also has a bunch of (offset) alignment checks as well overflow checks
so it would seem the natural place to also check length?

>  		/* Ensures that larger anonymous mappings are THP aligned. */
>  		addr = thp_get_unmapped_area_vmflags(file, addr, len,
>  						     pgoff, flags, vm_flags);
> --
> 2.47.0
>

