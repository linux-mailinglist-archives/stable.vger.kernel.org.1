Return-Path: <stable+bounces-121400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8369BA56AFA
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 15:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4E93ABC21
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 14:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BC021C17F;
	Fri,  7 Mar 2025 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z2d2O9LA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h1IBt+a1"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E808218AB4;
	Fri,  7 Mar 2025 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741359375; cv=fail; b=WrNTwCsdTSGn9flUZ0wAz1H2ABOEeLqQEujh/+IjuZCQHDu3wF7UhGS22yqKjIMGOccBGvkVDs5y1VBAVdW6nn49DMklBBXNPvbnobRe5gPOf2o9G5lugdhotzYtD84tcA28vASolAXRDSIu3HSOi4JJ6jHMl/A53pVEo+rntLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741359375; c=relaxed/simple;
	bh=EVcB0fIQxF8R9GGiS4HxshbrM5sbEa/hI1+cG8Sur9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lNm+LVlANPpsRuMP93iowLN4OVl3jgOm8mZB9EAjurjlLPDtuH98DhZrWm+zokAL+h+uz62LFBCfEAFfaaybdfVh8kpPnRYtiAyQXbX8ll9PZJNflv+27IOooUAv3wul5S6J5PiXJw7DEqejQEPGoEq0V0Vw7/GmXx7hZrossAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z2d2O9LA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h1IBt+a1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527EOOkH000336;
	Fri, 7 Mar 2025 14:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=bd2PiSkHNR37qlzSiH
	Rv7Svt2P6xmaEMdzpYugXRN94=; b=Z2d2O9LAxKLgaVlXImhgHX/QSSSQkGJK91
	ziUziKCw5CnCaL/UYhQv3Wy2Vcmbtd/nuCO7+NqdbeQb0nn7khsPQuy7B1JiAPtq
	KCQuPQRNrH4YMe79UdFg8imMGyEavPJ20Hm0P3qoDr1hN1tMe98v0cpHgcMeM5Bl
	Izl/wzssAYwAy45KYBu0TJwdNx7cVWXgg18g5kur94Fcv3Rz4dlnqH+4W6FYI4U3
	r924QhGBX56tZRRyhV7HZKTxCzdfrTJHRwnnR+qUZWQy/jv44ePexJlx6/g0TljM
	SOBUwCZD97skmUn1C/GvH1cA2UvcidmT7Q7k9zGPnVC/M+XYOxEA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u86vaty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 14:56:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 527D1thD039769;
	Fri, 7 Mar 2025 14:56:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rpeabtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 14:56:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=li0LTRyhG/jzO/YfQoq8X5bqFEOzZNELan3aMWLgVcRyjUUsYqA/sibPRVDHArTJo6FpC/m2JqdvxDikhCbc+5R+6JKniKK4gTTwq+RaiAYvCpg05IcsI5mPySxsUibs9S1FshXvjO0SiWvnken/lAc0+bNGPZxrxifsOA4NA72UsybffTnerwC68T7qFx4j6z86lTJvkzUXRJlpki9g1bWw2GwfPeXQSloj0O6O2qce+amhS+Vutl7pDF2lJ0JerAANmu86CePtN8L8xbE+9+9+Qlig8lgPKeFYie3e8lQ4//Y1yCiHeVmQb8xwFZp/qi2Fuw00S2l6bbnfWOFhcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bd2PiSkHNR37qlzSiHRv7Svt2P6xmaEMdzpYugXRN94=;
 b=pbUPKTlmEZSzNP/PwyYWX+pf5JzFGTsyNAa5TdonnwZGVapyOQvEOkwFga9kXVvuQcZQ2QClR3/3+X+YnSZacLxOt6c31NG/3D6YONrsr4gpJHDsIeEQmmZ6xUeBoSk6c+Qwgfk2fCrgjm5OqkL4IVc5fPPUTFPx7Ggr2J0Y0sFRPjxAtHEa07uZHwK7IVFcwGhBLMKI6ODElmFpIUSF6+hOk/QJ7pZ+8iL0bPZKB/nlMjsuJqf+lERjVpi9IeBg2NEDAM3BzMed80RP1FliB8fN7ed4pG9GGS3nFdPG/XtNJF2vohgLsJNA6LSvG1pwa6ym9bxqusJtYGJlRQ59bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bd2PiSkHNR37qlzSiHRv7Svt2P6xmaEMdzpYugXRN94=;
 b=h1IBt+a1JLEPMqkEID7eK3QpT/2GH8mqbSfUCgUdLMWc5dak+oIfMJo0UOSefrOkXxIYWgy5HFEpdd5k3VzPEyQbMfw/mMUgH9p3LAVaaV/4YnSQZD1j9UtR3d9z0+87xTt00QB/lVSVU5WER3usYiLKuRqBqLI2WstUogNuCpk=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DS7PR10MB5006.namprd10.prod.outlook.com (2603:10b6:5:3a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.23; Fri, 7 Mar
 2025 14:56:00 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Fri, 7 Mar 2025
 14:56:00 +0000
Date: Fri, 7 Mar 2025 14:55:55 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1] mm/madvise: Always set ptes via arch helpers
Message-ID: <d9cd67d7-f322-4131-a080-f7db9bf0f1fc@lucifer.local>
References: <20250307123307.262298-1-ryan.roberts@arm.com>
 <dbdeb4d7-f7b9-4b10-ada3-c2d37e915f6d@lucifer.local>
 <03997253-0717-4ecb-8ac8-4a7ba49481a3@arm.com>
 <3653c47f-f21a-493e-bcc4-956b99b6c501@lucifer.local>
 <2308a4d0-273e-4cf8-9c9f-3008c42b6d18@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2308a4d0-273e-4cf8-9c9f-3008c42b6d18@arm.com>
