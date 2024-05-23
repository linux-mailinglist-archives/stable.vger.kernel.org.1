Return-Path: <stable+bounces-45992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8038CDB01
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 21:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B8CFB226D3
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 19:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1A684D02;
	Thu, 23 May 2024 19:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DgUnfegg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lAdsIDq5"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC53C5FB9C
	for <stable@vger.kernel.org>; Thu, 23 May 2024 19:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716493533; cv=fail; b=EocNYTs/Ho2eoFdq4CkqsnsVvrIxxCDJOpJnNG6gfmmX1dRpqQBY/nEvoNqQ6UxZetoP+uXIcFkAlLCqyPO9r8PIyqIbD+ffYbdSJ7Ma/OPOI9aFUrPjhm0fPvytt2p/mQHy54kHAknGmWRkYDQCPStREgDu4DKyDCS+/cO2E6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716493533; c=relaxed/simple;
	bh=agR4Ja3q1+0VXApn2EyH8gN6mKXMFs/YMJRf7kHfdjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UeMTW1tGf1V1ltYsraOF+AoL32EDArEQcYHstQY5eKW/xoJNIH+jXjy2UBgGGJlF/JmxcojRiDLpJXbAxnik7fTi5zzFfP9kRPVF1J+FAkYuY3ky1tII22teRF1ZRXoQ28YYdIECMwvX5vTLy8QvnMCYkxEgDaHdMt7QOWyYxn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DgUnfegg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lAdsIDq5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44NJ1Nku021875;
	Thu, 23 May 2024 19:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=bz2n0LE9XXR3M/6hYY7l5eqaoezzvMPtpq3Y1AKBRf0=;
 b=DgUnfeggIIynYyf07ejbjR3hf5+9hnSWhBaPkrHCMRufd95DRCwC+opX3+XZJvCnMeeg
 H5JQpUNeWnvdGiK8ywF2ZMNqFaX0/Y+prNhhOHwHpgnxojF2GIaqf5pZu1cjmH3z9DsM
 sXwbb2Sjn30/zI1xjuBPjS85NrBVWRgEPzXFwRXx/btz4Z+USYFB5YGfRju3uEPNJxBf
 6uLPrVu0X2kpFwZUjrQvtvaHrV4idNzSngSOkD5aDUcP01jTXIKFlFyF6/fpqf+Q+SUE
 XWA0FcMa6ZVb4Nbe1c50WBQ7rUzuEuKNkAGfLWjohfGbCe/dyHRWYW4qxprFhDEqOyDH eQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mvvb0f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 19:45:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44NJ3nYk004951;
	Thu, 23 May 2024 19:45:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsbdxf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 19:45:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fI8+DICQzsxhOW5DORkV5fyS4sReNg/C7p/EObdJcn08Y7TYLObxBH4auCVkBOAagqdwgrCN8p763ZSc/OajU6MOHX7MaB9BsC4vK70OBuFI3yK8GGtQcZ7wFKvfaejjqeUTeo9HhCnCnBHYJGTpFIyw2vM/87/2kUN2ZDqUvXM5NHJm++I/TaWUVF8diFgogLqPDISbg0aLohA0ftoWu/E27WkiFA1NoIgFbmIi97r44LMtd20knpK8FWrUkLf2Fd58l1LR1fTttBOVqV0hmfGg5pVqTPFanZtHY1SoduB+w1TIs/WIILujrmp2+csZUJdwaIGlcJjXgQOK2row9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bz2n0LE9XXR3M/6hYY7l5eqaoezzvMPtpq3Y1AKBRf0=;
 b=lrT95s9bgPmqh3yggjQpQ36MnR/qo0ynWhKgqyHBPjJRFsfRa2xQ8e7Uf9TQETQHsAyPEAAbCHo6EvGs+K3ZZP/z7KzkZfNgi4c3NrB8EiXgCdx5FkaetHOm7LND6wgXcolEFdkn1Dpl/ThxCt73lQ/HYsEFz8ZjqKEgAXtrQXcWlbQh0Id/1qpcGGrW881oBKhWt/Z+8YjggNAAe/Vcv2WhXovjvJYpbOfByjwgobiQur0i20heITwIYBNdbUT0oMWh8fQXv+cJgsdwxCoYr8AsbMfF/DU3fMtaNkPnSWVeQ2RFXjmFbP3GFhgCyNNvHTCyRLhaGrgfZOtXk5YMAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bz2n0LE9XXR3M/6hYY7l5eqaoezzvMPtpq3Y1AKBRf0=;
 b=lAdsIDq523G9GF3DqR+JdThtmKt4CQLx5llDUrCJHOLhBRpLZuV0Iwx9tngg1XMtrYpE7NMJ6tKfHPZJ3ADUM/7yoBYbOLuYvS6tsXrWT4KoWUFFTcZ/S5wLc9FRHmJQIoigFhzClKGWhVXsSjdM61/rO2sBxGedb9BZDrcLbTE=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DM6PR10MB4362.namprd10.prod.outlook.com (2603:10b6:5:21a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Thu, 23 May
 2024 19:45:25 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 19:45:25 +0000
Date: Thu, 23 May 2024 15:45:22 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, fleischermarius@gmail.com,
        sidhartha.kumar@oracle.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] maple_tree: fix mas_empty_area_rev() null
 pointer dereference" failed to apply to 6.1-stable tree