X-ClientProxiedBy: AUXP273CA0035.AREP273.PROD.OUTLOOK.COM
 (2603:1086:200:1a::18) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DS7PR10MB5006:EE_
X-MS-Office365-Filtering-Correlation-Id: 1063332f-56ec-4031-7243-08dd5d882ce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N4YOQf0QLt2pGXyePSzb67v9julu1uh8EYai7cw8FDdaORYgGlb8cyzAT8c1?=
 =?us-ascii?Q?8SDEEqiK1nw54wITwsgyOQU3bONkXn4AlIMZeKF8zdyf9T+cFYAfELGRmoDm?=
 =?us-ascii?Q?OCVS3Hr+SmPr25qJSYOOgRLe5JcxwY8azESotbc8/eEeCyaTnoVvcd5r5ZEt?=
 =?us-ascii?Q?+KJWQbcak5C08x9YX3qFBj/E8r8wB/5foae4OC//PMDpS3ia5Jr1EH8UrTOm?=
 =?us-ascii?Q?/MeND6EvqMosfo9Svkb3ql0TarfTpOe+ip2oBSFIlQAydmRUr/GTbIpUspTS?=
 =?us-ascii?Q?OAwoh7GmUJY5GzAnIxvQeJ9Hl8RcTe68Mx5aUi63Jf02mH8vb081JAmWIOgJ?=
 =?us-ascii?Q?8AE9l+Ae3OZvw+LDsEWLuDA+QjIMf6oDiQ6J85DRKWbBDHvZXoCWgdL9yjTG?=
 =?us-ascii?Q?NRS6IN8oOWsvR2h5nR1Ryc/BTysxbcl7cehoFUS1wu6nE83HRtua5652tztS?=
 =?us-ascii?Q?pM+Ai3Gp4r4nuKX4dZRQJRMiK5maoUQG+fC9UGrgTn492tsJJhPhzPQhN+YP?=
 =?us-ascii?Q?pYWQ3yERraUGCB0TVJgCrwYREg2w4ZP2UljbS420+AHin+YG5muTffiWDVty?=
 =?us-ascii?Q?AJMiV+pC0tOs2rkeLYWL/2lqcQvqiTIQabFT7ExBkZ+j2/R+eBEvH8Gnpwzn?=
 =?us-ascii?Q?IMS53m240c9Nt0ODTdA+R196CIxsIZPAUDGsn7JdFgeTv3IKImWJfT+hk/uk?=
 =?us-ascii?Q?P4Kvausnnb18nC57lJ1BGMX8ZaAx0TtaKU/oj0Zz52zp3trjKHA74t6YhTJz?=
 =?us-ascii?Q?RksWWfovAHqAxL/3rdEBJks6ifkwQyNKLash8QAeKuJTksFo9DGZGya3A3Sb?=
 =?us-ascii?Q?a5Z7MSH1472yCx91owTADNg+5VglsLEhzG+SY0NnwMCCt1hF7Wx6EVmxMfoh?=
 =?us-ascii?Q?7jtup5xiEe1MQtamQdmJZTssoKlOT+LRSSYC2UZ6Xp2IeSnEe7TPdP0f881D?=
 =?us-ascii?Q?y6r32g4pTJIZhmHt6QL8gTIyOSmbe/YDZAr/MgK/5in2VL+ps6SFjMlj/LCV?=
 =?us-ascii?Q?Ev0nq+Wl/Tx4KzIOj5jFZSbckVfjSUmezSVmiM6aDtI8Oq1/mZ8QAelugITi?=
 =?us-ascii?Q?cS2l41CRZsLRfva9RUn3Q8f16HEVH5+8wR54lB3iwIADy6DZnIavI7uSibN3?=
 =?us-ascii?Q?drR1bzXPcfzeOAaxuSXmIIY+LqFOf8e6ipyEUHS/+hm/y080Y6LCVZhza6Oh?=
 =?us-ascii?Q?tLJ30ZV7gSZ/41Zcl5GiNyko/8kZ2fDTwUk6igQNUQcLy/n5KWCBWKeV15eB?=
 =?us-ascii?Q?0LIScamaqggfRrvTU8ObA+X33ER/h8FsgAT0DFxZsu2yFn+UmS1iw/5FHR8s?=
 =?us-ascii?Q?aQudcO2Fwg8fkx9qVHkyKcSdCo9O4vRmWhKVhUwO5EWzLZ5VrVVrW7QJ219P?=
 =?us-ascii?Q?v7xPPeQBV9PaFFkJYqHU3Zgck/zs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HatJ1+xs6hodeTXeSBaD3H39+4stir0AnHF47y5aulB/lPIz+Ar27/lDGZFr?=
 =?us-ascii?Q?e9A6AO113efG7XY9sNTVUcpNxRy+ZOj8tnlRmMiY83BZEG70kedcW0y0jTxU?=
 =?us-ascii?Q?bdLPOZ2LFLWiILjz1uCbm5C7KgG1X4QPYmrLDm3jH5MW19tvb+4VwCj+2fmz?=
 =?us-ascii?Q?gwNGfEwoFofYz8XoQ5yapMts/HLk4baMMK9Kdm1j+3DWi6TQm194/tkQ6UzX?=
 =?us-ascii?Q?Z1uFZle+v2e69hD64cvfDM9J3ocKzVARkG/ZWZbM78dRCiB2ek/SzWqZUW/Q?=
 =?us-ascii?Q?uemhiYl9dQouyhSHqwqjdOH4Qpsxppiqhdg5c6ob5WHrun5EuOa5/pNA555L?=
 =?us-ascii?Q?9Cs6kqOZ/JvWdzgsUo1KA5SsmDEeSWvvzfjO/+dn8Q7g1CLM4XyIbDRacMsb?=
 =?us-ascii?Q?1Pgp6oIggVXcHD1e9QlKGffRED+hDdessP6xOA9jIbjK6nKhV6yd5mYtUeh1?=
 =?us-ascii?Q?ytHbNvFlnOEahfdyRiApwO3KJotVLNNqaMePwY0uEjXsYJ1YG/8wVDaae03W?=
 =?us-ascii?Q?BGOarSuSMGnZuchrhXjJZzaSeOtzWAPEapHSaxpybdHCsHT7Ll94amW8WlZ5?=
 =?us-ascii?Q?t5FOfWEf1+1PtMfUYbhPFlwP9g3t7iEaYgaxgzoLtpbz8SRhiWaXUV06Buls?=
 =?us-ascii?Q?MsI51sYXjFvZQclQt4eF8IugsrF4psT/OzGsprvEfi7YPGtl9iglEM2ixxDE?=
 =?us-ascii?Q?IqtUAtVmIPoumf1uQXGLYcsAqR8vbImaT9c2OMaak4AR2UEWurBtiS2KwXKV?=
 =?us-ascii?Q?+lcMXC56kqk1eR9XXtuF3FVa1Yi3n/1phfgl+yPvSH+krfcweyJbppBONIxG?=
 =?us-ascii?Q?0yPjFFR61cBTPbdbaywJeysNKnfzBpBOdOHBBC/2LWRL4kH0fnQlogtSJ7um?=
 =?us-ascii?Q?efcChHgsBLT91IYSDT/AlP528zW+/eJn/bgHJX3josw9xECR/qHy0uLfIlLt?=
 =?us-ascii?Q?cQ6APmS0R+mYJL20smwoH/AIig0MSBs+asd1K9IZQH4krjgy9yKCIePUgxm9?=
 =?us-ascii?Q?Kri4iVZ21EB6hL1n+nszsiSdLNVGoAmiGcWK9Ct/PaZFeMB1FCrxyoXihdoO?=
 =?us-ascii?Q?Z8MJ/1yrKnyDKF1WLuDBZa9HU5BR0nZmx0djXgyx/hQKID9yGbXdHVXfE5FG?=
 =?us-ascii?Q?6AtJLSps7fMqeppU2UQDl7nIBIQDEKRxOQ6KuxVWNMntGcjK0mA1I/ov+hQ9?=
 =?us-ascii?Q?BzRGLvM//i7N8i6FkrKUV8ThXfUleFSYdBWtm4UYERSwo7nty/Zf+bxeRopW?=
 =?us-ascii?Q?Ce8v4yhtKkl+SB5bKLnrmdB2PGE4bZhFYpV9cOPdO+8h/+Dy7Wf8Nt8VAQUi?=
 =?us-ascii?Q?FyDaA5gReYHcE4hCtbKl1frUyts9i8cqmf7E3JsDOMyGRMmcr6OQ0CJcKBmX?=
 =?us-ascii?Q?+/+sFpmsuh1kJ6W/Yz/4sp+rl7pkWHwC50kuEdC4YwGaHjL3qAsQBzeTIZol?=
 =?us-ascii?Q?6YuGOX9MFpP/GejOEySZpY2Zh7JS3Pa/Xt/A0iBK/eZIMcI0e72mboeStUak?=
 =?us-ascii?Q?+Zm9m0cbt96xF1uWgZYnsWL4qB6y1AkU2W0Z9JWdhBvbhsQdVZcTxvYeW2rm?=
 =?us-ascii?Q?ppxqZifhXeA1NtazK2F3rZSPaMjLb2bqRa0QVi7d8VKMw6WCy64l7ZtEezEj?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XqKrALXBbVLHXIRfwbNPaGaQ0Mh8mAtWkP1VoToql7hQ4zroIijyGL0mkFr/Xo215jhcOZFiqqTBpxWLGQ6a0jbiXe43kgP6LOjPtK0jR3d+o962gSvCZD8zO3Fi1ww3xBjtPxq2LylRkNrc6XOKyRZ+hkuDmTj5cPh/2XYiVVlzUeVf4YR6OhwsBV1WbF7NKViZya4VoUH64QBkDAr9QWCYh6R0z5bBruZ9RV/iiB29lsL9t4vYFaKRJ76rlkjwYiEHjZpeS2ROIAcm9flChS9O2SDQeVO+4WRF4uPcStmrgpMeXP+bpuaim5jogAmACRgXuF2kiOulOlukqwk9uWSWcuPCUZnD2oleuL3ZDlITf6UVb6OlRG+Fj4AMHdsvPRvaPlle2ttxdz3tk8960FJt6fZv146ef4rSfPwibuU4Wzm+Zg+aAYfkwvAzVUEUdQC1BcvkoN/OffPuQSO9Z39h5lCx2RzVUBeecFMJLpHU5fVrTFjfnD5j5ddFoF4EWbG4Xh9/uhwFCcBYvniyIu0r8EiY4hB4+8SuZMTI6RCvlZqJyxLrpgWnxz5rj26gJx7nPOWPXwbT6G8D3z7NCuI8zS9qu+325DJQrYyVFVk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1063332f-56ec-4031-7243-08dd5d882ce1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 14:56:00.7871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xqevy7C0lY8y3gjEePlNx2JrohJU3fzrZXpxtSTwlOA1rYETYBEg/XZ3vu5GlTLSjrBEgM7oK4CDbJ02+T6E8cwxuHckWqStqkIok5i2ip0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5006
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_06,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070110
X-Proofpoint-ORIG-GUID: UA_6YoqC9jZRe3Cpi15bcNkuLcMQr67z
X-Proofpoint-GUID: UA_6YoqC9jZRe3Cpi15bcNkuLcMQr67z

+cc David

On Fri, Mar 07, 2025 at 02:35:12PM +0000, Ryan Roberts wrote:
> On 07/03/2025 13:59, Lorenzo Stoakes wrote:
> > On Fri, Mar 07, 2025 at 01:42:13PM +0000, Ryan Roberts wrote:
> >> On 07/03/2025 13:04, Lorenzo Stoakes wrote:
> >>> On Fri, Mar 07, 2025 at 12:33:06PM +0000, Ryan Roberts wrote:
> >>>> Instead of writing a pte directly into the table, use the set_pte_at()
> >>>> helper, which gives the arch visibility of the change.
> >>>>
> >>>> In this instance we are guaranteed that the pte was originally none and
> >>>> is being modified to a not-present pte, so there was unlikely to be a
> >>>> bug in practice (at least not on arm64). But it's bad practice to write
> >>>> the page table memory directly without arch involvement.
> >>>>
> >>>> Cc: <stable@vger.kernel.org>
> >>>> Fixes: 662df3e5c376 ("mm: madvise: implement lightweight guard page mechanism")
> >>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >>>> ---
> >>>>  mm/madvise.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/mm/madvise.c b/mm/madvise.c
> >>>> index 388dc289b5d1..6170f4acc14f 100644
> >>>> --- a/mm/madvise.c
> >>>> +++ b/mm/madvise.c
> >>>> @@ -1101,7 +1101,7 @@ static int guard_install_set_pte(unsigned long addr, unsigned long next,
> >>>>  	unsigned long *nr_pages = (unsigned long *)walk->private;
> >>>>
> >>>>  	/* Simply install a PTE marker, this causes segfault on access. */
> >>>> -	*ptep = make_pte_marker(PTE_MARKER_GUARD);
> >>>> +	set_pte_at(walk->mm, addr, ptep, make_pte_marker(PTE_MARKER_GUARD));
> >>>
> >>> I agree with you, but I think perhaps the arg name here is misleading :) If
> >>> you look at mm/pagewalk.c and specifically, in walk_pte_range_inner():
> >>>
> >>> 		if (ops->install_pte && pte_none(ptep_get(pte))) {
> >>> 			pte_t new_pte;
> >>>
> >>> 			err = ops->install_pte(addr, addr + PAGE_SIZE, &new_pte,
> >>> 					       walk);
> >>> 			if (err)
> >>> 				break;
> >>>
> >>> 			set_pte_at(walk->mm, addr, pte, new_pte);
> >>>
> >>> 			...
> >>> 		}
> >>>
> >>> So the ptep being assigned here is a stack value, new_pte, which we simply
> >>> assign to, and _then_ the page walker code handles the set_pte_at() for us.
> >>>
> >>> So we are indeed doing the right thing here, just in a different place :P
> >>
> >> Ahh my bad. In that case, please ignore the patch.
> >>
> >> But out of interest, why are you doing it like this? I find it a bit confusing
> >> as all the other ops (e.g. pte_entry()) work directly on the pgtable's pte
> >> without the intermediate.
> >
> > In those cases it's read-only, the data's already there, you can just go ahead
> > and manipulate it (and would expect to be able to do so).
>
> It's certainly not read-only in general. Just having a quick look to verify, the
> very first callback I landed on was clear_refs_pte_range(), which implements
> .pmd_entry to clear the softdirty and access flags from a leaf pmd or from all
> the child ptes.