Message-ID: <tqyvr6nenpho7fg5p5byipkmlhrv7oqdw6qi3mzbq54nofeohf@4m4fe7xcxoyr>
References: <2024051347-uncross-jockstrap-5ce0@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024051347-uncross-jockstrap-5ce0@gregkh>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT2PR01CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::28) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DM6PR10MB4362:EE_
X-MS-Office365-Filtering-Correlation-Id: 151c6b6d-6ccd-4d18-7b52-08dc7b60e3c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?TxWYJw1fNryiQVUS3smyuaaAEVXbB4iYA6F0xfdhCJV4ASwuwsC+FqbSC3Nt?=
 =?us-ascii?Q?f0psuzQoNkcipBAuMf2SKl5KqNC8zwwyhpbZartOBQFU8txBSpN4qQp92xpp?=
 =?us-ascii?Q?mvwDzQDUh/7PdRR+YtOXM9NZwD7uMb5FCWWdKlrJhPrEm7UIi2GoPHVvDBuP?=
 =?us-ascii?Q?J1QEtt3NJMw3fePY1Jginl5qW72zV5okWtb/D0d6uuRYeMEmjRSwX40QMHix?=
 =?us-ascii?Q?xCMZGzJlz2BCFrdV4XOMOu0zqRalHzM1Khh5Yo3azM6qb23ZBtgkPd7TqRWP?=
 =?us-ascii?Q?tPMZUIccDGx0v6dvLn+UaHqorcj+RDoSxjkJptUkwEDKT9M9Q9YqhDeHT9wf?=
 =?us-ascii?Q?W5AQxM27SBH1KNk5f16ibZpO/BIdTj/9fP9iDkvNdK125AORZjqAqyVO66sa?=
 =?us-ascii?Q?dTzqynTeyjlnbmWeUo7oSvXQ0besAxyvgtLx1bHqMUXW/0OdP1KfniyB/Dyb?=
 =?us-ascii?Q?aWjMmFEFWzyF8WXBXe6C9ILQ6lwQk99Efi3/3OnxTLatk15wSd9YyfK8LH1q?=
 =?us-ascii?Q?ZSNFVrxS8EgDpsBPQp1cAPmqN9Xwzf9KDeKjVCj6PbR5Mfl6Gwv4ixEdMzua?=
 =?us-ascii?Q?lKRh7a3/xEZJLc7XTvIpkcoe5tFxwB1C/8leNhR8TZPmiLr23WTrCSX1Rs4C?=
 =?us-ascii?Q?+b5j5f+Ky7QeGmW9qCVoRCf2pne/FstfIeZ1sBAyFOgut62Rh00bu13ULX3j?=
 =?us-ascii?Q?meRp0owYTwj5J/1q99mkx6P9JmlHmFBVUaSHnzTO0Y1zKmulOUcOc0KMGG7i?=
 =?us-ascii?Q?HqOpd5Kn4QmgaXN/DZazH7IoW3xOTF9ZlaL7d0I8I+Z9x/MaiRRWtZoka7L8?=
 =?us-ascii?Q?Hz8vdTEJLrVAkIoj3wmtFBkRMeQfNrjAQyy3tbYcAG3ZraiCBS9IZcn5kVE4?=
 =?us-ascii?Q?2y2qEbZosb9GgYcbTWY8YO6jr4RuoSXeLPgSbR1EryPOzrbJV67K+ZtPYiwu?=
 =?us-ascii?Q?iu7f082JEBWcFAdRRaTSpxTaJ19NsExsjcBIFWJyNdNFmK7sqfJsXwGG0smB?=
 =?us-ascii?Q?L4NQcY34VSTrfivKZ0yYrQ1InHbNFicGz/eP3oBoXkTrrj9CZDcUNdoUg19O?=
 =?us-ascii?Q?j5fmz1Eq4aXn3a6DTbU4gf5h5uGeUIcTDClLZpjGz8Ah4qibYyGxu/VfrBj4?=
 =?us-ascii?Q?iuoZzPfkaFesZpOEEEHj6de+HyV2uV5U/1l/DFqXfAD3A9v3rJBXQoESf13X?=
 =?us-ascii?Q?Ofeaxv87cl5+/m6SYsRy7qWT+cSQKiLfpIxtIBoY2S7zxovbdoHEHj9SMZ4?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mt0W0ecwV+pEEpMe1yNTVX80y7ntZ6/UrFDJVp0FFHUSa540Rfee2SBCShyO?=
 =?us-ascii?Q?63iATSPuTJRTj8Br7C/0EjGmEVVqi1B19VkDV3OBH3jJrwfwoIIMB/gV8EZY?=
 =?us-ascii?Q?sSoEHtMwEPHmc8R2+s4CpkIs053Aycf3BtQgJIiCLsh2WDqZg/wScXkLooet?=
 =?us-ascii?Q?iF1c3vpZA/UNEPAAnKU2+22c+VjbrSGM5k2qP/pFxlPmRj3dAc6Ot2GZcqRy?=
 =?us-ascii?Q?YjqRY+mX5S9jWCq1MOFGUZGjQ9Q5coHJGj7WUTzSazGMQqYX88KnPxoE0JXl?=
 =?us-ascii?Q?k7PQRhaARcvE4cbmofJTf79+x3C/4UlQfPzIJxQqkvZsS04L1kpR1uGzb6hX?=
 =?us-ascii?Q?sjE3O8gqHngL+O5xYItvUIroQSdJ2qykkqInbCOzXwOYZb70HaC6pX/CRjrq?=
 =?us-ascii?Q?BkclZHuOWRwoUSD64yjfR5ZHriJYa72CrvxMUfJ+rm+89cxV/tOdOF2lRphW?=
 =?us-ascii?Q?g2bOQiqTLIRSZ+y7RuxZGjNBiRbJ+Yn6noV4ZQgBvjg/CS1uWxsV8eNacQ7h?=
 =?us-ascii?Q?IkSbLvuqfXCZ6QaVxRvfKmGn4X11vLO1qO6lNCXai0C72iLBqd02SR8MOCvh?=
 =?us-ascii?Q?srx7yYI+PRnqHZdPGI979ycaYowSxw9uQHGpaGaDYG9Y9xDVk+2fiuz+2i1o?=
 =?us-ascii?Q?hC4QWWOIY40ftUoU8JtxEsh4PvI2MN9sRlD7cG5Z6nQluZ28nRkIxiG1GBYo?=
 =?us-ascii?Q?SNPTEtpnECYQ6o4CxypmVq1ZQG+wI13ZKUQDS3Oc4v/T3F0elx8gkcyNSz71?=
 =?us-ascii?Q?aPmNKewU45bxe4nC2/o5eKz7bncEWA02sPF7XilT8CqlkdCLD121XD6RAoWT?=
 =?us-ascii?Q?BBwWmkzEAOPJf5sFtJ4F3sZ2C8GA52YuqXRO0w2JHCnNaFTtaBXeCblKOL64?=
 =?us-ascii?Q?cAU+8wDjpgVeL3svxAPg2qy7cRAU0/JmBumXr6mTYGTgShAlKY+UVX6dbH80?=
 =?us-ascii?Q?aTLO9t+r3xzvgO30Xrl3OvpeDFN+vfpAwx0PPKoFa098u63oP40bKGq8sVR7?=
 =?us-ascii?Q?wJfSe4Cgcs6GqMC5/uFWWxBGyQUcZBaqdGNsbk2Fobmyt3pBJhqJ8I9g8D2g?=
 =?us-ascii?Q?ByCRwMUHd2Rf4zEgHDoqxrTdk0MbXfRTsPEeiu9PWwLKuZA9uM5TDrlEF5E6?=
 =?us-ascii?Q?aPFW6gEyJXqfeYipU/afP2NYPxIN3ykz7RJI3CPqQh/x/R4PdVe+lOGu/H7n?=
 =?us-ascii?Q?ZKNcIf41FgJoaVNtrbfNlu1iMX0HJq9JNr6yVu10knyPOEtR6mgbkRHccLgm?=
 =?us-ascii?Q?pUizCTVj1W4TLFMuun9GvYSCqmN6CjaxrLiDePoQf1jVMvsfRIZPxCPjp8zv?=
 =?us-ascii?Q?+cl7NZGMNVlbv0wlQA98BzCxE+dsio0EYejmfE3kRxeyBonUj5C4emEwWz2s?=
 =?us-ascii?Q?m3JixlZZENFuQaa7h8adfYENt74ZAUiHwF+PrQ5nHgNmKonA+agC0HcVcOIA?=
 =?us-ascii?Q?TS+P4FHV+4UT0NqB7yW9hRaLJBCSeZT4iAJTz9engpbaoi7gocB1p67oFb4K?=
 =?us-ascii?Q?shsvvw9HQi+x1O0L4MIIOvAufKdu9SFTZK2Ks3jvpNZxKq+rLr6T8pc0ihmF?=
 =?us-ascii?Q?UYgNfrs7dMAaHGStuzhYpjeGbCGo1BMkJ68C2Muu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Bapj1h3dkXoygv5W6JAC763zGEw0hUI85M0WeGvvvF0EJlf6fkFMa9vcXWgmci5K4kaZJ03B5otsnOGsv05kqcylMBHExW6VggPiodunJpoGljQRJ6kzx5tS5iIj3HsB9suTe5XSDwKmNAzHPTgMB805jtwKJ3nJsn+wrRCOjI6f9Yzsj3Pa+ypdvrOPuM/FJvxkHfILoRxCQB8Xsftz2EobAxRZYCyiHBhB07NSi5TH/WFZRsY+Dx8mNmIFHn7WgcJNXbWFOeMptqfDqBjjqxicGioUNPVDhFV3LhpFFloz0M/RcWWd+i4q0ReYmQjYl5ys6v1DRVjyHtih3HaJ4R6yoB3ZMpmaajHz0AyhksC50FUz7rkJDcnTvUyjmkJuaOMIyUQ5B37X1rxoWQGgSIIqATXnIJc0bfS46soS1kiug8Ts05mrXwHNbJcSd37C7fvQuLxRDl0LZ6bHDKgTRwaQGX2T9ZFywnNxAA2ctUFRn196WQO9iELLEwoFB5jyN7PfAG48OiFWIuVijZaUykvx+ZheDwIHZNeoeLX70oqVPjd3CwwCRJ3qXOotl6mK8Nt1uxn8z/zLygGzvoDog31TaxJfLFplps/27j/3k+0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151c6b6d-6ccd-4d18-7b52-08dc7b60e3c0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 19:45:24.9734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLM0k6BHcCJ0QI8bn0y6pF4ojuihCV9Kvbz63HI2yDstDREALjOhvViHWS38sovF/tIS3al9RaF1MpUaw3kLDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4362
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_11,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405230136
X-Proofpoint-ORIG-GUID: CRWq4y53COzjJa2Do0eXAMT_YUy7aAJi
X-Proofpoint-GUID: CRWq4y53COzjJa2Do0eXAMT_YUy7aAJi

* gregkh@linuxfoundation.org <gregkh@linuxfoundation.org> [240513 09:30]:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 955a923d2809803980ff574270f81510112be9cf
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051347-uncross-jockstrap-5ce0@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> 
> Possible dependencies:
> 
> 955a923d2809 ("maple_tree: fix mas_empty_area_rev() null pointer dereference")
> 29ad6bb31348 ("maple_tree: fix allocation in mas_sparse_area()")
   ^- This patch is needed, and has a fixes tag.  I'm not entirely sure
   why it wasn't included in 6.1 already, but it applies cleanly and
   fixes the issue with 955a923d2809.

> fad8e4291da5 ("maple_tree: make maple state reusable after mas_empty_area_rev()")

Thanks,
Liam