Yup sorry I misspoke, working some long hours atm so forgive me :) what I meant
to say is that we either read or modify existing.

And yes users do do potentially crazy things and yada yada.

David and I have spoken quite a few times about implementing generic page
table code that could help abstract a lot of things, and it feels like this
logic could all be rejigged in some fashion as to prevent the kind of
'everybody does their own handler' logic.q

I guess I felt it was more _dangerous_ as you are establishing _new_
mappings here, with the page tables being constructed for you up to the PTE
level.

And wanted to 'lock things down' somewhat.

But indeed, all this cries out for a need for a more generalised, robust
interface that handles some of what the downstream users of this are doing.

>
> >
> > When setting things are a little different, I'd rather not open up things to a
> > user being able to do *whatever*, but rather limit to the smallest scope
> > possible for installing the PTE.
>
> Understandable, but personally I think it will lead to potential misunderstandings:
>
>  - it will get copy/pasted as an example of how to set a pte (which is wrong;
> you have to use set_pte_at()/set_ptes()). There is currently only a single other
> case of direct dereferencing a pte to set it (in write_protect_page()).

Yeah, at least renaming the param could help, as 'ptep' implies you really
do have a pointer to the page table entry.

If we didn't return an error we could just return the PTE value or
something... hm.

>
>  - new users of .install_pte may assume (like I did) that the passed in ptep is
> pointing to the pgtable and they will manipulate it with arch helpers. arm64
> arch helpers all assume they are only ever passed pointers into pgtable memory.
> It will end horribly if that is not the case.

It will end very horribly indeed :P or perhaps with more of a fizzle than
anticipated...

>
> >
> > And also of course, it allows us to _mandate_ that set_pte_at() is used so we do
> > the right thing re: arches :)
> >
> > I could have named the parameter better though, in guard_install_pte_entry()
> > would be better to have called it 'new_pte' or something.
>
> I'd suggest at least describing this in the documentation in pagewalk.h. Or
> better yet, you could make the pte the return value for the function. Then it is
> clear because you have no pointer. You'd lose the error code but the only user
> of this currently can't fail anyway.

Haha and here you make the same point I did above... great minds :)

I mean yeah returning a pte would make it clearer what you're doing, but
then it makes it different from every other callback... but this already is
different :)

I do very much want the ability to return an error value to stop the walk
(if you return >0 you can indicate to caller that a non-error stop occurred
for instance, something I use on the reading side).

But we do need to improve this one way or another, at the very least the
documentation/comments.

David - any thoughts?

I'm not necessarily against just making this consitent, but I like this
property of us controlling what happens instead of just giving a pointer
into the page table - the principle of exposing the least possible.

ANWYAY, I will add to my ever expanding whiteboard TODO list [literally the
only todo that work for me] to look at this, will definitely improve docs
at very least.


>
> Anyway, just my 2 pence.

Your input is very much appreciated! Though, with inflation, I think we had
better say 2 pounds... ;)

>
> Thanks,
> Ryan

Cheers!

>
> >
> >>
> >> Thanks,
> >> Ryan
> >>
> >>>
> >>>>  	(*nr_pages)++;
> >>>>
> >>>>  	return 0;
> >>>> --
> >>>> 2.43.0
> >>>>
> >>
> >
> > Thanks for looking at this by the way, obviously I appreciate your point in
> > chasing up cases like this as endeavoured to do the right thing here, albeit
> > abstracted away :)
>

